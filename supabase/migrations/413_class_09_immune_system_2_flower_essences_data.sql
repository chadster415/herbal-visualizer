-- Migration 413: Class 9 — Immune System II and Flower Essences
-- Source files parsed:
--   BHC - Class 9 - Immune System II and Flower Essences - Rose Ashley.md (personal notes, note_type='personal')
--   No Generated Notes file exists for this class.
--
-- Herb normalisations applied:
--   California Goldenrod → Goldenrod (id=58, Solidago virgaurea) — closest match in DB
--   Nopal → Prickly Pear (id=2748, Opuntia spp.)
--   Aralia → California Spikenard (id=579, Aralia californica) — notes specify "California version"
--   Ochatillo → Ocotillo (id=1248, Fouquieria splendens)
--   elderberry syrup → Elder, berry (id=1651, Sambucus nigra)
--   elderflower / Elder flower → Elder, flower (id=57, Sambucus nigra)
--   rose → Rose, petal (id=850, Rosa spp.) — astringent context
--   Grindelia → Grindelia (id=2231, Grindelia squarrosa)
--   cinnamon → Cinnamon (id=167, Cinnamomum spp.)
--   white oak → White Oak (id=2241, Quercus alba)
--   Marsh root → Marshmallow (id=45, Althaea officinalis)
--
-- Herbs skipped:
--   Cedar — no entry in herbal.herbs
--   Pine — vague steam context only; Pine Needles (id=2643) is in DB but no specific clinical use named
--   Honey — food/preparation, not an herb
--
-- Keyword merge decisions:
--   "stuffy runny nose" → existing 'respiratory congestion' (no new keyword needed)
--   "cough" → NEW ailment keyword (distinct from existing 'chronic cough' and 'spasmodic cough'; covers acute cough)
--   "bone aches" → NEW ailment keyword 'bone pain' (specific flu symptom pattern; distinct from 'chronic pain')
--   "antiemetic" → NEW action keyword (not yet in DB)
--
-- No herb pairs extracted — no explicit two-herb synergy stated by instructor in these notes
--
-- Next migration: 414_class_09_immune_system_2_flower_essences_quiz.sql

SET search_path TO herbal, public;

-- ============================================================
-- SNIPPETS
-- ============================================================

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 9 - Immune System II and Flower Essences'
  ) THEN
    RAISE NOTICE 'Class 9 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === Stuffy Runny Nose ===

  (309,
   'Yerba Mansa — anticatarrhal (drying astringent) for stuffy runny nose; also good in neti pot, just a drop or 2 of tincture',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Stuffy Runny Nose', 10,
   '### Stuffy Runny Nose
- Herbal actions indicated: Anticatarrhal
    - these are drying astringent
    - Yerba Mansa, Goldenseal, California Goldenrod
        - Goldenrod likes to grow next to American Ginseng
        - Goldenseal, Berberine, yellow, alkaloid, strong effect on the body
            - very energizing
            - blood sugar stabilizing
            - tonifying to the RS
            - lower dose herb
    - Neti pot with herbs
        - tiny bit of tincture of the above herbs
        - Yerba Mansa good for this, just a drop or 2
    - Steams
        - help to open and dilate airways
        - Carminatives for this: Rosemary, Cedar, or Pine
    - Gua sha on the face to move lymph, also ears out and down
    - EO inhalers good too'),

  (30,
   'Goldenseal — anticatarrhal (drying astringent) for stuffy runny nose; contains berberine (yellow alkaloid, strong effect on the body); blood sugar stabilizing; tonifying to the respiratory system; lower dose herb',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Stuffy Runny Nose', 20,
   '### Stuffy Runny Nose
- Herbal actions indicated: Anticatarrhal
    - these are drying astringent
    - Yerba Mansa, Goldenseal, California Goldenrod
        - Goldenrod likes to grow next to American Ginseng
        - Goldenseal, Berberine, yellow, alkaloid, strong effect on the body
            - very energizing
            - blood sugar stabilizing
            - tonifying to the RS
            - lower dose herb
    - Neti pot with herbs
        - tiny bit of tincture of the above herbs
        - Yerba Mansa good for this, just a drop or 2
    - Steams
        - help to open and dilate airways
        - Carminatives for this: Rosemary, Cedar, or Pine
    - Gua sha on the face to move lymph, also ears out and down
    - EO inhalers good too'),

  (58,
   'California Goldenrod — anticatarrhal (drying astringent) for stuffy runny nose; likes to grow next to American Ginseng',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Stuffy Runny Nose', 30,
   '### Stuffy Runny Nose
- Herbal actions indicated: Anticatarrhal
    - these are drying astringent
    - Yerba Mansa, Goldenseal, California Goldenrod
        - Goldenrod likes to grow next to American Ginseng
        - Goldenseal, Berberine, yellow, alkaloid, strong effect on the body
            - very energizing
            - blood sugar stabilizing
            - tonifying to the RS
            - lower dose herb
    - Neti pot with herbs
        - tiny bit of tincture of the above herbs
        - Yerba Mansa good for this, just a drop or 2
    - Steams
        - help to open and dilate airways
        - Carminatives for this: Rosemary, Cedar, or Pine
    - Gua sha on the face to move lymph, also ears out and down
    - EO inhalers good too'),

  (109,
   'Rosemary — carminative used in steams to open and dilate airways for stuffy nose',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Stuffy Runny Nose', 40,
   '### Stuffy Runny Nose
- Herbal actions indicated: Anticatarrhal
    - these are drying astringent
    - Yerba Mansa, Goldenseal, California Goldenrod
        - Goldenrod likes to grow next to American Ginseng
        - Goldenseal, Berberine, yellow, alkaloid, strong effect on the body
            - very energizing
            - blood sugar stabilizing
            - tonifying to the RS
            - lower dose herb
    - Neti pot with herbs
        - tiny bit of tincture of the above herbs
        - Yerba Mansa good for this, just a drop or 2
    - Steams
        - help to open and dilate airways
        - Carminatives for this: Rosemary, Cedar, or Pine
    - Gua sha on the face to move lymph, also ears out and down
    - EO inhalers good too'),

  -- === Sore Throat ===

  (45,
   'Marshmallow (marsh root) — demulcent for sore throat; prepared as powder with water and honey, sit for an hour, taken from a small 4 oz jar every few hours',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 50,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (92,
   'Slippery Elm — demulcent for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 60,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (2748,
   'Nopal (Prickly Pear) — demulcent for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 70,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (180,
   'Flax — demulcent for sore throat; flax seed tea also specifically good for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 80,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (21,
   'Garlic (raw) — antimicrobial for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 90,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (59,
   'Thyme — antimicrobial for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 100,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (56,
   'Sage — antimicrobial for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 110,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (28,
   'Cleavers — lymphatic for sore throat',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 120,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  (26,
   'Echinacea — lymphatic for sore throat; specifically noted for numbing effect; dose 60-90 drops (2-3 dropperfuls) every 3 hours; also an alterative that reduces load on the liver (noted for snakebite)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Sore Throat', 130,
   '### Sore throat
- Herbal Actions indicated: Demulcents, Antimicrobials, Lymphatics
- Marsh root powder, little water and honey, site for hour, little 4 oz jar, take every few hours
    - Demulcents: Marshmallow, Slippery Elm, Nopal, Flax, Honey
    - Antimicrobials: Garlic (raw), Thyme, Sage
    - Lymphatics: Cleavers, Echinacea
        - Echinacea good because numbing effect
        - 60-90 drops (2-3 dropperfuls) every 3 hours
        - Echinacea also an alterative, reduces load on liver for snakebite so you can make it to the hospital in time
- Flax seed tea also good for sore throat
- David Winston and Paul Bergner
    - Paul Bergner ''Classic Herbal Pairs'' - Herbrally'),

  -- === Coughs (merged: "Coughs" + "Coughs cont") ===

  (140,
   'Wild Cherry Bark — antitussive/antispasmodic for hot/dry cough (sharp, painful, unproductive); used in natural cough syrups; soak in water before tincturing to extract cherry vanilla flavor; can combine with marshmallow and honey',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 140,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (45,
   'Marshmallow — antitussive / cooling and moistening agent for hot/dry cough (sharp, painful, unproductive)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 150,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (61,
   'Mullein — antitussive / cooling and moistening agent for hot/dry cough (sharp, painful, unproductive)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 160,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (78,
   'Licorice — warming and moistening agent for cold/dry cough (sticky mucus that won''t come out)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 170,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (124,
   'Ginger (fresh) — warming and moistening agent for cold/dry cough (sticky mucus that won''t come out)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 180,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (579,
   'Aralia (California Spikenard, Aralia californica) — relaxing expectorant for hot/damp cough; also nervine and antiviral; California version found in Huckleberry Regional Preserve in Berkeley',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 190,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (132,
   'Lobelia — relaxing expectorant for hot/damp cough',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 200,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (54,
   'Elecampane — multi-purpose expectorant that fits any cough type; both relaxing and stimulating; usually double extracted; celery-tasting',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 210,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (104,
   'Osha — stimulating expectorant for cold/damp cough; warming and drying to match the cold and damp condition',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 220,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (2231,
   'Grindelia — stimulating expectorant for cold/damp cough (warming and drying agents)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 230,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (980,
   'Lomatium — stimulating expectorant for cold/damp cough (warming and drying agents)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 240,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  (590,
   'Yerba Santa — stimulating expectorant for cold/damp cough (warming and drying agents)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Coughs', 250,
   '### Coughs
- When a cough is productive - don''t suppress it
- what color is the mucus?
    - green, yellow or streaked with blood = hot (more at the beginning)
    - cold = white and clear
    - colors can change, and therefore the energetics change, shift the herbs
- is the cough dry or wet?
    - wet is deeper, rattle in lungs
    - dry is a shallow
- energetics of the lungs
- TCM - lungs = "the tender organ" - hold our grief and emotions
- "mucosiliary escalator" - hairs that push things up and out of the lungs
    - 2 things paralyze them: smoking anything, dehydration

**Coughs cont:**
- Hot/Dry - breathing sharp and painful, coughing and nothing comes out, unproductive
    - use antitussives/antispasmodics + cooling and moistening agents
        - Wild Cherry Bark
            - will meet in Lakes Basin
            - in natural cough syrups
            - to get the cherry vanilla flavor out, soak in water before tincturing
            - can use in combo with marshmallow + honey
        - Marshmallow
        - Mullein
- Cold/Dry - less sharp and painful, more sticky mucus that won''t come out
    - use warming and moistening agents
        - Licorice
        - Ginger (fresh)
- Hot/Damp
    - use relaxing expectorant
        - Aralia
            - Nervine
            - Antiviral
            - California version, in Huckleberry Regional Preserve in Berkeley
        - Lobelia
        - Elecampane
- Cold/Damp
    - use stimulating expectorant (warming and drying agents)
        - Osha/Oshala
            - warming and drying, to match the cold and damp condition
        - Grindelia
        - Lomatium
        - Yerba Santa
- Cough herbs a lot are celery-tasting
- one multi-purpose herb across the board is Elecampane, fits anywhere
    - it''s both relaxing and stimulating
    - usually double extracted'),

  -- === Overall Immune Support ===

  (26,
   'Echinacea — immunostimulant preferred right when you first get sick; immunomodulators are for when illness is further along',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 260,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (1651,
   'Elderberry — antiviral as elderberry syrup; amount depends on severity of sickness',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 270,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (28,
   'Cleavers — lymphatic for overall immune support',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 280,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (88,
   'Chickweed — lymphatic for overall immune support',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 290,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (198,
   'Violet Leaf — lymphatic for overall immune support',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 300,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (981,
   'Red Root — lymphatic for overall immune support',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 310,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (1248,
   'Ocotillo — pelvic floor lymphatic',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 320,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  (35,
   'Poke Root — lymphatic for overall immune support',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Overall Immune Support', 330,
   '### Overall Immune Support
- Immunomodulators vs Immune Stimulators
    - right when you get sick, immunostimulant better: echinacea
    - immunomodulator, when it''s further along
- Antivirals
    - elderberry syrup, amount depending on sickness
- Lymphatics
    - Cleavers
    - Chickweed
    - Violet Leaf
    - Red Root
    - Ochatillo - pelvic floor lymphatic
    - Poke root
    - Mechanical movement of the lymph'),

  -- === Nausea ===

  (124,
   'Ginger — antiemetic for nausea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Nausea', 340,
   '### Nausea
- Herbal actions indicated:
    - Antiemetic
        - Ginger, Peppermint, Chamomile'),

  (55,
   'Peppermint — antiemetic for nausea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Nausea', 350,
   '### Nausea
- Herbal actions indicated:
    - Antiemetic
        - Ginger, Peppermint, Chamomile'),

  (84,
   'Chamomile — antiemetic for nausea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Nausea', 360,
   '### Nausea
- Herbal actions indicated:
    - Antiemetic
        - Ginger, Peppermint, Chamomile'),

  -- === Bone Aches ===

  (130,
   'Wild Lettuce — analgesic and sedative for bone aches (flu); can blend with water and honey and roll into pills',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Bone Aches', 370,
   '### Bone Aches
- use analgesic and sedative herbs
    - Wild Lettuce
        - blender with water and honey, roll into pills
    - California Poppy
        - Vinegar works well as tincture alternative
    - Passionflower
    - Valerian
        - 10% have opposite reaction - drop dose first
    - Boneset
    - Jamaican Dogwood
        - lower dose plant - 10-15 drops for pain'),

  (128,
   'California Poppy — analgesic and sedative for bone aches (flu); vinegar works well as tincture alternative',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Bone Aches', 380,
   '### Bone Aches
- use analgesic and sedative herbs
    - Wild Lettuce
        - blender with water and honey, roll into pills
    - California Poppy
        - Vinegar works well as tincture alternative
    - Passionflower
    - Valerian
        - 10% have opposite reaction - drop dose first
    - Boneset
    - Jamaican Dogwood
        - lower dose plant - 10-15 drops for pain'),

  (137,
   'Passionflower — analgesic and sedative for bone aches (flu)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Bone Aches', 390,
   '### Bone Aches
- use analgesic and sedative herbs
    - Wild Lettuce
        - blender with water and honey, roll into pills
    - California Poppy
        - Vinegar works well as tincture alternative
    - Passionflower
    - Valerian
        - 10% have opposite reaction - drop dose first
    - Boneset
    - Jamaican Dogwood
        - lower dose plant - 10-15 drops for pain'),

  (145,
   'Valerian — analgesic and sedative for bone aches (flu); safety note: 10% of people have opposite (stimulating) reaction — try a drop dose first',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Bone Aches', 400,
   '### Bone Aches
- use analgesic and sedative herbs
    - Wild Lettuce
        - blender with water and honey, roll into pills
    - California Poppy
        - Vinegar works well as tincture alternative
    - Passionflower
    - Valerian
        - 10% have opposite reaction - drop dose first
    - Boneset
    - Jamaican Dogwood
        - lower dose plant - 10-15 drops for pain'),

  (50,
   'Boneset — analgesic and sedative for bone aches (flu)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Bone Aches', 410,
   '### Bone Aches
- use analgesic and sedative herbs
    - Wild Lettuce
        - blender with water and honey, roll into pills
    - California Poppy
        - Vinegar works well as tincture alternative
    - Passionflower
    - Valerian
        - 10% have opposite reaction - drop dose first
    - Boneset
    - Jamaican Dogwood
        - lower dose plant - 10-15 drops for pain'),

  (2461,
   'Jamaican Dogwood — analgesic for bone aches (flu); lower dose plant, 10-15 drops for pain',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Bone Aches', 420,
   '### Bone Aches
- use analgesic and sedative herbs
    - Wild Lettuce
        - blender with water and honey, roll into pills
    - California Poppy
        - Vinegar works well as tincture alternative
    - Passionflower
    - Valerian
        - 10% have opposite reaction - drop dose first
    - Boneset
    - Jamaican Dogwood
        - lower dose plant - 10-15 drops for pain'),

  -- === Diarrhea ===

  (175,
   'Black Root — astringent for diarrhea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Diarrhea', 430,
   '### Diarrhea
- herbal action indicated: Astringent
- Black root
- cinnamon
- white oak
- yarrow
- willow
- rose'),

  (167,
   'Cinnamon — astringent for diarrhea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Diarrhea', 440,
   '### Diarrhea
- herbal action indicated: Astringent
- Black root
- cinnamon
- white oak
- yarrow
- willow
- rose'),

  (2241,
   'White Oak — astringent for diarrhea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Diarrhea', 450,
   '### Diarrhea
- herbal action indicated: Astringent
- Black root
- cinnamon
- white oak
- yarrow
- willow
- rose'),

  (44,
   'Yarrow — astringent for diarrhea; also diaphoretic for fever (appears in both sections)',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Diarrhea', 460,
   '### Diarrhea
- herbal action indicated: Astringent
- Black root
- cinnamon
- white oak
- yarrow
- willow
- rose'),

  (87,
   'Willow — astringent for diarrhea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Diarrhea', 470,
   '### Diarrhea
- herbal action indicated: Astringent
- Black root
- cinnamon
- white oak
- yarrow
- willow
- rose'),

  (850,
   'Rose — astringent for diarrhea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Diarrhea', 480,
   '### Diarrhea
- herbal action indicated: Astringent
- Black root
- cinnamon
- white oak
- yarrow
- willow
- rose'),

  -- === Fever ===

  (44,
   'Yarrow — diaphoretic for fever; also astringent for diarrhea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Fever', 490,
   '### Fever
- indicated - diaphoretic
- yarrow
- catnip
- elderflower
- boneset'),

  (136,
   'Catnip — diaphoretic for fever',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Fever', 500,
   '### Fever
- indicated - diaphoretic
- yarrow
- catnip
- elderflower
- boneset'),

  (57,
   'Elder Flower — diaphoretic for fever',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Fever', 510,
   '### Fever
- indicated - diaphoretic
- yarrow
- catnip
- elderflower
- boneset'),

  (50,
   'Boneset — diaphoretic for fever; also analgesic/sedative for bone aches',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Fever', 520,
   '### Fever
- indicated - diaphoretic
- yarrow
- catnip
- elderflower
- boneset'),

  -- === Case Practicum ===

  (104,
   'Osha — case: first parent with cold/wet rattly cough; stimulating expectorant (warming and drying); dose 10-15 drops every few hours',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 530,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup'),

  (20,
   'Ashwagandha — immunomodulator given once patient begins to feel better (recovery phase), not at the acute stage',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 540,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup'),

  (26,
   'Echinacea — case: lower dose and less frequent during recovery; higher dose and more frequent right at onset; immunostimulant used for all three family members',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 550,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup'),

  (167,
   'Cinnamon — case: warming herb for first parent with cold/wet constitution during acute illness',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 560,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup'),

  (1651,
   'Elderberry syrup — case: kept for all three family members as antiviral immune support',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 570,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup'),

  (84,
   'Chamomile glycerite — case: for girl with fever, chills, and nausea',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 580,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup'),

  (57,
   'Elder Flower — case: elderflower syrup for girl with fever',
   'BHC - Class 9 - Immune System II and Flower Essences', 'personal', 'Case Practicum', 590,
   '## Mini case practicum
- family all came down with the same bug, but presenting differently
- first parent gets sick every few months, and gets a really bad chest cold: rattle in the chest, runny nose, really cold and reaching for blankets. Mucus is white/clear
- 8 year old girl has a fever, chills and nausea
- second parent has a sore throat and just began to get sick

- first parent: cold and wet
    - osha - warming and drying for rattly cough
        - stim expectorant
    - ashwagandha once feeling better for immunomodulator
    - lower and less freq: echinacea
    - cinnamon for warming
- girl:
    - elderberry syrup and chamomile glycerite for nausea
- second parent:
    - higher and freq echinacea and marsh root for sore throat

in circle:
keep elderberry syrup for all
first parent:
osha - 10-15 drops every few hours
girl:
elderflower syrup, chamomile glycerite
second parent:
for all 3, immune stimulant
girl: bath + elderberry syrup');

END $$;

-- ============================================================
-- KEYWORDS
-- ============================================================

-- Yerba Mansa (309)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (309, 'respiratory congestion', 'ailment'),
  (309, 'anticatarrhal', 'action'),
  (309, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goldenseal (30)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (30, 'respiratory congestion', 'ailment'),
  (30, 'blood sugar dysregulation', 'ailment'),
  (30, 'anticatarrhal', 'action'),
  (30, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goldenrod (58)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (58, 'respiratory congestion', 'ailment'),
  (58, 'anticatarrhal', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rosemary (109)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'respiratory congestion', 'ailment'),
  (109, 'anticatarrhal', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Marshmallow (45)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'sore throat', 'ailment'),
  (45, 'cough', 'ailment'),
  (45, 'demulcent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Slippery Elm (92)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (92, 'sore throat', 'ailment'),
  (92, 'demulcent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Prickly Pear / Nopal (2748)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2748, 'sore throat', 'ailment'),
  (2748, 'demulcent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Flax (180)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (180, 'sore throat', 'ailment'),
  (180, 'demulcent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Garlic (21)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (21, 'sore throat', 'ailment'),
  (21, 'immune support', 'ailment'),
  (21, 'antimicrobial', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Thyme (59)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (59, 'sore throat', 'ailment'),
  (59, 'antimicrobial', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Sage (56)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (56, 'sore throat', 'ailment'),
  (56, 'antimicrobial', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cleavers (28)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (28, 'sore throat', 'ailment'),
  (28, 'lymphatic support', 'ailment'),
  (28, 'immune support', 'ailment'),
  (28, 'lymphatic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Echinacea (26)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26, 'sore throat', 'ailment'),
  (26, 'common cold', 'ailment'),
  (26, 'influenza', 'ailment'),
  (26, 'immune support', 'ailment'),
  (26, 'immunostimulant', 'action'),
  (26, 'antimicrobial', 'action'),
  (26, 'alterative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wild Cherry Bark (140)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (140, 'cough', 'ailment'),
  (140, 'spasmodic cough', 'ailment'),
  (140, 'antitussive', 'action'),
  (140, 'antispasmodic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mullein (61)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (61, 'cough', 'ailment'),
  (61, 'respiratory congestion', 'ailment'),
  (61, 'antitussive', 'action'),
  (61, 'demulcent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Licorice (78)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78, 'cough', 'ailment'),
  (78, 'respiratory congestion', 'ailment'),
  (78, 'demulcent', 'action'),
  (78, 'expectorant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginger (124)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'cough', 'ailment'),
  (124, 'nausea', 'ailment'),
  (124, 'common cold', 'ailment'),
  (124, 'expectorant', 'action'),
  (124, 'antiemetic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Spikenard / Aralia (579)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (579, 'cough', 'ailment'),
  (579, 'respiratory infection', 'ailment'),
  (579, 'expectorant', 'action'),
  (579, 'antiviral', 'action'),
  (579, 'nervine', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lobelia (132)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (132, 'cough', 'ailment'),
  (132, 'spasmodic cough', 'ailment'),
  (132, 'expectorant', 'action'),
  (132, 'antispasmodic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Elecampane (54)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (54, 'cough', 'ailment'),
  (54, 'chronic cough', 'ailment'),
  (54, 'expectorant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Osha (104)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (104, 'cough', 'ailment'),
  (104, 'common cold', 'ailment'),
  (104, 'influenza', 'ailment'),
  (104, 'respiratory infection', 'ailment'),
  (104, 'expectorant', 'action'),
  (104, 'antiviral', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Grindelia (2231)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2231, 'cough', 'ailment'),
  (2231, 'respiratory congestion', 'ailment'),
  (2231, 'expectorant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lomatium (980)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (980, 'cough', 'ailment'),
  (980, 'respiratory infection', 'ailment'),
  (980, 'expectorant', 'action'),
  (980, 'antiviral', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yerba Santa (590)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (590, 'cough', 'ailment'),
  (590, 'respiratory congestion', 'ailment'),
  (590, 'expectorant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Elder berry (1651)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1651, 'influenza', 'ailment'),
  (1651, 'immune support', 'ailment'),
  (1651, 'common cold', 'ailment'),
  (1651, 'antiviral', 'action'),
  (1651, 'immunostimulant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chickweed (88)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (88, 'lymphatic support', 'ailment'),
  (88, 'lymphatic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Violet (198)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (198, 'lymphatic support', 'ailment'),
  (198, 'lymphatic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Root (981)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (981, 'lymphatic support', 'ailment'),
  (981, 'immune support', 'ailment'),
  (981, 'lymphatic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ocotillo (1248)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1248, 'lymphatic support', 'ailment'),
  (1248, 'lymphatic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Poke Root (35)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (35, 'lymphatic support', 'ailment'),
  (35, 'lymphatic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Peppermint (55)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (55, 'nausea', 'ailment'),
  (55, 'antiemetic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chamomile (84)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (84, 'nausea', 'ailment'),
  (84, 'antiemetic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wild Lettuce (130)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (130, 'bone pain', 'ailment'),
  (130, 'chronic pain', 'ailment'),
  (130, 'analgesic', 'action'),
  (130, 'sedative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Poppy (128)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128, 'bone pain', 'ailment'),
  (128, 'analgesic', 'action'),
  (128, 'sedative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Passionflower (137)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (137, 'bone pain', 'ailment'),
  (137, 'analgesic', 'action'),
  (137, 'sedative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Valerian (145)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (145, 'bone pain', 'ailment'),
  (145, 'sedative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Boneset (50)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (50, 'bone pain', 'ailment'),
  (50, 'fever', 'ailment'),
  (50, 'influenza', 'ailment'),
  (50, 'analgesic', 'action'),
  (50, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Jamaican Dogwood (2461)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2461, 'bone pain', 'ailment'),
  (2461, 'chronic pain', 'ailment'),
  (2461, 'analgesic', 'action'),
  (2461, 'sedative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Black Root (175)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (175, 'diarrhea', 'ailment'),
  (175, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cinnamon (167)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (167, 'diarrhea', 'ailment'),
  (167, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- White Oak (2241)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2241, 'diarrhea', 'ailment'),
  (2241, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yarrow (44)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44, 'diarrhea', 'ailment'),
  (44, 'fever', 'ailment'),
  (44, 'astringent', 'action'),
  (44, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Willow (87)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (87, 'diarrhea', 'ailment'),
  (87, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose petal (850)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (850, 'diarrhea', 'ailment'),
  (850, 'astringent', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Elder flower (57)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (57, 'fever', 'ailment'),
  (57, 'influenza', 'ailment'),
  (57, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Catnip (136)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (136, 'fever', 'ailment'),
  (136, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ashwagandha (20)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (20, 'immune support', 'ailment'),
  (20, 'adaptogen', 'action'),
  (20, 'immunostimulant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- AILMENT SEARCH TERMS (new ailment keywords only)
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('cough',      ARRAY['acute cough', 'productive cough', 'dry cough', 'wet cough', 'bronchial irritation', 'coughing']),
  ('bone pain',  ARRAY['bone aches', 'aching bones', 'flu aches', 'body aches', 'deep muscle pain', 'myalgia'])
ON CONFLICT (ailment_keyword) DO NOTHING;
