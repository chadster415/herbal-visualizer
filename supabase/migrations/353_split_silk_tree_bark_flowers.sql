-- Herb 2285 (Silk Tree, Albizia julibrissin) had no plant_part set.
-- Bark and flowers have distinct chemistry and clinical roles:
--   Bark: julibrosides/saponins → anxiolytic, mast-cell stabilizing, grounding
--   Flowers: quercetin-family flavonoids → nervine, uplifting, anti-inflammatory
-- This migration tags 2285 as bark, moves flower-specific constituents to a new flowers row,
-- and populates all supporting tables for the flowers herb.

-- 1. Tag existing row as bark
UPDATE herbal.herbs SET plant_part = 'bark' WHERE id = 2285;

-- 2. Delete flower-specific constituents from the bark row
--    (isoquercitrin 2850, okanin 2851, acacetin 2852, quercetin 2854, rutin 2855)
DELETE FROM herbal.herb_constituents WHERE id IN (2850, 2851, 2852, 2854, 2855);

-- 3. Insert the flowers herb
INSERT INTO herbal.herbs (common_name, latin_name, plant_part, temperature, moisture, tone)
VALUES ('Silk Tree', 'Albizia julibrissin', 'flowers', 'neutral', 'moistening', 'neutral');

-- 4. Flower constituents (isoquercitrin, okanin, acacetin, quercetin, rutin)
INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
SELECT h.id, c.constituent_id, 'minor'::herbal.concentration_level, c.sort_order
FROM herbal.herbs h,
     (VALUES (744, 10), (1513, 20), (766, 30), (741, 40), (742, 50)) AS c(constituent_id, sort_order)
WHERE h.latin_name = 'Albizia julibrissin' AND h.plant_part = 'flowers';

-- 5. Flower keywords — emotional/nervous system; eczema and mast-cell stabilizing are bark-specific (julibrosides)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, k.keyword, k.category
FROM herbal.herbs h,
     (VALUES ('depression', 'ailment'), ('stress', 'ailment'), ('grief support', 'general')) AS k(keyword, category)
WHERE h.latin_name = 'Albizia julibrissin' AND h.plant_part = 'flowers';

-- 6. Flower disorder-action links — nervine relaxant + anti-inflammatory; anti-allergic is bark-specific via mast-cell julibrosides
INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
SELECT da.disorder_id, h.id, da.primary_action_id, da.sort_order
FROM herbal.herbs h,
     (VALUES (190, 23, 50), (190, 4, 20)) AS da(disorder_id, primary_action_id, sort_order)
WHERE h.latin_name = 'Albizia julibrissin' AND h.plant_part = 'flowers';

-- 7. Flower class note snippets — copy the five general snippets (315 and 284 explicitly mention both
--    bark and flowers); bark-only snippets 1242 and 1267 remain on the bark row
INSERT INTO herbal.class_note_snippets (herb_id, class_name, snippet_text, note_type, section_header, sort_order, source_block)
SELECT h.id, src.class_name, src.snippet_text, src.note_type, src.section_header, src.sort_order, src.source_block
FROM herbal.herbs h,
     (SELECT class_name, snippet_text, note_type, section_header, sort_order, source_block
      FROM herbal.class_note_snippets WHERE id IN (284, 295, 315, 328, 1299)) src
WHERE h.latin_name = 'Albizia julibrissin' AND h.plant_part = 'flowers';

-- 8. Flower menstruum — flavonoids extractable in hot water or 40–60% alcohol; marked needs_review
INSERT INTO herbal.herb_menstruum (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
SELECT h.id, 40, 60, true, '40–60% alcohol or water infusion',
       'Flower flavonoids (quercetin, rutin, isoquercitrin, okanin, acacetin) are water-extractable; 40–60% alcohol preferred for the full flavonoid complement.',
       true
FROM herbal.herbs h
WHERE h.latin_name = 'Albizia julibrissin' AND h.plant_part = 'flowers';
