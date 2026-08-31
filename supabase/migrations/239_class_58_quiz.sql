-- Migration 239: Class 58 — Ayurveda quiz questions
-- Source: supabase/migrations/220_class_58_ayurveda_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 58 - Ayurveda') THEN
    RAISE NOTICE 'Class 58 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1
    ('BHC - Class 58 - Ayurveda',
     'Which Ayurvedic dosha is described as prone to congestion, edema, and hypothyroid disorders?',
     'Vata', 'Pitta', 'Kapha', 'Tridosha',
     'c',
     'The Kapha dosha is characterised by fluid stagnancy, mucus buildup, and hypoglandular tendencies such as Hashimoto''s and hypothyroidism.',
     'Kapha plants: sour (schisandra) — for congestion, edema, fatigue, stagnancy; sour flavor liquifies mucus.',
     'Kapha', 10),

    -- Q2
    ('BHC - Class 58 - Ayurveda',
     'What is Schisandra''s primary role in treating Kapha presentations according to the class notes?',
     'Nervine sedative for anxiety', 'Sour, stimulating herb for congestion and stagnancy', 'Hepatic bitter for liver detox', 'Demulcent for dry mucous membranes',
     'b',
     'Schisandra is listed as a sour, stimulating herb providing symptomatic relief for Kapha''s hallmark patterns of congestion, edema, and fatigue.',
     'Schisandra — symptomatic relief for Kapha: used as a sour, stimulating herb for congestion, edema, and hypothyroid disorders.',
     'Kapha', 20),

    -- Q3
    ('BHC - Class 58 - Ayurveda',
     'According to the notes, what flavor does Schisandra contribute that is specifically therapeutic for Kapha mucus buildup?',
     'Bitter', 'Sweet', 'Sour', 'Pungent',
     'c',
     'The notes state that the sour flavor liquifies mucus, making sour herbs like Schisandra especially indicated for Kapha congestion.',
     'love juicing, spicy, raw; flavors are sour and pungent — sour liquifies mucus, pungent is heating and expectorating',
     'Kapha', 30),

    -- Q4
    ('BHC - Class 58 - Ayurveda',
     'Which emotional tendencies are associated with the Kapha dosha in these notes?',
     'Anxiety and irritability', 'Melancholy and denial', 'Fear and restlessness', 'Anger and jealousy',
     'b',
     'The generated notes explicitly list melancholy and denial as the emotional tendencies of Kapha types.',
     'Kapha plants: sour (schisandra) — for congestion, edema, fatigue, stagnancy; sour flavor liquifies mucus.',
     'Kapha', 40),

    -- Q5
    ('BHC - Class 58 - Ayurveda',
     'In the chemical sensitivity case study, which herb is highlighted as the primary liver/detox herb for complex chemical accumulation?',
     'Burdock', 'Dandelion root', 'Milk Thistle', 'Red Clover',
     'c',
     'Milk Thistle is singled out for complex accumulation with chemical exposure, long-term pharmaceutical use, and alcohol exposure, with a prioritised dose of 40–50 drops.',
     'Milk Thistle — for complex accumulation with chemical exposure, long-term pharma use, alcohol exposure; prioritize 40–50 drops.',
     'Chemical Sensitivity', 50),

    -- Q6
    ('BHC - Class 58 - Ayurveda',
     'What mechanism does Ginger act through in the chemical sensitivity formula to address constipation?',
     'Bulk laxative effect', 'Stimulates bile flow', 'Activates the migrating motor complex', 'Relaxes intestinal spasm',
     'c',
     'The notes specifically state that Ginger activates the migrating motor complex, which gets things moving in the bowel.',
     'Ginger — activates the migrating motor complex; gets things moving in the bowel; indicated for constipation.',
     'Chemical Sensitivity', 60),

    -- Q7
    ('BHC - Class 58 - Ayurveda',
     'What therapeutic actions are prioritised when building a formula for chemical sensitivity?',
     'Diaphoretic, diuretic, antispasmodic, tonic', 'Amphoteric, alterative, hepatic, nervine', 'Adaptogen, immunomodulator, antiviral, anti-inflammatory', 'Expectorant, demulcent, astringent, carminative',
     'b',
     'The class notes list amphoteric, alterative, hepatic, and nervine as the four primary action categories for a chemical sensitivity formula.',
     'Eucalyptus — example plant for chemical sensitivity formula; indicated actions include amphoteric, alterative, hepatic, nervine.',
     'Chemical Sensitivity', 70),

    -- Q8
    ('BHC - Class 58 - Ayurveda',
     'Which herb in the chemical sensitivity formula is noted for its mood stabilisation and listed at 60–100 drops?',
     'Lemon Balm', 'Linden', 'St. John''s Wort', 'Skullcap',
     'c',
     'St. John''s Wort is the mood stabiliser in the chemical sensitivity formula, with dosage ranges noted as 60–100 drops in the generated notes.',
     'St. John''s Wort — mood stabilization in chemical sensitivity formula; ranges 60–100 drops.',
     'Chemical Sensitivity', 80),

    -- Q9
    ('BHC - Class 58 - Ayurveda',
     'What caution is noted for Linden in the chemical sensitivity formula?',
     'Can increase liver enzymes', 'May cause drowsiness', 'Contraindicated with antidepressants', 'May aggravate constipation',
     'b',
     'The notes flag a drowsiness caution for Linden and advise adjusting the dose to maintain balance in the formula.',
     'Linden — mood support for chemical sensitivity formula; drowsiness caution; adjust for balance.',
     'Chemical Sensitivity', 90),

    -- Q10
    ('BHC - Class 58 - Ayurveda',
     'Yellow Dock is described in the chemical sensitivity notes as which type of herb?',
     'Strong stimulating laxative with purgative action', 'Mild laxative that is also bitter and gentle', 'Demulcent bulk-forming laxative', 'Hepatic cholagogue with no laxative action',
     'b',
     'Yellow Dock is described as a mild laxative that is bitter but also a gentle laxative, indicated for constipation and chemical detox.',
     'Yellow Dock — mild laxative; bitter but also a gentle laxative; 50–60 drops for constipation and chemical detox.',
     'Chemical Sensitivity', 100),

    -- Q11
    ('BHC - Class 58 - Ayurveda',
     'What prioritised drop dose is suggested for Yellow Dock in the chemical sensitivity formula?',
     '20–30 drops', '40 drops', '50 drops', '75 drops',
     'c',
     'The notes state "prioritize 50 drops" for Yellow Dock in the chemical sensitivity context.',
     'Yellow Dock — addresses chemicals and constipation; prioritize 50 drops.',
     'Chemical Sensitivity', 110),

    -- Q12
    ('BHC - Class 58 - Ayurveda',
     'In the personal notes, which herb is listed for "stimulating bile" as a hepatic/alterative in chemical sensitivity?',
     'Marshmallow root', 'Burdock', 'Valerian', 'Sarsaparilla',
     'b',
     'Burdock is explicitly listed as a bile-stimulating hepatic/alterative herb in the chemical sensitivity detox protocol.',
     'Burdock — stimulating bile; hepatic/alterative herb in chemical sensitivity detox protocol.',
     'Chemical Sensitivity', 120),

    -- Q13
    ('BHC - Class 58 - Ayurveda',
     'Which herb is indicated for "mood/nervine support" and specifically for "depression associated with chemical sensitivity"?',
     'Valerian', 'Passionflower', 'Lemon Balm', 'Catnip',
     'c',
     'Lemon Balm is listed as the nervine/mood herb for depression in the chemical sensitivity protocol.',
     'Lemon Balm — mood/nervine support; for depression associated with chemical sensitivity.',
     'Chemical Sensitivity', 130),

    -- Q14
    ('BHC - Class 58 - Ayurveda',
     'Which herb combination is described as a tea blend for the chemical sensitivity case?',
     'Chamomile, peppermint, licorice, fennel, ginger', 'Chicory, sarsaparilla, cinnamon, hawthorn berry, elder berry', 'Dandelion, burdock, red clover, milk thistle, yellow dock', 'Lemon balm, linden, passionflower, skullcap, oatstraw',
     'b',
     'The personal notes specify chicory, sarsaparilla, cinnamon, haw berry (hawthorn berry), and elder berry as the tea blend for the chemical sensitivity case.',
     'Chicory root — tea blend for chemical sensitivity case; bitter digestive and detox support.',
     'Chemical Sensitivity', 140),

    -- Q15
    ('BHC - Class 58 - Ayurveda',
     'According to the class notes, what does Eucalyptus represent in the chemical sensitivity formula context?',
     'A primary adaptogen for stress resilience', 'An example plant for chemical sensitivity with amphoteric and alterative actions', 'A specific remedy for Kapha congestion', 'A purgative for bowel clearance',
     'b',
     'Eucalyptus is listed as an example plant for the chemical sensitivity formula, with amphoteric, alterative, hepatic, and nervine as the indicated actions.',
     'Eucalyptus — example plant for chemical sensitivity formula; indicated actions include amphoteric, alterative, hepatic, nervine.',
     'Chemical Sensitivity', 150),

    -- Q16
    ('BHC - Class 58 - Ayurveda',
     'Licorice appears in the chemical sensitivity protocol primarily in what role?',
     'As a nervine for mood support', 'As a bile-stimulating hepatic/alterative', 'As a demulcent for the gut lining', 'As a hormonal adaptogen',
     'b',
     'Licorice is grouped with the bile-stimulating herbs (burdock, milk thistle, yellow dock, dandelion root) in the chemical sensitivity detox protocol.',
     'Licorice — bile-stimulating; included in hepatic/alterative protocol for chemical sensitivity.',
     'Chemical Sensitivity', 160),

    -- Q17
    ('BHC - Class 58 - Ayurveda',
     'What physical symptoms are described in the personal notes as characteristic of Kapha beyond congestion and edema?',
     'Dry skin, constipation, insomnia', 'Boggy lymph, possible sleep apnea, fatigue, bloating after meals', 'Hot flushes, palpitations, hypertension', 'Weight loss, anxiety, tremors',
     'b',
     'The personal Kapha block lists boggy/lumpy lymph, possible sleep apnea, fatigue, low BP, and bloating after meals among Kapha''s characteristic presentations.',
     'Kapha plants: sour (schisandra) — for congestion, edema, fatigue, stagnancy; sour flavor liquifies mucus.',
     'Kapha', 170),

    -- Q18
    ('BHC - Class 58 - Ayurveda',
     'In the chemical sensitivity case, what is the target total formula volume mentioned in the notes?',
     '2 ml dose', '5 ml dose', '10 ml dose', '15 ml dose',
     'b',
     'The personal notes state "adjust to 5 ml dose" when prioritising milk thistle 40–50 drops, yellow dock 50–60 drops, and SJW 60 drops.',
     'Focus on detox: prioritize milk thistle 40–50d, yellow dock 50–60d, SJW 60d; adjust to 5 ml dose',
     'Chemical Sensitivity', 180),

    -- Q19
    ('BHC - Class 58 - Ayurveda',
     'How are Red Clover and Dandelion root categorised in the chemical sensitivity notes?',
     'Nervine relaxants for mood', 'Bile-stimulating hepatic herbs', 'Adaptogens for stress', 'Anti-inflammatory herbs',
     'b',
     'Both Red Clover and Dandelion root (dan root) are listed under "stimulating bile" alongside burdock, milk thistle, yellow dock, and licorice in the chemical sensitivity protocol.',
     'Dandelion root (dan root) — bile-stimulating, hepatic; part of detox protocol for chemical sensitivity.',
     'Chemical Sensitivity', 190),

    -- Q20
    ('BHC - Class 58 - Ayurveda',
     'What pungent flavor quality is highlighted as therapeutic for Kapha, in addition to sour?',
     'Pungent is cooling and anti-inflammatory', 'Pungent is heating and expectorating', 'Pungent is bitter and liver-stimulating', 'Pungent is sweet and nourishing',
     'b',
     'The notes state that pungent flavor is heating and expectorating, making it especially indicated for Kapha''s cold, damp, congested nature.',
     'love juicing, spicy, raw; flavors are sour and pungent — sour liquifies mucus, pungent is heating and expectorating',
     'Kapha', 200),

    -- Q21
    ('BHC - Class 58 - Ayurveda',
     'What age and demographic factors are listed in the chemical sensitivity case study?',
     'Adult male, chronic exposure, 10 years', 'Eight-year-old cis female with chemical sensitivity, constipation, and depression', 'Elderly woman, multiple chemical intolerance, fibromyalgia', 'Teenage athlete with environmental illness',
     'b',
     'The case study explicitly identifies the client as an eight-year-old cis female with chemical sensitivity, constipation, and depression.',
     'Eucalyptus — example plant for chemical sensitivity formula; indicated actions include amphoteric, alterative, hepatic, nervine.',
     'Chemical Sensitivity', 210),

    -- Q22
    ('BHC - Class 58 - Ayurveda',
     'Which herb is noted as a Kapha-specific purgative/stimulating plant in addition to Schisandra?',
     'Lavender', 'Gentian', 'Ginsengs (as a category)', 'Licorice',
     'c',
     'The personal Kapha block mentions "stimulating (ginsengs)" alongside sour (schisandra) and expectorating/purgative plants as the herbal strategy for Kapha.',
     'Kapha plants: sour (schisandra) — for congestion, edema, fatigue, stagnancy; sour flavor liquifies mucus.',
     'Kapha', 220),

    -- Q23
    ('BHC - Class 58 - Ayurveda',
     'According to the dosage guidance for St. John''s Wort, what is the highest single-formula dose range mentioned?',
     '20–30 drops', '40–60 drops', '60–120 drops', '100–150 drops',
     'c',
     'The personal notes cite Tilgner/MM/MH references showing St. John''s Wort at 60–120 drops 3x/day as the uppermost range given.',
     'St John''s Wort: 20–30d 3×/day, 20–60d 4×/day, 60–120 3×/day',
     'Chemical Sensitivity', 230),

    -- Q24
    ('BHC - Class 58 - Ayurveda',
     'What is the prioritised drop dose for Milk Thistle in the chemical sensitivity formula focus?',
     '20–30 drops', '40–50 drops', '60–80 drops', '80–100 drops',
     'b',
     'The notes state "prioritize milk thistle 40–50d" when optimising the detox formula for chemical sensitivity.',
     'Milk Thistle — for complex accumulation with chemical exposure, long-term pharma use, alcohol exposure; prioritize 40–50 drops.',
     'Chemical Sensitivity', 240),

    -- Q25
    ('BHC - Class 58 - Ayurveda',
     'The chemical sensitivity formula addresses three main conditions simultaneously. What are they?',
     'Fatigue, insomnia, and poor immunity', 'Chemical sensitivity, constipation, and depression', 'Congestion, edema, and melancholy', 'Liver disease, anxiety, and bowel inflammation',
     'b',
     'The case study identifies chemical sensitivity, constipation, and depression as the three simultaneous conditions to address in the formula.',
     'Eucalyptus — example plant for chemical sensitivity formula; indicated actions include amphoteric, alterative, hepatic, nervine.',
     'Chemical Sensitivity', 250),

    -- Q26
    ('BHC - Class 58 - Ayurveda',
     'Which herb in the tea blend for chemical sensitivity is described as "warming and aromatic"?',
     'Sarsaparilla', 'Elder berry', 'Hawthorn berry', 'Cinnamon',
     'd',
     'Cinnamon is specifically noted as warming and aromatic in the tea blend for chemical sensitivity.',
     'Cinnamon — tea blend for chemical sensitivity case; warming, aromatic.',
     'Chemical Sensitivity', 260),

    -- Q27
    ('BHC - Class 58 - Ayurveda',
     'What does the notes guidance say about "ensuring therapeutic dose" in formulation?',
     'Always use the lowest possible dose to avoid side effects', 'Ensure therapeutic dose is achieved for all included herbs', 'Prioritise energetic intent over measurable physical dose', 'Divide total formula evenly across all herbs regardless of action',
     'b',
     'The formulation section stresses that therapeutic dose must be achieved for every herb included, noting the importance of amounts in formulation.',
     'Milk Thistle — detox, bile, bowel movement stimulant; dosage ranges 20–60 drops, focus on 40–60 drops.',
     'Chemical Sensitivity', 270),

    -- Q28
    ('BHC - Class 58 - Ayurveda',
     'In the chemical sensitivity notes, what distinguishes Milk Thistle''s generated notes dosage guidance from its personal notes guidance?',
     'Generated: 20–60 drops, focus 40–60; Personal: prioritize 40–50 drops', 'Generated: 50 drops only; Personal: 20–30 drops', 'Generated: 80–100 drops; Personal: 20–40 drops', 'There is no difference; both sources agree on 40 drops',
     'a',
     'The generated notes state "ranges 20–60 drops, focus on 40–60 drops" while the personal notes state "prioritize 40–50 drops," reflecting slightly different emphases from the two source files.',
     'Milk Thistle — detox, bile, bowel movement stimulant; dosage ranges 20–60 drops, focus on 40–60 drops.',
     'Chemical Sensitivity', 280),

    -- Q29
    ('BHC - Class 58 - Ayurveda',
     'Which condition is described in the Kapha block as a specific glandular disorder associated with this dosha?',
     'Hyperthyroidism (Graves'' disease)', 'Hashimoto''s thyroiditis / hypothyroid', 'Type 1 diabetes mellitus', 'Adrenal insufficiency',
     'b',
     'The personal Kapha notes specifically mention Hashimoto''s as an example hypoglandular disorder that Kapha individuals are prone toward.',
     'Kapha plants: sour (schisandra) — for congestion, edema, fatigue, stagnancy; sour flavor liquifies mucus.',
     'Kapha', 290),

    -- Q30
    ('BHC - Class 58 - Ayurveda',
     'Sarsaparilla appears in the chemical sensitivity notes in which specific context?',
     'As a bile-stimulating hepatic in the tincture formula', 'As part of the tea blend alongside chicory, cinnamon, hawthorn berry, and elder berry', 'As a purgative for bowel cleansing', 'As a Kapha-specific stimulating herb',
     'b',
     'Sarsaparilla is listed exclusively in the tea blend for the chemical sensitivity case, alongside chicory, cinnamon, haw berry, and elder berry.',
     'Sarsaparilla — tea blend for chemical sensitivity case.',
     'Chemical Sensitivity', 300)

    ;
END $$;
