SET search_path TO herbal, public;

-- Source files parsed:
--   BHC - Class 61 - Repro IV Hormonal Matrix - Generated Notes.md  (note_type='generated')
--   BHC - Class 61 - Repro IV Hormonal Matrix - Lisa.md             (note_type='personal')
--
-- Herb name normalisations applied:
--   "Eleuthero"      → Siberian Ginseng (Eleutherococcus senticosus, id=9)
--   "Reishi"         → Reishi Mushroom (Ganoderma lucidum, id=11)
--   "Ginsengs"       → Ginseng (Panax ginseng, id=14)
--   "Schisandra"     → Schizandra (Schisandra chinensis, id=17)
--   "Uva ursi"       → Bearberry (Arctostaphylos uva-ursi, id=46)
--   "Vitex"          → Chasteberry (Vitex agnus-castus, id=190)
--   "Trifolium"      → Red Clover (Trifolium pratense, id=42)
--   "White ash bark" → NOT in DB, skipped
--   "Blueberries"    → NOT in DB, skipped
--   "castor oil"     → preparation, not an herb entry, skipped

-- ─── Snippets: Class 61 ───────────────────────────────────────────────────────

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix') THEN
    RAISE NOTICE 'Class 61 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order)
  VALUES

  -- ── Generated Notes: Immune and Respiratory Support ──────────────────────
  (26,  'Echinacea for onset of illness',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Immune and Respiratory Support', 10),
  (21,  'Garlic in soups for immunity',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Immune and Respiratory Support', 20),
  (124, 'Steaming with ginger for respiratory relief',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Immune and Respiratory Support', 30),

  -- ── Generated Notes: Clinical Cases ──────────────────────────────────────
  (124, 'Ginger for digestive support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Clinical Cases', 40),
  (172, 'Artichoke leaf and mullein for liver and hydration',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Clinical Cases', 50),
  (61,  'Artichoke leaf and mullein for liver and hydration',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Clinical Cases', 60),
  (43,  'Nettle and raspberry for uterine tonic',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Clinical Cases', 70),
  (155, 'Nettle and raspberry for uterine tonic',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Clinical Cases', 80),

  -- ── Generated Notes: Chronic Pain and Nutrition ──────────────────────────
  (45,  'Use teas for hydration — marshmallow, linden, cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Chronic Pain and Nutrition', 90),
  (90,  'Use teas for hydration — marshmallow, linden, cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Chronic Pain and Nutrition', 100),
  (167, 'Use teas for hydration — marshmallow, linden, cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Chronic Pain and Nutrition', 110),

  -- ── Generated Notes: Fibroids and Uterine Health ─────────────────────────
  (78,  'Licorice for mineral support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Fibroids and Uterine Health', 120),
  (11,  'Reishi with white peony synergy',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Fibroids and Uterine Health', 130),
  (2238,'Reishi with white peony synergy',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Fibroids and Uterine Health', 140),

  -- ── Generated Notes: Herbal Preparation Tips ─────────────────────────────
  (852, 'Shatavari for hormone balance',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Herbal Preparation Tips', 150),

  -- ── Generated Notes: Inflammation and Gut Health ─────────────────────────
  (45,  'Marshmallow root for gut inflammation; blend with cinnamon and ashwagandha',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Inflammation and Gut Health', 160),
  (167, 'Marshmallow root blend with cinnamon and ashwagandha for gut inflammation',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Inflammation and Gut Health', 170),
  (20,  'Marshmallow root blend with cinnamon and ashwagandha for gut inflammation',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Inflammation and Gut Health', 180),

  -- ── Generated Notes: Balancing Mineral and Herb Effects ──────────────────
  (44,  'Addition of warming herbs like yarrow with cooling minerals',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Balancing Mineral and Herb Effects', 190),

  -- ── Generated Notes: Pelvic and Thyroid Support ──────────────────────────
  (1212,'Cranberry juice for UTI support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Pelvic and Thyroid Support', 200),

  -- ── Generated Notes: Complex Health Interactions ─────────────────────────
  (190, 'Vitex for hormonally induced symptoms',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Complex Health Interactions', 210),
  (1009,'Avoid dong quai for fibroids — dong quai is a tissue builder and can aggravate heavy bleeding',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Complex Health Interactions', 220),
  (25,  'Consider black cohosh as alternative to dong quai for fibroids',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Complex Health Interactions', 230),

  -- ── Generated Notes: Comprehensive Care ──────────────────────────────────
  (203, 'Turmeric and white peony for fibroid treatment',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Comprehensive Care', 240),
  (2238,'Turmeric and white peony for fibroid treatment',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Comprehensive Care', 250),
  (70,  'Calendula for immune and mucous membrane support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Comprehensive Care', 260),

  -- ── Generated Notes: Adaptogens and Carminatives ─────────────────────────
  (885, 'Alfalfa — alterative; suggested as part of morning routine',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Adaptogens and Carminatives', 270),
  (225, 'Astragalus — adaptogen; for prebiotic support, limit complexity in therapy',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Adaptogens and Carminatives', 280),

  -- ── Generated Notes: Dandelion and Prebiotics ────────────────────────────
  (122, 'Dandelion root — tea tonic, more bitter-specific',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Dandelion and Prebiotics', 290),
  (1648,'Dandelion leaf — diuretic, supports kidneys; flushes out microbes and proteins',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Dandelion and Prebiotics', 300),

  -- ── Generated Notes: Anxiety Support ─────────────────────────────────────
  (78,  'Licorice and rosemary — support anxiety',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Anxiety Support', 310),
  (109, 'Licorice and rosemary — support anxiety',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Anxiety Support', 320),
  (9,   'Eleuthero (Siberian Ginseng) — for energy, adaptogenic',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Anxiety Support', 330),
  (167, 'Cinnamon — astringent, supports appetite and circulation',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Anxiety Support', 340),
  (70,  'Calendula — immune support, hydrates mucous membranes',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Anxiety Support', 350),
  (74,  'Wild yam — anti-spasmodic, promotes bile flow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Anxiety Support', 360),

  -- ── Generated Notes: Vaginitis ───────────────────────────────────────────
  (203, 'Turmeric, ginger, black pepper — anti-inflammatory, synergistic; simmer 10 min, steep 10 min, twice daily',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Vaginitis', 370),
  (124, 'Turmeric, ginger, black pepper — anti-inflammatory decoction for vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Vaginitis', 380),
  (2498,'Turmeric, ginger, black pepper — synergistic anti-inflammatory for vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Vaginitis', 390),
  (70,  'Calendula and chamomile — infused bath to reduce inflammation in vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Vaginitis', 400),
  (84,  'Calendula and chamomile — infused bath to reduce inflammation in vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Vaginitis', 410),
  (206, 'Milk thistle — supports liver, metabolizes estrogen; used in vaginitis treatment',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Vaginitis', 420),

  -- ── Generated Notes: Nervous System Support ──────────────────────────────
  (14,  'Ginseng — use with caution; works best when nutritional foundation is already strong',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Nervous System Support', 430),
  (225, 'Astragalus as nourishing foundation when ginseng would be premature',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Nervous System Support', 440),

  -- ── Generated Notes: Fibroids and Vaginitis ──────────────────────────────
  (25,  'Black cohosh — helpful for premenopause; in tincture formula for fibroids and vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Fibroids and Vaginitis', 450),
  (46,  'Uva ursi — antimicrobial, anti-inflammatory; in tincture for fibroids and vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Fibroids and Vaginitis', 460),
  (136, 'Catnip — sedative; in tincture formula for fibroids and vaginitis',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Fibroids and Vaginitis', 470),

  -- ── Generated Notes: Regenerative Tea Blend ──────────────────────────────
  (151, 'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 480),
  (95,  'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 490),
  (43,  'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 500),
  (44,  'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 510),
  (1014,'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 520),
  (2233,'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 530),
  (42,  'Regenerative tea blend: horsetail, corn silk, nettle, yarrow, lady''s mantle, hibiscus, red clover — large daily infusions',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Regenerative Tea Blend', 540),

  -- ── Generated Notes: Hormone and Uterine Support ─────────────────────────
  (190, 'Vitex — hormone-balancing; in tincture for hormone and uterine support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Hormone and Uterine Support', 550),
  (17,  'Schisandra — hormone-balancing, astringent; in tincture for hormone and uterine support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Hormone and Uterine Support', 560),
  (155, 'Red raspberry leaf — uterine tonic; in tincture for hormone and uterine support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Hormone and Uterine Support', 570),

  -- ── Generated Notes: Traditional Formulas ────────────────────────────────
  (72,  'Blue cohosh, periwinkle, black cohosh — uterine tonic, astringents',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 580),
  (157, 'Blue cohosh, periwinkle, black cohosh — uterine tonic, astringents',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 590),
  (25,  'Blue cohosh, periwinkle, black cohosh — uterine tonic, astringents',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 600),
  (28,  'Cleavers — lymphatic support; add to formula for balance',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 610),
  (136, 'Stress formula — catnip, lemon balm, chamomile',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 620),
  (134, 'Stress formula — catnip, lemon balm, chamomile',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 630),
  (84,  'Stress formula — catnip, lemon balm, chamomile',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Traditional Formulas', 640),

  -- ── Generated Notes: Additional Herbs and Actions ────────────────────────
  (70,  'Perineal wash — calendula, plantain, rose, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Additional Herbs and Actions', 650),
  (85,  'Perineal wash — calendula, plantain, rose, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Additional Herbs and Actions', 660),
  (850, 'Perineal wash — calendula, plantain, rose, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Additional Herbs and Actions', 670),
  (44,  'Perineal wash — calendula, plantain, rose, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'generated',
        'Additional Herbs and Actions', 680),

  -- ── Personal Notes (Lisa.md): Presentations ──────────────────────────────
  (44,  'In a mineral formula (with nettles) — minerals are cooling, so add some warming herbs, for example Yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 10),
  (43,  'In a mineral formula (nettles etc.) — minerals are cooling; nettles as the mineral base',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 20),
  (71,  'Shepherd''s purse very effective for heavy bleeding — so effective it can clot up the uterus; only use in very heavy situations',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 30),
  (190, 'Vitex — dopamine agonist; allows the pituitary to release hormones; doesn''t affect the uterus directly',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 40),
  (1009,'Anytime heavy bleeding, dong quai can aggravate — dong quai is a tissue builder',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 50),
  (2238,'White peony — anti-fibrotic',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 60),
  (25,  'Black cohosh indicated for base of skull headaches, but can cause them if dose is too high',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 70),
  (206, 'Milk Thistle — helps with elimination of all things, enabling hormones to be better processed and eliminated',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 80),
  (14,  'Ginsengs work best when people are already well-resourced',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 90),
  (202, 'Aloe as a carrier for vaginal washes; oils can change pH of mucous tissues — wash or sitz bath is better',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Presentations', 100),

  -- ── Personal Notes (Lisa.md): Patient Case ───────────────────────────────
  (78,  'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover, Vitex, Cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 110),
  (2238,'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover, Vitex, Cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 120),
  (42,  'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover (Trifolium), Vitex, Cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 130),
  (190, 'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover, Vitex, Cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 140),
  (167, 'Patient formula (hormonal support — 2 tsp 3x/day): Licorice, White Peony, Red Clover, Vitex, Cinnamon',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 150),
  (70,  'Sitz bath (patient case): calendula, elecampane, rose petals, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 160),
  (54,  'Sitz bath (patient case): calendula, elecampane, rose petals, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 170),
  (850, 'Sitz bath (patient case): calendula, elecampane, rose petals, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 180),
  (44,  'Sitz bath (patient case): calendula, elecampane, rose petals, yarrow',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 190),
  (180, 'Flax seed 2 tbsp daily — in patient protocol for hormonal support',
        'BHC - Class 61 - Repro IV Hormonal Matrix', 'personal',
        'Lisa (Patient Case)', 200);

END $$;

-- ─── Keywords ────────────────────────────────────────────────────────────────

DO $$
BEGIN

INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES

  -- Siberian Ginseng / Eleuthero (9)
  (9,   'adaptogen',       'action'),
  (9,   'energy support',  'ailment'),
  (9,   'fatigue',         'symptom'),

  -- Reishi Mushroom (11)
  (11,  'fibroids',        'ailment'),
  (11,  'uterine health',  'ailment'),

  -- Ginseng (14)
  (14,  'adaptogen',       'action'),
  (14,  'energy support',  'ailment'),

  -- Schizandra (17)
  (17,  'hormonal support',   'ailment'),
  (17,  'hormonal imbalance', 'ailment'),
  (17,  'uterine support',    'ailment'),

  -- Ashwagandha (20)
  (20,  'gut inflammation',  'ailment'),
  (20,  'adaptogen',         'action'),

  -- Garlic (21)
  (21,  'immune support',    'ailment'),

  -- Black Cohosh (25)
  (25,  'fibroids',              'ailment'),
  (25,  'premenopause',          'ailment'),
  (25,  'perimenopause',         'ailment'),
  (25,  'uterine tonic',         'ailment'),
  (25,  'base of skull headache','symptom'),
  (25,  'headache',              'symptom'),

  -- Echinacea (26)
  (26,  'immune support',   'ailment'),
  (26,  'acute illness',    'ailment'),

  -- Cleavers (28)
  (28,  'lymphatic support', 'ailment'),

  -- Red Clover (42)
  (42,  'hormonal support',  'ailment'),
  (42,  'uterine tonic',     'ailment'),
  (42,  'estrogen support',  'ailment'),

  -- Nettle leaf (43)
  (43,  'uterine tonic',     'ailment'),
  (43,  'mineral support',   'ailment'),

  -- Yarrow (44)
  (44,  'mineral support',   'ailment'),
  (44,  'warming',           'action'),

  -- Marshmallow (45)
  (45,  'gut inflammation',        'ailment'),
  (45,  'digestive support',       'ailment'),
  (45,  'mucous membrane support', 'ailment'),

  -- Bearberry / Uva Ursi (46)
  (46,  'vaginitis',         'ailment'),
  (46,  'UTI',               'ailment'),
  (46,  'antimicrobial',     'action'),
  (46,  'anti-inflammatory', 'action'),

  -- Elecampane (54)
  (54,  'uterine support',      'ailment'),
  (54,  'reproductive support', 'ailment'),

  -- Mullein leaf (61)
  (61,  'liver support',     'ailment'),

  -- Calendula (70)
  (70,  'immune support',          'ailment'),
  (70,  'mucous membrane support', 'ailment'),
  (70,  'vaginitis',               'ailment'),

  -- Shepherd''s Purse (71)
  (71,  'heavy bleeding',   'ailment'),
  (71,  'uterine bleeding', 'ailment'),
  (71,  'hemostatic',       'action'),

  -- Blue Cohosh (72)
  (72,  'uterine tonic',    'ailment'),
  (72,  'uterine support',  'ailment'),

  -- Wild Yam (74)
  (74,  'anti-spasmodic',   'action'),
  (74,  'cramps',           'symptom'),
  (74,  'bile flow',        'ailment'),

  -- Licorice (78)
  (78,  'fibroids',          'ailment'),
  (78,  'mineral support',   'ailment'),
  (78,  'anxiety',           'ailment'),
  (78,  'hormonal support',  'ailment'),

  -- Chamomile (84)
  (84,  'vaginitis',         'ailment'),
  (84,  'stress',            'ailment'),
  (84,  'anxiety',           'ailment'),
  (84,  'inflammation',      'ailment'),

  -- Plantain (85)
  (85,  'wound healing',     'action'),
  (85,  'perineal care',     'general'),

  -- Linden (90)
  (90,  'hydration',         'ailment'),
  (90,  'digestive support', 'ailment'),
  (90,  'demulcent',         'action'),

  -- Corn Silk (95)
  (95,  'mineral support',   'ailment'),
  (95,  'kidney support',    'ailment'),

  -- Rosemary (109)
  (109, 'anxiety',           'ailment'),
  (109, 'stress',            'ailment'),

  -- Dandelion root (122)
  (122, 'digestive tonic',   'ailment'),
  (122, 'bitter tonic',      'action'),

  -- Ginger (124)
  (124, 'digestive support', 'ailment'),
  (124, 'vaginitis',         'ailment'),
  (124, 'anti-inflammatory', 'action'),

  -- Lemon Balm (134)
  (134, 'anxiety',           'ailment'),
  (134, 'stress',            'ailment'),

  -- Catnip (136)
  (136, 'sedative',          'action'),
  (136, 'stress',            'ailment'),
  (136, 'anxiety',           'ailment'),
  (136, 'fibroids',          'ailment'),
  (136, 'vaginitis',         'ailment'),

  -- Horsetail (151)
  (151, 'mineral support',   'ailment'),
  (151, 'regenerative',      'action'),

  -- Raspberry leaf (155)
  (155, 'uterine tonic',     'ailment'),
  (155, 'hormonal support',  'ailment'),

  -- Periwinkle (157)
  (157, 'uterine tonic',     'ailment'),

  -- Cinnamon (167)
  (167, 'gut inflammation',  'ailment'),
  (167, 'circulation',       'ailment'),
  (167, 'hormonal support',  'ailment'),

  -- Artichoke (172)
  (172, 'liver support',     'ailment'),

  -- Flax (180)
  (180, 'hormonal support',  'ailment'),

  -- Chasteberry / Vitex (190)
  (190, 'hormonal imbalance', 'ailment'),
  (190, 'hormonal support',   'ailment'),
  (190, 'fibroids',           'ailment'),
  (190, 'premenopause',       'ailment'),
  (190, 'perimenopause',      'ailment'),
  (190, 'pituitary support',  'ailment'),
  (190, 'dopamine support',   'action'),

  -- Aloe (202)
  (202, 'vaginitis',               'ailment'),
  (202, 'mucous membrane support', 'ailment'),

  -- Turmeric (203)
  (203, 'fibroids',          'ailment'),
  (203, 'vaginitis',         'ailment'),
  (203, 'anti-inflammatory', 'action'),

  -- Milk Thistle (206)
  (206, 'liver support',       'ailment'),
  (206, 'estrogen metabolism', 'ailment'),
  (206, 'vaginitis',           'ailment'),
  (206, 'hormonal support',    'ailment'),

  -- Astragalus (225)
  (225, 'adaptogen',          'action'),
  (225, 'immune support',     'ailment'),
  (225, 'nourishing tonic',   'action'),

  -- Rose petals (850)
  (850, 'perineal care',      'general'),

  -- Shatavari (852)
  (852, 'hormone balance',    'ailment'),
  (852, 'hormonal support',   'ailment'),

  -- Alfalfa (885)
  (885, 'adaptogen',          'action'),
  (885, 'alterative',         'action'),

  -- Dong Quai (1009)
  (1009,'fibroids',           'ailment'),
  (1009,'heavy bleeding',     'ailment'),
  (1009,'uterine health',     'ailment'),

  -- Lady''s Mantle (1014)
  (1014,'uterine tonic',      'ailment'),
  (1014,'heavy bleeding',     'ailment'),
  (1014,'mineral support',    'ailment'),

  -- Cranberry (1212)
  (1212,'UTI',                        'ailment'),
  (1212,'urinary tract infection',    'ailment'),

  -- Dandelion leaf (1648)
  (1648,'diuretic',           'action'),
  (1648,'kidney support',     'ailment'),

  -- Hibiscus (2233)
  (2233,'mineral support',    'ailment'),
  (2233,'regenerative',       'action'),

  -- White Peony root (2238)
  (2238,'fibroids',           'ailment'),
  (2238,'anti-fibrotic',      'action'),
  (2238,'hormonal support',   'ailment'),
  (2238,'uterine health',     'ailment'),

  -- Black Pepper (2498)
  (2498,'vaginitis',          'ailment'),
  (2498,'anti-inflammatory',  'action')

ON CONFLICT (herb_id, keyword) DO NOTHING;

END $$;

