SET search_path TO herbal, public;

-- Add powder_effective column to herb_menstruum
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'herbal' AND table_name = 'herb_menstruum' AND column_name = 'powder_effective'
  ) THEN
    ALTER TABLE herbal.herb_menstruum ADD COLUMN powder_effective BOOLEAN NOT NULL DEFAULT FALSE;
    RAISE NOTICE 'Added powder_effective column to herb_menstruum';
  ELSE
    RAISE NOTICE 'powder_effective column already exists';
  END IF;
END $$;

-- Update set_menstruum() to include powder_effective parameter
CREATE OR REPLACE FUNCTION herbal.set_menstruum(
  p_latin_name      TEXT,
  p_alcohol_min     INTEGER DEFAULT NULL,
  p_alcohol_max     INTEGER DEFAULT NULL,
  p_glycerin_pct    INTEGER DEFAULT NULL,
  p_vinegar_pct     INTEGER DEFAULT NULL,
  p_water_effective BOOLEAN DEFAULT FALSE,
  p_primary_label   TEXT    DEFAULT NULL,
  p_notes           TEXT    DEFAULT NULL,
  p_needs_review    BOOLEAN DEFAULT FALSE,
  p_powder_effective BOOLEAN DEFAULT FALSE
) RETURNS VOID LANGUAGE plpgsql AS $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'set_menstruum: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct,
     water_effective, primary_label, notes, needs_review, powder_effective)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review, p_powder_effective)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min   = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max   = EXCLUDED.alcohol_pct_max,
    glycerin_pct      = EXCLUDED.glycerin_pct,
    vinegar_pct       = EXCLUDED.vinegar_pct,
    water_effective   = EXCLUDED.water_effective,
    primary_label     = EXCLUDED.primary_label,
    notes             = EXCLUDED.notes,
    needs_review      = EXCLUDED.needs_review,
    powder_effective  = EXCLUDED.powder_effective;
END;
$$;

-- Set powder_effective = true based on constituent profile
-- Rules:
--   1. Has polysaccharide / mucilage / beta-glucan / FOS / oligosaccharide / lectin constituent
--      (the GI tract is better than a tincture bottle at extracting these)
--   2. Has mineral constituents at moderate+ concentration
--      (tinctures discard minerals with the marc)
--   3. Has anthraquinone at moderate+ concentration
--      (anthraquinone glycosides require gut-bacterial cleavage to become active)
DO $$
DECLARE v_count INTEGER;
BEGIN
  UPDATE herbal.herb_menstruum m
  SET powder_effective = TRUE
  WHERE m.herb_id IN (
    SELECT DISTINCT hc.herb_id
    FROM herbal.herb_constituents hc
    JOIN herbal.constituents c ON c.id = hc.constituent_id
    JOIN herbal.herbs h ON h.id = hc.herb_id
    WHERE h.is_tcm = FALSE
      AND (
        c.category IN (
          'polysaccharide',
          'sulfated polysaccharide',
          'beta-glucan polysaccharide',
          'acidic polysaccharide',
          'alpha-glucan polysaccharide',
          'fructo-oligosaccharide',
          'fructooligosaccharide polysaccharide',
          'oligosaccharide',
          'lectin'
        )
        OR (c.category = 'mineral'
            AND hc.concentration_level IN ('moderate', 'major', 'primary'))
        OR (c.category IN ('anthraquinone', 'anthraquinone glycoside')
            AND hc.concentration_level IN ('moderate', 'major', 'primary'))
      )
  );

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Marked % herbs as powder_effective', v_count;
END $$;
