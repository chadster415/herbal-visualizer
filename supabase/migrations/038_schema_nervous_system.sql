-- Migration 038: Schema changes for Nervous System data
-- 1. Add 'moderate' to strength_level enum
-- 2. Add 'All' body system sentinel for global secondary actions
-- 3. Add body_system_id to herb_secondary_actions

SET search_path TO herbal, public;

-- ============================================================================
-- 1. Add 'moderate' to strength_level enum
-- ============================================================================
ALTER TYPE herbal.strength_level ADD VALUE IF NOT EXISTS 'moderate';

-- ============================================================================
-- 2. Add 'All' body system sentinel
-- ============================================================================
INSERT INTO herbal.body_systems (name) VALUES ('All') ON CONFLICT (name) DO NOTHING;

-- ============================================================================
-- 3. Add body_system_id to herb_secondary_actions
-- ============================================================================
ALTER TABLE herbal.herb_secondary_actions
  ADD COLUMN IF NOT EXISTS body_system_id INTEGER REFERENCES herbal.body_systems(id);

-- Set existing rows to 'All'
UPDATE herbal.herb_secondary_actions
SET body_system_id = (SELECT id FROM herbal.body_systems WHERE name = 'All')
WHERE body_system_id IS NULL;

-- Make NOT NULL now that all rows are populated
ALTER TABLE herbal.herb_secondary_actions
  ALTER COLUMN body_system_id SET NOT NULL;

-- Drop old unique constraint and replace with new one including body_system_id
ALTER TABLE herbal.herb_secondary_actions
  DROP CONSTRAINT IF EXISTS herb_secondary_actions_herb_id_secondary_action_id_key;

ALTER TABLE herbal.herb_secondary_actions
  ADD CONSTRAINT herb_secondary_actions_herb_id_secondary_action_id_body_system_key
  UNIQUE (herb_id, secondary_action_id, body_system_id);

CREATE INDEX IF NOT EXISTS idx_herb_secondary_actions_body_system
  ON herbal.herb_secondary_actions(body_system_id);

RAISE NOTICE 'Migration 038 complete: strength_level enum updated, All body system added, herb_secondary_actions updated';
