-- Migration 392: BHC Class 19 — Black North American Herbalism
-- Personal notes (Shereel Bullock, 2026-04-28)
-- File parsed: BHC - Class 19 - Black North American Herbalism - Shereel.md
--
-- Herb normalizations applied:
--   "Cami Weed" → Chamomile (Matricaria recutita, id=84)
--   "White Cedar" → Thuja (Thuja occidentalis, id=201)
--   "Wax Myrtle" → Bayberry (Myrica cerifera, id=119) — same plant, different common name
--   "Hawthorn L/F" → Hawthorn leaf & flower (Crataegus spp., id=1652)
--   "Mint" (generic) → Peppermint (Mentha piperita, id=55)
--   "Comfrey" (infusion/immune/syrup context) → Comfrey leaf (id=1650)
--
-- Herbs added to DB in this migration:
--   Pomegranate (Punica granatum, root bark): found in MM Materia Medica
--   MM entry: root bark cold infusion 1–3 oz 3× daily; inhibits tapeworms
--
-- Herbs skipped (not in DB; reasons noted):
--   Jerusalem artichoke (Helianthus tuberosus): not in any reference book; primarily food plant
--   Maple bark (Acer spp.): not in any reference book; historical Cherokee use only
--   Spanish Moss (Tillandsia usneoides): no medicinal use noted
--   Fig, Gourd, Okra, Wild Okra: foods with no DB entry and no clinical use noted
--   Sweetgrass: cultural/agricultural, not primarily medicinal
--   Castro bean / Castor bean: preparation ingredient (playbook: skip)
--   Cotton: listed as "cotton –" with no use; Cotton Root Bark (id=2635) is in DB but distinct
--
-- Keyword merge decisions:
--   "vermifuge" → antiparasitic (existing action keyword)
--   "chills" merged into "fever" (chills/fever are the same syndrome in this context)
--
-- New ailment keywords introduced: fever, tuberculosis
-- New herb pairs: see migration 393

SET search_path TO herbal, public;

-- Add Pomegranate (found in MM Materia Medica)
INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES ('Pomegranate', 'Punica granatum', 'Root bark')
ON CONFLICT DO NOTHING;

DO $$
DECLARE
  v_pomegranate_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Punica granatum');

  v_mm_source CONSTANT TEXT :=
'### African American Materia Medica
- on arrival in North America, diversity of flora; 108 species documented in 400 years
- jerusalem artichoke - diuretic - late antebellum period (moonshine)
- asafetida - SE Asian cooking, also here in the south - asthma, colic - tincture and raw form around the neck - Contemporary, post slavery, well past emancipation
- black cohosh - leaves - chills, vermifuge - infusion, raw - contemporary
- boneset - late antebellum (post Civil War)
- burdock - TB - infusion - root
- catnip -
- white cedar -
- wild black cherry - bark
- comfrey - infusion - leaves
- elderberry -
- garlic -
- poke - leaves, root and berries
- pomegranate -
- sassafras - study done incorrectly and on animals
- horehound - very bitter
- witch hazel - leaves and bark';

  v_exchange_source CONSTANT TEXT :=
'### African + Indigenous Exchange
- Africans in the Americas predated the enslaved period
- exchange back and forth between Native American people and African peoples
- relied on each other for their specialties; 25% of African Americans claim Native American ancestry
- Corn: Africans used the husk; Native Americans used the silk
- Cherokee nations shared African herbal knowledge:
  - Black Walnut
  - Rue
  - Willow
  - Maple bark - cataracts
  - Wax Myrtle';

  v_fever_source CONSTANT TEXT :=
'#### For chills, aches and fever
- Sassafras
- Peach Leaf
- Cami Weed (Chamomile)';

  v_colic_source CONSTANT TEXT :=
'#### To calm fussy (colic) baby
- Sage
- Catnip';

  v_immune_source CONSTANT TEXT :=
'#### For immune support
- Sage
- Comfrey
- Cami weed (Chamomile)';

  v_digestive_source CONSTANT TEXT :=
'#### Bitter/Digestive Support
- Slippery Elm
- Mullein Leaf';

  v_syrup_source CONSTANT TEXT :=
'#### Glycerine Syrup
- Chamomile
- Comfrey - pain, fever, swelling
- Sage
- + flavonoid -> Lemon Balm or Mint
- boil then turn it off, let sit, then strain
- add more water to plant material and boil again, sit, strain
- combine 2 liquids and boil down for 20 minutes';

  v_refresher_source CONSTANT TEXT :=
'#### Hibiscus Refresher
- Hibiscus
- Clove
- Cinnamon
- Ginger
- Orange peel
- Hawthorn L/F
- bring to boil for 30 minutes, then strain
- add more water to plant material and boil again for 20 mins, strain
- combine 2 liquids and boil down for 20 minutes
- add a lot of honey to taste';

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 19 - Black North American Herbalism') THEN
    RAISE NOTICE 'Class 19 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- Introduction
    (1248,
     'Ocotillo described as an energetic and physical mover of abdominal energies; administered as a tincture.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Introduction', 10,
     'Ocotillo tincture
- energetic and physical mover of abdominal energies'),

    -- African American Materia Medica
    (2645,
     'Asafetida used in the American South for asthma and colic; administered as a tincture or worn raw around the neck. Contemporary period, post slavery.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 20,
     v_mm_source),

    (25,
     'Black cohosh leaves used for chills and as a vermifuge (antiparasitic); prepared as an infusion or taken raw. Contemporary period.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 30,
     v_mm_source),

    (50,
     'Boneset listed in the African American Materia Medica; used during the late antebellum period (post Civil War).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 40,
     v_mm_source),

    (22,
     'Burdock root prepared as an infusion and used for tuberculosis (TB) in the African American Materia Medica.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 50,
     v_mm_source),

    (136,
     'Catnip listed in the African American Materia Medica as part of the 108 documented species.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 60,
     v_mm_source),

    (201,
     'White cedar (Thuja) listed in the African American Materia Medica as part of the 108 documented species.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 70,
     v_mm_source),

    (140,
     'Wild black cherry bark listed in the African American Materia Medica as part of the 108 documented species.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 80,
     v_mm_source),

    (1650,
     'Comfrey leaves prepared as an infusion in the African American Materia Medica.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 90,
     v_mm_source),

    (1651,
     'Elderberry listed in the African American Materia Medica as part of the 108 documented species.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 100,
     v_mm_source),

    (21,
     'Garlic listed in the African American Materia Medica as part of the 108 documented species.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 110,
     v_mm_source),

    (35,
     'Poke leaves, root, and berries — all parts used in the African American Materia Medica.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 120,
     v_mm_source),

    (v_pomegranate_id,
     'Pomegranate listed in the African American Materia Medica as part of the 108 documented species.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 130,
     v_mm_source),

    (313,
     'Sassafras listed in the African American Materia Medica; instructor notes the commonly cited safety studies were conducted incorrectly and on animals.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 140,
     v_mm_source),

    (160,
     'Horehound noted as very bitter in the African American Materia Medica; its bitterness is a key therapeutic quality.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 150,
     v_mm_source),

    (79,
     'Witch hazel leaves and bark used in the African American Materia Medica.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African American Materia Medica', 160,
     v_mm_source),

    -- African and Indigenous Exchange
    (288,
     'Black walnut was part of the herbal knowledge exchanged between Cherokee nations and African Americans in North America.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African and Indigenous Exchange', 170,
     v_exchange_source),

    (110,
     'Rue was part of the herbal knowledge exchanged between Cherokee nations and African Americans in North America.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African and Indigenous Exchange', 180,
     v_exchange_source),

    (87,
     'Willow was part of the herbal knowledge exchanged between Cherokee nations and African Americans in North America.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African and Indigenous Exchange', 190,
     v_exchange_source),

    (119,
     'Wax myrtle (bayberry) was part of the herbal knowledge exchanged between Cherokee nations and African Americans in North America.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'African and Indigenous Exchange', 200,
     v_exchange_source),

    -- Historic Herbal Combinations: Chills, Aches and Fever
    (313,
     'Historical formula for chills, aches, and fever: sassafras combined with peach leaf and chamomile (cami weed).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Chills, Aches and Fever', 210,
     v_fever_source),

    (320,
     'Historical formula for chills, aches, and fever: peach leaf combined with sassafras and chamomile (cami weed).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Chills, Aches and Fever', 220,
     v_fever_source),

    (84,
     'Historical formula for chills, aches, and fever: chamomile (cami weed) combined with sassafras and peach leaf.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Chills, Aches and Fever', 230,
     v_fever_source),

    -- Historic Herbal Combinations: Colic
    (56,
     'Historical formula to calm a fussy colic baby: sage combined with catnip.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Colic (Infant)', 240,
     v_colic_source),

    (136,
     'Historical formula to calm a fussy colic baby: catnip combined with sage.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Colic (Infant)', 250,
     v_colic_source),

    -- Historic Herbal Combinations: Immune Support
    (56,
     'Historical formula for immune support: sage combined with comfrey and chamomile (cami weed).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Immune Support', 260,
     v_immune_source),

    (1650,
     'Historical formula for immune support: comfrey combined with sage and chamomile (cami weed).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Immune Support', 270,
     v_immune_source),

    (84,
     'Historical formula for immune support: chamomile (cami weed) combined with sage and comfrey.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Immune Support', 280,
     v_immune_source),

    -- Historic Herbal Combinations: Digestive Support
    (92,
     'Traditional African American formula for bitter and digestive support: slippery elm combined with mullein leaf.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Digestive Support', 290,
     v_digestive_source),

    (61,
     'Traditional African American formula for bitter and digestive support: mullein leaf combined with slippery elm.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Digestive Support', 300,
     v_digestive_source),

    -- Medicine Making: Glycerine Syrup
    (84,
     'Chamomile included in the traditional African American glycerine syrup alongside comfrey, sage, and a flavonoid (lemon balm or mint).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Glycerine Syrup', 310,
     v_syrup_source),

    (1650,
     'Comfrey used in the traditional African American glycerine syrup for pain, fever, and swelling; combined with chamomile, sage, and a flavonoid addition.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Glycerine Syrup', 320,
     v_syrup_source),

    (56,
     'Sage included in the traditional African American glycerine syrup alongside chamomile, comfrey, and a flavonoid (lemon balm or mint).',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Glycerine Syrup', 330,
     v_syrup_source),

    (134,
     'Lemon balm used as a flavonoid addition to the traditional African American glycerine syrup; interchangeable with mint.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Glycerine Syrup', 340,
     v_syrup_source),

    (55,
     'Mint (peppermint or spearmint) used as a flavonoid addition to the traditional African American glycerine syrup; interchangeable with lemon balm.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Glycerine Syrup', 350,
     v_syrup_source),

    -- Medicine Making: Hibiscus Refresher
    (2233,
     'Hibiscus used in the traditional Hibiscus Refresher beverage with clove, cinnamon, ginger, orange peel, and hawthorn leaf and flower; decocted twice then combined.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Hibiscus Refresher', 360,
     v_refresher_source),

    (111,
     'Clove included in the traditional Hibiscus Refresher with hibiscus, cinnamon, ginger, orange peel, and hawthorn L/F.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Hibiscus Refresher', 370,
     v_refresher_source),

    (167,
     'Cinnamon included in the traditional Hibiscus Refresher with hibiscus, clove, ginger, orange peel, and hawthorn L/F.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Hibiscus Refresher', 380,
     v_refresher_source),

    (124,
     'Ginger included in the traditional Hibiscus Refresher with hibiscus, clove, cinnamon, orange peel, and hawthorn L/F.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Hibiscus Refresher', 390,
     v_refresher_source),

    (748,
     'Orange peel included in the traditional Hibiscus Refresher with hibiscus, clove, cinnamon, ginger, and hawthorn L/F.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Hibiscus Refresher', 400,
     v_refresher_source),

    (1652,
     'Hawthorn leaf and flower included in the traditional Hibiscus Refresher with hibiscus, clove, cinnamon, ginger, and orange peel.',
     'BHC - Class 19 - Black North American Herbalism', 'personal', 'Hibiscus Refresher', 410,
     v_refresher_source);

  RAISE NOTICE 'Class 19 snippets: done (41 rows).';
END $$;

-- Keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Ocotillo (1248): abdominal mover, lymphatic action
  (1248, 'lymphatic', 'action'),

  -- Asafetida (2645): historical uses
  (2645, 'asthma', 'ailment'),
  (2645, 'colic', 'ailment'),

  -- Black Cohosh (25): chills/fever, vermifuge
  (25, 'fever', 'ailment'),
  (25, 'antiparasitic', 'action'),

  -- Burdock (22): TB historical use
  (22, 'tuberculosis', 'ailment'),

  -- Horehound (160): bitter digestive herb
  (160, 'bitter tonic', 'action'),
  (160, 'digestive bitter', 'action'),

  -- Sassafras (313): fever formula, safety note
  (313, 'fever', 'ailment'),
  (313, 'common cold', 'ailment'),

  -- Peach leaf (320): fever formula
  (320, 'fever', 'ailment'),
  (320, 'common cold', 'ailment'),

  -- Chamomile (84): fever, colic, immune support
  (84, 'fever', 'ailment'),
  (84, 'colic', 'ailment'),
  (84, 'immune support', 'ailment'),

  -- Sage (56): colic, immune support
  (56, 'colic', 'ailment'),
  (56, 'immune support', 'ailment'),

  -- Catnip (136): colic (may already exist)
  (136, 'colic', 'ailment'),

  -- Comfrey leaf (1650): immune support, fever, swelling
  (1650, 'immune support', 'ailment'),
  (1650, 'fever', 'ailment'),
  (1650, 'anti-inflammatory', 'action'),

  -- Slippery Elm (92): digestive support
  (92, 'digestive health', 'ailment'),
  (92, 'demulcent', 'action'),

  -- Mullein leaf (61): digestive bitter
  (61, 'digestive health', 'ailment'),
  (61, 'bitter', 'action')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- New ailment keyword search synonyms (only for keywords new to this migration)
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('fever',
   ARRAY['pyrexia', 'febrile illness', 'elevated temperature', 'hyperthermia', 'chills and fever', 'chills']),
  ('tuberculosis',
   ARRAY['TB', 'pulmonary tuberculosis', 'mycobacterium tuberculosis', 'consumption', 'lung infection', 'lung disease'])
ON CONFLICT (ailment_keyword) DO NOTHING;
