-- Migration 073: Herb data cleanup
-- Fixes malformed entries, duplicate herbs, and missing marker constituent data.
-- Built incrementally — each issue is a separate DO block.

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 1A: Neroli — fix malformed latin name
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE herbal.herbs
  SET latin_name = 'Citrus aurantium'
  WHERE id = 742 AND latin_name = 'Neroli';

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 1B: Maral Root — fix two latin names concatenated into one
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE herbal.herbs
  SET latin_name = 'Leuzea carthamoides'
  WHERE id = 12 AND latin_name = 'Hoppea dichotoma Leuzea carthamoides';

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 1C: Dandelion Root — merge into main Dandelion entry, then delete
-- Dandelion = id 122 (Taraxacum officinale, 18 actions, 18 constituent rows)
-- Dandelion Root = id 177 (Taraxacum officinale root, 6 actions, 0 constituent rows)
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_dandelion_id  INTEGER := 122;
  v_root_id       INTEGER := 177;
  v_all_bs_id     INTEGER := 21;  -- body_system 'All'
BEGIN
  -- Copy primary actions not already on Dandelion
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_dandelion_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions
  WHERE herb_id = v_root_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Copy secondary actions not already on Dandelion
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_dandelion_id, secondary_action_id, body_system_id
  FROM herbal.herb_secondary_actions
  WHERE herb_id = v_root_id
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  -- Delete Dandelion Root (cascades herb_primary_actions, herb_secondary_actions)
  DELETE FROM herbal.herbs WHERE id = v_root_id;

  RAISE NOTICE 'Dandelion Root merged into Dandelion and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 1D: Onion And Garlic — split disorder link to Onion and Garlic, then delete
-- Onion And Garlic = id 473 (Allium spp.)
-- disorder 61 = "All" in Upper Respiratory, action = Antimicrobial
-- Garlic = id 21 (Allium sativum)
-- Onion  = id 208 (Allium cepa)
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_combined_id  INTEGER := 473;
  v_garlic_id    INTEGER := 21;
  v_onion_id     INTEGER := 208;
  v_disorder_id  INTEGER := 61;
  v_action_id    INTEGER;
BEGIN
  SELECT primary_action_id INTO v_action_id
  FROM herbal.disorder_action_herbs WHERE herb_id = v_combined_id AND disorder_id = v_disorder_id;

  -- Give the link to both Garlic and Onion
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id)
  VALUES (v_disorder_id, v_garlic_id, v_action_id),
         (v_disorder_id, v_onion_id,  v_action_id)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Delete Onion And Garlic (cascades herb_primary_actions, disorder_action_herbs)
  DELETE FROM herbal.herbs WHERE id = v_combined_id;

  RAISE NOTICE 'Onion And Garlic split: Antimicrobial/Upper Respiratory assigned to Garlic and Onion, combined entry deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 2A: Hawthorn — merge Crataegus laevigata (1072) into Crataegus spp. (73)
-- laevigata has only 1 specific remedy (Threatened Miscarriage, disorder 95)
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 73;   -- Crataegus spp.
  v_drop_id   INTEGER := 1072; -- Crataegus laevigata
BEGIN
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Hawthorn: Crataegus laevigata merged into Crataegus spp. and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 2B: Lady's Mantle — merge Alchemilla spp. (219) into Alchemilla vulgaris (1014)
-- spp. has only 1 specific remedy (Diarrhea, disorder 2, "Excellent remedy")
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 1014; -- Alchemilla vulgaris
  v_drop_id   INTEGER := 219;  -- Alchemilla spp.
BEGIN
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Lady''s Mantle: Alchemilla spp. merged into Alchemilla vulgaris and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 2C: Linden — merge Tilia spp. (1159) into Tilia platyphyllos (90)
-- spp. has 4 unique primary actions and 2 unique Aging disorder links
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 90;   -- Tilia platyphyllos
  v_drop_id   INTEGER := 1159; -- Tilia spp.
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions
  WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id)
  SELECT disorder_id, v_keep_id, primary_action_id
  FROM herbal.disorder_action_herbs
  WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Linden: Tilia spp. merged into Tilia platyphyllos and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 2D: Pellitory-of-the-Wall — merge Parietaria diffusa (1403) into
-- Parietaria judaica (185); standardise common name; delete diffusa
-- diffusa has 1 specific remedy (Urinary Calculus, disorder 135)
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 185;  -- Parietaria judaica
  v_drop_id   INTEGER := 1403; -- Parietaria diffusa
BEGIN
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Standardise common name
  UPDATE herbal.herbs SET common_name = 'Pellitory of the Wall' WHERE id = v_keep_id;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Pellitory-of-the-Wall: Parietaria diffusa merged into Parietaria judaica and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 3A: Bugleweed — merge Lycopus europaeus (858) into Lycopus spp. (133)
-- europaeus has 1 unique action: Cardioactive/Cardiovascular
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 133; -- Lycopus spp.
  v_drop_id   INTEGER := 858; -- Lycopus europaeus
BEGIN
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions
  WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Bugleweed: Lycopus europaeus merged into Lycopus spp. and deleted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE 3B: Balm of Gilead — merge Populus balsamifera var. balsamifera (1475)
-- into Populus candicans (196)
-- balsamifera has 1 unique specific remedy: Psoriasis/Skin
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 196;  -- Populus candicans
  v_drop_id   INTEGER := 1475; -- Populus balsamifera var. balsamifera
BEGIN
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_keep_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_drop_id
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Balm of Gilead: Populus balsamifera merged into Populus candicans and deleted.';
END $$;
