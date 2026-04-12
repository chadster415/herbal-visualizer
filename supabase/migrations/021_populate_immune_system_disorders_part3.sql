-- Populate Immune System disorders and data - Part 3
-- This includes: Antibiotic Recovery, Vaginitis, Genitourinary Tract Infections

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- ANTIBIOTIC RECOVERY
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Antibiotic Recovery', v_immune_system_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Once a course of antibiotics has been completed, herbs may be used to speed convalescence.', 1),
    (v_disorder_id, 'The focus here should be on general nutrition, as well as herbal tonics.', 2);

  -- Add Actions Indicated descriptions
  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will safely stimulate normal metabolism', 1);

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Gentle diuretics and hepatics will support elimination', 2);

  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Gentle diuretics and hepatics will support elimination', 3);

  v_action_id := herbal.ensure_action('Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Specific tonics will support the tissue affected at the site of infection and the primary sites of symptomatic discomfort', 4);

  -- Add Immune Support note (not a specific action, but a general indication)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Immune Support: This is important, and may entail both deep and surface work. Focus on deep immune support if: • The infection is a chronic or recurrent problem • The patient is very debilitated after the infection • The patient is elderly • The patient is under much stress of any kind, and thus at risk of becoming immunocompromised', 3);

  RAISE NOTICE 'Antibiotic Recovery disorder created';
END $$;

-- ============================================================================
-- VAGINITIS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Vaginitis', v_immune_system_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Prescription 1: Capsule formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Capsule Formula', 'Mix equal parts of the powders thoroughly and encapsulate in size 00 capsules. Take 2 capsules three times daily for 5 days, then take 2 days off. Continue this cycle for 4 weeks, or until symptoms subside.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Juglans nigra', 'black walnut');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'hull powder', 1);

  v_herb_id := herbal.ensure_herb('Larrea tridentata', 'chaparral');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'powder', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'root powder', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'root powder', 4);

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'root powder', 5);

  v_herb_id := herbal.ensure_herb('Tabebuia impetiginosa', 'pau d''arco');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'equal parts', 'powder', 6);

  -- Prescription 2: Dusting Powder (Yoni Powder)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Dusting Powder (Yoni Powder)', 'Combine all the ingredients and mix together using a wire whisk. Spoon some into a jar with a shaker top for easy application. Store the remainder in a glass jar with a tight-fitting lid.', 2)
  RETURNING id INTO v_prescription_id;

  -- Note: Non-herb ingredients (clay, cornstarch, tea tree oil) are not herbs and won't be added

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Juglans nigra';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 tablespoons', 'hull powder', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 tablespoons', 'powder', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 tablespoon', 'root powder (organically cultivated)', 3);

  RAISE NOTICE 'Vaginitis disorder created with 2 prescriptions';
END $$;

-- ============================================================================
-- GENITOURINARY TRACT INFECTIONS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Genitourinary Tract Infections', v_immune_system_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Add disorder note
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'A range of antimicrobials are uniquely suited to treating this part of the body. They are usually herbs rich in essential oils.', 1);

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Agathosma betulina', 'buchu');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Elymus repens', 'couch grass');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Juniperus communis', 'juniper');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Petroselinum crispum', 'parsley');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  RAISE NOTICE 'Genitourinary Tract Infections disorder created';
END $$;

-- Clean up helper functions (will be recreated in next part)
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
