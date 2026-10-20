-- Migration 425: Class 2 — Herbal Actions I (Ashley) & Intro to Medicine Making (Claire)
-- Files parsed:
--   - BHC - Class 2 - Herbal Actions I - Ashley Claire.md (personal notes)
-- No generated notes file exists for this class.
--
-- Normalizations applied:
--   - "Eleuthero" → Siberian Ginseng (id=9, Eleutherococcus senticosus)
--   - "Mimosa" → Silk Tree, flowers (id=2746, Albizia julibrissin)
--   - "Oregon Grape Root" → Oregon Grape (id=33, Mahonia aquifolium)
--   - "california poppy" → California Poppy (id=128)
--   - "Dandelion Root" → Dandelion root (id=122)
--   - "nettles" → Nettle leaf (id=43)
--   - "oat straw" → Oat straw (id=2287)
--   - "[[Elder Leaf|Elder]]" → Elder flower (id=57; no leaf-specific entry in DB)
--   - Hawthorn berry (id=73) and Hawthorn leaf & flower (id=1652) added separately
--     (notes explicitly distinguish berries=muscle / flower=vasculature)
--
-- Skipped (not in DB):
--   - Shilajit: mineral pitch, not a plant herb; absent from herbal.herbs and herbal.supplements
--   - Greater Celandine: not in herbal.herbs (mentioned in choleretic callout note)
--
-- Keyword merge decisions:
--   - "blood cleanser" merged into existing "blood cleansing" ailment keyword
--   - "anthelmintic" action merged into existing "antiparasitic" keyword
--   - "gastric irritation" merged into existing "GI inflammation" ailment keyword
--
-- New action keyword added: "antidepressant"
-- New ailment keywords added: "dental pain", "musculoskeletal pain", "parasitic infection"

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 2 - Herbal Actions I - Ashley Claire') THEN
    RAISE NOTICE 'Class 2 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- =========================================================
  -- ADAPTOGEN (Ashley morning session)
  -- =========================================================

  (14, 'Ginseng (Panax ginseng) listed as an adaptogen example. In Chinese medicine, ginseng is seen as giving more Qi or life force; the Doctrine of Signatures notes it resembles the human form. Adaptogens regulate the H-P-A axis (Hypothalamic Pituitary Adrenal), are non-toxic at high doses, and work over 3–6 months though resilience builds within weeks.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 10,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- non-specific state of resistance to stress: environmental, psychological or physiological
- in our modern world, everyone can use an adaptogen
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

Reishi - tincture sample
Ashwagandha - glycerite sample

- in Chinese medicine, often seen as giving you more Qi or life force
- Doctrine of Signatures - what does a plant look like
    - ginseng = human form
- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks
- moderate to higher dose'),

  (15, 'American Ginseng listed as an adaptogen example. Adaptogens create a non-specific state of resistance to environmental, psychological, and physiological stress by regulating the H-P-A axis.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 20,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- non-specific state of resistance to stress: environmental, psychological or physiological
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

- in Chinese medicine, often seen as giving you more Qi or life force
- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks'),

  (9, 'Eleuthero (Siberian Ginseng) listed as an adaptogen. Ashley noted Eleuthero may have the quality of "stretching time" — suggesting an effect on perception of stress and mental capacity.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 30,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- non-specific state of resistance to stress: environmental, psychological or physiological
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

Ashley comment about Eleuthero "stretching time"?

- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks'),

  (16, 'Rhodiola listed as an adaptogen example. Tincture sample noted as chalky and dry — the dryness/astringency is an organoleptic indicator of its astringent quality alongside adaptogenic action.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 40,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- non-specific state of resistance to stress: environmental, psychological or physiological
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks'),

  (2634, 'Cordyceps listed as an adaptogen example. Adaptogens are non-toxic at high doses, produce non-specific resistance to stress, and regulate the H-P-A axis.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 50,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- non-specific state of resistance to stress: environmental, psychological or physiological
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks'),

  (20, 'Ashwagandha available as a glycerite sample in class. Listed as an adaptogen — helps regulate the H-P-A axis, resists stress, works best over 3–6 months at moderate to higher doses.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 60,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

Ashwagandha - glycerite sample

- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks
- moderate to higher dose'),

  (17, 'Schizandra listed as an adaptogen example. Adaptogens are non-toxic at high doses, non-specific throughout the body, and act on the H-P-A axis for stress resilience.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 70,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks'),

  (11, 'Reishi Mushroom provided as a tincture sample in class. Listed as an adaptogen — in Chinese medicine seen as giving more Qi or life force. Adaptogens used when someone is burned out, working best at moderate to higher doses over 3–6 months.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Adaptogen', 80,
   '### Adaptogen
- Helps the body adapt to stress
- virtually non-toxic at high doses
- non-specific action throughout the body
    - H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response
    - adaptogens help regulate this hormonal cascade
- ex: Panax Ginseng, American Ginseng, Eleuthero, Shilajit, Rhodiola, Cordyceps, Ashwagandha, Schisandra

Reishi - tincture sample

- in Chinese medicine, often seen as giving you more Qi or life force
- when someone is burned out, drained of life force
- work over time, 3-6 months, but more resilient in weeks
- moderate to higher dose'),

  -- =========================================================
  -- ALTERATIVES
  -- =========================================================

  (22, 'Burdock listed as an alterative — alters the body from unhealthy to healthy via the channels of elimination (bowel, kidney, skin, liver). Used to be called a "blood cleanser"; aids in detoxification.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Alteratives', 90,
   '### Alteratives
- alter the body from unhealthy to healthy via the body channels of elimination
- bowel, kidney, skin, liver
- aid in detoxification
- used to be called "blood cleanser"
- ex: Burdock, Yellow Dock, Dandelion Root

Yellow Dock - tincture sample
    - aperient - helps to soften stool
    - helps assimilate iron, but no iron in it'),

  (37, 'Yellow Dock (tincture sample): listed as an alterative — aids in detoxification via elimination channels. Also an aperient (helps soften stool). Notably helps the body assimilate iron even though it contains no iron itself.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Alteratives', 100,
   '### Alteratives
- alter the body from unhealthy to healthy via the body channels of elimination
- bowel, kidney, skin, liver
- aid in detoxification
- used to be called "blood cleanser"
- ex: Burdock, Yellow Dock, Dandelion Root

Yellow Dock - tincture sample
    - aperient - helps to soften stool
    - helps assimilate iron, but no iron in it'),

  (122, 'Dandelion Root listed as an alterative — works through the bowel, kidney, skin, and liver to detoxify and shift the body toward health.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Alteratives', 110,
   '### Alteratives
- alter the body from unhealthy to healthy via the body channels of elimination
- bowel, kidney, skin, liver
- aid in detoxification
- used to be called "blood cleanser"
- ex: Burdock, Yellow Dock, Dandelion Root'),

  -- =========================================================
  -- ANODYNES (ANALGESICS)
  -- =========================================================

  (2461, 'Jamaican Dogwood listed as an anodyne/analgesic — specifically noted as being specific for nerve pain. Anodynes can also be sedative, so caution with driving.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anodynes', 120,
   '### Anodynes (Analgesics)
- pain relieving herbs
- ex: Jamaican Dogwood (spec for nerve pain), Kava, California Poppy
- can also be sedative, so cautious driving

Kava - tincture sample
- pain-relieving - specific for dental pain
- numbing quality
- also good for musculoskeletal pain'),

  (138, 'Kava (tincture sample): specific for dental pain with a numbing quality. Also good for musculoskeletal pain. Anodynes can be sedative — caution with driving.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anodynes', 130,
   '### Anodynes (Analgesics)
- pain relieving herbs
- ex: Jamaican Dogwood (spec for nerve pain), Kava, California Poppy
- can also be sedative, so cautious driving

Kava - tincture sample
- pain-relieving - specific for dental pain
- numbing quality
- also good for musculoskeletal pain'),

  (128, 'California Poppy listed as an anodyne/analgesic. These herbs can also be sedative — caution with driving.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anodynes', 140,
   '### Anodynes (Analgesics)
- pain relieving herbs
- ex: Jamaican Dogwood (spec for nerve pain), Kava, California Poppy
- can also be sedative, so cautious driving'),

  -- =========================================================
  -- ANTI-CATARRHAL
  -- =========================================================

  (309, 'Yerba Mansa listed as an anti-catarrhal — thins mucus secretions and reduces congestion of the upper respiratory tract. Less effective than stimulating expectorants for deep-seated mucus.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-catarrhal', 150,
   '### Anti-catarrhal
- catarrh means mucus, specifically of upper respiratory tract
- thin the mucus secretions and reduce congestion
- can be used for lungs, although aren''t as effective in loosening deep-seated mucus as the more stimulating expectorant
- ex: Yerba Mansa, Goldenrod, Goldenseal'),

  (58, 'Goldenrod listed as an anti-catarrhal — thins mucus secretions and reduces upper respiratory congestion.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-catarrhal', 160,
   '### Anti-catarrhal
- catarrh means mucus, specifically of upper respiratory tract
- thin the mucus secretions and reduce congestion
- can be used for lungs, although aren''t as effective in loosening deep-seated mucus as the more stimulating expectorant
- ex: Yerba Mansa, Goldenrod, Goldenseal'),

  (30, 'Goldenseal listed as an anti-catarrhal — thins mucus secretions and reduces upper respiratory congestion.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-catarrhal', 170,
   '### Anti-catarrhal
- catarrh means mucus, specifically of upper respiratory tract
- thin the mucus secretions and reduce congestion
- can be used for lungs, although aren''t as effective in loosening deep-seated mucus as the more stimulating expectorant
- ex: Yerba Mansa, Goldenrod, Goldenseal'),

  -- =========================================================
  -- ANTIDEPRESSANT
  -- =========================================================

  (82, 'Lavender listed as an antidepressant — can help in cases of mild to moderate depression by lifting the spirits. The type of depression matters for herb selection.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antidepressant', 180,
   '### Antidepressant
- can help in cases of mild to moderate depression by lifting the spirits
- depends on type of depression (more nuance)
- ex: Lavender, St Johns Wort, Mimosa ("the tree of collective happiness")

Mimosa (flower) - tincture sample
- can also have leaf or root tincture'),

  (81, 'St. John''s Wort listed as an antidepressant — lifts the spirits in mild to moderate depression.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antidepressant', 190,
   '### Antidepressant
- can help in cases of mild to moderate depression by lifting the spirits
- depends on type of depression (more nuance)
- ex: Lavender, St Johns Wort, Mimosa ("the tree of collective happiness")'),

  (2746, 'Silk Tree / Mimosa (flower tincture sample): called "the tree of collective happiness." An antidepressant herb — lifts the spirits in mild to moderate depression. Can be used as flower, leaf, or root tincture.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antidepressant', 200,
   '### Antidepressant
- can help in cases of mild to moderate depression by lifting the spirits
- depends on type of depression (more nuance)
- ex: Lavender, St Johns Wort, Mimosa ("the tree of collective happiness")

Mimosa (flower) - tincture sample
- can also have leaf or root tincture'),

  -- =========================================================
  -- ANTI-FUNGALS
  -- =========================================================

  (288, 'Black Walnut listed as an anti-fungal — kills off fungal infections including yeast infections, thrush, GI candidiasis, and topical conditions like athlete''s foot and toenail fungus.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-fungals', 210,
   '### Anti-fungals
- kill off fungal infections (yeast infections and thrush), as well as GI candidiasis and conditions like athlete''s foot, toenail fungus
- ex: Black Walnut, Goldenseal, Calendula'),

  (30, 'Goldenseal listed as an anti-fungal alongside Black Walnut and Calendula — used for yeast infections, thrush, GI candidiasis, and topical fungal conditions.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-fungals', 220,
   '### Anti-fungals
- kill off fungal infections (yeast infections and thrush), as well as GI candidiasis and conditions like athlete''s foot, toenail fungus
- ex: Black Walnut, Goldenseal, Calendula'),

  (70, 'Calendula listed as an anti-fungal — effective against yeast infections, thrush, GI candidiasis, and topical fungal conditions such as athlete''s foot and toenail fungus.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-fungals', 230,
   '### Anti-fungals
- kill off fungal infections (yeast infections and thrush), as well as GI candidiasis and conditions like athlete''s foot, toenail fungus
- ex: Black Walnut, Goldenseal, Calendula'),

  -- =========================================================
  -- ANTI-INFLAMMATORIES
  -- =========================================================

  (1597, 'Frankincense (Boswellia resin) listed as an anti-inflammatory. Anti-inflammatories promote healthy inflammation — regulating it to turn on and off — rather than simply suppressing it. Work well for musculoskeletal discomfort, sprains, strains, headaches, wounds, and chronic internal conditions.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-inflammatories', 240,
   '### Anti-inflammatories
- reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions
- but really, what they do is promote healthy inflammation, regulate it to turn on and turn off
- work well with musculoskeletal discomfort
- ex: Boswellia (Frankincense resin), Gotu Kola, Willow, Meadowsweet'),

  (2229, 'Gotu Kola listed as an anti-inflammatory — promotes healthy inflammation regulation for sprains, strains, headaches, wounds, and chronic internal conditions.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-inflammatories', 250,
   '### Anti-inflammatories
- reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions
- but really, what they do is promote healthy inflammation, regulate it to turn on and turn off
- work well with musculoskeletal discomfort
- ex: Boswellia (Frankincense resin), Gotu Kola, Willow, Meadowsweet'),

  (87, 'Willow listed as an anti-inflammatory — promotes healthy inflammation regulation; works well for musculoskeletal discomfort, headaches, sprains, and chronic conditions.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-inflammatories', 260,
   '### Anti-inflammatories
- reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions
- but really, what they do is promote healthy inflammation, regulate it to turn on and turn off
- work well with musculoskeletal discomfort
- ex: Boswellia (Frankincense resin), Gotu Kola, Willow, Meadowsweet'),

  (75, 'Meadowsweet listed as an anti-inflammatory — promotes healthy inflammation regulation for musculoskeletal discomfort, sprains, strains, headaches, and chronic internal conditions.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anti-inflammatories', 270,
   '### Anti-inflammatories
- reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions
- but really, what they do is promote healthy inflammation, regulate it to turn on and turn off
- work well with musculoskeletal discomfort
- ex: Boswellia (Frankincense resin), Gotu Kola, Willow, Meadowsweet'),

  -- =========================================================
  -- ANTIMICROBIALS
  -- =========================================================

  (82, 'Lavender EO noted as the only essential oil that is safe for direct skin application. Listed as an antimicrobial — a disinfectant used both internally and externally. A sage-y/aromatic smell usually indicates antimicrobial action.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antimicrobials', 280,
   '### Antimicrobials
- disinfectants, used both internally and externally to prevent or cure infections
- Lavender EO, only EO safe for skin
- a lot of cooking herbs - sage, oregano
- a sage-y smell usually indicates antimicrobial action
- usually can be used both topically and internally
- ex: lavender, usnea (a lichen, one of the strongest antimicrobials we have), rosemary'),

  (112, 'Usnea (a lichen) called "one of the strongest antimicrobials we have." Antimicrobials are disinfectants used both internally and externally. A sage-y smell usually indicates antimicrobial action.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antimicrobials', 290,
   '### Antimicrobials
- disinfectants, used both internally and externally to prevent or cure infections
- a lot of cooking herbs - sage, oregano
- a sage-y smell usually indicates antimicrobial action
- usually can be used both topically and internally
- bacteria and viruses are not necessarily to be feared — balance is what is needed, build resilience
- ex: lavender, usnea (a lichen, one of the strongest antimicrobials we have), rosemary'),

  (109, 'Rosemary listed as an antimicrobial. Antimicrobials are disinfectants that can usually be used both topically and internally.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antimicrobials', 300,
   '### Antimicrobials
- disinfectants, used both internally and externally to prevent or cure infections
- a lot of cooking herbs - sage, oregano
- a sage-y smell usually indicates antimicrobial action
- usually can be used both topically and internally
- ex: lavender, usnea (a lichen, one of the strongest antimicrobials we have), rosemary'),

  (56, 'Sage listed as an antimicrobial cooking herb. Ashley noted that a sage-y smell usually indicates antimicrobial action — the aromatic volatile oils are a clue.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antimicrobials', 310,
   '### Antimicrobials
- disinfectants, used both internally and externally to prevent or cure infections
- a lot of cooking herbs - sage, oregano
- a sage-y smell usually indicates antimicrobial action
- usually can be used both topically and internally
- ex: lavender, usnea (a lichen, one of the strongest antimicrobials we have), rosemary'),

  (406, 'Oregano listed as an antimicrobial cooking herb. Aromatic cooking spices are natural examples of the antimicrobial category.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antimicrobials', 320,
   '### Antimicrobials
- disinfectants, used both internally and externally to prevent or cure infections
- a lot of cooking herbs - sage, oregano
- a sage-y smell usually indicates antimicrobial action
- usually can be used both topically and internally
- ex: lavender, usnea (a lichen, one of the strongest antimicrobials we have), rosemary'),

  -- =========================================================
  -- ANTHELMINTICS
  -- =========================================================

  (97, 'Wormwood (tincture sample): very bitter, historically associated with "underworld energy" (witch''s flying ointment, absinthe). Listed as an anthelmintic — removes parasites including amoebas, tapeworms, and GI worms. High doses require proper elimination support (kidney support, watch for Herx die-off reaction).',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anthelmintics', 330,
   '### Anthelmintics
- remove parasites, such as amoebas, tapeworms, or other worms, usually lodged somewhere in the GI tract
- taking high doses requires proper elimination support as well
    - kidney support
    - Herx reaction from die-off
- ex: Wormwood (Artemisia), Clove, Black Walnut

Wormwood - tincture sample (underworld energy, witch''s flying ointment, pass beyond the veil, in absinthe)
- very bitter'),

  (111, 'Clove listed as an anthelmintic — removes parasites such as amoebas, tapeworms, and GI worms. High doses require kidney support and awareness of Herx die-off reactions.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anthelmintics', 340,
   '### Anthelmintics
- remove parasites, such as amoebas, tapeworms, or other worms, usually lodged somewhere in the GI tract
- taking high doses requires proper elimination support as well
    - kidney support
    - Herx reaction from die-off
- ex: Wormwood (Artemisia), Clove, Black Walnut'),

  (288, 'Black Walnut listed as an anthelmintic alongside Wormwood and Clove — removes GI parasites including amoebas, tapeworms, and worms.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Anthelmintics', 350,
   '### Anthelmintics
- remove parasites, such as amoebas, tapeworms, or other worms, usually lodged somewhere in the GI tract
- taking high doses requires proper elimination support as well
    - kidney support
    - Herx reaction from die-off
- ex: Wormwood (Artemisia), Clove, Black Walnut'),

  -- =========================================================
  -- ANTIVIRALS
  -- =========================================================

  (57, 'Elder (flower) listed as an antiviral — immune stimulants with the power to destroy viral pathogens including common cold, flu, hepatitis, and HIV.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antivirals', 360,
   '### Antivirals
- usually immune stimulants with a special power to destroy viral pathogens (common cold, flu, hepatitis, HIV, etc)
- book: Herbal Antivirals by Stephen Buhner
- at the first sign of a virus, chopped up 1/2 garlic clove, let it sit and oxidize, then take like a pill every 3-4 hours
- ex: Elder, Echinacea (3 droppers, every 2 hours is the effective dose), Garlic'),

  (26, 'Echinacea: effective antiviral dose is 3 droppers every 2 hours at the first sign of illness. Listed as an antiviral immune stimulant for common cold, flu, and viral infections.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antivirals', 370,
   '### Antivirals
- usually immune stimulants with a special power to destroy viral pathogens (common cold, flu, hepatitis, HIV, etc)
- at the first sign of a virus, chopped up 1/2 garlic clove, let it sit and oxidize, then take like a pill every 3-4 hours
- ex: Elder, Echinacea (3 droppers, every 2 hours is the effective dose), Garlic'),

  (21, 'Garlic: at the first sign of a virus, chop 1/2 clove, let it sit to oxidize, then take like a pill every 3–4 hours. Listed as an antiviral immune stimulant.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Antivirals', 380,
   '### Antivirals
- usually immune stimulants with a special power to destroy viral pathogens (common cold, flu, hepatitis, HIV, etc)
- at the first sign of a virus, chopped up 1/2 garlic clove, let it sit and oxidize, then take like a pill every 3-4 hours
- ex: Elder, Echinacea (3 droppers, every 2 hours is the effective dose), Garlic'),

  -- =========================================================
  -- APERIENTS
  -- =========================================================

  (37, 'Yellow Dock described as an extremely gentle aperient — a mild laxative / stool softener that is not habit-forming.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Aperients', 390,
   '### Aperients
- mild laxatives that are not habit forming - "stool softener"
- Yellow Dock is extremely gentle example'),

  -- =========================================================
  -- ASTRINGENTS
  -- =========================================================

  (167, 'Cinnamon listed as an astringent — tannin-rich, toning and tightening tissues, with a pulling/drawing and drying effect. Most barks have astringent properties.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Astringents', 400,
   '### Astringents
- tone and tighten tissues
- tannin rich herbs
- pulling or drawing effect
- drying
- most barks have astringent properties
- ex: cinnamon, plantain, yerba mansa

Rhodiola - tincture sample
- chalky, dry'),

  (85, 'Plantain listed as an astringent — tannin-rich, toning and tightening tissues, drying effect.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Astringents', 410,
   '### Astringents
- tone and tighten tissues
- tannin rich herbs
- pulling or drawing effect
- drying
- most barks have astringent properties
- ex: cinnamon, plantain, yerba mansa'),

  (309, 'Yerba Mansa listed as an astringent — tannin-rich, tones and tightens tissues.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Astringents', 420,
   '### Astringents
- tone and tighten tissues
- tannin rich herbs
- pulling or drawing effect
- drying
- most barks have astringent properties
- ex: cinnamon, plantain, yerba mansa'),

  (16, 'Rhodiola (tincture sample in class) tasted chalky and dry — organoleptic sign of astringent quality. Also listed as an adaptogen; this session highlighted the drying/toning side of Rhodiola.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Astringents', 430,
   '### Astringents
- tone and tighten tissues
- tannin rich herbs
- pulling or drawing effect
- drying
- most barks have astringent properties
- ex: cinnamon, plantain, yerba mansa

Rhodiola - tincture sample
- chalky, dry'),

  -- =========================================================
  -- LANGUAGE OF HERBALISM (Blackberry root mention)
  -- =========================================================

  (156, 'Blackberry root used as an example of herbal energetics: diarrhea has a wet/hot tissue state, so an herb that is cold and dry is indicated — blackberry root fits this profile as a cooling, drying astringent.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Language of Herbalism', 440,
   '### The Language of Herbalism
- H. Energetics - wet/hot/cold/dry
    - example diarrhea = wet/hot, so use an herb that is cold and dry (blackberry root)
    - some disagreement about this between herbalists
- H. Constituents
    - phytochemicals — a lot, we can link to specific herbal actions
        - ex: tannins (constituent) => astringent (herbal action)
            - and then astringent tends to be cooling and drying (the energetic)
- H. Indications'),

  -- =========================================================
  -- CARDIOTONICS
  -- =========================================================

  (73, 'Hawthorn berries (glycerite sample): act on the heart muscle. Cardiotonics have special affinity for the heart — regulating its beat, moderating hypertension, and toning the heart.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cardiotonics', 450,
   '### Cardiotonics
- special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart
- ex: hawthorn
        berries - muscle
        flower - vasculature
Hawthorn: glycerite sample'),

  (1652, 'Hawthorn flower/leaf acts on the vasculature (as opposed to berries which act on the heart muscle). Cardiotonics regulate the heart''s beat, moderate hypertension, and tone the heart.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cardiotonics', 460,
   '### Cardiotonics
- special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart
- ex: hawthorn
        berries - muscle
        flower - vasculature
Hawthorn: glycerite sample'),

  -- =========================================================
  -- CARMINATIVES
  -- =========================================================

  (76, 'Fennel listed as a carminative — clears wind/gas/bloating. Carminatives are rich in volatile oils; cooking spices are classic examples. Carminatives also move energy downward in the body — useful for scattered thoughts.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Carminatives', 470,
   '### Carminatives
- clear "wind" and gas/bloating in the body
    - also shows up in our NS
    - move energy in the body downward if scattered thoughts as well!
- rich in volatile oils
- cooking spices great example
- ex: fennel

Cardamom - tincture example
    - gassy and bloating'),

  (127, 'Cardamom (tincture sample): a carminative herb for gas and bloating. Carminatives are rich in volatile oils and move energy downward — helpful both for GI wind and for scattered thoughts.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Carminatives', 480,
   '### Carminatives
- clear "wind" and gas/bloating in the body
    - also shows up in our NS
    - move energy in the body downward if scattered thoughts as well!
- rich in volatile oils
- cooking spices great example
- ex: fennel

Cardamom - tincture example
    - gassy and bloating'),

  -- =========================================================
  -- CHOLAGOGUES
  -- =========================================================

  (33, 'Oregon Grape Root (tincture sample): bitter taste that blooms slowly. A cholagogue — stimulates bile release from the gallbladder. Contains berberine (an alkaloid — nitrogen-bearing compounds often end in "-ine"), one of the more researched phytochemicals; gives its distinctive yellow color.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 490,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder, allowing the release of more bile
- helpful in aiding digestion, especially in the lower intestinal tract
- ex: Oregon Grape Root
    - bitter blooms after a minute but not bad
    - Berberine - alkaloid - often end in "-ine"
        - one of the more researched nitrogen-bearing compounds
        - yellow color

Note on Choleretics vs Cholagogues:
Choleretic: increases production of bile by the liver ("make more bile")
Cholagogue: increases flow/release of bile from the gallbladder ("move bile out")
Distinction matters: if gallstones or obstruction risk, cholagogues can trigger pain — choleretics are safer first step.
Mostly choleretic: Dandelion root, Artichoke leaf, Turmeric
Strong cholagogues: Barberry
Both: Milk thistle, Yellow dock'),

  (122, 'Dandelion root described as "mostly choleretic" — increases bile production by the liver rather than forcing bile release. Safer for patients with gallstone risk compared to strong cholagogues.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 500,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder
- helpful in aiding digestion, especially in the lower intestinal tract

Note on Choleretics vs Cholagogues:
Choleretic: increases bile production by the liver ("make more bile")
Cholagogue: increases bile flow/release from the gallbladder ("move bile out")
Safety note: if gallstones or obstruction risk, cholagogues can trigger pain — choleretics are safer first step.
Mostly choleretic: Dandelion root, Artichoke leaf, Turmeric
Both: Milk thistle, Yellow dock'),

  (172, 'Artichoke leaf described as "mostly choleretic" — increases bile production by the liver. Helpful in digestion, especially lower intestinal tract.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 510,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder
- helpful in aiding digestion, especially in the lower intestinal tract

Note on Choleretics vs Cholagogues:
Mostly choleretic: Dandelion root, Artichoke leaf, Turmeric
Strong cholagogues: Barberry
Both: Milk thistle, Yellow dock
Safety: cholagogues can trigger pain if gallstones or obstruction risk — use choleretics first'),

  (203, 'Turmeric described as "mostly choleretic" — increases bile production by the liver. Part of the group that is safer for patients with gallstone risk.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 520,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder

Note on Choleretics vs Cholagogues:
Mostly choleretic: Dandelion root, Artichoke leaf, Turmeric
Both: Milk thistle, Yellow dock
Safety: cholagogues can trigger pain if gallstones or obstruction risk'),

  (206, 'Milk Thistle described as both choleretic and cholagogue — increases bile production AND promotes bile flow/release. Works on the full biliary system.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 530,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder

Note on Choleretics vs Cholagogues:
Choleretic = make more bile (faucet)
Cholagogue = move bile out (drain valve)
Both: Milk thistle, Yellow dock'),

  (37, 'Yellow Dock described as both choleretic and cholagogue — increases bile production AND promotes bile flow. Combined with its aperient and alterative actions, it works broadly on the digestive and elimination systems.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 540,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder

Note on Choleretics vs Cholagogues:
Choleretic = make more bile (faucet)
Cholagogue = move bile out (drain valve)
Both: Milk thistle, Yellow dock'),

  (158, 'Barberry described as a "strong cholagogue" — promotes bile flow/release from the gallbladder. Caution: strong cholagogues can trigger pain or attacks if gallstones or obstruction risk is present.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Cholagogues', 550,
   '### Cholagogues
- greek "choler" meaning bile; has a cleaning and stimulating effect on the liver and gallbladder

Note on Choleretics vs Cholagogues:
Strong cholagogues (promote bile release): Barberry
Safety: strong cholagogues can trigger pain if gallstones or obstruction risk — use choleretics first in those cases'),

  -- =========================================================
  -- DEMULCENTS
  -- =========================================================

  (45, 'Marshmallow root (tincture sample): the classic demulcent — soothing, mucilage-rich herbs that heal the mucosal barrier. Used for gastric irritation and ulcers. Contraindicated if the person is already constitutionally damp. Preparation tip: use low alcohol content and add glycerine.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Demulcents', 560,
   '### Demulcents
- soothing herbs rich in mucilage
- helps to heal mucosal barrier
- gastric irritation, ulcers
- if someone is already damp, contraindication for demulcents
- ex: Marshmallow root

Marshmallow root - tincture sample
    - use low alcohol content and glycerine too!'),

  -- =========================================================
  -- HERB QUALITY (Claire afternoon session)
  -- =========================================================

  (134, 'Lemon Balm degrades super quickly — even fresh from your own garden. Claire used this as an example of why herb quality is essential: old herbs lose their medicine regardless of preparation method.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Herb Quality', 570,
   '### Herb Quality
- the most important part of making herbal medicine is the quality of your herbs
- if your herbs are old there is little to no medicine to extract, no matter what your method is
- how do we test? Organoleptics:
    - look roughly like what it looked like live
    - smell like what it should smell like
    - (lemon balm degrades super quickly even from your own garden)
    - should taste not musty, tell its strength'),

  -- =========================================================
  -- CHAMOMILE (Claire afternoon session)
  -- =========================================================

  (84, 'Chamomile: bitter — stimulating to the digestive system; anti-inflammatory to the GI. Called "for babies of all ages" (Matthew Wood). Specific for fussiness — when there is no right answer, soothe the baby. Warm and cozy; soothing. Therapeutic dosage 1–2 droppers; for spirit contact, only a few drops.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Chamomile', 580,
   '### Chamomile
- bitter - stimulating to the digestive system
- anti-inflammatory to the GI
- Wood: "for babies of all ages"
- specific for fussiness - when no right answer, soothe the baby
- warm and cozy - soothing
- therapeutic dosage - 1-2 droppers, but spirit contact, only a few drops'),

  -- =========================================================
  -- MUCILAGE (merged: cold infusion herbs + activity list)
  -- =========================================================

  (198, 'Violet leaf: lymphatic, hydrating the GI, with special affinity for the chest and moving lymph there. Mucilage extracted via cold water infusion.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 590,
   '**Mucilage - using cold water:**
- violet leaf
    - lymphatic, hydrating the GI
    - affinity for the chest, moving the lymph there
- linden
    - infusion of a few minutes -> astringent, few hours, demulcent
    - calming nervine
- hibiscus
    - cold infusion, full of slimy mucilage
    - lower blood pressure, antioxidant, vitamin c
- cinnamon
    - mucilage, slow transit time, allow better nutrient absorption
- licorice
    - sweet, can increase blood pressure, throat coat blend
- mullein
    - torch (mullein stalk used as a torch)
- marshmallow
    - master hydrator

**Mucilages (activity list):**
Plantain: gut healing, tannins + mucilage
Marshmallow: deep tissue hydration
Linden: heart tending'),

  (90, 'Linden: a short infusion (few minutes) makes it astringent; a long infusion (few hours) shifts it to demulcent. Calming nervine. Used for heart tending. Mucilage extracted via cold water.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 600,
   '**Mucilage - using cold water:**
- violet leaf
    - lymphatic, hydrating the GI
- linden
    - infusion of a few minutes -> astringent, few hours, demulcent
    - calming nervine
- hibiscus
    - cold infusion, full of slimy mucilage
    - lower blood pressure, antioxidant, vitamin c
- cinnamon
    - mucilage, slow transit time, allow better nutrient absorption
- licorice
    - sweet, can increase blood pressure, throat coat blend
- marshmallow
    - master hydrator

**Mucilages (activity list):**
Plantain: gut healing, tannins + mucilage
Marshmallow: deep tissue hydration
Linden: heart tending'),

  (2233, 'Hibiscus: cold infusion — full of slimy mucilage. Lowers blood pressure, antioxidant, rich in vitamin C.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 610,
   '**Mucilage - using cold water:**
- hibiscus
    - cold infusion, full of slimy mucilage
    - lower blood pressure, antioxidant, vitamin c
- violet leaf
    - lymphatic, hydrating the GI
- linden
    - infusion of a few minutes -> astringent, few hours, demulcent'),

  (167, 'Cinnamon: mucilaginous — slows transit time and allows better nutrient absorption. Cold infusion for mucilage extraction.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 620,
   '**Mucilage - using cold water:**
- cinnamon
    - mucilage
    - slow transit time, allow better nutrient absorption
- marshmallow
    - master hydrator
- mullein
    - torch'),

  (78, 'Licorice: sweet, mucilaginous. Can increase blood pressure — important safety note. Classic throat coat blend herb. Cold-water mucilage extraction.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 630,
   '**Mucilage - using cold water:**
- licorice
    - sweet
    - can increase blood pressure
    - throat coat blend
- marshmallow
    - master hydrator'),

  (61, 'Mullein: mucilaginous herb. Its stalk was historically used as a torch (a characteristic referred to in class).',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 640,
   '**Mucilage - using cold water:**
- mullein
    - torch (mullein stalk used historically as a torch)
- marshmallow
    - master hydrator'),

  (45, 'Marshmallow described as "the master hydrator." Used for deep tissue hydration. Mucilage extracted by cold water infusion. Use low alcohol and add glycerine to tincture preparation.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 650,
   '**Mucilage - using cold water:**
- marshmallow
    - master hydrator

**Mucilages (activity list):**
Plantain: gut healing, tannins + mucilage
Marshmallow: deep tissue hydration
Linden: heart tending'),

  (85, 'Plantain: gut healing — contains both tannins (astringent) and mucilage (demulcent), making it a dual-action herb for GI repair.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Mucilage', 660,
   '**Mucilages (activity list):**
Plantain: gut healing, tannins + mucilage
Marshmallow: deep tissue hydration
Linden: heart tending

**Mucilage - using cold water:**
- marshmallow - master hydrator
- linden - infusion of a few minutes -> astringent, few hours, demulcent'),

  -- =========================================================
  -- MINERALS (merged: mineral herbs section + activity list)
  -- =========================================================

  (155, 'Raspberry leaf: womb and uterine tonic — work with consistently over time. One of the classic mineral-rich infusion herbs.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Minerals', 670,
   '**Minerals - water temp not important, just long time:**
- raspberry leaf
    - womb and uterine tonic
    - work consistently with
- oat straw
    - 4+ hours, minerals
    - nutritive to nervous system
    - setting the stage for our emotional experience
    - much less volatile, stabilizing, graceful plant
- alfalfa
    - roots 30 ft down into the soil, chock full of minerals
- nettle
    - great antihistamine action
- horsetail
    - silica - hair, skin, and nails
- red clover
    - alterative - helps organs of elimination
    - lymphatic, vitamin c, "blood cleanser"
    - phyto-estrogenic - decreases innate estrogen (weaker, steals receptors), or increases low estrogen if receptors aren''t filled'),

  (2287, 'Oat straw: mineral-rich, needs 4+ hours to extract. Nutritive to the nervous system — "sets the stage for our emotional experience." Described as stabilizing and graceful; less volatile than other nervines.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Minerals', 680,
   '**Minerals - water temp not important, just long time:**
- oat straw
    - 4+ hours, minerals
    - nutritive to nervous system
    - setting the stage for our emotional experience
    - much less volatile, stabilizing, graceful plant
- raspberry leaf
    - womb and uterine tonic

**Minerals (activity list):**
Oat straw: calming nervine, high nutrition, feeds nervous system'),

  (885, 'Alfalfa: roots go 30 feet into the soil, making it "chock full of minerals." Excellent mineral-rich infusion herb.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Minerals', 690,
   '**Minerals - water temp not important, just long time:**
- alfalfa
    - roots 30 ft down into the soil
    - chock full of minerals'),

  (43, 'Nettle (leaf): great antihistamine action. One of the mineral-rich infusion herbs. Anti-histamine action — valuable for allergies and hay fever.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Minerals', 700,
   '**Minerals - water temp not important, just long time:**
- nettle
    - great antihistamine action

**Minerals (activity list):**
Nettle: anti-hist, nutritive'),

  (151, 'Horsetail: high in silica — supports hair, skin, and nails. Mineral-rich infusion herb.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Minerals', 710,
   '**Minerals - water temp not important, just long time:**
- horsetail
    - silica - hair, skin, and nails'),

  (42, 'Red Clover: alterative — helps organs of elimination. Lymphatic, vitamin C, "blood cleanser." Phyto-estrogenic mechanism: if estrogen receptors are full, red clover (weaker) steals the receptors and decreases net estrogenic effect; if receptors are empty (low estrogen), it fills them and increases effect.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Minerals', 720,
   '**Minerals - water temp not important, just long time:**
- red clover
    - alterative - helps organs of elimination
    - lymphatic, vit c, "blood cleanser"
    - phyto-estrogenic - actually decreases our innate estrogen because red clover is weaker, steals receptors, or increases low estrogen if the receptors aren''t filled at all

**Minerals (activity list):**
Red clover: lymph moving, gently detox, minerals'),

  -- =========================================================
  -- VOLATILE OILS (activity list)
  -- =========================================================

  (115, 'Mugwort: stimulates digestion, and associated with dreams and intuition. Listed in the volatile-oils activity group for cold infusion.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Volatile Oils', 730,
   '### Vol oils
Mugwort: stim digestion, dreams and intuition
Lemon balm: gentle uplift
Chamomile: GI support
(sub Catnip)'),

  (134, 'Lemon Balm: gentle uplift — listed in the volatile-oils activity group. Volatile oils are best extracted by cold infusion (4+ hours) or covered hot infusion (20 min).',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Volatile Oils', 740,
   '### Vol oils
Mugwort: stim digestion, dreams and intuition
Lemon balm: gentle uplift
Chamomile: GI support
(sub Catnip)'),

  (84, 'Chamomile: GI support — listed in the volatile-oils activity group alongside Mugwort, Lemon Balm, and Catnip.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Volatile Oils', 750,
   '### Vol oils
Mugwort: stim digestion, dreams and intuition
Lemon balm: gentle uplift
Chamomile: GI support
(sub Catnip)'),

  (136, 'Catnip listed as a substitute option in the volatile-oils activity group alongside Mugwort, Lemon Balm, and Chamomile.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Volatile Oils', 760,
   '### Vol oils
Mugwort: stim digestion, dreams and intuition
Lemon balm: gentle uplift
Chamomile: GI support
(sub Catnip)'),

  -- =========================================================
  -- WATER AS A SOLVENT (resin and alkaloid extraction examples)
  -- =========================================================

  (109, 'Rosemary mentioned as an example of a resin-containing herb — its resins are not well extracted by water alone. This is clinically relevant when choosing a preparation method.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 770,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - resin examples: rosemary, frankincense, myrrh, calendula
    - but you might not be after the resin for that preparation
    - Alkaloid ex - motherwort, california poppy, passionflower'),

  (1597, 'Frankincense mentioned as a resin-containing herb — resins are not extracted by water. An alcohol-based menstruum or infused oil is required to extract the anti-inflammatory resins from Frankincense.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 780,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - resin examples: rosemary, frankincense, myrrh, calendula
    - but you might not be after the resin for that preparation'),

  (99, 'Myrrh mentioned as a resin-containing herb — resins are not well extracted by water. Alcohol or oil-based preparations are needed to extract Myrrh''s medicinal constituents.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 790,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - resin examples: rosemary, frankincense, myrrh, calendula
    - but you might not be after the resin for that preparation'),

  (70, 'Calendula mentioned as a resin-containing herb — its medicinal resins are not extracted by water alone. Alcohol-based tincture is the preferred preparation for extracting Calendula''s anti-fungal and vulnerary resins.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 800,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - resin examples: rosemary, frankincense, myrrh, calendula
    - but you might not be after the resin for that preparation'),

  (131, 'Motherwort used as an example of an alkaloid-containing herb — alkaloids are not well extracted by water alone. Understanding which constituents water does and does not extract guides preparation method choice.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 810,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - Alkaloid ex - motherwort, california poppy, passionflower'),

  (128, 'California Poppy used as an example of an alkaloid-containing herb — alkaloids are not well extracted by water. An alcohol-based tincture is the appropriate preparation for extracting California Poppy''s analgesic alkaloids.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 820,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - Alkaloid ex - motherwort, california poppy, passionflower'),

  (137, 'Passionflower used as an example of an alkaloid-containing herb — alkaloids are not well extracted by water alone, requiring alcohol-based extraction for full therapeutic effect.',
   'BHC - Class 2 - Herbal Actions I - Ashley Claire', 'personal', 'Water as a Solvent', 830,
   '### Water as a solvent
- constituents water does NOT extract well: resins, some alkaloids
    - Alkaloid ex - motherwort, california poppy, passionflower');

END $$;

-- =========================================================
-- KEYWORDS
-- =========================================================

-- New action keyword
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (82,   'antidepressant', 'action'),
  (81,   'antidepressant', 'action'),
  (2746, 'antidepressant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Adaptogen section keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14,   'adaptogen',      'action'),
  (14,   'stress',         'ailment'),
  (14,   'burnout',        'ailment'),
  (14,   'energy support', 'ailment'),
  (15,   'adaptogen',      'action'),
  (15,   'stress',         'ailment'),
  (15,   'burnout',        'ailment'),
  (15,   'energy support', 'ailment'),
  (9,    'adaptogen',      'action'),
  (9,    'stress',         'ailment'),
  (9,    'burnout',        'ailment'),
  (9,    'energy support', 'ailment'),
  (9,    'fatigue',        'ailment'),
  (16,   'adaptogen',      'action'),
  (16,   'stress',         'ailment'),
  (16,   'burnout',        'ailment'),
  (16,   'energy support', 'ailment'),
  (16,   'fatigue',        'ailment'),
  (16,   'astringent',     'action'),
  (2634, 'adaptogen',      'action'),
  (2634, 'stress',         'ailment'),
  (2634, 'energy support', 'ailment'),
  (20,   'adaptogen',      'action'),
  (20,   'stress',         'ailment'),
  (20,   'burnout',        'ailment'),
  (20,   'energy support', 'ailment'),
  (17,   'adaptogen',      'action'),
  (17,   'stress',         'ailment'),
  (17,   'energy support', 'ailment'),
  (11,   'adaptogen',      'action'),
  (11,   'stress',         'ailment'),
  (11,   'immune support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alteratives keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (22,  'alterative',      'action'),
  (22,  'blood cleansing', 'ailment'),
  (22,  'liver support',   'ailment'),
  (22,  'detoxification',  'action'),
  (37,  'alterative',      'action'),
  (37,  'blood cleansing', 'ailment'),
  (37,  'aperient',        'action'),
  (37,  'iron deficiency', 'ailment'),
  (37,  'constipation',    'symptom'),
  (122, 'alterative',      'action'),
  (122, 'blood cleansing', 'ailment'),
  (122, 'liver support',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Anodynes keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2461, 'anodyne',             'action'),
  (2461, 'analgesic',           'action'),
  (2461, 'sedative',            'action'),
  (2461, 'nerve pain',          'symptom'),
  (138,  'anodyne',             'action'),
  (138,  'analgesic',           'action'),
  (138,  'sedative',            'action'),
  (138,  'dental pain',         'ailment'),
  (138,  'musculoskeletal pain','ailment'),
  (128,  'anodyne',             'action'),
  (128,  'analgesic',           'action'),
  (128,  'sedative',            'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Anti-catarrhal keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (309, 'anticatarrhal',        'action'),
  (309, 'astringent',           'action'),
  (309, 'respiratory congestion','ailment'),
  (58,  'anticatarrhal',        'action'),
  (58,  'respiratory congestion','ailment'),
  (30,  'anticatarrhal',        'action'),
  (30,  'antifungal',           'action'),
  (30,  'respiratory congestion','ailment'),
  (30,  'fungal infection',     'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Antidepressant keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (82,   'depression',             'ailment'),
  (81,   'depression',             'ailment'),
  (81,   'seasonal affective disorder', 'ailment'),
  (2746, 'depression',             'ailment'),
  (2746, 'anxiety',                'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Anti-fungal keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (288, 'antifungal',         'action'),
  (288, 'antiparasitic',      'action'),
  (288, 'fungal infection',   'ailment'),
  (288, 'yeast overgrowth',   'ailment'),
  (288, 'parasitic infection','ailment'),
  (70,  'antifungal',         'action'),
  (70,  'fungal infection',   'ailment'),
  (70,  'yeast overgrowth',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Anti-inflammatory keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1597, 'anti-inflammatory',   'action'),
  (1597, 'inflammation',        'ailment'),
  (1597, 'musculoskeletal pain','ailment'),
  (2229, 'anti-inflammatory',   'action'),
  (2229, 'inflammation',        'ailment'),
  (87,   'anti-inflammatory',   'action'),
  (87,   'analgesic',           'action'),
  (87,   'inflammation',        'ailment'),
  (87,   'headache',            'symptom'),
  (75,   'anti-inflammatory',   'action'),
  (75,   'inflammation',        'ailment'),
  (75,   'musculoskeletal pain','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Antimicrobial keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (82,  'antimicrobial',  'action'),
  (112, 'antimicrobial',  'action'),
  (112, 'immune support', 'ailment'),
  (112, 'respiratory infection', 'ailment'),
  (109, 'antimicrobial',  'action'),
  (56,  'antimicrobial',  'action'),
  (56,  'sore throat',    'ailment'),
  (406, 'antimicrobial',  'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Anthelmintic keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (97,  'antiparasitic',      'action'),
  (97,  'bitter',             'action'),
  (97,  'digestive health',   'ailment'),
  (97,  'parasitic infection','ailment'),
  (111, 'antiparasitic',      'action'),
  (111, 'dental health',      'ailment'),
  (111, 'parasitic infection','ailment'),
  (288, 'antiparasitic',      'action'),
  (288, 'parasitic infection','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Antiviral keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (57,  'antiviral',      'action'),
  (57,  'immunostimulant','action'),
  (57,  'immune support', 'ailment'),
  (57,  'common cold',    'ailment'),
  (57,  'influenza',      'ailment'),
  (26,  'antiviral',      'action'),
  (26,  'immunostimulant','action'),
  (26,  'immune support', 'ailment'),
  (26,  'common cold',    'ailment'),
  (26,  'acute illness',  'ailment'),
  (21,  'antiviral',      'action'),
  (21,  'antimicrobial',  'action'),
  (21,  'immune support', 'ailment'),
  (21,  'common cold',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cardiotonic keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73,   'cardiotonic',          'action'),
  (73,   'cardiovascular disease','ailment'),
  (73,   'arrhythmia',           'ailment'),
  (73,   'hypertension',         'ailment'),
  (1652, 'cardiotonic',          'action'),
  (1652, 'cardiovascular disease','ailment'),
  (1652, 'circulation',          'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Carminative keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (76,  'carminative',    'action'),
  (76,  'bloating',       'ailment'),
  (76,  'digestive health','ailment'),
  (127, 'carminative',    'action'),
  (127, 'bloating',       'ailment'),
  (127, 'digestive health','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cholagogue keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (33,  'cholagogue',     'action'),
  (33,  'bitter',         'action'),
  (33,  'bitter tonic',   'action'),
  (33,  'bile flow',      'ailment'),
  (33,  'liver support',  'ailment'),
  (33,  'digestive health','ailment'),
  (122, 'cholagogue',     'action'),
  (122, 'bile flow',      'ailment'),
  (122, 'bile insufficiency','ailment'),
  (172, 'cholagogue',     'action'),
  (172, 'bile flow',      'ailment'),
  (172, 'bile insufficiency','ailment'),
  (172, 'digestive health','ailment'),
  (203, 'cholagogue',     'action'),
  (203, 'anti-inflammatory','action'),
  (203, 'bile flow',      'ailment'),
  (203, 'liver support',  'ailment'),
  (206, 'cholagogue',     'action'),
  (206, 'hepatoprotective','action'),
  (206, 'liver support',  'ailment'),
  (206, 'bile flow',      'ailment'),
  (37,  'cholagogue',     'action'),
  (37,  'bile flow',      'ailment'),
  (158, 'cholagogue',     'action'),
  (158, 'bile flow',      'ailment'),
  (158, 'antimicrobial',  'action'),
  (158, 'digestive health','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Demulcent keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'demulcent',       'action'),
  (45, 'mucilaginous',    'action'),
  (45, 'GI inflammation', 'ailment'),
  (45, 'peptic ulcer',    'ailment'),
  (45, 'leaky gut',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Language of Herbalism keywords (Blackberry)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (156, 'astringent',  'action'),
  (156, 'diarrhea',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chamomile keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (84, 'anti-inflammatory', 'action'),
  (84, 'bitter',            'action'),
  (84, 'nervine',           'action'),
  (84, 'digestive health',  'ailment'),
  (84, 'colic',             'ailment'),
  (84, 'GI inflammation',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mucilage section keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (198, 'lymphatic',        'action'),
  (198, 'demulcent',        'action'),
  (198, 'lymphatic support','ailment'),
  (198, 'respiratory congestion','ailment'),
  (90,  'demulcent',        'action'),
  (90,  'astringent',       'action'),
  (90,  'nervine',          'action'),
  (90,  'nervous system support','ailment'),
  (90,  'cardiovascular disease','ailment'),
  (2233,'antioxidant',      'action'),
  (2233,'hypotensive',      'action'),
  (2233,'demulcent',        'action'),
  (2233,'hypertension',     'ailment'),
  (167, 'mucilaginous',     'action'),
  (167, 'astringent',       'action'),
  (167, 'digestive health', 'ailment'),
  (167, 'diarrhea',         'ailment'),
  (78,  'demulcent',        'action'),
  (78,  'mucilaginous',     'action'),
  (78,  'sore throat',      'ailment'),
  (78,  'hypertension',     'ailment'),
  (61,  'demulcent',        'action'),
  (61,  'mucilaginous',     'action'),
  (61,  'respiratory congestion','ailment'),
  (61,  'chronic cough',    'ailment'),
  (85,  'astringent',       'action'),
  (85,  'mucilaginous',     'action'),
  (85,  'GI inflammation',  'ailment'),
  (85,  'wound healing',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Minerals section keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (155,  'uterine tonic',       'action'),
  (155,  'uterine tonic',       'ailment'),
  (155,  'reproductive support','ailment'),
  (155,  'heavy bleeding',      'ailment'),
  (2287, 'nervine',             'action'),
  (2287, 'nutritive',           'action'),
  (2287, 'nervous system support','ailment'),
  (2287, 'mineral support',     'ailment'),
  (885,  'nutritive',           'action'),
  (885,  'mineral support',     'ailment'),
  (43,   'nutritive',           'action'),
  (43,   'allergies',           'ailment'),
  (43,   'hay fever',           'ailment'),
  (43,   'mineral support',     'ailment'),
  (151,  'mineralizer',         'action'),
  (151,  'hair loss',           'ailment'),
  (151,  'bone density',        'ailment'),
  (151,  'mineral support',     'ailment'),
  (42,   'alterative',          'action'),
  (42,   'lymphatic',           'action'),
  (42,   'phytoestrogen',       'action'),
  (42,   'lymphatic support',   'ailment'),
  (42,   'estrogen metabolism', 'ailment'),
  (42,   'hormonal support',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Volatile oils section keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (115, 'digestive stimulant', 'action'),
  (115, 'digestive health',    'ailment'),
  (134, 'nervine',             'action'),
  (134, 'depression',          'ailment'),
  (134, 'nervous system support','ailment'),
  (136, 'nervine',             'action'),
  (136, 'digestive health',    'ailment'),
  (136, 'colic',               'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Water as a Solvent section keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (99,  'antimicrobial', 'action'),
  (131, 'nervine',       'action'),
  (131, 'anti-spasmodic','action'),
  (131, 'cardiovascular disease','ailment'),
  (131, 'anxiety',       'ailment'),
  (131, 'palpitations',  'ailment'),
  (137, 'nervine',       'action'),
  (137, 'sedative',      'action'),
  (137, 'anxiety',       'ailment'),
  (137, 'insomnia',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- =========================================================
-- AILMENT SEARCH TERMS (new ailment keywords only)
-- =========================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('dental pain',         ARRAY['toothache', 'tooth pain', 'tooth ache', 'dental discomfort', 'dental nerve pain']),
  ('musculoskeletal pain',ARRAY['muscle pain', 'joint pain', 'myalgia', 'body aches', 'musculoskeletal discomfort', 'muscle and joint pain']),
  ('parasitic infection', ARRAY['parasites', 'intestinal parasites', 'intestinal worms', 'worm infestation', 'GI parasites', 'anthelmintic', 'amoeba infection'])
ON CONFLICT (ailment_keyword) DO NOTHING;
