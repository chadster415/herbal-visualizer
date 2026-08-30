SET search_path TO herbal, public;

-- ─── Class 60: AMAB Health and Lotions ────────────────────────────────────────
-- Files parsed:
--   BHC - Class 60 - AMAB Health and Lotions - Generated Notes.md (note_type='generated')
--   BHC - Class 60 - AMAB Health and Lotions - Bonnie-Rose Rose.md (note_type='personal')
--
-- Normalizations:
--   "Green tea" → Tea (Camellia sinensis, id 149)
--   "Nettle root" → Nettle (Urtica dioica, root, id 1649)
--   "Reishio" [typo] → Reishi Mushroom (Ganoderma lucidum, id 11)
--   "P. ginseng" → Ginseng (Panax ginseng, id 14)
--   "Ash" [abbreviation] → Ashwagandha (Withania somnifera, id 20)
--   "Sars" [abbreviation] → Sarsaparilla (Smilax spp., id 40)
--
-- Skipped herbs (not in DB):
--   White sage (Salvia apiana), Hydrangea root, Horny Goat Weed (Epimedium), Pine pollen
--
-- Skipped (non-herb foods/supplements):
--   Seaweeds, eggs, shellfish, cherries, berries, pomegranate, probiotics, Vitamin D
--   Zinc included via Pumpkin seeds (Cucurbita pepo, id 183) — the herb source
--
-- New ailment keywords: BPH, prostatitis, prostate cancer, andropause,
--   erectile dysfunction, low testosterone
-- Ailment keyword merges:
--   "androgen excess" → hormonal imbalance (existing)
--   "sperm health" → reproductive support (existing)
--   "prostate health" (too general) → split into BPH / prostatitis / prostate cancer

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 60 - AMAB Health and Lotions') THEN
    RAISE NOTICE 'Class 60 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ── Generated: Testosterone Regulation ──────────────────────────────────────
  (186, 'Herbs to down-regulate 5-alpha reductase — Saw palmetto',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Testosterone Regulation', 10,
   '- Herbs to down-regulate 5-alpha reductase:
	- Saw palmetto
	- Green tea
	- Nettle root
	- Turmeric root'),

  (149, 'Herbs to down-regulate 5-alpha reductase — Green tea',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Testosterone Regulation', 20,
   '- Herbs to down-regulate 5-alpha reductase:
	- Saw palmetto
	- Green tea
	- Nettle root
	- Turmeric root'),

  (1649, 'Herbs to down-regulate 5-alpha reductase — Nettle root',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Testosterone Regulation', 30,
   '- Herbs to down-regulate 5-alpha reductase:
	- Saw palmetto
	- Green tea
	- Nettle root
	- Turmeric root'),

  (203, 'Herbs to down-regulate 5-alpha reductase — Turmeric root',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Testosterone Regulation', 40,
   '- Herbs to down-regulate 5-alpha reductase:
	- Saw palmetto
	- Green tea
	- Nettle root
	- Turmeric root'),

  -- ── Generated: Men's Health ──────────────────────────────────────────────────
  (22, 'Alteratives to clear excess estrogen — Burdock and Sarsaparilla',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Men''s Health', 50,
   '- Alteratives — clear excess estrogen:
	- Burdock and Sarsaparilla
- Ashwagandha
	- Considered yang tonic in Ayurveda
	- Helps with stress; "strength of the horse"
	- Hormonal cascade: not converting to cortisol increases testosterone
- Important anti-inflammatory herbs:
	- Saw Palmetto — strong taste, better in capsule form
	- Nettle Root'),

  (40, 'Alteratives to clear excess estrogen — Burdock and Sarsaparilla',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Men''s Health', 60,
   '- Alteratives — clear excess estrogen:
	- Burdock and Sarsaparilla
- Ashwagandha
	- Considered yang tonic in Ayurveda
	- Helps with stress; "strength of the horse"
	- Hormonal cascade: not converting to cortisol increases testosterone
- Important anti-inflammatory herbs:
	- Saw Palmetto — strong taste, better in capsule form
	- Nettle Root'),

  (20, 'Ashwagandha — yang tonic in Ayurveda, helps with stress; reducing cortisol conversion increases testosterone',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Men''s Health', 70,
   '- Alteratives — clear excess estrogen:
	- Burdock and Sarsaparilla
- Ashwagandha
	- Considered yang tonic in Ayurveda
	- Helps with stress; "strength of the horse"
	- Hormonal cascade: not converting to cortisol increases testosterone
- Important anti-inflammatory herbs:
	- Saw Palmetto — strong taste, better in capsule form
	- Nettle Root'),

  (186, 'Important anti-inflammatory herbs for men''s health — Saw Palmetto; strong taste, better in capsule form',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Men''s Health', 80,
   '- Alteratives — clear excess estrogen:
	- Burdock and Sarsaparilla
- Ashwagandha
	- Considered yang tonic in Ayurveda
	- Helps with stress; "strength of the horse"
	- Hormonal cascade: not converting to cortisol increases testosterone
- Important anti-inflammatory herbs:
	- Saw Palmetto — strong taste, better in capsule form
	- Nettle Root'),

  (1649, 'Important anti-inflammatory herbs for men''s health — Nettle Root',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Men''s Health', 90,
   '- Alteratives — clear excess estrogen:
	- Burdock and Sarsaparilla
- Ashwagandha
	- Considered yang tonic in Ayurveda
	- Helps with stress; "strength of the horse"
	- Hormonal cascade: not converting to cortisol increases testosterone
- Important anti-inflammatory herbs:
	- Saw Palmetto — strong taste, better in capsule form
	- Nettle Root'),

  -- ── Generated: Case Study (BPH client) ──────────────────────────────────────
  (206, 'Use milk thistle as liver support (capsule form) — in BPH client case study',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Case Study', 100,
   '- Client with BPH history; beta-blockers and compliance
- Options discussed:
	- Milk thistle as liver support (capsule form for ease of use)
	- Adaptogens like Turmeric for support
- Consider cultural background and comfort in herbal recommendations'),

  (203, 'Adaptogens like Turmeric for support — in BPH client case study',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Case Study', 110,
   '- Client with BPH history; beta-blockers and compliance
- Options discussed:
	- Milk thistle as liver support (capsule form for ease of use)
	- Adaptogens like Turmeric for support
- Consider cultural background and comfort in herbal recommendations'),

  -- ── Generated: BPH (combines "## Prostate Health and BPH" + "## BPH") ────────
  (186, 'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'BPH', 120,
   '**Prostate Health:**
- Processed foods increase risk (bread, sugar, alcohol, caffeine)
- Reduce caffeine gradually (half-cup increments)
- Pumpkin seeds beneficial for sperm health (zinc content)

**BPH:**
- Prostate likened to walnut-sized organ; inflammation narrows urine passage
	- Causes dribbling, urgency, incomplete emptying
- Medication: alpha-blockers, 5-alpha reductase inhibitors
- Herbal support:
	- Saw palmetto, nettle root, green tea, white sage, pumpkin seed oil, pomegranate
		- Anti-inflammatory; suggested product: Gaia Herbs formula'),

  (1649, 'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'BPH', 130,
   '**Prostate Health:**
- Processed foods increase risk (bread, sugar, alcohol, caffeine)
- Reduce caffeine gradually (half-cup increments)
- Pumpkin seeds beneficial for sperm health (zinc content)

**BPH:**
- Prostate likened to walnut-sized organ; inflammation narrows urine passage
	- Causes dribbling, urgency, incomplete emptying
- Medication: alpha-blockers, 5-alpha reductase inhibitors
- Herbal support:
	- Saw palmetto, nettle root, green tea, white sage, pumpkin seed oil, pomegranate
		- Anti-inflammatory; suggested product: Gaia Herbs formula'),

  (149, 'Herbal support for BPH — Saw palmetto, nettle root, green tea; anti-inflammatory; Gaia Herbs formula suggested',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'BPH', 140,
   '**Prostate Health:**
- Processed foods increase risk (bread, sugar, alcohol, caffeine)
- Reduce caffeine gradually (half-cup increments)
- Pumpkin seeds beneficial for sperm health (zinc content)

**BPH:**
- Prostate likened to walnut-sized organ; inflammation narrows urine passage
	- Causes dribbling, urgency, incomplete emptying
- Medication: alpha-blockers, 5-alpha reductase inhibitors
- Herbal support:
	- Saw palmetto, nettle root, green tea, white sage, pumpkin seed oil, pomegranate
		- Anti-inflammatory; suggested product: Gaia Herbs formula'),

  (183, 'Pumpkin seeds beneficial for sperm health (zinc content); pumpkin seed oil in BPH herbal formula',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'BPH', 145,
   '**Prostate Health:**
- Processed foods increase risk (bread, sugar, alcohol, caffeine)
- Reduce caffeine gradually (half-cup increments)
- Pumpkin seeds beneficial for sperm health (zinc content)

**BPH:**
- Prostate likened to walnut-sized organ; inflammation narrows urine passage
	- Causes dribbling, urgency, incomplete emptying
- Medication: alpha-blockers, 5-alpha reductase inhibitors
- Herbal support:
	- Saw palmetto, nettle root, green tea, white sage, pumpkin seed oil, pomegranate
		- Anti-inflammatory; suggested product: Gaia Herbs formula'),

  -- ── Generated: Anti-inflammatory Support ────────────────────────────────────
  (203, 'Turmeric — anti-inflammatory diet and lifestyle for prostate health and BPH',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Anti-inflammatory Support', 150,
   '- Recommend a whole-foods approach
- Turmeric
- Marshmallow root for soothing
- Probiotics and antioxidant-rich foods (berries, fish, mushrooms)'),

  (45, 'Marshmallow root for soothing — anti-inflammatory diet and lifestyle for prostate health and BPH',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Anti-inflammatory Support', 160,
   '- Recommend a whole-foods approach
- Turmeric
- Marshmallow root for soothing
- Probiotics and antioxidant-rich foods (berries, fish, mushrooms)'),

  -- ── Personal: Testosterone Regulation (from ### 5-alpha reductase) ──────────
  (186, 'Saw palmetto, green tea, nettle root, turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase to reduce DHT in hormone-sensitive prostate tissue',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Testosterone Regulation', 10,
   '- enzyme that converts testosterone into a more powerful and active form (DHT)
- DHT can''t be changed back
- when prostate is enlarged/cancer, we want to down-regulate its production in hormone-sensitive tissues like the prostate
- herbs:
    - saw palmetto, green tea, nettle root, turmeric, reishi and P. ginseng
    - nettle root super gentle'),

  (149, 'Saw palmetto, green tea, nettle root, turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase to reduce DHT in hormone-sensitive prostate tissue',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Testosterone Regulation', 20,
   '- enzyme that converts testosterone into a more powerful and active form (DHT)
- DHT can''t be changed back
- when prostate is enlarged/cancer, we want to down-regulate its production in hormone-sensitive tissues like the prostate
- herbs:
    - saw palmetto, green tea, nettle root, turmeric, reishi and P. ginseng
    - nettle root super gentle'),

  (1649, 'Saw palmetto, green tea, nettle root (super gentle), turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Testosterone Regulation', 30,
   '- enzyme that converts testosterone into a more powerful and active form (DHT)
- DHT can''t be changed back
- when prostate is enlarged/cancer, we want to down-regulate its production in hormone-sensitive tissues like the prostate
- herbs:
    - saw palmetto, green tea, nettle root, turmeric, reishi and P. ginseng
    - nettle root super gentle'),

  (203, 'Saw palmetto, green tea, nettle root, turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Testosterone Regulation', 40,
   '- enzyme that converts testosterone into a more powerful and active form (DHT)
- DHT can''t be changed back
- when prostate is enlarged/cancer, we want to down-regulate its production in hormone-sensitive tissues like the prostate
- herbs:
    - saw palmetto, green tea, nettle root, turmeric, reishi and P. ginseng
    - nettle root super gentle'),

  (11, 'Saw palmetto, green tea, nettle root, turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Testosterone Regulation', 50,
   '- enzyme that converts testosterone into a more powerful and active form (DHT)
- DHT can''t be changed back
- when prostate is enlarged/cancer, we want to down-regulate its production in hormone-sensitive tissues like the prostate
- herbs:
    - saw palmetto, green tea, nettle root, turmeric, reishi and P. ginseng
    - nettle root super gentle'),

  (14, 'Saw palmetto, green tea, nettle root, turmeric, reishi and Panax ginseng — down-regulate 5-alpha reductase',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Testosterone Regulation', 60,
   '- enzyme that converts testosterone into a more powerful and active form (DHT)
- DHT can''t be changed back
- when prostate is enlarged/cancer, we want to down-regulate its production in hormone-sensitive tissues like the prostate
- herbs:
    - saw palmetto, green tea, nettle root, turmeric, reishi and P. ginseng
    - nettle root super gentle'),

  -- ── Personal: Alteratives ────────────────────────────────────────────────────
  (22, 'Alteratives — clear excess androgens circulating in the blood — Burdock, Figwort, Sarsaparilla, Yellow Dock',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Alteratives', 70,
   '- clear excess androgens circulating in the blood
- Burdock
- Figwort
- Sarsaparilla
- Yellow Dock'),

  (39, 'Alteratives — clear excess androgens circulating in the blood — Burdock, Figwort, Sarsaparilla, Yellow Dock',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Alteratives', 80,
   '- clear excess androgens circulating in the blood
- Burdock
- Figwort
- Sarsaparilla
- Yellow Dock'),

  (40, 'Alteratives — clear excess androgens circulating in the blood — Burdock, Figwort, Sarsaparilla, Yellow Dock',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Alteratives', 90,
   '- clear excess androgens circulating in the blood
- Burdock
- Figwort
- Sarsaparilla
- Yellow Dock'),

  (37, 'Alteratives — clear excess androgens circulating in the blood — Burdock, Figwort, Sarsaparilla, Yellow Dock',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Alteratives', 100,
   '- clear excess androgens circulating in the blood
- Burdock
- Figwort
- Sarsaparilla
- Yellow Dock'),

  -- ── Personal: Adaptogens ─────────────────────────────────────────────────────
  (20, 'Adaptogens for sex hormone regulation — Ashwagandha (yang tonic for masculine energy), Ginsengs, Maca; cycle 1-3 months',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Adaptogens', 110,
   '- sex hormone regulation and modulation
- Ashwagandha
    - yang tonic, for the masculine energy
- Ginsengs
- Horny Goat Weed
- Maca'),

  (14, 'Adaptogens for sex hormone regulation — Ashwagandha (yang tonic), Ginsengs, Maca',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Adaptogens', 120,
   '- sex hormone regulation and modulation
- Ashwagandha
    - yang tonic, for the masculine energy
- Ginsengs
- Horny Goat Weed
- Maca'),

  (851, 'Adaptogens for sex hormone regulation — Ashwagandha (yang tonic), Ginsengs, Maca',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Adaptogens', 130,
   '- sex hormone regulation and modulation
- Ashwagandha
    - yang tonic, for the masculine energy
- Ginsengs
- Horny Goat Weed
- Maca'),

  -- ── Personal: Anti-Inflammatory (from ### AI) ────────────────────────────────
  (186, 'Anti-inflammatory herbs to reduce prostate inflammation — Saw Palmetto, Nettle root, Hydrangea root, White sage',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Anti-Inflammatory', 140,
   '- reduce prostate inflammation
- Saw Palmetto
- Nettle root
- Hydrangea root
- White sage'),

  (1649, 'Anti-inflammatory herbs to reduce prostate inflammation — Saw Palmetto, Nettle root',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Anti-Inflammatory', 150,
   '- reduce prostate inflammation
- Saw Palmetto
- Nettle root
- Hydrangea root
- White sage'),

  -- ── Personal: Antioxidant Support ───────────────────────────────────────────
  (149, 'Antioxidants to reduce free radicals and oxidation in the body — green tea, turmeric',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Antioxidant Support', 160,
   '- reduce free radicals and oxidation in the body
- green tea
- turmeric
- cherries
- berries'),

  (203, 'Antioxidants to reduce free radicals and oxidation in the body — green tea, turmeric',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Antioxidant Support', 170,
   '- reduce free radicals and oxidation in the body
- green tea
- turmeric
- cherries
- berries'),

  -- ── Personal: Astringents ────────────────────────────────────────────────────
  (148, 'Astringent herbs for urinary and reproductive health — agrimony, horsetail',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Astringents', 180,
   '- help with urinary and reproductive health
- agrimony
- horsetail'),

  (151, 'Astringent herbs for urinary and reproductive health — agrimony, horsetail',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Astringents', 190,
   '- help with urinary and reproductive health
- agrimony
- horsetail'),

  -- ── Personal: Andropause ─────────────────────────────────────────────────────
  (178, 'Milky oats and neurorestorative for andropause support; alongside stress reduction, adaptogens, and circulatory stimulants',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Andropause', 200,
   '- help produce testosterone naturally:
    - reduce stress
    - adaptogen - 1-3 months then switching ("don''t adapt.. change")
    - circulatory stimulant
    - milky oats and neurorestorative
- pine pollen (limited herbal effect compared to pharmaceuticals)
- avoid testosterone agonists: beer'),

  -- ── Personal: Takeaway (zinc and antioxidants) ───────────────────────────────
  (183, 'Zinc depleted through semen expression — pumpkin seeds as food source for replenishment',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Takeaway', 210,
   '- zinc is depleted through semen expression
    - seaweeds, pumpkin seeds, eggs, shellfish
- antioxidant-rich foods:
    - berries, cherries, green tea and turmeric'),

  -- ── Personal: Erectile Dysfunction ──────────────────────────────────────────
  (183, 'Diet for erectile dysfunction — zinc from pumpkin seeds; avoid processed food, refined grains, alcohol, sugar, caffeine',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Erectile Dysfunction', 220,
   '- can be physical reasons; but majority may be emotional, psychological, spiritual
- actions: aphrodisiac, adaptogen, circulatory stimulant, nervine, nutritive/tonic, vasodilator
- lifestyle: regular exercise, kegels, hot/cold showers
- diet:
    - avoid processed food, refined grains, alcohol, sugar, caffeine
    - zinc: pumpkin seeds
    - Rosemary Gladstar: energy-herb balls and power-powder balls'),

  -- ── Personal: Case Study ─────────────────────────────────────────────────────
  (95, 'Case Study — Corn Silk for electrolytes and urinary support',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Case Study', 230,
   'Electrolytes
Corn Silk

Hawthorn not good for the low heart rate'),

  (73, 'Case Study — Hawthorn not good for low heart rate (caution for patients with bradycardia)',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Case Study', 240,
   'Electrolytes
Corn Silk

Hawthorn not good for the low heart rate');

END $$;

-- ─── Keywords ─────────────────────────────────────────────────────────────────

-- Saw Palmetto (186)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (186, 'BPH', 'ailment'),
  (186, 'prostatitis', 'ailment'),
  (186, 'prostate cancer', 'ailment'),
  (186, 'anti-inflammatory', 'action'),
  (186, '5-alpha reductase inhibitor', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Tea / Green Tea (149)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (149, 'BPH', 'ailment'),
  (149, 'prostate cancer', 'ailment'),
  (149, 'antioxidant', 'action'),
  (149, '5-alpha reductase inhibitor', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle root (1649)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1649, 'BPH', 'ailment'),
  (1649, 'prostatitis', 'ailment'),
  (1649, 'prostate cancer', 'ailment'),
  (1649, 'anti-inflammatory', 'action'),
  (1649, '5-alpha reductase inhibitor', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Turmeric (203)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (203, 'BPH', 'ailment'),
  (203, 'prostate cancer', 'ailment'),
  (203, 'inflammation', 'ailment'),
  (203, 'antioxidant', 'action'),
  (203, '5-alpha reductase inhibitor', 'action'),
  (203, 'liver support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Burdock (22)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (22, 'hormonal imbalance', 'ailment'),
  (22, 'alterative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Sarsaparilla (40)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (40, 'hormonal imbalance', 'ailment'),
  (40, 'alterative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Figwort (39)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (39, 'hormonal imbalance', 'ailment'),
  (39, 'alterative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yellow Dock (37)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (37, 'hormonal imbalance', 'ailment'),
  (37, 'alterative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ashwagandha (20)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (20, 'andropause', 'ailment'),
  (20, 'low testosterone', 'ailment'),
  (20, 'stress', 'ailment'),
  (20, 'reproductive support', 'ailment'),
  (20, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Milk Thistle (206)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (206, 'liver support', 'ailment'),
  (206, 'BPH', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Marshmallow (45)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'BPH', 'ailment'),
  (45, 'inflammation', 'ailment'),
  (45, 'demulcent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi Mushroom (11)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11, 'BPH', 'ailment'),
  (11, 'prostate cancer', 'ailment'),
  (11, '5-alpha reductase inhibitor', 'action'),
  (11, 'immune support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginseng (14)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14, 'BPH', 'ailment'),
  (14, 'prostate cancer', 'ailment'),
  (14, 'andropause', 'ailment'),
  (14, 'energy support', 'ailment'),
  (14, '5-alpha reductase inhibitor', 'action'),
  (14, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Maca (851)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (851, 'andropause', 'ailment'),
  (851, 'low testosterone', 'ailment'),
  (851, 'erectile dysfunction', 'ailment'),
  (851, 'reproductive support', 'ailment'),
  (851, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pumpkin (183)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (183, 'BPH', 'ailment'),
  (183, 'erectile dysfunction', 'ailment'),
  (183, 'reproductive support', 'ailment'),
  (183, 'mineral support', 'ailment'),
  (183, 'nutritive', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Agrimony (148)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (148, 'urinary tract infection', 'ailment'),
  (148, 'BPH', 'ailment'),
  (148, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Horsetail (151)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (151, 'urinary tract infection', 'ailment'),
  (151, 'BPH', 'ailment'),
  (151, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oat milky oats (178)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (178, 'andropause', 'ailment'),
  (178, 'stress', 'ailment'),
  (178, 'nervine', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Corn Silk (95)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (95, 'urinary tract infection', 'ailment'),
  (95, 'BPH', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hawthorn berry (73)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73, 'circulation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ─── Ailment search synonyms (new keywords only) ──────────────────────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('BPH',                ARRAY['benign prostatic hyperplasia','prostate enlargement','enlarged prostate','prostate hypertrophy','prostate']),
  ('prostatitis',        ARRAY['prostate inflammation','prostate infection','inflamed prostate','prostate pain']),
  ('prostate cancer',    ARRAY['prostate malignancy','prostate carcinoma','prostate tumor','hormone-sensitive cancer']),
  ('andropause',         ARRAY['male menopause','androgen decline','testosterone decline','male climacteric','aging male','low T']),
  ('erectile dysfunction',ARRAY['ED','impotence','male sexual dysfunction','erection problems','sexual dysfunction']),
  ('low testosterone',   ARRAY['hypogonadism','androgen deficiency','testosterone deficiency','low T','andropause'])
ON CONFLICT (ailment_keyword) DO NOTHING;
