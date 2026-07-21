-- Migration 091: Set plant_part on herbs that are always used as a single part
--
-- These herbs have no split needed — all their disorder references, prescriptions,
-- and constituent data point to one part. We're just making the part explicit
-- so the sidebar displays correctly.
--
--   Marshmallow → root  (all prescriptions are root; constituent note: "Root highest in mucilage")
--   Mullein     → leaf  (all 7 prescriptions are respiratory leaf; flower oil = topical prep note only)
--   Raspberry   → leaf  (no prescriptions; specific remedy says "Raspberry leaf tones...")
--   Poke        → root  (specific remedy description = "root"; western use is exclusively root)
--   Peach       → leaf  (specific remedy description = "leaf"; no other part used)

SET search_path TO herbal, public;

UPDATE herbal.herbs SET plant_part = 'root' WHERE id = 45  AND latin_name = 'Althaea officinalis';
UPDATE herbal.herbs SET plant_part = 'leaf' WHERE id = 61  AND latin_name = 'Verbascum thapsus';
UPDATE herbal.herbs SET plant_part = 'leaf' WHERE id = 155 AND latin_name = 'Rubus idaeus';
UPDATE herbal.herbs SET plant_part = 'root' WHERE id = 35  AND latin_name = 'Phytolacca americana';
UPDATE herbal.herbs SET plant_part = 'leaf' WHERE id = 320 AND latin_name = 'Prunus persica';
