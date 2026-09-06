import { NextRequest, NextResponse } from 'next/server';
import { verifySupabaseUser } from '@/lib/supabase-auth';
import { createServerClient } from '@/lib/supabase-server';

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

  const db = createServerClient();
  const { error } = await db.from('herb_images').insert({ herb_id: Number(herbId), image_key: imageKey });
  if (error) return NextResponse.json({ error: error.message }, { status: 500 });

  return NextResponse.json({ success: true });
}
