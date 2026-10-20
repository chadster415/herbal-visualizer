-- Migration 429: Class 1 — Introduction & Bancroft Garden Walk (Ashley / Claire)
-- Files parsed:
--   - BHC - Class 1 - Ashley Claire.md (personal notes)
-- No generated notes file exists for this class.
--
-- Normalizations applied:
--   - "Mexican Marigold" → Mexican Marigold (id=2756, Tagetes lucida — added in migration 428)
--   - "catnip" → Catnip (id=136)
--   - "tulsi" → Holy Basil (id=13, Ocimum sanctum)
--   - "Self-heal" → Self Heal (id=2437, Prunella vulgaris)
--   - "Silk tassel bush" → Silk Tassel (id=853, Garrya fremontii)
--   - "Cleavers / Gallium aperine" → Cleavers (id=28, Galium aparine — note: notes misspell as Gallium)
--   - "Raspberry Leaf" → Raspberry (id=155, Rubus idaeus, leaf)
--   - "oat straw" → Oat straw (id=2287)
--   - "nettles / Urtica dioica" → Nettle leaf (id=43) + Nettle root (id=1649) as separate snippets
--   - "Rose hips" → Rose hips (id=849); "Rose petals" → Rose petals (id=850)
--   - "alfalfa" → Alfalfa (id=885)
--   - "red clover" → Red Clover (id=42)
--
-- Skipped (not herb/supplement entries):
--   - Miner's lettuce: wild edible green, no medicinal indication given; not in herbs DB
--   - Mulberry: no medicinal info given
--   - Fig leaf tea: no medicinal info given ("tastes like coconut")
--
-- New ailment keywords added: "restless leg syndrome", "grief support"
-- Merge decisions:
--   - "vaginal cramps" → dysmenorrhea (existing)
--   - "brain lymph" → no standalone keyword; captured under "concussion" + "lymphatic support"
--   - "candida" → fungal infection (existing)

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 1 - Ashley Claire') THEN
    RAISE NOTICE 'Class 1 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- =========================================================
  -- CLASS OPENING (morning — Mexican Marigold ceremony)
  -- =========================================================

  (2756,
   'Mexican Marigold (Tagetes lucida) — sat with as the class opening herb, described as a grandmother plant embodying "healing the healer." Primary medicinal use: digestive, as a tea or bath.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Class Opening', 10,
   '- sat with Mexican Marigold - grandmother plant
    - healing the healer
    - digestive - tea, bath'),

  -- =========================================================
  -- BANCROFT GARDEN WALK (afternoon — Claire)
  -- =========================================================

  (134,
   'Lemon Balm — mildly uplifting nervine combined with catnip and tulsi (Holy Basil) as a mild antiviral trio. Always cover infusions to trap volatile oils.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 20,
   '## Walk to Bancroft
- Nervines
    - Lemon Balm - mildly uplifting + catnip + tulsi / mild antiviral
    - Catnip
        - both calming anxiety
        - volatile oils -> move things around after meals, "carminatives"
    - always cover your infusions - volatile oils trapped
- Valerian - sleep
- Self-heal - lymphatic, specific for brain lymph (concussion)
- Peppermint - nausea, digestion, bloating
- California Poppy - antidote to over-caffeinated + catnip (tincture)
- Thyme - steam, open up lungs
- Mullein - lungs, similar to thyme, moistening, soothing (tea)
    - essence, tincture - "guiding light" (mullein torch)
- Bush -> Silk tassel bush
    - only the male shrubs flower
    - spasm of smooth muscle
        - intestines
        - vaginal cramps
        - maybe restless leg
- Cleavers - sticky like velcro
    - spring green
    - Gallium aperine
    - lymphatic, esp tonsils
    - great full-body lymphatic tonic - strainer for your body
    - blend in blender, squeeze, preserve in alcohol or freeze
- Chickweed - itchy, skin irritation
    - infused oil, salve
    - tincture not great for skin, alcohol drying
- Miner''s lettuce - Vit C (miners needed it)
- Yarrow - feathery leaves
    - helpful for boundaries, thickening the emotional membrane
    - gentle, energetic bubble (before clients)
    - Achillea millefolium
    - styptic - stops bleeding, yarrow powder stops bleeding
    - antimicrobial
    - emmenagogue - stimulate menstruation (if already on the way)
        - compare to mugwort
- Linden - winnie the pooh world
    - children who can''t sleep
    - heart-shaped leaves
    - lowers blood pressure
    - soothes grief, modulator of emotions -> lower extra, or raise too low
- Plantain - broad leaf = Plantago major
    - first aid, like Yarrow
    - pulls out bee stings with tannins
    - splinters
    - vulnerary, speeds up wound healing
    - internal for chronic digestive issues; GI inflammation
    - tonifier for intestines
    - plantain + calendula -> gut health infusion
- Mulberry
- Fig leaf tea - tastes like coconut
- Borage - nice flower essence for courage, strength
    - associated with Jupiter
- Artichoke
    - a lot of herbal bitters blends contain this
    - stimulate digestion, wakes up the stomach
    - leaf -> high cholesterol & blood pressure
    - nice as a glycerite
- Fennel - smells like licorice, anise
    - use the seeds
    - found everywhere
    - carminative, good for bloating, gas
    - good for babies, farting
    - lactating mothers, gets into baby that way
- Rosemary - volatile oils
    - open sinuses
    - grounding, resilience
    - ceremonial burns
    - cerebral stimulant - brain fog, memory issues, brain blood flow
    - connecting with ancestors and memory
    - Rosmarinus - "dew of the sea"
    - good tea, even though savory
    - head, but still very grounding
- Raspberry Leaf - uterine tonic, but requires infusion every day
    - rich in minerals, like nettle
    - tea extracts the minerals, alcohol doesn''t
    - stress depletes mineral
        - raspberry, oat straw, alfalfa, red clover, lemon balm
- Oregano - very antimicrobial
    - oil capsules
    - recurrent infections - SIBO, candida
    - respiratory tea steam
- Nettles - Urtica dioica
    - "urtification" - whacking with it for arthritis, etc
    - every amino acid = full protein
        - Magnesium, Vit K, Calcium, Vit C
    - for anyone who is depleted, stressed, illness
    - seeds for kidney, root for benign prostate inflammation, any abnormal testosterone levels, excess androgens
    - associated with Mars
- Rose - hips and petals
    - petals = tannins
    - astringent = tonifying
    - chronic IBS, diarrhea
    - incredible heart herb
    - thorns = protective, keep heart open but have boundaries
    - Rose hips = cooling and anti-inflammatory (but match to constitution), Vitamin C'),

  (136,
   'Catnip — calms anxiety; volatile oils move things around after meals (carminative). Always cover infusions to trap volatile oils. Tincture combined with California Poppy for over-caffeination.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 30,
   '## Walk to Bancroft
- Nervines
    - Lemon Balm - mildly uplifting + catnip + tulsi / mild antiviral
    - Catnip
        - both calming anxiety
        - volatile oils -> move things around after meals, "carminatives"
    - always cover your infusions - volatile oils trapped
- California Poppy - antidote to over-caffeinated + catnip (tincture)'),

  (13,
   'Tulsi (Holy Basil) — mildly uplifting nervine combined with lemon balm and catnip; mild antiviral properties.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 40,
   '## Walk to Bancroft
- Nervines
    - Lemon Balm - mildly uplifting + catnip + tulsi / mild antiviral
    - always cover your infusions - volatile oils trapped'),

  (145,
   'Valerian — sleep.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 50,
   '- Valerian - sleep'),

  (2437,
   'Self-heal — lymphatic herb; specifically indicated for brain lymph drainage, particularly after concussion.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 60,
   '- Self-heal - lymphatic, specific for brain lymph (concussion)'),

  (55,
   'Peppermint — nausea, digestion, bloating.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 70,
   '- Peppermint - nausea, digestion, bloating'),

  (128,
   'California Poppy — antidote to over-caffeination; combined with catnip as a tincture.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 80,
   '- California Poppy - antidote to over-caffeinated + catnip (tincture)'),

  (59,
   'Thyme — steam to open up the lungs.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 90,
   '- Thyme - steam, open up lungs'),

  (61,
   'Mullein — moistening and soothing for the lungs (tea); similar to thyme. Also used as essence/tincture, referred to as a "guiding light" (the mullein torch).',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 100,
   '- Mullein - lungs, similar to thyme, moistening, soothing (tea)
    - essence, tincture - "guiding light" (mullein torch)'),

  (853,
   'Silk Tassel bush — only the male shrubs flower. Indicated for spasm of smooth muscle: intestines, vaginal cramps, and possibly restless leg.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 110,
   '- Bush -> Silk tassel bush
    - only the male shrubs flower
    - spasm of smooth muscle
        - intestines
        - vaginal cramps
        - maybe restless leg'),

  (28,
   'Cleavers (Galium aparine) — sticky like velcro; spring green. Lymphatic herb especially for tonsils; great full-body lymphatic tonic — "strainer for your body." Preparation: blend fresh in a blender, squeeze, preserve in alcohol or freeze.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 120,
   '- Cleavers - sticky like velcro
    - spring green
    - Gallium aperine
    - lymphatic, esp tonsils
    - great full-body lymphatic tonic - strainer for your body
    - blend in blender, squeeze, preserve in alcohol or freeze'),

  (88,
   'Chickweed — itchy skin and skin irritation. Best as infused oil or salve; tincture not recommended for skin use (alcohol is drying).',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 130,
   '- Chickweed - itchy, skin irritation
    - infused oil, salve
    - tincture not great for skin, alcohol drying'),

  (44,
   'Yarrow (Achillea millefolium) — helpful for boundaries, thickening the emotional membrane; gentle energetic bubble before client sessions. Styptic — stops bleeding (yarrow powder applied directly). Antimicrobial. Emmenagogue — stimulates menstruation if already on the way; compare to mugwort.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 140,
   '- Yarrow - feathery leaves
    - helpful for boundaries, thickening the emotional membrane
    - gentle, energetic bubble (before clients)
    - Achillea millefolium
    - styptic - stops bleeding, yarrow powder stops bleeding
    - antimicrobial
    - emmenagogue - stimulate menstruation (if already on the way)
        - compare to mugwort'),

  (115,
   'Mugwort — emmenagogue; compared to yarrow for stimulating menstruation.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 150,
   '- Yarrow - emmenagogue - stimulate menstruation (if already on the way)
        - compare to mugwort'),

  (90,
   'Linden — for children who can''t sleep. Heart-shaped leaves. Lowers blood pressure. Soothes grief; modulator of emotions — lowers excess or raises deficiency.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 160,
   '- Linden - winnie the pooh world
    - children who can''t sleep
    - heart-shaped leaves
    - lowers blood pressure
    - soothes grief, modulator of emotions -> lower extra, or raise too low'),

  (85,
   'Plantain (Plantago major) — first aid herb like Yarrow. Pulls out bee stings with tannins; also draws out splinters. Vulnerary — speeds up wound healing. Internal use for chronic digestive issues and GI inflammation; tonifier for intestines. Plantain + calendula → gut health infusion.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 170,
   '- Plantain - broad leaf = Plantago major
    - first aid, like Yarrow
    - pulls out bee stings with tannins
    - splinters
    - vulnerary, speeds up wound healing
    - internal for chronic digestive issues; GI inflammation
    - tonifier for intestines
    - plantain + calendula -> gut health infusion'),

  (69,
   'Borage — nice flower essence for courage and strength. Associated with Jupiter.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 180,
   '- Borage - nice flower essence for courage, strength
    - associated with Jupiter'),

  (172,
   'Artichoke — found in many herbal bitters blends; stimulates digestion and wakes up the stomach. Leaf used for high cholesterol and blood pressure. Also nice as a glycerite.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 190,
   '- Artichoke
    - a lot of herbal bitters blends contain this
    - stimulate digestion, wakes up the stomach
    - leaf -> high cholesterol & blood pressure
    - nice as a glycerite'),

  (76,
   'Fennel — smells like licorice/anise; use the seeds. Found everywhere. Carminative for bloating and gas. Good for babies (farting). For lactating mothers — carminative action gets into breast milk and reaches the baby.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 200,
   '- Fennel - smells like licorice, anise
    - use the seeds
    - found everywhere
    - carminative, good for bloating, gas
    - good for babies, farting
    - lactating mothers, gets into baby that way'),

  (109,
   'Rosemary — volatile oils; opens sinuses. Grounding and resilient. Used in ceremonial burns. Cerebral stimulant for brain fog, memory issues, and brain blood flow. Rosmarinus = "dew of the sea." Good as a tea even though it is a savory herb; head-focused but still grounding.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 210,
   '- Rosemary - volatile oils
    - open sinuses
    - grounding, resilience
    - ceremonial burns
    - cerebral stimulant - brain fog, memory issues, brain blood flow
    - connecting with ancestors and memory
    - Rosmarinus - "dew of the sea"
    - good tea, even though savory
    - head, but still very grounding'),

  (155,
   'Raspberry leaf — uterine tonic requiring daily infusion. Rich in minerals like nettle. Tea extracts minerals; alcohol does not. Stress depletes minerals — combine raspberry leaf with oat straw, alfalfa, red clover, and lemon balm for mineral-depleted states.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 220,
   '- Raspberry Leaf - uterine tonic, but requires infusion every day
    - rich in minerals, like nettle
    - tea extracts the minerals, alcohol doesn''t
    - stress depletes mineral
        - raspberry, oat straw, alfalfa, red clover, lemon balm'),

  (2287,
   'Oat straw — mineral-rich nervine; part of the stress-depletion mineral formula alongside raspberry leaf, alfalfa, red clover, and lemon balm.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 230,
   '- Raspberry Leaf - rich in minerals, like nettle
    - tea extracts the minerals, alcohol doesn''t
    - stress depletes mineral
        - raspberry, oat straw, alfalfa, red clover, lemon balm'),

  (885,
   'Alfalfa — mineral-rich herb; part of the stress-depletion mineral formula alongside raspberry leaf, oat straw, red clover, and lemon balm.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 240,
   '- Raspberry Leaf - rich in minerals, like nettle
    - stress depletes mineral
        - raspberry, oat straw, alfalfa, red clover, lemon balm'),

  (42,
   'Red Clover — mineral-rich herb; part of the stress-depletion mineral formula alongside raspberry leaf, oat straw, alfalfa, and lemon balm.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 250,
   '- Raspberry Leaf - rich in minerals, like nettle
    - stress depletes mineral
        - raspberry, oat straw, alfalfa, red clover, lemon balm'),

  (406,
   'Oregano — very antimicrobial. Used as oil capsules for recurrent infections including SIBO and candida. Also as a respiratory tea steam.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 260,
   '- Oregano - very antimicrobial
    - oil capsules
    - recurrent infections - SIBO, candida
    - respiratory tea steam'),

  (43,
   'Nettle leaf (Urtica dioica) — "urtification" (whacking with the fresh plant) used for arthritis. Every amino acid present — a complete protein. Contains Magnesium, Vitamin K, Calcium, and Vitamin C. For anyone who is depleted, stressed, or ill. Nettle seeds used for kidney support.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 270,
   '- Nettles - Urtica dioica
    - "urtification" - whacking with it for arthritis, etc
    - every amino acid = full protein
        - Magnesium, Vit K, Calcium, Vit C
    - for anyone who is depleted, stressed, illness
    - seeds for kidney, root for benign prostate inflammation, any abnormal testosterone levels, excess androgens
    - associated with Mars'),

  (1649,
   'Nettle root — indicated for benign prostate inflammation, any abnormal testosterone levels, and excess androgens.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 280,
   '- Nettles - Urtica dioica
    - seeds for kidney, root for benign prostate inflammation, any abnormal testosterone levels, excess androgens'),

  (850,
   'Rose petals — contain tannins; astringent/tonifying action. Useful for chronic IBS and diarrhea. Described as an incredible heart herb. Thorns = protective, keep the heart open but maintain boundaries.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 290,
   '- Rose - hips and petals
    - petals = tannins
    - astringent = tonifying
    - chronic IBS, diarrhea
    - incredible heart herb
    - thorns = protective, keep heart open but have boundaries'),

  (849,
   'Rose hips — cooling and anti-inflammatory (but match to constitution). High in Vitamin C.',
   'BHC - Class 1 - Ashley Claire', 'personal', 'Bancroft Garden Walk', 300,
   '- Rose hips = cooling and anti-inflammatory (but match to constitution), Vitamin C');

END $$;

-- =========================================================
-- KEYWORDS
-- =========================================================

-- Mexican Marigold
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2756, 'carminative',     'action'),
  (2756, 'digestive health','ailment'),
  (2756, 'antispasmodic',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lemon Balm
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (134, 'antiviral',              'action'),
  (134, 'anxiety',                'ailment'),
  (134, 'nervine',                'action'),
  (134, 'mineral support',        'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Catnip
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (136, 'anxiety',        'ailment'),
  (136, 'carminative',    'action'),
  (136, 'bloating',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Holy Basil / Tulsi
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (13, 'antiviral',  'action'),
  (13, 'anxiety',    'ailment'),
  (13, 'nervine',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Valerian
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (145, 'sleep support', 'ailment'),
  (145, 'hypnotic',      'action'),
  (145, 'sedative',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Self-heal
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2437, 'lymphatic support', 'ailment'),
  (2437, 'concussion',        'ailment'),
  (2437, 'lymphatic',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Peppermint
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (55, 'nausea',          'ailment'),
  (55, 'bloating',        'ailment'),
  (55, 'digestive health','ailment'),
  (55, 'carminative',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Poppy
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128, 'stress',   'ailment'),
  (128, 'anxiety',  'ailment'),
  (128, 'nervine',  'action'),
  (128, 'sedative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Thyme
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (59, 'respiratory congestion', 'ailment'),
  (59, 'antimicrobial',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mullein
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (61, 'respiratory congestion', 'ailment'),
  (61, 'chronic lung disease',   'ailment'),
  (61, 'demulcent',              'action'),
  (61, 'pectoral',               'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Silk Tassel
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (853, 'muscle spasms',          'ailment'),
  (853, 'dysmenorrhea',           'ailment'),
  (853, 'restless leg syndrome',  'ailment'),
  (853, 'antispasmodic',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cleavers
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (28, 'lymphatic support', 'ailment'),
  (28, 'lymphatic',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chickweed
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (88, 'skin conditions', 'ailment'),
  (88, 'eczema',          'ailment'),
  (88, 'antipruritic',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yarrow
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44, 'wound healing', 'ailment'),
  (44, 'antimicrobial', 'action'),
  (44, 'emmenagogue',   'action'),
  (44, 'styptic',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mugwort
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (115, 'emmenagogue',         'action'),
  (115, 'menstrual irregularity','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Linden
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (90, 'sleep support',         'ailment'),
  (90, 'hypertension',          'ailment'),
  (90, 'grief support',         'ailment'),
  (90, 'nervous system support','ailment'),
  (90, 'nervine',               'action'),
  (90, 'hypotensive',           'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Plantain
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (85, 'wound healing', 'ailment'),
  (85, 'GI inflammation','ailment'),
  (85, 'vulnerary',     'action'),
  (85, 'astringent',    'action'),
  (85, 'digestive tonic','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Artichoke
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (172, 'digestive health', 'ailment'),
  (172, 'hyperlipidemia',   'ailment'),
  (172, 'hypertension',     'ailment'),
  (172, 'liver support',    'ailment'),
  (172, 'bile flow',        'ailment'),
  (172, 'bitter',           'action'),
  (172, 'cholagogue',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Fennel
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (76, 'carminative',      'action'),
  (76, 'bloating',         'ailment'),
  (76, 'colic',            'ailment'),
  (76, 'lactation support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rosemary
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'brain fog',           'ailment'),
  (109, 'memory support',      'ailment'),
  (109, 'cognitive support',   'ailment'),
  (109, 'circulation',         'ailment'),
  (109, 'respiratory congestion','ailment'),
  (109, 'nootropic',           'action'),
  (109, 'circulatory stimulant','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Raspberry leaf
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (155, 'uterine tonic',  'ailment'),
  (155, 'mineral support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oat straw
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2287, 'mineral support',        'ailment'),
  (2287, 'nervous system support', 'ailment'),
  (2287, 'stress',                 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alfalfa
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (885, 'mineral support', 'ailment'),
  (885, 'nutritive',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Clover
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (42, 'mineral support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oregano
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (406, 'antimicrobial',         'action'),
  (406, 'SIBO',                  'ailment'),
  (406, 'fungal infection',      'ailment'),
  (406, 'respiratory congestion','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle leaf
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43, 'mineral support', 'ailment'),
  (43, 'fatigue',         'ailment'),
  (43, 'energy support',  'ailment'),
  (43, 'arthritis',       'ailment'),
  (43, 'nutritive',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1649, 'BPH',              'ailment'),
  (1649, 'prostate health',  'ailment'),
  (1649, 'hyperandrogenism', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose petals
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (850, 'diarrhea',   'ailment'),
  (850, 'IBS',        'ailment'),
  (850, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose hips
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (849, 'inflammation',  'ailment'),
  (849, 'immune support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- =========================================================
-- AILMENT SEARCH TERMS (new ailment keywords only)
-- =========================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('restless leg syndrome', ARRAY['restless legs', 'RLS', 'Willis-Ekbom disease', 'leg restlessness', 'nighttime leg movements', 'restless limb']),
  ('grief support',         ARRAY['grief', 'bereavement', 'emotional grief', 'sorrow', 'loss support', 'heartache', 'mourning'])
ON CONFLICT (ailment_keyword) DO NOTHING;
