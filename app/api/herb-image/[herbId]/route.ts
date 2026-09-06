import { NextRequest, NextResponse } from 'next/server';
import { S3Client, DeleteObjectCommand } from '@aws-sdk/client-s3';
import { verifySupabaseUser } from '@/lib/supabase-auth';
import { createServerClient } from '@/lib/supabase-server';

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

export async function GET(_req: NextRequest, { params }: { params: Promise<{ herbId: string }> }) {
  const { herbId } = await params;

  // Only query DB — legacy image probed client-side to avoid S3 IAM issues
  try {
    const db = createServerClient();
    const { data: rows } = await db
      .from('herb_images')
      .select('image_key')
      .eq('herb_id', herbId)
      .order('created_at', { ascending: true });
    const images = (rows ?? []).map((r: { image_key: string }) => r.image_key);
    return NextResponse.json({ images });
  } catch {
    return NextResponse.json({ images: [] });
  }
}

export async function DELETE(req: NextRequest, { params }: { params: Promise<{ herbId: string }> }) {
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
  }

  const user = await verifySupabaseUser(req);
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const { herbId } = await params;
  const bucket = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images';

  const key = new URL(req.url).searchParams.get('key') ?? `herb-images/${herbId}.png`;
  if (key !== `herb-images/${herbId}.png` && !key.startsWith(`herb-images/${herbId}/`)) {
    return NextResponse.json({ error: 'Invalid key' }, { status: 400 });
  }

  await s3.send(new DeleteObjectCommand({ Bucket: bucket, Key: key }));

  // Remove from DB if present (no-op for legacy key)
  const db = createServerClient();
  await db.from('herb_images').delete().eq('herb_id', herbId).eq('image_key', key);

  return NextResponse.json({ success: true });
}
