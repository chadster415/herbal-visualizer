-- Migration 262: Add 13 herbs required by Ellingwood (1919) herb-pairs data
-- Source: Finley Ellingwood, American Materia Medica, Therapeutics and Pharmacognosy (1919)
-- Input file: ellingwood_explicit_herb_pairings.txt
--
-- External references checked:
--   MM (Michael Moore): Aletris, Bryonia, Epilobium, Hyoscyamus, Cereus, Chamaelirium, Sticta, Datura — all have entries
--   Dispensatory (Easley): Chamaelirium (cooling/moistening), Selenicereus (cooling) — confirmed energetics
--   HOTE (Tilgner): Cactus/Selenicereus (1–15 drops), False unicorn/Chamaelirium (30–60 drops), Sticta (10–40 drops)
--   Stockley's: none of the 13 herbs appear
--   Hoffmann: none found
--
-- After running this migration, the following manifests need updating with the new herb IDs:
--   lib/mm-materia-medica.ts  — re-run scripts/parse-mm-materia-medica.py after adding SYNONYM_MAP entries
--   lib/hote-materia-medica.ts — add entries for Selenicereus (1–15 drops), Chamaelirium (30–60 drops), Sticta (10–40 drops)
--   lib/te-materia-medica.ts  — add entries for Chamaelirium (30–120 drops from 1–4 ml)

SET search_path TO herbal, public;

DO $$
BEGIN

  -- 1. Aletris farinosa
  --    MM: Tincture [1:5, 50% alcohol] 30–60 drops (add to mm-materia-medica.ts after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Aletris', 'Aletris farinosa', 'root',
    ARRAY['Star grass', 'True unicorn root', 'Starwort', 'Colic root', 'Ague grass', 'Bitter grass'])
  ON CONFLICT DO NOTHING;

  -- 2. Bryonia alba
  --    MM: Tincture [1:5, 50% alcohol] 2–10 drops, USE WITH CARE (add to mm-materia-medica.ts after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Bryonia', 'Bryonia alba', 'root',
    ARRAY['White bryony', 'Bryony', 'English mandrake', 'Wild hops', 'Devil''s turnip'])
  ON CONFLICT DO NOTHING;

  -- 3. Corydalis formosa (western eclectic species — distinct from TCM Corydalis yanhusuo in DB)
  --    MM: has a Corydalis entry but refers primarily to C. yanhusuo; C. formosa not separately listed
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Turkey Corn', 'Corydalis formosa', 'root',
    ARRAY['Squirrel corn', 'Wild bleeding heart', 'Corydalis', 'Turkey pea', 'Staggerweed'])
  ON CONFLICT DO NOTHING;

  -- 4. Epilobium angustifolium
  --    MM: Standard infusion, no tincture dosage given (add synonym to parse-mm-materia-medica.py)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Fireweed', 'Epilobium angustifolium', 'aerial parts',
    ARRAY['Fireweed', 'Great willowherb', 'Giant willowherb', 'Rosebay willowherb', 'Chamaenerion'])
  ON CONFLICT DO NOTHING;

  -- 5. Hyoscyamus niger
  --    MM: Tincture [1:5, 50% alcohol] 3–10 drops, USE WITH CARE (add to mm-materia-medica.ts after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Henbane', 'Hyoscyamus niger', 'leaf',
    ARRAY['Black henbane', 'Stinking nightshade', 'Fetid nightshade', 'Hog''s bean'])
  ON CONFLICT DO NOTHING;

  -- 6. Physostigma venenosum — no external reference hits
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Calabar Bean', 'Physostigma venenosum', 'seed',
    ARRAY['Ordeal bean', 'Chop nut', 'Esere nut', 'Physostigma'])
  ON CONFLICT DO NOTHING;

  -- 7. Selenicereus grandiflorus
  --    MM: Fresh Tincture [1:2] 5–15 drops (add to mm-materia-medica.ts after run)
  --    Dispensatory (Easley): ENERGETICS: Cooling — confirmed, no _inferred flag
  --    HOTE (Tilgner): 1:1 fresh extract 1–15 drops (add to hote-materia-medica.ts after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms, temperature)
  VALUES ('Night-Blooming Cereus', 'Selenicereus grandiflorus', NULL,
    ARRAY['Cactus grandiflorus', 'Queen of the night', 'Large-flowered cactus', 'Night-blooming cereus'],
    'cooling')
  ON CONFLICT DO NOTHING;

  -- 8. Chamaelirium luteum
  --    MM: Tincture [1:5, 50% alcohol] 10–40 drops (add to mm-materia-medica.ts after run)
  --    Dispensatory (Easley): ENERGETICS: Cooling and moistening — confirmed
  --    HOTE (Tilgner): 1:4 dry extract 30–60 drops (add to hote-materia-medica.ts after run)
  --    te-materia-medica.ts: 1–4 ml × 30 = 30–120 drops (add after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms, temperature, moisture)
  VALUES ('False Unicorn', 'Chamaelirium luteum', 'root',
    ARRAY['Helonias', 'Unicorn root', 'Blazing star', 'Devil''s bit', 'Fairy wand'],
    'cooling', 'moistening')
  ON CONFLICT DO NOTHING;

  -- 9. Sticta pulmonaria (lungwort lichen — Lobaria pulmonaria in modern taxonomy; ≠ Pulmonaria officinalis)
  --    MM: present under STICTA (Lobaria pulmonaria, Lungwort Moss)
  --    HOTE: 1:5 dry extract 10–40 drops (add to hote-materia-medica.ts after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Sticta', 'Sticta pulmonaria', 'thallus',
    ARRAY['Lungwort lichen', 'Tree lungwort', 'Lobaria', 'Oak lungwort', 'Lungwort moss'])
  ON CONFLICT DO NOTHING;

  -- 10. Ipomoea purga — no external reference hits
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Jalap', 'Ipomoea purga', 'root',
    ARRAY['Jalap root', 'Mexican jalap', 'Purga', 'High john the conqueror', 'Jalapa'])
  ON CONFLICT DO NOTHING;

  -- 11. Conium maculatum — MM has an entry (under CONIUM or hemlock); Hoffmann hit was false positive (Thuja)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Poison Hemlock', 'Conium maculatum', 'fruit',
    ARRAY['Hemlock', 'Spotted hemlock', 'Poison parsley', 'Spotted parsley', 'Musquash root', 'Beaver poison'])
  ON CONFLICT DO NOTHING;

  -- 12. Strophanthus kombé — mentioned in MM context but no dedicated entry; no other hits
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Strophanthus', 'Strophanthus kombé', 'seed',
    ARRAY['Kombé strophanthus', 'Kombé arrow poison', 'Kombe'])
  ON CONFLICT DO NOTHING;

  -- 13. Datura stramonium
  --    MM: Tincture [1:10, 60% alcohol] 3–10 drops, DANGEROUS IN MODERATE DOSES (add to mm-materia-medica.ts after run)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Stramonium', 'Datura stramonium', 'leaf',
    ARRAY['Jimsonweed', 'Thorn apple', 'Devil''s trumpet', 'Moon flower', 'Jamestown weed', 'Stinkwort'])
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Migration 262 complete — 13 Ellingwood herbs added.';
  RAISE NOTICE 'TODO after run: update mm-materia-medica.ts, hote-materia-medica.ts, te-materia-medica.ts with new herb IDs.';
END $$;
