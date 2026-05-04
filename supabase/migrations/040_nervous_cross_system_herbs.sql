-- Migration 040: Cross-system nervine data
-- Sources:
--   "Nervines and Body Systems" — nervines that also act on Circulatory/Respiratory/Digestive/Reproductive
--   "Hypnotics and Nervines for Specific Systems" (under Insomnia) — hypnotics for Circulatory/Digestive/Reproductive/Musculoskeletal/Skin
-- Populates herb_primary_actions with the target body system (not Nervous)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_circ_id   INTEGER;
  v_resp_id   INTEGER;
  v_dig_id    INTEGER;
  v_repro_id  INTEGER;
  v_musc_id   INTEGER;
  v_skin_id   INTEGER;
  v_relax_id  INTEGER;
  v_antispas_id INTEGER;
  v_hypnotic_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  -- Body system IDs (using legacy names from migration 001)
  SELECT id INTO v_circ_id  FROM herbal.body_systems WHERE name = 'Cardiovascular';
  SELECT id INTO v_resp_id  FROM herbal.body_systems WHERE name = 'Respiratory';
  SELECT id INTO v_dig_id   FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_repro_id FROM herbal.body_systems WHERE name = 'Reproductive';
  SELECT id INTO v_musc_id  FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_skin_id  FROM herbal.body_systems WHERE name = 'Skin';

  v_relax_id    := herbal.ensure_action('Nervine relaxant');
  v_antispas_id := herbal.ensure_action('Antispasmodic');
  v_hypnotic_id := herbal.ensure_action('Hypnotic');

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Circulatory
  -- ============================================================
  -- Relaxing
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Melissa officinalis',   'lemon balm'),
    herbal.ensure_herb('Cimicifuga racemosa',   'black cohosh'),
    herbal.ensure_herb('Viscum album',          'mistletoe'),
    herbal.ensure_herb('Lavandula spp.',        'lavender'),
    herbal.ensure_herb('Tilia platyphyllos',    'linden'),
    herbal.ensure_herb('Leonurus cardiaca',     'motherwort'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_relax_id, v_circ_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Antispasmodic
  v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_antispas_id, v_circ_id) ON CONFLICT DO NOTHING;

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Respiratory
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Grindelia spp.',      'grindelia'),
    herbal.ensure_herb('Lobelia inflata',     'lobelia'),
    herbal.ensure_herb('Prunus serotina',     'wild cherry'),
    herbal.ensure_herb('Lactuca virosa',      'wild lettuce')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_antispas_id, v_resp_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Digestive
  -- ============================================================
  -- Relaxing
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita',  'chamomile'),
    herbal.ensure_herb('Humulus lupulus',      'hops'),
    herbal.ensure_herb('Melissa officinalis',  'lemon balm'),
    herbal.ensure_herb('Valeriana officinalis','valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_relax_id, v_dig_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Antispasmodic
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Viburnum opulus',     'cramp bark'),
    herbal.ensure_herb('Foeniculum vulgare',  'fennel'),
    herbal.ensure_herb('Mentha piperita',     'peppermint'),
    herbal.ensure_herb('Dioscorea villosa',   'wild yam')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_antispas_id, v_dig_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- NERVINES AND BODY SYSTEMS — Reproductive
  -- ============================================================
  -- Relaxing
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Pulsatilla vulgaris',    'pasqueflower'),
    herbal.ensure_herb('Scutellaria lateriflora','skullcap'),
    herbal.ensure_herb('Valeriana officinalis',  'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_relax_id, v_repro_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Antispasmodic
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Viburnum prunifolium', 'black haw'),
    herbal.ensure_herb('Viburnum opulus',      'cramp bark')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_antispas_id, v_repro_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- HYPNOTICS AND NERVINES FOR SPECIFIC SYSTEMS (under Insomnia)
  -- ============================================================

  -- Circulatory
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Leonurus cardiaca',  'motherwort'),
    herbal.ensure_herb('Tilia platyphyllos', 'linden'),
    herbal.ensure_herb('Melissa officinalis','lemon balm')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_circ_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Respiratory
  v_herb_id := herbal.ensure_herb('Lactuca virosa', 'wild lettuce');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_hypnotic_id, v_resp_id) ON CONFLICT DO NOTHING;

  -- Digestive
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita',  'chamomile'),
    herbal.ensure_herb('Verbena officinalis',  'vervain'),
    herbal.ensure_herb('Melissa officinalis',  'lemon balm'),
    herbal.ensure_herb('Humulus lupulus',      'hops'),
    herbal.ensure_herb('Valeriana officinalis','valerian'),
    herbal.ensure_herb('Passiflora incarnata', 'passionflower'),
    herbal.ensure_herb('Piscidia erythrina',   'Jamaica dogwood')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_dig_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Reproductive
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower'),
    herbal.ensure_herb('Piscidia erythrina',  'Jamaica dogwood')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_repro_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Musculoskeletal
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Piscidia erythrina',   'Jamaica dogwood'),
    herbal.ensure_herb('Valeriana officinalis','valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_musc_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- Skin
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita', 'chamomile'),
    herbal.ensure_herb('Primula veris',       'cowslip')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_hypnotic_id, v_skin_id) ON CONFLICT DO NOTHING;
  END LOOP;

  RAISE NOTICE 'Migration 040 complete: cross-system nervine and hypnotic herb actions populated';
END $$;
