-- Migration 338: Class 68 - Insert new herbs referenced in Integumentary III
-- These herbs were skipped in migration 335 (not in DB); data populated in migration 339.
-- Run order: 335 → 336 → 337 → 338 → 339 → 340

SET search_path TO herbal, public;

INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES
  ('Lemongrass',   'Cymbopogon citratus',      'Aerial parts'),
  ('Sumac',        'Rhus glabra',              'Bark, fruit'),
  ('Neem',         'Azadirachta indica',        'Leaf'),
  ('Bee Balm',     'Monarda fistulosa',         'Flowering herb'),
  ('Bidens',       'Bidens spp.',               'Aerial parts'),
  ('Jojoba',       'Simmondsia chinensis',       'Leaf'),
  ('Agarita',      'Berberis trifoliolata',      'Root bark, berry'),
  ('Pine Needles', 'Pinus spp.',                'Needles'),
  ('Maravilla',    'Mirabilis multiflorum',      'Root')
ON CONFLICT DO NOTHING;

-- Re-link any constituent_profiles rows that were inserted with herb_id = NULL
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;
