-- Migration 232: Class quiz questions schema
-- Stores 30 MCQ questions per ingested class, referenced against class_note_snippets content.
SET search_path TO herbal, public;

CREATE TABLE IF NOT EXISTS herbal.class_quiz_questions (
  id             SERIAL PRIMARY KEY,
  class_name     TEXT NOT NULL,          -- matches class_note_snippets.class_name exactly
  question_text  TEXT NOT NULL,
  option_a       TEXT NOT NULL,
  option_b       TEXT NOT NULL,
  option_c       TEXT NOT NULL,
  option_d       TEXT NOT NULL,
  correct_option CHAR(1) NOT NULL CHECK (correct_option IN ('a', 'b', 'c', 'd')),
  explanation    TEXT NOT NULL,          -- 1-2 sentences explaining the correct answer
  snippet_text   TEXT NOT NULL,          -- verbatim note passage that supports the answer
  section_header TEXT,                   -- section the snippet came from
  sort_order     INTEGER DEFAULT 0
);

CREATE INDEX IF NOT EXISTS class_quiz_questions_class_name_idx
  ON herbal.class_quiz_questions (class_name);

GRANT ALL ON TABLE herbal.class_quiz_questions TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.class_quiz_questions_id_seq TO postgres, anon, authenticated, service_role;

ALTER TABLE herbal.class_quiz_questions ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='class_quiz_questions' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.class_quiz_questions FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='class_quiz_questions' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.class_quiz_questions FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;
