-- Populate Respiratory Systems - Part 7 (FINAL)
-- Upper Respiratory: Hay Fever, Sinusitis, Laryngitis, and Tonsillitis
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - HAY FEVER
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

  -- Create Hay Fever disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Hay Fever', v_upper_resp_id, 4)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Hay fever, or allergic rhinitis, is a form of allergy that affects the lining of the nose and, often, the eyes and throat.', 1),
    (v_disorder_id, 'Tonic support should be provided for both the upper and lower respiratory systems.', 2);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort often characteristic of this problem. Again, avoid trying to dry up mucus overproduction with herbal deconges-tants, as this can end up being quite painful.', 1);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will be needed if wheezing or pulmonary congestion develops. Relaxing expectorants will usually be most relevant.', 2);

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'essential if there is any marked difficulty with breathing.', 3);

  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help tone the whole body in the face of the immune systems response.', 4);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'soothe various symptoms of inflammation as and when they arise.', 5);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'often ease the symptom picture, as many anti-catarrhals are also astringents.', 6);

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'and immune support may help long term. This overall system support should cover the liver, kidney, and any other systems that require support.', 7);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: There is no particular specific remedy for hay fever. The well-known traditional Chinese remedy Ephedra sinica (ma huang) is a bronchodilator and has much to offer in the treatment of allergic reactions. Ayurveda and unani medicine use Ammi visnaga, a plant with a similar biochemical impact that is now being introduced to the Western world. In addition to these alkaloid-rich plants, certain herbs might be considered specific for various types and sites of symptoms that may arise. For example, Euphrasia spp. ease distress that occurs in the eyes.', 3);

  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Bronchodilator, effective for allergic reactions', 1);

  v_herb_id := herbal.ensure_herb('Ammi visnaga', 'khella');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Similar to Ephedra, from Ayurveda and unani medicine', 2);

  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Eases eye distress', 3);

  -- Prescription: A Prescription for Hay Fever
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Hay Fever', 'Dosage: 5 ml of tincture three times a day. Ideally, this treatment should be started two months before hay fever season is due to commence. Start with the following dosage regimen. Pre-Hay Fever Season Dosage Regimen: Weeks 1-2: 2.5 ml once a day, Weeks 3-4: 5 ml once a day, Weeks 5-6: 5 ml twice a day, Weeks 7-8: 5 ml three times a day. If this treatment cannot be initiated before the allergy flares up, then start with a full dose immediately, possibly increasing the dose to 5 ml four or five times a day (adults only).', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Ephedra sinica', 'ma huang');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 4);

  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 5);

  -- Prescription 2: Essential oils for hay fever
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oils for Hay Fever', 'Various essential oils can help with symptoms of hay fever, but the specifics vary from person to person. Oils recommended by aromatherapists include all of those listed above for the common cold, with the addition of blue chamomile, lemon balm, and lavender. If steam inhalation makes the patient feel even worse, suggest that the person put some oil on a tissue to sniff whenever needed. A massage with any of these oils can also be helpful.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'blue chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Melissa officinalis', 'lemon balm');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  RAISE NOTICE 'Upper Respiratory - Hay Fever disorder created';
END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - SINUSITIS
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

  -- Create Sinusitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Sinusitis', v_upper_resp_id, 5)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'The sinuses are four bony cavities positioned behind, above, and at each side of the nose and open into the nasal cavity. They act as a sound box to give resonance to the voice. Sinusitis is an inflammation of these air-containing cavities.', 1),
    (v_disorder_id, 'Because the openings from the nose into the sinuses are very narrow, they quickly become blocked when the mucous membranes swell during a cold, hay fever, or catarrh, trapping the infection inside the sinuses.', 2),
    (v_disorder_id, 'If the maxillary sinuses above the cheeks are infected, toothache may result.', 3);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'pivotal in the treatment of this often entrenched condition. These herbs will help the body deal with any infection present, but also support the immune system in resisting the development of secondary infection.', 1);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort characteristic of this problem and assist the body in eliminating buildup in the sinus cavities.', 2);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'often also anticatarrhals, reduce overproduction of mucus.', 3);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated, but most of the herbs with actions already listed here are also anti-inflammatory.', 4);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will be indicated if feverishness is part of the symptom picture.', 5);

  v_action_id := herbal.ensure_action('Analgesic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'may be necessary for temporary pain relief.', 6);

  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'aid the drainage and immune function of this vital system.', 7);

  v_action_id := herbal.ensure_action('Digestive support');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if overproduction of mucus causes stomach discomfort.', 8);

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'and immune support may help long term.', 9);

  -- Prescription 1: A Prescription for Sinusitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Sinusitis', 'Dosage: 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 2: Steam Inhalation for Upper Respiratory Tract
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Steam Inhalation for Upper Respiratory Tract', 'Combine ingredients in a bottle and shake well. Put a teaspoon of the mixture in a bowl and pour on ½ liter (1 pint) boiled water. Cover the head and the bowl with a towel or cloth and inhale. Caution: Keep the eyes closed', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Styrax benzoin', 'benzoin');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '30 ml', 'Compound tincture', 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2.5 ml', 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '6 drops', 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '5 drops', 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Pinus sylvestris', 'Scots pine');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '5 drops', 'essential oil', 5);

  RAISE NOTICE 'Upper Respiratory - Sinusitis disorder created';
END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - LARYNGITIS
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create Laryngitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Laryngitis', v_upper_resp_id, 6)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Laryngitis is an acute inflammation of the larynx, or voice box, usually associated with a common cold or overuse of the voice.', 1),
    (v_disorder_id, 'It is usually caused by a bacterial or viral infection.', 2);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will soothe the mucous lining and ease discomfort.', 1);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'will reduce the immediate cause of distress.', 2);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if there is a causal microorganism involved. However, they are not indicated if inflammation is due to some other cause.', 3);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'often effective as a local gargle, especially if the problem was precipitated by overuse of the vocal cords.', 4);

  v_action_id := herbal.ensure_action('Bitter');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'have a toning and stimulating effect on the mucosal lining.', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Aromatherapy provides some oils that ease inflammation quite effectively, including cypress and bergamot oils. To use as a gargle, put 3 drops of essential oil in ½/2 cup of warm water. Gargle hourly.', 3);

  v_herb_id := herbal.ensure_herb('Cupressus sempervirens', 'cypress');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Essential oil for gargle, eases inflammation', 1);

  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Essential oil for gargle, eases inflammation', 2);

  RAISE NOTICE 'Upper Respiratory - Laryngitis disorder created';
END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - TONSILLITIS
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

  -- Create Tonsillitis disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Tonsillitis', v_upper_resp_id, 7)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Tonsils are composed of the same type of tissue that makes up the lymph nodes, and they are part of the body''s natural defense system. When the tonsils are infected. the lymph glands in the neck often simultaneously become enlarged and tender.', 1);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are of primary importance, as this is an infection of lymphatic tissue.', 1);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the immune system combat the infection, whatever the causal pathogen might be, and help prevent the development of secondary infection', 2);

  v_action_id := herbal.ensure_action('Anticatarhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if there is associated sinus congestion or middle ear involvement.', 3);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the body cope with any associated fever.', 4);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if secondary problems develop in the lower respiratory system.', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'Specific Remedies: Lymphatic alteratives usually have local reputations as specifics for tonsillitis. In the United Kingdom, the most famous is Galium aparine (cleavers).', 2);

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Famous specific for tonsillitis in UK', 1);

  -- Prescription 1: A Prescription for Tonsillitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for Tonsillitis', 'Dosage: up to 5 ml of tincture three times a day. Diaphoretics should be added if fever is an issue.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 1);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 2);

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'calendula');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Prescription 2: Fomentation
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Fomentation', 'Make a strong infusion of dried herb mixture. Dip a cloth in the fomentation and wrap around the neck at night, repeating the procedure each night until the condition clears up.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '3 parts', 1);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  RAISE NOTICE 'Upper Respiratory - Tonsillitis disorder created';
END $$;

-- ============================================================================
-- FINAL SUMMARY
-- ============================================================================
-- This migration completes the Respiratory Systems import with:
-- 1. Hay Fever disorder with actions indicated, specific remedies, and 2 prescriptions
-- 2. Sinusitis disorder with actions indicated and 2 prescriptions
-- 3. Laryngitis disorder with actions indicated and specific remedies
-- 4. Tonsillitis disorder with actions indicated, specific remedies, and 2 prescriptions
--
-- ALL RESPIRATORY SYSTEM DISORDERS ARE NOW COMPLETE!
-- Total: 9 Lower Respiratory + 8 Upper Respiratory = 17 disorders