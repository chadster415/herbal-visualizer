-- Migration 396: BHC Class 18 — Cardiovascular System and Compost quiz questions
-- Class name: BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder
--
-- Target calculation:
--   H = 30 distinct herbs/supplements identified
--   F = 8 named factual items (ACE mechanism, emmenagogue caution, cayenne anti-platelet,
--       licorice BP caution, motherwort + hypothyroid, hawthorn climate, Poke safety, heart layers)
--   target = 15 + (30 × 4) + (8 × 1) = 15 + 120 + 8 = 143 → clamped to 50
--   Rounded to nearest 5: 50 questions
--
-- Correct option distribution: a=13, b=13, c=12, d=12

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder') THEN
    RAISE NOTICE 'Class 18 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1 (correct=a) — Hibiscus blood pressure mechanism
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What cardiovascular mechanism does hibiscus use to lower blood pressure?',
     'ACE inhibition leading to vasodilation',
     'Beta-blockade of cardiac receptors',
     'Calcium channel blockade',
     'Direct natriuresis via loop inhibition',
     'a',
     'The notes explicitly state hibiscus lowers blood pressure via "vasodilation (ACE mechanism)" — ACE inhibition is the named mechanism.',
     'hibiscus when the season shifts into hotter temps - nutritive, suppress appetite - also an emmenagogue; high in Mg, affinity for heart health (electrical contraction); can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)',
     'Blood Flows', 10),

    -- Q2 (correct=b) — Hibiscus as emmenagogue
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'In addition to cardiovascular support, hibiscus is described as what type of herb affecting menstruation?',
     'Galactagogue',
     'Emmenagogue',
     'Nervine',
     'Antispasmodic',
     'b',
     'The notes explicitly name hibiscus as "also an emmenagogue" — it stimulates or increases menstrual flow, an important safety consideration.',
     'hibiscus when the season shifts into hotter temps - nutritive, suppress appetite - also an emmenagogue; high in Mg, affinity for heart health (electrical contraction); can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)',
     'Blood Flows', 20),

    -- Q3 (correct=c) — Hibiscus magnesium + heart
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which herb is specifically noted as high in magnesium with affinity for heart health via electrical contraction?',
     'Hawthorn',
     'Motherwort',
     'Hibiscus',
     'Garlic',
     'c',
     'The notes state hibiscus is "high in Mg, affinity for heart health (electrical contraction)" — magnesium supports the electrical signals that coordinate cardiac contractions.',
     'hibiscus when the season shifts into hotter temps - nutritive, suppress appetite - also an emmenagogue; high in Mg, affinity for heart health (electrical contraction); can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)',
     'Blood Flows', 30),

    -- Q4 (correct=d) — Hibiscus two BP mechanisms
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Hibiscus lowers blood pressure through two named mechanisms — what are they?',
     'Beta-blockade and loop diuresis',
     'ACE inhibition and calcium channel blockade',
     'Natriuresis and alpha-adrenergic blockade',
     'Vasodilation via ACE mechanism and diuresis to reduce blood volume',
     'd',
     'The notes name both mechanisms together: "vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)".',
     'hibiscus when the season shifts into hotter temps - nutritive, suppress appetite - also an emmenagogue; high in Mg, affinity for heart health (electrical contraction); can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)',
     'Blood Flows', 40),

    -- Q5 (correct=a) — Red Drank primary herb
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'The Red Drank recipe is primarily built around which herb?',
     'Hibiscus',
     'Ginger',
     'Cinnamon',
     'Clove',
     'a',
     'The recipe is called the "Hibiscus Refresher" and uses hibiscus as the base; ginger, clove, and cinnamon are supporting spices.',
     'Red Drank / Hibiscus Refresher: hibiscus decoction (2 × 30 min, combine and reduce), with ginger, clove, cinnamon, honey; cardiovascular and appetite-suppressing beverage',
     'Red Drank', 50),

    -- Q6 (correct=b) — Red Drank functions
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'The Red Drank is described as serving what two primary functions?',
     'Immune support and fever reduction',
     'Cardiovascular support and appetite suppression',
     'Kidney cleansing and blood purification',
     'Stress relief and adrenal support',
     'b',
     'The snippet describes the Red Drank as a "cardiovascular and appetite-suppressing beverage" — both functions are attributed to hibiscus in the notes.',
     'Red Drank / Hibiscus Refresher: hibiscus decoction (2 × 30 min, combine and reduce), with ginger, clove, cinnamon, honey; cardiovascular and appetite-suppressing beverage',
     'Red Drank', 60),

    -- Q7 (correct=c) — Red Drank decoction method
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'How many decoctions does the Red Drank method use, and what is done with them?',
     'One 60-minute decoction',
     'Three 20-minute decoctions',
     'Two 30-minute decoctions, combined and reduced',
     'One decoction and one cold infusion',
     'c',
     'The notes describe "2 × 30 min" decoctions that are then combined and reduced — a double-extraction method to maximize the herb''s compounds.',
     'Red Drank / Hibiscus Refresher: hibiscus decoction (2 × 30 min, combine and reduce), with ginger, clove, cinnamon, honey; cardiovascular and appetite-suppressing beverage',
     'Red Drank', 70),

    -- Q8 (correct=d) — Hibiscus climate/region
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Hibiscus is from which climate or region, as contrasted with hawthorn?',
     'Mediterranean Europe',
     'East Asia',
     'South America',
     'Africa, tropical climates',
     'd',
     'The notes contrast the two: "hawthorn good for colder climates, but hibiscus from Africa, tropical" — regional origin informs which herb is climatically appropriate.',
     'compare to hawthorn, but hawthorn is not native to North America - hawthorn good for colder climates, but hibiscus from Africa, tropical',
     'Blood Flows', 80),

    -- Q9 (correct=a) — Hibiscus actions listed
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which of the following IS a listed action of hibiscus in these notes?',
     'Cardiotonic',
     'Adaptogen',
     'Nervine',
     'Antispasmodic',
     'a',
     'The notes list "cardiotonic" among hibiscus''s actions; adaptogen, nervine, and antispasmodic are not in the list.',
     'Hibiscus actions: Anti-inflammatory, Antioxidant, Astringent, antimicrobial, antiviral, cardiotonic, cholesterol lower, GI tonic, anticancer, diuretic, demulcent, hypotensive',
     'Hibiscus', 90),

    -- Q10 (correct=b) — Hibiscus NOT an action
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which of the following is NOT listed as a hibiscus action in these notes?',
     'Antiviral',
     'Adaptogen',
     'Demulcent',
     'Hypotensive',
     'b',
     'Adaptogen is not in hibiscus''s action list; antiviral, demulcent, and hypotensive are all explicitly listed.',
     'Hibiscus actions: Anti-inflammatory, Antioxidant, Astringent, antimicrobial, antiviral, cardiotonic, cholesterol lower, GI tonic, anticancer, diuretic, demulcent, hypotensive',
     'Hibiscus', 100),

    -- Q11 (correct=c) — Hawthorn cardiac tissue
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What specific cardiac tissue does hawthorn''s cardiotonic action directly support?',
     'Pericardium',
     'Endothelium',
     'Myocardium',
     'Heart valves',
     'c',
     'The notes state hawthorn "supports myocardium, contraction of heart muscles" — the myocardium is the muscular layer responsible for pumping.',
     'Hawthorn - cardiotonic - supports myocardium, contraction of heart muscles, nutrition, flavonoids',
     'Cardiovascular Herbal Support', 110),

    -- Q12 (correct=d) — Hawthorn climate
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Hawthorn is suited for which type of climate, in contrast to hibiscus?',
     'Tropical',
     'Mediterranean',
     'Desert',
     'Colder climates',
     'd',
     'The notes state "hawthorn good for colder climates" as a contrast to hibiscus from tropical Africa — climate matching guides herb selection.',
     'compare to hawthorn, but hawthorn is not native to North America - hawthorn good for colder climates, but hibiscus from Africa, tropical',
     'Blood Flows', 120),

    -- Q13 (correct=a) — Hawthorn constituents
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which constituents are specifically noted for hawthorn''s cardiovascular nutrition?',
     'Nutrition and flavonoids',
     'Terpenes and saponins',
     'Alkaloids and tannins',
     'Polysaccharides and mucilage',
     'a',
     'The notes say hawthorn provides "nutrition, flavonoids" to the myocardium — flavonoids are well-established as hawthorn''s key cardiovascular constituents.',
     'Hawthorn - cardiotonic - supports myocardium, contraction of heart muscles, nutrition, flavonoids',
     'Cardiovascular Herbal Support', 130),

    -- Q14 (correct=b) — Cayenne vs hibiscus
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'How does cayenne differ from hibiscus in its effect on blood?',
     'Both herbs thin blood through the same mechanism',
     'Cayenne is anti-platelet (blood thinning); hibiscus is not',
     'Hibiscus thins blood; cayenne does not',
     'Neither herb affects blood viscosity',
     'b',
     'The notes explicitly state "not blood thinning, but cayenne is (anti-platelet)" — this distinguishes cayenne as the anti-platelet herb while hibiscus is not.',
     'not blood thinning, but cayenne is (anti-platelet)',
     'Blood Flows', 140),

    -- Q15 (correct=c) — Cayenne capillary action
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What is cayenne''s primary vascular action that helps deliver medicinal ingredients to tissues?',
     'Constricts capillaries to increase systemic pressure',
     'Dilates major arteries to reduce resistance',
     'Relaxes capillaries, allowing medicinal ingredients to reach the tissues',
     'Strengthens capillary walls against permeability',
     'c',
     'The notes state cayenne "relaxes capillaries, allowing medicinal ingredients to reach the tissues" — this is why cayenne is often added to formulas as a carrier.',
     'cayenne - relaxes capillaries, allowing medicinal ingredients to reach the tissues',
     'Cardiovascular Herbal Support', 150),

    -- Q16 (correct=d) — Cayenne anti-platelet classification
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Cayenne is classified as what type of anti-clotting agent in these notes?',
     'Anticoagulant',
     'Thrombolytic',
     'Fibrinolytic',
     'Anti-platelet',
     'd',
     'The notes say "cayenne is (anti-platelet)" — anti-platelet agents prevent platelet aggregation, which is distinct from anticoagulant or thrombolytic mechanisms.',
     'not blood thinning, but cayenne is (anti-platelet)',
     'Blood Flows', 160),

    -- Q17 (correct=a) — Licorice safety
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What is the primary safety concern with using licorice in cardiovascular patients?',
     'Can raise BP in sodium-sensitive individuals and creates water retention with short-term use',
     'Lowers blood pressure dangerously in some patients',
     'Interacts with calcium channel blockers',
     'Causes potassium wasting',
     'a',
     'The notes warn licorice "can raise BP in sodium sensitive individuals. Short term use, creates water retention" — critical contraindication for hypertensive patients.',
     'licorice - a demulcent and AI, but can raise BP in sodium sensitive individuals. Short term use, creates water retention',
     'Cardiovascular Herbal Support', 170),

    -- Q18 (correct=b) — Licorice primary actions
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What are licorice''s two primary actions as noted in cardiovascular support?',
     'Cardiotonic and antispasmodic',
     'Demulcent and anti-inflammatory',
     'Diuretic and vasodilatory',
     'Adaptogenic and hepatoprotective',
     'b',
     'The notes describe licorice as "a demulcent and AI (anti-inflammatory)" — these are its key cardiovascular-context roles before noting the BP caution.',
     'licorice - a demulcent and AI, but can raise BP in sodium sensitive individuals. Short term use, creates water retention',
     'Cardiovascular Herbal Support', 180),

    -- Q19 (correct=c) — Motherwort indication
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Motherwort is specifically indicated for which cardiovascular symptom?',
     'Hypertension',
     'Chest pain',
     'Palpitations',
     'Edema',
     'c',
     'The notes state motherwort "reduces palpitations" — it is a classic herb for irregular or rapid heartbeat sensations.',
     'motherwort - reduces palpitations, antispasmodic, but can exacerbate hypothyroidal issues',
     'Cardiovascular Herbal Support', 190),

    -- Q20 (correct=d) — Motherwort safety
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which patient population should use motherwort with caution according to these notes?',
     'Those with hyperthyroidism',
     'Pregnant women',
     'Those with hypertension',
     'Those with hypothyroidal issues',
     'd',
     'The notes state motherwort "can exacerbate hypothyroidal issues" — this is a specific contraindication for patients with underactive thyroid.',
     'motherwort - reduces palpitations, antispasmodic, but can exacerbate hypothyroidal issues',
     'Cardiovascular Herbal Support', 200),

    -- Q21 (correct=a) — Motherwort secondary action
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What secondary action does motherwort have beyond palpitation relief?',
     'Antispasmodic',
     'Diuretic',
     'Adaptogenic',
     'Cardiotonic',
     'a',
     'The notes describe motherwort as both palpitation-reducing and "antispasmodic" — relaxing smooth muscle spasms in the cardiovascular system.',
     'motherwort - reduces palpitations, antispasmodic, but can exacerbate hypothyroidal issues',
     'Cardiovascular Herbal Support', 210),

    -- Q22 (correct=b) — Garlic #1 for what
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Garlic is described as "#1" for what clinical category in these notes?',
     'Infection and immunity',
     'Heart medicine (cardiovascular health)',
     'Digestive support',
     'Anti-inflammatory conditions',
     'b',
     'The notes call garlic "#1 heart medicine" — its LDL-lowering and HDL-raising effects place it at the top of cardiovascular herbs.',
     'garlic - lower LDL and increases HDL to reduce inflammation - #1 heart medicine',
     'Cardiovascular Herbal Support', 220),

    -- Q23 (correct=c) — Garlic lipid effects
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What specific lipid changes does garlic produce according to these notes?',
     'Raises both LDL and HDL',
     'Lowers both LDL and HDL',
     'Lowers LDL and increases HDL',
     'No direct effect on LDL/HDL',
     'c',
     'The notes state garlic "lower LDL and increases HDL to reduce inflammation" — a favorable lipid profile shift that reduces cardiovascular risk.',
     'garlic - lower LDL and increases HDL to reduce inflammation - #1 heart medicine',
     'Cardiovascular Herbal Support', 230),

    -- Q24 (correct=d) — Turmeric + Sassafras pair
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Turmeric and sassafras share which two cardiovascular actions in these notes?',
     'Cardiotonic and diuretic',
     'Adaptogenic and antioxidant',
     'Vasodilatory and nervine',
     'Anti-inflammatory to reduce LDL, and decrease platelet aggregation',
     'd',
     'The notes pair them: "AI properties to reduce LDL and decrease platelet aggregation (clots)" — both actions together address lipids and clot prevention.',
     'turmeric, sassafras - AI properties to reduce LDL and decrease platelet aggregation (clots)',
     'Cardiovascular Herbal Support', 240),

    -- Q25 (correct=a) — Which herb paired with turmeric
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which herb is paired with turmeric for anti-inflammatory cardiovascular effects in these notes?',
     'Sassafras',
     'Hawthorn',
     'Prickly ash',
     'Garlic',
     'a',
     'The notes list "turmeric, sassafras" together with shared "AI properties" — sassafras is the pairing herb for this cardiovascular action.',
     'turmeric, sassafras - AI properties to reduce LDL and decrease platelet aggregation (clots)',
     'Cardiovascular Herbal Support', 250),

    -- Q26 (correct=b) — Horse chestnut/stoneroot use
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Horse chestnut, stoneroot, and horsebalm are specifically used for which vascular condition?',
     'Arterial hypertension and atherosclerosis',
     'Varicose veins and improving venous return to the heart',
     'Deep vein thrombosis',
     'Pulmonary hypertension',
     'b',
     'The notes state these herbs "address the veins to bring fluid back up to the heart and can also be used to address varicose veins" — venous return and varicosities.',
     'Horse chestnut, stoneroot, horsebalm - addresses the veins to bring fluid back up to the heart and can also be used to address varicose veins',
     'Cardiovascular Herbal Support', 260),

    -- Q27 (correct=c) — Horsebalm = stoneroot
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     '"Horsebalm" is another common name for which herb?',
     'Horse chestnut (Aesculus hippocastanum)',
     'Prickly ash (Zanthoxylum americanum)',
     'Stoneroot (Collinsonia canadensis)',
     'Gotu kola (Centella asiatica)',
     'c',
     'Horsebalm is an alternate common name for Collinsonia canadensis (stoneroot) — both names appear together in the notes referring to the same plant.',
     'Horse chestnut, stoneroot, horsebalm - addresses the veins to bring fluid back up to the heart and can also be used to address varicose veins',
     'Cardiovascular Herbal Support', 270),

    -- Q28 (correct=d) — Gotu kola action
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What is gotu kola''s primary action in cardiovascular support?',
     'Vasodilation',
     'Anti-platelet aggregation',
     'Diuresis to reduce blood volume',
     'Restore connective tissue and improve integrity of veins/arteries',
     'd',
     'The notes say gotu kola is used "to restore connective tissue, improve integrity of veins/arteries to strengthen the heart muscle" — structural vascular repair.',
     'gotu kola - to restore connective tissue, improve integrity of veins/arteries to strengthen the heart muscle',
     'Cardiovascular Herbal Support', 280),

    -- Q29 (correct=a) — Gotu kola target structures
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Gotu kola''s vascular strengthening effect targets which structures specifically?',
     'Veins and arteries (connective tissue integrity)',
     'Lymphatic vessels',
     'Capillary walls specifically',
     'Heart valves',
     'a',
     'The notes specifically name "veins/arteries" as the target for gotu kola''s connective tissue restoration — supporting vascular wall integrity.',
     'gotu kola - to restore connective tissue, improve integrity of veins/arteries to strengthen the heart muscle',
     'Cardiovascular Herbal Support', 290),

    -- Q30 (correct=b) — Lung tonics list
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which four herbs are listed as Lung Tonics in the Cardiovascular Herbal Support section?',
     'Mullein, elderberry, plantain, eleuthero',
     'Mullein, reishi, plantain, eleuthero',
     'Mullein, reishi, yarrow, eleuthero',
     'Rosemary, reishi, plantain, eleuthero',
     'b',
     'The notes list exactly: "mullein, reishi, plantain, eleuthero" as Lung Tonics — elderberry, yarrow, and rosemary are not in this group.',
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'Cardiovascular Herbal Support', 300),

    -- Q31 (correct=c) — Eleuthero common name
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which lung tonic is commonly known as "eleuthero"?',
     'Mullein',
     'Reishi Mushroom',
     'Siberian Ginseng',
     'Plantain',
     'c',
     'Eleuthero is the common abbreviated name for Siberian Ginseng (Eleutherococcus senticosus) — frequently used in the class notes.',
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'Cardiovascular Herbal Support', 310),

    -- Q32 (correct=d) — Lung tonic that is a mushroom
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which lung tonic listed in these notes is a mushroom?',
     'Eleuthero',
     'Mullein',
     'Plantain',
     'Reishi',
     'd',
     'Reishi (Ganoderma lucidum) is the only mushroom in the lung tonics list — mullein, plantain, and eleuthero are all plant herbs.',
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'Cardiovascular Herbal Support', 320),

    -- Q33 (correct=a) — Plantain as lung tonic
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'In these class notes, plantain is listed as what type of tonic?',
     'Lung tonic',
     'Kidney tonic',
     'Cardiovascular tonic',
     'Nervous system tonic',
     'a',
     'Plantain is explicitly listed among the Lung Tonics alongside mullein, reishi, and eleuthero in the Cardiovascular Herbal Support section.',
     'Lung Tonics: mullein, reishi, plantain, eleuthero',
     'Cardiovascular Herbal Support', 330),

    -- Q34 (correct=b) — Bladderwrack = Kelp
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'The herb commonly called "bladderwrack" is identified in the herbal database as which plant?',
     'Cleavers (Galium aparine)',
     'Kelp (Fucus vesiculosus)',
     'Goldenrod (Solidago virgaurea)',
     'Irish Moss (Chondrus crispus)',
     'b',
     'Bladderwrack is a common name for Fucus vesiculosus, which is in the database as Kelp — it is listed in the kidney/bladder tonics group.',
     'Kidney/Bladder Tonics: dandelion leaf, goldenrod, cleavers, bladderwrack (Fucus vesiculosus / Kelp)',
     'Cardiovascular Herbal Support', 340),

    -- Q35 (correct=c) — Dandelion leaf dual role
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Dandelion leaf appears twice in Cardiovascular Herbal Support — what are its two listed roles?',
     'Anti-inflammatory and liver support',
     'Cardiotonic and lymphatic tonic',
     'Diuretic for cardiovascular support and kidney/bladder tonic',
     'Nervine and adaptogen',
     'c',
     'Dandelion leaf is listed first as a standalone diuretic ("dandelion leaf - diuretic") and again in the Kidney/Bladder Tonics sublist — two distinct cardiovascular roles.',
     'dandelion leaf - diuretic (cardiovascular support)',
     'Cardiovascular Herbal Support', 350),

    -- Q36 (correct=d) — Kidney/bladder tonic listed
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which herb is listed as a Kidney/Bladder Tonic in these notes?',
     'Prickly ash',
     'Hawthorn',
     'Motherwort',
     'Goldenrod',
     'd',
     'Goldenrod is explicitly listed in the Kidney/Bladder Tonics group; prickly ash is circulatory, hawthorn is cardiotonic, and motherwort is for palpitations.',
     'Kidney/Bladder Tonics: dandelion leaf, goldenrod, cleavers, bladderwrack (Fucus vesiculosus / Kelp)',
     'Cardiovascular Herbal Support', 360),

    -- Q37 (correct=a) — Marshmallow spring use
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Why might you use marshmallow leaves and flowers in spring rather than the root?',
     'Leaves and flowers contain less polysaccharides, requiring less moistening in spring',
     'The root is unavailable in spring',
     'Leaves have stronger anti-inflammatory properties',
     'The root is toxic in spring',
     'a',
     'The notes explain leaves and flowers have "less polysaccharides, but maybe you don''t need so much moistening in the spring" — seasonal adjustment to the degree of demulcency needed.',
     'maybe use the leaves and flowers in this season - less polysaccharides, but maybe you don''t need so much moistening in the spring; glycerin may be a better match for the polysaccharides than the alcohol tincture, which breaks them down',
     'Marshmallow Recap', 370),

    -- Q38 (correct=b) — Marshmallow best solvent
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What preparation is recommended as a better solvent for marshmallow''s polysaccharides than alcohol tincture?',
     'Vinegar extraction',
     'Glycerin',
     'Water decoction',
     'Cold infusion in wine',
     'b',
     'The notes state "glycerin may be a better match for the polysaccharides than the alcohol tincture, which breaks them down" — glycerin preserves polysaccharides that alcohol degrades.',
     'maybe use the leaves and flowers in this season - less polysaccharides, but maybe you don''t need so much moistening in the spring; glycerin may be a better match for the polysaccharides than the alcohol tincture, which breaks them down',
     'Marshmallow Recap', 380),

    -- Q39 (correct=c) — Prickly ash function
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What specific function does prickly ash serve in cardiovascular support?',
     'Blood thinning',
     'Diuresis',
     'Circulatory stimulant',
     'Vasodilation',
     'c',
     'The notes describe prickly ash as "circulatory" — it stimulates circulation and is used to move blood and lymph throughout the body.',
     'prickly ash - circulatory',
     'Cardiovascular Herbal Support', 390),

    -- Q40 (correct=d) — Rosemary cognitive benefit
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Rosemary''s noted benefit in cardiovascular and neurological support is described as what?',
     'Sedative for cardiac anxiety',
     'Anti-inflammatory for arterial walls',
     'Diuretic for blood volume management',
     'Cognitive repair (antioxidant, flavonoid)',
     'd',
     'The notes say rosemary provides "flavonoid, antioxidant, cognitive repair" — its antioxidant flavonoids support brain and vascular health.',
     'rosemary - flavonoid, antioxidant, cognitive repair',
     'Cardiovascular Herbal Support', 400),

    -- Q41 (correct=a) — Nervines for CV support
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which two herbs are listed as nervines for cardiovascular support in these notes?',
     'Oat straw/oat tops and asafetida',
     'Motherwort and valerian',
     'Skullcap and passionflower',
     'Lemon balm and chamomile',
     'a',
     'The notes group "oat straw/oat tops, asafetida" together as nervines — the nervous system''s role in cardiovascular health makes nervine support part of cardiac care.',
     'oat straw/oat tops, asafetida - nervine (cardiovascular support)',
     'Cardiovascular Herbal Support', 410),

    -- Q42 (correct=b) — Okra + hibiscus benefit
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'The okra water recipe with hibiscus provides what specific urinary benefit?',
     'Kidney stone dissolution',
     'Bladder and urinary assistance',
     'Urinary tract infection treatment',
     'Kidney inflammation reduction',
     'b',
     'The notes state the okra-hibiscus combination provides "bladder and urinary assistance" — both herbs have demulcent and urinary-soothing properties.',
     'okra pairs well with hibiscus - make a hibiscus hot decoction, 30 mins, let steep for several hours; bladder and urinary assistance',
     'Okra Water', 420),

    -- Q43 (correct=c) — Poke safety note
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'According to the class notes, what is the safety note about Poke?',
     'All parts of Poke are toxic at all times',
     'Only the berries are toxic; leaves are always safe',
     'Leaves can be eaten when the berry is white (not yet red)',
     'The root is always safe; berries and leaves are toxic',
     'c',
     'The notes state "can eat the leaves when the berry is white, not yet red" — once berries ripen to red, the whole plant is considered toxic.',
     'Poke - Poisonous? can eat the leaves when the berry is white, not yet red',
     'Cardiovascular Herbal Support', 430),

    -- Q44 (correct=d) — Hibiscus seasonal timing
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'According to these notes, when is hibiscus especially recommended?',
     'Year-round with no seasonal preference',
     'In winter to warm the body',
     'In spring for cleansing',
     'When the season shifts into hotter temps',
     'd',
     'The notes say "hibiscus when the season shifts into hotter temps" — hibiscus is a cooling, tropical herb most appropriate as temperatures rise.',
     'hibiscus when the season shifts into hotter temps - nutritive, suppress appetite - also an emmenagogue; high in Mg, affinity for heart health (electrical contraction); can lower blood pressure, vasodilation (ACE mechanism) and diuretic to reduce blood volume (in case of stroke)',
     'Blood Flows', 440),

    -- Q45 (correct=a) — Red Drank optional add-ins
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'What optional cardiovascular herbs are suggested to add after making the Red Drank?',
     'Hawthorn and elderberry',
     'Garlic and turmeric',
     'Motherwort and hibiscus',
     'Goldenrod and cleavers',
     'a',
     'The notes suggest "after, maybe add hawthorn, elderberry?" — both are classic cardiovascular/immune-supportive herbs that would complement the hibiscus base.',
     'after Red Drank, maybe add hawthorn, elderberry? - optional cardiovascular add-ins',
     'Red Drank', 450),

    -- Q46 (correct=b) — Hibiscus decoction prep for okra water
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'How should a hibiscus decoction be prepared for the okra water combination?',
     'Cold infused overnight',
     'Hot decoction for 30 minutes, then steeped for several hours',
     'Quick 5-minute boil',
     'One-hour slow simmer',
     'b',
     'The notes specify "make a hibiscus hot decoction, 30 mins, let steep for several hours" — a longer steeping after decoction extracts the mucilaginous compounds.',
     'okra pairs well with hibiscus - make a hibiscus hot decoction, 30 mins, let steep for several hours; bladder and urinary assistance',
     'Okra Water', 460),

    -- Q47 (correct=c) — Hawthorn appears in multiple sections
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which herb appears in both the Blood Flows discussion and the Cardiovascular Herbal Support section of these notes?',
     'Garlic',
     'Motherwort',
     'Hawthorn',
     'Turmeric',
     'c',
     'Hawthorn is mentioned in Blood Flows as a climate comparison to hibiscus, and again in Cardiovascular Herbal Support as a cardiotonic — demonstrating its centrality to this class.',
     'compare to hawthorn, but hawthorn is not native to North America - hawthorn good for colder climates, but hibiscus from Africa, tropical',
     'Blood Flows', 470),

    -- Q48 (correct=d) — Stoneroot category
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Stoneroot belongs to which broader herb category in the Cardiovascular Herbal Support section?',
     'Lung tonics',
     'Kidney/bladder tonics',
     'Nervines',
     'Venous herbs (cardiovascular herbal support)',
     'd',
     'Stoneroot is in the main Cardiovascular Herbal Support list alongside hawthorn, garlic, and gotu kola — specifically for venous conditions, not the lung or kidney sublists.',
     'Horse chestnut, stoneroot, horsebalm - addresses the veins to bring fluid back up to the heart and can also be used to address varicose veins',
     'Cardiovascular Herbal Support', 480),

    -- Q49 (correct=a) — Lemon balm in okra water
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Which herb is paired with lemon balm in the okra water recipe?',
     'Mint',
     'Hibiscus',
     'Ginger',
     'Turmeric',
     'a',
     'The notes list the okra water mixture as "filtered water, okra, mint, and lemon balm" — mint and lemon balm are the two herbs in the base recipe.',
     'Okra water mixture: filtered water, okra, mint, and lemon balm',
     'Okra Water', 490),

    -- Q50 (correct=b) — Dandelion leaf cardiovascular mechanism
    ('BHC - Class 18 - Cardiovascular System and Compost - Shereel and Alder',
     'Dandelion leaf provides which specific cardiovascular support mechanism?',
     'Anti-platelet action',
     'Diuretic to support blood volume management',
     'Cardiotonic strengthening of myocardium',
     'Anti-inflammatory to reduce arterial plaque',
     'b',
     'The notes list dandelion leaf as a diuretic in cardiovascular support — reducing blood volume through urinary elimination supports blood pressure management.',
     'dandelion leaf - diuretic (cardiovascular support)',
     'Cardiovascular Herbal Support', 500);

END $$;
