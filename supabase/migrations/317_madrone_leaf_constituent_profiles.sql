-- Migration 317: constituent_profiles for Madrone leaf (Arbutus menziesii)
--
-- Source: User-provided marker constituent data, based on species-specific research:
--   - Frontiers in Physiology (2021) — KCNQ/KCNE pharmacology rationalizing dual analgesic/GI use
--   - PMC8632246 — confirming tannin and quercetin glycoside profile
--
-- Five compounds: Tannic acid (marker), Gallic acid (major),
--   Quercitrin (major), Quercetin-3-O-glucoside (major), Avicularin (major)
--
-- Arbutin deliberately excluded: identified in closely related A. unedo but not
-- demonstrated for A. menziesii in species-specific literature.
-- "Madronin" deliberately excluded: crude antibacterial mixture, not a defined molecule.
-- Bark is a separate chemical profile (betulinic acid reported) — not included here.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id INTEGER;
  v_note    TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs
  WHERE latin_name = 'Arbutus menziesii' AND plant_part = 'leaf';

  IF v_herb_id IS NULL THEN
    RAISE EXCEPTION 'Madrone leaf not found in herbs table — run migration 316 first';
  END IF;

  v_note := 'Arbutus menziesii leaf is characterized primarily by tannins and tannin-derived phenolics, accompanied by quercetin glycosides, supporting its traditional astringent, antimicrobial, gastrointestinal, analgesic, and anti-inflammatory uses. Species-specific experimental work demonstrates antibacterial activity and modulation of potassium channels relevant to pain and gastrointestinal function. The historical term "madronin" is excluded because it represents a crude antibacterial mixture rather than a chemically defined constituent. Arbutin is also excluded: it is well-established in closely related A. unedo but has not been specifically demonstrated for A. menziesii leaf in the reviewed literature.';

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Madrone', 'Arbutus menziesii', 'Leaf',
     'Tannic acid', 'Tannin', 'Hydrolyzable tannin', 'High', 'Marker',
     'Principal representative of the strongly tannin-rich leaf chemistry associated with astringent and antibacterial activity.',
     v_note),

    (v_herb_id, 'Madrone', 'Arbutus menziesii', 'Leaf',
     'Gallic acid', 'Polyphenol', 'Phenolic acid', 'High', 'Major',
     'Prominent tannin-related phenolic associated with antimicrobial, antioxidant, and astringent activity.',
     v_note),

    (v_herb_id, 'Madrone', 'Arbutus menziesii', 'Leaf',
     'Quercitrin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Quercetin glycoside contributing antioxidant and anti-inflammatory activity.',
     v_note),

    (v_herb_id, 'Madrone', 'Arbutus menziesii', 'Leaf',
     'Quercetin-3-O-glucoside', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Characteristic leaf flavonoid contributing antioxidant and inflammatory-modulating activity.',
     v_note),

    (v_herb_id, 'Madrone', 'Arbutus menziesii', 'Leaf',
     'Avicularin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Quercetin arabinoside representing the complementary flavonoid fraction of the leaf.',
     v_note)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Madrone leaf constituent_profiles: done (herb_id = %).', v_herb_id;
END $$;
