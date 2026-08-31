-- Migration 233: Class 46 — Digestive System IV and Tongue Diagnosis quiz questions
-- Source: supabase/migrations/231_class_46_digestive_iv_tongue_diagnosis_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 46 - Digestive System IV and Tongue Diagnosis') THEN
    RAISE NOTICE 'Class 46 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES
    -- Q1  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which herb is described as specific for an underfunctioning thyroid and can be swapped out from Ashwagandha?',
     'Gotu Kola', 'Shatavari', 'Lemon Balm', 'Bupleurum',
     'a',
     'The notes state that Gotu Kola is specific for an underfunctioning thyroid and can be swapped out from Ashwagandha for good effect in thyroid-support formulas.',
     'Gotu Kola is specific for an underfunctioning thyroid — can swap it out from Ashwagandha for good effect in thyroid-support formulas.',
     'Clinical Notes', 10),

    -- Q2  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Why does Yellow Dock require decoction rather than a standard cold infusion?',
     'Its tannins break down in cold water', 'Heat is needed to extract its active constituents, including iron-binding compounds', 'Cold water makes it too bitter to tolerate', 'It is only soluble in alcohol',
     'b',
     'The notes specify that Yellow Dock requires decoction with heat for proper extraction — the active constituents (esculin, iron-binding compounds) are not water-soluble without heat.',
     'Yellow Dock requires decoction with heat for proper extraction — the active constituents (esculin, iron-binding compounds) are not water-soluble without heat. A glycerite, digestive bitter formula, or syrup helps mask the difficult taste.',
     'Extraction Methods', 20),

    -- Q3  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which herb is better suited to cold infusion because no heat is needed to extract its mucopolysaccharides?',
     'Calendula', 'Yellow Dock', 'Dandelion Root', 'Marshmallow',
     'd',
     'The notes state that Marshmallow is better suited to cold infusion — no heat needed to extract the mucopolysaccharides — contrasting it with Calendula, which requires heat for resin extraction.',
     'Marshmallow is better suited to cold infusion — no heat needed to extract the mucopolysaccharides. Contrast with Calendula, which requires heat for resin extraction.',
     'Extraction Methods', 30),

    -- Q4  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Why is Calendula not extractive in a cold infusion?',
     'Its resins require heat to release', 'Its alkaloids are denatured by cold water', 'Cold water increases its bitterness unpredictably', 'It can only be extracted via glycerite',
     'a',
     'The notes state that Calendula is not extractive in cold infusions because its resins require heat to release. Alcohol tincture or hot water infusion is recommended instead.',
     'Calendula is not extractive in cold infusions — its resins require heat to release. Use alcohol tincture or hot water infusion; cold water will not adequately extract the active constituents.',
     'Extraction Methods', 40),

    -- Q5  correct: c
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'For which menstrual presentation is Dong Quai specifically contraindicated?',
     'Scant menses', 'Amenorrhea', 'Heavy menses', 'Dysmenorrhea',
     'c',
     'The notes clearly state that Dong Quai is contraindicated for heavy menses — it can aggravate heavy bleeding — and is instead indicated for light or scant menses.',
     'Dong Quai is contraindicated for heavy menses — it can aggravate heavy bleeding. It is specifically indicated for light or scant menses (hypomenorrhea/amenorrhea). Remove it from formulas and shift dosage to Peony when heavy bleeding is present.',
     'Contraindications', 50),

    -- Q6  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which herb can substitute for Raspberry Leaf as a nutritive herb in dry constitutions?',
     'Holy Basil', 'Gotu Kola', 'Shatavari', 'Lemon Balm',
     'd',
     'The notes describe Lemon Balm as a nutritive replacement for Raspberry Leaf because Raspberry Leaf may be too drying for some constitutions.',
     'Lemon Balm can substitute for Raspberry Leaf as a nutritive herb in dry constitutions — Raspberry Leaf may be too drying for some people.',
     'Clinical Notes', 60),

    -- Q7  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Holy Basil (Tulsi) is described in these notes primarily as which type of herb?',
     'A cooling sedative', 'A warming adaptogen', 'A digestive bitter', 'A hepatoprotective',
     'b',
     'The notes describe Holy Basil (Tulsi) as a warming adaptogen — soft and uplifting — good for stress, anxiety, and adrenal support without over-stimulating.',
     'Holy Basil (Tulsi) is a warming adaptogen — described as soft and uplifting. Good gentle choice for stress, anxiety, and adrenal support without over-stimulating.',
     'Clinical Notes', 70),

    -- Q8  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What is the recommended dosage for Dandelion Root in these notes?',
     '2–4 mL twice daily', '1–2 mL twice daily', '3–6 mL once daily', '0.5–1 mL three times daily',
     'a',
     'The notes specify Dandelion root at 2–4 mL twice daily for liver support, GI tract stimulation, and bile flow.',
     'Dandelion root: 2–4 mL twice daily for liver support, GI tract stimulation, and bile flow. Also used for iron absorption support alongside Yellow Dock.',
     'Dosing', 80),

    -- Q9  correct: c
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What is the recommended dosage for Prickly Ash in these notes?',
     '3–5 mL twice daily', '0.5–1 mL once daily', '1–2 mL twice daily', '2–4 mL three times daily',
     'c',
     'The notes specify Prickly Ash at 1–2 mL twice daily for circulatory and digestive stimulation.',
     'Prickly Ash: 1–2 mL twice daily for circulatory and digestive stimulation.',
     'Dosing', 90),

    -- Q10  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which herb is the primary herb for Liver Qi stagnation and is found in the formulas Xiao Yao San and Shu Gan San?',
     'Dandelion Root', 'Shatavari', 'Gotu Kola', 'Bupleurum (Chai Hu)',
     'd',
     'The notes name Bupleurum (Chai Hu) as the primary herb for Liver Qi stagnation, used in the classical formulas Xiao Yao San and Shu Gan San.',
     'Bupleurum (Chai Hu) is the primary herb for Liver Qi stagnation — used in classical formulas Xiao Yao San and Shu Gan San. Liver Qi sx: depression, frustration, pain in the sides, PMS, decision-making difficulty, hormonal dysregulation.',
     'Clinical Notes', 100),

    -- Q11  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which combination formula is described as moistening and nourishing to the gut, appropriate for dry constitutions with GI inflammation?',
     'Shatavari, Marshmallow, Cinnamon, and Cardamom', 'Bupleurum, Dandelion, and Lemon Balm', 'Yellow Dock, Prickly Ash, and Gotu Kola', 'Dong Quai, Holy Basil, and Calendula',
     'a',
     'The notes describe the combination of Shatavari with Marshmallow, Cinnamon, and Cardamom as creating a moistening and nourishing gut formula for dry constitutions with GI inflammation or poor absorption.',
     'Shatavari combined with Marshmallow, Cinnamon, and Cardamom creates a moistening and nourishing gut formula — appropriate for dry constitutions with GI inflammation or poor absorption.',
     'Case Study Formula', 110),

    -- Q12  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'According to these notes, what are two hallmark symptoms of Liver Qi stagnation?',
     'Constipation and bloating', 'Depression and frustration, with pain on the sides', 'Dry mouth and thirst', 'Nausea and vomiting',
     'b',
     'The notes list Liver Qi stagnation symptoms as including depression, frustration, pain on the sides, decision-making issues, PMS, and hormonal dysregulation.',
     'Symptoms of Liver Qi Stagnation — Depression, frustration; Pain on sides, decision-making issues; PMS symptoms, hormonal issues linked to liver health.',
     'Clinical Notes', 120),

    -- Q13  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'How should Gotu Kola be dosed for brain fog and anxiety according to these notes?',
     'Once daily at bedtime', 'Three times daily with meals', '2 mL twice daily on an empty stomach', '3–6 times daily, especially before meals',
     'd',
     'The notes specify that Gotu Kola should be dosed 3–6 times daily, especially before meals, for brain fog and anxiety.',
     'Gotu Kola for brain fog and anxiety — dose 3–6 times daily, especially before meals.',
     'Dosing', 130),

    -- Q14  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which sour, fresh foods are listed as supportive for liver health in these notes?',
     'Sprouts, asparagus, green apples, lemon, lime juice', 'Beets, carrots, and parsnips', 'Fermented vegetables and dark leafy greens', 'Turmeric, ginger, and black pepper',
     'a',
     'The notes list sour, fresh green foods such as sprouts, asparagus, green apples, lemon, and lime juice as supportive for the liver.',
     'Liver herbs and food — sour, fresh green foods; Sprouts, asparagus, green apples, lemon, lime juice.',
     'Clinical Notes', 140),

    -- Q15  correct: c
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What is the general recommendation in these notes when a patient presents with digestive issues, regardless of their constitution?',
     'Default to cool, dry foods to reduce inflammation', 'Use primarily bitter herbs to stimulate digestion', 'Default to warm, wet foods', 'Focus on raw foods for enzyme content',
     'c',
     'The notes state: always when digestive issues, default to warm wet foods, regardless of their perceived constitution.',
     'always when digestive issues, default to warm wet foods, regardless of their perceived constitution',
     'Clinical Notes', 150),

    -- Q16  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'How many drops equals 2 mL according to these notes?',
     '30 drops', '60 drops', '45 drops', '90 drops',
     'b',
     'The notes explicitly state that 60 drops = 2 mL, an important conversion for dosing calculations.',
     '60 drops = 2ml',
     'Clinical Notes', 160),

    -- Q17  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What is the recommended maximum number of herbs in a formula to ensure each herb reaches a therapeutic dose?',
     '2–3 herbs', '6–7 herbs', '8–10 herbs', '4–5 herbs',
     'd',
     'The notes recommend generally 4–5 herbs max in a formula so that each herb can be present at a therapeutic dose.',
     'generally 4-5 herbs max in a formula to get to a therapeutic dose for each herb',
     'Clinical Notes', 170),

    -- Q18  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'In the Peony and Licorice formula, what dosing ratio is desired between the two herbs?',
     '3 parts Peony to 1 part Licorice', '1 part Peony to 3 parts Licorice', '1 part Peony to 1 part Licorice', '2 parts Peony to 1 part Licorice',
     'a',
     'The notes specify a Peony and Licorice dosing ratio of 3 parts Peony to 1 part Licorice.',
     'Peony and Licorice dosing ratio: 3 parts peony to 1 part licorice desired',
     'Clinical Notes', 180),

    -- Q19  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Dong Quai is specifically indicated for which menstrual presentation?',
     'Heavy menses with clotting', 'Light or scant menses', 'Irregular cycles with mood changes', 'Painful menses with cramping',
     'b',
     'The notes state that Dong Quai is specifically indicated for light or scant menses (hypomenorrhea/amenorrhea) and is contraindicated in heavy menses.',
     'Dong Quai is contraindicated for heavy menses — it can aggravate heavy bleeding. It is specifically indicated for light or scant menses (hypomenorrhea/amenorrhea).',
     'Contraindications', 190),

    -- Q20  correct: c
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Wild Ginger is noted in these class notes as having specific activity in which organ or system?',
     'The liver', 'The kidneys', 'The uterus', 'The lungs',
     'c',
     'The notes state that wild ginger targets the uterus and warms it up, noting it is not significant for the gut.',
     'wild ginger targets the uterus',
     'Clinical Notes', 200),

    -- Q21  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which preparation method is suggested to help mask the difficult taste of Yellow Dock?',
     'Hot infusion steeped for 20 minutes', 'Cold infusion in the refrigerator overnight', 'Steam distillation into an essential oil', 'Glycerite, digestive bitter formula, or syrup',
     'd',
     'The notes state that a glycerite, digestive bitter formula, or syrup helps mask the difficult taste of Yellow Dock after proper decoction.',
     'Yellow Dock requires decoction with heat for proper extraction — the active constituents (esculin, iron-binding compounds) are not water-soluble without heat. A glycerite, digestive bitter formula, or syrup helps mask the difficult taste.',
     'Extraction Methods', 210),

    -- Q22  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What are the primary therapeutic roles of Dandelion Root described in these notes?',
     'Liver support, GI tract stimulation, and bile flow', 'Antimicrobial and anti-inflammatory', 'Adrenal tonic and nervine', 'Circulatory stimulant and diaphoretic',
     'a',
     'The notes describe Dandelion Root as supporting the liver, GI tract, and stimulating bile flow, with dosing at 2–4 mL twice daily.',
     'Dandelion root: 2–4 mL twice daily for liver support, GI tract stimulation, and bile flow. Also used for iron absorption support alongside Yellow Dock.',
     'Dosing', 220),

    -- Q23  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Prickly Ash is described in these notes as having which two primary actions?',
     'Demulcent and nutritive', 'Circulatory stimulant and digestive stimulant', 'Cholagogue and alterative', 'Hepatoprotective and adaptogen',
     'b',
     'The notes describe Prickly Ash as supporting circulatory and digestive stimulation, dosed at 1–2 mL twice daily.',
     'Prickly Ash: 1–2 mL twice daily for circulatory and digestive stimulation.',
     'Dosing', 230),

    -- Q24  correct: c
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which liver-supporting TCM formula is mentioned alongside Xiao Yao San in these notes for Liver Qi stagnation?',
     'Liu Wei Di Huang Wan', 'Ba Zhen Tang', 'Shu Gan San', 'Si Jun Zi Tang',
     'c',
     'The notes list both Shu Gan San and Xiao Yao San as TCM formulas used for Liver Qi stagnation alongside Bupleurum.',
     'Shu gan san; Xiao yao san; Bupleurum (Chai hu)',
     'Clinical Notes', 240),

    -- Q25  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'PMS and hormonal dysregulation are listed in these notes as symptoms of which TCM pattern?',
     'Kidney Yin deficiency', 'Heart Blood deficiency', 'Spleen Qi deficiency', 'Liver Qi stagnation',
     'd',
     'The notes link PMS symptoms and hormonal issues to Liver Qi stagnation, alongside depression, frustration, side pain, and decision-making difficulty.',
     'Symptoms of Liver Qi Stagnation — Depression, frustration; Pain on sides, decision-making issues; PMS symptoms, hormonal issues linked to liver health.',
     'Clinical Notes', 250),

    -- Q26  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What distinguishes Lemon Balm from Raspberry Leaf when choosing a nutritive herb for a dry constitution?',
     'Raspberry Leaf may be too drying, making Lemon Balm the better choice', 'Lemon Balm is more warming than Raspberry Leaf', 'Lemon Balm has stronger astringency than Raspberry Leaf', 'Raspberry Leaf is contraindicated in pregnancy unlike Lemon Balm',
     'a',
     'The notes state that Lemon Balm can substitute for Raspberry Leaf as a nutritive herb specifically because Raspberry Leaf may be too drying for dry constitutions.',
     'Lemon Balm can substitute for Raspberry Leaf as a nutritive herb in dry constitutions — Raspberry Leaf may be too drying for some people.',
     'Clinical Notes', 260),

    -- Q27  correct: b
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Gotu Kola is listed in these notes with which two nervous system indications?',
     'Insomnia and headache', 'Brain fog and anxiety', 'Depression and PTSD', 'Neuropathy and tremor',
     'b',
     'The notes list Gotu Kola for brain fog and anxiety, dosed 3–6 times daily especially before meals.',
     'Gotu Kola for brain fog and anxiety — dose 3–6 times daily, especially before meals.',
     'Dosing', 270),

    -- Q28  correct: c
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'What role does Shatavari play in the case study formula described in these notes?',
     'It provides circulatory stimulation alongside Prickly Ash', 'It stimulates bile flow as a cholagogue', 'It is the primary moistening and nourishing herb in a gut formula with Marshmallow, Cinnamon, and Cardamom', 'It replaces Bupleurum for Liver Qi stagnation in dry constitutions',
     'c',
     'The notes describe Shatavari combined with Marshmallow, Cinnamon, and Cardamom as a moistening and nourishing gut formula for dry constitutions.',
     'Shatavari combined with Marshmallow, Cinnamon, and Cardamom creates a moistening and nourishing gut formula — appropriate for dry constitutions with GI inflammation or poor absorption.',
     'Case Study Formula', 280),

    -- Q29  correct: d
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Which herb can be substituted for Ashwagandha specifically in thyroid-support formulas?',
     'Dandelion Root', 'Bupleurum', 'Holy Basil', 'Gotu Kola',
     'd',
     'The notes state that Gotu Kola is specific for an underfunctioning thyroid and can be swapped out from Ashwagandha for good effect.',
     'Gotu Kola is specific for an underfunctioning thyroid — can swap it out from Ashwagandha for good effect in thyroid-support formulas.',
     'Clinical Notes', 290),

    -- Q30  correct: a
    ('BHC - Class 46 - Digestive System IV and Tongue Diagnosis',
     'Fennel seeds are mentioned in these notes as being taken at what specific time?',
     'After meals', 'First thing in the morning on an empty stomach', 'With the largest meal of the day', '30 minutes before meals',
     'a',
     'The notes specifically mention fennel seeds after meals as a digestive support strategy.',
     'fennel seeds after meals',
     'Clinical Notes', 300)
  ;
END $$;
