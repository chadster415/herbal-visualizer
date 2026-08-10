-- Migration 150: Endocrine System
-- Body system: Endocrine
-- 6 body-system notes, 4 disorders:
-- Hypothyroidism, Hyperthyroidism, Diabetes Mellitus, Adrenal Disorders

SET search_path TO herbal, public;


-- ============================================================
-- BLOCK 0: Ensure Endocrine body system exists
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.body_systems (name)
    VALUES ('Endocrine')
    ON CONFLICT (name) DO NOTHING;
END $$;


-- ============================================================
-- BLOCK 1: Body System Notes (6 notes from # Notes section)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Endocrine';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'When used skillfully within the context of an appropriate holistic approach, herbs can make a major contribution to treatment of endocrine disorders. However, the results achieved with herbs may not adequately replace drug treatment.', 10),
    (v_id, 'The endocrine system influences cellular metabolism by means of hormones. Endocrine glands, also known as ductless glands, release hormones into the blood or lymph.', 20),
    (v_id, 'The endocrine glands include the pituitary, thyroid, parathyroid, adrenal, pineal, and thymus glands.', 30),
    (v_id, 'Additionally, several non-endocrine organs contain areas of endocrine tissue that produce hormones. Such organs include the pancreas and the gonads. The hypothalamus, a part of the nervous system, produces and releases hormones, so is considered a neuroendocrine organ.', 40),
    (v_id, 'The thyroid gland is a butterfly-shaped organ located at the base of the neck, just above the collarbone. The main function of this gland is the production of thyroxine, an iodine-containing hormone. Thyroxine controls the rate and intensity of most physiologic functions.', 50),
    (v_id, 'The pituitary gland, located at the base of the front of the brain, controls the thyroid itself. The pituitary releases thyroid-stimulating hormone (TSH), required by the thyroid to produce thyroxine. In turn, production of pituitary TSH depends upon the presence of thyrotropin-releasing hormone, which comes from the hypothalamus.', 60)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Endocrine system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 2: Primary Actions (from ## Action Herbs sections across disorders)
-- ============================================================
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Endocrine';

  -- Vascular tonic (Diabetes Mellitus)
  v_action_id := herbal.ensure_action('Vascular tonic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Crataegus spp.',     'hawthorn',  'berry'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Ginkgo biloba',      'ginkgo'),             v_action_id, v_sys_id),
    (herbal.ensure_herb('Vaccinium myrtillus','bilberry'),           v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Adaptogen (Adrenal Disorders)
  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Panax spp.',                   'ginseng'),          v_action_id, v_sys_id),
    (herbal.ensure_herb('Eleutherococcus senticosus',   'Siberian ginseng'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Withania somnifera',            'ashwagandha'),      v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Nervine tonic (Adrenal Disorders)
  v_action_id := herbal.ensure_action('Nervine tonic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),          v_action_id, v_sys_id),
    (herbal.ensure_herb('Hypericum perforatum',    'St. John''s wort'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Avena sativa',            'oat', 'milky oats'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Endocrine primary actions inserted.';
END $$;


-- ============================================================
-- BLOCK 3: Disorder — Hypothyroidism
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Endocrine';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Hypothyroidism', v_sys_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Hypothyroidism' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Inadequate secretion of thyroid hormone leads to a general slowing of all physical and mental processes. The condition is characterized by an overall depression of most cellular enzyme systems and oxidative processes.', 10),
    (v_disorder_id, 'Fatigue, lack of energy, cold intolerance, severe constipation, heavy menstrual periods, and weight gain despite a diminishing appetite may go unnoticed or be attributed to other conditions, such as stress, depression, and overwork.', 20)
  ON CONFLICT DO NOTHING;

  -- Specific Remedies
  -- Group 1: Fucus vesiculosus (specific for iodine deficiency)
  -- Group 2: Cardiovascular tonics (Crataegus, Ginkgo, Allium)
  -- Group 3: Hepatic laxatives for constipation (Rumex, Juglans, Rhamnus, Senna)
  -- Group 4: Antidepressant nervines (Hypericum, Artemisia)
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Fucus vesiculosus',  'bladderwrack'),
      'Orthodox therapy for hypothyroidism is based upon daily thyroid hormone replacement therapy. As no herbs adequately fulfill this action, drug therapy will often remain the basis of treatment, and the role of phytotherapy will be to help the body deal with the repercussions of the condition and its treatment. In mild cases, the use of bitters may sometimes be enough, but it will be beneficial in all cases. Other than bitters, the seaweed Fucus vesiculosus (bladderwrack) has been traditionally used to treat this condition. While it has much to offer, it is only truly specific when the patient has an iodine deficiency.', 10),
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.',     'hawthorn', 'berry'),
      'Hypothyroidism accelerates the development of atherosclerosis, due to deposition of mucopolysaccharides in the heart muscle, placing patients at higher risk of coronary artery disease. This damage may be lessened through the use of cardiovascular tonics.', 20),
    (v_disorder_id, herbal.ensure_herb('Ginkgo biloba',      'ginkgo'),
      'Hypothyroidism accelerates the development of atherosclerosis, due to deposition of mucopolysaccharides in the heart muscle, placing patients at higher risk of coronary artery disease. This damage may be lessened through the use of cardiovascular tonics.', 30),
    (v_disorder_id, herbal.ensure_herb('Allium sativum',     'garlic'),
      'Hypothyroidism accelerates the development of atherosclerosis, due to deposition of mucopolysaccharides in the heart muscle, placing patients at higher risk of coronary artery disease. This damage may be lessened through the use of cardiovascular tonics.', 40),
    (v_disorder_id, herbal.ensure_herb('Rumex crispus',      'yellow dock'),
      'For chronic constipation, hepatic laxatives are the best choice, as they also support liver function. Examples of herbs that may be helpful include Rumex crispus (yellow dock) and Juglans cinerea (butternut). In extreme cases, anthraquinone-containing herbs, such as Rhamnus purshiana (cascara sagrada) and Senna alexandrina, may be required.', 50),
    (v_disorder_id, herbal.ensure_herb('Juglans cinerea',    'butternut'),
      'For chronic constipation, hepatic laxatives are the best choice, as they also support liver function. Examples of herbs that may be helpful include Rumex crispus (yellow dock) and Juglans cinerea (butternut). In extreme cases, anthraquinone-containing herbs, such as Rhamnus purshiana (cascara sagrada) and Senna alexandrina, may be required.', 60),
    (v_disorder_id, herbal.ensure_herb('Rhamnus purshiana',  'cascara sagrada'),
      'For chronic constipation, hepatic laxatives are the best choice, as they also support liver function. Examples of herbs that may be helpful include Rumex crispus (yellow dock) and Juglans cinerea (butternut). In extreme cases, anthraquinone-containing herbs, such as Rhamnus purshiana (cascara sagrada) and Senna alexandrina, may be required.', 70),
    (v_disorder_id, herbal.ensure_herb('Senna alexandrina',  'senna'),
      'For chronic constipation, hepatic laxatives are the best choice, as they also support liver function. Examples of herbs that may be helpful include Rumex crispus (yellow dock) and Juglans cinerea (butternut). In extreme cases, anthraquinone-containing herbs, such as Rhamnus purshiana (cascara sagrada) and Senna alexandrina, may be required.', 80),
    (v_disorder_id, herbal.ensure_herb('Hypericum perforatum','St. John''s wort'),
      'Nervine tonics and other nervines may be indicated, but avoid the stronger relaxing remedies, such as Humulus lupulus (hops) and Valeriana officinalis (valerian). This is because they may have too sedating an effect on body function. Antidepressant herbs like Hypericum perforatum (St. John''s wort) and Artemisia vulgaris (mugwort) can be helpful.', 90),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris',  'mugwort'),
      'Nervine tonics and other nervines may be indicated, but avoid the stronger relaxing remedies, such as Humulus lupulus (hops) and Valeriana officinalis (valerian). This is because they may have too sedating an effect on body function. Antidepressant herbs like Hypericum perforatum (St. John''s wort) and Artemisia vulgaris (mugwort) can be helpful.', 100)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  RAISE NOTICE 'Endocrine: Hypothyroidism disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 4: Disorder — Hyperthyroidism
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Endocrine';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Hyperthyroidism', v_sys_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Hyperthyroidism' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Symptoms: Nervousness, hyperexcitement, irritability, apprehension, sleeplessness - Difficulty sitting quietly - Rapid pulse at rest and upon exertion; heart palpitations - Low heat tolerance, profuse perspiration, flushed skin (e.g., warm, moist hands) - Fine tremor of hands, changes in bowel habits (constipation or diarrhea) - Increased appetite and progressive weight loss - Muscle fatigue and weakness - Amenorrhea - Bulging eyes (exophthalmos), producing a startled expression', 10),
    (v_disorder_id, 'Treatment: control of the underlying cause of the symptoms — excessive production of thyroid hormones — is challenging. Used as symptomatic relief, however, herbs can support the work of prescription medications.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'will ease agitation and anxiety. In this case, specific relaxing nervines are indicated (Lycopus virginicus or L. europaeus, discussed under Specific Remedies).', 10),
    (v_disorder_id, herbal.ensure_action('Cardiovascular tonic'),
      'are indicated, to help the heart function healthily in the face of the hormone-stimulated workload.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Lycopus virginicus', 'bugleweed'),
      'Traditional herbal treatment for hyperthyroidism provides us with one of the best examples of a condition for which a definite specific exists. This is Lycopus virginicus or L. europaeus, commonly known as bugleweed. The herb is a useful relaxing nervine, but in addition has a sometimes dramatic effect in improving the symptom picture associated with hyperthyroid conditions. I have seen no data on changes in thyroxine serum levels in patients using Lycopus, and thus cannot say that the improvement is related to any direct impact of the herb on hormone levels. Nonetheless, it does seem to help.', 10)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: A Prescription for Hyperthyroidism
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hyperthyroidism',
      'Dosage: up to 5 ml of tincture three times a day',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Lycopus spp.', 'bugleweed');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
      VALUES (v_rx_id, v_herb_id, '4 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
      VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Scutellaria spp.', 'skullcap');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
      VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic'))       ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant'))    ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn', 'berry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
      VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Cardiovascular tonic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: A Prescription for Insomnia Associated with Hyperthyroidism
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Insomnia Associated with Hyperthyroidism',
      'Dosage: 5 to 15 ml of tincture a half hour before retiring',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
      VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Passiflora incarnata', 'passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
      VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs
      WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Endocrine: Hyperthyroidism disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 5: Disorder — Diabetes Mellitus
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_action_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Endocrine';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Diabetes Mellitus', v_sys_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Diabetes Mellitus' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Diabetes mellitus, characterized by glycosuria (glucose in the urine) and hyperglycemia (elevated blood sugar levels), is an unfortunately common, chronic metabolic disorder involving carbohydrate, fat, and protein metabolism.', 10),
    (v_disorder_id, 'Metabolic changes in diabetes alter the way in which the body handles fats, including cholesterol. This leads to their accumulation in the small arteries of the body, often those of the eyes, kidneys, heart, and brain. Thus, people with diabetes have an increased incidence of blindness, kidney failure, heart attack, and stroke.', 20),
    (v_disorder_id, 'Insulin-dependent or Type I diabetes is often called juvenile onset diabetes, since it usually first presents in childhood or young adulthood.', 30),
    (v_disorder_id, 'Type I diabetes is treated with insulin and diet; there is no role for oral hypoglycemics.', 40),
    (v_disorder_id, 'Non-insulin-dependent or Type II diabetes usually occurs in elderly or overweight people, and is thus also called maturity onset diabetes. Non-insulin-dependent diabetes may be secondary to other diseases, such as pancreatitis.', 50),
    (v_disorder_id, 'In NIDDM, the aim of treatment is to regularize blood sugar levels through the use of hypoglycemics, glucosidase inhibitors, sugar-restricted diets, and complex carbohydrate preparations that delay the absorption of glucose from the gut.', 60),
    (v_disorder_id, 'Symptoms of either type of diabetes include fatigue, increased appetite (if enough blood sugar is lost to the urine), and increased urination, as the sugar causes the kidney to produce higher volumes to dissolve the excess load. Because of the accelerated loss of body fluid, the patient experiences greater thirst. As levels of blood sugar rise and ketosis occurs, body fluids become acidic. One of the body''s defenses against acidity is to decrease the amount of carbon dioxide in the blood, which leads to an increase in the rate and depth of respiration. Complications due to arterial blockage are common, including vision loss, heart problems, kidney damage, and peripheral neuropathy. Such problems usually develop over many years.', 70),
    (v_disorder_id, 'Such remedies can sometimes have a rapid impact on blood sugar levels, very close observation of glucose levels in urine and blood is required.', 80)
  ON CONFLICT DO NOTHING;

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Vascular tonic'),
      'Herbal preventive work to avoid long-term complications of diabetes may be undertaken quite safely, even if no attempt is made to alter insulin levels. Particular attention should be given to the cardiovascular system. Heart and vascular tonics are appropriate for long-term use, especially Crataegus spp., Ginkgo biloba, and Vaccinium myrtillus.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Action Herbs
  v_action_id := herbal.ensure_action('Vascular tonic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id) VALUES
    (v_disorder_id, herbal.ensure_herb('Crataegus spp.',     'hawthorn',  'berry'), v_action_id),
    (v_disorder_id, herbal.ensure_herb('Ginkgo biloba',      'ginkgo'),             v_action_id),
    (v_disorder_id, herbal.ensure_herb('Vaccinium myrtillus','bilberry'),           v_action_id)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Specific Remedies
  -- Group 1: Hypoglycemic herbs from the European tradition
  -- Group 2: Plants with hypoglycemic activity in animal studies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Allium sativum',             'garlic'),
      'Hypoglycemic herb from the European tradition', 10),
    (v_disorder_id, herbal.ensure_herb('Galega officinalis',         'goat''s rue'),
      'Hypoglycemic herb from the European tradition', 20),
    (v_disorder_id, herbal.ensure_herb('Morus alba',                 'mulberry leaf'),
      'Hypoglycemic herb from the European tradition', 30),
    (v_disorder_id, herbal.ensure_herb('Olea europaea',              'olive leaf'),
      'Hypoglycemic herb from the European tradition', 40),
    (v_disorder_id, herbal.ensure_herb('Vaccinium myrtillus',        'bilberry'),
      'Hypoglycemic herb from the European tradition', 50),
    (v_disorder_id, herbal.ensure_herb('Anacardium occidentale',     'cashew'),
      'Plant with hypoglycemic activity in animal studies', 60),
    (v_disorder_id, herbal.ensure_herb('Apium graveolens',           'celery seed'),
      'Plant with hypoglycemic activity in animal studies', 70),
    (v_disorder_id, herbal.ensure_herb('Arctium lappa',              'burdock'),
      'Plant with hypoglycemic activity in animal studies', 80),
    (v_disorder_id, herbal.ensure_herb('Avena sativa',               'oat', 'milky oats'),
      'Plant with hypoglycemic activity in animal studies', 90),
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum',            'cayenne'),
      'Plant with hypoglycemic activity in animal studies', 100),
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',        'black cohosh'),
      'Plant with hypoglycemic activity in animal studies', 110),
    (v_disorder_id, herbal.ensure_herb('Eupatorium purpureum',       'gravel root'),
      'Plant with hypoglycemic activity in animal studies', 120),
    (v_disorder_id, herbal.ensure_herb('Euphorbia pilulifera',       'pill-bearing spurge'),
      'Plant with hypoglycemic activity in animal studies', 130),
    (v_disorder_id, herbal.ensure_herb('Hydrastis canadensis',       'goldenseal'),
      'Plant with hypoglycemic activity in animal studies', 140),
    (v_disorder_id, herbal.ensure_herb('Lophophora williamsii',      'peyote'),
      'Plant with hypoglycemic activity in animal studies', 150),
    (v_disorder_id, herbal.ensure_herb('Panax spp.',                 'ginseng'),
      'Plant with hypoglycemic activity in animal studies', 160),
    (v_disorder_id, herbal.ensure_herb('Spinacia oleracea',          'spinach'),
      'Plant with hypoglycemic activity in animal studies', 170),
    (v_disorder_id, herbal.ensure_herb('Taraxacum officinale',       'dandelion', 'root'),
      'Plant with hypoglycemic activity in animal studies', 180),
    (v_disorder_id, herbal.ensure_herb('Trigonella foenum-graecum',  'fenugreek'),
      'Plant with hypoglycemic activity in animal studies', 190)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  RAISE NOTICE 'Endocrine: Diabetes Mellitus disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 6: Disorder — Adrenal Disorders
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_action_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Endocrine';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Adrenal Disorders', v_sys_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Adrenal Disorders' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The adrenal cortex is responsible for production of glucocorticoids, such as cortisol and hydrocortisone, which help regulate metabolism, the immune system, certain aspects of behavior, and many other processes. The cortex also secretes mineralocorticoids, such as aldosterone and desoxycorticosterone. Aldosterone is fundamental to the homeostatic control of sodium and potassium secretion by the kidney. These hormones are synthesized from cholesterol.', 10),
    (v_disorder_id, 'The immediate stress response is controlled mainly, although not completely, by the medulla, while long-term stress responses are handled by the surrounding cortex.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Adaptogen'),
      'constitute the core of herbal support for conditions affecting the adrenal medulla. Saponins such as the eleutherosides found in Eleutherococcus senticosus (Siberian ginseng), directly impact this part of the adrenal gland. Adaptogens will also help support the cortex in its response to adrenocorticotropic hormone (ACTH).', 10),
    (v_disorder_id, herbal.ensure_action('Nervine tonic'),
      'support of some kind is usually indicated as well. Although nervines will not directly affect the medulla, they will provide general systemic support to help ease the impact of tension and anxiety.', 20),
    (v_disorder_id, herbal.ensure_action('Bitter tonic'),
      'can be helpful as well.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Action Herbs
  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id) VALUES
    (v_disorder_id, herbal.ensure_herb('Panax spp.',                 'ginseng'),          v_action_id),
    (v_disorder_id, herbal.ensure_herb('Eleutherococcus senticosus', 'Siberian ginseng'), v_action_id),
    (v_disorder_id, herbal.ensure_herb('Withania somnifera',         'ashwagandha'),      v_action_id)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Nervine tonic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id) VALUES
    (v_disorder_id, herbal.ensure_herb('Scutellaria lateriflora', 'skullcap'),          v_action_id),
    (v_disorder_id, herbal.ensure_herb('Hypericum perforatum',    'St. John''s wort'),  v_action_id),
    (v_disorder_id, herbal.ensure_herb('Avena sativa',            'oat', 'milky oats'), v_action_id)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',  'wild yam'),
      'The direct effects of plants rich in saponins are most important.', 10),
    (v_disorder_id, herbal.ensure_herb('Glycyrrhiza glabra', 'licorice'),
      'The direct effects of plants rich in saponins are most important. Glycyrrhiza is contraindicated for hypertensive patients.', 20)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  RAISE NOTICE 'Endocrine: Adrenal Disorders disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 7: Sync — push prescription herb actions into herb_primary_actions
-- ============================================================
DO $$
DECLARE
  v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Endocrine';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Endocrine: herb_primary_actions synced from prescription data.';
END $$;
