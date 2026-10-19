-- Migration 419: BHC Class 7 – Digestion II and Nutrition I quiz questions
--
-- Target calculation:
--   H = 65 distinct herbs/supplements
--   F = 10 named factual items (Myrrh 75-90%, Mg 500mg/day, Vitamin D 70s range,
--       Ginger fresh/dry split, Red Root color = medicinal, Chaga unheated = inactive,
--       tea steep 1-4 hours, Corydalis+Dahhurian Angelica TCM pair,
--       protein .8g/kg baseline, Shatavari Ayurveda tradition)
--   target = clamp(15 + 65×4 + 10×1, 20, 50) = clamp(285, 20, 50) = 50

SET search_path TO herbal, public;

DO $$
DECLARE
  v_class CONSTANT TEXT := 'BHC - Class 7 - Digestion II and Nutrition I';
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 7 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- 1 (correct=a)
  (v_class,
   'Which herb is described as "bowl on the table!" as the go-to carminative for bloating?',
   'Fennel Seed', 'Cardamom', 'Peppermint', 'Chamomile',
   'a',
   'The notes single out Fennel Seed with this memorable phrase, marking it as the primary carminative to have readily available for bloating.',
   'Fennel Seed - bowl on the table! (carminative for bloating)',
   'Bloating', 10),

  -- 2 (correct=b)
  (v_class,
   'Which form of Ginger has more immune-boosting polysaccharide with demulcent action?',
   'Dry ginger', 'Fresh ginger', 'Ginger tincture', 'Ginger powder capsule',
   'b',
   'The notes state fresh ginger has more immune-boosting polysaccharide, whose herbal action is demulcent, while dry ginger has more diaphoretic activity.',
   'Ginger - always prefer fresh for digestion; dry is superconcentrated heat; fresh has more immune boosting polysaccharide (demulcent action); dry has more diaphoretic',
   'Nausea', 20),

  -- 3 (correct=c)
  (v_class,
   'For Hot Damp Diarrhea, which herb is specifically noted for "sudden onset" presentations?',
   'Goldenseal', 'Blackberry Root', 'Yellow Pond Lily Root', 'Garden Sage',
   'c',
   'Yellow Pond Lily Root is listed parenthetically as indicated for Hot Damp or sudden onset diarrhea, distinguishing it from the others on the Hot Damp list.',
   'Yellow Pond Lily Root - for Hot Damp Diarrhea or sudden onset (astringent)',
   'Diarrhea', 30),

  -- 4 (correct=d)
  (v_class,
   'Which two herbs form the "classic Eclectic pair for digestion" mentioned in the notes?',
   'Chamomile and Ginger', 'Turmeric and Dandelion root', 'Goldenseal and Cinnamon', 'Myrrh and Goldenseal',
   'd',
   'The notes explicitly name Myrrh + Goldenseal as the classic Eclectic pair for digestion, credited to 19th-century Eclectic physicians.',
   'Myrrh + Goldenseal was a classic Eclectic pair for digestion',
   'Diarrhea', 40),

  -- 5 (correct=b)
  (v_class,
   'Shatavari (Asparagus racemosus) comes from which traditional medicine system?',
   'Traditional Chinese Medicine', 'Ayurveda', 'Unani', 'Eclectic medicine',
   'b',
   'The notes identify Shatavari as from the Ayurveda tradition, noting it as an adaptogen that tonifies the uterus and moistens tissues.',
   'Shatavari (Asparagus racemosus) - for Cold Dry Constipation; adaptogen; uterus tonifying; helps moisten tissues - vagina and GI tract',
   'Constipation', 50),

  -- 6 (correct=c)
  (v_class,
   'Cardamom is particularly indicated for bloating when there is a correlation with what?',
   'Liver congestion', 'Food sensitivities', 'The nervous system', 'Excess HCl',
   'c',
   'The notes specify Cardamom when there is a correlation between the nervous system and bloating, and suggest using it as a bitter in a glycerite or infused into honey.',
   'Cardamom - if correlation between NS and bloating; Cardamom bitter in a glycerite; infuse into honey and sweeten your tea!',
   'Bloating', 60),

  -- 7 (correct=a)
  (v_class,
   'For Cold Dry Constipation, which herb is described as moistening tissues of both the vagina and GI tract?',
   'Shatavari', 'Licorice', 'Marshmallow', 'Dong Quai',
   'a',
   'Shatavari is specifically described as helping moisten tissues — both vaginal and GI — making it the primary Cold Dry Constipation herb with tissue-moistening action.',
   'Shatavari (Asparagus racemosus) - for Cold Dry Constipation; adaptogen; uterus tonifying; helps moisten tissues - vagina and GI tract',
   'Constipation', 70),

  -- 8 (correct=d)
  (v_class,
   'Which herb is described as the "eclectic remedy for swelling of the pancreas"?',
   'Red Root', 'Dandelion root', 'Turmeric', 'Milk Thistle',
   'd',
   'Milk Thistle is specifically named as the Eclectic remedy for swelling of the pancreas, used as a standardized extract or tincture.',
   'Milk Thistle - eclectic remedy for swelling of pancreas; use standardized extract or tincture',
   'Pancreatitis', 80),

  -- 9 (correct=b)
  (v_class,
   'How do you identify a medicinal Red Root vs the non-medicinal ornamental variety?',
   'Medicinal plants have white flowers', 'Medicinal plants have red roots', 'Medicinal plants have purple flowers', 'Medicinal plants have yellow roots',
   'b',
   'The notes state: "if the root is red, it is medicinal" — the ornamental variety has purple flowers and is not medicinal.',
   'Red Root (Ceanothus) - foamy tincture, very tannin-y; saponins in flowers and root; energetically moving; master lymph mover; can thin the blood; if the root is red, it is medicinal',
   'Pancreatitis', 90),

  -- 10 (correct=c)
  (v_class,
   'Which herb inhibits pancreatic fibrosis and is described as anti-inflammatory for pancreatitis?',
   'Frankincense', 'Chaga', 'Turmeric', 'Milk Thistle',
   'c',
   'Turmeric is specifically noted for inhibiting pancreatic fibrosis and its anti-inflammatory action, and is combined with Frankincense in the "Curamed" extract.',
   'Turmeric - inhibits pancreatic fibrosis, anti-inflammatory; "Curamed" by Terry''s Naturals - concentrated extract + frankincense for AI',
   'Pancreatitis', 100),

  -- 11 (correct=a)
  (v_class,
   'For gallstone pain, which herb is indicated for "sharp spasmodic pain anywhere in the GI" and can be used both preventively and acutely?',
   'Wild Yam', 'Stoneroot', 'Corydalis', 'Yellow Dock',
   'a',
   'Wild Yam is described as the go-to herb for sharp spasmodic GI pain, useful both preventively and in acute gallstone situations.',
   'Wild Yam - analgesic for sharp spasmodic GI pain; useful acutely and preventively for gallstone spasm',
   'Gallstones', 110),

  -- 12 (correct=d)
  (v_class,
   'What is the first-line herbal approach before adding bitters for hypochlorhydria?',
   'HCL stimulating herbs like Ginger', 'Warming bitters like Angelica', 'Carminatives like Peppermint', 'Demulcents: Marshmallow root, Chamomile cold infusion, Slippery Elm',
   'd',
   'The notes describe a staged approach: demulcents first (Marshmallow root, Chamomile cold infusion, Slippery Elm), then add balanced bitters — not HCL stimulants immediately.',
   'First: Marshmallow root, demulcents; Chamomile cold infusion; Slippery Elm powder, maybe in honey; then combining of warming + cooling bitters',
   'Hypochlorhydria', 120),

  -- 13 (correct=b)
  (v_class,
   'Which herb is specifically recommended when bloating correlates with nervous system involvement, prepared as a bitter in a glycerite?',
   'Fennel', 'Cardamom', 'Lemon Balm', 'Chamomile',
   'b',
   'Cardamom is flagged for nervous system-linked bloating and specifically suggested as a bitter in a glycerite or infused in honey.',
   'Cardamom - if correlation between NS and bloating; Cardamom bitter in a glycerite; infuse into honey and sweeten your tea!',
   'Bloating', 130),

  -- 14 (correct=c)
  (v_class,
   'Meadowsweet is described as a cooling GI tonic specifically for which part of the digestive tract?',
   'Lower GI and bowel', 'Liver and gallbladder', 'Upper GI always', 'Pancreas and spleen',
   'c',
   'The notes double-emphasize Meadowsweet with "!!" and the phrase "upper GI always!" — it is the go-to herb for upper GI hyperacidity.',
   'Meadowsweet - cooling GI tonic for hyperchlorhydria; upper GI always!',
   'Hyperchlorhydria', 140),

  -- 15 (correct=a)
  (v_class,
   'Which two herbs form the "classic sacred pairing" in TCM for biliary and GI spasmodic pain?',
   'Corydalis and Dahhurian Angelica', 'Myrrh and Goldenseal', 'Wild Yam and Cramp Bark', 'Ginger and Licorice',
   'a',
   'The notes describe Corydalis + Dahhurian Angelica as a classic sacred pairing in TCM, both low-dose herbs, with Corydalis causing drowsiness.',
   'Corydalis + Dahhurian Angelica - "classic sacred pairing" in TCM for gallstone/biliary pain; low dose herb - sleepy',
   'Gallstones', 150),

  -- 16 (correct=d)
  (v_class,
   'Chaga is noted to have what requirement before it is medicinally active?',
   'Must be taken with food', 'Must be extracted in high-alcohol tincture', 'Must be dried for at least one year', 'Must be heated — not medicinally active until heated',
   'd',
   'The notes state Chaga "reduces inflammation; not medicinally active until heated" — distinguishing it from herbs used in cold preparations.',
   'Chaga - reduces inflammation in pancreatitis; not medicinally active until heated',
   'Pancreatitis', 160),

  -- 17 (correct=b)
  (v_class,
   'What type of tongue presentation is associated with Cold Damp Diarrhea?',
   'Red tongue with yellow coating', 'White coated tongue', 'Red tongue with no coating', 'Dry cracked tongue',
   'b',
   'The notes list white coated tongue as a distinguishing sign of Cold Damp Diarrhea (along with borborygmus, loose stools, undigested food particles).',
   'Cold Damp Diarrhea: chronic, loose stools, undigested food particles, borborgymus, white coated tongue, abdominal distention',
   'Diarrhea', 170),

  -- 18 (correct=a)
  (v_class,
   'Which herb is noted as an "aperient to soften" stool for Deficient or Laxative Dependent Constipation?',
   'Yellow Dock', 'Psyllium', 'Fenugreek', 'Calendula',
   'a',
   'Yellow Dock is specifically described as an aperient (mild laxative) to soften stool, appropriate for Deficient or Laxative Dependent Constipation.',
   'Yellow Dock - aperient to soften stool; for Deficient/Laxative Dependent Constipation',
   'Constipation', 180),

  -- 19 (correct=c)
  (v_class,
   'What percentage is specified for Myrrh tincture as cited from Eclectic practice?',
   '25-40%', '50-60%', '75-90%', '40-60%',
   'c',
   'The notes cite Eclectic physicians recommending Myrrh resins in small amounts at 75-90% alcohol — a high-alcohol extraction appropriate for resins.',
   'Myrrh - Eclectic physicians - use resins in small amount, 75%-90% alcohol (for Cold Damp Diarrhea)',
   'Diarrhea', 190),

  -- 20 (correct=d)
  (v_class,
   'What is the optimum steep time for nutrient-rich teas as a supplement to ultra-processed food diets?',
   '5-10 minutes', '20-30 minutes', '30-60 minutes', '1-4 hours',
   'd',
   'Lisa recommends steeping nutrient-rich teas (nettle, alfalfa, red clover, lemon balm, raspberry) for 1-4 hours to maximize vitamin and mineral extraction.',
   'nutrient-rich teas are a good support here; rich in vits and mins and alkalizing to the gut; optimum steep for 1-4 hours',
   'Ultra Processed Foods', 200),

  -- 21 (correct=b)
  (v_class,
   'For Hot Dry Constipation, which demulcent herb is noted as "not as mucilaginous as others"?',
   'Flax seed', 'Calendula', 'Marshmallow', 'Slippery Elm',
   'b',
   'Calendula is listed as a demulcent cooling herb for Hot Dry Constipation with the qualifier "not as mucilaginous as others" — useful but less potent than Marshmallow or Slippery Elm.',
   'Calendula (not as mucilagenous as others) — for Hot Dry Constipation',
   'Constipation', 210),

  -- 22 (correct=a)
  (v_class,
   'Red Root is described as what kind of systemic herb in the notes?',
   'Master lymph mover, whole body', 'Master hepatoprotective herb', 'Primary GI astringent', 'Top immune stimulant',
   'a',
   'The notes specifically call Red Root "master lymph mover, whole body" — it is energetically moving, lymphatic, and can thin blood in high HB/HS/blood lipid situations.',
   'Red Root (Ceanothus) - foamy tincture, very tannin-y; saponins in flowers and root; energetically moving; master lymph mover, whole body; can thin the blood',
   'Pancreatitis', 220),

  -- 23 (correct=d)
  (v_class,
   'Dry Ginger has more of which action compared to fresh Ginger?',
   'Demulcent', 'Immune stimulating', 'Carminative', 'Diaphoretic',
   'd',
   'The notes contrast fresh vs dry: fresh has more immune-boosting polysaccharide (demulcent); dry ginger has more diaphoretic activity.',
   'Ginger - always prefer fresh for digestion; dry is superconcentrated heat; fresh has more immune boosting polysaccharide (demulcent action); dry has more diaphoretic',
   'Nausea', 230),

  -- 24 (correct=b)
  (v_class,
   'What form and dose of Magnesium is recommended for Deficient Constipation?',
   'Magnesium oxide, 250mg/day', 'Magnesium bisglycinate, 500mg/day', 'Magnesium citrate, 200mg/day', 'Magnesium sulfate, 400mg/day',
   'b',
   'The notes specify Mg bisglycinate 500mg/day, along with alternative routes (foot spray, Epsom salt bath). Magnesium Citrate (Natural Calm) is noted for bowel cleanse but causes loose stools initially.',
   'Magnesium (Mg bisglycinate) - 500mg/day for Deficient Constipation; also bottom-of-feet spray or Epsom salt bath',
   'Constipation', 240),

  -- 25 (correct=c)
  (v_class,
   'Which five herbs are specifically recommended as nutrient-rich teas to support patients eating ultra-processed foods?',
   'Chamomile, Peppermint, Ginger, Fennel, Lavender',
   'Echinacea, Elderberry, Astragalus, Nettle, Rosehip',
   'Nettle, red raspberry leaf, alfalfa, lemon balm, red clover',
   'Dandelion, Burdock, Yellow Dock, Milk Thistle, Chicory',
   'c',
   'Lisa''s list for ultra-processed food support is: nettle, red raspberry leaf (red rasp), alfalfa, lemon balm, and red clover — all nutrient-dense teas steeped 1-4 hours.',
   'nutrient-rich teas are a good support here: nettle, red rasp, alfalfa, lemon balm, red clover',
   'Ultra Processed Foods', 250),

  -- 26 (correct=a)
  (v_class,
   'For treating diarrhea, the class notes specify using herbs with what primary action?',
   'Astringents', 'Demulcents', 'Bitters', 'Carminatives',
   'a',
   'The notes state "Diarrhea: Use Astringents — use something that is drying" before listing the Hot Damp and Cold Damp herb lists.',
   'Diarrhea: Use Astringents — use something that is drying',
   'Diarrhea', 260),

  -- 27 (correct=d)
  (v_class,
   'Which herb appears in both the H. pylori inhibiting list AND the gastric mucosa healing list for ulcers?',
   'Thyme', 'Calendula', 'Yarrow', 'Goldenseal',
   'd',
   'Goldenseal is listed for both H. pylori inhibition and gastric mucosa healing — as well as Turmeric, but Goldenseal''s dual role is the more notable clinical point from the notes.',
   'H. Pylori inhibiting herbs: Goldenseal; ... Herbs to heal Gastric mucosa: Calendula; Goldenseal; ...',
   'Ulcers', 270),

  -- 28 (correct=b)
  (v_class,
   'Gotu Kola is described in the ulcers section as indicated for what tissue state?',
   'Cold, pale, and atonic tissue', 'Red, hot, irritated, and inflamed tissue', 'Dry, cracked, and deficient tissue', 'Boggy, damp, and swollen tissue',
   'b',
   'The notes specify Gotu Kola for "anytime tissue is red, hot, irritated and inflamed" — making it specific for gastric mucosa inflammation from ulceration.',
   'Gotu Kola - heals gastric mucosa; anytime tissue is red, hot, irritated and inflamed (peptic ulcer)',
   'Ulcers', 280),

  -- 29 (correct=c)
  (v_class,
   'What is the optimal Vitamin D blood level range mentioned in Lisa''s nutrition notes?',
   'In the 30s', 'In the 50s', 'In the 70s', 'In the 90s',
   'c',
   'Lisa states that 70s is the optimum range for Vitamin D, while most people test in the 30s — indicating widespread deficiency.',
   'Vitamin D - muscle integrity, cardiovascular health, bone health, calcium metabolism; optimum range is 70s; most people test in 30s',
   'Micronutrients', 290),

  -- 30 (correct=a)
  (v_class,
   'Ginger as an HCL stimulating herb has what important contraindication noted in class?',
   'Not indicated during active flareup of hypochlorhydria — better for long-term', 'Contraindicated with demulcent herbs', 'Not safe above 2ml doses', 'Avoid in Cold Dry constitutions',
   'a',
   'The notes explicitly state Ginger as an HCL stimulant "not during active flareup, but better longterm" — making it a maintenance herb, not acute for hypochlorhydria.',
   'Ginger - HCL stimulating herb for hypochlorhydria; not during active flareup, but better long-term',
   'Hypochlorhydria', 300),

  -- 31 (correct=d)
  (v_class,
   'Borborygmus (loud intestinal gurgling) in the context of diarrhea indicates what energetic state?',
   'Hot and excess — too much digestive fire', 'Liver qi stagnation — need movement', 'Yin deficiency — insufficient fluids', 'Cold, deficiency — digestive system needs building',
   'd',
   'The notes state borborygmus "says your digestive system needs some building" and associate it with cold, deficiency — a Cold Damp Diarrhea presentation.',
   'borborgymus - loud intestinal gurgling (cold, deficiency, says your digestive system needs some building)',
   'Diarrhea', 310),

  -- 32 (correct=b)
  (v_class,
   'The cooling bitters for hypochlorhydria include all EXCEPT which?',
   'Blue Vervain', 'Angelica (Archangelica)', 'Hops', 'Motherwort',
   'b',
   'Angelica (Archangelica) is a WARMING bitter for hypochlorhydria, not cooling. Blue Vervain, Hops, and Motherwort are all cooling bitters.',
   'Cooling bitters: Blue Vervain; Artichoke leaf; Dandelion root; Motherwort; Gentian; Hops; Mugwort; Wormwood — Warming bitters: Angelica (Archangelica); Turmeric; Orange Peel; Fenugreek',
   'Hypochlorhydria', 320),

  -- 33 (correct=c)
  (v_class,
   'Stoneroot (Collinsonia canadensis) is classified as what type of herb for gallstones?',
   'Analgesic and antispasmodic', 'Cholagogue and choleretic', 'Antilithic (stone-dissolving)', 'Hepatoprotective',
   'c',
   'Stoneroot is listed under "Antilithics" — herbs that dissolve or prevent stone formation — with a caution that large stones may need analgesics instead.',
   'Stoneroot (Collinsonia canadensis) - antilithic for gallstones; caution if stones are large (analgesics may be needed)',
   'Gallstones', 330),

  -- 34 (correct=a)
  (v_class,
   'Which herbal action category is specifically mentioned for Red Root in relation to blood lipids and blood viscosity?',
   'Anticoagulant (can thin the blood)', 'Astringent (tones vascular tissue)', 'Hepatoprotective (reduces lipid oxidation)', 'Diuretic (reduces blood volume)',
   'a',
   'The notes state Red Root "can thin the blood — if blood is sticky, high BS, study show noticeably thinned — high HB, high HS, high Blood lipids."',
   'Red Root (Ceanothus) - can thin the blood in high HB/HS/blood lipids',
   'Pancreatitis', 340),

  -- 35 (correct=d)
  (v_class,
   'What caution is given for Psyllium husk as a bulking laxative?',
   'Do not use with demulcents', 'Avoid with warming herbs', 'Limit to 3 days maximum use', 'Drink enough water — or it can worsen constipation',
   'd',
   'The notes specifically note "but caution to drink enough water with these" for Psyllium husk — insufficient water can make bulking laxatives counterproductive.',
   'Psyllium husk - bulking laxative for Deficient/Laxative Dependent Constipation; caution: drink enough water',
   'Constipation', 350),

  -- 36 (correct=b)
  (v_class,
   'Which herb for pancreatitis is specifically noted as having saponins in both its flowers and root?',
   'Chaga', 'Red Root', 'Milk Thistle', 'Dandelion root',
   'b',
   'Red Root (Ceanothus) is described as having saponins in both flowers and root, producing a foamy, tannin-rich tincture that is energetically moving.',
   'Red Root (Ceanothus) - foamy tincture, very tannin-y; saponins in flowers and root; energetically moving; master lymph mover, whole body',
   'Pancreatitis', 360),

  -- 37 (correct=c)
  (v_class,
   'What is the recommended treatment strategy for hyperchlorhydria (excess stomach acid)?',
   'Warming bitters + HCL stimulants', 'Nervines + adaptogens', 'Cooling demulcents + cooling GI tonics and nervines', 'Astringents + carminatives',
   'c',
   'For hyperchlorhydria, the notes prescribe cooling demulcents (Marshmallow, Slippery Elm) and cooling GI tonics and nervines (Meadowsweet, Chamomile, Lemon Balm, Licorice, Peach Leaf, Catnip).',
   'Cooling demulcents: Marshmallow, Slippery Elm — Cooling GI Tonics & Nervines: Meadowsweet!! — upper GI always!; Chamomile; Lemon Balm; Licorice; Peach Leaf; Catnip',
   'Hyperchlorhydria', 370),

  -- 38 (correct=a)
  (v_class,
   'The Corydalis + Dahhurian Angelica pair is described as a TCM "sacred pairing" for which type of pain?',
   'Biliary/gallstone spasmodic pain', 'Headache and sinus pain', 'Menstrual cramping', 'Post-surgical nerve pain',
   'a',
   'The context in the notes is the gallstones section — Corydalis + Dahhurian Angelica is given as an analgesic option for sharp gallstone or biliary colic pain.',
   'Corydalis + Dahhurian Angelica - "classic sacred pairing" in TCM for gallstone/biliary pain; low dose herb - sleepy',
   'Gallstones', 380),

  -- 39 (correct=d)
  (v_class,
   'What dosing consideration is specifically noted for Gentian in the hypochlorhydria section?',
   'Take on an empty stomach', 'Combine only with warming bitters', 'Avoid in liver conditions', 'Use in small doses',
   'd',
   'The notes list Gentian as a cooling bitter for hypochlorhydria with the specific qualifier "small doses" — indicating it is potent and should be used conservatively.',
   'Gentian - cooling bitter for hypochlorhydria; use in small doses',
   'Hypochlorhydria', 390),

  -- 40 (correct=b)
  (v_class,
   'Which mineral supplement is described as depleted by stress and specific for the nervous system?',
   'Zinc', 'Magnesium', 'Calcium', 'Iron',
   'b',
   'Lisa''s notes state Magnesium "gets depleted by stress; specific for nervous system" and recommend Atlantic or Celtic gray salt as a dietary source.',
   'Magnesium - depleted by stress; specific for nervous system; Atlantic or Celtic gray salt rich in Mg',
   'Micronutrients', 400),

  -- 41 (correct=c)
  (v_class,
   'The Latin name Asparagus racemosus in the class notes refers to which herb?',
   'Aloe', 'Licorice', 'Shatavari', 'Ashwagandha',
   'c',
   'The notes use both common name Shatavari and the Latin "Asparagus racemosas" (Asparagus racemosus) — an Ayurvedic adaptogen for Cold Dry Constipation.',
   'Shatavari (Asparagus racemosus) - for Cold Dry Constipation; adaptogen; uterus tonifying; helps moisten tissues',
   'Constipation', 410),

  -- 42 (correct=a)
  (v_class,
   'Which herb with Chinese Skullcap (Bikhail/Baikal Skullcap) is used for Hot Damp Diarrhea?',
   'Chinese Skullcap (Scutellaria baicalensis)', 'American Skullcap (Scutellaria lateriflora)', 'Sage-leaved Skullcap', 'Chinese Skullcap (Scutellaria barbata)',
   'a',
   '"Bikhail Skullcap" in the notes refers to Baikal/Baical Skullcap, which is Chinese Skullcap (Scutellaria baicalensis) — used for Hot Damp Diarrhea alongside Goldenseal and Sage.',
   'Bikhail Skullcap (Baikal/Chinese Skullcap) - for Hot Damp Diarrhea',
   'Diarrhea', 420),

  -- 43 (correct=d)
  (v_class,
   'What distinguishes hyperchlorhydria from hypochlorhydria on physical exam?',
   'Hyperchlorhydria has a white coated tongue; hypochlorhydria has a red tongue',
   'Hyperchlorhydria has excess gas and belching; hypochlorhydria has no gas',
   'Hyperchlorhydria is seen in older patients; hypochlorhydria in younger ones',
   'Hyperchlorhydria shows red receding gums and pointed red tongue; hypochlorhydria has lots of gas and belching',
   'd',
   'The notes distinguish: hyperchlorhydria = red receding gums + pointed red tongue + younger + little to no gas; hypochlorhydria = excessive gas or belching, borborygmus, and bloating.',
   'Hyperchlorhydria diagnostic signs: red receding gums; pointed red tongue; younger — Hypochlorhydria symptoms: excessive gas or belching; borborygmus; bloating',
   'Hyperchlorhydria', 430),

  -- 44 (correct=b)
  (v_class,
   'Which herbal action is attributed to fresh Ginger specifically related to its polysaccharide content?',
   'Diaphoretic', 'Demulcent', 'Bitter', 'Anti-inflammatory',
   'b',
   'The notes state "fresh also has more immune boosting polysaccharide — herbal action associated with polysaccharide is demulcent."',
   'Ginger - fresh has more immune boosting polysaccharide (demulcent action)',
   'Nausea', 440),

  -- 45 (correct=c)
  (v_class,
   'For Cold Dry Constipation, which herbal form of preparation is specifically recommended?',
   'Alcohol tincture', 'Glycerite', 'Decoction (tea)', 'Capsule',
   'c',
   'The notes state: "preference, use herbs in form of tea, as a decoction (all of the above are all roots — roots, barks, berries, seeds get decocted)".',
   'Cold Dry Constipation herbs: Dang gui, Shatavari, Fenugreek, Licorice — preference, use herbs in form of tea, as a decoction',
   'Constipation', 450),

  -- 46 (correct=a)
  (v_class,
   'Psyllium husk is classified as which type of laxative?',
   'Bulking laxative', 'Stimulant laxative', 'Osmotic laxative', 'Lubricant laxative',
   'a',
   'The notes explicitly call Psyllium husk a "bulking laxative" — appropriate for Deficient or Laxative Dependent Constipation, with the caution to drink enough water.',
   'Bulking laxatives, like Psyllium husk - caution: drink enough water',
   'Constipation', 460),

  -- 47 (correct=d)
  (v_class,
   'In the nausea section, Lobelia is mentioned as a contrast herb. What is its relevant action?',
   'Antiemetic (stops nausea)', 'Demulcent (coats irritated mucosa)', 'Nervine (settles nausea from anxiety)', 'Emetic (can itself cause nausea/vomiting)',
   'd',
   'The notes mention Lobelia parenthetically as "an emetic itself" — the opposite of antiemetic — as a contrast to the herbs being discussed for treating nausea.',
   'Lobelia - an emetic itself (not antiemetic); mentioned as contrast herb in nausea section',
   'Nausea', 470),

  -- 48 (correct=b)
  (v_class,
   'Which carminative herb is noted as specific for hypochlorhydria among those listed?',
   'Rosemary', 'Calamus', 'Fennel', 'Lavender',
   'b',
   'Calamus (Acorus calamus rhizome) is listed as a carminative specifically in the hypochlorhydria section, along with Cardamom, Catnip, Lemon Balm, Cinnamon, Damiana, Rosemary, Lavender, Sage, and Peppermint.',
   'Calamus - carminative for hypochlorhydria',
   'Hypochlorhydria', 480),

  -- 49 (correct=c)
  (v_class,
   'What does the "Trikatu" formula mentioned in the hypochlorhydria section consist of?',
   'Turmeric, Ginger, and Licorice', 'Cardamom, Cinnamon, and Clove', 'Pipali long pepper, Ginger, and Black Pepper', 'Coriander, Cumin, and Fennel',
   'c',
   'Trikatu means "three peppers" — Pipali (long pepper), Ginger, and Black Pepper — listed as an HCL stimulating formula for hypochlorhydria.',
   'HCL Stimulating Herbs: Ginger; Trikatu (three peppers) - Pipali long pepper, ginger, black pepper',
   'Hypochlorhydria', 490),

  -- 50 (correct=a)
  (v_class,
   'Which group of herbs is appropriate for Hyperchlorhydria but would aggravate Hypochlorhydria?',
   'Cooling demulcents (Marshmallow, Slippery Elm) are appropriate for both; warming bitters aggravate hyperchlorhydria',
   'Demulcents are only for hypochlorhydria',
   'Warming bitters and HCL stimulants are appropriate for hyperchlorhydria',
   'Cooling herbs and nervines aggravate both conditions',
   'a',
   'The two conditions require different approaches: hypochlorhydria needs warming bitters and HCL stimulants; hyperchlorhydria needs cooling demulcents and cooling GI tonics — warming bitters would worsen excess acid.',
   'Cooling demulcents: Marshmallow, Slippery Elm — Cooling GI Tonics & Nervines: Meadowsweet!! — upper GI always!; Chamomile; Lemon Balm; Licorice; Peach Leaf; Catnip',
   'Hyperchlorhydria', 500);

  RAISE NOTICE 'Class 7 quiz questions loaded: 50 questions.';
END $$;
