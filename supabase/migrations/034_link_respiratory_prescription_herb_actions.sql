-- Link Respiratory Systems prescription herbs to their therapeutic actions
-- This migration populates the prescription_herb_actions junction table
-- for all respiratory system prescriptions

SET search_path TO herbal, public;

-- For each prescription herb in respiratory disorders, find its matching actions
-- from disorder_action_herbs and create the linkage in prescription_herb_actions
INSERT INTO herbal.prescription_herb_actions (prescription_herb_id, primary_action_id)
SELECT DISTINCT
  ph.id as prescription_herb_id,
  dah.primary_action_id
FROM herbal.prescription_herbs ph
JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
JOIN herbal.disorders d ON dp.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
JOIN herbal.disorder_action_herbs dah ON dah.disorder_id = dp.disorder_id
  AND dah.herb_id = ph.herb_id
WHERE bs.name IN ('Lower Respiratory', 'Upper Respiratory')
  AND NOT EXISTS (
    -- Don't create duplicates
    SELECT 1 FROM herbal.prescription_herb_actions pha
    WHERE pha.prescription_herb_id = ph.id
      AND pha.primary_action_id = dah.primary_action_id
  )
ORDER BY ph.id, dah.primary_action_id;

-- Summary: Show how many prescription herb actions were linked for respiratory systems
DO $$
DECLARE
  v_count INTEGER;
  v_lower_count INTEGER;
  v_upper_count INTEGER;
BEGIN
  -- Total count for respiratory systems
  SELECT COUNT(DISTINCT pha.id) INTO v_count
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON pha.prescription_herb_id = ph.id
  JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
  JOIN herbal.disorders d ON dp.disorder_id = d.id
  JOIN herbal.body_systems bs ON d.body_system_id = bs.id
  WHERE bs.name IN ('Lower Respiratory', 'Upper Respiratory');

  -- Lower Respiratory count
  SELECT COUNT(DISTINCT pha.id) INTO v_lower_count
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON pha.prescription_herb_id = ph.id
  JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
  JOIN herbal.disorders d ON dp.disorder_id = d.id
  JOIN herbal.body_systems bs ON d.body_system_id = bs.id
  WHERE bs.name = 'Lower Respiratory';

  -- Upper Respiratory count
  SELECT COUNT(DISTINCT pha.id) INTO v_upper_count
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON pha.prescription_herb_id = ph.id
  JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
  JOIN herbal.disorders d ON dp.disorder_id = d.id
  JOIN herbal.body_systems bs ON d.body_system_id = bs.id
  WHERE bs.name = 'Upper Respiratory';

  RAISE NOTICE 'Total respiratory prescription herb actions linked: %', v_count;
  RAISE NOTICE 'Lower Respiratory: %', v_lower_count;
  RAISE NOTICE 'Upper Respiratory: %', v_upper_count;
END $$;
