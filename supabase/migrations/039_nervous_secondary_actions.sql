-- Migration 039: Nervine secondary actions for the Nervous System
-- Each herb in "Secondary Actions for Nervines" gets:
--   1. herb_primary_actions entry: action=Nervine, body_system=Nervous
--   2. herb_secondary_actions entry: secondary action=Tonic/Relaxant/etc, body_system=Nervous

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id   INTEGER;
  v_all_id       INTEGER;
  v_nervine_id   INTEGER;
  v_sec_id       INTEGER;
  v_herb_id      INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_all_id     FROM herbal.body_systems WHERE name = 'All';

  -- Ensure Nervine primary action exists
  v_nervine_id := herbal.ensure_action('Nervine');

  -- ============================================================
  -- TONIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Tonic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Tonic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Avena sativa', 'oats'),
    herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
    herbal.ensure_herb('Scutellaria lateriflora', 'skullcap')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- RELAXANT nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Relaxant') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Relaxant';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh'),
    herbal.ensure_herb('Eschscholzia californica', 'California poppy'),
    herbal.ensure_herb('Humulus lupulus', 'hops'),
    herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
    herbal.ensure_herb('Hyssopus officinalis', 'hyssop'),
    herbal.ensure_herb('Lavandula spp.', 'lavender'),
    herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),
    herbal.ensure_herb('Matricaria recutita', 'chamomile'),
    herbal.ensure_herb('Melissa officinalis', 'lemon balm'),
    herbal.ensure_herb('Nepeta cataria', 'catnip'),
    herbal.ensure_herb('Passiflora incarnata', 'passionflower'),
    herbal.ensure_herb('Piper methysticum', 'kava kava'),
    herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood'),
    herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower'),
    herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),
    herbal.ensure_herb('Tilia platyphyllos', 'linden'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian'),
    herbal.ensure_herb('Viscum album', 'mistletoe')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- STIMULANT nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Stimulant') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Stimulant';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Cola vera', 'kola nut'),
    herbal.ensure_herb('Coffea arabica', 'coffee'),
    herbal.ensure_herb('Ilex paraguayensis', 'yerba mate'),
    herbal.ensure_herb('Paullinia cupana', 'guarana'),
    herbal.ensure_herb('Rosmarinus officinalis', 'rosemary')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- HYPNOTIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Hypnotic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Hypnotic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Eschscholzia californica', 'California poppy'),
    herbal.ensure_herb('Humulus lupulus', 'hops'),
    herbal.ensure_herb('Lactuca virosa', 'wild lettuce'),
    herbal.ensure_herb('Passiflora incarnata', 'passionflower'),
    herbal.ensure_herb('Piper methysticum', 'kava kava'),
    herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ANTISPASMODIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Antispasmodic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Antispasmodic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Piper methysticum', 'kava kava'),
    herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian'),
    herbal.ensure_herb('Viburnum opulus', 'cramp bark'),
    herbal.ensure_herb('Viburnum prunifolium', 'black haw')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ADAPTOGEN nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Adaptogen') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Adaptogen';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Eleutherococcus senticosus', 'Siberian ginseng'),
    herbal.ensure_herb('Lentinus edodes', 'shiitake'),
    herbal.ensure_herb('Panax ginseng', 'Korean ginseng'),
    herbal.ensure_herb('Panax quinquefolius', 'American ginseng'),
    herbal.ensure_herb('Schisandra chinensis', 'schisandra'),
    herbal.ensure_herb('Withania somnifera', 'ashwagandha')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ANTIDEPRESSANT nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Antidepressant') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Antidepressant';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Artemisia vulgaris', 'mugwort'),
    herbal.ensure_herb('Avena sativa', 'oats'),
    herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
    herbal.ensure_herb('Lavandula spp.', 'lavender'),
    herbal.ensure_herb('Turnera diffusa', 'damiana')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  -- ============================================================
  -- ANALGESIC nervines
  -- ============================================================
  INSERT INTO herbal.secondary_actions (name) VALUES ('Analgesic') ON CONFLICT (name) DO NOTHING;
  SELECT id INTO v_sec_id FROM herbal.secondary_actions WHERE name = 'Analgesic';

  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Dioscorea villosa', 'wild yam'),
    herbal.ensure_herb('Eschscholzia californica', 'California poppy'),
    herbal.ensure_herb('Gelsemium sempervirens', 'yellow jasmine'),
    herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood'),
    herbal.ensure_herb('Stachys betonica', 'wood betony'),
    herbal.ensure_herb('Valeriana officinalis', 'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      VALUES (v_herb_id, v_nervine_id, v_nervous_id) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
      VALUES (v_herb_id, v_sec_id, v_nervous_id) ON CONFLICT DO NOTHING;
  END LOOP;

  RAISE NOTICE 'Migration 039 complete: Nervine secondary actions populated for Nervous system';
END $$;
