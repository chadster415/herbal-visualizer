import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

export async function POST(req: NextRequest) {
  const cookieStore = await cookies();
  if (cookieStore.get('_hv_verified')?.value !== '1') {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
  }

  const { herbId, contentType } = await req.json();
  if (!herbId) return NextResponse.json({ error: 'herbId required' }, { status: 400 });

  const bucket = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images-dev';
  const region = process.env.AWS_REGION ?? 'us-west-1';
  const mime = contentType ?? 'image/png';
  const ext = mime === 'image/jpeg' ? 'jpg' : mime === 'image/gif' ? 'gif' : mime === 'image/webp' ? 'webp' : 'png';
  const key = `herb-images/${herbId}.${ext}`;

  const command = new PutObjectCommand({ Bucket: bucket, Key: key, ContentType: mime });
  const uploadUrl = await getSignedUrl(s3, command, { expiresIn: 120 });
  const publicUrl = `https://${bucket}.s3.${region}.amazonaws.com/${key}`;

  return NextResponse.json({ uploadUrl, publicUrl });
}
