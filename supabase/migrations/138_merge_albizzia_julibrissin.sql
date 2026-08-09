SET search_path TO herbal, public;

-- Merge duplicate Silk Tree entries.
-- ID 2:    Albizzia julibrissin (misspelled) — has Adaptogen action, kaempferol constituent, 6 constituent_profiles rows
-- ID 2285: Albizia julibrissin  (correct)    — has Anti-allergic action, disorder_action_herbs, prescription_herbs
-- Strategy: keep 2285, migrate data from 2, delete 2.

DO $$
BEGIN
  -- Adaptogen action (no body system) — no conflict with 2285's Anti-allergic entry
  UPDATE herbal.herb_primary_actions SET herb_id = 2285 WHERE herb_id = 2;

  -- kaempferol constituent — 2285 has none, safe direct update
  UPDATE herbal.herb_constituents SET herb_id = 2285 WHERE herb_id = 2;

  -- constituent_profiles rows
  UPDATE herbal.constituent_profiles SET herb_id = 2285 WHERE herb_id = 2;

  -- Remove the misspelled duplicate
  DELETE FROM herbal.herbs WHERE id = 2;

  RAISE NOTICE 'Merged Albizzia julibrissin (id 2) into Albizia julibrissin (id 2285)';
END $$;
