-- Migration 275: BHC Class 40 — Musculoskeletal I and II
-- Snippets, keywords, and ailment search terms
--
-- Files parsed:
--   BHC - Class 40 - Musculoskeletal I and II - Lisa.md  (personal notes, note_type='personal')
--   No Generated Notes file exists for this class.
--
-- Normalisations applied:
--   "SJW" → St. John's Wort (herb_id 81)
--   "cal poppy" / "California Poppy" → California Poppy (herb_id 128)
--   "OGR" / Oregon Grape Root → Oregon Grape (herb_id 33)
--   "dand leaf" → Dandelion leaf (herb_id 1648)
--   "milky oats" → Oat milky oats (herb_id 178)
--   "Baical Skullcap" → Chinese Skullcap (herb_id 2274, Scutellaria baicalensis)
--   "skullcap" in nervine context → Skullcap (herb_id 142, Scutellaria lateriflora)
--   "reishi" → Reishi Mushroom (herb_id 11)
--   "licorice root" / "licorice" → Licorice (herb_id 78)
--   "Solomon's Seal" → Solomon's Seal (herb_id 1252)
--   "orange peel" → Sweet Orange (herb_id 748)
--   Calcium → supplement_id 15 | Vitamin D → supplement_id 11
--
-- Herbs skipped (not in DB):
--   Japanese Knotweed (Reynoutria japonica) — no DB entry
--   Pedicularis spp. — no DB entry (parasitic plant, wild-only)
--   Goji berries — food context, no DB entry
--   "citrus" (generic) — too vague to map
--
-- Keyword merges:
--   "menstrual cramps" → dysmenorrhea (existing)
--   "muscle cramps" → muscle spasms (existing)
--   "insomnia" → sleep support (existing)
--   "carpal tunnel syndrome" → repetitive use injuries (new umbrella)
--   "phantom pain" → nerve pain (new)
--   "scleroderma / lupus / MS / myasthenia gravis" → connective tissue disorders (new umbrella)

SET search_path TO herbal, public;

-- ============================================================
-- SNIPPETS
-- ============================================================
DO $$
DECLARE
  cn  text := 'BHC - Class 40 - Musculoskeletal I and II';

  src_calcium text;
  src_vitd    text;
  src_cp      text;
  src_ra      text;
  src_hibiscus  text;
  src_calpoppy  text;
  src_sjw       text;
  src_gotukola  text;
  src_solomon   text;
  src_bcohosh   text;
  src_kava      text;
  src_jdog      text;
  src_willow    text;
  src_valerian  text;
  src_sleep     text;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = 'BHC - Class 40 - Musculoskeletal I and II') THEN
    RAISE NOTICE 'Class 40 snippets already loaded, skipping';
    RETURN;
  END IF;

  src_calcium := $blk$### Calcium Metabolism
- calcium responsible for muscle tone, contraction
- supplements usually not the best form, food usually better
- lemon balm = calcium rich = tea better than tincture$blk$;

  src_vitd := $blk$### Vitamin D
- regulation of insulin secretion
- control of cell proliferation
- stimulation of cell differentiation
- induction of apoptosis
- regulation of muscle calcium transport
- growth and bone mineralization
- regulation of immune function
- regulation of phos and calcium homeostasis
- 75 or 80 is optimum
- 3000 IU good for long term$blk$;

  src_cp := $blk$### Chronic Pain
- common causes: systemic inflammation, nutrient deficiencies, toxic accumulation, blood stagnation, structural imbalance, digestive disturbance, stealth viruses
- stealth viruses: herpes, Epstein-Barr, Covid/long covid
- Steven Buehner's work for long covid: Baical Skullcap, Salvia rhiz / Reg Sage, Reishi, Licorice, Red root, Japanese Knotweed
- cilia desiccates in long covid — tissues get overwhelmed; cilia isn't removing stuff; mast cells lock down (overwhelm) and don't respond effectively; amyloid plaque filters into the bloodstream
- = achy body$blk$;

  src_ra := $blk$### Herbal actions (rheumatoid arthritis)
- AI (anti-inflammatory): turmeric, fresh ginger, SJW — oilination of affected areas and adjacent, and internal
- Alterative: dandelion leaf and root, burdock (internal), yellow dock
- AO (antioxidant) — the waste is oxidative, buffer the blood from it: cranberry, rose hips, goji berries, citrus
- Circulatory — promote lymph circulation, not blood: cleavers, red root, poke (low dose)
- Analgesic (topical): hops, cannabis, willow
- Diuretics — drain synovial fluid: dandelion leaf, nettle
- Nervines: passionflower, milky oats, skullcap, cal poppy
- Digestive bitters and carminatives: dandelion root, yellow dock, gentian, orange peel, fennel, cardamom
- Hepatic: yellow dock, licorice, OGR, milk thistle
- Immune modulator: echinacea
- Main point: immune modulation and waste elimination$blk$;

  src_hibiscus := $blk$#### Hibiscus sabdariffa
- diuretic
- AO (antioxidant)
- musculoskeletal: anthocyanins stimulate myogenesis, protect mitochondria, stimulate muscle protein synthesis, protect against muscle degradation
- excellent for metabolic disorders in general — where tissues are starting to degrade, loss of circulation in lower extremities; PCOS → PMOS
- cardioprotective
- supportive of hyaluronan production in the extracellular matrix — helps prevent expansion of hyaluronidase, which degrades cell membranes
- great as a wound wash
- internally for ulcers
- lowers blood pressure as a diuretic (if on the edge)
- formulate with marshmallow (glycerite) or other demulcent$blk$;

  src_calpoppy := $blk$#### California Poppy
- specifically for smooth and skeletal muscles
- low grade chronic pain
- menstrual cramps
- muscle cramps & spasms$blk$;

  src_sjw := $blk$#### St. John's Wort (SJW)
- mostly a neuroprotective plant — nerve endings
- use a lot for sciatica
- generally anti-inflammatory
- inhibit prostaglandin
- decrease amyloid reactive oxygen species (connected to Alzheimer's)
- pretty high doses for long term chronic pain issues
- especially if picture of viruses
- AI to the gut
- lots of drug interactions at therapeutic doses: steroid contraceptives, cardiac drugs, some anticancer drugs, some immunosuppressives, some anti-hypertensives, benzodiazepines, HIV, anticoagulants, SSRI, 1 antifungal$blk$;

  src_gotukola := $blk$#### Gotu Kola
- grassy taste
- cerebral circulation tonic
- connective tissue tonic
- primary herb in: scleroderma, lupus, myasthenia gravis, MS, general neuromuscular and muscular wasting conditions
- pillar of formula in repro realm: dysfunctional extracellular matrix
- supporting the fluid and tissue in the synovial capsule$blk$;

  src_solomon := $blk$#### Solomon's Seal
- tincture and decoction, no oil
- specifically acts on collagen and cartilage
- nutritive to tendons and ligaments
- prevents and removes swelling on bone after injury
- supportive for bone spurs
- Repetitive Use Injuries such as carpal tunnel syndrome
- arthritis associated with old injuries
- calcifications — build up of calcium on bone/joints
- muscular and skeletal tensions in general
- Matt Wood: "indispensable musculoskeletal remedy"
- maybe take a week off every 2 months (in long term use) to let your body find new normal$blk$;

  src_bcohosh := $blk$#### Black Cohosh
- influences estrogen but not directly at estrogen receptor sites
- specific for dull, aching, muscular pain and acute inflammatory rheumatic pains
- THE rheumatoid arthritis remedy
- observed to have influence on bone mineral loss (osteoporosis, osteopenia)
- used for anxiety, tension headaches, fibromyalgia pain
- associated with people with intrusive negative thoughts, in association with pain
- serotonin agonist — serotonin responsible for melatonin and estrogen
- severe dysmenorrhea and post-menopausal bodies
- mostly used now for body pain, not really repro stuff$blk$;

  src_kava := $blk$#### Kava
- one of the very few skeletal muscle relaxants that rivals Pedicularis (only in the wild, parasitic plant)
- nervine that helps with sleep
- antispasmodic — muscle cramps$blk$;

  src_jdog := $blk$#### Jamaican Dogwood ("Florida fish poison tree")
- generally specific for smooth muscle pain
- phantom pains (amputations)
- insomnia with spasms
- nervous irritability
- tachycardia
- general body pains
- sedative (by degrees, different perspectives)
- pretty well tolerated, no side effects
- targets face pain
- pairs well with AI to reduce sensation of pain: willow or meadowsweet
- pairs well with recent injury: wild lettuce or kava
- insomnia due to body aches: hops or skullcap
- skeletal pain: black cohosh, pedicularis$blk$;

  src_willow := $blk$#### White Willow
- specific as analgesic, anti-inflammatory
- useful for rheumatism, gout, headaches, aches and pains of all kinds
- AI for arthritis — mostly effective as a decoction for the hydrophilic salicylic acid
- decoction + baking soda = buffered acid
- astringent as tincture, but analgesic as a decoction$blk$;

  src_valerian := $blk$#### Valerian
- huge difference between fresh and dried tincture
- mild pain reliever
- relieves body of tension
- antispasmodic for smooth or skeletal muscles
- nervine and sedative
- can cause heart palpitations in some (dry people) — can pair with California Poppy to ease that possibility$blk$;

  src_sleep := $blk$Lisa: Nutmeg in milk with Ashwagandha — sleep
Lisa: Wild lettuce tea — sleep$blk$;

  -- ---- HERB SNIPPETS ----
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- CALCIUM METABOLISM
  (134, 'lemon balm = calcium rich = tea better than tincture', cn, 'personal', 'Calcium Metabolism', 10, src_calcium),

  -- CHRONIC PAIN — long covid / stealth virus protocol
  (2274, 'Baical Skullcap — Steven Buehner''s protocol for long covid and stealth viruses; cilia desiccates in long covid, mast cells lock down, amyloid plaque enters bloodstream → achy body and chronic pain', cn, 'personal', 'Chronic Pain', 10, src_cp),
  (56,   'Salvia [rhiz] / Reg Sage — Steven Buehner''s long covid protocol for stealth viral infections causing chronic pain', cn, 'personal', 'Chronic Pain', 20, src_cp),
  (11,   'Reishi — Steven Buehner''s long covid protocol; for stealth viral infections causing chronic pain and achy body', cn, 'personal', 'Chronic Pain', 30, src_cp),
  (78,   'Licorice — Steven Buehner''s long covid protocol; for stealth viral infections causing chronic pain', cn, 'personal', 'Chronic Pain', 40, src_cp),
  (981,  'Red Root — Steven Buehner''s long covid protocol; lymphatic clearance in chronic pain from stealth viral infections', cn, 'personal', 'Chronic Pain', 50, src_cp),

  -- RHEUMATOID ARTHRITIS — herbal actions list
  (203,  'Turmeric — anti-inflammatory (AI) for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 10, src_ra),
  (124,  'Fresh ginger — anti-inflammatory (AI) for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 20, src_ra),
  (81,   'SJW — anti-inflammatory for rheumatoid arthritis; oilination of affected areas and adjacent, and internal', cn, 'personal', 'Rheumatoid Arthritis', 30, src_ra),
  (1648, 'Dandelion leaf — alterative and diuretic (drains synovial fluid) for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 40, src_ra),
  (122,  'Dandelion root — alterative and digestive bitter for rheumatoid arthritis; supports waste elimination', cn, 'personal', 'Rheumatoid Arthritis', 50, src_ra),
  (22,   'Burdock — alterative (internal) for rheumatoid arthritis; blood and lymphatic clearing', cn, 'personal', 'Rheumatoid Arthritis', 60, src_ra),
  (37,   'Yellow Dock — alterative, digestive bitter, and hepatic for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 70, src_ra),
  (1212, 'Cranberry — antioxidant for rheumatoid arthritis; waste in RA is oxidative — buffer the blood', cn, 'personal', 'Rheumatoid Arthritis', 80, src_ra),
  (849,  'Rose hips — antioxidant for rheumatoid arthritis; buffers oxidative waste', cn, 'personal', 'Rheumatoid Arthritis', 90, src_ra),
  (28,   'Cleavers — circulatory herb promoting lymph circulation (not blood) for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 100, src_ra),
  (981,  'Red Root — circulatory herb promoting lymph circulation for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 110, src_ra),
  (35,   'Poke Root — circulatory herb promoting lymph circulation for rheumatoid arthritis; low dose', cn, 'personal', 'Rheumatoid Arthritis', 120, src_ra),
  (129,  'Hops — topical analgesic for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 130, src_ra),
  (2601, 'Cannabis — topical analgesic for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 140, src_ra),
  (87,   'Willow — topical analgesic for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 150, src_ra),
  (43,   'Nettle (leaf) — diuretic for rheumatoid arthritis; drains synovial fluid', cn, 'personal', 'Rheumatoid Arthritis', 160, src_ra),
  (137,  'Passionflower — nervine for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 170, src_ra),
  (178,  'Milky Oats — nervine for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 180, src_ra),
  (142,  'Skullcap — nervine for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 190, src_ra),
  (128,  'California Poppy — nervine for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 200, src_ra),
  (76,   'Fennel — digestive bitter and carminative for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 210, src_ra),
  (127,  'Cardamom — digestive bitter and carminative for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 220, src_ra),
  (102,  'Gentian — digestive bitter for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 230, src_ra),
  (748,  'Orange peel — digestive bitter and carminative for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 240, src_ra),
  (78,   'Licorice — hepatic support for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 250, src_ra),
  (33,   'Oregon Grape Root — hepatic support for rheumatoid arthritis', cn, 'personal', 'Rheumatoid Arthritis', 260, src_ra),
  (206,  'Milk Thistle — hepatic support for rheumatoid arthritis; key herb for waste elimination', cn, 'personal', 'Rheumatoid Arthritis', 270, src_ra),
  (26,   'Echinacea — immune modulator for rheumatoid arthritis; main point is immune modulation and waste elimination', cn, 'personal', 'Rheumatoid Arthritis', 280, src_ra),

  -- HIBISCUS section
  (2233, 'Hibiscus sabdariffa — diuretic, antioxidant; anthocyanins stimulate myogenesis and muscle protein synthesis, protect against muscle degradation; supportive of hyaluronan production in the extracellular matrix; prevents hyaluronidase expansion; excellent for metabolic disorders and tissue degradation (PCOS/PMOS); cardioprotective; wound wash; lowers blood pressure; formulate with marshmallow glycerite', cn, 'personal', 'Hibiscus', 10, src_hibiscus),
  (45,   'Marshmallow (glycerite) — formulated with Hibiscus sabdariffa as a demulcent to balance its acidity', cn, 'personal', 'Hibiscus', 20, src_hibiscus),

  -- CALIFORNIA POPPY (detailed)
  (128, 'California Poppy — specifically for smooth and skeletal muscles; low grade chronic pain; menstrual cramps; muscle cramps and spasms', cn, 'personal', 'California Poppy', 10, src_calpoppy),

  -- ST. JOHN'S WORT (detailed)
  (81, 'SJW — neuroprotective plant acting on nerve endings; primary herb for sciatica; anti-inflammatory (inhibits prostaglandin); decreases amyloid reactive oxygen species (Alzheimer''s connection); high doses for long term chronic pain; especially in viral picture; anti-inflammatory to the gut; significant drug interactions at therapeutic doses (contraceptives, cardiac drugs, anticancer, immunosuppressives, anti-hypertensives, benzodiazepines, HIV, anticoagulants, SSRI, antifungals)', cn, 'personal', 'St. John''s Wort', 10, src_sjw),

  -- GOTU KOLA
  (2229, 'Gotu Kola — cerebral circulation tonic; connective tissue tonic; primary herb for scleroderma, lupus, myasthenia gravis, MS, general neuromuscular and muscular wasting conditions; pillar of formula for dysfunctional extracellular matrix (repro realm); supports fluid and tissue in the synovial capsule', cn, 'personal', 'Gotu Kola', 10, src_gotukola),

  -- SOLOMON'S SEAL
  (1252, 'Solomon''s Seal — tincture and decoction (no oil); specifically acts on collagen and cartilage; nutritive to tendons and ligaments; prevents and removes swelling on bone after injury; supportive for bone spurs; repetitive use injuries including carpal tunnel syndrome; arthritis from old injuries; calcifications (calcium build up on bone/joints); muscular and skeletal tensions in general; Matt Wood: "indispensable musculoskeletal remedy"; take a week off every 2 months in long-term use', cn, 'personal', 'Solomon''s Seal', 10, src_solomon),

  -- BLACK COHOSH
  (25, 'Black Cohosh — specific for dull, aching, muscular pain and acute inflammatory rheumatic pains; THE rheumatoid arthritis remedy; influences bone mineral loss (osteoporosis, osteopenia); used for anxiety, tension headaches, fibromyalgia pain; associated with intrusive negative thoughts in association with pain; serotonin agonist; severe dysmenorrhea and post-menopausal bodies; used mostly now for body pain', cn, 'personal', 'Black Cohosh', 10, src_bcohosh),

  -- KAVA
  (138, 'Kava — one of the few skeletal muscle relaxants (rivals Pedicularis); nervine and sleep aid; antispasmodic for muscle cramps', cn, 'personal', 'Kava', 10, src_kava),

  -- JAMAICAN DOGWOOD
  (2461, 'Jamaican Dogwood ("Florida fish poison tree") — specific for smooth muscle pain; phantom pains (amputations); insomnia with spasms; nervous irritability; tachycardia; general body pains; sedative; targets face pain; pairs with Willow or Meadowsweet (AI) for pain; pairs with Wild Lettuce or Kava for recent injury; pairs with Hops or Skullcap for insomnia from body aches; pairs with Black Cohosh for skeletal pain', cn, 'personal', 'Jamaican Dogwood', 10, src_jdog),
  (75,   'Meadowsweet — pairs well with Jamaican Dogwood as an anti-inflammatory to reduce sensation of pain', cn, 'personal', 'Jamaican Dogwood', 20, src_jdog),
  (130,  'Wild Lettuce — pairs well with Jamaican Dogwood for recent injury and insomnia (also noted by Lisa as tea for sleep)', cn, 'personal', 'Jamaican Dogwood', 30, src_jdog),

  -- WHITE WILLOW (detailed)
  (87, 'White Willow — specific analgesic and anti-inflammatory; rheumatism, gout, headaches, aches and pains of all kinds; most effective for arthritis as a decoction (hydrophilic salicylic acid); decoction + baking soda = buffered acid; astringent as tincture, analgesic as decoction', cn, 'personal', 'White Willow', 10, src_willow),

  -- VALERIAN
  (145, 'Valerian — huge difference between fresh and dried tincture; mild pain reliever; relieves body tension; antispasmodic for smooth and skeletal muscles; nervine and sedative; can cause heart palpitations in dry people — pair with California Poppy to mitigate', cn, 'personal', 'Valerian', 10, src_valerian),

  -- SLEEP SUPPORT (personal notes at end of class)
  (1595, 'Nutmeg in milk with Ashwagandha — Lisa''s sleep formula', cn, 'personal', 'Sleep Support', 10, src_sleep),
  (20,   'Ashwagandha in milk with Nutmeg — Lisa''s sleep formula', cn, 'personal', 'Sleep Support', 20, src_sleep),
  (130,  'Wild Lettuce tea — Lisa''s sleep remedy', cn, 'personal', 'Sleep Support', 30, src_sleep);

  -- ---- SUPPLEMENT SNIPPETS ----
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (15, 'Calcium — responsible for muscle tone and contraction; supplements usually not the best form, food usually better', cn, 'personal', 'Calcium Metabolism', 20, src_calcium),
  (11, 'Vitamin D — regulates insulin secretion, cell proliferation, cell differentiation, apoptosis, muscle calcium transport, bone mineralization, immune function, phosphorus and calcium homeostasis; optimal level 75–80; 3000 IU good for long term', cn, 'personal', 'Vitamin D', 10, src_vitd);

END $$;


-- ============================================================
-- HERB KEYWORDS
-- ============================================================

-- Rheumatoid arthritis (anti-inflammatory herbs)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (203,  'rheumatoid arthritis', 'ailment'),
  (203,  'inflammation',         'ailment'),
  (203,  'anti-inflammatory',    'action'),
  (124,  'rheumatoid arthritis', 'ailment'),
  (124,  'inflammation',         'ailment'),
  (124,  'anti-inflammatory',    'action'),
  (81,   'rheumatoid arthritis', 'ailment'),
  (81,   'inflammation',         'ailment'),
  (81,   'anti-inflammatory',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alteratives for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1648, 'rheumatoid arthritis', 'ailment'),
  (1648, 'alterative',           'action'),
  (122,  'rheumatoid arthritis', 'ailment'),
  (122,  'alterative',           'action'),
  (22,   'rheumatoid arthritis', 'ailment'),
  (22,   'alterative',           'action'),
  (37,   'rheumatoid arthritis', 'ailment'),
  (37,   'alterative',           'action'),
  (37,   'liver support',        'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Antioxidants for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1212, 'rheumatoid arthritis', 'ailment'),
  (1212, 'antioxidant',          'action'),
  (849,  'rheumatoid arthritis', 'ailment'),
  (849,  'antioxidant',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Circulatory/lymphatic for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (28,   'rheumatoid arthritis', 'ailment'),
  (28,   'lymphatic support',    'ailment'),
  (981,  'rheumatoid arthritis', 'ailment'),
  (981,  'lymphatic support',    'ailment'),
  (981,  'long covid',           'ailment'),
  (981,  'antiviral',            'action'),
  (35,   'rheumatoid arthritis', 'ailment'),
  (35,   'lymphatic support',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Analgesics for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (129,  'rheumatoid arthritis', 'ailment'),
  (129,  'analgesic',            'action'),
  (129,  'chronic pain',         'ailment'),
  (2601, 'rheumatoid arthritis', 'ailment'),
  (2601, 'analgesic',            'action'),
  (2601, 'chronic pain',         'ailment'),
  (87,   'rheumatoid arthritis', 'ailment'),
  (87,   'analgesic',            'action'),
  (87,   'gout',                 'ailment'),
  (87,   'headache',             'ailment'),
  (87,   'arthritis',            'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Diuretics/nervines for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43,   'rheumatoid arthritis', 'ailment'),
  (43,   'diuretic',             'action'),
  (137,  'rheumatoid arthritis', 'ailment'),
  (137,  'nervine',              'action'),
  (178,  'rheumatoid arthritis', 'ailment'),
  (178,  'nervine',              'action'),
  (142,  'rheumatoid arthritis', 'ailment'),
  (142,  'nervine',              'action'),
  (128,  'rheumatoid arthritis', 'ailment'),
  (128,  'nervine',              'action'),
  (128,  'chronic pain',         'ailment'),
  (128,  'muscle spasms',        'ailment'),
  (128,  'dysmenorrhea',         'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Digestive bitters/carminatives for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (76,   'rheumatoid arthritis', 'ailment'),
  (76,   'carminative',          'action'),
  (127,  'rheumatoid arthritis', 'ailment'),
  (127,  'carminative',          'action'),
  (102,  'rheumatoid arthritis', 'ailment'),
  (748,  'rheumatoid arthritis', 'ailment'),
  (748,  'carminative',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hepatic for RA
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78,   'rheumatoid arthritis', 'ailment'),
  (78,   'long covid',           'ailment'),
  (78,   'antiviral',            'action'),
  (33,   'rheumatoid arthritis', 'ailment'),
  (206,  'rheumatoid arthritis', 'ailment'),
  (26,   'rheumatoid arthritis', 'ailment'),
  (26,   'immune support',       'ailment'),
  (26,   'autoimmune disease',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hibiscus
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2233, 'rheumatoid arthritis',      'ailment'),
  (2233, 'muscle wasting',            'ailment'),
  (2233, 'connective tissue disorders','ailment'),
  (2233, 'metabolic syndrome',        'ailment'),
  (2233, 'PCOS',                      'ailment'),
  (2233, 'cardiovascular disease',    'ailment'),
  (2233, 'hypertension',              'ailment'),
  (2233, 'wound healing',             'ailment'),
  (2233, 'antioxidant',               'action'),
  (2233, 'diuretic',                  'action'),
  (45,   'rheumatoid arthritis',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Poppy (detailed)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128,  'muscle spasms',  'ailment'),
  (128,  'analgesic',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- SJW (detailed)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (81,   'sciatica',          'ailment'),
  (81,   'nerve pain',        'ailment'),
  (81,   'chronic pain',      'ailment'),
  (81,   'neuroprotective',   'action'),
  (81,   'anti-inflammatory', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gotu Kola
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2229, 'connective tissue disorders', 'ailment'),
  (2229, 'muscle wasting',              'ailment'),
  (2229, 'rheumatoid arthritis',        'ailment'),
  (2229, 'circulation',                 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Solomon's Seal
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1252, 'arthritis',              'ailment'),
  (1252, 'bone spurs',             'ailment'),
  (1252, 'repetitive use injuries','ailment'),
  (1252, 'connective tissue disorders','ailment'),
  (1252, 'chronic pain',           'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Black Cohosh
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (25,   'rheumatoid arthritis', 'ailment'),
  (25,   'osteoporosis',         'ailment'),
  (25,   'fibromyalgia',         'ailment'),
  (25,   'headache',             'ailment'),
  (25,   'anxiety',              'ailment'),
  (25,   'chronic pain',         'ailment'),
  (25,   'dysmenorrhea',         'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Kava
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (138,  'muscle spasms',   'ailment'),
  (138,  'chronic pain',    'ailment'),
  (138,  'sleep support',   'ailment'),
  (138,  'muscle relaxant', 'action'),
  (138,  'antispasmodic',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Jamaican Dogwood
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2461, 'nerve pain',    'ailment'),
  (2461, 'muscle spasms', 'ailment'),
  (2461, 'chronic pain',  'ailment'),
  (2461, 'tachycardia',   'ailment'),
  (2461, 'sleep support', 'ailment'),
  (2461, 'analgesic',     'action'),
  (2461, 'sedative',      'action'),
  (2461, 'antispasmodic', 'action'),
  (75,   'rheumatoid arthritis', 'ailment'),
  (75,   'analgesic',            'action'),
  (75,   'anti-inflammatory',    'action'),
  (130,  'chronic pain',         'ailment'),
  (130,  'sleep support',        'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- White Willow (detailed)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (87,   'arthritis',        'ailment'),
  (87,   'anti-inflammatory','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Valerian
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (145,  'chronic pain',   'ailment'),
  (145,  'muscle spasms',  'ailment'),
  (145,  'sleep support',  'ailment'),
  (145,  'analgesic',      'action'),
  (145,  'antispasmodic',  'action'),
  (145,  'sedative',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chronic Pain herbs (long covid)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (134,  'mineral support', 'ailment'),
  (2274, 'long covid',      'ailment'),
  (2274, 'chronic pain',    'ailment'),
  (2274, 'antiviral',       'action'),
  (56,   'long covid',      'ailment'),
  (56,   'antiviral',       'action'),
  (11,   'long covid',      'ailment'),
  (11,   'immune support',  'ailment'),
  (11,   'antiviral',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Sleep Support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1595, 'sleep support', 'ailment'),
  (20,   'sleep support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;


-- ============================================================
-- SUPPLEMENT KEYWORDS
-- ============================================================
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (15, 'mineral support', 'ailment'),
  (15, 'muscle spasms',   'ailment'),
  (15, 'osteoporosis',    'ailment'),
  (11, 'immune support',  'ailment'),
  (11, 'osteoporosis',    'ailment'),
  (11, 'mineral support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;


-- ============================================================
-- AILMENT SEARCH TERMS
-- New ailment keywords introduced in this class, plus any
-- existing herb_keywords ailments not yet in ailment_search_terms.
-- ============================================================
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES

  -- existing herb_keywords ailments not yet in ailment_search_terms
  ('chronic pain',
   ARRAY['persistent pain', 'long-term pain', 'ongoing pain', 'pain syndrome']),

  ('inflammation',
   ARRAY['inflammatory condition', 'systemic inflammation', 'tissue inflammation', 'inflammatory response']),

  ('lymphatic support',
   ARRAY['lymph drainage', 'lymphatic congestion', 'lymph stagnation', 'lymphatic drainage']),

  ('muscle spasms',
   ARRAY['muscle cramps', 'muscle tension', 'muscle tightness', 'spasm', 'cramping', 'muscular spasm']),

  -- new ailment keywords introduced in this class
  ('rheumatoid arthritis',
   ARRAY['RA', 'inflammatory arthritis', 'autoimmune arthritis', 'rheumatic disease', 'rheumatism']),

  ('osteoporosis',
   ARRAY['bone density loss', 'osteopenia', 'bone mineral loss', 'bone fragility', 'brittle bones', 'bone thinning']),

  ('sciatica',
   ARRAY['sciatic pain', 'sciatic nerve pain', 'lumbar radiculopathy', 'leg nerve pain', 'shooting leg pain']),

  ('repetitive use injuries',
   ARRAY['repetitive strain injury', 'RSI', 'carpal tunnel syndrome', 'carpal tunnel', 'overuse injury', 'tendinitis', 'repetitive motion injury']),

  ('bone spurs',
   ARRAY['osteophytes', 'bone calcification', 'joint calcification', 'calcium deposits on bone', 'exostosis']),

  ('connective tissue disorders',
   ARRAY['scleroderma', 'lupus', 'multiple sclerosis', 'MS', 'myasthenia gravis', 'autoimmune connective tissue', 'collagen disorder', 'fascia disorder']),

  ('gout',
   ARRAY['gouty arthritis', 'uric acid arthritis', 'hyperuricemia', 'uric acid buildup', 'podagra']),

  ('nerve pain',
   ARRAY['neuropathic pain', 'neuropathy', 'neuralgia', 'phantom pain', 'nerve damage pain', 'burning nerve pain']),

  ('long covid',
   ARRAY['post-covid syndrome', 'post-viral syndrome', 'long-haul covid', 'PASC', 'post-acute sequelae', 'chronic covid', 'covid long haulers']),

  ('headache',
   ARRAY['tension headache', 'head pain', 'cephalgia', 'migraine', 'tension-type headache']),

  ('muscle wasting',
   ARRAY['muscular atrophy', 'muscle loss', 'sarcopenia', 'muscle degeneration', 'myasthenia']),

  ('tachycardia',
   ARRAY['rapid heart rate', 'fast heart rate', 'racing heart', 'elevated heart rate', 'palpitations'])

ON CONFLICT (ailment_keyword) DO NOTHING;
