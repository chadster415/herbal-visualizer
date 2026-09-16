-- Migration 328: Class 28 quiz — Urinary 2 and Herbs for Pets (50 questions)
--
-- Target calculation:
--   H = 38 distinct herbs/supplements
--   F = 10 named factual items (formulas with ratios, specific dosages, named compounds, specific attributions)
--   target = clamp(15 + 38×4 + 10×1, 20, 50) = clamp(177, 20, 50) = 50 questions
--
-- Correct option distribution: a=13, b=13, c=12, d=12

SET search_path TO herbal, public;

DO $$
DECLARE
  v_class TEXT := 'BHC - Class 28 - Urinary 2 and Herbs for Pets - Shereel and Cheryl';
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 28 quiz already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (c)
  (v_class,
   'What ratio does Valerian appear at in the final tincture formula for the PTSD case study patient?',
   '1P',
   '1/2',
   '2P',
   '3P',
   'c',
   'Valerian appears at double proportion (2P) in the final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon.',
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon; Valerian - hypnotic, sleep',
   'Case Study', 10),

  -- Q2 (d)
  (v_class,
   'What formula contains Yarrow + Marshmallow + Slippery Elm?',
   'Colon Rescue',
   'Hot to Cold Infusion',
   'Decoction',
   'Strengthen and Repair',
   'd',
   'The "Strengthen and Repair" formula consists of Yarrow + Marshmallow + Slippery Elm (combo of colostrum and aloe). Colon Rescue is a different formula: Slippery Elm, Marshmallow, Plantain, Licorice.',
   'Yarrow - hot to the 4th degree; act to decrease blood vomiting; burns; anti-infective, antibacterial; protector plant; Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula (combo of colostrum, aloe)',
   'Digestive', 20),

  -- Q3 (a)
  (v_class,
   'Which herb is described as "the best physical herb for the heart" in Cheryl''s pets class?',
   'Hawthorn',
   'Reishi',
   'Rose',
   'Motherwort',
   'a',
   'Hawthorn is described as the best physical herb for the heart: sweet, sour, stringent; cooling, decreases anxiety; high in flavonoid rutinin; opens up the coronary arteries.',
   'Hawthorn - best physical herb for the heart; sweet, sour, stringent; cooling, decreases anxiety; high in flavonoid rutinin; can use physical and spirit doses; restlessness, irritability, nervous from the heart; opens up the coronary arteries, supports the tissue; shen disturbance herb, good for ADHD; normalize cholesterol levels; stomach and GI disorders in TCM',
   'Chinese Elements', 30),

  -- Q4 (b)
  (v_class,
   'Which herb should you consider getting a patient off Lasix (furosemide) and onto, especially for edema?',
   'Corn Silk',
   'Dandelion leaf',
   'Cleavers',
   'Yarrow',
   'b',
   'Dandelion leaf is specifically noted as a diuretic that contains potassium, making it ideal to transition patients from the pharmaceutical diuretic Lasix (furosemide), especially for edema.',
   'Dandelion leaf - diuretic; contains potassium; try to get off Lasix (furosemide) and onto dandelion leaf, especially for edema; pet dosing: 5 drops per 1 cup water for small dog/cat; 10 drops per cup for medium; 20 drops per quart for large',
   'Chinese Elements', 40),

  -- Q5 (b)
  (v_class,
   'What combination is recommended as a poultice for breast cysts?',
   'Chamomile, Calendula, Yarrow',
   'Dandelion, Cleavers, Burdock',
   'Rose, Marshmallow, Plantain',
   'Nettle, Cleavers, Red Clover',
   'b',
   'Dandelion, Cleavers, and Burdock are the three herbs combined as a poultice for breast cysts, mentioned in the context of dandelion root as a liver herb.',
   'Dandelion root - good liver herb, fats digestion; mastitis and hepatitis; dandelion, cleavers and burdock poultice for breast cysts',
   'Chinese Elements', 50),

  -- Q6 (d)
  (v_class,
   'What is the pet tincture dosage of Dandelion leaf for a small dog or cat?',
   '10 drops per cup',
   '20 drops per quart',
   '15 drops per cup',
   '5 drops per cup',
   'd',
   'The dosing for Dandelion leaf tincture in pets is: 5 drops per cup for small dog or cat, 10 drops per cup for medium, and 20 drops per quart for large animals.',
   'Dandelion leaf - diuretic; contains potassium; try to get off Lasix (furosemide) and onto dandelion leaf, especially for edema; pet dosing: 5 drops per 1 cup water for small dog/cat; 10 drops per cup for medium; 20 drops per quart for large',
   'Chinese Elements', 60),

  -- Q7 (c)
  (v_class,
   'Which herbs are in Colon Rescue by Animal Essentials?',
   'Yarrow, Marshmallow, Calendula, Plantain',
   'Chamomile, Slippery Elm, Licorice, Fennel',
   'Slippery Elm, Marshmallow, Plantain, Licorice',
   'Plantain, Catnip, Marshmallow, Chamomile',
   'c',
   'Colon Rescue by Animal Essentials contains Slippery Elm, Marshmallow, Plantain, and Licorice, specifically for diarrhea in pets.',
   'Colon Rescue by Animal Essentials: Slippery Elm, Marshmallow, Plantain, Licorice - for diarrhea in pets',
   'Chinese Elements', 70),

  -- Q8 (a)
  (v_class,
   'Which herb is described as a "shen disturbance herb, good for ADHD" in the notes?',
   'Hawthorn',
   'Passionflower',
   'Skullcap',
   'Reishi',
   'a',
   'Hawthorn is specifically named as a shen disturbance herb that is good for ADHD, as well as for restlessness, irritability, and nervousness from the heart.',
   'Hawthorn - best physical herb for the heart; sweet, sour, stringent; cooling, decreases anxiety; high in flavonoid rutinin; can use physical and spirit doses; restlessness, irritability, nervous from the heart; opens up the coronary arteries, supports the tissue; shen disturbance herb, good for ADHD; normalize cholesterol levels; stomach and GI disorders in TCM',
   'Chinese Elements', 80),

  -- Q9 (b)
  (v_class,
   'What hot-to-cold infusion formula was given for the PTSD patient (by ratio)?',
   'Tulsi-3, Oatstraw-2, Chamomile-1',
   'Oatstraw-3, Tulsi-2, Lemon Balm-1',
   'Oatstraw-2, Lemon Balm-2, Tulsi-1',
   'Lemon Balm-3, Tulsi-2, Oatstraw-1',
   'b',
   'The hot-to-cold infusion for the PTSD patient was Oatstraw-3, Tulsi-2, Lemon Balm-1. This was for a patient with PTSD, incontinence, constipation, and elevated cortisol.',
   'Hot to Cold Infusion for PTSD patient (incontinence, constipation, elevated cortisol): Oatstraw - 3, Tulsi - 2, Lemon Balm - 1',
   'Case Study', 90),

  -- Q10 (d)
  (v_class,
   'Which mushroom is described as "one of the best mushrooms for diabetes; regulates blood sugar"?',
   'Reishi',
   'Lion''s Mane',
   'Cordyceps',
   'Maitake',
   'd',
   'Maitake is specifically called out at the end of the class notes as one of the best mushrooms for diabetes that regulates blood sugar.',
   'Maitake - one of the best mushrooms for diabetes; regulates blood sugar',
   'Chinese Elements', 100),

  -- Q11 (c)
  (v_class,
   'Paul Stamets recommends using which part of Cordyceps and other medicinal mushrooms?',
   'Mycelium only',
   'Spores',
   'Fruiting bodies',
   'Root-like substrate',
   'c',
   'Paul Stamets is cited in the notes as recommending fruiting bodies ("use the fruiting bodies") over mycelium for medicinal mushrooms like Cordyceps.',
   'Cordyceps mushroom - energy, vitality; increases oxygen, mobility; Paul Stamets recommends fruiting bodies; "Real Mushrooms" company; Lion''s Mane and Reishi more about focus, Cordyceps more about energy',
   'Chinese Elements', 110),

  -- Q12 (a)
  (v_class,
   'SJW helps ease which symptom in the context of medication changes?',
   'Withdrawal symptoms',
   'Edema',
   'Constipation',
   'Insect bites',
   'a',
   'SJW is noted as great for helping to ease withdrawal symptoms, with California Poppy as a possible additional herb, in the context of discussing diuretic herbs and medications.',
   'SJW is great for helping to ease withdrawal symptoms; possibly California Poppy as well (in context of discussing diuretic herbs and medications)',
   'Urinary 2 Pathologies', 120),

  -- Q13 (b)
  (v_class,
   'California Poppy is described as which type of herb for sleep in the case study?',
   'Adaptogen',
   'Hypnotic',
   'Nervine tonic',
   'Sedative',
   'b',
   'California Poppy is specifically labeled as a hypnotic in the case study: "Cal Poppy - hypnotic" — the same classification given to Valerian.',
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon; Cal Poppy - hypnotic',
   'Case Study', 130),

  -- Q14 (a)
  (v_class,
   'Which herb cools an overheated liver AND comforts the heart in Chinese five-element theory?',
   'Rose',
   'Hawthorn',
   'Chamomile',
   'Reishi',
   'a',
   'Rose is described as "the most primal of the fragrances; cools an overheated liver; comforts the heart; resists infection; Rose Cordial strengthens the spirit of the heart."',
   'Rose - the most primal of the fragrances; cools an overheated liver; comforts the heart; resists infection; Rose Cordial strengthens the spirit of the heart; rose water for animals with skin issues; cooling, of tempers as well',
   'Chinese Elements', 140),

  -- Q15 (c)
  (v_class,
   'Hawthorn is noted to be high in which flavonoid?',
   'Quercetin',
   'Rutin',
   'Rutinin',
   'Kaempferol',
   'c',
   'The notes specifically state Hawthorn is "high in flavonoid rutinin" — the class notes use the spelling "rutinin."',
   'Hawthorn - best physical herb for the heart; sweet, sour, stringent; cooling, decreases anxiety; high in flavonoid rutinin; can use physical and spirit doses; restlessness, irritability, nervous from the heart; opens up the coronary arteries, supports the tissue; shen disturbance herb, good for ADHD; normalize cholesterol levels; stomach and GI disorders in TCM',
   'Chinese Elements', 150),

  -- Q16 (d)
  (v_class,
   'For GI issues in pets, which cooling herbs are recommended?',
   'Fennel and Ginger',
   'Catnip and Chamomile',
   'Dill and Fennel',
   'Mint and Chamomile',
   'd',
   'The notes explicitly list mint and chamomile as cooling herbs to use for GI issues in pets. Fennel is noted as warming/carminative, contrasting with Dill which is cooling.',
   'GI issue in pets? Use a cooling herb: mint, chamomile',
   'Digestive', 160),

  -- Q17 (a)
  (v_class,
   'Which herb is specifically mentioned for "smelly diarrhea" and "clears damp heat" in pets?',
   'Plantain',
   'Slippery Elm',
   'Catnip',
   'Chamomile',
   'a',
   'Plantain is specifically listed for smelly diarrhea and described as clearing damp heat, along with treating insect bites and foreign bodies.',
   'Plantain - smelly diarrhea; clears damp heat; insect bites; foreign bodies; Plantain + SJW in gauze after dental in pets - good for gum irritation or inside cheek; Colon Rescue: Slippery Elm, Marshmallow, Plantain, Licorice for diarrhea',
   'Chinese Elements', 170),

  -- Q18 (b)
  (v_class,
   'In the decoction formula for the PTSD case study, what two herbs were used?',
   'Valerian and Passionflower',
   'Burdock and Yellow Dock',
   'Burdock and Dandelion root',
   'Nettle and Yellow Dock',
   'b',
   'The decoction for the PTSD patient with constipation and elevated cortisol contained Burdock-1 and Yellow Dock-1.',
   'Decoction: Burdock - 1, Yellow Dock - 1 (for patient with PTSD, constipation, elevated cortisol)',
   'Case Study', 180),

  -- Q19 (c)
  (v_class,
   'Dandelion leaf contains which important mineral that pharmaceutical diuretics can strip?',
   'Magnesium',
   'Calcium',
   'Potassium',
   'Sodium',
   'c',
   'Dandelion leaf is noted as a diuretic that contains potassium, an important mineral that is often stripped by pharmaceutical diuretics like Lasix (furosemide).',
   'Dandelion leaf - diuretic; contains potassium; try to get off Lasix (furosemide) and onto dandelion leaf, especially for edema; pet dosing: 5 drops per 1 cup water for small dog/cat; 10 drops per cup for medium; 20 drops per quart for large',
   'Chinese Elements', 190),

  -- Q20 (d)
  (v_class,
   'Which mushroom is described as primarily for "focus" along with Reishi, versus Cordyceps which is more for energy?',
   'Maitake',
   'Chaga',
   'Shiitake',
   'Lion''s Mane',
   'd',
   'The notes explicitly state: "Lions mane and Reishi more about focus" while "Cordyceps more about energy." Lion''s Mane is also described as for "standing in kitchen not knowing what to do."',
   'Lion''s Mane - for cognitive support: "standing in kitchen not knowing what to do"; pre-biotic fiber and immune modulation; listed as a power herb; Cordyceps more about energy, Lion''s Mane and Reishi more about focus',
   'Chinese Elements', 200),

  -- Q21 (a)
  (v_class,
   'Which combination is recommended in gauze after dental procedures in pets for gum irritation?',
   'Plantain and SJW',
   'Chamomile and Calendula',
   'Yarrow and Marshmallow',
   'Rose and Plantain',
   'a',
   'Plantain + SJW in gauze is specifically recommended for after dental procedures in pets — effective for gum irritation or inside cheek wounds.',
   'Plantain - smelly diarrhea; clears damp heat; insect bites; foreign bodies; Plantain + SJW in gauze after dental in pets - good for gum irritation or inside cheek; Colon Rescue: Slippery Elm, Marshmallow, Plantain, Licorice for diarrhea',
   'Chinese Elements', 210),

  -- Q22 (b)
  (v_class,
   'William LeSassier is quoted as saying which herb "relaxes the nerves in the lungs"?',
   'Mullein',
   'Slippery Elm',
   'Coltsfoot',
   'Elecampane',
   'b',
   'William LeSassier is specifically cited as saying Slippery Elm "relaxes the nerves in the lungs." Slippery Elm is also noted to help both the Earth and the Lung.',
   'Slippery Elm - helps both the Earth and the Lung; lubricant; William LeSassier: "relaxes the nerves in the lungs"; also in Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice) for diarrhea',
   'Chinese Elements', 220),

  -- Q23 (c)
  (v_class,
   'Catnip is recommended for animals that internalize and hold stress due to which mechanism?',
   'Cooling the heart fire',
   'Clearing damp heat from the liver',
   'Relieving liver congestion and intestinal spasms',
   'Reducing cortisol levels',
   'c',
   'Catnip is described as helping the animal who internalizes and holds stress because the liver gets congested and doesn''t want to move, causing tension in the stomach — Catnip relieves these spasms and liver congestion.',
   'Catnip - relieves spasms; for infants, colic; for animal who internalizes and holds stress; liver gets congested and doesn''t want to move',
   'Chinese Elements', 230),

  -- Q24 (d)
  (v_class,
   'What is Yarrow described as in terms of elemental heat?',
   'Hot to the 2nd degree',
   'Hot to the 3rd degree',
   'Warming and dry',
   'Hot to the 4th degree',
   'd',
   'Yarrow is specifically described as "hot to the 4th degree" — the highest level of heat in the traditional elemental system — in the context of its use in pets.',
   'Yarrow - hot to the 4th degree; act to decrease blood vomiting; burns; anti-infective, antibacterial; protector plant; Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula (combo of colostrum, aloe)',
   'Digestive', 240),

  -- Q25 (a)
  (v_class,
   'What is the correct herb combination for the "Strengthen and Repair" formula?',
   'Yarrow, Marshmallow, Slippery Elm',
   'Marshmallow, Slippery Elm, Chamomile',
   'Calendula, Yarrow, Plantain',
   'Yarrow, Chamomile, Marshmallow',
   'a',
   'The "Strengthen and Repair" formula combines Yarrow + Marshmallow + Slippery Elm. It is described as a combo with colostrum and aloe for digestive tract healing in dogs and cats.',
   'Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula; also in Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice) for diarrhea',
   'Digestive', 250),

  -- Q26 (b)
  (v_class,
   'What formula type in the case study contains Oatstraw, Tulsi, and Lemon Balm?',
   'Decoction',
   'Hot to Cold Infusion',
   'Tincture blend',
   'Standard tea infusion',
   'b',
   'Oatstraw-3, Tulsi-2, Lemon Balm-1 are combined in a Hot to Cold Infusion — one of two formulas given to the PTSD patient alongside the decoction of Burdock and Yellow Dock.',
   'Hot to Cold Infusion for PTSD patient (incontinence, constipation, elevated cortisol): Oatstraw - 3, Tulsi - 2, Lemon Balm - 1',
   'Case Study', 260),

  -- Q27 (c)
  (v_class,
   'Which herb is described as a "power herb" that helps you "stand strong in yourself"?',
   'Nettle',
   'Cordyceps',
   'Reishi',
   'Astragalus',
   'c',
   'Reishi is described as the power herb that supports the heart, with the quality of "standing strong in yourself." Other power herbs listed include Nettles, Plantain, True Solomon''s Seal, and Lion''s Mane.',
   'Medicinal mushrooms for anxiety: Lion''s Mane and Reishi; Reishi - power herb, supports the heart, "standing strong in yourself"; pre-biotic fiber and immune modulation; listed as a power herb alongside Nettles, Plantain, True Solomon''s Seal',
   'Chinese Elements', 270),

  -- Q28 (d)
  (v_class,
   'Hawthorn opens up which structure in the cardiovascular system?',
   'Ventricular walls',
   'Aortic valve',
   'Pulmonary veins',
   'Coronary arteries',
   'd',
   'Hawthorn is specifically noted to open up the coronary arteries and support the tissue, making it the best physical herb for the heart.',
   'Hawthorn - best physical herb for the heart; sweet, sour, stringent; cooling, decreases anxiety; high in flavonoid rutinin; can use physical and spirit doses; restlessness, irritability, nervous from the heart; opens up the coronary arteries, supports the tissue; shen disturbance herb, good for ADHD; normalize cholesterol levels; stomach and GI disorders in TCM',
   'Chinese Elements', 280),

  -- Q29 (a)
  (v_class,
   'Which herb in the topical hot spot spray for pets is described elsewhere as a good anti-flea plant?',
   'Rosemary',
   'Calendula',
   'SJW',
   'Chamomile',
   'a',
   'Rosemary is described as a good anti-flea plant in the introductory pets section with Cheryl Schwartz. Separately, the hot spot spray contains chamomile, burdock, alfalfa, dandelion, calendula, and SJW — but not rosemary.',
   'Rosemary good anti-flea plant',
   'Herbs for Pets', 290),

  -- Q30 (b)
  (v_class,
   'What dose of Dandelion leaf tincture is recommended for a medium-sized pet?',
   '5 drops per cup',
   '10 drops per cup',
   '15 drops per cup',
   '20 drops per quart',
   'b',
   'Pet dosing for Dandelion leaf tincture: 5 drops per cup for small (dog/cat), 10 drops per cup for medium, and 20 drops per quart for large animals.',
   'Dandelion leaf - diuretic; contains potassium; try to get off Lasix (furosemide) and onto dandelion leaf, especially for edema; pet dosing: 5 drops per 1 cup water for small dog/cat; 10 drops per cup for medium; 20 drops per quart for large',
   'Chinese Elements', 300),

  -- Q31 (c)
  (v_class,
   'David Winston recommends which herb as a more gentle alternative to Willow bark for cats?',
   'Valerian',
   'Meadowsweet',
   'Devil''s Claw or Boswellia',
   'Skullcap',
   'c',
   'David Winston (herbalist alchemist) recommends using only a tiny amount of Willow bark, and suggests Devil''s Claw or Boswellia or MSM for cats instead as more gentle alternatives.',
   'David Winston: Devil''s claw or Boswellia or MSM for cats instead of Willow bark (more gentle)',
   'Chinese Elements', 310),

  -- Q32 (a)
  (v_class,
   'Slippery Elm is said to help which two elemental systems in Chinese medicine?',
   'Earth and Lung (Metal)',
   'Water and Wood',
   'Fire and Water',
   'Metal and Wood',
   'a',
   'Slippery Elm is described as helping both the Earth (digestive/stomach) and the Lung (Metal element) — functioning as a lubricant and relaxer of the nerves in the lungs.',
   'Slippery Elm - helps both the Earth and the Lung; lubricant; William LeSassier: "relaxes the nerves in the lungs"; also in Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice) for diarrhea',
   'Chinese Elements', 320),

  -- Q33 (b)
  (v_class,
   'Which herb cools and relaxes and was specifically used for horses with colic pain?',
   'Catnip',
   'Chamomile',
   'Fennel',
   'Dill',
   'b',
   'Chamomile is described as cooling and relaxing, and specifically used for horses with colic pain. It is also good for soothing around the skin or mucosa such as anal gland abscesses.',
   'Chamomile - good for dogs and cats; use the dry for digestion, the fresh for behavior; cools and relaxes; used for horses with colic pain; anything for soothing around the skin or mucosa (anal gland abscesses)',
   'Chinese Elements', 330),

  -- Q34 (c)
  (v_class,
   'Which herb is specifically noted as "cooling" in contrast to Fennel''s "warming" quality?',
   'Chamomile',
   'Peppermint',
   'Dill',
   'Catnip',
   'c',
   'Dill is listed as "cooling" as a direct contrast to Fennel which is "warming" — both are digestive herbs used in pets with different thermal energetics.',
   'Dill - cooling (digestive use for pets)',
   'Digestive', 340),

  -- Q35 (d)
  (v_class,
   'Boswellia (Frankincense) is described as good for which condition in older pets?',
   'Diarrhea',
   'Anxiety and PTSD',
   'Skin conditions',
   'Mobility and decreasing pain',
   'd',
   'Boswellia (Frankincense) is specifically described as good for mobility for older animals and for decreasing pain, available in capsules as a powder.',
   'Boswellia (Frankincense) - good for mobility for older animals; decreasing pain; in capsules as a powder',
   'Chinese Elements', 350),

  -- Q36 (a)
  (v_class,
   'True Solomon''s Seal is recommended for what specific pet condition in the notes?',
   'Bald spots from licking',
   'Diarrhea',
   'Fleas',
   'Anxiety',
   'a',
   'True Solomon''s Seal is recommended for bald spots from licking in pets, to "clear the energy," and is listed as a power herb alongside Nettles, Reishi, Plantain, and Lion''s Mane.',
   'True Solomon''s Seal - for bald spot from licking in pets, clear the energy; listed as a power herb',
   'Chinese Elements', 360),

  -- Q37 (b)
  (v_class,
   'Rose Cordial is described as strengthening what?',
   'The kidneys',
   'The spirit of the heart',
   'The immune system',
   'The liver',
   'b',
   'Rose Cordial is specifically described as strengthening "the spirit of the heart" — Rose is the most primal of the fragrances and comforts the heart in Chinese five-element theory.',
   'Rose - the most primal of the fragrances; cools an overheated liver; comforts the heart; resists infection; Rose Cordial strengthens the spirit of the heart; rose water for animals with skin issues; cooling, of tempers as well',
   'Chinese Elements', 370),

  -- Q38 (c)
  (v_class,
   'Which herb appears in both the "Strengthen and Repair" formula and the Colon Rescue formula?',
   'Yarrow',
   'Licorice',
   'Marshmallow',
   'Plantain',
   'c',
   'Marshmallow appears in both formulas: Strengthen and Repair (Yarrow + Marshmallow + Slippery Elm) and Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice). Slippery Elm also appears in both, but the other unique herb in both is Marshmallow.',
   'Yarrow + Marshmallow + Slippery Elm - "Strengthen and Repair" formula; also in Colon Rescue (Slippery Elm, Marshmallow, Plantain, Licorice) for diarrhea',
   'Digestive', 380),

  -- Q39 (d)
  (v_class,
   'How many herbs are in the topical hot spot spray described in the notes?',
   '4',
   '5',
   '7',
   '6',
   'd',
   'The topical hot spot spray contains exactly 6 herbs: chamomile, burdock, alfalfa, dandelion, calendula, and SJW.',
   'Topical spray for hot spots (pets): chamomile, burdock, alfalfa, dandelion, calendula, SJW',
   'Chinese Elements', 390),

  -- Q40 (a)
  (v_class,
   'Which mushroom increases oxygen utilization and mobility, per the notes?',
   'Cordyceps',
   'Reishi',
   'Maitake',
   'Lion''s Mane',
   'a',
   'Cordyceps is described as increasing oxygen and mobility, providing energy and vitality. Paul Stamets recommends using the fruiting bodies, and "Real Mushrooms" is cited as a quality company.',
   'Cordyceps mushroom - energy, vitality; increases oxygen, mobility; Paul Stamets recommends fruiting bodies; "Real Mushrooms" company; Lion''s Mane and Reishi more about focus, Cordyceps more about energy',
   'Chinese Elements', 400),

  -- Q41 (b)
  (v_class,
   'In the PTSD case study, Dandelion leaf was questioned as potentially worsening which symptom?',
   'Constipation',
   'Incontinence',
   'Elevated cortisol',
   'Sleep difficulties',
   'b',
   'Dandelion leaf was questioned in the case study with a "?" because its diuretic action could potentially worsen incontinence, one of the patient''s primary concerns.',
   'Dandelion leaf? Would increase incontinence? (asked in context of urinary patient with incontinence — diuretic action could worsen symptoms)',
   'Case Study', 410),

  -- Q42 (c)
  (v_class,
   'Which herb is described as good for "soothing around the skin or mucosa" including anal gland abscesses?',
   'Plantain',
   'Slippery Elm',
   'Chamomile',
   'Catnip',
   'c',
   'Chamomile is specifically noted for anything soothing around the skin or mucosa, including anal gland abscesses in pets, in addition to its use for colic pain in horses.',
   'Chamomile - good for dogs and cats; use the dry for digestion, the fresh for behavior; cools and relaxes; used for horses with colic pain; anything for soothing around the skin or mucosa (anal gland abscesses)',
   'Chinese Elements', 420),

  -- Q43 (d)
  (v_class,
   'What is the main difference between using dry versus fresh Chamomile, per the notes?',
   'Dry is warming, fresh is cooling',
   'Fresh is stronger for digestion, dry for behavior',
   'Fresh is antiparasitic, dry is demulcent',
   'Dry for digestion, fresh for behavior',
   'd',
   'The notes specify: use dry Chamomile for digestion, but use fresh Chamomile for behavior issues in pets.',
   'Chamomile - good for dogs and cats; use the dry for digestion, the fresh for behavior; cools and relaxes; used for horses with colic pain; anything for soothing around the skin or mucosa (anal gland abscesses)',
   'Chinese Elements', 430),

  -- Q44 (a)
  (v_class,
   'Which herb in the case study tincture formula appears at double the proportion (2P)?',
   'Valerian',
   'California Poppy',
   'Holy Basil',
   'Hawthorn',
   'a',
   'Valerian appears at 2P (double proportion) in the final tincture: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon.',
   'Final tincture formula: 2P Valerian, 1P California Poppy, 1/2 Hawthorn leaf and flower, 1/2 Tulsi, 1/2 Marshmallow, 1/2 Cinnamon; Valerian - hypnotic, sleep',
   'Case Study', 440),

  -- Q45 (b)
  (v_class,
   'Mullein individuals are said to tend toward which condition?',
   'Excess moisture',
   'Dryness',
   'Heat',
   'Stagnation',
   'b',
   'The notes state "mullein indiv get dry" — Mullein individuals tend toward dryness, consistent with its elemental associations with lung (acrid pungent) and kidney (salty) tastes.',
   'Mullein - element tastes: Earth sweet, lung acrid pungent, kidney salty, liver sour; mullein individuals get dry',
   'Chinese Elements', 450),

  -- Q46 (c)
  (v_class,
   'What formula type is listed first for the PTSD patient, before the tincture blend?',
   'Cold infusion only',
   'Decoction',
   'Hot to Cold Infusion followed by Decoction',
   'Steam inhalation',
   'c',
   'The POC for the PTSD patient includes two separate preparations listed in order: first a Hot to Cold Infusion (Oatstraw-3, Tulsi-2, Lemon Balm-1), then a Decoction (Burdock-1, Yellow Dock-1), and finally the tincture blend.',
   'Hot to Cold Infusion for PTSD patient (incontinence, constipation, elevated cortisol): Oatstraw - 3, Tulsi - 2, Lemon Balm - 1',
   'Case Study', 460),

  -- Q47 (d)
  (v_class,
   'Which condition is Catnip specifically indicated for in infants?',
   'Fever',
   'Teething',
   'Constipation',
   'Colic',
   'd',
   'Catnip is specifically listed for colic in infants, as well as for animals that internalize and hold stress due to its antispasmodic and liver-decongestant properties.',
   'Catnip - relieves spasms; for infants, colic; for animal who internalizes and holds stress; liver gets congested and doesn''t want to move',
   'Chinese Elements', 470),

  -- Q48 (a)
  (v_class,
   'Rose water is recommended for animals with what condition?',
   'Skin issues',
   'Diarrhea',
   'Anxiety',
   'Respiratory problems',
   'a',
   'Rose water is specifically mentioned for animals with skin issues — Rose cools and soothes, consistent with its cooling and anti-inflammatory properties.',
   'Rose - the most primal of the fragrances; cools an overheated liver; comforts the heart; resists infection; Rose Cordial strengthens the spirit of the heart; rose water for animals with skin issues; cooling, of tempers as well',
   'Chinese Elements', 480),

  -- Q49 (b)
  (v_class,
   'Plantain''s spiritual medicine description refers to "white man''s footprint" and what broader quality?',
   'Grounding and earth connection',
   'Going beyond nationalism and borders',
   'Protecting sacred land',
   'Healing generational trauma',
   'b',
   'Plantain is described as "spirit medicine -> going beyond nationalism, borders" with the reference to "white man''s footprint" — reflecting its quality of growing wherever humans travel, transcending national and cultural boundaries.',
   'Plantain - smelly diarrhea; clears damp heat; insect bites; foreign bodies; Plantain + SJW in gauze after dental in pets - good for gum irritation or inside cheek; Colon Rescue: Slippery Elm, Marshmallow, Plantain, Licorice for diarrhea',
   'Chinese Elements', 490),

  -- Q50 (c)
  (v_class,
   'Which herb combination is used for Daisies + another herb for wounds that don''t heal in pets?',
   'Daisies and Yarrow',
   'Daisies and Chamomile',
   'Daisies and Calendula',
   'Daisies and SJW',
   'c',
   'Daisies + Calendula is the specific combination noted for wounds that don''t heal in pets. The herbal remedy can be put in a little meatball for dogs, or in fish for cats to mask the smell.',
   'Daisies + Calendula, for wounds that don''t heal; put herbal remedy in a little meatball for dogs, or in fish for cats to mask the smell',
   'Digestive', 500);

  RAISE NOTICE 'Class 28 quiz loaded (50 questions).';
END $$;
