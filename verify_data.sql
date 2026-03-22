-- Set schema
SET search_path TO herbal, public;

-- Check what we have
SELECT 'Herbs count:' as info, COUNT(*) as count FROM herbal.herbs;
SELECT 'Primary Actions count:' as info, COUNT(*) as count FROM herbal.primary_actions;
SELECT 'Body Systems count:' as info, COUNT(*) as count FROM herbal.body_systems;
SELECT 'Secondary Actions count:' as info, COUNT(*) as count FROM herbal.secondary_actions;
SELECT 'Herb Primary Actions count:' as info, COUNT(*) as count FROM herbal.herb_primary_actions;
SELECT 'Herb Secondary Actions count:' as info, COUNT(*) as count FROM herbal.herb_secondary_actions;

-- Check if the specific herbs exist
SELECT 'Garlic exists:' as check, EXISTS(SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum');
SELECT 'Burdock exists:' as check, EXISTS(SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa');
SELECT 'Echinacea exists:' as check, EXISTS(SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.');

-- Check if Alteratives action exists
SELECT 'Alteratives exists:' as check, EXISTS(SELECT 1 FROM herbal.primary_actions WHERE name = 'Alteratives');

-- List all primary actions to see actual names
SELECT id, name FROM herbal.primary_actions ORDER BY name;

-- Try a manual insert to test
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum' LIMIT 1),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives' LIMIT 1),
  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular' LIMIT 1),
  'mild'::herbal.strength_level
WHERE 
  EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
  AND EXISTS (SELECT 1 FROM herbal.primary_actions WHERE name = 'Alteratives')
  AND EXISTS (SELECT 1 FROM herbal.body_systems WHERE name = 'Cardiovascular')
ON CONFLICT DO NOTHING
RETURNING *;
