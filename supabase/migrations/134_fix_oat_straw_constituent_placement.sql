SET search_path TO herbal, public;

-- Fix Oat Straw constituent placement:
--   - Tricin was added to herb_constituents but is already a constituent_profiles Marker — remove duplicate.
--   - Vitexin and isovitexin are specific named marker compounds — move from herb_constituents
--     to constituent_profiles so they appear in the Profile Markers section.

DO $$
BEGIN
  -- Remove specific named compounds from herb_constituents (they belong in constituent_profiles)
  DELETE FROM herbal.herb_constituents
  WHERE herb_id = 2287 AND constituent_id IN (
    SELECT id FROM herbal.constituents WHERE name IN ('tricin', 'vitexin', 'isovitexin')
  );

  -- Add vitexin and isovitexin to constituent_profiles for Oat Straw
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes)
  VALUES
    (2287, 'Oat', 'Avena sativa', 'Straw', 'Vitexin',    'Flavonoid', 'Flavone C-glycoside', 'High',     'Major',
     'C-glycosyl flavone characteristic of oat straw; antioxidant and anti-inflammatory activity.'),
    (2287, 'Oat', 'Avena sativa', 'Straw', 'Isovitexin', 'Flavonoid', 'Flavone C-glycoside', 'Moderate', 'Major',
     'C-glycosyl flavone paired with vitexin; part of the characteristic flavonoid profile of oat straw.');

  RAISE NOTICE 'Oat Straw: tricin/vitexin/isovitexin removed from herb_constituents; vitexin and isovitexin added to constituent_profiles';
END $$;
