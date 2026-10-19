-- Migration 403: Class 15 — Herbs for Children (snippets, keywords, ailment search terms)
-- Source: BHC - Class 15 - Herbs for Children - Mer.md (personal notes)
-- Instructor: Mercy Tyne (afternoon session)
-- Class date: 2026-04-16
--
-- Herb normalisations:
--   Goji → Wolfberry Fruit (id=1548)
--   Oat straw → Oat straw (id=2287)
--   Chrysanthemum → Chrysanthemum Flower (id=1572)
--   Wild Cherry → Wild Cherry Bark (id=140)
--   [[Dandelion seeds]] root → Dandelion root (id=122) — Obsidian wiki-link typo in source
--   Licorice root → Licorice (id=78)
--   SJW → St. John's Wort (id=81)
--   EP → Echinacea (id=26)
--   Mints section → Peppermint (id=55) + Spearmint (id=2607)
--
-- New ailment keywords: earache, nausea
-- Keyword merges: none
--
-- Skipped (not in DB or not medicinal herbs):
--   Honey, ACV, Tiger Balm, Vicks — preparations/foods
--   Mimulus, Rock Rose, Impatiens, Walnut — Bach flower essences not in herbs DB
--   Probiotics — general supplement category, not in supplements table
--   Carob powder, cooked apples, oatmeal — foods

SET search_path TO herbal, public;

-- ─── Snippets ────────────────────────────────────────────────────────────────

DO $block$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 15 - Herbs for Children') THEN
    RAISE NOTICE 'Class 15 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Study Session Tea (morning)
  (45, 'Marshmallow included in the Steady Study morning tea formula alongside Rosemary, Gotu Kola, Lemon Balm, Oat straw, Chrysanthemum, Goji, and Schizandra.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 10,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (109, 'Rosemary included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 20,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (2229, 'Gotu Kola included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 30,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (134, 'Lemon Balm included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 40,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (2287, 'Oat straw included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 50,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (1572, 'Chrysanthemum Flower included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 60,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (1548, 'Wolfberry (Goji) included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 70,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  (17, 'Schizandra included in the Steady Study morning tea formula.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Study Session Tea', 80,
$$Tea: Steady Study
Marshmallow
Rosemary
Gotu Kola
Lemon Balm
Oat straw
Chrysanthemum
Goji
Schizandra$$),

  -- Burns, Cuts, Scrapes, and Insect Bites
  (202, 'Aloe fresh gel is cooling and healing on burns, wounds, and rash. Never use on a staph infection — it can seal in the bacteria.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Burns, Cuts, Scrapes, and Insect Bites', 90,
$$Burns, cuts, scrapes, insect bites
- Aloe: fresh gel, cooling and healing on burns, wounds, rash. Never use on a staph infection or it can seal in the bacteria
- Honey: minor and severe burns - 1 T of honey and 1-2 drops of peppermint or lavender EO$$),

  (55, 'Peppermint EO (1-2 drops) added to 1 T of honey for minor and severe burns.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Burns, Cuts, Scrapes, and Insect Bites', 100,
$$Burns, cuts, scrapes, insect bites
- Aloe: fresh gel, cooling and healing on burns, wounds, rash. Never use on a staph infection or it can seal in the bacteria
- Honey: minor and severe burns - 1 T of honey and 1-2 drops of peppermint or lavender EO$$),

  (82, 'Lavender EO (1-2 drops) added to 1 T of honey for minor and severe burns.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Burns, Cuts, Scrapes, and Insect Bites', 110,
$$Burns, cuts, scrapes, insect bites
- Aloe: fresh gel, cooling and healing on burns, wounds, rash. Never use on a staph infection or it can seal in the bacteria
- Honey: minor and severe burns - 1 T of honey and 1-2 drops of peppermint or lavender EO$$),

  -- First Signs of Sickness (herb snippets; Vitamin C supplement inserted below)
  (26, 'Echinacea given at first sign of cold or flu; use frequent, higher-than-normal doses (1/4 tsp every hour until symptoms subside) to jump-start the immune system. Nice to mix with elderberry.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'First Signs of Sickness', 130,
$$First signs of Sickness
- Vit C up to 5000 mg in children 12 or older, usually liquid form
    - start smaller and increase gradually, if runny stools, decrease
    - best at onset to prevent or lessen symptoms
- Echinacea: given at first sign of cold or flu
    - frequent, higher than normal doses to jump start the immune system (1/4 tsp every hour until symptoms subside)
    - nice to mix EP with elderberry
- Nervines: calm and soothe the child, with rest$$),

  (1651, 'Elder berry pairs well with Echinacea at the first sign of cold or flu.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'First Signs of Sickness', 140,
$$First signs of Sickness
- Vit C up to 5000 mg in children 12 or older, usually liquid form
    - start smaller and increase gradually, if runny stools, decrease
    - best at onset to prevent or lessen symptoms
- Echinacea: given at first sign of cold or flu
    - frequent, higher than normal doses to jump start the immune system (1/4 tsp every hour until symptoms subside)
    - nice to mix EP with elderberry
- Nervines: calm and soothe the child, with rest$$),

  -- Congestion
  (101, 'Eucalyptus oil or fresh leaves used in herbal steams for respiratory congestion relief.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Congestion', 150,
$$Congestion
Herbal steams for relief:
- eucalyptus oil or fresh leaves, also thyme, sage, ginger, oregano, rosemary
Hot water bottle on the back between shoulder blades or on chest to loosen phlegm and deep chest congestion.
- Saline nose drops
- avoid dairy products$$),

  (59, 'Thyme used in herbal steams for respiratory congestion relief.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Congestion', 160,
$$Congestion
Herbal steams for relief:
- eucalyptus oil or fresh leaves, also thyme, sage, ginger, oregano, rosemary
Hot water bottle on the back between shoulder blades or on chest to loosen phlegm and deep chest congestion.
- Saline nose drops
- avoid dairy products$$),

  (56, 'Sage used in herbal steams for respiratory congestion relief.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Congestion', 170,
$$Congestion
Herbal steams for relief:
- eucalyptus oil or fresh leaves, also thyme, sage, ginger, oregano, rosemary
Hot water bottle on the back between shoulder blades or on chest to loosen phlegm and deep chest congestion.
- Saline nose drops
- avoid dairy products$$),

  (124, 'Ginger used in herbal steams for respiratory congestion relief.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Congestion', 180,
$$Congestion
Herbal steams for relief:
- eucalyptus oil or fresh leaves, also thyme, sage, ginger, oregano, rosemary
Hot water bottle on the back between shoulder blades or on chest to loosen phlegm and deep chest congestion.
- Saline nose drops
- avoid dairy products$$),

  (406, 'Oregano used in herbal steams for respiratory congestion relief.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Congestion', 190,
$$Congestion
Herbal steams for relief:
- eucalyptus oil or fresh leaves, also thyme, sage, ginger, oregano, rosemary
Hot water bottle on the back between shoulder blades or on chest to loosen phlegm and deep chest congestion.
- Saline nose drops
- avoid dairy products$$),

  (109, 'Rosemary used in herbal steams for respiratory congestion relief.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Congestion', 200,
$$Congestion
Herbal steams for relief:
- eucalyptus oil or fresh leaves, also thyme, sage, ginger, oregano, rosemary
Hot water bottle on the back between shoulder blades or on chest to loosen phlegm and deep chest congestion.
- Saline nose drops
- avoid dairy products$$),

  -- Ginger (dedicated section)
  (124, 'Ginger: decongestant, diaphoretic, warming, circulatory stimulant; delicious as a glycerite. Helps with nausea, digestion, stomach pain, and fever chills. Heats the body, lifts the spirit, decreases kapha. Dry ginger is much more heating.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Ginger', 210,
$$Ginger — Zingiber officinale
- delicious glycerite
- decongestant, diaphoretic, warming, circulatory stimulant
    - dry ginger is more heating
- helps with nausea, digestion, stomach pain, fever chills
- heats the body, lifts the spirit, decreases kapha
- dry ginger is much more heating$$),

  -- Wild Cherry Bark
  (140, 'Wild Cherry Bark: antispasmodic for the lungs and chest; cooling, sedative for smooth muscle spasms (dry cough) — even heart palpitations. Delicious in honey syrup for coughs. Only for dry, unproductive coughs — for productive coughs, focus on an expectorant.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Wild Cherry Bark', 220,
$$Wild Cherry Bark — Prunus serotina
- antispasmodic for the lungs and chest
- cooling, sedative for smooth muscle spasms (dry cough) - even heart palpitations
- delicious honey and syrup for coughs!
- only for dry, unproductive coughs; for productive coughs, focus on expectorant
- Mullein is soothing and toning as well as expectorating$$),

  (61, 'Mullein is soothing, toning, and expectorating — the expectorant alternative to Wild Cherry Bark when a cough is productive rather than dry.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Wild Cherry Bark', 230,
$$Wild Cherry Bark — Prunus serotina
- antispasmodic for the lungs and chest
- cooling, sedative for smooth muscle spasms (dry cough) - even heart palpitations
- delicious honey and syrup for coughs!
- only for dry, unproductive coughs; for productive coughs, focus on expectorant
- Mullein is soothing and toning as well as expectorating$$),

  -- Horehound
  (160, 'Horehound: bitter, aromatic expectorant. Expels tough phlegm — regulates mucus secretion, loosens and thins mucus. Used in horehound candies, which are electuaries (powdered herbs bound with honey).',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Horehound', 240,
$$Horehound — Marrubium vulgare
- bitter, aromatic, expectorant
- expels tough phlegm - regulates mucus secretion, loosens and thins mucus
- Horehound candies! electuaries - powdered herbs bound with honey$$),

  -- Fevers
  (84, 'Chamomile used for hydration support during fevers alongside marshmallow.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Fevers', 250,
$$Fevers
- a useful tool! Controversy around how high is too high - 102-104.8
- hydration is very important - salt and water, trace mineral drops - chamomile and marshmallow
- bath: 1/4 cup apple cider vinegar in the bath (no drafts, wrap in warm blanket)
    - acidity and natural antibiotic and antifungal properties help restore pH and improve protective barrier; detox, lower fevers
- diaphoretic herbs as a hot tea or bath$$),

  (45, 'Marshmallow used for hydration support during fevers alongside chamomile.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Fevers', 260,
$$Fevers
- a useful tool! Controversy around how high is too high - 102-104.8
- hydration is very important - salt and water, trace mineral drops - chamomile and marshmallow
- bath: 1/4 cup apple cider vinegar in the bath (no drafts, wrap in warm blanket)
    - acidity and natural antibiotic and antifungal properties help restore pH and improve protective barrier; detox, lower fevers
- diaphoretic herbs as a hot tea or bath$$),

  -- Elder (dedicated section)
  (57, 'Elder flowers: diaphoretic; great for sinus conditions that are hot and stuck, with clogged ears, watery eyes, allergies. Good as a steam for congestion.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Elder', 270,
$$Elder — Sambucus nigra
- flowers and berries are used
- Berries: antiviral, can disarm a virus and best at the onset of sickness. Also "cleanse" the blood, and can help with skin conditions
- Flowers: diaphoretic, great for sinus conditions that are hot and stuck, with clogged ears, watery eyes, allergies and conditions
    - good as a steam for congestion - helps move congestion$$),

  (1651, 'Elder berries: antiviral, can disarm a virus; best at the onset of sickness. Also "cleanse" the blood and can help with skin conditions.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Elder', 280,
$$Elder — Sambucus nigra
- flowers and berries are used
- Berries: antiviral, can disarm a virus and best at the onset of sickness. Also "cleanse" the blood, and can help with skin conditions
- Flowers: diaphoretic, great for sinus conditions that are hot and stuck, with clogged ears, watery eyes, allergies and conditions
    - good as a steam for congestion - helps move congestion$$),

  -- Yarrow
  (44, 'Yarrow: diaphoretic panacea herb; bitter, encourages movement and saliva production — sweating, digestive aid. Great first-aid herb. Cools the blood, clears heat as a diaphoretic. Encourages blood flow to the skin. Astringent. Boundary plant.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Yarrow', 290,
$$Yarrow — Achillea millefolium
- diaphoretic, panacea herb
- bitter, encourages movement and saliva production - sweating, digestive aid
- great first aid herb!
- cools the blood, clears heat as a diaphoretic
- encourages blood flow to the skin
- astringent
- boundary plant!$$),

  -- Catnip
  (136, 'Catnip: diaphoretic that promotes sweating without heating up the system (unlike ginger). Calming, easing, supports sleep. Great for restless, nervous, colicky kids.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Catnip', 300,
$$Catnip — Nepeta cataria
- diaphoretic
- promotes sweating without heating up the system (unlike ginger)
- calming, easing, supports sleep
- great for restless, nervous, colicky kid$$),

  -- Mints
  (55, 'Peppermint (Mentha piperita): diaphoretic, carminative; super helpful for digestive complaints, gassiness, bloating, and pain. Awesome flavoring agent.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Mints', 310,
$$Mints — Mentha piperita, Mentha spicata etc
- diaphoretic, carminative
- super helpful for digestive complaints, gassiness, bloating, pain
- awesome flavoring agent to make teas and formulas more delicious$$),

  (2607, 'Spearmint (Mentha spicata): diaphoretic, carminative; helpful for digestive complaints, gassiness, bloating, and pain.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Mints', 320,
$$Mints — Mentha piperita, Mentha spicata etc
- diaphoretic, carminative
- super helpful for digestive complaints, gassiness, bloating, pain
- awesome flavoring agent to make teas and formulas more delicious$$),

  -- Earaches
  (1212, 'TCM connects kidneys to ears; drink sufficient fluids, especially water. Cranberry juice is supportive for ear health.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Earaches', 330,
$$Earaches
- ear canals aren''t fully formed and don''t drain well
- can be serious! Antibiotics wreak havoc and imbalance
- children''s probiotics (double the amount short term)
- TCM: kidneys are connected to the ears. Drink sufficient fluids, esp water. Cranberry juice is good too!
- Due to congestion: accompanied by runny nose, congestion, cough, and other cold symptoms
    - garlic mullein (flower) oil, warm packs on lower back, decongestant tea
    - mullein flower tincture as an anodyne
    - diet: reduce dairy, wheat
- Due to water (swimmer''s ear): treat with rubbing alcohol, witch hazel, ACV, St. John''s Wort tincture to evaporate the water$$),

  (21, 'Garlic mullein flower oil for congestion-type earaches in children, along with warm packs on the lower back and decongestant tea.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Earaches', 340,
$$Earaches
- ear canals aren''t fully formed and don''t drain well
- can be serious! Antibiotics wreak havoc and imbalance
- children''s probiotics (double the amount short term)
- TCM: kidneys are connected to the ears. Drink sufficient fluids, esp water. Cranberry juice is good too!
- Due to congestion: accompanied by runny nose, congestion, cough, and other cold symptoms
    - garlic mullein (flower) oil, warm packs on lower back, decongestant tea
    - mullein flower tincture as an anodyne
    - diet: reduce dairy, wheat
- Due to water (swimmer''s ear): treat with rubbing alcohol, witch hazel, ACV, St. John''s Wort tincture to evaporate the water$$),

  (61, 'Mullein flower oil used with garlic for congestion-type earaches. Mullein flower tincture also serves as an anodyne (pain reliever) for earaches.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Earaches', 350,
$$Earaches
- ear canals aren''t fully formed and don''t drain well
- can be serious! Antibiotics wreak havoc and imbalance
- children''s probiotics (double the amount short term)
- TCM: kidneys are connected to the ears. Drink sufficient fluids, esp water. Cranberry juice is good too!
- Due to congestion: accompanied by runny nose, congestion, cough, and other cold symptoms
    - garlic mullein (flower) oil, warm packs on lower back, decongestant tea
    - mullein flower tincture as an anodyne
    - diet: reduce dairy, wheat
- Due to water (swimmer''s ear): treat with rubbing alcohol, witch hazel, ACV, St. John''s Wort tincture to evaporate the water$$),

  (81, 'St. John''s Wort tincture applied topically for swimmer''s ear (water in the ear canal) alongside witch hazel and ACV to evaporate the water.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Earaches', 360,
$$Earaches
- ear canals aren''t fully formed and don''t drain well
- can be serious! Antibiotics wreak havoc and imbalance
- children''s probiotics (double the amount short term)
- TCM: kidneys are connected to the ears. Drink sufficient fluids, esp water. Cranberry juice is good too!
- Due to congestion: accompanied by runny nose, congestion, cough, and other cold symptoms
    - garlic mullein (flower) oil, warm packs on lower back, decongestant tea
    - mullein flower tincture as an anodyne
    - diet: reduce dairy, wheat
- Due to water (swimmer''s ear): treat with rubbing alcohol, witch hazel, ACV, St. John''s Wort tincture to evaporate the water$$),

  (79, 'Witch Hazel applied topically for swimmer''s ear alongside ACV and St. John''s Wort tincture to evaporate water from the ear canal.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Earaches', 370,
$$Earaches
- ear canals aren''t fully formed and don''t drain well
- can be serious! Antibiotics wreak havoc and imbalance
- children''s probiotics (double the amount short term)
- TCM: kidneys are connected to the ears. Drink sufficient fluids, esp water. Cranberry juice is good too!
- Due to congestion: accompanied by runny nose, congestion, cough, and other cold symptoms
    - garlic mullein (flower) oil, warm packs on lower back, decongestant tea
    - mullein flower tincture as an anodyne
    - diet: reduce dairy, wheat
- Due to water (swimmer''s ear): treat with rubbing alcohol, witch hazel, ACV, St. John''s Wort tincture to evaporate the water$$),

  -- Colic
  (82, 'Lavender oil massage for infant colic; warm baths with lavender oil to relax and ease.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Colic', 380,
$$Digestion: Colic
- spasmodic contraction from air and gas trapped in the intestines
- an infant''s digestive tract takes about 3 months to clear
- environment is important!
- mothers: avoid irritating foods, caffeine, stress
- warm baths to relax and ease
- massage with lavender oil!
- probiotics
- tincture formula: 2P dandelion root, 1P licorice, 1P fennel, 1P peppermint
    - 3-4 drops for a 2-3 month old baby
    - 4-6 drops for a 3-4 month old
    - 6-8 drops for 4 months and older$$),

  (122, 'Dandelion root (2 parts) in a colic tincture formula with licorice, fennel, and peppermint. Dosing: 3-4 drops (2-3 months old), 4-6 drops (3-4 months), 6-8 drops (4+ months).',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Colic', 390,
$$Digestion: Colic
- spasmodic contraction from air and gas trapped in the intestines
- an infant''s digestive tract takes about 3 months to clear
- environment is important!
- mothers: avoid irritating foods, caffeine, stress
- warm baths to relax and ease
- massage with lavender oil!
- probiotics
- tincture formula: 2P dandelion root, 1P licorice, 1P fennel, 1P peppermint
    - 3-4 drops for a 2-3 month old baby
    - 4-6 drops for a 3-4 month old
    - 6-8 drops for 4 months and older$$),

  (78, 'Licorice (1 part) in a colic tincture formula with dandelion root, fennel, and peppermint.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Colic', 400,
$$Digestion: Colic
- spasmodic contraction from air and gas trapped in the intestines
- an infant''s digestive tract takes about 3 months to clear
- environment is important!
- mothers: avoid irritating foods, caffeine, stress
- warm baths to relax and ease
- massage with lavender oil!
- probiotics
- tincture formula: 2P dandelion root, 1P licorice, 1P fennel, 1P peppermint
    - 3-4 drops for a 2-3 month old baby
    - 4-6 drops for a 3-4 month old
    - 6-8 drops for 4 months and older$$),

  (76, 'Fennel (1 part) in a colic tincture formula with dandelion root, licorice, and peppermint.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Colic', 410,
$$Digestion: Colic
- spasmodic contraction from air and gas trapped in the intestines
- an infant''s digestive tract takes about 3 months to clear
- environment is important!
- mothers: avoid irritating foods, caffeine, stress
- warm baths to relax and ease
- massage with lavender oil!
- probiotics
- tincture formula: 2P dandelion root, 1P licorice, 1P fennel, 1P peppermint
    - 3-4 drops for a 2-3 month old baby
    - 4-6 drops for a 3-4 month old
    - 6-8 drops for 4 months and older$$),

  (55, 'Peppermint (1 part) in a colic tincture formula with dandelion root, licorice, and fennel.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Colic', 420,
$$Digestion: Colic
- spasmodic contraction from air and gas trapped in the intestines
- an infant''s digestive tract takes about 3 months to clear
- environment is important!
- mothers: avoid irritating foods, caffeine, stress
- warm baths to relax and ease
- massage with lavender oil!
- probiotics
- tincture formula: 2P dandelion root, 1P licorice, 1P fennel, 1P peppermint
    - 3-4 drops for a 2-3 month old baby
    - 4-6 drops for a 3-4 month old
    - 6-8 drops for 4 months and older$$),

  -- Diarrhea
  (136, 'Catnip in gut healing tea (catnip, chamomile, ginger, fennel) for childhood diarrhea.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Diarrhea', 430,
$$Digestion: Diarrhea
- if it lasts more than a few days, cause for treatment and concern
- dehydration is a concern! warm baths, fluids
- gut healing tea: catnip, chamomile, ginger, fennel
- cooked apples with cinnamon! Pectin adds bulk to stools and coats the digestive system
- blackberry root (leaf more gentle): paired with high fluid intake and simple diet, should remedy the issue; tincture in water, juice, or tea$$),

  (84, 'Chamomile in gut healing tea (catnip, chamomile, ginger, fennel) for childhood diarrhea.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Diarrhea', 440,
$$Digestion: Diarrhea
- if it lasts more than a few days, cause for treatment and concern
- dehydration is a concern! warm baths, fluids
- gut healing tea: catnip, chamomile, ginger, fennel
- cooked apples with cinnamon! Pectin adds bulk to stools and coats the digestive system
- blackberry root (leaf more gentle): paired with high fluid intake and simple diet, should remedy the issue; tincture in water, juice, or tea$$),

  (124, 'Ginger in gut healing tea (catnip, chamomile, ginger, fennel) for childhood diarrhea.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Diarrhea', 450,
$$Digestion: Diarrhea
- if it lasts more than a few days, cause for treatment and concern
- dehydration is a concern! warm baths, fluids
- gut healing tea: catnip, chamomile, ginger, fennel
- cooked apples with cinnamon! Pectin adds bulk to stools and coats the digestive system
- blackberry root (leaf more gentle): paired with high fluid intake and simple diet, should remedy the issue; tincture in water, juice, or tea$$),

  (76, 'Fennel in gut healing tea (catnip, chamomile, ginger, fennel) for childhood diarrhea.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Diarrhea', 460,
$$Digestion: Diarrhea
- if it lasts more than a few days, cause for treatment and concern
- dehydration is a concern! warm baths, fluids
- gut healing tea: catnip, chamomile, ginger, fennel
- cooked apples with cinnamon! Pectin adds bulk to stools and coats the digestive system
- blackberry root (leaf more gentle): paired with high fluid intake and simple diet, should remedy the issue; tincture in water, juice, or tea$$),

  (156, 'Blackberry root for childhood diarrhea (leaf more gentle): tincture in water, juice, or tea paired with high fluid intake and a simple diet.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Diarrhea', 470,
$$Digestion: Diarrhea
- if it lasts more than a few days, cause for treatment and concern
- dehydration is a concern! warm baths, fluids
- gut healing tea: catnip, chamomile, ginger, fennel
- cooked apples with cinnamon! Pectin adds bulk to stools and coats the digestive system
- blackberry root (leaf more gentle): paired with high fluid intake and simple diet, should remedy the issue; tincture in water, juice, or tea$$),

  -- Constipation
  (78, 'Licorice as a bulk-building herb for childhood constipation; also in bulk-building candy (with licorice, fennel, marshmallow root, psyllium seed).',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Constipation', 480,
$$Digestion: Constipation
- often result of eating foods that are hot and dry with inadequate fluids
    - add: fruits, vegetables, whole grains, molasses, dried fruit, oatmeal, and marshmallow gruel
- probiotics
- Bulk building herbs: licorice, irish moss, marshmallow, flax seed
- Bulk building candy (Rosemary Gladstar): grind dried fruit together, mix in powdered psyllium seed, marshmallow root, and fennel; add carob powder to thicken
    - licorice, fennel, marshmallow root, psyllium seed
- exercise! stomach massage and deep breathing$$),

  (49, 'Irish Moss as a bulk-building herb for childhood constipation.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Constipation', 490,
$$Digestion: Constipation
- often result of eating foods that are hot and dry with inadequate fluids
    - add: fruits, vegetables, whole grains, molasses, dried fruit, oatmeal, and marshmallow gruel
- probiotics
- Bulk building herbs: licorice, irish moss, marshmallow, flax seed
- Bulk building candy (Rosemary Gladstar): grind dried fruit together, mix in powdered psyllium seed, marshmallow root, and fennel; add carob powder to thicken
    - licorice, fennel, marshmallow root, psyllium seed
- exercise! stomach massage and deep breathing$$),

  (45, 'Marshmallow as a bulk-building herb for childhood constipation and in bulk-building candy; marshmallow gruel recommended as a moist, cooling food.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Constipation', 500,
$$Digestion: Constipation
- often result of eating foods that are hot and dry with inadequate fluids
    - add: fruits, vegetables, whole grains, molasses, dried fruit, oatmeal, and marshmallow gruel
- probiotics
- Bulk building herbs: licorice, irish moss, marshmallow, flax seed
- Bulk building candy (Rosemary Gladstar): grind dried fruit together, mix in powdered psyllium seed, marshmallow root, and fennel; add carob powder to thicken
    - licorice, fennel, marshmallow root, psyllium seed
- exercise! stomach massage and deep breathing$$),

  (180, 'Flax seed as a bulk-building herb for childhood constipation.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Constipation', 510,
$$Digestion: Constipation
- often result of eating foods that are hot and dry with inadequate fluids
    - add: fruits, vegetables, whole grains, molasses, dried fruit, oatmeal, and marshmallow gruel
- probiotics
- Bulk building herbs: licorice, irish moss, marshmallow, flax seed
- Bulk building candy (Rosemary Gladstar): grind dried fruit together, mix in powdered psyllium seed, marshmallow root, and fennel; add carob powder to thicken
    - licorice, fennel, marshmallow root, psyllium seed
- exercise! stomach massage and deep breathing$$),

  (76, 'Fennel in bulk-building candy for childhood constipation (with licorice, marshmallow root, psyllium seed, and dried fruit).',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Constipation', 520,
$$Digestion: Constipation
- often result of eating foods that are hot and dry with inadequate fluids
    - add: fruits, vegetables, whole grains, molasses, dried fruit, oatmeal, and marshmallow gruel
- probiotics
- Bulk building herbs: licorice, irish moss, marshmallow, flax seed
- Bulk building candy (Rosemary Gladstar): grind dried fruit together, mix in powdered psyllium seed, marshmallow root, and fennel; add carob powder to thicken
    - licorice, fennel, marshmallow root, psyllium seed
- exercise! stomach massage and deep breathing$$),

  (2240, 'Psyllium seed in bulk-building candy for childhood constipation (with licorice, fennel, marshmallow root, and dried fruit).',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Constipation', 530,
$$Digestion: Constipation
- often result of eating foods that are hot and dry with inadequate fluids
    - add: fruits, vegetables, whole grains, molasses, dried fruit, oatmeal, and marshmallow gruel
- probiotics
- Bulk building herbs: licorice, irish moss, marshmallow, flax seed
- Bulk building candy (Rosemary Gladstar): grind dried fruit together, mix in powdered psyllium seed, marshmallow root, and fennel; add carob powder to thicken
    - licorice, fennel, marshmallow root, psyllium seed
- exercise! stomach massage and deep breathing$$),

  -- Balancing Mood and Excitability
  (73, 'Hawthorn berry cold infusion for excitability in children — described as for "sweaty little cherries".',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Balancing Mood and Excitability', 540,
$$Balancing mood, calming excitability
- Excitability: hawthorn berry cold infusion for "sweaty little cherries"
- Fear/worry/anxiety/embarrassment:
    - Nervines: chamomile, lavender, lemon balm, catnip
    - flower essences
- Overflowing emotions: calming, grounding plants, engaging with the senses, flower essences$$),

  (84, 'Chamomile as a nervine for children''s fear, worry, anxiety, and embarrassment.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Balancing Mood and Excitability', 550,
$$Balancing mood, calming excitability
- Excitability: hawthorn berry cold infusion for "sweaty little cherries"
- Fear/worry/anxiety/embarrassment:
    - Nervines: chamomile, lavender, lemon balm, catnip
    - flower essences
- Overflowing emotions: calming, grounding plants, engaging with the senses, flower essences$$),

  (82, 'Lavender as a nervine for children''s fear, worry, anxiety, and embarrassment.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Balancing Mood and Excitability', 560,
$$Balancing mood, calming excitability
- Excitability: hawthorn berry cold infusion for "sweaty little cherries"
- Fear/worry/anxiety/embarrassment:
    - Nervines: chamomile, lavender, lemon balm, catnip
    - flower essences
- Overflowing emotions: calming, grounding plants, engaging with the senses, flower essences$$),

  (134, 'Lemon Balm as a nervine for children''s fear, worry, anxiety, and embarrassment.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Balancing Mood and Excitability', 570,
$$Balancing mood, calming excitability
- Excitability: hawthorn berry cold infusion for "sweaty little cherries"
- Fear/worry/anxiety/embarrassment:
    - Nervines: chamomile, lavender, lemon balm, catnip
    - flower essences
- Overflowing emotions: calming, grounding plants, engaging with the senses, flower essences$$),

  (136, 'Catnip as a nervine for children''s fear, worry, anxiety, and embarrassment.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Balancing Mood and Excitability', 580,
$$Balancing mood, calming excitability
- Excitability: hawthorn berry cold infusion for "sweaty little cherries"
- Fear/worry/anxiety/embarrassment:
    - Nervines: chamomile, lavender, lemon balm, catnip
    - flower essences
- Overflowing emotions: calming, grounding plants, engaging with the senses, flower essences$$),

  -- Flower Essences
  (148, 'Agrimony used as a flower essence in Rescue Remedy context for children''s anxiety, panic, and overwhelm.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Flower Essences', 590,
$$Flower essences - maybe with vinegar
- Rescue remedy: panic, overwhelm, fear
    - mimulus
    - rock rose - specific for shock and panic
    - maybe agrimony...
- Mimulus: for specific fears and terrors (scared of the dark, etc)
- Impatiens: easily frustrated, impatient
- Walnut: for transitions and change
- Borage: for courage$$),

  (69, 'Borage used as a flower essence for courage in children.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'Flower Essences', 600,
$$Flower essences - maybe with vinegar
- Rescue remedy: panic, overwhelm, fear
    - mimulus
    - rock rose - specific for shock and panic
    - maybe agrimony...
- Mimulus: for specific fears and terrors (scared of the dark, etc)
- Impatiens: easily frustrated, impatient
- Walnut: for transitions and change
- Borage: for courage$$);

  -- Supplement snippet: Vitamin C
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (10, 'Vitamin C up to 5000 mg for children 12 or older at first sign of cold/flu; start smaller and increase gradually; if runny stools, decrease. Best at onset to prevent or lessen symptoms.',
   'BHC - Class 15 - Herbs for Children', 'personal', 'First Signs of Sickness', 120,
$$First signs of Sickness
- Vit C up to 5000 mg in children 12 or older, usually liquid form
    - start smaller and increase gradually, if runny stools, decrease
    - best at onset to prevent or lessen symptoms
- Echinacea: given at first sign of cold or flu
    - frequent, higher than normal doses to jump start the immune system (1/4 tsp every hour until symptoms subside)
    - nice to mix EP with elderberry
- Nervines: calm and soothe the child, with rest$$);

END $block$;

-- ─── Keywords ────────────────────────────────────────────────────────────────

-- Study Session Tea
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45,   'cognitive support', 'ailment'),
  (109,  'cognitive support', 'ailment'),
  (2229, 'cognitive support', 'ailment'),
  (2229, 'memory support',    'ailment'),
  (134,  'cognitive support', 'ailment'),
  (134,  'anxiety',           'ailment'),
  (2287, 'nervous system support', 'ailment'),
  (2287, 'stress',            'ailment'),
  (1572, 'cognitive support', 'ailment'),
  (1548, 'energy support',    'ailment'),
  (17,   'cognitive support', 'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Burns and topicals
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (202, 'burns',         'ailment'),
  (202, 'wound healing', 'ailment'),
  (202, 'skin conditions', 'ailment'),
  (202, 'insect bites',  'ailment'),
  (55,  'burns',         'ailment'),
  (82,  'burns',         'ailment'),
  (82,  'colic',         'ailment'),
  (82,  'anxiety',       'ailment'),
  (82,  'sleep support', 'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- First signs of sickness
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26,   'immune support', 'ailment'),
  (26,   'common cold',    'ailment'),
  (26,   'influenza',      'ailment'),
  (1651, 'immune support', 'ailment'),
  (1651, 'common cold',    'ailment'),
  (1651, 'influenza',      'ailment'),
  (1651, 'skin conditions', 'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (10, 'immune support', 'ailment'),
  (10, 'common cold',    'ailment'),
  (10, 'influenza',      'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Congestion / respiratory
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (101, 'respiratory congestion', 'ailment'),
  (101, 'common cold',            'ailment'),
  (59,  'respiratory congestion', 'ailment'),
  (56,  'respiratory congestion', 'ailment'),
  (124, 'respiratory congestion', 'ailment'),
  (124, 'common cold',            'ailment'),
  (124, 'nausea',                 'ailment'),
  (124, 'fever',                  'ailment'),
  (124, 'digestive health',       'ailment'),
  (124, 'colic',                  'ailment'),
  (406, 'respiratory congestion', 'ailment'),
  (109, 'respiratory congestion', 'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Wild Cherry Bark, Mullein, Horehound
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (140, 'spasmodic cough',        'ailment'),
  (140, 'chronic cough',          'ailment'),
  (61,  'respiratory congestion', 'ailment'),
  (61,  'spasmodic cough',        'ailment'),
  (61,  'earache',                'ailment'),
  (160, 'respiratory congestion', 'ailment'),
  (160, 'chronic cough',          'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Fevers, Elder, Yarrow
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (84,   'fever',                  'ailment'),
  (84,   'anxiety',                'ailment'),
  (84,   'colic',                  'ailment'),
  (84,   'diarrhea',               'ailment'),
  (45,   'fever',                  'ailment'),
  (45,   'constipation',           'ailment'),
  (45,   'mucous membrane support','ailment'),
  (57,   'fever',                  'ailment'),
  (57,   'respiratory congestion', 'ailment'),
  (57,   'allergies',              'ailment'),
  (57,   'common cold',            'ailment'),
  (1651, 'fever',                  'ailment'),
  (44,   'fever',                  'ailment'),
  (44,   'wound healing',          'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Catnip, Mints
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (136,  'fever',          'ailment'),
  (136,  'sleep support',  'ailment'),
  (136,  'colic',          'ailment'),
  (136,  'diarrhea',       'ailment'),
  (136,  'anxiety',        'ailment'),
  (55,   'colic',          'ailment'),
  (55,   'digestive health','ailment'),
  (55,   'nausea',         'ailment'),
  (2607, 'colic',          'ailment'),
  (2607, 'digestive health','ailment'),
  (2607, 'nausea',         'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Earaches
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1212, 'earache',              'ailment'),
  (1212, 'urinary tract infection', 'ailment'),
  (21,   'earache',              'ailment'),
  (21,   'immune support',       'ailment'),
  (61,   'earache',              'ailment'),
  (81,   'earache',              'ailment'),
  (79,   'earache',              'ailment'),
  (79,   'wound healing',        'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Colic / Diarrhea / Constipation
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (122,  'colic',           'ailment'),
  (122,  'digestive tonic', 'ailment'),
  (78,   'colic',           'ailment'),
  (78,   'constipation',    'ailment'),
  (76,   'colic',           'ailment'),
  (76,   'constipation',    'ailment'),
  (76,   'diarrhea',        'ailment'),
  (76,   'digestive health','ailment'),
  (156,  'diarrhea',        'ailment'),
  (49,   'constipation',    'ailment'),
  (180,  'constipation',    'ailment'),
  (2240, 'constipation',    'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Balancing mood, flower essences
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73,  'anxiety',     'ailment'),
  (73,  'stress',      'ailment'),
  (148, 'anxiety',     'ailment'),
  (148, 'shock',       'ailment'),
  (69,  'anxiety',     'ailment')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- Action keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124,  'diaphoretic',   'action'),
  (124,  'carminative',   'action'),
  (57,   'diaphoretic',   'action'),
  (57,   'antiviral',     'action'),
  (1651, 'antiviral',     'action'),
  (44,   'diaphoretic',   'action'),
  (44,   'astringent',    'action'),
  (136,  'diaphoretic',   'action'),
  (55,   'diaphoretic',   'action'),
  (55,   'carminative',   'action'),
  (2607, 'diaphoretic',   'action'),
  (2607, 'carminative',   'action'),
  (140,  'antispasmodic', 'action'),
  (140,  'sedative',      'action'),
  (160,  'expectorant',   'action'),
  (160,  'bitter',        'action'),
  (61,   'expectorant',   'action')
ON CONFLICT (herb_id, keyword) WHERE herb_id IS NOT NULL DO NOTHING;

-- ─── Ailment search terms (new keywords only) ────────────────────────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('earache',
   ARRAY['ear pain', 'ear infection', 'otitis media', 'otitis externa', 'swimmer''s ear', 'otalgia', 'ear ache']),
  ('nausea',
   ARRAY['upset stomach', 'queasy', 'nausea and vomiting', 'stomach nausea', 'queasiness', 'sick to stomach'])
ON CONFLICT (ailment_keyword) DO NOTHING;
