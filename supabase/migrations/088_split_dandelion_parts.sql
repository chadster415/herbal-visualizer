-- Migration 088: Split Dandelion into root and leaf herb entries
--
-- Dandelion root: Hepatic, Cholagogue, Bitter, Aperient, Alterative, Detoxifying, Tonic
--                 Constituents: inulin, sesquiterpene lactones, taraxasterol, triterpenoids
-- Dandelion leaf: Diuretic (strong), Tonic, Nutritive
--                 Constituents: potassium, beta-carotene, flavonoids, hydroxycinnamic acids
--
-- Strategy:
--   • Convert existing id 122 → Dandelion root (it already holds hepatic/cholagogue actions)
--   • Create new Dandelion leaf entry
--   • MOVE strong Diuretic actions to leaf (root is mildly diuretic, not strongly)
--   • Re-point constituent_profiles rows already tagged plant_part = 'Leaf' to the leaf herb
--   • Move leaf-specific herb_constituents (potassium, beta-carotene) to leaf
--   • Re-point the 1 prescription row with note = 'leaf'

SET search_path TO herbal, public;

DO $$
DECLARE
  v_leaf_id INTEGER;
BEGIN

  -- 1. Convert existing Dandelion entry to Dandelion root
  UPDATE herbal.herbs
  SET plant_part = 'root'
  WHERE id = 122 AND latin_name = 'Taraxacum officinale';

  RAISE NOTICE 'Dandelion (id 122) → Dandelion root';

  -- 2. Create Dandelion leaf entry (same energetics as root; adjust separately if needed)
  v_leaf_id := herbal.ensure_herb('Taraxacum officinale', 'Dandelion', 'leaf');

  UPDATE herbal.herbs
  SET temperature   = 'cooling',
      moisture      = 'drying',
      tone          = 'neutral'
  WHERE id = v_leaf_id;

  RAISE NOTICE 'Created Dandelion leaf (id %)', v_leaf_id;

  -- 3. Move Diuretic (strong) from root → leaf.
  --    Root has mild diuretic effect via inulin/mineral content; "strong" Diuretic = leaf.
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT v_leaf_id, hpa.primary_action_id, hpa.body_system_id,
         hpa.relative_strength, hpa.body_system_note
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.primary_actions pa ON pa.id = hpa.primary_action_id
  WHERE hpa.herb_id = 122
    AND pa.name = 'Diuretic'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions
  WHERE herb_id = 122
    AND primary_action_id IN (
      SELECT id FROM herbal.primary_actions WHERE name = 'Diuretic'
    );

  -- 4. Copy Tonic to leaf as well (both parts are tonic)
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT v_leaf_id, hpa.primary_action_id, hpa.body_system_id,
         hpa.relative_strength, hpa.body_system_note
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.primary_actions pa ON pa.id = hpa.primary_action_id
  WHERE hpa.herb_id = 122
    AND pa.name = 'Tonic'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- 5. Re-point constituent_profiles already tagged 'Leaf' → leaf herb
  UPDATE herbal.constituent_profiles
  SET herb_id = v_leaf_id
  WHERE herb_id = 122 AND plant_part = 'Leaf';

  RAISE NOTICE 'Moved Leaf constituent_profiles rows to id %', v_leaf_id;

  -- 6. Move leaf-specific herb_constituents to leaf
  --    potassium: "Abundant in leaves; contributes to diuretic effect"
  --    beta-carotene: "Especially in leaves"
  UPDATE herbal.herb_constituents
  SET herb_id = v_leaf_id
  WHERE herb_id = 122
    AND constituent_id IN (
      SELECT id FROM herbal.constituents WHERE name IN ('potassium', 'beta-carotene')
    );

  -- 7. Re-point the one prescription row that uses the leaf
  UPDATE herbal.prescription_herbs
  SET herb_id = v_leaf_id
  WHERE herb_id = 122 AND note = 'leaf';

  -- 8. Set monograph URL on leaf (same document covers both parts)
  UPDATE herbal.herbs
  SET monograph_url = (SELECT monograph_url FROM herbal.herbs WHERE id = 122)
  WHERE id = v_leaf_id;

  RAISE NOTICE 'Done. Dandelion root = 122, Dandelion leaf = %', v_leaf_id;

  -- Remaining on root (122): Hepatic, Cholagogue, Bitter, Aperient, Alterative,
  -- Detoxifying, Tonic, Anti-inflammatory, Antirheumatic
  -- disorder_action_herbs and disorder_specific_remedies remain on root — correct,
  -- as those disorder contexts (GI, Liver, Skin) are hepatic/cholagogue use cases.

END $$;
