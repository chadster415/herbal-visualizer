-- Migration 368: Class 25 — Seaweed and Menopause class notes
-- Parsed from: BHC - Class 25 - Seaweed and Menopause - Tanya Lisa.md (personal)
-- class_name: 'BHC - Class 25 - Seaweed and Menopause'
--
-- Herb normalisations:
--   Bladderwrack (Fucus spp.) → Kelp (id=118, Fucus vesiculosus) — same genus
--   Kombu (Laminaria spp.)   → Kelp (Laminaria) (id=2248, Laminaria digitata)
--   Vitex                    → Chasteberry (id=190)
--   OGR / Oregon Grape Root  → Oregon Grape (id=33)
--   Tulsi                    → Holy Basil (id=13)
--   orange peel              → Sweet Orange (id=748, Citrus sinensis)
--
-- Skipped seaweeds (not in DB, primarily nutritional mentions):
--   Wakame (Alaria spp.), Dulse (Palmaria palmatus), Sea Palm (Postelia palmaeformis),
--   Feather Boa (Egregia spp.), Nori (Porphyra spp.), Turkish Towel (Gigartina spp.),
--   Sea Lettuce (Ulva spp.)
--
-- New ailment keywords: heavy metal detox, vaginal dryness
-- Keyword merge decisions:
--   "thyroid support"    → hypothyroidism (existing, more specific)
--   "metabolic support"  → metabolic syndrome (existing)
--   "blood sugar regulation" → blood sugar dysregulation (existing)

SET search_path TO herbal, public;

DO $$
DECLARE
  v_sb_bladderwrack      TEXT;
  v_sb_kombu             TEXT;
  v_sb_herbal_actions    TEXT;
  v_sb_physical_changes  TEXT;
  v_sb_case_study        TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 25 - Seaweed and Menopause') THEN
    RAISE NOTICE 'Class 25 snippets already loaded, skipping';
    RETURN;
  END IF;

  v_sb_bladderwrack := $q$#### Bladderwrack (Fucus spp.)
- highest in iodine
- Lock and Key hypothesis
    - receptors only get absorbed if the key works
    - seaweeds pull out heavy metals with their locks
- Ryan Drum - ex-professor at Bastyr University
    - seaweed harvest after Fukushima
    - higher fats accumulate toxins
- traditionally used for thyroid support
- supporting lymphatic movement
- reducing inflammation
- supplies trace minerals
- tincture- hypothyroid conditions
- pain oil$q$;

  v_sb_kombu := $q$#### Kombu (Laminaria spp.)
- flavor enhancer - Dashi
- also high in iodine
- small strip added to broth usually enough
- very potent
- book: Pacific Seaweeds (id guide with color plates)
- supports digestion
- add to beans to reduce gas
- high in minerals
- useful for CV health$q$;

  v_sb_herbal_actions := $q$### Herbal Actions for the Perimenopausal  Period
- Adaptogens
    - can both up and down regulate
    - respond to the needs of the individual body
    - examples:
        - Shatavari - this is a drying phase of life, and this brings more juiciness to the tissues
        - Ashwagandha - if someone is stagnant or depressed, sluggish, grief or sadness
            - milk - 1/2 tsp ashwagandha powder with cinnamon and cardamom - at night for sleep with nutmeg, simmer with a little milk of choice
        - Ginsengs - cautious though for people's resources, give only to someone with good regular nourishment, not a replacement for that
        - Licorice - powerful and complicated - supports metabolism
            - can up and down-regulate cortisol
            - hepatoprotective, regulate BS
            - rich in isoflavones
- Nervines
    - nourish and tonify, some people relax and some people stimulate
- Alteratives
    - all the elimination pathways working as optimally as possible
- Demulcents
    - mucus functional
    - examples:
        - Licorice
        - Marshmallow + cinnamon to add warmth to the cooling Marshmallow
- Metabolic Support
    - examples:
        - Licorice again
        - Sarsaparilla
        - Dandelion root
        - Burdock
        - if BS dysregulation, then Berberine: OGR, Barberry
        - if hyperthyroid picture, then Rosmarinic-rich: Tulsi, Lemon Balm
            - look underweight, high metabolism - can cause dryness -> inflammatory states
- Digestive Support
    - examples:
        - bitters, so Blue Vervain (NS)
        - artichoke leaf
        - orange peel
        - Gentian (hardball)
- Hormone Balancers
    - Vitex will give life to that luteal phase as long as the body has capacity for it
    - examples:
        - white peony
        - black cohosh - serotonin agonist - harmonizes and amplifies
            - for someone with classic body pain, rheumatic, arthritic$q$;

  v_sb_physical_changes := $q$## Physical Changes in the Perimenopause
- Changing Metabolism
    - as the estrogen starts to fluctuate, all the hormone effects slow down
    - lipid metabolism effects (gaining weight around the abdomen)
        - lifting weights helps here - stress on the muscles stimulates the metabolism
    - accumulation of waste starts to build up
        - buildup of waste in the vascular tissues - slow and increase pressure in the tissues
    - ("andropause" in men, but not as dramatic - decrease in testosterone)
    - brain starts to favor ketones over glucose for quick energy
        - should stop eating earlier in the day and still have a normal breakfast within 1 hour of waking (keeps cortisol stable)
        - continuing to eat sugars leads then to blood sugar dysregulation
- CNS Disruption
    - the body is starting to dry out (vata phase of life)
    - not metabolizing lipids as efficiently
        - influences myelin sheaths, the brain, etc
    - most of the primary symptoms are nervous system symptoms
- Hormonal Fluctuations
    - fluctuations are different for each person, but still a mess
    - herbal resources: adaptogens
    - nourish and moisten as much as possible
    - estradiol replaces the estrogen, but FSH and LH are still present
    - not considered safe to take Hormone Replacement Therapies (HRT) for more than 10 years
    - if the FSH stays at an elevated level through the cycle, that is the sign of menopause
    - all bodies have testosterone - that starts to take the estradiol jobs
- Core Concepts for Herbal Care
    - Nourish the tissues
        - more protein needs, but less red meats
        - seaweeds, other meats
    - Support the NS
        - lean into the topical oilination
    - Support Metabolism
        - bitters, carminatives, alteratives
        - targeted methylation - B Vitamins in a methylated form
        - not a big fan of fasting, can be hard on the body
        - elimination diets to find your irritating foods, at least a couple of weeks a couple of times a year
        - the Mediterranean diet - majority veggies, some proteins and fats
        - work to get out of fight or flight and into rest and digest
    - Eliminate Waste
        - make sure bowels move regularly, once or twice a day
        - urination
        - skin is nourished and sloughing
        - sweating
        - moving and circulation, lymph$q$;

  v_sb_case_study := $q$## Case Study
- Jean is 58 yrs old, 140 lbs, 5'5"
- Primary Health Concern: Post Menopause maintenance
- Nutrition: No dairy
- Hydration: 8-10 cups / day
- Exercise: Walking, Biking 3x week
- Other symptoms:
    - sleeps poorly due to restlessness
    - freq wakes
    - sugar cravings
    - nausea
    - gas or bloating after meals
    - varicose veins
    - low libido
    - wakes to pee
    - vaginal dryness
    - dry skin
    - hair thinning
    - brain fog
    - cold hands/feet, anxiety
- recent labs:
    - Vit D: 34 (optimal 75)
    - TSH: 4.4 (normal but high side)
    - Hemoglobin: 11.2 (anemia is under 12)
    - Hematocrit: 34.7 (likes to be 36)
    - RBC: 3.5
- Supplements currently taking:
    - Synthroid
    - Liothyronine due to radiated thyroid as a result of Graves diagnosis at age 30

## Thoughts:
- nausea and bloating before eats? bitters (artichoke support)
- oilination for dry skin
- rich, fatty broths
- electrolytes
- shatavari/ashwagandha/cinn tea

1. soups stews broths
2. shatavari/ashwagandha/turmeric/cinnamon golden milk
3. oilination with sesame oil

ashwagandha
not eat too late in the evening, to avoid waking up stressed
shatavari, ashwagandha, cinnamon, nutmeg -> golden milk
Chamomile, Linden, Fennel glycerite
electrolytes
nourishing tea - nettles, lemon balm, alfalfa
skullcap/catnip glycerite for sleep

waking up to pee is usually dehydration therefore electrolytes needed$q$;

  -- Herb snippets
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Seaweed section (morning, Tanya)
    (118,
     'Bladderwrack (Fucus spp.): traditionally used for thyroid support; supporting lymphatic movement; reducing inflammation; supplies trace minerals; tincture for hypothyroid conditions; pain oil. Highest in iodine. Studied to bind certain heavy metals and chelate them out of the body — useful for detox, but not a standalone solution.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Bladderwrack', 10, v_sb_bladderwrack),
    (2248,
     'Kombu (Laminaria spp.): supports digestion; add to beans to reduce gas; high in minerals; useful for CV health. Also high in iodine — very potent, small strip added to broth is usually enough.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Kombu', 20, v_sb_kombu),
    -- Herbal Actions for the Perimenopausal Period (afternoon, Lisa)
    (852,
     'Shatavari — this is a drying phase of life, and this brings more juiciness to the tissues; adaptogen for perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 30, v_sb_herbal_actions),
    (20,
     'Ashwagandha — if someone is stagnant or depressed, sluggish, grief or sadness; milk: 1/2 tsp ashwagandha powder with cinnamon and cardamom — at night for sleep with nutmeg, simmer with a little milk of choice.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 40, v_sb_herbal_actions),
    (167,
     'Cinnamon — used with Marshmallow to add warmth to the cooling Marshmallow; also in the ashwagandha sleep formula: 1/2 tsp ashwagandha powder with cinnamon and cardamom at night.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 50, v_sb_herbal_actions),
    (127,
     'Cardamom — in ashwagandha milk formula: 1/2 tsp ashwagandha powder with cinnamon and cardamom at night for sleep with nutmeg.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 60, v_sb_herbal_actions),
    (1595,
     'Nutmeg — added to the ashwagandha/cinnamon/cardamom milk formula for sleep.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 70, v_sb_herbal_actions),
    (14,
     'Ginsengs — adaptogens for perimenopause; cautious for people''s resources — give only to someone with good regular nourishment, not a replacement for that.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 80, v_sb_herbal_actions),
    (78,
     'Licorice — powerful and complicated; supports metabolism; can up and down-regulate cortisol; hepatoprotective, regulate blood sugar; rich in isoflavones. Listed as adaptogen, demulcent, and metabolic support herb for perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 90, v_sb_herbal_actions),
    (45,
     'Marshmallow — demulcent for perimenopause; used with cinnamon to add warmth to the cooling Marshmallow; supports mucous membranes and moistens dry tissues.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 100, v_sb_herbal_actions),
    (40,
     'Sarsaparilla — metabolic support herb for perimenopause; supports all elimination pathways.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 110, v_sb_herbal_actions),
    (122,
     'Dandelion root — metabolic support herb for perimenopause; supports elimination.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 120, v_sb_herbal_actions),
    (22,
     'Burdock — metabolic support herb for perimenopause; supports all elimination pathways working as optimally as possible.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 130, v_sb_herbal_actions),
    (33,
     'Oregon Grape (OGR) — if BS dysregulation, then Berberine: OGR, Barberry. Berberine-containing herb for blood sugar support in perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 140, v_sb_herbal_actions),
    (158,
     'Barberry — if BS dysregulation, then Berberine: OGR, Barberry. Berberine-containing herb for blood sugar support in perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 150, v_sb_herbal_actions),
    (13,
     'Tulsi (Holy Basil) — rosmarinic-rich; if hyperthyroid picture, then Rosmarinic-rich: Tulsi, Lemon Balm. Hyperthyroid: look underweight, high metabolism — can cause dryness -> inflammatory states.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 160, v_sb_herbal_actions),
    (134,
     'Lemon Balm — rosmarinic-rich; if hyperthyroid picture, then Rosmarinic-rich: Tulsi, Lemon Balm.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 170, v_sb_herbal_actions),
    (983,
     'Blue Vervain — digestive bitters for perimenopause; bitters, so Blue Vervain (NS) — listed with artichoke leaf, orange peel, gentian as digestive support.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 180, v_sb_herbal_actions),
    (172,
     'Artichoke leaf — digestive support for perimenopause; listed with blue vervain, orange peel, and gentian as digestive bitters.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 190, v_sb_herbal_actions),
    (748,
     'Orange peel — digestive support for perimenopause; listed with blue vervain, artichoke leaf, and gentian as digestive bitters.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 200, v_sb_herbal_actions),
    (102,
     'Gentian — digestive bitters (hardball) for perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 210, v_sb_herbal_actions),
    (190,
     'Vitex (Chasteberry) — hormone balancer; Vitex will give life to that luteal phase as long as the body has capacity for it.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 220, v_sb_herbal_actions),
    (2238,
     'White peony — hormone balancer for perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 230, v_sb_herbal_actions),
    (25,
     'Black cohosh — serotonin agonist; harmonizes and amplifies; for someone with classic body pain, rheumatic, arthritic. Hormone balancer for perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Herbal Actions for the Perimenopausal Period', 240, v_sb_herbal_actions),
    -- Case Study section
    (172,
     'Case study (post-menopause, Jean 58): nausea and bloating before meals — bitters (artichoke support).',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 250, v_sb_case_study),
    (203,
     'Case study: shatavari/ashwagandha/turmeric/cinnamon golden milk — recommendation for post-menopausal patient.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 260, v_sb_case_study),
    (84,
     'Case study: Chamomile, Linden, Fennel glycerite — for post-menopausal patient with poor sleep, restlessness, and gas/bloating.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 270, v_sb_case_study),
    (90,
     'Case study: Chamomile, Linden, Fennel glycerite — for post-menopausal patient with poor sleep and restlessness.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 280, v_sb_case_study),
    (76,
     'Case study: Chamomile, Linden, Fennel glycerite — for post-menopausal patient with gas and bloating after meals.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 290, v_sb_case_study),
    (142,
     'Case study: skullcap/catnip glycerite for sleep — for post-menopausal patient with poor sleep and restlessness.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 300, v_sb_case_study),
    (136,
     'Case study: skullcap/catnip glycerite for sleep — for post-menopausal patient.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 310, v_sb_case_study),
    (43,
     'Case study: nourishing tea — nettles, lemon balm, alfalfa — for post-menopausal patient with anemia (Hemoglobin 11.2) and mineral support needs.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 320, v_sb_case_study),
    (134,
     'Case study: nourishing tea — nettles, lemon balm, alfalfa — for post-menopausal patient.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 330, v_sb_case_study),
    (885,
     'Case study: nourishing tea — nettles, lemon balm, alfalfa — for post-menopausal patient.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 340, v_sb_case_study);

  -- Supplement snippets
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (49,
     'Targeted methylation — B Vitamins in a methylated form — recommended for metabolic support in perimenopause.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Physical Changes in the Perimenopause', 350, v_sb_physical_changes),
    (11,
     'Case study: Vit D: 34 (optimal 75) — patient has suboptimal Vitamin D; relevant to post-menopause and bone density.',
     'BHC - Class 25 - Seaweed and Menopause', 'personal', 'Case Study', 360, v_sb_case_study);

END $$;

-- Herb keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Bladderwrack (Kelp, id=118)
  (118, 'hypothyroidism',        'ailment'),
  (118, 'lymphatic support',     'ailment'),
  (118, 'inflammation',          'ailment'),
  (118, 'mineral support',       'ailment'),
  (118, 'heavy metal detox',     'ailment'),
  -- Kombu (Kelp Laminaria, id=2248)
  (2248, 'digestive health',     'ailment'),
  (2248, 'cardiovascular disease','ailment'),
  (2248, 'mineral support',      'ailment'),
  -- Shatavari (id=852)
  (852, 'perimenopause',         'ailment'),
  (852, 'post-menopause',        'ailment'),
  (852, 'hormonal support',      'ailment'),
  (852, 'vaginal dryness',       'ailment'),
  -- Ashwagandha (id=20)
  (20,  'perimenopause',         'ailment'),
  (20,  'post-menopause',        'ailment'),
  (20,  'depression',            'ailment'),
  (20,  'sleep support',         'ailment'),
  (20,  'stress',                'ailment'),
  -- Cinnamon (id=167)
  (167, 'perimenopause',         'ailment'),
  (167, 'blood sugar dysregulation', 'ailment'),
  -- Cardamom (id=127)
  (127, 'perimenopause',         'ailment'),
  (127, 'digestive health',      'ailment'),
  -- Nutmeg (id=1595)
  (1595,'sleep support',         'ailment'),
  (1595,'perimenopause',         'ailment'),
  -- Ginseng (id=14)
  (14,  'perimenopause',         'ailment'),
  (14,  'fatigue',               'ailment'),
  (14,  'energy support',        'ailment'),
  -- Licorice (id=78)
  (78,  'perimenopause',         'ailment'),
  (78,  'post-menopause',        'ailment'),
  (78,  'hormonal support',      'ailment'),
  (78,  'blood sugar dysregulation','ailment'),
  (78,  'liver support',         'ailment'),
  (78,  'metabolic syndrome',    'ailment'),
  (78,  'mucous membrane support','ailment'),
  -- Marshmallow (id=45)
  (45,  'perimenopause',         'ailment'),
  (45,  'mucous membrane support','ailment'),
  (45,  'vaginal dryness',       'ailment'),
  -- Sarsaparilla (id=40)
  (40,  'perimenopause',         'ailment'),
  (40,  'metabolic syndrome',    'ailment'),
  -- Dandelion root (id=122)
  (122, 'perimenopause',         'ailment'),
  (122, 'metabolic syndrome',    'ailment'),
  (122, 'liver support',         'ailment'),
  -- Burdock (id=22)
  (22,  'perimenopause',         'ailment'),
  (22,  'blood cleansing',       'ailment'),
  (22,  'metabolic syndrome',    'ailment'),
  -- Oregon Grape (id=33)
  (33,  'perimenopause',         'ailment'),
  (33,  'blood sugar dysregulation','ailment'),
  -- Barberry (id=158)
  (158, 'perimenopause',         'ailment'),
  (158, 'blood sugar dysregulation','ailment'),
  -- Holy Basil / Tulsi (id=13)
  (13,  'perimenopause',         'ailment'),
  (13,  'hyperthyroidism',       'ailment'),
  -- Lemon Balm (id=134)
  (134, 'perimenopause',         'ailment'),
  (134, 'post-menopause',        'ailment'),
  (134, 'hyperthyroidism',       'ailment'),
  (134, 'sleep support',         'ailment'),
  -- Blue Vervain (id=983)
  (983, 'perimenopause',         'ailment'),
  (983, 'digestive health',      'ailment'),
  -- Artichoke (id=172)
  (172, 'perimenopause',         'ailment'),
  (172, 'post-menopause',        'ailment'),
  (172, 'digestive health',      'ailment'),
  -- Sweet Orange (id=748)
  (748, 'perimenopause',         'ailment'),
  (748, 'digestive health',      'ailment'),
  -- Gentian (id=102)
  (102, 'perimenopause',         'ailment'),
  (102, 'digestive health',      'ailment'),
  -- Chasteberry / Vitex (id=190)
  (190, 'perimenopause',         'ailment'),
  (190, 'hormonal support',      'ailment'),
  (190, 'PMS',                   'ailment'),
  (190, 'menstrual irregularity','ailment'),
  -- White Peony (id=2238)
  (2238,'perimenopause',         'ailment'),
  (2238,'hormonal support',      'ailment'),
  -- Black Cohosh (id=25)
  (25,  'perimenopause',         'ailment'),
  (25,  'post-menopause',        'ailment'),
  (25,  'arthritis',             'ailment'),
  (25,  'hormonal support',      'ailment'),
  -- Turmeric (id=203)
  (203, 'post-menopause',        'ailment'),
  (203, 'inflammation',          'ailment'),
  -- Chamomile (id=84)
  (84,  'post-menopause',        'ailment'),
  (84,  'sleep support',         'ailment'),
  (84,  'digestive health',      'ailment'),
  -- Linden (id=90)
  (90,  'post-menopause',        'ailment'),
  (90,  'sleep support',         'ailment'),
  (90,  'anxiety',               'ailment'),
  -- Fennel (id=76)
  (76,  'perimenopause',         'ailment'),
  (76,  'post-menopause',        'ailment'),
  (76,  'digestive health',      'ailment'),
  -- Skullcap (id=142)
  (142, 'post-menopause',        'ailment'),
  (142, 'sleep support',         'ailment'),
  (142, 'anxiety',               'ailment'),
  -- Catnip (id=136)
  (136, 'post-menopause',        'ailment'),
  (136, 'sleep support',         'ailment'),
  -- Nettle leaf (id=43)
  (43,  'post-menopause',        'ailment'),
  (43,  'mineral support',       'ailment'),
  (43,  'anemia',                'ailment'),
  -- Alfalfa (id=885)
  (885, 'post-menopause',        'ailment'),
  (885, 'mineral support',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (49, 'perimenopause',      'ailment'),
  (49, 'metabolic syndrome', 'ailment'),
  (11, 'post-menopause',     'ailment'),
  (11, 'bone density',       'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Ailment search synonyms — only for keywords new to this class
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('heavy metal detox',
   ARRAY['chelation', 'heavy metal poisoning', 'toxic metal exposure', 'mercury detox', 'lead detox', 'metal chelation']),
  ('vaginal dryness',
   ARRAY['vaginal atrophy', 'vulvovaginal dryness', 'vaginal discomfort', 'dyspareunia', 'menopausal dryness', 'vulvar dryness'])
ON CONFLICT (ailment_keyword) DO NOTHING;
