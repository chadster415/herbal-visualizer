-- Migration 364: BHC Class 26 - Urinary I and Glycerites
-- Source file: BHC - Class 26 - Urinary I and Glycerites - Shereel.md (note_type = 'personal')
-- Class name: BHC - Class 26 - Urinary I and Glycerites
--
-- Distinct herbs parsed (30):
--   Dandelion root (122), Bearberry/Uva ursi (46), Usnea (112), Juniper (103), Thyme (59),
--   Lavender (82), Yarrow (44), Cleavers (28), Dandelion leaf (1648), Nettle leaf (43),
--   Horsetail (151), Marshmallow (45), Corn Silk (95), Sumac (2637), Goldenrod (58),
--   Black Cohosh (25), Willow (87), Chamomile (84), Ginger (124), Aloe (202), Kava (138),
--   Skullcap (142), California Poppy (128), Gravel Root (117), Thuja (201), Hibiscus (2233),
--   Linden (90), Hawthorn leaf & flower (1652), Burdock (22), Peppermint (55)
--
-- Normalisations applied:
--   Uva ursi → Bearberry (46)
--   Nettles → Nettle leaf (43)
--   `Awa / Kava → Kava (138)
--   Corn (silk and husk) → Corn Silk (95)
--   White Willow → Willow (87)
--
-- Skipped (foods / not appropriate to add):
--   Watermelon/Seed — primarily a food; mentioned parenthetically for kidney stones
--   Red Onion — food
--   Okra — food
--
-- New ailment keywords: kidney stones, cystitis, chronic kidney disease, bladder support
-- New action keywords: diaphoretic, antilithic
-- Keyword merge decisions:
--   'UTI' mentions → merged into existing 'urinary tract infection'
--   'antiseptic' (herb action) → using existing 'antimicrobial'
--   'chronic kidney disease' is clinically distinct from existing 'kidney support' → new keyword
--   'cystitis' is distinct from existing 'urinary tract infection' (bladder-specific) → new keyword

SET search_path TO herbal, public;

-- ============================================================
-- SNIPPETS
-- ============================================================
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 26 - Urinary I and Glycerites') THEN
    RAISE NOTICE 'Class 26 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- HORMONES SECTION
  (122, 'Dandelion root reduces sodium with their potassium level — useful when hormones like Aldosterone, Estrogen, and Cortisol encourage kidneys to retain sodium and water.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Hormones', 10,
   '### Hormones
- Calcitriol - active form of Vitamin D
- Erythropoietin - stimulate production of red blood cells in order for the kidneys to get healthy blood quality
- Renin - helps to signal how much constriction..?

- from other organs influencing kidneys:
    - Aldosterone - ??
    - Estrogen -
    - Cortisol -
    - these all encourage kidneys to retain sodium, which causes water to be retained
    - trace mineral intake here is important to counteract this by allowing the cells to absorb more of this water
    - but also trace minerals also tell the body that homeostasis is being improved and water can be released
    - [[Dandelion root]] reduces sodium with their potassium level'),

  -- ANTISEPTICS SECTION
  (46, 'Bearberry (Uva ursi) — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Antiseptics', 20,
   '#### Antiseptics
- kills bacteria
- examples:
    - [[Uva ursi]]
    - [[Usnea]]
    - [[Databases/Herbs/Data/Juniper|Juniper]]
    - [[Thyme]]
    - [[Lavender]]
    - [[Yarrow]]'),

  (112, 'Usnea — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Antiseptics', 30,
   '#### Antiseptics
- kills bacteria
- examples:
    - [[Uva ursi]]
    - [[Usnea]]
    - [[Databases/Herbs/Data/Juniper|Juniper]]
    - [[Thyme]]
    - [[Lavender]]
    - [[Yarrow]]'),

  (103, 'Juniper — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Antiseptics', 40,
   '#### Antiseptics
- kills bacteria
- examples:
    - [[Uva ursi]]
    - [[Usnea]]
    - [[Databases/Herbs/Data/Juniper|Juniper]]
    - [[Thyme]]
    - [[Lavender]]
    - [[Yarrow]]'),

  (59, 'Thyme — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Antiseptics', 50,
   '#### Antiseptics
- kills bacteria
- examples:
    - [[Uva ursi]]
    - [[Usnea]]
    - [[Databases/Herbs/Data/Juniper|Juniper]]
    - [[Thyme]]
    - [[Lavender]]
    - [[Yarrow]]'),

  (82, 'Lavender — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Antiseptics', 60,
   '#### Antiseptics
- kills bacteria
- examples:
    - [[Uva ursi]]
    - [[Usnea]]
    - [[Databases/Herbs/Data/Juniper|Juniper]]
    - [[Thyme]]
    - [[Lavender]]
    - [[Yarrow]]'),

  (44, 'Yarrow — listed as a urinary antiseptic; kills bacteria in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Antiseptics', 70,
   '#### Antiseptics
- kills bacteria
- examples:
    - [[Uva ursi]]
    - [[Usnea]]
    - [[Databases/Herbs/Data/Juniper|Juniper]]
    - [[Thyme]]
    - [[Lavender]]
    - [[Yarrow]]'),

  -- DIURETICS SECTION
  (28, 'Cleavers — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Diuretics', 80,
   '#### Diuretics
- remove excess water and also sodium
- examples:
    - [[Cleavers]]
    - [[Dandelion leaf]]
    - [[Nettle]]
    - [[Horsetail]]'),

  (1648, 'Dandelion leaf — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Diuretics', 90,
   '#### Diuretics
- remove excess water and also sodium
- examples:
    - [[Cleavers]]
    - [[Dandelion leaf]]
    - [[Nettle]]
    - [[Horsetail]]'),

  (43, 'Nettle (leaf) — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Diuretics', 100,
   '#### Diuretics
- remove excess water and also sodium
- examples:
    - [[Cleavers]]
    - [[Dandelion leaf]]
    - [[Nettle]]
    - [[Horsetail]]'),

  (151, 'Horsetail — listed as a urinary diuretic; removes excess water and sodium from the body.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Diuretics', 110,
   '#### Diuretics
- remove excess water and also sodium
- examples:
    - [[Cleavers]]
    - [[Dandelion leaf]]
    - [[Nettle]]
    - [[Horsetail]]'),

  -- TOP HERBS SECTION
  (45, 'Marshmallow root — demulcent for the urinary system; helps the mucosal lining and moves waste that is hot and sticky.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 120,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (95, 'Corn (silk and husk) — for kidney pain and cooling inflammation in the urinary tract.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 130,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (2637, 'Sumac — enzymatic; helps to break up fatty deposits in the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 140,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (58, 'Goldenrod — addresses inflammation and chronic kidney disease; acts as a urinary antiseptic.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 150,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (25, 'Black Cohosh leaf — western herbalists typically use the root; the leaf is more gentle for urinary support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 160,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (87, 'Willow bark — used for pain relief in the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 170,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (84, 'Chamomile — listed as a top herb for urinary system support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 180,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (82, 'Lavender — "all the anti-s": anti-inflammatory, antimicrobial, and antispasmodic properties for the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 190,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (44, 'Yarrow — diaphoretic and diuretic; anti-inflammatory (AI) for the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 200,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (28, 'Cleavers — lymphatic herb for the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 210,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (1648, 'Dandelion leaf — diuretic for the urinary system; listed as a top herb for urinary support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 220,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (43, 'Nettles — necessary for red blood cell production; diuretic for the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 230,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (124, 'Ginger — warming and metabolism support for the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 240,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (202, 'Aloe — cooling, bitter, astringent; best indicated for the bladder — UTI, cystitis.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 250,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (138, '`Awa (also Kava) — sedating, relaxing; useful for bladder tension and urinary system support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 260,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (142, 'Skullcap — milder sedative; supports the nervous system in the context of urinary and bladder health.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 270,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (128, 'California Poppy — stronger sedative; pain relief and relaxation for the urinary system.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 280,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  (117, 'Gravel Root — European analog to watermelon seed; used for breaking down oxalates in kidney stones.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Top Herbs', 290,
   '### Top Herbs:
- Watermelon/Seed
    - seed is demulcent
    - used for breaking down the oxalates in kidney stones
    - can make a tea, or dry, grind and eat
    - also gravel root (European)
- Red Onion
    - Sulferic compounds breaks down oxylates in stones
- [[Marshmallow]] root
    - demulcent
- [[Corn]]
    - silk and husk
    - kidney pain and cooling inflammation
- [[Sumac]]
    - enzymatic
    - helps to break up fatty deposits
- [[Goldenrod]]
    - inflammation
    - chronic kidney disease
    - antiseptic
- [[Black Cohosh]] Leaf
    - western - root
    - leaf more gentle
- [[White Willow|Willow]] Bark
    - pain
- Okra
    - bladder and kidney
- [[Chamomile]]
- [[Lavender]]
    - all the anti-s
- [[Yarrow]]
    - [[diaphoretic]] and [[diuretic]]
    - AI
- [[Cleavers]]
    - [[lymphatic]]
- [[Dandelion leaf]]
- Nettles
    - necessary for red blood cell production
- [[Ginger]]
    - warming and metabolism
- Aloe
    - cooling, bitter, astringent
    - best indicated for the bladder - UTI, cystitis
- `Awa
    - also [[Kava]]
    - sedating, relaxing
- [[Skullcap]]
    - milder sedative
- [[Databases/Herbs/Data/California Poppy|California Poppy]]
    - stronger sedative'),

  -- JUNIPER SECTION (merged from two headers: Juniper/White Cedar + Juniper Juniperus Communis)
  (103, 'Juniper (Juniperus communis) — Navajo tradition: used with Bayberry root bark as a tea; juniper berries used as a female contraceptive. Western European use: chronic bladder and kidney infections, atony for edema from renal failure, amenorrhea, gout, arthritis. Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20–40 drops; infusion 2–3oz 3x day.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Juniper', 300,
   '**Juniper / White Cedar (Thuja occidentalis):**
- Thuja
- African Americans used White Cedar for Asthma
- Native Americans used the plant for fevers, coughs, headaches, swollen hands, and rheumatic problems.
- Skin issues: warts, oily, dry skin, eruptions, nail fungus, hemorrhoids
- Urogenital-swollen & inflamed Urethra, weak urine stream; urge to urinate frequently; infection; STD (gonorrhea)
- Preparation: Infusion / Steam/Inhalation / External Wash. Dosage: 1/4 cup
- Extraction: 1-part leaves fresh, chopped; 2 parts menstruum (50% alcohol, 50% water)
- Infused oil-Massage: 1-part leaves chopped fresh; 2 parts oil

**Juniper (Juniperus Communis):**
- Native Western American (Navajo) tribes used Juniper along with Bayberry root bark as a tea and juniper berries as a female contraceptive.
- Western European Medicine: Chronic bladder and kidney infections, atony for edema from renal failure congestion, amenorrhea, pain relief from gout and arthritis.
    - Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20-40 drops. Infusion 2-3oz 3x day.
- The more you are in a hypertensive state, the more damage to the kidneys; have to then regulate the NS — Skullcap as a nervine is useful here.
- Tests: GFR < 60 — stage 1 kidney disease; look at trends.'),

  (201, 'Thuja occidentalis (White Cedar) — used by African Americans for asthma; Native Americans for fevers, coughs, headaches, swollen hands, and rheumatic problems. Skin: warts, oily/dry skin, eruptions, nail fungus, hemorrhoids. Urogenital: swollen/inflamed urethra, weak urine stream, frequent urge to urinate, infection, STD/gonorrhea. Preparation: Infusion, Steam/Inhalation, External Wash; dosage 1/4 cup. Extraction: 1-part fresh leaves, 2-parts menstruum (50% alcohol, 50% water).',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Juniper', 310,
   '**Juniper / White Cedar (Thuja occidentalis):**
- Thuja
- African Americans used White Cedar for Asthma
- Native Americans used the plant for fevers, coughs, headaches, swollen hands, and rheumatic problems.
- Skin issues: warts, oily, dry skin, eruptions, nail fungus, hemorrhoids
- Urogenital-swollen & inflamed Urethra, weak urine stream; urge to urinate frequently; infection; STD (gonorrhea)
- Preparation: Infusion / Steam/Inhalation / External Wash. Dosage: 1/4 cup
- Extraction: 1-part leaves fresh, chopped; 2 parts menstruum (50% alcohol, 50% water)
- Infused oil-Massage: 1-part leaves chopped fresh; 2 parts oil

**Juniper (Juniperus Communis):**
- Native Western American (Navajo) tribes used Juniper along with Bayberry root bark as a tea and juniper berries as a female contraceptive.
- Western European Medicine: Chronic bladder and kidney infections, atony for edema from renal failure congestion, amenorrhea, pain relief from gout and arthritis.
    - Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20-40 drops. Infusion 2-3oz 3x day.
- The more you are in a hypertensive state, the more damage to the kidneys; have to then regulate the NS — Skullcap as a nervine is useful here.
- Tests: GFR < 60 — stage 1 kidney disease; look at trends.'),

  (142, 'Skullcap as a nervine is useful for kidney health — the more one is in a hypertensive state, the more damage to the kidneys; regulating the nervous system helps protect kidney function.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Juniper', 320,
   '**Juniper / White Cedar (Thuja occidentalis):**
- Thuja
- African Americans used White Cedar for Asthma
- Native Americans used the plant for fevers, coughs, headaches, swollen hands, and rheumatic problems.
- Skin issues: warts, oily, dry skin, eruptions, nail fungus, hemorrhoids
- Urogenital-swollen & inflamed Urethra, weak urine stream; urge to urinate frequently; infection; STD (gonorrhea)
- Preparation: Infusion / Steam/Inhalation / External Wash. Dosage: 1/4 cup
- Extraction: 1-part leaves fresh, chopped; 2 parts menstruum (50% alcohol, 50% water)
- Infused oil-Massage: 1-part leaves chopped fresh; 2 parts oil

**Juniper (Juniperus Communis):**
- Native Western American (Navajo) tribes used Juniper along with Bayberry root bark as a tea and juniper berries as a female contraceptive.
- Western European Medicine: Chronic bladder and kidney infections, atony for edema from renal failure congestion, amenorrhea, pain relief from gout and arthritis.
    - Preparation: Blue/Black Seed Cones (Berries) tincture 1:5 75% alcohol 20-40 drops. Infusion 2-3oz 3x day.
- The more you are in a hypertensive state, the more damage to the kidneys; have to then regulate the NS — Skullcap as a nervine is useful here.
- Tests: GFR < 60 — stage 1 kidney disease; look at trends.'),

  -- HEART FORMULA SECTION (afternoon glycerites)
  (2233, 'Hibiscus — part of the Heart Formula glycerite; acts like an ACE inhibitor by affecting the angiotensin process; used alongside Linden, Hawthorn leaf and flower, and Ginger for blood pressure support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Heart Formula', 330,
   '### Hibiscus and Linden (Heart Formula)
- kind of works the same way as an ACE inhibitor
- blood pressure pharmas work by stopping the angiotensin process
- hard to stop the drug after body gets used to it
- after 3-4 hours, maybe midday after taking drug in morning, pharma medicine wearing off, and Linden helps the body start the natural processes again
- off the drug, the body rebounds with extra high BP
- don''t take at the same time as pharma - BP could go down too low
- start with small tea doses at midday, take BP at bedtime, play around with dosage depending on number
- to get off drug, slowly slowly

Formula:
- Hawthorn leaf and flower
- Hibiscus
- Ginger
- Linden'),

  (90, 'Linden — part of the Heart Formula glycerite; helps the body restart natural blood pressure regulation after pharmaceutical medication wears off at midday. Do not take at the same time as BP pharmaceuticals — BP could go too low. Start with small tea doses at midday; taper slowly to get off the drug.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Heart Formula', 340,
   '### Hibiscus and Linden (Heart Formula)
- kind of works the same way as an ACE inhibitor
- blood pressure pharmas work by stopping the angiotensin process
- hard to stop the drug after body gets used to it
- after 3-4 hours, maybe midday after taking drug in morning, pharma medicine wearing off, and Linden helps the body start the natural processes again
- off the drug, the body rebounds with extra high BP
- don''t take at the same time as pharma - BP could go down too low
- start with small tea doses at midday, take BP at bedtime, play around with dosage depending on number
- to get off drug, slowly slowly

Formula:
- Hawthorn leaf and flower
- Hibiscus
- Ginger
- Linden'),

  (1652, 'Hawthorn leaf and flower — part of the Heart Formula glycerite with Hibiscus, Linden, and Ginger for blood pressure support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Heart Formula', 350,
   '### Hibiscus and Linden (Heart Formula)
- kind of works the same way as an ACE inhibitor
- blood pressure pharmas work by stopping the angiotensin process
- hard to stop the drug after body gets used to it
- after 3-4 hours, maybe midday after taking drug in morning, pharma medicine wearing off, and Linden helps the body start the natural processes again
- off the drug, the body rebounds with extra high BP
- don''t take at the same time as pharma - BP could go down too low
- start with small tea doses at midday, take BP at bedtime, play around with dosage depending on number
- to get off drug, slowly slowly

Formula:
- Hawthorn leaf and flower
- Hibiscus
- Ginger
- Linden'),

  (124, 'Ginger — part of the Heart Formula glycerite with Hibiscus, Linden, and Hawthorn for blood pressure support.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Heart Formula', 360,
   '### Hibiscus and Linden (Heart Formula)
- kind of works the same way as an ACE inhibitor
- blood pressure pharmas work by stopping the angiotensin process
- hard to stop the drug after body gets used to it
- after 3-4 hours, maybe midday after taking drug in morning, pharma medicine wearing off, and Linden helps the body start the natural processes again
- off the drug, the body rebounds with extra high BP
- don''t take at the same time as pharma - BP could go down too low
- start with small tea doses at midday, take BP at bedtime, play around with dosage depending on number
- to get off drug, slowly slowly

Formula:
- Hawthorn leaf and flower
- Hibiscus
- Ginger
- Linden'),

  -- URINARY FORMULA SECTION
  (43, 'Nettle — part of the Urinary System Support glycerite with Burdock, Dandelion leaf, and Peppermint; purpose: move water and remove waste.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Urinary Formula', 370,
   '### Urinary Formula
- move water and remove waste

Formula:
- Nettle
- Burdock
- Dandelion Leaf
- Peppermint'),

  (22, 'Burdock — part of the Urinary System Support glycerite with Nettle, Dandelion leaf, and Peppermint; purpose: move water and remove waste.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Urinary Formula', 380,
   '### Urinary Formula
- move water and remove waste

Formula:
- Nettle
- Burdock
- Dandelion Leaf
- Peppermint'),

  (1648, 'Dandelion leaf — part of the Urinary System Support glycerite with Nettle, Burdock, and Peppermint; purpose: move water and remove waste.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Urinary Formula', 390,
   '### Urinary Formula
- move water and remove waste

Formula:
- Nettle
- Burdock
- Dandelion Leaf
- Peppermint'),

  (55, 'Peppermint — part of the Urinary System Support glycerite with Nettle, Burdock, and Dandelion leaf; purpose: move water and remove waste.',
   'BHC - Class 26 - Urinary I and Glycerites', 'personal', 'Urinary Formula', 400,
   '### Urinary Formula
- move water and remove waste

Formula:
- Nettle
- Burdock
- Dandelion Leaf
- Peppermint');

END $$;

-- ============================================================
-- HERB KEYWORDS (ailment)
-- ============================================================
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Dandelion root
  (122, 'kidney support',         'ailment'),
  (122, 'edema',                   'ailment'),
  -- Bearberry (Uva ursi)
  (46,  'urinary tract infection', 'ailment'),
  (46,  'cystitis',                'ailment'),
  -- Usnea
  (112, 'urinary tract infection', 'ailment'),
  -- Juniper
  (103, 'urinary tract infection', 'ailment'),
  (103, 'kidney support',         'ailment'),
  (103, 'edema',                   'ailment'),
  (103, 'amenorrhea',              'ailment'),
  (103, 'gout',                    'ailment'),
  (103, 'arthritis',               'ailment'),
  -- Thyme
  (59,  'urinary tract infection', 'ailment'),
  -- Lavender
  (82,  'urinary tract infection', 'ailment'),
  (82,  'inflammation',            'ailment'),
  -- Yarrow
  (44,  'urinary tract infection', 'ailment'),
  (44,  'inflammation',            'ailment'),
  (44,  'edema',                   'ailment'),
  -- Cleavers
  (28,  'edema',                   'ailment'),
  (28,  'lymphatic support',       'ailment'),
  (28,  'kidney support',         'ailment'),
  -- Dandelion leaf
  (1648,'edema',                   'ailment'),
  (1648,'kidney support',         'ailment'),
  -- Nettle leaf
  (43,  'edema',                   'ailment'),
  (43,  'kidney support',         'ailment'),
  (43,  'anemia',                  'ailment'),
  -- Horsetail
  (151, 'edema',                   'ailment'),
  (151, 'kidney support',         'ailment'),
  -- Marshmallow
  (45,  'kidney support',         'ailment'),
  (45,  'cystitis',                'ailment'),
  (45,  'mucous membrane support', 'ailment'),
  -- Corn Silk
  (95,  'kidney support',         'ailment'),
  (95,  'cystitis',                'ailment'),
  (95,  'inflammation',            'ailment'),
  -- Sumac
  (2637,'kidney support',         'ailment'),
  -- Goldenrod
  (58,  'inflammation',            'ailment'),
  (58,  'chronic kidney disease',  'ailment'),
  (58,  'kidney support',         'ailment'),
  (58,  'urinary tract infection', 'ailment'),
  -- Black Cohosh
  (25,  'kidney support',         'ailment'),
  -- Willow
  (87,  'chronic pain',            'ailment'),
  -- Chamomile
  (84,  'urinary tract infection', 'ailment'),
  -- Ginger (Top Herbs context)
  (124, 'kidney support',         'ailment'),
  -- Aloe
  (202, 'urinary tract infection', 'ailment'),
  (202, 'cystitis',                'ailment'),
  (202, 'bladder support',         'ailment'),
  -- Kava
  (138, 'bladder support',         'ailment'),
  -- Skullcap
  (142, 'bladder support',         'ailment'),
  (142, 'kidney support',         'ailment'),
  (142, 'hypertension',            'ailment'),
  -- California Poppy
  (128, 'bladder support',         'ailment'),
  (128, 'chronic pain',            'ailment'),
  -- Gravel Root
  (117, 'kidney stones',           'ailment'),
  (117, 'kidney support',         'ailment'),
  -- Thuja
  (201, 'urinary tract infection', 'ailment'),
  (201, 'cystitis',                'ailment'),
  (201, 'asthma',                  'ailment'),
  (201, 'arthritis',               'ailment'),
  -- Hibiscus
  (2233,'hypertension',            'ailment'),
  (2233,'cardiovascular disease',  'ailment'),
  -- Linden
  (90,  'hypertension',            'ailment'),
  (90,  'cardiovascular disease',  'ailment'),
  -- Hawthorn leaf & flower
  (1652,'hypertension',            'ailment'),
  (1652,'cardiovascular disease',  'ailment'),
  -- Ginger (Heart Formula context — same herb_id, same keywords, ON CONFLICT handles duplicates)
  (124, 'hypertension',            'ailment'),
  (124, 'cardiovascular disease',  'ailment'),
  -- Burdock
  (22,  'kidney support',         'ailment'),
  -- Peppermint
  (55,  'kidney support',         'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- HERB KEYWORDS (action)
-- ============================================================
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Dandelion root
  (122, 'diuretic',        'action'),
  -- Bearberry
  (46,  'antimicrobial',   'action'),
  -- Usnea
  (112, 'antimicrobial',   'action'),
  -- Juniper
  (103, 'antimicrobial',   'action'),
  (103, 'diuretic',        'action'),
  -- Thyme
  (59,  'antimicrobial',   'action'),
  -- Lavender
  (82,  'anti-inflammatory','action'),
  (82,  'antimicrobial',   'action'),
  (82,  'antispasmodic',   'action'),
  -- Yarrow
  (44,  'diuretic',        'action'),
  (44,  'diaphoretic',     'action'),
  (44,  'anti-inflammatory','action'),
  -- Cleavers
  (28,  'diuretic',        'action'),
  (28,  'lymphatic',       'action'),
  -- Dandelion leaf
  (1648,'diuretic',        'action'),
  -- Nettle leaf
  (43,  'diuretic',        'action'),
  (43,  'nutritive',       'action'),
  -- Horsetail
  (151, 'diuretic',        'action'),
  -- Marshmallow
  (45,  'demulcent',       'action'),
  -- Goldenrod
  (58,  'antimicrobial',   'action'),
  (58,  'anti-inflammatory','action'),
  -- Willow
  (87,  'analgesic',       'action'),
  -- California Poppy
  (128, 'sedative',        'action'),
  (128, 'analgesic',       'action'),
  -- Gravel Root
  (117, 'antilithic',      'action'),
  (117, 'diuretic',        'action'),
  -- Thuja
  (201, 'antimicrobial',   'action'),
  -- Skullcap
  (142, 'nervine',         'action'),
  (142, 'sedative',        'action'),
  -- Kava
  (138, 'sedative',        'action'),
  -- Aloe
  (202, 'demulcent',       'action'),
  (202, 'anti-inflammatory','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- NEW AILMENT KEYWORDS IN AILMENT_SEARCH_TERMS
-- ============================================================
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('kidney stones',
   ARRAY['nephrolithiasis', 'renal calculi', 'urinary calculi', 'urolithiasis', 'oxalate stones', 'kidney stone', 'kidney gravel']),
  ('cystitis',
   ARRAY['bladder infection', 'bladder inflammation', 'lower urinary tract infection', 'interstitial cystitis', 'bladder cystitis', 'bladder UTI']),
  ('chronic kidney disease',
   ARRAY['CKD', 'renal failure', 'kidney failure', 'renal insufficiency', 'nephropathy', 'kidney disease', 'chronic renal disease']),
  ('bladder support',
   ARRAY['bladder tonic', 'bladder health', 'bladder weakness', 'bladder function', 'urinary bladder health', 'bladder tone'])
ON CONFLICT (ailment_keyword) DO NOTHING;
