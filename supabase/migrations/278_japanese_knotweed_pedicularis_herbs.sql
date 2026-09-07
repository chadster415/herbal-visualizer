-- Migration 278: Add Japanese Knotweed and Pedicularis to herbs table

SET search_path TO herbal, public;

INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES
  ('Japanese Knotweed', 'reynoutria japonica', 'Root'),
  ('Pedicularis',       'pedicularis spp.',    'Herb in flower')
ON CONFLICT DO NOTHING;

-- Link any pre-existing constituent_profiles rows (safe even if none exist yet)
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;
