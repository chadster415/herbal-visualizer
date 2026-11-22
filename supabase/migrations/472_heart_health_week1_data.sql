-- Migration 472: Herbal Heart Health - Week 1 - Reading the Hearts Whole Story
-- Source: Week 1 - Reading the Hearts Whole Story.md (slide-based, single file)
-- Note type: generated (all slides; no personal notes file for this course)
--
-- Herb normalizations applied:
--   Tilia spp. → Linden (id=90)
--   Crataegus spp./monogyna → Hawthorn (id=73)
--   Wolfiporia extensa / fu ling → Poria/Hoelen (id=1541)
--   Cordyceps sinensis → Cordyceps militaris (id=2634, closest DB match)
--   Ganoderma spp./lucidum → Reishi Mushroom (id=11)
--   Ocimum tenuifolium / Holy Basil → Holy Basil (id=13)
--   Salvia rosmarinus → Rosemary (id=109)
--   Dandelion root → id=122; Dandelion leaf → id=1648
--   Rose petals → id=850
--   Oats (nervous system context) → milky oats id=178
--
-- New herb added: Rauwolfia (Rauvolfia serpentina)
--
-- Supplements used (Frank's protocol):
--   Fish Oils (Omega-3) → supplement id=33
--   Vitamin B Complex → supplement id=49
--   Vitamin B3 (Niacin) → supplement id=4
--
-- Skipped (not in DB; not medicinal herbs):
--   Blackstrap Molasses (food)
--   Pomegranate juice → using Pomegranate herb id=2753 instead
--
-- Keyword merge decisions:
--   "poor circulation" → new ailment keyword (exists in herb_keywords but not ailment_search_terms)
--   "vascular health" → new ailment keyword (distinct from circulation / cardiovascular disease)
--   "hypotension" → new ailment keyword (not previously in ailment_search_terms)
--   "oral health" → new ailment keyword (broader than dental health; cardiovascular context)
--   "blood sugar support" → merged into existing 'blood sugar dysregulation' (ailment) where appropriate
--   "cognitive support" → reused existing keyword
--   "stress" → reused existing keyword for adaptogen contexts

SET search_path TO herbal, public;

-- Add Rauwolfia if not already present
INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
SELECT 'Rauwolfia', 'Rauvolfia serpentina', 'root'
WHERE NOT EXISTS (
  SELECT 1 FROM herbal.herbs WHERE latin_name ILIKE 'Rauvolfia serpentina'
);

DO $$
DECLARE
  v_rauwolfia_id INTEGER;
BEGIN
  SELECT id INTO v_rauwolfia_id
  FROM herbal.herbs
  WHERE latin_name ILIKE 'Rauvolfia serpentina'
  LIMIT 1;

  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story'
  ) THEN
    RAISE NOTICE 'Week 1 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ============================================================
  -- HEAT AND TENSION PATTERN
  -- ============================================================
  (90,
   'Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves; suited to the Heat and Tension pattern of elevated BP, irritability, difficulty sleeping, and rapid pulse.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heat and Tension Pattern', 10,
   '# Pattern: Heat and Tension
- Presents as elevated blood pressure, flushed skin, irritability, difficulty sleeping, rapid pulse, and headaches
- Energetically: hot and constricted - blood vessels tight, inflammation present, nervous system in a heightened state of stress
- Rosalee uses Rabbit as the archetype: bustling, quick to bristle, everything feels urgent, the system is reactive and keyed up
- For Heat and Tension, herbalists reach for herbs that cool, relax, and soften vascular tension; many fall into the category of hypotensives or nervine-cardiac herbs

# Herbs for Heat and Tension
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves
- Hawthorn (*Crataegus monogyna*) supports healthy vessel tone; Motherwort (*Leonurus cardiaca*) especially helpful when palpitations are linked to anxiety; Lemon Balm (*Melissa officinalis*) gently calms both nervous system and heart'),

  (73,
   'Hawthorn (*Crataegus spp.*) supports healthy vessel tone; a primary herb for the Heat and Tension pattern of elevated blood pressure and cardiovascular stress.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heat and Tension Pattern', 20,
   '# Pattern: Heat and Tension
- Presents as elevated blood pressure, flushed skin, irritability, difficulty sleeping, rapid pulse, and headaches
- Energetically: hot and constricted - blood vessels tight, inflammation present, nervous system in a heightened state of stress
- Rosalee uses Rabbit as the archetype: bustling, quick to bristle, everything feels urgent, the system is reactive and keyed up
- For Heat and Tension, herbalists reach for herbs that cool, relax, and soften vascular tension; many fall into the category of hypotensives or nervine-cardiac herbs

# Herbs for Heat and Tension
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves
- Hawthorn (*Crataegus monogyna*) supports healthy vessel tone; Motherwort (*Leonurus cardiaca*) especially helpful when palpitations are linked to anxiety; Lemon Balm (*Melissa officinalis*) gently calms both nervous system and heart'),

  (131,
   'Motherwort (*Leonurus cardiaca*) is especially helpful when palpitations are linked to anxiety; a key herb for the Heat and Tension pattern.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heat and Tension Pattern', 30,
   '# Pattern: Heat and Tension
- Presents as elevated blood pressure, flushed skin, irritability, difficulty sleeping, rapid pulse, and headaches
- Energetically: hot and constricted - blood vessels tight, inflammation present, nervous system in a heightened state of stress
- Rosalee uses Rabbit as the archetype: bustling, quick to bristle, everything feels urgent, the system is reactive and keyed up
- For Heat and Tension, herbalists reach for herbs that cool, relax, and soften vascular tension; many fall into the category of hypotensives or nervine-cardiac herbs

# Herbs for Heat and Tension
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves
- Hawthorn (*Crataegus monogyna*) supports healthy vessel tone; Motherwort (*Leonurus cardiaca*) especially helpful when palpitations are linked to anxiety; Lemon Balm (*Melissa officinalis*) gently calms both nervous system and heart'),

  (134,
   'Lemon Balm (*Melissa officinalis*) gently calms both the nervous system and the heart; suited to the Heat and Tension pattern.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heat and Tension Pattern', 40,
   '# Pattern: Heat and Tension
- Presents as elevated blood pressure, flushed skin, irritability, difficulty sleeping, rapid pulse, and headaches
- Energetically: hot and constricted - blood vessels tight, inflammation present, nervous system in a heightened state of stress
- Rosalee uses Rabbit as the archetype: bustling, quick to bristle, everything feels urgent, the system is reactive and keyed up
- For Heat and Tension, herbalists reach for herbs that cool, relax, and soften vascular tension; many fall into the category of hypotensives or nervine-cardiac herbs

# Herbs for Heat and Tension
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nerves
- Hawthorn (*Crataegus monogyna*) supports healthy vessel tone; Motherwort (*Leonurus cardiaca*) especially helpful when palpitations are linked to anxiety; Lemon Balm (*Melissa officinalis*) gently calms both nervous system and heart'),

  -- ============================================================
  -- COLD AND DEFICIENCY PATTERN
  -- ============================================================
  (124,
   'Ginger (*Zingiber officinale*) warms circulation and digestion; suited to the Cold and Deficiency pattern of low BP, cold extremities, fatigue, and weak pulse.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cold and Deficiency Pattern', 50,
   '# Pattern: Cold and Deficiency
- Presents as a cardiovascular system that feels cold, depleted, or underpowered: low blood pressure, cold hands and feet, fatigue, dizziness, weak pulse, pallor, and easy exhaustion
- Eeyore is the archetype: gray, low energy, gloomy, the kind of tired that sits deep in the bones
- Energetically: a deficient or underactive system; circulation sluggish, warmth lacking, vitality low

# Herbs for Cold and Deficiency
- Ginger (*Zingiber officinale*) warms circulation and digestion; Cayenne (*Capsicum annuum*) stimulates blood flow even in small amounts
- Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity; Prickly Ash (*Zanthoxylum americanum*) is a classic circulatory stimulant for cold, sluggish tissues'),

  (47,
   'Cayenne (*Capsicum annuum*) stimulates blood flow even in small amounts; suited to the Cold and Deficiency pattern of sluggish circulation and cold extremities.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cold and Deficiency Pattern', 60,
   '# Pattern: Cold and Deficiency
- Presents as a cardiovascular system that feels cold, depleted, or underpowered: low blood pressure, cold hands and feet, fatigue, dizziness, weak pulse, pallor, and easy exhaustion
- Eeyore is the archetype: gray, low energy, gloomy, the kind of tired that sits deep in the bones
- Energetically: a deficient or underactive system; circulation sluggish, warmth lacking, vitality low

# Herbs for Cold and Deficiency
- Ginger (*Zingiber officinale*) warms circulation and digestion; Cayenne (*Capsicum annuum*) stimulates blood flow even in small amounts
- Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity; Prickly Ash (*Zanthoxylum americanum*) is a classic circulatory stimulant for cold, sluggish tissues'),

  (109,
   'Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity; suited to Cold and Deficiency pattern with cognitive dullness.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cold and Deficiency Pattern', 70,
   '# Pattern: Cold and Deficiency
- Presents as a cardiovascular system that feels cold, depleted, or underpowered: low blood pressure, cold hands and feet, fatigue, dizziness, weak pulse, pallor, and easy exhaustion
- Eeyore is the archetype: gray, low energy, gloomy, the kind of tired that sits deep in the bones
- Energetically: a deficient or underactive system; circulation sluggish, warmth lacking, vitality low

# Herbs for Cold and Deficiency
- Ginger (*Zingiber officinale*) warms circulation and digestion; Cayenne (*Capsicum annuum*) stimulates blood flow even in small amounts
- Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity; Prickly Ash (*Zanthoxylum americanum*) is a classic circulatory stimulant for cold, sluggish tissues'),

  (123,
   'Prickly Ash (*Zanthoxylum americanum*) is a classic circulatory stimulant for cold, sluggish tissues; best suited to the Cold and Deficiency pattern.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cold and Deficiency Pattern', 80,
   '# Pattern: Cold and Deficiency
- Presents as a cardiovascular system that feels cold, depleted, or underpowered: low blood pressure, cold hands and feet, fatigue, dizziness, weak pulse, pallor, and easy exhaustion
- Eeyore is the archetype: gray, low energy, gloomy, the kind of tired that sits deep in the bones
- Energetically: a deficient or underactive system; circulation sluggish, warmth lacking, vitality low

# Herbs for Cold and Deficiency
- Ginger (*Zingiber officinale*) warms circulation and digestion; Cayenne (*Capsicum annuum*) stimulates blood flow even in small amounts
- Rosemary (*Salvia rosmarinus*) improves circulation while sharpening mental clarity; Prickly Ash (*Zanthoxylum americanum*) is a classic circulatory stimulant for cold, sluggish tissues'),

  -- ============================================================
  -- STAGNATION PATTERN
  -- ============================================================
  (203,
   'Turmeric (*Curcuma longa*) supports circulation and healthy inflammatory balance; suited to the Stagnation pattern of blood not moving freely, varicose veins, edema, and sharp localized pain.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Stagnation Pattern', 90,
   '# Pattern: Stagnation
- Blood not moving freely: varicose veins, sharp localized pain, heavy feeling in the limbs, bruising, edema
- Like a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction

# Herbs for Stagnation
- Turmeric (*Curcuma longa*) supports circulation and healthy inflammatory balance; Ginger (*Zingiber officinale*) gently stimulates blood flow
- Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; Cinnamon (*Cinnamomum verum*) warms and encourages circulation; Dan Shen (*Salvia miltiorrhiza*) widely used in Chinese medicine to support blood flow'),

  (124,
   'Ginger (*Zingiber officinale*) gently stimulates blood flow; suited to the Stagnation pattern alongside other blood-moving herbs.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Stagnation Pattern', 100,
   '# Pattern: Stagnation
- Blood not moving freely: varicose veins, sharp localized pain, heavy feeling in the limbs, bruising, edema
- Like a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction

# Herbs for Stagnation
- Turmeric (*Curcuma longa*) supports circulation and healthy inflammatory balance; Ginger (*Zingiber officinale*) gently stimulates blood flow
- Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; Cinnamon (*Cinnamomum verum*) warms and encourages circulation; Dan Shen (*Salvia miltiorrhiza*) widely used in Chinese medicine to support blood flow'),

  (1009,
   'Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; a primary herb for the Stagnation pattern of impaired circulation.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Stagnation Pattern', 110,
   '# Pattern: Stagnation
- Blood not moving freely: varicose veins, sharp localized pain, heavy feeling in the limbs, bruising, edema
- Like a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction

# Herbs for Stagnation
- Turmeric (*Curcuma longa*) supports circulation and healthy inflammatory balance; Ginger (*Zingiber officinale*) gently stimulates blood flow
- Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; Cinnamon (*Cinnamomum verum*) warms and encourages circulation; Dan Shen (*Salvia miltiorrhiza*) widely used in Chinese medicine to support blood flow'),

  (167,
   'Cinnamon (*Cinnamomum verum*) warms and encourages circulation; suited to the Stagnation pattern of sluggish blood flow.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Stagnation Pattern', 120,
   '# Pattern: Stagnation
- Blood not moving freely: varicose veins, sharp localized pain, heavy feeling in the limbs, bruising, edema
- Like a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction

# Herbs for Stagnation
- Turmeric (*Curcuma longa*) supports circulation and healthy inflammatory balance; Ginger (*Zingiber officinale*) gently stimulates blood flow
- Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; Cinnamon (*Cinnamomum verum*) warms and encourages circulation; Dan Shen (*Salvia miltiorrhiza*) widely used in Chinese medicine to support blood flow'),

  (956,
   'Dan Shen (*Salvia miltiorrhiza*) is widely used in Chinese medicine to support blood flow; a key herb for the Stagnation pattern.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Stagnation Pattern', 130,
   '# Pattern: Stagnation
- Blood not moving freely: varicose veins, sharp localized pain, heavy feeling in the limbs, bruising, edema
- Like a stream hitting a logjam: water still there but backed up, pooling, building pressure at the point of obstruction

# Herbs for Stagnation
- Turmeric (*Curcuma longa*) supports circulation and healthy inflammatory balance; Ginger (*Zingiber officinale*) gently stimulates blood flow
- Dong Quai (*Angelica sinensis*) traditionally moves and nourishes blood; Cinnamon (*Cinnamomum verum*) warms and encourages circulation; Dan Shen (*Salvia miltiorrhiza*) widely used in Chinese medicine to support blood flow'),

  -- ============================================================
  -- BLOOD DEFICIENCY PATTERN
  -- ============================================================
  (43,
   'Nettle (*Urtica dioica*), rich in minerals, supports the Blood Deficiency pattern of dry skin, pallor, fatigue, and poor concentration.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Deficiency Pattern', 140,
   '# Pattern: Blood Deficiency
- Presents as dry skin, dizziness, difficulty concentrating, pallor, brittle hair, fatigue, and anxiety
- In TCM, blood is said to anchor the mind and spirit; when deficient, the mind may feel restless or unsettled
- Piglet is the archetype: small, pale, easily startled, never quite feeling there is enough underneath to stand steady on

# Herbs for Blood Deficiency
- Nettle (*Urtica dioica*), rich in minerals; Yellow Dock (*Rumex crispus*), supports iron metabolism; Burdock Root (*Arctium lappa*), nourishes and supports the blood
- Dandelion Root (*Taraxacum officinale*), supports digestion and nutrient assimilation'),

  (37,
   'Yellow Dock (*Rumex crispus*) supports iron metabolism; a key herb for Blood Deficiency pattern with pallor, fatigue, and anemia tendency.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Deficiency Pattern', 150,
   '# Pattern: Blood Deficiency
- Presents as dry skin, dizziness, difficulty concentrating, pallor, brittle hair, fatigue, and anxiety
- In TCM, blood is said to anchor the mind and spirit; when deficient, the mind may feel restless or unsettled
- Piglet is the archetype: small, pale, easily startled, never quite feeling there is enough underneath to stand steady on

# Herbs for Blood Deficiency
- Nettle (*Urtica dioica*), rich in minerals; Yellow Dock (*Rumex crispus*), supports iron metabolism; Burdock Root (*Arctium lappa*), nourishes and supports the blood
- Dandelion Root (*Taraxacum officinale*), supports digestion and nutrient assimilation'),

  (22,
   'Burdock Root (*Arctium lappa*) nourishes and supports the blood; suited to the Blood Deficiency pattern of depletion and poor nourishment.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Deficiency Pattern', 160,
   '# Pattern: Blood Deficiency
- Presents as dry skin, dizziness, difficulty concentrating, pallor, brittle hair, fatigue, and anxiety
- In TCM, blood is said to anchor the mind and spirit; when deficient, the mind may feel restless or unsettled
- Piglet is the archetype: small, pale, easily startled, never quite feeling there is enough underneath to stand steady on

# Herbs for Blood Deficiency
- Nettle (*Urtica dioica*), rich in minerals; Yellow Dock (*Rumex crispus*), supports iron metabolism; Burdock Root (*Arctium lappa*), nourishes and supports the blood
- Dandelion Root (*Taraxacum officinale*), supports digestion and nutrient assimilation'),

  (122,
   'Dandelion Root (*Taraxacum officinale*) supports digestion and nutrient assimilation; used in the Blood Deficiency pattern to improve uptake of blood-building nutrients.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Deficiency Pattern', 170,
   '# Pattern: Blood Deficiency
- Presents as dry skin, dizziness, difficulty concentrating, pallor, brittle hair, fatigue, and anxiety
- In TCM, blood is said to anchor the mind and spirit; when deficient, the mind may feel restless or unsettled
- Piglet is the archetype: small, pale, easily startled, never quite feeling there is enough underneath to stand steady on

# Herbs for Blood Deficiency
- Nettle (*Urtica dioica*), rich in minerals; Yellow Dock (*Rumex crispus*), supports iron metabolism; Burdock Root (*Arctium lappa*), nourishes and supports the blood
- Dandelion Root (*Taraxacum officinale*), supports digestion and nutrient assimilation'),

  -- ============================================================
  -- BLOOD SUGAR AND METABOLIC SUPPORT
  -- ============================================================
  (167,
   'Cinnamon is used to support healthy glucose metabolism; supporting blood sugar balance with metabolic herbs indirectly supports long-term cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Sugar and Metabolic Support', 180,
   '# Herbs for Blood Sugar and Metabolic Support
- Cinnamon, fenugreek, and berberine-containing plants (like goldenseal or Oregon grape) are often used to support healthy glucose metabolism
- Supporting blood sugar balance with digestive bitters and metabolic herbs indirectly supports long-term cardiovascular health

# Blood Sugar Regulation and the Heart
- Chronic elevated blood sugar damages blood vessels over time, contributing to inflammation, impaired circulation, and increased cardiovascular risk
- Insulin resistance and metabolic syndrome are now recognized as major contributors to heart disease'),

  (91,
   'Fenugreek is used to support healthy glucose metabolism; a metabolic herb that indirectly supports long-term cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Sugar and Metabolic Support', 190,
   '# Herbs for Blood Sugar and Metabolic Support
- Cinnamon, fenugreek, and berberine-containing plants (like goldenseal or Oregon grape) are often used to support healthy glucose metabolism
- Supporting blood sugar balance with digestive bitters and metabolic herbs indirectly supports long-term cardiovascular health

# Blood Sugar Regulation and the Heart
- Chronic elevated blood sugar damages blood vessels over time, contributing to inflammation, impaired circulation, and increased cardiovascular risk
- Insulin resistance and metabolic syndrome are now recognized as major contributors to heart disease'),

  (33,
   'Oregon Grape (*Mahonia aquifolium*), a berberine-containing plant, is used to support healthy glucose metabolism and cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Sugar and Metabolic Support', 200,
   '# Herbs for Blood Sugar and Metabolic Support
- Cinnamon, fenugreek, and berberine-containing plants (like goldenseal or Oregon grape) are often used to support healthy glucose metabolism
- Supporting blood sugar balance with digestive bitters and metabolic herbs indirectly supports long-term cardiovascular health

# Blood Sugar Regulation and the Heart
- Chronic elevated blood sugar damages blood vessels over time, contributing to inflammation, impaired circulation, and increased cardiovascular risk
- Insulin resistance and metabolic syndrome are now recognized as major contributors to heart disease'),

  (30,
   'Goldenseal (*Hydrastis canadensis*), a berberine-containing plant, is used to support healthy glucose metabolism and cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Blood Sugar and Metabolic Support', 210,
   '# Herbs for Blood Sugar and Metabolic Support
- Cinnamon, fenugreek, and berberine-containing plants (like goldenseal or Oregon grape) are often used to support healthy glucose metabolism
- Supporting blood sugar balance with digestive bitters and metabolic herbs indirectly supports long-term cardiovascular health

# Blood Sugar Regulation and the Heart
- Chronic elevated blood sugar damages blood vessels over time, contributing to inflammation, impaired circulation, and increased cardiovascular risk
- Insulin resistance and metabolic syndrome are now recognized as major contributors to heart disease'),

  -- ============================================================
  -- CARDIOVASCULAR INFLAMMATION AND VASCULAR HEALTH
  -- ============================================================
  (203,
   'Turmeric (*Curcuma longa*) helps support the body''s inflammatory response and vascular health; particularly useful when circulation feels sluggish or when there are signs of pooling or congestion alongside an inflammatory picture.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cardiovascular Inflammation and Vascular Health', 220,
   '# Turmeric for Vascular Health
- Turmeric (*Curcuma longa*) helps support the body''s inflammatory response and vascular health
- Particularly useful when circulation feels sluggish or when there are signs of pooling or congestion alongside an inflammatory picture

# Garlic for Circulation and Immunity
- Garlic (*Allium sativum*) supports both circulation and immune balance - a dual-action heart herb
- Used traditionally and supported by modern research for its cardiovascular and antimicrobial effects

# Hawthorn for Heart and Endothelial Health
- Hawthorn (*Crataegus spp.*) nourishes the heart while also supporting healthy endothelial function
- Works on multiple levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining

# Hibiscus for Antioxidant and Vascular Support
- Hibiscus (*Hibiscus sabdariffa*) offers antioxidant support while gently relaxing blood vessels
- Well-studied for gentle blood pressure support; pairs well with other nervine-cardiac herbs in a Heat and Tension protocol'),

  (21,
   'Garlic (*Allium sativum*) supports both circulation and immune balance - a dual-action heart herb; used traditionally and supported by modern research for cardiovascular and antimicrobial effects.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cardiovascular Inflammation and Vascular Health', 230,
   '# Turmeric for Vascular Health
- Turmeric (*Curcuma longa*) helps support the body''s inflammatory response and vascular health
- Particularly useful when circulation feels sluggish or when there are signs of pooling or congestion alongside an inflammatory picture

# Garlic for Circulation and Immunity
- Garlic (*Allium sativum*) supports both circulation and immune balance - a dual-action heart herb
- Used traditionally and supported by modern research for its cardiovascular and antimicrobial effects

# Hawthorn for Heart and Endothelial Health
- Hawthorn (*Crataegus spp.*) nourishes the heart while also supporting healthy endothelial function
- Works on multiple levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining

# Hibiscus for Antioxidant and Vascular Support
- Hibiscus (*Hibiscus sabdariffa*) offers antioxidant support while gently relaxing blood vessels
- Well-studied for gentle blood pressure support; pairs well with other nervine-cardiac herbs in a Heat and Tension protocol'),

  (73,
   'Hawthorn (*Crataegus spp.*) nourishes the heart while supporting healthy endothelial function; works on multiple levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cardiovascular Inflammation and Vascular Health', 240,
   '# Turmeric for Vascular Health
- Turmeric (*Curcuma longa*) helps support the body''s inflammatory response and vascular health
- Particularly useful when circulation feels sluggish or when there are signs of pooling or congestion alongside an inflammatory picture

# Garlic for Circulation and Immunity
- Garlic (*Allium sativum*) supports both circulation and immune balance - a dual-action heart herb
- Used traditionally and supported by modern research for its cardiovascular and antimicrobial effects

# Hawthorn for Heart and Endothelial Health
- Hawthorn (*Crataegus spp.*) nourishes the heart while also supporting healthy endothelial function
- Works on multiple levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining

# Hibiscus for Antioxidant and Vascular Support
- Hibiscus (*Hibiscus sabdariffa*) offers antioxidant support while gently relaxing blood vessels
- Well-studied for gentle blood pressure support; pairs well with other nervine-cardiac herbs in a Heat and Tension protocol'),

  (2233,
   'Hibiscus (*Hibiscus sabdariffa*) offers antioxidant support while gently relaxing blood vessels; well-studied for gentle blood pressure support and pairs well with nervine-cardiac herbs in a Heat and Tension protocol.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Cardiovascular Inflammation and Vascular Health', 250,
   '# Turmeric for Vascular Health
- Turmeric (*Curcuma longa*) helps support the body''s inflammatory response and vascular health
- Particularly useful when circulation feels sluggish or when there are signs of pooling or congestion alongside an inflammatory picture

# Garlic for Circulation and Immunity
- Garlic (*Allium sativum*) supports both circulation and immune balance - a dual-action heart herb
- Used traditionally and supported by modern research for its cardiovascular and antimicrobial effects

# Hawthorn for Heart and Endothelial Health
- Hawthorn (*Crataegus spp.*) nourishes the heart while also supporting healthy endothelial function
- Works on multiple levels: tonifying the heart muscle, supporting vessel tone, and offering antioxidant protection to the vessel lining

# Hibiscus for Antioxidant and Vascular Support
- Hibiscus (*Hibiscus sabdariffa*) offers antioxidant support while gently relaxing blood vessels
- Well-studied for gentle blood pressure support; pairs well with other nervine-cardiac herbs in a Heat and Tension protocol'),

  -- ============================================================
  -- HEART-NERVOUS SYSTEM SUPPORT
  -- ============================================================
  (131,
   'Motherwort (*Leonurus cardiaca*) is famous for calming a racing heart connected to anxiety; a primary nervine-cardiac herb for the heart-nervous system connection.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Nervous System Support', 260,
   '# The Heart-Nervous System Connection
- The heart and nervous system are in constant bidirectional conversation; this is why supporting the nervous system often directly supports heart rhythm and adaptability
- Stress has a direct physiological pathway to the heart via the autonomic nervous system - one reason so many traditional heart herbs are nervines

# Nervine Herbs for the Heart-Nervous System
- Motherwort (*Leonurus cardiaca*) is famous for calming a racing heart connected to anxiety
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nervous system; Lemon Balm (*Melissa officinalis*) gently settles both emotional agitation and palpitations'),

  (90,
   'Linden (*Tilia spp.*) relaxes vascular tension while soothing the nervous system; a core nervine-cardiac herb for the heart-nervous system connection.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Nervous System Support', 270,
   '# The Heart-Nervous System Connection
- The heart and nervous system are in constant bidirectional conversation; this is why supporting the nervous system often directly supports heart rhythm and adaptability
- Stress has a direct physiological pathway to the heart via the autonomic nervous system - one reason so many traditional heart herbs are nervines

# Nervine Herbs for the Heart-Nervous System
- Motherwort (*Leonurus cardiaca*) is famous for calming a racing heart connected to anxiety
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nervous system; Lemon Balm (*Melissa officinalis*) gently settles both emotional agitation and palpitations'),

  (134,
   'Lemon Balm (*Melissa officinalis*) gently settles both emotional agitation and palpitations; a nervine-cardiac herb for the heart-nervous system connection.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Nervous System Support', 280,
   '# The Heart-Nervous System Connection
- The heart and nervous system are in constant bidirectional conversation; this is why supporting the nervous system often directly supports heart rhythm and adaptability
- Stress has a direct physiological pathway to the heart via the autonomic nervous system - one reason so many traditional heart herbs are nervines

# Nervine Herbs for the Heart-Nervous System
- Motherwort (*Leonurus cardiaca*) is famous for calming a racing heart connected to anxiety
- Linden (*Tilia spp.*) relaxes vascular tension while soothing the nervous system; Lemon Balm (*Melissa officinalis*) gently settles both emotional agitation and palpitations'),

  -- ============================================================
  -- LUNGS AND HEART
  -- ============================================================
  (21,
   'Garlic supports healthy circulation while also clearing the lungs; a dual-action herb bridging cardiovascular and respiratory support.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Lungs and Heart', 290,
   '# Herbs That Bridge Lungs and Heart
- Garlic supports healthy circulation while also clearing the lungs; Ginger warms the lungs and gets blood moving
- Cordyceps (*Cordyceps sinensis*) is a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality when the whole system feels depleted
- In TCM: the Lungs govern Qi, the Heart governs blood, and Qi leads the blood - where the breath goes, circulation follows'),

  (124,
   'Ginger warms the lungs and gets blood moving; bridges respiratory and cardiovascular support.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Lungs and Heart', 300,
   '# Herbs That Bridge Lungs and Heart
- Garlic supports healthy circulation while also clearing the lungs; Ginger warms the lungs and gets blood moving
- Cordyceps (*Cordyceps sinensis*) is a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality when the whole system feels depleted
- In TCM: the Lungs govern Qi, the Heart governs blood, and Qi leads the blood - where the breath goes, circulation follows'),

  (2634,
   'Cordyceps (*Cordyceps sinensis*) is a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality when the whole system feels depleted; bridges lung and cardiovascular endurance.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Lungs and Heart', 310,
   '# Herbs That Bridge Lungs and Heart
- Garlic supports healthy circulation while also clearing the lungs; Ginger warms the lungs and gets blood moving
- Cordyceps (*Cordyceps sinensis*) is a tonic mushroom traditionally used to support the lungs, improve stamina, and restore vitality when the whole system feels depleted
- In TCM: the Lungs govern Qi, the Heart governs blood, and Qi leads the blood - where the breath goes, circulation follows'),

  -- ============================================================
  -- LIVER SUPPORT FOR CARDIOVASCULAR HEALTH
  -- ============================================================
  (122,
   'Dandelion root (*Taraxacum officinale*) supports bile flow and metabolic balance, indirectly supporting healthy circulation and blood composition; a classic liver-supportive herb in heart formulas.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Liver Support for Cardiovascular Health', 320,
   '# The Liver and Cardiovascular Health
- The liver plays a surprisingly large role in cardiovascular health: filters blood, regulates cholesterol production, processes hormones, stores iron and B vitamins for healthy blood formation
- When the liver becomes overburdened, lipid balance may shift, inflammatory signals may rise, and blood vessels may become less resilient

# Liver-Supportive Herbs for Cardiovascular Health
- Dandelion root (*Taraxacum officinale*), Artichoke leaf (*Cynara scolymus*), and Burdock root (*Arctium lappa*) support bile flow and metabolic balance, indirectly supporting healthy circulation and blood composition
- Including liver-supportive herbs in heart formulas is a traditional practice across many herbal systems'),

  (172,
   'Artichoke leaf (*Cynara scolymus*) supports bile flow and metabolic balance; a liver-supportive herb used in heart formulas to support healthy lipid balance and circulation.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Liver Support for Cardiovascular Health', 330,
   '# The Liver and Cardiovascular Health
- The liver plays a surprisingly large role in cardiovascular health: filters blood, regulates cholesterol production, processes hormones, stores iron and B vitamins for healthy blood formation
- When the liver becomes overburdened, lipid balance may shift, inflammatory signals may rise, and blood vessels may become less resilient

# Liver-Supportive Herbs for Cardiovascular Health
- Dandelion root (*Taraxacum officinale*), Artichoke leaf (*Cynara scolymus*), and Burdock root (*Arctium lappa*) support bile flow and metabolic balance, indirectly supporting healthy circulation and blood composition
- Including liver-supportive herbs in heart formulas is a traditional practice across many herbal systems'),

  (22,
   'Burdock root (*Arctium lappa*) supports bile flow and metabolic balance; used as a liver-supportive herb in heart formulas to improve blood composition.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Liver Support for Cardiovascular Health', 340,
   '# The Liver and Cardiovascular Health
- The liver plays a surprisingly large role in cardiovascular health: filters blood, regulates cholesterol production, processes hormones, stores iron and B vitamins for healthy blood formation
- When the liver becomes overburdened, lipid balance may shift, inflammatory signals may rise, and blood vessels may become less resilient

# Liver-Supportive Herbs for Cardiovascular Health
- Dandelion root (*Taraxacum officinale*), Artichoke leaf (*Cynara scolymus*), and Burdock root (*Arctium lappa*) support bile flow and metabolic balance, indirectly supporting healthy circulation and blood composition
- Including liver-supportive herbs in heart formulas is a traditional practice across many herbal systems'),

  -- ============================================================
  -- KIDNEY AND HEART SUPPORT
  -- ============================================================
  (1648,
   'Dandelion leaf (*Taraxacum officinale*) is a gentle food-grade diuretic that supports kidney function without depleting electrolytes; notably potassium-sparing - it brings its own potassium while supporting fluid balance and heart health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Kidney and Heart Support', 350,
   '# The Kidneys and Cardiovascular Health
- The kidneys monitor blood volume, balance fluids and electrolytes, and regulate fluid retention - all of which directly affect blood pressure and cardiac workload
- Chronic kidney strain often manifests as elevated blood pressure; supporting kidney function is part of a comprehensive heart protocol

# Gentle Diuretic Herbs for Kidney and Heart Support
- Dandelion leaf (*Taraxacum officinale*), Parsley (*Petroselinum crispum*), and Nettle (*Urtica dioica*) are gentle food-grade diuretics that support kidney function without depleting electrolytes the way pharmaceutical diuretics can
- Dandelion leaf is notably potassium-sparing - it brings its own potassium while supporting fluid balance'),

  (120,
   'Parsley (*Petroselinum crispum*) is a gentle food-grade diuretic that supports kidney function without depleting electrolytes; supports fluid balance and cardiac workload.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Kidney and Heart Support', 360,
   '# The Kidneys and Cardiovascular Health
- The kidneys monitor blood volume, balance fluids and electrolytes, and regulate fluid retention - all of which directly affect blood pressure and cardiac workload
- Chronic kidney strain often manifests as elevated blood pressure; supporting kidney function is part of a comprehensive heart protocol

# Gentle Diuretic Herbs for Kidney and Heart Support
- Dandelion leaf (*Taraxacum officinale*), Parsley (*Petroselinum crispum*), and Nettle (*Urtica dioica*) are gentle food-grade diuretics that support kidney function without depleting electrolytes the way pharmaceutical diuretics can
- Dandelion leaf is notably potassium-sparing - it brings its own potassium while supporting fluid balance'),

  (43,
   'Nettle (*Urtica dioica*) is a gentle food-grade diuretic that supports kidney function and fluid balance without depleting electrolytes; supports cardiovascular health through the kidney-heart connection.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Kidney and Heart Support', 370,
   '# The Kidneys and Cardiovascular Health
- The kidneys monitor blood volume, balance fluids and electrolytes, and regulate fluid retention - all of which directly affect blood pressure and cardiac workload
- Chronic kidney strain often manifests as elevated blood pressure; supporting kidney function is part of a comprehensive heart protocol

# Gentle Diuretic Herbs for Kidney and Heart Support
- Dandelion leaf (*Taraxacum officinale*), Parsley (*Petroselinum crispum*), and Nettle (*Urtica dioica*) are gentle food-grade diuretics that support kidney function without depleting electrolytes the way pharmaceutical diuretics can
- Dandelion leaf is notably potassium-sparing - it brings its own potassium while supporting fluid balance'),

  -- ============================================================
  -- DIGESTIVE SUPPORT FOR HEART HEALTH
  -- ============================================================
  (102,
   'Gentian (*Gentiana lutea*) is a classic digestive bitter that stimulates bile flow, improves nutrient absorption, and supports liver function; used before meals to activate the entire digestive cascade with far-reaching metabolic and cardiovascular benefits.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Digestive Support for Heart Health', 380,
   '# Digestive Bitters for Heart Support
- Gentian (*Gentiana lutea*) and Dandelion (*Taraxacum officinale*) are classic digestive bitters that stimulate bile flow, improve nutrient absorption, and support liver function
- Bitters before meals activate the entire digestive cascade - a simple daily practice with far-reaching effects on metabolic and cardiovascular health

# TCM: Spleen Qi as Crucial to Heart-Blood
- In TCM, the Spleen (digestive function) generates the blood that the Heart then circulates; Spleen Qi deficiency leads to Heart Blood deficiency
- Supporting digestion - including through bitters, tonics, and regular eating habits - is a foundational heart support strategy'),

  (122,
   'Dandelion (*Taraxacum officinale*) is a classic digestive bitter that stimulates bile flow and improves nutrient absorption; used before meals to support metabolic and cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Digestive Support for Heart Health', 390,
   '# Digestive Bitters for Heart Support
- Gentian (*Gentiana lutea*) and Dandelion (*Taraxacum officinale*) are classic digestive bitters that stimulate bile flow, improve nutrient absorption, and support liver function
- Bitters before meals activate the entire digestive cascade - a simple daily practice with far-reaching effects on metabolic and cardiovascular health

# TCM: Spleen Qi as Crucial to Heart-Blood
- In TCM, the Spleen (digestive function) generates the blood that the Heart then circulates; Spleen Qi deficiency leads to Heart Blood deficiency
- Supporting digestion - including through bitters, tonics, and regular eating habits - is a foundational heart support strategy'),

  -- ============================================================
  -- ORAL HEALTH AND CARDIOVASCULAR RISK
  -- ============================================================
  (56,
   'Sage (*Salvia officinalis*) is an antimicrobial, anti-inflammatory herb used in mouth rinses and gum care to reduce bacterial burden that can enter circulation from unhealthy gum tissue.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Oral Health and Cardiovascular Risk', 400,
   '# Oral Health and the Heart
- Gum disease triggers chronic low-grade inflammation, allows bacteria to enter the bloodstream, and may directly damage blood vessel walls
- Maintaining good oral health is a surprisingly impactful cardiovascular intervention

# Herbs for Oral Health
- Sage (*Salvia officinalis*), Myrrh (*Commiphora myrrha*), Calendula (*Calendula officinalis*), and Goldenseal (*Hydrastis canadensis*) are antimicrobial, anti-inflammatory herbs used in mouth rinses and gum care
- These herbs address the oral microbiome directly, reducing the bacterial burden that can enter circulation from unhealthy gum tissue'),

  (99,
   'Myrrh (*Commiphora myrrha*) is an antimicrobial, anti-inflammatory herb used in mouth rinses and gum care to reduce the cardiovascular risk associated with gum disease.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Oral Health and Cardiovascular Risk', 410,
   '# Oral Health and the Heart
- Gum disease triggers chronic low-grade inflammation, allows bacteria to enter the bloodstream, and may directly damage blood vessel walls
- Maintaining good oral health is a surprisingly impactful cardiovascular intervention

# Herbs for Oral Health
- Sage (*Salvia officinalis*), Myrrh (*Commiphora myrrha*), Calendula (*Calendula officinalis*), and Goldenseal (*Hydrastis canadensis*) are antimicrobial, anti-inflammatory herbs used in mouth rinses and gum care
- These herbs address the oral microbiome directly, reducing the bacterial burden that can enter circulation from unhealthy gum tissue'),

  (70,
   'Calendula (*Calendula officinalis*) is an antimicrobial, anti-inflammatory herb used in mouth rinses and gum care to reduce the cardiovascular risk associated with oral bacteria.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Oral Health and Cardiovascular Risk', 420,
   '# Oral Health and the Heart
- Gum disease triggers chronic low-grade inflammation, allows bacteria to enter the bloodstream, and may directly damage blood vessel walls
- Maintaining good oral health is a surprisingly impactful cardiovascular intervention

# Herbs for Oral Health
- Sage (*Salvia officinalis*), Myrrh (*Commiphora myrrha*), Calendula (*Calendula officinalis*), and Goldenseal (*Hydrastis canadensis*) are antimicrobial, anti-inflammatory herbs used in mouth rinses and gum care
- These herbs address the oral microbiome directly, reducing the bacterial burden that can enter circulation from unhealthy gum tissue'),

  (30,
   'Goldenseal (*Hydrastis canadensis*) is an antimicrobial, anti-inflammatory herb used in mouth rinses and gum care to reduce the cardiovascular risk associated with gum disease and oral bacteria.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Oral Health and Cardiovascular Risk', 430,
   '# Oral Health and the Heart
- Gum disease triggers chronic low-grade inflammation, allows bacteria to enter the bloodstream, and may directly damage blood vessel walls
- Maintaining good oral health is a surprisingly impactful cardiovascular intervention

# Herbs for Oral Health
- Sage (*Salvia officinalis*), Myrrh (*Commiphora myrrha*), Calendula (*Calendula officinalis*), and Goldenseal (*Hydrastis canadensis*) are antimicrobial, anti-inflammatory herbs used in mouth rinses and gum care
- These herbs address the oral microbiome directly, reducing the bacterial burden that can enter circulation from unhealthy gum tissue'),

  -- ============================================================
  -- EMOTIONAL HEART
  -- ============================================================
  (73,
   'Hawthorn (*Crataegus spp.*) berries nourish both the physical heart and the emotional heart - deeply tonic and restorative; appropriate for grief, heartache, and cardiovascular depletion simultaneously.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Emotional Heart', 440,
   '# Herbs for the Emotional Heart
- Hawthorn (*Crataegus spp.*) berries nourish both the physical heart and the emotional heart - deeply tonic and restorative
- Rose (*Rosa spp.*) gently opens the heart and supports emotional processing; Linden (*Tilia spp.*) is profoundly relaxing, releasing tension from the chest and soothing grief and anxiety

# The Emotional Heart
- Loneliness and social isolation are associated with significantly increased cardiovascular risk; connection is medicine
- Emotions produce measurable physiological changes in the cardiovascular system - heartbreak, heartache, and a full heart are not merely metaphors'),

  (850,
   'Rose (*Rosa spp.*) gently opens the heart and supports emotional processing; suited to heartache, grief, and the emotional dimensions of cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Emotional Heart', 450,
   '# Herbs for the Emotional Heart
- Hawthorn (*Crataegus spp.*) berries nourish both the physical heart and the emotional heart - deeply tonic and restorative
- Rose (*Rosa spp.*) gently opens the heart and supports emotional processing; Linden (*Tilia spp.*) is profoundly relaxing, releasing tension from the chest and soothing grief and anxiety

# The Emotional Heart
- Loneliness and social isolation are associated with significantly increased cardiovascular risk; connection is medicine
- Emotions produce measurable physiological changes in the cardiovascular system - heartbreak, heartache, and a full heart are not merely metaphors'),

  (90,
   'Linden (*Tilia spp.*) is profoundly relaxing, releasing tension from the chest and soothing grief and anxiety; a key herb for the emotional dimensions of heart health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Emotional Heart', 460,
   '# Herbs for the Emotional Heart
- Hawthorn (*Crataegus spp.*) berries nourish both the physical heart and the emotional heart - deeply tonic and restorative
- Rose (*Rosa spp.*) gently opens the heart and supports emotional processing; Linden (*Tilia spp.*) is profoundly relaxing, releasing tension from the chest and soothing grief and anxiety

# The Emotional Heart
- Loneliness and social isolation are associated with significantly increased cardiovascular risk; connection is medicine
- Emotions produce measurable physiological changes in the cardiovascular system - heartbreak, heartache, and a full heart are not merely metaphors'),

  -- ============================================================
  -- HEART-MIND (SHEN) AND COGNITIVE HEALTH
  -- ============================================================
  (1541,
   'Poria (*Wolfiporia extensa*, fu ling) is a classic TCM herb for calming the heart-mind and resolving phlegm; used for cognitive fogginess, emotional heaviness, and poor concentration linked to Heart-Spleen imbalance.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Mind (Shen) and Cognitive Health', 470,
   '# Herbs for the Heart-Mind (Shen)
- Poria (*Wolfiporia extensa*, fu ling) is a classic TCM herb for calming the heart-mind and resolving phlegm; Reishi (*Ganoderma spp.*) supports both immune resilience and the nervous system
- Tulsi (*Ocimum tenuifolium*) is an adaptogenic nervine that lifts the spirit and calms anxiety; Rosemary (*Salvia rosmarinus*) improves circulation to the brain and supports cognitive clarity

# Shen and Cognitive Health
- In TCM, the Shen (Heart-Mind) encompasses consciousness, thought, memory, and emotional experience
- Heart patients experience higher rates of cognitive dysfunction; heart disease and cognitive decline share common risk factors
- Stroke survivors with atrial fibrillation are 2.4x more likely to develop dementia - vascular health is brain health
- Supporting resilience, inner peace, and emotional wellbeing is supporting heart health'),

  (11,
   'Reishi (*Ganoderma spp.*) supports both immune resilience and the nervous system; used to calm the heart-mind and support cognitive and cardiovascular health simultaneously.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Mind (Shen) and Cognitive Health', 480,
   '# Herbs for the Heart-Mind (Shen)
- Poria (*Wolfiporia extensa*, fu ling) is a classic TCM herb for calming the heart-mind and resolving phlegm; Reishi (*Ganoderma spp.*) supports both immune resilience and the nervous system
- Tulsi (*Ocimum tenuifolium*) is an adaptogenic nervine that lifts the spirit and calms anxiety; Rosemary (*Salvia rosmarinus*) improves circulation to the brain and supports cognitive clarity

# Shen and Cognitive Health
- In TCM, the Shen (Heart-Mind) encompasses consciousness, thought, memory, and emotional experience
- Heart patients experience higher rates of cognitive dysfunction; heart disease and cognitive decline share common risk factors
- Stroke survivors with atrial fibrillation are 2.4x more likely to develop dementia - vascular health is brain health
- Supporting resilience, inner peace, and emotional wellbeing is supporting heart health'),

  (13,
   'Tulsi (*Ocimum tenuifolium*) is an adaptogenic nervine that lifts the spirit and calms anxiety; suited to the Heart-Mind (Shen) pattern of restlessness, worry, and poor concentration linked to Heart imbalance.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Mind (Shen) and Cognitive Health', 490,
   '# Herbs for the Heart-Mind (Shen)
- Poria (*Wolfiporia extensa*, fu ling) is a classic TCM herb for calming the heart-mind and resolving phlegm; Reishi (*Ganoderma spp.*) supports both immune resilience and the nervous system
- Tulsi (*Ocimum tenuifolium*) is an adaptogenic nervine that lifts the spirit and calms anxiety; Rosemary (*Salvia rosmarinus*) improves circulation to the brain and supports cognitive clarity

# Shen and Cognitive Health
- In TCM, the Shen (Heart-Mind) encompasses consciousness, thought, memory, and emotional experience
- Heart patients experience higher rates of cognitive dysfunction; heart disease and cognitive decline share common risk factors
- Stroke survivors with atrial fibrillation are 2.4x more likely to develop dementia - vascular health is brain health
- Supporting resilience, inner peace, and emotional wellbeing is supporting heart health'),

  (109,
   'Rosemary (*Salvia rosmarinus*) improves circulation to the brain and supports cognitive clarity; used in the Heart-Mind (Shen) context to address cognitive symptoms linked to cardiovascular deficiency.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Heart-Mind (Shen) and Cognitive Health', 500,
   '# Herbs for the Heart-Mind (Shen)
- Poria (*Wolfiporia extensa*, fu ling) is a classic TCM herb for calming the heart-mind and resolving phlegm; Reishi (*Ganoderma spp.*) supports both immune resilience and the nervous system
- Tulsi (*Ocimum tenuifolium*) is an adaptogenic nervine that lifts the spirit and calms anxiety; Rosemary (*Salvia rosmarinus*) improves circulation to the brain and supports cognitive clarity

# Shen and Cognitive Health
- In TCM, the Shen (Heart-Mind) encompasses consciousness, thought, memory, and emotional experience
- Heart patients experience higher rates of cognitive dysfunction; heart disease and cognitive decline share common risk factors
- Stroke survivors with atrial fibrillation are 2.4x more likely to develop dementia - vascular health is brain health
- Supporting resilience, inner peace, and emotional wellbeing is supporting heart health'),

  -- ============================================================
  -- ADAPTOGENS FOR STRESS AND HEART RESILIENCE
  -- ============================================================
  (14,
   'Asian Ginseng (*Panax ginseng*) is warming and stimulating - best suited to cold, depleted individuals; a stimulating adaptogen for cardiovascular and stress resilience support.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 510,
   '# Adaptogens for Stress Resilience
- Adaptogens support the body''s resilience to stress - given the strong link between chronic stress and cardiovascular disease, they are a core component of heart health protocols
- Individualize: some people need stimulating adaptogens (like Asian ginseng), others need calming ones (like ashwagandha or reishi); matching energy and constitution is essential

# The Ginsengs
- Asian ginseng (*Panax ginseng*) is warming and stimulating - best for cold, depleted individuals; American ginseng (*Panax quinquefolius*) is cooler and more moistening
- Siberian ginseng (*Eleutherococcus senticosus*) is a milder adaptogen, well suited to long-term use and immune support

# Ashwagandha
- Ashwagandha (*Withania somnifera*) is a warming, tonifying adaptogen especially suited to exhausted, anxious individuals who are depleted by chronic stress
- Well-researched for cortisol modulation and thyroid support - both directly relevant to cardiovascular health

# Medicinal Mushroom Adaptogens
- Cordyceps supports lung and cardiovascular endurance; Reishi modulates the immune system and calms the nervous system
- These mushrooms are deeply tonic - suited to long-term use in debilitated or chronically stressed individuals

# Schisandra and Tulsi
- Schisandra (*Schisandra chinensis*) supports liver, kidneys, heart, and nervous system simultaneously - a true whole-body adaptogen
- Tulsi (*Ocimum tenuifolium*) is an uplifting, clarifying adaptogen gentle enough for daily use as a tea'),

  (15,
   'American Ginseng (*Panax quinquefolius*) is cooler and more moistening than Asian ginseng; suited to individuals who need adaptogenic support without stimulation.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 520,
   '# Adaptogens for Stress Resilience
- Adaptogens support the body''s resilience to stress - given the strong link between chronic stress and cardiovascular disease, they are a core component of heart health protocols
- Individualize: some people need stimulating adaptogens (like Asian ginseng), others need calming ones (like ashwagandha or reishi); matching energy and constitution is essential

# The Ginsengs
- Asian ginseng (*Panax ginseng*) is warming and stimulating - best for cold, depleted individuals; American ginseng (*Panax quinquefolius*) is cooler and more moistening
- Siberian ginseng (*Eleutherococcus senticosus*) is a milder adaptogen, well suited to long-term use and immune support'),

  (9,
   'Siberian Ginseng (*Eleutherococcus senticosus*) is a milder adaptogen, well suited to long-term use and immune support; appropriate for cardiovascular stress resilience without strong stimulation.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 530,
   '# The Ginsengs
- Asian ginseng (*Panax ginseng*) is warming and stimulating - best for cold, depleted individuals; American ginseng (*Panax quinquefolius*) is cooler and more moistening
- Siberian ginseng (*Eleutherococcus senticosus*) is a milder adaptogen, well suited to long-term use and immune support'),

  (20,
   'Ashwagandha (*Withania somnifera*) is a warming, tonifying adaptogen especially suited to exhausted, anxious individuals depleted by chronic stress; well-researched for cortisol modulation and thyroid support, both directly relevant to cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 540,
   '# Ashwagandha as Adaptogen
- Ashwagandha (*Withania somnifera*) is a warming, tonifying adaptogen especially suited to exhausted, anxious individuals who are depleted by chronic stress
- Well-researched for cortisol modulation and thyroid support - both directly relevant to cardiovascular health'),

  (2634,
   'Cordyceps supports lung and cardiovascular endurance; a deeply tonic adaptogenic mushroom suited to long-term use in debilitated or chronically stressed individuals.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 550,
   '# Medicinal Mushroom Adaptogens
- Cordyceps (*Cordyceps sinensis*) supports lung and cardiovascular endurance; Reishi (*Ganoderma lucidum* and *Ganoderma spp.*) modulates the immune system and calms the nervous system
- These mushrooms are deeply tonic - suited to long-term use in debilitated or chronically stressed individuals'),

  (11,
   'Reishi (*Ganoderma lucidum*) modulates the immune system and calms the nervous system; a deeply tonic adaptogenic mushroom suited to long-term use in chronically stressed or debilitated individuals.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 560,
   '# Medicinal Mushroom Adaptogens
- Cordyceps (*Cordyceps sinensis*) supports lung and cardiovascular endurance; Reishi (*Ganoderma lucidum* and *Ganoderma spp.*) modulates the immune system and calms the nervous system
- These mushrooms are deeply tonic - suited to long-term use in debilitated or chronically stressed individuals'),

  (17,
   'Schisandra (*Schisandra chinensis*) is a five-flavor berry that supports liver, kidneys, heart, and nervous system simultaneously - described as a true whole-body adaptogen.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 570,
   '# Schisandra and Tulsi as Adaptogens
- Schisandra (*Schisandra chinensis*) is a five-flavor berry that supports liver, kidneys, heart, and nervous system simultaneously - a true whole-body adaptogen
- Tulsi (*Ocimum tenuifolium*, Holy Basil) is an uplifting, clarifying adaptogen that is gentle enough for daily use as a tea'),

  (13,
   'Tulsi (*Ocimum tenuifolium*, Holy Basil) is an uplifting, clarifying adaptogen gentle enough for daily use as a tea; supports stress resilience and cardiovascular health.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Adaptogens for Stress and Heart Resilience', 580,
   '# Schisandra and Tulsi as Adaptogens
- Schisandra (*Schisandra chinensis*) is a five-flavor berry that supports liver, kidneys, heart, and nervous system simultaneously - a true whole-body adaptogen
- Tulsi (*Ocimum tenuifolium*, Holy Basil) is an uplifting, clarifying adaptogen that is gentle enough for daily use as a tea'),

  -- ============================================================
  -- RELAXANT NERVINES FOR HEAT AND TENSION
  -- ============================================================
  (131,
   'Motherwort (*Leonurus cardiaca*) is specific for palpitations and anxiety with a heat component; a vasodilative relaxant nervine with a bitter cooling quality that simultaneously relaxes the vascular system and calms the agitated Shen.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Relaxant Nervines for Heat and Tension', 590,
   '# Relaxant Nervines for Heat and Tension
- Motherwort (*Leonurus cardiaca*) is specific for palpitations and anxiety with a heat component; Black haw (*Viburnum prunifolium*) relaxes vascular spasm and smooth muscle tension
- Blue vervain (*Verbena hastata*) addresses the person who is wound tight, overworked, and held together by sheer willpower - classic Heat and Tension with nervous exhaustion underneath
- For Heart heat patterns with restlessness, irritability, and insomnia: vasodilative/relaxant nervines that also have a bitter cooling quality; these herbs simultaneously relax the vascular system and calm the agitated Shen'),

  (94,
   'Black Haw (*Viburnum prunifolium*) relaxes vascular spasm and smooth muscle tension; suited to the Heat and Tension pattern with cardiovascular constriction.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Relaxant Nervines for Heat and Tension', 600,
   '# Relaxant Nervines for Heat and Tension
- Motherwort (*Leonurus cardiaca*) is specific for palpitations and anxiety with a heat component; Black haw (*Viburnum prunifolium*) relaxes vascular spasm and smooth muscle tension
- Blue vervain (*Verbena hastata*) addresses the person who is wound tight, overworked, and held together by sheer willpower - classic Heat and Tension with nervous exhaustion underneath
- For Heart heat patterns with restlessness, irritability, and insomnia: vasodilative/relaxant nervines that also have a bitter cooling quality; these herbs simultaneously relax the vascular system and calm the agitated Shen'),

  (983,
   'Blue Vervain (*Verbena hastata*) addresses the person who is wound tight, overworked, and held together by sheer willpower - classic Heat and Tension with nervous exhaustion underneath.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Relaxant Nervines for Heat and Tension', 610,
   '# Relaxant Nervines for Heat and Tension
- Motherwort (*Leonurus cardiaca*) is specific for palpitations and anxiety with a heat component; Black haw (*Viburnum prunifolium*) relaxes vascular spasm and smooth muscle tension
- Blue vervain (*Verbena hastata*) addresses the person who is wound tight, overworked, and held together by sheer willpower - classic Heat and Tension with nervous exhaustion underneath
- For Heart heat patterns with restlessness, irritability, and insomnia: vasodilative/relaxant nervines that also have a bitter cooling quality; these herbs simultaneously relax the vascular system and calm the agitated Shen'),

  -- ============================================================
  -- NOURISHING NERVINES FOR HEART BLOOD DEFICIENCY
  -- ============================================================
  (2616,
   'Night-Blooming Cereus (*Selenicereus grandiflorus*) is a profound heart tonic with a specific affinity for palpitations and cardiac weakness; a nourishing nervine for the depleted, dry, anxious person.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Nourishing Nervines for Heart Blood Deficiency', 620,
   '# Sweet Nourishing Nervines
- Night blooming cactus (*Selenicereus grandiflorus*) is a profound heart tonic with an affinity for palpitations and cardiac weakness; Linden (*Tilia spp.*) is both relaxing and nourishing
- Oats (*Avena sativa*) deeply nourishes the nervous system when depleted; Hawthorn (*Crataegus spp.*) bridges nourishing and tonic actions - appropriate across most patterns
- These are the building, nourishing nervines for Heart Blood and Yin deficiency - the opposite pole from the clearing/relaxing herbs; for the depleted, dry, anxious person rather than the hot, tense one'),

  (90,
   'Linden (*Tilia spp.*) is both relaxing and nourishing; suited to the nourishing nervine role for Heart Blood Deficiency pattern of depletion, dryness, and anxiety.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Nourishing Nervines for Heart Blood Deficiency', 630,
   '# Sweet Nourishing Nervines
- Night blooming cactus (*Selenicereus grandiflorus*) is a profound heart tonic with an affinity for palpitations and cardiac weakness; Linden (*Tilia spp.*) is both relaxing and nourishing
- Oats (*Avena sativa*) deeply nourishes the nervous system when depleted; Hawthorn (*Crataegus spp.*) bridges nourishing and tonic actions - appropriate across most patterns
- These are the building, nourishing nervines for Heart Blood and Yin deficiency - the opposite pole from the clearing/relaxing herbs; for the depleted, dry, anxious person rather than the hot, tense one'),

  (178,
   'Oats (*Avena sativa*) deeply nourishes the nervous system when depleted; a sweet nourishing nervine for Heart Blood Deficiency pattern.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Nourishing Nervines for Heart Blood Deficiency', 640,
   '# Sweet Nourishing Nervines
- Night blooming cactus (*Selenicereus grandiflorus*) is a profound heart tonic with an affinity for palpitations and cardiac weakness; Linden (*Tilia spp.*) is both relaxing and nourishing
- Oats (*Avena sativa*) deeply nourishes the nervous system when depleted; Hawthorn (*Crataegus spp.*) bridges nourishing and tonic actions - appropriate across most patterns
- These are the building, nourishing nervines for Heart Blood and Yin deficiency - the opposite pole from the clearing/relaxing herbs; for the depleted, dry, anxious person rather than the hot, tense one'),

  (73,
   'Hawthorn (*Crataegus spp.*) bridges nourishing and tonic actions - appropriate across most cardiovascular patterns including Heart Blood Deficiency.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Nourishing Nervines for Heart Blood Deficiency', 650,
   '# Sweet Nourishing Nervines
- Night blooming cactus (*Selenicereus grandiflorus*) is a profound heart tonic with an affinity for palpitations and cardiac weakness; Linden (*Tilia spp.*) is both relaxing and nourishing
- Oats (*Avena sativa*) deeply nourishes the nervous system when depleted; Hawthorn (*Crataegus spp.*) bridges nourishing and tonic actions - appropriate across most patterns
- These are the building, nourishing nervines for Heart Blood and Yin deficiency - the opposite pole from the clearing/relaxing herbs; for the depleted, dry, anxious person rather than the hot, tense one'),

  -- ============================================================
  -- FRANK'S CARDIOVASCULAR PROTOCOL (case study)
  -- ============================================================
  (131,
   'Motherwort was included in Frank''s herbal protocol for a complex cardiometabolic case (hypertension, hyperlipidemia, T2D, Hashimoto''s, sleep apnea); herbs introduced slowly at low dose alongside Metformin, Metoprolol, Valsartan, and Synthroid.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 660,
   '# Frank - Case Overview
- Frank: 69 year old with hyperlipidemia, hypertension, unregulated T2D, fatty liver and cirrhosis, Hashimoto''s thyroiditis, sleep apnea, arthritis, history of clinical depression
- Meds: Metformin, Metoprolol, Valsartan, Synthroid; had discontinued statins
- Herbal remedies introduced slowly and at low dose to avoid herb-drug interactions

# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods

# Frank''s Outcomes
- Over the next few months: lost 70 pounds; mental health improved; cognitive health improved; arthritis alleviated; sleep apnea symptoms eased
- Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; HDL/TC ratio dropped from 6.3 to 5.3; blood pressure stabilized'),

  (172,
   'Artichoke leaf was included in Frank''s herbal protocol for a complex cardiometabolic case; used for liver and lipid support alongside Metformin, Metoprolol, Valsartan, and Synthroid.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 670,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods

# Frank''s Outcomes
- Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; blood pressure stabilized'),

  (73,
   'Hawthorn was included in Frank''s herbal protocol for a complex cardiometabolic case (hypertension, hyperlipidemia); introduced cautiously alongside antihypertensive medications with monitoring.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 680,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods

# Frank''s Outcomes
- Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; blood pressure stabilized'),

  (211,
   'Mistletoe (*Viscum album*) was included in Frank''s herbal protocol for hypertension and cardiovascular support; introduced cautiously alongside antihypertensive medications.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 690,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support

# Frank''s Outcomes
- Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; blood pressure stabilized'),

  (877,
   'Guggul (*Commiphora mukul*) was included in Frank''s herbal protocol for hyperlipidemia and cardiovascular support; introduced cautiously in a complex polypharmacy case.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 700,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support

# Frank''s Outcomes
- Lab improvements: total cholesterol dropped by 100 points; HDL/TC ratio dropped from 6.3 to 5.3; blood pressure stabilized'),

  (206,
   'Milk Thistle (*Silybum marianum*) was included in Frank''s herbal protocol specifically for liver support; Frank presented with fatty liver and cirrhosis alongside his cardiometabolic conditions.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 710,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support

# Frank''s Outcomes
- Liver enzymes all in healthy range after treatment'),

  (2233,
   'Hibiscus tea was used as a functional food in Frank''s protocol for cardiovascular support; everyday items with meaningful cardiovascular benefit.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 720,
   '# Frank''s Herbal Protocol
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods - everyday items with meaningful cardiovascular benefit'),

  (21,
   'Garlic was used as a functional food in Frank''s protocol for cardiovascular and metabolic support; everyday items with meaningful cardiovascular benefit.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 730,
   '# Frank''s Herbal Protocol
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods - everyday items with meaningful cardiovascular benefit'),

  (2749,
   'Cacao (*Theobroma cacao*) was used as a functional food in Frank''s protocol for cardiovascular support; everyday items with meaningful cardiovascular benefit.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 740,
   '# Frank''s Herbal Protocol
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods - everyday items with meaningful cardiovascular benefit'),

  (2753,
   'Pomegranate (*Punica granatum*) juice was used in small amounts as a functional food in Frank''s protocol for cardiovascular support; everyday items with meaningful cardiovascular benefit.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 750,
   '# Frank''s Herbal Protocol
- Hibiscus tea, garlic, cacao, and small amounts of pomegranate juice used as functional foods - everyday items with meaningful cardiovascular benefit');

  -- Rauwolfia snippet (uses dynamic ID)
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (v_rauwolfia_id,
   'Rauwolfia (*Rauvolfia serpentina*) was included in Frank''s herbal protocol; the original source of reserpine (a potent blood pressure medication). Used cautiously in a complex polypharmacy case with antihypertensives; not appropriate for general herbal practice.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 760,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day
- Rauwolfia (*Rauvolfia serpentina*) is the original source of reserpine, a potent blood pressure medication; can also cause depression as a side effect; not appropriate for general herbal practice');

END $$;

-- ============================================================
-- FRANK'S PROTOCOL SUPPLEMENTS
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE supplement_id = 33
      AND class_name = 'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story'
  ) THEN
    RAISE NOTICE 'Week 1 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (33,
   'Fish Oils (Omega-3s) at 4g/day were included in Frank''s protocol for cardiovascular and lipid support; introduced cautiously alongside Metformin, Metoprolol, Valsartan, and Synthroid.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 770,
   '# Frank''s Herbal Protocol
- Herbal remedies: motherwort, artichoke leaf, hawthorn, mistletoe, guggul, and Rauwolfia; 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support

# Frank''s Outcomes
- Lab improvements: HbA1C dropped from 7.1 to 6.3; total cholesterol dropped by 100 points; blood pressure stabilized'),

  (49,
   'Vitamin B Complex was included in Frank''s protocol for cardiovascular and metabolic support, with additional niacin for lipid management.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 780,
   '# Frank''s Herbal Protocol
- 4g fish oil (Omega-3s)/day; Vitamin B complex with additional niacin; Milk thistle for liver support'),

  (4,
   'Vitamin B3 (Niacin) was added in addition to the B complex in Frank''s protocol for lipid and cardiovascular support.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Cardiovascular Protocol', 790,
   '# Frank''s Herbal Protocol
- Vitamin B complex with additional niacin included for lipid and cardiovascular support');

END $$;

-- ============================================================
-- FRANK'S BLOOD SUGAR SUPPORT (separate section)
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story'
      AND section_header = 'Frank''s Blood Sugar Support'
  ) THEN
    RAISE NOTICE 'Week 1 blood sugar snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (167,
   'Cinnamon was included in Frank''s blood sugar support herbs for unregulated T2D; works through a different mechanism from Bitter Melon and Gymnema to improve insulin sensitivity and glucose metabolism.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Blood Sugar Support', 800,
   '# Frank''s Blood Sugar Support Herbs
- Herbal remedies to support blood sugar regulation and metabolic health: Cinnamon, Bitter Melon, and Gymnema
- These herbs address his unregulated T2D from multiple angles - each works through a different mechanism to improve insulin sensitivity and glucose metabolism'),

  (2556,
   'Bitter Melon (*Momordica charantia*) was included in Frank''s blood sugar support herbs for unregulated T2D; works through a different mechanism to improve insulin sensitivity.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Blood Sugar Support', 810,
   '# Frank''s Blood Sugar Support Herbs
- Herbal remedies to support blood sugar regulation and metabolic health: Cinnamon, Bitter Melon, and Gymnema
- These herbs address his unregulated T2D from multiple angles - each works through a different mechanism to improve insulin sensitivity and glucose metabolism'),

  (2232,
   'Gymnema (*Gymnema sylvestre*) was included in Frank''s blood sugar support herbs for unregulated T2D; addresses T2D through a different mechanism to improve insulin sensitivity and glucose metabolism.',
   'Herbal Heart Health - Week 1 - Reading the Hearts Whole Story', 'generated', 'Frank''s Blood Sugar Support', 820,
   '# Frank''s Blood Sugar Support Herbs
- Herbal remedies to support blood sugar regulation and metabolic health: Cinnamon, Bitter Melon, and Gymnema
- These herbs address his unregulated T2D from multiple angles - each works through a different mechanism to improve insulin sensitivity and glucose metabolism');

END $$;

-- ============================================================
-- HERB KEYWORDS
-- ============================================================

-- Heat and Tension Pattern herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (90,  'hypertension',           'ailment'),
  (90,  'palpitations',           'ailment'),
  (90,  'stress',                 'ailment'),
  (90,  'grief support',          'ailment'),
  (90,  'hypotensive',            'action'),
  (90,  'nervine-cardiac',        'action'),
  (73,  'hypertension',           'ailment'),
  (73,  'cardiovascular disease', 'ailment'),
  (73,  'vascular health',        'ailment'),
  (73,  'palpitations',           'ailment'),
  (73,  'grief support',          'ailment'),
  (73,  'cardiotonic',            'action'),
  (73,  'hypotensive',            'action'),
  (131, 'hypertension',           'ailment'),
  (131, 'palpitations',           'ailment'),
  (131, 'anxiety',                'ailment'),
  (131, 'tachycardia',            'ailment'),
  (131, 'hypotensive',            'action'),
  (131, 'nervine-cardiac',        'action'),
  (134, 'palpitations',           'ailment'),
  (134, 'anxiety',                'ailment'),
  (134, 'stress',                 'ailment'),
  (134, 'nervine-cardiac',        'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Cold and Deficiency Pattern herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'poor circulation',       'ailment'),
  (124, 'cold extremities',       'symptom'),
  (124, 'hypotension',            'ailment'),
  (124, 'circulatory stimulant',  'action'),
  (47,  'poor circulation',       'ailment'),
  (47,  'cold extremities',       'symptom'),
  (47,  'circulatory stimulant',  'action'),
  (109, 'poor circulation',       'ailment'),
  (109, 'cognitive support',      'ailment'),
  (109, 'circulatory stimulant',  'action'),
  (123, 'poor circulation',       'ailment'),
  (123, 'cold extremities',       'symptom'),
  (123, 'circulatory stimulant',  'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Stagnation Pattern herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (203, 'poor circulation',       'ailment'),
  (203, 'varicose veins',         'ailment'),
  (203, 'edema',                  'ailment'),
  (203, 'vascular health',        'ailment'),
  (203, 'inflammation',           'ailment'),
  (1009,'poor circulation',       'ailment'),
  (1009,'blood deficiency',       'ailment'),
  (167, 'poor circulation',       'ailment'),
  (167, 'blood sugar dysregulation','ailment'),
  (167, 'type 2 diabetes',        'ailment'),
  (956, 'poor circulation',       'ailment'),
  (956, 'cardiovascular disease', 'ailment'),
  (956, 'circulatory stimulant',  'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Blood Deficiency Pattern herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43,  'anemia',                 'ailment'),
  (43,  'mineral support',        'ailment'),
  (43,  'edema',                  'ailment'),
  (43,  'kidney support',         'ailment'),
  (37,  'anemia',                 'ailment'),
  (37,  'iron deficiency',        'ailment'),
  (22,  'liver support',          'ailment'),
  (22,  'blood deficiency',       'ailment'),
  (122, 'liver support',          'ailment'),
  (122, 'digestive health',       'ailment'),
  (122, 'blood deficiency',       'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Blood Sugar and Metabolic Support herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (91,  'blood sugar dysregulation','ailment'),
  (91,  'type 2 diabetes',        'ailment'),
  (91,  'metabolic syndrome',     'ailment'),
  (33,  'blood sugar dysregulation','ailment'),
  (33,  'type 2 diabetes',        'ailment'),
  (30,  'blood sugar dysregulation','ailment'),
  (30,  'type 2 diabetes',        'ailment'),
  (30,  'oral health',            'ailment'),
  (30,  'gingivitis',             'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Cardiovascular Inflammation and Vascular Health
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (21,  'cardiovascular disease', 'ailment'),
  (21,  'vascular health',        'ailment'),
  (21,  'hyperlipidemia',         'ailment'),
  (2233,'hypertension',           'ailment'),
  (2233,'vascular health',        'ailment'),
  (2233,'hypotensive',            'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Lungs and Heart
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2634,'cardiovascular disease', 'ailment'),
  (2634,'fatigue',                'ailment'),
  (2634,'chronic lung disease',   'ailment'),
  (2634,'cardiotonic',            'action'),
  (2634,'adaptogen',              'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Liver Support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (172, 'liver support',          'ailment'),
  (172, 'hyperlipidemia',         'ailment'),
  (172, 'fatty liver disease',    'ailment'),
  (172, 'bile flow',              'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Kidney and Heart Support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1648,'edema',                  'ailment'),
  (1648,'hypertension',           'ailment'),
  (1648,'kidney support',         'ailment'),
  (120, 'edema',                  'ailment'),
  (120, 'kidney support',         'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Digestive Support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (102, 'digestive health',       'ailment'),
  (102, 'liver support',          'ailment'),
  (102, 'metabolic syndrome',     'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Oral Health
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (56,  'oral health',            'ailment'),
  (56,  'gingivitis',             'ailment'),
  (99,  'oral health',            'ailment'),
  (99,  'gingivitis',             'ailment'),
  (70,  'oral health',            'ailment'),
  (70,  'gingivitis',             'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Emotional Heart
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (850, 'grief support',          'ailment'),
  (850, 'anxiety',                'ailment'),
  (850, 'depression',             'ailment'),
  (850, 'shen disturbance',       'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Heart-Mind (Shen)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1541,'shen disturbance',       'ailment'),
  (1541,'cognitive support',      'ailment'),
  (1541,'sleep support',          'ailment'),
  (11,  'shen disturbance',       'ailment'),
  (11,  'cognitive support',      'ailment'),
  (11,  'stress',                 'ailment'),
  (11,  'adaptogen',              'action'),
  (13,  'shen disturbance',       'ailment'),
  (13,  'anxiety',                'ailment'),
  (13,  'stress',                 'ailment'),
  (13,  'adaptogen',              'action'),
  (109, 'shen disturbance',       'ailment'),
  (109, 'memory support',         'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Adaptogens
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14,  'stress',                 'ailment'),
  (14,  'fatigue',                'ailment'),
  (14,  'cardiovascular disease', 'ailment'),
  (14,  'adaptogen',              'action'),
  (15,  'stress',                 'ailment'),
  (15,  'fatigue',                'ailment'),
  (15,  'adaptogen',              'action'),
  (9,   'stress',                 'ailment'),
  (9,   'fatigue',                'ailment'),
  (9,   'immune support',         'ailment'),
  (9,   'adaptogen',              'action'),
  (20,  'stress',                 'ailment'),
  (20,  'fatigue',                'ailment'),
  (20,  'anxiety',                'ailment'),
  (20,  'cardiovascular disease', 'ailment'),
  (20,  'adaptogen',              'action'),
  (17,  'stress',                 'ailment'),
  (17,  'liver support',          'ailment'),
  (17,  'cardiovascular disease', 'ailment'),
  (17,  'adaptogen',              'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Relaxant Nervines
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (94,  'hypertension',           'ailment'),
  (94,  'palpitations',           'ailment'),
  (94,  'muscle spasms',          'ailment'),
  (94,  'vasodilator',            'action'),
  (983, 'hypertension',           'ailment'),
  (983, 'stress',                 'ailment'),
  (983, 'anxiety',                'ailment'),
  (983, 'burnout',                'ailment'),
  (983, 'vasodilator',            'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Nourishing Nervines
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2616,'palpitations',           'ailment'),
  (2616,'heart failure',          'ailment'),
  (2616,'cardiovascular disease', 'ailment'),
  (2616,'cardiotonic',            'action'),
  (178, 'nervous system support', 'ailment'),
  (178, 'fatigue',                'ailment'),
  (178, 'burnout',                'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Frank's Protocol herbs not covered above
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (211, 'hypertension',           'ailment'),
  (211, 'cardiovascular disease', 'ailment'),
  (877, 'hyperlipidemia',         'ailment'),
  (877, 'cardiovascular disease', 'ailment'),
  (206, 'liver support',          'ailment'),
  (206, 'cirrhosis',              'ailment'),
  (206, 'fatty liver disease',    'ailment'),
  (2749,'cardiovascular disease', 'ailment'),
  (2749,'vascular health',        'ailment'),
  (2753,'cardiovascular disease', 'ailment'),
  (2753,'vascular health',        'ailment'),
  (2556,'blood sugar dysregulation','ailment'),
  (2556,'type 2 diabetes',        'ailment'),
  (2556,'insulin resistance',     'ailment'),
  (2232,'blood sugar dysregulation','ailment'),
  (2232,'type 2 diabetes',        'ailment'),
  (2232,'insulin resistance',     'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Rauwolfia keywords (using subquery for dynamic ID)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, 'hypertension', 'ailment' FROM herbal.herbs WHERE latin_name ILIKE 'Rauvolfia serpentina'
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, 'cardiovascular disease', 'ailment' FROM herbal.herbs WHERE latin_name ILIKE 'Rauvolfia serpentina'
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (33,  'cardiovascular disease', 'ailment'),
  (33,  'hyperlipidemia',         'ailment'),
  (33,  'inflammation',           'ailment'),
  (49,  'cardiovascular disease', 'ailment'),
  (49,  'nervous system support', 'ailment'),
  (4,   'hyperlipidemia',         'ailment'),
  (4,   'cardiovascular disease', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- AILMENT SEARCH TERM SYNONYMS (new keywords only)
-- ============================================================
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('vascular health',
   ARRAY['endothelial health', 'vessel health', 'blood vessel support', 'endothelial function', 'vascular tone']),
  ('hypotension',
   ARRAY['low blood pressure', 'cold and deficiency pattern', 'low BP', 'orthostatic hypotension', 'low cardiovascular tone']),
  ('oral health',
   ARRAY['gum disease', 'periodontal disease', 'gingivitis cardiovascular', 'oral microbiome', 'dental cardiovascular risk']),
  ('poor circulation',
   ARRAY['sluggish circulation', 'impaired circulation', 'blood flow problems', 'peripheral circulation', 'cold hands and feet']),
  ('blood deficiency',
   ARRAY['TCM blood deficiency', 'heart blood deficiency', 'blood depletion', 'anemia TCM pattern', 'yin blood deficiency'])
ON CONFLICT (ailment_keyword) DO NOTHING;
