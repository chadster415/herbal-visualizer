SET search_path TO herbal, public;

-- Migration 154 incorrectly added constituent data to herb_constituents
-- (which renders as "General Constituents") for 10 non-TCM herbs.
-- The correct table is constituent_profiles (migration 155, "Constituent
-- Profile Markers"). All 10 herbs had zero herb_constituents rows before
-- migration 154, so deleting by herb_id is safe.

DELETE FROM herbal.herb_constituents
WHERE herb_id IN (
  1860,  -- Black Mustard
  2341,  -- Cashew
  2274,  -- Chinese Skullcap
  1650,  -- Comfrey (leaf)
  2338,  -- Mulberry Leaf
  2288,  -- Oat (colloidal)
  2350,  -- Peyote
  1855,  -- Ragwort
  2352,  -- Spinach
  1861   -- White Mustard
);

DO $$ BEGIN
  RAISE NOTICE 'Removed incorrect herb_constituents rows for 10 non-TCM herbs';
END $$;
