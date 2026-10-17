-- Migration 379: Class 22 snippets, keywords, and ailment search terms
-- Class: BHC - Class 22 - Seaview Trail Herb Walk and Repro 2
-- File parsed: BHC - Class 22 - Seaview Trail Herb Walk and Repro 2 - Christine Lisa.md (personal notes only; no generated notes file)
--
-- Normalisations applied:
--   Vitex agnus-castus → Chasteberry (id=190)
--   Pueraria montana   → Kudzu Root (id=1547)
--   Paeonia lactiflora → White Peony (id=2238, root)
--   Panax ginseng      → Ginseng (id=14)
--   Viburnum opulus    → Cramp Bark (id=93); V. prunifolium → Black Haw (id=94)
--   Urtica dioica      → Nettle (id=43, leaf) — context: elevated testosterone / anemia
--   Serenoa repens     → Saw Palmetto (id=186)
--   Salvia officinalis → Sage (id=56)
--   Glycyrrhiza glabra → Licorice (id=78)
--   Medicago sativa    → Alfalfa (id=885)
--   Trifolium pratense → Red Clover (id=42)
--   Angelica sinensis  → Dong Quai (id=1009)
--   Milky oats         → Oat (id=178, milky oats)
--   Rose hips          → Rose (id=849, hips)
--   Stachys / California Hedge Nettle → Wood Betony (id=207)
--   Acorus calamus     → Calamus (id=2752, added migration 378)
--
-- Skipped:
--   Cheeseweed (not in DB; clinical content absorbed into Marshmallow snippet)
--   Italian thistle (not in DB; harvest-logistics note, no clinical use)
--   Monkey flower/Mimulus (Flower Essence — skip per playbook)
--   Cow Parsnip (food use only, not medicinal)
--   Poison hemlock (not medicinal — identification warning only)
--   Sesame oil (topical/food; no DB entry)
--   Vague category mentions: "Adaptogens" (category, not a specific herb)
--
-- Keyword merge decisions:
--   "elevated testosterone" → existing 'hyperandrogenism'
--   "prolactin suppression" → existing 'hyperprolactinemia'
--   "uterine tonification" → existing 'uterine tonic'
--   "nausea in pregnancy" → existing 'morning sickness'
--   "gestational hypertension" → NEW keyword (distinct from general 'hypertension')

SET search_path TO herbal, public;

DO $$
DECLARE
  v_class TEXT := 'BHC - Class 22 - Seaview Trail Herb Walk and Repro 2';

  v_walk TEXT :=
'- elderflower (poke berry can look like elderberry) - diaphoretic
  - berry - preventative
  - bark - emetic for poisoning
  - leaf - peanut smell
- Cheeseweed - in mallow family
  - good substitute for marshmallow (demulcent, edible, leaves not root)
- Italian thistle - time consuming to harvest milk thistle seeds, so can use this instead
- Yellow dock
  - bitter, alterative; primary for constipation
  - yellow, indicates bile; stagnation tends toward constipation
  - gentler than senna; use when adjusting to better digestion
  - iron rich — syrup with black strap molasses (extract in water first); use root, not AP
- Usnea - white thread, if pulled (Spanish moss, just breaks)
  - antimicrobial; most often urinary
  - (Oregon Grape root, digestive system affinity)
  - strong antimicrobial for pregnancy and children
- Figwort - Scrofula nodosa - bigger leaves, smelly
  - strong lymphatic; "King''s fever"; lymph nodes "nodosa" species
  - immune system stagnation, dehydration, sitting a lot
  - (Cleavers - affinity to neck/throat - also neck affinity)
  - Red Root more midsection affinity
  - Echinacea also lymphatic - deep cleansing, draining, very strong, deep seated
- Mustard - yellow - bath, sweat
- Plantain - drawing agent
  - demulcent and astringent; leaky gut, allows gaps to close
  - plantain + calendula + marshmallow root — great for healing ulcers
- Blackberry - astringent
- Stachys (Wood Betony / California Hedge Nettle)
  - grounding vata; calming, soothing; work with leaves
- Catnip - nervous, soothing
- Wood Betony + Calamus - Monks Tea Blend Tincture - if going out for a walk, etc
- Wild Lettuce - spine of spikes on back of leaf
  - sedative, sleep aid; bitter; cooling
  - one of the stronger herbal pain relievers
    - with Jamaican Dogwood, Corydalis = a TCM triplet -> targets skeletal muscle, injuries
    - Wild Yam -> better smooth muscle relaxant
  - harvest when plant shoots stalk, before flowering
  - high alcohol for preserving; very cold, not for already exhausted people';

  v_foundations TEXT :=
'### Foundations of Health
- Hydration
  - body needs to be wet, be able to make mucus
  - electrolytes create electrical charge allowing entry into cells
- Nutrient Dense diet
  - vegetable fiber, protein and healthy fats
  - building block for repro hormones is cholesterol, made from fats
  - vegetable fiber - 8-10 portions is the ideal
- Supplements
  - Beta carotene — if not gotten through food, for cellular immunity
  - Adequate EFAs — membrane integrity, mucus-rich membranes; Omega 3-6-9; 4-6 Tbl / 4-6000 mg a day
  - Healthy sugars (not in excess) — maple sugar, date sugar, not processed
  - Ayurvedic timeline: 35 days min, 3-6 months; order: Lymph, Blood, Muscle, Skin, Bone, Nerves, Reproductive
- Gut/Vaginal microbiome health: Probiotics!
  - comes from nutrient dense diet, healthy sugars and good hydration
  - 6 months supplementation; not a lifetime commitment
- Pelvic Circulation
  - Sitz baths: 15 mins hot, 5 mins cold; water just below belly button
  - Dry Brushing: strokes toward the heart; 60 strokes max in one location; 2-3x/week in crisis
  - Salt scrubs: jar of salt + oil (coconut=cooling, olive=all constitutions, sesame=warming)

**Fertili-Tea:**
astragalus
licorice
alfalfa
red clover';

  v_barriers TEXT :=
'### Hidden barriers to Fertility
- lubricants hostile to sperm (K-Y Jelly) — need balanced pH 7.2-7.8 and isotonic
- too little or too much exercise
  - too little → lymph stagnation
  - too much → can suppress parasympathetic NS state; caloric deficiencies
- gum inflammation — any inflammation causes oxidative stress, "not a good time" signal
- smoking — adverse effect on ovarian function; cannabis more effect on sperm
- too much red meat — oxidative waste
- trans fats — even 1 serving/day impacts fertility; implicated in uterine and sperm motility issues
- gluten intolerance — chronic gut inflammation
- blood sugar imbalance / high glycemic diet
  - influences sperm quality, male fertility, metabolic disruption in ovaries
- dehydration
- nutrient deficiencies
  - spec Vit C and antioxidants in general
  - Vit D
  - Zinc
  - Selenium
  - Iron
- stress
- NSAIDS — can interfere with ovulation';

  v_materia TEXT :=
'### Materia Medica
- Angelica sinensis (Dong quai) — circ to the repro organs, follicular cycle
- Panax ginseng — qi tonic, supportive to adrenals, cortisol
- Viburnum opulus - Cramp bark (or V. Prunifolium - Black haw)
  - smooth muscle relaxant - painful menstrual cycle, also to tonify the uterus
- Urtica urens, U. dioica - Nettles
  - can help to reduce elevated testosterone (PCOS picture)
  - tea, high in iron, vit and min
- Serenoa repens - Saw palmetto — elevated testosterone
- Vitex agnus-castus
  - nourishing progesterone levels, the pituitary; dopamine agonist
- Salvia officinalis — can help suppress prolactin levels (PCOS)
- Peonia lactiflora
  - pair with licorice to support repro disruption (3:1 peony:licorice)';

  v_legume TEXT :=
'### Legume Tea to Support Fertility
- suggest both partners drink it
- Trifolium pratense (Red clover)
- Pueraria montana (kudzu) — supports vascular and endocrine systems
- Astragalus membranaceus
  - anti-inflammatory, immune modulating
  - can enhance sperm motility
  - hormone modulating
- Glycyrrhiza glabra (licorice)
  - medicinal effects on every single body system
  - steroidal compounds; regulate adrenal function and cortisol levels
  - inositol and saponins — can improve fat metabolism
  - antispasmodic to the uterus; can restore menses
- Medicago sativa (alfalfa)
  - nutritive; high in phytosteroids

EP, 3 or more x / day';

  v_pregnancy TEXT :=
'### Herbs for Pregnancy
- Lisa doesn''t use a lot of herbs for pregnancy
- first trimester particularly delicate — nourish, nourish, nourish
- Red Raspberry — tonifying, but also very drying; avoid in the first 3 months
  - after first 3 months, very nourishing and can prepare uterus for birth process';

  v_nausea TEXT :=
'### Nausea and Vomiting
- get up and eat something immediately; sometimes food sensitivities arise
- Ginger — tea or candies
- Peppermint — together with Chamomile - good combo';

  v_stomach TEXT :=
'### Stomach Cramps
- start with Chamomile
- Peppermint if there is pain, tea form
- if very severe, then Wild Yam — antispasmodic to the smooth muscles
- sometimes stomach cramps can translate into uterine cramps which could threaten miscarriage';

  v_digestive TEXT :=
'### Digestive Support
- start with Marshmallow root
- then move to Dandelion root if not working
- then Yellow Dock if that not working
- if get queasy and difficulty digesting proteins and fats';

  v_heartburn TEXT :=
'### Heartburn
- Marshmallow root — stomach acids coming up';

  v_anemia TEXT :=
'### Anemia
- Alfalfa
- Nettle
- Yellow Dock -> Molasses Yellow Dock Syrup
  - the body also needs Vit C to metabolize iron
  - dried fruits, rose hips, Vit C
- Red Raspberry
- herbal vinegars';

  v_immune TEXT :=
'### Immune Support
- Echinacea
  - can be used preventatively
  - stimulates the innate immune response
- Usnea
  - supportive for urinary tract infections';

  v_bp TEXT :=
'### Reduce Blood Pressure
- Hawthorn
- Reishi — more in soup form
- Cramp Bark — long folk use for gestational hypertension
- Black Haw — long folk use for gestational hypertension
- Garlic — lean into the pestos';

  v_insomnia TEXT :=
'### Insomnia
- California Poppy
- Passionflower
- Milky Oats — doesn''t work as a tea, only alcohol soluble
- Lemon Balm
- Chamomile
- glycerine extracts both alcohol and water soluble properties, makes a more complex medicine';

  v_miscarriage TEXT :=
'### Threatened Miscarriage
- shot of whisky to relax the body
- Cramp Bark — used interchangeably with Black Haw
- Wild Yam — more effective
- formula 2:1 - 1/2 tsp every 30 mins for up to 4 hours || up to twice a day, for up to 3 days';

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 22 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ============================================================
  -- MORNING: Herb Walk (Christine Magee)
  -- ============================================================
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  (57,   -- Elder (flower)
   'Elderflower — diaphoretic. Bark emetic for poisoning. Leaf has peanut smell. Note: poke berry can look like elderberry.',
   v_class, 'personal', 'Herb Walk', 10, v_walk),

  (1651, -- Elder (berry)
   'Elder berry — preventative (poke berry can look like elderberry — identification caution).',
   v_class, 'personal', 'Herb Walk', 20, v_walk),

  (45,   -- Marshmallow
   'Cheeseweed (mallow family) is a good substitute for marshmallow — demulcent, edible, leaves not root. Good demulcent, available locally.',
   v_class, 'personal', 'Herb Walk', 30, v_walk),

  (37,   -- Yellow Dock
   'Yellow dock — bitter, alterative. Primary for constipation; gentler than senna. Yellow color indicates bile; stagnation tends toward constipation. Iron rich — syrup with black strap molasses (extract in water first). Use root, not aerial parts.',
   v_class, 'personal', 'Herb Walk', 40, v_walk),

  (112,  -- Usnea
   'Usnea — identified by white thread inside when pulled (Spanish moss just breaks). Antimicrobial, most often urinary affinity. Strong antimicrobial safe for use in pregnancy and children. Contrast: Oregon Grape root has digestive system affinity.',
   v_class, 'personal', 'Herb Walk', 50, v_walk),

  (33,   -- Oregon Grape
   'Oregon Grape root — digestive system affinity (contrasted with Usnea''s urinary affinity at the herb walk).',
   v_class, 'personal', 'Herb Walk', 60, v_walk),

  (39,   -- Figwort
   'Figwort (Scrophularia nodosa) — strong lymphatic. "King''s fever." Species name "nodosa" refers to lymph nodes. Indicated for immune system stagnation, dehydration, and sedentary lifestyle. Compare: Cleavers for neck/throat affinity, Red Root for midsection affinity.',
   v_class, 'personal', 'Herb Walk', 70, v_walk),

  (28,   -- Cleavers
   'Cleavers — affinity to neck and throat lymph nodes. Mentioned alongside Figwort and Red Root for organ-specific lymphatic affinities.',
   v_class, 'personal', 'Herb Walk', 80, v_walk),

  (981,  -- Red Root
   'Red Root — midsection lymphatic affinity. Mentioned alongside Figwort (general lymphatic) and Cleavers (neck/throat) for organ-specific affinities.',
   v_class, 'personal', 'Herb Walk', 90, v_walk),

  (26,   -- Echinacea
   'Echinacea — also lymphatic. Deep cleansing and draining, very strong, deep-seated action. Mentioned alongside Figwort in lymphatic stagnation context.',
   v_class, 'personal', 'Herb Walk', 100, v_walk),

  (116,  -- Mustard
   'Mustard — used as bath to promote sweating (diaphoretic).',
   v_class, 'personal', 'Herb Walk', 110, v_walk),

  (85,   -- Plantain
   'Plantain — drawing agent. Demulcent and astringent. Leaky gut: allows the gaps to close. Formula: plantain + calendula + marshmallow root (+ applesauce) — great for healing ulcers.',
   v_class, 'personal', 'Herb Walk', 120, v_walk),

  (70,   -- Calendula
   'Calendula — used in ulcer-healing formula: plantain + calendula + marshmallow root. Great for healing ulcers.',
   v_class, 'personal', 'Herb Walk', 130, v_walk),

  (45,   -- Marshmallow (second snippet — ulcer formula)
   'Marshmallow root — in ulcer-healing formula with plantain and calendula. Demulcent; root form specifically (not leaf).',
   v_class, 'personal', 'Herb Walk', 140, v_walk),

  (156,  -- Blackberry
   'Blackberry — astringent.',
   v_class, 'personal', 'Herb Walk', 150, v_walk),

  (207,  -- Wood Betony
   'Wood Betony (Stachys / California Hedge Nettle) — grounding vata, calming, soothing. Work with leaves.',
   v_class, 'personal', 'Herb Walk', 160, v_walk),

  (136,  -- Catnip
   'Catnip — nervous system, soothing.',
   v_class, 'personal', 'Herb Walk', 170, v_walk),

  (2752, -- Calamus
   'Calamus — used with Wood Betony in Monks Tea Blend Tincture. Taken when going out for a walk, etc.',
   v_class, 'personal', 'Herb Walk', 180, v_walk),

  (130,  -- Wild Lettuce
   'Wild Lettuce — identified by spine of spikes on back of leaf. Sedative, sleep aid. Bitter, cooling — very cold; not for already exhausted people. One of the stronger herbal pain relievers. With Jamaican Dogwood and Corydalis = TCM triplet targeting skeletal muscle and injuries. Harvest when plant shoots stalk, before flowering. High alcohol needed for preservation.',
   v_class, 'personal', 'Herb Walk', 190, v_walk),

  (74,   -- Wild Yam (morning — smooth muscle contrast)
   'Wild Yam — better smooth muscle relaxant (contrasted with Wild Lettuce / Jamaican Dogwood / Corydalis triplet which targets skeletal muscle).',
   v_class, 'personal', 'Herb Walk', 200, v_walk),

  (2228, -- Corydalis
   'Corydalis — part of a TCM triplet (with Wild Lettuce and Jamaican Dogwood) targeting skeletal muscle injuries.',
   v_class, 'personal', 'Herb Walk', 210, v_walk),

  (2461, -- Jamaican Dogwood
   'Jamaican Dogwood — part of a TCM triplet (with Wild Lettuce and Corydalis) targeting skeletal muscle injuries.',
   v_class, 'personal', 'Herb Walk', 220, v_walk),

  -- ============================================================
  -- AFTERNOON: Foundations of Health (incl. Fertili-Tea)
  -- ============================================================

  (225,  -- Astragalus (Fertili-Tea)
   'Astragalus — listed in Fertili-Tea (with licorice, alfalfa, red clover) for fertility support. Suggest both partners drink it.',
   v_class, 'personal', 'Foundations of Health', 230, v_foundations),

  (78,   -- Licorice (Fertili-Tea)
   'Licorice — listed in Fertili-Tea (with astragalus, alfalfa, red clover) for fertility support.',
   v_class, 'personal', 'Foundations of Health', 240, v_foundations),

  (885,  -- Alfalfa (Fertili-Tea)
   'Alfalfa — listed in Fertili-Tea (with astragalus, licorice, red clover) for fertility support.',
   v_class, 'personal', 'Foundations of Health', 250, v_foundations),

  (42,   -- Red Clover (Fertili-Tea)
   'Red Clover — listed in Fertili-Tea (with astragalus, licorice, alfalfa) for fertility support.',
   v_class, 'personal', 'Foundations of Health', 260, v_foundations);

  -- Supplement snippets — Foundations of Health (Beta-Carotene)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (41,  -- Beta-Carotene
   'Beta carotene — recommended if not obtained through food; for cellular immunity. Sources: orange foods (squash, carrots, cantaloupe), leafy greens, broccoli. Note: not Vitamin A (which can lead quickly to toxicity).',
   v_class, 'personal', 'Foundations of Health', 270, v_foundations);

  -- Supplement snippets — Hidden Barriers to Fertility
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (11,  -- Vitamin D
   'Vitamin D — nutrient deficiency specifically listed as a hidden barrier to fertility.',
   v_class, 'personal', 'Hidden Barriers to Fertility', 280, v_barriers),

  (24,  -- Zinc
   'Zinc — nutrient deficiency specifically listed as a hidden barrier to fertility.',
   v_class, 'personal', 'Hidden Barriers to Fertility', 290, v_barriers),

  (23,  -- Selenium
   'Selenium — nutrient deficiency specifically listed as a hidden barrier to fertility.',
   v_class, 'personal', 'Hidden Barriers to Fertility', 300, v_barriers),

  (19,  -- Iron
   'Iron — nutrient deficiency specifically listed as a hidden barrier to fertility.',
   v_class, 'personal', 'Hidden Barriers to Fertility', 310, v_barriers),

  (10,  -- Vitamin C
   'Vitamin C (antioxidants in general) — nutrient deficiency listed as barrier to fertility; specific Vit C mention.',
   v_class, 'personal', 'Hidden Barriers to Fertility', 320, v_barriers);

  -- ============================================================
  -- AFTERNOON: Materia Medica
  -- ============================================================
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  (1009, -- Dong Quai
   'Dong Quai (Angelica sinensis) — circulation to the reproductive organs, supports the follicular cycle.',
   v_class, 'personal', 'Materia Medica', 330, v_materia),

  (14,   -- Ginseng (Panax)
   'Panax ginseng — qi tonic, supportive to adrenals and cortisol. Fertility materia medica.',
   v_class, 'personal', 'Materia Medica', 340, v_materia),

  (93,   -- Cramp Bark
   'Cramp Bark (Viburnum opulus) — smooth muscle relaxant for painful menstrual cycle; also used to tonify the uterus. Used interchangeably with Black Haw (V. prunifolium).',
   v_class, 'personal', 'Materia Medica', 350, v_materia),

  (94,   -- Black Haw
   'Black Haw (Viburnum prunifolium) — smooth muscle relaxant for painful menstrual cycle; used interchangeably with Cramp Bark.',
   v_class, 'personal', 'Materia Medica', 360, v_materia),

  (43,   -- Nettle (leaf)
   'Nettle — can help reduce elevated testosterone (PCOS picture). Tea form; high in iron, vitamins, and minerals.',
   v_class, 'personal', 'Materia Medica', 370, v_materia),

  (186,  -- Saw Palmetto
   'Saw Palmetto (Serenoa repens) — indicated for elevated testosterone.',
   v_class, 'personal', 'Materia Medica', 380, v_materia),

  (190,  -- Chasteberry
   'Chasteberry (Vitex agnus-castus) — nourishes progesterone levels and supports the pituitary. Dopamine agonist.',
   v_class, 'personal', 'Materia Medica', 390, v_materia),

  (56,   -- Sage
   'Sage (Salvia officinalis) — can help suppress prolactin levels (PCOS picture).',
   v_class, 'personal', 'Materia Medica', 400, v_materia),

  (2238, -- White Peony
   'Paeonia lactiflora (White Peony) — pair with licorice to support reproductive disruption. Ratio: 3:1 peony to licorice.',
   v_class, 'personal', 'Materia Medica', 410, v_materia),

  -- ============================================================
  -- AFTERNOON: Legume Tea for Fertility
  -- ============================================================

  (42,   -- Red Clover (Legume Tea)
   'Red Clover (Trifolium pratense) — in Legume Tea to Support Fertility. Suggest both partners drink it.',
   v_class, 'personal', 'Legume Tea for Fertility', 420, v_legume),

  (1547, -- Kudzu Root
   'Kudzu (Pueraria montana) — in Legume Tea for Fertility. Supports vascular and endocrine systems.',
   v_class, 'personal', 'Legume Tea for Fertility', 430, v_legume),

  (225,  -- Astragalus (Legume Tea — detailed)
   'Astragalus membranaceus — in Legume Tea for Fertility. Anti-inflammatory, immune modulating. Can enhance sperm motility. Hormone modulating.',
   v_class, 'personal', 'Legume Tea for Fertility', 440, v_legume),

  (78,   -- Licorice (Legume Tea — detailed)
   'Licorice (Glycyrrhiza glabra) — in Legume Tea for Fertility. Medicinal effects on every body system. Steroidal compounds; regulates adrenal function and cortisol levels. Inositol and saponins improve fat metabolism. Antispasmodic to the uterus. Can restore menses.',
   v_class, 'personal', 'Legume Tea for Fertility', 450, v_legume),

  (885,  -- Alfalfa (Legume Tea — detailed)
   'Alfalfa (Medicago sativa) — in Legume Tea for Fertility. Nutritive; high in phytosteroids.',
   v_class, 'personal', 'Legume Tea for Fertility', 460, v_legume),

  -- ============================================================
  -- AFTERNOON: Herbs for Pregnancy
  -- ============================================================

  (155,  -- Raspberry (leaf)
   'Red Raspberry leaf — tonifying to the uterus, but very drying. Avoid in first trimester (first 3 months). After first trimester: very nourishing and can prepare uterus for the birth process.',
   v_class, 'personal', 'Herbs for Pregnancy', 470, v_pregnancy),

  -- ============================================================
  -- AFTERNOON: Nausea and Vomiting
  -- ============================================================

  (124,  -- Ginger
   'Ginger — for nausea and vomiting in pregnancy. Tea or candies.',
   v_class, 'personal', 'Nausea and Vomiting', 480, v_nausea),

  (55,   -- Peppermint (nausea)
   'Peppermint — for nausea in pregnancy; good combo together with Chamomile.',
   v_class, 'personal', 'Nausea and Vomiting', 490, v_nausea),

  (84,   -- Chamomile (nausea)
   'Chamomile — paired with Peppermint as a good combo for nausea and vomiting in pregnancy.',
   v_class, 'personal', 'Nausea and Vomiting', 500, v_nausea),

  -- ============================================================
  -- AFTERNOON: Stomach Cramps
  -- ============================================================

  (84,   -- Chamomile (stomach cramps)
   'Chamomile — first herb to use for stomach cramps in pregnancy.',
   v_class, 'personal', 'Stomach Cramps', 510, v_stomach),

  (55,   -- Peppermint (stomach cramps)
   'Peppermint — for pain with stomach cramps in pregnancy. Tea form. Use if Chamomile is insufficient.',
   v_class, 'personal', 'Stomach Cramps', 520, v_stomach),

  (74,   -- Wild Yam (stomach cramps)
   'Wild Yam — for very severe stomach cramps in pregnancy. Antispasmodic to smooth muscles. Note: stomach cramps can translate into uterine cramps which could threaten miscarriage.',
   v_class, 'personal', 'Stomach Cramps', 530, v_stomach),

  -- ============================================================
  -- AFTERNOON: Digestive Support
  -- ============================================================

  (45,   -- Marshmallow (digestive)
   'Marshmallow root — first herb for digestive support in pregnancy (queasy, difficulty digesting proteins and fats). Start here.',
   v_class, 'personal', 'Digestive Support', 540, v_digestive),

  (122,  -- Dandelion root
   'Dandelion root — second step for digestive support in pregnancy if Marshmallow root is not working.',
   v_class, 'personal', 'Digestive Support', 550, v_digestive),

  (37,   -- Yellow Dock (digestive)
   'Yellow Dock — third step for digestive support in pregnancy if Dandelion root is not working.',
   v_class, 'personal', 'Digestive Support', 560, v_digestive),

  -- ============================================================
  -- AFTERNOON: Heartburn
  -- ============================================================

  (45,   -- Marshmallow (heartburn)
   'Marshmallow root — for heartburn in pregnancy. Soothes stomach acids coming up.',
   v_class, 'personal', 'Heartburn', 570, v_heartburn),

  -- ============================================================
  -- AFTERNOON: Anemia
  -- ============================================================

  (885,  -- Alfalfa (anemia)
   'Alfalfa — indicated for anemia in pregnancy.',
   v_class, 'personal', 'Anemia', 580, v_anemia),

  (43,   -- Nettle (anemia)
   'Nettle — indicated for anemia in pregnancy.',
   v_class, 'personal', 'Anemia', 590, v_anemia),

  (37,   -- Yellow Dock (anemia)
   'Yellow Dock — Molasses Yellow Dock Syrup for anemia. Note: body also needs Vitamin C to metabolize iron; pair with dried fruits, rose hips, or Vitamin C.',
   v_class, 'personal', 'Anemia', 600, v_anemia),

  (155,  -- Raspberry (anemia)
   'Red Raspberry — indicated for anemia in pregnancy.',
   v_class, 'personal', 'Anemia', 610, v_anemia),

  (849,  -- Rose (hips)
   'Rose hips — source of Vitamin C to support iron metabolism; mentioned alongside dried fruits in the anemia section.',
   v_class, 'personal', 'Anemia', 620, v_anemia);

  -- Supplement snippet — Vitamin C for iron absorption (Anemia)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (10,  -- Vitamin C
   'Vitamin C — needed to metabolize iron. Pair with Yellow Dock syrup, dried fruits, or rose hips when treating anemia.',
   v_class, 'personal', 'Anemia', 625, v_anemia);

  -- ============================================================
  -- AFTERNOON: Immune Support
  -- ============================================================
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  (26,   -- Echinacea (immune support in pregnancy)
   'Echinacea — can be used preventatively in pregnancy. Stimulates the innate immune response.',
   v_class, 'personal', 'Immune Support', 630, v_immune),

  (112,  -- Usnea (UTI in pregnancy)
   'Usnea — supportive for urinary tract infections in pregnancy.',
   v_class, 'personal', 'Immune Support', 640, v_immune),

  -- ============================================================
  -- AFTERNOON: Blood Pressure (gestational context)
  -- ============================================================

  (73,   -- Hawthorn (berry)
   'Hawthorn — indicated for reducing blood pressure in pregnancy / gestational hypertension.',
   v_class, 'personal', 'Blood Pressure', 650, v_bp),

  (11,   -- Reishi Mushroom
   'Reishi — indicated for blood pressure reduction in pregnancy. Best used in soup form.',
   v_class, 'personal', 'Blood Pressure', 660, v_bp),

  (93,   -- Cramp Bark (gestational hypertension)
   'Cramp Bark — long folk use for gestational hypertension.',
   v_class, 'personal', 'Blood Pressure', 670, v_bp),

  (94,   -- Black Haw (gestational hypertension)
   'Black Haw — long folk use for gestational hypertension.',
   v_class, 'personal', 'Blood Pressure', 680, v_bp),

  (21,   -- Garlic
   'Garlic — indicated for blood pressure reduction in pregnancy. Lean into pestos as a food-medicine approach.',
   v_class, 'personal', 'Blood Pressure', 690, v_bp),

  -- ============================================================
  -- AFTERNOON: Insomnia
  -- ============================================================

  (128,  -- California Poppy
   'California Poppy — indicated for insomnia in pregnancy.',
   v_class, 'personal', 'Insomnia', 700, v_insomnia),

  (137,  -- Passionflower
   'Passionflower — indicated for insomnia in pregnancy.',
   v_class, 'personal', 'Insomnia', 710, v_insomnia),

  (178,  -- Oat (milky oats)
   'Milky Oats — indicated for insomnia in pregnancy. Does not work as a tea — only alcohol soluble. Glycerine extracts both alcohol and water soluble properties, making a more complex medicine.',
   v_class, 'personal', 'Insomnia', 720, v_insomnia),

  (134,  -- Lemon Balm
   'Lemon Balm — indicated for insomnia in pregnancy.',
   v_class, 'personal', 'Insomnia', 730, v_insomnia),

  (84,   -- Chamomile (insomnia)
   'Chamomile — indicated for insomnia in pregnancy.',
   v_class, 'personal', 'Insomnia', 740, v_insomnia),

  -- ============================================================
  -- AFTERNOON: Threatened Miscarriage
  -- ============================================================

  (93,   -- Cramp Bark (threatened miscarriage)
   'Cramp Bark — for threatened miscarriage. Used interchangeably with Black Haw. Formula 2:1 — 1/2 tsp every 30 minutes for up to 4 hours; up to twice a day for up to 3 days.',
   v_class, 'personal', 'Threatened Miscarriage', 750, v_miscarriage),

  (74,   -- Wild Yam (threatened miscarriage)
   'Wild Yam — more effective than Cramp Bark for threatened miscarriage. Formula 2:1 — 1/2 tsp every 30 minutes for up to 4 hours; up to twice a day for up to 3 days.',
   v_class, 'personal', 'Threatened Miscarriage', 760, v_miscarriage);

  RAISE NOTICE 'Class 22 snippets inserted.';
END $$;

-- ============================================================
-- KEYWORDS
-- ============================================================

-- Herb Walk herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Elder
  (57,   'diaphoretic',       'action'),
  -- Yellow Dock
  (37,   'constipation',      'ailment'),
  (37,   'anemia',            'ailment'),
  (37,   'iron deficiency',   'ailment'),
  (37,   'digestive tonic',   'ailment'),
  (37,   'bitter',            'action'),
  (37,   'alterative',        'action'),
  -- Usnea
  (112,  'urinary tract infection', 'ailment'),
  (112,  'antimicrobial',     'action'),
  (112,  'pregnancy support', 'ailment'),
  -- Figwort
  (39,   'lymphatic support', 'ailment'),
  (39,   'immune support',    'ailment'),
  -- Cleavers
  (28,   'lymphatic support', 'ailment'),
  -- Red Root
  (981,  'lymphatic support', 'ailment'),
  -- Echinacea (morning)
  (26,   'lymphatic support', 'ailment'),
  -- Mustard
  (116,  'diaphoretic',       'action'),
  -- Plantain
  (85,   'leaky gut',         'ailment'),
  (85,   'wound healing',     'ailment'),
  (85,   'demulcent',         'action'),
  (85,   'astringent',        'action'),
  -- Calendula
  (70,   'wound healing',     'ailment'),
  (70,   'GI inflammation',   'ailment'),
  -- Marshmallow (multiple uses)
  (45,   'heartburn',         'ailment'),
  (45,   'leaky gut',         'ailment'),
  (45,   'wound healing',     'ailment'),
  (45,   'digestive tonic',   'ailment'),
  (45,   'demulcent',         'action'),
  -- Blackberry
  (156,  'diarrhea',          'ailment'),
  (156,  'astringent',        'action'),
  -- Wood Betony
  (207,  'stress',            'ailment'),
  (207,  'nervous system support', 'ailment'),
  -- Catnip
  (136,  'stress',            'ailment'),
  (136,  'nervous system support', 'ailment'),
  -- Wild Lettuce
  (130,  'sleep support',     'ailment'),
  (130,  'chronic pain',      'ailment'),
  (130,  'sedative',          'action'),
  -- Wild Yam
  (74,   'muscle spasms',     'ailment'),
  (74,   'dysmenorrhea',      'ailment'),
  (74,   'threatened miscarriage', 'ailment'),
  -- Corydalis
  (2228, 'chronic pain',      'ailment'),
  (2228, 'muscle spasms',     'ailment'),
  -- Jamaican Dogwood
  (2461, 'chronic pain',      'ailment'),
  (2461, 'muscle spasms',     'ailment'),
  -- Calamus
  (2752, 'nervous system support', 'ailment'),

  -- Materia Medica / Fertility herbs
  -- Dong Quai
  (1009, 'fertility support', 'ailment'),
  (1009, 'menstrual irregularity', 'ailment'),
  (1009, 'reproductive support', 'ailment'),
  -- Ginseng
  (14,   'fertility support', 'ailment'),
  (14,   'adrenal fatigue',   'ailment'),
  -- Cramp Bark
  (93,   'dysmenorrhea',      'ailment'),
  (93,   'muscle spasms',     'ailment'),
  (93,   'threatened miscarriage', 'ailment'),
  (93,   'gestational hypertension', 'ailment'),
  (93,   'uterine tonic',     'ailment'),
  -- Black Haw
  (94,   'dysmenorrhea',      'ailment'),
  (94,   'threatened miscarriage', 'ailment'),
  (94,   'gestational hypertension', 'ailment'),
  (94,   'uterine tonic',     'ailment'),
  -- Nettle (leaf)
  (43,   'hyperandrogenism',  'ailment'),
  (43,   'PCOS',              'ailment'),
  (43,   'anemia',            'ailment'),
  (43,   'iron deficiency',   'ailment'),
  -- Saw Palmetto
  (186,  'hyperandrogenism',  'ailment'),
  (186,  'PCOS',              'ailment'),
  -- Chasteberry
  (190,  'PCOS',              'ailment'),
  (190,  'hyperprolactinemia','ailment'),
  (190,  'hormonal support',  'ailment'),
  (190,  'pituitary support', 'ailment'),
  -- Sage
  (56,   'PCOS',              'ailment'),
  (56,   'hyperprolactinemia','ailment'),
  -- White Peony
  (2238, 'hormonal support',  'ailment'),
  (2238, 'reproductive support', 'ailment'),
  (2238, 'PCOS',              'ailment'),
  -- Kudzu Root
  (1547, 'fertility support', 'ailment'),
  (1547, 'cardiovascular disease', 'ailment'),
  -- Astragalus
  (225,  'fertility support', 'ailment'),
  (225,  'sperm motility',    'ailment'),
  (225,  'immune support',    'ailment'),
  -- Licorice
  (78,   'fertility support', 'ailment'),
  (78,   'hormonal support',  'ailment'),
  (78,   'adrenal fatigue',   'ailment'),
  (78,   'dysmenorrhea',      'ailment'),
  (78,   'menstrual irregularity', 'ailment'),
  -- Alfalfa
  (885,  'fertility support', 'ailment'),
  (885,  'anemia',            'ailment'),
  -- Red Clover
  (42,   'fertility support', 'ailment'),
  (42,   'hormonal support',  'ailment'),

  -- Pregnancy herbs
  -- Raspberry leaf
  (155,  'pregnancy support', 'ailment'),
  (155,  'uterine tonic',     'ailment'),
  (155,  'anemia',            'ailment'),
  -- Ginger
  (124,  'morning sickness',  'ailment'),
  -- Peppermint
  (55,   'morning sickness',  'ailment'),
  (55,   'muscle spasms',     'ailment'),
  -- Chamomile
  (84,   'morning sickness',  'ailment'),
  (84,   'muscle spasms',     'ailment'),
  (84,   'sleep support',     'ailment'),
  -- Dandelion root
  (122,  'digestive tonic',   'ailment'),
  (122,  'pregnancy support', 'ailment'),
  -- Hawthorn (berry)
  (73,   'gestational hypertension', 'ailment'),
  (73,   'hypertension',      'ailment'),
  -- Reishi
  (11,   'gestational hypertension', 'ailment'),
  (11,   'hypertension',      'ailment'),
  -- Garlic
  (21,   'gestational hypertension', 'ailment'),
  (21,   'hypertension',      'ailment'),
  -- California Poppy
  (128,  'sleep support',     'ailment'),
  (128,  'insomnia',          'symptom'),
  -- Passionflower
  (137,  'sleep support',     'ailment'),
  (137,  'insomnia',          'symptom'),
  -- Oat (milky oats)
  (178,  'sleep support',     'ailment'),
  (178,  'nervous system support', 'ailment'),
  -- Lemon Balm
  (134,  'sleep support',     'ailment'),
  (134,  'insomnia',          'symptom'),
  -- Rose (hips)
  (849,  'anemia',            'ailment'),
  (849,  'iron deficiency',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (41,  'fertility support',  'ailment'),
  (41,  'immune support',     'ailment'),
  (11,  'fertility support',  'ailment'),  -- Vitamin D
  (24,  'fertility support',  'ailment'),  -- Zinc
  (23,  'fertility support',  'ailment'),  -- Selenium
  (19,  'anemia',             'ailment'),  -- Iron
  (19,  'fertility support',  'ailment'),
  (10,  'anemia',             'ailment'),  -- Vitamin C
  (10,  'fertility support',  'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- NEW AILMENT KEYWORD: gestational hypertension
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('gestational hypertension',
   ARRAY['pregnancy-induced hypertension', 'PIH', 'pregnancy hypertension',
         'hypertension in pregnancy', 'preeclampsia', 'high blood pressure in pregnancy'])
ON CONFLICT (ailment_keyword) DO NOTHING;
