-- Populate GI/Digestive System Disorders Data
-- Data extracted from GI.md
-- This migration auto-creates missing herbs and actions

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Function to get or create herb by latin name
CREATE OR REPLACE FUNCTION get_or_create_herb(p_latin_name TEXT, p_common_name TEXT DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
  v_common_name TEXT;
BEGIN
  -- Try to find existing herb
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;

  IF v_herb_id IS NULL THEN
    -- Extract common name from latin name if not provided
    v_common_name := COALESCE(p_common_name, INITCAP(SPLIT_PART(p_latin_name, ' ', 1)));

    -- Create new herb
    INSERT INTO herbal.herbs (latin_name, common_name)
    VALUES (p_latin_name, v_common_name)
    RETURNING id INTO v_herb_id;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

-- Function to get or create primary action by name
CREATE OR REPLACE FUNCTION get_or_create_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  -- Try to find existing action
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;

  IF v_action_id IS NULL THEN
    -- Create new action
    INSERT INTO herbal.primary_actions (name)
    VALUES (p_action_name)
    RETURNING id INTO v_action_id;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- POPULATE GI DISORDERS
-- ============================================================================

DO $$
DECLARE
  v_digestive_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_prescription_herb_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  -- Get Digestive system ID
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';

  -- ============================================================================
  -- DISORDER: Constipation
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Constipation', v_digestive_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Dosage: up to 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  -- Prescription Herbs
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Rumex crispus', 'Yellow Dock'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '2 parts', 'root', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Pimpinella anisum', 'Anise'), '1 part', 3);

  -- ============================================================================
  -- DISORDER: Diarrhea
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Diarrhea', v_digestive_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'),
    'May well be the best gentle overall treatment for diarrhea, as it seems to tone the lining of the small intestine', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), 'Excellent remedy', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Alchemilla spp.', 'Lady''s Mantle'), 'Excellent remedy', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), 'Excellent remedy', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Quercus spp.', 'Oak'), 'Stronger astringent, should be used only as a last resort', 5);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Combine dried herbs and prepare as an infusion; drink regularly throughout the day until symptoms subside.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- ============================================================================
  -- DISORDER: Aphthous Ulcers
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Aphthous Ulcers', v_digestive_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'Play a core role by reducing the localized mucosal reaction.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'Inhibit the development of infection or prevent the spread of bacteria to the rest of the body, which can occur due to impaired buccal immune response.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Immune Support'),
    'Necessary if the ulcers suggest a systemic problem.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'Will help with any metabolic problems that might be present.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'Help soothe and relieve symptoms.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'Assist the individual in coping with stress; counseling may also be indicated', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Adaptogen'),
    'Assist the individual in coping with stress; counseling may also be indicated', 7);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Alterative'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Lymphatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Lymphatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Vulnerary'), 1);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Salvia officinalis', 'Sage'),
    'This is a variety of ordinary sage that contains a stronger volatile oil. While it is rarely used in cooking, it makes a perfect herb to use as a mouthwash for aphthous ulcers and other inflammatory conditions of the mouth.', 1);

  -- Prescription 1: Mouthwash
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Mouthwash', 'Combine dried herbs and prepare as an infusion, to be gargled often.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Salvia officinalis', 'Sage'), '1 part', 'var. rubia', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 2);

  -- Prescription 2: Internal use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Internal use', 'Dosage - up to 3 ml of tincture three times a day', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Galium aparine', 'Cleavers'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '1 part', 3);

  -- ============================================================================
  -- DISORDER: Periodontal Disease
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Periodontal Disease', v_digestive_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'Essential to reduce populations of bacteria that contribute to the decay process.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'Reduce any localized mucosal reaction.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'Lessen local bleeding and other exudations.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Circulatory Stimulant'),
    'Promote the circulation of blood in the gums, aiding in detoxification.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Immune Support'),
    'Necessary if gum disease suggests a systemic problem.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'Help the body deal with any systemic problems related to the disease.', 6);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Commiphora molmol', 'Myrrh'),
    'May be considered a specific remedy here, as it has powerful antimicrobial effects against the pathogens that cause gum disease.', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Krameria triandra', 'Rhatany'),
    'An astringent herb from Peru, has proved uniquely effective for gum disease. Some proprietary herbal toothpastes can help support treatment', 2);

  -- Prescription 1: Gum application
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Gum application',
    'Combine tinctures and apply to the gums three times a day using a very fine brush. An infusion of buccal anti-inflammatory herbs, such as Salvia and Matricaria, may be used as a mouthwash, Do not swallow.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Commiphora molmol', 'Myrrh'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Krameria triandra', 'Rhatany'), '1 part', 3);

  -- Prescription 2: Internal use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Internal use', 'Dosage - up to 5 ml of tincture combination three times a day', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Galium aparine', 'Cleavers'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), get_or_create_action('Alterative'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Lymphatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Galium aparine', 'Cleavers'), get_or_create_action('Lymphatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), get_or_create_action('Lymphatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Zanthoxylum americanum', 'Prickly Ash'), get_or_create_action('Circulatory Stimulant'), 1);

  -- ============================================================================
  -- DISORDER: GERD
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('GERD', v_digestive_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe and coat the tissue of the esophagus, insulating the mucosal lining against acidic gastric contents.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'aid the natural healing of ulcerations and other lesions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding and other exudatations.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'help the body deal with any systemic problems related to the disease.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'may be needed if there is general disruption of digestive process.', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 5 ml of tincture three times a day. In addition, an infusion of the anti-inflammatory herb Matricaria, sipped slowly throughout the day, can be helpful. As an alternative, a cold infusion of Althaea root can be taken whenever needed.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Lymphatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 1);

  -- ============================================================================
  -- DISORDER: Gastritis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Gastritis', v_digestive_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe the lining of the stomach, by either coating the stomach or exerting anti-inflammatory actions.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antacid'),
    'have little more to offer than symptomatic relief.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'enhance the stomach''s natural wound-healing abilities.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress involvement.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'help the body deal with any systemic problems related to the disease', 7);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: Take tincture in divided doses, to 5 ml in total, three times a day. An infusion of Matricaria or Melissa sipped slowly throughout the day will also help.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '3 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 1);

  -- ============================================================================
  -- DISORDER: Peptic Ulcers
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Peptic Ulcers', v_digestive_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe the lining of the stomach, either by coating the stomach or exerting anti-inflammatory actions.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'are indicated for dealing with H. pylori. However, these herbs must be active in the stomach in order for them to be effective.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'speed natural wound healing', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'will reduce any flatulence in the gastrointestinal tract.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress involvement.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'aid the healing process in the latter stages of treatment.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'help the body deal with any systemic problems related to the disease.', 9);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '', 5);

  -- Prescription 1
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Focuses on reducing inflammation and beginning the healing process. Dosage: 5 ml of tincture combination three times a day. In addition, a cold infusion of these herbs (fresh or dried) may be drunk often to ease symptoms. Matricaria infusion drunk on an empty stomach will reduce inflammation and help reverse the ulcerative process. Caution: If symptoms have not subsided within a week, seek skilled diagnosis.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '1 part', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '1 part', 'root', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  -- Prescription 2
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Focuses on the second step in the healing process, to tone and complete healing. Dosage: 5 ml of tincture combination three times a day. Caution: If symptoms have not subsided within a week, seek skilled diagnosis.', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '2 parts', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Astringent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Vulnerary'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Bitter'), 1);

  -- ============================================================================
  -- DISORDER: Hiatus Hernia
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Hiatus Hernia', v_digestive_id, 8)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe the lining of the stomach, by either coating the mucosa or exerting anti-inflammatory actions.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'speed natural wound healing and may help strengthen the diaphragm.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'lessen local bleeding.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'will help with any flatulence or colic.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress involvement', 6);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'),
    'Symphytum has an especially valid role because of its content of allantoin, a constituent that promotes wound healing.', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Calendula officinalis', 'Calendula'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '', 5);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. An infusion of these herbs (fresh or dried) may be drunk often to ease symptoms. Carminative nervines may be added if stress is a major component. (Valeriana officinalis is a good example.)', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '1 part', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), '1 part', 'root', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), '1 part', 3);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Althaea officinalis', 'Marshmallow'), get_or_create_action('Demulcent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Astringent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Filipendula ulmaria', 'Meadowsweet'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  -- ============================================================================
  -- DISORDER: Functional Dyspepsia
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Functional Dyspepsia', v_digestive_id, 9)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Functional dyspepsia, often referred to as "indigestion," is a vague and variable problem that is functional in nature but usually not caused by underlying structural issues.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Specific remedies are often bitter carminatives or nervine carminatives.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Often, the traditional simple (tea made from a single fresh remedy) is the best treatment.', 3);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Indigestion may be disease-related, but for the most part, it results from eating too much or too quickly, eating high-fat foods, or eating during stressful situations. Smoking, alcohol, medications that irritate the stomach lining, fatigue, and ongoing stress can also aggravate or cause indigestion.', 4);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Exercising with a full stomach may also cause indigestion,', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Gentiana lutea', 'Gentian'), '', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Melissa officinalis', 'Lemon Balm'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Humulus lupulus', 'Hops'), '', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'For indigestion. Dosage: 2.5 ml of tincture combination 10 minutes before eating', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Gentiana lutea', 'Gentian'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 4);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Melissa officinalis', 'Lemon Balm'), get_or_create_action('Carminative'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Melissa officinalis', 'Lemon Balm'), get_or_create_action('Anti-inflammatory'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Gentiana lutea', 'Gentian'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 2);

END $$;

-- Cleanup helper functions
DROP FUNCTION IF EXISTS get_or_create_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS get_or_create_action(TEXT);

-- ============================================================================
-- NOTE: This migration contains 9 disorders. Due to file size constraints,
-- the remaining disorders will be in a continuation file (011_populate_gi_disorders_part2.sql):
--
-- - Irritable Bowel Syndrome
-- - Ulcerative Colitis
-- - Diverticulitis
-- - Liver Disease
-- - Jaundice
-- - Chronic Hepatitis
-- - Viral Hepatitis
-- - Cirrhosis
-- - Cholecystitis
-- - Cholelithiasis
-- - Hemorrhoids
-- ============================================================================
