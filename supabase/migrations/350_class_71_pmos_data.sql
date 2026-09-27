-- Migration 350: Class 71 — PMOS (Polyendocrine Metabolic Ovarian Syndrome)
-- Files parsed:
--   BHC - Class 71 - PMOS - Generated Notes.md  (note_type='generated')
--   BHC - Class 71 - PMOS - Lisa.md             (note_type='personal')
--   BHC - Class 71 - PMOS - Transcript.md       IGNORED
--
-- class_name: 'BHC - Class 71 - PMOS'
--
-- Normalisations:
--   Vitex → Chasteberry (id=190)
--   OGR / Oregon Grape Root → Oregon Grape (id=33)
--   SJW → St. John's Wort (id=81)
--   Iris → Blue Flag (id=31)
--   AI → anti-inflammatory (not artificial intelligence)
--   AO → antioxidant
--   BS → blood sugar
--
-- Skipped (not in DB or inappropriate):
--   Carob — legume/food, included in tea blend for nutritional inositol content; not in herbs DB
--   Sunchokes — food (Jerusalem artichoke); not in DB
--   Melatonin — not in supplements DB
--   Betaine HCL — digestive supplement; not in supplements DB
--   Castor oil / ghee — preparations
--   Fire cider / ACV — preparations
--   Sour cherry — mentioned as HCL stimulant, culinary use; not in herbs DB
--
-- Existing pairs (no new pairs migration needed):
--   Licorice + White Peony → already in herb_pairs (BHC class notes)
--   Chasteberry + Dong Quai → already in herb_pairs (Class 65, migration 294)
--
-- New ailment keywords: PMOS, hirsutism, menstrual irregularity, ovulation support, hyperandrogenism

SET search_path TO herbal, public;

-- ============================================================
-- SNIPPETS — GENERATED NOTES
-- ============================================================

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 71 - PMOS'
      AND note_type = 'generated'
  ) THEN
    RAISE NOTICE 'Class 71 PMOS generated snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- Personal Formulation Experiences
    -- source_block shared by all 10 herbs in this section
    (81, 'St. John''s wort, schizandra, ginseng used together in a personal adaptogen formula.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 10,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (17, 'St. John''s wort, schizandra, ginseng used together in a personal adaptogen formula.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 20,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (14, 'St. John''s wort, schizandra, ginseng used together in a personal adaptogen formula.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 30,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (16, 'Rhodiola, cardamom, fennel tincture at five drops, three times a day.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 40,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (127, 'Rhodiola, cardamom, fennel tincture at five drops, three times a day.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 50,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (76, 'Rhodiola, cardamom, fennel tincture at five drops, three times a day.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 60,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (122, 'Dandelion, lemon balm, nettle, fresh ginger tea — less bloated, decreased water retention, pause before reacting.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 70,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (134, 'Dandelion, lemon balm, nettle, fresh ginger tea — less bloated, decreased water retention, pause before reacting.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 80,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (43, 'Dandelion, lemon balm, nettle, fresh ginger tea — less bloated, decreased water retention, pause before reacting.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 90,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    (124, 'Dandelion, lemon balm, nettle, fresh ginger tea — less bloated, decreased water retention, pause before reacting.',
     'BHC - Class 71 - PMOS', 'generated', 'Personal Formulation Experiences', 100,
     '### Personal Formulation Experiences
- St. John''s wort, schizandra, ginseng
- Rhodiola, cardamom, fennel tincture
	- Five drops, three times a day
- Dandelion, lemon balm, nettle, fresh ginger tea
	- Less bloated, decreased water retention
	- Pause before reacting'),

    -- Stress Support (cleaned from "Stress Preparation Formulation")
    (134, 'Lemon balm glycerite, hibiscus, hawthorn, rhodiola — clarity and calmness in body.',
     'BHC - Class 71 - PMOS', 'generated', 'Stress Support', 110,
     '### Stress Preparation Formulation
- Lemon balm glycerite, hibiscus, hawthorn, rhodiola
	- Clarity and calmness in body'),

    (2233, 'Lemon balm glycerite, hibiscus, hawthorn, rhodiola — clarity and calmness in body.',
     'BHC - Class 71 - PMOS', 'generated', 'Stress Support', 120,
     '### Stress Preparation Formulation
- Lemon balm glycerite, hibiscus, hawthorn, rhodiola
	- Clarity and calmness in body'),

    (73, 'Lemon balm glycerite, hibiscus, hawthorn, rhodiola — clarity and calmness in body.',
     'BHC - Class 71 - PMOS', 'generated', 'Stress Support', 130,
     '### Stress Preparation Formulation
- Lemon balm glycerite, hibiscus, hawthorn, rhodiola
	- Clarity and calmness in body'),

    (16, 'Lemon balm glycerite, hibiscus, hawthorn, rhodiola — clarity and calmness in body.',
     'BHC - Class 71 - PMOS', 'generated', 'Stress Support', 140,
     '### Stress Preparation Formulation
- Lemon balm glycerite, hibiscus, hawthorn, rhodiola
	- Clarity and calmness in body'),

    -- Adaptogen Protocol (cleaned from "New Tincture Protocol")
    (11, 'Reishi, astragalus, schizandra used together in an adaptogen/immune tonic protocol.',
     'BHC - Class 71 - PMOS', 'generated', 'Adaptogen Protocol', 150,
     '### New Tincture Protocol
- Reishi, astragalus, schizandra
	- Natural pause aligning with protocol start'),

    (225, 'Reishi, astragalus, schizandra used together in an adaptogen/immune tonic protocol.',
     'BHC - Class 71 - PMOS', 'generated', 'Adaptogen Protocol', 160,
     '### New Tincture Protocol
- Reishi, astragalus, schizandra
	- Natural pause aligning with protocol start'),

    (17, 'Reishi, astragalus, schizandra used together in an adaptogen/immune tonic protocol.',
     'BHC - Class 71 - PMOS', 'generated', 'Adaptogen Protocol', 170,
     '### New Tincture Protocol
- Reishi, astragalus, schizandra
	- Natural pause aligning with protocol start'),

    -- PMOS Treatment
    (206, 'Milk thistle for liver function — a key step in PMOS treatment addressing blood health.',
     'BHC - Class 71 - PMOS', 'generated', 'PMOS Treatment', 180,
     '## Diagnosis and Treatment Strategies
- Labs and PMOS markers
	- Anti-Müllerian hormone (AMH) as a marker
	- Specific lab requests
- Treatment steps
	- Lymphatic health
	- Blood health — milk thistle for liver function
	- Muscle engagement, skin health
	- Bone health via weight-bearing exercise
	- Nervous system support with nervines
	- Hormone balance, circulation techniques'),

    -- Inflammatory Reduction
    (203, 'Anti-inflammatory herbs for PMOS: turmeric and ginger.',
     'BHC - Class 71 - PMOS', 'generated', 'Inflammatory Reduction', 190,
     '### Inflammatory Reduction
- Anti-inflammatory herbs: turmeric, ginger
	- St. John''s wort, meadowsweet, black cohosh for pain
	- Vegan diet, elimination of inflammatory foods recommended'),

    (124, 'Anti-inflammatory herbs for PMOS: turmeric and ginger.',
     'BHC - Class 71 - PMOS', 'generated', 'Inflammatory Reduction', 200,
     '### Inflammatory Reduction
- Anti-inflammatory herbs: turmeric, ginger
	- St. John''s wort, meadowsweet, black cohosh for pain
	- Vegan diet, elimination of inflammatory foods recommended'),

    (81, 'St. John''s wort, meadowsweet, black cohosh for pain in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Inflammatory Reduction', 210,
     '### Inflammatory Reduction
- Anti-inflammatory herbs: turmeric, ginger
	- St. John''s wort, meadowsweet, black cohosh for pain
	- Vegan diet, elimination of inflammatory foods recommended'),

    (75, 'St. John''s wort, meadowsweet, black cohosh for pain in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Inflammatory Reduction', 220,
     '### Inflammatory Reduction
- Anti-inflammatory herbs: turmeric, ginger
	- St. John''s wort, meadowsweet, black cohosh for pain
	- Vegan diet, elimination of inflammatory foods recommended'),

    (25, 'St. John''s wort, meadowsweet, black cohosh for pain in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Inflammatory Reduction', 230,
     '### Inflammatory Reduction
- Anti-inflammatory herbs: turmeric, ginger
	- St. John''s wort, meadowsweet, black cohosh for pain
	- Vegan diet, elimination of inflammatory foods recommended'),

    -- Fertility Support (inositol-rich tea blend)
    (225, 'Part of an inositol-rich tea blend for PMOS/fertility support: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'generated', 'Fertility Support', 240,
     '## Fertility Support
- inositol-rich tea blend
	- Includes astragalus, licorice, red clover, alfalfa, kudzu, carob
- Inositols in legumes
	- Improve insulin response
	- Enhance signal transduction with insulin binding
- Phytosterols: selective estrogen receptor modifiers
	- Dysfunctional in PMOS
- Legume-rich tea: fertility support'),

    (78, 'Part of an inositol-rich tea blend for PMOS/fertility support: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'generated', 'Fertility Support', 250,
     '## Fertility Support
- inositol-rich tea blend
	- Includes astragalus, licorice, red clover, alfalfa, kudzu, carob
- Inositols in legumes
	- Improve insulin response
	- Enhance signal transduction with insulin binding
- Phytosterols: selective estrogen receptor modifiers
	- Dysfunctional in PMOS
- Legume-rich tea: fertility support'),

    (42, 'Part of an inositol-rich tea blend for PMOS/fertility support: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'generated', 'Fertility Support', 260,
     '## Fertility Support
- inositol-rich tea blend
	- Includes astragalus, licorice, red clover, alfalfa, kudzu, carob
- Inositols in legumes
	- Improve insulin response
	- Enhance signal transduction with insulin binding
- Phytosterols: selective estrogen receptor modifiers
	- Dysfunctional in PMOS
- Legume-rich tea: fertility support'),

    (885, 'Part of an inositol-rich tea blend for PMOS/fertility support: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'generated', 'Fertility Support', 270,
     '## Fertility Support
- inositol-rich tea blend
	- Includes astragalus, licorice, red clover, alfalfa, kudzu, carob
- Inositols in legumes
	- Improve insulin response
	- Enhance signal transduction with insulin binding
- Phytosterols: selective estrogen receptor modifiers
	- Dysfunctional in PMOS
- Legume-rich tea: fertility support'),

    (1547, 'Part of an inositol-rich tea blend for PMOS/fertility support: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'generated', 'Fertility Support', 280,
     '## Fertility Support
- inositol-rich tea blend
	- Includes astragalus, licorice, red clover, alfalfa, kudzu, carob
- Inositols in legumes
	- Improve insulin response
	- Enhance signal transduction with insulin binding
- Phytosterols: selective estrogen receptor modifiers
	- Dysfunctional in PMOS
- Legume-rich tea: fertility support'),

    -- Blood Sugar and Lipid Regulation
    (13, 'Holy basil: adaptogen for blood sugar metabolism in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Blood Sugar and Lipid Regulation', 340,
     '## Blood Sugar and Lipid Regulation
- Holy basil: adaptogen for blood sugar metabolism
- Reishi: addresses elevated androgen
	- Reduces 5-alpha-reductase enzyme
- Berberine-containing plants
	- Improve blood sugar and cholesterol levels
- Spearmint: Mentha spicata
	- Lowers testosterone, reduces hirsutism'),

    (11, 'Reishi addresses elevated androgen in PMOS by reducing 5-alpha-reductase enzyme.',
     'BHC - Class 71 - PMOS', 'generated', 'Blood Sugar and Lipid Regulation', 350,
     '## Blood Sugar and Lipid Regulation
- Holy basil: adaptogen for blood sugar metabolism
- Reishi: addresses elevated androgen
	- Reduces 5-alpha-reductase enzyme
- Berberine-containing plants
	- Improve blood sugar and cholesterol levels
- Spearmint: Mentha spicata
	- Lowers testosterone, reduces hirsutism'),

    (33, 'Berberine-containing plants (e.g., Oregon Grape) improve blood sugar and cholesterol levels in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Blood Sugar and Lipid Regulation', 360,
     '## Blood Sugar and Lipid Regulation
- Holy basil: adaptogen for blood sugar metabolism
- Reishi: addresses elevated androgen
	- Reduces 5-alpha-reductase enzyme
- Berberine-containing plants
	- Improve blood sugar and cholesterol levels
- Spearmint: Mentha spicata
	- Lowers testosterone, reduces hirsutism'),

    (2607, 'Spearmint (Mentha spicata) lowers testosterone and reduces hirsutism in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Blood Sugar and Lipid Regulation', 370,
     '## Blood Sugar and Lipid Regulation
- Holy basil: adaptogen for blood sugar metabolism
- Reishi: addresses elevated androgen
	- Reduces 5-alpha-reductase enzyme
- Berberine-containing plants
	- Improve blood sugar and cholesterol levels
- Spearmint: Mentha spicata
	- Lowers testosterone, reduces hirsutism'),

    -- Hormonal Balance and Reproductive Health
    (190, 'Vitex reduces elevated prolactin, lengthens luteal phase, increases progesterone, and supports pregnancy; acts via dopamine activity on the hypothalamic-pituitary axis.',
     'BHC - Class 71 - PMOS', 'generated', 'Hormonal Balance and Reproductive Health', 380,
     '## Hormonal Balance and Reproductive Health
- Vitex
	- Reduces elevated prolactin, lengthens luteal phase
	- Increases progesterone, supports pregnancy
	- Dopamine activity, influences hypothalamic-pituitary axis
- Licorice and White Peony
	- Improves insulin resistance
	- Reduces elevated testosterone and prolactin (especially from risperidone)'),

    (78, 'Licorice and White Peony together: improve insulin resistance and reduce elevated testosterone and prolactin, especially prolactin elevated by risperidone.',
     'BHC - Class 71 - PMOS', 'generated', 'Hormonal Balance and Reproductive Health', 390,
     '## Hormonal Balance and Reproductive Health
- Vitex
	- Reduces elevated prolactin, lengthens luteal phase
	- Increases progesterone, supports pregnancy
	- Dopamine activity, influences hypothalamic-pituitary axis
- Licorice and White Peony
	- Improves insulin resistance
	- Reduces elevated testosterone and prolactin (especially from risperidone)'),

    (2238, 'Licorice and White Peony together: improve insulin resistance and reduce elevated testosterone and prolactin, especially prolactin elevated by risperidone.',
     'BHC - Class 71 - PMOS', 'generated', 'Hormonal Balance and Reproductive Health', 400,
     '## Hormonal Balance and Reproductive Health
- Vitex
	- Reduces elevated prolactin, lengthens luteal phase
	- Increases progesterone, supports pregnancy
	- Dopamine activity, influences hypothalamic-pituitary axis
- Licorice and White Peony
	- Improves insulin resistance
	- Reduces elevated testosterone and prolactin (especially from risperidone)'),

    -- PMOS Formula (Licorice + White Peony + Cinnamon + Gotu Kola; OGR in Lisa's notes only)
    (78, 'Licorice, white peony, cinnamon, gotu kola PMOS formula — supports extracellular matrix.',
     'BHC - Class 71 - PMOS', 'generated', 'PMOS Formula', 410,
     '## Herbal Combinations and Formulas
- Licorice, white peony, cinnamon, gotu kola formula
	- Supports extracellular matrix
	- Cinnamon: Cinnamomum verum, hypoglycemic and hypolipidemic
	- Gotu kola: connective tissue support'),

    (2238, 'Licorice, white peony, cinnamon, gotu kola PMOS formula — supports extracellular matrix.',
     'BHC - Class 71 - PMOS', 'generated', 'PMOS Formula', 420,
     '## Herbal Combinations and Formulas
- Licorice, white peony, cinnamon, gotu kola formula
	- Supports extracellular matrix
	- Cinnamon: Cinnamomum verum, hypoglycemic and hypolipidemic
	- Gotu kola: connective tissue support'),

    (167, 'Cinnamon (Cinnamomum verum) in PMOS formula: hypoglycemic and hypolipidemic.',
     'BHC - Class 71 - PMOS', 'generated', 'PMOS Formula', 430,
     '## Herbal Combinations and Formulas
- Licorice, white peony, cinnamon, gotu kola formula
	- Supports extracellular matrix
	- Cinnamon: Cinnamomum verum, hypoglycemic and hypolipidemic
	- Gotu kola: connective tissue support'),

    (2229, 'Gotu kola provides connective tissue and extracellular matrix support in the PMOS formula.',
     'BHC - Class 71 - PMOS', 'generated', 'PMOS Formula', 440,
     '## Herbal Combinations and Formulas
- Licorice, white peony, cinnamon, gotu kola formula
	- Supports extracellular matrix
	- Cinnamon: Cinnamomum verum, hypoglycemic and hypolipidemic
	- Gotu kola: connective tissue support'),

    -- Clinical Observations
    (167, 'Cinnamon for metabolic health: increases blood circulation and promotes tissue regeneration.',
     'BHC - Class 71 - PMOS', 'generated', 'Clinical Observations', 450,
     '## Clinical Observations
- Cinnamon for metabolic health
	- Increases blood circulation, promotes tissue regeneration
- Comprehensive lifestyle changes for lasting metabolic health improvements
- Poke, Phytolacca americana
	- For metabolic disruptions, lipid issues
	- Lymphatic stimulation'),

    (35, 'Poke (Phytolacca americana) for metabolic disruptions, lipid issues, and lymphatic stimulation.',
     'BHC - Class 71 - PMOS', 'generated', 'Clinical Observations', 460,
     '## Clinical Observations
- Cinnamon for metabolic health
	- Increases blood circulation, promotes tissue regeneration
- Comprehensive lifestyle changes for lasting metabolic health improvements
- Poke, Phytolacca americana
	- For metabolic disruptions, lipid issues
	- Lymphatic stimulation');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS — GENERATED NOTES
-- ============================================================

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 71 - PMOS'
      AND note_type = 'generated'
      AND supplement_id IS NOT NULL
  ) THEN
    RAISE NOTICE 'Class 71 PMOS generated supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (11, 'Vitamin D: supports inflammation and ovarian health in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Vitamins and Supplements', 290,
     '### Vitamins and Supplements
- Vitamin D: supports inflammation, ovarian health
- Omega-3: improves insulin sensitivity, reduces testosterone
- NAC: comparable to metformin for insulin regulation
- Melatonin: beneficial for insulin metabolism
- Inositol: helps with insulin resistance, fertility improvement
- L-carnitine: improves ovulation rates'),

    (33, 'Omega-3: improves insulin sensitivity and reduces testosterone in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Vitamins and Supplements', 300,
     '### Vitamins and Supplements
- Vitamin D: supports inflammation, ovarian health
- Omega-3: improves insulin sensitivity, reduces testosterone
- NAC: comparable to metformin for insulin regulation
- Melatonin: beneficial for insulin metabolism
- Inositol: helps with insulin resistance, fertility improvement
- L-carnitine: improves ovulation rates'),

    (29, 'NAC: comparable to metformin for insulin regulation in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Vitamins and Supplements', 310,
     '### Vitamins and Supplements
- Vitamin D: supports inflammation, ovarian health
- Omega-3: improves insulin sensitivity, reduces testosterone
- NAC: comparable to metformin for insulin regulation
- Melatonin: beneficial for insulin metabolism
- Inositol: helps with insulin resistance, fertility improvement
- L-carnitine: improves ovulation rates'),

    (35, 'Inositol: helps with insulin resistance and fertility improvement in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Vitamins and Supplements', 320,
     '### Vitamins and Supplements
- Vitamin D: supports inflammation, ovarian health
- Omega-3: improves insulin sensitivity, reduces testosterone
- NAC: comparable to metformin for insulin regulation
- Melatonin: beneficial for insulin metabolism
- Inositol: helps with insulin resistance, fertility improvement
- L-carnitine: improves ovulation rates'),

    (26, 'L-carnitine improves ovulation rates in PMOS.',
     'BHC - Class 71 - PMOS', 'generated', 'Vitamins and Supplements', 330,
     '### Vitamins and Supplements
- Vitamin D: supports inflammation, ovarian health
- Omega-3: improves insulin sensitivity, reduces testosterone
- NAC: comparable to metformin for insulin regulation
- Melatonin: beneficial for insulin metabolism
- Inositol: helps with insulin resistance, fertility improvement
- L-carnitine: improves ovulation rates');

END $$;

-- ============================================================
-- SNIPPETS — PERSONAL NOTES (Lisa.md)
-- ============================================================

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 71 - PMOS'
      AND note_type = 'personal'
      AND herb_id IS NOT NULL
  ) THEN
    RAISE NOTICE 'Class 71 PMOS personal herb snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- Check-in
    (43, 'Nettles and oat straw in broth — shared as a nourishing daily practice.',
     'BHC - Class 71 - PMOS', 'personal', 'Check-in', 10,
     '## Check-in
- recommendation -> as an herbalist, get your own herbalist
    - for outside perspective and insights
- neti pot + a drop of castor oil or ghee in the nose, for congestion
- nettles and oat straw in broth
- Getting Sick Blend:
    - echinacea
    - gotu kola
    - red root
    - elderberry glycerite'),

    (2287, 'Nettles and oat straw in broth — shared as a nourishing daily practice.',
     'BHC - Class 71 - PMOS', 'personal', 'Check-in', 20,
     '## Check-in
- recommendation -> as an herbalist, get your own herbalist
    - for outside perspective and insights
- neti pot + a drop of castor oil or ghee in the nose, for congestion
- nettles and oat straw in broth
- Getting Sick Blend:
    - echinacea
    - gotu kola
    - red root
    - elderberry glycerite'),

    (26, 'Getting Sick Blend: echinacea, gotu kola, red root, elderberry glycerite.',
     'BHC - Class 71 - PMOS', 'personal', 'Check-in', 30,
     '## Check-in
- recommendation -> as an herbalist, get your own herbalist
    - for outside perspective and insights
- neti pot + a drop of castor oil or ghee in the nose, for congestion
- nettles and oat straw in broth
- Getting Sick Blend:
    - echinacea
    - gotu kola
    - red root
    - elderberry glycerite'),

    (2229, 'Getting Sick Blend: echinacea, gotu kola, red root, elderberry glycerite.',
     'BHC - Class 71 - PMOS', 'personal', 'Check-in', 40,
     '## Check-in
- recommendation -> as an herbalist, get your own herbalist
    - for outside perspective and insights
- neti pot + a drop of castor oil or ghee in the nose, for congestion
- nettles and oat straw in broth
- Getting Sick Blend:
    - echinacea
    - gotu kola
    - red root
    - elderberry glycerite'),

    (981, 'Getting Sick Blend: echinacea, gotu kola, red root, elderberry glycerite.',
     'BHC - Class 71 - PMOS', 'personal', 'Check-in', 50,
     '## Check-in
- recommendation -> as an herbalist, get your own herbalist
    - for outside perspective and insights
- neti pot + a drop of castor oil or ghee in the nose, for congestion
- nettles and oat straw in broth
- Getting Sick Blend:
    - echinacea
    - gotu kola
    - red root
    - elderberry glycerite'),

    (1651, 'Getting Sick Blend: echinacea, gotu kola, red root, elderberry glycerite.',
     'BHC - Class 71 - PMOS', 'personal', 'Check-in', 60,
     '## Check-in
- recommendation -> as an herbalist, get your own herbalist
    - for outside perspective and insights
- neti pot + a drop of castor oil or ghee in the nose, for congestion
- nettles and oat straw in broth
- Getting Sick Blend:
    - echinacea
    - gotu kola
    - red root
    - elderberry glycerite'),

    -- Gut Health Support
    (22, 'Burdock — both pre- and pro-biotic; supports gut health and microbiome in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Gut Health Support', 70,
     '### Support Gut Health
    - prebiotics
        - burdock - both pre- and pro-biotic
        - sunchokes - inulin-rich
    - enough HCL - digestive fire cooking?
    - HCL burns out pathogens
    - Improve HCL?
        - ACV is one strategy - shot 1/2-1 ounce, 30 mins before eating
        - Sour cherry as a stimulant for HCL
        - Betaine HCL + pepsin for 2 weeks'),

    -- Inflammatory Reduction
    (203, 'Turmeric and ginger to comprehensively reduce inflammation in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Inflammatory Reduction', 80,
     '### Reduce inflammation
- we also want to comprehensively reduce inflammation
    - turmeric and ginger
    - SJW for nerve pain
    - sometime meadowsweet for general body pain
    - black cohosh
- try a vegan diet for 6 months
- flax is good - 1-2T, on top of food or cooked in, smoothie
- legumes are a critical complex carb, if tolerated'),

    (124, 'Turmeric and ginger to comprehensively reduce inflammation in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Inflammatory Reduction', 90,
     '### Reduce inflammation
- we also want to comprehensively reduce inflammation
    - turmeric and ginger
    - SJW for nerve pain
    - sometime meadowsweet for general body pain
    - black cohosh
- try a vegan diet for 6 months
- flax is good - 1-2T, on top of food or cooked in, smoothie
- legumes are a critical complex carb, if tolerated'),

    (81, 'SJW for nerve pain in PMOS; part of the anti-inflammatory protocol.',
     'BHC - Class 71 - PMOS', 'personal', 'Inflammatory Reduction', 100,
     '### Reduce inflammation
- we also want to comprehensively reduce inflammation
    - turmeric and ginger
    - SJW for nerve pain
    - sometime meadowsweet for general body pain
    - black cohosh
- try a vegan diet for 6 months
- flax is good - 1-2T, on top of food or cooked in, smoothie
- legumes are a critical complex carb, if tolerated'),

    (75, 'Meadowsweet sometimes used for general body pain in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Inflammatory Reduction', 110,
     '### Reduce inflammation
- we also want to comprehensively reduce inflammation
    - turmeric and ginger
    - SJW for nerve pain
    - sometime meadowsweet for general body pain
    - black cohosh
- try a vegan diet for 6 months
- flax is good - 1-2T, on top of food or cooked in, smoothie
- legumes are a critical complex carb, if tolerated'),

    (25, 'Black cohosh as part of the anti-inflammatory protocol for PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Inflammatory Reduction', 120,
     '### Reduce inflammation
- we also want to comprehensively reduce inflammation
    - turmeric and ginger
    - SJW for nerve pain
    - sometime meadowsweet for general body pain
    - black cohosh
- try a vegan diet for 6 months
- flax is good - 1-2T, on top of food or cooked in, smoothie
- legumes are a critical complex carb, if tolerated'),

    (180, 'Flax seed — 1-2 tablespoons daily on food, cooked in, or in a smoothie; good source of short-chain fatty acids and fiber for PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Inflammatory Reduction', 130,
     '### Reduce inflammation
- we also want to comprehensively reduce inflammation
    - turmeric and ginger
    - SJW for nerve pain
    - sometime meadowsweet for general body pain
    - black cohosh
- try a vegan diet for 6 months
- flax is good - 1-2T, on top of food or cooked in, smoothie
- legumes are a critical complex carb, if tolerated'),

    -- Inositol Rich Tea Blend (afternoon)
    (225, 'Inositol-rich tea blend for PMOS: astragalus, licorice, red clover, alfalfa, kudzu. Inositol enhances signal transduction when insulin binds to the cell membrane.',
     'BHC - Class 71 - PMOS', 'personal', 'Inositol Rich Tea Blend', 200,
     '## Inositol Rich Tea Blend
- Astragalus
- Licorice
- Red Clover
- Alfalfa
- Kudzu
- Carob
- inositol - enhances signal transduction when insulin binds to the cell membrane
- phytosterols - selective estrogen receptor modifiers
    - act as agonist or antagonist
    - upregulate or downregulate estrogen'),

    (78, 'Inositol-rich tea blend for PMOS: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'personal', 'Inositol Rich Tea Blend', 210,
     '## Inositol Rich Tea Blend
- Astragalus
- Licorice
- Red Clover
- Alfalfa
- Kudzu
- Carob
- inositol - enhances signal transduction when insulin binds to the cell membrane
- phytosterols - selective estrogen receptor modifiers
    - act as agonist or antagonist
    - upregulate or downregulate estrogen'),

    (42, 'Inositol-rich tea blend for PMOS: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'personal', 'Inositol Rich Tea Blend', 220,
     '## Inositol Rich Tea Blend
- Astragalus
- Licorice
- Red Clover
- Alfalfa
- Kudzu
- Carob
- inositol - enhances signal transduction when insulin binds to the cell membrane
- phytosterols - selective estrogen receptor modifiers
    - act as agonist or antagonist
    - upregulate or downregulate estrogen'),

    (885, 'Inositol-rich tea blend for PMOS: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'personal', 'Inositol Rich Tea Blend', 230,
     '## Inositol Rich Tea Blend
- Astragalus
- Licorice
- Red Clover
- Alfalfa
- Kudzu
- Carob
- inositol - enhances signal transduction when insulin binds to the cell membrane
- phytosterols - selective estrogen receptor modifiers
    - act as agonist or antagonist
    - upregulate or downregulate estrogen'),

    (1547, 'Inositol-rich tea blend for PMOS: astragalus, licorice, red clover, alfalfa, kudzu.',
     'BHC - Class 71 - PMOS', 'personal', 'Inositol Rich Tea Blend', 240,
     '## Inositol Rich Tea Blend
- Astragalus
- Licorice
- Red Clover
- Alfalfa
- Kudzu
- Carob
- inositol - enhances signal transduction when insulin binds to the cell membrane
- phytosterols - selective estrogen receptor modifiers
    - act as agonist or antagonist
    - upregulate or downregulate estrogen'),

    -- Materia Medica (bullet-point section before ### sub-headers)
    -- section_header = "Materia Medica" for herbs in the bullet list
    (13, 'Holy basil: adaptogen, improves blood sugar levels in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 250,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (11, 'Reishi: may reduce 5-alpha-reductase enzyme, supporting hormone-related hair loss in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 260,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (2633, 'Maitake: adaptogen and indicated to induce ovulation in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 270,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (33, 'Oregon Grape Root (or any berberine-containing plant): reduces blood sugar and lipid levels in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 280,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (2607, 'Spearmint (Mentha spicata): daily infusion for 30 days shown to lower testosterone and reduce hirsutism (facial hair) in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 290,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (190, 'Vitex: reduces elevated prolactin, lengthens luteal phase, increases progesterone and pregnancy rates in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 295,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (78, 'Licorice: reduces insulin resistance, improves fat deposition, restores normal menses; with White Peony normalizes testosterone; reduces prolactin elevated by Risperidone.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 297,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    (2238, 'White Peony: reduces testosterone via aromatase enzyme, increases progesterone, regulates estrogen and prolactin.',
     'BHC - Class 71 - PMOS', 'personal', 'Materia Medica', 299,
     '## Materia Medica
- Holy basil
    - Adaptogen
    - improves BS level
- Reishi
    - may reduce 5-reductase enzyme and so supportive for hormone caused hair loss
- Maitake
    - Adaptogen and induce ovulation
- OGR (but any berberine containing plant)
    - reduce BS and lipid levels
- Spearmint (Mentha spicata)
    - daily infusion for 30 days shown to lower levels of testosterone and reduce hirsutism
- Vitex
    - reduce elevated prolactin
    - lengthen luteal phase
    - increase progesterone
    - increase pregnancy rates
- Licorice
    - reduce insulin resistance
    - restore normal menses
    - with White Peony - normalize testosterone levels
    - reduce elevated prolactin specifically induced by Risperidone
- White Peony
    - reduces testosterone through action on the aromatase enzyme
    - this can increase progesterone
    - regulate estrogen and prolactin'),

    -- PMOS Treatment Protocol (4-week protocol note)
    (1009, '4-week PMOS protocol: dong quai (anabolic, supports follicular stage) + vitex (stimulates pituitary LH release, lowers prolactin).',
     'BHC - Class 71 - PMOS', 'personal', 'PMOS Treatment Protocol', 300,
     '(4 week protocol:
dong quai - anabolic, support follicular stage
vitex - spark for the pituitary to release that LH
    - vitex also lowers prolactin, good
)'),

    (190, '4-week PMOS protocol: dong quai (anabolic, supports follicular stage) + vitex (stimulates pituitary LH release, lowers prolactin).',
     'BHC - Class 71 - PMOS', 'personal', 'PMOS Treatment Protocol', 310,
     '(4 week protocol:
dong quai - anabolic, support follicular stage
vitex - spark for the pituitary to release that LH
    - vitex also lowers prolactin, good
)'),

    -- Vitex (detailed MM section)
    (190, 'Vitex: dopamine agonist stimulating FSH and LH; downregulates excess prolactin; binds opiate receptor sites without sedation; may take 6 months to a year to effect. Dose: tincture 1-2 ml 3x/day; infusion 1 tsp berries:8oz water. Caution: may interact with dopamine antagonists.',
     'BHC - Class 71 - PMOS', 'personal', 'Vitex', 320,
     '### Vitex
- dopamine agonist in the body, which stimulates FSH and LH
- 5-finger leaves, like Cannabis
- sometimes takes 6 months to a year to effect
- binds with certain opiate receptor sites without being sedative or addictive
- thyroid and adrenal formulas
- downregulates excess prolactin level for dopaminergic activity
- some people consider it an aphrodisiac, others don''t
- Part Used: Berry
- Preparation: Infusion, Tincture
- Infusion: 1 tsp berries: 8oz water
- Tincture: 1-2 ml, 3 x day
- Caution: This plant may interact with dopamine antagonists and dopamine receptor blocking agents.'),

    -- PCOS Formula (specific ml ratios)
    (33, 'PCOS formula: OGR 30ml, Licorice 10ml, White Peony 30ml, Cinnamon 20ml, Gotu kola 30ml; 4ml 2x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'PCOS Formula', 350,
     '### A Formula for PCOS
OGR 30ml
Licorice 10ml
White Peony 30 ml
Cinnamon  20ml
Gotu kola 30 ml (for Extracellular Matrix)
4ml 2x/day'),

    (78, 'PCOS formula: OGR 30ml, Licorice 10ml, White Peony 30ml, Cinnamon 20ml, Gotu kola 30ml; 4ml 2x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'PCOS Formula', 360,
     '### A Formula for PCOS
OGR 30ml
Licorice 10ml
White Peony 30 ml
Cinnamon  20ml
Gotu kola 30 ml (for Extracellular Matrix)
4ml 2x/day'),

    (2238, 'PCOS formula: OGR 30ml, Licorice 10ml, White Peony 30ml, Cinnamon 20ml, Gotu kola 30ml; 4ml 2x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'PCOS Formula', 370,
     '### A Formula for PCOS
OGR 30ml
Licorice 10ml
White Peony 30 ml
Cinnamon  20ml
Gotu kola 30 ml (for Extracellular Matrix)
4ml 2x/day'),

    (167, 'PCOS formula: OGR 30ml, Licorice 10ml, White Peony 30ml, Cinnamon 20ml, Gotu kola 30ml; 4ml 2x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'PCOS Formula', 380,
     '### A Formula for PCOS
OGR 30ml
Licorice 10ml
White Peony 30 ml
Cinnamon  20ml
Gotu kola 30 ml (for Extracellular Matrix)
4ml 2x/day'),

    (2229, 'PCOS formula: OGR 30ml, Licorice 10ml, White Peony 30ml, Cinnamon 20ml, Gotu kola 30ml (for extracellular matrix); 4ml 2x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'PCOS Formula', 390,
     '### A Formula for PCOS
OGR 30ml
Licorice 10ml
White Peony 30 ml
Cinnamon  20ml
Gotu kola 30 ml (for Extracellular Matrix)
4ml 2x/day'),

    -- Cinnamon (detailed MM)
    (167, 'Cinnamon (Ceylon, Cinnamomum verum): warming, tonifying, hypoglycemic, hypolipidemic; contains eugenol (anti-inflammatory); increases blood circulation, promotes tissue regeneration; classic for postpartum hemorrhage and loss of uterine tone. Dose: tincture 20-50 drops 4x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'Cinnamon', 400,
     '### Cinnamon
- warming and tonifying
- picture of cinnamon person is cold dry frail
- hypoglycemic and hypolipidemic
- Ceylon Cinnamon
- much more paper-like than Cassia
- has eugenol (AI effects)
- can improve insulin sensitivity and glucose levels
- increases blood circ and promotes tissue regeneration
- classic for postpartum hemorrhage
- loss of uterine tone
- Part Used: Bark
- Preparation: Tincture, Decoction
- Dose: Tincture: 20-50 drops, 4x/day'),

    -- Andrographis (detailed MM)
    (2629, 'Andrographis: specific for liver congestion with fat intolerance and sluggish liver; indicated in arthritis and type 2 diabetes; anti-inflammatory, antioxidant, adaptogen, hypoglycemic, cardioprotective; take with a tissue moistener like marshmallow glycerite. Dose: tincture 1ml 3x/day. Not for use in pregnancy or when trying to conceive.',
     'BHC - Class 71 - PMOS', 'personal', 'Andrographis', 410,
     '### Andrographis
- specific for liver congestion when people have intolerance to fats
- sluggish liver
- indicated in arthritis and Type 2 Diabetes
- actions: bitter tonic digestive, immune enhancing, cholagogue, hepatoprotective, anti-inflammatory, antioxidant, adaptogen, hypoglycemic, cardioprotective
- indicated for chronic inflammatory conditions
- take with a tissue moistener, like marshmallow glycerite
- Part Used: Aerial Parts
- Preparation: Tincture
- Dose: Tincture: 1 ml, 3 x day
- Precautions: Not for use in pregnancy. Avoid when trying to conceive.'),

    (45, 'Marshmallow glycerite as a companion to Andrographis — use as a tissue moistener given Andrographis''s intensity.',
     'BHC - Class 71 - PMOS', 'personal', 'Andrographis', 420,
     '### Andrographis
- specific for liver congestion when people have intolerance to fats
- sluggish liver
- indicated in arthritis and Type 2 Diabetes
- actions: bitter tonic digestive, immune enhancing, cholagogue, hepatoprotective, anti-inflammatory, antioxidant, adaptogen, hypoglycemic, cardioprotective
- indicated for chronic inflammatory conditions
- take with a tissue moistener, like marshmallow glycerite
- Part Used: Aerial Parts
- Preparation: Tincture
- Dose: Tincture: 1 ml, 3 x day
- Precautions: Not for use in pregnancy. Avoid when trying to conceive.'),

    -- Ocotillo (detailed MM)
    (1248, 'Ocotillo with PMOS: improves circulation (lymphatic and blood); specific for liver inflammation and chronic poor fat digestion. Dose: tincture 10-30 drops 4x/day (smaller doses more frequently).',
     'BHC - Class 71 - PMOS', 'personal', 'Ocotillo', 430,
     '### Ocotillo
- with PMOS - this is about circulation, lymphatic and blood
- spec for liver inflammation
- spec for chronic poor fat digestion
- likes smaller doses more frequently
- Part Used: Fresh bark
- Preparation: Tincture
- Dose: Tincture: 10-30 drops, 4 x day'),

    -- Astragalus (detailed MM)
    (225, 'Astragalus: circulation-enhancing, hepatoprotective, immune-specific; antioxidant; hormone modulating (isoflavones); tonic taken over time. Caution: aggravates damp conditions and fungal infections (polysaccharides feed yeast); avoid in acute illness. Dose: decoction 2 tsp:12oz water; tincture 1-3 ml 3x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'Astragalus', 440,
     '### Astragalus
- circ enhancing hepatoprotective, specific for the immune system
- AO
- hormone modulating due to the isoflavones
- tonic, take over time
- aggravates a damp condition — could prolong it, drive deeper into tissue
    - not good for fungal conditions / mold toxicity
    - swap for Reishi, Echinacea
- full of polysaccharides - feeds yeast and fungus
- Part Used: Root
- Preparation: Decoction, Tincture
- Dose: Decoction: 2 tsp root to 12 oz water, Tincture: 1-3 ml, 3 x day
- Caution: Should not be given in persons with acute infectious illness.'),

    (11, 'Reishi as alternative to Astragalus in damp or fungal conditions (Astragalus'' polysaccharides can aggravate damp/fungal).',
     'BHC - Class 71 - PMOS', 'personal', 'Astragalus', 450,
     '### Astragalus
- circ enhancing hepatoprotective, specific for the immune system
- AO
- hormone modulating due to the isoflavones
- tonic, take over time
- aggravates a damp condition — could prolong it, drive deeper into tissue
    - not good for fungal conditions / mold toxicity
    - swap for Reishi, Echinacea
- full of polysaccharides - feeds yeast and fungus
- Part Used: Root
- Preparation: Decoction, Tincture
- Dose: Decoction: 2 tsp root to 12 oz water, Tincture: 1-3 ml, 3 x day
- Caution: Should not be given in persons with acute infectious illness.'),

    (26, 'Echinacea as alternative to Astragalus in damp or fungal conditions.',
     'BHC - Class 71 - PMOS', 'personal', 'Astragalus', 460,
     '### Astragalus
- circ enhancing hepatoprotective, specific for the immune system
- AO
- hormone modulating due to the isoflavones
- tonic, take over time
- aggravates a damp condition — could prolong it, drive deeper into tissue
    - not good for fungal conditions / mold toxicity
    - swap for Reishi, Echinacea
- full of polysaccharides - feeds yeast and fungus
- Part Used: Root
- Preparation: Decoction, Tincture
- Dose: Decoction: 2 tsp root to 12 oz water, Tincture: 1-3 ml, 3 x day
- Caution: Should not be given in persons with acute infectious illness.'),

    -- Poke (detailed MM)
    (35, 'Poke (low dose): for long-term metabolic disruption — a small amount (2-3 drops per dose in formula) to jumpstart lymph flow, then shift to a longer-term lymphatic. Dose: fresh 2-5 drops, dry 5-15 drops, up to 3x/day. Caution: caustic, use with care.',
     'BHC - Class 71 - PMOS', 'personal', 'Poke', 470,
     '### Poke
- low dose
- if a person with long term metabolic disruption
- little bit of this to push that lymph, give it a jumpstart
- really low dose - 2-3 drops per dose in formula
- then shift to another lymphatic better for long term
- Part Used: Root or Berries
- Preparation: Tincture
- Dose: Tincture: Fresh 2-5 drops, Dry: 5-15 drops, to 3 x day
- Caution: Caustic, use with care'),

    -- Iris / Blue Flag (detailed MM)
    (31, 'Iris/Blue Flag: specific for LDL and VLDL; specific for venous and lymphatic stasis (Priest and Priest). Dose: decoction 1 tsp:8oz 3x/day; tincture 10-30 drops 3x/day.',
     'BHC - Class 71 - PMOS', 'personal', 'Iris (Blue Flag)', 480,
     '### Iris
- specific for LDL and VLDL
- picture: maybe constipation, nausea, food headaches
- specific for venous and lymphatic stasis (Priest and Priest)
- Part Used: Rhizome
- Preparation: Decoction, Tincture
- Dose: Decoction: 1 tsp: 8 oz water, 3 x day Tincture: 10-30 drops, 3 x day');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS — PERSONAL NOTES (Lisa.md)
-- ============================================================

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 71 - PMOS'
      AND note_type = 'personal'
      AND supplement_id IS NOT NULL
  ) THEN
    RAISE NOTICE 'Class 71 PMOS personal supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (11, 'Vitamin D: helps body absorb calcium; supports PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Nutrients', 140,
     '### Nutrients
- Vitamin D — help body absorb calcium
- Omega 3 — taken 2-6 months can reduce testosterone levels; improve unwanted hair growth, menstrual irregularity
- NAC — comparable to metformin; improve regularity
- Selenium — taken at least 8 weeks, beneficial for insulin metabolism; 200mcg
- Inositol — anxiety; Myoinositol + Chiroinositol (Viva Rahm recommends)
- L-carnitine — increase fertility; combined with Clomid works better than either alone
- Melatonin — 2x/day for 6 months; decrease testosterone levels (not in DB, skipped)'),

    (33, 'Omega-3: taken 2-6 months can reduce testosterone levels, improve unwanted hair growth and menstrual irregularity in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Nutrients', 150,
     '### Nutrients
- Vitamin D — help body absorb calcium
- Omega 3 — taken 2-6 months can reduce testosterone levels; improve unwanted hair growth, menstrual irregularity
- NAC — comparable to metformin; improve regularity
- Selenium — taken at least 8 weeks, beneficial for insulin metabolism; 200mcg
- Inositol — anxiety; Myoinositol + Chiroinositol (Viva Rahm recommends)
- L-carnitine — increase fertility; combined with Clomid works better than either alone
- Melatonin — 2x/day for 6 months; decrease testosterone levels (not in DB, skipped)'),

    (29, 'NAC: comparable to metformin; improves menstrual regularity in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Nutrients', 160,
     '### Nutrients
- Vitamin D — help body absorb calcium
- Omega 3 — taken 2-6 months can reduce testosterone levels; improve unwanted hair growth, menstrual irregularity
- NAC — comparable to metformin; improve regularity
- Selenium — taken at least 8 weeks, beneficial for insulin metabolism; 200mcg
- Inositol — anxiety; Myoinositol + Chiroinositol (Viva Rahm recommends)
- L-carnitine — increase fertility; combined with Clomid works better than either alone
- Melatonin — 2x/day for 6 months; decrease testosterone levels (not in DB, skipped)'),

    (23, 'Selenium: taken at least 8 weeks, beneficial for insulin metabolism in PMOS; 200 mcg dose.',
     'BHC - Class 71 - PMOS', 'personal', 'Nutrients', 170,
     '### Nutrients
- Vitamin D — help body absorb calcium
- Omega 3 — taken 2-6 months can reduce testosterone levels; improve unwanted hair growth, menstrual irregularity
- NAC — comparable to metformin; improve regularity
- Selenium — taken at least 8 weeks, beneficial for insulin metabolism; 200mcg
- Inositol — anxiety; Myoinositol + Chiroinositol (Viva Rahm recommends)
- L-carnitine — increase fertility; combined with Clomid works better than either alone
- Melatonin — 2x/day for 6 months; decrease testosterone levels (not in DB, skipped)'),

    (35, 'Inositol (Myoinositol + Chiroinositol combination recommended by Viva Rahm): for insulin resistance and anxiety in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Nutrients', 180,
     '### Nutrients
- Vitamin D — help body absorb calcium
- Omega 3 — taken 2-6 months can reduce testosterone levels; improve unwanted hair growth, menstrual irregularity
- NAC — comparable to metformin; improve regularity
- Selenium — taken at least 8 weeks, beneficial for insulin metabolism; 200mcg
- Inositol — anxiety; Myoinositol + Chiroinositol (Viva Rahm recommends)
- L-carnitine — increase fertility; combined with Clomid works better than either alone
- Melatonin — 2x/day for 6 months; decrease testosterone levels (not in DB, skipped)'),

    (26, 'L-carnitine: increases fertility; combined with Clomid works better than either alone in PMOS.',
     'BHC - Class 71 - PMOS', 'personal', 'Nutrients', 190,
     '### Nutrients
- Vitamin D — help body absorb calcium
- Omega 3 — taken 2-6 months can reduce testosterone levels; improve unwanted hair growth, menstrual irregularity
- NAC — comparable to metformin; improve regularity
- Selenium — taken at least 8 weeks, beneficial for insulin metabolism; 200mcg
- Inositol — anxiety; Myoinositol + Chiroinositol (Viva Rahm recommends)
- L-carnitine — increase fertility; combined with Clomid works better than either alone
- Melatonin — 2x/day for 6 months; decrease testosterone levels (not in DB, skipped)');

END $$;

-- ============================================================
-- HERB KEYWORDS
-- ============================================================

INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Personal Formulation herbs (adaptogen context)
  (81, 'PMOS', 'ailment'),
  (81, 'nerve pain', 'symptom'),
  (81, 'anti-inflammatory', 'action'),
  (17, 'PMOS', 'ailment'),
  (17, 'adaptogen', 'action'),
  (14, 'PMOS', 'ailment'),
  (16, 'PMOS', 'ailment'),
  (16, 'stress', 'ailment'),
  (16, 'adaptogen', 'action'),
  -- Stress Support
  (134, 'stress', 'ailment'),
  (134, 'anxiety', 'ailment'),
  (2233, 'stress', 'ailment'),
  (73, 'stress', 'ailment'),
  -- Adaptogen Protocol
  (11, 'PMOS', 'ailment'),
  (11, 'hyperandrogenism', 'ailment'),
  (11, 'hair loss', 'ailment'),
  (11, 'adaptogen', 'action'),
  -- PMOS Treatment
  (206, 'PMOS', 'ailment'),
  (206, 'metabolic syndrome', 'ailment'),
  -- Inflammatory Reduction
  (203, 'PMOS', 'ailment'),
  (203, 'anti-inflammatory', 'action'),
  (203, 'inflammation', 'ailment'),
  (124, 'PMOS', 'ailment'),
  (124, 'anti-inflammatory', 'action'),
  (75, 'PMOS', 'ailment'),
  (75, 'anti-inflammatory', 'action'),
  (75, 'chronic pain', 'ailment'),
  (25, 'PMOS', 'ailment'),
  (25, 'anti-inflammatory', 'action'),
  -- Fertility Support / inositol tea
  (225, 'PMOS', 'ailment'),
  (225, 'insulin resistance', 'ailment'),
  (225, 'fertility support', 'ailment'),
  (225, 'hormonal support', 'ailment'),
  (78, 'PMOS', 'ailment'),
  (78, 'insulin resistance', 'ailment'),
  (78, 'menstrual irregularity', 'ailment'),
  (78, 'hyperprolactinemia', 'ailment'),
  (78, 'fertility support', 'ailment'),
  (42, 'PMOS', 'ailment'),
  (42, 'fertility support', 'ailment'),
  (885, 'PMOS', 'ailment'),
  (885, 'fertility support', 'ailment'),
  (885, 'insulin resistance', 'ailment'),
  (1547, 'PMOS', 'ailment'),
  (1547, 'insulin resistance', 'ailment'),
  (1547, 'fertility support', 'ailment'),
  -- Blood Sugar and Lipid Regulation
  (13, 'PMOS', 'ailment'),
  (13, 'blood sugar dysregulation', 'ailment'),
  (13, 'insulin resistance', 'ailment'),
  (13, 'adaptogen', 'action'),
  (33, 'PMOS', 'ailment'),
  (33, 'blood sugar dysregulation', 'ailment'),
  (33, 'hyperlipidemia', 'ailment'),
  (33, 'metabolic syndrome', 'ailment'),
  (2607, 'PMOS', 'ailment'),
  (2607, 'hirsutism', 'ailment'),
  (2607, 'hyperandrogenism', 'ailment'),
  (2607, 'menstrual irregularity', 'ailment'),
  -- Hormonal Balance
  (190, 'PMOS', 'ailment'),
  (190, 'ovulation support', 'ailment'),
  (190, 'menstrual irregularity', 'ailment'),
  (190, 'hyperprolactinemia', 'ailment'),
  (190, 'fertility support', 'ailment'),
  (2238, 'PMOS', 'ailment'),
  (2238, 'hyperandrogenism', 'ailment'),
  (2238, 'hormonal support', 'ailment'),
  (2238, 'fertility support', 'ailment'),
  (2238, 'hyperprolactinemia', 'ailment'),
  -- PMOS Formula
  (167, 'PMOS', 'ailment'),
  (167, 'insulin resistance', 'ailment'),
  (167, 'blood sugar dysregulation', 'ailment'),
  (167, 'hyperlipidemia', 'ailment'),
  (167, 'metabolic syndrome', 'ailment'),
  (167, 'postpartum support', 'ailment'),
  (167, 'uterine tonic', 'action'),
  (2229, 'PMOS', 'ailment'),
  (2229, 'connective tissue disorders', 'ailment'),
  -- Clinical Observations / Poke
  (35, 'PMOS', 'ailment'),
  (35, 'metabolic syndrome', 'ailment'),
  (35, 'hyperlipidemia', 'ailment'),
  -- Check-in
  (22, 'PMOS', 'ailment'),
  (22, 'microbiome support', 'ailment'),
  (22, 'gut inflammation', 'ailment'),
  (22, 'insulin resistance', 'ailment'),
  -- Inflammatory Reduction (Lisa)
  (180, 'PMOS', 'ailment'),
  (180, 'anti-inflammatory', 'action'),
  (180, 'gut inflammation', 'ailment'),
  -- Materia Medica (Lisa)
  (2633, 'PMOS', 'ailment'),
  (2633, 'ovulation support', 'ailment'),
  (2633, 'adaptogen', 'action'),
  -- PMOS Treatment Protocol
  (1009, 'PMOS', 'ailment'),
  (1009, 'ovulation support', 'ailment'),
  (1009, 'menstrual irregularity', 'ailment'),
  -- Andrographis
  (2629, 'PMOS', 'ailment'),
  (2629, 'fatty liver disease', 'ailment'),
  (2629, 'type 2 diabetes', 'ailment'),
  (2629, 'liver congestion', 'ailment'),
  -- Ocotillo
  (1248, 'PMOS', 'ailment'),
  (1248, 'liver congestion', 'ailment'),
  (1248, 'lymphatic support', 'ailment'),
  (1248, 'fatty liver disease', 'ailment'),
  -- Blue Flag
  (31, 'PMOS', 'ailment'),
  (31, 'hyperlipidemia', 'ailment'),
  (31, 'lymphatic support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- SUPPLEMENT KEYWORDS
-- ============================================================

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (11, 'PMOS', 'ailment'),
  (11, 'insulin resistance', 'ailment'),
  (33, 'PMOS', 'ailment'),
  (33, 'hyperandrogenism', 'ailment'),
  (33, 'menstrual irregularity', 'ailment'),
  (29, 'PMOS', 'ailment'),
  (29, 'insulin resistance', 'ailment'),
  (29, 'metabolic syndrome', 'ailment'),
  (23, 'PMOS', 'ailment'),
  (23, 'insulin resistance', 'ailment'),
  (23, 'menstrual irregularity', 'ailment'),
  (35, 'PMOS', 'ailment'),
  (35, 'insulin resistance', 'ailment'),
  (35, 'fertility support', 'ailment'),
  (35, 'ovulation support', 'ailment'),
  (35, 'anxiety', 'ailment'),
  (26, 'PMOS', 'ailment'),
  (26, 'ovulation support', 'ailment'),
  (26, 'fertility support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- AILMENT SEARCH TERMS (new keywords only)
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('PMOS',
   ARRAY['polycystic ovarian syndrome', 'PCOS', 'polyendocrine metabolic ovarian syndrome',
         'polycystic ovary syndrome', 'ovarian cysts', 'PMOS treatment']),
  ('hirsutism',
   ARRAY['excess hair growth', 'unwanted hair growth', 'facial hair', 'chin hair',
         'elevated testosterone hair', 'male pattern hair growth']),
  ('menstrual irregularity',
   ARRAY['irregular periods', 'irregular menstrual cycle', 'oligomenorrhea',
         'infrequent periods', 'irregular menses', 'cycle irregularity']),
  ('ovulation support',
   ARRAY['support ovulation', 'anovulation', 'oligo-ovulation', 'promote ovulation',
         'follicle maturation', 'induce ovulation']),
  ('hyperandrogenism',
   ARRAY['elevated androgens', 'elevated testosterone', 'excess testosterone',
         'androgen excess', 'testosterone imbalance', 'high testosterone'])
ON CONFLICT (ailment_keyword) DO NOTHING;
