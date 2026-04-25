-- Populate Respiratory Systems - Part 5
-- Upper Respiratory: All (Overall) and The Common Cold
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - ALL (OVERALL)
-- ============================================================================

DO $$
DECLARE
  v_upper_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_upper_resp_id FROM herbal.body_systems WHERE name = 'Upper Respiratory';

  -- Create "All" disorder for Upper Respiratory
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('All', v_upper_resp_id, 0)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Many chronic catarrhal states represent the body''s response to a diet too rich in mucus-forming foods.', 1),
    (v_disorder_id, 'If the body is using the mucous membranes of the sinuses as a window for removing waste through the vehicle of the catarrh, then it is best to support rather than block this activity.', 2),
    (v_disorder_id, 'Blockage of the sinus cavities is very common and relatively easy to treat with herbs.', 3),
    (v_disorder_id, 'Specific Remedies: Anticatarrhal herbs do not substitute for the nurturing action of tonics for this part of the body. From the European perspective, here are some appropriate tonics that also possess anti-catarrhal properties.', 4);

  -- Add Action Herbs for Overall Upper Respiratory
  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');

  v_herb_id := herbal.ensure_herb('Allium spp.', 'onion and garlic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus spp.', 'eucalyptus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Baptisia tinctoria', 'wild indigo');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Ligusticum porteri', 'osha');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  -- Immune stimulant
  v_action_id := herbal.ensure_action('Immune stimulant');
  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  -- Anticatarrhal
  v_action_id := herbal.ensure_action('Anticatarrhal');
  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  -- Astringents
  v_action_id := herbal.ensure_action('Astringent');
  v_herb_id := herbal.ensure_herb('Salvia officinalis', 'sage');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');
  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Add Specific Remedies (tonics with anti-catarrhal properties)
  v_herb_id := herbal.ensure_herb('Euphrasia spp.', 'eyebright');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 1);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 2);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 3);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 4);

  v_herb_id := herbal.ensure_herb('Solidago virgaurea', 'goldenrod');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 5);

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Tonic with anti-catarrhal properties', 6);

  RAISE NOTICE 'Upper Respiratory - All disorder created with action herbs and specific remedies';
END $$;

-- ============================================================================
-- UPPER RESPIRATORY SYSTEM - THE COMMON COLD
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

  -- Create The Common Cold disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('The Common Cold', v_upper_resp_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'When the mucous membranes of the nose and throat are inflamed by infection, they are far more vulnerable to attack by bacteria, and this can easily give rise to secondary infections that are more serious than the original cold, such as sinusitis, ear infections, and bronchitis.', 1),
    (v_disorder_id, 'For a short-term, acute infection, there is usually no need to focus on system support. However, if the individual has frequent or recurrent colds, the use of tonic remedies will be vital.', 2),
    (v_disorder_id, 'If the patient has a history of heart dis-ease, cardiotonics may be used as a precautionary measure. However, Tilia is most appropriate, as it is diaphoretic in addition to being a heart tonic.', 3);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the immune system combat the viral infection and help prevent secondary infection.', 1);

  v_action_id := herbal.ensure_action('Immune stimulant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the immune system combat the viral infection and help prevent secondary infection.', 2);

  v_action_id := herbal.ensure_action('Anticatarrhal');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'ease the symptomatic discomfort so characteristic of this problem. However, avoid trying to dry up mucus overproduction with herbal decongestants.', 3);

  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help with feverishness and support the body''s efforts to cope with elevated body temperature.', 4);

  v_action_id := herbal.ensure_action('Expectorant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help combat the development of secondary problems in the lower respiratory system.', 5);

  v_action_id := herbal.ensure_action('Lymphatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'indicated if the lymph glands are swollen or there is a known history of such problems', 6);

  -- Specific Remedies Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Specific Remedies: Aches and pains are common, and our materia medica offers a number of plants that will relieve these unpleasant feelings. Perhaps the best is the diaphoretic Eupatorium perfoliatum (boneset), especially if the patient has a fever. Boneset''s bitter taste is one of its therapeutic assets.', 4),
    (v_disorder_id, 'Do not inhibit nasal congestion with anticatarrhal drugs, as mucus production is part of the body''s normal response to infection. Herbal anticatarrhals work in a different, safer way than anticatarrhal drugs. Matricaria, Mentha piperita, or Eupatorium perfoliatum can help relieve much of the discomfort. Steam inhalations of eucalyptus and thyme oils will also help reduce the formation of catarrh.', 5),
    (v_disorder_id, 'To support the immune system, use antimicrobial herbs such as echinacea and goldenseal, as well as ton-ics, such as cleavers and nettles. These may be combined in capsules or as tinctures. Hydrastis canadensis will speed recovery from infection, as will raw garlic or garlic oil capsules.', 6);

  RAISE NOTICE 'Upper Respiratory - The Common Cold disorder created';
END $$;

-- ============================================================================
-- THE COMMON COLD - SPECIFIC REMEDIES AND PRESCRIPTIONS
-- ============================================================================

DO $$
DECLARE
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'The Common Cold';

  -- Add Specific Remedies
  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Diaphoretic and antimicrobial', 1);

  v_herb_id := herbal.ensure_herb('Allium spp.', 'onion and garlic');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial', 2);

  v_herb_id := herbal.ensure_herb('Armoracia rusticana', 'horseradish');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating antimicrobial', 3);

  v_herb_id := herbal.ensure_herb('Brassica spp.', 'mustard');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating and warming', 4);

  v_herb_id := herbal.ensure_herb('Capsicum spp.', 'cayenne');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Stimulating circulatory', 5);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Best for aches and pains with fever', 6);

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Anti-inflammatory and calming', 7);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Relieves discomfort', 8);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Diaphoretic and anticatarrhal', 9);

  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Diaphoretic and cardiotonic', 10);

  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Immune support and antimicrobial', 11);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial for steam inhalations', 12);

  v_herb_id := herbal.ensure_herb('Hydrastis canadensis', 'goldenseal');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Speeds recovery from infection', 13);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'Antimicrobial for steam inhalations', 14);

  -- Prescription 1: A Prescription for the Common Cold
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'A Prescription for the Common Cold', 'Infuse 1 to 2 teaspoons of dried herb mixture in 1 cup of boiling water, this should be drunk hot often until symptoms pass.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  -- Prescription 2: Herbal Footbath for Colds
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Herbal Footbath for Colds', 'Footbaths are a traditional treatment for colds. Dissolve 1 tablespoon of mustard powder in 4 pints of hot water. Bathe the feet for 10 minutes, twice a day.', 2)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Brassica spp.', 'mustard');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 tablespoon powder', 1);

  -- Prescription 3: Chamomile Steam Inhalation
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Chamomile Steam Inhalation', 'Place a handful of Matricaria flowers in a bowl and pour boiling water over them. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl for 5 to 10 minutes.', 3)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'handful', 'flowers', 1);

  -- Prescription 4: Steam Inhalation Combination
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Steam Inhalation Combination', 'Add 1 tablespoon of dried herb mixture to ½ liter (1 pint) of boiling water. Follow inhalation instructions given for Chamomile Steam Inhalation.', 4)
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

  -- Prescription 5: Essential Oils for Common Cold
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oils for Common Cold', 'It clears congested nasal passages and soothes inflamed mucous membranes. At the same time, the essential oil will kill many bacteria. Some of the oils, especially Eucalyptus and Melaleuca, have an inhibitory effect on the cold virus. Use either of these two oils for inhalations in the earlier part of the day (possibly alternating with Rosmarinus and Mentha piperita), as they are mildly stimulating. At night, use inhalations of Lavandula or add a few drops of oil to a bath. Diffusing oil in the bedroom is helpful, especially if the patient has a cough.', 5)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Citrus aurantium ssp. bergamia', 'bergamot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 1);

  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'myrrh');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 2);

  v_herb_id := herbal.ensure_herb('Eucalyptus globulus', 'eucalyptus');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 3);

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 4);

  v_herb_id := herbal.ensure_herb('Melaleuca spp.', 'tea tree');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 5);

  v_herb_id := herbal.ensure_herb('Mentha arvensis var. piperascens', 'Asian mint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 6);

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 7);

  v_herb_id := herbal.ensure_herb('Ocimum basilicum', 'basil');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 8);

  v_herb_id := herbal.ensure_herb('Origanum majorana', 'marjoram');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 9);

  v_herb_id := herbal.ensure_herb('Pinus pumilio', 'dwarf pine');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 10);

  v_herb_id := herbal.ensure_herb('Rosmarinus officinalis', 'rosemary');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 11);

  v_herb_id := herbal.ensure_herb('Santalum album', 'sandalwood');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 12);

  v_herb_id := herbal.ensure_herb('Styrax benzoin', 'benzoin');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 13);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, 'essential oil', 14);

  -- Prescription 6: Kitchen Remedy to Ward Off a Cold
  -- Note: This contains non-herbal ingredients (ginger, cinnamon, coriander, cloves, lemon)
  -- We'll include only the ones that might be considered herbs
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Kitchen Remedy to Ward Off a Cold', 'Decoct ingredients for 15 minutes in l pint of water; strain. Drink a cupful hot every 2 hours. Sweeten with organic honey to taste.', 6)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Zingiber officinale', 'ginger');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 ounce', 'fresh, sliced', 1);

  v_herb_id := herbal.ensure_herb('Cinnamomum verum', 'cinnamon');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 stick', 'broken', 2);

  v_herb_id := herbal.ensure_herb('Coriandrum sativum', 'coriander');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 teaspoon', 'seeds', 3);

  v_herb_id := herbal.ensure_herb('Syzygium aromaticum', 'clove');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '3', 4);

  v_herb_id := herbal.ensure_herb('Citrus limon', 'lemon');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 slice', '', 5);

  RAISE NOTICE 'Common Cold specific remedies and prescriptions created';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Upper Respiratory - All disorder with action herbs and specific remedies
-- 2. The Common Cold disorder with:
--    - Disorder notes
--    - Actions Indicated
--    - Specific Remedies (14 herbs)
--    - 6 Prescriptions
