-- Set schema
SET search_path TO herbal, public;

-- ============================================
-- ALTERATIVES - Herb to Action to Body System Relationships
-- ============================================

-- Cardiovascular System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Cardiovascular'
AND h.latin_name IN ('Galium aparine', 'Phytolacca americana', 'Echinacea spp.', 'Scrophularia nodosa', 'Allium sativum');

-- Respiratory System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Respiratory'
AND h.latin_name IN ('Allium sativum', 'Hydrastis canadensis', 'Sanguinaria canadensis', 'Baptisia tinctoria', 'Echinacea spp.');

-- Digestive System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 
  CASE 
    WHEN h.latin_name IN ('Arctium lappa', 'Hydrastis canadensis', 'Rumex crispus', 'Smilax spp.', 'Urtica dioica') THEN 'strong'::herbal.strength_level
    WHEN h.latin_name IN ('Iris versicolor') THEN 'very_strong'::herbal.strength_level
    ELSE 'mild'::herbal.strength_level
  END
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Digestive'
AND h.latin_name IN ('Allium sativum', 'Arctium lappa', 'Chionanthus virginicus', 'Hydrastis canadensis', 'Iris versicolor', 'Menyanthes trifoliata', 'Rumex crispus', 'Smilax spp.', 'Urtica dioica');

-- Urinary System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'strong'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Urinary'
AND h.latin_name IN ('Galium aparine', 'Urtica dioica');

-- Reproductive System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Reproductive'
AND h.latin_name IN ('Cimicifuga racemosa', 'Hydrastis canadensis');

-- Musculoskeletal System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'strong'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Musculoskeletal'
AND h.latin_name IN ('Cimicifuga racemosa', 'Menyanthes trifoliata', 'Arctium lappa');

-- Nervous System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Nervous'
AND h.latin_name IN ('Pulsatilla vulgaris', 'Trifolium pratense');

-- Skin System Alteratives
INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
SELECT h.id, pa.id, bs.id,
  CASE 
    WHEN h.latin_name IN ('Arctium lappa', 'Fumaria officinalis', 'Galium aparine', 'Hydrastis canadensis', 'Rumex crispus', 'Scrophularia nodosa', 'Smilax spp.', 'Trifolium pratense', 'Urtica dioica') THEN 'strong'::herbal.strength_level
    ELSE 'mild'::herbal.strength_level
  END
FROM herbal.herbs h
CROSS JOIN herbal.primary_actions pa
CROSS JOIN herbal.body_systems bs
WHERE pa.name = 'Alteratives' AND bs.name = 'Skin'
AND h.latin_name IN ('Arctium lappa', 'Mahonia aquifolium', 'Fumaria officinalis', 'Galium aparine', 'Echinacea spp.', 'Scrophularia nodosa', 'Smilax spp.', 'Rumex crispus', 'Trifolium pratense');

-- ============================================
-- SECONDARY ACTIONS for Alteratives
-- ============================================

-- Anticatarrhal
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Anticatarrhal'
AND h.latin_name IN ('Allium sativum', 'Baptisia tinctoria', 'Echinacea spp.', 'Hydrastis canadensis', 'Phytolacca americana', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Anti-inflammatory
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Anti-inflammatory'
AND h.latin_name IN ('Galium aparine', 'Guaiacum officinale', 'Hydrastis canadensis', 'Iris versicolor', 'Menyanthes trifoliata', 'Smilax spp.')
ON CONFLICT DO NOTHING;

-- Antimicrobial
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Antimicrobial'
AND h.latin_name IN ('Allium sativum', 'Baptisia tinctoria', 'Echinacea spp.', 'Hydrastis canadensis', 'Larrea tridentata', 'Phytolacca americana', 'Pulsatilla vulgaris', 'Sanguinaria canadensis')
ON CONFLICT DO NOTHING;

-- Antispasmodic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Antispasmodic'
AND h.latin_name IN ('Allium sativum', 'Cimicifuga racemosa', 'Pulsatilla vulgaris', 'Sanguinaria canadensis', 'Trifolium pratense')
ON CONFLICT DO NOTHING;

-- Astringent
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Astringent'
AND h.latin_name IN ('Hydrastis canadensis', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Bitter
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Bitter'
AND h.latin_name IN ('Arctium lappa', 'Hydrastis canadensis', 'Menyanthes trifoliata')
ON CONFLICT DO NOTHING;

-- Diaphoretic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Diaphoretic'
AND h.latin_name IN ('Allium sativum', 'Guaiacum officinale', 'Stillingia sylvatica', 'Smilax spp.')
ON CONFLICT DO NOTHING;

-- Diuretic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Diuretic'
AND h.latin_name IN ('Arctium lappa', 'Galium aparine', 'Guaiacum officinale', 'Iris versicolor', 'Menyanthes trifoliata', 'Smilax spp.', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Emmenagogue
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Emmenagogue'
AND h.latin_name IN ('Cimicifuga racemosa')
ON CONFLICT DO NOTHING;

-- Expectorant
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Expectorant'
AND h.latin_name IN ('Sanguinaria canadensis', 'Trifolium pratense', 'Verbascum thapsus')
ON CONFLICT DO NOTHING;

-- Hepatic
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Hepatic'
AND h.latin_name IN ('Allium sativum', 'Arctium lappa', 'Chionanthus virginicus', 'Hydrastis canadensis', 'Iris versicolor', 'Mahonia aquifolium', 'Menyanthes trifoliata', 'Phytolacca americana', 'Rumex crispus')
ON CONFLICT DO NOTHING;

-- Hypotensive
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Hypotensive'
AND h.latin_name IN ('Allium sativum', 'Cimicifuga racemosa', 'Urtica dioica')
ON CONFLICT DO NOTHING;

-- Nervine
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Nervine'
AND h.latin_name IN ('Cimicifuga racemosa', 'Pulsatilla vulgaris', 'Trifolium pratense')
ON CONFLICT DO NOTHING;

-- Vulnerary
INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)
SELECT h.id, sa.id
FROM herbal.herbs h
CROSS JOIN herbal.secondary_actions sa
WHERE sa.name = 'Vulnerary'
AND h.latin_name IN ('Galium aparine', 'Hydrastis canadensis')
ON CONFLICT DO NOTHING;

-- Insert all secondary actions first
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
  ('Vulnerary')
ON CONFLICT (name) DO NOTHING;

