-- Migration 311: BHC Class 36 - Constitution I — snippets, keywords
-- Source file parsed: BHC - Class 36 - Constitution I - Lisa.md (personal notes only;
--   no Generated Notes file exists for this class; Transcript ignored per playbook)
-- class_name: 'BHC - Class 36 - Constitution I'
--
-- Herb name normalisations:
--   Dong quai              → Dong Quai (Angelica sinensis, id=1009)
--   Nettles/nettle         → Nettle (Urtica dioica, leaf, id=43)
--   SJW                    → St. John's Wort (Hypericum perforatum, id=81)
--   OGR                    → Oregon Grape (Mahonia aquifolium, id=33)
--   Schisandra             → Schizandra (id=17)
--   Eleuthero/eluthero     → Siberian Ginseng (id=9)
--   Ginsengs (general)     → Ginseng (Panax ginseng, id=14) as representative
--   Sars                   → Sarsaparilla (id=40)
--   Baptisia               → Wild Indigo (id=23)
--   Anemone                → Pasqueflower (Pulsatilla vulgaris, id=36)
--   Aralia                 → California Spikenard (Aralia californica, id=579)
--   Stilingia/Queen's root → Queen's Delight (Stillingia sylvatica, id=41)
--   Silktassel/sil tassel  → Silk Tassel (Garrya fremontii, id=853)
--   Buckbean               → Bogbean (Menyanthes trifoliata, id=34)
--   Rubus spp.             → Raspberry (Rubus idaeus, leaf, id=155)
--   Marsh root             → Marshmallow (Althaea officinalis, id=45)
--   Turkey rhubarb         → Rhubarb (Rheum palmatum, id=154)
--   Bugelweed/bugle weed   → Bugleweed (Lycopus spp., id=133)
--   Iris all spp.          → Blue Flag (Iris versicolor, id=31)
--   Orange peel            → Sweet Orange (Citrus sinensis, id=748)
--   Kola nut               → Kola Nut (Cola vera, id=615)
--   Vitex                  → Chasteberry (id=190)
--   Thuja/red cedar        → Thuja (id=201)
--   Little black cohosh / little poke = small doses; coded to same herb
--   Yelow palm lily / yellow pond lily → Yellow Pond Lily (new, Nuphar lutea)
--   Trillian               → Trillium (new, Trillium spp.)
--
-- New herbs added (not previously in DB):
--   Trillium (Trillium spp.) — reproductive excess (male and female)
--   Yellow Pond Lily (Nuphar lutea) — reproductive excess (male and female)
--   Wild Ginger (Asarum canadense) — circ stimulant, reproductive and cardiovascular
--     (distinct from Chinese Wild Ginger, Herba Asari, TCM herb id=1625)
--
-- Herbs skipped (not appropriate to add or no DB entry):
--   Aristolochia — toxic; omitted
--   Cured Aconite — processed TCM preparation; omitted
--   Vinca (periwinkle) — noted as "dreaded invasive"; omitted
--   Dogbane (Apocynum), Asclepias — audio-only references, not in DB; omitted
--   Acacia — food-grade gum, not a BHC herb; omitted
--   Dietary spices (asafoetida, celery seed, dill seed, sumac) — dietary recommendations, not herbs prescribed
--   Coptis (TCM, id=1561) — mentioned in berberine list but in TCM context; omitted from Western clinical snippets
--
-- Keyword merge decisions:
--   "adrenal depletion" / "HPA dysregulation" → merged into existing 'adrenal fatigue'
--   "tension headaches" → merged into existing 'headache'
--   "muscle tightness" → merged into existing 'muscle spasms'
--   "lowered immunity" → merged into existing 'immune deficiency' / 'immune support'
-- No new ailment_search_terms needed: all ailment keywords used already exist in DB.

SET search_path TO herbal, public;

-- ── 1. ENSURE NEW HERBS ───────────────────────────────────────────────────
DO $$
BEGIN
  PERFORM herbal.ensure_herb('Trillium spp.', 'Trillium');
  PERFORM herbal.ensure_herb('Nuphar lutea', 'Yellow Pond Lily');
  PERFORM herbal.ensure_herb('Asarum canadense', 'Wild Ginger');
  RAISE NOTICE 'Ensured new herbs: Trillium, Yellow Pond Lily, Wild Ginger.';
END $$;

-- ── 2. SNIPPETS ───────────────────────────────────────────────────────────
DO $$
DECLARE
  v_trillium_id    INTEGER;
  v_pond_lily_id   INTEGER;
  v_wild_ginger_id INTEGER;

  v_src_cold       TEXT;
  v_src_dry        TEXT;
  v_src_hot        TEXT;
  v_src_wet        TEXT;
  v_src_thompson   TEXT;
  v_src_upper_gi   TEXT;
  v_src_lower_gi   TEXT;
  v_src_liver      TEXT;
  v_src_kidneys    TEXT;
  v_src_repro_f    TEXT;
  v_src_repro_m    TEXT;
  v_src_resp       TEXT;
  v_src_cardio     TEXT;
  v_src_lymph      TEXT;
  v_src_skin       TEXT;
  v_src_msk        TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 36 - Constitution I') THEN
    RAISE NOTICE 'Class 36 snippets already loaded, skipping';
    RETURN;
  END IF;

  SELECT id INTO v_trillium_id    FROM herbal.herbs WHERE latin_name = 'Trillium spp.';
  SELECT id INTO v_pond_lily_id   FROM herbal.herbs WHERE latin_name = 'Nuphar lutea';
  SELECT id INTO v_wild_ginger_id FROM herbal.herbs WHERE latin_name = 'Asarum canadense';

  -- Source blocks (verbatim section text, condensed to clinical content)
  v_src_cold := '### Cold
- physical: cold extremities, poor circulation, stiffness in joints, constipation, slow metabolism, slow to break a sweat
- emotionally: fearful (yeah but, what if), sorry syndrome, rigidity, strict boundaries, contractive - hard to speak their truth
- care for cold: warm and wet foods, porridges/soups/stews, warming spices (cayenne, ginger, cinnamon), fermented foods
- herbs:
    - Blood building: Dong quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice
        - (Nettles - no, because cooling and drying)
    - Circ stimulants (blood and lymph): Dong quai, Prickly Ash, Cayenne, Poke root (lymph), Calendula (lymph), Ocotillo (lymph)
    - Alteratives: Burdock, Slippery Elm, Marshmallow root with Cinnamon or Cardamom
- Tulsi: hormone balancer, tissue protective in face of microbes/toxin/stress, nourish to repro organs
- Ginger: heats up and stimulates the migrating motor complex of the small intestine; big impacts on cold bodies; warms internal organs (liver, lungs); David Hoffman → blood to extremities; Lisa → heat for internal organs';

  v_src_dry := '### Dry
- physical: dry hair/skin/nails, constipation, adrenal depletion, kidney impacts, low back pain, frequent urination, irregular breathing, sleep apnea
- emotionally: anxiety, indecision, hyperactivity, lots of balls in the air
- care for dry: sweet and salty flavors; moistening spices (fenugreek, fennel, cinnamon, sumac); electrolytes and hydration
- herbs:
    - Lemon Balm, Alfalfa, Nettles (can be drying - use together with moistening, e.g. Lemon Balm), Red raspberry
    - Adaptogens (moistening): Shatavari, Schisandra, Ginsengs, Licorice
    - Nervines: Milky Oats, Kava
    - Demulcents: Marshmallow, Slippery Elm, Cinnamon, Cardamom
- Licorice: considered a model adaptogen; TCM - almost in every formula as harmonizer; exhaustion and debility; improves insulin resistance; cortisol modulator; supportive of HPA dysregulation (survival mode → overdrive → exhaustion); immune modulating; supports anabolic activity (building tissue, muscle, baby); has influence on every body system';

  v_src_hot := '### Hot
- physical: chronic inflammation, chronic migraines, allergies, arthritis, asthma, loose stools (can lead to leaky gut long-term)
- emotionally: opinionated, perfectionist, quick to anger
- care for hot: cooling/raw foods, bitter and astringent flavors, cooling spices (cumin, coriander, fennel - classic triplet; fenugreek, dill); avoid ginger, cayenne, peppers
- herbs:
    - Alteratives (liver): Dandelion root, Chicory, Sarsaparilla, Sassafras, Licorice, Astragalus
    - Alteratives (lymph): Red Root, Cleavers, Calendula
    - Echinacea (alterative)
    - Hepatics: Turmeric, Milk Thistle, Artichoke leaf
    - Anti-inflammatory (AI): St. John''s Wort (SJW), Willow
    - Bitters: Gentian, Oregon Grape Root (hot-reducing, liver-supporting, alterative), Orange peel, Artichoke leaf
- Black Cohosh: classic arthritis/fibromyalgia plant; extreme muscle tension; tension headaches; PMS with tight squeezing cramps; muscle tightness with menopause; associated with chronic pain and negative self-talk; serotonin agonist (estrogen balance); melatonin production; works via pituitary influence on serotonin production; PMS with muscle pain and insomnia; consider before resorting to SSRIs';

  v_src_wet := '### Wet
- physical: mucus congestion (lungs/bowels/vaginal tissue), weight gain/edema, flatulence, pressurized stool, lowered immunity, lack of muscle tone, labored or mouth breathing
- emotionally: low self-esteem, poor boundaries, emotional eating, stuck in grief, depression
- care for wet: cleansing/raw foods (warm cleansing teas if wet and cold), sour/pungent/bitter flavors, spices (cumin, coriander, fennel, ginger, star anise, clove, oregano, thyme, sage)
- herbs:
    - Alteratives (waste eliminating): Burdock, Dandelion root, Sarsaparilla, Baptisia (Wild Indigo)
    - Circ stimulants: Ginger, Prickly Ash, Red Root, Hawthorn berry, Rosemary, Ginkgo
    - Adaptogens: Rhodiola, Ashwagandha (as long as not hot/wet), Schisandra berry
    - Bitters: all
- Reishi: protects against oxidative stress; adrenal and thyroid imbalance; wet can be part of metabolic syndrome (aging changes without changing diet - elevated lipids, weight gain, ankle swelling, visceral fat accumulation); helps body metabolize cortisol when stuck in overdrive; helps metabolize BPA and triclosan';

  v_src_thompson := '### Thompson''s Standard Protocol
- Lobelia - stimulate digestion: purging → elimination of waste
- Cayenne - stoke the fire
- Bayberry (myrica) - berberine, more gentle removal of waste
- Barberry - enhance digestive secretions
- Cherry pits and Myrrh resin - restorative';

  v_src_upper_gi := '### Upper GI (Mouth, esophagus, stomach)
- Deficiency: insufficient fluids; insufficient bile and liver function
    - Stimulate secretions with berberine plants: Oregon Grape Root, Barberry, Gentian, Bogbean
    - Functional stimulants: Cayenne, Angelica, Prickly Ash, Ginseng
- Excess (cool the excess overproduction; protect mucosa):
    - Astringents, vasoconstrictors, AI, demulcents
    - Astringents: Sage, Bayberry, Rubus spp.
    - Demulcents: Marsh root (Marshmallow), Licorice, Comfrey root
    - With pain: Wild Yam, Fennel, Hops, Catnip, Silk Tassel';

  v_src_lower_gi := '### Lower GI
- Deficiency: abdominal distention (food moving slowly), hemorrhoids/varicosities from straining
    - Stimulate peristalsis (constipative/dry type): Buckbean (Bogbean), Cinnamon, Licorice, Yellow Dock
    - Stimulate congestive type (stagnation): Ocotillo, Fringetree, Yellow Dock
- Excess (soft stools = not all water reabsorbed; fermentation in gut):
    - Cinnamon (good for both deficiency and excess)
    - Bugleweed/Lycopis, Silk Tassel, Bayberry, Turkey rhubarb (rhubarb root)';

  v_src_liver := '### Liver
- Deficiency: dry skin and mucosa (needs sugars to operate), sugar cravings (often need more protein)
    - Stimulate liver metabolism (berberine plants): Iris all spp. (Blue Flag), Milk Thistle, Poke (extreme cases or small part of formula)
    - Improve fat absorption: Yellow Dock
    - Stimulate arterial circulation to liver: Prickly Ash
- Excess: fat and protein cravings, anabolic excess (more fluid on the bones)
    - Buffer blood with mineral-rich herbs: Red Clover, Red Raspberry leaf, Alfalfa, Lemon Balm, Nettles
      (decrease aggravating protein/red meat; pay attention to quality fats; increase vegetables)
    - Cool the anabolic tendency: Burdock, Bugleweed, Milk Thistle, Devil''s Club
    - Stimulate bile secretion without stimulating liver metabolism: Dandelion root, Artemisia vulgaris (Mugwort)';

  v_src_kidneys := '### Kidneys
- Deficiency: orthostatic hypotension (low blood volume; all fluid getting flushed out by kidneys)
    - Stimulate nephrons, support adrenals, improve hormonal stimulation:
      Dong Quai (improve renal blood supply and hormonal stimulation), Horsetail, Licorice, Ginsengs, Shepherd''s Purse
- Excess: holding salt and water (sometimes potassium), orthostatic hypertension
    - Dilate renal arteries
    - Metabolic cooler / diuretic cooler: Blue Flag (Iris), Burdock, Shepherd''s Purse, Horsetail, Dandelion leaf';

  v_src_repro_f := '### Reproductive - Female
- Deficiency (improve pelvic circulation, improve HPA relationship):
    - Anabolic stimulants: Dong Quai, Blue Cohosh, Licorice, White Peony, Ginsengs
    - Circ stimulants: Wild Ginger, Ocotillo, Black Cohosh, Poke (little poke)
    - Stimulate HPA: Motherwort, Damiana, Vitex, Anemone (Pasqueflower)
- Excess (short cycles < 24 days; cool the system):
    - Wild Yam, Yellow Pond Lily, Trillium, Black Haw, Cramp Bark
    - Anabolic coolers: Vitex, White Peony, Eleuthero (Siberian Ginseng)';

  v_src_repro_m := '### Reproductive - Male
- Deficiency (beer can influence sperm count; improve body use of hormone, pelvic circulation, HPA Axis):
    - Dong Quai, Licorice, White Peony, Ginsengs
    - Circ stimulants: Wild Ginger, Ocotillo, Poke (little), Black Cohosh (little)
- Excess (oiliness from excess testosterone):
    - Wild Yam, Yellow Pond Lily, Trillium, Viburnums (Cramp Bark, Black Haw)';

  v_src_resp := '### Respiratory
- Deficiency (increase cardiopulmonary function; address adrenaline stress):
    - Increase parasympathetic function: Pulsatilla (Pasqueflower), Lobelia (small doses)
    - Increase mucus secretion in tissues: Aralia (California Spikenard), Osha/Oshala
    - Stimulate lymph: Queen''s Delight (Stilingia / Queen''s root)
- Excess (cool excess overproduction; may be thyroid picture with hyperventilation under stress):
    - Mullein, Horsetail, Grindelia, Licorice, Wild Cherry';

  v_src_cardio := '### Cardiovascular
- Deficiency: thready or shallow pulse, mottled/mosaic skin pattern on thighs and upper arms
    - Stimulate cardiac output, stimulate parasympathetic energy, simple vasodilators:
      Ginkgo, Prickly Ash, Anemone (Pasqueflower), Ginger
    - Support excess in kidney or liver as contributing factor';

  v_src_lymph := '### Lymph / Immune
- Deficiency (stimulate immune system via lymph transport, bone marrow, innate immunity):
    - Lymphagogues: Red Root, Yerba Mansa, Ocotillo, Poke, Queen''s Delight (Stilingia)
    - Innate immunity: Marshmallow, Astragalus, Baptisia (Wild Indigo), Myrrh, Echinacea, Cypress
    - Support acquired immune function: Thuja (red cedar)
- Excess (autoimmune disorders):
    - Chinese Skullcap (Baikal Scutellaria) - cool mast cell activation, modulate immune system
    - Licorice';

  v_src_skin := '### Skin
- Deficiency (= liver deficiency symptoms; support liver, increase blood supply to skin):
    - Stimulate circulation: Calendula, Prickly Ash, Queen''s Delight (Stilingia), Goldenseal root
    - Stimulate liver: Oregon Grape Root, Panax Ginseng
- Excess (buildup of toxins; Ayurveda = toxin accumulation on body):
    - Cleansing, moving lymph, sweating, cupping, sloughing
    - Liver cooling: Dandelion root, Burdock root
    - Nerve cooling / decrease liver excitability: Nettles, Euphrasia (Eyebright)';

  v_src_msk := '### Musculoskeletal
- Deficiency (stimulate blood flow, sympathetic NS response, nerve tonics):
    - Kola Nut, Anemone (Pasqueflower), Panax Ginsengs
- Excess (disperse blood from musculature into viscera):
    - Muscle relaxants: Black Cohosh, Lobelia, Passionflower, Skullcap
    - Cool the sympathetic stress response: Milky Oats';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  -- ── COLD ──────────────────────────────────────────────────────────────────
    (1009,'Blood building herbs for cold constitution: Dong Quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice.','BHC - Class 36 - Constitution I','personal','Cold',10,v_src_cold),
    (20,  'Blood building herbs for cold constitution: Dong Quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice.','BHC - Class 36 - Constitution I','personal','Cold',20,v_src_cold),
    (134, 'Blood building herbs for cold constitution: Dong Quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice.','BHC - Class 36 - Constitution I','personal','Cold',30,v_src_cold),
    (885, 'Blood building herbs for cold constitution: Dong Quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice.','BHC - Class 36 - Constitution I','personal','Cold',40,v_src_cold),
    (2238,'Blood building herbs for cold constitution: Dong Quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice.','BHC - Class 36 - Constitution I','personal','Cold',50,v_src_cold),
    (78,  'Blood building herbs for cold constitution: Dong Quai, Ashwagandha, Lemon Balm, Alfalfa, White Peony, Licorice.','BHC - Class 36 - Constitution I','personal','Cold',60,v_src_cold),
    (43,  'Nettles NOT recommended for cold constitution — cooling and drying.','BHC - Class 36 - Constitution I','personal','Cold',70,v_src_cold),
    (1009,'Circ stimulants (blood and lymph) for cold constitution: Dong Quai, Prickly Ash, Cayenne, Poke root (lymph), Calendula (lymph), Ocotillo (lymph).','BHC - Class 36 - Constitution I','personal','Cold',80,v_src_cold),
    (123, 'Circ stimulants (blood and lymph) for cold constitution: Dong Quai, Prickly Ash, Cayenne, Poke root (lymph), Calendula (lymph), Ocotillo (lymph).','BHC - Class 36 - Constitution I','personal','Cold',90,v_src_cold),
    (47,  'Circ stimulants (blood and lymph) for cold constitution: Dong Quai, Prickly Ash, Cayenne, Poke root (lymph), Calendula (lymph), Ocotillo (lymph).','BHC - Class 36 - Constitution I','personal','Cold',100,v_src_cold),
    (35,  'Poke root as lymph stimulant for cold constitution.','BHC - Class 36 - Constitution I','personal','Cold',110,v_src_cold),
    (70,  'Calendula as lymph stimulant for cold constitution.','BHC - Class 36 - Constitution I','personal','Cold',120,v_src_cold),
    (1248,'Ocotillo as lymph stimulant for cold constitution.','BHC - Class 36 - Constitution I','personal','Cold',130,v_src_cold),
    (22,  'Alteratives for cold constitution: Burdock, Slippery Elm, Marshmallow root with Cinnamon or Cardamom. Cold body tends toward sluggish metabolism and bowel stagnation.','BHC - Class 36 - Constitution I','personal','Cold',140,v_src_cold),
    (92,  'Slippery Elm as alterative for cold constitution.','BHC - Class 36 - Constitution I','personal','Cold',150,v_src_cold),
    (45,  'Marshmallow root as alterative for cold constitution (combine with Cinnamon or Cardamom).','BHC - Class 36 - Constitution I','personal','Cold',160,v_src_cold),
    (13,  'Tulsi (Holy Basil) for cold constitution: hormone balancer, tissue protective in face of microbes/toxin/stress, nourish to reproductive organs.','BHC - Class 36 - Constitution I','personal','Cold',170,v_src_cold),
    (124, 'Ginger for cold constitution: heats up and stimulates the migrating motor complex of the small intestine; big impacts on cold bodies; warms internal organs (liver, lungs); David Hoffman → blood to extremities; Lisa → heat for internal organs.','BHC - Class 36 - Constitution I','personal','Cold',180,v_src_cold),

  -- ── DRY ───────────────────────────────────────────────────────────────────
    (134, 'Dry constitution herbs: Lemon Balm, Alfalfa, Nettles (use with moistening Lemon Balm), Red Raspberry.','BHC - Class 36 - Constitution I','personal','Dry',190,v_src_dry),
    (885, 'Dry constitution herbs: Lemon Balm, Alfalfa, Nettles, Red Raspberry.','BHC - Class 36 - Constitution I','personal','Dry',200,v_src_dry),
    (43,  'Nettles for dry constitution: can be drying — use together with moistening herbs like Lemon Balm.','BHC - Class 36 - Constitution I','personal','Dry',210,v_src_dry),
    (155, 'Red Raspberry (leaf) for dry constitution — moistening.','BHC - Class 36 - Constitution I','personal','Dry',220,v_src_dry),
    (852, 'Moistening adaptogens for dry constitution: Shatavari, Schisandra, Ginsengs, Licorice.','BHC - Class 36 - Constitution I','personal','Dry',230,v_src_dry),
    (17,  'Schisandra as moistening adaptogen for dry constitution.','BHC - Class 36 - Constitution I','personal','Dry',240,v_src_dry),
    (14,  'Ginsengs as moistening adaptogens for dry constitution.','BHC - Class 36 - Constitution I','personal','Dry',250,v_src_dry),
    (78,  'Licorice for dry constitution: moistening adaptogen. Model adaptogen; in TCM almost in every formula as harmonizer; addresses exhaustion and debility; improves insulin resistance; cortisol modulator; supports HPA dysregulation (adrenal fatigue); immune modulating; supports anabolic activity (tissue, muscle, baby); influence on every body system.','BHC - Class 36 - Constitution I','personal','Dry',260,v_src_dry),
    (178, 'Milky Oats as nervine for dry constitution.','BHC - Class 36 - Constitution I','personal','Dry',270,v_src_dry),
    (138, 'Kava as nervine for dry constitution.','BHC - Class 36 - Constitution I','personal','Dry',280,v_src_dry),
    (45,  'Marshmallow as demulcent for dry constitution: Marshmallow, Slippery Elm, Cinnamon, Cardamom.','BHC - Class 36 - Constitution I','personal','Dry',290,v_src_dry),
    (92,  'Slippery Elm as demulcent for dry constitution.','BHC - Class 36 - Constitution I','personal','Dry',300,v_src_dry),
    (167, 'Cinnamon as demulcent for dry constitution (also listed as moistening spice).','BHC - Class 36 - Constitution I','personal','Dry',310,v_src_dry),
    (127, 'Cardamom as demulcent for dry constitution.','BHC - Class 36 - Constitution I','personal','Dry',320,v_src_dry),

  -- ── HOT ───────────────────────────────────────────────────────────────────
    (122, 'Liver alteratives for hot constitution: Dandelion root, Chicory, Sarsaparilla, Sassafras, Licorice, Astragalus.','BHC - Class 36 - Constitution I','personal','Hot',330,v_src_hot),
    (2227,'Liver alteratives for hot constitution: Dandelion root, Chicory, Sarsaparilla, Sassafras, Licorice, Astragalus.','BHC - Class 36 - Constitution I','personal','Hot',340,v_src_hot),
    (40,  'Sarsaparilla as liver alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',350,v_src_hot),
    (313, 'Sassafras as liver alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',360,v_src_hot),
    (78,  'Licorice as liver alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',370,v_src_hot),
    (225, 'Astragalus as liver alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',380,v_src_hot),
    (981, 'Lymph alteratives for hot constitution: Red Root, Cleavers, Calendula.','BHC - Class 36 - Constitution I','personal','Hot',390,v_src_hot),
    (28,  'Cleavers as lymph alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',400,v_src_hot),
    (70,  'Calendula as lymph alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',410,v_src_hot),
    (26,  'Echinacea as alterative for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',420,v_src_hot),
    (203, 'Hepatics for hot constitution: Turmeric, Milk Thistle, Artichoke leaf.','BHC - Class 36 - Constitution I','personal','Hot',430,v_src_hot),
    (206, 'Milk Thistle as hepatic for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',440,v_src_hot),
    (172, 'Artichoke leaf as both hepatic and bitter for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',450,v_src_hot),
    (81,  'St. John''s Wort (SJW) as anti-inflammatory for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',460,v_src_hot),
    (87,  'Willow as anti-inflammatory for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',470,v_src_hot),
    (102, 'Bitters for hot constitution: Gentian, Oregon Grape Root (hot-reducing, liver-supporting, alterative), Orange peel, Artichoke leaf.','BHC - Class 36 - Constitution I','personal','Hot',480,v_src_hot),
    (33,  'Oregon Grape Root for hot constitution: hot-reducing, liver-supporting, alterative. Bitter tonic.','BHC - Class 36 - Constitution I','personal','Hot',490,v_src_hot),
    (748, 'Orange peel as bitter for hot constitution.','BHC - Class 36 - Constitution I','personal','Hot',500,v_src_hot),
    (25,  'Black Cohosh: classic arthritis/fibromyalgia plant; extreme muscle tension; tension headaches; PMS with tight squeezing cramps; muscle tightness with menopause; associated with chronic pain and negative self-talk; serotonin agonist (estrogen balance); melatonin production; works via pituitary influence on serotonin production; PMS with muscle pain and insomnia; consider before resorting to SSRIs.','BHC - Class 36 - Constitution I','personal','Hot',510,v_src_hot),

  -- ── WET ───────────────────────────────────────────────────────────────────
    (22,  'Alteratives (waste eliminating) for wet constitution: Burdock, Dandelion root, Sarsaparilla, Baptisia (Wild Indigo).','BHC - Class 36 - Constitution I','personal','Wet',520,v_src_wet),
    (122, 'Dandelion root as waste-eliminating alterative for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',530,v_src_wet),
    (40,  'Sarsaparilla as waste-eliminating alterative for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',540,v_src_wet),
    (23,  'Baptisia (Wild Indigo) as waste-eliminating alterative for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',550,v_src_wet),
    (124, 'Circ stimulants for wet constitution: Ginger, Prickly Ash, Red Root, Hawthorn berry, Rosemary, Ginkgo.','BHC - Class 36 - Constitution I','personal','Wet',560,v_src_wet),
    (123, 'Prickly Ash as circ stimulant for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',570,v_src_wet),
    (981, 'Red Root as circ stimulant for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',580,v_src_wet),
    (73,  'Hawthorn berry as circ stimulant for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',590,v_src_wet),
    (109, 'Rosemary as circ stimulant for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',600,v_src_wet),
    (165, 'Ginkgo as circ stimulant for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',610,v_src_wet),
    (16,  'Adaptogens for wet constitution: Rhodiola, Ashwagandha (not if hot/wet), Schisandra berry.','BHC - Class 36 - Constitution I','personal','Wet',620,v_src_wet),
    (20,  'Ashwagandha as adaptogen for wet constitution (not if hot/wet).','BHC - Class 36 - Constitution I','personal','Wet',630,v_src_wet),
    (17,  'Schisandra berry as adaptogen for wet constitution.','BHC - Class 36 - Constitution I','personal','Wet',640,v_src_wet),
    (11,  'Reishi Mushroom: protects against oxidative stress; adrenal and thyroid imbalance; wet as metabolic syndrome (aging changes — elevated lipids, weight gain, ankle swelling, visceral fat); helps body metabolize cortisol when stuck in overdrive; helps metabolize BPA and triclosan.','BHC - Class 36 - Constitution I','personal','Wet',650,v_src_wet),

  -- ── THOMPSON'S STANDARD PROTOCOL ─────────────────────────────────────────
    (132, 'Thompson''s Standard Protocol: Lobelia — stimulate digestion: purging → elimination of waste.','BHC - Class 36 - Constitution I','personal','Thompson''s Standard Protocol',660,v_src_thompson),
    (47,  'Thompson''s Standard Protocol: Cayenne — stoke the fire.','BHC - Class 36 - Constitution I','personal','Thompson''s Standard Protocol',670,v_src_thompson),
    (119, 'Thompson''s Standard Protocol: Bayberry (myrica) — berberine, more gentle removal of waste.','BHC - Class 36 - Constitution I','personal','Thompson''s Standard Protocol',680,v_src_thompson),
    (158, 'Thompson''s Standard Protocol: Barberry — enhance digestive secretions.','BHC - Class 36 - Constitution I','personal','Thompson''s Standard Protocol',690,v_src_thompson),
    (99,  'Thompson''s Standard Protocol: Myrrh resin (with cherry pits) — restorative.','BHC - Class 36 - Constitution I','personal','Thompson''s Standard Protocol',700,v_src_thompson),

  -- ── UPPER GI ──────────────────────────────────────────────────────────────
    (33,  'Upper GI deficiency: stimulate secretions with berberine plants — Oregon Grape Root, Barberry, Gentian, Bogbean.','BHC - Class 36 - Constitution I','personal','Upper GI',710,v_src_upper_gi),
    (158, 'Upper GI deficiency: Barberry as berberine plant to stimulate secretions.','BHC - Class 36 - Constitution I','personal','Upper GI',720,v_src_upper_gi),
    (102, 'Upper GI deficiency: Gentian as berberine plant to stimulate secretions.','BHC - Class 36 - Constitution I','personal','Upper GI',730,v_src_upper_gi),
    (34,  'Upper GI deficiency: Bogbean as berberine plant to stimulate secretions.','BHC - Class 36 - Constitution I','personal','Upper GI',740,v_src_upper_gi),
    (47,  'Upper GI deficiency: functional stimulants — Cayenne, Angelica, Prickly Ash, Ginseng.','BHC - Class 36 - Constitution I','personal','Upper GI',750,v_src_upper_gi),
    (65,  'Upper GI deficiency: Angelica as functional digestive stimulant.','BHC - Class 36 - Constitution I','personal','Upper GI',760,v_src_upper_gi),
    (123, 'Upper GI deficiency: Prickly Ash as functional digestive stimulant.','BHC - Class 36 - Constitution I','personal','Upper GI',770,v_src_upper_gi),
    (14,  'Upper GI deficiency: Ginseng as functional digestive stimulant.','BHC - Class 36 - Constitution I','personal','Upper GI',780,v_src_upper_gi),
    (56,  'Upper GI excess: astringents — Sage, Bayberry, Rubus spp.','BHC - Class 36 - Constitution I','personal','Upper GI',790,v_src_upper_gi),
    (119, 'Upper GI excess: Bayberry as astringent.','BHC - Class 36 - Constitution I','personal','Upper GI',800,v_src_upper_gi),
    (155, 'Upper GI excess: Rubus spp. (Raspberry) as astringent.','BHC - Class 36 - Constitution I','personal','Upper GI',810,v_src_upper_gi),
    (45,  'Upper GI excess: demulcents to protect mucosa — Marshmallow (Marsh root), Licorice, Comfrey root.','BHC - Class 36 - Constitution I','personal','Upper GI',820,v_src_upper_gi),
    (78,  'Upper GI excess: Licorice as demulcent.','BHC - Class 36 - Constitution I','personal','Upper GI',830,v_src_upper_gi),
    (89,  'Upper GI excess: Comfrey root as demulcent.','BHC - Class 36 - Constitution I','personal','Upper GI',840,v_src_upper_gi),
    (74,  'Upper GI excess with pain: antispasmodics — Wild Yam, Fennel, Hops, Catnip, Silk Tassel.','BHC - Class 36 - Constitution I','personal','Upper GI',850,v_src_upper_gi),
    (76,  'Upper GI excess with pain: Fennel as antispasmodic.','BHC - Class 36 - Constitution I','personal','Upper GI',860,v_src_upper_gi),
    (129, 'Upper GI excess with pain: Hops as antispasmodic.','BHC - Class 36 - Constitution I','personal','Upper GI',870,v_src_upper_gi),
    (136, 'Upper GI excess with pain: Catnip as antispasmodic.','BHC - Class 36 - Constitution I','personal','Upper GI',880,v_src_upper_gi),
    (853, 'Upper GI excess with pain: Silk Tassel as antispasmodic.','BHC - Class 36 - Constitution I','personal','Upper GI',890,v_src_upper_gi),

  -- ── LOWER GI ──────────────────────────────────────────────────────────────
    (37,  'Lower GI deficiency (constipative/dry type): stimulate peristalsis — Buckbean (Bogbean), Cinnamon, Licorice, Yellow Dock.','BHC - Class 36 - Constitution I','personal','Lower GI',900,v_src_lower_gi),
    (34,  'Lower GI deficiency (constipative type): Buckbean (Bogbean) to stimulate peristalsis.','BHC - Class 36 - Constitution I','personal','Lower GI',910,v_src_lower_gi),
    (167, 'Lower GI: Cinnamon good for both deficiency and excess.','BHC - Class 36 - Constitution I','personal','Lower GI',920,v_src_lower_gi),
    (78,  'Lower GI deficiency (constipative type): Licorice to stimulate peristalsis.','BHC - Class 36 - Constitution I','personal','Lower GI',930,v_src_lower_gi),
    (37,  'Lower GI deficiency (congestive/stagnation type): stimulate — Ocotillo, Fringetree, Yellow Dock.','BHC - Class 36 - Constitution I','personal','Lower GI',940,v_src_lower_gi),
    (1248,'Lower GI deficiency (congestive type): Ocotillo to stimulate.','BHC - Class 36 - Constitution I','personal','Lower GI',950,v_src_lower_gi),
    (24,  'Lower GI deficiency (congestive type): Fringetree to stimulate.','BHC - Class 36 - Constitution I','personal','Lower GI',960,v_src_lower_gi),
    (133, 'Lower GI excess: Bugleweed/Lycopis, Silk Tassel, Bayberry, Turkey rhubarb (rhubarb root).','BHC - Class 36 - Constitution I','personal','Lower GI',970,v_src_lower_gi),
    (853, 'Lower GI excess: Silk Tassel.','BHC - Class 36 - Constitution I','personal','Lower GI',980,v_src_lower_gi),
    (119, 'Lower GI excess: Bayberry.','BHC - Class 36 - Constitution I','personal','Lower GI',990,v_src_lower_gi),
    (154, 'Lower GI excess: Turkey rhubarb (rhubarb root).','BHC - Class 36 - Constitution I','personal','Lower GI',1000,v_src_lower_gi),

  -- ── LIVER ─────────────────────────────────────────────────────────────────
    (31,  'Liver deficiency: stimulate liver metabolism with berberine plants — Blue Flag (Iris all spp.), Milk Thistle, Poke (extreme cases).','BHC - Class 36 - Constitution I','personal','Liver',1010,v_src_liver),
    (206, 'Liver deficiency: Milk Thistle to stimulate liver metabolism (berberine plant).','BHC - Class 36 - Constitution I','personal','Liver',1020,v_src_liver),
    (35,  'Liver deficiency: Poke — use only in extreme cases or small part of formula to stimulate liver metabolism.','BHC - Class 36 - Constitution I','personal','Liver',1030,v_src_liver),
    (37,  'Liver deficiency: Yellow Dock to improve fat absorption.','BHC - Class 36 - Constitution I','personal','Liver',1040,v_src_liver),
    (123, 'Liver deficiency: Prickly Ash to stimulate arterial circulation to the liver.','BHC - Class 36 - Constitution I','personal','Liver',1050,v_src_liver),
    (42,  'Liver excess: mineral-rich herbs to buffer blood — Red Clover, Red Raspberry leaf, Alfalfa, Lemon Balm, Nettles.','BHC - Class 36 - Constitution I','personal','Liver',1060,v_src_liver),
    (155, 'Liver excess: Red Raspberry leaf as mineral-rich herb to buffer blood.','BHC - Class 36 - Constitution I','personal','Liver',1070,v_src_liver),
    (885, 'Liver excess: Alfalfa as mineral-rich herb to buffer blood.','BHC - Class 36 - Constitution I','personal','Liver',1080,v_src_liver),
    (134, 'Liver excess: Lemon Balm as mineral-rich herb to buffer blood.','BHC - Class 36 - Constitution I','personal','Liver',1090,v_src_liver),
    (43,  'Liver excess: Nettles as mineral-rich herb to buffer blood.','BHC - Class 36 - Constitution I','personal','Liver',1100,v_src_liver),
    (22,  'Liver excess: cool the anabolic tendency — Burdock, Bugleweed, Milk Thistle, Devil''s Club.','BHC - Class 36 - Constitution I','personal','Liver',1110,v_src_liver),
    (133, 'Liver excess: Bugleweed to cool the anabolic tendency.','BHC - Class 36 - Constitution I','personal','Liver',1120,v_src_liver),
    (206, 'Liver excess: Milk Thistle to cool the anabolic tendency (also used in liver deficiency).','BHC - Class 36 - Constitution I','personal','Liver',1130,v_src_liver),
    (591, 'Liver excess: Devil''s Club to cool the anabolic tendency.','BHC - Class 36 - Constitution I','personal','Liver',1140,v_src_liver),
    (122, 'Liver excess: Dandelion root to stimulate bile secretion without stimulating liver metabolism.','BHC - Class 36 - Constitution I','personal','Liver',1150,v_src_liver),
    (115, 'Liver excess: Mugwort (Artemisia vulgaris) to stimulate bile secretion without stimulating liver metabolism.','BHC - Class 36 - Constitution I','personal','Liver',1160,v_src_liver),

  -- ── KIDNEYS ───────────────────────────────────────────────────────────────
    (1009,'Kidney deficiency: Dong Quai to improve renal blood supply and hormonal stimulation.','BHC - Class 36 - Constitution I','personal','Kidneys',1170,v_src_kidneys),
    (151, 'Kidney deficiency: Horsetail to stimulate nephrons.','BHC - Class 36 - Constitution I','personal','Kidneys',1180,v_src_kidneys),
    (78,  'Kidney deficiency: Licorice to support adrenals and hormonal stimulation.','BHC - Class 36 - Constitution I','personal','Kidneys',1190,v_src_kidneys),
    (14,  'Kidney deficiency: Ginsengs — support adrenals and improve hormonal stimulation.','BHC - Class 36 - Constitution I','personal','Kidneys',1200,v_src_kidneys),
    (71,  'Kidney deficiency: Shepherd''s Purse for adrenal and hormonal support.','BHC - Class 36 - Constitution I','personal','Kidneys',1210,v_src_kidneys),
    (31,  'Kidney excess: Blue Flag (Iris) as metabolic cooler to dilate renal arteries.','BHC - Class 36 - Constitution I','personal','Kidneys',1220,v_src_kidneys),
    (22,  'Kidney excess: diuretic cooler — Burdock, Shepherd''s Purse, Horsetail, Dandelion leaf.','BHC - Class 36 - Constitution I','personal','Kidneys',1230,v_src_kidneys),
    (71,  'Kidney excess: Shepherd''s Purse as diuretic cooler.','BHC - Class 36 - Constitution I','personal','Kidneys',1240,v_src_kidneys),
    (151, 'Kidney excess: Horsetail as diuretic cooler (also listed for deficiency).','BHC - Class 36 - Constitution I','personal','Kidneys',1250,v_src_kidneys),
    (1648,'Kidney excess: Dandelion leaf as diuretic cooler.','BHC - Class 36 - Constitution I','personal','Kidneys',1260,v_src_kidneys),

  -- ── REPRODUCTIVE - FEMALE ─────────────────────────────────────────────────
    (1009,'Female reproductive deficiency: anabolic stimulants — Dong Quai, Blue Cohosh, Licorice, White Peony, Ginsengs.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1270,v_src_repro_f),
    (72,  'Female reproductive deficiency: Blue Cohosh as anabolic stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1280,v_src_repro_f),
    (78,  'Female reproductive deficiency: Licorice as anabolic stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1290,v_src_repro_f),
    (2238,'Female reproductive deficiency: White Peony as anabolic stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1300,v_src_repro_f),
    (14,  'Female reproductive deficiency: Ginsengs as anabolic stimulants.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1310,v_src_repro_f),
    (v_wild_ginger_id,'Female reproductive deficiency: circ stimulants — Wild Ginger, Ocotillo, Black Cohosh, Poke (little poke).','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1320,v_src_repro_f),
    (1248,'Female reproductive deficiency: Ocotillo as circ stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1330,v_src_repro_f),
    (25,  'Female reproductive deficiency: Black Cohosh as circ stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1340,v_src_repro_f),
    (35,  'Female reproductive deficiency: Poke (little poke) as circ stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1350,v_src_repro_f),
    (131, 'Female reproductive deficiency: Motherwort to stimulate HPA.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1360,v_src_repro_f),
    (144, 'Female reproductive deficiency: Damiana to stimulate HPA.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1370,v_src_repro_f),
    (190, 'Female reproductive deficiency: Vitex to stimulate HPA.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1380,v_src_repro_f),
    (36,  'Female reproductive deficiency: Anemone (Pasqueflower) to stimulate HPA.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1390,v_src_repro_f),
    (74,  'Female reproductive excess (short cycles < 24 days): cool the system — Wild Yam, Yellow Pond Lily, Trillium, Black Haw, Cramp Bark.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1400,v_src_repro_f),
    (v_pond_lily_id,'Female reproductive excess: Yellow Pond Lily to cool the system.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1410,v_src_repro_f),
    (v_trillium_id,'Female reproductive excess: Trillium to cool the system.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1420,v_src_repro_f),
    (94,  'Female reproductive excess: Black Haw to cool the system.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1430,v_src_repro_f),
    (93,  'Female reproductive excess: Cramp Bark to cool the system.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1440,v_src_repro_f),
    (190, 'Female reproductive excess: Vitex as anabolic cooler (also listed for deficiency HPA stimulation).','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1450,v_src_repro_f),
    (2238,'Female reproductive excess: White Peony as anabolic cooler.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1460,v_src_repro_f),
    (9,   'Female reproductive excess: Eleuthero (Siberian Ginseng) as anabolic cooler.','BHC - Class 36 - Constitution I','personal','Reproductive - Female',1470,v_src_repro_f),

  -- ── REPRODUCTIVE - MALE ───────────────────────────────────────────────────
    (1009,'Male reproductive deficiency: Dong Quai, Licorice, White Peony, Ginsengs — improve hormone use, pelvic circulation, HPA Axis. Note: beer can influence sperm count.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1480,v_src_repro_m),
    (78,  'Male reproductive deficiency: Licorice for hormone use and HPA axis support.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1490,v_src_repro_m),
    (2238,'Male reproductive deficiency: White Peony for hormone use and HPA axis support.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1500,v_src_repro_m),
    (14,  'Male reproductive deficiency: Ginsengs for hormone use and HPA axis support.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1510,v_src_repro_m),
    (v_wild_ginger_id,'Male reproductive deficiency: circ stimulants — Wild Ginger, Ocotillo, Poke (little), Black Cohosh (little).','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1520,v_src_repro_m),
    (1248,'Male reproductive deficiency: Ocotillo as circ stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1530,v_src_repro_m),
    (35,  'Male reproductive deficiency: Poke (little) as circ stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1540,v_src_repro_m),
    (25,  'Male reproductive deficiency: Black Cohosh (little) as circ stimulant.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1550,v_src_repro_m),
    (74,  'Male reproductive excess (oiliness from excess testosterone): Wild Yam, Yellow Pond Lily, Trillium, Viburnums (Cramp Bark, Black Haw).','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1560,v_src_repro_m),
    (v_pond_lily_id,'Male reproductive excess: Yellow Pond Lily.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1570,v_src_repro_m),
    (v_trillium_id,'Male reproductive excess: Trillium.','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1580,v_src_repro_m),
    (93,  'Male reproductive excess: Cramp Bark (viburnum).','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1590,v_src_repro_m),
    (94,  'Male reproductive excess: Black Haw (viburnum).','BHC - Class 36 - Constitution I','personal','Reproductive - Male',1600,v_src_repro_m),

  -- ── RESPIRATORY ───────────────────────────────────────────────────────────
    (36,  'Respiratory deficiency: increase parasympathetic function — Pulsatilla (Pasqueflower), Lobelia (small doses).','BHC - Class 36 - Constitution I','personal','Respiratory',1610,v_src_resp),
    (132, 'Respiratory deficiency: Lobelia in small doses to increase parasympathetic function.','BHC - Class 36 - Constitution I','personal','Respiratory',1620,v_src_resp),
    (579, 'Respiratory deficiency: Aralia (California Spikenard) to increase mucus secretion in tissues.','BHC - Class 36 - Constitution I','personal','Respiratory',1630,v_src_resp),
    (104, 'Respiratory deficiency: Osha (Oshala) to increase mucus secretion in tissues.','BHC - Class 36 - Constitution I','personal','Respiratory',1640,v_src_resp),
    (41,  'Respiratory deficiency: Queen''s Delight (Stilingia / Queen''s root) to stimulate lymph.','BHC - Class 36 - Constitution I','personal','Respiratory',1650,v_src_resp),
    (61,  'Respiratory excess: cool excess overproduction — Mullein, Horsetail, Grindelia, Licorice, Wild Cherry. May be a thyroid picture (esp. hyperventilation with stress).','BHC - Class 36 - Constitution I','personal','Respiratory',1660,v_src_resp),
    (151, 'Respiratory excess: Horsetail to cool overproduction.','BHC - Class 36 - Constitution I','personal','Respiratory',1670,v_src_resp),
    (2231,'Respiratory excess: Grindelia to cool overproduction.','BHC - Class 36 - Constitution I','personal','Respiratory',1680,v_src_resp),
    (78,  'Respiratory excess: Licorice to cool overproduction.','BHC - Class 36 - Constitution I','personal','Respiratory',1690,v_src_resp),
    (140, 'Respiratory excess: Wild Cherry to cool overproduction.','BHC - Class 36 - Constitution I','personal','Respiratory',1700,v_src_resp),

  -- ── CARDIOVASCULAR ────────────────────────────────────────────────────────
    (165, 'Cardiovascular deficiency: vasodilators — Ginkgo, Prickly Ash, Anemone (Pasqueflower), Ginger. Signs: thready/shallow pulse, mottled skin on thighs/upper arms.','BHC - Class 36 - Constitution I','personal','Cardiovascular',1710,v_src_cardio),
    (123, 'Cardiovascular deficiency: Prickly Ash as vasodilator.','BHC - Class 36 - Constitution I','personal','Cardiovascular',1720,v_src_cardio),
    (36,  'Cardiovascular deficiency: Anemone (Pasqueflower) as vasodilator/parasympathetic support.','BHC - Class 36 - Constitution I','personal','Cardiovascular',1730,v_src_cardio),
    (124, 'Cardiovascular deficiency: Ginger as vasodilator.','BHC - Class 36 - Constitution I','personal','Cardiovascular',1740,v_src_cardio),

  -- ── LYMPH / IMMUNE ────────────────────────────────────────────────────────
    (981, 'Lymph/Immune deficiency: lymphagogues — Red Root, Yerba Mansa, Ocotillo, Poke, Queen''s Delight (Stilingia).','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1750,v_src_lymph),
    (309, 'Lymph/Immune deficiency: Yerba Mansa as lymphagogue.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1760,v_src_lymph),
    (1248,'Lymph/Immune deficiency: Ocotillo as lymphagogue.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1770,v_src_lymph),
    (35,  'Lymph/Immune deficiency: Poke as lymphagogue.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1780,v_src_lymph),
    (41,  'Lymph/Immune deficiency: Queen''s Delight (Stilingia) as lymphagogue.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1790,v_src_lymph),
    (45,  'Lymph/Immune deficiency: innate immunity — Marshmallow, Astragalus, Baptisia (Wild Indigo), Myrrh, Echinacea, Cypress.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1800,v_src_lymph),
    (225, 'Lymph/Immune deficiency: Astragalus for innate immunity.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1810,v_src_lymph),
    (23,  'Lymph/Immune deficiency: Baptisia (Wild Indigo) for innate immunity.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1820,v_src_lymph),
    (99,  'Lymph/Immune deficiency: Myrrh for innate immunity.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1830,v_src_lymph),
    (26,  'Lymph/Immune deficiency: Echinacea for innate immunity.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1840,v_src_lymph),
    (570, 'Lymph/Immune deficiency: Cypress for innate immunity.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1850,v_src_lymph),
    (201, 'Lymph/Immune deficiency: Thuja (red cedar) to support acquired immune function.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1860,v_src_lymph),
    (2274,'Lymph/Immune excess (autoimmune): Chinese Skullcap (Baikal Scutellaria) — cool mast cell activation, modulate immune system.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1870,v_src_lymph),
    (78,  'Lymph/Immune excess (autoimmune): Licorice to modulate immune system.','BHC - Class 36 - Constitution I','personal','Lymph / Immune',1880,v_src_lymph),

  -- ── SKIN ──────────────────────────────────────────────────────────────────
    (70,  'Skin deficiency (= liver deficiency): stimulate circulation — Calendula, Prickly Ash, Queen''s Delight (Stilingia), Goldenseal root.','BHC - Class 36 - Constitution I','personal','Skin',1890,v_src_skin),
    (123, 'Skin deficiency: Prickly Ash to stimulate circulation.','BHC - Class 36 - Constitution I','personal','Skin',1900,v_src_skin),
    (41,  'Skin deficiency: Queen''s Delight (Stilingia) to stimulate circulation.','BHC - Class 36 - Constitution I','personal','Skin',1910,v_src_skin),
    (30,  'Skin deficiency: Goldenseal root to stimulate circulation.','BHC - Class 36 - Constitution I','personal','Skin',1920,v_src_skin),
    (33,  'Skin deficiency: Oregon Grape Root to stimulate liver.','BHC - Class 36 - Constitution I','personal','Skin',1930,v_src_skin),
    (14,  'Skin deficiency: Panax Ginseng to stimulate liver.','BHC - Class 36 - Constitution I','personal','Skin',1940,v_src_skin),
    (122, 'Skin excess (toxin buildup): liver cooling — Dandelion root, Burdock root.','BHC - Class 36 - Constitution I','personal','Skin',1950,v_src_skin),
    (22,  'Skin excess: Burdock root for liver cooling.','BHC - Class 36 - Constitution I','personal','Skin',1960,v_src_skin),
    (43,  'Skin excess: Nettles for nerve cooling / decrease liver excitability.','BHC - Class 36 - Constitution I','personal','Skin',1970,v_src_skin),
    (51,  'Skin excess: Euphrasia (Eyebright) for nerve cooling / decrease liver excitability.','BHC - Class 36 - Constitution I','personal','Skin',1980,v_src_skin),

  -- ── MUSCULOSKELETAL ───────────────────────────────────────────────────────
    (615, 'Musculoskeletal deficiency: stimulate blood flow, sympathetic NS response — Kola Nut, Anemone (Pasqueflower), Panax Ginsengs.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',1990,v_src_msk),
    (36,  'Musculoskeletal deficiency: Anemone (Pasqueflower) as vascular stimulant.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2000,v_src_msk),
    (14,  'Musculoskeletal deficiency: Panax Ginsengs as vascular stimulant.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2010,v_src_msk),
    (25,  'Musculoskeletal excess: muscle relaxants — Black Cohosh, Lobelia, Passionflower, Skullcap. Disperse blood from musculature into viscera.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2020,v_src_msk),
    (132, 'Musculoskeletal excess: Lobelia as muscle relaxant.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2030,v_src_msk),
    (137, 'Musculoskeletal excess: Passionflower as muscle relaxant.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2040,v_src_msk),
    (142, 'Musculoskeletal excess: Skullcap as muscle relaxant.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2050,v_src_msk),
    (178, 'Musculoskeletal excess: Milky Oats to cool the sympathetic stress response.','BHC - Class 36 - Constitution I','personal','Musculoskeletal',2060,v_src_msk);

  RAISE NOTICE 'Class 36 snippets inserted.';
END $$;

-- ── 3. KEYWORDS — new herbs (IDs resolved at runtime) ─────────────────────
DO $$
DECLARE
  v_trillium_id    INTEGER;
  v_pond_lily_id   INTEGER;
  v_wild_ginger_id INTEGER;
BEGIN
  SELECT id INTO v_trillium_id    FROM herbal.herbs WHERE latin_name = 'Trillium spp.';
  SELECT id INTO v_pond_lily_id   FROM herbal.herbs WHERE latin_name = 'Nuphar lutea';
  SELECT id INTO v_wild_ginger_id FROM herbal.herbs WHERE latin_name = 'Asarum canadense';

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    (v_trillium_id,    'reproductive support', 'ailment'),
    (v_trillium_id,    'hormonal support',     'ailment'),
    (v_pond_lily_id,   'reproductive support', 'ailment'),
    (v_pond_lily_id,   'hormonal support',     'ailment'),
    (v_wild_ginger_id, 'reproductive support', 'ailment'),
    (v_wild_ginger_id, 'poor circulation',     'ailment')
  ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;
END $$;

-- ── 4. KEYWORDS — existing herbs ──────────────────────────────────────────
-- Constitutional type keywords (general) are new to this class.
-- Specific ailment keywords reuse existing entries.
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Constitutional type assignments (new 'general' keywords)
  (1009,'cold constitution','general'),(1009,'poor circulation','ailment'),(1009,'blood building','action'),
  (1009,'reproductive support','ailment'),(1009,'kidney support','ailment'),
  (20,  'cold constitution','general'),(20,  'blood building','action'),(20,'wet constitution','general'),
  (134, 'cold constitution','general'),(134, 'blood building','action'),(134,'dry constitution','general'),
  (134, 'liver support','ailment'),
  (885, 'cold constitution','general'),(885, 'blood building','action'),(885,'dry constitution','general'),
  (885, 'liver support','ailment'),
  (2238,'cold constitution','general'),(2238,'blood building','action'),(2238,'reproductive support','ailment'),
  (78,  'cold constitution','general'),(78,  'dry constitution','general'),(78,'hot constitution','general'),
  (78,  'adrenal fatigue','ailment'),(78,'insulin resistance','ailment'),(78,'hormonal support','ailment'),
  (78,  'immune support','ailment'),(78,'autoimmune disease','ailment'),(78,'reproductive support','ailment'),
  (78,  'kidney support','ailment'),
  (43,  'cold constitution','general'),(43,'dry constitution','general'),(43,'liver support','ailment'),
  (123, 'cold constitution','general'),(123,'poor circulation','ailment'),(123,'wet constitution','general'),
  (47,  'cold constitution','general'),(47,'digestive tonic','ailment'),
  (35,  'cold constitution','general'),(35,'lymphatic support','ailment'),
  (70,  'cold constitution','general'),(70,'lymphatic support','ailment'),(70,'skin conditions','ailment'),
  (1248,'cold constitution','general'),(1248,'lymphatic support','ailment'),
  (22,  'cold constitution','general'),(22,'wet constitution','general'),(22,'liver support','ailment'),
  (22,  'skin conditions','ailment'),(22,'kidney support','ailment'),
  (92,  'cold constitution','general'),(92,'dry constitution','general'),
  (45,  'cold constitution','general'),(45,'dry constitution','general'),(45,'immune support','ailment'),
  (45,  'gut inflammation','ailment'),
  (13,  'cold constitution','general'),(13,'hormonal support','ailment'),
  (124, 'cold constitution','general'),(124,'poor circulation','ailment'),(124,'wet constitution','general'),
  (124, 'digestive tonic','ailment'),(124,'cardiovascular disease','ailment'),
  -- Dry constitution
  (155, 'dry constitution','general'),(155,'liver support','ailment'),
  (852, 'dry constitution','general'),(852,'adrenal fatigue','ailment'),
  (17,  'dry constitution','general'),(17,'wet constitution','general'),
  (14,  'dry constitution','general'),(14,'adrenal fatigue','ailment'),(14,'digestive tonic','ailment'),
  (14,  'kidney support','ailment'),(14,'reproductive support','ailment'),
  (178, 'dry constitution','general'),(178,'stress','ailment'),(178,'musculoskeletal','general'),
  (138, 'dry constitution','general'),(138,'anxiety','ailment'),
  (167, 'dry constitution','general'),(127,'dry constitution','general'),
  -- Hot constitution
  (122, 'hot constitution','general'),(122,'liver support','ailment'),(122,'wet constitution','general'),
  (2227,'hot constitution','general'),(2227,'liver support','ailment'),
  (40,  'hot constitution','general'),(40,'wet constitution','general'),(40,'liver support','ailment'),
  (313, 'hot constitution','general'),
  (225, 'hot constitution','general'),(225,'liver support','ailment'),(225,'immune support','ailment'),
  (981, 'hot constitution','general'),(981,'lymphatic support','ailment'),(981,'wet constitution','general'),
  (28,  'hot constitution','general'),(28,'lymphatic support','ailment'),
  (26,  'hot constitution','general'),(26,'immune support','ailment'),
  (203, 'hot constitution','general'),(203,'liver support','ailment'),(203,'inflammation','ailment'),
  (206, 'hot constitution','general'),(206,'liver support','ailment'),
  (172, 'hot constitution','general'),(172,'liver support','ailment'),(172,'digestive tonic','ailment'),
  (81,  'hot constitution','general'),(81,'inflammation','ailment'),
  (87,  'hot constitution','general'),(87,'inflammation','ailment'),(87,'arthritis','ailment'),
  (102, 'hot constitution','general'),(102,'digestive tonic','ailment'),
  (33,  'hot constitution','general'),(33,'liver support','ailment'),(33,'skin conditions','ailment'),
  (748, 'hot constitution','general'),
  (25,  'hot constitution','general'),(25,'fibromyalgia','ailment'),(25,'arthritis','ailment'),
  (25,  'PMS','ailment'),(25,'muscle spasms','ailment'),(25,'sleep support','ailment'),
  (25,  'headache','ailment'),(25,'pituitary support','ailment'),
  -- Wet constitution
  (23,  'wet constitution','general'),(23,'immune support','ailment'),
  (73,  'wet constitution','general'),(73,'poor circulation','ailment'),(73,'cardiovascular disease','ailment'),
  (109, 'wet constitution','general'),(109,'poor circulation','ailment'),
  (165, 'wet constitution','general'),(165,'poor circulation','ailment'),(165,'cardiovascular disease','ailment'),
  (16,  'wet constitution','general'),(16,'adrenal fatigue','ailment'),(16,'fatigue','ailment'),
  (11,  'wet constitution','general'),(11,'metabolic syndrome','ailment'),(11,'hypothyroidism','ailment'),
  (11,  'adrenal fatigue','ailment'),(11,'hormonal support','ailment'),
  -- Thompson
  (132, 'digestive tonic','ailment'),(132,'muscle spasms','ailment'),
  (119, 'digestive tonic','ailment'),
  (158, 'digestive tonic','ailment'),
  (99,  'immune support','ailment'),
  -- Upper GI
  (34,  'digestive tonic','ailment'),(65,'digestive tonic','ailment'),
  (56,  'digestive tonic','ailment'),(89,'gut inflammation','ailment'),
  (74,  'muscle spasms','ailment'),(76,'muscle spasms','ailment'),
  (129, 'muscle spasms','ailment'),(136,'muscle spasms','ailment'),(853,'muscle spasms','ailment'),
  -- Lower GI
  (37,  'constipation','ailment'),(24,'constipation','ailment'),(133,'constipation','ailment'),
  (154, 'constipation','ailment'),
  -- Liver
  (31,  'liver support','ailment'),(31,'kidney support','ailment'),
  (591, 'liver support','ailment'),(115,'liver support','ailment'),(42,'liver support','ailment'),
  -- Kidneys
  (151, 'kidney support','ailment'),(71,'kidney support','ailment'),(1648,'kidney support','ailment'),
  -- Reproductive
  (72,  'reproductive support','ailment'),(72,'hormonal support','ailment'),
  (131, 'reproductive support','ailment'),(131,'hormonal support','ailment'),
  (144, 'reproductive support','ailment'),(144,'hormonal support','ailment'),
  (190, 'reproductive support','ailment'),(190,'hormonal support','ailment'),(190,'PMS','ailment'),
  (36,  'reproductive support','ailment'),(36,'spasmodic cough','ailment'),(36,'cardiovascular disease','ailment'),
  (74,  'reproductive support','ailment'),(93,'reproductive support','ailment'),
  (94,  'reproductive support','ailment'),(9,'reproductive support','ailment'),
  -- Respiratory
  (579, 'respiratory infection','ailment'),(104,'respiratory infection','ailment'),
  (41,  'lymphatic support','ailment'),(41,'respiratory infection','ailment'),
  (61,  'chronic cough','ailment'),(2231,'chronic cough','ailment'),(140,'spasmodic cough','ailment'),
  -- Lymph/Immune
  (309, 'lymphatic support','ailment'),(570,'immune support','ailment'),(201,'immune support','ailment'),
  (2274,'autoimmune disease','ailment'),(2274,'mast cell activation syndrome','ailment'),
  -- Skin
  (30,  'skin conditions','ailment'),(51,'skin conditions','ailment'),
  -- Musculoskeletal
  (615, 'poor circulation','ailment'),(137,'muscle spasms','ailment'),
  (142, 'muscle spasms','ailment'),(142,'stress','ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;
