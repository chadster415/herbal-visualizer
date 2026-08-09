SET search_path TO herbal, public;

-- Merge duplicate Poke Root entries.
-- ID 35:   Phytolacca americana, plant_part='root', common_name='Poke' — has all data
-- ID 1785: Phytolacca americana, plant_part=NULL, common_name='Poke Root' — stub with 2 actions + 2 disorder_action_herbs
-- No conflicts in any table. Strategy: migrate 1785 → 35, delete 1785, normalize name.

DO $$
BEGIN
  UPDATE herbal.disorder_action_herbs SET herb_id = 35 WHERE herb_id = 1785;
  UPDATE herbal.herb_primary_actions  SET herb_id = 35 WHERE herb_id = 1785;

  DELETE FROM herbal.herbs WHERE id = 1785;

  -- Normalize: encode part in common_name, clear plant_part column
  UPDATE herbal.herbs SET common_name = 'Poke Root', plant_part = NULL WHERE id = 35;

  RAISE NOTICE 'Merged Poke Root (id 1785) into id 35; name normalized to Poke Root';
END $$;
