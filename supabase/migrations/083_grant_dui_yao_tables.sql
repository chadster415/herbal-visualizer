SET search_path TO herbal, public;

-- Tables created in migration 080 (dui_yao_pairs, dui_yao_indications,
-- dui_yao_herb_properties) are missing SELECT grants and RLS policies.
-- Migration 064 covered all tables that existed at the time; new tables
-- created afterward require explicit grants + policies.

GRANT SELECT ON herbal.dui_yao_pairs           TO anon, authenticated;
GRANT SELECT ON herbal.dui_yao_indications     TO anon, authenticated;
GRANT SELECT ON herbal.dui_yao_herb_properties TO anon, authenticated;

ALTER TABLE herbal.dui_yao_pairs           ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.dui_yao_indications     ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.dui_yao_herb_properties ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'herbal' AND tablename = 'dui_yao_pairs' AND policyname = 'public_read') THEN
    CREATE POLICY public_read ON herbal.dui_yao_pairs FOR SELECT TO anon, authenticated USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'herbal' AND tablename = 'dui_yao_indications' AND policyname = 'public_read') THEN
    CREATE POLICY public_read ON herbal.dui_yao_indications FOR SELECT TO anon, authenticated USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'herbal' AND tablename = 'dui_yao_herb_properties' AND policyname = 'public_read') THEN
    CREATE POLICY public_read ON herbal.dui_yao_herb_properties FOR SELECT TO anon, authenticated USING (true);
  END IF;
  RAISE NOTICE 'Migration 083 complete: grants and RLS policies applied to dui_yao tables.';
END $$;
