-- Migration 111: Supplement recommendations from Textbook of Natural Medicine (Pizzorno & Murray)
-- Extracted from disorder images: Acne, Angina Pectoris, Arteriosclerosis, Asthma,
-- Chronic Hepatitis, Cirrhosis, Congestive Heart Failure, Cystitis, Depression, Eczema,
-- Emphysema, Fibrocystic Breast Disease, Headache, Hypertension, Osteoporosis,
-- Periodontal Disease, Pregnancy (Morning Sickness, Stretch Marks), Prostatitis,
-- Psoriasis, Restless Legs Syndrome, Rheumatoid Arthritis, Shingles, The Common Cold,
-- Varicose Veins.
-- Osteoarthritis already done in migration 109.

SET search_path TO herbal, public;

-- ============================================================
-- BLOCK 0: New supplements not yet in the DB
-- All flagged for filling out with more detail.
-- ============================================================

DO $$
BEGIN
  INSERT INTO herbal.supplements (name, category, description, sort_order)
  VALUES
    ('Garlic',                   'Other',       'Antimicrobial and cardiovascular herb used therapeutically as a supplement (fresh garlic equivalent doses). Flagged for detail.',                       200),
    ('Brewer''s Yeast',          'Other',       'Nutrient-rich yeast supplement, source of B vitamins, chromium, and selenium. Flagged for detail.',                                                   210),
    ('Quercetin',                'Other',       'Bioflavonoid antioxidant; anti-inflammatory and mast-cell stabilizing properties. Flagged for detail.',                                               220),
    ('Beta-Carotene',            'Vitamin',     'Provitamin A (converts to Vitamin A in the body); fat-soluble antioxidant carotenoid. Flagged for detail.',                                          230),
    ('Evening Primrose Oil',     'Other',       'Rich source of GLA (gamma-linolenic acid); supports prostaglandin E1 synthesis. Flagged for detail.',                                                 240),
    ('DHEA',                     'Other',       'Dehydroepiandrosterone; adrenal hormone precursor with anti-inflammatory and immune-modulating effects. Flagged for detail.',                         250),
    ('Lysine',                   'Amino Acid',  'Essential amino acid; inhibits viral replication, particularly herpes simplex/zoster viruses. Flagged for detail.',                                   260),
    ('Lactobacillus acidophilus', 'Other',      'Probiotic bacterium; supports gut flora, immune function, and bile metabolism. Flagged for detail.',                                                  270),
    ('Choline',                  'Vitamin',     'B-vitamin-related phospholipid precursor; essential for liver function and methyl group metabolism. Flagged for detail.',                             280),
    ('Flaxseed Oil',             'Other',       'Rich source of ALA (alpha-linolenic acid, omega-3); anti-inflammatory fatty acid. Flagged for detail.',                                               290),
    ('Manganese',                'Mineral',     'Trace mineral; cofactor for superoxide dismutase and joint/connective tissue enzymes. Flagged for detail.',                                           300),
    ('Vitamin B Complex',        'Vitamin',     'Combined B vitamin formulation (B1, B2, B3, B5, B6, B7, B9, B12). Dose expressed as potency factor (e.g., B-50, B-100). Flagged for detail.',       310)
  ON CONFLICT (name) DO NOTHING;

  RAISE NOTICE 'Block 0 complete: new supplements inserted.';
END $$;


-- ============================================================
-- BLOCK 1: ACNE (disorder id 138)
-- Source: Acne 3.jpeg
-- Supplements are in the named Acne section (no other disorder header present).
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 138,
    'Supplements for Acne',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray recommend: Vitamin A 100,000 IU/day for three months; Vitamin E 400 IU/day; Vitamin C 1,000 mg/day; Zinc 50 mg/day as picolinate; Selenium 200 mcg/day; Brewer''s yeast 1 tablespoon twice a day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 138 AND title = 'Supplements for Acne'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 138 AND title = 'Supplements for Acne';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),       '100,000 IU/day', 'for three months',   10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),       '400 IU/day',     NULL,                 20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),       '1,000 mg/day',   NULL,                 30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),            '50 mg/day',      'as picolinate',      40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),        '200 mcg/day',    NULL,                 50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Brewer''s Yeast'), '1 tbsp twice/day', NULL,              60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 1 complete: Acne supplements.';
END $$;


-- ============================================================
-- BLOCK 2: ANGINA PECTORIS (disorder id 85)
-- Source: Angina Pectoris 2.jpeg
-- Supplements appear in the Angina Pectoris section; Peripheral Arterial
-- Occlusive Disease starts after the supplement list — ignored.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 85,
    'Supplements for Angina Pectoris',
    'In Textbook of Natural Medicine, Drs. Murray and Pizzorno recommend: Magnesium 200–400 mg three times a day; Coenzyme Q10 150–300 mg/day; Garlic the equivalent of 4,000 mg/day of fresh garlic.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 85 AND title = 'Supplements for Angina Pectoris'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 85 AND title = 'Supplements for Angina Pectoris';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),       '200 to 400 mg three times/day', NULL,                          10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'CoQ10 / Ubiquinol'), '150 to 300 mg/day',          NULL,                          20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Garlic'),          'equiv. 4,000 mg/day fresh',    NULL,                          30)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 2 complete: Angina Pectoris supplements.';
END $$;


-- ============================================================
-- BLOCK 3: ARTERIOSCLEROSIS (disorder id 83)
-- Source: Arteriosclerosis 3.jpeg (continuation from Arteriosclerosis 2)
-- Supplement list continues at top of page before Congestive Heart Failure starts.
-- NOTE: First item reads ambiguously but dose (800–1,200 mg/day) is consistent
-- with Magnesium, not selenium (800–1,200 mg selenium would be toxic).
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 83,
    'Supplements for Arteriosclerosis',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray recommend: Magnesium 800–1,200 mg/day; Vitamin C 500–1,000 mg three times a day; Vitamin E 400–800 IU/day; Coenzyme Q10 50 mg three times a day; Niacin 500 mg with meals (as inositol hexanicotinate); Garlic equivalent of 4,000 mg/day fresh.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 83 AND title = 'Supplements for Arteriosclerosis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 83 AND title = 'Supplements for Arteriosclerosis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),         '800 to 1,200 mg/day',         NULL,                              10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),         '500 to 1,000 mg three times/day', NULL,                          20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),         '400 to 800 IU/day',           NULL,                              30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'CoQ10 / Ubiquinol'), '50 mg three times/day',       NULL,                              40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B3 (Niacin)'), '500 mg with meals',         'as inositol hexanicotinate',      50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Garlic'),             'equiv. 4,000 mg/day fresh',  NULL,                              60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 3 complete: Arteriosclerosis supplements.';
END $$;


-- ============================================================
-- BLOCK 4: ASTHMA (disorder id 59)
-- Source: Asthma 4.jpeg + top of Emphysema 1.jpeg (continuation)
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 59,
    'Supplements for Asthma',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray recommend: Vitamin B6 25 mg twice a day; Vitamin B12 1,000 mcg/day; Vitamin C 1–2 g/day; Vitamin E 400 IU/day; Magnesium 200–300 mg three times a day; Quercetin 400 mg 20 minutes before meals; Beta-carotene 25,000–50,000 IU/day; Selenium 250 mcg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 59 AND title = 'Supplements for Asthma'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 59 AND title = 'Supplements for Asthma';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)'), '25 mg twice/day',             NULL,                        10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B12'),             '1,000 mcg/day',               NULL,                        20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),               '1 to 2 g/day',                NULL,                        30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),               '400 IU/day',                  NULL,                        40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),               '200 to 300 mg three times/day', NULL,                      50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Quercetin'),               '400 mg',                      '20 minutes before meals',   60),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Beta-Carotene'),           '25,000 to 50,000 IU/day',     NULL,                        70),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),                '250 mcg/day',                 NULL,                        80)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 4 complete: Asthma supplements.';
END $$;


-- ============================================================
-- BLOCK 5: CHRONIC HEPATITIS (disorder id 15)
-- Source: Chronic Hepatitis 2.jpeg
-- High-dose multivitamin and mineral supplementation section.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 15,
    'Supplements for Chronic Hepatitis',
    'High-dose multivitamin and mineral supplementation is recommended. Drs. Pizzorno and Murray recommend: Magnesium 200 mg/day; Zinc picolinate 50 mg/day; Vitamin A 100,000 IU/day; Vitamin E 200 IU/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 15 AND title = 'Supplements for Chronic Hepatitis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 15 AND title = 'Supplements for Chronic Hepatitis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),   '200 mg/day',      NULL,           10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),        '50 mg/day',       'picolinate',   20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),   '100,000 IU/day',  NULL,           30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),   '200 IU/day',      NULL,           40)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 5 complete: Chronic Hepatitis supplements.';
END $$;


-- ============================================================
-- BLOCK 6: CIRRHOSIS (disorder id 17)
-- Source: Cirrhosis 2.jpeg (continuation at top of page before Cholecystitis starts)
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 17,
    'Supplements for Cirrhosis',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray recommend: Vitamin A 25,000 IU/day; Vitamin B complex 20 times the US RDA; Vitamin C 1 g twice a day; Vitamin E 400 IU/day; Magnesium 250 mg twice a day; Selenium 200 mcg/day; Zinc 30 mg/day; L-Carnitine 500 mg twice a day; L-Glutamine 1 g/day; Lactobacillus acidophilus 1 teaspoon/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 17 AND title = 'Supplements for Cirrhosis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 17 AND title = 'Supplements for Cirrhosis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),               '25,000 IU/day',      NULL,              10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B Complex'),       '20× US RDA',         NULL,              20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),               '1 g twice/day',      NULL,              30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),               '400 IU/day',         NULL,              40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),               '250 mg twice/day',   NULL,              50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),                '200 mcg/day',        NULL,              60),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),                    '30 mg/day',          NULL,              70),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'L-Carnitine'),             '500 mg twice/day',   NULL,              80),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'L-Glutamine'),             '1 g/day',            NULL,              90),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Lactobacillus acidophilus'), '1 tsp/day',        NULL,             100)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 6 complete: Cirrhosis supplements.';
END $$;


-- ============================================================
-- BLOCK 7: CONGESTIVE HEART FAILURE (disorder id 84)
-- Source: Congestive Heart Failure 2.jpeg
-- Supplements appear in the CHF section; Angina Pectoris starts after.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 84,
    'Supplements for Congestive Heart Failure',
    'In Textbook of Natural Medicine, Drs. Murray and Pizzorno recommend: Magnesium 200–400 mg three times a day; Thiamine 200–250 mg/day; L-Carnitine 500–1,000 mg three times a day; Coenzyme Q10 150–300 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 84 AND title = 'Supplements for Congestive Heart Failure'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 84 AND title = 'Supplements for Congestive Heart Failure';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),          '200 to 400 mg three times/day',   NULL, 10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B1 (Thiamine)'), '200 to 250 mg/day',           NULL, 20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'L-Carnitine'),        '500 to 1,000 mg three times/day', NULL, 30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'CoQ10 / Ubiquinol'),  '150 to 300 mg/day',               NULL, 40)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 7 complete: Congestive Heart Failure supplements.';
END $$;


-- ============================================================
-- BLOCK 8: CYSTITIS (disorder id 134)
-- Source: Cystitis 3.jpeg
-- Supplement list in the Cystitis section; Urinary Calculus starts after.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 134,
    'Supplements for Cystitis',
    'In addition, take the following supplements. Note: ascorbic acid irritates the bladder — use calcium ascorbate form of vitamin C. Vitamin A 25,000 IU/day; Vitamin C 500 mg every 2 hours (as calcium ascorbate); Zinc 30 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 134 AND title = 'Supplements for Cystitis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 134 AND title = 'Supplements for Cystitis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'), '25,000 IU/day',      NULL,                        10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'), '500 mg every 2 hrs', 'use calcium ascorbate form', 20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),      '30 mg/day',           NULL,                        30)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 8 complete: Cystitis supplements.';
END $$;


-- ============================================================
-- BLOCK 9: DEPRESSION (disorder id 71)
-- Source: Depression 2.jpeg
-- Supplements in the Depression section; Insomnia starts after.
-- NOTE: Image shows "Folic acid: 400 mg/day" — this is almost certainly
-- a source typo for 400 mcg/day (standard therapeutic dose).
-- Stored as 400 mcg/day (the physiologically correct interpretation).
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 71,
    'Supplements for Depression',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray suggest: B vitamin complex 50 times the recommended daily dose; Vitamin C 1 g three times daily; Folic acid 400 mcg/day; Vitamin B12 250 mcg/day; Magnesium 500 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 71 AND title = 'Supplements for Depression'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 71 AND title = 'Supplements for Depression';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B Complex'),   '50× recommended daily dose', NULL,   10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),           '1 g three times/day',        NULL,   20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)'), '400 mcg/day',           NULL,   30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B12'),         '250 mcg/day',                NULL,   40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),           '500 mg/day',                 NULL,   50)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 9 complete: Depression supplements.';
END $$;


-- ============================================================
-- BLOCK 10: ECZEMA (disorder id 136)
-- Source: Eczema 3.jpeg
-- Supplements in the Eczema section; Psoriasis starts on Eczema 4.jpeg.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 136,
    'Supplements for Eczema',
    'Supplements suggested by Drs. Pizzorno and Murray in Textbook of Natural Medicine: Vitamin A 50,000 IU/day; Vitamin E 400 IU/day (mixed tocopherols); Zinc 50 mg/day as picolinate (decrease as condition clears); Quercetin 200–400 mg three times a day taken 5 minutes before meals; EPA and DHA 540 mg + 360 mg/day (or flaxseed oil 10 g daily); Evening primrose oil 3,000 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 136 AND title = 'Supplements for Eczema'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 136 AND title = 'Supplements for Eczema';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),          '50,000 IU/day',                   NULL,                              10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),          '400 IU/day',                      'mixed tocopherols',               20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),               '50 mg/day',                       'decrease as condition clears',    30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Quercetin'),          '200 to 400 mg three times/day',   '5 minutes before meals',          40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Fish Oils (Omega-3)'), '540 mg EPA + 360 mg DHA/day',   'or flaxseed oil 10 g daily',      50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Evening Primrose Oil'), '3,000 mg/day',                 NULL,                              60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 10 complete: Eczema supplements.';
END $$;


-- ============================================================
-- BLOCK 11: EMPHYSEMA (disorder id 60)
-- Source: Emphysema 1.jpeg
-- The Emphysema section explicitly states the asthma supplement recommendations
-- are also relevant here, then lists the same supplements.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 60,
    'Supplements for Emphysema',
    'The nutritional supplements recommended for asthma are also relevant here (Drs. Pizzorno and Murray, Textbook of Natural Medicine): Vitamin B6 25 mg twice a day; Vitamin B12 1,000 mcg/day; Vitamin C 1–2 g/day; Vitamin E 400 IU/day; Magnesium 200–300 mg three times a day; Quercetin 400 mg 20 minutes before meals; Beta-carotene 25,000–50,000 IU/day; Selenium 250 mcg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 60 AND title = 'Supplements for Emphysema'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 60 AND title = 'Supplements for Emphysema';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)'), '25 mg twice/day',             NULL,                      10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B12'),             '1,000 mcg/day',               NULL,                      20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),               '1 to 2 g/day',                NULL,                      30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),               '400 IU/day',                  NULL,                      40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),               '200 to 300 mg three times/day', NULL,                    50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Quercetin'),               '400 mg',                      '20 minutes before meals', 60),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Beta-Carotene'),           '25,000 to 50,000 IU/day',     NULL,                      70),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),                '250 mcg/day',                 NULL,                      80)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 11 complete: Emphysema supplements.';
END $$;


-- ============================================================
-- BLOCK 12: FIBROCYSTIC BREAST DISEASE (disorder id 116)
-- Source: Fibrocystic Breast Disease 2.jpeg
-- Supplements in the FBD section; Male Reproductive System starts after.
-- NOTE: Beta-carotene upper dose was difficult to read from image —
-- stored as 150,000 IU/day pending verification.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 116,
    'Supplements for Fibrocystic Breast Disease',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray recommend: B-complex 10 times the recommended daily dose; Choline 500–1,000 mg/day; Methionine 500–1,000 mg/day; Vitamin B6 25–50 mg three times a day; Vitamin E 400–800 IU/day (d-alpha tocopherol); Beta-carotene 50,000–150,000 IU/day; Vitamin C 500 mg three times a day; Zinc 15 mg/day; Flaxseed oil 1 tablespoon/day; Lactobacillus acidophilus 1 teaspoon three times a day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 116 AND title = 'Supplements for Fibrocystic Breast Disease'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 116 AND title = 'Supplements for Fibrocystic Breast Disease';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B Complex'),      '10× recommended daily dose',    NULL,                     10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Choline'),                '500 to 1,000 mg/day',           NULL,                     20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Methionine'),             '500 to 1,000 mg/day',           NULL,                     30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)'), '25 to 50 mg three times/day', NULL,                     40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),              '400 to 800 IU/day',             'd-alpha tocopherol',     50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Beta-Carotene'),          '50,000 to 150,000 IU/day',      'upper dose needs verification', 60),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),              '500 mg three times/day',        NULL,                     70),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),                   '15 mg/day',                     NULL,                     80),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Flaxseed Oil'),           '1 tablespoon/day',              NULL,                     90),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Lactobacillus acidophilus'), '1 tsp three times/day',     NULL,                    100)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 12 complete: Fibrocystic Breast Disease supplements.';
END $$;


-- ============================================================
-- BLOCK 13: HEADACHE (disorder id 75)
-- Source: Headache 4.jpeg
-- Supplements listed before Migraine section starts.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 75,
    'Supplements for Headache',
    'The following supplements may also be helpful (Drs. Pizzorno and Murray, Textbook of Natural Medicine): B-complex vitamins and vitamin C (general support); Magnesium 200–300 mg twice daily; Fish oil 3–4 g/day with meals.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 75 AND title = 'Supplements for Headache'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 75 AND title = 'Supplements for Headache';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),          '200 to 300 mg twice/day', NULL,             10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Fish Oils (Omega-3)'), '3 to 4 g/day',          'with meals',     20)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 13 complete: Headache supplements.';
END $$;


-- ============================================================
-- BLOCK 14: HYPERTENSION (disorder id 82)
-- Source: Hypertension 5.jpeg
-- Supplements in the Hypertension section; Arteriosclerosis starts after.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 82,
    'Supplements for Hypertension',
    'Drs. Pizzorno and Murray recommend supplementing the diet with: Magnesium 800–1,200 mg/day; Vitamin C 500–1,000 mg three times a day; Vitamin E 400–800 IU/day; Coenzyme Q10 50 mg two or three times a day; Garlic equivalent of 4,000 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 82 AND title = 'Supplements for Hypertension'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 82 AND title = 'Supplements for Hypertension';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),           '800 to 1,200 mg/day',           NULL, 10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),           '500 to 1,000 mg three times/day', NULL, 20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),           '400 to 800 IU/day',             NULL, 30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'CoQ10 / Ubiquinol'),  '50 mg two or three times/day',  NULL, 40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Garlic'),             'equiv. 4,000 mg/day fresh',      NULL, 50)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 14 complete: Hypertension supplements.';
END $$;


-- ============================================================
-- BLOCK 15: OSTEOPOROSIS (disorder id 144)
-- Source: Osteoporosis 2.jpeg + Osteoporosis 3.jpeg (continuation)
-- Gout section starts on Osteoporosis 3 after the supplement list ends.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 144,
    'Supplements for Osteoporosis',
    'The following supplements are recommended to help prevent and treat osteoporosis (Drs. Pizzorno and Murray): High-potency multiple vitamin and mineral formula; Calcium 800–1,200 mg/day; Vitamin D 400 IU/day; Magnesium 400–800 mg/day; Boron 1–5 mg/day (as sodium tetrahydroborate).',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 144 AND title = 'Supplements for Osteoporosis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 144 AND title = 'Supplements for Osteoporosis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Calcium'),    '800 to 1,200 mg/day', NULL,                          10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin D'),  '400 IU/day',          NULL,                          20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),  '400 to 800 mg/day',   NULL,                          30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Boron'),      '1 to 5 mg/day',       'as sodium tetrahydroborate',  40)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 15 complete: Osteoporosis supplements.';
END $$;


-- ============================================================
-- BLOCK 16: PERIODONTAL DISEASE (disorder id 4)
-- Source: Periodontal Disease 2.jpeg
-- Supplements in the Periodontal Disease section; Esophagitis/GERD starts after.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 4,
    'Supplements for Periodontal Disease',
    'The following supplements may be relevant adjuncts for the long-term treatment of periodontal disease: Vitamin C 3–5 g/day; Vitamin E 400–800 IU/day; Vitamin A 20,000 IU/day; Selenium 400 mcg/day; Zinc picolinate 30 mg/day; Folic acid 2 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 4 AND title = 'Supplements for Periodontal Disease'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 4 AND title = 'Supplements for Periodontal Disease';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),               '3 to 5 g/day',   NULL,         10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),               '400 to 800 IU/day', NULL,     20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),               '20,000 IU/day',  NULL,         30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),                '400 mcg/day',    NULL,         40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),                    '30 mg/day',      'picolinate', 50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)'), '2 mg/day',      NULL,         60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 16 complete: Periodontal Disease supplements.';
END $$;


-- ============================================================
-- BLOCK 17: PREGNANCY - FIRST TRIMESTER - MORNING SICKNESS (disorder id 96)
-- Source: Pregnancy - First Trimester - Morning Sickness 2.jpeg
-- Constipation section starts after morning sickness content.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 96,
    'Supplements for Morning Sickness',
    'Vitamin B6 may help: 100–300 mg/day. Maintain electrolyte balance if vomiting is severe.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 96 AND title = 'Supplements for Morning Sickness'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 96 AND title = 'Supplements for Morning Sickness';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)'), '100 to 300 mg/day', 10)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 17 complete: Morning Sickness supplements.';
END $$;


-- ============================================================
-- BLOCK 18: PREGNANCY - SECOND AND THIRD TRIMESTER - STRETCH MARKS (disorder id 105)
-- Source: Pregnancy - Second and Third Trimester - Stretch Marks 1.jpeg
-- Vitamins E, C, and B5 mentioned as helpful; no specific doses given in source.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 105,
    'Supplements for Stretch Marks',
    'Vitamins E, C, and B5 (pantothenic acid) can help with stretch marks and can all be obtained from the diet. Massage wheat germ or vitamin E oil into the skin area regularly. No specific therapeutic doses were given in source.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 105 AND title = 'Supplements for Stretch Marks'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 105 AND title = 'Supplements for Stretch Marks';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),               NULL, 'also topically as wheat germ oil', 10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),               NULL, NULL,                              20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B5 (Pantothenic Acid)'), NULL, NULL,                       30)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 18 complete: Stretch Marks supplements.';
END $$;


-- ============================================================
-- BLOCK 19: PROSTATITIS (disorder id 29)
-- Source: Prostatitis 1.jpeg
-- Supplements listed under Prostatitis; Skin Infections section starts after.
-- Source is Michael Murray's Male Sexual Vitality.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 29,
    'Supplements for Prostatitis',
    'In Male Sexual Vitality, Michael Murray, N.D. recommends: Vitamin E 800 IU/day; Calcium-magnesium combination 400–600 mg/day; Zinc picolinate 20–50 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 29 AND title = 'Supplements for Prostatitis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 29 AND title = 'Supplements for Prostatitis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),  '800 IU/day',          NULL,                          10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Calcium'),    '400 to 600 mg/day',   'combined with magnesium',     20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),  '400 to 600 mg/day',   'combined with calcium',       30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),       '20 to 50 mg/day',     'picolinate',                  40)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 19 complete: Prostatitis supplements.';
END $$;


-- ============================================================
-- BLOCK 20: PSORIASIS (disorder id 137)
-- Source: Psoriasis 4.jpeg
-- Supplements listed in the Psoriasis section; Acne section starts after.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 137,
    'Supplements for Psoriasis',
    'Supplements suggested by Drs. Pizzorno and Murray in Textbook of Natural Medicine: High-potency multiple vitamin and mineral formula; Flaxseed oil 1 tablespoon/day; Vitamin A 50,000 IU/day (do not use in pregnancy or for women planning pregnancy); Vitamin E 400 IU/day; Chromium 400 mcg/day; Selenium 200 mcg/day; Zinc 30 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 137 AND title = 'Supplements for Psoriasis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 137 AND title = 'Supplements for Psoriasis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Flaxseed Oil'),  '1 tablespoon/day',  NULL,                                          10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),     '50,000 IU/day',     'do not use in pregnancy or pre-conception',   20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),     '400 IU/day',        NULL,                                          30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Chromium'),      '400 mcg/day',       NULL,                                          40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),      '200 mcg/day',       NULL,                                          50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),          '30 mg/day',         NULL,                                          60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 20 complete: Psoriasis supplements.';
END $$;


-- ============================================================
-- BLOCK 21: RESTLESS LEGS SYNDROME (disorder id 147)
-- Source: Restless Legs Syndrome 2.jpeg
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 147,
    'Supplements for Restless Legs Syndrome',
    'To help correct nutrient deficiencies contributing to symptoms: Vitamin E (with an iron-containing multivitamin); B complex; Folic acid 400–1,000 mcg/day (to offset potential folic acid deficiency).',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 147 AND title = 'Supplements for Restless Legs Syndrome'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 147 AND title = 'Supplements for Restless Legs Syndrome';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),               NULL,                  'take with iron-containing multivitamin', 10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B Complex'),       NULL,                  NULL,                                    20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)'), '400 to 1,000 mcg/day', NULL,                                  30)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 21 complete: Restless Legs Syndrome supplements.';
END $$;


-- ============================================================
-- BLOCK 22: RHEUMATOID ARTHRITIS (disorder id 143)
-- Source: Rheumatoid Arthritis 10.jpeg
-- Supplements in the RA section; Osteoporosis section starts after.
-- The general dietary suggestions for OA are also pertinent, but the
-- specific supplement recommendations are different.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 143,
    'Supplements for Rheumatoid Arthritis',
    'In Textbook of Natural Medicine, Drs. Pizzorno and Murray suggest: DHEA 50–200 mg/day; EPA 1.8 g/day (or flaxseed oil 1 tablespoon/day); Pantothenic acid 500 mg four times a day; Quercetin 250 mg three times a day between meals; Vitamin C 1–3 g/day; Vitamin E 400 IU/day; Copper 1 mg/day; Manganese 15 mg/day; Selenium 200 mcg/day; Zinc 45 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 143 AND title = 'Supplements for Rheumatoid Arthritis'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 143 AND title = 'Supplements for Rheumatoid Arthritis';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'DHEA'),                   '50 to 200 mg/day',      NULL,                           10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Fish Oils (Omega-3)'),    '1.8 g EPA/day',         'or flaxseed oil 1 tbsp/day',   20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B5 (Pantothenic Acid)'), '500 mg four times/day', NULL,                    30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Quercetin'),              '250 mg three times/day', 'between meals',               40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),              '1 to 3 g/day',           NULL,                          50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),              '400 IU/day',             NULL,                          60),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Copper'),                 '1 mg/day',               NULL,                          70),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Manganese'),              '15 mg/day',              NULL,                          80),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Selenium'),               '200 mcg/day',            NULL,                          90),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),                   '45 mg/day',              NULL,                         100)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 22 complete: Rheumatoid Arthritis supplements.';
END $$;


-- ============================================================
-- BLOCK 23: SHINGLES (disorder id 80)
-- Source: Shingles 2.jpeg
-- Supplements in the Shingles section.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 80,
    'Supplements for Shingles',
    'The following supplements are recommended: Vitamin B complex 100 mg three times a day with food; Vitamin C 2 g twice a day; Lysine 500 mg twice daily.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 80 AND title = 'Supplements for Shingles'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 80 AND title = 'Supplements for Shingles';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B Complex'), '100 mg three times/day', 'with food',  10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),         '2 g twice/day',          NULL,         20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Lysine'),            '500 mg twice/day',       NULL,         30)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 23 complete: Shingles supplements.';
END $$;


-- ============================================================
-- BLOCK 24: THE COMMON COLD (disorder id 62)
-- Source: The Common Cold 2.jpeg
-- Dietary advice section recommends taking vitamin C daily.
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 62,
    'Supplements for The Common Cold',
    'For both the prevention and treatment of colds, take 1–3 g of vitamin C daily.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 62 AND title = 'Supplements for The Common Cold'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 62 AND title = 'Supplements for The Common Cold';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'), '1 to 3 g/day', 10)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 24 complete: The Common Cold supplements.';
END $$;


-- ============================================================
-- BLOCK 25: VARICOSE VEINS (disorder id 87)
-- Source: Varicose Veins 3.jpeg
-- ============================================================

DO $$
DECLARE
  v_rx_id INTEGER;
BEGIN
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  SELECT 87,
    'Supplements for Varicose Veins',
    'In Textbook of Natural Medicine, Drs. Murray and Pizzorno recommend: Vitamin A 10,000 IU/day; Vitamin B complex 10–100 mg/day; Vitamin C (with bioflavonoids) 1–3 g/day; Vitamin E 200–600 IU/day; Magnesium 800–1,200 mg/day; Zinc 15–30 mg/day.',
    100
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.disorder_prescriptions
    WHERE disorder_id = 87 AND title = 'Supplements for Varicose Veins'
  );

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = 87 AND title = 'Supplements for Varicose Veins';

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order) VALUES
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin A'),          '10,000 IU/day',           NULL,                10),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin B Complex'),  '10 to 100 mg/day',        NULL,                20),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin C'),          '1 to 3 g/day',            'with bioflavonoids', 30),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Vitamin E'),          '200 to 600 IU/day',       NULL,                40),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Magnesium'),          '800 to 1,200 mg/day',     NULL,                50),
    (v_rx_id, (SELECT id FROM herbal.supplements WHERE name = 'Zinc'),               '15 to 30 mg/day',         NULL,                60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Block 25 complete: Varicose Veins supplements.';
END $$;


-- ============================================================
-- SKIPPED DISORDERS (no specific dose supplements found in images):
--   Acute Stress (id 70)     — image mentions B vitamins essential, no doses given
--   Premenstrual Syndrome (92) — dietary advice mentions Mg, B6, Zn, niacin, C
--                                 but no specific dose supplement protocol visible
--   Pregnancy - First Trimester - Threatened Miscarriage (95) — no supplement list
-- ============================================================

DO $$ BEGIN
  RAISE NOTICE 'Migration 111 complete: supplement prescriptions added for 25 disorders, 12 new supplements created.';
END $$;
