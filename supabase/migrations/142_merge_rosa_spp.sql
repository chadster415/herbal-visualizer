SET search_path TO herbal, public;

-- Merge duplicate Rose entries.
-- ID 850:  Rosa gallica, no plant_part — has herb_constituents, constituent_profiles (petal)
-- ID 2252: Rosa spp., plant_part='petal' — has constituent_profiles only (nearly identical to 850)
-- The 5 overlapping constituent_profiles are duplicates; only Ellagic acid is unique to 2252.
-- Strategy: migrate Ellagic acid profile to 850, drop duplicates, update latin name, delete 2252.

DO $$
BEGIN
  -- Migrate only the unique profile row (Ellagic acid)
  UPDATE herbal.constituent_profiles
  SET herb_id = 850, latin_name = 'Rosa spp.'
  WHERE herb_id = 2252 AND constituent = 'Ellagic acid';

  -- Drop the 5 duplicate profile rows
  DELETE FROM herbal.constituent_profiles WHERE herb_id = 2252;

  -- Remove the stub herb
  DELETE FROM herbal.herbs WHERE id = 2252;

  -- Normalize the canonical entry: Rosa spp., common_name Rose, petal
  UPDATE herbal.herbs
  SET latin_name  = 'Rosa spp.',
      common_name = 'Rose',
      plant_part  = 'petal'
  WHERE id = 850;

  -- Update the 6 remaining constituent_profiles to reflect new latin name
  UPDATE herbal.constituent_profiles SET latin_name = 'Rosa spp.' WHERE herb_id = 850;

  RAISE NOTICE 'Merged Rosa gallica (id 850) + Rosa spp. (id 2252) → Rosa spp. petal (id 850)';
END $$;
