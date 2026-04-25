-- Sync herbs from Respiratory Systems disorders to herb_primary_actions table
-- This ensures both Lower and Upper Respiratory Systems show the correct herb count

SET search_path TO herbal, public;

-- Insert herb-action pairs from disorder_action_herbs into herb_primary_actions
-- for the Lower Respiratory System
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
WHERE bs.name = 'Lower Respiratory'
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

-- Insert herb-action pairs from disorder_action_herbs into herb_primary_actions
-- for the Upper Respiratory System
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
WHERE bs.name = 'Upper Respiratory'
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

-- Summary: Show how many herbs were synced for each system
DO $$
DECLARE
  v_lower_herb_count INTEGER;
  v_upper_herb_count INTEGER;
BEGIN
  SELECT COUNT(DISTINCT herb_id) INTO v_lower_herb_count
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
  WHERE bs.name = 'Lower Respiratory';

  SELECT COUNT(DISTINCT herb_id) INTO v_upper_herb_count
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
  WHERE bs.name = 'Upper Respiratory';

  RAISE NOTICE 'Lower Respiratory System now has % unique herbs', v_lower_herb_count;
  RAISE NOTICE 'Upper Respiratory System now has % unique herbs', v_upper_herb_count;
END $$;
