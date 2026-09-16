-- Migration 329: Class 67 (Thyroid) — snippets, keywords, ailment search terms
-- Files parsed:
--   BHC - Class 67 - Thyroid - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 67 - Thyroid - Lisa.md             (note_type = 'personal')
-- Class name: BHC - Class 67 - Thyroid
--
-- Herb normalisations:
--   Mukul myrrh / Commiphora Mukul → Guggul (id 877)
--   Bladderwrack                   → Kelp / Fucus vesiculosus (id 118)
--   Iris versicolor                → Blue Flag (id 31)
--   Lycopus / bugleweed            → Bugleweed (id 133)
--   Panax ginseng                  → Ginseng (id 14)
--   Schisandra / schizandra        → Schizandra (id 17)
--   Milky oat / milky oats         → Oat milky oats (id 178)
--   Tulsi                          → Holy Basil (id 13)
--   Self-heal                      → Self Heal (id 2437)
--   Peony                          → White Peony root (id 2238)
--
-- New ailment keywords: hyperthyroidism, Hashimoto's thyroiditis, goiter
-- Keyword merges:
--   lymphatic stasis → lymphatic support (existing)
--   gut dysbiosis    → microbiome support (existing)
--
-- Supplements: Selenium (id 23), Vitamin D (id 11)
-- Pairs: see 331_class_67_thyroid_pairs.sql

SET search_path TO herbal, public;

-- ============================================================
-- SNIPPETS — herb rows
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 67 - Thyroid'
  ) THEN
    RAISE NOTICE 'Class 67 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ======== GENERATED NOTES ========

  -- Fall Self-Care Strategies
  (134,
   'Lemon balm included in fall self-care morning juicing blend with nettles and fennel for grounding and nutritive support.',
   'BHC - Class 67 - Thyroid', 'generated', 'Fall Self-Care Strategies', 10,
   '## Fall Self-Care Strategies

- Grounding rituals
	- Morning routine with fresh ginger tea
	- Juicing with lemon balm, nettles, and fennel
- Oils for self-care
	- Extra virgin olive oil
	- Rose essential oil

- Hydration and moisture
	- Thicker oil use for skin
	- Rose glycerin and rose water as moisturizer

- Sleep and relaxation aids
	- Chamomile and lavender tea at night
	- Elderberry baths

- Nutritive support
	- Immune support with elderberry
	- Incorporate seasonal foods and herbs'),

  (43,
   'Nettles included in fall self-care morning juicing blend with lemon balm and fennel.',
   'BHC - Class 67 - Thyroid', 'generated', 'Fall Self-Care Strategies', 20,
   '## Fall Self-Care Strategies

- Grounding rituals
	- Morning routine with fresh ginger tea
	- Juicing with lemon balm, nettles, and fennel
- Oils for self-care
	- Extra virgin olive oil
	- Rose essential oil

- Hydration and moisture
	- Thicker oil use for skin
	- Rose glycerin and rose water as moisturizer

- Sleep and relaxation aids
	- Chamomile and lavender tea at night
	- Elderberry baths

- Nutritive support
	- Immune support with elderberry
	- Incorporate seasonal foods and herbs'),

  (76,
   'Fennel included in fall self-care morning juicing blend with lemon balm and nettles.',
   'BHC - Class 67 - Thyroid', 'generated', 'Fall Self-Care Strategies', 30,
   '## Fall Self-Care Strategies

- Grounding rituals
	- Morning routine with fresh ginger tea
	- Juicing with lemon balm, nettles, and fennel
- Oils for self-care
	- Extra virgin olive oil
	- Rose essential oil

- Hydration and moisture
	- Thicker oil use for skin
	- Rose glycerin and rose water as moisturizer

- Sleep and relaxation aids
	- Chamomile and lavender tea at night
	- Elderberry baths

- Nutritive support
	- Immune support with elderberry
	- Incorporate seasonal foods and herbs'),

  (84,
   'Chamomile and lavender tea at night recommended for sleep and relaxation as fall self-care.',
   'BHC - Class 67 - Thyroid', 'generated', 'Fall Self-Care Strategies', 40,
   '## Fall Self-Care Strategies

- Grounding rituals
	- Morning routine with fresh ginger tea
	- Juicing with lemon balm, nettles, and fennel
- Oils for self-care
	- Extra virgin olive oil
	- Rose essential oil

- Hydration and moisture
	- Thicker oil use for skin
	- Rose glycerin and rose water as moisturizer

- Sleep and relaxation aids
	- Chamomile and lavender tea at night
	- Elderberry baths

- Nutritive support
	- Immune support with elderberry
	- Incorporate seasonal foods and herbs'),

  (82,
   'Lavender and chamomile tea at night recommended for sleep and relaxation as fall self-care.',
   'BHC - Class 67 - Thyroid', 'generated', 'Fall Self-Care Strategies', 50,
   '## Fall Self-Care Strategies

- Grounding rituals
	- Morning routine with fresh ginger tea
	- Juicing with lemon balm, nettles, and fennel
- Oils for self-care
	- Extra virgin olive oil
	- Rose essential oil

- Hydration and moisture
	- Thicker oil use for skin
	- Rose glycerin and rose water as moisturizer

- Sleep and relaxation aids
	- Chamomile and lavender tea at night
	- Elderberry baths

- Nutritive support
	- Immune support with elderberry
	- Incorporate seasonal foods and herbs'),

  (1651,
   'Elderberry recommended for immune support and elderberry baths as fall self-care; elderberry syrup making noted.',
   'BHC - Class 67 - Thyroid', 'generated', 'Fall Self-Care Strategies', 60,
   '## Fall Self-Care Strategies

- Grounding rituals
	- Morning routine with fresh ginger tea
	- Juicing with lemon balm, nettles, and fennel
- Oils for self-care
	- Extra virgin olive oil
	- Rose essential oil

- Hydration and moisture
	- Thicker oil use for skin
	- Rose glycerin and rose water as moisturizer

- Sleep and relaxation aids
	- Chamomile and lavender tea at night
	- Elderberry baths

- Nutritive support
	- Immune support with elderberry
	- Incorporate seasonal foods and herbs'),

  (122,
   'Dandelion noted as a nourishing root to embrace as seasonal greens and roots shift in fall.',
   'BHC - Class 67 - Thyroid', 'generated', 'Plant Strategies and Adjustments', 70,
   '## Plant Strategies and Adjustments

- Embrace seasonal greens and roots
	- Dandelion as a nourishing root
	- Modify smoothie with more seasonal, starchy additions
	- Consider omitting fresh greens if they feel heavy

- Personal rituals
	- Candlelight and incense for relaxation
	- Adjust workout routines as seasons change

- Experimentation with herbs and teas
	- Elderberry syrup making
	- Preserve energy and warmth with physical activities'),

  -- Therapeutic Strategies — Stansbury formula for Hashimoto's
  (877,
   'Mukul myrrh (Guggul) in Jill Stansbury Hashimoto''s formula: Mukul myrrh, bladderwrack, licorice, Panax ginseng, Iris versicolor — equal parts, 1–2 dropperfuls 3–5x/day for months.',
   'BHC - Class 67 - Thyroid', 'generated', 'Therapeutic Strategies', 80,
   '## Therapeutic Strategies
- Formula from Jill Stansbury
	- Mukul myrrh, bladderwrack, licorice, panax ginseng, Iris versicolor
- Hyperthyroidism treatment addresses stress
	- Metabolism high without nourishment
	- Manage stress history, sleep, trauma
- Address digestive health
	- Nutrient assimilation, check malabsorption
	- Chemical exposure, liver health
- HPA axis and stealth infections
	- Epstein-Barr, cytomegalovirus, herpes
	- Interference from medications'),

  (118,
   'Bladderwrack in Jill Stansbury Hashimoto''s formula: Mukul myrrh, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'generated', 'Therapeutic Strategies', 90,
   '## Therapeutic Strategies
- Formula from Jill Stansbury
	- Mukul myrrh, bladderwrack, licorice, panax ginseng, Iris versicolor
- Hyperthyroidism treatment addresses stress
	- Metabolism high without nourishment
	- Manage stress history, sleep, trauma
- Address digestive health
	- Nutrient assimilation, check malabsorption
	- Chemical exposure, liver health
- HPA axis and stealth infections
	- Epstein-Barr, cytomegalovirus, herpes
	- Interference from medications'),

  (78,
   'Licorice in Jill Stansbury Hashimoto''s formula: Mukul myrrh, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'generated', 'Therapeutic Strategies', 100,
   '## Therapeutic Strategies
- Formula from Jill Stansbury
	- Mukul myrrh, bladderwrack, licorice, panax ginseng, Iris versicolor
- Hyperthyroidism treatment addresses stress
	- Metabolism high without nourishment
	- Manage stress history, sleep, trauma
- Address digestive health
	- Nutrient assimilation, check malabsorption
	- Chemical exposure, liver health
- HPA axis and stealth infections
	- Epstein-Barr, cytomegalovirus, herpes
	- Interference from medications'),

  (14,
   'Panax ginseng in Jill Stansbury Hashimoto''s formula: Mukul myrrh, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'generated', 'Therapeutic Strategies', 110,
   '## Therapeutic Strategies
- Formula from Jill Stansbury
	- Mukul myrrh, bladderwrack, licorice, panax ginseng, Iris versicolor
- Hyperthyroidism treatment addresses stress
	- Metabolism high without nourishment
	- Manage stress history, sleep, trauma
- Address digestive health
	- Nutrient assimilation, check malabsorption
	- Chemical exposure, liver health
- HPA axis and stealth infections
	- Epstein-Barr, cytomegalovirus, herpes
	- Interference from medications'),

  (31,
   'Iris versicolor (Blue Flag) in Jill Stansbury Hashimoto''s formula: Mukul myrrh, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'generated', 'Therapeutic Strategies', 120,
   '## Therapeutic Strategies
- Formula from Jill Stansbury
	- Mukul myrrh, bladderwrack, licorice, panax ginseng, Iris versicolor
- Hyperthyroidism treatment addresses stress
	- Metabolism high without nourishment
	- Manage stress history, sleep, trauma
- Address digestive health
	- Nutrient assimilation, check malabsorption
	- Chemical exposure, liver health
- HPA axis and stealth infections
	- Epstein-Barr, cytomegalovirus, herpes
	- Interference from medications'),

  -- Treatment Details
  (85,
   'Plantain used as vulnerary for gut healing and leaky gut; part of strategy to nourish gut mucosa alongside calendula.',
   'BHC - Class 67 - Thyroid', 'generated', 'Treatment Details', 130,
   '## Treatment Details
- Elimination diet to remove triggers
- Gut nourishment and probiotics
- Use vulneraries like plantain and calendula
- Modulation of immune function
- Selenium at 200 micrograms
	- Brazil nuts as source
- Herbal actions: anti-inflammatory, immune support
- Moistening adaptogens like schizandra
	- Ashwagandha for hypothyroid'),

  (70,
   'Calendula used as vulnerary for gut healing and leaky gut; part of strategy to nourish gut mucosa alongside plantain.',
   'BHC - Class 67 - Thyroid', 'generated', 'Treatment Details', 140,
   '## Treatment Details
- Elimination diet to remove triggers
- Gut nourishment and probiotics
- Use vulneraries like plantain and calendula
- Modulation of immune function
- Selenium at 200 micrograms
	- Brazil nuts as source
- Herbal actions: anti-inflammatory, immune support
- Moistening adaptogens like schizandra
	- Ashwagandha for hypothyroid'),

  (17,
   'Schizandra noted as a moistening adaptogen in thyroid treatment; useful when tissues are dry from hyperthyroid burnout.',
   'BHC - Class 67 - Thyroid', 'generated', 'Treatment Details', 150,
   '## Treatment Details
- Elimination diet to remove triggers
- Gut nourishment and probiotics
- Use vulneraries like plantain and calendula
- Modulation of immune function
- Selenium at 200 micrograms
	- Brazil nuts as source
- Herbal actions: anti-inflammatory, immune support
- Moistening adaptogens like schizandra
	- Ashwagandha for hypothyroid'),

  (20,
   'Ashwagandha specific for hypothyroid; noted as moistening adaptogen for the foggy, slow, depleted hypothyroid picture.',
   'BHC - Class 67 - Thyroid', 'generated', 'Treatment Details', 160,
   '## Treatment Details
- Elimination diet to remove triggers
- Gut nourishment and probiotics
- Use vulneraries like plantain and calendula
- Modulation of immune function
- Selenium at 200 micrograms
	- Brazil nuts as source
- Herbal actions: anti-inflammatory, immune support
- Moistening adaptogens like schizandra
	- Ashwagandha for hypothyroid'),

  -- Herb Usage
  (31,
   'Iris versicolor (Blue Flag) for hypothyroid picture: poor fat metabolism, lymphatic stasis; good for poor fat metabolism and lymphatic stagnation.',
   'BHC - Class 67 - Thyroid', 'generated', 'Herb Usage', 170,
   '## Herb Usage
- Iris versicolor for hypothyroid
	- Good for poor fat metabolism, lymphatic stasis
- Lycopus, bugleweed for thyroid balance
	- Motherwort for cardiovascular support
	- Metabolic cooler
- Rosemary acid for calming thyroid response
	- Modulates T-cells in autoimmune conditions
	- Use rosemary, self-heal, lemon balm'),

  (133,
   'Bugleweed (Lycopus) for thyroid balance; acts as a metabolic cooler.',
   'BHC - Class 67 - Thyroid', 'generated', 'Herb Usage', 180,
   '## Herb Usage
- Iris versicolor for hypothyroid
	- Good for poor fat metabolism, lymphatic stasis
- Lycopus, bugleweed for thyroid balance
	- Motherwort for cardiovascular support
	- Metabolic cooler
- Rosemary acid for calming thyroid response
	- Modulates T-cells in autoimmune conditions
	- Use rosemary, self-heal, lemon balm'),

  (131,
   'Motherwort for cardiovascular support alongside bugleweed in thyroid treatment; metabolic cooler.',
   'BHC - Class 67 - Thyroid', 'generated', 'Herb Usage', 190,
   '## Herb Usage
- Iris versicolor for hypothyroid
	- Good for poor fat metabolism, lymphatic stasis
- Lycopus, bugleweed for thyroid balance
	- Motherwort for cardiovascular support
	- Metabolic cooler
- Rosemary acid for calming thyroid response
	- Modulates T-cells in autoimmune conditions
	- Use rosemary, self-heal, lemon balm'),

  (109,
   'Rosemary (rosmarinic acid) for calming thyroid response; modulates T-cells in autoimmune thyroid conditions. Use rosemary, self-heal, lemon balm.',
   'BHC - Class 67 - Thyroid', 'generated', 'Herb Usage', 200,
   '## Herb Usage
- Iris versicolor for hypothyroid
	- Good for poor fat metabolism, lymphatic stasis
- Lycopus, bugleweed for thyroid balance
	- Motherwort for cardiovascular support
	- Metabolic cooler
- Rosemary acid for calming thyroid response
	- Modulates T-cells in autoimmune conditions
	- Use rosemary, self-heal, lemon balm'),

  (2437,
   'Self-heal (rosmarinic acid) for calming thyroid response in autoimmune thyroid conditions; used with rosemary and lemon balm.',
   'BHC - Class 67 - Thyroid', 'generated', 'Herb Usage', 210,
   '## Herb Usage
- Iris versicolor for hypothyroid
	- Good for poor fat metabolism, lymphatic stasis
- Lycopus, bugleweed for thyroid balance
	- Motherwort for cardiovascular support
	- Metabolic cooler
- Rosemary acid for calming thyroid response
	- Modulates T-cells in autoimmune conditions
	- Use rosemary, self-heal, lemon balm'),

  (134,
   'Lemon balm (rosmarinic acid) for calming thyroid response in autoimmune thyroid conditions; used with rosemary and self-heal.',
   'BHC - Class 67 - Thyroid', 'generated', 'Herb Usage', 220,
   '## Herb Usage
- Iris versicolor for hypothyroid
	- Good for poor fat metabolism, lymphatic stasis
- Lycopus, bugleweed for thyroid balance
	- Motherwort for cardiovascular support
	- Metabolic cooler
- Rosemary acid for calming thyroid response
	- Modulates T-cells in autoimmune conditions
	- Use rosemary, self-heal, lemon balm'),

  -- Afternoon 2 — Digestive and Inflammatory Support
  (20,
   'Ashwagandha in adaptogen/nervine tincture for thyroid case: ashwagandha, milky oat, licorice.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 230,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (178,
   'Milky oat in adaptogen/nervine tincture for thyroid case: ashwagandha, milky oat, licorice.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 240,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (78,
   'Licorice in adaptogen/nervine tincture for thyroid case: ashwagandha, milky oat, licorice.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 250,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (983,
   'Blue vervain in bitter digestive tincture for thyroid case: blue vervain, cardamom, ginger.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 260,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (127,
   'Cardamom in bitter digestive tincture for thyroid case: blue vervain, cardamom, ginger.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 270,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (124,
   'Ginger in bitter digestive tincture for thyroid case: blue vervain, cardamom, ginger.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 280,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (885,
   'Alfalfa in infusion with red clover for nourishment in thyroid case; nutritive support.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 290,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (42,
   'Red clover in nourishing infusion with alfalfa for thyroid case.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 300,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (118,
   'Bladderwrack capsules recommended in thyroid case for iodine/mineral support.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 310,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  -- Gut Health and Thyroid — reproductive formula
  (109,
   'Rosemary tincture for methylation and detoxification support; rosmarinic acid role in detoxification and thyroid health.',
   'BHC - Class 67 - Thyroid', 'generated', 'Gut Health and Thyroid', 320,
   '## Gut Health and Thyroid

- Rosemary tincture
	- Supports methylation and detoxification
	- Rosmarinic acid role in detoxification
- Reproductive formula tincture
	- Peony, cinnamon, burdock, licorice, gotu kola

### Case Complexity

- Misdiagnosed Hashimoto''s after childbirth
	- Chronic mismanagement with thyroid meds
- Long-term nutrient depletion
	- Gut absorption issues
	- Misunderstood genetic conditions (MTHFR)'),

  (2238,
   'White Peony in reproductive formula tincture for thyroid case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'generated', 'Gut Health and Thyroid', 330,
   '## Gut Health and Thyroid

- Rosemary tincture
	- Supports methylation and detoxification
	- Rosmarinic acid role in detoxification
- Reproductive formula tincture
	- Peony, cinnamon, burdock, licorice, gotu kola

### Case Complexity

- Misdiagnosed Hashimoto''s after childbirth
	- Chronic mismanagement with thyroid meds
- Long-term nutrient depletion
	- Gut absorption issues
	- Misunderstood genetic conditions (MTHFR)'),

  (167,
   'Cinnamon in reproductive formula tincture for thyroid case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'generated', 'Gut Health and Thyroid', 340,
   '## Gut Health and Thyroid

- Rosemary tincture
	- Supports methylation and detoxification
	- Rosmarinic acid role in detoxification
- Reproductive formula tincture
	- Peony, cinnamon, burdock, licorice, gotu kola

### Case Complexity

- Misdiagnosed Hashimoto''s after childbirth
	- Chronic mismanagement with thyroid meds
- Long-term nutrient depletion
	- Gut absorption issues
	- Misunderstood genetic conditions (MTHFR)'),

  (22,
   'Burdock in reproductive formula tincture for thyroid case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'generated', 'Gut Health and Thyroid', 350,
   '## Gut Health and Thyroid

- Rosemary tincture
	- Supports methylation and detoxification
	- Rosmarinic acid role in detoxification
- Reproductive formula tincture
	- Peony, cinnamon, burdock, licorice, gotu kola

### Case Complexity

- Misdiagnosed Hashimoto''s after childbirth
	- Chronic mismanagement with thyroid meds
- Long-term nutrient depletion
	- Gut absorption issues
	- Misunderstood genetic conditions (MTHFR)'),

  (78,
   'Licorice in reproductive formula tincture for thyroid case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'generated', 'Gut Health and Thyroid', 360,
   '## Gut Health and Thyroid

- Rosemary tincture
	- Supports methylation and detoxification
	- Rosmarinic acid role in detoxification
- Reproductive formula tincture
	- Peony, cinnamon, burdock, licorice, gotu kola

### Case Complexity

- Misdiagnosed Hashimoto''s after childbirth
	- Chronic mismanagement with thyroid meds
- Long-term nutrient depletion
	- Gut absorption issues
	- Misunderstood genetic conditions (MTHFR)'),

  (2229,
   'Gotu kola in reproductive formula tincture for thyroid case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'generated', 'Gut Health and Thyroid', 370,
   '## Gut Health and Thyroid

- Rosemary tincture
	- Supports methylation and detoxification
	- Rosmarinic acid role in detoxification
- Reproductive formula tincture
	- Peony, cinnamon, burdock, licorice, gotu kola

### Case Complexity

- Misdiagnosed Hashimoto''s after childbirth
	- Chronic mismanagement with thyroid meds
- Long-term nutrient depletion
	- Gut absorption issues
	- Misunderstood genetic conditions (MTHFR)'),

  -- Recommended Herbs and Supplements
  (13,
   'Tulsi in main absorption tincture for thyroid case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'generated', 'Recommended Herbs and Supplements', 380,
   '## Recommended Herbs and Supplements

- Tincture components
	- Tulsi, schisandra, ashwagandha, milk thistle, rosemary
- Vitamin supplementation
	- High dose vitamin D to improve absorption
	- Ferritin for iron reserve

### Treatment Adjustments

- Stopping ineffective practices
	- Liver smoothie habit
	- Collaborate with naturopathic doctors
- Chronic inflammation considerations
	- Linked with vitamin D deficiency
	- Affect on ferritin levels and absorption'),

  (17,
   'Schisandra in main absorption tincture for thyroid case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'generated', 'Recommended Herbs and Supplements', 390,
   '## Recommended Herbs and Supplements

- Tincture components
	- Tulsi, schisandra, ashwagandha, milk thistle, rosemary
- Vitamin supplementation
	- High dose vitamin D to improve absorption
	- Ferritin for iron reserve

### Treatment Adjustments

- Stopping ineffective practices
	- Liver smoothie habit
	- Collaborate with naturopathic doctors
- Chronic inflammation considerations
	- Linked with vitamin D deficiency
	- Affect on ferritin levels and absorption'),

  (20,
   'Ashwagandha in main absorption tincture for thyroid case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'generated', 'Recommended Herbs and Supplements', 400,
   '## Recommended Herbs and Supplements

- Tincture components
	- Tulsi, schisandra, ashwagandha, milk thistle, rosemary
- Vitamin supplementation
	- High dose vitamin D to improve absorption
	- Ferritin for iron reserve

### Treatment Adjustments

- Stopping ineffective practices
	- Liver smoothie habit
	- Collaborate with naturopathic doctors
- Chronic inflammation considerations
	- Linked with vitamin D deficiency
	- Affect on ferritin levels and absorption'),

  (206,
   'Milk thistle in main absorption tincture for thyroid case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'generated', 'Recommended Herbs and Supplements', 410,
   '## Recommended Herbs and Supplements

- Tincture components
	- Tulsi, schisandra, ashwagandha, milk thistle, rosemary
- Vitamin supplementation
	- High dose vitamin D to improve absorption
	- Ferritin for iron reserve

### Treatment Adjustments

- Stopping ineffective practices
	- Liver smoothie habit
	- Collaborate with naturopathic doctors
- Chronic inflammation considerations
	- Linked with vitamin D deficiency
	- Affect on ferritin levels and absorption'),

  (109,
   'Rosemary in main absorption tincture for thyroid case; supports methylation and nutrient absorption: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'generated', 'Recommended Herbs and Supplements', 420,
   '## Recommended Herbs and Supplements

- Tincture components
	- Tulsi, schisandra, ashwagandha, milk thistle, rosemary
- Vitamin supplementation
	- High dose vitamin D to improve absorption
	- Ferritin for iron reserve

### Treatment Adjustments

- Stopping ineffective practices
	- Liver smoothie habit
	- Collaborate with naturopathic doctors
- Chronic inflammation considerations
	- Linked with vitamin D deficiency
	- Affect on ferritin levels and absorption');

  -- ======== PERSONAL NOTES (Lisa) ========

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Hashimoto's — Stansbury formula
  (877,
   'Commiphora Mukul (Guggul) in Stansbury Hashimoto''s tincture: equal parts Commiphora Mukul, bladderwrack, licorice, Panax ginseng, Iris versicolor; 1–2 dropperfuls 3–5x/day for months.',
   'BHC - Class 67 - Thyroid', 'personal', 'Hashimoto''s', 10,
   '### Hashimoto''s
- body starts to attack those cells in the thyroid
- might see elevated TSH, low Thyroxine and evidence of anti-TPO
    - anti-TPO positive in 90% of cases
    - globulin test positive in 50-80% of cases
- causes an extreme version of Hypothyroidism
- primarily affects those with uteruses, in the 5th decade of life
- correlations:
    - gut dysbiosis definitely correlated with Hashimoto''s
    - H. pylori
    - iron-deficient anemia
    - low selenium, Vit D, and high iodine exposure
    - also, viruses (stealth)
- can be restored and repaired
- tincture from Jill Stansbury:
    - Commiphora Mukul (myrrh)
    - Bladderwrack
    - Licorice
    - Panax ginseng
    - Iris versicolor
    - equal parts
    - 1-2 dropperful 3-5x/day for months'),

  (118,
   'Bladderwrack in Stansbury Hashimoto''s tincture: equal parts Commiphora Mukul, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'personal', 'Hashimoto''s', 20,
   '### Hashimoto''s
- body starts to attack those cells in the thyroid
- might see elevated TSH, low Thyroxine and evidence of anti-TPO
    - anti-TPO positive in 90% of cases
    - globulin test positive in 50-80% of cases
- causes an extreme version of Hypothyroidism
- primarily affects those with uteruses, in the 5th decade of life
- correlations:
    - gut dysbiosis definitely correlated with Hashimoto''s
    - H. pylori
    - iron-deficient anemia
    - low selenium, Vit D, and high iodine exposure
    - also, viruses (stealth)
- can be restored and repaired
- tincture from Jill Stansbury:
    - Commiphora Mukul (myrrh)
    - Bladderwrack
    - Licorice
    - Panax ginseng
    - Iris versicolor
    - equal parts
    - 1-2 dropperful 3-5x/day for months'),

  (78,
   'Licorice in Stansbury Hashimoto''s tincture: equal parts Commiphora Mukul, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'personal', 'Hashimoto''s', 30,
   '### Hashimoto''s
- body starts to attack those cells in the thyroid
- might see elevated TSH, low Thyroxine and evidence of anti-TPO
    - anti-TPO positive in 90% of cases
    - globulin test positive in 50-80% of cases
- causes an extreme version of Hypothyroidism
- primarily affects those with uteruses, in the 5th decade of life
- correlations:
    - gut dysbiosis definitely correlated with Hashimoto''s
    - H. pylori
    - iron-deficient anemia
    - low selenium, Vit D, and high iodine exposure
    - also, viruses (stealth)
- can be restored and repaired
- tincture from Jill Stansbury:
    - Commiphora Mukul (myrrh)
    - Bladderwrack
    - Licorice
    - Panax ginseng
    - Iris versicolor
    - equal parts
    - 1-2 dropperful 3-5x/day for months'),

  (14,
   'Panax ginseng in Stansbury Hashimoto''s tincture: equal parts Commiphora Mukul, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'personal', 'Hashimoto''s', 40,
   '### Hashimoto''s
- body starts to attack those cells in the thyroid
- might see elevated TSH, low Thyroxine and evidence of anti-TPO
    - anti-TPO positive in 90% of cases
    - globulin test positive in 50-80% of cases
- causes an extreme version of Hypothyroidism
- primarily affects those with uteruses, in the 5th decade of life
- correlations:
    - gut dysbiosis definitely correlated with Hashimoto''s
    - H. pylori
    - iron-deficient anemia
    - low selenium, Vit D, and high iodine exposure
    - also, viruses (stealth)
- can be restored and repaired
- tincture from Jill Stansbury:
    - Commiphora Mukul (myrrh)
    - Bladderwrack
    - Licorice
    - Panax ginseng
    - Iris versicolor
    - equal parts
    - 1-2 dropperful 3-5x/day for months'),

  (31,
   'Iris versicolor in Stansbury Hashimoto''s tincture: equal parts Commiphora Mukul, bladderwrack, licorice, Panax ginseng, Iris versicolor.',
   'BHC - Class 67 - Thyroid', 'personal', 'Hashimoto''s', 50,
   '### Hashimoto''s
- body starts to attack those cells in the thyroid
- might see elevated TSH, low Thyroxine and evidence of anti-TPO
    - anti-TPO positive in 90% of cases
    - globulin test positive in 50-80% of cases
- causes an extreme version of Hypothyroidism
- primarily affects those with uteruses, in the 5th decade of life
- correlations:
    - gut dysbiosis definitely correlated with Hashimoto''s
    - H. pylori
    - iron-deficient anemia
    - low selenium, Vit D, and high iodine exposure
    - also, viruses (stealth)
- can be restored and repaired
- tincture from Jill Stansbury:
    - Commiphora Mukul (myrrh)
    - Bladderwrack
    - Licorice
    - Panax ginseng
    - Iris versicolor
    - equal parts
    - 1-2 dropperful 3-5x/day for months'),

  -- Herbal Actions for Thyroid Health
  (11,
   'Reishi: immune modulating herb for thyroid health.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 60,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (225,
   'Astragalus: immune modulating and moistening adaptogen for thyroid health; indicated when on the edge of burnout with dry tissues.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 70,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (2233,
   'Hibiscus: antioxidant for thyroid health; note — check for low blood pressure before using.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 80,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (167,
   'Cinnamon: glucose-regulating herb for thyroid health.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 90,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (13,
   'Tulsi: glucose-regulating herb for thyroid health; also specific for hyperthyroidism via rosmarinic acid — calms uptake of T3 into tissues.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 100,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (2556,
   'Bitter melon: glucose-regulating herb for thyroid health.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 110,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (31,
   'Iris (Blue Flag): hypolipidemic herb for thyroid health; helps body metabolize fats.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 120,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (78,
   'Licorice: hypolipidemic herb for thyroid health.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 130,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (178,
   'Milky oats: nervine for thyroid health; use based on whether patient needs scaffolding or calming.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 140,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (20,
   'Ashwagandha has more affinity for hypothyroidism: foggy, forgetful, slow transit time — specific for this picture.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 150,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (131,
   'Motherwort (rosmarinic acid): specific for hyperthyroidism; calms uptake of T3 into tissues via rosmarinic acid.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 160,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (852,
   'Shatavari: moistening adaptogen for thyroid health; indicated when on the edge of burnout with dry tissues.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 170,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  -- Alfalfa herb profile
  (885,
   'Alfalfa picture for thyroid: moderate malabsorption, poor appetite, nervousness, weakness, poor nutritional status. AI, cardioprotective, bone building, hypolipidemic, nourishing for hormone regulation.',
   'BHC - Class 67 - Thyroid', 'personal', 'Alfalfa', 180,
   '### Alfalfa
- picture:
    - moderate malabsorption
    - poor appetite, nervousness, weakness
    - poor nutritional status
- AI, cardioprotective, bone building
- hypolipidemic
- nourishing for hormone regulation'),

  -- Iris versicolor herb profile
  (31,
   'Iris versicolor picture: hypothyroidism, can''t metabolize fats well (even vomiting from fats), nausea headaches, light-colored feces, heartburn from fats, morning nausea, elevated VLDL and LDL, pancreatic insufficiency, eczema with poor fat assimilation. Lower dose plant: 10–30 drops. Specific for stagnation; stimulates innate immunity.',
   'BHC - Class 67 - Thyroid', 'personal', 'Iris versicolor', 190,
   '### Iris versicolor
- technically a lower dose plant
- 10-30 drops
- picture:
    - hypothyroidism
    - can''t metabolize fats well, even vomiting from fats
    - may get nausea headaches, light-colored feces
    - heartburn from fats
    - morning nausea
    - elevated VLDL and LDL
    - pancreatic insufficiency, impair the breaking down of food in the small intestine
    - semi-formed feces
    - eczema with poor fat assimilation and dry skin
- specific for stagnation
- stimulates innate immunity'),

  -- Poke herb profile
  (35,
   'Poke Root picture: thyroid hypofunction with fluid retention and immune depression, puffy face and ankles, chronic hard inflamed neck nodes, eczema, cracks on the sides of the mouth (specific for poke). Pairs: fibrocystic acute breast disease + Red Root; acute mastitis + Red Root + Cotton Root Bark; bacterial infections in feeble individuals + Echinacea + Baptisia. Start low and slow; can give rashes as waste moves out.',
   'BHC - Class 67 - Thyroid', 'personal', 'Poke', 200,
   '### Poke
- picture:
    - thyroid hypofunction with fluid retention and immune depression
    - puffy face and ankles
    - getting sick a lot
    - might have a pale tongue, white foamy coat
    - or dry tongue
    - inflamed gums
    - chronic hard inflamed neck nodes
    - eczema, especially history or chronic inflamed lymph nodes
    - cracks on the sides of the mouth, specific for poke
    - fibrocystic acute breast disease + Red Root
    - acute mastitis +Red root and +Cotton root bark
    - bacterial infections in "feeble individuals" +Echinacea and +Baptisia
- can be dramatic in how it makes things move
- can give rashes - waste wants to come out through the skin (thighs, underarms)
    - pay attention to abdominal rashes, want to cool things down
- start low and slow, esp with those with low resources
- fresh - a little less intense'),

  (981,
   'Red Root paired with Poke Root for fibrocystic acute breast disease and acute mastitis (also with Cotton Root Bark for mastitis).',
   'BHC - Class 67 - Thyroid', 'personal', 'Poke', 210,
   '### Poke
- picture:
    - thyroid hypofunction with fluid retention and immune depression
    - puffy face and ankles
    - getting sick a lot
    - might have a pale tongue, white foamy coat
    - or dry tongue
    - inflamed gums
    - chronic hard inflamed neck nodes
    - eczema, especially history or chronic inflamed lymph nodes
    - cracks on the sides of the mouth, specific for poke
    - fibrocystic acute breast disease + Red Root
    - acute mastitis +Red root and +Cotton root bark
    - bacterial infections in "feeble individuals" +Echinacea and +Baptisia
- can be dramatic in how it makes things move
- can give rashes - waste wants to come out through the skin (thighs, underarms)
    - pay attention to abdominal rashes, want to cool things down
- start low and slow, esp with those with low resources
- fresh - a little less intense'),

  (26,
   'Echinacea paired with Poke Root for bacterial infections in feeble individuals (also with Baptisia).',
   'BHC - Class 67 - Thyroid', 'personal', 'Poke', 220,
   '### Poke
- picture:
    - thyroid hypofunction with fluid retention and immune depression
    - puffy face and ankles
    - getting sick a lot
    - might have a pale tongue, white foamy coat
    - or dry tongue
    - inflamed gums
    - chronic hard inflamed neck nodes
    - eczema, especially history or chronic inflamed lymph nodes
    - cracks on the sides of the mouth, specific for poke
    - fibrocystic acute breast disease + Red Root
    - acute mastitis +Red root and +Cotton root bark
    - bacterial infections in "feeble individuals" +Echinacea and +Baptisia
- can be dramatic in how it makes things move
- can give rashes - waste wants to come out through the skin (thighs, underarms)
    - pay attention to abdominal rashes, want to cool things down
- start low and slow, esp with those with low resources
- fresh - a little less intense'),

  (23,
   'Wild Indigo (Baptisia) paired with Poke Root for bacterial infections in feeble individuals (also with Echinacea).',
   'BHC - Class 67 - Thyroid', 'personal', 'Poke', 230,
   '### Poke
- picture:
    - thyroid hypofunction with fluid retention and immune depression
    - puffy face and ankles
    - getting sick a lot
    - might have a pale tongue, white foamy coat
    - or dry tongue
    - inflamed gums
    - chronic hard inflamed neck nodes
    - eczema, especially history or chronic inflamed lymph nodes
    - cracks on the sides of the mouth, specific for poke
    - fibrocystic acute breast disease + Red Root
    - acute mastitis +Red root and +Cotton root bark
    - bacterial infections in "feeble individuals" +Echinacea and +Baptisia
- can be dramatic in how it makes things move
- can give rashes - waste wants to come out through the skin (thighs, underarms)
    - pay attention to abdominal rashes, want to cool things down
- start low and slow, esp with those with low resources
- fresh - a little less intense'),

  -- Bugleweed herb profile
  (133,
   'Bugleweed (Lycopus virginicus) picture: goiter phase with tachycardia and mild respiratory dysfunction (shallow breathing), tachycardia with circulatory issues and anxiety, passive capillary hemorrhage, palpitations. Metabolic cooler; cools lower GI excess. Interchangeable with Motherwort for CV support.',
   'BHC - Class 67 - Thyroid', 'personal', 'Bugleweed', 240,
   '### Bugleweed
Lycopus virginicus
- picture:
    - when goiter phase with tachycardia and mild respiratory disfunction (shallow breathing)
    - tachycardia with circ issues and anxiety
    - passive capillary hemorrhage
    - palpitations
- technically a metabolic cooler
- cools lower GI excess - explosive liquid bowel movements
- interchangeable with Motherwort for this - CV support'),

  -- Bladderwrack herb profile
  (118,
   'Bladderwrack picture: thyroid hypofunction, tendency toward obesity, fatty accumulation of the heart, malnutrition with mineral deficiencies.',
   'BHC - Class 67 - Thyroid', 'personal', 'Bladderwrack', 250,
   '### Bladderwrack
- picture:
    - thyroid hypofunction
    - tendency toward obesity
    - fatty accumulation of the heart
    - malnutrition with mineral deficiencies'),

  -- Rosmarinic acid containing plants
  (109,
   'Rosemary: rosmarinic acid — more indicated for hyperthyroidism (calms uptake of T3 into tissues) but no harm for hypo.',
   'BHC - Class 67 - Thyroid', 'personal', 'Rosmarinic Acid Plants', 260,
   '### Rosmarinic acid containing plants
- more indicated for hyperthyroidism, but no harm for hypo'),

  (2437,
   'Self-heal: rosmarinic acid — more indicated for hyperthyroidism, but no harm for hypo.',
   'BHC - Class 67 - Thyroid', 'personal', 'Rosmarinic Acid Plants', 270,
   '### Rosmarinic acid containing plants
- more indicated for hyperthyroidism, but no harm for hypo'),

  (134,
   'Lemon balm: rosmarinic acid — more indicated for hyperthyroidism, but no harm for hypo.',
   'BHC - Class 67 - Thyroid', 'personal', 'Rosmarinic Acid Plants', 280,
   '### Rosmarinic acid containing plants
- more indicated for hyperthyroidism, but no harm for hypo'),

  (131,
   'Motherwort: rosmarinic acid — more indicated for hyperthyroidism, but no harm for hypo.',
   'BHC - Class 67 - Thyroid', 'personal', 'Rosmarinic Acid Plants', 290,
   '### Rosmarinic acid containing plants
- more indicated for hyperthyroidism, but no harm for hypo'),

  -- Case Study (Lisa's treatment plan for Mary)
  (983,
   'Blue vervain in bitter digestive tincture for thyroid/Hashimoto''s case: blue vervain, cardamom, ginger.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 300,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (127,
   'Cardamom in bitter digestive tincture for thyroid/Hashimoto''s case: blue vervain, cardamom, ginger.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 310,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (124,
   'Ginger in bitter digestive tincture for thyroid/Hashimoto''s case: blue vervain, cardamom, ginger.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 320,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (20,
   'Ashwagandha in adaptogen/nervine tincture for thyroid/Hashimoto''s case: ashwagandha, milky oats, licorice.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 330,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (178,
   'Milky oats in adaptogen/nervine tincture for thyroid/Hashimoto''s case: ashwagandha, milky oats, licorice.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 340,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (78,
   'Licorice in adaptogen/nervine tincture for thyroid/Hashimoto''s case: ashwagandha, milky oats, licorice.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 350,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (118,
   'Bladderwrack capsules in thyroid/Hashimoto''s case treatment plan.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 360,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (885,
   'Alfalfa in nourishing tea blend with Red Clover for thyroid/Hashimoto''s case.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 370,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (42,
   'Red Clover in nourishing tea blend with Alfalfa for thyroid/Hashimoto''s case.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 380,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (13,
   'Tulsi in primary absorption tincture for thyroid/Hashimoto''s case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 390,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (17,
   'Schisandra in primary absorption tincture for thyroid/Hashimoto''s case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 400,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (206,
   'Milk thistle in primary absorption tincture for thyroid/Hashimoto''s case: tulsi, schisandra, ashwagandha, milk thistle, rosemary.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 410,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (109,
   'Rosemary in primary absorption tincture for thyroid/Hashimoto''s case; supports the body''s ability to take in nutrients through methylation.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 420,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (2238,
   'White Peony in reproductive tincture for thyroid/Hashimoto''s case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 430,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (167,
   'Cinnamon in reproductive tincture for thyroid/Hashimoto''s case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 440,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (22,
   'Burdock in reproductive tincture for thyroid/Hashimoto''s case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 450,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (78,
   'Licorice in reproductive tincture for thyroid/Hashimoto''s case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 460,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea'),

  (2229,
   'Gotu kola in reproductive tincture for thyroid/Hashimoto''s case: peony, cinnamon, burdock, licorice, gotu kola.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 470,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS — Selenium
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE supplement_id = 23 AND class_name = 'BHC - Class 67 - Thyroid'
  ) THEN
    RAISE NOTICE 'Class 67 Selenium snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (23,
   'Selenium at 200 micrograms recommended as starting point for thyroid support; Brazil nuts as food source.',
   'BHC - Class 67 - Thyroid', 'generated', 'Treatment Details', 480,
   '## Treatment Details
- Elimination diet to remove triggers
- Gut nourishment and probiotics
- Use vulneraries like plantain and calendula
- Modulation of immune function
- Selenium at 200 micrograms
	- Brazil nuts as source
- Herbal actions: anti-inflammatory, immune support
- Moistening adaptogens like schizandra
	- Ashwagandha for hypothyroid'),

  (23,
   'Selenium supplementation suggested alongside bladderwrack capsules in thyroid case treatment plan.',
   'BHC - Class 67 - Thyroid', 'generated', 'Digestive and Inflammatory Support', 490,
   '## Digestive and Inflammatory Support

- Adaptogen and nervine tincture
	- Ashwagandha, milky oat, licorice
- Digestive support
	- Blue vervain, cardamom, ginger
	- Infusion of alfalfa and red clover for nourishment
- Bladderwrack capsules
	- Selenium supplement suggested

### Dietary Adjustments

- Garlic, flaxseed oil
	- Reduces thyroid antibodies
	- Important selenium intake
- More cooking, garlic, legumes, vegetables
	- Variety and nutritional enhancement'),

  (23,
   'Selenium: antioxidant for thyroid health; low selenium is a correlation and risk factor for Hashimoto''s. Always start with selenium (200 mcg) for thyroid nourishment.',
   'BHC - Class 67 - Thyroid', 'personal', 'Herbal Actions for Thyroid Health', 500,
   '### Herbal Actions for Thyroid Health
- Antiinflammatory
- Immune modulating
    - Reishi
    - Astragalus
- Antioxidant
    - Selenium
    - Berries - Goji, Hawthorn, Elderberry
    - Hibiscus (check low blood pressure)
- Glucose regulating
    - Cinnamon
    - Tulsi
    - Bitter melon
- Hypolipidemic
    - Iris (help body metabolize fats)
    - Licorice
- Nervine (look at the person - are we scaffolding, calming?)
    - Milky oats
- Carminative
    - digestive secretions
- Digestive Bitters
    - getting that bile flowing
- Hepatoprotective
    - supporting the liver
- Adaptogens
    - will depend on the person
    - like the ginsengs - energizing
    - moistening - shatavari, astragalus
        - in case on the edge of burnout with dry tissues
    - ashwagandha has more of an affinity for Hypothyroidism
        - foggy, forgetful, slow transit time - specific for Ashwagandha
    - Tulsi, Motherwort (Rosmarinic acid - calm the uptake of T3 into the tissues)
        - specific for hyperthyroidism'),

  (23,
   'Selenium supplementation recommended in thyroid/Hashimoto''s case treatment plan.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 510,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS — Vitamin D
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE supplement_id = 11 AND class_name = 'BHC - Class 67 - Thyroid'
  ) THEN
    RAISE NOTICE 'Class 67 Vitamin D snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (11,
   'High dose vitamin D recommended to improve absorption in thyroid case; vitamin D deficiency linked to chronic inflammation and impaired ferritin levels.',
   'BHC - Class 67 - Thyroid', 'generated', 'Recommended Herbs and Supplements', 520,
   '## Recommended Herbs and Supplements

- Tincture components
	- Tulsi, schisandra, ashwagandha, milk thistle, rosemary
- Vitamin supplementation
	- High dose vitamin D to improve absorption
	- Ferritin for iron reserve

### Treatment Adjustments

- Stopping ineffective practices
	- Liver smoothie habit
	- Collaborate with naturopathic doctors
- Chronic inflammation considerations
	- Linked with vitamin D deficiency
	- Affect on ferritin levels and absorption'),

  (11,
   'Vitamin D 10K IU in thyroid/Hashimoto''s case; low Vit D can also affect Ferritin levels; deficiency correlated with Hashimoto''s.',
   'BHC - Class 67 - Thyroid', 'personal', 'Case Study', 530,
   '## Lisa

- first, get on top of absorption:
- Tincture:
    Tulsi
    Schisandra
    Ashwagandha
    Milk Thistle
    Rosemary - support the body''s ability to take in nutrients through that methylation

- Repro tincture:
    - Peony
    - Cinnamon
    - Burdock
    - Licorice
    - Gotu kola

- Vit D - 10K IU
- Selenium

---
H. pylori test
Supplementation:
- selenium supplementation
- Vitamin D supp

tinctures:
bitter digestive:
- blue vervain, cardamom, ginger
adaptogen nervine:
- ashwagandha, milky oats, licorice

- bladderwrack capsules
- Alfalfa and Red Clover tea');

END $$;

-- ============================================================
-- KEYWORDS — herbs
-- ============================================================

-- Guggul: Hashimoto's thyroiditis, hypothyroidism
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (877, 'Hashimoto''s thyroiditis', 'ailment'),
  (877, 'hypothyroidism', 'ailment'),
  (877, 'autoimmune disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bladderwrack: hypothyroidism, Hashimoto's, malnutrition
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (118, 'hypothyroidism', 'ailment'),
  (118, 'Hashimoto''s thyroiditis', 'ailment'),
  (118, 'malabsorption', 'ailment'),
  (118, 'hyperlipidemia', 'ailment'),
  (118, 'mineral support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Licorice: Hashimoto's, hypothyroidism, hypolipidemic
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78, 'Hashimoto''s thyroiditis', 'ailment'),
  (78, 'hypothyroidism', 'ailment'),
  (78, 'hyperlipidemia', 'ailment'),
  (78, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginseng: Hashimoto's
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14, 'Hashimoto''s thyroiditis', 'ailment'),
  (14, 'hypothyroidism', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Blue Flag (Iris versicolor): hypothyroidism, fat malabsorption, lymphatic support, hyperlipidemia
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (31, 'hypothyroidism', 'ailment'),
  (31, 'malabsorption', 'ailment'),
  (31, 'lymphatic support', 'ailment'),
  (31, 'hyperlipidemia', 'ailment'),
  (31, 'Hashimoto''s thyroiditis', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Plantain: leaky gut
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (85, 'leaky gut', 'ailment'),
  (85, 'gut inflammation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula: leaky gut
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'leaky gut', 'ailment'),
  (70, 'gut inflammation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Schizandra: hypothyroidism, adaptogen
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (17, 'hypothyroidism', 'ailment'),
  (17, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ashwagandha: hypothyroidism, brain fog, malabsorption, adaptogen
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (20, 'hypothyroidism', 'ailment'),
  (20, 'malabsorption', 'ailment'),
  (20, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bugleweed: hyperthyroidism, tachycardia, goiter
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (133, 'hyperthyroidism', 'ailment'),
  (133, 'tachycardia', 'ailment'),
  (133, 'goiter', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Motherwort: hyperthyroidism, tachycardia, cardiovascular disease
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (131, 'hyperthyroidism', 'ailment'),
  (131, 'tachycardia', 'ailment'),
  (131, 'cardiovascular disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rosemary: hyperthyroidism, autoimmune disease, methylation support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'hyperthyroidism', 'ailment'),
  (109, 'autoimmune disease', 'ailment'),
  (109, 'methylation support', 'action'),
  (109, 'detoxification', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Self Heal: hyperthyroidism, autoimmune disease
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2437, 'hyperthyroidism', 'ailment'),
  (2437, 'autoimmune disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lemon Balm: hyperthyroidism
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (134, 'hyperthyroidism', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Tulsi: hyperthyroidism, blood sugar dysregulation
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (13, 'hyperthyroidism', 'ailment'),
  (13, 'blood sugar dysregulation', 'ailment'),
  (13, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Milk Thistle: methylation support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (206, 'methylation support', 'action'),
  (206, 'malabsorption', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi: immune modulating, autoimmune disease
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11, 'autoimmune disease', 'ailment'),
  (11, 'hypothyroidism', 'ailment'),
  (11, 'immune modulating', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Astragalus: immune modulating, adaptogen
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (225, 'hypothyroidism', 'ailment'),
  (225, 'immune modulating', 'action'),
  (225, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hibiscus: antioxidant, hyperlipidemia
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2233, 'hyperlipidemia', 'ailment'),
  (2233, 'antioxidant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cinnamon: blood sugar dysregulation
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (167, 'blood sugar dysregulation', 'ailment'),
  (167, 'hypothyroidism', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bitter Melon: blood sugar dysregulation, insulin resistance
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2556, 'blood sugar dysregulation', 'ailment'),
  (2556, 'insulin resistance', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Milky Oats: adrenal fatigue, nervine trophorestorative
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (178, 'adrenal fatigue', 'ailment'),
  (178, 'hypothyroidism', 'ailment'),
  (178, 'trophorestorative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Poke Root: hypothyroidism, lymphatic support, breast cysts, mastitis
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (35, 'hypothyroidism', 'ailment'),
  (35, 'lymphatic support', 'ailment'),
  (35, 'breast cysts', 'ailment'),
  (35, 'mastitis', 'ailment'),
  (35, 'immune deficiency', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Root: breast cysts, mastitis, lymphatic support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (981, 'breast cysts', 'ailment'),
  (981, 'mastitis', 'ailment'),
  (981, 'lymphatic support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alfalfa: malabsorption, mineral support, hormonal support, bone density
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (885, 'malabsorption', 'ailment'),
  (885, 'mineral support', 'ailment'),
  (885, 'hormonal support', 'ailment'),
  (885, 'bone density', 'ailment'),
  (885, 'hyperlipidemia', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Clover: hormonal support, mineral support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (42, 'hormonal support', 'ailment'),
  (42, 'mineral support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Shatavari: adaptogen, hypothyroidism
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (852, 'adaptogen', 'action'),
  (852, 'hypothyroidism', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- White Peony: hormonal support, heavy bleeding
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2238, 'hormonal support', 'ailment'),
  (2238, 'heavy bleeding', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Burdock: hormonal support, liver support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (22, 'hormonal support', 'ailment'),
  (22, 'liver support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gotu Kola: leaky gut
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2229, 'leaky gut', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Blue Vervain: digestive tonic, stress
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (983, 'digestive tonic', 'ailment'),
  (983, 'stress', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Echinacea: immune deficiency (bacterial infections in feeble individuals)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26, 'immune deficiency', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wild Indigo (Baptisia): immune deficiency, bacterial infections
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (23, 'immune deficiency', 'ailment'),
  (23, 'acute illness', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- KEYWORDS — supplements
-- ============================================================

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (23, 'hypothyroidism', 'ailment'),
  (23, 'Hashimoto''s thyroiditis', 'ailment'),
  (23, 'autoimmune disease', 'ailment'),
  (23, 'antioxidant', 'action')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (11, 'hypothyroidism', 'ailment'),
  (11, 'Hashimoto''s thyroiditis', 'ailment'),
  (11, 'malabsorption', 'ailment'),
  (11, 'iron deficiency', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- AILMENT SEARCH TERMS — new keywords only
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('hyperthyroidism',
   ARRAY['overactive thyroid', 'thyrotoxicosis', 'Graves disease', 'elevated T3', 'elevated T4',
         'high thyroid function', 'thyroid overactivity']),
  ('Hashimoto''s thyroiditis',
   ARRAY['Hashimoto''s', 'autoimmune thyroiditis', 'chronic lymphocytic thyroiditis',
         'Hashimoto thyroiditis', 'autoimmune hypothyroidism', 'anti-TPO positive']),
  ('goiter',
   ARRAY['thyroid enlargement', 'enlarged thyroid', 'thyroid swelling', 'thyroid goiter']),
  ('malabsorption',
   ARRAY['nutrient malabsorption', 'poor absorption', 'impaired nutrient absorption',
         'intestinal malabsorption', 'maldigestion', 'poor nutrient assimilation'])
ON CONFLICT (ailment_keyword) DO NOTHING;
