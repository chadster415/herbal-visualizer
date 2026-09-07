-- Migration 280: Fix Pedicularis species name; add constituent_profiles for
-- Japanese Knotweed and Pedicularis densiflora.

SET search_path TO herbal, public;

-- Pedicularis: correct latin_name to species level; align plant_part with constituent data
UPDATE herbal.herbs
SET latin_name = 'pedicularis densiflora',
    plant_part = 'Aerial parts'
WHERE latin_name = 'pedicularis spp.';

-- Re-link any constituent_profiles rows that may now match (safe no-op if none)
UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL;

-- ═══════════════════════════════════════════════════════════════
-- JAPANESE KNOTWEED — constituent_profiles
-- ═══════════════════════════════════════════════════════════════
DO $$
DECLARE
  v_herb_id INTEGER;
  v_note    TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'reynoutria japonica';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Japanese Knotweed not found'; RETURN; END IF;

  v_note := 'Reynoutria japonica root and rhizome are chemically distinguished by the combination of resveratrol-derived stilbenes and anthraquinones. Polydatin is often quantitatively dominant among the stilbenes, while emodin and physcion represent the characteristic quinone fraction. Preserving both families is important because either one alone would underrepresent Japanese Knotweed''s unusually distinctive medicinal chemistry.';

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Japanese Knotweed', 'Reynoutria japonica', 'Root/rhizome',
     'Polydatin', 'Glycoside', 'Stilbene glycoside', 'High', 'Marker',
     'Major resveratrol glucoside and important quality marker contributing antioxidant and anti-inflammatory activity.',
     v_note),
    (v_herb_id, 'Japanese Knotweed', 'Reynoutria japonica', 'Root/rhizome',
     'Resveratrol', 'Polyphenol', 'Stilbene', 'High', 'Marker',
     'Characteristic bioactive stilbene associated with antioxidant, anti-inflammatory, and cardiovascular effects.',
     v_note),
    (v_herb_id, 'Japanese Knotweed', 'Reynoutria japonica', 'Root/rhizome',
     'Emodin', 'Anthraquinone', 'Anthraquinone', 'High', 'Marker',
     'Major anthraquinone contributing antimicrobial, anti-inflammatory, and laxative-related activity.',
     v_note),
    (v_herb_id, 'Japanese Knotweed', 'Reynoutria japonica', 'Root/rhizome',
     'Physcion', 'Anthraquinone', 'Anthraquinone', 'Moderate', 'Major',
     'Characteristic methoxylated anthraquinone accompanying emodin in the medicinal root.',
     v_note),
    (v_herb_id, 'Japanese Knotweed', 'Reynoutria japonica', 'Root/rhizome',
     'Emodin-8-O-β-D-glucoside', 'Anthraquinone', 'Anthraquinone glycoside', 'Moderate', 'Major',
     'Characteristic glycosylated anthraquinone contributing to the broader quinone fraction.',
     v_note),
    (v_herb_id, 'Japanese Knotweed', 'Reynoutria japonica', 'Root/rhizome',
     'Resveratroloside', 'Glycoside', 'Stilbene glycoside', 'Moderate', 'Major',
     'Additional characteristic stilbene glycoside complementing the dominant polydatin/resveratrol fraction.',
     v_note)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Japanese Knotweed constituent_profiles: done.';
END $$;

-- ═══════════════════════════════════════════════════════════════
-- PEDICULARIS DENSIFLORA — constituent_profiles
-- ═══════════════════════════════════════════════════════════════
DO $$
DECLARE
  v_herb_id INTEGER;
  v_note    TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'pedicularis densiflora';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Pedicularis densiflora not found'; RETURN; END IF;

  v_note := 'Pedicularis densiflora appears to share the characteristic iridoid-glycoside and phenylethanoid-glycoside chemistry of the genus Pedicularis, with aucubin and verbascoside the most defensible named representatives. However, modern species- and plant-part-specific phytochemical characterization is sparse, so these are retained as Reported rather than Marker or Major rather than importing the much richer chemistry established for other Pedicularis species.';

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Pedicularis', 'Pedicularis densiflora', 'Aerial parts',
     'Aucubin', 'Glycoside', 'Iridoid glycoside', 'Moderate', 'Reported',
     'Iridoid glycoside widely characteristic of Pedicularis and reported for Indian Warrior, but species-specific analytical documentation is limited.',
     v_note),
    (v_herb_id, 'Pedicularis', 'Pedicularis densiflora', 'Aerial parts',
     'Verbascoside', 'Polyphenol', 'Phenylethanoid glycoside', 'Moderate', 'Reported',
     'Characteristic phenylethanoid glycoside of the genus and repeatedly attributed to P. densiflora, though strong species-specific quantitative evidence is lacking.',
     v_note)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Pedicularis densiflora constituent_profiles: done.';
END $$;
