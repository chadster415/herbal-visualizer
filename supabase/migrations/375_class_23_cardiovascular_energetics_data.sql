-- Migration 375: BHC Class 23 — Cardiovascular System 2 and Energetics
--
-- Files parsed:
--   personal: BHC - Class 23 - Cardiovascular System 2 and Energetics - Shereel Lisa.md
--   (no generated notes file for this class)
--
-- Normalisations applied:
--   Eleuthero             → Siberian Ginseng (id=9)
--   Panax Ginseng         → Ginseng (id=14)
--   Schizandra/Schisandra → Schizandra (id=17)
--   Tulsi                 → Holy Basil (id=13)
--   Cal poppy             → California Poppy (id=128)
--   Oat straw             → Oat straw (id=2287)
--   Milky Oats            → Oat milky oats (id=178)
--   Mint                  → Peppermint (id=55)
--   OGR / Oregon Grape Root → Oregon Grape (id=33)
--   Blackberry Root       → Blackberry (id=156)
--   Gotu kola             → Gotu Kola aerial parts (id=2229)
--   Sarsparilla           → Sarsaparilla (id=40)
--
-- Herbs skipped (culinary / not in DB):
--   Curry Leaf — not in DB
--   Cumin — not in DB
--   Chiles — food, not added
--   Okra — food, not added
--   Methi Leaf — leaf of Fenugreek (id=91), covered there
--
-- Keyword merge decisions:
--   "high cholesterol"       → existing 'hyperlipidemia'
--   "water retention"        → existing 'edema'
--   "oily skin"              → existing 'skin conditions'
--   "adrenal depletion"      → existing 'adrenal fatigue'
--   "ischemic heart disease" → existing 'cardiovascular disease'
--   "dry skin"               → existing 'skin conditions'
--   "slow metabolism"        → existing 'metabolic syndrome'
--   "yeast"                  → new 'yeast overgrowth' (distinct from vaginitis)
--   New ailment keywords: arrhythmia, atherosclerosis, angina, Raynaud''s syndrome,
--                         thrombosis, heart attack, palpitations, heart failure,
--                         respiratory congestion, yeast overgrowth

SET search_path TO herbal, public;

-- ============================================================
-- SNIPPETS
-- ============================================================
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 23 - Cardiovascular System 2 and Energetics') THEN
    RAISE NOTICE 'Class 23 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- Herb snippets
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ── Cardiovascular System 2 ───────────────────────────────
  (73, 'Hawthorn Tincture and Glycerite — alcohol absorbs phytochemicals more fully, but can be dry and hot, not tolerated by all. Glycerite may improve compliance. Option: add tincture to water, or use spirits (50–60%), noting infusing time is longer than with 95%.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Cardiovascular System 2', 10,
   '**[[Hawthorn]] Tincture and [[Glycerite]]**
Alcohol does absorb the phytochemicals more
.. but dry, hot, not tolerated by all
glycerite may improve compliance a little more
option: add the tincture to water as well
anything to moisten and soften the remedy
option: use spirits (50-60%), but the infusing time is more than 95%'),

  -- Psyllium — dietary fiber for CV health
  (2240, 'Psyllium — mentioned as bulky fiber supporting cardiovascular health; "fill and scrape." Water-soluble fiber feeds the microbiome.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Cardiovascular System 2', 20,
   '- **fiber**
    - bulky (psyllium, fill and scrape)
    - water - soluble as well
    - microbiome feeds on this'),

  -- ── Adaptogens and CV Health ──────────────────────────────
  (15, 'American Ginseng — cardioprotective, blood sugar regulation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 30,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (14, 'Panax Ginseng — cardio anti-inflammatory, reduces LDL oxidation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 40,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (9, 'Siberian Ginseng (Eleuthero) — lowers cholesterol, improves ischemic heart disease, reduces stress-induced thrombosis.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 50,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (11, 'Reishi Mushroom — lowers cholesterol, protects against clot formation and platelet aggregation, hypotensive.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 60,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (16, 'Rhodiola — reduces stress-induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure. Described as "energetic heart medicine."', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 70,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (17, 'Schizandra — reduces oxidative stress; described as "Liver medicine, Anger medicine"; associated with reducing the cardiac insults of anger. Cardioprotective through antioxidant activity.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 80,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (313, 'Sassafras — listed among Black Herbal herbs for cardiovascular and circulatory support.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 90,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (2645, 'Asafetida — aromatic pungent spice listed among Black Herbal cardiovascular herbs; described as a strong sedative with antiviral properties ("warding off viral load").', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 100,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (2233, 'Hibiscus — listed among Black Herbal herbs for cardiovascular support.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 110,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (21, 'Garlic — listed among Black Herbal herbs for cardiovascular support.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 120,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (90, 'Linden — described as the Black Herbal herb to "work with the most" for cardiovascular support; good for the nervous system.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 130,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  (131, 'Motherwort — listed among Black Herbal herbs for cardiovascular support.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Adaptogens and CV Health', 140,
   '- American Ginseng - Cardioprotective, blood sugar regulation
- Panax Ginseng - cardio anti inflammatory, reduces LDL oxidation
- [[Siberian Ginseng|Eleuthero]] - lowers cholesterol, improves ishemic heart disease, reduce stress induced thrombosis
- [[Reishi]] - lowers cholesterol, protect clots from forming and platelet aggregation, hypotensive
- [[Rhodiola]] - reduces stress induced arrhythmias, cardioprotective, modulates stress, normalizes blood pressure, energetic heart medicine
- [[Schisandra|Schizandra]] - reduces oxidative stress, Liver medicine, Anger medicine, associated with reducing insults of anger on the heart, cardioprotective through antioxidant activity

In addition, moreso Black Herbal herbs:
- [[Sassafras]]
- Asafetida - aromatic pungent spice, strong [[sedative]]
    - warding off viral load
- [[Hibiscus]]
- [[Databases/Herbs/Data/Garlic|Garlic]]
- [[Linden]] - work with the most
    - good for NS
- [[Motherwort]]'),

  -- ── Cardiovascular Conditions ─────────────────────────────
  (90, 'Linden — specifically highlighted for stroke support: "important to calm the person down, accept what happened."', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Cardiovascular Conditions', 150,
   '- Stroke (ischemic or hemorrhagic)
    - blood clot created or traveled to the brain, stopped oxygen traveling there
    - **[[linden]]** important to calm the person down, accept what happened'),

  -- ── Hypertension ──────────────────────────────────────────
  (90, 'Linden — ingredient in a calming blend for hypertension: Linden, Hawthorn L+F, Motherwort, possibly Tulsi.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Hypertension', 160,
   '### Hypertension
- increased risk of heart attack, kidney disease, stroke
- kidneys, retina, brain are most affected, small capillaries
- dizziness, flushed, headaches, fatigue, nervousness, epistaxis
- sympathetic innervation affects the Renin Angiotensin/Aldosterone system
- CAUSES: stress, poor salts, age, heredity, obesity, lifestyle/diet

great calming blend -> ([[Linden]], [[Hawthorn]] L+F, maybe [[Motherwort]]
maybe bring in [[Tulsi]] as well)'),

  (1652, 'Hawthorn (leaf & flower) — ingredient in a calming blend for hypertension alongside Linden and Motherwort.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Hypertension', 170,
   '### Hypertension
- increased risk of heart attack, kidney disease, stroke
- kidneys, retina, brain are most affected, small capillaries
- dizziness, flushed, headaches, fatigue, nervousness, epistaxis
- sympathetic innervation affects the Renin Angiotensin/Aldosterone system
- CAUSES: stress, poor salts, age, heredity, obesity, lifestyle/diet

great calming blend -> ([[Linden]], [[Hawthorn]] L+F, maybe [[Motherwort]]
maybe bring in [[Tulsi]] as well)'),

  (131, 'Motherwort — ingredient in a calming blend for hypertension alongside Linden and Hawthorn L+F.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Hypertension', 180,
   '### Hypertension
- increased risk of heart attack, kidney disease, stroke
- kidneys, retina, brain are most affected, small capillaries
- dizziness, flushed, headaches, fatigue, nervousness, epistaxis
- sympathetic innervation affects the Renin Angiotensin/Aldosterone system
- CAUSES: stress, poor salts, age, heredity, obesity, lifestyle/diet

great calming blend -> ([[Linden]], [[Hawthorn]] L+F, maybe [[Motherwort]]
maybe bring in [[Tulsi]] as well)'),

  (13, 'Holy Basil (Tulsi) — suggested addition to a calming blend for hypertension with Linden, Hawthorn L+F, and Motherwort.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Hypertension', 190,
   '### Hypertension
- increased risk of heart attack, kidney disease, stroke
- kidneys, retina, brain are most affected, small capillaries
- dizziness, flushed, headaches, fatigue, nervousness, epistaxis
- sympathetic innervation affects the Renin Angiotensin/Aldosterone system
- CAUSES: stress, poor salts, age, heredity, obesity, lifestyle/diet

great calming blend -> ([[Linden]], [[Hawthorn]] L+F, maybe [[Motherwort]]
maybe bring in [[Tulsi]] as well)'),

  -- ── Heart Bypass Support ──────────────────────────────────
  (44, 'Yarrow — listed for heart bypass support; keeps the body calm so the brain signals more efficiently.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Heart Bypass Support', 200,
   '### Heart Bypass Support Herbs?
[[Yarrow]]
[[Cinnamon]]
[[Catnip]]
[[Skullcap]]
- keep the body calm so that the brain signals more efficiently
- also use [[alterative]] cleansing herbs
- maybe an [[adaptogen]]

### Tip:
- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things'),

  (167, 'Cinnamon — listed for heart bypass support; calming and nervine support.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Heart Bypass Support', 210,
   '### Heart Bypass Support Herbs?
[[Yarrow]]
[[Cinnamon]]
[[Catnip]]
[[Skullcap]]
- keep the body calm so that the brain signals more efficiently
- also use [[alterative]] cleansing herbs
- maybe an [[adaptogen]]

### Tip:
- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things'),

  (136, 'Catnip — listed for heart bypass support; calming so the brain signals more efficiently.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Heart Bypass Support', 220,
   '### Heart Bypass Support Herbs?
[[Yarrow]]
[[Cinnamon]]
[[Catnip]]
[[Skullcap]]
- keep the body calm so that the brain signals more efficiently
- also use [[alterative]] cleansing herbs
- maybe an [[adaptogen]]

### Tip:
- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things'),

  (142, 'Skullcap — listed for heart bypass support; calming so the brain signals more efficiently.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Heart Bypass Support', 230,
   '### Heart Bypass Support Herbs?
[[Yarrow]]
[[Cinnamon]]
[[Catnip]]
[[Skullcap]]
- keep the body calm so that the brain signals more efficiently
- also use [[alterative]] cleansing herbs
- maybe an [[adaptogen]]

### Tip:
- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things'),

  (90, 'Linden — "can do a lot of things"; highlighted as a versatile cardiovascular herb. Tip: don''t use a ton of herbs, find a few that cover most actions.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Heart Bypass Support', 240,
   '### Heart Bypass Support Herbs?
[[Yarrow]]
[[Cinnamon]]
[[Catnip]]
[[Skullcap]]
- keep the body calm so that the brain signals more efficiently
- also use [[alterative]] cleansing herbs
- maybe an [[adaptogen]]

### Tip:
- don''t use a ton of herbs - find a few that cover most actions
- [[Linden]] can do a lot of things'),

  -- ── Milky Oats ────────────────────────────────────────────
  (178, 'Milky Oats — trophorestorative for "crispy fried nerve endings"; for people who have lost their buffer or cushion and perceive pain/sounds in amplified ways. Milk is not soluble in water, only alcohol. Can be frozen.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Milky Oats', 250,
   'Milky [[Oats]]
- spring - milky
- milk is not soluble in water, only alcohol
- can freeze it if needed
- trophorestorative - for crispy fried nerve endings
    - people who have lost their buffer or cushion
    - perceive pain, sounds in more amplified way
- Mg good for kids with issues, [[catnip]], cal poppy
([[Oats|Oat straw]])
- main medicine is silica
- tissue restorative
(Oat groats)
- bulking [[laxative]]'),

  (2287, 'Oat Straw — main medicine is silica; tissue restorative.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Milky Oats', 260,
   'Milky [[Oats]]
- spring - milky
- milk is not soluble in water, only alcohol
- can freeze it if needed
- trophorestorative - for crispy fried nerve endings
    - people who have lost their buffer or cushion
    - perceive pain, sounds in more amplified way
- Mg good for kids with issues, [[catnip]], cal poppy
([[Oats|Oat straw]])
- main medicine is silica
- tissue restorative
(Oat groats)
- bulking [[laxative]]'),

  (128, 'California Poppy — listed alongside Magnesium and Catnip as helpful for children with nervous system issues.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Milky Oats', 270,
   'Milky [[Oats]]
- spring - milky
- milk is not soluble in water, only alcohol
- can freeze it if needed
- trophorestorative - for crispy fried nerve endings
    - people who have lost their buffer or cushion
    - perceive pain, sounds in more amplified way
- Mg good for kids with issues, [[catnip]], cal poppy
([[Oats|Oat straw]])
- main medicine is silica
- tissue restorative
(Oat groats)
- bulking [[laxative]]'),

  (136, 'Catnip — listed alongside Magnesium and California Poppy for children with nervous system issues.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Milky Oats', 280,
   'Milky [[Oats]]
- spring - milky
- milk is not soluble in water, only alcohol
- can freeze it if needed
- trophorestorative - for crispy fried nerve endings
    - people who have lost their buffer or cushion
    - perceive pain, sounds in more amplified way
- Mg good for kids with issues, [[catnip]], cal poppy
([[Oats|Oat straw]])
- main medicine is silica
- tissue restorative
(Oat groats)
- bulking [[laxative]]'),

  -- ── Energetics of Tea Blending ────────────────────────────
  (17, 'Schizandra — used as an energetics tea example; sour taste = moistening energetic quality.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetics of Tea Blending', 300,
   'Energetics Teas:
1: Schizandra
- sour = moistening
2: [[Damiana]]
- heating
3: [[Raspberry]]
- [[astringent]] = drying
4: [[Chamomile]]'),

  (144, 'Damiana — used as an energetics tea example; heating energetic quality.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetics of Tea Blending', 310,
   'Energetics Teas:
1: Schizandra
- sour = moistening
2: [[Damiana]]
- heating
3: [[Raspberry]]
- [[astringent]] = drying
4: [[Chamomile]]'),

  (155, 'Raspberry — used as an energetics tea example; astringent = drying energetic quality.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetics of Tea Blending', 320,
   'Energetics Teas:
1: Schizandra
- sour = moistening
2: [[Damiana]]
- heating
3: [[Raspberry]]
- [[astringent]] = drying
4: [[Chamomile]]'),

  (84, 'Chamomile — used as an energetics tea example; cooling energetic quality (implied by its anti-inflammatory, nervine properties).', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetics of Tea Blending', 330,
   'Energetics Teas:
1: Schizandra
- sour = moistening
2: [[Damiana]]
- heating
3: [[Raspberry]]
- [[astringent]] = drying
4: [[Chamomile]]'),

  -- ── Spices for Energetic Constitutions ───────────────────
  (2498, 'Black Pepper — recommended for Wet constitution; pungent, drying, stimulating digestion.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 340,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (91, 'Fenugreek — recommended for Wet and Dry constitutions; seeds and Methi leaf (backbone of curry blends) both useful.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 350,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (2637, 'Sumac — sour and moistening; antioxidant; good for Wet, Cold, and Dry constitutions. Not recommended if someone is congested.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 360,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (124, 'Ginger — fresh ginger for Wet and Dry constitutions; dry ginger much more heating, for Cold constitution.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 370,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (167, 'Cinnamon — listed as a spice for Wet and Cold constitutions.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 380,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (127, 'Cardamom — listed as a spice for Wet and Dry constitutions.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 390,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (420, 'Basil — listed as a spice for Cold and Dry constitutions; warming.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 400,
   '### Spices
- to help Wet:
    - [[Black Pepper]]
    - [[Fenugreek]]
    - Asafoetida
    - [[Sumac]]
    - [[Ginger]], fresh
    - [[Cinnamon]]
    - [[Cardamom]]
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida
- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]
- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut
- most people are kind of dry
    - [[sumac]] is kind of sour and moistening, good savory additive for a lot of things (not if someone is congested)
    - [[sumac]] also antioxidant'),

  (1595, 'Nutmeg — listed as a spice for Cold constitution; warming.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 410,
   '### Spices
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida'),

  (1546, 'Galangal — milder than ginger; listed as a spice for Cold constitution.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 420,
   '### Spices
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida'),

  (2636, 'Lemongrass — listed as a spice for Cold constitution; warming.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 430,
   '### Spices
- to help Cold:
    - [[Ginger]], dry - much more heating than fresh
    - [[Basil]]
    - [[Nutmeg]]
    - [[Galangal]] - milder than [[Ginger]]
    - [[Cinnamon]]
    - [[Lemongrass]]
    - [[Sumac]]
    - Asafoetida'),

  (76, 'Fennel — listed as a spice for Hot constitution; cooling. Part of the classic "Cumin, Coriander, Fennel" combo for inflamed conditions — "gives good tools to the gut."', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 440,
   '- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut'),

  (100, 'Coriander — listed as a spice for Hot constitution; cooling. Classic combo with Cumin and Fennel for inflamed conditions.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 450,
   '- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]
- Cumin [[Coriander]] [[Fennel]] = classic combo for inflamed conditions
    - gives good tools to the gut'),

  (55, 'Peppermint (Mint) — listed as a spice for Hot constitution; cooling.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 460,
   '- to help Hot:
    - [[Mint]]
    - [[Fennel]]
    - [[Coriander]]'),

  (66, 'Celery Seed — listed as a moistening spice for Dry constitution; "any tiny seeds help with hormone production" (Ayurveda).', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Spices for Energetic Constitutions', 470,
   '- to help Dry:
    - Celery seed - moistening
        - ayurveda -> any tiny seeds help with hormone production
    - [[Cardamom]]
    - Sumac
    - [[Basil]]
    - [[Ginger]], fresh
    - [[Fenugreek]]'),

  -- ── Energetic Herbs by Action (Recap) ────────────────────
  -- Warming
  (225, 'Astragalus — warming herb; indicated for poor circulation, slow digestion, constipation, low immunity, stagnation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 480,
   '### Recap
- when would you need **warming**?
    - poor circulation
    - slow digestion
    - fever
    - stiffness
    - constipation
    - low immunity
    - shock
    - stagnation
    - herbs:
        - [[Astragalus]]
        - [[Cinnamon]]
        - [[Damiana]]
        - [[Fennel]]
        - Sarsparilla
        - [[Ginger]]
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome
        - (most plants are cooling and drying)
- when would we need **cooling** herbs?
    - heartburn
    - diarrhea
    - fever
    - inflammation
    - endometriosis
    - IBS
    - Crohn''s
    - Colitis
    - Headache
    - herbs:
        - [[Marshmallow]] - heartburn
        - [[Blackberry]] Root - diarr
        - [[Yarrow]] - fever
        - [[Turmeric]] - inflammation, endometriosis
        - [[Catnip]] - headache
        - [[Burdock]] ("distributes moisture but is ultimately drying" - Tilgner) - endo.
- when would we need **drying** herbs?
    - congestion
    - yeast
    - slow metabolism
    - water retention
    - oily skin: liver/skin
    - bronchitis
    - herbs:
        - [[Osha]] - congestion
        - [[Black Walnut]], [[Goldenrod]]: yeast
        - Dry [[ginger]] - slow metab
        - [[Red root]] (**drying** [[lymphatic]]) - water retention
        - [[Oregon Grape Root]] - oily skin (berberines for liver)
        - [[Yerba santa]] (super drying) - bronchitis
- when would we need **moistening** herbs?
    - dehydration ->[[marshmallow]], okra
    - constipation -> [[Licorice root|licorice]], [[marshmallow]]
    - diarrhea (even a preventive, slowing down transit time) -> [[cinnamon]] [[cold infusion]] (low-key adaptogenic)
    - dry cough -> [[mullein]] flowers and roots (not hairy leaves), also [[Yerba mansa]] (Anemposis - stimulates immune function in the mucus membranes)
    - reproductive issues - dong quai (stim circ), white peony with [[Licorice root|licorice]]
    - dry skin - [[gotu kola]], [[calendula]]
    - adrenal fatigue - milky [[oats]]
    - dry gut - [[marshmallow]], [[yellow dock]], celery seed
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (167, 'Cinnamon — warming herb for poor circulation, slow digestion, stiffness, constipation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 490,
   '### Recap
- when would you need **warming**?
    - poor circulation
    - slow digestion
    - fever
    - stiffness
    - constipation
    - low immunity
    - shock
    - stagnation
    - herbs:
        - [[Astragalus]]
        - [[Cinnamon]]
        - [[Damiana]]
        - [[Fennel]]
        - Sarsparilla
        - [[Ginger]]
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome
        - (most plants are cooling and drying)
- when would we need **cooling** herbs?
    - heartburn
    - diarrhea
    - fever
    - inflammation
    - endometriosis
    - IBS
    - Crohn''s
    - Colitis
    - Headache
    - herbs:
        - [[Marshmallow]] - heartburn
        - [[Blackberry]] Root - diarr
        - [[Yarrow]] - fever
        - [[Turmeric]] - inflammation, endometriosis
        - [[Catnip]] - headache
        - [[Burdock]] ("distributes moisture but is ultimately drying" - Tilgner) - endo.
- when would we need **drying** herbs?
    - congestion
    - yeast
    - slow metabolism
    - water retention
    - oily skin: liver/skin
    - bronchitis
    - herbs:
        - [[Osha]] - congestion
        - [[Black Walnut]], [[Goldenrod]]: yeast
        - Dry [[ginger]] - slow metab
        - [[Red root]] (**drying** [[lymphatic]]) - water retention
        - [[Oregon Grape Root]] - oily skin (berberines for liver)
        - [[Yerba santa]] (super drying) - bronchitis
- when would we need **moistening** herbs?
    - dehydration ->[[marshmallow]], okra
    - constipation -> [[Licorice root|licorice]], [[marshmallow]]
    - diarrhea (even a preventive, slowing down transit time) -> [[cinnamon]] [[cold infusion]] (low-key adaptogenic)
    - dry cough -> [[mullein]] flowers and roots (not hairy leaves), also [[Yerba mansa]] (Anemposis - stimulates immune function in the mucus membranes)
    - reproductive issues - dong quai (stim circ), white peony with [[Licorice root|licorice]]
    - dry skin - [[gotu kola]], [[calendula]]
    - adrenal fatigue - milky [[oats]]
    - dry gut - [[marshmallow]], [[yellow dock]], celery seed
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (144, 'Damiana — warming herb; indicated for poor circulation, stagnation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 500,
   '### Recap
- when would you need **warming**?
    - poor circulation
    - slow digestion
    - fever
    - stiffness
    - constipation
    - low immunity
    - shock
    - stagnation
    - herbs:
        - [[Astragalus]]
        - [[Cinnamon]]
        - [[Damiana]]
        - [[Fennel]]
        - Sarsparilla
        - [[Ginger]]
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome
        - (most plants are cooling and drying)'),

  (76, 'Fennel — warming herb; indicated for poor circulation and digestive stagnation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 510,
   '### Recap
- when would you need **warming**?
    - poor circulation
    - slow digestion
    - fever
    - stiffness
    - constipation
    - low immunity
    - shock
    - stagnation
    - herbs:
        - [[Astragalus]]
        - [[Cinnamon]]
        - [[Damiana]]
        - [[Fennel]]
        - Sarsparilla
        - [[Ginger]]
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome
        - (most plants are cooling and drying)'),

  (40, 'Sarsaparilla — listed as a warming herb for poor circulation and stagnation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 520,
   '### Recap
- when would you need **warming**?
    - poor circulation
    - slow digestion
    - fever
    - stiffness
    - constipation
    - low immunity
    - shock
    - stagnation
    - herbs:
        - [[Astragalus]]
        - [[Cinnamon]]
        - [[Damiana]]
        - [[Fennel]]
        - Sarsparilla
        - [[Ginger]]
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome
        - (most plants are cooling and drying)'),

  (124, 'Ginger — warming herb for poor circulation and stagnation. Dry ginger is specifically drying for slow metabolism.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 530,
   '### Recap
- when would you need **warming**?
    - herbs:
        - [[Ginger]]
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome
- when would we need **drying** herbs?
    - herbs:
        - Dry [[ginger]] - slow metab'),

  (123, 'Prickly Ash — pungent, spicy warming herb; specifically indicated for Raynaud''s syndrome.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 540,
   '### Recap
- when would you need **warming**?
    - herbs:
        - [[Prickly Ash]] - pungent spicy - for Reynaud''s syndrome'),

  -- Cooling
  (45, 'Marshmallow — cooling herb; specifically indicated for heartburn. Also moistening: dehydration, constipation, dry gut.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 550,
   '- when would we need **cooling** herbs?
    - herbs:
        - [[Marshmallow]] - heartburn
- when would we need **moistening** herbs?
    - dehydration ->[[marshmallow]], okra
    - constipation -> [[Licorice root|licorice]], [[marshmallow]]
    - dry gut - [[marshmallow]], [[yellow dock]], celery seed'),

  (156, 'Blackberry Root — cooling herb; specifically indicated for diarrhea.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 560,
   '- when would we need **cooling** herbs?
    - herbs:
        - [[Blackberry]] Root - diarr'),

  (44, 'Yarrow — cooling herb; specifically indicated for fever.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 570,
   '- when would we need **cooling** herbs?
    - herbs:
        - [[Yarrow]] - fever'),

  (203, 'Turmeric — cooling anti-inflammatory herb; indicated for inflammation and endometriosis.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 580,
   '- when would we need **cooling** herbs?
    - herbs:
        - [[Turmeric]] - inflammation, endometriosis'),

  (136, 'Catnip — cooling herb; specifically indicated for headache. Also moistening for anxiety.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 590,
   '- when would we need **cooling** herbs?
    - herbs:
        - [[Catnip]] - headache
- when would we need **moistening** herbs?
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (22, 'Burdock — "distributes moisture but is ultimately drying" (Tilgner); cooling herb indicated for endometriosis.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 600,
   '- when would we need **cooling** herbs?
    - herbs:
        - [[Burdock]] ("distributes moisture but is ultimately drying" - Tilgner) - endo.'),

  -- Drying
  (104, 'Osha — drying herb; specifically indicated for congestion.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 610,
   '- when would we need **drying** herbs?
    - herbs:
        - [[Osha]] - congestion'),

  (288, 'Black Walnut — drying herb; indicated for yeast overgrowth.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 620,
   '- when would we need **drying** herbs?
    - herbs:
        - [[Black Walnut]], [[Goldenrod]]: yeast'),

  (58, 'Goldenrod — drying herb; indicated for yeast overgrowth.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 630,
   '- when would we need **drying** herbs?
    - herbs:
        - [[Black Walnut]], [[Goldenrod]]: yeast'),

  (981, 'Red Root — drying lymphatic herb; specifically indicated for water retention and lymphatic congestion.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 640,
   '- when would we need **drying** herbs?
    - herbs:
        - [[Red root]] (**drying** [[lymphatic]]) - water retention'),

  (33, 'Oregon Grape Root — drying herb; indicated for oily skin via berberines acting on the liver.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 650,
   '- when would we need **drying** herbs?
    - herbs:
        - [[Oregon Grape Root]] - oily skin (berberines for liver)'),

  (590, 'Yerba Santa — described as "super drying"; specifically indicated for bronchitis.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 660,
   '- when would we need **drying** herbs?
    - herbs:
        - [[Yerba santa]] (super drying) - bronchitis'),

  -- Moistening
  (78, 'Licorice — moistening herb; indicated for constipation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 670,
   '- when would we need **moistening** herbs?
    - constipation -> [[Licorice root|licorice]], [[marshmallow]]
    - reproductive issues - dong quai (stim circ), white peony with [[Licorice root|licorice]]'),

  (167, 'Cinnamon — moistening as a cold infusion; "low-key adaptogenic"; indicated for diarrhea as a preventive that slows transit time.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 680,
   '- when would we need **moistening** herbs?
    - diarrhea (even a preventive, slowing down transit time) -> [[cinnamon]] [[cold infusion]] (low-key adaptogenic)'),

  (61, 'Mullein — moistening; flowers and roots (not hairy leaves) for dry cough.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 690,
   '- when would we need **moistening** herbs?
    - dry cough -> [[mullein]] flowers and roots (not hairy leaves), also [[Yerba mansa]] (Anemposis - stimulates immune function in the mucus membranes)'),

  (309, 'Yerba Mansa (Anemopsis californica) — moistening; stimulates immune function in the mucus membranes; indicated for dry cough.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 700,
   '- when would we need **moistening** herbs?
    - dry cough -> [[mullein]] flowers and roots (not hairy leaves), also [[Yerba mansa]] (Anemposis - stimulates immune function in the mucus membranes)'),

  (1009, 'Dong Quai — moistening; indicated for reproductive issues from dry tissues; stimulates circulation.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 710,
   '- when would we need **moistening** herbs?
    - reproductive issues - dong quai (stim circ), white peony with [[Licorice root|licorice]]'),

  (2238, 'White Peony — used with licorice for moistening; indicated for reproductive issues from dry tissues.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 720,
   '- when would we need **moistening** herbs?
    - reproductive issues - dong quai (stim circ), white peony with [[Licorice root|licorice]]'),

  (2229, 'Gotu Kola — moistening; indicated for dry skin.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 730,
   '- when would we need **moistening** herbs?
    - dry skin - [[gotu kola]], [[calendula]]'),

  (70, 'Calendula — moistening; indicated for dry skin.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 740,
   '- when would we need **moistening** herbs?
    - dry skin - [[gotu kola]], [[calendula]]'),

  (178, 'Milky Oats — moistening; indicated for adrenal fatigue and anxiety.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 750,
   '- when would we need **moistening** herbs?
    - adrenal fatigue - milky [[oats]]
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (134, 'Lemon Balm — moistening; indicated for anxiety.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 760,
   '- when would we need **moistening** herbs?
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (225, 'Astragalus — moistening; indicated for anxiety.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 770,
   '- when would we need **moistening** herbs?
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (852, 'Shatavari — moistening; indicated for anxiety and reproductive issues from dry tissues.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 780,
   '- when would we need **moistening** herbs?
    - anxiety - milky [[oats]], [[catnip]], [[Databases/Herbs/Data/Lemon Balm|lemon balm]], [[astragalus]], shatavari'),

  (37, 'Yellow Dock — moistening; indicated for dry gut.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 790,
   '- when would we need **moistening** herbs?
    - dry gut - [[marshmallow]], [[yellow dock]], celery seed'),

  (66, 'Celery Seed — moistening; indicated for dry gut; noted in Ayurveda as hormone-supporting ("any tiny seeds help with hormone production").', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Energetic Herbs by Action', 800,
   '- when would we need **moistening** herbs?
    - dry gut - [[marshmallow]], [[yellow dock]], celery seed');

  -- Supplement snippet (Magnesium)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (21, 'Magnesium — listed with Catnip and California Poppy as helpful for children with nervous system issues.', 'BHC - Class 23 - Cardiovascular System 2 and Energetics', 'personal', 'Milky Oats', 290,
   'Milky [[Oats]]
- Mg good for kids with issues, [[catnip]], cal poppy');

END $$;

-- ============================================================
-- KEYWORDS
-- ============================================================

-- Adaptogens and CV Health
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (15, 'cardiovascular disease', 'ailment'),
  (15, 'blood sugar dysregulation', 'ailment'),
  (15, 'adaptogen', 'action'),
  (14, 'cardiovascular disease', 'ailment'),
  (14, 'anti-inflammatory', 'action'),
  (14, 'hyperlipidemia', 'ailment'),
  (9,  'cardiovascular disease', 'ailment'),
  (9,  'hyperlipidemia', 'ailment'),
  (9,  'thrombosis', 'ailment'),
  (9,  'adaptogen', 'action'),
  (11, 'hyperlipidemia', 'ailment'),
  (11, 'thrombosis', 'ailment'),
  (11, 'hypertension', 'ailment'),
  (11, 'cardiovascular disease', 'ailment'),
  (16, 'arrhythmia', 'ailment'),
  (16, 'hypertension', 'ailment'),
  (16, 'cardiovascular disease', 'ailment'),
  (16, 'stress', 'ailment'),
  (16, 'adaptogen', 'action'),
  (17, 'cardiovascular disease', 'ailment'),
  (17, 'liver support', 'ailment'),
  (17, 'stress', 'ailment'),
  (17, 'antioxidant', 'action'),
  (313,'cardiovascular disease', 'ailment'),
  (313,'circulation', 'ailment'),
  (2645,'cardiovascular disease', 'ailment'),
  (2645,'sedative', 'action'),
  (2233,'cardiovascular disease', 'ailment'),
  (2233,'hypertension', 'ailment'),
  (21, 'cardiovascular disease', 'ailment'),
  (21, 'hyperlipidemia', 'ailment'),
  (90, 'cardiovascular disease', 'ailment'),
  (90, 'hypertension', 'ailment'),
  (90, 'stroke recovery', 'ailment'),
  (90, 'anxiety', 'ailment'),
  (90, 'nervine', 'action'),
  (131,'cardiovascular disease', 'ailment'),
  (131,'hypertension', 'ailment'),
  (131,'arrhythmia', 'ailment'),
  (131,'palpitations', 'ailment'),
  -- Hypertension blend
  (1652,'hypertension', 'ailment'),
  (1652,'cardiovascular disease', 'ailment'),
  (13, 'hypertension', 'ailment'),
  (13, 'stress', 'ailment'),
  (13, 'adaptogen', 'action'),
  -- Heart Bypass Support
  (44, 'heart failure', 'ailment'),
  (44, 'cardiovascular disease', 'ailment'),
  (44, 'fever', 'symptom'),
  (167,'cardiovascular disease', 'ailment'),
  (167,'poor circulation', 'ailment'),
  (136,'headache', 'ailment'),
  (136,'anxiety', 'ailment'),
  (136,'nervine', 'action'),
  (142,'cardiovascular disease', 'ailment'),
  (142,'anxiety', 'ailment'),
  (142,'nervine', 'action'),
  -- Milky Oats
  (178,'adrenal fatigue', 'ailment'),
  (178,'anxiety', 'ailment'),
  (178,'nerve pain', 'ailment'),
  (178,'trophorestorative', 'action'),
  (2287,'connective tissue disorders', 'ailment'),
  (128,'anxiety', 'ailment'),
  (128,'sedative', 'action'),
  -- Energetics Teas
  (17, 'dry gut', 'ailment'),
  (144,'poor circulation', 'ailment'),
  (144,'low libido', 'ailment'),
  (155,'diarrhea', 'ailment'),
  (155,'astringent', 'action'),
  (84, 'anxiety', 'ailment'),
  (84, 'inflammation', 'ailment'),
  -- Spices
  (2637,'antioxidant', 'action'),
  (2637,'inflammation', 'ailment'),
  (76, 'inflammation', 'ailment'),
  (76, 'IBS', 'ailment'),
  (100,'inflammation', 'ailment'),
  (100,'digestive health', 'ailment'),
  (66, 'dry gut', 'ailment'),
  (66, 'hormonal support', 'ailment'),
  -- Energetic Herbs by Action
  (225,'poor circulation', 'ailment'),
  (225,'constipation', 'ailment'),
  (225,'immune support', 'ailment'),
  (225,'anxiety', 'ailment'),
  (167,'constipation', 'ailment'),
  (167,'diarrhea', 'ailment'),
  (167,'poor circulation', 'ailment'),
  (40, 'poor circulation', 'ailment'),
  (40, 'circulation', 'ailment'),
  (123,'Raynaud''s syndrome', 'ailment'),
  (123,'poor circulation', 'ailment'),
  (123,'circulatory stimulant', 'action'),
  (45, 'heartburn', 'ailment'),
  (45, 'constipation', 'ailment'),
  (45, 'dry gut', 'ailment'),
  (45, 'demulcent', 'action'),
  (156,'diarrhea', 'ailment'),
  (203,'inflammation', 'ailment'),
  (203,'endometriosis', 'ailment'),
  (22, 'endometriosis', 'ailment'),
  (104,'respiratory congestion', 'ailment'),
  (288,'yeast overgrowth', 'ailment'),
  (58, 'yeast overgrowth', 'ailment'),
  (981,'edema', 'ailment'),
  (981,'lymphatic support', 'ailment'),
  (981,'astringent', 'action'),
  (33, 'skin conditions', 'ailment'),
  (33, 'liver support', 'ailment'),
  (590,'bronchitis', 'ailment'),
  (590,'respiratory congestion', 'ailment'),
  (78, 'constipation', 'ailment'),
  (78, 'demulcent', 'action'),
  (61, 'chronic cough', 'ailment'),
  (61, 'demulcent', 'action'),
  (309,'mucous membrane support', 'ailment'),
  (309,'chronic cough', 'ailment'),
  (309,'immune support', 'ailment'),
  (1009,'reproductive support', 'ailment'),
  (1009,'poor circulation', 'ailment'),
  (2238,'reproductive support', 'ailment'),
  (2229,'skin conditions', 'ailment'),
  (70, 'skin conditions', 'ailment'),
  (134,'anxiety', 'ailment'),
  (134,'nervine', 'action'),
  (852,'anxiety', 'ailment'),
  (852,'reproductive support', 'ailment'),
  (37, 'dry gut', 'ailment'),
  (37, 'constipation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (21, 'anxiety', 'ailment'),
  (21, 'nervous system support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- AILMENT SEARCH TERMS (new keywords only)
-- ============================================================
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('arrhythmia',          ARRAY['irregular heartbeat', 'cardiac arrhythmia', 'heart rhythm disorder', 'atrial fibrillation', 'AFib']),
  ('atherosclerosis',     ARRAY['hardening of the arteries', 'arteriosclerosis', 'arterial plaque', 'coronary artery disease', 'atherosclerotic plaque']),
  ('angina',              ARRAY['chest pain', 'angina pectoris', 'chest tightness', 'coronary chest pain', 'cardiac chest pain']),
  ('Raynaud''s syndrome', ARRAY['Raynaud''s disease', 'Raynaud''s phenomenon', 'cold hands and feet', 'peripheral circulation disorder', 'vasospasm']),
  ('thrombosis',          ARRAY['blood clot', 'deep vein thrombosis', 'DVT', 'thrombus', 'clot formation', 'venous thrombosis']),
  ('heart attack',        ARRAY['myocardial infarction', 'MI', 'cardiac arrest', 'STEMI', 'NSTEMI', 'acute coronary syndrome']),
  ('palpitations',        ARRAY['heart palpitations', 'racing heart', 'fluttering heart', 'irregular pulse', 'heart flutter']),
  ('heart failure',       ARRAY['congestive heart failure', 'CHF', 'cardiac failure', 'heart insufficiency', 'left heart failure', 'right heart failure']),
  ('respiratory congestion', ARRAY['nasal congestion', 'chest congestion', 'phlegm', 'mucus congestion', 'congestion', 'upper respiratory congestion']),
  ('yeast overgrowth',    ARRAY['candida', 'candidiasis', 'yeast infection', 'fungal overgrowth', 'thrush', 'systemic candida'])
ON CONFLICT (ailment_keyword) DO NOTHING;
