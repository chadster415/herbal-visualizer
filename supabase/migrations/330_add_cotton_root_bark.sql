-- Migration 330: Add Cotton Root Bark (Gossypium herbaceum)
-- Referenced in Class 67 Poke section: "acute mastitis + Red Root and + Cotton Root Bark"
-- Not previously in the DB; added here so pairs migration 331 can reference it.

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.herbs
    WHERE latin_name ILIKE 'Gossypium%' AND plant_part ILIKE '%root%'
  ) THEN
    RAISE NOTICE 'Cotton Root Bark already exists, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
  VALUES ('Cotton Root Bark', 'Gossypium herbaceum', 'root bark');

END $$;
