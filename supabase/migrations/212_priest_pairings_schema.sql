-- Migration 212: Priest & Priest Pairings table
-- Stores herb combination data from Priest & Priest, Herbal Medication (1982)
-- One row per paired herb per combination context

CREATE TABLE herbal.priest_pairings (
  id SERIAL PRIMARY KEY,
  herb_id INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  partner_herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE SET NULL,
  partner_name_raw TEXT NOT NULL,
  combination_context TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX ON herbal.priest_pairings(herb_id);
CREATE INDEX ON herbal.priest_pairings(partner_herb_id);

COMMENT ON TABLE herbal.priest_pairings IS 'Herb combination pairings from Priest & Priest, Herbal Medication (1982)';
COMMENT ON COLUMN herbal.priest_pairings.herb_id IS 'The main herb this pairing belongs to';
COMMENT ON COLUMN herbal.priest_pairings.partner_herb_id IS 'The partner herb (NULL if not in database)';
COMMENT ON COLUMN herbal.priest_pairings.partner_name_raw IS 'Partner herb name as written in the source book';
COMMENT ON COLUMN herbal.priest_pairings.combination_context IS 'Description of the therapeutic rationale for this pairing';
COMMENT ON COLUMN herbal.priest_pairings.sort_order IS 'Display ordering within a herb''s pairings';

GRANT ALL ON TABLE herbal.priest_pairings TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.priest_pairings_id_seq TO postgres, anon, authenticated, service_role;

ALTER TABLE herbal.priest_pairings ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='priest_pairings' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.priest_pairings FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='priest_pairings' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.priest_pairings FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;
