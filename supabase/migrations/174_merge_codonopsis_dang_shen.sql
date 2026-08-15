-- Merge duplicate Codonopsis entries.
-- ID 7  (Dang Shen / Codonoposis pilosula — typo): Adaptogen action, 2 constituents, 12 constituent_profiles
-- ID 2407 (Codonopsis / Codonopsis pilosula — correct): 3 primary actions, 1 constituent, 6 constituent_profiles
-- Keep ID 2407 (correct latin spelling); move all data from ID 7; add Dang Shen as pinyin_name.

SET search_path TO herbal, public;

DO $$
BEGIN
  -- Primary actions: move Adaptogen (body_system_id NULL) from 7 → 2407
  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 7
    AND (primary_action_id, body_system_id) IN (
      SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 2407
    );
  UPDATE herbal.herb_primary_actions SET herb_id = 2407 WHERE herb_id = 7;

  -- Constituents: move polyacetylenes + polysaccharides from 7 → 2407
  DELETE FROM herbal.herb_constituents
  WHERE herb_id = 7
    AND constituent_id IN (
      SELECT constituent_id FROM herbal.herb_constituents WHERE herb_id = 2407
    );
  UPDATE herbal.herb_constituents SET herb_id = 2407 WHERE herb_id = 7;

  -- Constituent profiles: re-point the 12 rows from ID 7 → 2407
  UPDATE herbal.constituent_profiles SET herb_id = 2407 WHERE herb_id = 7;

  -- Preserve "Dang Shen" as the pinyin/TCM name
  UPDATE herbal.herbs SET pinyin_name = 'Dang Shen' WHERE id = 2407;

  -- Delete the duplicate row (ID 7 had a typo: "Codonoposis")
  DELETE FROM herbal.herbs WHERE id = 7;

  RAISE NOTICE 'Merged Codonopsis: deleted id 7, all data consolidated into id 2407 (Codonopsis pilosula)';
END $$;
