-- Migration 376: BHC Class 23 quiz — Cardiovascular System 2 and Energetics
--
-- H = 62 distinct herbs/supplements
-- F = 4 named factual items (Eleuthero: stress-induced thrombosis; Reishi: platelet aggregation;
--       Rhodiola: stress-induced arrhythmias; Oat Straw: main medicine is silica)
-- target = clamp(15 + 62×4 + 4×1, 20, 50) = clamp(267, 20, 50) = 50 questions

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 23 - Cardiovascular System 2 and Energetics') THEN
    RAISE NOTICE 'Class 23 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- 1
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which cardiovascular adaptogen is specifically noted for reducing stress-induced arrhythmias?',
   'Reishi Mushroom', 'Rhodiola', 'Siberian Ginseng', 'American Ginseng',
   'b',
   'The notes specifically name Rhodiola as reducing stress-induced arrhythmias, as well as being cardioprotective and "energetic heart medicine."',
   '[[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine',
   'Adaptogens and CV Health', 10),

  -- 2
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which herb is described as a "drying lymphatic" specifically indicated for water retention?',
   'Goldenrod', 'Black Walnut', 'Red Root', 'Yerba Santa',
   'c',
   'Red Root is specifically labeled as a "drying lymphatic" indicated for water retention. Goldenrod and Black Walnut are paired for yeast; Yerba Santa is for bronchitis.',
   '[[Red root]] (**drying** [[lymphatic]]) - water retention',
   'Energetic Herbs by Action', 20),

  -- 3
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the hypertension calming blend, which herb was suggested as an optional addition to Linden, Hawthorn L+F, and Motherwort?',
   'Skullcap', 'Passionflower', 'Ashwagandha', 'Tulsi',
   'd',
   'The notes suggest "maybe bring in Tulsi as well" for the hypertension blend alongside Linden, Hawthorn L+F, and Motherwort.',
   'great calming blend -> ([[Linden]], [[Hawthorn]] L+F, maybe [[Motherwort]]
maybe bring in [[Tulsi]] as well)',
   'Hypertension', 30),

  -- 4
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Milky Oats is described as a trophorestorative — for which type of patient is it most indicated?',
   'People who have lost their buffer or cushion and perceive pain/sounds in an amplified way', 'Patients with low testosterone and adrenal exhaustion', 'People with chronic cold extremities and sluggish circulation', 'Patients recovering from stroke with cognitive deficits',
   'a',
   'The notes describe Milky Oats as a trophorestorative for "crispy fried nerve endings" — people who have lost their buffer and perceive pain and sounds in a more amplified way.',
   'trophorestorative - for crispy fried nerve endings
    - people who have lost their buffer or cushion
    - perceive pain, sounds in more amplified way',
   'Milky Oats', 40),

  -- 5
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which herb is specifically highlighted in the context of stroke to "calm the person down, accept what happened"?',
   'Motherwort', 'Linden', 'Skullcap', 'Passionflower',
   'b',
   'Linden is bolded in the stroke section for calming the patient — an emotional/nervous system support role in acute cardiovascular events.',
   '**[[linden]]** important to calm the person down, accept what happened',
   'Cardiovascular Conditions', 50),

  -- 6
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which cardiovascular adaptogen is described as "Liver medicine, Anger medicine" and is cardioprotective through antioxidant activity?',
   'Rhodiola', 'Reishi Mushroom', 'Schizandra', 'Siberian Ginseng',
   'c',
   'Schizandra is described as Liver medicine and Anger medicine, associated with reducing the cardiac insults of anger, and cardioprotective through antioxidant activity.',
   '[[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity',
   'Adaptogens and CV Health', 60),

  -- 7
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'What energetic quality does Damiana demonstrate in the tea blending examples?',
   'Cooling', 'Drying', 'Moistening', 'Heating',
   'd',
   'In the Energetics Teas examples, Damiana (tea #2) is listed as heating. Schizandra is moistening (sour), Raspberry is drying (astringent).',
   '2: [[Damiana]]
- heating',
   'Energetics of Tea Blending', 70),

  -- 8
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which herb is described as "super drying" and specifically indicated for bronchitis?',
   'Yerba Santa', 'Osha', 'Goldenrod', 'Black Walnut',
   'a',
   'Yerba Santa is explicitly described as "super drying" and listed for bronchitis in the drying herbs section. Osha is for congestion; Black Walnut and Goldenrod are for yeast.',
   '[[Yerba santa]] (super drying) - bronchitis',
   'Energetic Herbs by Action', 80),

  -- 9
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which spice combination is described as a "classic combo for inflamed conditions" that "gives good tools to the gut"?',
   'Ginger, Cardamom, Cinnamon', 'Cumin, Coriander, Fennel', 'Black Pepper, Turmeric, Ginger', 'Sumac, Fenugreek, Basil',
   'b',
   'The notes explicitly call out Cumin, Coriander, and Fennel as a classic combo for inflamed conditions.',
   'Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut',
   'Spices for Energetic Constitutions', 90),

  -- 10
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'What is identified as the main medicine in Oat Straw?',
   'Avenanthramides', 'Beta-glucan', 'Silica', 'Saponins',
   'c',
   'The notes state that Oat Straw''s "main medicine is silica" and that it is a tissue restorative.',
   '([[Oats|Oat straw]])
- main medicine is silica
- tissue restorative',
   'Milky Oats', 100),

  -- 11
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which cardiovascular adaptogen is noted for lowers cholesterol, improving ischemic heart disease, AND reducing stress-induced thrombosis?',
   'Rhodiola', 'Reishi Mushroom', 'American Ginseng', 'Siberian Ginseng',
   'd',
   'Siberian Ginseng (Eleuthero) is described with all three actions: lowers cholesterol, improves ischemic heart disease, and reduces stress-induced thrombosis.',
   '[[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis',
   'Adaptogens and CV Health', 110),

  -- 12
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Beyond calming herbs, what other category of herbs is specifically suggested for heart bypass support?',
   'Alterative cleansing herbs', 'Diuretic herbs', 'Emmenagogue herbs', 'Astringent herbs',
   'a',
   'The notes say to "also use alterative cleansing herbs" alongside calming herbs (Yarrow, Cinnamon, Catnip, Skullcap) for heart bypass support.',
   '- also use [[alterative]] cleansing herbs
- maybe an [[adaptogen]]',
   'Heart Bypass Support', 120),

  -- 13
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the energetics tea examples, Raspberry represents which energetic quality?',
   'Moistening', 'Drying', 'Cooling', 'Warming',
   'b',
   'Raspberry is listed as tea #3 with the label "astringent = drying." Schizandra is moistening (sour); Damiana is heating.',
   '3: [[Raspberry]]
- [[astringent]] = drying',
   'Energetics of Tea Blending', 130),

  -- 14
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Rhodiola is described as "energetic heart medicine" — which specific heart-protective action is highlighted alongside this description?',
   'Lowers LDL oxidation', 'Prevents platelet aggregation', 'Cardioprotective and normalizes blood pressure', 'Reduces cholesterol via liver support',
   'c',
   'The notes say Rhodiola is "cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine." LDL oxidation is Panax Ginseng; platelet aggregation is Reishi.',
   '[[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine',
   'Adaptogens and CV Health', 140),

  -- 15
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Sumac is noted for which combination of properties in the energetics framework?',
   'Heating, pungent, stimulating', 'Cooling, bitter, anti-inflammatory', 'Warming, aromatic, carminative', 'Sour, moistening, antioxidant',
   'd',
   'Sumac is described as "kind of sour and moistening" and also antioxidant. It is noted as good for Wet, Cold, and Dry constitutions.',
   '[[sumac]] is kind of sour and moistening, good savory additive for a lot of things, and moistening (so not if someone is congested)
    - [[sumac]] also antioxidant',
   'Spices for Energetic Constitutions', 150),

  -- 16
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which cardiovascular herb is described as an "aromatic pungent spice, strong sedative" with antiviral properties?',
   'Asafetida', 'Sassafras', 'Hibiscus', 'Garlic',
   'a',
   'Asafetida is described as an aromatic pungent spice, a strong sedative, and noted for "warding off viral load."',
   'Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load',
   'Adaptogens and CV Health', 160),

  -- 17
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Milky Oats milk is soluble in which menstruum, making tincture the appropriate preparation?',
   'Water (hot infusion)', 'Alcohol', 'Glycerin', 'Apple cider vinegar',
   'b',
   'The notes explicitly state that "milk is not soluble in water, only alcohol," making an alcohol tincture essential to capture the medicinal constituents.',
   '- milk is not soluble in water, only alcohol
- can freeze it if needed',
   'Milky Oats', 170),

  -- 18
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which adaptogen provides all three of these cardiovascular actions: lowers cholesterol, protects against platelet aggregation, and is hypotensive?',
   'Siberian Ginseng', 'Rhodiola', 'Reishi Mushroom', 'Schizandra',
   'c',
   'Reishi Mushroom is described as lowering cholesterol, protecting against clot formation and platelet aggregation, and being hypotensive.',
   '[[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive',
   'Adaptogens and CV Health', 180),

  -- 19
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the moistening herbs section, a cold infusion of Cinnamon is described as what type of preparation?',
   'Strongly diaphoretic', 'Deeply sedating', 'A specific for diarrhea with bleeding', 'Low-key adaptogenic',
   'd',
   'Cinnamon cold infusion is described as "low-key adaptogenic" and indicated for diarrhea as a preventive that slows transit time.',
   'diarrhea (even a preventive, slowing down transit time) -> [[cinnamon]] [[cold infusion]] (low-key adaptogenic)',
   'Energetic Herbs by Action', 190),

  -- 20
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Celery Seed is noted in which Ayurvedic context related to hormones?',
   '"Any tiny seeds help with hormone production"', '"Seed coats stimulate the endocrine glands"', '"Seeds dry up excess dampness causing hormonal imbalance"', '"Tiny seeds tonify the reproductive organs directly"',
   'a',
   'The notes state "Celery seed - moistening; ayurveda -> any tiny seeds help with hormone production," placing it in the Dry constitution support section.',
   '- Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production',
   'Spices for Energetic Constitutions', 200),

  -- 21
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'For which specific condition is Prickly Ash listed as a warming herb?',
   'Chronic fatigue and adrenal exhaustion', 'Raynaud''s syndrome', 'Intermittent claudication', 'Cold-type arthritis with stiffness',
   'b',
   'Prickly Ash is described as "pungent spicy — for Reynaud''s syndrome" in the warming herbs list.',
   '[[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome',
   'Energetic Herbs by Action', 210),

  -- 22
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which herb is listed as moistening for BOTH adrenal fatigue AND anxiety?',
   'Lemon Balm', 'Astragalus', 'Milky Oats', 'Shatavari',
   'c',
   'Milky Oats appears in both the "adrenal fatigue" and "anxiety" bullets in the moistening herbs section.',
   '    - adrenal fatigue - milky [[oats]]
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari',
   'Energetic Herbs by Action', 220),

  -- 23
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'What is the energetic direction of dry Ginger compared to fresh Ginger?',
   'Dry ginger is more moistening; fresh is drying', 'Both are equally warming', 'Dry ginger is cooling; fresh is warming', 'Dry ginger is much more heating than fresh',
   'd',
   'The notes explicitly state "dry ginger — much more heating than fresh" under Cold constitution spices.',
   '    - [[Ginger]], dry - much more heating than fresh',
   'Spices for Energetic Constitutions', 230),

  -- 24
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which herb is given as the example of cardiovascular versatility with the note "can do a lot of things"?',
   'Linden', 'Hawthorn', 'Motherwort', 'Yarrow',
   'a',
   'The Tip section says "don''t use a ton of herbs — find a few that cover most actions" and gives Linden as the example: "Linden can do a lot of things."',
   '- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things',
   'Heart Bypass Support', 240),

  -- 25
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which heart herb among the Black Herbal herbs is noted as the one to "work with the most" and is "good for NS"?',
   'Motherwort', 'Linden', 'Hibiscus', 'Sassafras',
   'b',
   'Linden is singled out as the herb to "work with the most" and noted as "good for NS" (nervous system) in the Black Herbal CV herbs list.',
   '[[Linden]] - work with the most
    - good for NS',
   'Adaptogens and CV Health', 250),

  -- 26
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Oregon Grape Root is listed as a drying herb for oily skin. What mechanism is given?',
   'Tannins tone the sebaceous glands', 'Berberines act on the liver', 'Bitters stimulate bile to clear excess fats', 'Alkaloids reduce androgen-driven oil production',
   'c',
   'The notes say "Oregon Grape Root - oily skin (berberines for liver)," indicating the liver connection via berberine alkaloids.',
   '[[Oregon Grape Root]] - oily skin (berberines for liver)',
   'Energetic Herbs by Action', 260),

  -- 27
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'How is Galangal described relative to Ginger in the spice notes?',
   'Stronger and more heating than Ginger', 'Similar warming effects but more bitter', 'Milder than Ginger', 'Cooling where Ginger is heating',
   'c',
   'The notes say "Galangal — milder than Ginger" in the Cold constitution spices section.',
   '    - [[Galangal]] - milder than [[Ginger]]',
   'Spices for Energetic Constitutions', 270),

  -- 28
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'For which specific indication is Blackberry Root listed as a cooling herb?',
   'Diarrhea', 'Fever', 'Colitis', 'IBS',
   'a',
   'Blackberry Root is specifically listed as "cooling" for diarrhea. Fever is Yarrow; Colitis and IBS are indications listed for the cooling category generally.',
   '[[Blackberry]] Root - diarr',
   'Energetic Herbs by Action', 280),

  -- 29
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Schizandra''s cardioprotective mechanism is specifically attributed to which property?',
   'Hypotensive action', 'Antioxidant activity', 'Anti-platelet action', 'Cholesterol-lowering',
   'b',
   'The notes say Schizandra is "cardioprotective through antioxidant activity." Hypotensive is Reishi; anti-platelet is Reishi; cholesterol-lowering is Reishi and Eleuthero.',
   '[[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity',
   'Adaptogens and CV Health', 290),

  -- 30
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which two herbs are specifically paired together as drying herbs for yeast overgrowth?',
   'Osha and Red Root', 'Oregon Grape and Goldenrod', 'Black Walnut and Goldenrod', 'Yerba Santa and Osha',
   'c',
   'The notes pair Black Walnut and Goldenrod together with a colon for yeast: "[[Black Walnut]], [[Goldenrod]]: yeast."',
   '[[Black Walnut]], [[Goldenrod]]: yeast',
   'Energetic Herbs by Action', 300),

  -- 31
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which trophorestorative herb is specifically described for people who "perceive pain, sounds in more amplified way"?',
   'Oat Straw', 'Skullcap', 'Passionflower', 'Milky Oats',
   'd',
   'Milky Oats is described as trophorestorative for people who have lost their buffer and perceive pain and sounds in a more amplified way.',
   'trophorestorative - for crispy fried nerve endings
    - people who have lost their buffer or cushion
    - perceive pain, sounds in more amplified way',
   'Milky Oats', 310),

  -- 32
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which cooling herb is noted with the Tilgner quote "distributes moisture but is ultimately drying" and is indicated for endometriosis?',
   'Burdock', 'Yarrow', 'Turmeric', 'Marshmallow',
   'a',
   'Burdock is cited with the Tilgner quote and listed as a cooling herb for endometriosis, despite its ultimately drying quality.',
   '[[Burdock]] ("distributes moisture but is ultimately drying" - Tilgner) - endo.',
   'Energetic Herbs by Action', 320),

  -- 33
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'American Ginseng provides which two specific cardiovascular benefits according to the notes?',
   'Lowers cholesterol and reduces thrombosis', 'Cardioprotective and blood sugar regulation', 'Reduces arrhythmias and normalizes blood pressure', 'Liver support and anger medicine',
   'b',
   'American Ginseng is described as "Cardioprotective, blood sugar regulation." The other actions belong to other adaptogens.',
   '- American Ginseng - Cardioprotective, blood sugar regulation',
   'Adaptogens and CV Health', 330),

  -- 34
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'The herbs Marshmallow, Blackberry Root, Yarrow, Turmeric, Catnip, and Burdock are all grouped under which energetic category?',
   'Warming herbs', 'Drying herbs', 'Cooling herbs', 'Moistening herbs',
   'c',
   'All six herbs are listed under "when would we need cooling herbs?" with specific indications (heartburn, diarrhea, fever, inflammation, headache, endometriosis).',
   '    - [[Marshmallow]] - heartburn
        - [[Blackberry]] Root - diarr
        - [[Yarrow]] - fever
        - [[Turmeric]] - inflammation, endometriosis
        - [[Catnip]] - headache
        - [[Burdock]] ("distributes moisture but is ultimately drying" - Tilgner) - endo.',
   'Energetic Herbs by Action', 340),

  -- 35
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which cardiovascular adaptogen is noted for cardio anti-inflammatory effects and reducing LDL oxidation?',
   'Siberian Ginseng', 'American Ginseng', 'Rhodiola', 'Panax Ginseng',
   'd',
   'Panax Ginseng is noted as "cardio anti inflammatory, reduces LDL oxidation." Siberian Ginseng lowers cholesterol and thrombosis; American Ginseng is cardioprotective and blood sugar.',
   '- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation',
   'Adaptogens and CV Health', 350),

  -- 36
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Yerba Mansa (Anemopsis californica) is noted for what specific immunological action?',
   'Stimulates immune function in the mucus membranes', 'Activates macrophage response to viral pathogens', 'Modulates autoimmune inflammation in the lungs', 'Stimulates white blood cell production',
   'a',
   'The notes say Yerba Mansa "stimulates immune function in the mucus membranes," making it useful for dry cough.',
   'also [[Yerba mansa]] (Anemposis - stimulates immune function in the mucus membranes)',
   'Energetic Herbs by Action', 360),

  -- 37
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which two herbs are listed together for the dry cough indication?',
   'Marshmallow and Slippery Elm', 'Mullein and Yerba Mansa', 'Osha and Elecampane', 'Licorice and Oat Straw',
   'b',
   'The notes say "dry cough → mullein flowers and roots (not hairy leaves), also Yerba Mansa (Anemopsis — stimulates immune function in the mucus membranes)."',
   'dry cough -> [[mullein]] flowers and roots (not hairy leaves), also [[Yerba mansa]] (Anemposis - stimulates immune function in the mucus membranes)',
   'Energetic Herbs by Action', 370),

  -- 38
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the energetics tea examples, which herb''s astringent quality makes it representative of the drying energetic?',
   'Chamomile', 'Damiana', 'Raspberry', 'Schizandra',
   'c',
   'Raspberry is explicitly labeled "astringent = drying" in the energetics teas section. Schizandra is sour = moistening; Damiana is heating.',
   '3: [[Raspberry]]
- [[astringent]] = drying',
   'Energetics of Tea Blending', 380),

  -- 39
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Rhodiola''s cardiovascular action specifically addresses which cardiac event triggered by stress?',
   'Atherosclerosis', 'Hypertension episodes', 'Arrhythmias', 'Thrombosis',
   'd',
   'Rhodiola specifically "reduces stress-induced arrhythmias." Stress-induced thrombosis is Eleuthero; hypertension is both Rhodiola and others but arrhythmias is the most specific note.',
   '[[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine',
   'Adaptogens and CV Health', 390),

  -- 40
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Marshmallow appears in both the cooling AND moistening sections. Which cooling indication is specifically listed for it?',
   'Heartburn', 'Diarrhea', 'Fever', 'IBS',
   'a',
   'Marshmallow is listed as "cooling — heartburn" in the cooling herbs section, and separately for dehydration, constipation, and dry gut in the moistening section.',
   '[[Marshmallow]] - heartburn',
   'Energetic Herbs by Action', 400),

  -- 41
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the hypertension calming blend, which specific part of Hawthorn is mentioned?',
   'Berry', 'Leaf and flower (L+F)', 'Root bark', 'Seed',
   'b',
   'The blend specifies "Hawthorn L+F" (leaf and flower), not the berry. The berry and L+F forms have overlapping but distinct actions.',
   'great calming blend -> ([[Linden]], [[Hawthorn]] L+F, maybe [[Motherwort]]
maybe bring in [[Tulsi]] as well)',
   'Hypertension', 410),

  -- 42
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'For which energetic constitution type would you prescribe Nutmeg, Galangal, dry Ginger, and Basil?',
   'Wet', 'Hot', 'Cold', 'Dry',
   'c',
   'All four herbs are listed under "to help Cold" in the spices section. Dry Ginger is specifically described as "much more heating than fresh" for the cold constitution.',
   '- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]',
   'Spices for Energetic Constitutions', 420),

  -- 43
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which moistening herb is indicated for reproductive issues "from dry tissues" and is specifically noted for stimulating circulation?',
   'White Peony', 'Shatavari', 'Licorice', 'Dong Quai',
   'd',
   'Dong Quai is listed with the note "stim circ" (stimulates circulation) for reproductive issues from dry tissues, paired with White Peony and Licorice.',
   'reproductive issues - dong quai (stim circ), white peony with [[Licorice root|licorice]]',
   'Energetic Herbs by Action', 430),

  -- 44
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'What is the formulation principle stated in the cardiovascular tip?',
   'Don''t use a ton of herbs — find a few that cover most actions', 'Always combine a nervine with a cardiotonic', 'Start with adaptogens before adding specifics', 'Use the same formula for at least 3 months before adjusting',
   'a',
   'The Tip section says: "don''t use a ton of herbs — find a few that cover most actions," with Linden as the example of a versatile herb.',
   '- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things',
   'Heart Bypass Support', 440),

  -- 45
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the Black Herbal CV herbs, which herb is specifically noted as good for the nervous system?',
   'Motherwort', 'Linden', 'Hibiscus', 'Garlic',
   'b',
   'Linden is noted as the herb to "work with the most" and "good for NS" (nervous system) among the Black Herbal cardiovascular herbs.',
   '[[Linden]] - work with the most
    - good for NS',
   'Adaptogens and CV Health', 450),

  -- 46
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which two herbs are specifically paired together for dry skin moistening?',
   'Marshmallow and Slippery Elm', 'Calendula and Rose', 'Gotu Kola and Calendula', 'Dong Quai and White Peony',
   'c',
   'The notes list "dry skin → Gotu Kola, Calendula" in the moistening herbs section.',
   '    - dry skin - [[gotu kola]], [[calendula]]',
   'Energetic Herbs by Action', 460),

  -- 47
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Beyond lowering cholesterol, Siberian Ginseng (Eleuthero) is noted for improving which specific cardiovascular disease?',
   'Hypertensive heart disease', 'Congestive heart failure', 'Ischemic heart disease', 'Valvular heart disease',
   'c',
   'The notes say Eleuthero "improves ischemic heart disease" specifically.',
   '[[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis',
   'Adaptogens and CV Health', 470),

  -- 48
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'Which adaptogen''s cardiovascular role is specifically framed around the emotional connection between anger and heart disease?',
   'Schizandra', 'Rhodiola', 'Reishi Mushroom', 'Holy Basil',
   'a',
   'Schizandra is described as "Anger medicine" — "associated with reducing insults of anger on the heart," making it unique among the CV adaptogens for this emotional-cardiac connection.',
   '[[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity',
   'Adaptogens and CV Health', 480),

  -- 49
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'In the four energetics tea examples, which herb represents "sour = moistening"?',
   'Chamomile', 'Schizandra', 'Damiana', 'Raspberry',
   'b',
   'Schizandra is listed as tea #1 with the note "sour = moistening." Damiana is heating; Raspberry is astringent = drying.',
   '1: Schizandra
- sour = moistening',
   'Energetics of Tea Blending', 490),

  -- 50
  ('BHC - Class 23 - Cardiovascular System 2 and Energetics',
   'For the moistening indication of anxiety, which group of five herbs is specifically listed together in the notes?',
   'Linden, Motherwort, Skullcap, Passionflower, Valerian', 'Chamomile, Catnip, Lemon Balm, Kava, Hops', 'Milky Oats, Catnip, Lemon Balm, Astragalus, Shatavari', 'Ashwagandha, Holy Basil, Reishi, Schizandra, Rhodiola',
   'c',
   'The notes list "anxiety → milky oats, catnip, lemon balm, astragalus, shatavari" as moistening herbs for anxiety.',
   '    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari',
   'Energetic Herbs by Action', 500);

END $$;
