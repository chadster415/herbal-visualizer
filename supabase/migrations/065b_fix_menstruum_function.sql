SET search_path TO herbal, public;

-- Fix: SMALLINT parameters cause function-resolution failure when callers pass
-- bare integer literals (PostgreSQL types those as INTEGER, not SMALLINT).
-- Also fixes a missing p_water_effective in the VALUES clause.

ALTER TABLE herbal.herb_menstruum
  ALTER COLUMN alcohol_pct_min TYPE INTEGER,
  ALTER COLUMN alcohol_pct_max TYPE INTEGER,
  ALTER COLUMN glycerin_pct    TYPE INTEGER,
  ALTER COLUMN vinegar_pct     TYPE INTEGER;

CREATE OR REPLACE FUNCTION herbal.set_menstruum(
  p_latin_name      TEXT,
  p_alcohol_min     INTEGER DEFAULT NULL,
  p_alcohol_max     INTEGER DEFAULT NULL,
  p_glycerin_pct    INTEGER DEFAULT NULL,
  p_vinegar_pct     INTEGER DEFAULT NULL,
  p_water_effective BOOLEAN DEFAULT FALSE,
  p_primary_label   TEXT    DEFAULT NULL,
  p_notes           TEXT    DEFAULT NULL,
  p_needs_review    BOOLEAN DEFAULT FALSE
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
    alcohol_pct_min = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max = EXCLUDED.alcohol_pct_max,
    glycerin_pct    = EXCLUDED.glycerin_pct,
    vinegar_pct     = EXCLUDED.vinegar_pct,
    water_effective = EXCLUDED.water_effective,
    primary_label   = EXCLUDED.primary_label,
    notes           = EXCLUDED.notes,
    needs_review    = EXCLUDED.needs_review;
END;
$$;

DO $$ BEGIN RAISE NOTICE 'Migration 065b complete: set_menstruum fixed (INTEGER params, water_effective in VALUES).'; END $$;
