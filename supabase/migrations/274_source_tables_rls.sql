-- Add RLS policies for sources and herb_source_notes.
-- Migration 269 created these tables with GRANTs but no RLS policies,
-- which causes production Supabase to hide all rows.

SET search_path TO herbal, public;

ALTER TABLE herbal.sources          ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.herb_source_notes ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'sources' AND policyname = 'anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.sources FOR SELECT USING (true);
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'herb_source_notes' AND policyname = 'anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.herb_source_notes FOR SELECT USING (true);
  END IF;
END $$;
