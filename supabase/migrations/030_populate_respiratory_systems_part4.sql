-- Populate Respiratory Systems - Part 4
-- Lower Respiratory: Pertussis, Asthma, and Emphysema
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - PERTUSSIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Pertussis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Pertussis', v_lower_resp_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Pertussis, commonly known as whooping cough, is caused by the bacterium Bordetella pertussis. This highly contagious infection is transmitted when the bacteria are coughed or sneezed out by an infected person and breathed in by someone else, especially during the catarrhal and early paroxysmal stages of the disease.', 1),
    (v_disorder_id, 'The disease lasts about six weeks and has three well-defined stages. 1. Catarrhal. This stage begins slowly, with sneezing, free-flowing tears, and other signs typical of the common cold. 2. Paroxysmal. Developing after 10 to 14 days, this stage is characterized by paroxysmal coughing. 3. Convalescent. This stage usually begins within four weeks.', 2),
    (v_disorder_id, 'Long-term immune system support is essential after such an infection. In addition, support for the respiratory system and potentially even the cardiovascular system may be needed.', 3),
    (v_disorder_id, 'Specific Remedies: The European herbal tradition proposes a number of herbs as possible specifics. However, these are not dramatically effective and do not replace appropriate antibiotic treatment. Instead, they support antibiotic therapy.', 4);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Traditional specific for pertussis', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial support', 2);

  v_herb_id := herbal.ensure_herb('Pinguicula vulgaris', 'butterwort');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Traditional remedy', 3);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and cough suppressant', 4);

  v_herb_id := herbal.ensure_herb('Eryngium planum', 'sea holly');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Traditional remedy', 5);

  -- Prescription: For Pertussis and Other Paroxysmal Coughs
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Pertussis and Other Paroxysmal Coughs', 'Infuse 1 teaspoon of dried herb mixture in 1 cup of boiling water for 20 minutes. This should be drunk hot several times a day. Hot infusions are valuable in that they replace lost fluids and promote diaphoresis.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  RAISE NOTICE 'Lower Respiratory - Pertussis disorder created';
END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - ASTHMA
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

  -- Create Asthma disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Asthma', v_lower_resp_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Asthma is a chronic inflammatory disorder of the airways typified by wheezing, chest tightness, coughing exacerbations, and difficult breathing.', 1),
    (v_disorder_id, 'Asthma can develop at any time, but is most common in young children.', 2),
    (v_disorder_id, 'Replacement of the term asthma with a more descriptive name, reactive airway disease (RAD). People with RAD have bronchial passages that are more sensitive than normal to irritation.', 3),
    (v_disorder_id, 'The inflammation in turn fosters the production of excess mucus and a tightening of the muscles that wind around the bronchial tubes.', 4),
    (v_disorder_id, 'A dry cough is sometimes the only sign.', 5),
    (v_disorder_id, 'An estimated 75% of childhood asthma is allergy related, so controlling allergies may be pivotal to reducing the frequency of asthma attacks.', 6),
    (v_disorder_id, 'As much as 30% of all asthma may be caused by gastro-esophageal reflux, which causes the unpleasant symptom commonly known as heartburn.', 7),
    (v_disorder_id, 'Asthma that begins in childhood is closely linked with the presence of eczema, hay fever, urticaria (hives), and migraine in the patient or in close relatives.', 8);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Important for long-term strengthening of the lungs, but offer little short-term relief for acute attacks.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help prevent buildup of sputum in the lungs. However, use only relaxing expectorants, as stimulant expectorants can potentially aggravate breathing difficulties.', 2);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'soothe irritation and support the action of relaxing expectorants.', 3);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease spasm responses in the muscles that facilitate respiration.', 4);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help reduce the potential for secondary in-fection, which should be avoided at all costs.', 5);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'aid the body in dealing with overproduction of sputum in lungs or sinuses.', 6);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the heart in the face of lung congestion or strain,', 7);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support is always appropriate, both because stress is a potential trigger and because asthma can cause stress, which in turn can trigger further attacks.', 8);

  -- Specific Remedies Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Ephedra sinica (ma huang) and other Asian ephedra species prove exceptionally useful as bronchodilators. Although synthetic ephedrine is available, the whole herb is better tolerated and causes fewer adverse heart effects. Ephedra stimulates the sympathetic nervous system and thus relieves the bronchospasm that underlies asthma and certain other conditions, including emphysema. Allergic reactions respond well to Ephedra because of its action on the sympathetic nervous system. The ayurvedic herb Coleus forskohlii may be useful in asthma. The constituent forskolin raises cellular levels of CAMP, which results in relaxation of bronchial muscles and relief of asthma symptoms. Forskolin also inhibits the release of histamine and the synthesis of allergic compounds. The others herbs in this list have Antispasmodic and Bronchodilating effects.', 9);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Exceptionally useful bronchodilator, better tolerated than synthetic ephedrine', 1);

  v_herb_id := herbal.ensure_herb('Coleus forskohlii', 'coleus');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Ayurvedic herb useful for bronchial muscle relaxation', 2);

  v_herb_id := herbal.ensure_herb('Ammi visnaga', 'khella');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and bronchodilator', 3);

  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic effects', 4);

  v_herb_id := herbal.ensure_herb('Euphorbia pilulifera', 'pill-bearing spurge');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and bronchodilator', 5);

  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and expectorant', 6);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic effects', 7);

  RAISE NOTICE 'Lower Respiratory - Asthma disorder created with actions indicated and specific remedies';
END $$;

-- ============================================================================
-- ASTHMA - PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Asthma';

  -- Prescription 1: Dyspnea Formula for Asthma
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Dyspnea Formula for Asthma', 'Dosage: 5 ml of mixture three times a day. If Euphorbia pilulifera proves difficult to obtain, double the amount of Grindelia to make up for it.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '24 parts', 'tincture', 1);

  v_herb_id := herbal.ensure_herb('Euphorbia pilulifera', 'pill-bearing spurge');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '24 parts', 'tincture', 2);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 3);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 4);

  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'licorice');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 5);

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '12 parts', 'tincture', 6);

  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '10 parts', 'tincture', 7);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'essential oil', 8);

  -- Prescription 2: For Childhood Atopic Asthma Associated with Eczema
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Childhood Atopic Asthma Associated with Eczema', 'Add Dyspnea Formula - 2 parts. Dosage: up to 5 ml of tincture three times a day', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Trifolium pratense', 'red clover');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Additional Specific Remedies for acute asthmatic crisis
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Additional Specific Remedies: During an actual asthmatic crisis, inhalation of an antispasmodic oil is the only practical herbal help.', 10);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 8);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 9);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 10);

  v_herb_id := herbal.ensure_herb('Pinus sylvestris', 'Scots pine');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 11);

  v_herb_id := herbal.ensure_herb('Rosmarinus officinalis', 'rosemary');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic oil for acute crisis inhalation', 12);

  RAISE NOTICE 'Asthma prescriptions created';
END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - EMPHYSEMA
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

  -- Create Emphysema disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Emphysema', v_lower_resp_id, 8)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Emphysema, which often develops as a long-term complication of chronic bronchitis, is characterized by damage to the elastic walls of the sac-like alveoli in the lungs. This damage is caused by constant coughing.', 1);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Important for long-term strengthening of the lungs but offer little short-term relief for acute attacks.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Essential to minimize the buildup of sputum in the lungs. Stimulant expectorants are necessary here because of the lessening of tone that affects the walls of the alveoli.', 2);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'soothe irritation and support the work of expectorants.', 3);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease spasm responses in the muscles that facilitate respiration.', 4);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help reduce the potential for secondary infection, which should be avoided at all costs.', 5);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'aid the body in dealing with overproduction of sputum in lungs or sinuses.', 6);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the heart in the face of lung congestion or strain.', 7);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support is always appropriate, as stress will exacerbate emphysema.', 8);

  -- Prescription: For Emphysema
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Emphysema', 'Add Dyspnea Formula (1 part) Dosage: up to 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  RAISE NOTICE 'Lower Respiratory - Emphysema disorder created';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Pertussis disorder with specific remedies and prescription
-- 2. Asthma disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies (12 herbs)
--    - 2 Prescriptions
-- 3. Emphysema disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - 1 Prescription
--
-- Lower Respiratory system disorders are now complete
