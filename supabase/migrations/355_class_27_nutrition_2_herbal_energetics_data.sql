-- Migration 355: Class 27 – Nutrition 2 and Herbal Energetics
--
-- Parsed files:
--   BHC - Class 27 - Nutrition 2 and Herbal Energetics - Lisa Claire.md
--   note_type = 'personal'
-- Class name: BHC - Class 27 - Nutrition 2 and Herbal Energetics
--
-- Normalisations:
--   Vitex → Chasteberry (Vitex agnus-castus, id=190)
--   Ginsengs (general) → Ginseng (Panax ginseng, id=14)
--   Schisandra/Schizandra → Schizandra (Schisandra chinensis, id=17)
--   OGR/Oregon Grape Root → Oregon Grape (Mahonia aquifolium, id=33)
--   Licorice root → Licorice (Glycyrrhiza glabra, id=78)
--   Rose hips → Rose (Rosa spp., hips, id=849)
--   Rose petals → Rose (Rosa spp., petal, id=850)
--   Pine → Pine Needles (Pinus spp., id=2643)
--   [[Databases/Herbs/Data/Orange|orange]] peel → Sweet Orange (Citrus sinensis, id=748)
--
-- Skipped (not in DB or non-medicinal food):
--   Star anise (Illicium verum) – not in DB; broth recipe ingredient
--   Bay leaves (Laurus nobilis) – not in DB; broth recipe ingredient
--   Kombu/seaweed – not in DB; food ingredient
--   Dried figs, molasses, pomegranate, apricots, dates – food in Iron Tonic
--   Brazil nuts – food; selenium source (noted as usually rancid)
--
-- Keyword merge decisions:
--   "estrogen pathways" (alfalfa) → existing 'estrogen support'
--   "lymph mover" → 'lymphatic' (action)
--   "immune function of mucus membranes" → 'immune support' + 'mucous membrane support'
--   "thyroid disorders" (selenium) → existing 'hypothyroidism', 'hyperthyroidism'
--   "libido enhancer" (maca) → new ailment 'low libido'
--   "sinus infection" – new ailment keyword
--   nausea – already exists as symptom keyword
--   "digestive health" → merged into existing 'digestive tonic' (ailment)
--
-- Energetics updates (Part 1):
--   Removes 4 erroneous 'warming' action keywords – warming is an energetic, not an action
--   licorice (78): temperature neutral → cooling
--   chasteberry (190): moisture neutral → drying
--   alfalfa (885), red clover (42): taste NULL → salty
--   hibiscus (2233), hawthorn (73): taste NULL → sour
--   reishi mushroom (11): taste NULL → sweet
--   chamomile (84): taste NULL → bitter
--   mugwort (115): taste pungent → bitter (instructor explicit classification)

SET search_path TO herbal, public;

-- =============================================================
-- PART 1: Fix energetics keywords + update herb energetics
-- =============================================================

DELETE FROM herbal.herb_keywords
WHERE keyword = 'warming' AND category = 'action';

-- Temperature
UPDATE herbal.herbs SET temperature = 'cooling' WHERE id = 78;   -- Licorice

-- Moisture
UPDATE herbal.herbs SET moisture = 'drying'    WHERE id = 190;  -- Chasteberry

-- Taste (NULL → value from notes)
UPDATE herbal.herbs SET taste = 'salty'  WHERE id IN (885, 42)  AND taste IS NULL;
UPDATE herbal.herbs SET taste = 'sour'   WHERE id IN (2233, 73) AND taste IS NULL;
UPDATE herbal.herbs SET taste = 'sweet'  WHERE id = 11          AND taste IS NULL;
UPDATE herbal.herbs SET taste = 'bitter' WHERE id = 84          AND taste IS NULL;
-- Mugwort: instructor explicitly classifies as bitter (overrides existing 'pungent')
UPDATE herbal.herbs SET taste = 'bitter' WHERE id = 115;

-- =============================================================
-- PART 2: Snippets, keywords, ailment search terms
-- =============================================================
DO $MIGRATION$
DECLARE
  v_class TEXT := 'BHC - Class 27 - Nutrition 2 and Herbal Energetics';

  v_src_broths       TEXT;
  v_src_salts        TEXT;
  v_src_gen_recs     TEXT;
  v_src_broth_rec    TEXT;
  v_src_salt_rec     TEXT;
  v_src_vita         TEXT;
  v_src_vitb         TEXT;
  v_src_vitc         TEXT;
  v_src_vitd         TEXT;
  v_src_vite         TEXT;
  v_src_vitk         TEXT;
  v_src_selenium     TEXT;
  v_src_zinc         TEXT;
  v_src_iron         TEXT;
  v_src_warming      TEXT;
  v_src_cooling      TEXT;
  v_src_drying       TEXT;
  v_src_moistening   TEXT;
  v_src_laxness      TEXT;
  v_src_constricting TEXT;
  v_src_relaxing     TEXT;
  v_src_flavors      TEXT;
  v_src_salty        TEXT;
  v_src_sour         TEXT;
  v_src_bitter       TEXT;
  v_src_sweet        TEXT;
  v_src_pungent      TEXT;
  v_src_schisandra   TEXT;

BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class
  ) THEN
    RAISE NOTICE 'Class 27 snippets already loaded, skipping';
    RETURN;
  END IF;

  v_src_broths :=
'## Broths
- veggie scraps in freezer container
- miso at the end, in the bowl for eating
- gallon of broth, 1 quart in fridge, rest in freezer
- use broth instead of oil for saute
- seaweed
- add herbs!
    - [[calendula]] - Pot marigold, put it in the pot! - [[vulnerary]], healing and stimulant for the immune function of all mucus membranes, lymph mover
    - [[oregano]] - [[antimicrobial]]
    - [[thyme]] - [[antimicrobial]]
    - [[rosemary]] - [[antimicrobial]]
    - [[nettle]] - rich in vitamins, protein - add after straining, vitamins only if you eat them
    - jujubes - vitamin rich, delicious
    - [[reishi]] - not always, tongue depressor type, designed to be put in soups
- boil, simmer for 20 minutes, lid on for volatile oils
- strain into containers or jars
- add miso in morning or night, protein rich broth
- if animal bones, add some vinegar or lemon juice to draw out nutrients';

  v_src_salts :=
'## Salts
- iodized salts are generally not great for electrolyte use, the iodine jeopardizes the other minerals
- if you want iodine, look to your seaweeds
- gray salts may not work well for spice grinds - too wet
- try to avoid buying the himalayan pink salts - strip mining
- all of the mineral-rich salts are good for herbs
    - [[lemon balm]] - excellent seasoning for chicken or fish
    - [[alfalfa]] - high vitamin, legume, so good for estrogen pathways, and tastes like salt
    - [[red clover]] - little bit not too much, high in vitamins and minerals
    - nettles good in salts
    - dried [[parsley]] - so high in nutrients
    - [[fennel]] seeds - excellent as a [[carminative]]
- just want it to be able to grind nicely and be inviting';

  v_src_gen_recs :=
'- [[Astragalus]] is so potent in moistening, it can push the body to dampness
    - so if acute conditions, can drive the infection deeper into the tissues
- Neti pot - add [[Calendula]] tea or [[Yerba Mansa]] tea as the liquid, if infection';

  v_src_broth_rec :=
'## Herbal Broth Recipe
- 1/4 c dried shiitake mushrooms
- 2 [[astragalus]] sticks
- 2 jujube dates
- 2" piece kombu
- 2 T dried [[orange]] peel - stimulating bitter, aromatic
- 2 [[star anise]]
- 2 [[bay]] leaves
- + container of veggie scraps';

  v_src_salt_rec :=
'## Herbal Salt Recipe
- 1P [[Nettle]]
- 2P [[Rosemary]]
- 1P [[Alfalfa]]
- 1P [[Thyme]] or [[Oregano]]
- 1/2 P coarse pink or gray sea salt';

  v_src_vita :=
'### Vitamin A (Beta carotene is a constituent found in food)
- helps form and maintain healthy: teeth, bones, soft tissue, mucus membranes, skin, retinal tissue
- excess drinking can lead to deficiency
- spices: [[nutmeg]] richest; [[fenugreek]] seeds; red chili; smaller in [[basil]], marjoram, [[sage]], dried [[coriander]]
- don''t supplement with Vit A, but with Beta carotene, due to toxicity if buildup';

  v_src_vitb :=
'### Vitamin B
- B1 = Thiamine - helps cells be responsive to changes in the body, and exert their autonomy
- B2 = Riboflavin - important for production of red blood cells (anemia), growth
- B3 = Niacin - important for skin and nerves, helps body to metabolize triglycerides
- B5 = Pantothenic Acid - role in production of cholesterol, therefore hormones
- B6 = Pyridoxine - brain function, red blood cells, chemical reactions in the body; necessary for metabolism of proteins
- B7 = Biotin - role in metabolism of protein and carb metabolism, also metabolizes cholesterol therefore production hormones
- B9 = Folate - works with B12 to help form red blood cells, needed for DNA production, tissue growth and cell function
    - deficiency can cause deformed babies
    - low levels associated with cognitive decline, related to role in methylation (liver detox pathway)
- B12 = Cobalamin - generally supports metabolism incl methylation, also formation of RBC, maintains CNS and PNS
- herbs:
    - [[Nettle]] (1,2,3,5,6,9)
    - [[Red Clover]] (1,2,6) + inositol
    - [[Alfalfa]] (1,2,3,5,6,9,12)';

  v_src_vitc :=
'### Vitamin C
- an AO promoting healthy teeth and gums, but more generally the integument (Skin +)
- helps the body absorb iron and maintain healthy tissue
- essential for wound healing (and post-surgical care)
- herbs: Rosehips, [[Parsley]], Citrus peel, [[Hibiscus]] flowers, Nettles, [[Hawthorn]] berries';

  v_src_vitd :=
'### Vitamin D
- helps the body to absorb calcium which is necessary for normal development and maintenance of healthy teeth and bones
- helps maintain proper blood levels of calcium and phosphorus
- if someone is scattershot feeling bad, get the levels
- North American angle of the sun not enough to fill the bodies needs
- should be around 70
- recommended dose 3000 IU/day
- doesn''t need to be taken with Vit K, but the combo can increase insulin sensitivity and so support blood sugar homeostasis';

  v_src_vite :=
'### Vitamin E
- an AO
- helps the body form RBC
- helps the body use Vit K
- fat soluble, so pay attention to how much you take in
- sources: avo seeds and nuts, wheat germ oil, spinach, broccoli, asparagus, papaya, mango, broadly found in seed oils';

  v_src_vitk :=
'### Vit K
- needed for blood coagulation
- important for bone health
- synergistic with Vit D
- foods: cruciferous veggies - cabbage, cauliflower; cereals: quinoa, amaranth; spinach; fish, liver, beef, eggs';

  v_src_selenium :=
'### Selenium
- AO, lean into for any thyroid disorders
- assoc also with repro: fibroids and endomet
- therapy as well for PCOS
- foods: brazil nuts (but usually rancid)';

  v_src_zinc :=
'### Zinc
- related to poor immune function
- associated with fibroids and endometriosis as well
- think of when someone with chronic low immunity or repro problems';

  v_src_iron :=
'### Iron
- have to get enough Vitamin C to absorb
- most common supplement for this extremely constipating - Ferrous Sulfate
- Nettles - prefer a syrup that contains Vitamin C
- foods: pumpkin seeds, lentils, beets, spinach

Iron Tonic Syrup:
• 4 tbsp dried [[Nettle]] (Urtica dioica) leaf
• 3 tbsp [[Alfalfa]] (Medicago sativa)
• 2 tbsp [[Raspberry]] Leaf (Rubus idaeus)
• 1 tbsp dried [[Yellow Dock]] (Rumex crispus) root
• 1 tbsp [[Hawthorn]] berries (Crataegus)
• 1 tsp [[Rose hips]] (Rosa spp.)
• 2 cups molasses; 1 cup pomegranate or black cherry concentrate
- decoct from yellow dock down, 20 mins, off heat, then add leaves to steep, strain, then add molasses and pomegranate
- doesn''t store very long, freeze some (3 weeks in fridge); 2T / day
- if iron deficient anemia; has enough Vit C to metabolize
- [[Yellow dock]] in there for people who tend toward constipation, can omit if not constipated
- careful of bioaccumulation of iron, can happen if not enough Vit C in diet';

  v_src_warming :=
'## When we are cold, we want warming herbs
- they stimulate metabolism, increase vitality and blood flow
- for: pale, slow, weak, deficient

## Examples of warming herbs
- [[ashwagandha]]
- ginsengs
- [[ginger]]
- [[rosemary]]
- [[thyme]]
- [[cayenne]]
- [[garlic]]
- [[maca]] - libido enhancer
- [[yerba mansa]] - anything sinus related
- [[turmeric]]
- resins: very heating and AI - joint pain, low part of a formula, usually
    - [[myrrh]]';

  v_src_cooling :=
'## When we are hot, we want cooling herbs
- soothe irritation, inflammation and redness

## Cooling herbs
- [[blue vervain]] (all bitters except Orange peel and angelica) - NS related, relaxing, "type A people will die with a to do list"
- rosehips
- [[lemon balm]]
- [[violet]] leaf
- [[licorice]]
- peach leaf - underused, can get from farmer''s market, help for nausea, anything hot
    - topical for bee stings and bug bites';

  v_src_drying :=
'## When we are damp, we want drying herbs
- remove excess fluid, congestion, swelling and stagnation
- elimination pathways are impaired or blocked
- for: swollen, congested, weepy tissues

## Drying Herbs
- Vitex
- [[Nettle]]
- [[Ginger]]
- [[Pine]]
- [[Rhodiola]] - improves stamina, hormones (+ shatavari maybe to moisten)
- [[Rose]] Petals
- [[Rosemary]]
- [[Yerba santa]]';

  v_src_moistening :=
'## When we are dry we want moistening herbs
- lubricate and soften and soothe dry, brittle tissues
- dryness -> heat (forest fire)
- if you are already dry nasal passages, easier for infection to enter

## Moistening herbs
- shatavari - traditionally a decoction, not a tincture
- [[marshmallow]]
- [[violet]] leaf
- aloe
- [[licorice]]
- oat
- [[plantain]]
- [[mullein]]';

  v_src_laxness :=
'## Signs of laxness
- excessive sweating
- chronic infections
- disrupted bacterial ecology
- diarrhea/vomiting
- bleeding
- cysts
- leaky bladder, excess discharge
- muscle weakness
- Herbs:
    - [[Plantain]] superstar for the GI
    - Schizandra specific for excess discharges
    - [[Solomons Seal]] loosens whats too tight and tightens whats too loose - musculoskeletal';

  v_src_constricting :=
'## Constricting herbs
- increase tone and tension of lax muscles
- for ''leaky'' tissues that secrete fluids such as blood or mucus
- herbs: tannins
    - [[plantain]]
    - [[oak]]
    - [[rose]]
    - witch hazel
    - [[yarrow]]
    - [[raspberry]] leaf - uterine tonic, maybe acutely, but more helpful to take all cycle long
    - shepherd''s purse - specific for stopping bleeding';

  v_src_relaxing :=
'## Relaxing Herbs
- relax muscle cramps and spasms, tension in the muscles
- promote flow and movement
- herbs:
    - silk tassel
    - [[catnip]]
    - [[kava]] kava';

  v_src_flavors :=
'## Flavors
- the flavor of an herb tells us a lot about its medicinal qualities and energetic makeup
- [[SOUR]], [[SALTY]], [[SWEET]], [[PUNGENT]], [[BITTER]]
- [[horsetail]] -> salty';

  v_src_salty :=
'### Salty Herbs
- downward direction; specific for directing energy to the kidney
- balances fluids, restore electrolyte balances, nourishes kidney and bladder, strengthens teeth and bones
- minerals are the spark plugs for every bodily process
- energetics: balancing and nourishing
- properties: nutritive, mineralizing, [[diuretic]], [[lymphatic]]
- constituents: magnesium, potassium, sodium, calcium
- examples: [[alfalfa]], [[chickweed]], [[nettle]], [[red clover]]';

  v_src_sour :=
'### Sour Herbs
- [[hibiscus]] -> sour
- move energy inward and downward. Astringe the spirit.
- their energies tonify tissues. Protect against oxidative stress (heat). Supports the liver
- tend to be nice and cool
- energetics: cooling, astringing
- properties: AO, tonic, hepatic
- constituents: fruit acids, flavanoids, antioxidants
- examples: [[hawthorn]], rosehips, [[schisandra]]
- think about a saturated sponge, wringing it out';

  v_src_bitter :=
'### Bitter Herbs
- [[mugwort]] -> bitter (try a cold infusion, fresh or dry, add [[marshmallow]], [[chamomile]] or [[lemon balm]])
- have a downward, grounding, drying, and clearing action
- stimulate bile, increase appetite and help with digestion, elimination
- examples:
    - [[gentian]]
    - [[artichoke]] leaf - subtle
    - [[wormwood]] - gnarly
    - [[mugwort]]
    - [[dandelion root]]
    - [[blue vervain]]
    - [[motherwort]]
    - [[chamomile]]
    - [[Oregon Grape Root]]
    - [[Angelica]]
- doesn''t make sense to dilute in water, because you need the bitter taste to activate bile, etc';

  v_src_sweet :=
'### Sweet herbs
- [[Astragalus]] -> sweet
- nourish and build tissues; strengthening, replenishing
- energetics: moistening and neutral
- properties: tonic, [[demulcent]] nutritive, adaptogenic, immune enhancing
- constituents: polysaccharides, saponins
- the subtle flavor of grains, some roots, and some mushrooms ([[Reishi]] has a sweet aftertaste)
- Rehmania - grounding and calming
- examples: [[Licorice]], [[Reishi]] (most mushrooms), Ginsengs, [[Marshmallow]], [[Burdock]]';

  v_src_pungent :=
'### Pungent Herbs
- [[Rosemary]] -> Pungent
- stimulate digestion, circulation and metabolism
- helps to disperse congestion and excess energy
- increase circulation and wake up our senses
- most culinary herbs are pungent: they help increase digestive action
- typically strong, usually used in low doses
- movers, potentiators
- energetics: warming and drying
- properties: circ & digestive stimulant, [[diaphoretic]]
- constituents: resins, monoterpenes
- examples: [[rosemary]], [[ginger]], [[garlic]], [[clove]], horseradish, [[thyme]], [[cardamom]], [[prickly ash]], [[echinacea]]';

  v_src_schisandra :=
'### Schisandra - the 5 flavor berry
- liver protective like [[milk thistle]]
- focus, clarity
- zing, confidence, but helps regulate cortisol
- balances energy
- associated with longevity and beauty in TCM
- works on the liver
- eat a couple berries in the morning';

  -- =========================================================
  -- HERB SNIPPETS
  -- =========================================================
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- BROTHS
  (70,   'calendula - Pot marigold, put it in the pot! - vulnerary, healing and stimulant for the immune function of all mucus membranes, lymph mover', v_class, 'personal', 'Broths', 10, v_src_broths),
  (406,  'oregano - antimicrobial', v_class, 'personal', 'Broths', 20, v_src_broths),
  (59,   'thyme - antimicrobial', v_class, 'personal', 'Broths', 30, v_src_broths),
  (109,  'rosemary - antimicrobial', v_class, 'personal', 'Broths', 40, v_src_broths),
  (43,   'nettle - rich in vitamins, protein - add after straining, vitamins only if you eat them', v_class, 'personal', 'Broths', 50, v_src_broths),
  (11,   'reishi - not always, tongue depressor type, designed to be put in soups', v_class, 'personal', 'Broths', 60, v_src_broths),
  (1528, 'jujubes - vitamin rich, delicious', v_class, 'personal', 'Broths', 70, v_src_broths),

  -- SALTS
  (134,  'lemon balm - excellent seasoning for chicken or fish', v_class, 'personal', 'Salts', 80, v_src_salts),
  (885,  'alfalfa - high vitamin, legume, so good for estrogen pathways, and tastes like salt', v_class, 'personal', 'Salts', 90, v_src_salts),
  (42,   'red clover - little bit not too much, high in vitamins and minerals', v_class, 'personal', 'Salts', 100, v_src_salts),
  (43,   'nettles good in salts', v_class, 'personal', 'Salts', 110, v_src_salts),
  (120,  'dried parsley - so high in nutrients', v_class, 'personal', 'Salts', 120, v_src_salts),
  (76,   'fennel seeds - excellent as a carminative', v_class, 'personal', 'Salts', 130, v_src_salts),

  -- GENERAL RECOMMENDATIONS (standalone bullets between Salts and Herbal Broth Recipe)
  (225,  'Astragalus is so potent in moistening, it can push the body to dampness; so if acute conditions, can drive the infection deeper into the tissues', v_class, 'personal', 'General Recommendations', 140, v_src_gen_recs),
  (70,   'Neti pot: add Calendula tea as the liquid, if infection', v_class, 'personal', 'General Recommendations', 150, v_src_gen_recs),
  (309,  'Neti pot: add Yerba Mansa tea as the liquid, if infection', v_class, 'personal', 'General Recommendations', 160, v_src_gen_recs),

  -- HERBAL BROTH RECIPE
  (226,  '1/4 c dried shiitake mushrooms in herbal broth recipe', v_class, 'personal', 'Herbal Broth Recipe', 170, v_src_broth_rec),
  (225,  '2 astragalus sticks in herbal broth recipe', v_class, 'personal', 'Herbal Broth Recipe', 180, v_src_broth_rec),
  (1528, '2 jujube dates in herbal broth recipe', v_class, 'personal', 'Herbal Broth Recipe', 190, v_src_broth_rec),
  (748,  '2 T dried orange peel - stimulating bitter, aromatic - in herbal broth recipe', v_class, 'personal', 'Herbal Broth Recipe', 200, v_src_broth_rec),

  -- HERBAL SALT RECIPE
  (43,   '1P Nettle in herbal salt recipe', v_class, 'personal', 'Herbal Salt Recipe', 210, v_src_salt_rec),
  (109,  '2P Rosemary in herbal salt recipe', v_class, 'personal', 'Herbal Salt Recipe', 220, v_src_salt_rec),
  (885,  '1P Alfalfa in herbal salt recipe', v_class, 'personal', 'Herbal Salt Recipe', 230, v_src_salt_rec),
  (59,   '1P Thyme (or Oregano) in herbal salt recipe', v_class, 'personal', 'Herbal Salt Recipe', 240, v_src_salt_rec),
  (406,  '1P Oregano (or Thyme) in herbal salt recipe', v_class, 'personal', 'Herbal Salt Recipe', 250, v_src_salt_rec),

  -- VITAMIN A (herbs as sources)
  (1595, 'nutmeg - richest spice in Vitamin A / Beta carotene', v_class, 'personal', 'Vitamin A', 260, v_src_vita),
  (91,   'fenugreek seeds - source of Vitamin A / Beta carotene', v_class, 'personal', 'Vitamin A', 270, v_src_vita),
  (420,  'basil - smaller source of Vitamin A / Beta carotene', v_class, 'personal', 'Vitamin A', 280, v_src_vita),
  (56,   'sage - smaller source of Vitamin A / Beta carotene', v_class, 'personal', 'Vitamin A', 290, v_src_vita),
  (100,  'coriander - smaller source of Vitamin A / Beta carotene', v_class, 'personal', 'Vitamin A', 300, v_src_vita),

  -- VITAMIN B (herbs as sources)
  (43,   'Nettle contains B vitamins B1, B2, B3, B5, B6, B9', v_class, 'personal', 'Vitamin B', 310, v_src_vitb),
  (42,   'Red Clover contains B vitamins B1, B2, B6 + inositol', v_class, 'personal', 'Vitamin B', 320, v_src_vitb),
  (885,  'Alfalfa contains B vitamins B1, B2, B3, B5, B6, B9, B12', v_class, 'personal', 'Vitamin B', 330, v_src_vitb),

  -- VITAMIN C (herbs as sources)
  (849,  'Rosehips - rich source of Vitamin C', v_class, 'personal', 'Vitamin C', 340, v_src_vitc),
  (120,  'Parsley - source of Vitamin C', v_class, 'personal', 'Vitamin C', 350, v_src_vitc),
  (2233, 'Hibiscus flowers - source of Vitamin C', v_class, 'personal', 'Vitamin C', 360, v_src_vitc),
  (43,   'Nettles - source of Vitamin C', v_class, 'personal', 'Vitamin C', 370, v_src_vitc),
  (73,   'Hawthorn berries - source of Vitamin C', v_class, 'personal', 'Vitamin C', 380, v_src_vitc),

  -- IRON TONIC SYRUP (herbs)
  (43,   'Nettle leaf 4 tbsp in Iron Tonic Syrup; has enough Vit C to metabolize iron', v_class, 'personal', 'Iron', 390, v_src_iron),
  (885,  'Alfalfa 3 tbsp in Iron Tonic Syrup', v_class, 'personal', 'Iron', 400, v_src_iron),
  (155,  'Raspberry Leaf 2 tbsp in Iron Tonic Syrup', v_class, 'personal', 'Iron', 410, v_src_iron),
  (37,   'Yellow Dock root 1 tbsp in Iron Tonic Syrup; in there for people who tend toward constipation, can omit if not constipated', v_class, 'personal', 'Iron', 420, v_src_iron),
  (73,   'Hawthorn berries 1 tbsp in Iron Tonic Syrup', v_class, 'personal', 'Iron', 430, v_src_iron),
  (849,  'Rose hips 1 tsp in Iron Tonic Syrup', v_class, 'personal', 'Iron', 440, v_src_iron),

  -- WARMING HERBS
  (20,   'ashwagandha - warming herb; stimulates metabolism, increases vitality and blood flow; for pale, slow, weak, deficient', v_class, 'personal', 'Warming Herbs', 450, v_src_warming),
  (14,   'ginsengs - warming herbs', v_class, 'personal', 'Warming Herbs', 460, v_src_warming),
  (124,  'ginger - warming herb', v_class, 'personal', 'Warming Herbs', 470, v_src_warming),
  (109,  'rosemary - warming herb', v_class, 'personal', 'Warming Herbs', 480, v_src_warming),
  (59,   'thyme - warming herb', v_class, 'personal', 'Warming Herbs', 490, v_src_warming),
  (47,   'cayenne - warming herb', v_class, 'personal', 'Warming Herbs', 500, v_src_warming),
  (21,   'garlic - warming herb', v_class, 'personal', 'Warming Herbs', 510, v_src_warming),
  (851,  'maca - warming herb, libido enhancer', v_class, 'personal', 'Warming Herbs', 520, v_src_warming),
  (309,  'yerba mansa - warming herb, anything sinus related', v_class, 'personal', 'Warming Herbs', 530, v_src_warming),
  (203,  'turmeric - warming herb', v_class, 'personal', 'Warming Herbs', 540, v_src_warming),
  (99,   'myrrh - resin; very heating and anti-inflammatory; joint pain; used in low part of a formula', v_class, 'personal', 'Warming Herbs', 550, v_src_warming),

  -- COOLING HERBS
  (983,  'blue vervain - cooling; all bitters except Orange peel and angelica; NS related, relaxing; "type A people will die with a to do list"', v_class, 'personal', 'Cooling Herbs', 560, v_src_cooling),
  (849,  'rosehips - cooling herb', v_class, 'personal', 'Cooling Herbs', 570, v_src_cooling),
  (134,  'lemon balm - cooling herb', v_class, 'personal', 'Cooling Herbs', 580, v_src_cooling),
  (198,  'violet leaf - cooling herb', v_class, 'personal', 'Cooling Herbs', 590, v_src_cooling),
  (78,   'licorice - cooling herb', v_class, 'personal', 'Cooling Herbs', 600, v_src_cooling),
  (320,  'peach leaf - cooling, underused; helps for nausea, anything hot; topical for bee stings and bug bites', v_class, 'personal', 'Cooling Herbs', 610, v_src_cooling),

  -- DRYING HERBS
  (190,  'Vitex (Chasteberry) - drying herb', v_class, 'personal', 'Drying Herbs', 620, v_src_drying),
  (43,   'nettle - drying herb', v_class, 'personal', 'Drying Herbs', 630, v_src_drying),
  (124,  'ginger - drying herb', v_class, 'personal', 'Drying Herbs', 640, v_src_drying),
  (2643, 'pine - drying herb', v_class, 'personal', 'Drying Herbs', 650, v_src_drying),
  (16,   'rhodiola - drying herb; improves stamina, hormones (+ shatavari maybe to moisten)', v_class, 'personal', 'Drying Herbs', 660, v_src_drying),
  (850,  'rose petals - drying herb', v_class, 'personal', 'Drying Herbs', 670, v_src_drying),
  (109,  'rosemary - drying herb', v_class, 'personal', 'Drying Herbs', 680, v_src_drying),
  (590,  'yerba santa - drying herb', v_class, 'personal', 'Drying Herbs', 690, v_src_drying),

  -- MOISTENING HERBS
  (852,  'shatavari - moistening herb; traditionally a decoction, not a tincture', v_class, 'personal', 'Moistening Herbs', 700, v_src_moistening),
  (45,   'marshmallow - moistening herb', v_class, 'personal', 'Moistening Herbs', 710, v_src_moistening),
  (198,  'violet leaf - moistening herb', v_class, 'personal', 'Moistening Herbs', 720, v_src_moistening),
  (202,  'aloe - moistening herb', v_class, 'personal', 'Moistening Herbs', 730, v_src_moistening),
  (78,   'licorice - moistening herb', v_class, 'personal', 'Moistening Herbs', 740, v_src_moistening),
  (178,  'oat - moistening herb', v_class, 'personal', 'Moistening Herbs', 750, v_src_moistening),
  (85,   'plantain - moistening herb', v_class, 'personal', 'Moistening Herbs', 760, v_src_moistening),
  (61,   'mullein - moistening herb', v_class, 'personal', 'Moistening Herbs', 770, v_src_moistening),

  -- SIGNS OF LAXNESS (herbs)
  (85,   'Plantain - superstar for the GI; specific for signs of laxness', v_class, 'personal', 'Signs of Laxness', 780, v_src_laxness),
  (17,   'Schizandra - specific for excess discharges; used for signs of laxness', v_class, 'personal', 'Signs of Laxness', 790, v_src_laxness),
  (1252, 'Solomon''s Seal - loosens what''s too tight and tightens what''s too loose; specific for musculoskeletal', v_class, 'personal', 'Signs of Laxness', 800, v_src_laxness),

  -- CONSTRICTING HERBS
  (85,   'plantain - constricting herb (tannins); for leaky tissues that secrete fluids such as blood or mucus', v_class, 'personal', 'Constricting Herbs', 810, v_src_constricting),
  (153,  'oak - constricting herb (tannins)', v_class, 'personal', 'Constricting Herbs', 820, v_src_constricting),
  (850,  'rose - constricting herb (tannins)', v_class, 'personal', 'Constricting Herbs', 830, v_src_constricting),
  (79,   'witch hazel - constricting herb (tannins)', v_class, 'personal', 'Constricting Herbs', 840, v_src_constricting),
  (44,   'yarrow - constricting herb (tannins)', v_class, 'personal', 'Constricting Herbs', 850, v_src_constricting),
  (155,  'raspberry leaf - constricting herb (tannins); uterine tonic; more helpful to take all cycle long than just acutely', v_class, 'personal', 'Constricting Herbs', 860, v_src_constricting),
  (71,   'shepherd''s purse - constricting herb (tannins); specific for stopping bleeding', v_class, 'personal', 'Constricting Herbs', 870, v_src_constricting),

  -- RELAXING HERBS
  (853,  'silk tassel - relaxing herb; relax muscle cramps and spasms, tension in the muscles', v_class, 'personal', 'Relaxing Herbs', 880, v_src_relaxing),
  (136,  'catnip - relaxing herb', v_class, 'personal', 'Relaxing Herbs', 890, v_src_relaxing),
  (138,  'kava kava - relaxing herb', v_class, 'personal', 'Relaxing Herbs', 900, v_src_relaxing),

  -- FLAVORS (intro / horsetail)
  (151,  'horsetail → salty', v_class, 'personal', 'Flavors', 910, v_src_flavors),

  -- SALTY HERBS
  (885,  'alfalfa - salty herb; nutritive, mineralizing, diuretic, lymphatic; balances fluids, restores electrolytes, nourishes kidney and bladder', v_class, 'personal', 'Salty Herbs', 920, v_src_salty),
  (88,   'chickweed - salty herb', v_class, 'personal', 'Salty Herbs', 930, v_src_salty),
  (43,   'nettle - salty herb; nutritive, mineralizing', v_class, 'personal', 'Salty Herbs', 940, v_src_salty),
  (42,   'red clover - salty herb', v_class, 'personal', 'Salty Herbs', 950, v_src_salty),

  -- SOUR HERBS
  (2233, 'hibiscus → sour; cooling, astringing; antioxidant, tonic, hepatic; fruit acids, flavanoids, antioxidants', v_class, 'personal', 'Sour Herbs', 960, v_src_sour),
  (73,   'hawthorn - sour herb; cooling, astringing; tonifies tissues, protects against oxidative stress, supports the liver', v_class, 'personal', 'Sour Herbs', 970, v_src_sour),
  (849,  'rosehips - sour herb; cooling, astringing', v_class, 'personal', 'Sour Herbs', 980, v_src_sour),
  (17,   'schisandra - sour herb; cooling, astringing', v_class, 'personal', 'Sour Herbs', 990, v_src_sour),

  -- BITTER HERBS
  (115,  'mugwort → bitter; try a cold infusion, fresh or dry; add marshmallow, chamomile or lemon balm; downward, grounding, drying, and clearing action', v_class, 'personal', 'Bitter Herbs', 1000, v_src_bitter),
  (102,  'gentian - bitter herb; stimulates bile, increases appetite and helps with digestion, elimination', v_class, 'personal', 'Bitter Herbs', 1010, v_src_bitter),
  (172,  'artichoke leaf - bitter, subtle', v_class, 'personal', 'Bitter Herbs', 1020, v_src_bitter),
  (97,   'wormwood - bitter herb, gnarly', v_class, 'personal', 'Bitter Herbs', 1030, v_src_bitter),
  (122,  'dandelion root - bitter herb', v_class, 'personal', 'Bitter Herbs', 1040, v_src_bitter),
  (983,  'blue vervain - bitter herb', v_class, 'personal', 'Bitter Herbs', 1050, v_src_bitter),
  (131,  'motherwort - bitter herb', v_class, 'personal', 'Bitter Herbs', 1060, v_src_bitter),
  (84,   'chamomile - bitter herb; add to mugwort cold infusion to balance', v_class, 'personal', 'Bitter Herbs', 1070, v_src_bitter),
  (33,   'Oregon Grape Root - bitter herb', v_class, 'personal', 'Bitter Herbs', 1080, v_src_bitter),
  (65,   'angelica - bitter herb', v_class, 'personal', 'Bitter Herbs', 1090, v_src_bitter),
  (45,   'marshmallow - add to mugwort cold infusion to temper bitterness', v_class, 'personal', 'Bitter Herbs', 1100, v_src_bitter),
  (134,  'lemon balm - add to mugwort cold infusion to temper bitterness', v_class, 'personal', 'Bitter Herbs', 1110, v_src_bitter),

  -- SWEET HERBS
  (225,  'astragalus → sweet; nourishes and builds tissues; polysaccharides, saponins; adaptogenic, immune enhancing', v_class, 'personal', 'Sweet Herbs', 1120, v_src_sweet),
  (78,   'licorice - sweet herb; demulcent, tonic, adaptogenic', v_class, 'personal', 'Sweet Herbs', 1130, v_src_sweet),
  (11,   'reishi mushroom - sweet herb (most mushrooms have a sweet aftertaste)', v_class, 'personal', 'Sweet Herbs', 1140, v_src_sweet),
  (14,   'ginsengs - sweet herbs; nourish and build tissues', v_class, 'personal', 'Sweet Herbs', 1150, v_src_sweet),
  (45,   'marshmallow - sweet herb; moistening, demulcent, tonic', v_class, 'personal', 'Sweet Herbs', 1160, v_src_sweet),
  (22,   'burdock - sweet herb; nourishes and builds tissues', v_class, 'personal', 'Sweet Herbs', 1170, v_src_sweet),
  (223,  'rehmannia - sweet herb; grounding and calming', v_class, 'personal', 'Sweet Herbs', 1180, v_src_sweet),

  -- PUNGENT HERBS
  (109,  'rosemary → pungent; stimulates digestion, circulation and metabolism; circulatory & digestive stimulant, diaphoretic; resins, monoterpenes', v_class, 'personal', 'Pungent Herbs', 1190, v_src_pungent),
  (124,  'ginger - pungent herb; stimulates digestion, circulation and metabolism', v_class, 'personal', 'Pungent Herbs', 1200, v_src_pungent),
  (21,   'garlic - pungent herb', v_class, 'personal', 'Pungent Herbs', 1210, v_src_pungent),
  (111,  'clove - pungent herb', v_class, 'personal', 'Pungent Herbs', 1220, v_src_pungent),
  (113,  'horseradish - pungent herb', v_class, 'personal', 'Pungent Herbs', 1230, v_src_pungent),
  (59,   'thyme - pungent herb', v_class, 'personal', 'Pungent Herbs', 1240, v_src_pungent),
  (127,  'cardamom - pungent herb; digestive stimulant', v_class, 'personal', 'Pungent Herbs', 1250, v_src_pungent),
  (123,  'prickly ash - pungent herb; circulatory stimulant', v_class, 'personal', 'Pungent Herbs', 1260, v_src_pungent),
  (26,   'echinacea - pungent herb', v_class, 'personal', 'Pungent Herbs', 1270, v_src_pungent),

  -- SCHISANDRA
  (17,   'Schisandra - the 5 flavor berry; liver protective like milk thistle; focus, clarity; zing and confidence; helps regulate cortisol; balances energy; associated with longevity and beauty in TCM; works on the liver; eat a couple berries in the morning', v_class, 'personal', 'Schisandra', 1280, v_src_schisandra);

  -- =========================================================
  -- SUPPLEMENT SNIPPETS
  -- =========================================================
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (1,  'Vitamin A (Beta carotene from food): helps form and maintain healthy teeth, bones, soft tissue, mucus membranes, skin, retinal tissue; don''t supplement with pure Vit A, supplement with Beta carotene due to toxicity risk', v_class, 'personal', 'Vitamin A', 305, v_src_vita),
  (41, 'Beta-Carotene: safer supplement form of Vitamin A; excess alcohol can deplete; richest spice source is nutmeg', v_class, 'personal', 'Vitamin A', 306, v_src_vita),
  (2,  'B1 = Thiamine: helps cells be responsive to changes in the body and exert their autonomy', v_class, 'personal', 'Vitamin B', 335, v_src_vitb),
  (3,  'B2 = Riboflavin: important for production of red blood cells (anemia), growth', v_class, 'personal', 'Vitamin B', 336, v_src_vitb),
  (4,  'B3 = Niacin: important for skin and nerves, helps body metabolize triglycerides', v_class, 'personal', 'Vitamin B', 337, v_src_vitb),
  (5,  'B5 = Pantothenic Acid: role in production of cholesterol, therefore hormones', v_class, 'personal', 'Vitamin B', 338, v_src_vitb),
  (6,  'B6 = Pyridoxine: brain function, red blood cells; necessary for metabolism of proteins', v_class, 'personal', 'Vitamin B', 339, v_src_vitb),
  (7,  'B7 = Biotin: protein and carb metabolism; metabolizes cholesterol therefore supports hormone production', v_class, 'personal', 'Vitamin B', 340, v_src_vitb),
  (8,  'B9 = Folate: helps form red blood cells, needed for DNA production, tissue growth; deficiency can cause birth defects; low levels associated with cognitive decline; role in methylation (liver detox pathway)', v_class, 'personal', 'Vitamin B', 341, v_src_vitb),
  (9,  'B12 = Cobalamin: supports metabolism including methylation, formation of RBC, maintains CNS and PNS', v_class, 'personal', 'Vitamin B', 342, v_src_vitb),
  (10, 'Vitamin C: antioxidant; promotes healthy teeth and gums and integument (skin+); helps body absorb iron; essential for wound healing and post-surgical care', v_class, 'personal', 'Vitamin C', 385, v_src_vitc),
  (11, 'Vitamin D: helps body absorb calcium for healthy teeth and bones; blood levels of calcium and phosphorus; North American sun angle insufficient; levels should be around 70; recommended dose 3000 IU/day; combo with Vit K can increase insulin sensitivity and support blood sugar homeostasis', v_class, 'personal', 'Vitamin D', 386, v_src_vitd),
  (12, 'Vitamin E: antioxidant; helps body form RBC; helps body use Vit K; fat soluble, pay attention to dose', v_class, 'personal', 'Vitamin E', 387, v_src_vite),
  (13, 'Vitamin K: needed for blood coagulation; important for bone health; synergistic with Vit D', v_class, 'personal', 'Vitamin K', 388, v_src_vitk),
  (23, 'Selenium: antioxidant; lean into for any thyroid disorders; associated with fibroids and endometriosis; therapy for PCOS', v_class, 'personal', 'Selenium', 389, v_src_selenium),
  (24, 'Zinc: related to poor immune function; associated with fibroids and endometriosis; think of for chronic low immunity or repro problems', v_class, 'personal', 'Zinc', 390, v_src_zinc),
  (19, 'Iron: requires Vitamin C to absorb; most common supplement (Ferrous Sulfate) is extremely constipating; prefer a syrup containing Vitamin C; 2T/day; careful of bioaccumulation if not enough Vit C in diet', v_class, 'personal', 'Iron', 391, v_src_iron);

  -- =========================================================
  -- HERB KEYWORDS
  -- =========================================================
  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Calendula
  (70,  'vulnerary',              'action'),
  (70,  'lymphatic',              'action'),
  (70,  'mucous membrane support','ailment'),
  (70,  'immune support',         'ailment'),
  (70,  'sinus infection',        'ailment'),
  -- Oregano
  (406, 'antimicrobial',          'action'),
  -- Thyme
  (59,  'antimicrobial',          'action'),
  -- Rosemary
  (109, 'antimicrobial',          'action'),
  (109, 'circulatory stimulant',  'action'),
  (109, 'digestive stimulant',    'action'),
  -- Nettle
  (43,  'mineral support',        'ailment'),
  (43,  'iron deficiency',        'ailment'),
  (43,  'anemia',                 'ailment'),
  -- Reishi
  (11,  'immune support',         'ailment'),
  -- Alfalfa
  (885, 'estrogen support',       'ailment'),
  (885, 'mineral support',        'ailment'),
  (885, 'kidney support',         'ailment'),
  -- Red Clover
  (42,  'mineral support',        'ailment'),
  -- Parsley
  (120, 'mineral support',        'ailment'),
  -- Fennel
  (76,  'carminative',            'action'),
  (76,  'digestive tonic',        'ailment'),
  -- Astragalus
  (225, 'immune support',         'ailment'),
  (225, 'adaptogen',              'action'),
  -- Yerba Mansa
  (309, 'sinus infection',        'ailment'),
  (309, 'antimicrobial',          'action'),
  -- Maca
  (851, 'low libido',             'ailment'),
  -- Myrrh
  (99,  'arthritis',              'ailment'),
  (99,  'inflammation',           'ailment'),
  (99,  'anti-inflammatory',      'action'),
  -- Blue Vervain
  (983, 'nervous system support', 'action'),
  (983, 'stress',                 'ailment'),
  (983, 'depression',             'ailment'),
  (983, 'bitter tonic',           'action'),
  -- Lemon Balm
  (134, 'stress',                 'ailment'),
  (134, 'anxiety',                'ailment'),
  -- Peach leaf
  (320, 'nausea',                 'symptom'),
  (320, 'insect bites',           'ailment'),
  -- Yellow Dock
  (37,  'iron deficiency',        'ailment'),
  (37,  'anemia',                 'ailment'),
  (37,  'constipation',           'symptom'),
  -- Raspberry leaf
  (155, 'uterine tonic',          'action'),
  (155, 'heavy bleeding',         'ailment'),
  -- Rose hips (849)
  (849, 'iron deficiency',        'ailment'),
  (849, 'anemia',                 'ailment'),
  (849, 'wound healing',          'ailment'),
  -- Hawthorn (73)
  (73,  'iron deficiency',        'ailment'),
  (73,  'liver support',          'ailment'),
  (73,  'antioxidant',            'action'),
  -- Rhodiola
  (16,  'fatigue',                'ailment'),
  (16,  'energy support',         'ailment'),
  (16,  'hormonal support',       'ailment'),
  (16,  'adaptogen',              'action'),
  -- Shatavari
  (852, 'reproductive support',   'ailment'),
  -- Solomon's Seal
  (1252,'musculoskeletal',        'general'),
  (1252,'connective tissue disorders','ailment'),
  (1252,'joint mobility',         'ailment'),
  -- Shepherd's Purse
  (71,  'heavy bleeding',         'ailment'),
  (71,  'hemostatic',             'action'),
  -- Oak
  (153, 'heavy bleeding',         'ailment'),
  (153, 'astringent',             'action'),
  -- Witch Hazel
  (79,  'heavy bleeding',         'ailment'),
  (79,  'astringent',             'action'),
  -- Silk Tassel
  (853, 'muscle spasms',          'ailment'),
  (853, 'anti-spasmodic',         'action'),
  -- Catnip
  (136, 'muscle spasms',          'ailment'),
  (136, 'anti-spasmodic',         'action'),
  -- Kava
  (138, 'muscle spasms',          'ailment'),
  (138, 'anxiety',                'ailment'),
  (138, 'nervine',                'action'),
  -- Horsetail
  (151, 'mineral support',        'ailment'),
  (151, 'kidney support',         'ailment'),
  -- Hibiscus (sour)
  (2233,'liver support',          'ailment'),
  (2233,'antioxidant',            'action'),
  -- Schizandra
  (17,  'liver support',          'ailment'),
  (17,  'stress',                 'ailment'),
  (17,  'hormonal support',       'ailment'),
  (17,  'hepatoprotective',       'action'),
  -- Mugwort
  (115, 'digestive tonic',        'ailment'),
  (115, 'bile flow',              'ailment'),
  (115, 'bitter tonic',           'action'),
  -- Gentian
  (102, 'digestive tonic',        'ailment'),
  (102, 'bile flow',              'ailment'),
  (102, 'bitter tonic',           'action'),
  -- Artichoke
  (172, 'digestive tonic',        'ailment'),
  (172, 'bile flow',              'ailment'),
  (172, 'liver support',          'ailment'),
  (172, 'bitter tonic',           'action'),
  -- Wormwood
  (97,  'digestive tonic',        'ailment'),
  (97,  'bile flow',              'ailment'),
  (97,  'bitter tonic',           'action'),
  -- Dandelion root
  (122, 'digestive tonic',        'ailment'),
  (122, 'bile flow',              'ailment'),
  (122, 'liver support',          'ailment'),
  (122, 'bitter tonic',           'action'),
  -- Oregon Grape Root
  (33,  'digestive tonic',        'ailment'),
  (33,  'liver support',          'ailment'),
  (33,  'antimicrobial',          'action'),
  (33,  'bitter tonic',           'action'),
  -- Angelica
  (65,  'digestive tonic',        'ailment'),
  (65,  'carminative',            'action'),
  -- Motherwort
  (131, 'bitter tonic',           'action'),
  -- Chamomile
  (84,  'digestive tonic',        'ailment'),
  (84,  'bitter tonic',           'action'),
  -- Rehmannia
  (223, 'nervous system support', 'action'),
  -- Prickly Ash
  (123, 'poor circulation',       'ailment'),
  (123, 'circulatory stimulant',  'action'),
  -- Ginger (pungent)
  (124, 'digestive stimulant',    'action'),
  (124, 'carminative',            'action'),
  -- Chickweed
  (88,  'mineral support',        'ailment')
  ON CONFLICT (herb_id, keyword) DO NOTHING;

  -- =========================================================
  -- SUPPLEMENT KEYWORDS
  -- =========================================================
  INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (1,  'malabsorption',            'ailment'),
  (41, 'malabsorption',            'ailment'),
  (8,  'cognitive support',        'ailment'),
  (8,  'methylation support',      'action'),
  (8,  'anemia',                   'ailment'),
  (9,  'anemia',                   'ailment'),
  (9,  'cognitive support',        'ailment'),
  (9,  'methylation support',      'action'),
  (10, 'wound healing',            'ailment'),
  (10, 'iron deficiency',          'ailment'),
  (10, 'antioxidant',              'action'),
  (11, 'bone density',             'ailment'),
  (11, 'blood sugar dysregulation','ailment'),
  (11, 'malabsorption',            'ailment'),
  (12, 'antioxidant',              'action'),
  (13, 'bone density',             'ailment'),
  (23, 'hypothyroidism',           'ailment'),
  (23, 'hyperthyroidism',          'ailment'),
  (23, 'fibroids',                 'ailment'),
  (23, 'endometriosis',            'ailment'),
  (23, 'PCOS',                     'ailment'),
  (23, 'antioxidant',              'action'),
  (24, 'immune support',           'ailment'),
  (24, 'fibroids',                 'ailment'),
  (24, 'endometriosis',            'ailment'),
  (19, 'iron deficiency',          'ailment'),
  (19, 'anemia',                   'ailment'),
  (19, 'fatigue',                  'ailment')
  ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

  -- =========================================================
  -- NEW AILMENT SEARCH TERMS
  -- =========================================================
  INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('sinus infection',  ARRAY['sinusitis', 'sinus congestion', 'sinus inflammation', 'nasal infection', 'rhinosinusitis', 'sinus pressure']),
  ('low libido',       ARRAY['decreased libido', 'loss of sex drive', 'low sex drive', 'decreased sexual desire', 'loss of libido'])
  ON CONFLICT (ailment_keyword) DO NOTHING;

END $MIGRATION$;
