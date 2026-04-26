import { NextResponse } from 'next/server';
import { readdirSync } from 'fs';
import { join } from 'path';

export async function GET() {
  const dir = join(process.cwd(), 'public', 'disorder_images');
  let files: string[] = [];
  try {
    files = readdirSync(dir);
  } catch {
    return NextResponse.json({});
  }

  const manifest: Record<string, number> = {};
  for (const file of files) {
    const match = file.match(/^(.+)\s+(\d+)\.(jpeg|jpg|png|webp)$/i);
    if (match) {
      const name = match[1];
      const page = parseInt(match[2], 10);
      manifest[name] = Math.max(manifest[name] ?? 0, page);
    }
  }

  return NextResponse.json(manifest);
}
