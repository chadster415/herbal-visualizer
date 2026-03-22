-- Set schema
SET search_path TO herbal, public;

-- ============================================
-- INSERT SECONDARY ACTIONS FIRST
-- ============================================
INSERT INTO herbal.secondary_actions (name) VALUES
  ('Anticatarrhal'),
  ('Anti-inflammatory'),
  ('Antimicrobial'),
  ('Antispasmodic'),
  ('Astringent'),
  ('Bitter'),
  ('Carminative'),
  ('Demulcent'),
  ('Diaphoretic'),
  ('Diuretic'),
  ('Emmenagogue'),
  ('Expectorant'),
  ('Hepatic'),
  ('Hypotensive'),
  ('Nervine'),
  ('Stimulant'),
  ('Tonic'),
  ('Vulnerary')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- EXAMPLE RELATIONSHIPS - Alteratives
-- Based on your text file
-- ============================================

-- Garlic (Allium sativum) - Alterative for Multiple Systems
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular'),
  'mild'::herbal.strength_level,
  'The hypocholesteremic and hypotensive actions are well known'
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

-- Burdock (Arctium lappa) - Strong Alterative
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),
  'strong'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Musculoskeletal'),
  'strong'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Skin'),
  'strong'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

-- Echinacea - Mild Alterative
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),
  (SELECT id FROM herbal.body_systems WHERE name = 'Skin'),
  'mild'::herbal.strength_level
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

-- ============================================
-- SECONDARY ACTIONS FOR SAMPLE HERBS
-- ============================================

-- Garlic secondary actions
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Anticatarrhal')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antispasmodic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Diaphoretic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hepatic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hypotensive')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')
ON CONFLICT DO NOTHING;

-- Burdock secondary actions
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Bitter')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Diuretic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hepatic')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')
ON CONFLICT DO NOTHING;

-- Echinacea secondary actions
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Anticatarrhal')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT 
  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),
  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')
WHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')
ON CONFLICT DO NOTHING;

