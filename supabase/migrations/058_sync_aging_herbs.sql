-- Migration 058: Sync Aging system herbs to herb_primary_actions
-- Pulls all herbs from disorder_action_herbs and prescription_herb_actions
-- for Aging system disorders and ensures they appear in herb_primary_actions
-- under the Aging body system with the correct action.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_aging_id INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';

  -- Sync from disorder_action_herbs for all Aging system disorders
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT
    dah.herb_id,
    dah.primary_action_id,
    v_aging_id
  FROM herbal.disorder_action_herbs dah
  JOIN herbal.disorders d ON d.id = dah.disorder_id
  WHERE d.body_system_id = v_aging_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Sync from prescription_herb_actions via prescription_herbs → prescriptions → disorders
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT
    ph.herb_id,
    pha.primary_action_id,
    v_aging_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_aging_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Migration 058 complete: Aging system herbs synced to herb_primary_actions';
END $$;

-- Summary report
SELECT
  pa.name AS action,
  COUNT(DISTINCT hpa.herb_id) AS herb_count
FROM herbal.herb_primary_actions hpa
JOIN herbal.primary_actions pa ON pa.id = hpa.primary_action_id
JOIN herbal.body_systems bs ON bs.id = hpa.body_system_id
WHERE bs.name = 'Aging'
GROUP BY pa.name
ORDER BY herb_count DESC, pa.name;
