-- Migration 048: Cardiovascular System
-- Body system: Cardiovascular
-- Primary actions with herbs, 7 disorders with notes, actions indicated,
-- specific remedies, and prescriptions

SET search_path TO herbal, public;

-- ============================================================
-- BLOCK 1: Primary Actions for the Cardiovascular System
-- ============================================================
DO $$
DECLARE
  v_cv_id     INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  -- Cardiotonic
  v_action_id := herbal.ensure_action('Cardiotonic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Crataegus spp.', 'hawthorn'),       v_action_id, v_cv_id),
    (herbal.ensure_herb('Tilia platyphyllos', 'linden'),     v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Cardioactive
  v_action_id := herbal.ensure_action('Cardioactive');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Convallaria majalis', 'lily of the valley'), v_action_id, v_cv_id),
    (herbal.ensure_herb('Cytisus scoparius', 'scotch broom'),         v_action_id, v_cv_id),
    (herbal.ensure_herb('Lycopus europaeus', 'bugleweed'),            v_action_id, v_cv_id),
    (herbal.ensure_herb('Scrophularia nodosa', 'figwort'),            v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Circulatory stimulant
  v_action_id := herbal.ensure_action('Circulatory stimulant');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Capsicum annuum', 'cayenne'), v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Peripheral vasodilator
  v_action_id := herbal.ensure_action('Peripheral vasodilator');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Zanthoxylum americanum', 'prickly ash'), v_action_id, v_cv_id),
    (herbal.ensure_herb('Ginkgo biloba', 'ginkgo'),               v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Hypotensive
  v_action_id := herbal.ensure_action('Hypotensive');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Tilia platyphyllos', 'linden'),  v_action_id, v_cv_id),
    (herbal.ensure_herb('Viscum album', 'mistletoe'),     v_action_id, v_cv_id),
    (herbal.ensure_herb('Allium sativum', 'garlic'),      v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Hypertensive
  v_action_id := herbal.ensure_action('Hypertensive');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Cytisus scoparius', 'scotch broom'), v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Diuretic
  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Taraxacum officinale', 'dandelion'),   v_action_id, v_cv_id),
    (herbal.ensure_herb('Achillea millefolium', 'yarrow'),      v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Vascular tonic
  v_action_id := herbal.ensure_action('Vascular tonic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut'), v_action_id, v_cv_id),
    (herbal.ensure_herb('Fagopyrum esculentum', 'buckwheat'),        v_action_id, v_cv_id),
    (herbal.ensure_herb('Ginkgo biloba', 'ginkgo'),                  v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Nervine
  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),      v_action_id, v_cv_id),
    (herbal.ensure_herb('Tilia platyphyllos', 'linden'),         v_action_id, v_cv_id),
    (herbal.ensure_herb('Valeriana officinalis', 'valerian'),    v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

  -- Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Viburnum opulus', 'cramp bark'),        v_action_id, v_cv_id),
    (herbal.ensure_herb('Valeriana officinalis', 'valerian'),    v_action_id, v_cv_id)
  ON CONFLICT DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 2: Disorder — Elevated Cholesterol
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Elevated Cholesterol', v_cv_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Elevated Cholesterol' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Cholesterol is found in all cells of the body, primarily as a structural component of cell membranes. Stored in the adrenal glands, testes, and ovaries, it serves as a precursor molecule for hormones.', 10),
    (v_disorder_id, 'In the bloodstream, cholesterol binds with protein molecules to form lipoproteins. HDL transports excess cholesterol to the liver for elimination, while LDL tends to remain in the body. VLDLs transport triglycerides.', 20),
    (v_disorder_id, 'LDL is often called "bad" cholesterol because excess LDL leads to buildup and blockage in the arteries. HDL is "good" cholesterol because it removes cholesterol from the blood, preventing arterial accumulation.', 30),
    (v_disorder_id, 'A desirable total cholesterol level for adults without heart disease is lower than 200 mg/dl. A level of 240 mg/dl or higher is considered high. Even borderline high levels (200–239 mg/dl) increase the risk of heart disease.', 40)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Commiphora mukul', 'guggul'),
      'Guggulipid is gaining a reputation for reducing high blood cholesterol. As antioxidants, guggulsterones keep LDL from oxidizing, protecting against atherosclerosis.', 10),
    (v_disorder_id, herbal.ensure_herb('Allium sativum', 'garlic'),
      'Significantly reduces serum cholesterol levels and possesses antiplatelet effects. Its cholesterol-lowering action appears unaffected by cooking.', 20),
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum', 'cayenne'),
      'Capsaicin-containing plants may help lower blood cholesterol levels.', 30),
    (v_disorder_id, herbal.ensure_herb('Trigonella foenum-graecum', 'fenugreek'),
      'May help lower blood cholesterol levels.', 40),
    (v_disorder_id, herbal.ensure_herb('Carum carvi', 'caraway'),
      'An aromatic spice with demonstrable cholesterol-lowering properties.', 50),
    (v_disorder_id, herbal.ensure_herb('Phyllanthus emblica', 'Indian gooseberry'),
      'An Asian herbal remedy proving its value in reducing elevated cholesterol.', 60),
    (v_disorder_id, herbal.ensure_herb('Ligustrum lucidum', 'privet'),
      'An Asian herbal remedy proving its value in reducing elevated cholesterol.', 70),
    (v_disorder_id, herbal.ensure_herb('Allium cepa', 'onion'),
      'Has an international reputation for lowering blood pressure and improving cardiovascular health.', 80),
    (v_disorder_id, herbal.ensure_herb('Medicago sativa', 'alfalfa'),
      'Reputed to have cholesterol-lowering properties.', 90),
    (v_disorder_id, herbal.ensure_herb('Curcuma longa', 'turmeric'),
      'Reputed to have cholesterol-lowering properties.', 100),
    (v_disorder_id, herbal.ensure_herb('Panax ginseng', 'Korean ginseng'),
      'Reputed to have cholesterol-lowering properties.', 110)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

END $$;


-- ============================================================
-- BLOCK 3: Disorder — Hypertension
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Hypertension', v_cv_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Hypertension' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Hypertension is common in Western culture but rare in those untouched by the Western lifestyle. Lifestyle plays a major role; dietary, psychological, and social factors must all be addressed.', 10),
    (v_disorder_id, 'Hypertension typically causes no symptoms until complications arise, which can include dizziness, flushed face, headache, fatigue, epistaxis (nosebleed), and nervousness.', 20),
    (v_disorder_id, 'In general, hypertension is indicated by a blood pressure measurement higher than 140/90 mm Hg. Blood pressure lower than 120/80 mm Hg is considered optimal.', 30),
    (v_disorder_id, 'If left untreated, high blood pressure can lead to arteriosclerosis, myocardial infarction, enlarged heart, kidney damage, and stroke.', 40),
    (v_disorder_id, 'Weight reduction, dietary changes, tobacco cessation, exercise, massage, relaxation techniques, and meditation are all important treatment components. Blood pressure usually falls when patients cut back on salt and sodium.', 50)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Hypotensive'),
      'A broad range of remedies with the observed effect of lowering elevated blood pressure. They appear to work in a variety of ways.', 10),
    (v_disorder_id, herbal.ensure_action('Cardiotonic'),
      'Play a fundamental role in strengthening and toning the whole cardiovascular system under such literal pressure. They facilitate beneficial changes in both the pattern and the volume of cardiac output.', 20),
    (v_disorder_id, herbal.ensure_action('Peripheral vasodilator'),
      'Lessen resistance within the peripheral blood vessels, increasing the total volume of the system and lowering pressure within it.', 30),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'Help reduce the buildup of excess fluid in the body and overcome any decreased renal blood flow that might accompany the hypertension.', 40),
    (v_disorder_id, herbal.ensure_action('Vascular tonic'),
      'Help nourish and tone the tissue of the arteries and veins.', 50),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'Address the tension and anxiety associated with any stress component in the patient''s picture. Hypertension itself causes increased tension that can be eased with appropriate nervines.', 60),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'Help ease peripheral resistance to blood flow by gently relaxing the muscular coat of the vessels and the muscles the vessels pass through.', 70),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'Help increase peripheral circulation.', 80)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),
      'The most important hypotensive plant remedy in Western medicine.', 10),
    (v_disorder_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),
      'Probably the second most important hypotensive plant remedy in Western medicine. Especially indicated when anxiety and tension are part of the spectrum.', 20),
    (v_disorder_id, herbal.ensure_herb('Viscum album', 'mistletoe'),
      'A well-known plant that may be considered specific for hypertension.', 30),
    (v_disorder_id, herbal.ensure_herb('Olea europaea', 'olive'),
      'Another well-known plant that may be considered specific for hypertension.', 40),
    (v_disorder_id, herbal.ensure_herb('Stachys betonica', 'wood betony'),
      'If headaches are part of the picture, include this as part of the prescription.', 50),
    (v_disorder_id, herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),
      'If there are associated heart palpitations, add this herb.', 60)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Basic Hypertension
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Hypertension with Major Stress Component
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with a Major Stress Component',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),                    '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),                  '1 part',  20),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),                '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Eleutherococcus senticosus', 'Siberian ginseng'),'1 part',  40),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),           '1 part',  50),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),                 '1 part',  60),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis', 'valerian'),             '1 part',  70);
  END IF;

  -- Prescription 3: Hypertension with Associated Headache
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with Associated Headache',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),      '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Stachys betonica', 'wood betony'), '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),    '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),  '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),   '1 part',  50);
  END IF;

  -- Prescription 4: Hypertension with Palpitations
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with Palpitations',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),  '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),       '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),     '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),   '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),    '1 part',  50);
  END IF;

  -- Prescription 5: Hypertension with Debility
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with Debility',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      50)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),      '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),    '1 part',  20),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),  '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),   '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Artemisia vulgaris', 'mugwort'),   '1 part',  50);
  END IF;

  -- Prescription 6: Hypertension with Indigestion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with Indigestion',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      60)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),        '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Matricaria recutita', 'chamomile'),  '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),      '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),    '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),     '1 part',  50),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis', 'valerian'), '1 part',  60);
  END IF;

  -- Prescription 7: Hypertension with Bronchitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with Bronchitis',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      70)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),      '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),    '1 part',  20),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),  '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Marrubium vulgare', 'horehound'),  '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),   '1 part',  50),
      (v_rx_id, herbal.ensure_herb('Verbascum thapsus', 'mullein'),    '1 part',  60);
  END IF;

  -- Prescription 8: Hypertension with Premenstrual Syndrome
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hypertension with Premenstrual Syndrome',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      80)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),         '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),       '1 part',  20),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),     '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),'1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),      '1 part',  50),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis', 'valerian'),  '1 part',  60),
      (v_rx_id, herbal.ensure_herb('Vitex agnus-castus', 'chaste tree'),  '1 part',  70);
  END IF;

END $$;


-- ============================================================
-- BLOCK 4: Disorder — Arteriosclerosis
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Arteriosclerosis', v_cv_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Arteriosclerosis' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The most familiar form of arteriosclerosis is atherosclerosis, characterized by fatty deposits on the inner lining of the arteries. These arterial plaques lead to loss of arterial elasticity and narrowing of the artery.', 10),
    (v_disorder_id, 'Atherosclerosis tends to target the aorta as well as the arteries leading to the brain, lower limbs, and kidneys. Overwhelming evidence links it closely to diet and lifestyle, suggesting it can be prevented, slowed, or in some cases reversed.', 20),
    (v_disorder_id, 'Hypertension is a critical factor in the atherosclerotic process. People with high LDL cholesterol are at risk, though many with high cholesterol do not develop atherosclerosis and many with atherosclerosis have normal cholesterol levels.', 30),
    (v_disorder_id, 'Herbalism aims to prevent the disease by addressing causative factors: hypertension, diabetes mellitus, smoking, diet, and obesity. The cardiovascular system should be the focus of tonic attention.', 40)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Cardiotonic'),
      'Help support the tissue of the cardiovascular system, possibly maintaining flexibility and tone in affected vessels.', 10),
    (v_disorder_id, herbal.ensure_action('Vascular tonic'),
      'Help support the tissue of the cardiovascular system, possibly maintaining flexibility and tone in affected vessels.', 20),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'Promote the circulation of blood and oxygen availability in the face of increased vascular resistance characteristic of this condition.', 30),
    (v_disorder_id, herbal.ensure_action('Peripheral vasodilator'),
      'Have obvious value, because they have the potential to lessen the impact of vessel blockage.', 40),
    (v_disorder_id, herbal.ensure_action('Hypotensive'),
      'Indicated to help lower elevated blood pressure.', 50),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'Indicated if stress is an issue.', 60),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'Help relax the muscular coat of the arteries, as well as the muscles that the peripheral vessels pass through.', 70)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Atherosclerosis',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))      ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))            ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))      ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))          ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Peripheral vasodilator')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypotensive'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))  ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiotonic'))          ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Peripheral vasodilator')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))        ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 5: Disorder — Congestive Heart Failure
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Congestive Heart Failure', v_cv_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Congestive Heart Failure' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Congestive heart failure (CHF) is a severe condition in which the heart cannot supply the body with enough blood because it is functioning inadequately as a pump. The condition generally develops slowly as the heart gradually loses its ability to pump efficiently.', 10),
    (v_disorder_id, 'Shortness of breath is often the most prominent symptom, resulting from fluid buildup in the lungs. Fatigue, edema (swelling of feet, ankles, legs), and persistent coughing are other common symptoms.', 20),
    (v_disorder_id, 'The heart compensates through enlargement, thickening of muscle fibers, and more frequent contractions. Eventually it cannot offset its lost pumping ability, and the signs of heart failure appear.', 30),
    (v_disorder_id, 'While herbs containing cardiac glycosides form the basis of important pharmaceutical drugs for CHF, herbal treatment focuses on cardiotonics, peripheral vasodilators, hypotensives, diuretics, and nervines.', 40)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Cardioactive'),
      'Drugs are often the core of treatment. Cardiac glycosides must be prescribed by skilled diagnosticians with regular monitoring of blood levels.', 10),
    (v_disorder_id, herbal.ensure_action('Cardiotonic'),
      'Will support the action of cardiac glycosides prescribed. As they may potentiate cardioactives, blood monitoring is still needed.', 20),
    (v_disorder_id, herbal.ensure_action('Peripheral vasodilator'),
      'May be indicated to help with general blood circulation.', 30),
    (v_disorder_id, herbal.ensure_action('Hypotensive'),
      'Often appropriate because of associated hypertension.', 40),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'Ease water-retention problems. Replacement of flushed-out potassium is essential.', 50),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'Will ease stress, whether causal or a result of the heart disease.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),
      'A primary cardiotonic specific for supporting the heart in congestive heart failure.', 10),
    (v_disorder_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),
      'Supports the cardiovascular system and addresses associated anxiety and tension.', 20),
    (v_disorder_id, herbal.ensure_herb('Allium sativum', 'garlic'),
      'Supports overall cardiovascular health and helps address associated hypertension.', 30),
    (v_disorder_id, herbal.ensure_herb('Coleus forskohlii', 'coleus'),
      'Coleus forskohlii and its diterpene constituent forskolin can lower blood pressure while improving the contractility of the heart.', 40)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Mild Congestive Heart Failure',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),         '3 parts', 10),
      (v_rx_id, herbal.ensure_herb('Ginkgo biloba', 'ginkgo'),            '1 part',  20),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),       '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Taraxacum officinale', 'dandelion'),  '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),      '1 part',  50),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis', 'valerian'),  '1 part',  60);
  END IF;

END $$;


-- ============================================================
-- BLOCK 6: Disorder — Angina Pectoris
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Angina Pectoris', v_cv_id, 50)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Angina Pectoris' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Angina pectoris is a recurring pain or discomfort in the chest indicating that the heart is not getting enough oxygen. The main underlying cause is coronary artery disease stemming from atherosclerosis.', 10),
    (v_disorder_id, 'Episodes occur when the heart''s need for oxygen exceeds its availability from the blood. Physical exertion is the most common trigger.', 20),
    (v_disorder_id, 'An angina attack is not a heart attack. While the pain is similar, it usually lasts no more than five minutes and does not mean the heart muscle is suffering irreversible damage.', 30)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),
      'Studies show Crataegus may inhibit the progression of atherosclerosis, increase coronary perfusion, and confer mild hypotensive effects.', 10),
    (v_disorder_id, herbal.ensure_herb('Salvia miltiorrhiza', 'dan shen'),
      'Used in traditional Chinese medicine as a circulatory stimulant, sedative, and cooling agent. It has been shown to dilate coronary arteries and has a protective action against myocardial ischemia.', 20)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Angina',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day. In addition, the patient can take 5 ml of Crataegus tincture at the first sign of an angina attack. This will not replace the use of prescription medication.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),       '3 parts', 10),
      (v_rx_id, herbal.ensure_herb('Leonurus cardiaca', 'motherwort'),   '2 parts', 20),
      (v_rx_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),    '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Tilia platyphyllos', 'linden'),      '1 part',  40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),     '1 part',  50),
      (v_rx_id, herbal.ensure_herb('Ginkgo biloba', 'ginkgo'),           '1 part',  60);
  END IF;

END $$;


-- ============================================================
-- BLOCK 7: Disorder — Peripheral Arterial Occlusive Disease
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Peripheral Arterial Occlusive Disease', v_cv_id, 60)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Peripheral Arterial Occlusive Disease' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Peripheral arterial occlusive disease, also known as intermittent claudication, is a peripheral vascular disease caused by narrowing of the arteries in the legs.', 10),
    (v_disorder_id, 'Because of the limited blood supply, muscles do not receive the oxygen they need, resulting in the buildup of lactic acid.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Cardiotonic'),
      'The pathology that manifests in the legs suggests that disease processes are almost certainly affecting the whole cardiovascular system.', 10),
    (v_disorder_id, herbal.ensure_action('Peripheral vasodilator'),
      'Facilitate blood flow to the extremities.', 20),
    (v_disorder_id, herbal.ensure_action('Hypotensive'),
      'May help, as there is a close connection between hypertension and the development of this condition.', 30),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'May be appropriate if edema is present; however, edema calls for careful examination of the heart.', 40),
    (v_disorder_id, herbal.ensure_action('Vascular tonic'),
      'Essential to tone and strengthen the blood vessels.', 50),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'May be indicated depending upon the individual''s needs.', 60),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'May help ease the degree of muscular spasm.', 70)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),
      'Crataegus, Aesculus, and Ginkgo may all be considered specifics for this problem.', 10),
    (v_disorder_id, herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut'),
      'Has been the subject of numerous clinical studies on the treatment of this condition. A meta-analysis concluded the herb was efficacious and safe.', 20),
    (v_disorder_id, herbal.ensure_herb('Ginkgo biloba', 'ginkgo'),
      'Useful for treating peripheral vascular disease including diabetic retinopathy and intermittent claudication. Flavonoids reduce capillary permeability and fragility; terpene ginkgolides inhibit platelet-activating factor and decrease vascular resistance.', 30)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Peripheral Arterial Disease',
      'Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Crataegus spp.', 'hawthorn'),             '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut'),'1 part', 20),
      (v_rx_id, herbal.ensure_herb('Ginkgo biloba', 'ginkgo'),                 '1 part', 30),
      (v_rx_id, herbal.ensure_herb('Zanthoxylum americanum', 'prickly ash'),   '1 part', 40),
      (v_rx_id, herbal.ensure_herb('Viburnum opulus', 'cramp bark'),           '1 part', 50);
  END IF;

END $$;


-- ============================================================
-- BLOCK 8: Disorder — Varicose Veins
-- ============================================================
DO $$
DECLARE
  v_cv_id       INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Varicose Veins', v_cv_id, 70)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Varicose Veins' AND body_system_id = v_cv_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The core problem is valve incompetency in the veins of the legs, which leads to dilation of the veins, loss of tissue tone, and some degree of reversal of blood flow.', 10),
    (v_disorder_id, 'When vein efficiency declines, blood may stagnate, causing the veins to become swollen and tortuous (twisted), resulting in aching and abnormal fatigue in the legs.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Vascular tonic'),
      'Help the tissues regain tone and strength. Flavonoid-rich herbs are especially useful here, although they do not work quickly.', 10),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'Assist in the process of venous return to the trunk of the body.', 20),
    (v_disorder_id, herbal.ensure_action('Astringent'),
      'Can support the work of the vascular tonics. The astringency is best applied externally.', 30),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'Ease localized inflammation and discomfort.', 40),
    (v_disorder_id, herbal.ensure_action('Emollient'),
      'Used externally, lessen local discomfort.', 50),
    (v_disorder_id, herbal.ensure_action('Demulcent'),
      'Used externally, lessen local discomfort.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut'),
      'Traditionally in Europe considered an effective specific. The seeds have long been used to treat venous disorders, including varicose veins.', 10)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Internal
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Varicose Veins',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Zanthoxylum americanum', 'prickly ash');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Circulatory stimulant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Circulatory stimulant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vascular tonic'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: External Lotion
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Varicose Veins Lotion for External Use',
      'Apply liberally as needed to ease irritation and discomfort. Rose water or another floral water may be added to make the lotion more cosmetically pleasing.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Hamamelis virginiana', 'witch hazel');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, 'distilled, 80 ml', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, 'tincture, 10 ml', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Symphytum officinale', 'comfrey');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, 'tincture, 10 ml', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Emollient'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary'))  ON CONFLICT DO NOTHING;
  END IF;

END $$;


-- ============================================================
-- BLOCK 9: Sync herb_primary_actions from disorder data
-- ============================================================
DO $$
DECLARE
  v_cv_id INTEGER;
BEGIN
  SELECT id INTO v_cv_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT dah.herb_id, dah.primary_action_id, v_cv_id
  FROM herbal.disorder_action_herbs dah
  JOIN herbal.disorders d ON d.id = dah.disorder_id
  WHERE d.body_system_id = v_cv_id
  ON CONFLICT DO NOTHING;

END $$;
