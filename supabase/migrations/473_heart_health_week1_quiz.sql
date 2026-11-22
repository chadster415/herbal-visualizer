-- Migration 473: Herbal Heart Health - Week 1 quiz questions
-- Class: Herbal Heart Health - Week 1 - Reading the Hearts Whole Story
--
-- Target calculation:
--   H (distinct herbs + supplements) = 53
--   F (named factual items: specific stats, Frank's outcomes/labs, named protocols) = 12
--   target = clamp(15 + 53*4 + 12, 20, 50) = clamp(239, 20, 50) = 50 questions
--
-- Correct option distribution: a=13, b=12, c=12, d=13

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_quiz_questions
    WHERE class_name = 'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story'
  ) THEN
    RAISE NOTICE 'Week 1 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb is described as relaxing vascular tension while soothing the nerves, making it a primary herb for the Heat and Tension pattern?',
   'Motherwort', 'Linden', 'Black Haw', 'Blue Vervain',
   'b',
   'Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves; it is specifically named as a primary herb for Heat and Tension. Motherwort addresses palpitations with anxiety; Black Haw relaxes vascular spasm; Blue Vervain is for the wound-tight, overworked person.',
   'Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves; suited to the Heat and Tension pattern of elevated BP, irritability, difficulty sleeping, and rapid pulse.',
   'Heat and Tension Pattern', 10),

  -- Q2 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The Heat and Tension cardiovascular pattern is associated with which archetype in Rosalee de la Foret''s framework?',
   'Rabbit', 'Eeyore', 'Piglet', 'Pooh',
   'a',
   'Rosalee uses the Rabbit as the archetype for Heat and Tension: bustling, quick to bristle, everything feels urgent, the system is reactive and keyed up. Eeyore is Cold and Deficiency; Piglet is Blood Deficiency.',
   'Rosalee uses Rabbit as the archetype for Heat and Tension: bustling, quick to bristle, everything feels urgent, the system is reactive and keyed up.',
   'Heat and Tension Pattern', 20),

  -- Q3 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb is described as especially helpful when palpitations are linked to anxiety, making it a key herb for the Heat and Tension pattern?',
   'Lemon Balm', 'Linden', 'Hawthorn', 'Motherwort',
   'd',
   'Motherwort (*Leonurus cardiaca*) is specifically noted as especially helpful when palpitations are linked to anxiety. Lemon Balm gently calms both nervous system and heart; Linden relaxes vascular tension; Hawthorn supports vessel tone.',
   'Motherwort (*Leonurus cardiaca*) is especially helpful when palpitations are linked to anxiety; a key herb for the Heat and Tension pattern.',
   'Heat and Tension Pattern', 30),

  -- Q4 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The Cold and Deficiency cardiovascular pattern is characterized by which set of presentations?',
   'Low BP, cold hands and feet, fatigue, dizziness, weak pulse, pallor',
   'Elevated BP, flushed skin, irritability, rapid pulse',
   'Varicose veins, sharp localized pain, heavy limbs, edema',
   'Dry skin, dizziness, difficulty concentrating, pallor, brittle hair',
   'a',
   'Cold and Deficiency presents as a cardiovascular system that feels cold, depleted, or underpowered: low blood pressure, cold hands and feet, fatigue, dizziness, weak pulse, pallor, and easy exhaustion. Option B describes Heat and Tension, C describes Stagnation, D describes Blood Deficiency.',
   'Cold and Deficiency presents as a cardiovascular system that feels cold, depleted, or underpowered: low blood pressure, cold hands and feet, fatigue, dizziness, weak pulse, pallor, and easy exhaustion.',
   'Cold and Deficiency Pattern', 40),

  -- Q5 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb is described as a classic circulatory stimulant specifically for cold, sluggish tissues, making it well-suited to Cold and Deficiency?',
   'Motherwort', 'Blue Vervain', 'Prickly Ash', 'Black Haw',
   'c',
   'Prickly Ash (*Zanthoxylum americanum*) is described as a classic circulatory stimulant for cold, sluggish tissues - the defining feature of Cold and Deficiency. The other three are relaxant nervines suited to Heat and Tension patterns.',
   'Prickly Ash (*Zanthoxylum americanum*) is a classic circulatory stimulant for cold, sluggish tissues; best suited to the Cold and Deficiency pattern.',
   'Cold and Deficiency Pattern', 50),

  -- Q6 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Rosemary is specifically noted for which dual benefit making it suited to Cold and Deficiency with cognitive symptoms?',
   'Relaxes vascular tension and soothes the nerves',
   'Warms circulation and digestion',
   'Stimulates blood flow in small amounts',
   'Improves circulation while sharpening mental clarity',
   'd',
   'Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity - making it specifically suited to Cold and Deficiency with cognitive dullness alongside poor circulation. Option B describes Ginger; Option A describes Linden.',
   'Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity; suited to Cold and Deficiency pattern with cognitive dullness.',
   'Cold and Deficiency Pattern', 60),

  -- Q7 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The Stagnation cardiovascular pattern is likened to which image in the class notes?',
   'A stream hitting a logjam - water still there but backed up, pooling, building pressure',
   'A dried riverbed with no water or movement',
   'A turbulent river running too fast and overflowing its banks',
   'A frozen lake where all movement has stopped',
   'a',
   'Stagnation is likened to a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction. This captures the idea that blood exists but is not moving freely, causing varicose veins, edema, and sharp localized pain.',
   'Like a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction.',
   'Stagnation Pattern', 70),

  -- Q8 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb is described as traditionally moving and nourishing blood, making it a primary herb for the Stagnation pattern?',
   'Cinnamon', 'Turmeric', 'Ginger', 'Dong Quai',
   'd',
   'Dong Quai (*Angelica sinensis*) is specifically described as traditionally moving and nourishing blood - the dual action distinguishing it in the Stagnation pattern. Cinnamon warms and encourages circulation; Turmeric supports circulation and inflammatory balance; Ginger gently stimulates blood flow.',
   'Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; a primary herb for the Stagnation pattern of impaired circulation.',
   'Stagnation Pattern', 80),

  -- Q9 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Blood Deficiency in TCM is characterized by which emotional or mental presentation alongside the physical symptoms?',
   'Irritability, anger, and a hot tense feeling',
   'Restlessness, unsettled mind, and anxiety - because blood anchors the mind and spirit',
   'Deep fatigue, coldness, and lack of motivation',
   'Heaviness in the limbs and sharp localized pain',
   'b',
   'In TCM, blood is said to anchor the mind and spirit; when deficient, the mind may feel restless or unsettled. This distinguishes Blood Deficiency''s anxiety and restlessness from the Hot-Tense irritability of Heat and Tension (option A) or the deep fatigue of Cold and Deficiency (option C).',
   'In TCM, blood is said to anchor the mind and spirit; when deficient, the mind may feel restless or unsettled.',
   'Blood Deficiency Pattern', 90),

  -- Q10 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb supports iron metabolism and is a key herb for the Blood Deficiency pattern with pallor and fatigue?',
   'Burdock Root', 'Dandelion Root', 'Yellow Dock', 'Nettle',
   'c',
   'Yellow Dock (*Rumex crispus*) specifically supports iron metabolism, distinguishing it from Nettle (rich in minerals broadly), Burdock Root (nourishes and supports the blood), and Dandelion Root (supports digestion and nutrient assimilation).',
   'Yellow Dock (*Rumex crispus*) supports iron metabolism; a key herb for Blood Deficiency pattern with pallor, fatigue, and anemia tendency.',
   'Blood Deficiency Pattern', 100),

  -- Q11 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which category of herbs is noted as supporting healthy glucose metabolism through a berberine mechanism, indirectly supporting cardiovascular health?',
   'Adaptogens like Ashwagandha and Reishi',
   'Liver herbs like Dandelion Root and Artichoke',
   'Nervines like Motherwort and Blue Vervain',
   'Berberine-containing plants like Oregon Grape and Goldenseal',
   'd',
   'The notes specifically identify berberine-containing plants (like goldenseal or Oregon grape) alongside cinnamon and fenugreek for healthy glucose metabolism, and note that blood sugar balance indirectly supports long-term cardiovascular health.',
   'Cinnamon, fenugreek, and berberine-containing plants (like goldenseal or Oregon grape) are often used to support healthy glucose metabolism. Supporting blood sugar balance indirectly supports long-term cardiovascular health.',
   'Blood Sugar and Metabolic Support', 110),

  -- Q12 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Hawthorn is noted as working on multiple levels for cardiovascular health. Which statement best captures all three levels described in the notes?',
   'Calms the nervous system, reduces inflammation, and lowers cholesterol',
   'Tonifies the heart muscle, supports vessel tone, and offers antioxidant protection to the vessel lining',
   'Moves stagnant blood, warms circulation, and supports kidney function',
   'Nourishes the blood, supports iron metabolism, and reduces palpitations',
   'b',
   'Hawthorn is specifically described as working on three levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining - making it unique among the cardiovascular herbs discussed.',
   'Hawthorn (*Crataegus spp.*) nourishes the heart while also supporting healthy endothelial function; works on multiple levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining.',
   'Cardiovascular Inflammation and Vascular Health', 120),

  -- Q13 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Hibiscus is described as pairing well with which category of herbs in a Heat and Tension protocol?',
   'Adaptogenic mushrooms', 'Blood-moving herbs', 'Nervine-cardiac herbs', 'Digestive bitters',
   'c',
   'Hibiscus (*Hibiscus sabdariffa*) is well-studied for gentle blood pressure support and is noted as pairing well with other nervine-cardiac herbs in a Heat and Tension protocol - because both address the nervous-system-heart connection in this pattern.',
   'Hibiscus (*Hibiscus sabdariffa*) offers antioxidant support while gently relaxing blood vessels; well-studied for gentle blood pressure support; pairs well with other nervine-cardiac herbs in a Heat and Tension protocol.',
   'Cardiovascular Inflammation and Vascular Health', 130),

  -- Q14 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Garlic is described as a "dual-action heart herb." What are the two actions?',
   'Warms circulation and nourishes blood',
   'Reduces inflammation and relaxes vascular tension',
   'Tonifies the heart muscle and lowers cholesterol',
   'Supports both circulation and immune balance',
   'd',
   'Garlic (*Allium sativum*) is specifically described as a dual-action heart herb for supporting both circulation and immune balance, used traditionally and supported by modern research for its cardiovascular and antimicrobial effects.',
   'Garlic (*Allium sativum*) supports both circulation and immune balance - a dual-action heart herb; used traditionally and supported by modern research for its cardiovascular and antimicrobial effects.',
   'Cardiovascular Inflammation and Vascular Health', 140),

  -- Q15 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The class notes identify the heart-nervous system connection as one reason why many traditional heart herbs are nervines. Which herb is specifically described as famous for calming a racing heart connected to anxiety?',
   'Linden', 'Motherwort', 'Lemon Balm', 'Hawthorn',
   'b',
   'Motherwort (*Leonurus cardiaca*) is specifically described as famous for calming a racing heart connected to anxiety. Linden relaxes vascular tension while soothing the nervous system; Lemon Balm gently settles emotional agitation and palpitations; Hawthorn supports vessel tone.',
   'Motherwort (*Leonurus cardiaca*) is famous for calming a racing heart connected to anxiety; a primary nervine-cardiac herb for the heart-nervous system connection.',
   'Heart-Nervous System Support', 150),

  -- Q16 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Cordyceps is described as a tonic mushroom traditionally used to support what combination of functions?',
   'Calm the heart-mind, resolve phlegm, and support sleep',
   'Modulate the immune system, calm the nervous system, and balance blood sugar',
   'Move blood, support liver function, and reduce inflammation',
   'Support the lungs, improve stamina, and restore vitality when the whole system feels depleted',
   'd',
   'Cordyceps (*Cordyceps sinensis*) is described as a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality when the whole system feels depleted - linking it to the Lungs and Heart connection and the adaptogen section.',
   'Cordyceps (*Cordyceps sinensis*) is a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality when the whole system feels depleted; bridges lung and cardiovascular endurance.',
   'Lungs and Heart', 160),

  -- Q17 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which three herbs are identified as liver-supportive for cardiovascular health through supporting bile flow and metabolic balance?',
   'Dandelion Root, Artichoke Leaf, and Burdock Root',
   'Garlic, Turmeric, and Cinnamon',
   'Nettle, Yellow Dock, and Burdock',
   'Gentian, Dandelion, and Milk Thistle',
   'a',
   'The notes specifically name Dandelion root, Artichoke leaf, and Burdock root as the three liver-supportive herbs for cardiovascular health, all working through bile flow and metabolic balance to indirectly support healthy circulation and blood composition.',
   'Dandelion root (*Taraxacum officinale*), Artichoke leaf (*Cynara scolymus*), and Burdock root (*Arctium lappa*) support bile flow and metabolic balance, indirectly supporting healthy circulation and blood composition.',
   'Liver Support for Cardiovascular Health', 170),

  -- Q18 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Dandelion leaf is noted as "notably potassium-sparing." What does this mean in the context of kidney and heart support?',
   'It depletes potassium more slowly than pharmaceutical diuretics',
   'It is contraindicated with potassium-based medications',
   'It brings its own potassium while supporting fluid balance, unlike drugs that deplete it',
   'It conserves potassium by inhibiting aldosterone release',
   'c',
   'Dandelion leaf is described as notably potassium-sparing: it brings its own potassium while supporting fluid balance - a key advantage over pharmaceutical diuretics that deplete electrolytes and can worsen cardiovascular risk.',
   'Dandelion leaf is notably potassium-sparing - it brings its own potassium while supporting fluid balance.',
   'Kidney and Heart Support', 180),

  -- Q19 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The class notes describe digestive bitters as having "far-reaching effects on metabolic and cardiovascular health." What is the recommended way to use them?',
   'As a nightly tea before bed to support overnight repair',
   'Before meals to activate the entire digestive cascade',
   'After meals to improve nutrient absorption from food',
   'As a morning tonic to stimulate circulation on an empty stomach',
   'b',
   'Bitters before meals activate the entire digestive cascade - a simple daily practice with far-reaching effects on metabolic and cardiovascular health. Gentian and Dandelion are the two classic examples named.',
   'Bitters before meals activate the entire digestive cascade - a simple daily practice with far-reaching effects on metabolic and cardiovascular health.',
   'Digestive Support for Heart Health', 190),

  -- Q20 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which four herbs are identified as antimicrobial, anti-inflammatory herbs used in mouth rinses for cardiovascular-relevant oral health?',
   'Sage, Myrrh, Calendula, and Goldenseal',
   'Linden, Rose, Calendula, and Goldenseal',
   'Garlic, Myrrh, Sage, and Thyme',
   'Calendula, Goldenseal, Echinacea, and Oregon Grape',
   'a',
   'The notes specifically name Sage (*Salvia officinalis*), Myrrh (*Commiphora myrrha*), Calendula (*Calendula officinalis*), and Goldenseal (*Hydrastis canadensis*) as the four oral health herbs used in mouth rinses to address the oral microbiome and reduce cardiovascular risk from gum bacteria.',
   'Sage (*Salvia officinalis*), Myrrh (*Commiphora myrrha*), Calendula (*Calendula officinalis*), and Goldenseal (*Hydrastis canadensis*) are antimicrobial, anti-inflammatory herbs used in mouth rinses and gum care.',
   'Oral Health and Cardiovascular Risk', 200),

  -- Q21 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Gum disease triggers cardiovascular risk through what specific mechanism described in the notes?',
   'Directly raising LDL cholesterol levels',
   'Depleting potassium and increasing arrhythmia risk',
   'Triggering chronic low-grade inflammation, allowing bacteria to enter the bloodstream, and potentially damaging blood vessel walls',
   'Increasing cortisol levels that promote atherosclerosis',
   'c',
   'The notes describe a three-part mechanism: gum disease triggers chronic low-grade inflammation, allows bacteria to enter the bloodstream, and may directly damage blood vessel walls - making oral health a surprisingly impactful cardiovascular intervention.',
   'Gum disease triggers chronic low-grade inflammation, allows bacteria to enter the bloodstream, and may directly damage blood vessel walls.',
   'Oral Health and Cardiovascular Risk', 210),

  -- Q22 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Rose is described as serving which specific role for the emotional heart?',
   'Profoundly relaxing, releasing tension from the chest and soothing grief',
   'Nourishing both the physical and emotional heart as a tonic and restorative',
   'Calming a restless mind and anchoring the spirit in TCM',
   'Gently opening the heart and supporting emotional processing',
   'd',
   'Rose (*Rosa spp.*) is described as gently opening the heart and supporting emotional processing - distinguishing it from Linden (option A: releases tension and soothes grief) and Hawthorn (option B: nourishes physical and emotional heart).',
   'Rose (*Rosa spp.*) gently opens the heart and supports emotional processing; suited to heartache, grief, and the emotional dimensions of cardiovascular health.',
   'Emotional Heart', 220),

  -- Q23 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb is described as profoundly relaxing, releasing tension from the chest, and soothing grief and anxiety as an emotional heart herb?',
   'Rose', 'Linden', 'Hawthorn', 'Oats',
   'b',
   'Linden (*Tilia spp.*) is specifically described as profoundly relaxing, releasing tension from the chest and soothing grief and anxiety in the Emotional Heart section - distinct from its action of relaxing vascular tension in the Heat and Tension pattern.',
   'Linden (*Tilia spp.*) is profoundly relaxing, releasing tension from the chest and soothing grief and anxiety; a key herb for the emotional dimensions of heart health.',
   'Emotional Heart', 230),

  -- Q24 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'In TCM, what does the concept of "Shen" encompass, and why is it relevant to cardiovascular health?',
   'The consciousness, thought, memory, and emotional experience housed in the heart; relevant because cardiovascular and cognitive health are deeply intertwined',
   'The vital energy that circulates through meridians and powers organ function',
   'The cooling and moistening quality of blood that nourishes tissues',
   'The transformative digestive force that generates blood from food',
   'a',
   'In TCM, the Shen (Heart-Mind) encompasses consciousness, thought, memory, and emotional experience - all housed in the heart. This bridges the modern finding that cardiovascular health and cognitive health are deeply intertwined.',
   'In TCM, the Shen (Heart-Mind) encompasses consciousness, thought, memory, and emotional experience - all housed in the heart.',
   'Heart-Mind (Shen) and Cognitive Health', 240),

  -- Q25 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Poria (fu ling) is described in the notes as a classic TCM herb for which two actions related to the Heart-Mind?',
   'Lifting the spirit and calming anxiety',
   'Supporting immune resilience and calming the nervous system',
   'Improving circulation to the brain and supporting cognitive clarity',
   'Calming the heart-mind and resolving phlegm',
   'd',
   'Poria (*Wolfiporia extensa*, fu ling) is specifically described as a classic TCM herb for calming the heart-mind and resolving phlegm - relevant to "Phlegm Invading the Mind" as both a Spleen and Heart disharmony in TCM.',
   'Poria (*Wolfiporia extensa*, fu ling) is a classic TCM herb for calming the heart-mind and resolving phlegm.',
   'Heart-Mind (Shen) and Cognitive Health', 250),

  -- Q26 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Stroke survivors with atrial fibrillation have what increased risk of dementia, according to the class notes?',
   '1.5 times more likely', '3.2 times more likely', '2.4 times more likely', '4.0 times more likely',
   'c',
   'The notes state that stroke survivors with atrial fibrillation are 2.4x more likely to develop dementia - illustrating that vascular health is brain health and cardiovascular disease and cognitive decline share common risk factors.',
   'Stroke survivors with atrial fibrillation are 2.4x more likely to develop dementia - vascular health is brain health.',
   'Heart-Mind (Shen) and Cognitive Health', 260),

  -- Q27 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which adaptogen is described as well-researched for cortisol modulation and thyroid support, both directly relevant to cardiovascular health?',
   'Ashwagandha', 'Schisandra', 'Siberian Ginseng', 'Tulsi',
   'a',
   'Ashwagandha (*Withania somnifera*) is specifically noted as well-researched for cortisol modulation and thyroid support, both directly relevant to cardiovascular health - linking it to the stress-cardiovascular connection discussed throughout the class.',
   'Ashwagandha (*Withania somnifera*) is well-researched for cortisol modulation and thyroid support - both directly relevant to cardiovascular health.',
   'Adaptogens for Stress and Heart Resilience', 270),

  -- Q28 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Asian Ginseng is described as best suited to which constitutional type, contrasted with American Ginseng?',
   'Hot, tense individuals with elevated BP',
   'Cold, depleted individuals needing warming and stimulation',
   'Anxious, restless individuals needing calming',
   'Damp, sluggish individuals with poor circulation',
   'b',
   'Asian ginseng (*Panax ginseng*) is warming and stimulating - best for cold, depleted individuals, contrasting with American ginseng which is cooler and more moistening. This energetic matching is key to adaptogen selection.',
   'Asian ginseng (*Panax ginseng*) is warming and stimulating - best for cold, depleted individuals; American ginseng (*Panax quinquefolius*) is cooler and more moistening.',
   'Adaptogens for Stress and Heart Resilience', 280),

  -- Q29 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Schisandra is described as a "true whole-body adaptogen." What makes it unique compared to other adaptogens in the notes?',
   'It is the strongest cortisol modulator available',
   'It is gentle enough for daily use as a tea without stimulating effects',
   'It supports liver, kidneys, heart, and nervous system simultaneously as a five-flavor berry',
   'It modulates the immune system and calms the nervous system',
   'c',
   'Schisandra (*Schisandra chinensis*) is specifically described as a true whole-body adaptogen because it supports liver, kidneys, heart, and nervous system simultaneously - as a five-flavor berry, its breadth is its defining characteristic.',
   'Schisandra (*Schisandra chinensis*) is a five-flavor berry that supports liver, kidneys, heart, and nervous system simultaneously - a true whole-body adaptogen.',
   'Adaptogens for Stress and Heart Resilience', 290),

  -- Q30 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Motherwort is specifically described in the Relaxant Nervines section as being specific for which particular presentation?',
   'Palpitations and anxiety with a heat component',
   'Deep exhaustion and burnout without emotional overlay',
   'Cold sluggish blood flow with cognitive dullness',
   'Grief and emotional depletion with pallor',
   'a',
   'Motherwort is specifically described as "specific for palpitations and anxiety with a heat component" in the Relaxant Nervines section - distinguishing it from herbs suited to Cold and Deficiency or Blood Deficiency patterns.',
   'Motherwort (*Leonurus cardiaca*) is specific for palpitations and anxiety with a heat component; a vasodilative relaxant nervine with a bitter cooling quality.',
   'Relaxant Nervines for Heat and Tension', 300),

  -- Q31 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Blue Vervain''s key clinical picture is described as which presentation?',
   'Pale, depleted, easily startled - not enough substance to feel grounded',
   'Cold, low energy, gloomy - the kind of tired that sits deep in the bones',
   'Palpitations and racing heart from nervous tension with heat',
   'The person who is wound tight, overworked, and held together by sheer willpower',
   'd',
   'Blue Vervain (*Verbena hastata*) is described as addressing the person who is wound tight, overworked, and held together by sheer willpower - classic Heat and Tension with nervous exhaustion underneath. Options A and B describe Blood Deficiency (Piglet) and Cold and Deficiency (Eeyore) respectively.',
   'Blue vervain (*Verbena hastata*) addresses the person who is wound tight, overworked, and held together by sheer willpower - classic Heat and Tension with nervous exhaustion underneath.',
   'Relaxant Nervines for Heat and Tension', 310),

  -- Q32 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Black Haw is described as relaxing what specifically in the cardiovascular context?',
   'Palpitations and anxiety with a heat component',
   'Vascular spasm and smooth muscle tension',
   'Tension from the chest while soothing grief',
   'Vascular tension while soothing the nervous system',
   'b',
   'Black Haw (*Viburnum prunifolium*) relaxes vascular spasm and smooth muscle tension - distinguishing it from Motherwort (option A: palpitations with heat/anxiety), Linden (option D: vascular tension with nervous system soothing), and Linden again in the emotional heart context (option C).',
   'Black Haw (*Viburnum prunifolium*) relaxes vascular spasm and smooth muscle tension; suited to the Heat and Tension pattern with cardiovascular constriction.',
   'Relaxant Nervines for Heat and Tension', 320),

  -- Q33 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Night-Blooming Cereus (*Selenicereus grandiflorus*) is described as a profound heart tonic with an affinity for which specific presentations?',
   'Palpitations and cardiac weakness',
   'Stagnation and varicose veins',
   'Blood Deficiency and pallor',
   'Heat and Tension with elevated BP',
   'a',
   'Night-Blooming Cereus is described as a profound heart tonic with an affinity for palpitations and cardiac weakness - placing it among the nourishing nervines for the depleted, dry, anxious person rather than the hot, tense one.',
   'Night blooming cactus (*Selenicereus grandiflorus*) is a profound heart tonic with an affinity for palpitations and cardiac weakness.',
   'Nourishing Nervines for Heart Blood Deficiency', 330),

  -- Q34 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Hawthorn is described in the Nourishing Nervines section as "bridging nourishing and tonic actions - appropriate across most patterns." What does this imply for clinical use?',
   'It should only be used in advanced cases after simpler herbs have failed',
   'It is too non-specific to be a primary herb for any pattern',
   'It works best combined with adaptogenic mushrooms for maximum effect',
   'It can be included in heart formulas for Heat and Tension, Cold and Deficiency, or Blood Deficiency patterns',
   'd',
   'Hawthorn bridging nourishing and tonic actions appropriate across most patterns means it is a broadly applicable herb that can be included in heart formulas for any of the cardiovascular energetic patterns - making it one of the most versatile cardiovascular herbs.',
   'Hawthorn (*Crataegus spp.*) bridges nourishing and tonic actions - appropriate across most cardiovascular patterns including Heart Blood Deficiency.',
   'Nourishing Nervines for Heart Blood Deficiency', 340),

  -- Q35 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'What was Frank''s initial A1C, and what did it drop to after herbal and lifestyle interventions?',
   'From 8.5 to 7.1', 'From 7.1 to 6.3', 'From 6.3 to 5.9', 'From 9.2 to 7.6',
   'b',
   'Frank''s Hemoglobin A1C dropped from 7.1 to 6.3 after treatment - a clinically significant improvement in glycemic control that accompanied his broader cardiometabolic improvements.',
   'Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; HDL/TC ratio dropped from 6.3 to 5.3; blood pressure stabilized.',
   'Frank''s Cardiovascular Protocol', 350),

  -- Q36 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Frank''s total cholesterol improved by how much, according to the case study?',
   '50 points', '75 points', '125 points', '100 points',
   'd',
   'Frank''s total cholesterol dropped by 100 points - noted as one of the most striking objective outcomes, with his doctor described as "shocked at the numbers."',
   'Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; HDL/TC ratio dropped from 6.3 to 5.3; blood pressure stabilized.',
   'Frank''s Cardiovascular Protocol', 360),

  -- Q37 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Which herb in Frank''s protocol was included specifically for liver support, given that Frank presented with fatty liver and cirrhosis?',
   'Milk Thistle', 'Guggul', 'Mistletoe', 'Artichoke Leaf',
   'a',
   'Milk Thistle was specifically noted as being included in Frank''s protocol for liver support, with the outcome that liver enzymes were all in healthy range after treatment. Artichoke Leaf also appeared in the protocol but in a broader cardiovascular context.',
   'Milk Thistle (*Silybum marianum*) was included in Frank''s herbal protocol specifically for liver support; Frank presented with fatty liver and cirrhosis alongside his cardiometabolic conditions.',
   'Frank''s Cardiovascular Protocol', 370),

  -- Q38 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Rauwolfia is noted as not appropriate for general herbal practice for which two reasons?',
   'It raises blood pressure and depletes potassium',
   'It has a narrow therapeutic index and significant interactions with warfarin',
   'It is the original source of the potent BP drug reserpine and can also cause depression as a side effect',
   'It contains cardiac glycosides like digoxin and can cause arrhythmia',
   'c',
   'Rauwolfia (*Rauvolfia serpentina*) is the original source of reserpine (a potent blood pressure medication) and can also bring on depression as a side effect - two reasons it is not appropriate for general herbal practice, though it was used cautiously in Frank''s polypharmacy case.',
   'Rauwolfia (*Rauvolfia serpentina*) is the original source of reserpine, a potent blood pressure medication. Can also bring on depression as a side effect - not appropriate for general practice.',
   'Frank''s Cardiovascular Protocol', 380),

  -- Q39 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The three herbs in Frank''s blood sugar support protocol each work through a different mechanism. Which three herbs are they?',
   'Fenugreek, Oregon Grape, and Goldenseal',
   'Cinnamon, Bitter Melon, and Gymnema',
   'Berberine, Turmeric, and Artichoke',
   'Cinnamon, Fenugreek, and Oregon Grape',
   'b',
   'The notes specifically name Cinnamon, Bitter Melon, and Gymnema as Frank''s blood sugar support herbs, each working through a different mechanism to improve insulin sensitivity and glucose metabolism for his unregulated T2D.',
   'Herbal remedies to support blood sugar regulation and metabolic health: Cinnamon, Bitter Melon, and Gymnema. These herbs address his unregulated T2D from multiple angles - each works through a different mechanism to improve insulin sensitivity and glucose metabolism.',
   'Frank''s Blood Sugar Support', 390),

  -- Q40 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The class notes describe what approach to introducing herbs in a polypharmacy case like Frank''s?',
   'Starting with the most potent herbs to get rapid results before testing for interactions',
   'Using only food-grade herbs with no pharmacological activity until cleared by the prescriber',
   'Waiting until the client stabilizes medically before introducing any herbs',
   'Starting low and slow while monitoring for interactions, especially with dose-sensitive medications',
   'd',
   'The notes emphasize that herbal remedies were introduced slowly and at low dose to avoid herb-drug interactions - critical with Frank''s medication list including Metformin, Metoprolol, Valsartan, and Synthroid. Starting low and slow while monitoring for interactions is essential in polypharmacy cases.',
   'Herbal remedies introduced slowly and at low dose to avoid herb-drug interactions - critical with Frank''s medication list (Metformin, Metoprolol, Valsartan, Synthroid).',
   'Frank''s Cardiovascular Protocol', 400),

  -- Q41 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Fish oils (Omega-3s) were included in Frank''s protocol. How much was used daily?',
   '4g/day', '1g/day', '2g/day', '6g/day',
   'a',
   'Fish oil (Omega-3s) was included at 4g/day in Frank''s protocol for cardiovascular and lipid support - a clinically meaningful dose for cardiovascular outcomes.',
   'Fish Oils (Omega-3s) at 4g/day were included in Frank''s protocol for cardiovascular and lipid support.',
   'Frank''s Cardiovascular Protocol', 410),

  -- Q42 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The class notes frame the relationship between depression and heart disease as causal in which direction?',
   'Only unidirectional: heart disease causes depression through physiological stress',
   'Only unidirectional: depression causes heart disease through stress pathways',
   'Bidirectional: depression causes heart disease AND heart disease causes depression',
   'Correlational only: they share common risk factors but neither causes the other',
   'c',
   'The notes explicitly state this is causation, not just correlation, and that the relationship is bidirectional: depression causes heart disease, and heart disease causes depression - with depression/stress increasing heart disease risk 2-5x and up to 40% of cardiac patients being clinically depressed.',
   'The relationship between mental/emotional health and cardiovascular health is bidirectional - each influences the other. This is causation, not just correlation: depression causes heart disease, and heart disease causes depression.',
   'Heart-Mind (Shen) and Cognitive Health', 420),

  -- Q43 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The Nurses Health Study finding about sleep and cardiovascular risk states that women sleeping 5 hours or less per night had what increased risk of CVD compared to women sleeping 8 hours?',
   '25% increased risk', '35% increased risk', '55% increased risk', '45% increased risk',
   'd',
   'The Nurses Health Study found that women sleeping 5 hours or less per night had a 45% increased risk of CVD over women sleeping 8 hours - evidence that sleep is not a luxury but a cardiovascular necessity.',
   'The Nurses Health Study found that women sleeping 5 hours or less per night had a 45% increased risk of CVD over women sleeping 8 hours.',
   'Heart-Mind (Shen) and Cognitive Health', 430),

  -- Q44 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Job stress is described in the notes as increasing heart attack risk by approximately how much, and how does this compare to other known risk factors?',
   '1.5x; similar to occasional alcohol use',
   '2x; equal to daily smoking and obesity',
   '3x; greater than hypertension alone',
   '4x; greater than any other modifiable risk factor',
   'b',
   'The notes state that job stress increases risk of a heart attack 2x, equal to daily smoking and obesity - making occupational stress a major, underaddressed cardiovascular risk factor often overlooked in clinical settings.',
   'Job stress increases risk of a heart attack 2x, equal to daily smoking and obesity.',
   'Heart-Mind (Shen) and Cognitive Health', 440),

  -- Q45 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'In TCM, what does the Spleen do, and what happens when Spleen Qi is deficient in relation to the Heart?',
   'The Spleen generates the blood that the Heart circulates; Spleen Qi deficiency leads to Heart Blood deficiency',
   'The Spleen houses the Shen; when deficient, restlessness and anxiety increase',
   'The Spleen governs water metabolism; when deficient, edema and fluid retention burden the Heart',
   'The Spleen transforms phlegm; when deficient, Heart fire blazes unchecked',
   'a',
   'In TCM, the Spleen (digestive function) generates the blood that the Heart then circulates; Spleen Qi deficiency leads to Heart Blood deficiency - which is why supporting digestion through bitters, tonics, and regular eating habits is a foundational heart support strategy.',
   'In TCM, the Spleen (digestive function) generates the blood that the Heart then circulates; Spleen Qi deficiency leads to Heart Blood deficiency.',
   'Digestive Support for Heart Health', 450),

  -- Q46 correct=d
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The class notes describe the difference between "relaxant" nervines and "nourishing" nervines for the heart. Which constitutional type calls for the nourishing nervines?',
   'The hot, tense person with elevated BP and irritability',
   'The person who is wound tight and held together by willpower',
   'The cold, sluggish person with low vitality',
   'The depleted, dry, anxious person rather than the hot, tense one',
   'd',
   'The notes describe the nourishing nervines (Night-Blooming Cereus, Linden, Oats, Hawthorn) as being for the depleted, dry, anxious person - the opposite pole from the clearing/relaxing herbs suited to the hot, tense person. This is the Blood Deficiency and Heart Yin deficiency pattern.',
   'These are the building, nourishing nervines for Heart Blood and Yin deficiency - the opposite pole from the clearing/relaxing herbs; for the depleted, dry, anxious person rather than the hot, tense one.',
   'Nourishing Nervines for Heart Blood Deficiency', 460),

  -- Q47 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The liver''s role in cardiovascular health is described through four specific functions. Which function is NOT listed in the notes?',
   'Regulates cholesterol production',
   'Processes hormones',
   'Directly controls heart rate and blood pressure',
   'Stores iron and B vitamins for healthy blood formation',
   'c',
   'The notes list the liver as filtering blood, regulating cholesterol production, processing hormones, and storing iron and B vitamins for healthy blood formation. Directly controlling heart rate and blood pressure is a function of the nervous system and kidneys, not the liver.',
   'The liver plays a surprisingly large role in cardiovascular health: filters blood, regulates cholesterol production, processes hormones, stores iron and B vitamins for healthy blood formation.',
   'Liver Support for Cardiovascular Health', 470),

  -- Q48 correct=a
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'Oats (milky oats, *Avena sativa*) is included among the nourishing nervines for the heart. What is its primary role in this context?',
   'Deeply nourishing the nervous system when depleted',
   'Stimulating blood flow and warming cold circulation',
   'Calming a racing heart linked to anxiety and heat',
   'Moving stagnant blood and supporting liver function',
   'a',
   'Oats (*Avena sativa*) deeply nourishes the nervous system when depleted - making it suited to Heart Blood Deficiency pattern where depletion of the nervous system accompanies cardiovascular insufficiency.',
   'Oats (*Avena sativa*) deeply nourishes the nervous system when depleted; a sweet nourishing nervine for Heart Blood Deficiency pattern.',
   'Nourishing Nervines for Heart Blood Deficiency', 480),

  -- Q49 correct=b
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The class notes describe calf muscles as the "second heart." What do they mean by this?',
   'The calf muscles can maintain blood flow during cardiac arrest',
   'When calf muscles contract, they pump blood back up toward the heart against gravity',
   'The calf muscles store reserve blood during periods of physical exertion',
   'The calf muscles contain secondary circulation pathways that bypass the heart',
   'b',
   'The calf muscles are described as the "second heart" because when they contract, they pump blood back up toward the heart against gravity. Prolonged sitting or standing without movement allows blood to pool in the legs, increasing cardiac workload and contributing to varicose veins.',
   'The calf muscles act as a "second heart" - when they contract, they pump blood back up toward the heart against gravity.',
   'Heart-Mind (Shen) and Cognitive Health', 490),

  -- Q50 correct=c
  ('Herbal Heart Health - Week 1 - Reading the Hearts Whole Story',
   'The systems herbalist''s core philosophy for cardiovascular health is described as what approach at the end of the module?',
   'Treating the cardiovascular system directly with specific cardiac herbs before addressing lifestyle factors',
   'Following established herbal protocols based on the patient''s diagnosis rather than their individual constitution',
   'An honest look at the whole landscape the heart is responding to, with support offered wherever the body is actually asking for it',
   'Using laboratory values as the primary guide for herb selection and dosing',
   'c',
   'The systems herbalist''s core philosophy is described as "an honest look at the whole landscape the heart is responding to, and support offered wherever the body is actually asking for it" - meeting the body where it is, not where the textbook says it should be.',
   'The goal is "an honest look at the whole landscape the heart is responding to, and support offered wherever the body is actually asking for it." This is the systems herbalist''s core philosophy: meet the body where it is, not where the textbook says it should be.',
   'Heart-Mind (Shen) and Cognitive Health', 500);

END $$;
