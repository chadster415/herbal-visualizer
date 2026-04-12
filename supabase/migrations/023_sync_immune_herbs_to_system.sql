-- Sync herbs from Immune System disorders to herb_primary_actions table
-- This ensures the Immune System shows the correct herb count

SET search_path TO herbal, public;

-- Insert herb-action pairs from disorder_action_herbs into herb_primary_actions
-- for the Immune System
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
SELECT DISTINCT
  dah.herb_id,
  dah.primary_action_id,
  d.body_system_id
FROM herbal.disorder_action_herbs dah
JOIN herbal.disorders d ON dah.disorder_id = d.id
JOIN herbal.body_systems bs ON d.body_system_id = bs.id
WHERE bs.name = 'Immune'
ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

-- Summary: Show how many herbs were synced
DO $$
DECLARE
  v_herb_count INTEGER;
BEGIN
  SELECT COUNT(DISTINCT herb_id) INTO v_herb_count
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.body_systems bs ON hpa.body_system_id = bs.id
  WHERE bs.name = 'Immune';

  RAISE NOTICE 'Immune System now has % unique herbs', v_herb_count;
END $$;
