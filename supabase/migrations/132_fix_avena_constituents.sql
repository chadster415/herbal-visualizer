SET search_path TO herbal, public;

-- Fix constituent data for the Avena sativa split:
--   1. Re-point constituent_profiles rows with plant_part='Straw' from Milky Oats (178) → Oat Straw (2287)
--   2. Add herb_constituents for Oat Straw (2287)

DO $$
DECLARE
  v_tricin_id INTEGER;
BEGIN
  -- 1. Fix constituent_profiles: Straw rows were still pointing to Milky Oats
  UPDATE herbal.constituent_profiles
  SET herb_id = 2287
  WHERE herb_id = 178 AND plant_part = 'Straw';

  -- 2. Oat Straw herb_constituents
  --    silica is the defining constituent of oat straw (silicic acid — connective tissue, minerals)
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES (2287, 996, 'primary', 10, 'Primary mineral; oat straw is a leading silica source')
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- tricin — characteristic flavone marker of oat straw
  v_tricin_id := herbal.ensure_constituent('tricin', 'flavone',
    'Characteristic flavone of oat straw; antioxidant and anti-inflammatory activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, v_tricin_id, 'major', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- beta-glucans — present in straw, though lower than milky seed
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, 916, 'moderate', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- saponins — present in straw
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, 1038, 'moderate', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- avenanthramides — present but lower than milky seed
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, 1041, 'minor', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Oat Straw constituents fixed; Straw profile rows re-pointed to herb_id=2287';
END $$;
