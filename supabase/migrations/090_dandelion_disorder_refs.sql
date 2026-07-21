-- Migration 090: Move leaf-context disorder references from Dandelion root → leaf
--
-- After migration 088 split Dandelion into root (id 122) and leaf (new id),
-- three disorder references remained on root that belong to the leaf:
--
--   disorder_specific_remedies:
--     • Urinary / Edema — description says "Leaf. The diuretic effect..."
--     • Reproductive-Female / Pregnancy Anemia — "Leafy herb that can be added to salads"
--
--   disorder_action_herbs:
--     • Immune / Elimination and Detox Issues / Diuretic — Diuretic is a leaf action
--       (Aperient and Hepatic in the same disorder stay on root — those are root actions)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_root_id INTEGER := 122;
  v_leaf_id INTEGER;
BEGIN

  SELECT id INTO v_leaf_id FROM herbal.herbs
  WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'leaf';

  IF v_leaf_id IS NULL THEN
    RAISE EXCEPTION 'Dandelion leaf entry not found — run migration 088 first';
  END IF;

  RAISE NOTICE 'Dandelion root = %, leaf = %', v_root_id, v_leaf_id;

  -- ── disorder_specific_remedies ────────────────────────────────────────────

  -- Urinary / Edema (explicit "Leaf." in description)
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_leaf_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_root_id
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Edema' AND bs.name = 'Urinary'
    )
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_root_id
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Edema' AND bs.name = 'Urinary'
    );

  RAISE NOTICE 'Moved Urinary/Edema specific remedy → leaf';

  -- Reproductive-Female / Pregnancy - First Trimester - Anemia ("Leafy herb...")
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_leaf_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_root_id
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Pregnancy - First Trimester - Anemia' AND bs.name = 'Reproductive - Female'
    )
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_root_id
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Pregnancy - First Trimester - Anemia' AND bs.name = 'Reproductive - Female'
    );

  RAISE NOTICE 'Moved Reproductive-Female/Pregnancy Anemia specific remedy → leaf';

  -- ── disorder_action_herbs ─────────────────────────────────────────────────

  -- Immune / Elimination and Detox Issues / Diuretic
  -- (Aperient and Hepatic in same disorder stay on root)
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note)
  SELECT disorder_id, v_leaf_id, primary_action_id, note
  FROM herbal.disorder_action_herbs
  WHERE herb_id = v_root_id
    AND primary_action_id = (SELECT id FROM herbal.primary_actions WHERE name = 'Diuretic')
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Elimination and Detox Issues' AND bs.name = 'Immune'
    )
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  DELETE FROM herbal.disorder_action_herbs
  WHERE herb_id = v_root_id
    AND primary_action_id = (SELECT id FROM herbal.primary_actions WHERE name = 'Diuretic')
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Elimination and Detox Issues' AND bs.name = 'Immune'
    );

  RAISE NOTICE 'Moved Immune/Elimination Diuretic action herb → leaf';

  RAISE NOTICE 'Done.';

END $$;
