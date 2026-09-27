SET search_path TO herbal, public;

-- ============================================================
-- Dicentra formosa (Bleeding Heart) — full herb data
-- Created bare by ensure_herb in migration 346.
-- Source: MM Materia Medica (dosages); constituents from literature.
-- Not found in Easley, Hoffmann, Tilgner, or Stockley's.
-- ============================================================

-- Block 1 — Synonyms
-- (energetics set after constituents in Block 4)
DO $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Dicentra formosa';
  IF v_herb_id IS NULL THEN
    RAISE EXCEPTION 'Dicentra formosa not found — run migration 346 first';
  END IF;

  UPDATE herbal.herbs
  SET synonyms = ARRAY['Pacific Bleeding Heart', 'Western Bleeding Heart', 'Wild Bleeding Heart', 'Bikukulla formosa']
  WHERE id = v_herb_id
    AND (synonyms IS NULL OR synonyms = '{}');

  RAISE NOTICE 'Block 1 done — synonyms';
END $$;

-- Block 2 — Primary actions
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Dicentra formosa';

  -- Musculoskeletal
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  v_action_id := herbal.ensure_action('Nervine Relaxant');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Releases chronic emotional and physical holding patterns; indicated for grief and emotional armoring expressed as muscle tension and back pain.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Isoquinoline alkaloids modulate neuromuscular tone; relaxes skeletal and smooth muscle spasm.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Nervous
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';

  v_action_id := herbal.ensure_action('Nervine Relaxant');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Pacific West nervine for stress, anxiety, and grief; acts via isoquinoline alkaloid modulation of GABA and opioid receptor systems; Michael Moore tradition herb for emotional armoring held in the body.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Antispasmodic to smooth and skeletal muscle; used in pain patterns with a significant emotional or grief component.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Block 2 done — primary actions';
END $$;

-- Block 3 — Herb constituents
-- Key isoquinoline alkaloids shared with California Poppy and Corydalis family.
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Dicentra formosa');
  v_c INTEGER;
BEGIN
  -- Protopine — primary marker alkaloid (in DB, 3 herbs)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'protopine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Primary marker alkaloid; shared with California Poppy and Corydalis; contributes to antispasmodic and sedative activity.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Allocryptopine — secondary isoquinoline alkaloid (in DB, 1 herb)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'allocryptopine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Canadine (l-THP / l-tetrahydroberberine) — sedative/analgesic alkaloid (in DB, 1 herb)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'canadine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Also called tetrahydropalmatine; contributes to sedative and analgesic activity.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Bicuculline — pharmacologically notable GABA-A modulator (not yet in DB)
  v_c := herbal.ensure_constituent(
    'bicuculline',
    'isoquinoline alkaloid',
    'GABA-A receptor antagonist found in Dicentra and Corydalis species; at clinical herbal doses contributes to muscle-relaxing and sedative effects via complex modulation of inhibitory neurotransmission.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Coptisine — minor isoquinoline alkaloid (in DB, 1 herb)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'coptisine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Quercetin — broadly shared flavonol (112 herbs in corpus)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Rutin — broadly shared flavonol glycoside (58 herbs)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rutin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Beta-sitosterol — broadly shared phytosterol (39 herbs)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'trace', NULL, 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Block 3 done — herb_constituents';
END $$;

-- Block 4 — Energetics inference from constituents
-- Isoquinoline alkaloids dominant → cooling (alkaloid-cooling rule)
-- No significant mucilage or strong tannin signals → moisture neutral
-- Tone: relaxing (clinical, not inferred — do not set tone_inferred flag)
UPDATE herbal.herbs
SET temperature          = 'cooling',
    temperature_inferred = true,
    moisture             = 'neutral',
    moisture_inferred    = true,
    tone                 = 'relaxing'
WHERE latin_name = 'Dicentra formosa'
  AND temperature IS NULL;

-- Block 5 — Menstruum
-- Isoquinoline alkaloids require moderate alcohol; MM specifies 50% for dry root/herb.
-- Vinegar (5–10%) improves alkaloid salt formation but is not required per MM.
-- Water alone is ineffective for this alkaloid-dominant herb.
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Dicentra formosa',
    40::INTEGER,
    65::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    false,
    '40–65% alcohol',
    'Isoquinoline alkaloids (protopine, allocryptopine, bicuculline, canadine) require moderate alcohol; MM specifies 50% for both dry root [1:5] and herb [1:5] tinctures. Adding 5–10% vinegar can improve alkaloid salt formation. Water extraction is not effective.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Block 5 done — menstruum';
  RAISE NOTICE 'Migration 347 complete — Dicentra formosa herb data populated.';
END $$;
