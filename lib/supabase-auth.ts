import { createClient } from '@supabase/supabase-js';
import { NextRequest } from 'next/server';

export async function verifySupabaseUser(req: NextRequest): Promise<{ userId: string; email: string } | null> {
  const authHeader = req.headers.get('authorization');
  const token = authHeader?.startsWith('Bearer ') ? authHeader.slice(7) : null;
  if (!token) return null;

  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL ?? 'http://localhost:54321',
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? ''
  );
  const { data: { user }, error } = await supabase.auth.getUser(token);
  if (error || !user) return null;
  return { userId: user.id, email: user.email ?? 'unknown' };
}
