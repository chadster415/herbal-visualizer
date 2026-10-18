-- Migration 395: BHC Class 18 — Cardiovascular System and Compost
-- Personal notes only (no generated notes file for this class)
-- File parsed: BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder.md (personal)
--
-- Herb normalizations:
--   eleuthero          → Siberian Ginseng (id=9, Eleutherococcus senticosus)
--   bladderwrack       → Kelp (id=118, Fucus vesiculosus) — same plant, bladderwrack is common name
--   horsebalm          → Stoneroot (id=182, Collinsonia canadensis) — horsebalm is alternate common name
--   oat straw          → Oat straw (id=2287, Avena sativa)
--   oat tops           → Oat milky oats (id=178, Avena sativa)
--   reishi             → Reishi Mushroom (id=11, Ganoderma lucidum)
--   gotu kola          → Gotu Kola (id=2229, Centella asiatica)
--   elderberry         → Elder berry (id=1651, Sambucus nigra)
--
-- Keyword merge decisions:
--   "cardiovascular support"       → cardiovascular disease (existing)
--   "cholesterol lowering"         → hyperlipidemia (existing)
--   "platelet aggregation / clots" → thrombosis (existing)
--   "connective tissue repair"     → connective tissue disorders (existing)
--
-- New ailment keyword: varicose veins
--
-- Skipped (food items, not herbs):
--   okra, watermelon, honey/brown sugar — food ingredients
--   mint (generic culinary mention in okra water recipe, no clinical context)

SET search_path TO herbal, public;

DO $$
DECLARE

  v_marshmallow_recap_src CONSTANT TEXT :=
'- maybe use the leaves and flowers in this season - less polysaccharides, but maybe you don''t need so much moistening in the spring
- glycerin may be a better match for the polysaccharides than the alcohol tincture, which breaks them down
- maybe cleavers in tequila';

  v_okra_water_src CONSTANT TEXT :=
'- mixture: filtered water, okra, mint, and lemon balm
- okra pairs well with hibiscus
    - seeds are also similar and mucilagenous - also can eat leaves of both plants
    - make a hibiscus hot decoction, 30 mins, then let steep for several hours. Then add some of the okra slime, ginger, turmeric, cinnamon, clove
    - Bladder and urinary assistance
- okra also thickens a liquid when cooking
- benefits: belly and dry eyes, stuck waste in colon
- high in vitamins A, C
- Okra:
    - originates in West Africa
    - eaten every day, in their light soups, even dry it first, then add to soups
    - Gumbo means, soups, thickening, with things like okra';

  v_blood_flows_src CONSTANT TEXT :=
'- flows from the right atrium to the right ventricle, then to the lungs for oxygen
- returns to the left atrium, moves to the left ventricle, then pumped into systemic circulation
- the heart''s conduction system coordinates chamber contractions
- substances move through capillary walls via diffusion, filtration and osmosis

- (High BP not from salt itself (gray salt, pink salt), but from sodium in packaged foods, processed)
- (hibiscus when the season shifts into hotter temps - rinse after purchasing!
    - compare to hawthorn, but hawthorn is not native to North America
    - hawthorn good for colder climates, but hibiscus from Africa, tropical
    - hibiscus, nutritive, suppress your appetite - also an emmenagogue
    - high in Mg, affinity for heart health (electrical contraction)
    - also polyphenols, etc
    - can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)
    - not blood thinning, but cayenne is (anti-platelet)
    - pharma 3-7 hours until wear off, can do herbs after that to avoid interaction)';

  v_hibiscus_src CONSTANT TEXT :=
'Anti-inflammatory
Antioxidant
Astringent
antimicrobial
antiviral
cardiotonic
cholesterol lower
GI tonic
anticancer
diuretic
demulcent
hypotensive
- top is systolic, bottom is diastolic
- 90''s? a little excited - space between the beats';

  v_red_drank_src CONSTANT TEXT :=
'- Hibiscus Refresher
- "Hibiscus"
- Ginger
- Clove
- Cinnamon
- honey/brown sugar
- 2 decoctions, rinse before using
- 30 minutes, cool for couple of hours, strain don''t press
- 30 minutes with fresh water, boil 30 mins, then strain and press
- combine 2 liquids, then decoct 20 minutes to reduce a bit
- then add the honey at 98 deg or so
- cool, fridge, sparkling water, maybe, or okra water?

- after, maybe add hawthorn, elderberry? etc
- appetite suppressing?';

  v_cv_support_src CONSTANT TEXT :=
'- Hawthorn
    - cardiotonic - supports myocardium, contraction of heart muscles, nutrition, flavonoids
- Horse chestnut, stoneroot, horsebalm
    - addresses the veins to bring fluid back up to the heart and can also be used to address varicose veins
- turmeric, sassafras
    - AI properties to reduce LDL and decrease platelet aggregation (clots)
- garlic
    - lower LDL and increases HDL to reduce inflammation - #1 heart medicine
- motherwort
    - reduces palpitations, antispasmodic, but can exacerbate hypothyroidal issues
- oat straw/ oat tops, asafetida
    - nervine
- rosemary
    - flavonoid, antioxidant, cognitive repair
- gotu kola
    - to restore connective tissue, improve integrity of veins/arteries to strengthen the heart muscle
- dandelion leaf - diuretic
- prickly ash - circulatory
- cayenne -
    - relaxes capillaries, allowing medicinal ingredients to reach the tissues
- licorice -
    - a demulcent and AI, but can raise BP in sodium sensitive individuals. Short term use, creates water retention
- Lung Tonics
    - mullein
    - reishi
    - plantain
    - eleuthero
- Kidney/Bladder Tonics
    - dandelion leaf
    - goldenrod
    - watermelon - in season, June (corn too), seeded or seedless is fine - can use the seeds in teas and remedies
    - cleavers
    - bladderwrack

Poke - Poisonous? can eat the leaves when the berry is white, not yet red';

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder') THEN
    RAISE NOTICE 'Class 18 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- ─── Marshmallow Recap ────────────────────────────────────────────
    (45,
     'maybe use the leaves and flowers in this season - less polysaccharides, but maybe you don''t need so much moistening in the spring; glycerin may be a better match for the polysaccharides than the alcohol tincture, which breaks them down',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Marshmallow Recap', 10,
     v_marshmallow_recap_src),

    (28,
     'maybe cleavers in tequila',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Marshmallow Recap', 20,
     v_marshmallow_recap_src),

    -- ─── Okra Water ───────────────────────────────────────────────────
    (134,
     'Okra water mixture: filtered water, okra, mint, and lemon balm',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Okra Water', 30,
     v_okra_water_src),

    (2233,
     'okra pairs well with hibiscus - make a hibiscus hot decoction, 30 mins, let steep for several hours; bladder and urinary assistance',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Okra Water', 40,
     v_okra_water_src),

    (124,
     'make a hibiscus hot decoction, 30 mins, then let steep for several hours. Then add some of the okra slime, ginger, turmeric, cinnamon, clove',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Okra Water', 50,
     v_okra_water_src),

    (203,
     'make a hibiscus hot decoction, 30 mins, then let steep for several hours. Then add some of the okra slime, ginger, turmeric, cinnamon, clove',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Okra Water', 60,
     v_okra_water_src),

    (167,
     'make a hibiscus hot decoction, 30 mins, then let steep for several hours. Then add some of the okra slime, ginger, turmeric, cinnamon, clove',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Okra Water', 70,
     v_okra_water_src),

    (111,
     'make a hibiscus hot decoction, 30 mins, then let steep for several hours. Then add some of the okra slime, ginger, turmeric, cinnamon, clove',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Okra Water', 80,
     v_okra_water_src),

    -- ─── Blood Flows ──────────────────────────────────────────────────
    (2233,
     'hibiscus when the season shifts into hotter temps - nutritive, suppress appetite - also an emmenagogue; high in Mg, affinity for heart health (electrical contraction); can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Blood Flows', 90,
     v_blood_flows_src),

    (73,
     'compare to hawthorn, but hawthorn is not native to North America - hawthorn good for colder climates, but hibiscus from Africa, tropical',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Blood Flows', 100,
     v_blood_flows_src),

    (47,
     'not blood thinning, but cayenne is (anti-platelet)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Blood Flows', 110,
     v_blood_flows_src),

    -- ─── Hibiscus (dedicated properties section) ──────────────────────
    (2233,
     'Hibiscus actions: Anti-inflammatory, Antioxidant, Astringent, antimicrobial, antiviral, cardiotonic, cholesterol lower, GI tonic, anticancer, diuretic, demulcent, hypotensive',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Hibiscus', 120,
     v_hibiscus_src),

    -- ─── Red Drank ────────────────────────────────────────────────────
    (2233,
     'Red Drank / Hibiscus Refresher: hibiscus decoction (2 × 30 min, combine and reduce), with ginger, clove, cinnamon, honey; cardiovascular and appetite-suppressing beverage',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Red Drank', 130,
     v_red_drank_src),

    (124,
     'Red Drank ingredients: hibiscus, ginger, clove, cinnamon, honey/brown sugar; 2 decoctions method, combine and reduce 20 minutes',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Red Drank', 140,
     v_red_drank_src),

    (111,
     'Red Drank ingredients: hibiscus, ginger, clove, cinnamon, honey/brown sugar; 2 decoctions method',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Red Drank', 150,
     v_red_drank_src),

    (167,
     'Red Drank ingredients: hibiscus, ginger, clove, cinnamon, honey/brown sugar; 2 decoctions method',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Red Drank', 160,
     v_red_drank_src),

    (73,
     'after Red Drank, maybe add hawthorn, elderberry? - optional cardiovascular add-ins',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Red Drank', 170,
     v_red_drank_src),

    (1651,
     'after Red Drank, maybe add hawthorn, elderberry? - optional add-ins',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Red Drank', 180,
     v_red_drank_src),

    -- ─── Cardiovascular Herbal Support ────────────────────────────────
    (73,
     'Hawthorn - cardiotonic - supports myocardium, contraction of heart muscles, nutrition, flavonoids',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 190,
     v_cv_support_src),

    (62,
     'Horse chestnut, stoneroot, horsebalm - addresses the veins to bring fluid back up to the heart and can also be used to address varicose veins',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 200,
     v_cv_support_src),

    (182,
     'Horse chestnut, stoneroot, horsebalm - addresses the veins to bring fluid back up to the heart and can also be used to address varicose veins',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 210,
     v_cv_support_src),

    (203,
     'turmeric, sassafras - AI properties to reduce LDL and decrease platelet aggregation (clots)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 220,
     v_cv_support_src),

    (313,
     'turmeric, sassafras - AI properties to reduce LDL and decrease platelet aggregation (clots)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 230,
     v_cv_support_src),

    (21,
     'garlic - lower LDL and increases HDL to reduce inflammation - #1 heart medicine',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 240,
     v_cv_support_src),

    (131,
     'motherwort - reduces palpitations, antispasmodic, but can exacerbate hypothyroidal issues',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 250,
     v_cv_support_src),

    (2287,
     'oat straw/oat tops, asafetida - nervine (cardiovascular support)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 260,
     v_cv_support_src),

    (178,
     'oat straw/oat tops, asafetida - nervine (cardiovascular support)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 270,
     v_cv_support_src),

    (2645,
     'oat straw/oat tops, asafetida - nervine (cardiovascular support)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 280,
     v_cv_support_src),

    (109,
     'rosemary - flavonoid, antioxidant, cognitive repair',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 290,
     v_cv_support_src),

    (2229,
     'gotu kola - to restore connective tissue, improve integrity of veins/arteries to strengthen the heart muscle',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 300,
     v_cv_support_src),

    (1648,
     'dandelion leaf - diuretic (cardiovascular support)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 310,
     v_cv_support_src),

    (123,
     'prickly ash - circulatory',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 320,
     v_cv_support_src),

    (47,
     'cayenne - relaxes capillaries, allowing medicinal ingredients to reach the tissues',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 330,
     v_cv_support_src),

    (78,
     'licorice - a demulcent and AI, but can raise BP in sodium sensitive individuals. Short term use, creates water retention',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 340,
     v_cv_support_src),

    -- Lung Tonics (subsection of Cardiovascular Herbal Support)
    (61,
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 350,
     v_cv_support_src),

    (11,
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 360,
     v_cv_support_src),

    (85,
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 370,
     v_cv_support_src),

    (9,
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 380,
     v_cv_support_src),

    -- Kidney/Bladder Tonics (subsection of Cardiovascular Herbal Support)
    (1648,
     'Kidney/Bladder Tonics: dandelion leaf, goldenrod, cleavers, bladderwrack (watermelon in season)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 390,
     v_cv_support_src),

    (58,
     'Kidney/Bladder Tonics: dandelion leaf, goldenrod, cleavers, bladderwrack (watermelon in season)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 400,
     v_cv_support_src),

    (28,
     'Kidney/Bladder Tonics: dandelion leaf, goldenrod, cleavers, bladderwrack (watermelon in season)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 410,
     v_cv_support_src),

    (118,
     'Kidney/Bladder Tonics: dandelion leaf, goldenrod, cleavers, bladderwrack (Fucus vesiculosus / Kelp)',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 420,
     v_cv_support_src),

    -- Poke Root safety note (end of Cardiovascular section)
    (35,
     'Poke - Poisonous? can eat the leaves when the berry is white, not yet red',
     'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder', 'personal', 'Cardiovascular Herbal Support', 430,
     v_cv_support_src);

END $$;

-- Keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Marshmallow (45) — seasonal and preparation context
  (45,   'demulcent',                  'action'),
  (45,   'mucous membrane support',    'ailment'),
  -- Cleavers (28) — kidney/bladder tonic
  (28,   'diuretic',                   'action'),
  (28,   'lymphatic',                  'action'),
  (28,   'kidney support',             'ailment'),
  (28,   'bladder support',            'ailment'),
  (28,   'lymphatic support',          'ailment'),
  -- Lemon Balm (134) — nervine recipe context
  (134,  'nervine',                    'action'),
  -- Hibiscus (2233)
  (2233, 'anti-inflammatory',          'action'),
  (2233, 'antioxidant',                'action'),
  (2233, 'astringent',                 'action'),
  (2233, 'antimicrobial',              'action'),
  (2233, 'antiviral',                  'action'),
  (2233, 'cardiotonic',                'action'),
  (2233, 'diuretic',                   'action'),
  (2233, 'demulcent',                  'action'),
  (2233, 'hypotensive',                'action'),
  (2233, 'emmenagogue',                'action'),
  (2233, 'hypertension',               'ailment'),
  (2233, 'cardiovascular disease',     'ailment'),
  (2233, 'edema',                      'ailment'),
  (2233, 'hyperlipidemia',             'ailment'),
  (2233, 'bladder support',            'ailment'),
  -- Hawthorn (73) — berry
  (73,   'cardiotonic',                'action'),
  (73,   'cardiovascular disease',     'ailment'),
  (73,   'heart failure',              'ailment'),
  (73,   'palpitations',               'ailment'),
  -- Horse Chestnut (62)
  (62,   'venous tonic',               'action'),
  (62,   'varicose veins',             'ailment'),
  (62,   'circulation',                'ailment'),
  (62,   'edema',                      'ailment'),
  (62,   'cardiovascular disease',     'ailment'),
  -- Stoneroot (182)
  (182,  'venous tonic',               'action'),
  (182,  'varicose veins',             'ailment'),
  (182,  'circulation',                'ailment'),
  (182,  'edema',                      'ailment'),
  -- Turmeric (203)
  (203,  'anti-inflammatory',          'action'),
  (203,  'anti-platelet',              'action'),
  (203,  'cardiovascular disease',     'ailment'),
  (203,  'hyperlipidemia',             'ailment'),
  (203,  'thrombosis',                 'ailment'),
  -- Sassafras (313)
  (313,  'anti-inflammatory',          'action'),
  (313,  'anti-platelet',              'action'),
  (313,  'cardiovascular disease',     'ailment'),
  (313,  'hyperlipidemia',             'ailment'),
  (313,  'thrombosis',                 'ailment'),
  -- Garlic (21)
  (21,   'anti-inflammatory',          'action'),
  (21,   'cardiovascular disease',     'ailment'),
  (21,   'hyperlipidemia',             'ailment'),
  (21,   'hypertension',               'ailment'),
  -- Motherwort (131)
  (131,  'antispasmodic',              'action'),
  (131,  'cardiotonic',                'action'),
  (131,  'palpitations',               'ailment'),
  (131,  'arrhythmia',                 'ailment'),
  (131,  'tachycardia',                'ailment'),
  (131,  'cardiovascular disease',     'ailment'),
  -- Oat straw (2287)
  (2287, 'nervine',                    'action'),
  (2287, 'nervous system support',     'ailment'),
  (2287, 'cardiovascular disease',     'ailment'),
  -- Oat milky oats (178)
  (178,  'nervine',                    'action'),
  (178,  'nervous system support',     'ailment'),
  (178,  'cardiovascular disease',     'ailment'),
  -- Asafetida (2645)
  (2645, 'nervine',                    'action'),
  (2645, 'nervous system support',     'ailment'),
  (2645, 'cardiovascular disease',     'ailment'),
  -- Rosemary (109)
  (109,  'antioxidant',                'action'),
  (109,  'cognitive support',          'ailment'),
  (109,  'memory support',             'ailment'),
  (109,  'cardiovascular disease',     'ailment'),
  -- Gotu Kola (2229)
  (2229, 'connective tissue disorders','ailment'),
  (2229, 'varicose veins',             'ailment'),
  (2229, 'cardiovascular disease',     'ailment'),
  (2229, 'circulation',                'ailment'),
  -- Dandelion leaf (1648)
  (1648, 'diuretic',                   'action'),
  (1648, 'edema',                      'ailment'),
  (1648, 'hypertension',               'ailment'),
  (1648, 'kidney support',             'ailment'),
  (1648, 'bladder support',            'ailment'),
  (1648, 'cardiovascular disease',     'ailment'),
  -- Prickly Ash (123)
  (123,  'circulatory stimulant',      'action'),
  (123,  'circulation',                'ailment'),
  (123,  'poor circulation',           'ailment'),
  (123,  'cardiovascular disease',     'ailment'),
  -- Cayenne (47)
  (47,   'anti-platelet',              'action'),
  (47,   'circulatory stimulant',      'action'),
  (47,   'thrombosis',                 'ailment'),
  (47,   'poor circulation',           'ailment'),
  (47,   'cardiovascular disease',     'ailment'),
  -- Licorice (78)
  (78,   'demulcent',                  'action'),
  (78,   'anti-inflammatory',          'action'),
  (78,   'hypertension',               'ailment'),
  (78,   'cardiovascular disease',     'ailment'),
  -- Mullein (61)
  (61,   'lung tonic',                 'action'),
  (61,   'chronic lung disease',       'ailment'),
  (61,   'respiratory congestion',     'ailment'),
  -- Reishi Mushroom (11)
  (11,   'lung tonic',                 'action'),
  (11,   'adaptogen',                  'action'),
  (11,   'chronic lung disease',       'ailment'),
  (11,   'immune support',             'ailment'),
  -- Plantain (85)
  (85,   'lung tonic',                 'action'),
  (85,   'respiratory congestion',     'ailment'),
  (85,   'chronic lung disease',       'ailment'),
  -- Siberian Ginseng (9)
  (9,    'adaptogen',                  'action'),
  (9,    'lung tonic',                 'action'),
  (9,    'chronic lung disease',       'ailment'),
  (9,    'fatigue',                    'ailment'),
  (9,    'energy support',             'ailment'),
  -- Goldenrod (58)
  (58,   'diuretic',                   'action'),
  (58,   'kidney support',             'ailment'),
  (58,   'bladder support',            'ailment'),
  -- Kelp / bladderwrack (118)
  (118,  'diuretic',                   'action'),
  (118,  'kidney support',             'ailment'),
  (118,  'bladder support',            'ailment'),
  -- Poke Root (35)
  (35,   'lymphatic support',          'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ailment search synonyms — only new keyword: varicose veins
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('varicose veins', ARRAY['chronic venous insufficiency', 'venous insufficiency', 'venous varicosity', 'spider veins', 'venous pooling', 'poor venous return'])
ON CONFLICT (ailment_keyword) DO NOTHING;
