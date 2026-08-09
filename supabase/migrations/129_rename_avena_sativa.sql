SET search_path TO herbal, public;

-- Rename all three Avena sativa entries to consistent "Oat (part)" format.

DO $$
BEGIN
  UPDATE herbal.herbs SET common_name = 'Oat (Milky Oats)' WHERE id = 178;
  UPDATE herbal.herbs SET common_name = 'Oat (Straw)'      WHERE id = 2287;
  UPDATE herbal.herbs SET common_name = 'Oat (Colloidal)'  WHERE id = 2288;

  RAISE NOTICE 'Renamed Avena sativa entries to Oat (Milky Oats), Oat (Straw), Oat (Colloidal)';
END $$;
