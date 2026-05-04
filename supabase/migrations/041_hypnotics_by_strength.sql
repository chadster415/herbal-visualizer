-- Migration 041: Hypnotics by Strength
-- Sets relative_strength on herb_primary_actions for Hypnotic action under Nervous system
-- Strength levels: mild, moderate, strong (enum updated in 038)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_hypnotic_id INTEGER;
  v_herb_id     INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';
  v_hypnotic_id := herbal.ensure_action('Hypnotic');

  -- ============================================================
  -- MILD hypnotics
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Matricaria recutita', 'chamomile'),
    herbal.ensure_herb('Melissa officinalis', 'lemon balm'),
    herbal.ensure_herb('Nepeta cataria',      'catnip'),
    herbal.ensure_herb('Tilia platyphyllos',  'linden'),
    herbal.ensure_herb('Trifolium pratense',  'red clover')
  ]) LOOP
    -- Ensure the herb_primary_actions row exists first
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
      VALUES (v_herb_id, v_hypnotic_id, v_nervous_id, 'mild')
      ON CONFLICT (herb_id, primary_action_id, body_system_id)
      DO UPDATE SET relative_strength = 'mild';
  END LOOP;

  -- ============================================================
  -- MODERATE hypnotics
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Leonurus cardiaca',    'motherwort'),
    herbal.ensure_herb('Pulsatilla vulgaris',  'pasqueflower'),
    herbal.ensure_herb('Scutellaria lateriflora','skullcap'),
    herbal.ensure_herb('Verbena officinalis',  'vervain')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
      VALUES (v_herb_id, v_hypnotic_id, v_nervous_id, 'moderate')
      ON CONFLICT (herb_id, primary_action_id, body_system_id)
      DO UPDATE SET relative_strength = 'moderate';
  END LOOP;

  -- ============================================================
  -- STRONG hypnotics
  -- ============================================================
  FOR v_herb_id IN SELECT unnest(ARRAY[
    herbal.ensure_herb('Eschscholzia californica','California poppy'),
    herbal.ensure_herb('Humulus lupulus',         'hops'),
    herbal.ensure_herb('Lactuca virosa',          'wild lettuce'),
    herbal.ensure_herb('Passiflora incarnata',    'passionflower'),
    herbal.ensure_herb('Piper methysticum',       'kava kava'),
    herbal.ensure_herb('Valeriana officinalis',   'valerian')
  ]) LOOP
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
      VALUES (v_herb_id, v_hypnotic_id, v_nervous_id, 'strong')
      ON CONFLICT (herb_id, primary_action_id, body_system_id)
      DO UPDATE SET relative_strength = 'strong';
  END LOOP;

  RAISE NOTICE 'Migration 041 complete: hypnotic strength levels set for Nervous system';
END $$;
