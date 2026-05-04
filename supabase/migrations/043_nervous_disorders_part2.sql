-- Migration 043: Nervous system disorders part 2
-- Disorders: Withdrawal from Benzodiazepines, Anorexia Nervosa, Headache

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
  -- DISORDER: Withdrawal from Benzodiazepines
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Withdrawal from Benzodiazepines', v_nervous_id, 50)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Withdrawal from Benzodiazepines' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
    VALUES (v_disorder_id,
      'All of the commonly prescribed and abused minor tranquilizers, such as Valium and Xanax, can be safely replaced by herbal remedies when used in a broadly holistic context.',
      10)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),     'Fundamental to any long-term change in the individual''s ability to cope with life and transform what must be changed.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),  'Will fulfill the tranquilizing role of the drug in the short term.', 20),
    (v_disorder_id, herbal.ensure_action('Nervine stimulant'), 'May be indicated in some cases, due to the long-term slowing of mind and body that results from use of these drugs in some people.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),     'Alleviate muscular tension that develops in response to withdrawal.', 40),
    (v_disorder_id, herbal.ensure_action('Bitter'),            'Act as safe metabolic stimulants.', 50),
    (v_disorder_id, herbal.ensure_action('Adaptogen'),         'Will support the adrenals through the stressful process the body will undergo.', 60),
    (v_disorder_id, herbal.ensure_action('Hepatic'),           'May be appropriate to support the detoxification process.', 70)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies (Primary Relaxing and Tonic Nervines for Withdrawal)
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Avena sativa','oats'),                  'Primary Relaxing and Tonic Nervine for Withdrawal', 10),
    (v_disorder_id, herbal.ensure_herb('Passiflora incarnata','passionflower'), 'Primary Relaxing and Tonic Nervine for Withdrawal', 20),
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),   'Primary Relaxing and Tonic Nervine for Withdrawal', 30),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),     'Primary Relaxing and Tonic Nervine for Withdrawal', 40)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- disorder_action_herbs: "Nervines with Relevant Secondary Actions in Withdrawal"
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Verbena officinalis','vervain'),           herbal.ensure_action('Nervine tonic'),    10),
    (v_disorder_id, herbal.ensure_herb('Verbena officinalis','vervain'),           herbal.ensure_action('Hepatic'),          20),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),            herbal.ensure_action('Antidepressant'),   30),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),            herbal.ensure_action('Bitter'),           40),
    (v_disorder_id, herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng'), herbal.ensure_action('Adaptogen'), 50),
    (v_disorder_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),herbal.ensure_action('Antidepressant'),   60),
    (v_disorder_id, herbal.ensure_herb('Silybum marianum','milk thistle'),         herbal.ensure_action('Antihepatotoxic'), 70)
    ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription to Help with Benzodiazepine Withdrawal',
      'Dosage: 2.5 ml to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca','motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Eleutherococcus senticosus','Siberian ginseng');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
  END IF;

  -- ============================================================
  -- DISORDER: Anorexia Nervosa
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Anorexia Nervosa', v_nervous_id, 60)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Anorexia Nervosa' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Anorexia nervosa is a problem typified by self-starvation.', 10),
    (v_disorder_id, 'In general, the patient will sleep poorly but, despite weight loss, will remain physically active, believing herself to be much fatter than she actually is. These symptoms suggest that anorexia nervosa may be associated with a disorder of the hypothalamus, a region of the brain that regulates menstruation, eating, body temperature, and sleep.', 20)
    ON CONFLICT DO NOTHING;

  -- Actions indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Bitter'),           'Indicated because they stimulate both appetite and general metabolism.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),    'Fundamental to any long-term change in the individual''s ability to cope with life and transform what must be changed.', 20),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'), 'Will alleviate associated anxiety.', 30),
    (v_disorder_id, herbal.ensure_action('Hepatic'),          'Will support the detoxification process and generally benefit the body.', 40)
    ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
    VALUES (v_disorder_id, herbal.ensure_herb('Verbena officinalis','vervain'),
      'Bitters are considered specifics here, but especially Verbena officinalis (vervain), a relaxing nervine with marked hepatic properties.', 10)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Anorexia Nervosa',
      'Dosage: 5 ml of tincture 10 to 15 minutes before eating, three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Gentiana lutea','gentian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum','St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Verbena officinalis','vervain');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;
  END IF;

  -- ============================================================
  -- DISORDER: Headache
  -- ============================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Headache', v_nervous_id, 70)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders WHERE name = 'Headache' AND body_system_id = v_nervous_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'For most headaches, even when the pain is severe, no underlying disease exists. Most headaches are caused by fatigue, emotional disorders, or allergies.', 10),
    (v_disorder_id, 'Headache pain results from the stimulation of pain-sensitive structures such as the meninges and the nerves of the cranium and upper neck — produced by inflammation, dilation of blood vessels in the head, or muscle spasms.', 20),
    (v_disorder_id, 'Headaches brought on by muscle spasms are classified as tension headaches. Those caused by dilation of blood vessels are called vascular headaches.', 30)
    ON CONFLICT DO NOTHING;

  -- Specific remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Artemisia absinthium','wormwood'),    'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 10),
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum','cayenne'),          'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 20),
    (v_disorder_id, herbal.ensure_herb('Lavandula spp.','lavender'),          'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 30),
    (v_disorder_id, herbal.ensure_herb('Matricaria recutita','chamomile'),    'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 40),
    (v_disorder_id, herbal.ensure_herb('Melissa officinalis','lemon balm'),   'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 50),
    (v_disorder_id, herbal.ensure_herb('Mentha piperita','peppermint'),       'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 60),
    (v_disorder_id, herbal.ensure_herb('Origanum marjorana','marjoram'),      'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 70),
    (v_disorder_id, herbal.ensure_herb('Piscidia erythrina','Jamaica dogwood'),'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 80),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis','rosemary'),  'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 90),
    (v_disorder_id, herbal.ensure_herb('Ruta graveolens','rue'),              'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 100),
    (v_disorder_id, herbal.ensure_herb('Sambucus nigra','elder'),             'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 110),
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'), 'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 120),
    (v_disorder_id, herbal.ensure_herb('Stachys betonica','wood betony'),     'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 130),
    (v_disorder_id, herbal.ensure_herb('Thymus vulgaris','thyme'),            'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 140),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),   'Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.', 150)
    ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Essential Oils for Headache
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Essential Oils for Headache',
      'Many essential oils can be used to relieve headache. Particularly effective oils include Lavandula spp., Rosmarinus officinalis, and Mentha piperita, which can be used separately or in combination. Lavandula may be rubbed on the temples or made into a cold compress. Equal parts of Lavandula and Mentha piperita may be even more effective. If headache is caused by catarrh or sinus infection, inhalations will be very effective.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),      'essential oil', 10),
      (v_rx_id, herbal.ensure_herb('Rosmarinus officinalis','rosemary'), 'essential oil', 20),
      (v_rx_id, herbal.ensure_herb('Mentha piperita','peppermint'),   'essential oil', 30);
  END IF;

  -- Prescription 2: Supportive Nervines for Tension Headaches (list)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Supportive Nervines for Tension Headaches',
      'A daily supplement of B-complex vitamins and vitamin C is also helpful. Relaxation exercises are invaluable, and the impact of various stressors should be softened.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),      'as needed', 10),
      (v_rx_id, herbal.ensure_herb('Avena sativa','oats'),               'as needed', 20),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),   'as needed', 30),
      (v_rx_id, herbal.ensure_herb('Melissa officinalis','lemon balm'),  'as needed', 40),
      (v_rx_id, herbal.ensure_herb('Piper methysticum','kava kava'),     'as needed', 50),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),'as needed', 60),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos','linden'),       'as needed', 70),
      (v_rx_id, herbal.ensure_herb('Verbena officinalis','vervain'),     'as needed', 80);
  END IF;

  -- Prescription 3: Tension-Related Headaches tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Tension-Related Headaches',
      'Dosage: 2.5 ml of tincture combination three times a day. If using dried herbs, infuse 2 teaspoons of the mixture in 1 cup of boiling water, drunk three times a day.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora','skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);

    v_herb_id := herbal.ensure_herb('Valeriana officinalis','valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);

    v_herb_id := herbal.ensure_herb('Avena sativa','oats');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
  END IF;

  -- Prescription 4: Tension Headache with Indigestion and Palpitations
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Tension Headache with Indigestion and Palpitations',
      'Dosage: 5 ml of tincture mixture three times a day. If using dried herbs, infuse 2 teaspoons of mixture to 1 cup of boiling water, drunk three times a day.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),  '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis','valerian'),    '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Leonurus cardiaca','motherwort'),      '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),     '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Artemisia vulgaris','mugwort'),        '1 part',  50);
  END IF;

  -- Prescription 5: Essential Oil Formula for Headache Relief
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Essential Oil Formula for Headache Relief',
      'Use as a massage or bath oil to relieve headache.',
      50)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.','lavender'),       '3 drops oil', 10),
      (v_rx_id, herbal.ensure_herb('Neroli','neroli'),                 '3 drops oil', 20),
      (v_rx_id, herbal.ensure_herb('Origanum marjorana','marjoram'),   '2 drops oil', 30),
      (v_rx_id, herbal.ensure_herb('Cananga odorata','ylang ylang'),   '2 drops oil', 40),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'), '1 drop oil',  50),
      (v_rx_id, herbal.ensure_herb('Salvia sclarea','clary sage'),     '1 drop oil',  60);
  END IF;

  RAISE NOTICE 'Migration 043 complete: Withdrawal from Benzodiazepines, Anorexia Nervosa, Headache disorders populated';
END $$;
