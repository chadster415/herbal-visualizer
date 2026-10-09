-- Migration 360: Class 72 – Stroke (quiz questions)
-- Target: 50 questions
-- H=16 herbs/supplements, F=4 named facts → clamp(15 + 16×4 + 4×1, 20, 50) = clamp(83, 20, 50) = 50

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 72 - Stroke') THEN
    RAISE NOTICE 'Class 72 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (sort 10) — Bacopa: memory and cognitive support [correct: a]
  ('BHC - Class 72 - Stroke',
   'Which herb is described in these notes as supporting memory and cognitive function for stroke recovery?',
   'Bacopa', 'Ginkgo', 'Rosemary', 'Valerian',
   'a',
   'The notes specifically name Bacopa for supporting memory and cognitive function in the stroke recovery herbal support section.',
   '**Bacopa**: supports memory, cognitive function',
   'Stroke Recovery - Herbal Support', 10),

  -- Q2 (sort 20) — Ginkgo: circulation and cognition [correct: b]
  ('BHC - Class 72 - Stroke',
   'According to the class notes, what two benefits does Ginkgo biloba offer in stroke recovery?',
   'Anti-inflammatory and antioxidant', 'Circulation and cognition', 'Sleep support and muscle relaxation', 'Kidney support and diuresis',
   'b',
   'The notes record Ginkgo biloba as supporting circulation and cognition, making it relevant for post-stroke cognitive and vascular concerns.',
   'Ginkgo biloba - circulation and cognition',
   'Stroke Recovery - Herbal Support', 20),

  -- Q3 (sort 30) — Rosemary: contraindicated due to anticoagulant properties [correct: d]
  ('BHC - Class 72 - Stroke',
   'Why is Rosemary described as "not recommended" for a stroke recovery patient on anticoagulant medication?',
   'It raises blood pressure significantly', 'It interferes with kidney function', 'It causes excessive sedation', 'It has anticoagulant properties that compound bleeding risk',
   'd',
   'The notes state Rosemary is not recommended due to its own anticoagulant properties, which would compound the risk for a patient already on anticoagulant medications like Eliquis.',
   '**Rosemary**: not recommended due to anticoagulant properties',
   'Stroke Recovery - Herbal Support', 30),

  -- Q4 (sort 40) — Bleeding risk trio: ginkgo bolded [correct: b]
  ('BHC - Class 72 - Stroke',
   'Which three herbs or supplements are specifically flagged to avoid with anticoagulants like warfarin due to increased bleeding risk?',
   'Bacopa, Valerian, and Hops', 'Ginkgo, Garlic, and Ginger', 'Turmeric, Linden, and Nettle', 'Rosemary, Cleavers, and Oat Straw',
   'b',
   'The notes explicitly state: avoid ginkgo, garlic, and ginger with anticoagulants like warfarin because they increase bleeding risk.',
   'Anticoagulants like warfarin — avoid **ginkgo**, garlic, ginger — increase bleeding risk',
   'Herb-Drug Interactions', 40),

  -- Q5 (sort 50) — Garlic timing rule [correct: c]
  ('BHC - Class 72 - Stroke',
   'The notes specify a waiting period before using garlic after taking blood-thinning medications. How long is that wait?',
   '1 or more hours', '2 or more hours', '3 or more hours', '4 or more hours',
   'c',
   'The notes state to wait 3 or more hours after medications before using garlic (raw, supplement, or tea) to reduce the compounded bleeding risk with blood thinners.',
   'Care: garlic (raw, supplement or tea) can increase bleeding risk — do not combine with blood thinners. Wait 3 or more hours after meds before using.',
   'Stroke Recovery - Herbal Support', 50),

  -- Q6 (sort 60) — Ginger: timing rule [correct: a]
  ('BHC - Class 72 - Stroke',
   'According to the class notes, ginger in any form (raw, supplement, or tea) can increase bleeding risk. What precaution is recommended when a patient is on blood thinners?',
   'Wait 3 or more hours after meds before using ginger', 'Take ginger only with food', 'Avoid ginger entirely at all times', 'Limit ginger to one cup of tea per week',
   'a',
   'The notes specify not combining ginger with blood thinners and waiting 3 or more hours after medications before using ginger in any form.',
   'Care: ginger (raw, supplement, or tea) can increase bleeding risk — do not combine with blood thinners. Wait 3 or more hours after meds before using.',
   'Stroke Recovery - Herbal Support', 60),

  -- Q7 (sort 70) — St. John's Wort: drug interactions [correct: d]
  ('BHC - Class 72 - Stroke',
   'St. John''s Wort is flagged in these notes as a concern for a stroke patient on multiple medications. What is the primary reason?',
   'It elevates blood pressure dangerously', 'It causes excessive bleeding', 'It suppresses kidney function', 'It has broad herb-drug interactions with many medications',
   'd',
   'The notes state to avoid St. John''s Wort alongside certain meds due to herb-drug interactions, and the case study reinforces: do not take SJW with medications due to drug interactions.',
   'Avoid alongside **St. John''s Wort** with certain meds due to herb-drug interactions',
   'Herb-Drug Interactions', 70),

  -- Q8 (sort 80) — Linden: excessive BP lowering [correct: b]
  ('BHC - Class 72 - Stroke',
   'Why is Linden specifically cautioned for the stroke recovery case study patient?',
   'It increases bleeding risk with anticoagulants', 'It could lower blood pressure too much given multiple BP medications', 'It worsens kidney disease', 'It interferes with sleep patterns',
   'b',
   'The notes caution that Linden could lower BP too much for a patient already on multiple blood pressure medications (Losartan, Hydralazine, Lasix).',
   'Caution: Linden could lower BP too much (patient on multiple blood pressure medications: Losartan, Hydralazine, Lasix)',
   'Case Study', 80),

  -- Q9 (sort 90) — Blood pressure herbs group: Nettle bolded [correct: a]
  ('BHC - Class 72 - Stroke',
   'The class notes group four herbs together as requiring caution due to blood pressure effects. Which of the following is part of that group?',
   'Nettle', 'Turmeric', 'Bacopa', 'Valerian',
   'a',
   'The notes list linden, nettle, cleavers, and oat straw as a group requiring caution for their blood pressure effects.',
   'Caution with herbs for blood pressure like linden, **nettle**, cleavers, oat straw',
   'Herb-Drug Interactions', 90),

  -- Q10 (sort 100) — Blood pressure herbs group: Cleavers bolded [correct: d]
  ('BHC - Class 72 - Stroke',
   'Cleavers is listed in the notes among herbs requiring blood pressure caution. Which of the following correctly names the full group?',
   'Linden, Valerian, Cleavers, Hops', 'Bacopa, Nettle, Cleavers, Rosemary', 'Ginkgo, Nettle, Cleavers, Hibiscus', 'Linden, Nettle, Cleavers, Oat Straw',
   'd',
   'The notes list linden, nettle, cleavers, and oat straw together as herbs requiring caution for their blood pressure effects in patients on multiple BP medications.',
   'Caution with herbs for blood pressure like linden, nettle, **cleavers**, oat straw',
   'Herb-Drug Interactions', 100),

  -- Q11 (sort 110) — Blood pressure herbs group: Oat Straw bolded [correct: b]
  ('BHC - Class 72 - Stroke',
   'Oat Straw appears in the notes as part of a group of herbs that require caution in patients on blood pressure medications. What is the concern?',
   'It increases bleeding risk like ginkgo', 'It can compound blood pressure lowering when added to BP medications', 'It has significant herb-drug interactions with anticoagulants', 'It causes excessive sedation',
   'b',
   'The notes flag oat straw alongside linden, nettle, and cleavers as herbs requiring caution for their blood pressure effects, particularly when a patient is on multiple BP medications.',
   'Caution with herbs for blood pressure like linden, nettle, cleavers, **oat straw**',
   'Herb-Drug Interactions', 110),

  -- Q12 (sort 120) — Sleep timing: Valerian bolded [correct: c]
  ('BHC - Class 72 - Stroke',
   'What time window does the class recommend for administering sleep herbs like valerian and hops in stroke recovery?',
   'Between 8:00 and 10:00 PM', 'Between 9:00 and 11:00 PM', 'Between 5:00 and 7:00 PM', 'Between 6:00 and 8:00 AM',
   'c',
   'The notes specify timing sleep herbs between 5:00 and 7:00 PM — using valerian and hops — to encourage appropriate sleep onset in stroke recovery patients.',
   'Time sleep herbs between 5:00 and 7:00 PM — **valerian** and hops for sleep encouragement',
   'Sleep Support', 120),

  -- Q13 (sort 130) — Sleep herbs: Hops bolded [correct: a]
  ('BHC - Class 72 - Stroke',
   'Which two herbs are named in the notes for sleep encouragement in stroke recovery, timed between 5:00 and 7:00 PM?',
   'Valerian and Hops', 'Linden and Passionflower', 'Chamomile and Lavender', 'Skullcap and Kava',
   'a',
   'The notes name valerian and hops as the sleep support herbs, to be given between 5:00 and 7:00 PM for stroke recovery patients.',
   'Time sleep herbs between 5:00 and 7:00 PM — valerian and **hops** for sleep encouragement',
   'Sleep Support', 130),

  -- Q14 (sort 140) — Burdock: single-herb principle [correct: d]
  ('BHC - Class 72 - Stroke',
   'The instructor recommends focusing on single herbs when a patient is on multiple medications. Which herb is given as the example?',
   'Bacopa', 'Ginkgo', 'Nettle', 'Burdock',
   'd',
   'The instructor advice section states: focus on single herbs where possible, giving burdock as the example — reflecting the "less is more" principle for patients on many medications.',
   'Less is more with herbs due to multiple medications. Focus on single herbs where possible, e.g., **burdock**',
   'Instructor Advice', 140),

  -- Q15 (sort 150) — St. John's Wort: external applications caution [correct: c]
  ('BHC - Class 72 - Stroke',
   'The instructor notes advise using external applications cautiously and cite a specific herb as an example. Which herb is named?',
   'Lavender', 'Rosemary', 'St. John''s Wort', 'Arnica',
   'c',
   'The instructor advice notes that external applications should be used cautiously, giving St. John''s Wort as the specific example, reinforcing the "less is more" principle with multiple medications.',
   'Use external applications cautiously with herbs like **St. John''s Wort**; less is more with multiple medications',
   'Instructor Advice', 150),

  -- Q16 (sort 160) — Case study: Hibiscus bolded [correct: a]
  ('BHC - Class 72 - Stroke',
   'Four herbs were selected for the stroke recovery case study patient with hypertension, atrial fibrillation, and stage 4 CKD. Which herb is listed first?',
   'Hibiscus', 'Nettle', 'Cleavers', 'Oat Straw',
   'a',
   'The case study specifies Hibiscus, Nettle, Cleavers, and Oat Straw as the selected herbs for the patient with hypertension, atrial fibrillation, and stage 4 CKD.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): **Hibiscus**, Nettle, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 160),

  -- Q17 (sort 170) — Case study: medication timing [correct: d]
  ('BHC - Class 72 - Stroke',
   'For the stroke recovery case study patient, when does the protocol recommend taking herbs relative to medications?',
   'Herbs in the morning, meds in the evening', 'Herbs and meds together at all meals', 'Herbs only at bedtime, meds at midday', 'Meds in the morning and evening, herbs in the midday',
   'd',
   'The case study specifies that meds are taken in the morning and evening while herbs are taken in the midday, creating separation to reduce herb-drug interaction risk.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, **Nettle**, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 170),

  -- Q18 (sort 180) — Case study patient conditions [correct: a]
  ('BHC - Class 72 - Stroke',
   'The case study patient has three concurrent diagnoses that shape herb selection. Which set correctly describes his conditions?',
   'Hypertension, atrial fibrillation, and stage 4 CKD', 'Atrial fibrillation, COPD, and hypertension', 'Hypertension, Type 2 diabetes, and stage 3 CKD', 'Stage 4 CKD, heart failure, and stroke',
   'a',
   'The case study patient has hypertension, atrial fibrillation (resulting from chronic hypertension), and stage 4 chronic kidney disease — all of which constrain herb and supplement choices.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, Nettle, **Cleavers**, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 180),

  -- Q19 (sort 190) — Case study: Oat Straw bolded [correct: b]
  ('BHC - Class 72 - Stroke',
   'Oat Straw is one of four herbs selected for the case study patient. What conditions does the patient have that make this herb appropriate?',
   'Sleep apnea and high cholesterol', 'Hypertension, atrial fibrillation, and stage 4 CKD', 'Type 2 diabetes and neuropathy', 'Anxiety and chronic pain',
   'b',
   'Oat Straw was selected alongside Hibiscus, Nettle, and Cleavers for the patient with hypertension, atrial fibrillation, and stage 4 CKD.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, Nettle, Cleavers, **Oat Straw** — meds in the morning and evening, herbs in the midday',
   'Case Study', 190),

  -- Q20 (sort 200) — Fish oils: bleeding risk [correct: d]
  ('BHC - Class 72 - Stroke',
   'The personal notes flag fish oils as a concern when combined with anticoagulants. What specific risk is mentioned?',
   'They raise blood pressure dangerously', 'They reduce kidney function', 'They interfere with sleep cycles', 'They can be a bleeding risk',
   'd',
   'The notes state that some fish oils can be a bleeding risk and advise being mindful of herb/drug interactions when using them with anticoagulants.',
   'Care: some fish oils can be a bleeding risk — be mindful of herb/drug interactions when using with anticoagulants',
   'Stroke Recovery - Herbal Support', 200),

  -- Q21 (sort 210) — Bacopa + Ginkgo head oil [correct: a]
  ('BHC - Class 72 - Stroke',
   'The personal notes suggest an external application using Bacopa and another herb. What application method is recommended?',
   'An oil with Bacopa and Ginkgo massaged into the head', 'A foot bath with Bacopa and Rosemary', 'A chest compress with Bacopa and Turmeric', 'A steam inhalation with Bacopa and Lavender',
   'a',
   'The notes describe using an oil with Bacopa and Ginkgo to massage the head, as an external application for cognitive support in stroke recovery.',
   'Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being. Oil with Bacopa and Ginkgo and massage the head.',
   'Stroke Recovery - Herbal Support', 210),

  -- Q22 (sort 220) — Turmeric: anti-inflammatory [correct: d]
  ('BHC - Class 72 - Stroke',
   'The class notes list Turmeric/curcumin as relevant to stroke recovery. What is its primary noted action?',
   'Circulation support', 'Sleep promotion', 'Diuretic', 'Anti-inflammatory',
   'd',
   'The notes identify Turmeric/curcumin as anti-inflammatory (noted as "AI" in the original text), which is relevant to post-stroke neuroinflammation.',
   'Turmeric/curcumin - anti-inflammatory (AI)',
   'Stroke Recovery - Herbal Support', 220),

  -- Q23 (sort 230) — Oat straw: nervous system support [correct: b]
  ('BHC - Class 72 - Stroke',
   'According to the personal notes, Oat Straw supports which body system, promoting calm focus?',
   'The cardiovascular system', 'The nervous system', 'The digestive system', 'The immune system',
   'b',
   'The notes state that Oat Straw supports nervous system vitality and promotes calm focus, while also nourishing bones with calcium and silica.',
   'Oat straw - supports nervous system (NS) vitality, promotes calm focus, nourishes bones with calcium and silica. Contains minerals and antioxidants like avenanthramides, which may aid in circulation.',
   'Stroke Recovery - Herbal Support', 230),

  -- Q24 (sort 240) — Oat straw: bone nourishment constituents [correct: c]
  ('BHC - Class 72 - Stroke',
   'The notes describe Oat Straw as nourishing bones with two specific minerals. Which pair is correct?',
   'Iron and magnesium', 'Potassium and zinc', 'Calcium and silica', 'Selenium and phosphorus',
   'c',
   'The notes state Oat Straw nourishes bones with calcium and silica, and also contains antioxidants like avenanthramides that may aid circulation.',
   'Oat straw - supports nervous system (NS) vitality, promotes calm focus, nourishes bones with calcium and silica. Contains minerals and antioxidants like avenanthramides, which may aid in circulation.',
   'Stroke Recovery - Herbal Support', 240),

  -- Q25 (sort 250) — Bacopa: Ayurvedic origin [correct: a]
  ('BHC - Class 72 - Stroke',
   'The class notes describe Bacopa as having roots in a specific traditional medical system. Which system is referenced?',
   'Ayurvedic Medicine', 'Traditional Chinese Medicine', 'Unani Medicine', 'Indigenous North American herbalism',
   'a',
   'The notes state that Bacopa has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being.',
   'Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being. Oil with Bacopa and Ginkgo and massage the head.',
   'Stroke Recovery - Herbal Support', 250),

  -- Q26 (sort 260) — Bacopa: anxiety reduction [correct: d]
  ('BHC - Class 72 - Stroke',
   'Beyond memory and cognitive function, what emotional benefit does the class note for Bacopa?',
   'Reduces depression', 'Improves mood and motivation', 'Relieves grief', 'Reduces anxiety',
   'd',
   'The notes state that Bacopa supports memory, cognitive function, and also reduces anxiety — relevant for the stroke patient experiencing brain fog and anxiety.',
   'Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being. Oil with Bacopa and Ginkgo and massage the head.',
   'Stroke Recovery - Herbal Support', 260),

  -- Q27 (sort 270) — Clinical principle: less is more [correct: b]
  ('BHC - Class 72 - Stroke',
   'The instructor''s core principle for herbal prescribing when a patient is on multiple medications is best described as which of the following?',
   'Use the broadest formula possible to cover all symptoms', 'Less is more — focus on single herbs where possible', 'Prioritize the most stimulating herbs to counteract drug side effects', 'Combine as many adaptogens as the patient can tolerate',
   'b',
   'The instructor explicitly advises "less is more with herbs due to multiple medications" and recommends focusing on single herbs where possible, citing burdock as an example.',
   'Less is more with herbs due to multiple medications. Focus on single herbs where possible, e.g., **burdock**',
   'Instructor Advice', 270),

  -- Q28 (sort 280) — Coffee and beta-blockers [correct: c]
  ('BHC - Class 72 - Stroke',
   'The case study notes advise the patient to avoid coffee. What medication interaction is the reason given?',
   'Coffee worsens kidney disease progression', 'Coffee increases bleeding risk with anticoagulants', 'Beta-blockers and caffeine are antagonistic', 'Coffee raises potassium and interacts with Lasix',
   'c',
   'The case study notes state no coffee because of beta-blockers, reflecting the antagonistic relationship between caffeine (a stimulant) and beta-blockers (which slow heart rate and lower blood pressure).',
   'Caution: St. John''s Wort (SJW) — do not take with medications due to drug interactions',
   'Case Study', 280),

  -- Q29 (sort 290) — Stroke types: ischemic vs hemorrhagic [correct: a]
  ('BHC - Class 72 - Stroke',
   'The two main types of stroke discussed in the class are ischemic and hemorrhagic. Which statement correctly distinguishes them?',
   'Ischemic stroke is caused by a clot blocking blood flow; hemorrhagic is caused by a blood vessel rupturing', 'Ischemic stroke involves bleeding in the brain; hemorrhagic involves a clot', 'Both types are caused by clots but affect different brain regions', 'Hemorrhagic stroke only affects the brain stem; ischemic affects the cortex',
   'a',
   'Ischemic stroke results from a blood clot blocking an artery (accounting for ~87% of strokes), while hemorrhagic stroke results from a blood vessel rupturing and bleeding into the brain — a critical distinction for treatment and herb selection.',
   '**Ginkgo**: circulation and cognition aid',
   'Stroke Recovery - Herbal Support', 290),

  -- Q30 (sort 300) — FAST acronym: F [correct: d]
  ('BHC - Class 72 - Stroke',
   'In the FAST stroke recognition acronym, what does the letter "F" stand for?',
   'Fever', 'Fatigue', 'Falling', 'Face drooping',
   'd',
   'FAST is the stroke recognition mnemonic: F = Face drooping (one side of the face droops or is numb), A = Arm weakness, S = Speech difficulty, T = Time to call emergency services.',
   '**Bacopa**: supports memory, cognitive function',
   'Stroke Recovery - Herbal Support', 300),

  -- Q31 (sort 310) — FAST acronym: A [correct: b]
  ('BHC - Class 72 - Stroke',
   'In the FAST stroke recognition acronym, what does "A" stand for?',
   'Altered vision', 'Arm weakness', 'Abdominal pain', 'Accelerated heartbeat',
   'b',
   'In the FAST mnemonic, A stands for Arm weakness — one or both arms may be weak or numb, and when raised, one arm may drift downward.',
   'Ginkgo biloba - circulation and cognition',
   'Stroke Recovery - Herbal Support', 310),

  -- Q32 (sort 320) — FAST acronym: S [correct: c]
  ('BHC - Class 72 - Stroke',
   'In the FAST stroke recognition acronym, "S" stands for which warning sign?',
   'Sweating suddenly', 'Severe headache', 'Speech difficulty', 'Slowed heart rate',
   'c',
   'In FAST, S stands for Speech difficulty — slurred speech, difficulty speaking, or inability to understand speech are key stroke warning signs.',
   'Turmeric/curcumin - anti-inflammatory (AI)',
   'Stroke Recovery - Herbal Support', 320),

  -- Q33 (sort 330) — FAST acronym: T [correct: a]
  ('BHC - Class 72 - Stroke',
   'In the FAST stroke recognition acronym, what action does "T" call for?',
   'Time — call emergency services right away', 'Test reflexes immediately', 'Take an aspirin', 'Treat with cold compress',
   'a',
   'T in FAST stands for Time — it is critical to call emergency services immediately, as "time is brain": every minute of delayed treatment in ischemic stroke results in the loss of approximately 1.9 million neurons.',
   '**Ginkgo**: circulation and cognition aid',
   'Herb-Drug Interactions', 330),

  -- Q34 (sort 340) — Garlic forms that carry bleeding risk [correct: d]
  ('BHC - Class 72 - Stroke',
   'The notes specify that garlic can increase bleeding risk in which forms?',
   'Only raw garlic cloves', 'Only garlic supplements in capsule form', 'Only when applied topically', 'Raw, supplement, or tea',
   'd',
   'The notes are explicit that garlic in any form — raw, supplement, or tea — can increase bleeding risk and should not be combined with blood thinners.',
   'Care: garlic (raw, supplement or tea) can increase bleeding risk — do not combine with blood thinners. Wait 3 or more hours after meds before using.',
   'Stroke Recovery - Herbal Support', 340),

  -- Q35 (sort 350) — Case study: atrial fibrillation cause [correct: b]
  ('BHC - Class 72 - Stroke',
   'According to the case study, what was the underlying cause of the patient''s atrial fibrillation?',
   'Genetic predisposition to arrhythmia', 'Chronic hypertension', 'Long-term use of anticoagulants', 'A viral infection affecting the heart',
   'b',
   'The case study states the patient was "diagnosed with atrial fibrillation as a result of chronic hypertension," establishing hypertension as the root condition driving multiple diagnoses.',
   'Caution: Linden could lower BP too much (patient on multiple blood pressure medications: Losartan, Hydralazine, Lasix)',
   'Case Study', 350),

  -- Q36 (sort 360) — Case study: CKD cause [correct: c]
  ('BHC - Class 72 - Stroke',
   'What caused the case study patient''s stage 4 chronic kidney disease, according to the clinical history?',
   'Overuse of herbal diuretics', 'Long-term use of anticoagulants', 'Long-term hypertension', 'Recurrent urinary tract infections',
   'c',
   'The case study notes that the patient was "classified with stage 4 chronic kidney disease due to long-term hypertension," again connecting hypertension as the root driver.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): **Hibiscus**, Nettle, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 360),

  -- Q37 (sort 370) — Oat straw: avenanthramides [correct: d]
  ('BHC - Class 72 - Stroke',
   'The notes mention a specific class of antioxidants in Oat Straw that may aid circulation. What are they called?',
   'Quercetin glycosides', 'Terpene lactones', 'Procyanidins', 'Avenanthramides',
   'd',
   'The notes specifically name avenanthramides as the antioxidants in Oat Straw that may aid in circulation, alongside its mineral content of calcium and silica.',
   'Oat straw - supports nervous system (NS) vitality, promotes calm focus, nourishes bones with calcium and silica. Contains minerals and antioxidants like avenanthramides, which may aid in circulation.',
   'Stroke Recovery - Herbal Support', 370),

  -- Q38 (sort 380) — Fish oils: what to be mindful of [correct: a]
  ('BHC - Class 72 - Stroke',
   'When fish oils are used alongside anticoagulants, the notes advise being mindful of what?',
   'Herb and drug interactions', 'Vitamin D toxicity from combined supplementation', 'Mercury content in fish oil capsules', 'The timing of fish oil relative to meals',
   'a',
   'The notes state: "be mindful of herb/drug interactions when using with anticoagulants" — fish oils can compound the bleeding risk of anticoagulant medications.',
   'Care: some fish oils can be a bleeding risk — be mindful of herb/drug interactions when using with anticoagulants',
   'Stroke Recovery - Herbal Support', 380),

  -- Q39 (sort 390) — Valerian: primary use in stroke context [correct: c]
  ('BHC - Class 72 - Stroke',
   'In the stroke recovery context, what is the primary role of Valerian according to the class notes?',
   'Blood pressure reduction', 'Anti-inflammatory support', 'Sleep encouragement', 'Circulation and cognition',
   'c',
   'The notes identify Valerian (along with Hops) as a sleep herb, to be timed between 5:00 and 7:00 PM for sleep encouragement in stroke recovery patients.',
   'Time sleep herbs between 5:00 and 7:00 PM — **valerian** and hops for sleep encouragement',
   'Sleep Support', 390),

  -- Q40 (sort 400) — Hops: timing context [correct: b]
  ('BHC - Class 72 - Stroke',
   'Hops is used for sleep support in the stroke recovery protocol. According to the notes, what timing principle applies?',
   'Take with the morning medications to reduce anxiety throughout the day', 'Give between 5:00 and 7:00 PM to encourage appropriate sleep onset', 'Give at bedtime alongside evening medications', 'Use only as needed during nighttime awakenings',
   'b',
   'The notes specify that sleep herbs — Valerian and Hops — should be timed between 5:00 and 7:00 PM for sleep encouragement, separate from the bedtime medication timing.',
   'Time sleep herbs between 5:00 and 7:00 PM — valerian and **hops** for sleep encouragement',
   'Sleep Support', 400),

  -- Q41 (sort 410) — SJW: case study caution phrasing [correct: d]
  ('BHC - Class 72 - Stroke',
   'The case study personal notes give what specific instruction about St. John''s Wort for this patient?',
   'Use only as an external oil, never internally', 'Limit to one cup of tea daily', 'Avoid in the morning but safe in the evening', 'Do not take with medications due to drug interactions',
   'd',
   'The personal case study notes state explicitly: "SJW — do not take with medications due to drug interactions," reflecting the herb''s known CYP450 enzyme induction and broad medication interactions.',
   'Caution: St. John''s Wort (SJW) — do not take with medications due to drug interactions',
   'Case Study', 410),

  -- Q42 (sort 420) — Linden: the three BP meds mentioned [correct: a]
  ('BHC - Class 72 - Stroke',
   'The notes caution against Linden for the case study patient because it could lower BP too much. Which three blood pressure medications is the patient taking that create this concern?',
   'Losartan, Hydralazine, and Lasix', 'Carvedilol, Eliquis, and Keppra', 'Zetia, Jardiance, and Losartan', 'Hydralazine, Eliquis, and Carvedilol',
   'a',
   'The notes specifically name Losartan (antihypertensive), Hydralazine (vasodilator), and Lasix (diuretic) as the combination that makes excessive BP lowering from Linden a real concern.',
   'Caution: Linden could lower BP too much (patient on multiple blood pressure medications: Losartan, Hydralazine, Lasix)',
   'Case Study', 420),

  -- Q43 (sort 430) — Ginkgo generated vs personal notes [correct: b]
  ('BHC - Class 72 - Stroke',
   'Both the generated and personal notes describe Ginkgo biloba''s benefits for stroke recovery. Which pair of benefits is consistently noted?',
   'Sleep support and anti-inflammatory action', 'Circulation and cognition', 'Diuretic effect and kidney support', 'Blood pressure lowering and stress reduction',
   'b',
   'Both the generated notes ("Ginkgo: circulation and cognition aid") and the personal notes ("Ginkgo biloba - circulation and cognition") consistently identify circulation and cognition as Ginkgo''s core benefits.',
   '**Ginkgo**: circulation and cognition aid',
   'Stroke Recovery - Herbal Support', 430),

  -- Q44 (sort 440) — Ginkgo: part of bleeding risk trio [correct: c]
  ('BHC - Class 72 - Stroke',
   'Although Ginkgo supports circulation and cognition, why must it be used cautiously in a patient on anticoagulant medication?',
   'It raises blood pressure and worsens hypertension', 'It impairs kidney clearance of medications', 'It increases bleeding risk and should be avoided with warfarin or similar drugs', 'It has sedative effects that interact with sleep medications',
   'c',
   'The notes flag Ginkgo as one of the three herbs (with garlic and ginger) to avoid with anticoagulants like warfarin, because it increases bleeding risk.',
   'Anticoagulants like warfarin — avoid **ginkgo**, garlic, ginger — increase bleeding risk',
   'Herb-Drug Interactions', 440),

  -- Q45 (sort 450) — Case study: stroke locations and deficits [correct: d]
  ('BHC - Class 72 - Stroke',
   'According to the case study clinical history, in which areas of the brain did the patient experience strokes, and what functional impact resulted?',
   'Cerebellum only, causing balance problems', 'Frontal lobe only, causing personality changes', 'Brain stem, causing breathing difficulties', 'Both hemispheres with micro hemorrhaging, causing aphasia and right hand hemiparesis',
   'd',
   'The case study records strokes in both hemispheres with micro hemorrhaging, resulting in aphasia, short-term memory impact, and right hand hemiparesis — guiding the focus on memory and language recovery herbs.',
   'Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being. Oil with Bacopa and Ginkgo and massage the head.',
   'Case Study', 450),

  -- Q46 (sort 460) — Ginger: bleeding risk forms [correct: a]
  ('BHC - Class 72 - Stroke',
   'Like garlic, ginger can increase bleeding risk in multiple forms. Which of the following correctly names the forms specified in the notes?',
   'Raw, supplement, or tea', 'Dried powder and tincture only', 'Topical oil and capsule only', 'Only when taken in large doses as a supplement',
   'a',
   'The notes specify that ginger in any form — raw, supplement, or tea — can increase bleeding risk and should not be combined with blood thinners.',
   'Care: ginger (raw, supplement, or tea) can increase bleeding risk — do not combine with blood thinners. Wait 3 or more hours after meds before using.',
   'Stroke Recovery - Herbal Support', 460),

  -- Q47 (sort 470) — Hibiscus: kidney and BP context [correct: b]
  ('BHC - Class 72 - Stroke',
   'Hibiscus was selected for the case study patient partly because of its relevance to one of his conditions. Which condition makes Hibiscus an appropriate choice?',
   'Atrial fibrillation management', 'Hypertension and kidney support in the setting of stage 4 CKD', 'Anticoagulant support', 'Sleep disturbance from stroke',
   'b',
   'Hibiscus is well known for supporting healthy blood pressure and kidney function, making it appropriate for a patient with both hypertension and stage 4 CKD.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): **Hibiscus**, Nettle, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 470),

  -- Q48 (sort 480) — Cleavers: lymphatic and kidney context [correct: c]
  ('BHC - Class 72 - Stroke',
   'Cleavers was chosen as one of the four herbs for the case study patient. Given his diagnosis of stage 4 CKD, what role does Cleavers typically play that is relevant?',
   'Direct cardiac rate regulation', 'Central nervous system stimulation', 'Lymphatic and kidney/urinary system support', 'Anticoagulant activity to replace Eliquis',
   'c',
   'Cleavers is a lymphatic and kidney/urinary tonic, supporting filtration and fluid clearance — relevant for a patient with stage 4 CKD who also needs gentle kidney support.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, Nettle, **Cleavers**, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 480),

  -- Q49 (sort 490) — Nettle: mineral-rich nutritive context [correct: d]
  ('BHC - Class 72 - Stroke',
   'Nettle was selected for the stroke recovery case study patient. What characteristic of Nettle makes it appropriate alongside herbs like Hibiscus and Oat Straw in this protocol?',
   'It is a strong sedative for sleep disturbance', 'It directly inhibits platelet aggregation', 'It is an adaptogen for adrenal support', 'It is a mineral-rich nutritive herb that supports blood pressure and kidney function',
   'd',
   'Nettle is a mineral-rich nutritive herb known for its gentle support of blood pressure and kidney function, complementing Hibiscus, Cleavers, and Oat Straw in the case study protocol.',
   'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, **Nettle**, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
   'Case Study', 490),

  -- Q50 (sort 500) — Integrative principle: herb-drug safety with multiple meds [correct: b]
  ('BHC - Class 72 - Stroke',
   'Which statement best reflects the overarching clinical principle taught in Class 72 for herbal support when a patient is on many pharmaceutical medications?',
   'Use full herbal formulas to address all symptoms simultaneously', 'Prioritize simplicity — single herbs, cautious dosing, and careful attention to herb-drug interactions', 'Start with the most potent herbs to achieve faster results', 'Avoid all herbal support until all pharmaceutical medications are discontinued',
   'b',
   'Class 72 consistently emphasizes: less is more, use single herbs where possible, time herbs away from meds, flag bleeding risks, and always be mindful of herb-drug interactions — especially for complex patients on multiple medications.',
   'Less is more with herbs due to multiple medications. Focus on single herbs where possible, e.g., **burdock**',
   'Instructor Advice', 500);

END $$;
