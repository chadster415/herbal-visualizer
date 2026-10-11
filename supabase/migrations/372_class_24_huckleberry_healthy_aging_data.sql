-- Migration 372: Class 24 — Huckleberry Herb Walk and Healthy Aging (data)
-- Files parsed:
--   BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging - Mer Lisa.md (personal, note_type='personal')
--   No generated notes file.
--
-- Normalisations:
--   "Dead Nettle - wood betony" → Wood Betony (Stachys officinalis, id=207)
--   "Bay" on trail → California Bay Laurel (Umbellularia californica, id=2751; added in migration 371)
--   "Aralia / Queen of the Forest / Spikenard" → California Spikenard (Aralia californica, id=579)
--   "Prunella - self-heal" → Self Heal (Prunella vulgaris, id=2437)
--   "lion's mane" → Lion's Mane Mushroom (Hericium erinaceus, id=2632)
--   "Tulsi" → Holy Basil (Ocimum sanctum, id=13)
--   "Goji berries" → Wolfberry Fruit (Fructus Lycii Chinensis, id=1548)
--   "Jujubes" → Jujube / Chinese Red Date (Fructus Zizyphi Jujubae, id=1528)
--   "Panax Ginseng" → Ginseng (Panax ginseng, id=14)
--   "Siberian Ginseng" → Siberian Ginseng (Eleutherococcus senticosus, id=9)
--   "Licorice root" / "Licorice" → Licorice (Glycyrrhiza glabra, id=78); appears in two sections
--
-- Merge decisions (keywords):
--   "allergy/allergies" (Self Heal) → new keyword 'allergies' (distinct from existing 'hay fever')
--   "concussion" → new keyword (distinct from 'cognitive support', 'memory support')
--   "dissociation" (Wood Betony) → new keyword (distinct from 'anxiety')
--   "neuroprotective" → new action keyword
--   "stimulate innate immune response" (Myrrh) → 'immune support' (existing)
--   "Lymphagogue" → 'lymphatic support' (existing)
--   "blood cleansing" used for alteratives (existing)
--   "healthy aging" → new general keyword for key herbs in afternoon section
--
-- Skipped herbs (not appropriate to add):
--   Sticky Monkeyflower — FE only, not clinical
--   Miner's Lettuce — food only
--   Cow Parsnip — brief ID note, not in DB, not clinical
--   Madrone — folk story, not clinical
--   Poison Oak — folk remedy context only
--   Raspberry (id=155) — mentioned only for poison oak first aid, no clinical content for Raspberry itself

SET search_path TO herbal, public;

DO $$
DECLARE
  v_morning  text;
  v_healthy  text;
  v_physical text;
  v_accum    text;
  v_pancha   text;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging') THEN
    RAISE NOTICE 'Class 24 snippets already loaded, skipping';
    RETURN;
  END IF;

  v_morning := '- California Poppy
    - AP - fresh tea with Catnip
- Sticky Monkeyflower FE
    - someone else''s energy unstick
- Robin Rose Bennett - The Gift of Healing Herbs - field of Milky Oats
- Milky Oats - myelin coating
- Miner''s Lettuce - like spinach
    - springtime food, salad
- Dead Nettle - wood betony - little purple flowers
    - headaches, to drain the energy
    - Stachys - helps with embodiment, sense of self-love
    - Betony - Easley Monograph
        - rootedness and groundedness in the solar plexus
        - for dissociation with anxiety
        - Stachys bellota
- Bay - smell for headaches on the trail
- Usnea - for hot/damp infections
    - immune support
    - heat up tincture
- Cow Parsnip - latex is a rubefacient
- Figwort - cleansing pathways
    - edema, sluggish
    - skin issues
- Madrone
    - berries are medicinal
    - eating 1 berry every day while growing up said to make one immune to poison oak
- Poison Oak - crush leaves of blackberry or raspberry and rub - astringent helps if you were exposed, but isn''t itchy and activated yet
- Lily of the Valley
    - super low dose heart medicine
    - cute hanging upside down flowers
    - FE - connecting to the angel realm
- Prunella - self-heal
    - drain and cool the liver
    - affinity to brain (concussions)
    - allergies
    - brain lymphatic
    - concussion?
        - lion''s mane - regenerate nerves, influence cognition
        - rosemary
        - ginkgo
- Aralia - Queen of the Forest
    - Spikenard
    - connects air and water
    - medicinally, root and berry
    - lungs, adaptogen
        - strengthens
    - tense and tight, can''t catch breath
    - plants that support our lungs connect us with everything';

  v_healthy := 'Tea:
Jujubes
Goji berries
- chinese Lycium species
- american one is wolfberry - L. fremontii
Shatavari
Calendula

- aging is not a disease
- not allowed now as something that can go on the death certificate
- legally, there has to be some other reason
- but the body changes as it ages, and becomes more vulnerable
- the tools that we have are nourishing our own vulnerabilities
- live forever?
    - mitochondrial health
    - telomeres
- disturbing that we try to hide our elderly, whereas in other cultures, they are the ones to hold the culture';

  v_physical := '### Physical changes to support
- slowing of digestion -> marshmallow, etc
- slowing of metabolism -> Licorice root
    - how we take the nutrients from digestion, build tissues, hormones, detox
- why? body starting to dry out, skin more alkaline
    - "the Vata phase of life" - Ayurveda
    - closer to the ethers
    - we need to nourish those secretions
- leads to lowered immunity
- potential for building up of waste (because of slowed digestion and metabolism)
    - first stage of potential disease
    - our whole lives are to avoid accumulation of waste - keep circulation flowing
- nervous system dysregulation';

  v_accum := '### Accumulation
- toxins build up
- cause immune response
- one of the first signals is inflammation
    - forms: aches and pains, etc
    - it''s an alarm
- where does that waste reside? blood, joints, bowels
- inflammation lands in sites of overuse, previous injury, vulnerable areas
    - joint articulations
- what do we need with herbal actions?
    - Alteratives
        - Dandelion root
        - Mullein?
        - Burdock
        - Yellow Dock, esp with constipation
        - Red Clover, esp for the elderly
        - Milk Thistle
        - Licorice (but not just an alterative)
    - Immune support
        - Elder
        - Myrrh - stimulate innate immune response
        - Echinacea
    - Adaptogen
        - Tulsi
    - Lymphagogue
        - Cleavers - Lymphagogue
        - Figwort';

  v_pancha := '### "Pancha karma"
- way of addressing accumulation in the body, point by point
- as the body ages, this addressing should happen every year
- from the herbalist perspective:
    - start with alteratives and demulcents
    - skin more alkaline, so body needs more protein
        - 1 g/kg of body weight
        - this is where you get into the spices, make it taste good
        - carminatives for cold bodies, bitters for hot bodies
- for nervous system dysregulation:
    - oilination - daily
    - this nourishes the skin, improves healing speed with less alkalinity
- for immunity:
    - strategy: moistening while stimulating the immune function
    - Astragalus
    - Jujubes
    - Goji Berries
    - Calendula
    - Shatavari
    - Echinacea and Myrrh: stimulates immune function while addressing waste accumulation

Tasting:
- Astragalus - preserved decoction
    - nourishing and moistening to the tissues
    - contraindicated when acute sick, but good for chronic or preventative
    - hypotensive
    - vasodilating and cardiodepressive - too much fluid in the tissues, pounding heartbeat
    - induces apoptosis -> eliminating aging and dead cells
        - help especially for post-menopausal
- Milk Thistle - Silybum marianum
    - most potent hepatoprotective
    - help the liver process toxins from any source
        - but especially chemicals
        - extended pharma use
        - survive Amanita mushroom poisoning
        - with aging, liver is slowing down, so it needs help
    - safe, can use as a food - seeds in a pepper grinder over food
    - standardized fluid extract best for people with known contaminant exposure
    - only the seeds so directly influence the liver tissues
    - but the inner pith of the stalk is edible
    - specific for hepatitis, cirrhosis, elevated bilirubin (indicator liver stuff going on)
- dosing for the elderly, start small, and work up
    - tea is a great delivery
- Ashwagandha
    - a nightshade, so warming to the body
    - for those showing cognitive decline, esp assoc with hypertension
    - supports vitality, endurance, and physical exercise tolerance
    - for nervous exhaustion, anemia, depleted and frazzled
    - forgetful because frazzled
- Turmeric
    - AI (anti-inflammatory)
    - when waste has built up and generalized pain, excellent daily tonic
    - prefer in a golden milk, spice in foods, 1T in kitcheree
    - liver support, hepatoprotective
    - suppresses Reactive Oxygen Species (free radicals)
    - Black Pepper does help it be more soluble in milk at least
    - make sure smell is good and aromatic when buying
    - 1/2 tsp in 1 cup of golden milk
- Rosemary
    - neuroprotective to the brain
    - AO (antioxidant) and AI (anti-inflammatory)
    - specific for atonic conditions of the digestive tract
    - headaches with indigestion - diff digesting proteins and fats
    - circ weakness
    - cognitive enhancer of brain dopamine levels
    - Rosmarinic acid calms the thyroid - slows conversion of T3 to T4
- Siberian Ginseng
    - increasing exercise tolerance
    - enhances concentration
    - helps to mobilize oxygen to organs and tissues
    - strengthens digestion and kidney function
    - enhances overall resistance to disease
    - the reason why we have the concept of adaptogens
        - super secret weapon for Russian athletes back in the day
    - in general, lowers lipids specifically assoc with arteriosclerosis
        - which then impairs circulation
        - supports high cholesterol
- Panax Ginseng
    - more potent, more warming
    - for nervous agitation, general weakness
    - supports stamina, appetite
    - specific for malabsorption in the elderly
    - specific for blood and tissues going more alkaline
    - asthenia - for someone who feels chilled in a warm room, fingertips cold
    - preventive for early stages of insulin-resistant diabetes
    - for depressed testosterone and low sperm count
    - hyperlipidemia
    - can overdo it - if you are already running on empty, can burn out
        - Tulsi, Rhodiola - same
        - Ashwagandha - aggravates hot bodies
        - they are there to support bodies adapting and change, not give extra energy
    - (contrast to American Ginseng)
        - for low metabolic fire
        - hyperlipidemia';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- ── MORNING: Huckleberry Herb Walk ───────────────────────────────────────
    (128,  'California Poppy - AP (aerial parts) - fresh tea with Catnip',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 10, v_morning),

    (136,  'Catnip - fresh tea with California Poppy (aerial parts)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 20, v_morning),

    (178,  'Milky Oats - myelin coating',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 30, v_morning),

    (207,  'Dead Nettle / Wood Betony (Stachys officinalis) - little purple flowers; headaches, to drain the energy; helps with embodiment, sense of self-love; Betony - Easley Monograph: rootedness and groundedness in the solar plexus; for dissociation with anxiety',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 40, v_morning),

    (2751, 'Bay (California Bay Laurel) - smell for headaches on the trail',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 50, v_morning),

    (112,  'Usnea - for hot/damp infections; immune support; heat up tincture',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 60, v_morning),

    (39,   'Figwort - cleansing pathways; edema, sluggish; skin issues',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 70, v_morning),

    (163,  'Lily of the Valley - super low dose heart medicine; FE - connecting to the angel realm',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 80, v_morning),

    (2437, 'Prunella (Self-Heal) - drain and cool the liver; affinity to brain (concussions); allergies; brain lymphatic; concussion support herbs: lion''s mane (regenerate nerves, influence cognition), rosemary, ginkgo',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 90, v_morning),

    (2632, 'Lion''s Mane (mentioned for concussion support) - regenerate nerves, influence cognition',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 100, v_morning),

    (109,  'Rosemary - mentioned for concussion support alongside lion''s mane and ginkgo',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 110, v_morning),

    (165,  'Ginkgo - mentioned for concussion support alongside lion''s mane and rosemary',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 120, v_morning),

    (579,  'Aralia (California Spikenard) - Queen of the Forest; Spikenard; connects air and water; medicinally root and berry; lungs, adaptogen - strengthens; tense and tight, can''t catch breath; plants that support our lungs connect us with everything',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Huckleberry Herb Walk', 130, v_morning),

    -- ── AFTERNOON: Herbs for Healthy Aging (tea formula) ────────────────────
    (1528, 'Tea for healthy aging includes: Jujubes, Goji berries (Chinese Lycium), Shatavari, Calendula',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Healthy Aging', 10, v_healthy),

    (1548, 'Goji berries (Wolfberry Fruit / Fructus Lycii Chinensis, Chinese Lycium species) - in healthy aging tea; American wolfberry is L. fremontii',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Healthy Aging', 20, v_healthy),

    (852,  'Shatavari - in healthy aging tea formula with Jujubes, Goji berries, Calendula',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Healthy Aging', 30, v_healthy),

    (70,   'Calendula - in healthy aging tea formula with Jujubes, Goji berries, Shatavari',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Healthy Aging', 40, v_healthy),

    -- ── Physical Changes with Aging ──────────────────────────────────────────
    (45,   'Slowing of digestion with aging -> marshmallow, etc. (demulcents to address the drying secretions of the aging body)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Physical Changes with Aging', 10, v_physical),

    (78,   'Slowing of metabolism with aging -> Licorice root; how we take nutrients from digestion, build tissues, hormones, detox',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Physical Changes with Aging', 20, v_physical),

    -- ── Accumulation ─────────────────────────────────────────────────────────
    (122,  'Dandelion root - alterative for accumulation with aging; removes waste from blood, joints, and bowels',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 10, v_accum),

    (61,   'Mullein - listed as an alterative for accumulation with aging (with question mark — uncertain role)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 20, v_accum),

    (22,   'Burdock - alterative for accumulation with aging',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 30, v_accum),

    (37,   'Yellow Dock - alterative, esp with constipation',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 40, v_accum),

    (42,   'Red Clover - alterative, esp for the elderly',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 50, v_accum),

    (206,  'Milk Thistle - alterative for accumulation with aging; listed alongside Dandelion root, Burdock, Yellow Dock, Red Clover',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 60, v_accum),

    (78,   'Licorice - alterative for accumulation (but not just an alterative)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 70, v_accum),

    (57,   'Elder - immune support for accumulation with aging',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 80, v_accum),

    (99,   'Myrrh - stimulate innate immune response; for immune support with aging and waste accumulation',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 90, v_accum),

    (26,   'Echinacea - immune support for accumulation with aging',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 100, v_accum),

    (13,   'Tulsi (Holy Basil) - adaptogen for accumulation with aging',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 110, v_accum),

    (28,   'Cleavers - Lymphagogue for accumulation with aging',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 120, v_accum),

    (39,   'Figwort - Lymphagogue for accumulation with aging',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Accumulation', 130, v_accum),

    -- ── Pancha Karma ─────────────────────────────────────────────────────────
    (225,  'Astragalus (preserved decoction) - nourishing and moistening to the tissues; contraindicated when acutely sick, good for chronic or preventative use; hypotensive; vasodilating and cardiodepressive - too much fluid in the tissues, pounding heartbeat; induces apoptosis (eliminating aging and dead cells); helps especially for post-menopausal',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 10, v_pancha),

    (1528, 'For immunity with aging: strategy is moistening while stimulating immune function — Astragalus, Jujubes, Goji Berries, Calendula, Shatavari, Echinacea and Myrrh (stimulate immune function while addressing waste accumulation)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 20, v_pancha),

    (1548, 'For immunity with aging: strategy is moistening while stimulating immune function — Astragalus, Jujubes, Goji Berries, Calendula, Shatavari, Echinacea and Myrrh (stimulate immune function while addressing waste accumulation)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 30, v_pancha),

    (70,   'For immunity with aging: strategy is moistening while stimulating immune function — Astragalus, Jujubes, Goji Berries, Calendula, Shatavari, Echinacea and Myrrh (stimulate immune function while addressing waste accumulation)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 40, v_pancha),

    (852,  'For immunity with aging: strategy is moistening while stimulating immune function — Astragalus, Jujubes, Goji Berries, Calendula, Shatavari, Echinacea and Myrrh (stimulate immune function while addressing waste accumulation)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 50, v_pancha),

    (26,   'Echinacea and Myrrh: stimulates immune function while addressing waste accumulation',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 60, v_pancha),

    (99,   'Echinacea and Myrrh: stimulates immune function while addressing waste accumulation',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 70, v_pancha),

    (206,  'Milk Thistle (Silybum marianum) - most potent hepatoprotective; helps liver process toxins from any source (especially chemicals, extended pharma use); survive Amanita mushroom poisoning; safe as food (seeds in pepper grinder); standardized fluid extract best for known contaminant exposure; only seeds directly influence liver tissues; specific for hepatitis, cirrhosis, elevated bilirubin',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 80, v_pancha),

    (20,   'Ashwagandha - a nightshade, warming; for cognitive decline associated with hypertension; supports vitality, endurance, physical exercise tolerance; for nervous exhaustion, anemia, depleted and frazzled; forgetful because frazzled',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 90, v_pancha),

    (203,  'Turmeric - anti-inflammatory; excellent daily tonic when waste has built up with generalized pain; prefer golden milk or food (1T in kitcheree, 1/2 tsp in 1 cup golden milk); liver support, hepatoprotective; suppresses Reactive Oxygen Species (free radicals); Black Pepper helps it be more soluble in milk',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 100, v_pancha),

    (2498, 'Black Pepper - helps Turmeric be more soluble in milk (enhances bioavailability of curcumin)',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 110, v_pancha),

    (109,  'Rosemary - neuroprotective to the brain; antioxidant and anti-inflammatory; specific for atonic conditions of the digestive tract; headaches with indigestion (difficulty digesting proteins and fats); circulatory weakness; cognitive enhancer of brain dopamine levels; Rosmarinic acid calms the thyroid — slows conversion of T3 to T4',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 120, v_pancha),

    (9,    'Siberian Ginseng - increases exercise tolerance; enhances concentration; mobilizes oxygen to organs and tissues; strengthens digestion and kidney function; enhances overall resistance to disease; the reason for the concept of adaptogens (Russian athletes); lowers lipids associated with arteriosclerosis',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 130, v_pancha),

    (14,   'Panax Ginseng - more potent and warming than Siberian; for nervous agitation, general weakness; supports stamina, appetite; specific for malabsorption in the elderly; for blood and tissues going more alkaline; asthenia (chilled in warm room, cold fingertips); preventive for early insulin-resistant diabetes; depressed testosterone and low sperm count; hyperlipidemia; can overdo — if already running on empty, can burn out',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 140, v_pancha),

    (13,   'Tulsi (Holy Basil) — like Panax Ginseng and Rhodiola, can overdo it if already running on empty; they support adapting and change, not giving extra energy; Ashwagandha aggravates hot bodies',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 150, v_pancha),

    (16,   'Rhodiola — like Panax Ginseng and Tulsi, can overdo it if already depleted; supports adapting and change, not extra energy',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 160, v_pancha),

    (15,   'American Ginseng — contrast to Panax Ginseng: for low metabolic fire; hyperlipidemia',
     'BHC - Class 24 - Huckleberry Herb Walk and Healthy Aging', 'personal', 'Pancha Karma', 170, v_pancha);

END $$;

-- ── Keywords ─────────────────────────────────────────────────────────────────
-- New ailment keywords: 'concussion', 'dissociation', 'allergies'
-- New action keywords: 'neuroprotective'
-- New general keywords: 'healthy aging'

INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Morning herbs
  (128,  'sleep support',       'ailment'),   -- California Poppy
  (128,  'anxiety',             'ailment'),
  (136,  'digestive health',    'ailment'),   -- Catnip
  (136,  'anxiety',             'ailment'),
  (178,  'nervous system',      'action'),    -- Milky Oats (myelin coating)
  (207,  'headache',            'ailment'),   -- Wood Betony
  (207,  'anxiety',             'ailment'),
  (207,  'dissociation',        'ailment'),
  (2751, 'headache',            'ailment'),   -- California Bay Laurel
  (112,  'immune support',      'ailment'),   -- Usnea
  (112,  'infection',           'action'),
  (39,   'edema',               'ailment'),   -- Figwort
  (39,   'skin conditions',     'ailment'),
  (39,   'lymphatic support',   'ailment'),
  (163,  'cardiovascular disease', 'ailment'), -- Lily of the Valley
  (2437, 'liver support',       'ailment'),   -- Self Heal
  (2437, 'concussion',          'ailment'),
  (2437, 'allergies',           'ailment'),
  (2437, 'lymphatic support',   'ailment'),
  (2632, 'concussion',          'ailment'),   -- Lion's Mane
  (2632, 'cognitive support',   'ailment'),
  (2632, 'neuroprotective',     'action'),
  (109,  'concussion',          'ailment'),   -- Rosemary (morning)
  (109,  'cognitive support',   'ailment'),
  (109,  'neuroprotective',     'action'),
  (165,  'concussion',          'ailment'),   -- Ginkgo
  (165,  'cognitive support',   'ailment'),
  (165,  'neuroprotective',     'action'),
  (579,  'chronic lung disease','ailment'),   -- California Spikenard
  (579,  'adaptogen',           'action'),
  -- Healthy aging tea
  (1528, 'immune support',      'ailment'),   -- Jujube
  (1528, 'healthy aging',       'general'),
  (1548, 'immune support',      'ailment'),   -- Wolfberry Fruit (Goji)
  (1548, 'healthy aging',       'general'),
  (852,  'immune support',      'ailment'),   -- Shatavari
  (852,  'healthy aging',       'general'),
  (70,   'immune support',      'ailment'),   -- Calendula
  (70,   'healthy aging',       'general'),
  -- Physical changes
  (45,   'digestive health',    'ailment'),   -- Marshmallow
  (78,   'digestive health',    'ailment'),   -- Licorice
  (78,   'metabolic syndrome',  'ailment'),
  -- Accumulation (alteratives)
  (122,  'blood cleansing',     'ailment'),   -- Dandelion root
  (61,   'blood cleansing',     'ailment'),   -- Mullein
  (22,   'blood cleansing',     'ailment'),   -- Burdock
  (37,   'blood cleansing',     'ailment'),   -- Yellow Dock
  (37,   'constipation',        'ailment'),
  (42,   'blood cleansing',     'ailment'),   -- Red Clover
  (206,  'liver support',       'ailment'),   -- Milk Thistle
  (206,  'blood cleansing',     'ailment'),
  (57,   'immune support',      'ailment'),   -- Elder
  (99,   'immune support',      'ailment'),   -- Myrrh
  (26,   'immune support',      'ailment'),   -- Echinacea
  (13,   'adaptogen',           'action'),    -- Tulsi
  (13,   'stress',              'ailment'),
  (28,   'lymphatic support',   'ailment'),   -- Cleavers
  (39,   'lymphatic support',   'ailment'),   -- Figwort (already above, ON CONFLICT handles)
  -- Pancha Karma herbs
  (225,  'immune support',      'ailment'),   -- Astragalus
  (225,  'immune deficiency',   'ailment'),
  (225,  'post-menopause',      'ailment'),
  (225,  'healthy aging',       'general'),
  (206,  'hepatitis',           'ailment'),   -- Milk Thistle (Pancha Karma)
  (206,  'healthy aging',       'general'),
  (20,   'cognitive support',   'ailment'),   -- Ashwagandha
  (20,   'hypertension',        'ailment'),
  (20,   'anemia',              'ailment'),
  (20,   'fatigue',             'ailment'),
  (20,   'healthy aging',       'general'),
  (203,  'inflammation',        'ailment'),   -- Turmeric
  (203,  'liver support',       'ailment'),
  (203,  'chronic pain',        'ailment'),
  (203,  'healthy aging',       'general'),
  (109,  'headache',            'ailment'),   -- Rosemary (Pancha Karma)
  (109,  'digestive health',    'ailment'),
  (109,  'hyperthyroidism',     'ailment'),
  (109,  'healthy aging',       'general'),
  (9,    'fatigue',             'ailment'),   -- Siberian Ginseng
  (9,    'circulation',         'ailment'),
  (9,    'hyperlipidemia',      'ailment'),
  (9,    'adaptogen',           'action'),
  (9,    'healthy aging',       'general'),
  (14,   'malabsorption',       'ailment'),   -- Panax Ginseng
  (14,   'insulin resistance',  'ailment'),
  (14,   'hyperlipidemia',      'ailment'),
  (14,   'low testosterone',    'ailment'),
  (14,   'cognitive support',   'ailment'),
  (14,   'healthy aging',       'general'),
  (13,   'healthy aging',       'general'),   -- Tulsi (Pancha Karma)
  (16,   'fatigue',             'ailment'),   -- Rhodiola
  (16,   'stress',              'ailment'),
  (16,   'adaptogen',           'action'),
  (15,   'hyperlipidemia',      'ailment')    -- American Ginseng
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ── Ailment search synonyms (new keywords only) ──────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('concussion',   ARRAY['traumatic brain injury', 'TBI', 'mild traumatic brain injury', 'mTBI', 'head injury', 'brain injury']),
  ('dissociation', ARRAY['dissociative disorder', 'depersonalization', 'derealization', 'feeling ungrounded', 'emotional disconnection', 'dissociative episode']),
  ('allergies',    ARRAY['allergic reaction', 'allergy', 'hypersensitivity', 'atopic', 'allergic response', 'seasonal allergy', 'food allergy'])
ON CONFLICT (ailment_keyword) DO NOTHING;
