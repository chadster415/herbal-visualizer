SET search_path TO herbal, public;

-- ============================================================
-- Bitter Melon (Momordica charantia) — corrections from Easley
-- Migration 209 inferred moisture = moistening; Easley's Dispensatory
-- confirms "Cooling and drying" — override with confirmed values.
-- Also adds synonyms.
-- ============================================================

-- Block 1 — Correct energetics to confirmed values (Easley: "Cooling and drying")
UPDATE herbal.herbs
SET temperature          = 'cooling',
    temperature_inferred = false,
    moisture             = 'drying',
    moisture_inferred    = false
WHERE latin_name = 'Momordica charantia';

-- Block 2 — Synonyms
UPDATE herbal.herbs
SET synonyms = ARRAY['Bitter Gourd', 'Karela', 'Balsam Pear', 'Bitter Cucumber', 'Ampalaya', 'Goya']
WHERE latin_name = 'Momordica charantia';
