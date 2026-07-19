SET search_path TO herbal, public;

-- Dui Yao herb pairs
CREATE TABLE IF NOT EXISTS herbal.dui_yao_pairs (
  id               SERIAL PRIMARY KEY,
  herb1_id         INTEGER NOT NULL REFERENCES herbal.herbs(id),
  herb2_id         INTEGER NOT NULL REFERENCES herbal.herbs(id),
  book_page        INTEGER,
  image_file       TEXT,
  combined_summary TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (herb1_id, herb2_id)
);

-- Major indications for each pair
CREATE TABLE IF NOT EXISTS herbal.dui_yao_indications (
  id         SERIAL PRIMARY KEY,
  pair_id    INTEGER NOT NULL REFERENCES herbal.dui_yao_pairs(id) ON DELETE CASCADE,
  indication TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);

-- Individual herb properties per pair (nature, taste, functions, dosage)
CREATE TABLE IF NOT EXISTS herbal.dui_yao_herb_properties (
  id         SERIAL PRIMARY KEY,
  pair_id    INTEGER NOT NULL REFERENCES herbal.dui_yao_pairs(id) ON DELETE CASCADE,
  herb_id    INTEGER NOT NULL REFERENCES herbal.herbs(id),
  property   TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);

DO $$ BEGIN
  RAISE NOTICE 'Migration 080 complete: created dui_yao_pairs, dui_yao_indications, dui_yao_herb_properties';
END $$;
