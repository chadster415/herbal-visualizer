import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { S3Client, DeleteObjectCommand } from '@aws-sdk/client-s3';

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

async function requireAuth(req: NextRequest): Promise<string | null> {
  const cookieStore = await cookies();
  if (cookieStore.get('_hv_verified')?.value !== '1') return 'Unauthorized';
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) return 'Forbidden';
  return null;
}

export async function DELETE(req: NextRequest, { params }: { params: Promise<{ herbId: string }> }) {
  const authError = await requireAuth(req);
  if (authError) return NextResponse.json({ error: authError }, { status: 401 });

  const { herbId } = await params;
  const bucket = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images';

  await s3.send(new DeleteObjectCommand({ Bucket: bucket, Key: `herb-images/${herbId}.png` }));

  return NextResponse.json({ success: true });
}
