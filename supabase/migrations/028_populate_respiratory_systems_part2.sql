-- Populate Respiratory Systems - Part 2
-- Lower Respiratory: Bronchitis and Acute Bronchitis disorders
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - BRONCHITIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Bronchitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Bronchitis', v_lower_resp_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Bronchitis is either an acute or a chronic inflammation of the mucous lining of the bronchial tubes, the main airways that carry air from the trachea to the lungs.', 1),
    (v_disorder_id, 'When the cells of the bronchial lining tissue are irritated bevond a certain point, cilia that normally trap and eliminate pollutants stop functioning.', 2),
    (v_disorder_id, 'Bronchitis makes breathing difficult and sometimes even painful. Pain may be related to the swelling of the mucous membrane in the trachea. Other common sions of bronchitis are persistent coughing, aching associated with fever, and mucus secretions. The patient will feel very fatigued due to the fact that the body is receiving less oxygen than it needs.', 3);

  RAISE NOTICE 'Lower Respiratory - Bronchitis disorder created';
END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - ACUTE BRONCHITIS
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
  v_presc_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Acute Bronchitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Acute Bronchitis', v_lower_resp_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Acute bronchitis usually originates with a viral infection of the upper respiratory tract, such as a cold or sore throat, that can become a secondary bacterial infection and spread to the lungs.', 1),
    (v_disorder_id, 'It usually lasts about a week and is accompanied by a cough that produces thick green or yellow mucus.', 2),
    (v_disorder_id, 'It may be accompanied by fever that lasts a few days, but persistent fever suggests the development of a pneumonia complication.', 3),
    (v_disorder_id, 'The cough of acute bronchitis may last for several weeks or even months, a reflection of the amount of time it takes for the bronchial lining to heal.', 4),
    (v_disorder_id, 'Acute bronchitis can be confused with asthma.', 5),
    (v_disorder_id, 'Acute bronchitis most commonly develops as a complication of a cold in a healthy person.', 6),
    (v_disorder_id, 'Congestive mucus should be coughed up, so avoid the use of cough suppressants. The use of soothing, relaxing expectorants in combination with antimicrobials is often the key to successful treatment. Particularly important relaxing expectorants are Tussilago, Verbascum, Plantago, Cetraria, Trigonella, Althaea, and Pulmonaria.', 7);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are not crucial if the bronchitis is not a recurrent problem. However, they are clearly indicated for immunocompromised people.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are indicated; the choice between stimulating and relaxing expectorants will depend on the individual''s needs. Demulcents augment the action of relaxing expectorants, if necessary.', 2);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'can help if coughing is very troublesome.', 3);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are essential to deal with infection and to help the body defend against the development of secondary infection.', 4);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'may be indicated if there is extensive inflammation, and especially if the larynx or pharynx is involved.', 5);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'improve the upper respiratory symptom picture.', 6);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are indicated if the patient has a fever.', 7);

  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs offer support if there is any history or suspicion of cardiovascular problems.', 8);

  -- Specific Remedies Note
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Osha (Ligusticum porteri), a plant of the American Southwest, is an excellent specific for cases of tracheobronchitis. The specifics listed here cover a range of expectorant, antimicrobial, and antispasmodic actions. Strictly speaking, none of them is guaranteed to work in all cases, as specifics must be chosen based on the unique needs of an individual with a particular clinical picture.', 8);

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial and immune support', 1);

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent and soothing', 2);

  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Relaxing expectorant', 3);

  v_herb_id := herbal.ensure_herb('Cephaelis ipecacuanha', 'ipecac');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating expectorant', 4);

  v_herb_id := herbal.ensure_herb('Cetraria islandica', 'Iceland moss');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent and nutritive', 5);

  v_herb_id := herbal.ensure_herb('Chondrus crispus', 'Irish moss');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent', 6);

  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic', 7);

  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'licorice');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Anti-inflammatory and expectorant', 8);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial and anticatarrhal', 9);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Anticatarrhal and expectorant', 10);

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic and expectorant', 11);

  v_herb_id := herbal.ensure_herb('Ligusticum porteri', 'osha');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Excellent specific for tracheobronchitis', 12);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic and expectorant', 13);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 14);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial and antispasmodic', 15);

  v_herb_id := herbal.ensure_herb('Plantago spp.', 'plantain');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Soothing expectorant', 16);

  v_herb_id := herbal.ensure_herb('Polygala senega', 'Seneca snakeroot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating expectorant', 17);

  v_herb_id := herbal.ensure_herb('Populus balsamifera var. balsamifera', 'balm of Gilead');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 18);

  v_herb_id := herbal.ensure_herb('Primula veris', 'cowslip');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 19);

  v_herb_id := herbal.ensure_herb('Pulmonaria officinalis', 'lungwort');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic', 20);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating expectorant', 21);

  v_herb_id := herbal.ensure_herb('Symphytum officinale', 'comfrey');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent', 22);

  v_herb_id := herbal.ensure_herb('Symplocarpus foetidus', 'skunk cabbage');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antispasmodic', 23);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial', 24);

  v_herb_id := herbal.ensure_herb('Trigonella foenum-graecum', 'fenugreek');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Demulcent expectorant', 25);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic and expectorant', 26);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Pulmonary tonic and expectorant', 27);

  v_herb_id := herbal.ensure_herb('Verbena officinalis', 'vervain');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Nervine support', 28);

  v_herb_id := herbal.ensure_herb('Viola odorata', 'sweet violet');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Expectorant', 29);

  RAISE NOTICE 'Lower Respiratory - Acute Bronchitis disorder created with actions indicated and specific remedies';
END $$;

-- ============================================================================
-- ACUTE BRONCHITIS - PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
  v_presc_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Acute Bronchitis';

  -- Prescription 1: A Demulcent Tea for Acute Dry Cough
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Demulcent Tea for Acute Dry Cough', 'The infusion presented here, provided by Dr. Rudolf Fritz Weiss in Herbal Medicine, supplies the additional benefit of increased fluid intake. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1)
  RETURNING id INTO v_presc_herb_id;

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2)
  RETURNING id INTO v_presc_herb_id;

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3)
  RETURNING id INTO v_presc_herb_id;

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4)
  RETURNING id INTO v_presc_herb_id;

  -- Prescription 2: Prescription I to Promote Expectoration
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Prescription I to Promote Expectoration', 'Another approach increases the stimulating expectorant component, making it more appropriate for subacute and chronic bronchitis characterized by excessive sputum production. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Primula veris', 'cowslip');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 3: Prescription II to Promote Expectoration
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Prescription II to Promote Expectoration', 'An alternative yet equivalent approach for acute dry cough replaces Thymus vulgaris with Pimpinella anisum. This combination also boosts the stimulating expectorant action of the prescription by increasing the proportion of saponin-rich Primula veris. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day.', 3)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Primula veris', 'cowslip');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 1);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 4: A Prescription to Combat Infection in Acute Bronchitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription to Combat Infection in Acute Bronchitis', 'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw (one clove a day) or garlic oil taken as a supplement.', 4)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 5);

  -- Prescription 5: Steam Inhalation
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Steam Inhalation', 'Thymus, Eucalyptus, Matricaria, and Origanum are good choices for steam inhalations. Pure plant essential oils may also be used. Volatile oil-rich herbs are effective decongestants and support the internal treatment by addressing some associated symptoms. Add 1 tablespoon of dried herb combination to ½ liter (1 pint) of boiling water. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl. Inhale vapors for 5 to 10 minutes.', 5)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'flowers', 1);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'herb', 2);

  v_herb_id := herbal.ensure_herb('Origanum vulgare', 'oregano');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'herb', 3);

  -- Prescription 6: Essential Oil Inhalation (note about various oils)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oil Inhalation', 'In the first stages of acute bronchitis, when the cough is dry and painful, steam inhalation with the oils listed here may provide a great deal of relief. Bergamot and eucalyptus oils are also effective in lowering fever, and all of these oils will help to reinforce the immune response to the infection. Dwarf pine needle oil (Pinus pumilio) has been the main oil used traditionally, but with the growing interest in aromatherapy, many volatile oils are now recognized as valuable remedies for inhalations. Mentha arvensis var. piperascens, the source of "Chinese white flower oil," is especially rich in menthol. Menthol is anti-inflammatory, especially for the mucous membranes of the upper respiratory tract. It stimulates mucous secretions and exerts antimicrobial and mild anaesthetic actions. As with many oils, it is best used at the onset of symptoms. Essential Oil Inhalation: Place 3 to 5 drops of essential oil in a bowl and add boiling water. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl. Inhale for 5 to 10 minutes, keeping the eyes closed to prevent irritation from vapor. Massaging or otherwise applying oils to chest, neck, or back fosters absorption through the skin, technically called percutaneous absorption. Be sure to dilute the oil first in an appropriate carrier oil, such as almond oil. Essential oils absorbed through the skin are often eliminated from the body via the lungs, allowing the constituents to come in contact with the site of lung infection or inflammation. A good technique is to apply the oil and then place a clean dry cloth over the area to ensure that oils are absorbed and do not evaporate.', 6)
  RETURNING id INTO v_prescription_id;

  -- Note: Essential oils - these herbs are just referenced as oils, not as traditional herbal preparations
  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Mentha arvensis var. piperascens', 'Asian mint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 5);

  v_herb_id := herbal.ensure_herb('Pinus pumilio', 'dwarf pine');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 6);

  v_herb_id := herbal.ensure_herb('Santalum album', 'sandalwood');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 7);

  v_herb_id := herbal.ensure_herb('Styrax benzoin', 'benzoin');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 8);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 9);

  RAISE NOTICE 'Acute Bronchitis prescriptions created';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Bronchitis disorder with notes
-- 2. Acute Bronchitis disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies (29 herbs)
--    - 6 Prescriptions with herbs
