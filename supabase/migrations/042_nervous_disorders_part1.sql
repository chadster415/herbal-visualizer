-- Migration 042: Nervous system disorders part 1
-- Disorders: Ongoing Stress, Acute Stress, Depression, Insomnia
-- Includes: notes, actions indicated, specific remedies, prescriptions, actions supplied

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nervous_id  INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
  v_action_id   INTEGER;
BEGIN
  SELECT id INTO v_nervous_id FROM herbal.body_systems WHERE name = 'Nervous';

  -- ============================================================
  -- DISORDER: Ongoing Stress
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Ongoing Stress', v_nervous_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Ongoing Stress' AND body_system_id = v_nervous_id;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES
      (v_disorder_id, herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng'), 'Adaptogen', 10),
      (v_disorder_id, herbal.ensure_herb('Panax ginseng','Korean ginseng'),                'Adaptogen', 20),
      (v_disorder_id, herbal.ensure_herb('Withania somnifera','ashwagandha'),              'Adaptogen', 30)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- ============================================================
  -- DISORDER: Acute Stress
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Acute Stress', v_nervous_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Acute Stress' AND body_system_id = v_nervous_id;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES
      (v_disorder_id, herbal.ensure_herb('Passiflora incarnata','passionflower'), 'Nervine Relaxant', 10),
      (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),     'Nervine Relaxant', 20),
      (v_disorder_id, herbal.ensure_herb('Piper methysticum','kava kava'),        'Nervine Relaxant', 30),
      (v_disorder_id, herbal.ensure_herb('Lactuca virosa','wild lettuce'),        'Nervine Relaxant', 40)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Simple acute stress
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute Stress Reactions',
      'Dosage: up to 5 ml of tincture as needed. The stress response is cyclical, and different times of the day will be more challenging for each person. The dosage may be increased until symptoms are relieved, as this is largely symptomatic medication. The dosage regimen may also be altered as necessary, varying time of day and quantity of dose to suit individual needs.',
      10)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Acute stress with indigestion and palpitations
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute Stress Reaction with Indigestion and Palpitations',
      'Dosage: up to 5 ml of tincture as needed. Motherwort (Leonurus cardiaca) supports the relaxing action of the other nervines, but also has a specific calming impact upon tachycardia.',
      20)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca','motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Matricaria recutita','chamomile');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Acute stress with muscle tension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute Stress Reaction with Associated Muscle Tension',
      'Dosage: up to 5 ml of tincture as needed.',
      30)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Piper methysticum','kava kava');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 4: Hot chamomile compress
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Hot Chamomile Compress for Muscle Tension',
      'Hot chamomile compresses work well to relax painful, tense muscles. Prepare a strong infusion, using a full cup of chamomile flowers and 2 quarts of water. Cover with a lid and allow to steep for about 10 minutes; strain. Dip a towel into the infusion, wring it out, and spread it (as hot as is tolerable) on the back, shoulders, and neck. Repeat the procedure 10 to 20 times, until there is a sense of relaxation and relief of tension.',
      40)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Matricaria recutita','chamomile');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
      VALUES (v_rx_id, v_herb_id, 'strong infusion', 'topical compress', 10);
  END IF;

  -- ============================================================
  -- DISORDER: Depression
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Depression', v_nervous_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Depression' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Depression is either a disorder in its own right or can be a symptom of another disorder, either mental or physical.', 10),
    (v_disorder_id, 'Major depression occurs in 10% to 20% of the world''s population in the course of a lifetime. Women are more often affected than men are, by a 2:1 ratio, and they seem to be at particular risk just before menstruation or immediately after childbirth.', 20),
    (v_disorder_id, 'Depression that is considered a reaction to some loss of or separation from a valued person or object is called reactive or exogenous depression. In contrast, the usually more severe form of depression without apparent cause is called endogenous depression.', 30),
    (v_disorder_id, 'TREATMENT OF DEPRESSION: In terms of the herbal component of treatment protocols for depression, attention to the liver and the digestive system in general is usually a good idea.', 40)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),     'Fundamental to any long-term change in the individual''s ability to cope and transform what must be changed.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),  'May be indicated in the short term, or if the depression has an agitated or hyperactive aspect. These should not be strong herbs, which could trigger a more entrenched depression.', 20),
    (v_disorder_id, herbal.ensure_action('Bitter'),            'Bitters often bring about dramatic changes in patients'' perceptions of themselves and of their lives.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),     'Will alleviate muscular tension that might manifest as a bodily expression of psychological depression. Care should be taken not to use strong relaxants.', 40),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),         'Support the adrenals in coping with the stress that the whole body is experiencing.', 50),
    (v_disorder_id, herbal.ensure_action('Hepatic'),           'Indicated to support the liver''s detoxification work, especially if the patient has been using prescription psychotropic drugs.', 60)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),
      'Hypericum perforatum (St. John''s wort) has a long tradition of use. This herb requires time to work, and so must be taken for at least a month.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription: Moderate Depression
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Moderate Depression',
      'Dosage: up to 5 ml of tincture three times a day for at least 1 month.',
      10)
    ON CONFLICT DO NOTHING
    RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
  END IF;

  -- ============================================================
  -- DISORDER: Insomnia
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Insomnia', v_nervous_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Insomnia' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'While sleeping approximately eight hours a night is vital to physical and mental health, dreaming is necessary for psychological health. Eight hours of sleep a night is the usually cited average, although 7 to 7½ hours is more accurate for most people.', 10),
    (v_disorder_id, 'Insomnia is especially related to conditions that result in pain, shortness of breath, cough, urination, nausea, diarrhea, or other bothersome symptoms that occur at night.', 20),
    (v_disorder_id, 'The key to successful treatment of insomnia is to find the cause and deal with it. Treatment should not depend upon substances, whether herbs or drugs.', 30),
    (v_disorder_id, 'Insomnia and Aromatherapy: Aromatherapy, a healing system based on the external application of herbs in the form of essential oils, has much to offer to those in search of restful sleep.', 40)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Hypnotic'),          'Herbs with a reputation for easing a person into sleep. They are usually strong nervine relaxants, rather than "plant knockout drops"!', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),  'Ease the tensions that often produce sleeplessness.', 20),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),     'Address any somatic muscular tightness that might be involved.', 30),
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),     'Indicated if there is any suspicion that insomnia is related to nervous exhaustion (as it often is).', 40),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),         'Will help in a way similar to nervine tonics, but should be used only in the morning to help deal with stress, as they might be too energizing at night.', 50)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Leonurus cardiaca','motherwort'),
      'By choosing herbs that address the specific health issues compounding the sleep difficulties, better results are obtained than if one simply chooses a strong hypnotic. If a patient with insomnia also has heart palpitations, Leonurus cardiaca would be a good choice of nervine.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Basic insomnia
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id, 'A Prescription for Insomnia', 'Dosage: 5 ml of tincture 30 minutes before bedtime.', 10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Insomnia with menopausal problems
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Menopausal Problems',
      'Dosage: 5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca','motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Insomnia with indigestion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Indigestion',
      'Dosage: 7.5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments. An infusion of Matricaria, Tilia, or Melissa at night may also be helpful.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Melissa officinalis','lemon balm');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 4: Insomnia with depression
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Depression',
      'Dosage: 7.5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments. Note: Avoid the use of Humulus lupulus (hops) in depression.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Passiflora incarnata','passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris','mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 5: Relaxing Antidepressant Essential Oil Formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Relaxing Antidepressant Essential Oil Formula',
      'This can be used as either a massage or a bath oil. Lavender is the primary essential oil used to induce sleep. Always dilute oils before applying to skin: 10 to 12 drops per ounce of carrier oil (2% dilution). For baths, add up to 5 drops to warm water.',
      50)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),         '3 drops oil', 10),
      (v_rx_id, herbal.ensure_herb('Neroli','neroli'),                   '3 drops oil', 20),
      (v_rx_id, herbal.ensure_herb('Salvia sclarea','clary sage'),       '2 drops oil', 30),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),     '2 drops oil', 40),
      (v_rx_id, herbal.ensure_herb('Cananga odorata','ylang ylang'),     '2 drops oil', 50),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),   '1 drop oil',  60);
  END IF;

  -- Prescription 6: Fragrant Insomnia Blend (diffuser)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Fragrant Insomnia Blend (for diffuser)',
      'Use in a diffuser to promote sleep.',
      60)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),       '25 drops oil', 10),
      (v_rx_id, herbal.ensure_herb('Citrus sinensis','sweet orange'),  '10 drops oil', 20),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'), '8 drops oil',  30),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),   '8 drops oil',  40),
      (v_rx_id, herbal.ensure_herb('Cananga odorata','ylang ylang'),   '6 drops oil',  50);
  END IF;

  RAISE NOTICE 'Migration 042 complete: Ongoing Stress, Acute Stress, Depression, Insomnia disorders populated';
END $$;
