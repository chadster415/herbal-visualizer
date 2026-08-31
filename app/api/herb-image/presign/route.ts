import { NextRequest, NextResponse } from 'next/server';
import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import { verifySupabaseUser } from '@/lib/supabase-auth';

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

export async function POST(req: NextRequest) {
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
  }

  const user = await verifySupabaseUser(req);
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const { herbId } = await req.json();
  if (!herbId) return NextResponse.json({ error: 'herbId required' }, { status: 400 });

  const bucket = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images';
  const key = `herb-images/${herbId}.png`;

  const command = new PutObjectCommand({ Bucket: bucket, Key: key, ContentType: 'image/png' });
  const uploadUrl = await getSignedUrl(s3, command, { expiresIn: 120 });

  return NextResponse.json({ uploadUrl });
}
