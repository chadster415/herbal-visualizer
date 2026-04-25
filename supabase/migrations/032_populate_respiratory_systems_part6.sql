-- Populate Respiratory Systems - Part 6
-- Upper Respiratory: Influenza and Influenza Convalescence
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - INFLUENZA
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Influenza disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Influenza', v_upper_resp_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Influenza, commonly called the flu, is a severe form of viral respiratory tract infection with generalized bodily symptoms.', 1),
    (v_disorder_id, 'Typical clinical features of influenza include fever (100°F to 103°F in adults and even higher in children), headache, muscle aches, extreme fatigue, and respiratory symptoms, such as cough, sore throat, and runny or stuffy nose.', 2),
    (v_disorder_id, 'Gastrointestinal symptoms are rarely prominent.', 3),
    (v_disorder_id, 'Most people recover completely in one to two weeks.', 4),
    (v_disorder_id, 'Secondary bacterial infections are the greatest risk of influenza.', 5),
    (v_disorder_id, 'Treatment will be most effective if initiated at the very first sign of infection. A moderately hot bath containing a few drops of antiviral essential oil will often induce diaphoresis, followed by a deep, restful sleep.', 6),
    (v_disorder_id, 'It is a good idea to repeat this bath treatment for the next two or three days. Tea tree oil is particularly effective for this purpose. However, some people find it to be a mild skin irritant, and may not be able to tolerate more than 3 or 4 drops in a full bath.', 7);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the immune system in combating viral infection and help prevent the development of secondary infection.', 1);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help with symptoms of fever and support the body''s efforts to cope with elevated temperature.', 2);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort so characteristic of this problem. However, avoid trying to dry up mucus overproduction with herbal decongestants.', 3);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help combat the development of secondary problems in the lower respiratory system.', 4);

  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are indicated if the lymph glands are swollen or there is a known history of such problems.', 5);

  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'support the body in dealing with the debility that often follows severe viral infections.', 6);

  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'assist the body in dealing with high fever and associated distress.', 7);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: As with the common cold, there are no miracle cures here. However, certain plants can make life much more bearable during a bout of flu. These are usually diaphoretics, and my favorite is Eupatorium perfolatum (boneset).', 8);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Favorite diaphoretic for flu, especially effective', 1);

  -- Prescription: A Prescription for Influenza
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Influenza', 'Dosage: 2.5 ml of tincture every 2 hours. In addition, the patient should drink a strong hot infusion of Eupatorium perfoliatum every hour. If the symptom picture calls for it, follow recommendations given earlier for the common cold.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'infusion', '', 3);

  RAISE NOTICE 'Upper Respiratory - Influenza disorder created';
END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - INFLUENZA CONVALESCENCE
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Influenza Convalescence disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Influenza Convalescence', v_upper_resp_id, 3)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Recovery from influenza is often slow, and the convalescing patient may feel very weak and lacking in vitality. Caffeine-containing stimulant herbs should be avoided, as the lift they confer is only temporary and will slow down recovery.', 1),
    (v_disorder_id, 'Bitter tonics will speed recovery through their metabolism-stimulating effects.', 2);

  -- Add Action Herbs for Influenza Convalescence
  v_action_id := herbal.ensure_action('Anticatarrhal');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_action_id := herbal.ensure_action('Bitter');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Gentiana spp.', 'gentian');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_action_id := herbal.ensure_action('Diaphoretic');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_action_id := herbal.ensure_action('Tonic');
  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_action_id := herbal.ensure_action('Expectorant');
  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  RAISE NOTICE 'Upper Respiratory - Influenza Convalescence disorder created';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Influenza disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies
--    - 1 Prescription
-- 2. Influenza Convalescence disorder with:
--    - Disorder notes
--    - Action Herbs