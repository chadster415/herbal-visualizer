SET search_path TO herbal, public;

-- ============================================================
-- Migration 250: Aralia racemosa (Spikenard) — herb data
--
-- Source: Thomas Easley's Dispensatory
-- Properties: expectorant, anti-inflammatory; alterative for
--   arthritis and skin; warming and drying energetics.
-- ============================================================

DO $$
DECLARE
  v_herb_id   CONSTANT INTEGER := 2479;  -- Aralia racemosa
  v_resp_low  INTEGER;
  v_resp_up   INTEGER;
  v_musc      INTEGER;
  v_skin      INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_resp_low  FROM herbal.body_systems WHERE name = 'Respiratory - Lower';
  SELECT id INTO v_resp_up   FROM herbal.body_systems WHERE name = 'Respiratory - Upper';
  SELECT id INTO v_musc      FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_skin      FROM herbal.body_systems WHERE name = 'Skin';

  -- Expectorant — Respiratory Lower
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Expectorant';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_resp_low, 'moderate',
    'Tonic expectorant for chronic weak lungs with cough, bronchitis, and asthma; Easley recommends it after quitting smoking.')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Anti-Inflammatory — Respiratory Lower
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Anti-Inflammatory';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_resp_low, 'moderate', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Pulmonary Tonic — Respiratory Lower
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Pulmonary Tonic';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_resp_low, NULL,
    'Long-term lung tonic for chronic respiratory weakness; daily tonic dose 20–40 drops (Easley).')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Expectorant — Respiratory Upper
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Expectorant';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_resp_up, 'moderate',
    'Expectorant for colds and upper respiratory infections.')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Anti-Inflammatory — Respiratory Upper
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Anti-Inflammatory';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_resp_up, 'moderate', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Alterative — Musculoskeletal (arthritis)
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Alterative';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_musc, NULL,
    'Alterative for arthritis; used similarly to sarsaparilla (Easley).')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Alterative — Skin (skin diseases)
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  VALUES (v_herb_id, v_action_id, v_skin, NULL,
    'Alterative for chronic skin diseases.')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'A. racemosa primary actions: done.';
END $$;

-- Confirmed energetics from Easley's Dispensatory
-- (override the placeholder neutral/neutral values)
UPDATE herbal.herbs
SET temperature          = 'warming',
    temperature_inferred = false,
    moisture             = 'drying',
    moisture_inferred    = false
WHERE id = 2479;

RAISE NOTICE 'A. racemosa energetics: warming/drying (Easley).';
