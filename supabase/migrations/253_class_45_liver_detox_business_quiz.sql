-- Migration 253: BHC Class 45 quiz — Liver Detox Pathways and Starting an Herbal Business
-- class_name: 'BHC - Class 45 - Liver Detox Pathways and Starting an Herbal Business'
-- 30 questions; guard by class_name

SET search_path TO herbal, public;

DO $$
DECLARE
  v_class CONSTANT TEXT := 'BHC - Class 45 - Liver Detox Pathways and Starting an Herbal Business';

  v_sn_dandelion_liver TEXT;
  v_sn_burdock_liver   TEXT;
  v_sn_astragalus      TEXT;
  v_sn_licorice_liver  TEXT;
  v_sn_milk_thistle_mm TEXT;
  v_sn_schizandra      TEXT;
  v_sn_ogr_mm          TEXT;
  v_sn_turmeric_mm     TEXT;
  v_sn_licorice_mm     TEXT;
  v_sn_fennel_mafld    TEXT;
  v_sn_licorice_hrm    TEXT;
  v_sn_mafld_ogr       TEXT;
  v_sn_b2_detox        TEXT;
  v_sn_methionine      TEXT;
  v_sn_b_cpx           TEXT;
  v_sn_milk_treat      TEXT;
  v_sn_sleepy_horsey   TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_quiz_questions WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 45 quiz already loaded, skipping';
    RETURN;
  END IF;

  -- ── Snippet text anchors (verbatim from migration 252) ──────────────────────

  v_sn_dandelion_liver :=
    'Liver tea formula (2P Burdock, 2P Astragalus, 1P Dandelion, 1P Orange Peel, 1P Fennel, '
    '1P Licorice). Dandelion root: nourishing hepatoprotective. Spec ind: jaundice, pain in '
    'the gallbladder, digestive disturbance, headache due to liver issues (forehead), tenderness '
    'in liver, coated tongue.';

  v_sn_burdock_liver :=
    'Liver tea formula (2P Burdock, 2P Astragalus, 1P Dandelion, 1P Orange Peel, 1P Fennel, '
    '1P Licorice). Burdock root: nourishing, safe for liver; cholagogue (bile stim); gallstones '
    'and biliary disease; optimizes toxin elimination and fat-soluble vitamin absorption; helps '
    'with fatty liver disease. Spec ind: hyperlipidemia, chronic acne/skin disorders, fatigue '
    'and malaise.';

  v_sn_astragalus :=
    'Liver tea formula (2P Burdock, 2P Astragalus, 1P Dandelion, 1P Orange Peel, 1P Fennel, '
    '1P Licorice). Astragalus: nourishing supporting hepatoprotective plant.';

  v_sn_licorice_liver :=
    'Licorice (liver tea formula): supports metabolism — for person who has started to '
    'accumulate adipose tissue without change in activity; adaptogen; harmonizer.';

  v_sn_milk_thistle_mm :=
    'Milk Thistle (Silybum marianum), seed. Dose: FE 20-40 drops 5x/day; Tinc 1/2-1tsp '
    '4x/day (avoid alcohol prep with active liver disease); Capsules 600mg/day to 80% '
    'silymarin; acute mushroom poisoning 5g/day. Actions: hepatoprotective, galactagogue, '
    'anti-hepatotoxic, antisclerotic; restores liver from toxins/acetaminophen; protects '
    'kidneys; supports during/after chemo; corrects bilirubin levels; "anabolic cooler" '
    'for metabolic fat/protein dysregulation.';

  v_sn_schizandra :=
    'Schizandra: antioxidant, hepatoprotective; key herb supporting liver detoxification pathways.';

  v_sn_ogr_mm :=
    'Oregon Grape Root (Berberis aquifolium). Fresh 1:2 80-95%, dry 1:5 50%. Actions: '
    'cholagogue, bitter (upper GI), broad antimicrobial (gram neg: E. coli/Salmonella; '
    'gram pos: Strep/Staph). Spec ind: liver congestion and low bile, infectious hepatitis '
    '(Hep A), food poisoning, liver tenderness with slow digestion, skin eruptions (boils, '
    'acne) with coated tongue, SIBO/candida (penetrates biofilms), anti-protozoal, '
    'potentiates antibiotics (MRSA).';

  v_sn_turmeric_mm :=
    'Turmeric (Curcuma longa), rhizome. Dose: capsules 500mg 2-4x/day; golden milk 1-2 tsp '
    '5x/day; enhance absorption with black pepper and fat. Actions: antioxidant, antilipidemic, '
    'cholagogue; cancer care (cell signaling, apoptosis); promotes Phase 2 detox; preventative '
    'with acetaminophen; protects from hepatitis damage; improves liver enzymes; hormone '
    'clearance; good for gallstones and biliary pain.';

  v_sn_licorice_mm :=
    'Licorice (Glycyrrhiza glabra), dried root. Dose: decoction 1 tsp root : 1 cup water; '
    'Tinc/FE 10-20 drops 3x/day. Caution: may aggravate BP with potassium imbalance. Actions: '
    'adapts cortisol regulation (hypo or hyper), improves insulin resistance, maintains HPA '
    'axis communication, general exhaustion and debility, immune modulator, adrenal '
    'insufficiency from aging.';

  v_sn_fennel_mafld :=
    'Fennel essential oil: applied topically directly on the liver, especially with tenderness, '
    'for metabolic-associated fatty liver disease.';

  v_sn_licorice_hrm := v_sn_licorice_liver;  -- same source for harmonizer/adaptogen question

  v_sn_mafld_ogr :=
    'Oregon Grape Root (OGR, berberine): go-to for metabolic-associated fatty liver disease '
    'alongside turmeric and liver tea herbs.';

  v_sn_b2_detox :=
    'Vitamin B2 (Riboflavin): required for Phase I liver detoxification, which converts '
    'fat-soluble toxins to water-soluble via cytochrome P450 and requires B2, B3, B6, B12, '
    'folic acid, glutathione, and flavonoids.';

  v_sn_methionine :=
    'Methionine: required for Phase II liver detoxification (sulfation, glutathione conjugation, '
    'methylation); Phase II requires methionine, cysteine, magnesium, vitamin C, glycine, '
    'and taurine.';

  v_sn_b_cpx :=
    'Methylated B vitamins ("Methyl Pro"): jumpstart the liver process and support Phase 1 '
    'detox; especially indicated for chronic chemical exposure, past medicine or drug use, '
    'alcohol.';

  v_sn_milk_treat :=
    'Choice between dandelion tea and milk thistle extract based on history of chronic toxin '
    'exposure — milk thistle extract for more serious or chronic cases.';

  v_sn_sleepy_horsey :=
    'Chamomile: ingredient in "Sleepy Horsey" tea (chamomile, tulsi, lavender, horsetail); '
    'supports calm and clear mind; promotes tranquilizing sleep.';

  -- ── 30 Questions ────────────────────────────────────────────────────────────

  INSERT INTO herbal.class_quiz_questions
    (class_name, question_text, option_a, option_b, option_c, option_d,
     correct_option, explanation, snippet_text, section_header, sort_order)
  VALUES

  -- Q1 (correct: a)
  (v_class,
   'Which head pain pattern is listed as a specific indication for Dandelion root linked to liver dysfunction?',
   'Forehead headache',
   'Base of skull headache',
   'Temporal / side of head headache',
   'Migraine with visual aura',
   'a',
   'The notes distinguish forehead headache as the liver-linked pattern, explicitly contrasting it with base of skull (muscle tension) and side of head (dehydration).',
   v_sn_dandelion_liver,
   'Liver', 10),

  -- Q2 (correct: b)
  (v_class,
   'In the liver support tea formula, what is the ratio of Burdock to Dandelion by parts?',
   'Equal parts (1:1)',
   '2:1 — Burdock is double the Dandelion',
   '3:1 — three times more Burdock',
   '1:2 — Dandelion is double Burdock',
   'b',
   'The formula is 2P Burdock and 1P Dandelion (2:1); Astragalus also appears at 2 parts while Orange Peel, Fennel, and Licorice are each 1 part.',
   v_sn_burdock_liver,
   'Liver', 20),

  -- Q3 (correct: d)
  (v_class,
   'Which combination of specific indications for Burdock root is listed in these class notes?',
   'Insomnia, joint pain, amenorrhea',
   'Hypothyroidism, PCOS, heavy bleeding',
   'Hypertension, anxiety, edema',
   'Hyperlipidemia, chronic acne/skin disorders, fatigue and malaise',
   'd',
   'The personal notes specifically list hyperlipidemia, chronic acne, skin disorders, hives from contact allergy, and fatigue and malaise as specific indications for Burdock root.',
   v_sn_burdock_liver,
   'Liver', 30),

  -- Q4 (correct: c)
  (v_class,
   'Oregon Grape Root is specifically noted as a go-to herb for which type of hepatitis?',
   'Hepatitis B',
   'Hepatitis C',
   'Infectious hepatitis (Hep A / travellers)',
   'Autoimmune hepatitis',
   'c',
   'The notes say OGR is specific for "infectious hepatitis — travellers (Hep A)"; it is not singled out for Hep B, C, or autoimmune forms.',
   v_sn_ogr_mm,
   'Oregon Grape Root', 40),

  -- Q5 (correct: c)
  (v_class,
   'What is the standard daily capsule dose of Milk Thistle for liver support?',
   '200 mg/day',
   '400 mg/day',
   '600 mg/day standardized to 80% silymarin',
   '1,000 mg/day',
   'c',
   '600 mg/day standardized to 80% silymarin is the primary capsule dose; 400 mg with each meal is a secondary option mentioned in the notes.',
   v_sn_milk_thistle_mm,
   'Milk Thistle', 50),

  -- Q6 (correct: a)
  (v_class,
   'Oregon Grape Root''s ability to penetrate biofilms makes it specifically useful for which conditions?',
   'SIBO and entrenched fungal or candida gut infections',
   'Hepatitis B and C viral infections',
   'Urinary tract infections and kidney stones',
   'Rheumatoid arthritis and fibromyalgia',
   'a',
   'The notes state that OGR "can penetrate biofilms: entrenched fungal infection or SIBO (candida in the gut)" — this is the biofilm mechanism.',
   v_sn_ogr_mm,
   'Oregon Grape Root', 60),

  -- Q7 (correct: b)
  (v_class,
   'Which vitamins are required for Phase I liver detoxification according to the class notes?',
   'Vitamins A, D, E, and K (fat-soluble)',
   'Vitamins B2, B3, B6, B12, and folic acid',
   'Vitamin C, magnesium, and methionine',
   'Zinc, selenium, and alpha lipoic acid',
   'b',
   'Phase I uses cytochrome P450 and requires the B vitamins (B2, B3, B6, B12) and folic acid; Vitamin C, magnesium, and methionine belong to Phase II.',
   v_sn_b2_detox,
   'Liver Detoxification Pathways', 70),

  -- Q8 (correct: d)
  (v_class,
   'What is the recommended Licorice tincture or fluid extract dose from the personal notes?',
   '20–40 drops 5x/day',
   '1/2–1 tsp 4x/day',
   '30–60 drops 4x/day',
   '10–20 drops 3x/day',
   'd',
   'Licorice Tinc/FE is 10–20 drops 3x/day; the 20–40 drops 5x/day dose is Milk Thistle FE, and 1/2–1 tsp 4x/day is the Milk Thistle tincture dose.',
   v_sn_licorice_mm,
   'Licorice', 80),

  -- Q9 (correct: a)
  (v_class,
   'Which herb is described in the notes as an "anabolic cooler" for metabolic fat and protein dysregulation?',
   'Milk Thistle',
   'Burdock',
   'Turmeric',
   'Licorice',
   'a',
   'The notes describe Milk Thistle as the "anabolic cooler — calms inability to metabolize fats and proteins," making it useful when patients put on weight without dietary changes.',
   v_sn_milk_thistle_mm,
   'Milk Thistle', 90),

  -- Q10 (correct: b)
  (v_class,
   'Turmeric absorption is enhanced by which two additions?',
   'Vitamin C and alkaline water',
   'Black pepper and fat',
   'Ginger and honey',
   'Lemon juice and omega-3 oil',
   'b',
   'The notes specify "enhance absorption with black pepper and some kind of fat" — piperine in black pepper and a fat carrier significantly improve curcumin bioavailability.',
   v_sn_turmeric_mm,
   'Turmeric', 100),

  -- Q11 (correct: d)
  (v_class,
   'Which nutrient is required for Phase II liver detox processes including sulfation, glutathione conjugation, and methylation?',
   'Vitamin A',
   'Vitamin D',
   'Vitamin B12',
   'Methionine',
   'd',
   'Methionine is a sulfur-containing amino acid essential for all three Phase II processes named; B12 participates in methylation but is a Phase I nutrient in these notes.',
   v_sn_methionine,
   'Liver Detoxification Pathways', 110),

  -- Q12 (correct: c)
  (v_class,
   'Schizandra is described in these notes as serving which two primary liver actions?',
   'Cholagogue and diuretic',
   'Adaptogen and sedative',
   'Antioxidant and hepatoprotective',
   'Alterative and anti-inflammatory',
   'c',
   'Both the generated and personal notes consistently describe Schizandra as "antioxidant, hepatoprotective" for liver detox support.',
   v_sn_schizandra,
   'Liver Detoxification Pathways', 120),

  -- Q13 (correct: b)
  (v_class,
   'What are the menstruum ratios for Oregon Grape Root fresh vs dry preparations?',
   'Fresh 1:3 60%, dry 1:4 40%',
   'Fresh 1:2 80–95%, dry 1:5 50%',
   'Fresh 1:1 95%, dry 1:3 60%',
   'Same ratio for fresh and dry (1:4)',
   'b',
   'OGR fresh root: 1:2 at 80–95% alcohol; dry root: 1:5 at 50% alcohol — higher alcohol is used for the fresh root to account for its water content.',
   v_sn_ogr_mm,
   'Oregon Grape Root', 130),

  -- Q14 (correct: a)
  (v_class,
   'Dandelion root is specifically indicated for coated tongue as a sign of which underlying condition?',
   'Liver congestion',
   'SIBO or gut dysbiosis',
   'Kidney insufficiency',
   'Spleen qi deficiency',
   'a',
   'Coated tongue appears alongside tenderness in liver and slow digestion in the notes, pointing to liver congestion — not primarily a gut microbiome issue.',
   v_sn_dandelion_liver,
   'Liver', 140),

  -- Q15 (correct: c)
  (v_class,
   'Which herb is described as "specific for liver congestion and low bile" in these class notes?',
   'Dandelion root',
   'Milk Thistle',
   'Oregon Grape Root',
   'Schizandra',
   'c',
   'Oregon Grape Root is specifically noted for "liver congestion and low bile" alongside its cholagogue and antimicrobial actions.',
   v_sn_ogr_mm,
   'Oregon Grape Root', 150),

  -- Q16 (correct: b)
  (v_class,
   'According to the personal notes, Turmeric specifically protects from liver damage caused by which dietary factor?',
   'Excessive dietary fiber',
   'High fat diets',
   'Alcohol consumption',
   'Artificial sweeteners',
   'b',
   'The notes say Turmeric "protects from hepatitis damage" including from "high fat diets" — it is listed as a protection against diet-induced hepatic damage.',
   v_sn_turmeric_mm,
   'Turmeric', 160),

  -- Q17 (correct: b)
  (v_class,
   'What is the recommended Fluid Extract dose for Milk Thistle?',
   '5–10 drops 2x/day',
   '20–40 drops up to 5x/day',
   '1/2–1 tsp 4x/day',
   '60 drops 3x/day',
   'b',
   'FE dose is 20–40 drops up to 5 times per day; 1/2–1 tsp 4x/day is the Tinc dose — the tincture is noted with a caution to avoid alcohol preparations with active liver disease.',
   v_sn_milk_thistle_mm,
   'Milk Thistle', 170),

  -- Q18 (correct: b)
  (v_class,
   'For metabolic-associated fatty liver disease, how is Fennel described as being used in the personal notes?',
   'Fennel seed tea taken internally',
   'Fennel essential oil applied topically on the liver',
   'Fennel root decoction twice daily',
   'Fennel tincture given sublingually',
   'b',
   'The notes specify "fennel EO topical right on the liver, esp. with tenderness" for MAFLD — this is a topical essential oil application, distinct from the internal fennel seed carminative use.',
   v_sn_fennel_mafld,
   'Metabolic Associated Fatty Liver Disease', 180),

  -- Q19 (correct: a)
  (v_class,
   'Which herb in the liver tea formula is described as a "harmonizer"?',
   'Licorice',
   'Astragalus',
   'Fennel Seed',
   'Orange Peel',
   'a',
   'The personal notes describe Licorice as "adaptogen; harmonizer" in the context of the liver formula — it helps balance the formula and supports HPA axis communication.',
   v_sn_licorice_liver,
   'Liver', 190),

  -- Q20 (correct: d)
  (v_class,
   'What enzyme system does Phase I liver detoxification use to process fat-soluble toxins?',
   'Glutathione S-transferase',
   'Sulfotransferase',
   'UDP-glucuronyltransferase',
   'Cytochrome P450',
   'd',
   'Phase I uses cytochrome P450 enzymes; glutathione S-transferase, sulfotransferase, and UGT are all Phase II conjugation enzymes.',
   v_sn_b2_detox,
   'Liver Detoxification Pathways', 200),

  -- Q21 (correct: d)
  (v_class,
   'What is the Milk Thistle dose specifically indicated for acute mushroom poisoning?',
   '1 g/day',
   '2 g/day',
   '3 g/day',
   '5 g/day',
   'd',
   'The notes specify 5 g/day for acute mushroom poisoning — dramatically higher than the standard 600 mg/day maintenance dose, reflecting its anti-hepatotoxic action.',
   v_sn_milk_thistle_mm,
   'Milk Thistle', 210),

  -- Q22 (correct: d)
  (v_class,
   'Licorice root carries which specific caution mentioned in these class notes?',
   'Contraindicated with iron deficiency',
   'Avoid in thyroid disease',
   'Contraindicated in active gallstones',
   'May aggravate blood pressure in people with potassium imbalance',
   'd',
   'The notes specify "may aggravate BP in people with potassium imbalance" — potassium-depleting conditions can lead to pseudo-hyperaldosteronism with Licorice.',
   v_sn_licorice_mm,
   'Licorice', 220),

  -- Q23 (correct: c)
  (v_class,
   'Which of the following is NOT a specific indication for Burdock root in these class notes?',
   'Hyperlipidemia',
   'Chronic acne and skin disorders',
   'Amenorrhea or light menses',
   'Fatigue and malaise',
   'c',
   'Burdock root spec ind listed are hyperlipidemia, chronic acne/skin disorders, and fatigue and malaise; amenorrhea/light menses belongs to herbs like Dong Quai.',
   v_sn_burdock_liver,
   'Liver', 230),

  -- Q24 (correct: c)
  (v_class,
   'Astragalus is described in the liver tea formula primarily as what type of herb?',
   'Bitter, stimulating cholagogue',
   'Anti-inflammatory alterative',
   'Nourishing supporting hepatoprotective',
   'Warming carminative and harmonizer',
   'c',
   'The personal notes describe Astragalus as a "nourishing supporting hepatoprotective plant" — it provides gentle immune and liver support without the bitterness or stimulation of other formula herbs.',
   v_sn_astragalus,
   'Liver', 240),

  -- Q25 (correct: a)
  (v_class,
   'For which specific situations do the personal notes recommend methylated B vitamins ("Methyl Pro") to support Phase 1 liver detox?',
   'Chronic chemical exposure, past medicine or drug use, alcohol',
   'Pregnancy and postpartum recovery',
   'Autoimmune disease and Lyme disease',
   'Thyroid conditions and hormonal imbalance',
   'a',
   'The notes name three specific contexts: chronic chemical exposure, past medicine/drug use, and alcohol — all situations where Phase 1 pathways are under extra load.',
   v_sn_b_cpx,
   'Liver Detox Pathways', 250),

  -- Q26 (correct: b)
  (v_class,
   'Turmeric for cancer care — which three mechanisms are described in the personal notes?',
   'Boosting NK cells, inhibiting angiogenesis, reducing inflammation',
   'Regulating cell signaling, inhibiting cell division, inducing cell death',
   'Improving liver enzymes, reducing tumor markers, supporting lymphatics',
   'Antioxidant, anti-inflammatory, adaptogenic',
   'b',
   'The notes describe cancer care as "regulate cell signaling, inhibit cell division, induce cell death" — these are the three direct tumor-modulating mechanisms named.',
   v_sn_turmeric_mm,
   'Turmeric', 260),

  -- Q27 (correct: d)
  (v_class,
   'In the herbal business section, which product carries structure/function claims including "Promotes tranquilizing sleep" and "Nourishes skin and nails"?',
   'A chamomile and lemon balm tincture',
   'A valerian and passionflower capsule',
   'A nettle and oat straw mineral infusion',
   '"Sleepy Horsey" tea — chamomile, tulsi, lavender, and horsetail',
   'd',
   'The Sleepy Horsey tea is the example product; Horsetail contributes to skin and nail nourishment, while Chamomile and Lavender support the sleep claim.',
   v_sn_sleepy_horsey,
   'Herbal Business', 270),

  -- Q28 (correct: a)
  (v_class,
   'When choosing between dandelion tea and milk thistle extract for a liver patient, what is the key determining factor?',
   'History of chronic toxin exposure',
   'Patient''s hot or cold constitutional type',
   'Current AST/ALT laboratory values',
   'Patient''s age and body weight',
   'a',
   'The notes frame the clinical decision around history of chronic toxin exposure — milk thistle extract for more serious or chronic cases, dandelion tea for lighter ongoing support.',
   v_sn_milk_treat,
   'Liver Treatment', 280),

  -- Q29 (correct: c)
  (v_class,
   'Oregon Grape Root can potentiate antibiotics to improve outcomes for which specific resistant infection?',
   'C. difficile (CDI)',
   'Vancomycin-resistant Enterococcus (VRE)',
   'MRSA',
   'ESBL-producing E. coli',
   'c',
   'The notes specifically say OGR "can potentiate some antibiotics → good for MRSA treatment" — its berberine content enhances antibiotic efficacy against this resistant pathogen.',
   v_sn_ogr_mm,
   'Oregon Grape Root', 290),

  -- Q30 (correct: a)
  (v_class,
   'Which herbal action of Turmeric specifically involves stimulating bile release?',
   'Cholagogue',
   'Antilipidemic',
   'Antioxidant',
   'Anti-inflammatory',
   'a',
   'Cholagogue means bile-stimulating; the notes explicitly define it as "stimulate bile release." Antilipidemic refers to lipid-lowering, distinct from bile flow.',
   v_sn_turmeric_mm,
   'Turmeric', 300)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 45 quiz: 30 questions loaded.';
END $$;
