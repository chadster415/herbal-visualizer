-- Migration 194: flower_essence_categories — searchable index of Part One soul conditions
SET search_path TO herbal, public;

CREATE TABLE IF NOT EXISTS herbal.flower_essence_categories (
  category        TEXT PRIMARY KEY,
  search_keywords TEXT[] DEFAULT '{}'
);

-- Seed from the condition entries already imported
INSERT INTO herbal.flower_essence_categories (category)
SELECT DISTINCT category
FROM herbal.flower_essence_condition_entries
ORDER BY category
ON CONFLICT (category) DO NOTHING;

GRANT ALL ON TABLE herbal.flower_essence_categories TO postgres, anon, authenticated, service_role;

ALTER TABLE herbal.flower_essence_categories ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'herbal' AND tablename = 'flower_essence_categories' AND policyname = 'anon_read'
  ) THEN
    CREATE POLICY "anon_read" ON herbal.flower_essence_categories FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'herbal' AND tablename = 'flower_essence_categories' AND policyname = 'service_write'
  ) THEN
    CREATE POLICY "service_write" ON herbal.flower_essence_categories
      FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;
