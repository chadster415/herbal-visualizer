-- Migration 236: Class 50 — Respiratory IV and Supplements quiz questions
-- Source: supabase/migrations/228_class_50_respiratory_iv_and_supplements_data.sql
SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions
             WHERE class_name = 'BHC - Class 50 - Respiratory IV and Supplements') THEN
    RAISE NOTICE 'Class 50 quiz questions already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

    -- Q1: Infusion technique (type: what is the purpose)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Why are long-chain mucopolysaccharides important in cold infusions, and what happens to them with heat?',
     'They provide astringency and are enhanced by heat',
     'They feed mucus membranes and are destroyed by heat',
     'They provide demulcent action and survive heat',
     'They extract minerals and are concentrated by heat',
     'b',
     'Long-chain mucopolysaccharides nourish mucus membranes but are destroyed by heat; cold infusion is required to preserve them. The demulcent action itself survives heat.',
     'Gotu Kola — cold (suspended) infusion for skin; long-chain mucopolysaccharides that feed mucus membranes are destroyed by heat — demulcent action survives heat, but full mucous-membrane nourishment requires cold infusion.',
     'Infusion Techniques', 10),

    -- Q2: Infusion technique (which herb)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which herb is specifically noted as suitable for extended infusion to pull minerals — unlike Astragalus?',
     'Burdock',
     'Calendula',
     'Yellow Dock',
     'Red Root',
     'c',
     'Yellow Dock (Rumex) benefits from extended infusion for mineral extraction. Astragalus does NOT benefit from extended infusion in the same way.',
     'Yellow Dock — suitable for extended infusion to pull minerals; 4 hours ≈ 2 hours for most constituents. Contrast: Astragalus does NOT benefit from extended infusion for mineral extraction.',
     'Infusion Techniques', 20),

    -- Q3: Formula composition (which herb is anchor)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'In the chronic-pain lymph formula, which herb is the anchor herb and takes the largest portion at 22 ml (11 parts)?',
     'Red Root (Ceanothus)',
     'Yellow Dock',
     'Calendula',
     'Burdock (Arctium)',
     'd',
     'Burdock is the alterative anchor herb at 22 ml (11 parts) — the largest portion in the 60 ml formula for a 150 lb chronic patient with weakened vitality.',
     'Burdock (Arctium) — alterative; anchor herb in chronic-pain lymph formula; 22 ml (11 parts) out of 60 ml; dose middle of MM range (60 drops) for 150 lb chronic patient with weakened vitality.',
     'Therapeutic Dosing', 30),

    -- Q4: Formula composition (why Calendula over Red Root)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Why was Calendula chosen as the lymphatic in the chronic-pain formula instead of Red Root (Ceanothus)?',
     'Calendula has a broader Michael Moore dosing range',
     'Calendula is more nourishing and moistening to tissues',
     'Red Root causes excess lymphatic stimulation at higher doses',
     'Calendula has stronger antispasmodic properties',
     'b',
     'Calendula was chosen over Red Root because it is more nourishing and moistening to tissues — important for this patient''s constitution.',
     'Calendula — chosen as the lymphatic in this formula over Red Root because more nourishing and moistening to tissues; 4 ml (2 parts); lower MM dose (15 drops) for this patient.',
     'Therapeutic Dosing', 40),

    -- Q5: Dosing (Red Root drying quality)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Why was Red Root (Ceanothus) dosed at 50 drops rather than 60 drops in the formula?',
     'It has a narrow therapeutic window',
     'It is contraindicated at higher doses with Pulsatilla',
     'It has a drying quality',
     'It would overwhelm the alterative herbs',
     'c',
     'Red Root''s drying quality was the reason for choosing 50 drops rather than the 60-drop midpoint — the drying nature warranted restraint.',
     'Red Root (Ceanothus) — powerful lymphatic but drying; chose 50 drops not 60 because of drying quality; 16 ml (8 parts); MM range 30-90 drops; Tilgner range 20-40 drops.',
     'Therapeutic Dosing', 50),

    -- Q6: Dosing (Pulsatilla dose range)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What is the Michael Moore dose range for Pulsatilla (Anemone) in the chronic-pain formula?',
     '10–30 drops 4x/day',
     '3–10 drops 4x/day',
     '5–20 drops 3x/day',
     '30–60 drops 3x/day',
     'b',
     'Michael Moore''s range for Pulsatilla is 3–10 drops 4x/day — one of the lowest dose herbs in the formula at 2 ml (1 part), 5 drops rounded down.',
     'Pulsatilla (Anemone) — 2 ml (1 part), 5 drops rounded down; MM range 3-10 drops 4x/day; use at the low end; David Hoffmann range 30-60 drops.',
     'Therapeutic Dosing', 60),

    -- Q7: Respiratory case study (Yerba Mansa)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'In the asthma case study, what is Yerba Mansa''s primary role?',
     'Dilating airways during acute attack',
     'Interrupting the panic-asthma feedback cycle',
     'Acute respiratory and chronic mucus membrane support',
     'Addressing the feedback loop of coughing causing spasm',
     'c',
     'Yerba Mansa was chosen for acute respiratory support and always thinking about mucus membrane support chronically — not just the acute phase.',
     'Yerba Mansa — acute respiratory; always thinking about mucus membrane support for chronic respiratory cases; indicated for this asthma/spasmodic cough patient.',
     'Respiratory Case Study', 70),

    -- Q8: Respiratory case study (Angelica)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Why was Angelica included in the asthma tincture formula?',
     'It is specific for the panic-asthma feedback cycle',
     'It dilates airways acutely',
     'It addresses the cough-spasm feedback loop',
     'It nourishes and moistens respiratory membranes',
     'c',
     'Angelica targets spasmodic cough and the feedback loop where coughing triggers more bronchial spasm.',
     'Angelica — spasmodic cough; addresses the feedback loop where coughing triggers more bronchial spasm; used in this asthma case study tincture.',
     'Respiratory Case Study', 80),

    -- Q9: Respiratory case study (Passionflower)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What makes Passionflower "specific" for this asthma patient''s presentation?',
     'It thins mucus secretions',
     'It calms the panic-asthma feedback cycle as a nervine',
     'It is a bronchodilator at high doses',
     'It provides anti-inflammatory support to airways',
     'b',
     'Passionflower is specific for this asthma picture because it interrupts the panic-asthma feedback cycle as a calming nervine.',
     'Passionflower — specific for this asthma picture; calming nervine that interrupts the panic-asthma feedback cycle; included in the base tincture.',
     'Respiratory Case Study', 90),

    -- Q10: Respiratory case study (Lobelia dosing)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'How should Lobelia be dosed in the asthma case study — at maintenance versus during an acute attack?',
     'Equal doses at all times; adjust by body weight only',
     '5 drops maintenance; near full cap for acute attack',
     '15 drops maintenance; 30 drops for acute attack',
     'Only use during acute attacks; discontinue between episodes',
     'b',
     'Lobelia is given at 5 drops low dose for maintenance and near full cap for an acute attack — kept as a simple tincture separate from the base formula.',
     'Lobelia — simple tincture (separate from the base formula); dilates airway; low dose 5 drops; near full cap for acute attack; maintenance dose paired with full formula for ongoing support.',
     'Respiratory Case Study', 100),

    -- Q11: Respiratory case study (repair tea)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which three herbs make up the nourishing repair tea for the chronic respiratory case?',
     'Yerba Mansa, Angelica, Lobelia',
     'Calendula, Plantain, Passionflower',
     'Horsetail, Calendula, Plantain',
     'Horsetail, Yerba Mansa, Calendula',
     'c',
     'The repair tea blend is Horsetail, Calendula, and Plantain — focused on nourishing, moistening, and chronic membrane repair for the asthma patient.',
     'Horsetail — repair tea blend (with Calendula and Plantain) for the chronic nourishing/moistening dimension of this respiratory case; supports membrane integrity.',
     'Respiratory Case Study', 110),

    -- Q12: Supplements intro (CoQ10 + statins)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which nutrient is depleted by statin drugs and must be supplemented for anyone on a statin?',
     'Vitamin D',
     'Magnesium',
     'CoQ10',
     'Vitamin B12',
     'c',
     'Statins deplete CoQ10 — it is essential to supplement for anyone on a statin. CoQ10 is oil-soluble and should be taken with breakfast once per day.',
     'CoQ10 — depleted by statin drugs; essential to supplement for anyone on a statin. Oil-soluble; take with breakfast once per day.',
     'Pharmaceutical Nutrient Depletion', 120),

    -- Q13: Vitamins (fat-soluble group)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which group of vitamins must be taken with food because they are fat-soluble?',
     'A, C, E, K',
     'B complex, C',
     'A, D, E, K',
     'A, B12, D, K',
     'c',
     'Fat-soluble vitamins A, D, E, and K require food for proper absorption. Water-soluble vitamins (B complex, C) do not require food.',
     'Fat-soluble: A, D, E, K (take with food)\nWater-soluble: B complex, C (no food required)',
     'Vitamins', 130),

    -- Q14: Vitamins (B1 GABA connection)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Vitamin B1 (Thiamine) is required for the production of which neurotransmitters?',
     'Serotonin and dopamine',
     'Epinephrine and norepinephrine',
     'GABA and acetylcholine',
     'Glutamate and glycine',
     'c',
     'Vitamin B1 is required for GABA and acetylcholine production; it is depleted by alcoholism and may modestly lower blood pressure in elevated blood sugar.',
     'Vitamin B1 (Thiamine) — required for GABA and acetylcholine production; depleted by alcoholism; modestly lowers blood pressure in elevated blood sugar; may relieve PMS. Dose: 15–30 mg/day.',
     'Vitamins', 140),

    -- Q15: Vitamins (B6 depletion causes)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which of the following depletes Vitamin B6 (Pyridoxine)?',
     'Antacids and proton pump inhibitors',
     'Smoking, corticosteroids, diuretics, and contraceptives',
     'Statins and ADHD medications',
     'Metformin and alcohol',
     'b',
     'Vitamin B6 is depleted by smoking, corticosteroids, diuretics, and contraceptives. Its deficiency causes eczema, anemia, and fatigue.',
     'Vitamin B6 (Pyridoxine) — stimulates glycogen release from liver and muscles; component of myelin sheath; deficiency causes eczema, anemia, fatigue. Depleted by smoking, corticosteroids, diuretics, contraceptives. Dose: 35–50 mg/day.',
     'Vitamins', 150),

    -- Q16: Vitamins (B9 MTHFR)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'For a patient with an MTHFR mutation who needs folate supplementation, what form should be used?',
     'Folic acid (standard B9)',
     'Folinic acid',
     'Methylfolate',
     'Cyanocobalamin',
     'c',
     'The MTHFR mutation impairs folic acid conversion, so methylfolate (active form) must be used instead of standard folic acid.',
     'Vitamin B9 (Folic Acid) — red blood cells, DNA synthesis, fertility. MTHFR mutation: use methylfolate. Deficiency: emotional instability, diarrhea, anemia, tongue swelling. Metformin and alcohol reduce folate. Dose: 400 mcg–1 mg/day.',
     'Vitamins', 160),

    -- Q17: Vitamins (B12 and vegan diet)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which patient populations are most at risk for Vitamin B12 deficiency?',
     'Those on corticosteroids or diuretics',
     'Those with ADHD or cardiovascular disease',
     'Those following a vegan diet or with PCOS',
     'Those with irritable bowel or leaky gut',
     'c',
     'B12 deficiency is common with vegan diets (no animal products) and PCOS. Deficiency causes depression, impaired memory, fatigue, and nervous system damage.',
     'Vitamin B12 — cellular metabolism, nervous system function, DNA synthesis, blood production; deficiency common with vegan diet and PCOS. Deficiency causes depression, impaired memory, fatigue, brain and nervous system damage. Dose: 200–500 mcg/day.',
     'Vitamins', 170),

    -- Q18: Minerals (chromium mechanism)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What is Chromium''s mechanism of action related to blood sugar regulation?',
     'It stimulates insulin secretion from the pancreas',
     'It allows insulin to bind cellular receptors ("key and lock for glucose into the cell")',
     'It converts stored glycogen into blood glucose',
     'It blocks glucagon receptor activity',
     'b',
     'Chromium''s key function is enabling insulin to bind cellular receptors — described as a "key and lock for glucose into the cell" — making it essential for insulin resistance.',
     'Chromium — essential trace element; allows insulin to bind cellular receptors ("key and lock for glucose into the cell"); key for insulin resistance. Inhibited by antacids, PPIs, achlorhydria. Dose: 100–400 mcg/day.',
     'Minerals', 180),

    -- Q19: Minerals (iodine function)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What is iodine''s only known function in the body?',
     'Bone mineralization and calcium metabolism',
     'Antioxidant protection of cell membranes',
     'Thyroid gland uses it with tyrosine to make T3 and T4',
     'Nerve transmission and electrolyte balance',
     'c',
     'Iodine''s only function is thyroid hormone synthesis — the thyroid uses iodine together with tyrosine to produce T3 and T4.',
     'Iodine — only function in the body: thyroid gland uses it with tyrosine to make T3 and T4. Antagonists: raw brassicas, unfermented soy, fluorine, bromine, chlorine (explains deficiency despite iodized salt). Dose: 150 mcg/day.',
     'Minerals', 190),

    -- Q20: Minerals (selenium and thyroid)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What role does selenium play in thyroid hormone metabolism?',
     'It synthesizes thyroid-binding globulin',
     'It converts T4 (storage form) to T3 (active form)',
     'It is required for iodine uptake into the thyroid gland',
     'It inhibits excess TSH production from the pituitary',
     'b',
     'Selenium converts T4 (inactive storage form) to T3 (active form). It is also linked to reduced cardiovascular disease risk and may help Grave''s disease bulging eyes.',
     'Selenium — converts T4 (storage form) to T3 (active form); linked to reduced cardiovascular disease risk; may help bulging eyes in Grave''s disease. Best source: Brazil nuts. Dose: 100–200 mcg/day.',
     'Minerals', 200),

    -- Q21: Minerals (lithium and bipolar)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which herb should be avoided in patients with bipolar disorder, and what supplement is used for weaning off pharmaceutical lithium?',
     'Valerian avoided; magnesium glycinate for weaning',
     'Passionflower avoided; lithium carbonate for weaning',
     'Albizia (mimosa bark/flower) avoided; lithium orotate for weaning',
     'St. John''s Wort avoided; lithium citrate for weaning',
     'c',
     'Albizia (mimosa bark or flower) should be avoided in bipolar patients. Lithium orotate is the supplement form used for people weaning off pharmaceutical lithium.',
     'Lithium orotate — supplement form for people weaning off pharmaceutical lithium (bipolar disorder). Avoid giving Albizia (mimosa bark or flower) to people with bipolar. Managing chronic inflammation with nervines and adaptogens for bipolar. Dose: 10–20 mg/day.',
     'Minerals', 210),

    -- Q22: Minerals (magnesium absorption form)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Which form of magnesium has the highest absorption, and which form is more laxative?',
     'Citrate = highest absorption; oxide = more laxative',
     'Biglycinate = highest absorption; citrate = more laxative',
     'Oxide = highest absorption; malate = more laxative',
     'Threonate = highest absorption; carbonate = more laxative',
     'b',
     'Magnesium biglycinate has the highest absorption; magnesium citrate is more laxative. Magnesium is often deficient and essential for blood sugar regulation, muscle function, and neuroprotection.',
     'Magnesium — often deficient; essential for blood sugar regulation, metabolism, muscle function, intestinal motility, neuroprotection. Biglycinate = highest absorption; citrate = more laxative. Deficiency from IBD, kidney disease, diabetes, alcoholism, antibiotics. Dose: 400–600 mg/day.',
     'Minerals', 220),

    -- Q23: Amino acids (5-HTP safety)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Why must 5-HTP be avoided with SSRIs?',
     'It competitively inhibits SSRI metabolism in the liver',
     'It causes serotonin syndrome risk',
     'It depletes dopamine when combined with SSRIs',
     'It raises prolactin and can worsen SSRI side effects',
     'b',
     '5-HTP is a serotonin and melatonin precursor; combining it with SSRIs risks serotonin syndrome. It is indicated for panic disorder, chronic headaches, fibromyalgia, and IBS.',
     '5-HTP — serotonin and melatonin precursor; tryptophan converts to 5-HTP with B6 help; indicated for panic disorder, chronic headaches, fibromyalgia, IBS; avoid with SSRIs (serotonin syndrome risk). Dose: 50–400 mg/day.',
     'Amino Acids and Other Supplements', 230),

    -- Q24: Amino acids (NAC for COPD)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'NAC (N-Acetyl-Cysteine) is particularly indicated for which respiratory condition, and what is its primary mechanism?',
     'Asthma; it dilates bronchioles',
     'COPD and bronchitis; it thins mucus for expectoration',
     'Pneumonia; it reduces fever and inflammation',
     'Pleurisy; it reduces pleural fluid accumulation',
     'b',
     'NAC thins mucus for easier expectoration in COPD, bronchitis, and pneumonia. It is also used IV in orthodox medicine for acetaminophen overdose.',
     'NAC (N-Acetyl-Cysteine) — thins mucus for easier expectoration in COPD, bronchitis, and pneumonia; also helpful for PCOS/insulin resistance. Used IV in orthodox medicine for acetaminophen overdose. Dose: 200–600 mg/day.',
     'Amino Acids and Other Supplements', 240),

    -- Q25: Amino acids (L-Glutamine)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What is L-Glutamine''s primary therapeutic application, and what should be paired with it for best results?',
     'Joint repair; pair with glucosamine and chondroitin',
     'Gut mucosa healing and tight junctions; pair with gut-healing herbs and dietary changes',
     'Muscle building; pair with L-Carnitine for fat metabolism',
     'Dopamine support; pair with mucuna and B6',
     'b',
     'L-Glutamine heals gut mucosa and promotes tight junctions for IBS and leaky gut. It works best when paired with gut-healing herbs, infusions, and removal of irritating foods.',
     'L-Glutamine — heals gut mucosa and promotes tight junctions; for IBS and leaky gut; pair with gut-healing herbs, infusions, and removing irritating foods from diet. Dose: 500–1,000 mg TID.',
     'Amino Acids and Other Supplements', 250),

    -- Q26: Amino acids (L-Theanine)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What is the origin of L-Theanine and what is its characteristic action?',
     'Derived from valerian root; promotes deep sleep without grogginess',
     'Synthesized from tryptophan; relieves fibromyalgia pain',
     'Originally isolated from green tea; promotes calm relaxation without sedation',
     'Extracted from mushrooms; enhances dopamine and motivation',
     'c',
     'L-Theanine is a non-protein amino acid originally isolated from green tea. It promotes calm relaxation without sedation and counterbalances caffeine.',
     'L-Theanine — non-protein amino acid originally isolated from green tea; promotes calm relaxation without sedation; counterbalances caffeine. Dose: 200 mg, 2–3x/day.',
     'Amino Acids and Other Supplements', 260),

    -- Q27: Amino acids (SAMe caution)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'SAMe is useful for seasonal affective disorder but carries an important caution — what is it?',
     'Avoid with kidney disease due to methionine accumulation',
     'Avoid with bipolar disorder due to mania risk',
     'Avoid with thyroid conditions due to iodine interactions',
     'Avoid with pregnancy due to methylation effects on fetal DNA',
     'b',
     'SAMe must be avoided in bipolar disorder because it can trigger mania. It helps produce serotonin, dopamine, and melatonin and should be taken on an empty stomach in the AM.',
     'SAMe — useful for seasonal affective disorder; helps produce serotonin, dopamine, and melatonin; take 400–1,200 mg on empty stomach in AM; expensive; avoid with bipolar disorder due to mania risk.',
     'Amino Acids and Other Supplements', 270),

    -- Q28: Proteolytic enzymes (strength ranking)
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What is the correct order of proteolytic enzyme strength from weakest to strongest?',
     'Nattokinase < Serrapeptase < Lumbrokinase',
     'Lumbrokinase < Nattokinase < Serrapeptase',
     'Serrapeptase < Lumbrokinase < Nattokinase',
     'Serrapeptase < Nattokinase < Lumbrokinase',
     'd',
     'The order from weakest to strongest is serrapeptase < nattokinase < lumbrokinase. Lumbrokinase is 300× stronger than serrapeptase and is particularly effective for Lyme disease.',
     'Proteolytic Enzymes — Serrapeptase, Nattokinase, Lumbrokinase; dissolve scar tissue and plaque that don''t serve a healthy purpose. Strength: serrapeptase < nattokinase < lumbrokinase (Lumbrokinase 300× stronger than serrapeptase). Lumbrokinase: phenomenal for Lyme disease. Nattokinase: cardiovascular plaque, Mono that won''t budge. Take on empty stomach.',
     'Amino Acids and Other Supplements', 280),

    -- Q29: Inositol and PCOS
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'What effect does Inositol have in PCOS?',
     'It raises FSH and supports ovulation induction',
     'It lowers estrogen by competing with estrogen receptors',
     'It lowers insulin and testosterone in PCOS',
     'It reduces prolactin-related cycle disruption',
     'c',
     'Inositol lowers insulin and testosterone in PCOS. It supports fat/cholesterol metabolism, cell membrane integrity, serotonin utilization, and insulin signaling.',
     'Inositol — produced by kidneys from glucose (not a vitamin); fat/cholesterol metabolism, cell membrane integrity, serotonin utilization, insulin signaling; lowers insulin and testosterone in PCOS. Powder form recommended. Dose: 2–10 g/day (myo-inositol).',
     'Amino Acids and Other Supplements', 290),

    -- Q30: Glucosamine caution
    ('BHC - Class 50 - Respiratory IV and Supplements',
     'Glucosamine Sulfate is derived from shellfish exoskeletons and is used for arthritis — what caution applies?',
     'Caution with kidney disease — it accumulates in renal tissue',
     'Caution with shellfish allergy',
     'Caution with blood thinners — it increases clotting risk',
     'Caution with thyroid disease — it affects iodine metabolism',
     'b',
     'Glucosamine Sulfate is derived from shellfish exoskeletons, so patients with shellfish allergy should use caution. It is used with chondroitin for arthritis of hips, spine, and wrists.',
     'Glucosamine Sulfate — derived from shellfish exoskeletons; used with chondroitin for arthritis of hips, spine, and wrists; can reduce rheumatoid arthritis symptoms; caution with shellfish allergy. Dose: 1,500 mg/day.',
     'Amino Acids and Other Supplements', 300)
    ;
END $$;
