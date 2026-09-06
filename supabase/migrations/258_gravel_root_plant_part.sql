-- Migration 258: Set plant_part = 'Whole herb' on pre-existing Gravel Root (id 117)
-- Disambiguates from id 2602 (Eupatorium purpureum, Root) added in migration 256

SET search_path TO herbal, public;

DO $$
BEGIN
  UPDATE herbal.herbs
  SET plant_part = 'Whole herb'
  WHERE id = 117
    AND latin_name = 'Eupatorium purpureum'
    AND plant_part IS NULL;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Herb id 117 not found or plant_part already set — check before proceeding.';
  END IF;

  RAISE NOTICE 'Migration 258 complete — Gravel Root (id 117) plant_part set to Whole herb.';
END $$;
