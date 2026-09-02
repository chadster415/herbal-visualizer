-- Migration 247: Deduplicate Anti-inflammatory / Anti-Inflammatory
-- Keep id=4 (Anti-Inflammatory, the canonical entry with ~100+ references).
-- Re-point the handful of rows referencing id=1297 (Anti-inflammatory) to id=4,
-- then delete the duplicate action.

SET search_path TO herbal, public;

DO $$
BEGIN
  -- herb_primary_actions (unique on herb_id, primary_action_id, body_system_id)
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT herb_id, 4, body_system_id
  FROM herbal.herb_primary_actions
  WHERE primary_action_id = 1297
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  DELETE FROM herbal.herb_primary_actions WHERE primary_action_id = 1297;

  -- disorder_action_herbs (unique on disorder_id, herb_id, primary_action_id)
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id)
  SELECT disorder_id, herb_id, 4
  FROM herbal.disorder_action_herbs
  WHERE primary_action_id = 1297
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  DELETE FROM herbal.disorder_action_herbs WHERE primary_action_id = 1297;

  -- disorder_actions_indicated (unique on disorder_id, primary_action_id)
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  SELECT disorder_id, 4, description, sort_order
  FROM herbal.disorder_actions_indicated
  WHERE primary_action_id = 1297
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  DELETE FROM herbal.disorder_actions_indicated WHERE primary_action_id = 1297;

  -- prescription_herb_actions (unique on prescription_herb_id, primary_action_id)
  INSERT INTO herbal.prescription_herb_actions (prescription_herb_id, primary_action_id)
  SELECT prescription_herb_id, 4
  FROM herbal.prescription_herb_actions
  WHERE primary_action_id = 1297
  ON CONFLICT (prescription_herb_id, primary_action_id) DO NOTHING;

  DELETE FROM herbal.prescription_herb_actions WHERE primary_action_id = 1297;

  -- action_pattern (if referenced)
  DELETE FROM herbal.action_pattern WHERE primary_action_id = 1297;

  -- Delete the duplicate action
  DELETE FROM herbal.primary_actions WHERE id = 1297;

  RAISE NOTICE 'Merged Anti-inflammatory (id=1297) into Anti-Inflammatory (id=4)';
END $$;
