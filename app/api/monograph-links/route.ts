import { NextRequest, NextResponse } from 'next/server';
import { cookies } from 'next/headers';
import { createServerClient } from '@/lib/supabase-server';

// ── Rate limiter: 1 mutation per 30s per IP ───────────────────────────────────
const lastMutation = new Map<string, number>();
const RATE_LIMIT_MS = 30_000;

function getIp(req: NextRequest): string {
  return req.headers.get('x-forwarded-for')?.split(',')[0].trim() ?? 'unknown';
}

function checkRateLimit(ip: string): boolean {
  const now = Date.now();
  const last = lastMutation.get(ip) ?? 0;
  if (now - last < RATE_LIMIT_MS) return false;
  lastMutation.set(ip, now);
  return true;
}

// ── Auth guards ───────────────────────────────────────────────────────────────

async function requireAuth(req: NextRequest): Promise<string | null> {
  // 1. Turnstile cookie (httpOnly — can't be forged by JS on another domain)
  const cookieStore = await cookies();
  if (cookieStore.get('_hv_verified')?.value !== '1') return 'Unauthorized';

  // 2. Origin check — blocks cross-site requests even with a valid cookie
  const origin = req.headers.get('origin') ?? '';
  const host = req.headers.get('host') ?? '';
  if (origin && !origin.includes(host)) return 'Forbidden';

  // 3. Rate limit
  if (!checkRateLimit(getIp(req))) return 'Rate limit exceeded — wait 30 seconds';

  return null;
}

// ── Handlers ──────────────────────────────────────────────────────────────────

export async function POST(req: NextRequest) {
  const authError = await requireAuth(req);
  if (authError) {
    return NextResponse.json({ error: authError }, { status: authError === 'Rate limit exceeded — wait 30 seconds' ? 429 : 401 });
  }

  const { herb_id, url } = await req.json();
  if (!herb_id || !url) {
    return NextResponse.json({ error: 'herb_id and url are required' }, { status: 400 });
  }

  const supabase = createServerClient();
  const { data, error } = await supabase
    .from('herb_monograph_links')
    .insert({ herb_id, url })
    .select()
    .single();

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json(data);
}

export async function DELETE(req: NextRequest) {
  const authError = await requireAuth(req);
  if (authError) {
    return NextResponse.json({ error: authError }, { status: authError === 'Rate limit exceeded — wait 30 seconds' ? 429 : 401 });
  }

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
