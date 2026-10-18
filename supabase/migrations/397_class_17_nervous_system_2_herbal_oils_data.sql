-- Migration 397: BHC Class 17 — Nervous System 2 and Herbal Oils
-- Class name: BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose
-- Personal notes only (no generated notes file for this class)
--
-- Herb normalizations:
--   Stachys               → Wood Betony (id=207, Stachys officinalis)
--   Eleuthero             → Siberian Ginseng (id=9, Eleutherococcus senticosus)
--   Bladderwrack          → Kelp (id=118, Fucus vesiculosus)
--   Mimosa Bark / Albizia → Silk Tree bark (id=2285); mimosa flowers → Silk Tree flowers (id=2746)
--   Boswellia             → Frankincense (id=1597)
--   Red Ginseng           → Ginseng/Panax Ginseng (id=14)
--   Evergreen oils (pine) → Pine Needles (id=2643)
--   Dandelion [flower]    → Dandelion root (id=122; DB has no flower part entry)
--   Anemone / Pulsatilla  → Pasqueflower (id=36)
--   SJW                   → St. John's Wort (id=81)
--
-- Keyword merge decisions:
--   GI-based depression         → 'depression' (subtype covered by section header)
--   Stagnant depression         → 'depression' + 'PTSD'
--   Thyroid induced depression  → 'depression' + 'hypothyroidism'
--   Menopausal insomnia         → 'perimenopause' + 'sleep support'
--   insomnia (as concept)       → 'sleep support'
--
-- New ailment keyword introduced: neuritis
--
-- Skipped entirely:
--   Ghost Pipe (Monotropa uniflora) — no DB entry
--   Tobacco                         — energetic/spiritual mention only, not medicinal

SET search_path TO herbal, public;

DO $$
DECLARE

  -- ─── Source blocks ─────────────────────────────────────────────────────────

  v_daily_tea_src CONSTANT TEXT :=
'**Daily Tea**
Marshmallow
Cinnamon';

  v_nervine_tonics_src CONSTANT TEXT :=
'### Nervine Tonics
- Skullcap
    - spasms, shakiness, acute anxiety
    - for some people, may make tired
    - best fresh, tincture or in tea
    - dried tincture not very effective
- Milky Oats
    - food for NS, emotional instability, drug withdrawal, frazzled nerves
    - Oat Straw used more in tea - high mineral support
- St. Johns Wort
    - nerve damage/nerve pain
    - will work with at Lakes Basin
    - blooms around Summer Solstice
    - topical applications common';

  v_nervine_relaxants_src CONSTANT TEXT :=
'### Nervine relaxants
- Skullcap
    - acute anxiety, anger, tremors, spasm, nervous ticks
    - too much caffeine
- Hawthorn (and Motherwort)
    - for the heart and chest anxiety/tightness
- Lavender
    - helps with depression and sleep
- Lemon Balm
    - gentle, yet powerful, enhances mood, potentiates other nervines
    - dry carefully, scent dissipates
- Linden
    - grief remedy, pair with lemon balm and mimosa flowers for depression
    - flowers smell like honey
    - astringent, can ground weepiness
- Blue Vervain
    - dispels illusion, use for fear of death with Night Blooming Cereus, combine with motherwort, PMS and menopausal anxiety with Milky Oats
    - if you are hyper-focused on something and can''t shut it off
    - really bitter
- Pulsatilla
    - drop dose plant for anxiety and acute wind
    - for shock trauma
- Kava
    - heart opening antispasmodic
    - good for fast paced city dwellers
    - smoothing out social anxiety
- Catnip
    - good for worry, great for children, good for stress induced GI symptoms combined with Chamomile
    - maybe little baby baths with strong tea for fevers
- Stachys
    - good for head pain and stress induced migraines';

  v_nervine_stimulants_src CONSTANT TEXT :=
'### Nervine Stimulants
- Coffee
- Rosemary
- Kola Nut
- Cacao
- Panax Ginseng
- Rhodiola';

  v_sedatives_src CONSTANT TEXT :=
'### Sedatives
- stress or pain, to fall asleep
- Hops
    - good for premenopausal insomnia
- Valerian
    - may wire some people
- Passionflower
    - good for sleep
- California Poppy
    - maybe during day, smooth out the edges
    - smaller doses for kids
- Wild Lettuce
    - great for pain management, sedative';

  v_adaptogens_src CONSTANT TEXT :=
'### Adaptogens
- helpful but don''t overuse to make you unhealthfully push you too far
- you can still experience burnout even when using adaptogens
- American Ginseng
    - maybe less stimulating than Panax
- Panax Ginseng
- Eleuthero
    - the "White Rabbit" - running around late
    - bend time, make more space in the day
- Ashwagandha
    - warming
- Rhodiola
    - very drying
    - making a tincture of this with a little glycerin is good to moisten
    - more stimulating
    - good for elevation sickness, camping trips
- Tulsi
- Schisandra
    - five-flavor berry
    - what flavor you taste is said to be what you need
    - help with energy and focus';

  v_gi_depression_src CONSTANT TEXT :=
'### GI-based depression
- most of the body''s serotonin is produced in the GI tract aka the "enteric brain"
- a healthy gut microbiome is essential for helping maintain a healthy emotional state
- GI dysbiosis has been linked to depression and anxiety: Dyspepsia, Chronic constipation or diarrhea, IBS, IBD, Leaky Gut Syndrome
- GI-based depression is moody and lethargic
- herbs specific for GI depression:
    - St Johns Wort
    - Saffron, Wormwood, Lemon Balm, Chamomile, Catnip';

  v_stagnant_depression_src CONSTANT TEXT :=
'### Stagnant Depression
- chronic situational depression where a trauma has become the focus of someone''s entire existence
- PTSD and chronic unrelenting grief
- herbs:
    - Mimosa Bark
    - Tulsi
        - fresh tincture is incredible, also dries well
    - Rose Petals
    - Lavender
    - Rosemary
        - for remembrance - the part that you lost
    - Damiana';

  v_thyroid_depression_src CONSTANT TEXT :=
'### Thyroid Induced Depression
- (bloodwork probably called for here to narrow down)
- often caused by hypothyroidism
- symptoms include: feeling cold, poor memory, dry skin, thinning hair, depression, weight gain
- supplement iodine, selenium, and L-tyrosine
- herbs:
    - ashwagandha
    - bacopa
    - bladderwrack
        - can dry and put in capsules, tastes not good
    - Damiana
    - Red Ginseng';

  v_sad_src CONSTANT TEXT :=
'### SAD
- caused by lack of sunlight, can be exacerbated by vit D deficiency
- supplementing 2000 iu/day
- get outside
- light boxes and full spectrum lighting in homes
- use light-bearing plants:
    - Calendula - follows the sun
    - Lemon Balm
    - SJW - summer solstice
- can also supplement SAMe (400-1200mg in the morning on an empty stomach)';

  v_herbs_depression_src CONSTANT TEXT :=
'### Herbs for Depression
- Rosemary - good for brain fog and memory from depression, eases headaches, circ tonic, warming and stimulating
- Lavender - GI based depression, with insomnia and headaches
- Tulsi - stagnant depression
- Mimosa Bark - depression with grief, heartbreak, bad dreams, anger, irritability
- Hawthorn - depression from heartbreak or grief
- Rose - depression from loss, scattered depression, lack of boundaries
- Black Cohosh - black cloud depression, hormonal depression
- St John''s Wort - sour stomach, sour attitude, dark outlook with a sense of emotional unease
- Lemon Balm - uplifting, light-bearing plant
- Boswellia - depression with other signs of systemic inflammation (esp if with GI inflammation)';

  v_spirit_remedies_src CONSTANT TEXT :=
'### Spirit Remedies for Depression
- Mullein FE: a guiding torch when someone is stuck in the "underworld"
- Albizia: the tree of joy, utilize in all forms
- Hawthorn: for courage and strength of the heart
- Borage FE - for courage
- Rose - resilience of the heart, self-love
- Linden - for processing and moving through grief, tree of joy and sorrow
- Bleeding Heart FE - depression due to loss
- Self Heal FE
- Herbs for Transformation: Ginger and Cayenne
- Reishi - inviting the light back in';

  v_anxiety_src CONSTANT TEXT :=
'## Anxiety
- often caused by high chronic cortisol levels (chronic anxiety)
- must deal with chronic stress (use adaptogens and change lifestyle)
- actions indicated: anxiolytic, adaptogen, relaxing nervine, hypotensive
- determine the source of your anxiety!
- herbs:
    - blue vervain
    - motherwort
    - anemone aka pulsatilla
    - skullcap
    - albizia
    - lemon balm
    - passionflower
    - california poppy
    - wild lettuce
    - hops
    - ashwagandha
    - damiana
    - borage
    - linden
    - chamomile
    - lavender
    - hawthorn';

  v_nervine_differentials_src CONSTANT TEXT :=
'### Nervine differentials
- Skullcap - light, noises and smells overwhelm, recovery from mental breakdown or stimulant drugs
- Hops - stress induced stomach heat, over-planning, over-thinking, menopausal sleep disturbances
- Valerian - palliative sedative, antispasmodic (can have opposite reaction for some)
- Passionflower - circular thinking, helps mind disconnect
- Chamomile
- Milky Oats - frayed NS
- Lemon Balm - uplifting but relaxing
- Lavender - headaches, anxiety, insomnia from constant worry
- Motherwort - fried frazzled w/ tendency to palps and other heart stress
- Linden flower - nerves causing cardio heat and palps';

  v_insomnia_src CONSTANT TEXT :=
'## Insomnia
- Actions: hypnotic, sedative, antispasmodic, relaxing nervine, adaptogen
- sleep hygiene / Diet & Lifestyle
- Determine the source:
    - Pain: CA Poppy, Corydalis, Jamaican Dogwood, Wild Lettuce, Valerian
    - Menopause: Motherwort, Passionflower
    - Heartburn & Indigestion: Chamomile, Bitters
    - Anxiety: Skullcap, Milky Oats, Passionflower, Lavender, Pulsatilla
    - Muscle Tension: Pedicularis, Kava
        - Pedicularis (specific for jaw)';

  v_neuritis_src CONSTANT TEXT :=
'## Neuritis
- inflammation of peripheral nerves causing numbness, tingling, loss of reflex
- use nerve tonics:
    - SJW
    - milky oats
    - skullcap';

  v_hypnotic_analgesics_src CONSTANT TEXT :=
'## HYPNOTIC ANALGESICS
- Exact mechanism of action unknown
- Won''t sedate an unwilling person
- They decrease pain and increase quality of sleep
- Kava (Piper methysticum)
- Ghost Pipe (Monotropa uniflora) [NOT IN DB — skip]
- Valerian (Valeriana officinalis)
- California Poppy (Escholzia californica)
- Jamaican Dogwood (Piscidia piscula)';

  v_oils_src CONSTANT TEXT :=
'### Herbs to infuse in oils
- calendula: vulnerary, emollient, cools inflammation, good for cold stagnant depression
- chickweed: cooling, antipruritic, good for rash and sunburn
- evergreen oils (pine): anti-inflammatory, lymphatic, good for pain, good for arthritic joints, anti-tumor, antibacterial
- lavender: cooling, antiseptic - good for bites and burns, relaxing and calming
- mugwort: great for dreaming and meditation anointing oils, can be applied to womb area during menstruation
- plantain: drawing, anti-inflammatory for bites rashes and stings, improves wound healing, antimicrobial
- gotu kola: great for scar tissue; can use a gua sha tool with the oil to break up the tissue
- kava: antispasmodic, great for sore muscles, tightness and pain
- rosemary: stimulating, increases blood flow, use for arthritis, hair growth
- SJW: nerve pain and sore muscles, warming; one of few fresh plant oils (the other is chickweed — let it wilt for a day then use half-dry half-fresh)
- Yarrow: antimicrobial
- Violet: cooling, lymphatic, great for breast massage
- arnica flowers: great for strains, sprains and bruises; hard to find high quality flowers
- Dandelion [flower]: good for moving through deep seated emotional blockages, breaks through physical congestion and lethargy
- Chapparal: broadly antimicrobial, first aid plant; incredible for first aid; cellulitis with tea compresses';

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose') THEN
    RAISE NOTICE 'Class 17 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- ─── Daily Tea ────────────────────────────────────────────────────────────
    (45,
     'Marshmallow in daily tea',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Daily Tea', 10,
     v_daily_tea_src),

    (167,
     'Cinnamon in daily tea',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Daily Tea', 20,
     v_daily_tea_src),

    -- ─── Nervine Tonics ───────────────────────────────────────────────────────
    (142,
     'Skullcap as nervine tonic: spasms, shakiness, acute anxiety; best fresh tincture or tea — dried tincture not very effective',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Tonics', 30,
     v_nervine_tonics_src),

    (178,
     'Milky Oats: food for nervous system, emotional instability, drug withdrawal, frazzled nerves',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Tonics', 40,
     v_nervine_tonics_src),

    (2287,
     'Oat Straw used more in tea for high mineral support; nervine tonic',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Tonics', 50,
     v_nervine_tonics_src),

    (81,
     'St. John''s Wort: nerve damage and nerve pain; topical applications common; blooms around Summer Solstice',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Tonics', 60,
     v_nervine_tonics_src),

    -- ─── Nervine Relaxants ────────────────────────────────────────────────────
    (142,
     'Skullcap as nervine relaxant: acute anxiety, anger, tremors, spasm, nervous ticks; for too much caffeine',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 70,
     v_nervine_relaxants_src),

    (73,
     'Hawthorn (with Motherwort): for heart and chest anxiety/tightness',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 80,
     v_nervine_relaxants_src),

    (131,
     'Motherwort (with Hawthorn): for heart and chest anxiety/tightness',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 90,
     v_nervine_relaxants_src),

    (82,
     'Lavender: helps with depression and sleep',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 100,
     v_nervine_relaxants_src),

    (134,
     'Lemon Balm: gentle yet powerful, enhances mood, potentiates other nervines; dry carefully as scent dissipates',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 110,
     v_nervine_relaxants_src),

    (90,
     'Linden: grief remedy; pair with lemon balm and mimosa flowers for depression; astringent, can ground weepiness',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 120,
     v_nervine_relaxants_src),

    (983,
     'Blue Vervain: dispels illusion; use for fear of death with Night-Blooming Cereus; combine with Motherwort; PMS and menopausal anxiety with Milky Oats; for hyper-focus you can''t shut off; really bitter',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 130,
     v_nervine_relaxants_src),

    (2616,
     'Night-Blooming Cereus: paired with Blue Vervain for fear of death',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 140,
     v_nervine_relaxants_src),

    (36,
     'Pasqueflower (Pulsatilla): drop dose plant for anxiety and acute wind; for shock trauma',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 150,
     v_nervine_relaxants_src),

    (138,
     'Kava: heart-opening antispasmodic; good for fast-paced city dwellers; smoothing out social anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 160,
     v_nervine_relaxants_src),

    (136,
     'Catnip: good for worry; great for children; good for stress-induced GI symptoms combined with Chamomile; infant fever baths with strong tea',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 170,
     v_nervine_relaxants_src),

    (207,
     'Wood Betony (Stachys): good for head pain and stress-induced migraines',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Relaxants', 180,
     v_nervine_relaxants_src),

    -- ─── Nervine Stimulants ───────────────────────────────────────────────────
    (217,
     'Coffee: nervine stimulant',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Stimulants', 190,
     v_nervine_stimulants_src),

    (109,
     'Rosemary: nervine stimulant',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Stimulants', 200,
     v_nervine_stimulants_src),

    (615,
     'Kola Nut: nervine stimulant',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Stimulants', 210,
     v_nervine_stimulants_src),

    (2749,
     'Cacao: nervine stimulant',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Stimulants', 220,
     v_nervine_stimulants_src),

    (14,
     'Panax Ginseng: nervine stimulant',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Stimulants', 230,
     v_nervine_stimulants_src),

    (16,
     'Rhodiola: nervine stimulant',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Stimulants', 240,
     v_nervine_stimulants_src),

    -- ─── Sedatives ────────────────────────────────────────────────────────────
    (129,
     'Hops: sedative for stress or pain; good for premenopausal insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Sedatives', 250,
     v_sedatives_src),

    (145,
     'Valerian: sedative; may wire some people (paradoxical reaction)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Sedatives', 260,
     v_sedatives_src),

    (137,
     'Passionflower: sedative; good for sleep',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Sedatives', 270,
     v_sedatives_src),

    (128,
     'California Poppy: sedative; good during day to smooth out the edges; smaller doses for kids',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Sedatives', 280,
     v_sedatives_src),

    (130,
     'Wild Lettuce: great for pain management; sedative',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Sedatives', 290,
     v_sedatives_src),

    -- ─── Adaptogens ───────────────────────────────────────────────────────────
    (15,
     'American Ginseng: adaptogen; possibly less stimulating than Panax',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 300,
     v_adaptogens_src),

    (14,
     'Panax Ginseng: adaptogen',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 310,
     v_adaptogens_src),

    (9,
     'Siberian Ginseng (Eleuthero): adaptogen; "the White Rabbit — running around late"; bend time, make more space in the day',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 320,
     v_adaptogens_src),

    (20,
     'Ashwagandha: adaptogen; warming',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 330,
     v_adaptogens_src),

    (16,
     'Rhodiola: adaptogen; very drying — adding a little glycerin to tincture helps; more stimulating; good for elevation sickness and camping trips',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 340,
     v_adaptogens_src),

    (13,
     'Tulsi: adaptogen',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 350,
     v_adaptogens_src),

    (17,
     'Schizandra: adaptogen; five-flavor berry — what flavor you taste is said to be what you need; helps with energy and focus',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Adaptogens', 360,
     v_adaptogens_src),

    -- ─── GI-Based Depression ──────────────────────────────────────────────────
    (81,
     'St. John''s Wort: specific for GI-based depression (enteric brain/serotonin connection)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'GI-Based Depression', 370,
     v_gi_depression_src),

    (2573,
     'Saffron: herb for GI-based depression (gut-brain axis)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'GI-Based Depression', 380,
     v_gi_depression_src),

    (97,
     'Wormwood: herb for GI-based depression (bitter to support enteric brain)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'GI-Based Depression', 390,
     v_gi_depression_src),

    (134,
     'Lemon Balm: herb for GI-based depression (gut-brain axis)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'GI-Based Depression', 400,
     v_gi_depression_src),

    (84,
     'Chamomile: herb for GI-based depression (gut-brain axis)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'GI-Based Depression', 410,
     v_gi_depression_src),

    (136,
     'Catnip: herb for GI-based depression (gut-brain axis)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'GI-Based Depression', 420,
     v_gi_depression_src),

    -- ─── Stagnant Depression ──────────────────────────────────────────────────
    (2285,
     'Silk Tree bark (Mimosa Bark / Albizia): for stagnant depression — PTSD and chronic unrelenting grief',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Stagnant Depression', 430,
     v_stagnant_depression_src),

    (13,
     'Tulsi: for stagnant depression; fresh tincture is incredible, also dries well',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Stagnant Depression', 440,
     v_stagnant_depression_src),

    (850,
     'Rose petal: for stagnant depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Stagnant Depression', 450,
     v_stagnant_depression_src),

    (82,
     'Lavender: for stagnant depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Stagnant Depression', 460,
     v_stagnant_depression_src),

    (109,
     'Rosemary: for stagnant depression — for remembrance, the part that you lost',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Stagnant Depression', 470,
     v_stagnant_depression_src),

    (144,
     'Damiana: for stagnant depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Stagnant Depression', 480,
     v_stagnant_depression_src),

    -- ─── Thyroid Induced Depression ───────────────────────────────────────────
    (20,
     'Ashwagandha: for thyroid-induced depression from hypothyroidism',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 490,
     v_thyroid_depression_src),

    (2381,
     'Bacopa: for thyroid-induced depression from hypothyroidism; memory support',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 500,
     v_thyroid_depression_src),

    (118,
     'Kelp (Bladderwrack, Fucus vesiculosus): for thyroid-induced depression; can dry and put in capsules',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 510,
     v_thyroid_depression_src),

    (144,
     'Damiana: for thyroid-induced depression from hypothyroidism',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 520,
     v_thyroid_depression_src),

    (14,
     'Red Ginseng (Panax Ginseng): for thyroid-induced depression from hypothyroidism',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 530,
     v_thyroid_depression_src),

    -- ─── Seasonal Affective Disorder ──────────────────────────────────────────
    (70,
     'Calendula: light-bearing plant for SAD; follows the sun',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Seasonal Affective Disorder', 540,
     v_sad_src),

    (134,
     'Lemon Balm: light-bearing plant for SAD',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Seasonal Affective Disorder', 550,
     v_sad_src),

    (81,
     'St. John''s Wort: light-bearing plant for SAD; blooms at Summer Solstice',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Seasonal Affective Disorder', 560,
     v_sad_src),

    -- ─── Herbs for Depression ─────────────────────────────────────────────────
    (109,
     'Rosemary: good for brain fog and memory from depression; eases headaches; circulation tonic; warming and stimulating',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 570,
     v_herbs_depression_src),

    (82,
     'Lavender: for GI-based depression; with insomnia and headaches',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 580,
     v_herbs_depression_src),

    (13,
     'Tulsi: for stagnant depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 590,
     v_herbs_depression_src),

    (2285,
     'Silk Tree bark (Mimosa Bark): depression with grief, heartbreak, bad dreams, anger, irritability',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 600,
     v_herbs_depression_src),

    (73,
     'Hawthorn: depression from heartbreak or grief',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 610,
     v_herbs_depression_src),

    (850,
     'Rose: depression from loss, scattered depression, lack of boundaries',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 620,
     v_herbs_depression_src),

    (25,
     'Black Cohosh: black cloud depression, hormonal depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 630,
     v_herbs_depression_src),

    (81,
     'St. John''s Wort: for depression with sour stomach, sour attitude, dark outlook with a sense of emotional unease',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 640,
     v_herbs_depression_src),

    (134,
     'Lemon Balm: uplifting, light-bearing plant for depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 650,
     v_herbs_depression_src),

    (1597,
     'Frankincense (Boswellia): depression with other signs of systemic inflammation, especially with GI inflammation',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs for Depression', 660,
     v_herbs_depression_src),

    -- ─── Spirit Remedies for Depression ──────────────────────────────────────
    (61,
     'Mullein Flower Essence: a guiding torch when someone is stuck in the "underworld" — for deep depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 670,
     v_spirit_remedies_src),

    (2285,
     'Silk Tree (Albizia / Mimosa Bark): the tree of joy — utilize in all forms for depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 680,
     v_spirit_remedies_src),

    (2746,
     'Silk Tree flowers (Mimosa flowers): the tree of joy — utilize in all forms for depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 690,
     v_spirit_remedies_src),

    (73,
     'Hawthorn: for courage and strength of the heart (spirit remedy for depression)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 700,
     v_spirit_remedies_src),

    (69,
     'Borage Flower Essence: for courage (spirit remedy for depression)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 710,
     v_spirit_remedies_src),

    (850,
     'Rose: resilience of the heart, self-love (spirit remedy for depression)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 720,
     v_spirit_remedies_src),

    (90,
     'Linden: for processing and moving through grief — tree of joy and sorrow (spirit remedy for depression)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 730,
     v_spirit_remedies_src),

    (2653,
     'Bleeding Heart Flower Essence: depression due to loss',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 740,
     v_spirit_remedies_src),

    (2437,
     'Self Heal Flower Essence: spirit remedy for depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 750,
     v_spirit_remedies_src),

    (124,
     'Ginger: herb for transformation (spirit remedy context for depression)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 760,
     v_spirit_remedies_src),

    (47,
     'Cayenne: herb for transformation (spirit remedy context for depression)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 770,
     v_spirit_remedies_src),

    (11,
     'Reishi: inviting the light back in — spirit remedy for depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Spirit Remedies for Depression', 780,
     v_spirit_remedies_src),

    -- ─── Anxiety ──────────────────────────────────────────────────────────────
    (983,
     'Blue Vervain: anxiolytic for chronic high cortisol anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 790,
     v_anxiety_src),

    (131,
     'Motherwort: anxiolytic; hypotensive nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 800,
     v_anxiety_src),

    (36,
     'Pasqueflower (Anemone / Pulsatilla): anxiolytic nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 810,
     v_anxiety_src),

    (142,
     'Skullcap: relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 820,
     v_anxiety_src),

    (2285,
     'Silk Tree (Albizia): anxiolytic for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 830,
     v_anxiety_src),

    (134,
     'Lemon Balm: relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 840,
     v_anxiety_src),

    (137,
     'Passionflower: relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 850,
     v_anxiety_src),

    (128,
     'California Poppy: anxiolytic; relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 860,
     v_anxiety_src),

    (130,
     'Wild Lettuce: sedative anxiolytic for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 870,
     v_anxiety_src),

    (129,
     'Hops: sedative nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 880,
     v_anxiety_src),

    (20,
     'Ashwagandha: adaptogen for anxiety (address underlying chronic stress)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 890,
     v_anxiety_src),

    (144,
     'Damiana: anxiolytic nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 900,
     v_anxiety_src),

    (69,
     'Borage: nervine for anxiety and courage',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 910,
     v_anxiety_src),

    (90,
     'Linden: relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 920,
     v_anxiety_src),

    (84,
     'Chamomile: relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 930,
     v_anxiety_src),

    (82,
     'Lavender: relaxing nervine for anxiety',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 940,
     v_anxiety_src),

    (73,
     'Hawthorn: relaxing nervine for anxiety (heart and chest tightness)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Anxiety', 950,
     v_anxiety_src),

    -- ─── Nervine Differentials ────────────────────────────────────────────────
    (142,
     'Skullcap differential: light, noises and smells overwhelm; recovery from mental breakdown or stimulant drugs',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 960,
     v_nervine_differentials_src),

    (129,
     'Hops differential: stress-induced stomach heat, over-planning, over-thinking, menopausal sleep disturbances',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 970,
     v_nervine_differentials_src),

    (145,
     'Valerian differential: palliative sedative, antispasmodic; can have opposite (wiring) reaction in some people',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 980,
     v_nervine_differentials_src),

    (137,
     'Passionflower differential: circular thinking; helps the mind disconnect',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 990,
     v_nervine_differentials_src),

    (84,
     'Chamomile: nervine relaxant differential (general)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 1000,
     v_nervine_differentials_src),

    (178,
     'Milky Oats differential: frayed nervous system',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 1010,
     v_nervine_differentials_src),

    (134,
     'Lemon Balm differential: uplifting but relaxing',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 1020,
     v_nervine_differentials_src),

    (82,
     'Lavender differential: headaches, anxiety, insomnia from constant worry',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 1030,
     v_nervine_differentials_src),

    (131,
     'Motherwort differential: fried/frazzled with tendency toward palpitations and heart stress',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 1040,
     v_nervine_differentials_src),

    (90,
     'Linden flower differential: nerves causing cardiovascular heat and palpitations',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Nervine Differentials', 1050,
     v_nervine_differentials_src),

    -- ─── Insomnia ─────────────────────────────────────────────────────────────
    (128,
     'California Poppy: for pain-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1060,
     v_insomnia_src),

    (2228,
     'Corydalis: for pain-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1070,
     v_insomnia_src),

    (2461,
     'Jamaican Dogwood: for pain-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1080,
     v_insomnia_src),

    (130,
     'Wild Lettuce: for pain-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1090,
     v_insomnia_src),

    (145,
     'Valerian: for pain-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1100,
     v_insomnia_src),

    (131,
     'Motherwort: for menopause-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1110,
     v_insomnia_src),

    (137,
     'Passionflower: for menopause-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1120,
     v_insomnia_src),

    (84,
     'Chamomile: for heartburn and indigestion insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1130,
     v_insomnia_src),

    (142,
     'Skullcap: for anxiety-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1140,
     v_insomnia_src),

    (178,
     'Milky Oats: for anxiety-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1150,
     v_insomnia_src),

    (137,
     'Passionflower: for anxiety-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1160,
     v_insomnia_src),

    (82,
     'Lavender: for anxiety-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1170,
     v_insomnia_src),

    (36,
     'Pasqueflower (Pulsatilla): for anxiety-induced insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1180,
     v_insomnia_src),

    (2624,
     'Pedicularis: for muscle tension insomnia; specific for jaw tension',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1190,
     v_insomnia_src),

    (138,
     'Kava: for muscle tension insomnia',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Insomnia', 1200,
     v_insomnia_src),

    -- ─── Neuritis ─────────────────────────────────────────────────────────────
    (81,
     'St. John''s Wort: nerve tonic for neuritis (inflammation of peripheral nerves causing numbness, tingling, loss of reflex)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Neuritis', 1210,
     v_neuritis_src),

    (178,
     'Milky Oats: nerve tonic for neuritis (peripheral nerve inflammation)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Neuritis', 1220,
     v_neuritis_src),

    (142,
     'Skullcap: nerve tonic for neuritis (peripheral nerve inflammation)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Neuritis', 1230,
     v_neuritis_src),

    -- ─── Hypnotic Analgesics ──────────────────────────────────────────────────
    (138,
     'Kava: hypnotic analgesic — exact mechanism unknown; won''t sedate an unwilling person; decreases pain and increases quality of sleep',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Hypnotic Analgesics', 1240,
     v_hypnotic_analgesics_src),

    (145,
     'Valerian: hypnotic analgesic — exact mechanism unknown; won''t sedate an unwilling person; decreases pain and increases quality of sleep',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Hypnotic Analgesics', 1250,
     v_hypnotic_analgesics_src),

    (128,
     'California Poppy: hypnotic analgesic — decreases pain and increases quality of sleep; will not sedate an unwilling person',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Hypnotic Analgesics', 1260,
     v_hypnotic_analgesics_src),

    (2461,
     'Jamaican Dogwood: hypnotic analgesic — decreases pain and increases quality of sleep; will not sedate an unwilling person',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Hypnotic Analgesics', 1270,
     v_hypnotic_analgesics_src),

    -- ─── Herbs to Infuse in Oils ──────────────────────────────────────────────
    (70,
     'Calendula oil: vulnerary, emollient, cools inflammation; good for cold stagnant depression',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1280,
     v_oils_src),

    (88,
     'Chickweed oil: cooling, antipruritic; good for rash and sunburn; let wilt for a day, use half-dry half-fresh (one of few fresh plant oils)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1290,
     v_oils_src),

    (2643,
     'Pine Needles (evergreen/pine oil): anti-inflammatory, lymphatic; good for pain, arthritic joints, anti-tumor, antibacterial',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1300,
     v_oils_src),

    (82,
     'Lavender oil: cooling, antiseptic; good for bites and burns; relaxing and calming',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1310,
     v_oils_src),

    (115,
     'Mugwort oil: great for dreaming and meditation anointing oils; can be applied to womb area during menstruation',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1320,
     v_oils_src),

    (85,
     'Plantain oil: drawing, anti-inflammatory for bites, rashes and stings; improves wound healing; antimicrobial',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1330,
     v_oils_src),

    (2229,
     'Gotu Kola oil: great for scar tissue; can use a gua sha tool with the oil to break up the tissue',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1340,
     v_oils_src),

    (138,
     'Kava oil: antispasmodic; great for sore muscles, tightness and pain',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1350,
     v_oils_src),

    (109,
     'Rosemary oil: stimulating, increases blood flow; use for arthritis, hair growth',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1360,
     v_oils_src),

    (81,
     'St. John''s Wort oil: nerve pain and sore muscles, warming; one of few fresh plant oils (along with chickweed)',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1370,
     v_oils_src),

    (44,
     'Yarrow oil: antimicrobial',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1380,
     v_oils_src),

    (198,
     'Violet oil: cooling, lymphatic; great for breast massage',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1390,
     v_oils_src),

    (114,
     'Arnica flowers oil: great for strains, sprains and bruises; high quality flowers hard to find',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1400,
     v_oils_src),

    (122,
     'Dandelion flower oil (mapped to root id 122 — DB has no flower part entry): good for moving through deep-seated emotional blockages; breaks through physical congestion and lethargy',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1410,
     v_oils_src),

    (32,
     'Chaparral oil: broadly antimicrobial, first aid plant; cellulitis with tea compresses',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Herbs to Infuse in Oils', 1420,
     v_oils_src);

END $$;

-- ─── Supplement snippets (SAD section) ────────────────────────────────────────
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose') THEN
    RAISE NOTICE 'Class 17 snippets already loaded (supplement block skipped)';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (11,
     'Vitamin D: supplement 2000 IU/day for Seasonal Affective Disorder caused by lack of sunlight',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Seasonal Affective Disorder', 1430,
     '### SAD
- caused by lack of sunlight, can be exacerbated by vit D deficiency
- supplementing 2000 iu/day
- get outside
- light boxes and full spectrum lighting in homes
- use light-bearing plants:
    - Calendula - follows the sun
    - Lemon Balm
    - SJW - summer solstice
- can also supplement SAMe (400-1200mg in the morning on an empty stomach)'),

    (36,
     'SAM-E: supplement for SAD and depression; 400–1200mg in the morning on an empty stomach',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Seasonal Affective Disorder', 1440,
     '### SAD
- caused by lack of sunlight, can be exacerbated by vit D deficiency
- supplementing 2000 iu/day
- get outside
- light boxes and full spectrum lighting in homes
- use light-bearing plants:
    - Calendula - follows the sun
    - Lemon Balm
    - SJW - summer solstice
- can also supplement SAMe (400-1200mg in the morning on an empty stomach)'),

    (23,
     'Selenium: supplement for thyroid-induced depression from hypothyroidism',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 1450,
     '### Thyroid Induced Depression
- (bloodwork probably called for here to narrow down)
- often caused by hypothyroidism
- symptoms include: feeling cold, poor memory, dry skin, thinning hair, depression, weight gain
- supplement iodine, selenium, and L-tyrosine
- herbs:
    - ashwagandha
    - bacopa
    - bladderwrack
        - can dry and put in capsules, tastes not good
    - Damiana
    - Red Ginseng'),

    (18,
     'Iodine: supplement for thyroid-induced depression from hypothyroidism',
     'BHC - Class 17 - Nervous System 2 and Herbal Oils - Rose', 'personal', 'Thyroid Induced Depression', 1460,
     '### Thyroid Induced Depression
- (bloodwork probably called for here to narrow down)
- often caused by hypothyroidism
- symptoms include: feeling cold, poor memory, dry skin, thinning hair, depression, weight gain
- supplement iodine, selenium, and L-tyrosine
- herbs:
    - ashwagandha
    - bacopa
    - bladderwrack
        - can dry and put in capsules, tastes not good
    - Damiana
    - Red Ginseng');
END $$;

-- ─── Herb keywords ────────────────────────────────────────────────────────────
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Marshmallow (45) — daily tea context, no new clinical keywords from this mention
  -- Cinnamon (167) — daily tea context, no new clinical keywords from this mention

  -- Skullcap (142)
  (142, 'anxiety',                   'ailment'),
  (142, 'nervous system support',    'ailment'),
  (142, 'substance withdrawal',      'ailment'),
  (142, 'neuritis',                  'ailment'),
  (142, 'sleep support',             'ailment'),
  (142, 'muscle spasms',             'ailment'),
  (142, 'anxiolytic',                'action'),

  -- Milky Oats (178)
  (178, 'nervous system support',    'ailment'),
  (178, 'substance withdrawal',      'ailment'),
  (178, 'neuritis',                  'ailment'),
  (178, 'anxiety',                   'ailment'),
  (178, 'sleep support',             'ailment'),

  -- Oat Straw (2287)
  (2287, 'nervous system support',   'ailment'),
  (2287, 'anxiety',                  'ailment'),

  -- St. John's Wort (81)
  (81, 'nerve pain',                 'ailment'),
  (81, 'depression',                 'ailment'),
  (81, 'neuritis',                   'ailment'),
  (81, 'anxiety',                    'ailment'),
  (81, 'seasonal affective disorder','ailment'),
  (81, 'GI inflammation',            'ailment'),

  -- Hawthorn berry (73)
  (73, 'anxiety',                    'ailment'),
  (73, 'depression',                 'ailment'),
  (73, 'palpitations',               'ailment'),

  -- Motherwort (131)
  (131, 'anxiety',                   'ailment'),
  (131, 'palpitations',              'ailment'),
  (131, 'perimenopause',             'ailment'),
  (131, 'sleep support',             'ailment'),

  -- Lavender (82)
  (82, 'anxiety',                    'ailment'),
  (82, 'depression',                 'ailment'),
  (82, 'sleep support',              'ailment'),
  (82, 'headache',                   'ailment'),

  -- Lemon Balm (134)
  (134, 'anxiety',                   'ailment'),
  (134, 'depression',                'ailment'),
  (134, 'seasonal affective disorder','ailment'),
  (134, 'nervous system support',    'ailment'),

  -- Linden (90)
  (90, 'anxiety',                    'ailment'),
  (90, 'depression',                 'ailment'),
  (90, 'palpitations',               'ailment'),

  -- Blue Vervain (983)
  (983, 'anxiety',                   'ailment'),
  (983, 'depression',                'ailment'),
  (983, 'shock',                     'ailment'),
  (983, 'perimenopause',             'ailment'),

  -- Night-Blooming Cereus (2616)
  (2616, 'anxiety',                  'ailment'),

  -- Pasqueflower (36)
  (36, 'anxiety',                    'ailment'),
  (36, 'shock',                      'ailment'),
  (36, 'sleep support',              'ailment'),

  -- Kava (138)
  (138, 'anxiety',                   'ailment'),
  (138, 'muscle spasms',             'ailment'),
  (138, 'sleep support',             'ailment'),
  (138, 'nerve pain',                'ailment'),
  (138, 'antispasmodic',             'action'),

  -- Catnip (136)
  (136, 'anxiety',                   'ailment'),
  (136, 'stress',                    'ailment'),

  -- Wood Betony (207)
  (207, 'headache',                  'ailment'),
  (207, 'stress',                    'ailment'),

  -- Coffee (217)
  (217, 'nervous system support',    'ailment'),

  -- Rosemary (109)
  (109, 'depression',                'ailment'),
  (109, 'brain fog',                 'ailment'),
  (109, 'arthritis',                 'ailment'),
  (109, 'memory support',            'ailment'),
  (109, 'headache',                  'ailment'),

  -- Kola Nut (615)
  (615, 'fatigue',                   'ailment'),
  (615, 'nervous system support',    'ailment'),

  -- Cacao (2749)
  (2749, 'nervous system support',   'ailment'),

  -- Panax Ginseng (14)
  (14, 'adaptogen',                  'action'),
  (14, 'fatigue',                    'ailment'),
  (14, 'stress',                     'ailment'),
  (14, 'hypothyroidism',             'ailment'),
  (14, 'depression',                 'ailment'),

  -- Hops (129)
  (129, 'sleep support',             'ailment'),
  (129, 'perimenopause',             'ailment'),
  (129, 'anxiety',                   'ailment'),

  -- Valerian (145)
  (145, 'sleep support',             'ailment'),
  (145, 'muscle spasms',             'ailment'),
  (145, 'nerve pain',                'ailment'),
  (145, 'anxiety',                   'ailment'),
  (145, 'antispasmodic',             'action'),

  -- Passionflower (137)
  (137, 'sleep support',             'ailment'),
  (137, 'anxiety',                   'ailment'),
  (137, 'perimenopause',             'ailment'),

  -- California Poppy (128)
  (128, 'sleep support',             'ailment'),
  (128, 'anxiety',                   'ailment'),
  (128, 'nerve pain',                'ailment'),

  -- Wild Lettuce (130)
  (130, 'sleep support',             'ailment'),
  (130, 'nerve pain',                'ailment'),

  -- American Ginseng (15)
  (15, 'adaptogen',                  'action'),
  (15, 'stress',                     'ailment'),
  (15, 'fatigue',                    'ailment'),

  -- Siberian Ginseng (9)
  (9, 'adaptogen',                   'action'),
  (9, 'stress',                      'ailment'),
  (9, 'fatigue',                     'ailment'),

  -- Ashwagandha (20)
  (20, 'adaptogen',                  'action'),
  (20, 'stress',                     'ailment'),
  (20, 'hypothyroidism',             'ailment'),
  (20, 'depression',                 'ailment'),
  (20, 'anxiety',                    'ailment'),

  -- Rhodiola (16)
  (16, 'adaptogen',                  'action'),
  (16, 'stress',                     'ailment'),
  (16, 'fatigue',                    'ailment'),

  -- Tulsi (13)
  (13, 'adaptogen',                  'action'),
  (13, 'stress',                     'ailment'),
  (13, 'depression',                 'ailment'),
  (13, 'PTSD',                       'ailment'),

  -- Schizandra (17)
  (17, 'adaptogen',                  'action'),
  (17, 'fatigue',                    'ailment'),
  (17, 'memory support',             'ailment'),

  -- Silk Tree bark (2285)
  (2285, 'depression',               'ailment'),
  (2285, 'anxiety',                  'ailment'),
  (2285, 'PTSD',                     'ailment'),

  -- Silk Tree flowers (2746)
  (2746, 'depression',               'ailment'),
  (2746, 'anxiety',                  'ailment'),
  (2746, 'PTSD',                     'ailment'),

  -- Rose petal (850)
  (850, 'depression',                'ailment'),
  (850, 'anxiety',                   'ailment'),

  -- Damiana (144)
  (144, 'depression',                'ailment'),
  (144, 'hypothyroidism',            'ailment'),
  (144, 'anxiety',                   'ailment'),

  -- Wormwood (97)
  (97, 'depression',                 'ailment'),
  (97, 'GI inflammation',            'ailment'),

  -- Saffron (2573)
  (2573, 'depression',               'ailment'),

  -- Chamomile (84)
  (84, 'anxiety',                    'ailment'),
  (84, 'depression',                 'ailment'),
  (84, 'sleep support',              'ailment'),

  -- Calendula (70)
  (70, 'depression',                 'ailment'),
  (70, 'seasonal affective disorder','ailment'),

  -- Black Cohosh (25)
  (25, 'depression',                 'ailment'),
  (25, 'perimenopause',              'ailment'),

  -- Bacopa (2381)
  (2381, 'depression',               'ailment'),
  (2381, 'hypothyroidism',           'ailment'),
  (2381, 'memory support',           'ailment'),

  -- Kelp (118)
  (118, 'hypothyroidism',            'ailment'),
  (118, 'depression',                'ailment'),

  -- Mullein (61) — Flower Essence context
  (61, 'depression',                 'ailment'),

  -- Borage (69)
  (69, 'anxiety',                    'ailment'),
  (69, 'depression',                 'ailment'),

  -- Bleeding Heart (2653)
  (2653, 'depression',               'ailment'),

  -- Self Heal (2437)
  (2437, 'depression',               'ailment'),

  -- Frankincense (1597)
  (1597, 'depression',               'ailment'),
  (1597, 'GI inflammation',          'ailment'),
  (1597, 'inflammation',             'ailment'),
  (1597, 'anti-inflammatory',        'action'),

  -- Pine Needles (2643)
  (2643, 'inflammation',             'ailment'),
  (2643, 'arthritis',                'ailment'),
  (2643, 'lymphatic support',        'ailment'),
  (2643, 'anti-inflammatory',        'action'),
  (2643, 'antimicrobial',            'action'),

  -- Chickweed (88)
  (88, 'skin conditions',            'ailment'),

  -- Plantain (85)
  (85, 'wound healing',              'ailment'),
  (85, 'inflammation',               'ailment'),
  (85, 'antimicrobial',              'action'),
  (85, 'anti-inflammatory',          'action'),

  -- Gotu Kola (2229)
  (2229, 'wound healing',            'ailment'),

  -- Yarrow (44)
  (44, 'antimicrobial',              'action'),

  -- Violet (198)
  (198, 'lymphatic support',         'ailment'),

  -- Arnica (114)
  (114, 'inflammation',              'ailment'),
  (114, 'arthritis',                 'ailment'),

  -- Dandelion root (122) — no new keywords from this mention

  -- Chaparral (32)
  (32, 'antimicrobial',              'action'),
  (32, 'skin conditions',            'ailment'),

  -- Reishi Mushroom (11)
  (11, 'depression',                 'ailment'),

  -- Pedicularis (2624)
  (2624, 'muscle spasms',            'ailment'),
  (2624, 'sleep support',            'ailment'),
  (2624, 'antispasmodic',            'action'),

  -- Jamaican Dogwood (2461)
  (2461, 'sleep support',            'ailment'),
  (2461, 'nerve pain',               'ailment'),

  -- Corydalis (2228)
  (2228, 'sleep support',            'ailment'),
  (2228, 'nerve pain',               'ailment')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ─── Supplement keywords ───────────────────────────────────────────────────────
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (11, 'seasonal affective disorder', 'ailment'),
  (36, 'depression',                  'ailment'),
  (36, 'seasonal affective disorder', 'ailment'),
  (23, 'hypothyroidism',              'ailment'),
  (18, 'hypothyroidism',              'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ─── New ailment search term ──────────────────────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('neuritis',
   ARRAY['peripheral neuropathy', 'peripheral nerve inflammation', 'nerve inflammation', 'neuropathy', 'numbness and tingling', 'peripheral neuritis'])
ON CONFLICT (ailment_keyword) DO NOTHING;
