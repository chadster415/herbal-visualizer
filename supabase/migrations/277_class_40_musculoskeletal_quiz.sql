-- Migration 277: BHC Class 40 — Musculoskeletal I and II — quiz questions (30 MCQ)

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = 'BHC - Class 40 - Musculoskeletal I and II') THEN
    RAISE NOTICE 'Class 40 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d, correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Which herb is described as "THE rheumatoid arthritis remedy" and specific for dull, aching, muscular pain and acute inflammatory rheumatic pains?',
   'Jamaican Dogwood', 'Solomon''s Seal', 'Black Cohosh', 'Kava',
   'c',
   'Black Cohosh is explicitly called "THE rheumatoid arthritis remedy" in these notes for its specificity for dull, aching, muscular pain and acute inflammatory rheumatic pains.',
   'Black Cohosh — specific for dull, aching, muscular pain and acute inflammatory rheumatic pains; THE rheumatoid arthritis remedy',
   'Black Cohosh', 10),

  -- Q2
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Matt Wood called which herb "indispensable musculoskeletal remedy" for its action on collagen, cartilage, tendons, and ligaments?',
   'Gotu Kola', 'Solomon''s Seal', 'Jamaican Dogwood', 'St. John''s Wort',
   'b',
   'The notes quote Matt Wood calling Solomon''s Seal "indispensable musculoskeletal remedy" — it specifically acts on collagen and cartilage and is nutritive to tendons and ligaments.',
   'Solomon''s Seal — tincture and decoction, no oil; specifically acts on collagen and cartilage; nutritive to tendons and ligaments; Matt Wood: "indispensable musculoskeletal remedy"',
   'Solomon''s Seal', 20),

  -- Q3
  ('BHC - Class 40 - Musculoskeletal I and II',
   'According to the class notes, for which condition is St. John''s Wort (SJW) particularly indicated as a neuroprotective herb?',
   'Rheumatoid arthritis', 'Sciatica', 'Osteoporosis', 'Bone spurs',
   'b',
   'The notes state SJW is "mostly a neuroprotective plant — nerve endings" and "use a lot for sciatica," making sciatica its primary nerve indication in these notes.',
   'SJW — mostly a neuroprotective plant — nerve endings; use a lot for sciatica; generally anti-inflammatory; inhibit prostaglandin',
   'St. John''s Wort', 30),

  -- Q4
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Which herb is described as the primary herb for scleroderma, lupus, myasthenia gravis, and MS, and is also a connective tissue tonic?',
   'Solomon''s Seal', 'Black Cohosh', 'Gotu Kola', 'Hibiscus',
   'c',
   'Gotu Kola is described as a "connective tissue tonic" and "primary herb in: scleroderma, lupus, myasthenia gravis, MS, general neuromuscular and muscular wasting conditions."',
   'Gotu Kola — cerebral circulation tonic; connective tissue tonic; primary herb in: scleroderma, lupus, myasthenia gravis, MS, general neuromuscular and muscular wasting conditions',
   'Gotu Kola', 40),

  -- Q5
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Steven Buehner''s long covid protocol includes all of the following EXCEPT:',
   'Baical Skullcap', 'Reishi', 'Solomon''s Seal', 'Licorice',
   'c',
   'Buehner''s protocol listed: Baical Skullcap, Salvia rhiz/Reg Sage, Reishi, Licorice, Red root, and Japanese Knotweed. Solomon''s Seal is a musculoskeletal herb not part of this protocol.',
   'Steven Buehner''s protocol for long covid: Baical Skullcap, Salvia rhiz / Reg Sage, Reishi, Licorice, Red root, Japanese Knotweed',
   'Chronic Pain', 50),

  -- Q6
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Hibiscus sabdariffa''s anthocyanins are specifically noted to do which of the following in the musculoskeletal system?',
   'Lubricate synovial joints', 'Stimulate myogenesis and protect mitochondria', 'Mineralize bone', 'Relax smooth muscle',
   'b',
   'The notes state Hibiscus anthocyanins "stimulate myogenesis, protect mitochondria, stimulate muscle protein synthesis, protect against muscle degradation."',
   'musculoskeletal: anthocyanins stimulate myogenesis, protect mitochondria, stimulate muscle protein synthesis, protect against muscle degradation',
   'Hibiscus', 60),

  -- Q7
  ('BHC - Class 40 - Musculoskeletal I and II',
   'According to the notes, Jamaican Dogwood "pairs well with AI to reduce sensation of pain" — which two herbs are specifically mentioned as the AI pairing options?',
   'Turmeric or Ginger', 'Meadowsweet or Willow', 'Echinacea or Milk Thistle', 'Hops or Skullcap',
   'b',
   'The notes state Jamaican Dogwood "pairs well with AI, to reduce sensation of pain, like willow or meadowsweet."',
   'pairs well with AI, to reduce sensation of pain, like willow or meadowsweet',
   'Jamaican Dogwood', 70),

  -- Q8
  ('BHC - Class 40 - Musculoskeletal I and II',
   'For rheumatoid arthritis, the main strategic principle Lisa emphasizes is:',
   'Anti-inflammatory action and nerve support', 'Immune modulation and waste elimination', 'Hormonal balancing and liver support', 'Bone mineralization and circulation',
   'b',
   'The notes explicitly state: "main point with rheumatoid arthritis → immune modulation and waste elimination."',
   'Main point with rheumatoid arthritis → immune modulation and waste elimination',
   'Rheumatoid Arthritis', 80),

  -- Q9
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Which herb is described as one of the very few skeletal muscle relaxants that "rivals Pedicularis"?',
   'Valerian', 'Hops', 'Kava', 'Jamaican Dogwood',
   'c',
   'Kava is described as "one of the very few skeletal muscle relaxants that rivals Pedicularis (only in the wild, parasitic plant)."',
   'Kava — one of the very few skeletal muscle relaxants that rivals Pedicularis (only in the wild, parasitic plant); nervine that helps with sleep; antispasmodic — muscle cramps',
   'Kava', 90),

  -- Q10
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Solomon''s Seal is specifically noted for which preparation method (and which to avoid)?',
   'Oil preferred; avoid decoction', 'Tincture and decoction; avoid oil', 'Tea only; avoid tincture', 'All preparations equally effective',
   'b',
   'The notes state "tincture and decoction, no oil" for Solomon''s Seal.',
   'Solomon''s Seal — tincture and decoction, no oil; specifically acts on collagen and cartilage',
   'Solomon''s Seal', 100),

  -- Q11
  ('BHC - Class 40 - Musculoskeletal I and II',
   'For White Willow''s anti-inflammatory action in arthritis, which preparation is described as most effective and why?',
   'Tincture, because alcohol extracts salicin more efficiently', 'Decoction, because salicylic acid is hydrophilic', 'Oil infusion, because salicylates absorb transdermally', 'Glycerite, because it is gentler on the stomach',
   'b',
   'The notes state White Willow is "most effective as a decoction for the hydrophilic salicylic acid" and "decoction + baking soda = buffered acid."',
   'AI for arthritis — mostly effective as a decoction for the hydrophilic salicylic acid; decoction + baking soda = buffered acid; astringent as tincture, but analgesic as a decoction',
   'White Willow', 110),

  -- Q12
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Hibiscus sabdariffa supports hyaluronan production in the extracellular matrix by doing what?',
   'Stimulating collagen fibroblasts directly', 'Preventing the expansion of hyaluronidase, which degrades cell membranes', 'Providing silica to rebuild cartilage', 'Activating vitamin D receptors in synovial tissue',
   'b',
   'The notes state Hibiscus is "supportive of hyaluronan production in the EM — helps to prevent the expansion of hyaluronidase, which degrades cell membranes."',
   'supportive of hyaluronan production in the extracellular matrix — helps to prevent expansion of hyaluronidase, which degrades cell membranes',
   'Hibiscus', 120),

  -- Q13
  ('BHC - Class 40 - Musculoskeletal I and II',
   'When Valerian causes heart palpitations in dry people, which herb is recommended to pair with it to ease that possibility?',
   'Skullcap', 'Passionflower', 'California Poppy', 'Milky Oats',
   'c',
   'The notes state Valerian "can cause heart palpitations in some (dry people) — can pair with California Poppy to ease that possibility."',
   'can cause heart palpitations in some (dry people) — can pair with California Poppy to ease that possibility',
   'Valerian', 130),

  -- Q14
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Black Cohosh is described as a serotonin agonist. According to these notes, serotonin is responsible for which two hormones?',
   'Cortisol and aldosterone', 'Melatonin and estrogen', 'Testosterone and DHEA', 'Progesterone and oxytocin',
   'b',
   'The notes state Black Cohosh is a "serotonin agonist — serotonin responsible for melatonin and estrogen."',
   'serotonin agonist — serotonin responsible for melatonin and estrogen',
   'Black Cohosh', 140),

  -- Q15
  ('BHC - Class 40 - Musculoskeletal I and II',
   'For circulatory support in rheumatoid arthritis, Lisa emphasizes promoting which type of circulation (not blood)?',
   'Arterial circulation', 'Venous return', 'Lymph circulation', 'Cerebral circulation',
   'c',
   'The notes specify: "Circulatory — promote lymph circulation, not blood" for RA, listing Cleavers, Red Root, and Poke (low dose).',
   'Circulatory — promote lymph circulation, not blood: cleavers, red root, poke (low dose)',
   'Rheumatoid Arthritis', 150),

  -- Q16
  ('BHC - Class 40 - Musculoskeletal I and II',
   'According to the notes, lemon balm is calcium-rich and what preparation method is preferred for this use?',
   'Tincture', 'Tea (infusion)', 'Glycerite', 'Decoction',
   'b',
   'The notes state "lemon balm = calcium rich = tea better than tincture" indicating tea (infusion) is the preferred preparation to access its mineral content.',
   'lemon balm = calcium rich = tea better than tincture',
   'Calcium Metabolism', 160),

  -- Q17
  ('BHC - Class 40 - Musculoskeletal I and II',
   'In long covid, what mechanism is described as causing the "achy body" sensation according to Steven Buehner''s model?',
   'Calcium depletion in muscle tissue', 'Cilia desiccation, mast cell lockdown, and amyloid plaque entering the bloodstream', 'Synovial fluid depletion and joint grinding', 'Prostaglandin cascade causing systemic inflammation',
   'b',
   'The notes describe: "cilia desiccates in long covid — tissues get overwhelmed; cilia isn''t removing stuff; mast cells lock down and don''t respond effectively; amyloid plaque filters into the bloodstream — = achy body."',
   'cilia desiccates in long covid — tissues get overwhelmed; cilia isn''t removing stuff; mast cells lock down (overwhelm) and don''t respond effectively; amyloid plaque filters into the bloodstream — = achy body',
   'Chronic Pain', 170),

  -- Q18
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Solomon''s Seal is described as supportive for which specific structural abnormality that forms when calcium builds up on bone or joints?',
   'Bone spurs', 'Rheumatoid nodules', 'Synovial cysts', 'Periosteal tears',
   'a',
   'The notes state Solomon''s Seal is "supportive for bone spurs" and helpful for "calcifications — build up of calcium on bone/joints."',
   'supportive for bone spurs; calcifications — build up of calcium on bone/joints',
   'Solomon''s Seal', 180),

  -- Q19
  ('BHC - Class 40 - Musculoskeletal I and II',
   'For Jamaican Dogwood, which painful condition related to amputation is it specifically indicated for?',
   'Phantom pains', 'Stump infections', 'Prosthetic skin irritation', 'Bone resorption pain',
   'a',
   'The notes state Jamaican Dogwood is specific for "phantom pains (amputations)" as one of its clinical indications.',
   'Jamaican Dogwood — generally specific for smooth muscle pain; phantom pains (amputations); insomnia with spasms; nervous irritability',
   'Jamaican Dogwood', 190),

  -- Q20
  ('BHC - Class 40 - Musculoskeletal I and II',
   'SJW at therapeutic doses has significant drug interactions with many medications. Which of the following is NOT listed as a drug category with interactions?',
   'Anticoagulants', 'Benzodiazepines', 'Antibiotics', 'Steroid contraceptives',
   'c',
   'The notes list drug interactions with: steroid contraceptives, cardiac drugs, anticancer drugs, immunosuppressives, anti-hypertensives, benzodiazepines, HIV, anticoagulants, SSRI, and 1 antifungal. Antibiotics are not listed.',
   'lots of drug interactions at therapeutic doses: steroid contraceptives, cardiac drugs, some anticancer drugs, some immunosuppressives, some anti-hypertensives, benzodiazepines, HIV, anticoagulants, SSRI, 1 antifungal',
   'St. John''s Wort', 200),

  -- Q21
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Which of the following is the correct hepatic herb grouping mentioned for rheumatoid arthritis support?',
   'Burdock, Cleavers, Nettle', 'Yellow Dock, Licorice, Oregon Grape Root, Milk Thistle', 'Dandelion root, Gentian, Fennel', 'Echinacea, Reishi, Astragalus',
   'b',
   'The notes list "Hepatic: yellow dock, licorice, OGR (Oregon Grape Root), milk thistle" for RA support.',
   'Hepatic: yellow dock, licorice, OGR, milk thistle',
   'Rheumatoid Arthritis', 210),

  -- Q22
  ('BHC - Class 40 - Musculoskeletal I and II',
   'For rheumatoid arthritis, diuretics are used to drain what specifically?',
   'Lymph nodes', 'Synovial fluid', 'Interstitial edema', 'Pleural fluid',
   'b',
   'The notes state diuretics are used to "drain synovial fluid" in rheumatoid arthritis, listing dandelion leaf and nettle.',
   'Diuretics — drain synovial fluid: dandelion leaf, nettle',
   'Rheumatoid Arthritis', 220),

  -- Q23
  ('BHC - Class 40 - Musculoskeletal I and II',
   'California Poppy is described as specifically targeting which type(s) of muscle?',
   'Cardiac muscle only', 'Smooth and skeletal muscles', 'Smooth muscle only', 'Skeletal muscle only',
   'b',
   'The notes state California Poppy is "specifically for smooth and skeletal muscles" for low grade chronic pain, menstrual cramps, and muscle cramps and spasms.',
   'California Poppy — specifically for smooth and skeletal muscles; low grade chronic pain; menstrual cramps; muscle cramps & spasms',
   'California Poppy', 230),

  -- Q24
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Hibiscus sabdariffa is indicated for metabolic disorders involving tissue degradation and poor circulation in the lower extremities, and is noted as transitioning which hormonal condition?',
   'Hypothyroidism → hyperthyroidism', 'PCOS → PMOS', 'Perimenopause → menopause', 'Andropause → testosterone support',
   'b',
   'The notes state Hibiscus is "excellent for metabolic disorders in general — where tissues are starting to degrade, loss of circulation in lower extremities — PCOS → PMOS."',
   'excellent for metabolic disorders in general — where tissues are starting to degrade, loss of circulation in lower extremities — PCOS → PMOS',
   'Hibiscus', 240),

  -- Q25
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Valerian is noted to have a "huge difference" depending on what preparation variable?',
   'Whether it is taken with food', 'Whether the tincture is fresh or dried', 'Whether it is combined with Hops', 'Whether it is a high or low dose',
   'b',
   'The notes state there is a "huge difference between fresh and dried tincture" for Valerian.',
   'Valerian — huge difference between fresh and dried tincture; mild pain reliever; relieves body of tension',
   'Valerian', 250),

  -- Q26
  ('BHC - Class 40 - Musculoskeletal I and II',
   'SJW''s ability to decrease amyloid reactive oxygen species is connected in these notes to which neurological condition?',
   'Parkinson''s disease', 'Multiple sclerosis', 'Alzheimer''s disease', 'Myasthenia gravis',
   'c',
   'The notes state SJW "decrease amyloid reactive oxygen species — connected to Alzheimer''s."',
   'decrease amyloid reactive oxygen species — connected to Alzheimer''s',
   'St. John''s Wort', 260),

  -- Q27
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Black Cohosh is associated with a specific psychological pattern when used for pain. What is that pattern?',
   'Euphoria and overconfidence', 'Intrusive negative thoughts in association with pain', 'Dissociation from physical sensation', 'Emotional flatness and anhedonia',
   'b',
   'The notes state Black Cohosh is "associated with people with intrusive negative thoughts, in association with pain."',
   'associated with people with intrusive negative thoughts, in association with pain',
   'Black Cohosh', 270),

  -- Q28
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Regarding the antioxidant role in rheumatoid arthritis, the notes describe the waste as being what type, requiring the blood to be "buffered"?',
   'Acidic waste requiring alkalizing', 'Oxidative waste requiring antioxidant buffering', 'Mucilaginous waste requiring diuretics', 'Toxic alkaloids requiring liver support',
   'b',
   'The notes state "AO (antioxidant) — the waste is oxidative — buffer the blood from it" with cranberry, rose hips, goji berries, and citrus listed.',
   'AO (antioxidant) — the waste is oxidative — buffer the blood from it: cranberry, rose hips, goji berries, citrus',
   'Rheumatoid Arthritis', 280),

  -- Q29
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Gotu Kola is noted as a pillar in formulas for what reproductive/structural issue?',
   'Fibroids and heavy bleeding', 'Dysfunctional extracellular matrix', 'Ovarian cysts and endometriosis', 'Cervical dysplasia',
   'b',
   'The notes state Gotu Kola is a "pillar of formula in repro realm: dysfunctional extracellular matrix."',
   'pillar of formula in repro realm: dysfunctional extracellular matrix',
   'Gotu Kola', 290),

  -- Q30
  ('BHC - Class 40 - Musculoskeletal I and II',
   'Solomon''s Seal is specifically indicated for arthritis of what etiology?',
   'Autoimmune rheumatoid arthritis', 'Arthritis associated with old injuries', 'Gouty arthritis from uric acid', 'Infectious septic arthritis',
   'b',
   'The notes state Solomon''s Seal is for "arthritis associated with old injuries" as a specific indication, distinct from rheumatoid or gouty arthritis.',
   'Solomon''s Seal — arthritis associated with old injuries; calcifications — build up of calcium on bone/joints',
   'Solomon''s Seal', 300);

END $$;
