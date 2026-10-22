import { createClient } from '@supabase/supabase-js';
import { S3Client, GetObjectCommand, PutObjectCommand } from '@aws-sdk/client-s3';
import sharp from 'sharp';
import { Readable } from 'stream';
import * as fs from 'fs';
import * as path from 'path';

// Load .env.local so AWS credentials are available when running via ts-node
const envPath = path.resolve(process.cwd(), '.env.local');
if (fs.existsSync(envPath)) {
  for (const line of fs.readFileSync(envPath, 'utf8').split('\n')) {
    const m = line.match(/^([A-Z0-9_]+)=(.*)$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2].replace(/^['"]|['"]$/g, '');
  }
}

const supabase = createClient(
  'http://127.0.0.1:54321',
  'sb_secret_N7UND0UgjKTVK-Uodkm0Hg_xSvEMPvz',
  { db: { schema: 'herbal' } }
);

const s3 = new S3Client({
  region: process.env.AWS_REGION ?? 'us-west-1',
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID ?? '',
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY ?? '',
  },
});

const BUCKET = process.env.AWS_S3_BUCKET ?? 'herbal-herb-images';
const THUMB_WIDTH = 400;

function thumbKey(imageKey: string): string {
  const dot = imageKey.lastIndexOf('.');
  return dot === -1
    ? `${imageKey}_thumb.jpg`
    : `${imageKey.slice(0, dot)}_thumb.jpg`;
}

async function streamToBuffer(stream: Readable): Promise<Buffer> {
  const chunks: Buffer[] = [];
  for await (const chunk of stream) chunks.push(Buffer.from(chunk));
  return Buffer.concat(chunks);
}

async function main() {
  const { data: rows, error } = await supabase
    .from('herb_images')
    .select('id, image_key')
    .is('thumbnail_key', null);

  if (error) { console.error('DB read failed:', error.message); process.exit(1); }
  if (!rows?.length) { console.log('Nothing to do — all images already have thumbnails.'); return; }

  console.log(`Generating thumbnails for ${rows.length} images…`);

  for (const row of rows) {
    const tKey = thumbKey(row.image_key);
    try {
      const { Body } = await s3.send(new GetObjectCommand({ Bucket: BUCKET, Key: row.image_key }));
      const buf = await streamToBuffer(Body as Readable);

      const thumb = await sharp(buf).resize({ width: THUMB_WIDTH, withoutEnlargement: true }).jpeg({ quality: 82 }).toBuffer();

      await s3.send(new PutObjectCommand({
        Bucket: BUCKET,
        Key: tKey,
        Body: thumb,
        ContentType: 'image/jpeg',
      }));

      const { error: upErr } = await supabase
        .from('herb_images')
        .update({ thumbnail_key: tKey })
        .eq('id', row.id);

      if (upErr) throw new Error(upErr.message);

      console.log(`  ✓ ${row.image_key}`);
    } catch (err) {
      console.error(`  ✗ ${row.image_key}:`, (err as Error).message);
    }
  }

  console.log('Done.');
}

main();
