-- Source attribution system
-- Adds a generic sources reference table plus source_id FK on junction tables
-- and a new herb_source_notes table for narrative text from any document.

SET search_path TO herbal, public;

-- ============================================================
-- 1. sources reference table
-- ============================================================
CREATE TABLE herbal.sources (
  id           SERIAL PRIMARY KEY,
  short_name   TEXT NOT NULL UNIQUE,   -- machine key, e.g. 'priest_priest'
  display_name TEXT NOT NULL,          -- e.g. 'Priest & Priest'
  full_title   TEXT,
  authors      TEXT,
  year         INTEGER,
  created_at   TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

GRANT SELECT ON herbal.sources TO anon, authenticated;
GRANT ALL    ON herbal.sources TO service_role;
GRANT USAGE, SELECT ON SEQUENCE herbal.sources_id_seq TO service_role;

-- Seed known sources
INSERT INTO herbal.sources (short_name, display_name, full_title, authors, year) VALUES
  ('priest_priest', 'Priest & Priest',
   'Herbal Medication: A Clinical and Dispensary Handbook',
   'A. W. Priest and L. R. Priest', 1982),
  ('scudder', 'Scudder',
   'Specific Medication and Specific Medicines',
   'John M. Scudder', 1898),
  ('ellingwood', 'Ellingwood',
   'American Materia Medica, Therapeutics and Pharmacognosy',
   'Finley Ellingwood', 1919);

-- ============================================================
-- 2. herb_source_notes — narrative text from any source document
--    section_type values (not enforced by enum to stay flexible):
--      'special_characteristics', 'combinations_technique',
--      'indications', 'general'
-- ============================================================
CREATE TABLE herbal.herb_source_notes (
  id           SERIAL PRIMARY KEY,
  herb_id      INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  source_id    INTEGER NOT NULL REFERENCES herbal.sources(id),
  section_type TEXT    NOT NULL,
  content      TEXT    NOT NULL,
  created_at   TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE (herb_id, source_id, section_type)
);

CREATE INDEX ON herbal.herb_source_notes (herb_id);
CREATE INDEX ON herbal.herb_source_notes (source_id);

GRANT SELECT ON herbal.herb_source_notes TO anon, authenticated;
GRANT ALL    ON herbal.herb_source_notes TO service_role;
GRANT USAGE, SELECT ON SEQUENCE herbal.herb_source_notes_id_seq TO service_role;

-- ============================================================
-- 3. source_id on herb_secondary_actions
-- ============================================================
ALTER TABLE herbal.herb_secondary_actions
  ADD COLUMN source_id INTEGER REFERENCES herbal.sources(id);

CREATE INDEX ON herbal.herb_secondary_actions (source_id);

-- ============================================================
-- 4. source_id on disorder_specific_remedies
-- ============================================================
ALTER TABLE herbal.disorder_specific_remedies
  ADD COLUMN source_id INTEGER REFERENCES herbal.sources(id);

CREATE INDEX ON herbal.disorder_specific_remedies (source_id);
