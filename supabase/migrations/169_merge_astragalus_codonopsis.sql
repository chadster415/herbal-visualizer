SET search_path TO herbal, public;

-- Merge Astragalus mongholicus → membranaceus (near-synonymous Huang Qi species)
DO $$
BEGIN
  -- Transfer Organ Affinity / Respiratory (unique to mongholicus)
  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 2445
    AND (primary_action_id, body_system_id) IN (
      SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 225
    );
  UPDATE herbal.herb_primary_actions SET herb_id = 225 WHERE herb_id = 2445;

  UPDATE herbal.herb_secondary_actions SET herb_id = 225 WHERE herb_id = 2445;
  UPDATE herbal.herb_constituents     SET herb_id = 225 WHERE herb_id = 2445;
  UPDATE herbal.constituent_profiles  SET herb_id = 225 WHERE herb_id = 2445;

  DELETE FROM herbal.herbs WHERE id = 2445;
  RAISE NOTICE 'Merged Astragalus mongholicus (2445) into membranaceus (225)';
END $$;

-- Merge Codonopsis tangshen → pilosula (pilosula is the primary Dang Shen species)
-- Note: tangshen (271) appears in dui yao pair 51 and must be reparented first.
DO $$
BEGIN
  -- Reparent dui yao references before deleting the herb
  UPDATE herbal.dui_yao_pairs SET herb1_id = 2407 WHERE herb1_id = 271;
  UPDATE herbal.dui_yao_pairs SET herb2_id = 2407 WHERE herb2_id = 271;
  UPDATE herbal.dui_yao_herb_properties SET herb_id = 2407 WHERE herb_id = 271;

  -- Transfer primary actions (Immunomodulator / Immune is unique to tangshen)
  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 271
    AND (primary_action_id, body_system_id) IN (
      SELECT primary_action_id, body_system_id FROM herbal.herb_primary_actions WHERE herb_id = 2407
    );
  UPDATE herbal.herb_primary_actions SET herb_id = 2407 WHERE herb_id = 271;

  UPDATE herbal.herb_secondary_actions SET herb_id = 2407 WHERE herb_id = 271;

  -- Transfer constituent from tangshen
  DELETE FROM herbal.herb_constituents
  WHERE herb_id = 271
    AND constituent_id IN (SELECT constituent_id FROM herbal.herb_constituents WHERE herb_id = 2407);
  UPDATE herbal.herb_constituents SET herb_id = 2407 WHERE herb_id = 271;

  UPDATE herbal.constituent_profiles SET herb_id = 2407 WHERE herb_id = 271;

  -- Copy energetics from tangshen (moistening / toning) onto pilosula which had neutral
  UPDATE herbal.herbs SET moisture = 'moistening', tone = 'toning' WHERE id = 2407;

  DELETE FROM herbal.herbs WHERE id = 271;
  RAISE NOTICE 'Merged Codonopsis tangshen (271) into pilosula (2407)';
END $$;
