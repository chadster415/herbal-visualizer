import { NextRequest, NextResponse } from 'next/server';
import { createServerClient } from '@/lib/supabase-server';
import { verifySupabaseUser } from '@/lib/supabase-auth';

async function requireAuth(req: NextRequest) {
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) return { error: 'Forbidden', status: 403 } as const;

  const user = await verifySupabaseUser(req);
  if (!user) return { error: 'Unauthorized', status: 401 } as const;

  return { user };
}

export async function POST(req: NextRequest) {
  const auth = await requireAuth(req);
  if ('error' in auth) return NextResponse.json({ error: auth.error }, { status: auth.status });

  const { herb_id, url } = await req.json();
  if (!herb_id || !url) return NextResponse.json({ error: 'herb_id and url are required' }, { status: 400 });

  const supabase = createServerClient();
  const { data, error } = await supabase
    .from('herb_monograph_links')
    .insert({ herb_id, url, updated_by: auth.user.email })
    .select()
    .single();

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json(data);
}

export async function DELETE(req: NextRequest) {
  const auth = await requireAuth(req);
  if ('error' in auth) return NextResponse.json({ error: auth.error }, { status: auth.status });

  const { id } = await req.json();
  if (!id) return NextResponse.json({ error: 'id is required' }, { status: 400 });

  const supabase = createServerClient();
  const { error } = await supabase
    .from('herb_monograph_links')
    .delete()
    .eq('id', id);

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ success: true });
}
