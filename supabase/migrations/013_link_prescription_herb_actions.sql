-- Link prescription herbs to their therapeutic actions
-- This migration populates the prescription_herb_actions junction table
-- by matching prescription herbs with their actions from disorder_action_herbs

SET search_path TO herbal, public;

-- For each prescription herb, find its matching actions from disorder_action_herbs
-- and create the linkage in prescription_herb_actions
INSERT INTO herbal.prescription_herb_actions (prescription_herb_id, primary_action_id)
SELECT DISTINCT
  ph.id as prescription_herb_id,
  dah.primary_action_id
FROM herbal.prescription_herbs ph
JOIN herbal.disorder_prescriptions dp ON ph.prescription_id = dp.id
JOIN herbal.disorder_action_herbs dah ON dah.disorder_id = dp.disorder_id
  AND dah.herb_id = ph.herb_id
WHERE NOT EXISTS (
  -- Don't create duplicates
  SELECT 1 FROM herbal.prescription_herb_actions pha
  WHERE pha.prescription_herb_id = ph.id
    AND pha.primary_action_id = dah.primary_action_id
)
ORDER BY ph.id, dah.primary_action_id;

-- Summary: Show how many prescription herb actions were linked
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM herbal.prescription_herb_actions;
  RAISE NOTICE 'Total prescription herb actions linked: %', v_count;
END $$;
