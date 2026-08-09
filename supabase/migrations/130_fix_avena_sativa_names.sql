SET search_path TO herbal, public;

-- Fix Avena sativa display: common_name should be plain 'Oat' so the UI renders
-- "Oat (milky oats)", "Oat (straw)", "Oat (colloidal)" — consistent with other split herbs.
-- Also shorten plant_part 'oat straw' → 'straw' to avoid the redundant "Oat (oat straw)".

DO $$
BEGIN
  UPDATE herbal.herbs SET common_name = 'Oat'            WHERE id IN (178, 2287, 2288);
  UPDATE herbal.herbs SET plant_part  = 'straw'          WHERE id = 2287;

  RAISE NOTICE 'Avena sativa names fixed: Oat (milky oats), Oat (straw), Oat (colloidal)';
END $$;
