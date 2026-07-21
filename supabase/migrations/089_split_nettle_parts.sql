-- Migration 089: Split Nettles into leaf and root herb entries
--
-- Nettles leaf: Alterative, Diuretic, Antirheumatic, Tonic, Lymphatic tonic
--               Classic use for eczema, hayfever, asthma, anaemia, urticaria
--               Constituents: flavonoids, hydroxycinnamic acids, iron, histamine (stinging hairs)
-- Nettles root: Prostate tonic, Anti-inflammatory, Diuretic (urinary flow in BPH)
--               Mechanism: UDA lectin inhibits SHBG; lignans anti-androgenic; beta-sitosterol
--
-- Strategy:
--   • Convert existing id 43 → leaf (already holds all leaf actions, prescriptions, profiles)
--   • Create new root entry with Prostate tonic + Anti-inflammatory + Diuretic actions
--   • Move root-specific herb_constituents to root (UDA, lignans, beta-sitosterol)
--   • Set monograph URL on both (same document covers both parts)
--   • No prescription updates needed (all 4 uses are leaf contexts)
--   • No constituent_profiles updates needed (all 6 profiles are plant_part = 'Leaf')
--   • disorder_action_herbs and disorder_specific_remedies stay on leaf — correct

SET search_path TO herbal, public;

DO $$
DECLARE
  v_root_id   INTEGER;
  v_sys_id    INTEGER;
  v_mono_url  TEXT;
BEGIN

  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';

  -- 1. Convert existing Nettles entry to leaf
  UPDATE herbal.herbs
  SET plant_part = 'leaf'
  WHERE id = 43 AND latin_name = 'Urtica dioica';

  RAISE NOTICE 'Nettles (id 43) → Nettles leaf';

  -- 2. Create Nettles root entry (same energetics as leaf)
  v_root_id := herbal.ensure_herb('Urtica dioica', 'Nettles', 'root');

  UPDATE herbal.herbs
  SET temperature = 'neutral',
      moisture    = 'drying',
      tone        = 'toning'
  WHERE id = v_root_id;

  RAISE NOTICE 'Created Nettles root (id %)', v_root_id;

  -- 3. Set monograph URL on root (same document covers both parts)
  SELECT monograph_url INTO v_mono_url FROM herbal.herbs WHERE id = 43;

  UPDATE herbal.herbs
  SET monograph_url = v_mono_url
  WHERE id = v_root_id;

  -- 4. Add primary actions to Nettles root
  --    Prostate tonic — principal action for BPH
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_root_id, id, v_sys_id FROM herbal.primary_actions WHERE name = 'Prostate tonic'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  --    Anti-inflammatory — reduces prostatic inflammation
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_root_id, id, v_sys_id FROM herbal.primary_actions WHERE name = 'Anti-inflammatory'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  --    Diuretic — supports urinary flow in BPH (Urinary body system)
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_root_id, pa.id, bs.id
  FROM herbal.primary_actions pa, herbal.body_systems bs
  WHERE pa.name = 'Diuretic' AND bs.name = 'Urinary'
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- 5. Move root-specific herb_constituents to root
  --    UDA lectin: "Lectin in root; immunomodulatory; inhibits SHBG binding"
  --    lignans:    "Especially in root; anti-androgenic"
  --    beta-sitosterol: "Especially in root"
  UPDATE herbal.herb_constituents
  SET herb_id = v_root_id
  WHERE herb_id = 43
    AND constituent_id IN (
      SELECT id FROM herbal.constituents
      WHERE name IN ('urtica dioica agglutinin', 'lignans', 'beta-sitosterol')
    );

  RAISE NOTICE 'Done. Nettles leaf = 43, Nettles root = %', v_root_id;

END $$;
