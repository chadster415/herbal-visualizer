-- Migration 332: Class 67 (Thyroid) quiz questions — 30 MCQ
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'BHC - Class 67 - Thyroid'
  ) THEN
    RAISE NOTICE 'Class 67 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1
  ('BHC - Class 67 - Thyroid',
   'Which five herbs make up Jill Stansbury''s formula for Hashimoto''s thyroiditis?',
   'Bladderwrack, licorice, ashwagandha, Iris versicolor, rosemary',
   'Mukul myrrh, bladderwrack, licorice, Panax ginseng, Iris versicolor',
   'Guggul, motherwort, blue flag, self-heal, schizandra',
   'Bladderwrack, bugleweed, licorice, astragalus, tulsi',
   'b',
   'The Stansbury Hashimoto''s formula is equal parts Commiphora Mukul (myrrh/Guggul), bladderwrack, licorice, Panax ginseng, and Iris versicolor — taken 1–2 dropperfuls 3–5x/day for months.',
   'Commiphora Mukul (myrrh) in Stansbury Hashimoto''s tincture: equal parts Commiphora Mukul, bladderwrack, licorice, Panax ginseng, Iris versicolor; 1–2 dropperfuls 3–5x/day for months.',
   'Hashimoto''s', 10),

  -- Q2
  ('BHC - Class 67 - Thyroid',
   'What dose and frequency is recommended for the Stansbury Hashimoto''s tincture?',
   '5 drops twice daily for one week',
   '1 dropperful once daily for 30 days',
   '1–2 dropperfuls 3–5 times per day for months',
   '2 dropperfuls twice daily for 2 weeks then taper',
   'c',
   'The Stansbury formula is taken at 1–2 dropperfuls 3–5x/day for months — a sustained, higher-frequency dosing strategy consistent with autoimmune thyroid treatment.',
   'tincture from Jill Stansbury: Commiphora Mukul (myrrh), Bladderwrack, Licorice, Panax ginseng, Iris versicolor — equal parts — 1-2 dropperful 3-5x/day for months',
   'Hashimoto''s', 20),

  -- Q3
  ('BHC - Class 67 - Thyroid',
   'Which herb is described as a "metabolic cooler" that is interchangeable with Motherwort for cardiovascular support in thyroid disorders?',
   'Lemon balm',
   'Schizandra',
   'Bugleweed',
   'Blue Flag',
   'c',
   'Bugleweed (Lycopus virginicus) is described as technically a metabolic cooler and is noted as interchangeable with Motherwort for cardiovascular support in thyroid imbalance.',
   'Bugleweed (Lycopus virginicus) picture: goiter phase with tachycardia and mild respiratory dysfunction (shallow breathing), tachycardia with circulatory issues and anxiety, passive capillary hemorrhage, palpitations. Metabolic cooler; cools lower GI excess. Interchangeable with Motherwort for CV support.',
   'Bugleweed', 30),

  -- Q4
  ('BHC - Class 67 - Thyroid',
   'What is the clinical picture that calls for Iris versicolor (Blue Flag) in thyroid conditions?',
   'Hyperthyroidism with tachycardia and explosive bowel movements',
   'Hypothyroidism with poor fat metabolism, lymphatic stasis, elevated VLDL/LDL, and pancreatic insufficiency',
   'Hashimoto''s with anti-TPO antibodies and gut dysbiosis',
   'Adrenal fatigue with cold intolerance and brain fog',
   'b',
   'Iris versicolor''s picture is specifically hypothyroidism where the patient can''t metabolize fats — including nausea headaches, heartburn from fats, elevated VLDL and LDL, pancreatic insufficiency, and eczema with poor fat assimilation.',
   'Iris versicolor picture: hypothyroidism, can''t metabolize fats well, even vomiting from fats, may get nausea headaches, light-colored feces, heartburn from fats, morning nausea, elevated VLDL and LDL, pancreatic insufficiency, impair the breaking down of food in the small intestine, semi-formed feces, eczema with poor fat assimilation and dry skin. Specific for stagnation; stimulates innate immunity.',
   'Iris versicolor', 40),

  -- Q5
  ('BHC - Class 67 - Thyroid',
   'What dose range is recommended for Iris versicolor, and why is it noted as a "lower dose plant"?',
   '60–90 drops; it has a narrow therapeutic window and is very stimulating',
   '10–30 drops; it is technically a lower dose plant',
   '2–5 drops; it contains toxic alkaloids requiring careful titration',
   '1/4 teaspoon per day in tea; tincture form is too concentrated',
   'b',
   'Iris versicolor is technically a lower dose plant at 10–30 drops — less is needed to achieve its specific action on fat metabolism and lymphatic stagnation.',
   'Iris versicolor — technically a lower dose plant — 10-30 drops',
   'Iris versicolor', 50),

  -- Q6
  ('BHC - Class 67 - Thyroid',
   'What is the clinical picture of Bladderwrack as described in these class notes?',
   'Hyperthyroidism with tachycardia, anxiety, and hair loss',
   'Gut dysbiosis with malabsorption and low ferritin',
   'Thyroid hypofunction with tendency toward obesity, fatty accumulation of the heart, and malnutrition with mineral deficiencies',
   'Autoimmune thyroiditis with elevated TSH and anti-TPO antibodies',
   'c',
   'Bladderwrack''s picture is thyroid hypofunction, tendency toward obesity, fatty accumulation of the heart, and malnutrition with mineral deficiencies — making it a mineral-rich thyroid trophorestorative.',
   'Bladderwrack picture: thyroid hypofunction, tendency toward obesity, fatty accumulation of the heart, malnutrition with mineral deficiencies.',
   'Bladderwrack', 60),

  -- Q7
  ('BHC - Class 67 - Thyroid',
   'What is the clinical picture for Poke Root as described in these notes?',
   'Hyperthyroidism with tachycardia, hot constitution, and explosive diarrhea',
   'Thyroid hypofunction with fluid retention, immune depression, puffy face and ankles, chronic hard inflamed neck nodes, and cracks at the sides of the mouth',
   'Hypothyroidism with constipation, weight gain, and cold intolerance',
   'Hashimoto''s with gut dysbiosis, H. pylori, and low selenium',
   'b',
   'Poke Root''s picture is thyroid hypofunction with fluid retention and immune depression — specifically including puffy face and ankles, chronic hard inflamed neck nodes, eczema, and cracks on the sides of the mouth as a hallmark sign.',
   'Poke Root picture: thyroid hypofunction with fluid retention and immune depression, puffy face and ankles, chronic hard inflamed neck nodes, eczema, cracks on the sides of the mouth (specific for poke). Start low and slow; can give rashes as waste moves out.',
   'Poke', 70),

  -- Q8
  ('BHC - Class 67 - Thyroid',
   'Which herb is paired with Poke Root specifically for fibrocystic acute breast disease?',
   'Motherwort',
   'Red Root',
   'Calendula',
   'Blue Cohosh',
   'b',
   'The notes specifically state "fibrocystic acute breast disease + Red Root" in the context of Poke Root''s clinical picture — Red Root addresses lymphatic congestion in the breast tissue.',
   'fibrocystic acute breast disease + Red Root',
   'Poke', 80),

  -- Q9
  ('BHC - Class 67 - Thyroid',
   'Which herbs are added to Poke Root for acute mastitis?',
   'Echinacea and Baptisia',
   'Red Root and Cotton Root Bark',
   'Calendula and Plantain',
   'Red Clover and Alfalfa',
   'b',
   'The notes specify "acute mastitis + Red Root and + Cotton Root Bark" — combining Poke''s lymphatic action with Red Root''s lymph drainage and Cotton Root Bark''s breast/uterine tissue affinity.',
   'acute mastitis +Red root and +Cotton root bark',
   'Poke', 90),

  -- Q10
  ('BHC - Class 67 - Thyroid',
   'Which herbs accompany Poke Root for bacterial infections in constitutionally feeble individuals?',
   'Red Root and Cotton Root Bark',
   'Astragalus and Reishi',
   'Echinacea and Baptisia (Wild Indigo)',
   'Motherwort and Bugleweed',
   'c',
   'The notes list "bacterial infections in ''feeble individuals'' + Echinacea and + Baptisia" — combining Poke''s lymphatic restoration with Echinacea''s immune stimulation and Baptisia''s antimicrobial potency.',
   'bacterial infections in "feeble individuals" +Echinacea and +Baptisia',
   'Poke', 100),

  -- Q11
  ('BHC - Class 67 - Thyroid',
   'Which category of herbs contains rosmarinic acid and is indicated more for hyperthyroidism than hypothyroidism?',
   'Moistening adaptogens — shatavari, astragalus, schizandra',
   'Rosemary, self-heal, lemon balm, motherwort, and tulsi',
   'Bitter digestive herbs — blue vervain, cardamom, ginger',
   'Nervine tonics — milky oats, passionflower, skullcap',
   'b',
   'Rosmarinic acid-containing plants — rosemary, self-heal, lemon balm, motherwort, and tulsi — are more indicated for hyperthyroidism because rosmarinic acid calms the uptake of T3 into the tissues.',
   'Rosmarinic acid containing plants — more indicated for hyperthyroidism, but no harm for hypo',
   'Rosmarinic Acid Plants', 110),

  -- Q12
  ('BHC - Class 67 - Thyroid',
   'How does rosmarinic acid exert its effect in hyperthyroidism?',
   'It blocks TSH receptors in the pituitary, reducing thyroid stimulation',
   'It calms the uptake of T3 into tissues and modulates T-cells in autoimmune conditions',
   'It directly inhibits T4 to T3 conversion in the liver',
   'It increases selenium bioavailability, reducing anti-TPO antibodies',
   'b',
   'Rosmarinic acid calms the uptake of T3 into the tissues and modulates T-cells in autoimmune conditions — a mechanism relevant to hyperthyroidism and autoimmune thyroid disease.',
   'Rosemary (rosmarinic acid) for calming thyroid response; modulates T-cells in autoimmune thyroid conditions. Use rosemary, self-heal, lemon balm.',
   'Herb Usage', 120),

  -- Q13
  ('BHC - Class 67 - Thyroid',
   'Which adaptogen has the most specific affinity for hypothyroidism, especially with the foggy, forgetful, slow transit time picture?',
   'Astragalus',
   'Tulsi',
   'Shatavari',
   'Ashwagandha',
   'd',
   'Ashwagandha has more of an affinity for hypothyroidism — specifically for the patient who is foggy, forgetful, and has slow transit time (constipation from low thyroid function).',
   'Ashwagandha has more of an affinity for Hypothyroidism — foggy, forgetful, slow transit time — specific for Ashwagandha',
   'Herbal Actions for Thyroid Health', 130),

  -- Q14
  ('BHC - Class 67 - Thyroid',
   'What are the correlating risk factors for Hashimoto''s thyroiditis listed in these class notes?',
   'High cortisol, MTHFR mutation, low ferritin, gut overgrowth',
   'Gut dysbiosis, H. pylori, iron-deficient anemia, low selenium, low Vit D, high iodine exposure, stealth viruses',
   'Elevated TSH, low T3, low T4, anti-TPO positive, leaky gut',
   'Stress, toxic exposures, beta-blocker use, corticosteroid use',
   'b',
   'The notes list Hashimoto''s correlations as: gut dysbiosis, H. pylori, iron-deficient anemia, low selenium, low Vit D, high iodine exposure, and stealth viruses.',
   'correlations: gut dysbiosis definitely correlated with Hashimoto''s, H. pylori, iron-deficient anemia, low selenium, Vit D, and high iodine exposure, also, viruses (stealth)',
   'Hashimoto''s', 140),

  -- Q15
  ('BHC - Class 67 - Thyroid',
   'What starting dose of selenium is recommended for thyroid support in these class notes?',
   '50 micrograms daily',
   '100 micrograms with food',
   '200 micrograms',
   '400 micrograms as a loading dose',
   'c',
   'Selenium at 200 micrograms is specifically noted as the starting point for thyroid nourishment — with Brazil nuts mentioned as a food source.',
   'Selenium at 200 micrograms — Brazil nuts as source',
   'Treatment Details', 150),

  -- Q16
  ('BHC - Class 67 - Thyroid',
   'What is the Bugleweed clinical picture that calls for its use?',
   'Hypothyroidism with weight gain, cold intolerance, and brain fog',
   'Goiter phase with tachycardia, mild respiratory dysfunction, palpitations, and passive capillary hemorrhage',
   'Hashimoto''s with gut dysbiosis and mineral deficiencies',
   'Grave''s disease with ocular pressure and cardiovascular havoc',
   'b',
   'Bugleweed''s picture is specifically the goiter phase with tachycardia, mild respiratory dysfunction (shallow breathing), circulatory issues with anxiety, passive capillary hemorrhage, and palpitations.',
   'Bugleweed (Lycopus virginicus) picture: when goiter phase with tachycardia and mild respiratory disfunction (shallow breathing), tachycardia with circ issues and anxiety, passive capillary hemorrhage, palpitations. Metabolic cooler; cools lower GI excess.',
   'Bugleweed', 160),

  -- Q17
  ('BHC - Class 67 - Thyroid',
   'Which two herbs are described as "moistening adaptogens" specifically appropriate when a patient is on the edge of burnout with dry tissues?',
   'Ashwagandha and tulsi',
   'Reishi and astragalus',
   'Shatavari and astragalus',
   'Schizandra and licorice',
   'c',
   'Shatavari and astragalus are specifically named as moistening adaptogens in the context of thyroid burnout — chosen when the patient has dry tissues from chronic hyperthyroid depletion.',
   'moistening - shatavari, astragalus — in case on the edge of burnout with dry tissues',
   'Herbal Actions for Thyroid Health', 170),

  -- Q18
  ('BHC - Class 67 - Thyroid',
   'What three tinctures/formulas did Lisa recommend for the Mary thyroid case?',
   'Immune formula, lymphatic formula, and hormone formula',
   'Primary absorption tincture (tulsi, schisandra, ashwagandha, milk thistle, rosemary), bitter digestive (blue vervain, cardamom, ginger), and reproductive tincture (peony, cinnamon, burdock, licorice, gotu kola)',
   'Stansbury Hashimoto''s formula, adrenal tincture, and liver formula',
   'Adaptogen tincture, anti-inflammatory tincture, and thyroid tincture',
   'b',
   'Lisa recommended three formulas: a primary absorption tincture (tulsi, schisandra, ashwagandha, milk thistle, rosemary), a bitter digestive tincture (blue vervain, cardamom, ginger), and a reproductive tincture (peony, cinnamon, burdock, licorice, gotu kola).',
   'Tincture: Tulsi, Schisandra, Ashwagandha, Milk Thistle, Rosemary — support the body''s ability to take in nutrients through that methylation. Repro tincture: Peony, Cinnamon, Burdock, Licorice, Gotu kola.',
   'Case Study', 180),

  -- Q19
  ('BHC - Class 67 - Thyroid',
   'Why is rosemary included in Lisa''s primary tincture for the thyroid case?',
   'As an anti-inflammatory to reduce thyroid antibody production',
   'To support the body''s ability to take in nutrients through methylation',
   'For its rosmarinic acid content to calm T3 uptake in hyperthyroid',
   'As a digestive bitter to improve bile flow',
   'b',
   'The notes specifically state rosemary is included to "support the body''s ability to take in nutrients through that methylation" — addressing the patient''s MTHFR mutation and absorption issues.',
   'Rosemary — support the body''s ability to take in nutrients through that methylation',
   'Case Study', 190),

  -- Q20
  ('BHC - Class 67 - Thyroid',
   'What herbal actions are recommended for thyroid health according to Lisa''s notes on herbal categories?',
   'Diuretic, diaphoretic, expectorant, and emmenagogue',
   'Anti-inflammatory, immune modulating, antioxidant, glucose regulating, hypolipidemic, nervine, carminative, digestive bitters, hepatoprotective, adaptogen',
   'Lymphatic, alterative, thyroid stimulant, and hormonal',
   'Demulcent, vulnerary, anti-spasmodic, and trophorestorative only',
   'b',
   'Lisa''s notes outline ten herbal action categories for thyroid health: anti-inflammatory, immune modulating, antioxidant, glucose regulating, hypolipidemic, nervine, carminative, digestive bitters, hepatoprotective, and adaptogen.',
   'Herbal Actions for Thyroid Health: Antiinflammatory, Immune modulating (Reishi, Astragalus), Antioxidant (Selenium, Hibiscus), Glucose regulating (Cinnamon, Tulsi, Bitter melon), Hypolipidemic (Iris, Licorice), Nervine (Milky oats), Carminative, Digestive Bitters, Hepatoprotective, Adaptogens',
   'Herbal Actions for Thyroid Health', 200),

  -- Q21
  ('BHC - Class 67 - Thyroid',
   'What vulnerary herbs are recommended for gut healing in thyroid treatment to address leaky gut?',
   'Alfalfa and red clover',
   'Calendula and plantain',
   'Slippery elm and marshmallow',
   'Chamomile and licorice',
   'b',
   'The notes specifically name plantain and calendula as vulneraries (mucopolysaccharide-rich gut healers) for the leaky gut component of thyroid disorders.',
   'Use vulneraries like plantain and calendula',
   'Treatment Details', 210),

  -- Q22
  ('BHC - Class 67 - Thyroid',
   'What is Alfalfa''s clinical picture for thyroid-related presentations?',
   'Hyperthyroidism with tachycardia and anxiety needing nervine support',
   'Moderate malabsorption, poor appetite, nervousness, weakness, poor nutritional status; AI, cardioprotective, bone building, hypolipidemic, nourishing for hormone regulation',
   'Hashimoto''s with gut dysbiosis and mineral deficiencies requiring iodine',
   'Hypothyroidism with dry skin, constipation, and cold intolerance',
   'b',
   'Alfalfa''s picture is moderate malabsorption with poor appetite, nervousness, weakness, and poor nutritional status — making it a nutritive trophorestorative for thyroid-related malnutrition.',
   'Alfalfa picture: moderate malabsorption, poor appetite, nervousness, weakness, poor nutritional status. AI, cardioprotective, bone building, hypolipidemic, nourishing for hormone regulation.',
   'Alfalfa', 220),

  -- Q23
  ('BHC - Class 67 - Thyroid',
   'What adaptogen/nervine tincture did the class recommend for the thyroid case (adaptogen nervine blend)?',
   'Tulsi, schisandra, ashwagandha, milk thistle, rosemary',
   'Ashwagandha, milky oats, licorice',
   'Blue vervain, cardamom, ginger',
   'Peony, cinnamon, burdock, licorice, gotu kola',
   'b',
   'The adaptogen nervine tincture for the case was ashwagandha, milky oats, and licorice — distinct from the primary absorption tincture and the reproductive formula.',
   'adaptogen nervine: ashwagandha, milky oats, licorice',
   'Case Study', 230),

  -- Q24
  ('BHC - Class 67 - Thyroid',
   'Which herb is noted as hepatoprotective and included in Lisa''s primary absorption tincture to support liver processing in the thyroid case?',
   'Burdock',
   'Gotu Kola',
   'Milk Thistle',
   'Rosemary',
   'c',
   'Milk Thistle is the hepatoprotective herb in the primary absorption tincture (tulsi, schisandra, ashwagandha, milk thistle, rosemary) — it supports the liver''s role in T4 to T3 conversion and overall detoxification.',
   'Milk thistle in primary absorption tincture for thyroid/Hashimoto''s case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'Case Study', 240),

  -- Q25
  ('BHC - Class 67 - Thyroid',
   'What is the key observation about where thyroid dysfunction sits in relation to other body systems?',
   'Thyroid disorders are primary and always need to be treated directly first',
   'Thyroid disorders are always downstream of another imbalance — HPA axis, gut, or nutrient deficiency',
   'Thyroid issues are caused solely by iodine deficiency and are corrected with iodine supplementation',
   'Thyroid health is primarily genetic and not modifiable through herbal treatment',
   'b',
   'The notes conclude: "thyroid is often a downstream situation — circuitous" and "always downstream of another imbalance — requires addressing root issues (HPA, gut)".',
   'thyroid is often a downstream situation - circuitous - this case didn''t start out a thyroid situation though. Always downstream of another imbalance — requires addressing root issues (HPA, gut)',
   'Case Study', 250),

  -- Q26
  ('BHC - Class 67 - Thyroid',
   'What herb is specifically indicated for hyperthyroidism for its glucose-regulating AND rosmarinic acid properties?',
   'Cinnamon',
   'Lemon balm',
   'Tulsi',
   'Bitter melon',
   'c',
   'Tulsi is noted both as a glucose-regulating herb and — alongside Motherwort — as specific for hyperthyroidism via rosmarinic acid, calming the uptake of T3 into the tissues.',
   'Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues) — specific for hyperthyroidism',
   'Herbal Actions for Thyroid Health', 260),

  -- Q27
  ('BHC - Class 67 - Thyroid',
   'What precaution is noted for using Hibiscus in thyroid treatment?',
   'It can increase T3 uptake and worsen hyperthyroidism',
   'It interacts with selenium and reduces its absorption',
   'Check for low blood pressure before using',
   'It contains goitrogens and should be avoided in hypothyroid',
   'c',
   'Hibiscus is noted as an antioxidant for thyroid health with the specific caution: "check low blood pressure" — as Hibiscus can lower blood pressure further in patients who are already hypotensive.',
   'Hibiscus: antioxidant for thyroid health; note — check for low blood pressure before using.',
   'Herbal Actions for Thyroid Health', 270),

  -- Q28
  ('BHC - Class 67 - Thyroid',
   'What is the primary nourishing tea recommended alongside the tinctures for the thyroid case?',
   'Chamomile and lavender tea',
   'Nettle and fennel tea',
   'Alfalfa and Red Clover tea',
   'Elderberry and ginger tea',
   'c',
   'Alfalfa and Red Clover tea is recommended as a nourishing infusion in the treatment plan — providing mineral and nutritive support for the depleted thyroid patient.',
   'Alfalfa in nourishing tea blend with Red Clover for thyroid/Hashimoto''s case.',
   'Case Study', 280),

  -- Q29
  ('BHC - Class 67 - Thyroid',
   'What TSH range is considered normal, and what does a HIGH TSH indicate about thyroid function?',
   'Normal: 0.4–5.0; high TSH indicates hyperthyroidism',
   'Normal: 1.2–4.0; high TSH (above 5) indicates hypothyroidism — the pituitary is producing excess TSH trying to stimulate an underactive gland',
   'Normal: 2.0–8.0; high TSH indicates optimal thyroid stimulation',
   'Normal: 0.1–2.0; high TSH indicates Grave''s disease',
   'b',
   'Normal TSH range is 1.2 to 4.0 (above 5 is high, below 0.4 is low). High TSH means the pituitary is pushing hard because T3 and T4 are low — indicating hypothyroidism.',
   'Normal TSH range: 1.2 to 4.0 — Above 5 is considered high — Below 0.4 is low end. High TSH (hypothyroid).',
   'Therapeutic Strategies', 290),

  -- Q30
  ('BHC - Class 67 - Thyroid',
   'What morning fall self-care juicing blend is described in these notes?',
   'Elderberry, chamomile, and lavender',
   'Dandelion, ginger, and fennel',
   'Lemon balm, nettles, and fennel',
   'Tulsi, schisandra, and rose hip',
   'c',
   'The fall self-care morning routine includes juicing with lemon balm, nettles, and fennel — a grounding, nutritive blend for seasonal transition.',
   'Juicing with lemon balm, nettles, and fennel as a grounding morning routine for fall self-care.',
   'Fall Self-Care Strategies', 300);

END $$;
