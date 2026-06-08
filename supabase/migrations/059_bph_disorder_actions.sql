-- Migration 059: Add missing disorder_actions_indicated, disorder_action_herbs,
-- and prescription_herb_actions for Benign Prostatic Hypertrophy (Reproductive - Male).
-- Migration 055 Block 29 created the disorder, notes, specific remedy, and prescriptions
-- but omitted action data, leaving Reproductive - Male with 0 herbs.
-- This migration fills in the gaps and re-runs the sync.

SET search_path TO herbal, public;

-- ============================================================
-- BLOCK 1: Actions indicated + herb groupings for BPH
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Benign Prostatic Hypertrophy' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Prostate tonic'),    'Inhibit 5-alpha reductase to reduce conversion of testosterone to DHT, addressing the underlying driver of prostatic enlargement.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'), 'Reduce inflammation and congestion of the prostate gland.', 20),
    (v_disorder_id, herbal.ensure_action('Demulcent'),         'Soothe and protect the inflamed urinary mucosa from irritation caused by obstructed flow.', 30),
    (v_disorder_id, herbal.ensure_action('Astringent'),        'Tone the urinary tract tissues and reduce congestion.', 40),
    (v_disorder_id, herbal.ensure_action('Alterative'),        'Support systemic detoxification and hormonal balance.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Serenoa repens',          'saw palmetto'), herbal.ensure_action('Prostate tonic'),    10),
    (v_disorder_id, herbal.ensure_herb('Hydrangea arborescens',   'hydrangea'),    herbal.ensure_action('Anti-inflammatory'), 10),
    (v_disorder_id, herbal.ensure_herb('Smilax spp.',             'sarsaparilla'), herbal.ensure_action('Alterative'),        10),
    (v_disorder_id, herbal.ensure_herb('Zea mays',                'corn silk'),    herbal.ensure_action('Demulcent'),         10),
    (v_disorder_id, herbal.ensure_herb('Elymus repens',           'couch grass'),  herbal.ensure_action('Demulcent'),         20),
    (v_disorder_id, herbal.ensure_herb('Arctostaphylos uva-ursi', 'uva ursi'),     herbal.ensure_action('Astringent'),        10),
    (v_disorder_id, herbal.ensure_herb('Equisetum arvense',       'horsetail'),    herbal.ensure_action('Astringent'),        20)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'BPH disorder actions and herbs inserted.';
END $$;


-- ============================================================
-- BLOCK 2: prescription_herb_actions for internal tincture
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Benign Prostatic Hypertrophy' AND body_system_id = v_sys_id;
  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
    WHERE disorder_id = v_disorder_id AND sort_order = 10;

  IF v_rx_id IS NULL THEN
    RAISE NOTICE 'Internal tincture prescription not found — skipping.';
    RETURN;
  END IF;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Serenoa repens';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Prostate tonic'))
    ON CONFLICT DO NOTHING;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Hydrangea arborescens';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory'))
    ON CONFLICT DO NOTHING;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Smilax spp.';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))
    ON CONFLICT DO NOTHING;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Zea mays';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))
    ON CONFLICT DO NOTHING;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent'))
    ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Internal tincture prescription_herb_actions inserted.';
END $$;


-- ============================================================
-- BLOCK 3: prescription_herb_actions for sitz bath
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Benign Prostatic Hypertrophy' AND body_system_id = v_sys_id;
  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
    WHERE disorder_id = v_disorder_id AND sort_order = 20;

  IF v_rx_id IS NULL THEN
    RAISE NOTICE 'Sitz bath prescription not found — skipping.';
    RETURN;
  END IF;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Equisetum arvense';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent'))
    ON CONFLICT DO NOTHING;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Elymus repens';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))
    ON CONFLICT DO NOTHING;

  SELECT ph.id INTO v_ph_id FROM herbal.prescription_herbs ph
    JOIN herbal.herbs h ON h.id = ph.herb_id
    WHERE ph.prescription_id = v_rx_id AND h.latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent'))
    ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Sitz bath prescription_herb_actions inserted.';
END $$;


-- ============================================================
-- BLOCK 4: Sync to herb_primary_actions
-- ============================================================
DO $$
DECLARE
  v_male_id INTEGER;
BEGIN
  SELECT id INTO v_male_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT dah.herb_id, dah.primary_action_id, v_male_id
  FROM herbal.disorder_action_herbs dah
  JOIN herbal.disorders d ON d.id = dah.disorder_id
  WHERE d.body_system_id = v_male_id
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_male_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_male_id
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Migration 059 complete: Reproductive - Male herbs synced to herb_primary_actions';
END $$;

-- Summary report
SELECT
  pa.name AS action,
  COUNT(DISTINCT hpa.herb_id) AS herb_count
FROM herbal.herb_primary_actions hpa
JOIN herbal.primary_actions pa ON pa.id = hpa.primary_action_id
JOIN herbal.body_systems bs ON bs.id = hpa.body_system_id
WHERE bs.name = 'Reproductive - Male'
GROUP BY pa.name
ORDER BY herb_count DESC, pa.name;
