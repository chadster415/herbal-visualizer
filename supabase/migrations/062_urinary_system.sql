-- Migration 062: Urinary System
-- Body system: Urinary
-- System notes from # Notes section, primary actions with herbs, 6 disorders
-- with notes, actions indicated, specific remedies, and prescriptions.

SET search_path TO herbal, public;


-- ============================================================
-- BLOCK 0: Ensure Urinary body system exists
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.body_systems (name)
    VALUES ('Urinary')
    ON CONFLICT (name) DO NOTHING;
END $$;


-- ============================================================
-- BLOCK 1: Body System Notes (17 notes from # Notes section)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Urinary';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'The maintenance of homeostasis is pivotal to any experience of wellness. With the variety of diuretics in our materia medica, the phytotherapist is uniquely endowed by nature with the means to support the complex physiology that maintains healthy kidneys and water balance in the body.', 10),
    (v_id, 'Because of their excretory function, the kidneys are also largely responsible for maintaining the water balance of the body and the pH of the blood.', 20),
    (v_id, 'The kidneys release the protein erythropoietin, which stimulates the bone marrow to increase the formation of red blood cells.', 30),
    (v_id, 'They also help to control blood pressure.', 40),
    (v_id, 'The production of urine is a complex and quite wonderful process. It is far from a simple removal of water from the body. Rather, it is a process of selective filtration that moves waste and potential toxins from the blood while retaining essential molecules.', 50),
    (v_id, 'Arterial blood pressure drives a filtrate of plasma across the porous capillary walls.', 60),
    (v_id, 'The filtered plasma, now called glomerular filtrate, is mainly water, but also contains salts, glucose, amino acids, nitrogenous wastes such as urea, and a small amount of ammonia.', 70),
    (v_id, 'In normal kidneys, 100 to 140 ml of filtrate is formed each minute, a total of about 170 liters per day. Only about 1% of the volume of the original filtrate is finally excreted as urine. The kidneys excrete 400 to 2,000 ml of urine or more per day.', 80),
    (v_id, 'This reabsorption process is highly selective. Water, sodium, and chloride ions, most of the bicarbonate, and all of the glucose are reabsorbed into the blood-stream, while other products, such as urea and ammonia, remain in the tubule.', 90),
    (v_id, 'The cells lining the tubules are under the influence of regulating factors, such as the hormone aldosterone (from the adrenal gland), antidiuretic hormone, parathyroid hormone, and atrial natriuretic factor (from the heart).', 100),
    (v_id, 'The distal tubule regulates the overall acidity of the urine, and ultimately of the blood, by excretion of hydrogen ions.', 110),
    (v_id, 'Much of the sodium ion in kidney filtrate is transported back to the blood, but 3 to 5 grams pass into the urine each day. As a result, most animals have strict salt requirements and must consume several grams of sodium chloride daily in order to live.', 120),
    (v_id, 'The retention of sodium is enhanced by the presence of aldosterone. This hormone is secreted into the bloodstream when the body''s supply of sodium falls below normal. When there is an excess of sodium, aldosterone secretion is reduced and more sodium is excreted.', 130),
    (v_id, 'When excessive amounts of fluid are lost from the body, or the blood pressure falls below normal, the kidneys release the enzyme renin into the blood, where it promotes the formation of angiotensin. Within minutes, angiotensin causes vasoconstriction, which increases blood pressure and stimulates the secretion of aldosterone.', 140),
    (v_id, 'In the urinary system, the emphasis is on nourishing the tissue and helping to support the normal functioning of the various organs and tissues involved. Thus, stronger diuretics are not emphasized.', 150),
    (v_id, 'Avoid too much protein in the diet, as it will tend to overload the kidneys.', 160),
    (v_id, 'Avoid dietary irritants, especially foods containing oxalic acid.', 170)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Urinary system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 2: Primary Actions for the Urinary System
-- ============================================================
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  -- Diuretic (central to this system; drawn from tonics and prescription actions)
  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Galium aparine',          'cleavers'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Elymus repens',            'couch grass'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Achillea millefolium',     'yarrow'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Taraxacum officinale',     'dandelion'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Zea mays',                 'corn silk'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctostaphylos uva-ursi',  'bearberry'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Agathosma betulina',        'buchu'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium purpureum',      'gravel root'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Collinsonia canadensis',    'stoneroot'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Juniperus communis',        'juniper berry'),v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Anti-inflammatory
  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium',     'yarrow'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Apium graveolens',         'celery seed'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctostaphylos uva-ursi',  'bearberry'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium purpureum',      'gravel root'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Galium aparine',            'cleavers'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Zea mays',                  'corn silk'),    v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Antilithic
  v_action_id := herbal.ensure_action('Antilithic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Collinsonia canadensis',  'stoneroot'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium purpureum',    'gravel root'),  v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium',    'yarrow'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Agathosma betulina',      'buchu'),         v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Elymus repens',           'couch grass'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Juniperus communis',      'juniper berry'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Matricaria recutita',    'chamomile'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Valeriana officinalis',  'valerian'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Viburnum opulus',        'cramp bark'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Dioscorea villosa',      'wild yam'),   v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Astringent
  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium',    'yarrow'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Agrimonia eupatoria',     'agrimony'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Equisetum arvense',       'horsetail'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Cola vera',               'kola nut'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Cytisus scoparius',       'scotch broom'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Cardioactive
  v_action_id := herbal.ensure_action('Cardioactive');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Convallaria majalis', 'lily of the valley'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Cytisus scoparius',   'scotch broom'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Lycopus spp.',        'bugleweed'),          v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Demulcent
  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Collinsonia canadensis',  'stoneroot'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Elymus repens',           'couch grass'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Zea mays',                'corn silk'),   v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium',    'yarrow'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium perfoliatum',  'boneset'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Sambucus nigra',          'elder'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Tilia platyphyllos',      'linden'),  v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Hypotensive
  v_action_id := herbal.ensure_action('Hypotensive');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium', 'yarrow'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Crataegus spp.',       'hawthorn'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Tilia platyphyllos',   'linden'),   v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Urinary system primary actions inserted.';
END $$;


-- ============================================================
-- BLOCK 3: Disorder — Frequency
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Frequency', v_sys_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Frequency' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'This common symptom indicates that the bladder cannot hold as much fluid as usual.', 10),
    (v_disorder_id, 'Infection, foreign bodies, stones, and tumors can all injure the tissue of the bladder wall and cause inflammation.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),
      'will help the body rid itself of any pathogens present, thus reducing inflammation and its resulting symptoms.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'soothe inflamed tissue and thus reduce the irritation of local muscle spasm.', 20),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'will often help, simply because they usually will also have either antimicrobial or anti-inflammatory effects. Diuretics rich in volatile oils, such as Juniperus communis (juniper berry), may be contraindicated in severe cases, as it can be irritating to the nephrons.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Zea mays', 'corn silk'),
      'A number of demulcent diuretic remedies work well. It is difficult to say whether they act primarily as anti-inflammatory agents to reduce inflammation or as demulcents that soothe the surface of the cells.', 10),
    (v_disorder_id, herbal.ensure_herb('Elymus repens', 'couch grass'),
      'A number of demulcent diuretic remedies work well. It is difficult to say whether they act primarily as anti-inflammatory agents to reduce inflammation or as demulcents that soothe the surface of the cells.', 20),
    (v_disorder_id, herbal.ensure_herb('Althaea officinalis', 'marshmallow'),
      'A number of demulcent diuretic remedies work well. It is difficult to say whether they act primarily as anti-inflammatory agents to reduce inflammation or as demulcents that soothe the surface of the cells.', 30)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Urinary Frequency Associated with Infection',
      'Infuse 2 teaspoons of dry herb mixture in 1 cup of boiling water; drink 1 cup every hour until symptoms subside.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))          ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))         ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Urinary: Frequency disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 4: Disorder — Dysuria
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Dysuria', v_sys_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Dysuria' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Painful urination.', 10)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'will usually help ease the pain by reducing inflammation.', 10),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'soothe muscle spasms that often accompany such urinary tract problems.', 20),
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),
      'help the body rid itself of any pathogens, further reducing inflammation and associated symptoms.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Dysuria',
      'Infuse 2 teaspoons of dried herb mixture in 1 cup of boiling water; drink 1 cup every hour until the symptoms subside.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))         ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Urinary: Dysuria disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 5: Disorder — Hematuria
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Hematuria', v_sys_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Hematuria' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Hematuria can give the urine a red or brown color.', 10),
    (v_disorder_id, 'The bleeding may occur at a site of physical trauma, such as where a kidney stone has cut the tissue, or from a focus of infection.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Astringent'),
      'will stanch bleeding. They may not always be powerful enough — for example, in cases of bleeding caused by large kidney stones.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'will soothe inflamed tissue, thus lessening bleeding.', 20),
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),
      'will help the body rid itself of any pathogens present, thus reducing inflammation and resultant bleeding.', 30),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'A number of diuretic plants have an astringent effect.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Vinca major',              'periwinkle'),
      'A number of diuretic plants have an astringent effect.', 10),
    (v_disorder_id, herbal.ensure_herb('Equisetum arvense',        'horsetail'),
      'A number of diuretic plants have an astringent effect.', 20),
    (v_disorder_id, herbal.ensure_herb('Alchemilla vulgaris',      'lady''s mantle'),
      'A number of diuretic plants have an astringent effect.', 30),
    (v_disorder_id, herbal.ensure_herb('Capsella bursa-pastoris',  'shepherd''s purse'),
      'A number of diuretic plants have an astringent effect.', 40)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Hematuria',
      'Infuse 2 teaspoons of dried herb mixture to 1 cup of boiling water; drink 1 cup every 2 hours.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Vinca major', 'periwinkle');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Capsella bursa-pastoris', 'shepherd''s purse');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent'))    ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Urinary: Hematuria disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 6: Disorder — Edema
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Edema', v_sys_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Edema' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'This accumulation may be associated with liver or kidney disturbances, pregnancy, premenstrual syndrome, or heart failure. Never treat water retention without addressing its causal factors.', 10)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'of course, the primary herbs to consider. The broader picture that the patient presents will suggest the appropriate treatment.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Taraxacum officinale', 'dandelion'),
      'Leaf. The diuretic effect of this herb is comparable to that of the drug furosemide. In dandelion leaf, however, we have one of the best natural sources of potassium. Dandelion leaf simultaneously replaces the potassium that is flushed from the body via its diuretic action.', 10)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Edema',
      '2.5 ml of tincture three times a day or 5 ml of tincture when needed, but not at night.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
      VALUES (v_rx_id, v_herb_id, '', 'leaf', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Urinary: Edema disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 7: Disorder — Cystitis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Cystitis', v_sys_id, 50)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Cystitis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Cystitis, or inflammation of the wall and lining of the urinary bladder, may be due to bacterial infection or to mechanical abrasion from microcrystals of calcium phosphate in urine.', 10),
    (v_disorder_id, 'These infections are usually caused by the rod-shaped bacterium called Escherichia coli, commonly known as E. coli.', 20),
    (v_disorder_id, 'Treatment: plants that are specifically active in the urinary tract. Thus, antimicrobials containing terpene essential oils are indicated. The essential oil is excreted from the body via the kidney, directing its action to the site of infection in the bladder.', 30)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antimicrobial'),
      'help the body control and then clear bacterial infection.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'soothe the pain and discomfort, but avoid overemphasizing them in the prescription. The symptomatic relief they produce must be applied in the context of removing the infection that causes the inflammation.', 20),
    (v_disorder_id, herbal.ensure_action('Astringent'),
      'may be indicated if there is any hematuria.', 30),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'help flush the whole of the tract. Of course, it is best to select diuretics that possess antimicrobial and anti-inflammatory actions.', 40),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'may be necessary if there is much pain.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),
      'In Wales, preferably harvested from sea cliffs, has a dramatic effect even in intransigent cases of cystitis. Unfortunately, tinctures or infusions made from the same plants after drying do not replicate the results achieved with fresh plant material. This is probably due to changes in the amount or relative composition of the volatile oils present.', 10),
    (v_disorder_id, herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry'),
      'Plants that contain antimicrobial volatile oils have most to offer.', 20),
    (v_disorder_id, herbal.ensure_herb('Agathosma betulina', 'buchu'),
      'Plants that contain antimicrobial volatile oils have most to offer.', 30),
    (v_disorder_id, herbal.ensure_herb('Vaccinium macrocarpon', 'cranberry'),
      'Juice has a strong traditional reputation for soothing symptoms of cystitis. It actually helps prevent the adherence of pathogenic bacteria to the lining of the urinary tract. Cranberry has been shown to inhibit the adherence of fimbriated E. coli to the mucosa. It now appears that a group of flavonoids in cranberry, called proanthocyanidins, are responsible for these anti-adhesion effects. Unsweetened cranberry juice is recommended.', 40)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: Basic Cystitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Cystitis',
      '5 ml of tincture three times a day. Infusion of Achillea millefolium (preferably fresh) should be drunk often.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Agathosma betulina', 'buchu');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Cystitis with Pain and Discomfort
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Cystitis with Pain and Discomfort',
      '5 ml of tincture three times a day. An infusion of Achillea millefolium (preferably fresh) should be drunk often.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Cystitis Infusion (Annie McIntyre)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Cystitis Infusion',
      'Hot infusions can ease symptoms dramatically. A combination recommended by British medical herbalist Annie McIntyre. Add 1 teaspoon of this mixture to 1 cup of boiling water and infuse for 10 to 15 minutes. Drink hot four to five times a day.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Althaea officinalis',     'marshmallow'), '2 parts', 'root', 10),
      (v_rx_id, herbal.ensure_herb('Zea mays',                'corn silk'),   '2 parts', NULL,   20),
      (v_rx_id, herbal.ensure_herb('Elymus repens',           'couch grass'), '2 parts', NULL,   30),
      (v_rx_id, herbal.ensure_herb('Equisetum arvense',       'horsetail'),   '2 parts', NULL,   40),
      (v_rx_id, herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry'),   '2 parts', NULL,   50),
      (v_rx_id, herbal.ensure_herb('Agathosma betulina',      'buchu'),       '1 part',  NULL,   60);
  END IF;

  RAISE NOTICE 'Urinary: Cystitis disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 8: Disorder — Urinary Calculus
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Urinary Calculus', v_sys_id, 60)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Urinary Calculus' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Low urine pH due to hereditary causes or bowel disease promotes uric acid stones. High pH related to alkali drugs or renal tubular acidosis increases calcium phosphate supersaturation.', 10),
    (v_disorder_id, 'For patients with calcium oxalate stones, avoid foods that contain oxalates, such as spinach, rhubarb, beets, parsley, sorrel, and chocolate. These patients should be advised to restrict intake of dairy products, which are rich in calcium. Mineral waters rich in magnesium will increase the solubility of calcium. Both vitamin B6 and folic acid are thought to restrict the amount of calcium formed in the body.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antilithic'),
      'remedies are the core of any treatment of renal calculus.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'indicated to lessen the inflammation caused by the passage of hard material along the delicate tissue of this system. Such remedies will decrease the pain and discomfort to some extent.', 20),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'are essential to help reduce muscular spasms along the urinary tract as peristalsis moves the stone. Unfortunately, legal plant antispasmodics are not strong enough to deal with acute problems of this nature.', 30),
    (v_disorder_id, herbal.ensure_action('Demulcent'),
      'will help, as they usually also act as anti-inflammatory agents in this system.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Hydrangea arborescens',  'hydrangea'),             'a long tradition of use as specific in Europe', 10),
    (v_disorder_id, herbal.ensure_herb('Aphanes arvensis',       'parsley piert'),          'a long tradition of use as specific in Europe', 20),
    (v_disorder_id, herbal.ensure_herb('Parietaria diffusa',     'pellitory-of-the-wall'),  'a long tradition of use as specific in Europe', 30),
    (v_disorder_id, herbal.ensure_herb('Elymus repens',          'couch grass'),            'a long tradition of use as specific in Europe', 40),
    (v_disorder_id, herbal.ensure_herb('Urtica dioica',          'nettle'),                 'a long tradition of use as specific in Europe', 50),
    (v_disorder_id, herbal.ensure_herb('Solidago virgaurea',     'goldenrod'),              'a long tradition of use as specific in Europe', 60),
    (v_disorder_id, herbal.ensure_herb('Eupatorium purpureum',   'gravel root'),            'North American plant', 70),
    (v_disorder_id, herbal.ensure_herb('Collinsonia canadensis', 'stoneroot'),              'North American plant', 80),
    (v_disorder_id, herbal.ensure_herb('Zea mays',               'corn silk'),              'North American plant', 90)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Kidney Stones',
      'Up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Collinsonia canadensis', 'stoneroot');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antilithic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))  ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Eupatorium purpureum', 'gravel root');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))   ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antilithic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Zea mays', 'corn silk');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Dioscorea villosa', 'wild yam');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Urinary: Urinary Calculus disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 9: Sync — push prescription herb actions into herb_primary_actions
-- ============================================================
DO $$
DECLARE
  v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Urinary: herb_primary_actions synced from prescription data.';
END $$;
