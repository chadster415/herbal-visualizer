SET search_path TO herbal, public;

-- ─── Constituent concentration level enum ────────────────────────────────────

DO $$ BEGIN
  CREATE TYPE herbal.concentration_level AS ENUM ('trace', 'minor', 'moderate', 'major', 'primary');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ─── Normalized constituents table ───────────────────────────────────────────
-- Each unique chemical constituent (e.g. "berberine", "linalool") lives here once.
-- Multiple herbs link to the same constituent, enabling cross-herb lookups.

CREATE TABLE IF NOT EXISTS herbal.constituents (
  id          SERIAL PRIMARY KEY,
  name        TEXT NOT NULL UNIQUE,
  category    TEXT NOT NULL,  -- e.g. 'isoquinoline alkaloid', 'monoterpene alcohol'
  description TEXT,           -- optional brief note on biological activity
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Herb ↔ constituent join table ──────────────────────────────────────────

CREATE TABLE IF NOT EXISTS herbal.herb_constituents (
  id                  SERIAL PRIMARY KEY,
  herb_id             INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  constituent_id      INTEGER NOT NULL REFERENCES herbal.constituents(id) ON DELETE CASCADE,
  concentration_level herbal.concentration_level NOT NULL DEFAULT 'moderate',
  notes               TEXT,       -- herb-specific note, e.g. "highest in roots"
  needs_review        BOOLEAN NOT NULL DEFAULT FALSE,  -- flag uncertain data
  sort_order          INTEGER NOT NULL DEFAULT 0,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (herb_id, constituent_id)
);

CREATE INDEX IF NOT EXISTS herb_constituents_herb_id_idx        ON herbal.herb_constituents(herb_id);
CREATE INDEX IF NOT EXISTS herb_constituents_constituent_id_idx ON herbal.herb_constituents(constituent_id);
CREATE INDEX IF NOT EXISTS herb_constituents_level_idx          ON herbal.herb_constituents(concentration_level);

-- ─── Herb menstruum recommendations ─────────────────────────────────────────
-- One row per herb. NULL pct columns = that solvent not recommended.
-- primary_label is the short string shown on herb cards (e.g. "60–70% alcohol").

CREATE TABLE IF NOT EXISTS herbal.herb_menstruum (
  herb_id           INTEGER PRIMARY KEY REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  alcohol_pct_min   SMALLINT CHECK (alcohol_pct_min BETWEEN 0 AND 100),
  alcohol_pct_max   SMALLINT CHECK (alcohol_pct_max BETWEEN 0 AND 100),
  glycerin_pct      SMALLINT CHECK (glycerin_pct BETWEEN 0 AND 100),
  vinegar_pct       SMALLINT CHECK (vinegar_pct BETWEEN 0 AND 100),
  water_effective   BOOLEAN NOT NULL DEFAULT FALSE,
  primary_label     TEXT NOT NULL,  -- e.g. "60–70% alcohol", "water", "glycerin"
  notes             TEXT,
  needs_review      BOOLEAN NOT NULL DEFAULT FALSE,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Helper: upsert a constituent, return its id ─────────────────────────────

CREATE OR REPLACE FUNCTION herbal.ensure_constituent(
  p_name     TEXT,
  p_category TEXT,
  p_desc     TEXT DEFAULT NULL
) RETURNS INTEGER
LANGUAGE plpgsql AS $$
DECLARE v_id INTEGER;
BEGIN
  INSERT INTO herbal.constituents (name, category, description)
  VALUES (p_name, p_category, p_desc)
  ON CONFLICT (name) DO UPDATE SET
    category    = EXCLUDED.category,
    description = COALESCE(EXCLUDED.description, herbal.constituents.description)
  RETURNING id INTO v_id;
  RETURN v_id;
END;
$$;

-- ─── Helper: link herb to constituent ────────────────────────────────────────

CREATE OR REPLACE FUNCTION herbal.link_constituent(
  p_latin_name          TEXT,
  p_constituent_name    TEXT,
  p_level               herbal.concentration_level DEFAULT 'moderate',
  p_sort_order          INTEGER DEFAULT 0,
  p_notes               TEXT DEFAULT NULL,
  p_needs_review        BOOLEAN DEFAULT FALSE
) RETURNS VOID
LANGUAGE plpgsql AS $$
DECLARE
  v_herb_id INTEGER;
  v_con_id  INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'link_constituent: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  SELECT id INTO v_con_id FROM herbal.constituents WHERE name = p_constituent_name;
  IF v_con_id IS NULL THEN
    RAISE NOTICE 'link_constituent: constituent not found: %', p_constituent_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes, needs_review)
  VALUES
    (v_herb_id, v_con_id, p_level, p_sort_order, p_notes, p_needs_review)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;
END;
$$;

-- ─── Helper: upsert menstruum row ────────────────────────────────────────────

CREATE OR REPLACE FUNCTION herbal.set_menstruum(
  p_latin_name      TEXT,
  p_alcohol_min     SMALLINT DEFAULT NULL,
  p_alcohol_max     SMALLINT DEFAULT NULL,
  p_glycerin_pct    SMALLINT DEFAULT NULL,
  p_vinegar_pct     SMALLINT DEFAULT NULL,
  p_water_effective BOOLEAN  DEFAULT FALSE,
  p_primary_label   TEXT     DEFAULT NULL,
  p_notes           TEXT     DEFAULT NULL,
  p_needs_review    BOOLEAN  DEFAULT FALSE
) RETURNS VOID
LANGUAGE plpgsql AS $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'set_menstruum: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct,
     water_effective, primary_label, notes, needs_review)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min   = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max   = EXCLUDED.alcohol_pct_max,
    glycerin_pct      = EXCLUDED.glycerin_pct,
    vinegar_pct       = EXCLUDED.vinegar_pct,
    water_effective   = EXCLUDED.water_effective,
    primary_label     = EXCLUDED.primary_label,
    notes             = EXCLUDED.notes,
    needs_review      = EXCLUDED.needs_review;
END;
$$;
