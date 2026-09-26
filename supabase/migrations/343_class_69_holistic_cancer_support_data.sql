-- Migration 343: Class 69 — Holistic Cancer Support — snippets, keywords, ailment synonyms
--
-- Parsed files:
--   BHC - Class 69 - Holistic Cancer Support - Generated Notes.md  (note_type='generated')
--   BHC - Class 69 - Holistic Cancer Support - Shereel.md          (note_type='personal')
--
-- Normalizations applied:
--   Red onion         → Onion (Allium cepa, id=208)
--   Indian tobacco    → Lobelia (Lobelia inflata, id=132)
--   SJW               → St. John's Wort (Hypericum perforatum, id=81)
--   Corn / corn shuck → Corn Silk (Zea mays, id=95) — same plant, closest DB entry
--   Elderberry        → Elder berry (Sambucus nigra, id=1651)
--   Vit C therapy     → Vitamin C (supplement_id=10)
--   iron tincture     → Iron (supplement_id=19)
--   Comfrey           → Comfrey root (id=89) — unqualified; root is primary medicinal part
--
-- Skipped (not herbs/supplements):
--   "Metal therapy"            — no specific herb name; context only
--   "Chlorophyll and aloe-rich treatment" — aloe captured separately; chlorophyll is a pigment
--   "Full-spectrum nutrition"  — dietary guidance, not a named herb/supplement
--   "Cardiotonics"             — category word, not a specific herb
--
-- New ailment keywords introduced: chemotherapy support, blood cleansing
-- Merge decisions:
--   "blood cleaning" (notes)   → blood cleansing (new keyword)
--   "cancer treatment support" → chemotherapy support (new; distinct clinical concept)
--
-- Depends on: migration 342 (Asafetida and Cat's Claw must exist)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_asaf_id INTEGER;
  v_claw_id INTEGER;

  -- ── generated note source blocks ──────────────────────────────────────
  sb_g_trad TEXT := '* Common herbal treatments
* **Black walnut leaves**, **burdock root**, **catnip**
    * Used for digestive ailments like diarrhea and colic
* *Mullein* leaf and corn shuck
    * Used for illnesses like measles, malaria, smallpox
* Garlic and red onion
    * Anti-bacterial and infection fighters
* Homeopathic stabilizers: cotton root, bayberry bark, black cohosh root';

  sb_g_herbal_treatment TEXT := '* Immunomodulating and alkaline-rich herbs
    * Chlorophyll-rich, mineral-dense plants
* Anticarcinogenic herbs
    * Aloe vera, black walnut, sarsaparilla bark, poke root
* Importance of lymphatic flow and digestive support herbs';

  sb_g_cancer_support TEXT := '- Metal therapy for inflammation reduction
    - Chlorophyll and aloe-rich treatment
    - Gentle approach
- **Black walnut leaf** and **poke root**
    - Aggressive
    - Useful in early cancer stages
- Digestive support during chemo
    - Marshmallow leaf to cool overheated systems
    - Slippery elm for pain reduction';

  sb_g_chemo TEXT := '- Communicate with doctors
    - Understand cancer stage and progression
    - Inquiry on low-dose options
- **Marshmallow root** for immune support
- **Cleavers** for metabolic waste removal
- **Nettle** for blood and minerals
- **Witch hazel leaf** and **cat''s claw**
    - Cooling and anti-inflammatory
    - Tissue soothing';

  sb_g_strategy TEXT := '- Initial gentle approach
    - Allow for environment shifting
    - Gradual increase in formula intensity
- Key herbs for cancer care
    - **Black walnut**
    - **Damiana**
    - **Ashwagandha**';

  sb_g_formulary TEXT := '- Case study: African American male, 59
    - Stage 3 cancer
    - Herbal tonics for blood cleaning
    - **St. John''s wort** and **Indian tobacco**
    - **Black walnut** for circulatory and lymphatic involvement';

  sb_g_client TEXT := '- Example client case recap
    - Medical history and current treatments
    - Herbal recommendations: **CBD**, **turmeric**, **passionflower**
- Client feedback on treatment plan
    - Grouping herbs into a tea
    - Adjustments in consistency and daily routine
- New symptoms and adjustments
    - Noted improvements and remaining challenges
    - Continual monitoring of symptomatology and lifestyle influences';

  sb_g_prep TEXT := '- Cold infusion of herbs
    - Leaves, stems for mineral extraction
    - Dark tea color indicates mineral presence
- Possible tea components
    - Nettle, red raspberry, oat straw, dandelion for various effects
    - Adding sea salt for mineral enhancement';

  sb_g_formulas TEXT := '- Stress and sleep support formula updates
    - Bacopa, gotu kola mentioned
    - Add chamomile, catnip or valerian for sleep aid
    - Consideration for hormonal herbs and urinary issues
- Substituting red raspberry with horsetail
    - Gently opens pores for sweating';

  -- ── personal note source blocks ───────────────────────────────────────
  sb_p_cancer_report TEXT := '### Shereel''s Cancer report in 2022
- digestive
    - Black Walnut leaf and hull - worms
    - burdock root - stomach ache and cramp
    - catnip - diarrhea and colic
    - asafetida - digestion
- lymphatic
    - echinacea root - antiseptic and analgesic
    - mullein leaf and flower - cold, fever and inflammation and hidden disease
    - corn - shuck was for measles, malaria, smallpox
    - pine - needles and resin
- nervines
    - sassafras
    - poke
    - lobelia
- cardiotonics
- viral and bacterial infection
    - garlic
    - red onion
    - horehound
    - sage
- hormonal stabilizers
    - cotton root
    - black cohosh root
- outlined the scientific method
- inhibit, mitigate, prevent and cure
- examples
    - poke root
    - sassafras
    - asafetida
    - garlic
    - black walnut leaf and hull
- when the body is overtaxed and depleted (slavery)
    - makes the body hospitable for cancers and other diseases';

  sb_p_actions TEXT := '#### Herbal Actions
- immunomodulation
- alkaline rich (alkaloid?)
- chlorophyll rich
- AM
- oxygenating
- blood building
- nutritive
- anticarcinogenic
    - asafetida
    - black walnut leaf and hull
    - sassafras
    - poke
- analgesic';

  sb_p_formula1 TEXT := '#### Anti-cancer formula 1
- change the environment quickly, early stage, nutratives
- garlic
- burdock root
- black walnut leaves
- witch hazel leaves
- asafetida - nervine, calm and reduce pain
- marshmallow root - cooling
- peach leaves - relieve stomach pain, healthy elimination';

  sb_p_formula2 TEXT := '#### Anti-cancer formula 2
- more intense - after the first one - do in stages - keep getting tested
- garlic
- black walnut hulls
- cleavers
- witch hazel bark
- sassafras root
- black cohosh
- SJW
- Comfrey
- poke root
- feverfew';

  sb_p_lymphatic TEXT := '#### Lymphatic herbs
- black walnut
- burdock root
- elderberry
- poke root
- sassafras
- peach
- black pepper
- SJW';

  sb_p_nervine TEXT := '#### Nervine / AI
- Asafetida
- Black cohosh
- Catnip
- Comfrey
- Corn
- Peach
- SJW
- if cancer already metastasized, best to get western treatment first, then replenishing holistic therapies
- support chemo?
    - all good in tea - stay hydrated
        - marshmallow root - nourishing and cooling and tissue protective
        - cleavers - remove metabolic waste, radiation chemicals
        - nettle - cooling, nutritive, minerals
        - witch hazel leaf - cooling, AI, heal the tissue, and break up scar tissue
        - poke root - break up tumors and scar tissue - low dose
        - sassafras - good taste, soothes nerves, reduce inflamed and hot tissue
- try to avoid tinctures - alcohol is hot and we want to cool - prefer glycerites and teas';

  sb_p_7principles TEXT := '#### 7 Principles of Cancer Therapy
- Non-toxic Cancer Therapy
    - Light and Sound Therapy
        - trigger biochemical responses and activate the immune system
    - Photodynamic and infrared sauna
    - bio immunotherapies
    - oxygen therapy - hyper-baric chambers
    - immunomodulation to boost the immune system
    - biologics (Vit C therapy)
    - full spectrum nutrition
    - detox thermal energy, magnetic, electric fields, antimicrobial
    - microbiome restoration
    - emotional / spiritual healing';

  sb_p_feri TEXT := '## Feri followup
- sleep may be getting better
- more patient
- energy has calmed
- lot less crampy painful and heavy menses
- tea = lots of movement and elimination
- brain fog cleared
- added in iron tincture
- gave up instagram for last 2 weeks
- definitely continue with the tea
    - help to move out waste and nourish the blood
    - maybe add diaphoretic herbs to help the quality be more productive
- update the sleep formula
- work on getting in walks
- cold infusion (room temp) for infusion mixtures of all leaf
    - maybe hot to cold infusion if you need something quicker
- to alleviate nighttime pee:
    - in the infusion, swap out Red Raspberry for Horsetail (gentle diaphoretic)
- add Skullcap and Catnip to stress glycerite
    - take at night';

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 69 - Holistic Cancer Support') THEN
    RAISE NOTICE 'Class 69 snippets already loaded, skipping';
    RETURN;
  END IF;

  SELECT id INTO v_asaf_id FROM herbal.herbs WHERE latin_name = 'Ferula asafoetida';
  SELECT id INTO v_claw_id FROM herbal.herbs WHERE latin_name = 'Uncaria tomentosa';
  IF v_asaf_id IS NULL THEN RAISE EXCEPTION 'Asafetida not found — run migration 342 first'; END IF;
  IF v_claw_id IS NULL THEN RAISE EXCEPTION 'Cat''s Claw not found — run migration 342 first'; END IF;

  -- ============================================================
  -- GENERATED NOTES
  -- ============================================================

  -- Section: Traditional Black American Herbal Practices (sort 10–100)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (288, 'Black walnut leaves used for digestive ailments — diarrhea and colic — in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 10, sb_g_trad),
    (22,  'Burdock root used for digestive ailments — diarrhea and colic — in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 20, sb_g_trad),
    (136, 'Catnip used for digestive ailments — diarrhea and colic — in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 30, sb_g_trad),
    (61,  'Mullein leaf used for illnesses like measles, malaria, and smallpox in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 40, sb_g_trad),
    (95,  'Corn (shuck/husk, Zea mays) used for illnesses like measles, malaria, and smallpox in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 50, sb_g_trad),
    (21,  'Garlic and red onion listed as anti-bacterial and infection fighters in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 60, sb_g_trad),
    (208, 'Red onion and garlic listed as anti-bacterial and infection fighters in traditional Black American herbalism.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 70, sb_g_trad),
    (2635,'Cotton root listed as a hormonal stabilizer in traditional Black American herbal practices.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 80, sb_g_trad),
    (119, 'Bayberry bark listed as a stabilizer in traditional Black American herbal practices.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 90, sb_g_trad),
    (25,  'Black cohosh root listed as a hormonal stabilizer in traditional Black American herbal practices.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Traditional Black American Herbal Practices', 100, sb_g_trad),

    -- Section: Use of Herbal Treatment in Cancer Care (sort 110–140)
    (202, 'Aloe vera listed as an anticarcinogenic herb for cancer care; immunomodulating and alkaline-rich.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Use of Herbal Treatment in Cancer Care', 110, sb_g_herbal_treatment),
    (288, 'Black walnut listed as an anticarcinogenic herb for cancer care; immunomodulating and chlorophyll-rich.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Use of Herbal Treatment in Cancer Care', 120, sb_g_herbal_treatment),
    (40,  'Sarsaparilla bark listed as an anticarcinogenic herb for cancer care; lymphatic support.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Use of Herbal Treatment in Cancer Care', 130, sb_g_herbal_treatment),
    (35,  'Poke root listed as an anticarcinogenic herb for cancer care; important for lymphatic flow.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Use of Herbal Treatment in Cancer Care', 140, sb_g_herbal_treatment),

    -- Section: Cancer Treatment Support (sort 150–190)
    (202, 'Chlorophyll and aloe-rich treatment used as the gentle, initial approach for inflammation reduction in cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Cancer Treatment Support', 150, sb_g_cancer_support),
    (288, 'Black walnut leaf used aggressively (alongside poke root) in early cancer stages; useful for tumor involvement.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Cancer Treatment Support', 160, sb_g_cancer_support),
    (35,  'Poke root used aggressively (alongside black walnut leaf) in early cancer stages; useful for tumor involvement.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Cancer Treatment Support', 170, sb_g_cancer_support),
    (45,  'Marshmallow leaf used to cool overheated systems during chemotherapy; digestive support in cancer treatment.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Cancer Treatment Support', 180, sb_g_cancer_support),
    (92,  'Slippery elm for pain reduction as digestive support during chemotherapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Cancer Treatment Support', 190, sb_g_cancer_support),

    -- Section: Chemotherapy Support (sort 200–240)
    (45,  'Marshmallow root for immune support and nourishment during chemotherapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Chemotherapy Support', 200, sb_g_chemo),
    (28,  'Cleavers for metabolic waste removal during chemotherapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Chemotherapy Support', 210, sb_g_chemo),
    (43,  'Nettle for blood support and minerals during chemotherapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Chemotherapy Support', 220, sb_g_chemo),
    (79,  'Witch hazel leaf for cooling, anti-inflammatory, and tissue-soothing support during chemotherapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Chemotherapy Support', 230, sb_g_chemo);

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_claw_id, 'Cat''s claw for cooling, anti-inflammatory, and tissue-soothing support during chemotherapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Chemotherapy Support', 240, sb_g_chemo),

    -- Section: Herbal Support Strategy (sort 250–270)
    (288, 'Black walnut is a key herb in the herbal support strategy for cancer care.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Support Strategy', 250, sb_g_strategy),
    (144, 'Damiana is a key herb in the herbal support strategy for cancer care.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Support Strategy', 260, sb_g_strategy),
    (20,  'Ashwagandha is a key herb in the herbal support strategy for cancer care.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Support Strategy', 270, sb_g_strategy),

    -- Section: Formulary Development (sort 280–300)
    (81,  'St. John''s wort in herbal tonic formula for blood cleansing; Stage 3 cancer case study, African American male, 59.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Formulary Development', 280, sb_g_formulary),
    (132, 'Indian tobacco (lobelia) in herbal tonic formula for blood cleansing; Stage 3 cancer case study, African American male, 59.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Formulary Development', 290, sb_g_formulary),
    (288, 'Black walnut for circulatory and lymphatic involvement in Stage 3 cancer case study, African American male, 59.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Formulary Development', 300, sb_g_formulary),

    -- Section: Client Case Review (sort 310–330)
    (2601,'CBD recommended in client herbal tea for cancer support alongside turmeric and passionflower.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Client Case Review', 310, sb_g_client),
    (203, 'Turmeric recommended in client herbal tea for cancer support alongside CBD and passionflower.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Client Case Review', 320, sb_g_client),
    (137, 'Passionflower recommended in client herbal tea for cancer support alongside CBD and turmeric.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Client Case Review', 330, sb_g_client),

    -- Section: Herb Preparation and Effects (sort 340–370)
    (43,  'Nettle included in cold infusion tea for mineral extraction; dark tea color indicates mineral presence.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herb Preparation and Effects', 340, sb_g_prep),
    (155, 'Red raspberry included in cold infusion tea for mineral extraction and therapeutic effects.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herb Preparation and Effects', 350, sb_g_prep),
    (2287,'Oat straw included in cold infusion tea for mineral extraction.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herb Preparation and Effects', 360, sb_g_prep),
    (1648,'Dandelion included in cold infusion tea for mineral extraction and therapeutic effects.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herb Preparation and Effects', 370, sb_g_prep),

    -- Section: Herbal Formulas and Adjustments (sort 380–440)
    (2381,'Bacopa mentioned for stress and sleep support formula updates in patient case followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 380, sb_g_formulas),
    (2229,'Gotu kola mentioned for stress and sleep support formula updates in patient case followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 390, sb_g_formulas),
    (84,  'Chamomile added to stress and sleep support formula as sleep aid in patient case followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 400, sb_g_formulas),
    (136, 'Catnip added to stress and sleep support formula as sleep aid option in patient case followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 410, sb_g_formulas),
    (145, 'Valerian considered for stress and sleep support formula as sleep aid in patient case followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 420, sb_g_formulas),
    (155, 'Red raspberry in infusion tea; substituted with horsetail for better diaphoretic action in patient case followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 430, sb_g_formulas),
    (151, 'Horsetail substituted for red raspberry in infusion; gentle diaphoretic that gently opens pores for sweating.',
     'BHC - Class 69 - Holistic Cancer Support', 'generated', 'Herbal Formulas and Adjustments', 440, sb_g_formulas);

  -- ============================================================
  -- PERSONAL NOTES
  -- ============================================================

  -- Section: Shereel's Cancer Report (sort 10–170)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (288,  'Black walnut leaf and hull — worms (digestive) in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 10, sb_p_cancer_report),
    (22,   'Burdock root — stomach ache and cramp in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 20, sb_p_cancer_report),
    (136,  'Catnip — diarrhea and colic in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 30, sb_p_cancer_report);

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_asaf_id, 'Asafetida — digestion in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 40, sb_p_cancer_report),
    (26,   'Echinacea root — antiseptic and analgesic (lymphatic) in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 50, sb_p_cancer_report),
    (61,   'Mullein leaf and flower — cold, fever, inflammation, and hidden disease (lymphatic) in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 60, sb_p_cancer_report),
    (95,   'Corn (shuck) — for measles, malaria, smallpox (lymphatic) in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 70, sb_p_cancer_report),
    (2643, 'Pine (needles and resin) — lymphatic support in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 80, sb_p_cancer_report),
    (313,  'Sassafras — nervine in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 90, sb_p_cancer_report),
    (35,   'Poke root — nervine in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 100, sb_p_cancer_report),
    (132,  'Lobelia — nervine in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 110, sb_p_cancer_report),
    (21,   'Garlic — viral and bacterial infection in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 120, sb_p_cancer_report),
    (208,  'Red onion — viral and bacterial infection in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 130, sb_p_cancer_report),
    (160,  'Horehound — viral and bacterial infection in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 140, sb_p_cancer_report),
    (56,   'Sage — viral and bacterial infection in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 150, sb_p_cancer_report),
    (2635, 'Cotton root — hormonal stabilizer in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 160, sb_p_cancer_report),
    (25,   'Black cohosh root — hormonal stabilizer in Shereel''s 2022 cancer report.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Shereel''s Cancer Report', 170, sb_p_cancer_report);

  -- Section: Herbal Actions (sort 180–210)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (35,   'Poke root listed as anticarcinogenic: inhibits, mitigates, prevents, and can help cure cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Herbal Actions', 180, sb_p_actions),
    (313,  'Sassafras listed as anticarcinogenic: inhibits, mitigates, prevents, and can help cure cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Herbal Actions', 190, sb_p_actions),
    (21,   'Garlic listed as anticarcinogenic: inhibits, mitigates, prevents, and can help cure cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Herbal Actions', 200, sb_p_actions),
    (288,  'Black walnut leaf and hull listed as anticarcinogenic: inhibits, mitigates, prevents, and can help cure cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Herbal Actions', 205, sb_p_actions);

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_asaf_id, 'Asafetida listed as anticarcinogenic: inhibits, mitigates, prevents, and can help cure cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Herbal Actions', 210, sb_p_actions);

  -- Section: Anti-Cancer Formula 1 (sort 220–280)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (21,   'Garlic in anti-cancer formula 1 to quickly change the environment in early-stage cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 220, sb_p_formula1),
    (22,   'Burdock root in anti-cancer formula 1 to quickly change the environment in early-stage cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 230, sb_p_formula1),
    (288,  'Black walnut leaves in anti-cancer formula 1 to quickly change the environment in early-stage cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 240, sb_p_formula1),
    (79,   'Witch hazel leaves in anti-cancer formula 1 to quickly change the environment in early-stage cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 250, sb_p_formula1),
    (45,   'Marshmallow root in anti-cancer formula 1 for cooling in early-stage cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 260, sb_p_formula1),
    (320,  'Peach leaves in anti-cancer formula 1 to relieve stomach pain and support healthy elimination.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 270, sb_p_formula1);

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_asaf_id, 'Asafetida in anti-cancer formula 1 as nervine to calm and reduce pain in early-stage cancer.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 1', 280, sb_p_formula1);

  -- Section: Anti-Cancer Formula 2 (sort 290–380)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (21,   'Garlic in anti-cancer formula 2: more intense formula used in stages after formula 1; keep getting tested.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 290, sb_p_formula2),
    (288,  'Black walnut hulls in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 300, sb_p_formula2),
    (28,   'Cleavers in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 310, sb_p_formula2),
    (79,   'Witch hazel bark in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 320, sb_p_formula2),
    (313,  'Sassafras root in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 330, sb_p_formula2),
    (25,   'Black cohosh in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 340, sb_p_formula2),
    (81,   'St. John''s wort in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 350, sb_p_formula2),
    (89,   'Comfrey in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 360, sb_p_formula2),
    (35,   'Poke root in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 370, sb_p_formula2),
    (121,  'Feverfew in anti-cancer formula 2: more intense formula used in stages after formula 1.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Anti-Cancer Formula 2', 380, sb_p_formula2),

    -- Section: Lymphatic Herbs (sort 390–460)
    (288,  'Black walnut listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 390, sb_p_lymphatic),
    (22,   'Burdock root listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 400, sb_p_lymphatic),
    (1651, 'Elderberry listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 410, sb_p_lymphatic),
    (35,   'Poke root listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 420, sb_p_lymphatic),
    (313,  'Sassafras listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 430, sb_p_lymphatic),
    (320,  'Peach listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 440, sb_p_lymphatic),
    (2498, 'Black pepper listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 450, sb_p_lymphatic),
    (81,   'St. John''s wort listed as lymphatic herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Lymphatic Herbs', 460, sb_p_lymphatic);

  -- Section: Nervines and Anti-Inflammatories (sort 470–590)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (25,   'Black cohosh listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 470, sb_p_nervine),
    (136,  'Catnip listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 480, sb_p_nervine),
    (89,   'Comfrey listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 490, sb_p_nervine),
    (95,   'Corn listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 500, sb_p_nervine),
    (320,  'Peach listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 510, sb_p_nervine),
    (81,   'St. John''s wort listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 520, sb_p_nervine),
    (45,   'Marshmallow root for chemo support: nourishing, cooling, and tissue protective in tea.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 530, sb_p_nervine),
    (28,   'Cleavers for chemo support: removes metabolic waste and radiation chemicals in tea.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 540, sb_p_nervine),
    (43,   'Nettle for chemo support: cooling, nutritive, provides minerals in tea.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 550, sb_p_nervine),
    (79,   'Witch hazel leaf for chemo support: cooling, anti-inflammatory, heals tissue, breaks up scar tissue in tea.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 560, sb_p_nervine),
    (35,   'Poke root (low dose) for chemo support: breaks up tumors and scar tissue in tea.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 570, sb_p_nervine),
    (313,  'Sassafras for chemo support: good taste, soothes nerves, reduces inflamed and hot tissue in tea.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 580, sb_p_nervine);

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_asaf_id, 'Asafetida listed as nervine and anti-inflammatory herb for cancer support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Nervines and Anti-Inflammatories', 590, sb_p_nervine);

  -- Section: 7 Principles of Cancer Therapy — supplement snippet (sort 600)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (10, 'Vitamin C therapy (biologics) listed as one of the 7 principles of non-toxic cancer therapy.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', '7 Principles of Cancer Therapy', 600, sb_p_7principles);

  -- Section: Feri (Patient Case) (sort 610–650)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (19, 'Iron tincture added to Feri''s formula to address iron deficiency noted in followup.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Feri (Patient Case)', 610, sb_p_feri);

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (155,  'Red raspberry in Feri''s infusion tea; swapped out for horsetail to alleviate nighttime urination.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Feri (Patient Case)', 620, sb_p_feri),
    (151,  'Horsetail substituted for red raspberry in Feri''s infusion tea; gentle diaphoretic to alleviate nighttime urination.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Feri (Patient Case)', 630, sb_p_feri),
    (142,  'Skullcap added to Feri''s stress glycerite (with catnip) to be taken at night for sleep support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Feri (Patient Case)', 640, sb_p_feri),
    (136,  'Catnip added to Feri''s stress glycerite (with skullcap) to be taken at night for sleep support.',
     'BHC - Class 69 - Holistic Cancer Support', 'personal', 'Feri (Patient Case)', 650, sb_p_feri);

  RAISE NOTICE 'Class 69 snippets loaded: generated + personal notes.';
END $$;

-- ============================================================
-- HERB KEYWORDS
-- ============================================================

-- Cancer support — all herbs appearing in cancer-care sections
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (288,  'cancer support',    'ailment'),
  (22,   'cancer support',    'ailment'),
  (136,  'cancer support',    'ailment'),
  (61,   'cancer support',    'ailment'),
  (95,   'cancer support',    'ailment'),
  (21,   'cancer support',    'ailment'),
  (208,  'cancer support',    'ailment'),
  (2635, 'cancer support',    'ailment'),
  (119,  'cancer support',    'ailment'),
  (25,   'cancer support',    'ailment'),
  (202,  'cancer support',    'ailment'),
  (40,   'cancer support',    'ailment'),
  (35,   'cancer support',    'ailment'),
  (45,   'cancer support',    'ailment'),
  (92,   'cancer support',    'ailment'),
  (28,   'cancer support',    'ailment'),
  (43,   'cancer support',    'ailment'),
  (79,   'cancer support',    'ailment'),
  (144,  'cancer support',    'ailment'),
  (20,   'cancer support',    'ailment'),
  (81,   'cancer support',    'ailment'),
  (132,  'cancer support',    'ailment'),
  (2601, 'cancer support',    'ailment'),
  (203,  'cancer support',    'ailment'),
  (137,  'cancer support',    'ailment'),
  (26,   'cancer support',    'ailment'),
  (2643, 'cancer support',    'ailment'),
  (313,  'cancer support',    'ailment'),
  (160,  'cancer support',    'ailment'),
  (56,   'cancer support',    'ailment'),
  (2498, 'cancer support',    'ailment'),
  (1651, 'cancer support',    'ailment'),
  (320,  'cancer support',    'ailment'),
  (121,  'cancer support',    'ailment'),
  (89,   'cancer support',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Add cancer support for new herbs via subquery (v_asaf_id and v_claw_id not available outside DO block)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, 'cancer support', 'ailment' FROM herbal.herbs
WHERE latin_name IN ('Ferula asafoetida', 'Uncaria tomentosa')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chemotherapy support (new keyword) — herbs in chemo support sections
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45,  'chemotherapy support', 'ailment'),
  (28,  'chemotherapy support', 'ailment'),
  (43,  'chemotherapy support', 'ailment'),
  (79,  'chemotherapy support', 'ailment'),
  (35,  'chemotherapy support', 'ailment'),
  (313, 'chemotherapy support', 'ailment'),
  (92,  'chemotherapy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, 'chemotherapy support', 'ailment' FROM herbal.herbs
WHERE latin_name = 'Uncaria tomentosa'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Blood cleansing (new keyword) — herbs in blood cleaning / lymphatic sections
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (288, 'blood cleansing', 'ailment'),
  (22,  'blood cleansing', 'ailment'),
  (81,  'blood cleansing', 'ailment'),
  (132, 'blood cleansing', 'ailment'),
  (35,  'blood cleansing', 'ailment'),
  (313, 'blood cleansing', 'ailment'),
  (28,  'blood cleansing', 'ailment'),
  (1651,'blood cleansing', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lymphatic support — herbs in lymphatic sections
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (288,  'lymphatic support', 'ailment'),
  (22,   'lymphatic support', 'ailment'),
  (1651, 'lymphatic support', 'ailment'),
  (35,   'lymphatic support', 'ailment'),
  (313,  'lymphatic support', 'ailment'),
  (320,  'lymphatic support', 'ailment'),
  (2498, 'lymphatic support', 'ailment'),
  (81,   'lymphatic support', 'ailment'),
  (40,   'lymphatic support', 'ailment'),
  (61,   'lymphatic support', 'ailment'),
  (2643, 'lymphatic support', 'ailment'),
  (26,   'lymphatic support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Anticarcinogenic action — herbs explicitly named anticarcinogenic
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (35,  'anticarcinogenic', 'action'),
  (313, 'anticarcinogenic', 'action'),
  (21,  'anticarcinogenic', 'action'),
  (288, 'anticarcinogenic', 'action'),
  (202, 'anticarcinogenic', 'action'),
  (40,  'anticarcinogenic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, 'anticarcinogenic', 'action' FROM herbal.herbs
WHERE latin_name IN ('Ferula asafoetida', 'Uncaria tomentosa')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nervine action — herbs listed in nervine section
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (25,  'nervine', 'action'),
  (136, 'nervine', 'action'),
  (89,  'nervine', 'action'),
  (95,  'nervine', 'action'),
  (320, 'nervine', 'action'),
  (81,  'nervine', 'action'),
  (313, 'nervine', 'action'),
  (132, 'nervine', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, 'nervine', 'action' FROM herbal.herbs
WHERE latin_name = 'Ferula asafoetida'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (10, 'cancer support',    'ailment'),
  (10, 'immune support',    'ailment'),
  (19, 'anemia',            'ailment'),
  (19, 'iron deficiency',   'ailment'),
  (19, 'heavy bleeding',    'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Feri case herbs — sleep and urinary keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (142, 'sleep support', 'ailment'),
  (142, 'stress',        'ailment'),
  (151, 'incontinence',  'ailment'),
  (151, 'sleep support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- AILMENT SEARCH SYNONYMS (new keywords only)
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('chemotherapy support',
   ARRAY['chemo support', 'chemotherapy recovery', 'chemo detox', 'cancer treatment support',
         'radiation support', 'oncology support', 'chemo side effects']),
  ('blood cleansing',
   ARRAY['blood detox', 'blood purification', 'blood purifying', 'depurative',
         'alterative therapy', 'blood cleaning'])
ON CONFLICT (ailment_keyword) DO NOTHING;
