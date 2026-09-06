-- Migration 256: Add herbs required for Scudder 1898 pairings (migration 257)
-- Source: Scudder, American Eclectic Materia Medica and Therapeutics (12th ed., 1898)
--         via Henriette's Herbal transcription
--
-- All 12 herbs are referenced in scudder_herb_pairings_henriette_first_pass.txt
-- but were absent from the DB. Added here as minimal entries to support pairing data.
-- Constituent profiles, body system actions, and menstruum data to be added separately.
--
-- Expected IDs (sequence last_value=2597, is_called=t → next = 2598):
--   Aconitum napellus    → 2598    Apocynum cannabinum → 2599
--   Atropa belladonna    → 2600    Cannabis sativa     → 2601
--   Eupatorium purpureum → 2602    Strychnos ignatii   → 2603
--   Strychnos nux-vomica → 2604    Podophyllum peltatum→ 2605
--   Toxicodendron radicans→ 2606   Mentha spicata      → 2607
--   Veratrum viride      → 2608    Menispermum canadense→ 2609
--
-- Post-migration steps (update these lib/ files with confirmed IDs from RAISE NOTICE):
--   lib/hote-materia-medica.ts  — add Gravel Root (10–40 drops) and Veratrum (1–5 drops)
--   lib/dh-materia-medica.ts    — add Gravel Root (60 drops)
--   lib/contraindications-manifest.ts — add Cannabis (Stockley's pages 116–123)
--   scripts/parse-mm-materia-medica.py SYNONYM_MAP updated separately in this commit
--
-- External reference checks:
--   MM Materia Medica (Michael Moore): Aconitum columbianum, Apocynum cannabinum,
--     Cannabis sativa, Eupatorium purpureum, Menispermum, Mentha spicata,
--     Podophyllum, Veratrum found. Atropa, Strychnos spp., Rhus tox not in MM.
--   Stockley's Drug Interactions: Cannabis found (pages 116–123) — images to extract.
--   Easley's Dispensatory: Gravel Root found (energetics: cooling & drying; no drop dosage).
--   Hoffmann's Medical Herbalism: Gravel Root found (2 ml × 30 = 60 drops per dose).
--   Tilgner's Heart of the Earth: Gravel Root (10–40 drops), Veratrum (1–5 drops, expert use).

SET search_path TO herbal, public;

DO $$
DECLARE
  v_id INTEGER;
BEGIN

  -- ── 1. Aconite / Wolfsbane — Aconitum napellus ──────────────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Aconite', 'Aconitum napellus', NULL,
    ARRAY['Wolfsbane', 'Monkshood', 'Blue Monkshood', 'Aconitum', 'Aconite Root',
          'Napellus', 'Blue Rocket', 'Friar''s Cap'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Aconitum napellus' AND plant_part IS NULL;
  END IF;
  RAISE NOTICE 'Aconitum napellus id=%', v_id;

  -- ── 2. Dogbane / Canadian Hemp — Apocynum cannabinum ────────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Dogbane', 'Apocynum cannabinum', 'Root',
    ARRAY['Canada Hemp', 'Canadian Hemp', 'Indian Hemp', 'Black Indian Hemp',
          'American Hemp', 'Bitter Root', 'Fly-trap', 'Amy Root'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Apocynum cannabinum' AND plant_part = 'Root';
  END IF;
  RAISE NOTICE 'Apocynum cannabinum id=%', v_id;

  -- ── 3. Belladonna / Deadly Nightshade — Atropa belladonna ───────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Belladonna', 'Atropa belladonna', NULL,
    ARRAY['Deadly Nightshade', 'Belladonna Root', 'Belladonna Leaf', 'Atropa',
          'Devil''s Cherries', 'Beautiful Lady', 'Naughty Man''s Cherries'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Atropa belladonna' AND plant_part IS NULL;
  END IF;
  RAISE NOTICE 'Atropa belladonna id=%', v_id;

  -- ── 4. Cannabis / Hemp — Cannabis sativa ────────────────────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Cannabis', 'Cannabis sativa', 'Aerial parts',
    ARRAY['Hemp', 'Indian Hemp', 'Cannabis indica', 'Marijuana', 'Ganja',
          'Cannabis sativa var. indica', 'Medical Cannabis'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Cannabis sativa' AND plant_part = 'Aerial parts';
  END IF;
  RAISE NOTICE 'Cannabis sativa id=%', v_id;

  -- ── 5. Gravel Root / Joe Pye Weed — Eupatorium purpureum ────────────────────
  -- Energetics: cooling & drying (Easley's Dispensatory, confirmed source value)
  -- Contraindications: pyrrolizidine alkaloids; not for long-term use or pregnancy (Easley)
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms,
    temperature, temperature_inferred, moisture, moisture_inferred,
    contraindications, contraindications_source)
  VALUES ('Gravel Root', 'Eupatorium purpureum', 'Root',
    ARRAY['Joe Pye Weed', 'Purple Boneset', 'Queen of the Meadow', 'Kidney Root',
          'Trumpet Weed', 'Sweet Joe Pye Weed', 'Gravel Weed'],
    'cooling', false, 'drying', false,
    'Contains pyrrolizidine alkaloids. Not recommended for long-term use. Contraindicated in pregnancy and breastfeeding. May cause allergic reactions in persons sensitive to Asteraceae.',
    'Easley''s Dispensatory / Hoffmann''s Medical Herbalism')
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Eupatorium purpureum' AND plant_part = 'Root';
  END IF;
  RAISE NOTICE 'Eupatorium purpureum id=%', v_id;

  -- ── 6. Ignatia / St. Ignatius Bean — Strychnos ignatii ──────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Ignatia', 'Strychnos ignatii', 'Seed',
    ARRAY['St. Ignatius Bean', 'Ignatius Bean', 'Nux ignatia', 'Ignatia amara',
          'Saint Ignatius Bean'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Strychnos ignatii' AND plant_part = 'Seed';
  END IF;
  RAISE NOTICE 'Strychnos ignatii id=%', v_id;

  -- ── 7. Nux Vomica / Poison Nut — Strychnos nux-vomica ───────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Nux Vomica', 'Strychnos nux-vomica', 'Seed',
    ARRAY['Poison Nut', 'Quaker Button', 'Strychnine Nut', 'Bachelor''s Button',
          'Brucine Nut', 'Vomit Nut'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Strychnos nux-vomica' AND plant_part = 'Seed';
  END IF;
  RAISE NOTICE 'Strychnos nux-vomica id=%', v_id;

  -- ── 8. Podophyllum / Mayapple — Podophyllum peltatum ────────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Podophyllum', 'Podophyllum peltatum', 'Root',
    ARRAY['Mayapple', 'American Mandrake', 'Wild Lemon', 'Hog Apple', 'May Apple',
          'Duck''s Foot', 'Indian Apple', 'Raccoon Berry'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Podophyllum peltatum' AND plant_part = 'Root';
  END IF;
  RAISE NOTICE 'Podophyllum peltatum id=%', v_id;

  -- ── 9. Poison Ivy / Rhus Tox — Toxicodendron radicans ───────────────────────
  -- Historical eclectic use in minute doses for rheumatic/neuralgic conditions.
  -- Scudder's "Rhus" in dysmenorrhoea and orchitis contexts refers to this species.
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Poison Ivy', 'Toxicodendron radicans', 'Leaf',
    ARRAY['Rhus toxicodendron', 'Rhus Tox', 'Eastern Poison Ivy', 'Rhus radicans',
          'Poison Oak (Eastern)', 'Three-leafed Ivy'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Toxicodendron radicans' AND plant_part = 'Leaf';
  END IF;
  RAISE NOTICE 'Toxicodendron radicans id=%', v_id;

  -- ── 10. Spearmint — Mentha spicata ──────────────────────────────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Spearmint', 'Mentha spicata', 'Aerial parts',
    ARRAY['Garden Spearmint', 'Common Spearmint', 'Mentha viridis', 'Green Mint',
          'Lamb Mint', 'Mackerel Mint', 'Our Lady''s Mint', 'Yerba Buena'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Mentha spicata' AND plant_part = 'Aerial parts';
  END IF;
  RAISE NOTICE 'Mentha spicata id=%', v_id;

  -- ── 11. Veratrum / American Hellebore — Veratrum viride ─────────────────────
  -- Tilgner: 1–5 drops, acute short-term only; expert practitioners only.
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Veratrum', 'Veratrum viride', 'Root',
    ARRAY['American Hellebore', 'Green Hellebore', 'False Hellebore', 'Indian Poke',
          'Itch-weed', 'Tickleweed', 'Swamp Hellebore', 'Bear Corn', 'Crow Poison'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Veratrum viride' AND plant_part = 'Root';
  END IF;
  RAISE NOTICE 'Veratrum viride id=%', v_id;

  -- ── 12. Yellow Parilla / Moonseed — Menispermum canadense ───────────────────
  INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
  VALUES ('Yellow Parilla', 'Menispermum canadense', 'Root',
    ARRAY['Moonseed', 'Canadian Moonseed', 'Yellow Sarsaparilla', 'Canada Moonseed',
          'Texas Sarsaparilla', 'Common Moonseed'])
  ON CONFLICT DO NOTHING
  RETURNING id INTO v_id;
  IF v_id IS NULL THEN
    SELECT id INTO v_id FROM herbal.herbs WHERE latin_name = 'Menispermum canadense' AND plant_part = 'Root';
  END IF;
  RAISE NOTICE 'Menispermum canadense id=%', v_id;

  RAISE NOTICE 'Migration 256 complete — 12 herbs inserted for Scudder pairings.';
END $$;
