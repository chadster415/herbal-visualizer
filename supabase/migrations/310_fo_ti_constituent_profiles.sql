-- Migration 310: constituent_profiles for Fo-Ti (Reynoutria multiflora / Polygonum multiflorum)
--
-- Source: User-provided marker constituent data
-- Six compounds: THSG (marker), emodin (marker), physcion (marker),
--   emodin-8-O-β-D-glucoside (major), physcion-8-O-β-D-glucoside (major), polydatin (major)
-- No new subclasses needed: Stilbene glycoside and Anthraquinone glycoside already exist.

SET search_path TO herbal, public;

DO $$
DECLARE
  v_herb_id INTEGER;
  v_note    TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Polygonum multiflorum';
  IF v_herb_id IS NULL THEN RAISE EXCEPTION 'Fo Ti not found in herbs table'; END IF;

  v_note := 'Reynoutria multiflora root is chemically characterized by two complementary families: stilbene glycosides, dominated by THSG, and free and glycosylated anthraquinones, particularly emodin and physcion derivatives. THSG, emodin, and physcion are established quality markers, while their relative concentrations change with processing, making this profile useful for representing the underlying plant chemistry without conflating raw and traditionally processed Fo-Ti.';

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Fo-Ti', 'Reynoutria multiflora', 'Root',
     '2,3,5,4''-Tetrahydroxystilbene-2-O-β-D-glucoside (THSG)', 'Glycoside', 'Stilbene glycoside', 'High', 'Marker',
     'Dominant characteristic stilbene glycoside and major quality-control marker of the medicinal root.',
     v_note),
    (v_herb_id, 'Fo-Ti', 'Reynoutria multiflora', 'Root',
     'Emodin', 'Anthraquinone', 'Anthraquinone', 'High', 'Marker',
     'Characteristic free anthraquinone used with THSG and physcion in quality assessment.',
     v_note),
    (v_herb_id, 'Fo-Ti', 'Reynoutria multiflora', 'Root',
     'Physcion', 'Anthraquinone', 'Anthraquinone', 'High', 'Marker',
     'Characteristic methoxylated anthraquinone and established quality-control constituent.',
     v_note),
    (v_herb_id, 'Fo-Ti', 'Reynoutria multiflora', 'Root',
     'Emodin-8-O-β-D-glucoside', 'Glycoside', 'Anthraquinone glycoside', 'High', 'Major',
     'Dominant glycosylated anthraquinone characteristic of unprocessed root material.',
     v_note),
    (v_herb_id, 'Fo-Ti', 'Reynoutria multiflora', 'Root',
     'Physcion-8-O-β-D-glucoside', 'Glycoside', 'Anthraquinone glycoside', 'High', 'Major',
     'Major glycosylated physcion derivative contributing to the characteristic anthraquinone fraction.',
     v_note),
    (v_herb_id, 'Fo-Ti', 'Reynoutria multiflora', 'Root',
     'Polydatin', 'Glycoside', 'Stilbene glycoside', 'Moderate', 'Major',
     'Resveratrol glucoside accompanying THSG within the characteristic stilbene fraction.',
     v_note)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Fo-Ti constituent_profiles: done (herb_id = %).', v_herb_id;
END $$;
