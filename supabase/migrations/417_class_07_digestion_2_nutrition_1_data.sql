-- Migration 417: BHC Class 7 – Digestion II and Nutrition I
-- Parsed from: BHC - Class 7 - Digestion II and Nutrition I - Ashley Lisa.md (personal notes)
--
-- New herbs added:
--   Chaga (Inonotus obliquus, sclerotium) — absent from all five reference books
--   Dahhurian Angelica (Angelica dahurica, root) — absent from all five reference books
--
-- Herb name normalisations:
--   "Bikhail Skullcap" → Chinese Skullcap (Scutellaria baicalensis, id=2274)
--   "Dang gui" → Dong Quai (Angelica sinensis, id=1009)
--   "Marsh root" → Marshmallow (Althaea officinalis, id=45)
--   "Orange Peel / unripe green peel" (carminative / warming bitter) → Unripe Bitter Orange (id=1641)
--   "Archangelica" → Angelica (Angelica archangelica, id=65)
--   "red rasp" → Raspberry leaf (Rubus idaeus, id=155)
--   "Stoneroot (Collinsonia callidensis)" → Stoneroot (Collinsonia canadensis, id=182) — typo in notes
--
-- Skipped (formulae / foods / non-specific):
--   Triphala, Trikatu — Ayurvedic formula blends, not single herbs
--   Chia seed, Broccoli sprouts, Coconut yogurt — foods, not in DB
--   "Probiotics" — supplement category, not a specific DB supplement
--   Castor oil, honey, apple cider vinegar — preparations / foods
--   Coffee — food/beverage, no clinical herb context
--   Sesame Oil — food context only
--
-- Keyword merge decisions:
--   "uterus tonifying" (Shatavari) → existing "uterine tonic"
--   "immune boosting polysaccharide" (Ginger fresh form) → existing "immune support"
--   "master lymph mover" (Red Root) → existing "lymphatic support"
--   "blood thinning" (Red Root) → action "anticoagulant"
--   New ailment keywords introduced: bloating, pancreatitis, hypochlorhydria,
--     hyperchlorhydria, peptic ulcer, H. pylori infection

SET search_path TO herbal, public;

-- =====================================================================
-- NEW HERBS
-- =====================================================================
INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES
  ('Chaga', 'Inonotus obliquus', 'sclerotium'),
  ('Dahhurian Angelica', 'Angelica dahurica', 'root')
ON CONFLICT DO NOTHING;

UPDATE herbal.constituent_profiles cp
SET herb_id = h.id
FROM herbal.herbs h
WHERE cp.latin_name = h.latin_name
  AND cp.herb_id IS NULL
  AND h.latin_name IN ('Inonotus obliquus', 'Angelica dahurica');

-- =====================================================================
-- SNIPPETS
-- =====================================================================
DO $$
DECLARE
  v_chaga_id    INTEGER;
  v_dahurica_id INTEGER;
  v_class       CONSTANT TEXT := 'BHC - Class 7 - Digestion II and Nutrition I';

  -- source blocks (reused across multiple snippets in the same section)
  v_src_bloating TEXT := E'### Bloating\n- occurs when DS organs are stretched either by liquids or solids building up\n- Herbal Actions: Carminatives, Bitters\n    - Fennel Seed - bowl on the table!\n    - Chamomile\n    - Peppermint - tea after eating\n    - Cardamom - if correlation between NS and bloating\n        - Cardamom bitter in a glycerite\n        - infuse into honey and sweeten your tea!\n- use bitters before the meal and then carminatives after - help with bloating\n- extra water with food may "weaken the digestive fire"';

  v_src_nausea TEXT := E'### Nausea\n- Nausea is a protective mechanism to protect against toxic ingestion\n- Underlying causes can be the central NS (motion), the autonomic NS, gastric dysrhythmias, medications, surgery, etc\n- Anti nausea medications block 5-HT3 receptors (regulate gut motility and peristalsis)\n- Herbal actions for nausea: antiemetic, Carminative\n    - Lemon Balm\n    - Ginger - always prefer fresh for digestion - dry is superconcentrated heat\n        - fresh also has more immune boosting polysaccharide (demulcent action)\n        - dry has more diaphoretic\n    - Peppermint\n    - Chamomile\n    - (an emetic itself could be Lobelia)';

  v_src_diarrhea TEXT := E'### Diarrhea\n- Hot Damp Diarrhea: acute, burning and liquid, sharp pain, blood or mucus in stool, red tongue, fever, dehydration\n- Cold Damp Diarrhea: chronic, loose stools, undigested food particles, borborgymus, white coated tongue, abdominal distention\n\n- Diarrhea: Use Astringents\n    - Hot Damp Diarrhea herbs:\n        - Yellow Pond Lily Root (Hot Damp or sudden onset)\n        - Blackberry Root\n        - Oak Bark\n        - Red Root\n        - Chamomile - tea\n        - Goldenseal\n        - Bikhail Skullcap (Baikal/Chinese Skullcap)\n        - Garden Sage\n    - Cold Damp Diarrhea herbs:\n        - Cinnamon\n        - Ginger\n        - Myrrh - Eclectic physicians - use resins in small amount, 75%-90%\n        - Orange Peel - as a carminative, bloating or distention - the unripe green peel\n    - Myrrh + Goldenseal was a classic Eclectic pair for digestion';

  v_src_constipation TEXT := E'### Constipation\n- "atonic bowel" - bowel not contracting as it normally should\n- Cold Dry Constipation herbs:\n    - Dang gui (Dong Quai)\n    - Shatavari - Asparagus racemosas; adaptogen; uterus tonifying; helps moisten tissues - vagina and GI tract\n    - Fenugreek\n    - Licorice\n    - use herbs as decoction (roots, barks, seeds)\n- Hot Dry Constipation herbs (demulcents that are cooling):\n    - Marsh root (Marshmallow)\n    - Chia and Flax seed\n    - Calendula (not as mucilagenous as others)\n- Deficient or Laxative Dependent Constipation:\n    - Triphala\n    - Bulking laxatives, like Psyllium husk - caution to drink enough water\n    - Yellow Dock - aperient to soften\n    - can supplement with Magnesium\n        - Mg (bis)glycinate - 500mg/day\n        - bottom of feet spray; Epsom salt bath';

  v_src_pancreatitis TEXT := E'### Pancreatitis\n- inflammation of the pancreas; digestive enzymes attacking the pancreas\n- Herbs for Pancreatitis:\n    - Chaga - reduces inflammation; not medicinally active until heated\n    - Dandelion root\n    - Milk Thistle - eclectic remedy for swelling of pancreas; standardized extract or tincture\n    - Red Root (Ceanothus) - foamy tincture, very tannin-y; saponins in flowers and root; energetically moving; master lymph mover; can thin the blood in high HB/HS/blood lipids; medicinal if root is red\n    - Turmeric - inhibits pancreatic fibrosis, anti-inflammatory; "Curamed" by Terry''s Naturals - concentrated extract + frankincense for AI';

  v_src_gallstones TEXT := E'### Gallstones\n- Occur when cholesterol precipitates out of the bile\n- Risk factors: Birth control pills, high levels of triglycerides\n- Herbal treatment:\n    - Antilithics:\n        - Stoneroot (Collinsonia) - caution if stones are large\n    - Analgesics for spasm/acute pain:\n        - Wild Yam - anytime there is sharp spasmodic pain anywhere in the GI; can be both preventative and acute\n        - Corydalis + Dahhurian Angelica - "classic sacred pairing" in TCM; low dose herb - sleepy';

  v_src_hypochlorhydria TEXT := E'#### Hypochlorhydria\n- Symptoms: stomach pain or burning; excessive gas or belching; borborygmus; bloating; chronic diarrhea with undigested food particles; GERD; SIBO; IBS\n- Herbal treatment strategies:\n    - First: Marshmallow root, demulcents; Chamomile cold infusion; Slippery Elm powder, maybe in honey\n    - Combining of warming + cooling bitters in balanced formula\n    - Cooling bitters: Blue Vervain; Artichoke leaf; Dandelion root; Motherwort; Gentian (small doses); Hops; Mugwort; Wormwood\n    - Warming bitters: Angelica (Archangelica); Turmeric; Orange Peel (unripe); Fenugreek\n    - HCL Stimulating Herbs: Ginger - not during active flareup, but better longterm; Trikatu (three peppers)\n    - Carminatives: Calamus; Cardamom; Catnip; Lemon Balm; Cinnamon; Damiana; Rosemary; Lavender; Sage; Peppermint\n    - can dilute tinctures in water, or give as a tea (alcohol can irritate)';

  v_src_hyperchlorhydria TEXT := E'#### Hyperchlorhydria\n- Symptoms: Stomach pain or burning; little to no gas, belching, diarrhea\n- Diagnostic signs: red receding gums; pointed red tongue; younger\n- Herbal treatment:\n    - Cooling demulcents: Marshmallow, Slippery Elm\n    - Cooling GI Tonics & Nervines: Meadowsweet!! (upper GI always!); Chamomile; Lemon Balm; Licorice; Peach Leaf; Catnip';

  v_src_ulcers TEXT := E'#### Ulcers\n- Most common cause: H. Pylori (90% gastric, 80% duodenal)\n- Other causes: Stress, NSAIDs, Alcohol, Chewing Tobacco\n- Herbal treatment: inhibit H. Pylori; demulcents to heal GI tissue; digestive tonics and bitters\n- H. Pylori inhibiting herbs: Goldenseal; Cranberry; Cinnamon; Oregano; Sage; Turmeric; Clove; Olive Leaf; Artichoke leaf; Thyme; Ginger\n- Herbs to heal Gastric mucosa: Calendula; Goldenseal; Licorice; Gotu kola (anytime tissue is red hot irritated and inflamed); Marshmallow root; Myrrh; Turmeric; Yarrow\n- Important supplements: Probiotics; Fish oil; Broccoli sprouts';

  v_src_tea TEXT := E'## Ultra processed foods\n- filling the belly but not nourishing the tissues\n- nutrient-rich teas are a good support here\n    - rich in vits and mins and alkalizing to the gut\n    - optimum steep for 1-4 hours\n    - nettle\n    - red rasp\n    - alfalfa\n    - lemon balm\n    - red clover';

  v_src_micros TEXT := E'### Micronutrients\n- Vitamins: fat soluble (A D K) and water soluble (C B complex)\n- Minerals: macro (Ca Mg P) and micro (I Zn Fe)\n- Vitamin D: muscle integrity; Cardio; Bone health; to metabolize calcium; 70s is the optimum range; pretty rare to be K deficient; mail-in Vitamin D test\n- Vitamin A: easy to overdo it; much better to get through orange foods\n- Mg gets depleted by stress; specific for nervous system\n- Atlantic or Celtic gray salt - rich in Mg\n- Magnesium Citrate (Natural Calm): for the bowel cleanse; causes loose stools initially, keep taking until they stop; indicated for those who tend to dryness and constipation\n- Every day electrolyte: 1/4 tsp salt in pint of warm water every day - should taste minerally but not salty';

BEGIN
  SELECT id INTO v_chaga_id FROM herbal.herbs WHERE latin_name = 'Inonotus obliquus';
  SELECT id INTO v_dahurica_id FROM herbal.herbs WHERE latin_name = 'Angelica dahurica';

  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 7 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- -------- BLOATING --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (76,  'Fennel Seed - bowl on the table! (carminative for bloating)', v_class, 'personal', 'Bloating', 10, v_src_bloating),
    (84,  'Chamomile (carminative for bloating)', v_class, 'personal', 'Bloating', 20, v_src_bloating),
    (55,  'Peppermint - tea after eating (carminative for bloating)', v_class, 'personal', 'Bloating', 30, v_src_bloating),
    (127, 'Cardamom - if correlation between NS and bloating; Cardamom bitter in a glycerite; infuse into honey and sweeten your tea!', v_class, 'personal', 'Bloating', 40, v_src_bloating);

  -- -------- NAUSEA --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (134, 'Lemon Balm (antiemetic, carminative for nausea)', v_class, 'personal', 'Nausea', 50, v_src_nausea),
    (124, 'Ginger - always prefer fresh for digestion; dry is superconcentrated heat; fresh has more immune boosting polysaccharide (demulcent action); dry has more diaphoretic', v_class, 'personal', 'Nausea', 60, v_src_nausea),
    (55,  'Peppermint (antiemetic, carminative for nausea)', v_class, 'personal', 'Nausea', 70, v_src_nausea),
    (84,  'Chamomile (antiemetic, carminative for nausea)', v_class, 'personal', 'Nausea', 80, v_src_nausea),
    (132, 'Lobelia - an emetic itself (not antiemetic); mentioned as contrast herb in nausea section', v_class, 'personal', 'Nausea', 90, v_src_nausea);

  -- -------- DIARRHEA --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (2627, 'Yellow Pond Lily Root - for Hot Damp Diarrhea or sudden onset (astringent)', v_class, 'personal', 'Diarrhea', 100, v_src_diarrhea),
    (156,  'Blackberry Root (astringent for Hot Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 110, v_src_diarrhea),
    (153,  'Oak Bark (astringent for Hot Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 120, v_src_diarrhea),
    (981,  'Red Root (astringent for Hot Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 130, v_src_diarrhea),
    (84,   'Chamomile tea (for Hot Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 140, v_src_diarrhea),
    (30,   'Goldenseal (for Hot Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 150, v_src_diarrhea),
    (2274, 'Bikhail Skullcap (Baikal/Chinese Skullcap) - for Hot Damp Diarrhea', v_class, 'personal', 'Diarrhea', 160, v_src_diarrhea),
    (56,   'Garden Sage (astringent for Hot Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 170, v_src_diarrhea),
    (167,  'Cinnamon (for Cold Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 180, v_src_diarrhea),
    (124,  'Ginger (for Cold Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 190, v_src_diarrhea),
    (99,   'Myrrh - Eclectic physicians - use resins in small amount, 75%-90% alcohol (for Cold Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 200, v_src_diarrhea),
    (1641, 'Orange Peel (unripe green peel) - as a carminative for bloating or distention (for Cold Damp Diarrhea)', v_class, 'personal', 'Diarrhea', 210, v_src_diarrhea);

  -- -------- CONSTIPATION --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (1009, 'Dang gui (Dong Quai) - for Cold Dry Constipation; use as decoction', v_class, 'personal', 'Constipation', 220, v_src_constipation),
    (852,  'Shatavari (Asparagus racemosus) - for Cold Dry Constipation; adaptogen; uterus tonifying; helps moisten tissues - vagina and GI tract', v_class, 'personal', 'Constipation', 230, v_src_constipation),
    (91,   'Fenugreek - for Cold Dry Constipation; use as decoction', v_class, 'personal', 'Constipation', 240, v_src_constipation),
    (78,   'Licorice - for Cold Dry Constipation; use as decoction', v_class, 'personal', 'Constipation', 250, v_src_constipation),
    (45,   'Marshmallow root (Marsh root) - demulcent cooling herb for Hot Dry Constipation', v_class, 'personal', 'Constipation', 260, v_src_constipation),
    (180,  'Flax seed - demulcent cooling herb for Hot Dry Constipation', v_class, 'personal', 'Constipation', 270, v_src_constipation),
    (70,   'Calendula - for Hot Dry Constipation (not as mucilaginous as others)', v_class, 'personal', 'Constipation', 280, v_src_constipation),
    (2240, 'Psyllium husk - bulking laxative for Deficient/Laxative Dependent Constipation; caution: drink enough water', v_class, 'personal', 'Constipation', 290, v_src_constipation),
    (37,   'Yellow Dock - aperient to soften stool; for Deficient/Laxative Dependent Constipation', v_class, 'personal', 'Constipation', 300, v_src_constipation);

  -- -------- CONSTIPATION — SUPPLEMENT --------
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (21, 'Magnesium (Mg bisglycinate) - 500mg/day for Deficient Constipation; also bottom-of-feet spray or Epsom salt bath; Magnesium Citrate (Natural Calm) causes loose stools initially, continue until stools normalize', v_class, 'personal', 'Constipation', 310, v_src_constipation);

  -- -------- PANCREATITIS --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_chaga_id, 'Chaga - reduces inflammation in pancreatitis; not medicinally active until heated', v_class, 'personal', 'Pancreatitis', 320, v_src_pancreatitis),
    (122,        'Dandelion root (for pancreatitis)', v_class, 'personal', 'Pancreatitis', 330, v_src_pancreatitis),
    (206,        'Milk Thistle - eclectic remedy for swelling of pancreas; use standardized extract or tincture', v_class, 'personal', 'Pancreatitis', 340, v_src_pancreatitis),
    (981,        'Red Root (Ceanothus) - foamy tincture, very tannin-y; saponins in flowers and root; energetically moving; master lymph mover, whole body; can thin the blood (high HB, HS, blood lipids); if the root is red, it is medicinal', v_class, 'personal', 'Pancreatitis', 350, v_src_pancreatitis),
    (203,        'Turmeric - inhibits pancreatic fibrosis, anti-inflammatory; "Curamed" by Terry''s Naturals - concentrated extract + frankincense for AI', v_class, 'personal', 'Pancreatitis', 360, v_src_pancreatitis),
    (1597,       'Frankincense - combined with Turmeric in "Curamed" for anti-inflammatory support in pancreatitis', v_class, 'personal', 'Pancreatitis', 370, v_src_pancreatitis);

  -- -------- GALLSTONES --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (182,         'Stoneroot (Collinsonia canadensis) - antilithic for gallstones; caution if stones are large (analgesics may be needed)', v_class, 'personal', 'Gallstones', 380, v_src_gallstones),
    (74,          'Wild Yam - analgesic for sharp spasmodic GI pain; useful acutely and preventively for gallstone spasm', v_class, 'personal', 'Gallstones', 390, v_src_gallstones),
    (2228,        'Corydalis - "classic sacred pairing" with Dahhurian Angelica in TCM for gallstone/biliary pain; low dose, causes drowsiness', v_class, 'personal', 'Gallstones', 400, v_src_gallstones),
    (v_dahurica_id, 'Dahhurian Angelica - "classic sacred pairing" with Corydalis in TCM for gallstone/biliary pain; low dose, causes drowsiness', v_class, 'personal', 'Gallstones', 410, v_src_gallstones);

  -- -------- HYPOCHLORHYDRIA --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (45,   'Marshmallow root - demulcent first-line for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 420, v_src_hypochlorhydria),
    (84,   'Chamomile - cold infusion for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 430, v_src_hypochlorhydria),
    (92,   'Slippery Elm powder - maybe in honey; first-line demulcent for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 440, v_src_hypochlorhydria),
    (983,  'Blue Vervain - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 450, v_src_hypochlorhydria),
    (172,  'Artichoke leaf - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 460, v_src_hypochlorhydria),
    (122,  'Dandelion root - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 470, v_src_hypochlorhydria),
    (131,  'Motherwort - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 480, v_src_hypochlorhydria),
    (102,  'Gentian - cooling bitter for hypochlorhydria; use in small doses', v_class, 'personal', 'Hypochlorhydria', 490, v_src_hypochlorhydria),
    (129,  'Hops - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 500, v_src_hypochlorhydria),
    (115,  'Mugwort - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 510, v_src_hypochlorhydria),
    (97,   'Wormwood - cooling bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 520, v_src_hypochlorhydria),
    (65,   'Angelica (Archangelica) - warming bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 530, v_src_hypochlorhydria),
    (203,  'Turmeric - warming bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 540, v_src_hypochlorhydria),
    (1641, 'Orange Peel (unripe, warming bitter) for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 550, v_src_hypochlorhydria),
    (91,   'Fenugreek - warming bitter for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 560, v_src_hypochlorhydria),
    (124,  'Ginger - HCL stimulating herb for hypochlorhydria; not during active flareup, but better long-term', v_class, 'personal', 'Hypochlorhydria', 570, v_src_hypochlorhydria),
    (2752, 'Calamus - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 580, v_src_hypochlorhydria),
    (127,  'Cardamom - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 590, v_src_hypochlorhydria),
    (136,  'Catnip - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 600, v_src_hypochlorhydria),
    (134,  'Lemon Balm - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 610, v_src_hypochlorhydria),
    (167,  'Cinnamon - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 620, v_src_hypochlorhydria),
    (144,  'Damiana - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 630, v_src_hypochlorhydria),
    (109,  'Rosemary - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 640, v_src_hypochlorhydria),
    (82,   'Lavender - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 650, v_src_hypochlorhydria),
    (56,   'Sage - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 660, v_src_hypochlorhydria),
    (55,   'Peppermint - carminative for hypochlorhydria', v_class, 'personal', 'Hypochlorhydria', 670, v_src_hypochlorhydria);

  -- -------- HYPERCHLORHYDRIA --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (45,  'Marshmallow - cooling demulcent for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 680, v_src_hyperchlorhydria),
    (92,  'Slippery Elm - cooling demulcent for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 690, v_src_hyperchlorhydria),
    (75,  'Meadowsweet - cooling GI tonic for hyperchlorhydria; upper GI always!', v_class, 'personal', 'Hyperchlorhydria', 700, v_src_hyperchlorhydria),
    (84,  'Chamomile - cooling GI tonic and nervine for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 710, v_src_hyperchlorhydria),
    (134, 'Lemon Balm - cooling GI tonic and nervine for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 720, v_src_hyperchlorhydria),
    (78,  'Licorice - cooling GI tonic for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 730, v_src_hyperchlorhydria),
    (320, 'Peach Leaf - cooling GI tonic and nervine for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 740, v_src_hyperchlorhydria),
    (136, 'Catnip - cooling GI tonic and nervine for hyperchlorhydria', v_class, 'personal', 'Hyperchlorhydria', 750, v_src_hyperchlorhydria);

  -- -------- ULCERS (H. pylori inhibiting) --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (30,   'Goldenseal - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 760, v_src_ulcers),
    (1212, 'Cranberry - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 770, v_src_ulcers),
    (167,  'Cinnamon - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 780, v_src_ulcers),
    (406,  'Oregano - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 790, v_src_ulcers),
    (56,   'Sage - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 800, v_src_ulcers),
    (203,  'Turmeric - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 810, v_src_ulcers),
    (111,  'Clove - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 820, v_src_ulcers),
    (106,  'Olive Leaf - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 830, v_src_ulcers),
    (172,  'Artichoke leaf - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 840, v_src_ulcers),
    (59,   'Thyme - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 850, v_src_ulcers),
    (124,  'Ginger - inhibits H. pylori (peptic ulcer)', v_class, 'personal', 'Ulcers', 860, v_src_ulcers);

  -- -------- ULCERS (healing gastric mucosa) --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (70,   'Calendula - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 870, v_src_ulcers),
    (30,   'Goldenseal - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 880, v_src_ulcers),
    (78,   'Licorice - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 890, v_src_ulcers),
    (2229, 'Gotu Kola - heals gastric mucosa; anytime tissue is red, hot, irritated and inflamed (peptic ulcer)', v_class, 'personal', 'Ulcers', 900, v_src_ulcers),
    (45,   'Marshmallow root - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 910, v_src_ulcers),
    (99,   'Myrrh - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 920, v_src_ulcers),
    (203,  'Turmeric - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 930, v_src_ulcers),
    (44,   'Yarrow - heals gastric mucosa (peptic ulcer)', v_class, 'personal', 'Ulcers', 940, v_src_ulcers);

  -- -------- ULCERS — SUPPLEMENT --------
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (33, 'Fish oil (Omega-3) - important supplement for peptic ulcer support; favorite brand "Designs for Health, Omega Avail"; find algae-based for vegans', v_class, 'personal', 'Ulcers', 950, v_src_ulcers);

  -- -------- NUTRIENT-RICH TEAS (Ultra Processed Foods section) --------
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (43,  'Nettle - nutrient-rich tea; rich in vitamins and minerals, alkalizing to the gut; optimum steep 1-4 hours', v_class, 'personal', 'Ultra Processed Foods', 960, v_src_tea),
    (885, 'Alfalfa - nutrient-rich tea; rich in vitamins and minerals, alkalizing to the gut; optimum steep 1-4 hours', v_class, 'personal', 'Ultra Processed Foods', 970, v_src_tea),
    (134, 'Lemon Balm - nutrient-rich tea; rich in vitamins and minerals, alkalizing to the gut', v_class, 'personal', 'Ultra Processed Foods', 980, v_src_tea),
    (42,  'Red Clover - nutrient-rich tea; rich in vitamins and minerals, alkalizing to the gut', v_class, 'personal', 'Ultra Processed Foods', 990, v_src_tea),
    (155, 'Raspberry (red raspberry leaf) - nutrient-rich tea; rich in vitamins and minerals, alkalizing to the gut', v_class, 'personal', 'Ultra Processed Foods', 1000, v_src_tea);

  -- -------- MICRONUTRIENTS — SUPPLEMENTS --------
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (11, 'Vitamin D - muscle integrity, cardiovascular health, bone health, calcium metabolism; optimum range is 70s; most people test in 30s; mail-in test available', v_class, 'personal', 'Micronutrients', 1010, v_src_micros),
    (21, 'Magnesium - depleted by stress; specific for nervous system; Atlantic or Celtic gray salt rich in Mg; electrolyte: 1/4 tsp salt in pint of warm water daily', v_class, 'personal', 'Micronutrients', 1020, v_src_micros);

  RAISE NOTICE 'Class 7 snippets loaded successfully.';
END $$;

-- =====================================================================
-- HERB KEYWORDS
-- =====================================================================

-- Bloating herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (76,  'bloating', 'ailment'),
  (76,  'carminative', 'action'),
  (76,  'digestive health', 'ailment'),
  (84,  'bloating', 'ailment'),
  (84,  'nausea', 'ailment'),
  (84,  'diarrhea', 'ailment'),
  (84,  'hypochlorhydria', 'ailment'),
  (84,  'hyperchlorhydria', 'ailment'),
  (84,  'carminative', 'action'),
  (84,  'digestive health', 'ailment'),
  (55,  'bloating', 'ailment'),
  (55,  'nausea', 'ailment'),
  (55,  'hypochlorhydria', 'ailment'),
  (55,  'carminative', 'action'),
  (127, 'bloating', 'ailment'),
  (127, 'hypochlorhydria', 'ailment'),
  (127, 'carminative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nausea herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (134, 'nausea', 'ailment'),
  (134, 'hypochlorhydria', 'ailment'),
  (134, 'hyperchlorhydria', 'ailment'),
  (134, 'carminative', 'action'),
  (134, 'microbiome support', 'ailment'),
  (124, 'nausea', 'ailment'),
  (124, 'diarrhea', 'ailment'),
  (124, 'hypochlorhydria', 'ailment'),
  (124, 'H. pylori infection', 'ailment'),
  (124, 'peptic ulcer', 'ailment'),
  (124, 'carminative', 'action'),
  (124, 'demulcent', 'action'),
  (124, 'diaphoretic', 'action'),
  (132, 'nausea', 'ailment'),
  (132, 'antiemetic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Diarrhea herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2627, 'diarrhea', 'ailment'),
  (2627, 'astringent', 'action'),
  (156,  'diarrhea', 'ailment'),
  (156,  'astringent', 'action'),
  (153,  'diarrhea', 'ailment'),
  (153,  'astringent', 'action'),
  (981,  'diarrhea', 'ailment'),
  (981,  'pancreatitis', 'ailment'),
  (981,  'lymphatic support', 'action'),
  (981,  'anticoagulant', 'action'),
  (2274, 'diarrhea', 'ailment'),
  (2274, 'astringent', 'action'),
  (56,   'diarrhea', 'ailment'),
  (56,   'H. pylori infection', 'ailment'),
  (56,   'peptic ulcer', 'ailment'),
  (56,   'astringent', 'action'),
  (56,   'carminative', 'action'),
  (167,  'diarrhea', 'ailment'),
  (167,  'hypochlorhydria', 'ailment'),
  (167,  'H. pylori infection', 'ailment'),
  (167,  'peptic ulcer', 'ailment'),
  (167,  'carminative', 'action'),
  (99,   'diarrhea', 'ailment'),
  (99,   'peptic ulcer', 'ailment'),
  (99,   'astringent', 'action'),
  (99,   'antimicrobial', 'action'),
  (1641, 'diarrhea', 'ailment'),
  (1641, 'bloating', 'ailment'),
  (1641, 'hypochlorhydria', 'ailment'),
  (1641, 'carminative', 'action'),
  (1641, 'bitter', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Constipation herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1009, 'constipation', 'ailment'),
  (852,  'constipation', 'ailment'),
  (852,  'uterine tonic', 'action'),
  (852,  'adaptogen', 'action'),
  (852,  'demulcent', 'action'),
  (91,   'constipation', 'ailment'),
  (91,   'hypochlorhydria', 'ailment'),
  (91,   'bitter', 'action'),
  (78,   'constipation', 'ailment'),
  (78,   'hyperchlorhydria', 'ailment'),
  (78,   'peptic ulcer', 'ailment'),
  (78,   'demulcent', 'action'),
  (45,   'constipation', 'ailment'),
  (45,   'hypochlorhydria', 'ailment'),
  (45,   'hyperchlorhydria', 'ailment'),
  (45,   'peptic ulcer', 'ailment'),
  (45,   'demulcent', 'action'),
  (180,  'constipation', 'ailment'),
  (70,   'constipation', 'ailment'),
  (70,   'peptic ulcer', 'ailment'),
  (70,   'vulnerary', 'action'),
  (2240, 'constipation', 'ailment'),
  (37,   'constipation', 'ailment'),
  (37,   'aperient', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Constipation supplement
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (21, 'constipation', 'ailment'),
  (21, 'mineral support', 'ailment'),
  (21, 'nervous system support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Pancreatitis herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('pancreatitis', 'ailment'),
  ('anti-inflammatory', 'action'),
  ('immune support', 'ailment')
) AS kw(keyword, category)
WHERE h.latin_name = 'Inonotus obliquus'
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (122,  'pancreatitis', 'ailment'),
  (122,  'digestive tonic', 'ailment'),
  (122,  'liver support', 'ailment'),
  (206,  'pancreatitis', 'ailment'),
  (206,  'digestive health', 'ailment'),
  (203,  'pancreatitis', 'ailment'),
  (203,  'H. pylori infection', 'ailment'),
  (203,  'peptic ulcer', 'ailment'),
  (203,  'anti-inflammatory', 'action'),
  (203,  'anti-fibrotic', 'action'),
  (1597, 'pancreatitis', 'ailment'),
  (1597, 'anti-inflammatory', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gallstones herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (182,  'gallstones', 'ailment'),
  (182,  'antilithic', 'action'),
  (74,   'gallstones', 'ailment'),
  (74,   'muscle spasms', 'ailment'),
  (74,   'antispasmodic', 'action'),
  (2228, 'gallstones', 'ailment'),
  (2228, 'analgesic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('gallstones', 'ailment'),
  ('analgesic', 'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Angelica dahurica'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hypochlorhydria herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (92,  'hypochlorhydria', 'ailment'),
  (92,  'hyperchlorhydria', 'ailment'),
  (92,  'peptic ulcer', 'ailment'),
  (92,  'demulcent', 'action'),
  (983, 'hypochlorhydria', 'ailment'),
  (983, 'bitter', 'action'),
  (172, 'hypochlorhydria', 'ailment'),
  (172, 'H. pylori infection', 'ailment'),
  (172, 'peptic ulcer', 'ailment'),
  (172, 'bitter', 'action'),
  (172, 'digestive tonic', 'ailment'),
  (131, 'hypochlorhydria', 'ailment'),
  (131, 'bitter', 'action'),
  (102, 'hypochlorhydria', 'ailment'),
  (102, 'bitter', 'action'),
  (102, 'digestive tonic', 'ailment'),
  (129, 'hypochlorhydria', 'ailment'),
  (129, 'bitter', 'action'),
  (115, 'hypochlorhydria', 'ailment'),
  (115, 'bitter', 'action'),
  (97,  'hypochlorhydria', 'ailment'),
  (97,  'bitter', 'action'),
  (65,  'hypochlorhydria', 'ailment'),
  (65,  'bitter', 'action'),
  (65,  'carminative', 'action'),
  (2752,'hypochlorhydria', 'ailment'),
  (2752,'carminative', 'action'),
  (136, 'hypochlorhydria', 'ailment'),
  (136, 'hyperchlorhydria', 'ailment'),
  (136, 'carminative', 'action'),
  (144, 'hypochlorhydria', 'ailment'),
  (144, 'carminative', 'action'),
  (109, 'hypochlorhydria', 'ailment'),
  (109, 'carminative', 'action'),
  (82,  'hypochlorhydria', 'ailment'),
  (82,  'carminative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hyperchlorhydria herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (75,  'hyperchlorhydria', 'ailment'),
  (75,  'digestive health', 'ailment'),
  (75,  'anti-inflammatory', 'action'),
  (75,  'peptic ulcer', 'ailment'),
  (320, 'hyperchlorhydria', 'ailment'),
  (320, 'nervine', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ulcers herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (30,   'H. pylori infection', 'ailment'),
  (30,   'peptic ulcer', 'ailment'),
  (1212, 'H. pylori infection', 'ailment'),
  (1212, 'peptic ulcer', 'ailment'),
  (406,  'H. pylori infection', 'ailment'),
  (406,  'peptic ulcer', 'ailment'),
  (406,  'antimicrobial', 'action'),
  (111,  'H. pylori infection', 'ailment'),
  (111,  'peptic ulcer', 'ailment'),
  (111,  'antimicrobial', 'action'),
  (106,  'H. pylori infection', 'ailment'),
  (106,  'peptic ulcer', 'ailment'),
  (106,  'antimicrobial', 'action'),
  (59,   'H. pylori infection', 'ailment'),
  (59,   'peptic ulcer', 'ailment'),
  (59,   'antimicrobial', 'action'),
  (70,   'H. pylori infection', 'ailment'),
  (2229, 'peptic ulcer', 'ailment'),
  (2229, 'vulnerary', 'action'),
  (99,   'H. pylori infection', 'ailment'),
  (44,   'peptic ulcer', 'ailment'),
  (44,   'vulnerary', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ulcers supplement
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (33, 'peptic ulcer', 'ailment'),
  (33, 'inflammation', 'ailment'),
  (33, 'anti-inflammatory', 'action')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Nutrient-rich teas
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43,  'microbiome support', 'ailment'),
  (43,  'mineral support', 'ailment'),
  (43,  'nutritive', 'action'),
  (885, 'microbiome support', 'ailment'),
  (885, 'mineral support', 'ailment'),
  (885, 'nutritive', 'action'),
  (42,  'microbiome support', 'ailment'),
  (42,  'nutritive', 'action'),
  (155, 'microbiome support', 'ailment'),
  (155, 'mineral support', 'ailment'),
  (155, 'nutritive', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Micronutrient supplements
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (11, 'bone density', 'ailment'),
  (11, 'mineral support', 'ailment'),
  (11, 'cardiovascular disease', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- =====================================================================
-- AILMENT SEARCH SYNONYMS (new ailment keywords only)
-- =====================================================================
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('bloating',
   ARRAY['abdominal bloating', 'gas and bloating', 'distension', 'abdominal distention', 'flatulence', 'gassiness']),
  ('pancreatitis',
   ARRAY['inflamed pancreas', 'pancreatic inflammation', 'acute pancreatitis', 'chronic pancreatitis', 'pancreas swelling']),
  ('hypochlorhydria',
   ARRAY['low stomach acid', 'achlorhydria', 'insufficient stomach acid', 'low HCl', 'digestive acid insufficiency', 'GERD']),
  ('hyperchlorhydria',
   ARRAY['excess stomach acid', 'high stomach acid', 'excess HCl', 'acid overproduction', 'gastric hyperacidity']),
  ('peptic ulcer',
   ARRAY['gastric ulcer', 'duodenal ulcer', 'stomach ulcer', 'H. pylori ulcer', 'gastric ulceration', 'ulceration']),
  ('H. pylori infection',
   ARRAY['Helicobacter pylori', 'H pylori', 'helicobacter', 'h pylori infection', 'bacterial gastric infection']),
  ('digestive health',
   ARRAY['digestive support', 'gut health', 'GI health', 'gastrointestinal health', 'digestive wellness'])
ON CONFLICT (ailment_keyword) DO NOTHING;
