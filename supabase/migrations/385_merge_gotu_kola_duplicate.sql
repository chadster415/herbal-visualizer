-- Migration 385: Remove duplicate Gotu Kola entry
--
-- Two rows existed for Centella asiatica:
--   id=2229 — Gotu Kola, plant_part='aerial parts', has 23 snippets / 30 keywords / constituents / menstruum
--   id=2649 — Gotu Kola, plant_part=NULL, no data in any child table
--
-- id=2649 is an empty duplicate; delete it.

SET search_path TO herbal, public;

DELETE FROM herbal.herbs WHERE id = 2649 AND common_name = 'Gotu Kola' AND latin_name = 'Centella asiatica';
