SET search_path TO herbal, public;

-- Merge duplicate Marshmallow entries.
-- ID 45:   Althaea officinalis, plant_part='root' — canonical entry with all data
-- ID 2265: Althaea officinalis, plant_part=NULL   — stub with only 2 disorder_action_herbs
-- Strategy: migrate 2265's rows to 45, delete 2265, then clear plant_part on 45
--           (convention: Althaea officinalis is not a plant-part-split herb).

DO $$
BEGIN
  -- Migrate the 2 disorder_action_herbs (Immune case study + Digestive case study, Demulcent)
  -- No conflicts with ID 45's existing rows.
  UPDATE herbal.disorder_action_herbs SET herb_id = 45 WHERE herb_id = 2265;

  -- Remove the stub
  DELETE FROM herbal.herbs WHERE id = 2265;

  -- Clear plant_part so it displays as "Marshmallow" (not "Marshmallow (root)")
  UPDATE herbal.herbs SET plant_part = NULL WHERE id = 45;

  RAISE NOTICE 'Merged Marshmallow (id 2265) into id 45; plant_part cleared';
END $$;
