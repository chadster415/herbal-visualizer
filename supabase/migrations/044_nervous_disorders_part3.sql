-- Migration 044: Nervous system disorders part 3
-- Disorders: Migraine, Neuritis, Tinnitus, Motion Sickness, Shingles

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';

  -- ============================================================
  -- DISORDER: Migraine
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Migraine', v_nervous_id, 80)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Migraine' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Orthodox medicine considers the underlying cause of migraine to be unknown. Common migraine may affect as many as 25% of Americans.', 10),
    (v_disorder_id, 'The immediate cause appears to relate to spasms in the muscular walls of the blood vessels of the brain and scalp. In approximately 15% of all cases, migraine attacks are preceded by warning signs known as auras.', 20),
    (v_disorder_id, 'Triggers don''t actually cause the pain; rather, they activate an already existing chemical mechanism in the brain. The more triggers present at any given time, the more likely that a headache will follow.', 30)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Tanacetum parthenium','feverfew'),
      'The most important herb for migraine prevention. Feverfew is a long-term treatment, not an immediate cure for a migraine attack.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Prevention of Migraines
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for the Prevention of Migraines',
      'Tanacetum parthenium: 125 mg of dried herb taken once daily. Lavandula officinalis: massage essential oil into temples at first sign of an attack.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Tanacetum parthenium','feverfew'),         '125 mg dried herb daily', 10),
      (v_rx_id, herbal.ensure_herb('Lavandula officinalis','lavender'),        'massage essential oil', 20);
  END IF;

  -- Prescription 2: Migraine with Stress and Hypertension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Migraine Associated with Stress and Hypertension',
      'Dosage: 2.5 ml of tincture three times a day. In addition, the patient should follow instructions given in Prescription for Prevention of Migraine.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.','hawthorn'),           '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos','linden'),         '1 part', 20),
      (v_rx_id, herbal.ensure_herb('Stachys betonica','wood betony'),      '1 part', 30),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),  '1 part', 40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus','cramp bark'),        '1 part', 50);
  END IF;

  -- Prescription 3: Cooling Compress for Migraine
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Cooling Compress for Migraine',
      'Pour 1 quart ice-cold water into a 2-quart glass bowl and add the essential oils. Soak a clean cloth in the water and apply it to the head, forehead, or neck at the first sign of a migraine. Do not allow the compress to come into contact with the eyes. An ice pack applied over the compress will help keep it from getting warm.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'), '2 drops essential oil', 10),
      (v_rx_id, herbal.ensure_herb('Zingiber officinale','ginger'), '1 drop essential oil',  20),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),'1 drop essential oil',  30);
  END IF;

  -- ============================================================
  -- DISORDER: Neuritis
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Neuritis', v_nervous_id, 90)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Neuritis' AND body_system_id = v_nervous_id;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),    'Important to nourish the traumatized nerve tissue.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'), 'Ease associated pain and anxiety.', 20),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),'Reduce the inflammatory response.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),    'Help alleviate any muscular tension developed in response to the discomfort.', 40),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),        'Support the body''s efforts to cope with the stress of the pain and any stress-related causes.', 50)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription 1: Internal Use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Neuritis — Internal Use',
      'Dosage: 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: External Use
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Neuritis — External Use',
      'Three approaches to minimizing discomfort caused by touch. Gently applying menthol-rich peppermint oil produces a cooling, locally anesthetic effect. Applying infused oil of Hypericum will reduce neurological inflammation. Colloidal oatmeal can act as a dry lubricant between the skin and clothing, minimizing irritation.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'),         'essential oil', 'or any menthol-rich mint oil', 10),
      (v_rx_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),'infused oil', 'topical application', 20),
      (v_rx_id, herbal.ensure_herb('Avena sativa','oats'),                  'colloidal oatmeal', 'dry lubricant on skin', 30);
  END IF;

  -- Prescription 3: Essential Oils for Pain (massage)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Essential Oils for Pain',
      'Combine ingredients and use for massage.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Helichrysum italicum','helichrysum'),   '5 drops', 10),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),      '3 drops', 20),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),        '2 drops', 30),
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),            '2 drops', 40);
  END IF;

  -- ============================================================
  -- DISORDER: Tinnitus
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Tinnitus', v_nervous_id, 100)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Tinnitus' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'One person out of 10 has some type of hearing impairment or ear problem, and 85% of these have some associated tinnitus.', 10),
    (v_disorder_id, 'Hypericum perforatum is the main herb to consider here for tinnitus associated with depression. Ginkgo biloba may help improve problems of the inner ear that result from a disturbance in blood supply.', 20)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa','black cohosh'),    'Specific remedy for tinnitus, particularly noise-induced tinnitus.', 10),
    (v_disorder_id, herbal.ensure_herb('Hydrastis canadensis','goldenseal'),     'Specific remedy for tinnitus.', 20),
    (v_disorder_id, herbal.ensure_herb('Ginkgo biloba','ginkgo'),                'May help improve inner ear problems resulting from disturbance in blood supply.', 30)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Tinnitus',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Cimicifuga racemosa','black cohosh'), '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Hydrastis canadensis','goldenseal'),  '1 part', 20),
      (v_rx_id, herbal.ensure_herb('Ginkgo biloba','ginkgo'),             '1 part', 30);
  END IF;

  -- ============================================================
  -- DISORDER: Motion Sickness
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Motion Sickness', v_nervous_id, 110)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Motion Sickness' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Zingiber officinale (ginger) can usually be relied upon. Research published in The Lancet showed it to be more effective than Dramamine in preventing symptoms of motion sickness. Ginger may be drunk as a fresh infusion, eaten as candied ginger, or taken as capsules of the powder (usual dosage: 2 to 4 capsules as needed).', 10),
    (v_disorder_id, 'Ballota nigra (black horehound) will also reduce this kind of nausea. One of the more effective allopathic treatments involves a dermal patch of scopolamine, a constituent of Atropa belladonna.', 20)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Zingiber officinale','ginger'),        'Primary specific for motion sickness — more effective than Dramamine per Lancet research.', 10),
    (v_disorder_id, herbal.ensure_herb('Ballota nigra','black horehound'),     'Also reduces nausea from motion sickness.', 20)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Motion Sickness',
      'Dosage: 5 ml of tincture 20 minutes before travel. In addition, the patient should eat a small piece of candied ginger just before travel and as needed.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Ballota nigra','black horehound'), '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'),    '1 part', 20);
  END IF;

  -- ============================================================
  -- DISORDER: Shingles
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Shingles', v_nervous_id, 120)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Shingles' AND body_system_id = v_nervous_id;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),    'Will nourish traumatized nerve tissue.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'), 'May help ease the associated pain and will definitely lessen associated anxiety or tension.', 20),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),'Will reduce the inflammatory response.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),    'Will alleviate muscular tension developed in response to pain.', 40),
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),    'May help deal with the virus infection, but it is very intransigent.', 50)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Shingles',
      'Dosage: up to 5 ml of tincture four times a day. Topical application of Mentha piperita oil may reduce pain through a mild, local numbing effect (do not use if skin is extremely sensitive). Colloidal oatmeal powder may be dusted on affected skin to minimize pain caused by contact with clothes.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Echinacea spp.','echinacea');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Immune support')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Migration 044 complete: Migraine, Neuritis, Tinnitus, Motion Sickness, Shingles disorders populated';
END $$;
