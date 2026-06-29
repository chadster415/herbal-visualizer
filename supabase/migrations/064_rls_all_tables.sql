-- Migration 064: Enable consistent RLS across all herbal schema tables.
-- All tables get RLS enabled + a permissive SELECT policy for anon and authenticated.
-- Effect on reads: none — all data remains publicly readable.
-- Effect on writes: anon/authenticated can no longer INSERT/UPDATE/DELETE via the
-- client-side Supabase key (no write policy exists). Service role is unaffected.
-- This matches Supabase best practice and fixes body_system_notes / aging_herbs,
-- which had RLS auto-enabled without a SELECT policy, blocking production reads.

SET search_path TO herbal, public;

DO $$
DECLARE
  t TEXT;
BEGIN
  FOR t IN
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'herbal'
      AND table_type = 'BASE TABLE'
    ORDER BY table_name
  LOOP
    -- Enable RLS (idempotent — safe to run on already-enabled tables)
    EXECUTE format('ALTER TABLE herbal.%I ENABLE ROW LEVEL SECURITY', t);

    -- Add permissive SELECT policy if it doesn't already exist
    IF NOT EXISTS (
      SELECT 1 FROM pg_policies
      WHERE schemaname = 'herbal'
        AND tablename = t
        AND policyname = 'public_read'
    ) THEN
      EXECUTE format(
        'CREATE POLICY public_read ON herbal.%I FOR SELECT TO anon, authenticated USING (true)',
        t
      );
      RAISE NOTICE 'public_read policy added: %', t;
    ELSE
      RAISE NOTICE 'public_read policy already exists, skipped: %', t;
    END IF;
  END LOOP;

  RAISE NOTICE 'RLS migration complete — all herbal tables now have consistent public SELECT access.';
END $$;
