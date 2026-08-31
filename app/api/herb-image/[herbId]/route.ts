import { NextRequest, NextResponse } from 'next/server';
import { S3Client, DeleteObjectCommand } from '@aws-sdk/client-s3';
import { verifySupabaseUser } from '@/lib/supabase-auth';

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

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

  await s3.send(new DeleteObjectCommand({ Bucket: bucket, Key: `herb-images/${herbId}.png` }));

  return NextResponse.json({ success: true });
}
