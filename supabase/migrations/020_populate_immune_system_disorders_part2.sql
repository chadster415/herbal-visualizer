-- Populate Immune System disorders and data - Part 2
-- This includes: Postoperative Recovery and Infection

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
-- POSTOPERATIVE RECOVERY
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
  VALUES ('Postoperative Recovery', v_immune_system_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'To support the body system that is the focus of the surgical procedure, choose relevant tonic remedies', 1),
    (v_disorder_id, 'Consider Urtica for skin and membranes, Crataegus and Ginkgo for blood vessels, and Hypericum for nerves.', 2);

  -- Adaptogen
  v_action_id := herbal.ensure_action('Adaptogen');

  v_herb_id := herbal.ensure_herb('Eleutherococcus senticosus', 'Siberian ginseng');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'help the body adapt around the problem and avoid the possibility of collapse', 1);

  -- Alterative
  v_action_id := herbal.ensure_action('Alterative');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'avoid strong immunostimulants and instead use a mild alterative', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'avoid strong immunostimulants and instead use a mild alterative', 2);

  -- Hepatic
  v_action_id := herbal.ensure_action('Hepatic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Silybum marianum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'support the liver''s detoxification process, facilitating the removal of the metabolites from the body and speeding the return to normal. This is the main herb to consider, as it is best to avoid stronger liver stimulants after an operation', 1);

  -- Vulnerary
  v_action_id := herbal.ensure_action('Vulnerary');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'excellent for limiting the amount of scar tissue that forms without compromising the viability of the wound healing, when blended with Vitamin E oil', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hypericum perforatum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'excellent for limiting the amount of scar tissue that forms without compromising the viability of the wound healing, when blended with Vitamin E oil', 2);

  RAISE NOTICE 'Postoperative Recovery disorder created';
END $$;

-- ============================================================================
-- INFECTION
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
  VALUES ('Infection', v_immune_system_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Baptisia tinctoria';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'The Eclectics recommended this in combination with Echinacea for acute febrile infections.', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'appropriate for a bladder infection', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'good choice for topical application', 3);

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');

  v_herb_id := herbal.ensure_herb('Nepeta cataria', 'catnip');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'good choice for children', 1);

  v_herb_id := herbal.ensure_herb('Armoracia rusticana', 'horseradish');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'reserve this diaphoretic for adults', 2);

  -- Tonic
  v_action_id := herbal.ensure_action('Tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'may be the right choice for a lung infection', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'more appropriate for lymphatic tissue infections', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Crataegus spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'use this as a tonic if there is any concern about cardiovascular health', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Ginkgo biloba';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, note, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 'use this as a tonic for an elderly patient', 4);

  RAISE NOTICE 'Infection disorder created';
END $$;

-- Clean up helper functions (will be recreated in next part)
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
