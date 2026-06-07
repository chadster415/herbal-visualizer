-- Migration 055: Reproductive System
-- Body systems: Reproductive - Female, Reproductive - Male
-- Includes primary actions, 28 disorders, notes, actions indicated,
-- specific remedies, and prescriptions with herb actions

SET search_path TO herbal, public;

-- ============================================================
-- BLOCK 0: Create body systems
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.body_systems (name)
    VALUES ('Reproductive - Female')
    ON CONFLICT (name) DO NOTHING;

  INSERT INTO herbal.body_systems (name)
    VALUES ('Reproductive - Male')
    ON CONFLICT (name) DO NOTHING;
END $$;


-- ============================================================
-- BLOCK 1: Primary Actions for the Reproductive - Female System
-- ============================================================
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  -- Uterine tonic
  v_action_id := herbal.ensure_action('Uterine tonic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Angelica sinensis',          'dong quai'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Cimicifuga racemosa',        'black cohosh'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Mitchella repens',           'partridgeberry'),  v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Hormonal normalizer
  v_action_id := herbal.ensure_action('Hormonal normalizer');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Vitex agnus-castus', 'chasteberry'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Uterine astringent
  v_action_id := herbal.ensure_action('Uterine astringent');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Alchemilla vulgaris',        'lady''s mantle'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Capsella bursa-pastoris',    'shepherd''s purse'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Geranium maculatum',         'cranesbill'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Vinca major',                'periwinkle'),        v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Uterine demulcent
  v_action_id := herbal.ensure_action('Uterine demulcent');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Viburnum opulus',     'cramp bark'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Viburnum prunifolium','black haw'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Leonurus cardiaca',   'motherwort'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower'),   v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 2: Disorder — Amenorrhea
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Amenorrhea', v_sys_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Amenorrhea' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The duration of a menstrual period is 28 ± 3 days for 65% of women, with a range of 18 to 40 days. Once a menstrual pattern has been established, the variation does not normally exceed five days. The average duration of flow is 5 ± 2 days, with a blood loss averaging 30 ml. Flow is generally heaviest on the second day.', 10),
    (v_disorder_id, 'The core herbal treatment guidelines for this condition must start with tonic support for the reproductive system.', 20),
    (v_disorder_id, 'Other actions will be indicated by the associated symptom picture or case history. For example, if anxiety and stress are an issue, consider appropriate nervines. If severe menstrual cramps occur, use antispasmodics.', 30)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Emmenagogue'),
      'Are the classic treatment, as they can trigger the menstrual process.', 10),
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'Will help the body regulate levels of various hormones.', 20),
    (v_disorder_id, herbal.ensure_action('Uterine tonic'),
      'Will contribute their nourishing, toning power.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Mentha pulegium',    'pennyroyal'), 'Can help initiate flow.', 10),
    (v_disorder_id, herbal.ensure_herb('Achillea millefolium','yarrow'),    'Can help initiate flow.', 20),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris', 'mugwort'),   'Can help initiate flow.', 30)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Hormonal Imbalance
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Amenorrhea Associated with Hormonal Imbalance',
      'Dosage: 2 ml of tincture three times a day until period starts.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Artemisia vulgaris', 'mugwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue'))         ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Stress
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Amenorrhea Associated with Stress',
      'Dosage: 2.5 ml of tincture three times a day until period starts.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Verbena officinalis', 'vervain');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emmenagogue'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 3: Disorder — Dysmenorrhea
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Dysmenorrhea', v_sys_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Dysmenorrhea' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Dysmenorrhea, or painful menstruation, is the most common of all gynecologic complaints.', 10),
    (v_disorder_id, 'A number of constitutional factors may lower the pain threshold and thus appear to worsen dysmenorrhea. Common factors include anemia, increase in obesity, chronic illness, over-work, stress in general, diabetes, and poor nutrition.', 20),
    (v_disorder_id, 'Primary dysmenorrhea is dysmenorrhea unrelated to any definable pelvic lesion. It usually starts with the first ovulatory cycles, beginning in most cases before the age of 20 years. It generally occurs over the midline of the abdomen, and is relieved by the onset of good menstrual flow.', 30),
    (v_disorder_id, 'Secondary dysmenorrhea is related to the presence of pelvic lesions associated with organic pelvic disease; often it is lateralized to one side of the body. In general, the onset of secondary dysmenorrhea occurs later in life in women who have not had primary dysmenorrhea.', 40),
    (v_disorder_id, 'Psychological issues can be fundamental here. Low tolerance to the sensation of uterine contraction may be learned behavior.', 50)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'Ease the muscle spasms that are the immediate cause of pain.', 10),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'Will help associated psychological tension or anxiety.', 20),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'Are indicated if dysmenorrhea is of a congestive nature, accompanied by water retention.', 30),
    (v_disorder_id, herbal.ensure_action('Uterine tonic'),
      'Provide the basis for any healing work in this body system.', 40),
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'Are indicated if the diagnosis suggests that hormonal imbalance is making a pivotal contribution.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',  'black cohosh'), '', 10),
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',    'wild yam'),     '', 20),
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),   '', 30),
    (v_disorder_id, herbal.ensure_herb('Viburnum opulus',      'cramp bark'),   '', 40),
    (v_disorder_id, herbal.ensure_herb('Viburnum prunifolium', 'black haw'),    '', 50)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Dysmenorrhea',
      'Dosage: 5 ml of tincture as needed.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Pelvic Lesions
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Dysmenorrhea Associated with Pelvic Lesions',
      'Dosage: 5 ml of tincture three times a day. The addition of Dioscorea villosa will provide a more reliable antispasmodic action if a physical problem is present. This prescription will support, but not replace, whatever treatment is necessary for the underlying problem.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Dioscorea villosa', 'wild yam');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic')) ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 4: Disorder — Premenstrual Syndrome
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Premenstrual Syndrome', v_sys_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Premenstrual Syndrome' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The name premenstrual syndrome (PMS) describes a broad range of symptoms that occur cyclically and are severe enough to disturb a woman''s life or cause her to seek help from a health practitioner.', 10),
    (v_disorder_id, 'There is, by definition, a period of time for PMS sufferers during which symptoms are absent, usually just after the onset or end of menses. PMS occurs during the proliferative or luteal phase of the menstrual cycle, when levels of estrogen and progesterone are relatively high. Estrogen is a central nervous system (CNS) stimulant and progesterone is a CNS depressant.', 20),
    (v_disorder_id, 'Violent crimes by women and suicide are often committed in the premenstrual period.', 30)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'Usually alleviate symptoms, but rarely clear the recurrent pattern.', 10),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'Ease any accompanying dysmenorrhea.', 20),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'Indicated if water retention is part of the picture.', 30),
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'Indicated if the diagnosis suggests that hormonal imbalance is making a pivotal contribution to PMS.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),
      'Useful in the short term; is as close as possible to a specific for symptomatic relief.', 10),
    (v_disorder_id, herbal.ensure_herb('Vitex agnus-castus', 'chasteberry'),
      'A longer-term specific, hormonally focused.', 20)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Acute PMS Symptoms
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Acute PMS Symptoms',
      'Dosage: 5 ml of tincture as needed to alleviate symptoms. The dosage may be increased until the desired relief is experienced. The regimen may be altered as necessary, varying time of day and quantity of dose to suit the individual''s needs. Always treat the human being, not the theory about the condition.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, 'leaf, 1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Normalize Hormone Levels
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Supportive Prescription to Normalize Hormone Levels',
      'Dosage: 5 ml of tincture once a day throughout cycle. Use in combination with the prescription for symptomatic relief.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: PMS with Transitory Skin Problems
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for PMS Associated with Transitory Skin Problems',
      'Dosage: 5 ml of tincture as needed to alleviate symptoms. Use in combination with the Prescription to Normalize Hormone Levels.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, 'leaf, 1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 5: Disorder — Menopausal Complaints
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Menopausal Complaints', v_sys_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Menopausal Complaints' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'In our society, far too many women approach menopause with dread, fearing that they will no longer be valued as women. On the other hand, menopause may also be viewed as a great gift in a woman''s life, a liberation and an initiation.', 10),
    (v_disorder_id, 'Menopause is the cessation of menstruation and the termination of fertility, which are not the same thing and may occur at different times. Climacteric is a transition phase that lasts for 15 to 20 years, during which time ovarian function and hormone production decline and the body readapts. Menopause is simply one event within this process.', 20),
    (v_disorder_id, 'The years of progressive ovarian failure that lead up to menopause are what are referred to as the climacteric, or "change of life." In the United States, the majority of women experience menopause between the ages of 40 and 55, and the average age of menopause is 51 years.', 30),
    (v_disorder_id, 'The most common symptom caused by the menopausal decline in estrogen secretion is hot flashes, or flushing. About 85% of women over the age of 50 are affected. Vitex agnus-castus is an effective remedy for this often distressing symptom.', 40),
    (v_disorder_id, 'Decreased estrogen secretion has no direct effect on libido. As long as vaginal symptoms are effectively treated, there is no reason why postmenopausal women should not be able to enjoy a satisfying sex life.', 50),
    (v_disorder_id, 'With decreased production of natural lubricating substances, the vagina becomes dry and irritated. Itching and dyspareunia (painful sexual intercourse) may result.', 60),
    (v_disorder_id, 'Estrogen deficiency plays a role in postmenopausal osteoporosis by diminishing the intestinal absorption of calcium.', 70)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'Will help the body''s endocrine control mechanisms balance activity in the face of the menopausal changes.', 10),
    (v_disorder_id, herbal.ensure_action('Uterine tonic'),
      'Help the various organs and tissues involved move through the changes with minimal trauma.', 20),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'Indicated for the anxiety and tension that often accompany menopausal changes. The nervines will ideally also be tonics.', 30),
    (v_disorder_id, herbal.ensure_action('Antidepressant'),
      'Will be needed if the woman experiences depression.', 40),
    (v_disorder_id, herbal.ensure_action('Bitter'),
      'Help in a generalized way as stimulants. These may be taken as part of the diet.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'),
      'May help lessen any depression that might occur.', 10),
    (v_disorder_id, herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),
      'Can help with the distressing tachycardia that often accompanies hot flashes.', 20),
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh'),
      'In North American herbalism, a potential specific for menopausal complaints.', 30),
    (v_disorder_id, herbal.ensure_herb('Senecio aureus', 'life root'),
      'In North American herbalism, a potential specific for menopausal complaints.', 40)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Easing Menopause Symptoms
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Easing Menopause Symptoms',
      'Dosage: 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Menopause with Anxiety and Tachycardia
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Menopause Symptoms with Anxiety and Tachycardia',
      'Dosage: up to 5 ml of tincture three times a day.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant'))  ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))    ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 6: Disorder — Pregnancy - General Issues
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - General Issues', v_sys_id, 50)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - General Issues' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Herbs can shorten labor and decrease the likelihood that complications will arise during pregnancy and in childbirth. The most widely used of these in Europe is raspberry leaf (Rubus idaeus).', 10),
    (v_disorder_id, 'Because bitters stimulate metabolism in general, and some bitters also act as emmenagogues to stimulate smooth muscle activity, bitters are contraindicated during pregnancy.', 20),
    (v_disorder_id, 'Alkaloids are a diverse group of secondary plant constituents with a wide range of pharmacological effects. The stronger representatives should be avoided during pregnancy, including the caffeine-containing social drugs coffee and tea.', 30),
    (v_disorder_id, 'Many essential oils can have a devastating impact on the placenta and fetus if taken internally during pregnancy. However, if used in moderation, the whole plant from which the oil was distilled will usually be fine.', 40),
    (v_disorder_id, 'The strong herbal laxatives often owe their effects to the presence of anthraquinone constituents that stimulate peristalsis in the bowel. They may have a similar stimulating impact upon the uterus.', 50),
    (v_disorder_id, 'Anthelmintic remedies should be avoided because they often stimulate uterine contractions, as well as containing potentially toxic constituents.', 60)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Rubus idaeus', 'raspberry leaf'),
      'Has a mildly soothing astringent and tonic action. Helps to quell nausea and is slightly sedative. Has a particular affinity for the uterus, acting to strengthen the uterine and pelvic muscles and prevent miscarriage. The relaxant properties bring about tonic relaxation of the smooth muscle of the uterus, helping to reduce the pain of uterine contractions at labor. Raspberry leaf tones the mucous membranes throughout the body, soothes the kidneys and urinary tract, and helps prevent hemorrhage. Principally used before delivery to encourage safe, easy, and speedy childbirth, and after delivery to improve milk production and speed recovery.', 10)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 7: Disorder — Pregnancy - First Trimester - Threatened Miscarriage
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Threatened Miscarriage', v_sys_id, 60)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Threatened Miscarriage' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Herbs can help as long as the fetus is normal and the mother''s general physical, emotional, and mental health is good. No herbal remedy will block appropriate miscarriage — most cases are a natural rejection of a malformed fetus.', 10),
    (v_disorder_id, 'To ensure fewer complications, women should take at least 6 to 12 months between pregnancies.', 20),
    (v_disorder_id, 'When chronic poor health, inadequate diet, or trauma and stress has depleted a woman''s general strength, herbs can provide extra vitality, especially to the womb, and so help avoid unnecessary miscarriage.', 30),
    (v_disorder_id, 'The woman should eat plenty of foods containing vitamins E and C. Asparagus and celery are said to be strengthening.', 40)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',           'wild yam'),       '', 10),
    (v_disorder_id, herbal.ensure_herb('Viburnum opulus',             'cramp bark'),     '', 20),
    (v_disorder_id, herbal.ensure_herb('Viburnum prunifolium',        'black haw'),      '', 30),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis',      'rosemary'),       '', 40),
    (v_disorder_id, herbal.ensure_herb('Rubus idaeus',                'raspberry leaf'), '', 50),
    (v_disorder_id, herbal.ensure_herb('Crataegus laevigata',         'hawthorn'),       '', 60),
    (v_disorder_id, herbal.ensure_herb('Mitchella repens',            'partridgeberry'), '', 70),
    (v_disorder_id, herbal.ensure_herb('Leonurus cardiaca',           'motherwort'),     '', 80),
    (v_disorder_id, herbal.ensure_herb('Allium sativum',              'garlic'),         '', 90),
    (v_disorder_id, herbal.ensure_herb('Trigonella foenum-graecum',   'fenugreek'),      '', 100)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription to Help Prevent Miscarriage',
      'Dosage: 2.5 ml of tincture three times a day, building up to 5 ml three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 8: Disorder — Pregnancy - First Trimester - Morning Sickness
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Morning Sickness', v_sys_id, 70)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Morning Sickness' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Morning sickness refers to the nausea and vomiting some women experience when they become pregnant. It is caused by the sudden increase in hormone levels during pregnancy.', 10),
    (v_disorder_id, 'It is very common early in pregnancy, but tends to go away later, and is almost always gone by the second trimester (the fourth month). Morning sickness is seen in about 50% of pregnancies, and tends to worsen with each successive pregnancy.', 20),
    (v_disorder_id, 'During the first 12 to 14 weeks of pregnancy, when most women experience sickness, hormones are primarily produced in the corpus luteum in the ovaries. After this time, hormone production shifts to the placenta, which may help explain why morning sickness stops at around the same time.', 30)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antiemetic'),
      'Important, as they will calm the vomit reflex, no matter what the cause of morning sickness.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Ballota nigra',            'black horehound'),  'Valuable antiemetic safe to use in early pregnancy.', 10),
    (v_disorder_id, herbal.ensure_herb('Filipendula ulmaria',      'meadowsweet'),      'Valuable antiemetic safe to use in early pregnancy.', 20),
    (v_disorder_id, herbal.ensure_herb('Gentiana lutea',           'gentian'),          'Valuable antiemetic safe to use in early pregnancy.', 30),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis',   'rosemary'),         'Valuable antiemetic safe to use in early pregnancy.', 40),
    (v_disorder_id, herbal.ensure_herb('Cinnamomum aromaticum',    'cinnamon bark'),    'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 50),
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',        'wild yam'),         'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 60),
    (v_disorder_id, herbal.ensure_herb('Foeniculum vulgare',       'fennel seed'),      'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 70),
    (v_disorder_id, herbal.ensure_herb('Humulus lupulus',          'hops'),             'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 80),
    (v_disorder_id, herbal.ensure_herb('Lavandula spp.',           'lavender'),         'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 90),
    (v_disorder_id, herbal.ensure_herb('Matricaria recutita',      'chamomile'),        'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 100),
    (v_disorder_id, herbal.ensure_herb('Melissa officinalis',      'lemon balm'),       'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 110),
    (v_disorder_id, herbal.ensure_herb('Mentha piperita',          'peppermint'),       'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 120),
    (v_disorder_id, herbal.ensure_herb('Rubus idaeus',             'raspberry leaf'),   'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 130),
    (v_disorder_id, herbal.ensure_herb('Syzygium aromaticum',      'clove'),            'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 140),
    (v_disorder_id, herbal.ensure_herb('Zingiber officinale',      'ginger root'),      'Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.', 150),
    (v_disorder_id, herbal.ensure_herb('Chondrus crispus',         'Irish moss'),       'Mucilage-rich demulcent that helps soothe the digestive tract. Highly nutritious and easily digested, with many minerals and trace elements.', 160),
    (v_disorder_id, herbal.ensure_herb('Ulmus rubra',              'slippery elm'),     'Mucilage-rich demulcent that helps soothe the digestive tract. Highly nutritious and easily digested, with many minerals and trace elements.', 170)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Morning Sickness',
      'Dosage: 2.5 ml of tincture at night and in the morning, building up to 5 ml if needed.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Zingiber officinale', 'ginger root'),    '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Dioscorea villosa',   'wild yam'),       '1 part', 20),
      (v_rx_id, herbal.ensure_herb('Ballota nigra',       'black horehound'),'1 part', 30);
  END IF;

  -- Prescription 2: Infusion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Supplemental Infusion for Morning Sickness',
      'Dosage: Infuse 1 teaspoon of dried herb mixture in 1 cup of boiling water. Drink often during the day.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Mentha piperita',    'peppermint'), '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita','chamomile'),  '1 part', 20);
  END IF;

END $$;


-- ============================================================
-- BLOCK 9: Disorder — Pregnancy - First Trimester - Constipation
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Constipation', v_sys_id, 80)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Constipation' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'High levels of progesterone relax the intestinal muscles, and thus reduce their ability to propel the contents of the bowel toward the rectum and out of the body.', 10),
    (v_disorder_id, 'The weight of the baby and placenta increases pressure on the lower bowel, aggravating the tendency to constipation.', 20),
    (v_disorder_id, 'Anthraquinone-containing stimulant laxatives are not safe for use during pregnancy.', 30),
    (v_disorder_id, 'Increase water intake to 8 glasses per day. Increase exercise — walking half a mile a day is appropriate. Increase intake of fresh fruits and certain dried fruits, such as prunes, raisins, and figs. Increase fiber intake. Use bulk laxatives, such as psyllium seeds: 1 tablespoon three times a day in 1/4 cup of juice.', 40)
  ON CONFLICT DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 10: Disorder — Pregnancy - First Trimester - Anemia
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Anemia', v_sys_id, 90)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Anemia' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Anemia commonly occurs during the last two months of pregnancy, when the baby utilizes a high proportion of the mother''s iron.', 10),
    (v_disorder_id, 'The best approach is to increase dietary intake of iron-containing foods, as iron supplements may aggravate constipation.', 20)
  ON CONFLICT DO NOTHING;

  -- Note: Crataegus spp. appears twice in the source with different common names/uses;
  -- merged here as a single entry since herb_id is shared.
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.',         'hawthorn'),     'Leafy herb that can be added to salads, cooked as a vegetable, and added to soups; also contains meaningful levels of iron when used as an infusion or tincture.', 10),
    (v_disorder_id, herbal.ensure_herb('Rumex acetosa',          'sorrel'),       'Leafy herb that can be added to salads, cooked as a vegetable, and added to soups.', 20),
    (v_disorder_id, herbal.ensure_herb('Symphytum officinale',   'comfrey leaf'), 'Leafy herb that can be added to salads, cooked as a vegetable, and added to soups — use in moderation.', 30),
    (v_disorder_id, herbal.ensure_herb('Taraxacum officinale',   'dandelion'),    'Leafy herb that can be added to salads, cooked as a vegetable, and added to soups.', 40),
    (v_disorder_id, herbal.ensure_herb('Urtica dioica',          'nettle'),       'Leafy herb that can be added to salads, cooked as a vegetable, and added to soups.', 50),
    (v_disorder_id, herbal.ensure_herb('Arctium lappa',          'burdock'),      'Contains meaningful levels of iron when used as an infusion or tincture.', 60),
    (v_disorder_id, herbal.ensure_herb('Gentiana lutea',         'gentian'),      'Contains meaningful levels of iron when used as an infusion or tincture.', 70),
    (v_disorder_id, herbal.ensure_herb('Humulus lupulus',        'hops'),         'Contains meaningful levels of iron when used as an infusion or tincture.', 80),
    (v_disorder_id, herbal.ensure_herb('Rubus idaeus',           'raspberry leaf'),'Contains meaningful levels of iron when used as an infusion or tincture.', 90),
    (v_disorder_id, herbal.ensure_herb('Rumex crispus',          'yellow dock'),  'Contains meaningful levels of iron when used as an infusion or tincture.', 100),
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),     'Contains meaningful levels of iron when used as an infusion or tincture.', 110),
    (v_disorder_id, herbal.ensure_herb('Verbena officinalis',    'vervain'),      'Contains meaningful levels of iron when used as an infusion or tincture.', 120)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCKS 11-15: Pregnancy - First Trimester (notes-only disorders)
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  -- Dizziness
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Dizziness', v_sys_id, 100)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Dizziness' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Dizziness caused by the ability of progesterone to relax the blood vessel walls is common in pregnancy.', 10),
    (v_disorder_id, 'Recommendations: Change positions slowly. Eat small meals throughout the day rather than three large meals. Maintain blood sugar levels.', 20)
  ON CONFLICT DO NOTHING;

  -- Heartburn
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Heartburn', v_sys_id, 110)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Heartburn' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Heartburn, caused by reflux of gastric contents into the esophagus, is one of the most common complaints of pregnancy.', 10),
    (v_disorder_id, 'The relaxing effects of progesterone also reach the cardiac sphincter, the valve that guards the entrance to the stomach at the bottom of the esophagus.', 20)
  ON CONFLICT DO NOTHING;

  -- Bleeding Gums
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Bleeding Gums', v_sys_id, 120)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Bleeding Gums' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Bleeding gums are frequently seen in pregnancy. Gingival hypertrophy, a temporary softening of the gums, is seen in 40% of pregnancies. This is a response to elevated progesterone levels in the blood.', 10),
    (v_disorder_id, 'Suggestions: Brush gums frequently with a soft brush. Vitamin C and bioflavonoids complex: up to 2,000 mg/day.', 20)
  ON CONFLICT DO NOTHING;

  -- Headache
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Headache', v_sys_id, 130)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Headache' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Headache sometimes occurs in early pregnancy, but is worse between three and five months. A few cases may result from eyestrain, as pregnancy may result in a change in the amount of refractive error in the eyes. Some cases may be caused by sinusitis, and frontal headaches are seen with hypertension.', 10)
  ON CONFLICT DO NOTHING;

  -- Hemorrhoids
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - First Trimester - Hemorrhoids', v_sys_id, 140)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - First Trimester - Hemorrhoids' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Hemorrhoids may be exacerbated by or occur for the first time during pregnancy. The condition is caused by increased pressure and impairment of return of venous fluid in the veins by the pressure of the enlarging uterus.', 10)
  ON CONFLICT DO NOTHING;

END $$;


-- ============================================================
-- BLOCKS 16-19: Pregnancy - Second and Third Trimester (notes-only)
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  -- General
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Second and Third Trimester - General', v_sys_id, 150)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Second and Third Trimester - General' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'During the second trimester, the woman will usually experience decreased nausea and better sleep patterns, and have more stamina and energy than during the first trimester.', 10),
    (v_disorder_id, 'A whole new set of symptoms and sensations commonly arise, including back pain, leg cramps, heartburn, skin changes, and constipation.', 20),
    (v_disorder_id, 'Many of the physical symptoms of late pregnancy arise from the increase in uterine size. These may include shortness of breath, sleeping problems, varicose veins, skin changes, and hemorrhoids.', 30)
  ON CONFLICT DO NOTHING;

  -- Stretch Marks
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Second and Third Trimester - Stretch Marks', v_sys_id, 160)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Second and Third Trimester - Stretch Marks' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The tendency to develop stretch marks can be lessened by eating appropriately and using remedies to address collagen problems in the skin.', 10),
    (v_disorder_id, 'Massaging wheat germ or vitamin E oil into the breasts, abdomen, and thighs daily will reduce the likelihood that marks will develop. Calendula oil mixed with wheat germ oil is especially helpful.', 20)
  ON CONFLICT DO NOTHING;

  -- Backache
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Second and Third Trimester - Backache', v_sys_id, 170)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Second and Third Trimester - Backache' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The relaxation of the ligaments that support the spine combined with the weight of the growing abdomen often cause backache.', 10),
    (v_disorder_id, 'Yoga exercises may be helpful. Rest is important in preventing or relieving backache, especially in the last three months of pregnancy. Deep breathing and relaxation exercises can also help. Baths with lavender and rosemary essential oils and massage of the whole spine with a mixture of chamomile and geranium essential oils can be effective.', 20)
  ON CONFLICT DO NOTHING;

  -- Hypertension
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Second and Third Trimester - Hypertension', v_sys_id, 180)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Second and Third Trimester - Hypertension' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Gestational hypertension is characterized by a steady rise in blood pressure after the 28th week of gestation. The general rule for the upper limit of gestational hypertension is 140/90 mm Hg.', 10),
    (v_disorder_id, 'Herbal treatment can do much to mitigate this form of secondary hypertension, but blood pressure must be monitored closely.', 20)
  ON CONFLICT DO NOTHING;

END $$;


-- ============================================================
-- BLOCKS 20-21: Pregnancy - Postpartum - General and Depression
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  -- General
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Postpartum - General', v_sys_id, 190)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Postpartum - General' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Generally, if a woman does not nurse, she will menstruate six to eight weeks after birth. Nursing women begin to menstruate again at any time from six weeks after birth to two years after birth.', 10),
    (v_disorder_id, 'Nursing is not an adequate method of birth control, as most women ovulate before they menstruate, and a woman can become pregnant before her period returns.', 20)
  ON CONFLICT DO NOTHING;

  -- Depression
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Postpartum - Depression', v_sys_id, 200)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Postpartum - Depression' AND body_system_id = v_sys_id;
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'If the woman is lactating, she will secrete prolactin, which is stimulated by the sensation caused by the nursing baby. Prolactin is a mild relaxant and depressant. As prolactin levels rise, the elevated levels of estrogen and progesterone maintained throughout the pregnancy drop abruptly. This may lead to postpartum depression.', 10),
    (v_disorder_id, 'Greater emphasis can be placed on Artemisia vulgaris and Hypericum perforatum. It is important to encourage the new mother to go out and enjoy the company of other adults.', 20)
  ON CONFLICT DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 22: Disorder — Pregnancy - Postpartum - Perineal Tears or Extensive Episiotomy
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Postpartum - Perineal Tears or Extensive Episiotomy', v_sys_id, 210)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Postpartum - Perineal Tears or Extensive Episiotomy' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The perineum (the area of skin between the vagina and the anus) may be surgically cut (an episiotomy) or may tear during birth.', 10)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Aloe vera',            'aloe vera'),         'Apply gel externally to soothe and heal tissue.', 10),
    (v_disorder_id, herbal.ensure_herb('Calendula officinalis','calendula'),         'Good choice of herb for ointments or sitz baths.', 20),
    (v_disorder_id, herbal.ensure_herb('Symphytum officinale', 'comfrey'),           'Good choice of herb for ointments or sitz baths.', 30),
    (v_disorder_id, herbal.ensure_herb('Hydrastis canadensis', 'goldenseal'),        'Good choice of herb for ointments or sitz baths.', 40),
    (v_disorder_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),            'Good choice of herb for ointments or sitz baths.', 50)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 23: Disorder — Pregnancy - Postpartum - After Pains
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Postpartum - After Pains or Recurrent Uterine Contractions', v_sys_id, 220)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Postpartum - After Pains or Recurrent Uterine Contractions' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'For women who have had more than one child, after pains increase in strength with each successive pregnancy.', 10),
    (v_disorder_id, 'If necessary, use antispasmodic herbs and uterine tonics.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',  'black cohosh'), '', 10),
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',    'wild yam'),     '', 20),
    (v_disorder_id, herbal.ensure_herb('Viburnum prunifolium', 'black haw'),    '', 30),
    (v_disorder_id, herbal.ensure_herb('Viburnum opulus',      'cramp bark'),   '', 40)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 24: Disorder — Pregnancy - Postpartum - Stimulating Lactation
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Postpartum - Stimulating Lactation', v_sys_id, 230)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Postpartum - Stimulating Lactation' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Herbal remedies called galactogogues encourage milk production to begin and increase total milk volume.', 10)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Galega officinalis',  'goat''s rue'),     '', 10),
    (v_disorder_id, herbal.ensure_herb('Foeniculum vulgare',  'fennel seed'),     '', 20),
    (v_disorder_id, herbal.ensure_herb('Cnicus benedictus',   'blessed thistle'), '', 30)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 25: Disorder — Pregnancy - Postpartum - Mastitis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Pregnancy - Postpartum - Mastitis', v_sys_id, 240)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Pregnancy - Postpartum - Mastitis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Mastitis is inflammation of the mammary gland, usually caused by infection. Such breast infections are located in the tissue of the breast; the bacteria usually enter through cracks in the nipples.', 10)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Calendula officinalis', 'calendula'),
      'Apply vulnerary and antimicrobial herbs externally, such as Calendula.', 10)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 26: Disorder — Uterine Fibroids
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Uterine Fibroids', v_sys_id, 250)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Uterine Fibroids' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Fibroid tumors are benign muscle tumors that cause enlargement and distortion of the uterus in premenopausal women. They may make menstruation painful and heavy, possibly leading to anemia.', 10)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Uterine tonic'),
      'Support the general health and vitality of the uterus.', 10),
    (v_disorder_id, herbal.ensure_action('Uterine astringent'),
      'Reduce blood loss.', 20),
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'Often help in health problems associated with benign growths.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'Will lessen cramping pains.', 40),
    (v_disorder_id, herbal.ensure_action('Lymphatic'),
      'Support the drainage of fluid from the womb.', 50),
    (v_disorder_id, herbal.ensure_action('Immune support'),
      'May be appropriate.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Uterine Fibroids',
      'Dosage: 2.5 ml of tincture three times a day. This formula can be made stronger by adding more antispasmodic or astringent remedies.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))     ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Vinca major', 'periwinkle');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine astringent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Dioscorea villosa', 'wild yam');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic'))   ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 27: Disorder — Endometriosis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Endometriosis', v_sys_id, 260)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Endometriosis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Endometriosis is the presence of uterine tissue (endometrium) outside its usual location on the inner lining of the uterus. Pain, abnormal menstrual bleeding, infertility, and prolonged disability may result.', 10),
    (v_disorder_id, 'Endometrial tissue may implant itself on the ovaries, fallopian tubes, pelvic ligaments, abdominal organs, old scars, and, in rare cases, the chest, lungs, spinal cord, and extremities. Over time, the implants may enlarge, bleed, cause scarring, and form tough fibrous adhesions between pelvic and abdominal structures.', 20),
    (v_disorder_id, 'Implants often regress during pregnancy, and first pregnancy at a young age seems to protect against the development of endometriosis.', 30),
    (v_disorder_id, 'Endometriosis is a notoriously difficult condition to diagnose; conclusive diagnosis often necessitates exploratory laparoscopy. In severe cases, surgery may be indicated.', 40)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'Such as Vitex, appear to help the body alter underlying hormonal problems.', 10),
    (v_disorder_id, herbal.ensure_action('Uterine tonic'),
      'Essential for their tonic actions on endometrial tissue. In theory, this will help wherever such tissue is.', 20),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'Ease the muscular, cramping pain that is so distressing in this condition.', 30),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'Help with stress and pain.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',    'wild yam'),
      'There are no traditional specifics for endometriosis, but this is almost specific for the pain, although it is not very strong.', 10),
    (v_disorder_id, herbal.ensure_herb('Vitex agnus-castus',  'chasteberry'),
      'May be considered the most appropriate remedy for the underlying processes involved.', 20)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Endometriosis',
      'Dosage: 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Uterine tonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Dioscorea villosa', 'wild yam');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 28: Disorder — Fibrocystic Breast Disease
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Fibrocystic Breast Disease', v_sys_id, 270)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Fibrocystic Breast Disease' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Fibrocystic breast disease, also known as chronic cystic mastitis, is the most common nonmalignant breast disease.', 10),
    (v_disorder_id, 'While uncomfortable, the condition is not dangerous, and up to 20% of women develop some degree of fibrocystic breast disease during their lives.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Hormonal normalizer'),
      'Help the body balance hormones and regularize swings, enabling a move toward complete alleviation of the problem.', 10),
    (v_disorder_id, herbal.ensure_action('Lymphatic'),
      'Assist with drainage and the general vitality of the lymphatic tissue in the breast.', 20),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'May help if there are excessive dragging pains.', 30),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'Are indicated if the problem is associated with PMS.', 40),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'Help if there is associated water retention, but should not be used alone.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Vitex agnus-castus', 'chasteberry'),
      'No true specifics are known for this condition, but Vitex is undoubtedly strongly indicated.', 10),
    (v_disorder_id, herbal.ensure_herb('Oenothera biennis', 'evening primrose'),
      'Evening primrose oil may also be of great value.', 20)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Fibrocystic Breast Disease',
      'Dosage: 2.5 ml of tincture three times a day. In addition, the patient should take evening primrose oil (Oenothera biennis) at a dosage of five 500 mg capsules a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal normalizer')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 29: Disorder — Benign Prostatic Hypertrophy (Male)
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Benign Prostatic Hypertrophy', v_sys_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Benign Prostatic Hypertrophy' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'As it achieves adult size, the prostate wraps itself around the urethra, into which its secretions empty. The gland is normally about the size of a chestnut.', 10),
    (v_disorder_id, 'Because of its location, if it becomes inflamed or enlarged, it may exert pressure on the urethra or block the outlet to the bladder, thus obstructing the flow of urine. Urine trapped in the bladder may become infected, causing cystitis, and backward pressure can lead to kidney infection.', 20),
    (v_disorder_id, 'Congestion and overgrowth of the prostate gland is virtually universal in men older than 60.', 30),
    (v_disorder_id, 'DHT is necessary for the normal growth and development of the prostate, but its presence is also necessary for the pathologic enlargement that occurs in BPH. One therapeutic approach is to reduce the formation of DHT by blocking the enzyme 5-alpha reductase. Serenoa repens (saw palmetto) has this effect.', 40),
    (v_disorder_id, 'When it becomes impossible to empty the bladder of all its contents, the occasional bacteria present in the urinary tract are able to multiply, and urinary tract infection may occur.', 50)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Serenoa repens', 'saw palmetto'),
      'Reduces the formation of DHT by blocking the enzyme 5-alpha reductase, addressing the underlying driver of prostatic enlargement.', 10)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Internal tincture
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Benign Prostatic Hypertrophy (Internal)',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Serenoa repens',           'saw palmetto'), '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Hydrangea arborescens',    'hydrangea'),    '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Smilax spp.',              'sarsaparilla'), '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Zea mays',                 'corn silk'),    '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Arctostaphylos uva-ursi',  'uva ursi'),     '1 part',  50);
  END IF;

  -- Prescription 2: Sitz bath infusion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'An Infusion for Benign Prostatic Hypertrophy (Sitz Bath)',
      'Dosage: Infuse 2 oz of the mixture to each 1 pint of boiling water. Add infusion to sitz bath.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Equisetum arvense',       'horsetail'),  '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Elymus repens',           'couch grass'),'1 part', 20),
      (v_rx_id, herbal.ensure_herb('Arctostaphylos uva-ursi', 'uva ursi'),   '1 part', 30);
  END IF;

END $$;


-- ============================================================
-- BLOCK 30: Sync herb_primary_actions from disorder data
-- ============================================================
DO $$
DECLARE
  v_female_id INTEGER;
  v_male_id   INTEGER;
BEGIN
  SELECT id INTO v_female_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  SELECT id INTO v_male_id   FROM herbal.body_systems WHERE name = 'Reproductive - Male';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT dah.herb_id, dah.primary_action_id, d.body_system_id
  FROM herbal.disorder_action_herbs dah
  JOIN herbal.disorders d ON d.id = dah.disorder_id
  WHERE d.body_system_id IN (v_female_id, v_male_id)
  ON CONFLICT DO NOTHING;

END $$;
