SET search_path TO herbal, public;

-- Table to store one or more monograph links per herb
CREATE TABLE IF NOT EXISTS herbal.herb_monograph_links (
  id         SERIAL PRIMARY KEY,
  herb_id    INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  url        TEXT NOT NULL,
  label      TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Migrate existing monograph_url values from herbs table
DO $$
BEGIN
  INSERT INTO herbal.herb_monograph_links (herb_id, url, sort_order)
  SELECT id, monograph_url, 0
  FROM herbal.herbs
  WHERE monograph_url IS NOT NULL
    AND NOT EXISTS (
      SELECT 1 FROM herbal.herb_monograph_links ml WHERE ml.herb_id = herbal.herbs.id
    );

  RAISE NOTICE 'Migrated % existing monograph_url values to herb_monograph_links',
    (SELECT COUNT(*) FROM herbal.herb_monograph_links);
END $$;

-- Grant access (ALL TABLES grant in 001 only covers tables that existed at that time)
GRANT ALL ON TABLE herbal.herb_monograph_links TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.herb_monograph_links_id_seq TO postgres, anon, authenticated, service_role;

-- RLS policies (prod Supabase auto-enables RLS on new tables)
ALTER TABLE herbal.herb_monograph_links ENABLE ROW LEVEL SECURITY;
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'herbal' AND tablename = 'herb_monograph_links' AND policyname = 'anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.herb_monograph_links FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'herbal' AND tablename = 'herb_monograph_links' AND policyname = 'service_write') THEN
    CREATE POLICY "service_write" ON herbal.herb_monograph_links FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

GRANT ALL ON TABLE herbal.constituent_profiles TO postgres, anon, authenticated, service_role;