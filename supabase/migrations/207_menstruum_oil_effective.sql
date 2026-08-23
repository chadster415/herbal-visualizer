SET search_path TO herbal, public;

-- Add oil_effective column to herb_menstruum
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'herbal' AND table_name = 'herb_menstruum' AND column_name = 'oil_effective'
  ) THEN
    ALTER TABLE herbal.herb_menstruum ADD COLUMN oil_effective BOOLEAN NOT NULL DEFAULT FALSE;
    RAISE NOTICE 'Added oil_effective column to herb_menstruum';
  ELSE
    RAISE NOTICE 'oil_effective column already exists';
  END IF;
END $$;

-- Update set_menstruum() to include oil_effective parameter
CREATE OR REPLACE FUNCTION herbal.set_menstruum(
  p_latin_name       TEXT,
  p_alcohol_min      INTEGER DEFAULT NULL,
  p_alcohol_max      INTEGER DEFAULT NULL,
  p_glycerin_pct     INTEGER DEFAULT NULL,
  p_vinegar_pct      INTEGER DEFAULT NULL,
  p_water_effective  BOOLEAN DEFAULT FALSE,
  p_primary_label    TEXT    DEFAULT NULL,
  p_notes            TEXT    DEFAULT NULL,
  p_needs_review     BOOLEAN DEFAULT FALSE,
  p_powder_effective BOOLEAN DEFAULT FALSE,
  p_oil_effective    BOOLEAN DEFAULT FALSE
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
     water_effective, primary_label, notes, needs_review, powder_effective, oil_effective)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review,
     p_powder_effective, p_oil_effective)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min   = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max   = EXCLUDED.alcohol_pct_max,
    glycerin_pct      = EXCLUDED.glycerin_pct,
    vinegar_pct       = EXCLUDED.vinegar_pct,
    water_effective   = EXCLUDED.water_effective,
    primary_label     = EXCLUDED.primary_label,
    notes             = EXCLUDED.notes,
    needs_review      = EXCLUDED.needs_review,
    powder_effective  = EXCLUDED.powder_effective,
    oil_effective     = EXCLUDED.oil_effective;
END;
$$;

-- Mark oil_effective herbs
DO $$
DECLARE v_count INTEGER;
BEGIN
  UPDATE herbal.herb_menstruum m
  SET oil_effective = TRUE
  WHERE m.herb_id IN (
    SELECT h.id FROM herbal.herbs h
    WHERE (h.latin_name = 'Calendula officinalis')                           -- infused oil: carotenoids/resins
       OR (h.latin_name = 'Hypericum perforatum')                            -- red infused oil: hyperforin
       OR (h.latin_name = 'Arnica montana')                                  -- infused oil: sesquiterpene lactones
       OR (h.latin_name = 'Symphytum officinale')                            -- infused oil: allantoin (both root & leaf)
       OR (h.latin_name = 'Verbascum thapsus')                               -- flower/leaf oil: ear oil
       OR (h.latin_name = 'Stellaria media')                                 -- infused oil: skin conditions
       OR (h.latin_name = 'Capsicum annuum')                                 -- capsaicinoids: highly lipophilic
       OR (h.latin_name = 'Oenothera biennis')                               -- seed oil: GLA (primary preparation)
       OR (h.latin_name = 'Cucurbita pepo')                                  -- seed oil: phytosterols
       OR (h.latin_name = 'Serenoa repens')                                  -- lipid extract: gold standard
       OR (h.latin_name = 'Curcuma longa')                                   -- curcuminoids: fat-soluble
       OR (h.latin_name = 'Plantago major')                                  -- infused oil: topical wound care
  );

  GET DIAGNOSTICS v_count = ROW_COUNT;
  RAISE NOTICE 'Marked % herb_menstruum rows as oil_effective', v_count;
END $$;
