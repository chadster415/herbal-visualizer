import { NextRequest, NextResponse } from 'next/server';
import { S3Client, GetObjectCommand, PutObjectCommand } from '@aws-sdk/client-s3';
import sharp from 'sharp';
import { Readable } from 'stream';
import { verifySupabaseUser } from '@/lib/supabase-auth';
import { createServerClient } from '@/lib/supabase-server';

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

const BUCKET = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images';

function thumbKey(imageKey: string): string {
  const dot = imageKey.lastIndexOf('.');
  return dot === -1 ? `${imageKey}_thumb.jpg` : `${imageKey.slice(0, dot)}_thumb.jpg`;
}

export async function POST(req: NextRequest, { params }: { params: Promise<{ herbId: string }> }) {
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
  }

  const user = await verifySupabaseUser(req);
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const { herbId } = await params;
  const { imageKey } = await req.json();

  if (!imageKey || !imageKey.startsWith(`herb-images/${herbId}/`)) {
    return NextResponse.json({ error: 'Invalid imageKey' }, { status: 400 });
  }

  const tKey = thumbKey(imageKey);

  try {
    console.log(`[thumbnail] downloading ${imageKey}`);
    const { Body } = await s3.send(new GetObjectCommand({ Bucket: BUCKET, Key: imageKey }));
    const chunks: Buffer[] = [];
    for await (const chunk of Body as Readable) chunks.push(Buffer.from(chunk));
    const buf = Buffer.concat(chunks);
    console.log(`[thumbnail] downloaded ${buf.length} bytes, resizing…`);

    const thumb = await sharp(buf).resize({ width: 400, withoutEnlargement: true }).jpeg({ quality: 82 }).toBuffer();
    console.log(`[thumbnail] resized to ${thumb.length} bytes, uploading as ${tKey}`);

    await s3.send(new PutObjectCommand({
      Bucket: BUCKET,
      Key: tKey,
      Body: thumb,
      ContentType: 'image/jpeg',
    }));
    console.log(`[thumbnail] done`);
  } catch (err) {
    console.error('[thumbnail] generation failed:', err);
    // Proceed without thumbnail rather than failing the whole upload
  }

  const db = createServerClient();
  const { error } = await db.from('herb_images').insert({
    herb_id: Number(herbId),
    image_key: imageKey,
    thumbnail_key: tKey,
  });
  if (error) return NextResponse.json({ error: error.message }, { status: 500 });

  return NextResponse.json({ success: true });
}
