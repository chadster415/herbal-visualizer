-- Remove "Moderate" from secondary_actions — it is a relative strength level,
-- not an herbal action, and was ingested by mistake.

SET search_path TO herbal, public;

DELETE FROM herbal.herb_secondary_actions
WHERE secondary_action_id = (SELECT id FROM herbal.secondary_actions WHERE name = 'Moderate');

DELETE FROM herbal.secondary_actions WHERE name = 'Moderate';
