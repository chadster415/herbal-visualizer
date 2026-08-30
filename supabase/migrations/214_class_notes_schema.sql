SET search_path TO herbal, public;

-- ─── class_note_snippets ─────────────────────────────────────────────────────
-- One row per herb mention extracted from a class note file.
-- note_type: 'generated' = AI-summarized notes, 'personal' = hand-taken notes.

CREATE TABLE IF NOT EXISTS herbal.class_note_snippets (
  id           SERIAL PRIMARY KEY,
  herb_id      INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  snippet_text TEXT    NOT NULL,
  class_name   TEXT    NOT NULL,  -- e.g. 'BHC - Class 61 - Repro IV Hormonal Matrix'
  note_type    TEXT    NOT NULL CHECK (note_type IN ('generated', 'personal')),
  section_header TEXT,            -- most specific heading above this mention
  sort_order   INTEGER DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_class_note_snippets_herb_id
  ON herbal.class_note_snippets(herb_id);

-- ─── herb_keywords ───────────────────────────────────────────────────────────
-- Searchable keyword → herb mappings extracted from class notes.
-- category: 'ailment' = condition/disease, 'symptom' = sign/symptom,
--           'action'  = therapeutic action/property, 'general' = misc

CREATE TABLE IF NOT EXISTS herbal.herb_keywords (
  id       SERIAL PRIMARY KEY,
  herb_id  INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  keyword  TEXT    NOT NULL,
  category TEXT    NOT NULL CHECK (category IN ('ailment', 'symptom', 'action', 'general')),
  UNIQUE (herb_id, keyword)
);

CREATE INDEX IF NOT EXISTS idx_herb_keywords_herb_id
  ON herbal.herb_keywords(herb_id);
CREATE INDEX IF NOT EXISTS idx_herb_keywords_keyword
  ON herbal.herb_keywords(keyword);

-- ─── Grants ──────────────────────────────────────────────────────────────────
GRANT ALL ON TABLE herbal.class_note_snippets TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.class_note_snippets_id_seq TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.class_note_snippets ENABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE herbal.herb_keywords TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.herb_keywords_id_seq TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.herb_keywords ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='class_note_snippets' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.class_note_snippets FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='class_note_snippets' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.class_note_snippets FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_keywords' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.herb_keywords FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_keywords' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.herb_keywords FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

