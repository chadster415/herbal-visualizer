SET search_path TO herbal, public;

-- ID 8:    Echinopanax elatus (old synonym, no plant_part) → Oplopanax elatus, bark
-- ID 2226: Oplopanax elatus, root bark — already correct, no change needed

DO $$
BEGIN
  UPDATE herbal.herbs
  SET latin_name = 'Oplopanax elatus',
      plant_part = 'bark'
  WHERE id = 8;

  RAISE NOTICE 'Fixed: Echinopanax elatus → Oplopanax elatus (bark)';
END $$;
