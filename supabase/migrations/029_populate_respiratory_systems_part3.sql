-- Populate Respiratory Systems - Part 3
-- Lower Respiratory: Post-Bronchitis Recovery and Chronic Bronchitis
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - POST-BRONCHITIS RECOVERY
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Post-Bronchitis Recovery disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Post-Bronchitis Recovery', v_lower_resp_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'A bout of acute bronchitis is commonly followed by a period of debility.', 1),
    (v_disorder_id, 'Emphasis should be given to respiratory tonics, bitter tonics, and support for any body system or functions indicated for the individual.', 2),
    (v_disorder_id, 'Goals of treatment in the latter stages of acute bronchitis include clearing mucus from the lungs and preventing the development of complications, and any of the expectorant essential oils will be indicated.', 3),
    (v_disorder_id, 'Specific Remedies: Toning remedies to consider include Verbascum thapsus and Marrubium vulgare. Marrubium is especially useful, for not only is it a useful lung remedy, but it also has valuable bitter properties.', 4);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Toning remedy for lungs', 1);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Useful lung remedy with valuable bitter properties', 2);

  -- Prescription: Essential oils for recovery
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oils for Recovery', 'Applying essential oils in inhalations, baths, and local massage to chest and throat will shorten the time needed for full recovery.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Ocimum basilicum', 'basil');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Origanum majorana', 'marjoram');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Santalum album', 'sandalwood');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 5);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 6);

  RAISE NOTICE 'Lower Respiratory - Post-Bronchitis Recovery disorder created';
END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - CHRONIC BRONCHITIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Chronic Bronchitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Chronic Bronchitis', v_lower_resp_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Chronic bronchitis is a long-term condition unaccompanied by fever. It is characterized by a permanent cough with sputum that results from continual overproduction of mucus.', 1),
    (v_disorder_id, 'When infection, air pollution, smoking, or other external factors irritate the bronchi, the lungs are provoked to produce abnormally large amounts of mucus, which literally swamp the minute cilia. A deep layer of mucus covers the cilia, so they are no longer able to propel it out of the bronchi.', 2),
    (v_disorder_id, 'Chronic bronchitis is preventable, as the primary causal factors are pollutants.', 3),
    (v_disorder_id, 'Bronchi become narrowed due to thickening, the lungs lose some of their elasticity, damage also reduces the amount of alveolar tissue. Eventually, the heart may become strained.', 4),
    (v_disorder_id, 'Giving up smoking is the first and most important preventive measure. The other is improving nutrition, particularly cutting out or greatly reducing the consumption of foods that encourage the production of mucus. For most people, these are dairy products and refined starches.', 5),
    (v_disorder_id, 'Exercise can strengthen the muscles that facilitate breathing. Patients should exercise at least three times a week, starting with short sessions of gentle exercise and gradually building up to longer, more strenuous sessions.', 6),
    (v_disorder_id, 'Specific Remedies: Please refer to Specific Remedies provided for acute bronchitis. In addition, the steam inhalation and aromatherapy recommendations given for acute bronchitis are also relevant to chronic bronchitis.', 7);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Essential for supporting respiratory function and the health and general tone of the lungs.', 1);

  v_action_id := herbal.ensure_action('Stimulating expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Especially useful in cases characterized by heavy mucus production.', 2);

  v_action_id := herbal.ensure_action('Relaxing expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Not as important in chronic as acute bronchitis; however, they often serve as good supportive remedies.', 3);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will soothe any associated irritation.', 4);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Valuable when fever is an issue, but are not as vital here as in acute bronchitis.', 5);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'can help if coughing or breathlessness is severe.', 6);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the body rid itself of any accompanying infection.', 7);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Essential for supporting cardiac function in the elderly, patients with cardiovascular weakness, or those with long-term chronic bronchitis.', 8);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'and even adaptogen support may be useful in some cases.', 9);

  RAISE NOTICE 'Lower Respiratory - Chronic Bronchitis disorder created with actions indicated';
END $$;

-- ============================================================================
-- CHRONIC BRONCHITIS - PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Chronic Bronchitis';

  -- Prescription 1: Basic formula for debilitated patients
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, NULL, 'Add 1 teaspoon of dried herb mixture to 1 cup of boiling water and infuse for 20 minutes. Drink hot three times a day. This formulation is designed for a patient who is debilitated and weakened by chronic bronchitis. Thus, it contains a blend of stimulating and relaxing pulmonary tonics. Cetraria has long been used in the United Kingdom (the world capital of chronic bronchitis!) as nutritive support in such cases. To this may be added other herbs appropriate for the individual, such as Crataegus spp., Eleutherococcus senticosus, and Galium aparine.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Cetraria islandica', 'Iceland moss');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 2: For Chronic Bronchitis with Infection
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Chronic Bronchitis with Infection', 'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw (one clove a day) or garlic oil taken as a supplement.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 3: For Chronic Recurrent Bronchitis with Dyspnea
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Chronic Recurrent Bronchitis with Dyspnea', 'Add 1 part the Dyspnea formula as well. Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw in the diet (one clove a day) or garlic oil taken as a supplement.', 3)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 4: For Chronic Recurrent Bronchitis with Severe Congestion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Chronic Recurrent Bronchitis with Severe Congestion', 'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw in the diet (one clove a day) or garlic oil taken as a supplement.', 4)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  RAISE NOTICE 'Chronic Bronchitis prescriptions created';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Post-Bronchitis Recovery disorder with specific remedies and essential oil prescription
-- 2. Chronic Bronchitis disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - 4 Prescriptions with herbs
