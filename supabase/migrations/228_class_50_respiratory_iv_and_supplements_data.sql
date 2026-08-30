-- Migration 228: Class 50 — Respiratory IV and Supplements
-- Source: BHC - Class 50 - Respiratory IV and Supplements - Lisa Ashley.md (personal)
-- The generated notes file for this class contains placeholder digestive system content
-- and is not used; all snippets are from the hand-taken personal notes (note_type = 'personal').
-- Supplements use supplement_id (schema added in migration 219).
-- All vitamins/minerals/amino acids already in herbal.supplements (migration 109, built from this class).
-- Herb normalizations:
--   Arctium / Burdock          → id=22  (Arctium lappa)
--   Rumex / Yellow Dock        → id=37  (Rumex crispus)
--   Calendula                  → id=70  (Calendula officinalis)
--   Pulsatilla / Anemone       → id=36  (Pulsatilla vulgaris)
--   Ceanothus / Red Root       → id=981 (Ceanothus americanus)
--   Yerba Mansa                → id=309 (Anemopsis californica)
--   Angelica                   → id=65  (Angelica archangelica)
--   Lobelia                    → id=132 (Lobelia inflata)
--   Plantain                   → id=85  (Plantago major)
-- Dynamic resolution: Centella, Passiflora, Equisetum, Tilia

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- Snippets
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_class TEXT := 'BHC - Class 50 - Respiratory IV and Supplements';

  -- Herb IDs resolved dynamically
  v_gotu_kola_id     INTEGER;
  v_passionflower_id INTEGER;
  v_horsetail_id     INTEGER;

  -- Supplement IDs resolved dynamically
  v_vit_a_id        INTEGER;
  v_vit_b1_id       INTEGER;
  v_vit_b2_id       INTEGER;
  v_vit_b3_id       INTEGER;
  v_vit_b5_id       INTEGER;
  v_vit_b6_id       INTEGER;
  v_vit_b7_id       INTEGER;
  v_vit_b9_id       INTEGER;
  v_vit_b12_id      INTEGER;
  v_vit_c_id        INTEGER;
  v_vit_d_id        INTEGER;
  v_vit_k_id        INTEGER;
  v_boron_id        INTEGER;
  v_calcium_id      INTEGER;
  v_chromium_id     INTEGER;
  v_copper_id       INTEGER;
  v_iodine_id       INTEGER;
  v_iron_id         INTEGER;
  v_lithium_id      INTEGER;
  v_magnesium_id    INTEGER;
  v_potassium_id    INTEGER;
  v_selenium_id     INTEGER;
  v_zinc_id         INTEGER;
  v_ala_id          INTEGER;
  v_fivehtp_id      INTEGER;
  v_lcarnitine_id   INTEGER;
  v_lglutamine_id   INTEGER;
  v_ltheanine_id    INTEGER;
  v_nac_id          INTEGER;
  v_coq10_id        INTEGER;
  v_fishoils_id     INTEGER;
  v_glucosamine_id  INTEGER;
  v_inositol_id     INTEGER;
  v_same_id         INTEGER;
  v_enzymes_id      INTEGER;

  -- Source blocks
  v_infusion_block   TEXT;
  v_dosing_block     TEXT;
  v_case_study_block TEXT;
  v_supp_intro_block TEXT;
  v_vitamins_block   TEXT;
  v_minerals_block   TEXT;
  v_other_block      TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 50 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ── Resolve herb IDs ────────────────────────────────────────────────────────
  SELECT id INTO v_gotu_kola_id     FROM herbal.herbs WHERE latin_name = 'Centella asiatica'   LIMIT 1;
  SELECT id INTO v_passionflower_id FROM herbal.herbs WHERE latin_name = 'Passiflora incarnata' LIMIT 1;
  SELECT id INTO v_horsetail_id     FROM herbal.herbs WHERE latin_name = 'Equisetum arvense'    LIMIT 1;

  -- ── Resolve supplement IDs ───────────────────────────────────────────────────
  SELECT id INTO v_vit_a_id        FROM herbal.supplements WHERE name = 'Vitamin A';
  SELECT id INTO v_vit_b1_id       FROM herbal.supplements WHERE name = 'Vitamin B1 (Thiamine)';
  SELECT id INTO v_vit_b2_id       FROM herbal.supplements WHERE name = 'Vitamin B2 (Riboflavin)';
  SELECT id INTO v_vit_b3_id       FROM herbal.supplements WHERE name = 'Vitamin B3 (Niacin)';
  SELECT id INTO v_vit_b5_id       FROM herbal.supplements WHERE name = 'Vitamin B5 (Pantothenic Acid)';
  SELECT id INTO v_vit_b6_id       FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)';
  SELECT id INTO v_vit_b7_id       FROM herbal.supplements WHERE name = 'Vitamin B7 (Biotin)';
  SELECT id INTO v_vit_b9_id       FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)';
  SELECT id INTO v_vit_b12_id      FROM herbal.supplements WHERE name = 'Vitamin B12';
  SELECT id INTO v_vit_c_id        FROM herbal.supplements WHERE name = 'Vitamin C';
  SELECT id INTO v_vit_d_id        FROM herbal.supplements WHERE name = 'Vitamin D';
  SELECT id INTO v_vit_k_id        FROM herbal.supplements WHERE name = 'Vitamin K';
  SELECT id INTO v_boron_id        FROM herbal.supplements WHERE name = 'Boron';
  SELECT id INTO v_calcium_id      FROM herbal.supplements WHERE name = 'Calcium';
  SELECT id INTO v_chromium_id     FROM herbal.supplements WHERE name = 'Chromium';
  SELECT id INTO v_copper_id       FROM herbal.supplements WHERE name = 'Copper';
  SELECT id INTO v_iodine_id       FROM herbal.supplements WHERE name = 'Iodine';
  SELECT id INTO v_iron_id         FROM herbal.supplements WHERE name = 'Iron';
  SELECT id INTO v_lithium_id      FROM herbal.supplements WHERE name = 'Lithium';
  SELECT id INTO v_magnesium_id    FROM herbal.supplements WHERE name = 'Magnesium';
  SELECT id INTO v_potassium_id    FROM herbal.supplements WHERE name = 'Potassium';
  SELECT id INTO v_selenium_id     FROM herbal.supplements WHERE name = 'Selenium';
  SELECT id INTO v_zinc_id         FROM herbal.supplements WHERE name = 'Zinc';
  SELECT id INTO v_ala_id          FROM herbal.supplements WHERE name = 'Alpha Lipoic Acid';
  SELECT id INTO v_fivehtp_id      FROM herbal.supplements WHERE name = '5-HTP';
  SELECT id INTO v_lcarnitine_id   FROM herbal.supplements WHERE name = 'L-Carnitine';
  SELECT id INTO v_lglutamine_id   FROM herbal.supplements WHERE name = 'L-Glutamine';
  SELECT id INTO v_ltheanine_id    FROM herbal.supplements WHERE name = 'L-Theanine';
  SELECT id INTO v_nac_id          FROM herbal.supplements WHERE name = 'N-Acetyl-Cysteine (NAC)';
  SELECT id INTO v_coq10_id        FROM herbal.supplements WHERE name = 'CoQ10 / Ubiquinol';
  SELECT id INTO v_fishoils_id     FROM herbal.supplements WHERE name = 'Fish Oils (Omega-3)';
  SELECT id INTO v_glucosamine_id  FROM herbal.supplements WHERE name = 'Glucosamine Sulfate';
  SELECT id INTO v_inositol_id     FROM herbal.supplements WHERE name = 'Inositol';
  SELECT id INTO v_same_id         FROM herbal.supplements WHERE name = 'SAM-E';
  SELECT id INTO v_enzymes_id      FROM herbal.supplements WHERE name = 'Proteolytic Enzymes';

  -- ── Source blocks ────────────────────────────────────────────────────────────

  v_infusion_block := $blk$## Infusions (Morning — Lisa)
- Gotu kola for skin; ginger juice

- Cold Infusion = Suspended Cold Infusion
    - strainer in container; cold water rotates through plant material
    - long-chain mucopolysaccharides (food for mucus membranes) are destroyed by heat
    - the demulcent action is NOT destroyed by heat
- Extended Infusion ("Hot to Cold")
    - better to pull out more minerals; 4 hours ≈ 2 hours (not much more extracted)
    - decoction → extended infusion? Only for minerals (yellow dock yes; astragalus no)$blk$;

  v_dosing_block := $blk$## Therapeutic Dosing (Morning — Lisa)

Michael Moore ranges for formula (chronic pain patient, 150 lbs, 40 y/o, weakened vitality):
- Ceanothus (Red Root): MM 30-90 drops 4x/day
- Arctium (Burdock): MM 30-90 drops 3x/day
- Rumex (Yellow Dock): MM 30-75 drops 3x/day
- Calendula: MM 5-30 drops 4x/day
- Anemone (Pulsatilla): MM 3-10 drops 4x/day

Dose selection considerations: body weight, sensitivities, energetics, acute/chronic, cost, medications, supplements, breastfeeding, age, vitality

Final 60 ml formula (5D = 150 drops = 1 tsp per dose):
- Burdock: 22 ml (11 parts) — alterative, start here
- Calendula: 4 ml (2 parts) — nourishing lymphatic, preferred over Ceanothus for this patient
- Yellow Dock: 16 ml (8 parts)
- Ceanothus: 16 ml (8 parts) — 50 drops not 60, because drying
- Pulsatilla: 2 ml (1 part) — 5 drops, rounded

David Hoffmann (Tilgner for Ceanothus): Anemone 30-60, Calendula 30-120, Rumex 30-60, Arctium 60-120, Ceanothus 20-40

Dosing frequency: more doses = smaller amounts; 3x/day = happy medium; 4x = ideal; acute → more doses; chronic → fewer$blk$;

  v_case_study_block := $blk$## Respiratory Case Study (Morning — Lisa)

Patient: adult-onset asthma, spasmodic dry/clear cough, wheezing, chest tightness; bike commuter near oil refinery; runs cold; stress and panic attacks tied to asthma attacks; three ER visits in past year

Lisa's prescription:

Tincture:
- Yerba Mansa — acute respiratory; always thinking of mucus membrane support chronically
- Angelica — feedback loop: coughing causing spasm
- Passionflower — specific for asthma picture; calming

Simple tincture (separate):
- Lobelia — dilates airway; 5 drops low dose, near full cap for acute attack; maintenance dose ongoing

Lifestyle: box breathing after bike ride

Tea (nourishing, moistening, chronic repair):
- Horsetail, Calendula, Plantain

Key clinical note: don't get hung up on energetics and constitution at first; focus on what's in front of you$blk$;

  v_supp_intro_block := $blk$## Nutritional Supplements (Afternoon — Ashley)

- "Consult with your doctor first" if prescribed supplements by a practitioner
- Consider compliance and cost; timing of consumption for max absorption
- Avoid overconsumption — adverse effects possible (chromium, zinc)
- Pharmaceutical-Nutrient Depletion: mytavin.com tracks med-induced nutrient loss
  - Statins → deplete CoQ10
  - ADHD medications → deplete adrenal minerals
- Preferred supplement brands: Thorne, Pure Encapsulations, Jarrow$blk$;

  v_vitamins_block := $blk$## Vitamins (Afternoon — Ashley)
Fat-soluble: A, D, E, K (take with food)
Water-soluble: B complex, C (no food required)
Antioxidant vitamins (take together): A, C, E, D — red/purple/bluish color foods
3rd party lab testing: My Med Labs, True Health Labs, Rupa Health$blk$;

  v_minerals_block := $blk$## Minerals (Afternoon — Ashley)
Key minerals covered: Boron, Calcium, Chromium, Copper, Iodine, Iron, Lithium, Magnesium, Potassium, Selenium, Zinc
Note on Lithium: lithium orotate for weaning off pharmaceutical lithium (bipolar); avoid mimosa bark/flower with bipolar
Facial and nail diagnostics: Margi Flint (book)$blk$;

  v_other_block := $blk$## Amino Acids and Other Supplements (Afternoon — Ashley)
Includes: Alpha Lipoic Acid, 5-HTP, L-Carnitine, L-Glutamine, L-Theanine, NAC, CoQ10, Fish Oils, Glucosamine, Inositol, SAMe, Proteolytic Enzymes (Serrapeptase, Nattokinase, Lumbrokinase)
Proteolytic enzyme strength: serrapeptase < nattokinase < lumbrokinase
Key indications: gut healing, PCOS, COPD, Lyme disease, cardiovascular plaque, long COVID, seasonal affective disorder$blk$;

  -- ── Morning: Infusion Techniques ─────────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_gotu_kola_id,
     'Gotu Kola — cold (suspended) infusion for skin; long-chain mucopolysaccharides that feed mucus membranes are destroyed by heat — demulcent action survives heat, but full mucous-membrane nourishment requires cold infusion.',
     v_class, 'personal', 'Infusion Techniques', 10, v_infusion_block),

    (37,  -- Yellow Dock
     'Yellow Dock — suitable for extended infusion to pull minerals; 4 hours ≈ 2 hours for most constituents. Contrast: Astragalus does NOT benefit from extended infusion for mineral extraction.',
     v_class, 'personal', 'Infusion Techniques', 20, v_infusion_block);

  -- ── Morning: Therapeutic Dosing ───────────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (22,  -- Burdock
     'Burdock (Arctium) — alterative; anchor herb in chronic-pain lymph formula; 22 ml (11 parts) out of 60 ml; dose middle of MM range (60 drops) for 150 lb chronic patient with weakened vitality.',
     v_class, 'personal', 'Therapeutic Dosing', 10, v_dosing_block),

    (70,  -- Calendula
     'Calendula — chosen as the lymphatic in this formula over Red Root because more nourishing and moistening to tissues; 4 ml (2 parts); lower MM dose (15 drops) for this patient.',
     v_class, 'personal', 'Therapeutic Dosing', 20, v_dosing_block),

    (37,  -- Yellow Dock
     'Yellow Dock (Rumex) — 16 ml (8 parts) in formula; MM range 30-75 drops 3x/day; alterative and mineral-rich; dose 45 drops for this patient.',
     v_class, 'personal', 'Therapeutic Dosing', 30, v_dosing_block),

    (981, -- Red Root / Ceanothus
     'Red Root (Ceanothus) — powerful lymphatic but drying; chose 50 drops not 60 because of drying quality; 16 ml (8 parts); MM range 30-90 drops; Tilgner range 20-40 drops.',
     v_class, 'personal', 'Therapeutic Dosing', 40, v_dosing_block),

    (36,  -- Pulsatilla / Anemone
     'Pulsatilla (Anemone) — 2 ml (1 part), 5 drops rounded down; MM range 3-10 drops 4x/day; use at the low end; David Hoffmann range 30-60 drops.',
     v_class, 'personal', 'Therapeutic Dosing', 50, v_dosing_block);

  -- ── Morning: Respiratory Case Study ──────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (309,                  -- Yerba Mansa
     'Yerba Mansa — acute respiratory; always thinking about mucus membrane support for chronic respiratory cases; indicated for this asthma/spasmodic cough patient.',
     v_class, 'personal', 'Respiratory Case Study', 10, v_case_study_block),

    (65,                   -- Angelica
     'Angelica — spasmodic cough; addresses the feedback loop where coughing triggers more bronchial spasm; used in this asthma case study tincture.',
     v_class, 'personal', 'Respiratory Case Study', 20, v_case_study_block),

    (v_passionflower_id,
     'Passionflower — specific for this asthma picture; calming nervine that interrupts the panic-asthma feedback cycle; included in the base tincture.',
     v_class, 'personal', 'Respiratory Case Study', 30, v_case_study_block),

    (132,                  -- Lobelia
     'Lobelia — simple tincture (separate from the base formula); dilates airway; low dose 5 drops; near full cap for acute attack; maintenance dose paired with full formula for ongoing support.',
     v_class, 'personal', 'Respiratory Case Study', 40, v_case_study_block),

    (v_horsetail_id,
     'Horsetail — repair tea blend (with Calendula and Plantain) for the chronic nourishing/moistening dimension of this respiratory case; supports membrane integrity.',
     v_class, 'personal', 'Respiratory Case Study', 50, v_case_study_block),

    (70,                   -- Calendula
     'Calendula — repair tea blend (with Horsetail and Plantain); nourishing, moistening, and anti-inflammatory for chronic respiratory membrane repair.',
     v_class, 'personal', 'Respiratory Case Study', 60, v_case_study_block),

    (85,                   -- Plantain
     'Plantain — repair tea blend (with Horsetail and Calendula); moistening demulcent for respiratory membrane support in chronic asthma case.',
     v_class, 'personal', 'Respiratory Case Study', 70, v_case_study_block);

  -- ── Afternoon: Pharmaceutical Nutrient Depletion ──────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_coq10_id,
     'CoQ10 — depleted by statin drugs; essential to supplement for anyone on a statin. Oil-soluble; take with breakfast once per day.',
     v_class, 'personal', 'Pharmaceutical Nutrient Depletion', 10, v_supp_intro_block);

  -- ── Afternoon: Vitamins ───────────────────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_vit_a_id,
     'Vitamin A — fat-soluble; immune deficiency, asthma, glaucoma, macular degeneration, premature aging skin when low; Crohn''s, celiac, gallbladder removal, liver disease inhibit absorption. Dose: 5,000–10,000 IU/day (retinol); 15,000–25,000 IU/day (beta carotene / mixed carotenoids).',
     v_class, 'personal', 'Vitamins', 10, v_vitamins_block),

    (v_vit_b1_id,
     'Vitamin B1 (Thiamine) — required for GABA and acetylcholine production; depleted by alcoholism; modestly lowers blood pressure in elevated blood sugar; may relieve PMS. Dose: 15–30 mg/day.',
     v_class, 'personal', 'Vitamins', 20, v_vitamins_block),

    (v_vit_b2_id,
     'Vitamin B2 (Riboflavin) — deficiency causes cracked lips, cracked mucus membranes, iron deficiency anemia; low levels from alcohol abuse. Dose: 5–15 mg/day.',
     v_class, 'personal', 'Vitamins', 30, v_vitamins_block),

    (v_vit_b3_id,
     'Vitamin B3 (Niacin) — lowers inflammation and cholesterol; improves brain function; synthesized from tryptophan; may improve schizophrenia symptoms. Dose: 15–30 mg/day.',
     v_class, 'personal', 'Vitamins', 40, v_vitamins_block),

    (v_vit_b5_id,
     'Vitamin B5 (Pantothenic Acid) — active form (Coenzyme A) essential for Krebs cycle ATP production, cholesterol synthesis, adrenal function, and sex hormone production. Deficiency is very rare.',
     v_class, 'personal', 'Vitamins', 50, v_vitamins_block),

    (v_vit_b6_id,
     'Vitamin B6 (Pyridoxine) — stimulates glycogen release from liver and muscles; component of myelin sheath; deficiency causes eczema, anemia, fatigue. Depleted by smoking, corticosteroids, diuretics, contraceptives. Dose: 35–50 mg/day.',
     v_class, 'personal', 'Vitamins', 60, v_vitamins_block),

    (v_vit_b7_id,
     'Vitamin B7 (Biotin) — hair, skin, nails; may help with cholesterol and diabetic blood sugar control. Sources: liver, peanuts, egg yolks, cauliflower, gut bacteria. Dose: 30–300 mcg/day.',
     v_class, 'personal', 'Vitamins', 70, v_vitamins_block),

    (v_vit_b9_id,
     'Vitamin B9 (Folic Acid) — red blood cells, DNA synthesis, fertility. MTHFR mutation: use methylfolate. Deficiency: emotional instability, diarrhea, anemia, tongue swelling. Metformin and alcohol reduce folate. Dose: 400 mcg–1 mg/day.',
     v_class, 'personal', 'Vitamins', 80, v_vitamins_block),

    (v_vit_b12_id,
     'Vitamin B12 — cellular metabolism, nervous system function, DNA synthesis, blood production; deficiency common with vegan diet and PCOS. Deficiency causes depression, impaired memory, fatigue, brain and nervous system damage. Dose: 200–500 mcg/day.',
     v_class, 'personal', 'Vitamins', 90, v_vitamins_block),

    (v_vit_c_id,
     'Vitamin C — water-soluble antioxidant; bones, ligaments, blood vessels, skin; lowers A1C when taken with metformin. Take 2x/day in smaller divided doses. Dose: 500 mg–2 g/day.',
     v_class, 'personal', 'Vitamins', 100, v_vitamins_block),

    (v_vit_d_id,
     'Vitamin D — fat-soluble (take with food); D3 = more active form; synthesized from sunlight. Protects against cancer, viruses, osteoporosis, diabetes, autoimmune disease, heart disease. 3rd party testing labs: My Med Labs, True Health Labs, Rupa Health. Dose: 1,000–5,000 IU/day.',
     v_class, 'personal', 'Vitamins', 110, v_vitamins_block),

    (v_vit_k_id,
     'Vitamin K — K1 (leafy greens, blood coagulation) and K2 (gut bacteria, bone metabolism). Chronic bowel disease, bowel resections, and frequent antibiotics deplete Vit K. Dose: 750 mcg–2 mg/day.',
     v_class, 'personal', 'Vitamins', 120, v_vitamins_block);

  -- ── Afternoon: Minerals ───────────────────────────────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_boron_id,
     'Boron — healthy bones and teeth through calcium and magnesium metabolism. Sources: dark leafy greens, raisins, nuts, legumes, avocados. Dose: 1–2 mg/day.',
     v_class, 'personal', 'Minerals', 10, v_minerals_block),

    (v_calcium_id,
     'Calcium — stored in bones and teeth; nerve transmission, vasodilation/vasoconstriction. Requires HCl, Vit D, magnesium, potassium, silica, and Vit K for absorption. Deficiency: osteoporosis, arrhythmia, muscle spasms. Antacids, corticosteroids, thyroid hormones, HRT inhibit absorption. Dose: 350–500 mg BID (calcium carbonate).',
     v_class, 'personal', 'Minerals', 20, v_minerals_block),

    (v_chromium_id,
     'Chromium — essential trace element; allows insulin to bind cellular receptors ("key and lock for glucose into the cell"); key for insulin resistance. Inhibited by antacids, PPIs, achlorhydria. Dose: 100–400 mcg/day.',
     v_class, 'personal', 'Minerals', 30, v_minerals_block),

    (v_copper_id,
     'Copper — bone strength, iron transport, brain development, immune function, cardiac function; deficiency can underlie anemia. Excessive zinc supplementation causes copper deficiency. Dose: 2 mg/day.',
     v_class, 'personal', 'Minerals', 40, v_minerals_block),

    (v_iodine_id,
     'Iodine — only function in the body: thyroid gland uses it with tyrosine to make T3 and T4. Antagonists: raw brassicas, unfermented soy, fluorine, bromine, chlorine (explains deficiency despite iodized salt). Dose: 150 mcg/day.',
     v_class, 'personal', 'Minerals', 50, v_minerals_block),

    (v_iron_id,
     'Iron — hemoglobin component for oxygen transport; Vit C significantly increases absorption; tannin-rich herbs reduce absorption (useful for iron overload). Sources: beans, lentils, molasses, spinach. Dose: 18 mg/day.',
     v_class, 'personal', 'Minerals', 60, v_minerals_block),

    (v_lithium_id,
     'Lithium orotate — supplement form for people weaning off pharmaceutical lithium (bipolar disorder). Avoid giving Albizia (mimosa bark or flower) to people with bipolar. Managing chronic inflammation with nervines and adaptogens for bipolar. Dose: 10–20 mg/day.',
     v_class, 'personal', 'Minerals', 70, v_minerals_block),

    (v_magnesium_id,
     'Magnesium — often deficient; essential for blood sugar regulation, metabolism, muscle function, intestinal motility, neuroprotection. Biglycinate = highest absorption; citrate = more laxative. Deficiency from IBD, kidney disease, diabetes, alcoholism, antibiotics. Dose: 400–600 mg/day.',
     v_class, 'personal', 'Minerals', 80, v_minerals_block),

    (v_potassium_id,
     'Potassium — nerve transmission, brain/heart/muscle function, electrolyte balance, protein synthesis. Most people get enough from diet. Low potassium → eye spasms. Daily requirement: 4,700 mg.',
     v_class, 'personal', 'Minerals', 90, v_minerals_block),

    (v_selenium_id,
     'Selenium — converts T4 (storage form) to T3 (active form); linked to reduced cardiovascular disease risk; may help bulging eyes in Grave''s disease. Best source: Brazil nuts. Dose: 100–200 mcg/day.',
     v_class, 'personal', 'Minerals', 100, v_minerals_block),

    (v_zinc_id,
     'Zinc — immune function, skin/wound healing, neurotransmitter function, prostate health. Sources: oysters, pumpkin seeds, beef, king crab. Dose: 15–30 mg/day.',
     v_class, 'personal', 'Minerals', 110, v_minerals_block);

  -- ── Afternoon: Amino Acids and Other Supplements ──────────────────────────────
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_ala_id,
     'Alpha Lipoic Acid — antioxidant; enhances glucose sensitivity for metabolic syndrome and Type 2 Diabetes. Dose: 200–1,200 mg/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 10, v_other_block),

    (v_fivehtp_id,
     '5-HTP — serotonin and melatonin precursor; tryptophan converts to 5-HTP with B6 help; indicated for panic disorder, chronic headaches, fibromyalgia, IBS; avoid with SSRIs (serotonin syndrome risk). Dose: 50–400 mg/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 20, v_other_block),

    (v_lcarnitine_id,
     'L-Carnitine — transports fatty acids into mitochondria for energy production; supports muscle building and fat metabolism. Sources: beef, pork. Dose: 1–3 g/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 30, v_other_block),

    (v_lglutamine_id,
     'L-Glutamine — heals gut mucosa and promotes tight junctions; for IBS and leaky gut; pair with gut-healing herbs, infusions, and removing irritating foods from diet. Dose: 500–1,000 mg TID.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 40, v_other_block),

    (v_ltheanine_id,
     'L-Theanine — non-protein amino acid originally isolated from green tea; promotes calm relaxation without sedation; counterbalances caffeine. Dose: 200 mg, 2–3x/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 50, v_other_block),

    (v_nac_id,
     'NAC (N-Acetyl-Cysteine) — thins mucus for easier expectoration in COPD, bronchitis, and pneumonia; also helpful for PCOS/insulin resistance. Used IV in orthodox medicine for acetaminophen overdose. Dose: 200–600 mg/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 60, v_other_block),

    (v_coq10_id,
     'CoQ10 / Ubiquinol — oil-soluble; essential for mitochondrial and cellular function; antioxidant protecting against LDL oxidation; essential for people on statins; cardiovascular disease support. Take once/day with breakfast. Dose: 100–1,000 mg/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 70, v_other_block),

    (v_fishoils_id,
     'Fish Oils (Omega-3) — brain function, cardiovascular disease, memory, seizure reduction, ADHD, neurological issues, dry eyes, skin disease; key to balance Omega-3 vs Omega-6 (Omega-3 reduces inflammation). Brands: OmegAvail Hi-Po, Nordic Naturals. Dose: 1–6 g/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 80, v_other_block),

    (v_glucosamine_id,
     'Glucosamine Sulfate — derived from shellfish exoskeletons; used with chondroitin for arthritis of hips, spine, and wrists; can reduce rheumatoid arthritis symptoms; caution with shellfish allergy. Dose: 1,500 mg/day.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 90, v_other_block),

    (v_inositol_id,
     'Inositol — produced by kidneys from glucose (not a vitamin); fat/cholesterol metabolism, cell membrane integrity, serotonin utilization, insulin signaling; lowers insulin and testosterone in PCOS. Powder form recommended. Dose: 2–10 g/day (myo-inositol).',
     v_class, 'personal', 'Amino Acids and Other Supplements', 100, v_other_block),

    (v_same_id,
     'SAMe — useful for seasonal affective disorder; helps produce serotonin, dopamine, and melatonin; take 400–1,200 mg on empty stomach in AM; expensive; avoid with bipolar disorder due to mania risk.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 110, v_other_block),

    (v_enzymes_id,
     'Proteolytic Enzymes — Serrapeptase, Nattokinase, Lumbrokinase; dissolve scar tissue and plaque that don''t serve a healthy purpose. Strength: serrapeptase < nattokinase < lumbrokinase (Lumbrokinase 300× stronger than serrapeptase). Lumbrokinase: phenomenal for Lyme disease. Nattokinase: cardiovascular plaque, Mono that won''t budge. Take on empty stomach.',
     v_class, 'personal', 'Amino Acids and Other Supplements', 120, v_other_block);

  RAISE NOTICE 'Class 50 snippets inserted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Herb Keywords (morning section)
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_gotu_kola_id     INTEGER;
  v_passionflower_id INTEGER;
  v_horsetail_id     INTEGER;
BEGIN
  SELECT id INTO v_gotu_kola_id     FROM herbal.herbs WHERE latin_name = 'Centella asiatica'    LIMIT 1;
  SELECT id INTO v_passionflower_id FROM herbal.herbs WHERE latin_name = 'Passiflora incarnata' LIMIT 1;
  SELECT id INTO v_horsetail_id     FROM herbal.herbs WHERE latin_name = 'Equisetum arvense'    LIMIT 1;

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    -- Gotu Kola
    (v_gotu_kola_id, 'skin conditions',         'ailment'),
    (v_gotu_kola_id, 'tissue repair',            'action'),
    (v_gotu_kola_id, 'mucus membrane integrity', 'action'),

    -- Burdock (22)
    (22, 'alterative',           'action'),
    (22, 'lymphatic support',    'action'),
    (22, 'chronic pain',         'ailment'),

    -- Calendula (70) — already has SAD, depression from class 52
    (70, 'lymphatic support',    'action'),
    (70, 'tissue repair',        'action'),

    -- Red Root / Ceanothus (981)
    (981, 'lymphatic support',   'action'),

    -- Yellow Dock (37)
    (37, 'alterative',           'action'),

    -- Yerba Mansa (309)
    (309, 'asthma',                    'ailment'),
    (309, 'respiratory infection',     'ailment'),
    (309, 'mucus membrane integrity',  'action'),

    -- Angelica (65)
    (65, 'asthma',               'ailment'),
    (65, 'spasmodic cough',      'ailment'),
    (65, 'antispasmodic',        'action'),

    -- Passionflower — already has anxiety, insomnia, GABA from class 52
    (v_passionflower_id, 'asthma', 'ailment'),

    -- Lobelia (132)
    (132, 'asthma',              'ailment'),
    (132, 'bronchodilator',      'action'),
    (132, 'antispasmodic',       'action'),

    -- Horsetail
    (v_horsetail_id, 'tissue repair',   'action'),
    (v_horsetail_id, 'asthma',          'ailment'),

    -- Plantain (85)
    (85, 'asthma',                       'ailment'),
    (85, 'mucus membrane integrity',     'action')

  ON CONFLICT (herb_id, keyword) DO NOTHING;

  RAISE NOTICE 'Class 50 herb keywords inserted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Supplement Keywords
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_vit_a_id        INTEGER;
  v_vit_b1_id       INTEGER;
  v_vit_b9_id       INTEGER;
  v_vit_b12_id      INTEGER;
  v_vit_d_id        INTEGER;
  v_chromium_id     INTEGER;
  v_copper_id       INTEGER;
  v_iodine_id       INTEGER;
  v_iron_id         INTEGER;
  v_lithium_id      INTEGER;
  v_magnesium_id    INTEGER;
  v_selenium_id     INTEGER;
  v_zinc_id         INTEGER;
  v_ala_id          INTEGER;
  v_fivehtp_id      INTEGER;
  v_lglutamine_id   INTEGER;
  v_ltheanine_id    INTEGER;
  v_nac_id          INTEGER;
  v_coq10_id        INTEGER;
  v_fishoils_id     INTEGER;
  v_glucosamine_id  INTEGER;
  v_inositol_id     INTEGER;
  v_same_id         INTEGER;
  v_enzymes_id      INTEGER;
BEGIN
  SELECT id INTO v_vit_a_id       FROM herbal.supplements WHERE name = 'Vitamin A';
  SELECT id INTO v_vit_b1_id      FROM herbal.supplements WHERE name = 'Vitamin B1 (Thiamine)';
  SELECT id INTO v_vit_b9_id      FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)';
  SELECT id INTO v_vit_b12_id     FROM herbal.supplements WHERE name = 'Vitamin B12';
  SELECT id INTO v_vit_d_id       FROM herbal.supplements WHERE name = 'Vitamin D';
  SELECT id INTO v_chromium_id    FROM herbal.supplements WHERE name = 'Chromium';
  SELECT id INTO v_copper_id      FROM herbal.supplements WHERE name = 'Copper';
  SELECT id INTO v_iodine_id      FROM herbal.supplements WHERE name = 'Iodine';
  SELECT id INTO v_iron_id        FROM herbal.supplements WHERE name = 'Iron';
  SELECT id INTO v_lithium_id     FROM herbal.supplements WHERE name = 'Lithium';
  SELECT id INTO v_magnesium_id   FROM herbal.supplements WHERE name = 'Magnesium';
  SELECT id INTO v_selenium_id    FROM herbal.supplements WHERE name = 'Selenium';
  SELECT id INTO v_zinc_id        FROM herbal.supplements WHERE name = 'Zinc';
  SELECT id INTO v_ala_id         FROM herbal.supplements WHERE name = 'Alpha Lipoic Acid';
  SELECT id INTO v_fivehtp_id     FROM herbal.supplements WHERE name = '5-HTP';
  SELECT id INTO v_lglutamine_id  FROM herbal.supplements WHERE name = 'L-Glutamine';
  SELECT id INTO v_ltheanine_id   FROM herbal.supplements WHERE name = 'L-Theanine';
  SELECT id INTO v_nac_id         FROM herbal.supplements WHERE name = 'N-Acetyl-Cysteine (NAC)';
  SELECT id INTO v_coq10_id       FROM herbal.supplements WHERE name = 'CoQ10 / Ubiquinol';
  SELECT id INTO v_fishoils_id    FROM herbal.supplements WHERE name = 'Fish Oils (Omega-3)';
  SELECT id INTO v_glucosamine_id FROM herbal.supplements WHERE name = 'Glucosamine Sulfate';
  SELECT id INTO v_inositol_id    FROM herbal.supplements WHERE name = 'Inositol';
  SELECT id INTO v_same_id        FROM herbal.supplements WHERE name = 'SAM-E';
  SELECT id INTO v_enzymes_id     FROM herbal.supplements WHERE name = 'Proteolytic Enzymes';

  INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
    (v_vit_a_id,       'asthma',                    'ailment'),
    (v_vit_a_id,       'immune deficiency',          'ailment'),
    (v_vit_a_id,       'macular degeneration',       'ailment'),
    (v_vit_b1_id,      'GABA support',               'action'),
    (v_vit_b9_id,      'anemia',                     'ailment'),
    (v_vit_b12_id,     'depression',                 'ailment'),
    (v_vit_b12_id,     'PCOS',                       'ailment'),
    (v_vit_d_id,       'seasonal affective disorder','ailment'),
    (v_vit_d_id,       'immune deficiency',          'ailment'),
    (v_chromium_id,    'insulin resistance',         'ailment'),
    (v_chromium_id,    'blood sugar dysregulation',  'ailment'),
    (v_copper_id,      'anemia',                     'ailment'),
    (v_iodine_id,      'hypothyroidism',             'ailment'),
    (v_iron_id,        'anemia',                     'ailment'),
    (v_lithium_id,     'bipolar disorder',           'ailment'),
    (v_magnesium_id,   'muscle spasms',              'ailment'),
    (v_magnesium_id,   'insomnia',                   'symptom'),
    (v_selenium_id,    'hypothyroidism',             'ailment'),
    (v_zinc_id,        'immune deficiency',          'ailment'),
    (v_zinc_id,        'PCOS',                       'ailment'),
    (v_ala_id,         'insulin resistance',         'ailment'),
    (v_ala_id,         'blood sugar dysregulation',  'ailment'),
    (v_fivehtp_id,     'depression',                 'ailment'),
    (v_fivehtp_id,     'fibromyalgia',               'ailment'),
    (v_fivehtp_id,     'panic disorder',             'ailment'),
    (v_fivehtp_id,     'insomnia',                   'symptom'),
    (v_lglutamine_id,  'leaky gut',                  'ailment'),
    (v_lglutamine_id,  'IBS',                        'ailment'),
    (v_ltheanine_id,   'anxiety',                    'ailment'),
    (v_ltheanine_id,   'stress',                     'ailment'),
    (v_nac_id,         'COPD',                       'ailment'),
    (v_nac_id,         'bronchitis',                 'ailment'),
    (v_nac_id,         'PCOS',                       'ailment'),
    (v_nac_id,         'insulin resistance',         'ailment'),
    (v_coq10_id,       'cardiovascular disease',     'ailment'),
    (v_fishoils_id,    'ADHD',                       'ailment'),
    (v_fishoils_id,    'cardiovascular disease',     'ailment'),
    (v_glucosamine_id, 'arthritis',                  'ailment'),
    (v_inositol_id,    'PCOS',                       'ailment'),
    (v_inositol_id,    'insulin resistance',         'ailment'),
    (v_same_id,        'seasonal affective disorder','ailment'),
    (v_same_id,        'depression',                 'ailment'),
    (v_enzymes_id,     'Lyme disease',               'ailment')
  ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

  RAISE NOTICE 'Class 50 supplement keywords inserted.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Ailment search synonyms (new ailment keywords only)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('asthma',
   ARRAY['bronchial asthma', 'reactive airway disease', 'adult-onset asthma', 'asthmatic', 'bronchospasm']),
  ('COPD',
   ARRAY['chronic obstructive pulmonary disease', 'emphysema', 'chronic bronchitis', 'chronic obstructive lung disease']),
  ('spasmodic cough',
   ARRAY['spasm cough', 'cough spasm', 'convulsive cough', 'nervous cough', 'bronchial spasm']),
  ('PCOS',
   ARRAY['polycystic ovarian syndrome', 'polycystic ovary syndrome', 'polycystic ovaries']),
  ('insulin resistance',
   ARRAY['metabolic syndrome', 'pre-diabetes', 'prediabetes', 'insulin insensitivity', 'type 2 diabetes risk', 'glucose intolerance']),
  ('fibromyalgia',
   ARRAY['fibromyalgia syndrome', 'FMS', 'fibromyalgic', 'widespread muscle pain']),
  ('leaky gut',
   ARRAY['intestinal permeability', 'gut permeability', 'permeable gut', 'tight junction dysfunction', 'hyperpermeability']),
  ('panic disorder',
   ARRAY['panic attacks', 'panic attack', 'anxiety attacks', 'acute anxiety episode']),
  ('bipolar disorder',
   ARRAY['bipolar', 'manic depression', 'manic depressive', 'bipolar I', 'bipolar II']),
  ('cardiovascular disease',
   ARRAY['heart disease', 'CVD', 'coronary artery disease', 'CAD', 'atherosclerosis', 'cardiovascular']),
  ('arthritis',
   ARRAY['osteoarthritis', 'rheumatoid arthritis', 'RA', 'OA', 'joint inflammation', 'joint pain']),
  ('ADHD',
   ARRAY['attention deficit hyperactivity disorder', 'attention deficit disorder', 'ADD', 'hyperactivity']),
  ('Lyme disease',
   ARRAY['Lyme', 'borreliosis', 'Borrelia', 'chronic Lyme', 'tick-borne illness'])
ON CONFLICT (ailment_keyword) DO NOTHING;
