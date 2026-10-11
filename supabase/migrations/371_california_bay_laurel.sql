-- Migration 371: Add California Bay Laurel (Umbellularia californica)
-- Source: Mentioned in BHC Class 24 herb walk (Huckleberry trail with Mer);
--         MM Materia Medica entry confirmed: UMBELLULARIA (California Bay, Pepperwood, Oregon Myrtle)
--         Not found in Easley's, Hoffmann's, Tilgner's, or Stockley's.

SET search_path TO herbal, public;

INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
VALUES (
  'California Bay Laurel',
  'Umbellularia californica',
  'Leaf',
  ARRAY['California Bay', 'Pepperwood', 'Oregon Myrtle', 'California Laurel', 'Bay Laurel', 'Headache Tree']
)
ON CONFLICT DO NOTHING;
