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

export async function DELETE(req: NextRequest, { params }: { params: Promise<{ recipeId: string }> }) {
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
  }

  const user = await verifySupabaseUser(req);
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  const { recipeId } = await params;
  const bucket = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images';

  const key = new URL(req.url).searchParams.get('key') ?? '';
  if (!key.startsWith(`recipe-images/${recipeId}/`)) {
    return NextResponse.json({ error: 'Invalid key' }, { status: 400 });
  }

  await s3.send(new DeleteObjectCommand({ Bucket: bucket, Key: key }));

  const db = createServerClient();
  await db.from('recipe_images').delete().eq('recipe_id', recipeId).eq('image_key', key);

  return NextResponse.json({ success: true });
}
