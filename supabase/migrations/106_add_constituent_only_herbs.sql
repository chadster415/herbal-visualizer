-- Migration 106: Add herbs present in constituent_profiles but missing from herbs table
-- These 29 herbs have constituent chemistry data but no herbs entry, so they don't appear
-- in the frontend at all. Adding them here makes them visible with their Constituents and
-- Alternates sections. Primary actions, body systems, and disorders can be linked later.
--
-- 8 entries have naming conflicts with existing herbs (different species, same common name).
-- Those receive disambiguated common names below.

BEGIN;

INSERT INTO herbal.herbs (common_name, latin_name, plant_part) VALUES
  -- Completely new herbs (no naming conflict)
  ('Asian Devil''s Club',   'Oplopanax elatus',       'Root bark'),
  ('Chicory',               'Cichorium intybus',       'Root'),
  ('Corydalis',             'Corydalis yanhusuo',      'Tuber'),
  ('Gotu Kola',             'Centella asiatica',       'Aerial parts'),
  ('Grape Seed',            'Vitis vinifera',          'Seed'),
  ('Grindelia',             'Grindelia squarrosa',     'Flowering tops'),
  ('Gymnema',               'Gymnema sylvestre',       'Leaf'),
  ('Hibiscus',              'Hibiscus sabdariffa',     'Calyx'),
  ('Japanese Honeysuckle',  'Lonicera japonica',       'Flower bud'),
  ('Lemon Verbena',         'Aloysia citrodora',       'Leaf'),
  ('Lovage',                'Levisticum officinale',   'Root'),
  ('Madder',                'Rubia tinctorum',         'Root'),
  ('Peony',                 'Paeonia lactiflora',      'Root'),
  ('Pipsissewa',            'Chimaphila umbellata',    'Aerial parts'),
  ('Psyllium',              'Plantago ovata',          'Seed husk'),
  ('White Oak',             'Quercus alba',            'Bark'),
  ('White Pond Lily',       'Nymphaea odorata',        'Rhizome'),
  ('Yohimbe',               'Pausinystalia johimbe',   'Bark'),
  ('Yucca',                 'Yucca spp.',              'Root'),
  ('Zedoary',               'Curcuma zedoaria',        'Rhizome'),

  -- Disambiguated: share a common name with an existing herb (different species)
  -- Existing: Asian Mint = Mentha arvensis var. piperascens
  ('Agastache',             'Agastache rugosa',        'Aerial parts'),
  -- Existing: Bupleurum = Bupleurum falcatum
  ('Bupleurum (chinense)',  'Bupleurum chinense',      'Root'),
  -- Existing: Kelp = Fucus vesiculosus
  ('Kelp (Laminaria)',      'Laminaria digitata',      'Thallus'),
  ('Kelp (Saccharina)',     'Saccharina latissima',    'Blade'),
  -- Existing: Periwinkle = Vinca major
  ('Lesser Periwinkle',     'Vinca minor',             'Aerial parts'),
  -- Existing: Pill-Bearing Spurge = Euphorbia pilulifera; E. lathyris is Caper Spurge
  ('Caper Spurge',          'Euphorbia lathyris',      'Seed'),
  -- Existing: Rose = Rosa gallica
  ('Rose (Rosa spp.)',      'Rosa spp.',               'Petal'),
  -- Existing: Silk Tassel = Garrya fremontii
  ('Silk Tassel (elliptica)', 'Garrya elliptica',      'Bark'),
  -- Existing: Thyme = Thymus vulgaris
  ('Thyme (spp.)',          'Thymus spp.',             'Leaf')
;

-- Link all newly inserted herbs back to their constituent_profiles rows
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;

COMMIT;
