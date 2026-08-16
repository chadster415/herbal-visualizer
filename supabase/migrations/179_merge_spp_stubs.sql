-- Migration 179: Merge remaining spp./synonym herb stubs identified after migration 178.
-- Stubs merged: Guggul, Plantain, Shiitake, Vervain, Violet.
-- Each has only Organ Affinity primary actions, no other data.
--
-- NOTE: Kola (Cola acuminata, id=150) and Kola Nut (Cola vera, id=615) were also
-- identified as likely duplicates but have conflicting actions (Nervine Stimulant vs
-- Nervine Relaxant) and significant secondary action data — requires manual review
-- before merging.
--
-- NOTE: Silk Tassel (Garrya fremontii) and Silk Tassel (Garrya elliptica) are
-- intentionally separate entries — different species, not duplicates.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Merge Guggul stub (Commiphora guggul, id=2521)
--          into Guggul (Commiphora mukul, id=877)
-- Commiphora guggul is the currently accepted name; mukul is a synonym.
-- Actions: Organ Affinity - Endocrine.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 877, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2521
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2521;
  DELETE FROM herbal.herbs WHERE id = 2521;

  RAISE NOTICE 'Merged Guggul stub (Commiphora guggul, id=2521) into Guggul (Commiphora mukul, id=877)';
END $$;

-- ============================================================
-- Block 2: Merge Plantain stub (Plantago spp., id=2449)
--          into Plantain (Plantago major, id=85)
-- Actions: Organ Affinity - Skin, Respiratory, Respiratory - Upper.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 85, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2449
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2449;
  DELETE FROM herbal.herbs WHERE id = 2449;

  RAISE NOTICE 'Merged Plantain stub (Plantago spp., id=2449) into Plantain (Plantago major, id=85)';
END $$;

-- ============================================================
-- Block 3: Merge Shiitake stub (Lentinula edodes, id=2430)
--          into Shiitake (Lentinus edodes, id=226)
-- Lentinula edodes is the currently accepted name; Lentinus edodes is the
-- older synonym. Merging stub into the populated entry regardless.
-- Actions: Organ Affinity - Digestive.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 226, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2430
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2430;
  DELETE FROM herbal.herbs WHERE id = 2430;

  RAISE NOTICE 'Merged Shiitake stub (Lentinula edodes, id=2430) into Shiitake (Lentinus edodes, id=226)';
END $$;

-- ============================================================
-- Block 4: Merge Vervain stub (Verbena spp., id=2431)
--          into Vervain (Verbena officinalis, id=146)
-- Actions: Organ Affinity - Musculoskeletal, Digestive.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 146, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2431
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2431;
  DELETE FROM herbal.herbs WHERE id = 2431;

  RAISE NOTICE 'Merged Vervain stub (Verbena spp., id=2431) into Vervain (Verbena officinalis, id=146)';
END $$;

-- ============================================================
-- Block 5: Merge Violet stub (Viola spp., id=2391)
--          into Violet (Viola odorata, id=198)
-- Actions: Organ Affinity - Immune, Reproductive - Female, Respiratory - Upper.
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT 198, primary_action_id, body_system_id, relative_strength, body_system_note
  FROM herbal.herb_primary_actions
  WHERE herb_id = 2391
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE herb_id = 2391;
  DELETE FROM herbal.herbs WHERE id = 2391;

  RAISE NOTICE 'Merged Violet stub (Viola spp., id=2391) into Violet (Viola odorata, id=198)';
END $$;
