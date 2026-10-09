-- Migration 361: Class 73 – Blood Sugar and Stroke Case Study Presentations (data)
-- Source files parsed:
--   BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations - Generated Notes.md
--   BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations - Ashley Shereel.md
--   (Transcript ignored per playbook)
--
-- New herbs added:
--   Nigella sativa (Black Seed)       — absent from all 5 reference books
--   Opuntia spp. (Prickly Pear/Nopal) — in MM (fresh juice/flowers) and Easley's (energetics + capsule dose)
--   Theobroma cacao (Cacao)           — in Stockley's pages 148–150 (drug interactions via flavonoids + theobromine)
--   Dioscorea opposita (Chinese Yam)  — absent from all 5 reference books
--
-- NOTE: After migration 361 is run, extract Theobroma cacao herb_id and:
--   1. Copy /tmp/stockleys_cocoa/page_0*.jpg to public/contraindications/{herb_id}/
--   2. Add {herb_id}: 3 entry to lib/contraindications-manifest.ts
--
-- Normalizations:
--   "Eleuthero"                       → Siberian Ginseng (Eleutherococcus senticosus, id=9)
--   "Panax Ginseng" / "Asian Ginseng" → Ginseng (Panax ginseng, id=14)
--   "American Ginseng" / "Panax Quinquefolius" → American Ginseng (id=15)
--   "Oregon Grape Root" / "OGR"       → Oregon Grape (Mahonia aquifolium, id=33)
--   "Blueberry/Huckleberry Leaf"      → Bilberry (Vaccinium myrtillus, id=1160)
--   "Goji Berry" / "Lycium barbarum"  → Wolfberry Fruit (Fructus Lycii Chinensis, id=1548)
--   "Tulsi"                           → Holy Basil (Ocimum sanctum, id=13)
--   "AI" = anti-inflammatory
--
-- Skipped:
--   Actaea Spicata (Baneberry) — generated notes error; Actaea spicata is highly toxic; personal
--     notes correctly use Guduchi (Tinospora cordifolia) for the same cooling/anti-inflammatory picture
--   Blue Lotus — only in euphoric formula list in case study; not a primary teaching herb; not in DB
--   ACV, chia seed, bone broth, Greek yogurt — foods, not in herbs/supplements DB

SET search_path TO herbal, public;

-- ─── Ensure new herbs exist ─────────────────────────────────────────────────

INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
VALUES
  ('Nigella (Black Seed)', 'Nigella sativa', 'seed',
   ARRAY['Black Seed', 'Black Cumin', 'Kalonji', 'Blessed Seed', 'Habbatus Sauda', 'Love in a Mist']),
  ('Prickly Pear (Nopal)', 'Opuntia spp.', 'pad, fruit, flower',
   ARRAY['Nopal', 'Cactus Pear', 'Prickly Pear Cactus', 'Tuna', 'Nopal Cactus']),
  ('Cacao', 'Theobroma cacao', 'seed',
   ARRAY['Chocolate', 'Cocoa', 'Chocolate Tree', 'Dark Chocolate', 'Theobroma']),
  ('Chinese Yam', 'Dioscorea opposita', 'root',
   ARRAY['Shan Yao', 'Huai Shan', 'Nagaimo', 'Japanese Mountain Yam'])
ON CONFLICT DO NOTHING;

-- Add Opuntia energetics from Easley's (cooling and moistening)
UPDATE herbal.herbs
SET temperature = 'cooling', temperature_inferred = false,
    moisture    = 'moistening', moisture_inferred = false
WHERE latin_name = 'Opuntia spp.'
  AND temperature IS NULL;

-- ─── Snippets ───────────────────────────────────────────────────────────────

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations') THEN
    RAISE NOTICE 'Class 73 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ══════════════════════════════════════════════════════════════════════════
  -- GENERATED NOTES
  -- ══════════════════════════════════════════════════════════════════════════

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Supplement Recommendations (generated) ──────────────────────────────────
  (49,
   'B vitamins essential for glucose metabolism.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 10,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (21,
   'Magnesium citrate or glycinate: 400 to 600 milligrams range for blood sugar support.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 20,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (24,
   'Zinc important for blood sugar and thyroid health.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 30,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (16,
   'Chromium picolinate: typical 400 micrograms dose, safe up to 800 micrograms — helps the docking of insulin to receptor sites.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 40,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (12,
   'Vitamin E — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 50,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (10,
   'Vitamin C — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 60,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (32,
   'CoQ10 — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 70,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (23,
   'Selenium — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 80,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range'),

  (30,
   'Alpha-lipoic acid favored for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Supplement Recommendations', 90,
   '## Supplement Recommendations

* B vitamins essential for glucose metabolism
* Magnesium citrate or glycinate
* Zinc important for blood sugar and thyroid health
* Chromium picolinate
	* Typical 400 micrograms dose
	* Safe up to 800 micrograms
* Antioxidants
	* Vitamin E, Vitamin C, CoQ10, selenium
	* Alpha-lipoic acid favored for blood sugar regulation
* Magnesium supplementation recommendation
	* 400 to 600 milligrams range');

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Cinnamon (generated) ─────────────────────────────────────────────────────
  (167,
   '**Cinnamomum verum** — Reduces A1C (3-month blood sugar average), lowers LDL cholesterol, immunoregulatory (benefits Crohn''s disease, ulcerative colitis, allergies). Drying — caution with severe constipation; pair with moistening herbs like flaxseed, marshmallow, or chia. Pair with licorice, bitter melon. Dosage: 1/4 to 1/2 tsp powdered bark in water; capsule or tincture options available.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Cinnamon', 100,
   '## Cinnamon

• **Cinnamomum verum** — Red Hot taste
	• Can be added to food for therapeutic dosage
• Reduces A1C (3-month blood sugar average)
• Lowers LDL cholesterol
• Immunoregulatory
	• Benefits conditions like Crohn''s disease, ulcerative colitis, allergies
• Drying effect
	• Caution with severe constipation
	• Pair with moistening herbs like *flaxseed*, *marshmallow*, or in *chia seed pudding*
• Formulation
	• Effective as powder or cold infusion with heat
	• Pair with *licorice*, *bitter melon*
• Dosage
	• 1/4 to 1/2 tsp of powdered bark in water
	• Capsule or tincture options available'),

  (180,
   'Flaxseed — paired with Cinnamon for its moistening properties to counteract Cinnamon''s drying effect (caution in severe constipation).',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Cinnamon', 110,
   '## Cinnamon

• **Cinnamomum verum** — Red Hot taste
	• Can be added to food for therapeutic dosage
• Reduces A1C (3-month blood sugar average)
• Lowers LDL cholesterol
• Immunoregulatory
	• Benefits conditions like Crohn''s disease, ulcerative colitis, allergies
• Drying effect
	• Caution with severe constipation
	• Pair with moistening herbs like *flaxseed*, *marshmallow*, or in *chia seed pudding*
• Formulation
	• Effective as powder or cold infusion with heat
	• Pair with *licorice*, *bitter melon*
• Dosage
	• 1/4 to 1/2 tsp of powdered bark in water
	• Capsule or tincture options available'),

  (45,
   'Marshmallow — paired with Cinnamon to counteract Cinnamon''s drying effect (caution in severe constipation).',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Cinnamon', 120,
   '## Cinnamon

• **Cinnamomum verum** — Red Hot taste
	• Can be added to food for therapeutic dosage
• Reduces A1C (3-month blood sugar average)
• Lowers LDL cholesterol
• Immunoregulatory
	• Benefits conditions like Crohn''s disease, ulcerative colitis, allergies
• Drying effect
	• Caution with severe constipation
	• Pair with moistening herbs like *flaxseed*, *marshmallow*, or in *chia seed pudding*
• Formulation
	• Effective as powder or cold infusion with heat
	• Pair with *licorice*, *bitter melon*
• Dosage
	• 1/4 to 1/2 tsp of powdered bark in water
	• Capsule or tincture options available'),

  (78,
   'Licorice — paired with Cinnamon for blood sugar formulas.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Cinnamon', 130,
   '## Cinnamon

• **Cinnamomum verum** — Red Hot taste
	• Can be added to food for therapeutic dosage
• Reduces A1C (3-month blood sugar average)
• Lowers LDL cholesterol
• Immunoregulatory
	• Benefits conditions like Crohn''s disease, ulcerative colitis, allergies
• Drying effect
	• Caution with severe constipation
	• Pair with moistening herbs like *flaxseed*, *marshmallow*, or in *chia seed pudding*
• Formulation
	• Effective as powder or cold infusion with heat
	• Pair with *licorice*, *bitter melon*
• Dosage
	• 1/4 to 1/2 tsp of powdered bark in water
	• Capsule or tincture options available'),

  -- Fenugreek (generated) ────────────────────────────────────────────────────
  (91,
   '*Trigonella* — Increases insulin sensitivity, lowers LDL cholesterol. Must be used in high doses for efficacy: 5–30 grams a day, 3–4 mils four times a day. Can be used in food (curries, stews, tea); tastes good, high compliance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Fenugreek', 140,
   '## Fenugreek

• *Trigonella* — Insulin sensitivity
	• Lowers LDL cholesterol
• Requires high dosage
	• 5-30 grams a day
	• 3-4 mils four times a day
• Can be used in food like curries, stews, or tea
• Tastes good, high compliance'),

  -- Astragalus (generated) ───────────────────────────────────────────────────
  (225,
   'Astragalus — Immune herb for "wasting and thirsting syndrome" (TCM; symptoms: frequent urination, thirst, hunger). Astragalus polysaccharides improve insulin sensitivity and inhibit insulin resistance. Works in conjunction with Angelica sinensis. Dosage: 2–4 mils, three times a day; needs decoction, 4 hours max.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Astragalus', 150,
   '## Astragalus

• Immune herb for wasting and thirsting syndrome
	• Symptoms: frequent urination, thirst, hunger
• Improves insulin sensitivity, inhibits resistance
	• Works in conjunction with *Angelica sinensis*
• Benefits immune system
• Dosage: 2-4 mils, three times a day
	• Needs decoction, 4 hours max'),

  (1009,
   'Angelica sinensis (Dong Quai) — works in conjunction with Astragalus for insulin sensitivity. In TCM formula, 5 parts Dang Gui to 1 part Astragalus shown to help with insulin sensitivity.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Astragalus', 160,
   '## Astragalus

• Immune herb for wasting and thirsting syndrome
	• Symptoms: frequent urination, thirst, hunger
• Improves insulin sensitivity, inhibits resistance
	• Works in conjunction with *Angelica sinensis*
• Benefits immune system
• Dosage: 2-4 mils, three times a day
	• Needs decoction, 4 hours max'),

  -- Panax Ginseng (generated) ────────────────────────────────────────────────
  (14,
   '*Panax ginseng* (Asian ginseng) — Increases insulin sensitivity, lowers fasting glucose and hemoglobin A1C, reduces cortisol. Stimulating, heating — suitable for older, depleted individuals.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Panax Ginseng', 170,
   '## Panax Ginseng

• *Panax ginseng* — Asian ginseng
	• Increases insulin sensitivity
	• Lowers fasting glucose, hemoglobin A1C
	• Reduces cortisol
• Stimulating, heating
	• Suitable for older, depleted individuals
• *American ginseng*
	• Increases insulin sensitivity
	• More mild, energetically controlled'),

  (15,
   'American Ginseng — increases insulin sensitivity; more mild and energetically controlled than Asian Ginseng.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Panax Ginseng', 180,
   '## Panax Ginseng

• *Panax ginseng* — Asian ginseng
	• Increases insulin sensitivity
	• Lowers fasting glucose, hemoglobin A1C
	• Reduces cortisol
• Stimulating, heating
	• Suitable for older, depleted individuals
• *American ginseng*
	• Increases insulin sensitivity
	• More mild, energetically controlled'),

  -- Berberine (generated) ────────────────────────────────────────────────────
  (30,
   'Goldenseal — berberine-containing herb for mucous membrane issues alongside insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Berberine', 190,
   '## Berberine

• Isolated alkaloid for insulin sensitivity
	• Less drastic results in whole herb form
• *Goldenseal* for mucous membrane issues
	• *Oregon grape root* for kidney, skin issues'),

  (33,
   'Oregon Grape Root — berberine-containing alterative for kidney and skin issues alongside insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Berberine', 200,
   '## Berberine

• Isolated alkaloid for insulin sensitivity
	• Less drastic results in whole herb form
• *Goldenseal* for mucous membrane issues
	• *Oregon grape root* for kidney, skin issues'),

  -- Bitter Melon (generated) ─────────────────────────────────────────────────
  (2556,
   '*Momordica charantia* — Anti-inflammatory, lowers blood sugar and cholesterol. Use as food, tincture, or for diabetic neuropathy. Combine with Gymnema sylvestre, fenugreek, CoQ10.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Bitter Melon', 210,
   '## Bitter Melon

• *Momordica charantia* — Anti-inflammatory
	• Lowers blood sugar, cholesterol
	• Use as food, tincture, or for diabetic neuropathy
	• Combine with *Gymnema sylvestre*, *fenugreek*, CoQ10'),

  (2232,
   'Gymnema sylvestre — combine with Bitter Melon for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Bitter Melon', 220,
   '## Bitter Melon

• *Momordica charantia* — Anti-inflammatory
	• Lowers blood sugar, cholesterol
	• Use as food, tincture, or for diabetic neuropathy
	• Combine with *Gymnema sylvestre*, *fenugreek*, CoQ10'),

  -- Nigella (generated) ──────────────────────────────────────────────────────
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Nigella sativa'),
   'Black seed (Nigella) — Gastroprotective, expectorant, beneficial for asthma. Consume as oil, tincture, or capsule.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Nigella', 230,
   '## Nigella

• Black seed — Gastroprotective
	• Expectorant, beneficial for asthma
	• Consume as oil, tincture, or capsule'),

  -- Eleuthero (generated) ────────────────────────────────────────────────────
  (9,
   'Eleuthero (Siberian Ginseng) — for jittery blood sugar dysregulation; lowers cortisol and enhances insulin sensitivity. Sweet medicine, similar in appearance to ginseng. Root requires decoction.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Eleuthero', 240,
   '## Eleuthero

• For jittery blood sugar dysregulation
	• Lowers cortisol, enhances insulin sensitivity
• Sweet medicine, similar in appearance to ginseng
• Root requires decoction'),

  -- Treatment Approaches (generated) ────────────────────────────────────────
  (1160,
   'Blueberry/huckleberry leaf — avoid or use cautiously for type 1 diabetes. Hypoglycemic that works via inhibiting liver gluconeogenesis; does not increase insulin sensitivity.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Treatment Approaches', 250,
   '## Treatment Approaches

• Herbs for insulin resistance: *bitter melon*, *fenugreek*
• Avoid or use cautiously: *blueberry leaf*, *goldenseal*, *gymnema* for type 1 diabetes
• Supplements
	• Carnitine, alpha-lipoic acid, vitamins C and E
• Lifestyle changes
	• Low glycemic foods: fiber, healthy fats, protein, complex carbs'),

  (30,
   'Goldenseal — avoid or use cautiously for type 1 diabetes (berberine-containing).',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Treatment Approaches', 260,
   '## Treatment Approaches

• Herbs for insulin resistance: *bitter melon*, *fenugreek*
• Avoid or use cautiously: *blueberry leaf*, *goldenseal*, *gymnema* for type 1 diabetes
• Supplements
	• Carnitine, alpha-lipoic acid, vitamins C and E
• Lifestyle changes
	• Low glycemic foods: fiber, healthy fats, protein, complex carbs'),

  (2232,
   'Gymnema — avoid or use cautiously for type 1 diabetes. Increases insulin levels rather than enhancing insulin sensitivity.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Treatment Approaches', 270,
   '## Treatment Approaches

• Herbs for insulin resistance: *bitter melon*, *fenugreek*
• Avoid or use cautiously: *blueberry leaf*, *goldenseal*, *gymnema* for type 1 diabetes
• Supplements
	• Carnitine, alpha-lipoic acid, vitamins C and E
• Lifestyle changes
	• Low glycemic foods: fiber, healthy fats, protein, complex carbs');

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (26,
   'L-Carnitine (Carnitine) — supplement for type 2 diabetes treatment; helps burn fat for fuel and maintain muscle mass.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'generated', 'Treatment Approaches', 280,
   '## Treatment Approaches

• Herbs for insulin resistance: *bitter melon*, *fenugreek*
• Avoid or use cautiously: *blueberry leaf*, *goldenseal*, *gymnema* for type 1 diabetes
• Supplements
	• Carnitine, alpha-lipoic acid, vitamins C and E
• Lifestyle changes
	• Low glycemic foods: fiber, healthy fats, protein, complex carbs');

  -- ══════════════════════════════════════════════════════════════════════════
  -- PERSONAL NOTES (Ashley Shereel)
  -- ══════════════════════════════════════════════════════════════════════════

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Top-line herbs for blood sugar (personal) ───────────────────────────────
  (223,
   'Rehmannia — named at top of blood sugar dysregulation section as a key herb for insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Insulin Resistance and Blood Sugar Dysregulation', 10,
   '## Insulin Resistance and Blood Sugar Dysregulation

Rehmannia
Cinnamon
American Ginseng

- this is one of the things we can really affect clinically and before it becomes an overt pathology'),

  (167,
   'Cinnamon — named at top of blood sugar dysregulation section as a key herb.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Insulin Resistance and Blood Sugar Dysregulation', 20,
   '## Insulin Resistance and Blood Sugar Dysregulation

Rehmannia
Cinnamon
American Ginseng

- this is one of the things we can really affect clinically and before it becomes an overt pathology'),

  (15,
   'American Ginseng — named at top of blood sugar dysregulation section as a key herb.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Insulin Resistance and Blood Sugar Dysregulation', 30,
   '## Insulin Resistance and Blood Sugar Dysregulation

Rehmannia
Cinnamon
American Ginseng

- this is one of the things we can really affect clinically and before it becomes an overt pathology'),

  -- Cinnamon materia medica (personal) ──────────────────────────────────────
  (167,
   'Cinnamon (Cinnamomum verum - Ceylon). Actions: carminative, circulatory tonic, diaphoretic, immunoregulatory. Uses: increases beta cell ability to utilize endogenous insulin; use for insulin resistant diabetes, hyperinsulinemia, and metabolic syndrome; reduces Hemoglobin A1C; hypotensive; can lower VLDL and triglyceride levels; appropriate for nonalcoholic fatty liver disease and PMOS; immunoregulatory (allergies, Crohn''s, ulcerative colitis). Pair with Gymnema, Bitter Melon, and Hibiscus for Type 2 Diabetes. Contraindication: synergistic effect with Pioglitazone (Actos) — could allow for lower dosage of medication. Dosage: Tincture 1 ml TID, tea 1/4–1/2 tsp powdered bark in 8 oz water 3x a day, 1–2 00 capsules BID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Cinnamon', 40,
   '#### Cinnamon
- Cinnamomum verum - Ceylon
- Actions: carminative, circulatory tonic, diaphoretic, immunoregulatory (atherosclerosis, Crohn''s and allergic rhinitis)
- Uses:
    - Increases ability of beta cell''s to utilize endogenous insulin
    - Use for insulin resistant diabetes, hyperinsulinemia, and metabolic syndrome
    - Reduces Hemoglobin AlC
    - Hypotensive
    - Can lower VLDL and triglyceride levels
    - Appropriate for use with nonalcoholic fatty liver disease and PMOS
    - immunoregulatory (allergies, Crohns, ulcerative collitis)
    - Pair with Gymnema, Bitter Melon, and Hibiscus for Type 2 Diabetes
- Contraindications: has synergistic affect with the medication Pioglitazone (Actos) - could allow for lower dosage of medication
- Dosage: Tincture 1 ml TID, tea 1/4-1/2 tsp powdered bark in 8 oz water 3x a day, 1-2 00 capsules BID

- Caution: someone who is constipated — pair with moistening: marshmallow, flax seed, chia'),

  (2232,
   'Gymnema — paired with Cinnamon and Bitter Melon for Type 2 Diabetes.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Cinnamon', 50,
   '#### Cinnamon
- Pair with Gymnema, Bitter Melon, and Hibiscus for Type 2 Diabetes
- Caution: someone who is constipated — pair with moistening: marshmallow, flax seed, chia'),

  (2233,
   'Hibiscus — paired with Cinnamon, Gymnema, and Bitter Melon for Type 2 Diabetes.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Cinnamon', 60,
   '#### Cinnamon
- Pair with Gymnema, Bitter Melon, and Hibiscus for Type 2 Diabetes
- Caution: someone who is constipated — pair with moistening: marshmallow, flax seed, chia'),

  -- Fenugreek materia medica (personal) ─────────────────────────────────────
  (91,
   'Fenugreek (Trigonella foenum-graecum). Actions: carminative. Uses: increases insulin sensitivity; decreases LDL and VLDL cholesterol; lowers fasting glucose and Hemoglobin A1C. Must be used in high doses for efficacy: 5–30 g per day. Contraindication: synergistic with Pioglitazone (Actos). Dosage: Tincture 3–4 ml QID, powder 3–7 g TID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Fenugreek', 70,
   '#### Fenugreek
- Actions: carminative
- Uses:
    - Increases insulin sensitivity
    - Decreases LDL and VLDL cholesterol
    - Lowers fasting glucose and Hemoglobin A1C
    - ** Must be used in high doses for efficacy (5-30 g per day)
- Contraindications: has synergistic affect with the medication Pioglitazone (Actos) - could allow for lower dosage of medication
- Dosage: Tincture 3-4 ml QID, powder 3-7 g TID'),

  -- Astragalus materia medica (personal) ────────────────────────────────────
  (225,
   'Astragalus. Actions: immune amphoteric, cardiac tonic, diuretic, nephroprotective, restorative tonic. Used in TCM for "wasting and thirsting syndrome" (3 Ps: polyuria, polyphagia, polydipsia). Astragalus polysaccharides improve insulin sensitivity and inhibit insulin resistance. TCM formula: 5 parts Dang Gui (Angelica sinensis) to 1 part Astragalus shown to help with insulin sensitivity. Needs to be decocted to be effective — 4 hours (Instant Pot). Dose: 2–4 ml TID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Astragalus', 80,
   '#### Astragalus
- Actions: Immune amphoteric, cardiac tonic, diuretic, nephroprotective, restorative tonic
- Used in TCM for what they call "wasting and thirsting syndrome"
- Astragalus polysaccharides improve insulin sensitivity and inhibit insulin resistance
- In TCM formula 5 part Dang Gui to I part Astragalus was shown to help with insulin sensitivity
- Dose: 2-4 ml TID

- Wasting and Thirsting syndrome - TCM
    - 3 P''s: Polyuria, Polyphagia, Polydipsia
- improve insulin sensitivity
- needs to be decocted to be effective - 4 hours (Instant Pot)'),

  (1009,
   'Dong Quai (Angelica sinensis / Dang Gui) — TCM formula: 5 parts Dang Gui to 1 part Astragalus shown to help with insulin sensitivity.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Astragalus', 90,
   '#### Astragalus
- In TCM formula 5 part Dang Gui to I part Astragalus was shown to help with insulin sensitivity'),

  -- Panax Ginseng materia medica (personal) ─────────────────────────────────
  (14,
   'Panax ginseng (Asian Ginseng) — stimulating adaptogen; increases insulin sensitivity; lowers fasting glucose and hemoglobin A1C; reduces cortisol. Rarely used with younger clients, too stimulating; good for depleted or depressed people. Use in small doses for insulin resistance — can stimulate insulin secretion in larger amounts. Dose: 1:5, 1–2 ml TID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Panax Ginseng', 100,
   '#### Panax Ginseng
- Increases insulin sensitivity, lowers fasting glucose and hemoglobin AlC
- Stimulating adaptogen that can also help to reduce cortisol
- Use in small doses for those with insulin resistance because it can in some cases stimulate insulin secretion in larger amounts
- Dose: 1:5, 1-2 ml TID

- Asian Ginseng
- adaptogen, unique in that it reduces cortisol too
- rarely used with younger clients, too stimulating
- good for also depressed people'),

  -- American Ginseng materia medica (personal) ──────────────────────────────
  (15,
   'American Ginseng (Panax quinquefolius) — improves insulin sensitivity; helps lower cortisol; warming and moistening; more energetically neutral than Asian Ginseng. 7–10 days until effect. Expensive and overharvested. Dose: Tincture 1:5, 2–4 ml TID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - American Ginseng', 110,
   '#### Panax Quinquefolius
- Improves insulin sensitivity
- You can also use the berries
- Warming and moistening
- Helps to lower cortisol
- Dose: Tincture 1:5 2-4 ml TID

- milder than Asian Ginseng
- American ginseng
- more energetically neutral - slightly warmer and moistening
- 7-10 days until effect
- BS reg and cortisol
- BUT, expensive, overharvested and hard to find'),

  -- Berberine-containing herbs (personal) ───────────────────────────────────
  (30,
   'Goldenseal — berberine-containing; use for folks with mucous membrane issues alongside insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Berberine Herbs', 120,
   '#### Berberine containing plants
- Isolated berberine (from Chinese coptis, Oregon Grape Root, Barberry, Goldenseal, and Yellow Root has been shown to increase insulin sensitivity, reduce triglycerides, lowers leptin
- Berberine has been shown to inhibit adipogenesis and carbohydrate glucose absorption
- Beware that all these studies were done on the isolated alkaloid!

- Goldenseal, for folks also with mucus membrane issues
- OGR, more for people that need an alterative - skin issues, rashes
    - skin eruptions on the back or butt - comedones - pimples that won''t head'),

  (33,
   'Oregon Grape Root (OGR) — berberine-containing; more for people that need an alterative — skin issues, rashes, comedones.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Berberine Herbs', 130,
   '#### Berberine containing plants
- Isolated berberine (from Chinese coptis, Oregon Grape Root, Barberry, Goldenseal, and Yellow Root has been shown to increase insulin sensitivity, reduce triglycerides, lowers leptin
- Berberine has been shown to inhibit adipogenesis and carbohydrate glucose absorption
- Beware that all these studies were done on the isolated alkaloid!

- Goldenseal, for folks also with mucus membrane issues
- OGR, more for people that need an alterative - skin issues, rashes
    - skin eruptions on the back or butt - comedones - pimples that won''t head'),

  (158,
   'Barberry — berberine-containing herb; increases insulin sensitivity, reduces triglycerides, lowers leptin.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Berberine Herbs', 140,
   '#### Berberine containing plants
- Isolated berberine (from Chinese coptis, Oregon Grape Root, Barberry, Goldenseal, and Yellow Root has been shown to increase insulin sensitivity, reduce triglycerides, lowers leptin
- Berberine has been shown to inhibit adipogenesis and carbohydrate glucose absorption'),

  -- Bitter Melon materia medica (personal) ──────────────────────────────────
  (2556,
   'Bitter Melon (Momordica charantia). Actions: anthelmintic, abortifacient, antiviral, emmenagogue, hypoglycemic, hypocholesterolemic. Can be used for both non-insulin dependent and insulin-dependent diabetes. Good for IR combined with elevated blood lipids. Can prevent and treat diabetic neuropathy. For type 2 diabetes combine with Gymnema, Fenugreek, Kudzu. For IR combine with American Ginseng, Cinnamon, Holy Basil, Barberry. Contraindication: monitor blood sugar levels closely. Dose: powder 2 00 capsules 2–3x/day, Tincture 1:2 2–4 ml TID, standardized extract 100–200 mg TID, juice 10–20 ml BID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Bitter Melon', 150,
   '#### Bitter melon
- Actions: anthelmintic, abortifacient, antiviral, emmenagogue, hypoglycemic, hypocholesterolemic
- Can be used for both non-insulin dependent diabetes and insulin-dependent diabetes
- Good for treating IR combined with elevated blood lipids
- Can also prevent and treat diabetic neuropathy
- For type 2 diabetes combine with Gymnema, Fenugreek, Kudzu
- For IR combine with American Ginseng, Cinnamon, Holy Basil, Barberry
- Contraindications: monitor blood sugar levels closely
- Dose: powder 2 00 capsules 2-3x a day, Tincture 1:2 2-4 ml TID, standardized extract 100-200 mg TID, juice 10-20ml BID'),

  (1547,
   'Kudzu Root — combine with Bitter Melon and Gymnema for type 2 diabetes.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Bitter Melon', 160,
   '#### Bitter melon
- For type 2 diabetes combine with Gymnema, Fenugreek, Kudzu'),

  (13,
   'Holy Basil (Tulsi) — combine with Bitter Melon, American Ginseng, Cinnamon, and Barberry for insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Bitter Melon', 170,
   '#### Bitter melon
- For IR combine with American Ginseng, Cinnamon, Holy Basil, Barberry'),

  -- Nigella Sativa materia medica (personal) ────────────────────────────────
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Nigella sativa'),
   'Nigella Sativa (Black seed). Actions: antibacterial, bronchodilator, carminative, diuretic, hepatoprotective, hypocholesterolemic, hypoglycemic. Used in Unani-Tibb system. Extremely gastroprotective. Helps with metabolic syndrome (unhealthy blood lipids — use with Turmeric). Also for cold damp coughs and asthma. Contraindication: inhibits CYP2C11 pathway. Dose: Tincture 1:5 1–2 ml TID, Capsules 500 mg BID, Capsules seed oil 100–200 mg BID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Nigella', 180,
   '#### Nigella Sativa
- Actions: antibacterial, bronchodilator, carminative, diuretic, hepatoprotective, hypocholesterolemic, hypoglycemic
- In Unani-Tibb system it is widely used
- Extremely gastroprotective
- Helps with other symptoms of Metabolic Syndrome like unhealthy blood lipids (use with Turmeric)
- Also use for cold damp coughs + Asthma
- Dose: Tincture I:5 1-2 ml TID, Capsules 500 mg BID, Capsules seed oil 100-200 mg BID
- Contraindications: Inhibits CYP2CI 1 pathway

- for gastro issues mixed with BS dysregulation
- seed oil, tincture, or capsules'),

  (203,
   'Turmeric — use with Nigella Sativa for metabolic syndrome picture with unhealthy blood lipids.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Nigella', 190,
   '#### Nigella Sativa
- Helps with other symptoms of Metabolic Syndrome like unhealthy blood lipids (use with Turmeric)'),

  -- Eleuthero materia medica (personal) ─────────────────────────────────────
  (9,
   'Eleuthero — helps lower cortisol and enhances insulin sensitivity. Good for burnt-out, busy person with blood sugar dysregulation. Sweet; root decocted or double extracted for tincture. Dose: Tincture 1:4, 3–5 ml TID.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Eleuthero', 200,
   '#### Eleuthero
- Helps to lower cortisol and enhances insulin sensitivity
- Dose: Tincture 1:4 3-5 ml TID

- BS regulation for the busy person, burnt out
- sweet
- root, decocted or **double extracted for tincture**'),

  -- Guduchi materia medica (personal) ──────────────────────────────────────
  (18,
   'Guduchi (Tinospora cordifolia). Actions: anti-inflammatory, immune amphoteric, alterative. Helps with gout, liver disease, and arthritis. Use for folks sensitive to surroundings and overstimulated by everything. Inhibits insulin resistance and helps with blood lipid metabolism. Cooling — good for hot and irritated people. Dose: Tincture 1:5, 1.5–2.5 ml TID. Source: Banyan Botanicals.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Materia Medica - Guduchi', 210,
   '#### Guduchi - Tinospora Cordifolia
- Antiinflammatory, Immune Amphoteric, Alterative
- Helps with gout, liver disease, and arthritis
- Use for folks sensitive to surroundings
- Inhibits insulin resistance and helps with blood lipid metabolism
- Dose: Tincture 1:5 1.5-2.5 ml TID

- good for super overwhelmed by env, overstimulated by everything
- helps with insulin resistance and cholesterol
- cooling
- good for hot and irritated people
- Banyan Botanicals good source'),

  -- Other herbs to consider (personal) ──────────────────────────────────────
  (2233,
   'Hibiscus (Hibiscus sabdariffa) — also helps lower blood pressure; included in "other herbs to consider" for blood sugar dysregulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 220,
   '#### Other herbs to consider

- Hibiscus - BP lowering as well
    - Hibiscus sabdariffa (also helps lower blood pressure)
- Tulsi - adapt, good for GI
    - Occimum Tenniflorum
    - contraindicated with hypothyroidism - cooling to thyroid
- Goji Berry
    - Lycium Barbatum
- Devil''s club
    - Opplopanax Horridus
    - if also dealing with patterns of addiction
- Maitake Mushroom (high dose)
    - good for insulin resistance
    - capsule or take powdered extract
- Cactus fruit
    - Oppuntia spp fruit / Prickly Pear
    - juice with celery for BS reg
- Green tea
    - Camellia sinensis
    - consider the person''s sensitivity to caffeine, which might cause a stress response (causes BS to spike)
- Cacao
    - Theobroma cacao
    - theobromine — acts like caffeine but different
- Chinese Yam (Diascorea opposita)
    - Increases insulin sensitivity'),

  (13,
   'Tulsi (Holy Basil, Ocimum tenuiflorum) — adaptogen, good for GI. Contraindicated with hypothyroidism — cooling to thyroid.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 230,
   '#### Other herbs to consider

- Tulsi - adapt, good for GI
    - Occimum Tenniflorum
    - contraindicated with hypothyroidism - cooling to thyroid'),

  (1548,
   'Goji Berry (Lycium barbarum / Wolfberry) — listed among other herbs to consider for blood sugar dysregulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 240,
   '#### Other herbs to consider

- Goji Berry
    - Lycium Barbatum'),

  (591,
   'Devil''s Club (Oplopanax horridus) — listed among other herbs for blood sugar dysregulation; particularly when also dealing with patterns of addiction.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 250,
   '#### Other herbs to consider

- Devil''s club
    - Opplopanax Horridus
    - if also dealing with patterns of addiction'),

  (2633,
   'Maitake Mushroom (Grifola frondosa) — good for insulin resistance at high dose; capsule or powdered extract.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 260,
   '#### Other herbs to consider

- Maitake Mushroom (high dose)
    - good for insulin resistance
    - capsule or take powdered extract'),

  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Opuntia spp.'),
   'Prickly Pear / Nopal (Opuntia spp.) — cactus fruit; juice with celery for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 270,
   '#### Other herbs to consider

- Cactus fruit
    - Oppuntia spp fruit / Prickly Pear
    - juice with celery for BS reg'),

  (149,
   'Green Tea (Camellia sinensis) — consider person''s sensitivity to caffeine, which might cause a stress response (causes blood sugar to spike).',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 280,
   '#### Other herbs to consider

- Green tea
    - Camellia sinensis
    - consider the person''s sensitivity to caffeine, which might cause a stress response (causes BS to spike)'),

  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Theobroma cacao'),
   'Cacao (Theobroma cacao) — contains theobromine, which acts like caffeine but different. Listed among blood sugar herbs to consider.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 290,
   '#### Other herbs to consider

- Cacao
    - Theobroma cacao
    - theobromine — acts like caffeine but different'),

  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Dioscorea opposita'),
   'Chinese Yam (Dioscorea opposita / Shan Yao) — increases insulin sensitivity.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Other Herbs for Blood Sugar', 300,
   '#### Other herbs to consider

- Chinese Yam (Diascorea opposita)
    - Increases insulin sensitivity');

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Supplement Recommendation (personal) ────────────────────────────────────
  (49,
   'Multi vitamin with Vitamin B — essential for glucose metabolism.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 310,
   '### Supplement Recommendation
- Multi vitamin with Vitamin B (essential for glucose metabolism)
- Magnesium citrate or glycinate: 400-600 mg
- Zinc 20-40 mg, important for glucose metabolism and thyroid health
- Manganese 2-5 mg
- Chromium picolinate 400-800 mcg
- Full complement of trace elements (food based in seaweed) - trace element drops
- Inositol
- Antioxidants:
    - Vitamin E 100 iu bid
    - Vitamin C 500 mg bid
    - CoQ-10 60 mg bid
    - Selenium 100 mcg bid
    - Alpha lipolic acid 200 mg bid - personal favorite of Ashley''s'),

  (21,
   'Magnesium citrate or glycinate: 400–600 mg for blood sugar support.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 320,
   '### Supplement Recommendation
- Magnesium citrate or glycinate: 400-600 mg'),

  (24,
   'Zinc 20–40 mg — important for glucose metabolism and thyroid health.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 330,
   '### Supplement Recommendation
- Zinc 20-40 mg, important for glucose metabolism and thyroid health'),

  (48,
   'Manganese 2–5 mg — recommended in blood sugar support protocol.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 340,
   '### Supplement Recommendation
- Manganese 2-5 mg'),

  (16,
   'Chromium picolinate 400–800 mcg for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 350,
   '### Supplement Recommendation
- Chromium picolinate 400-800 mcg'),

  (35,
   'Inositol — included in blood sugar support supplement protocol.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 360,
   '### Supplement Recommendation
- Inositol'),

  (12,
   'Vitamin E 100 IU BID — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 370,
   '### Supplement Recommendation
- Antioxidants:
    - Vitamin E 100 iu bid
    - Vitamin C 500 mg bid
    - CoQ-10 60 mg bid
    - Selenium 100 mcg bid
    - Alpha lipolic acid 200 mg bid'),

  (10,
   'Vitamin C 500 mg BID — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 380,
   '### Supplement Recommendation
- Antioxidants:
    - Vitamin E 100 iu bid
    - Vitamin C 500 mg bid
    - CoQ-10 60 mg bid
    - Selenium 100 mcg bid
    - Alpha lipolic acid 200 mg bid'),

  (32,
   'CoQ-10 60 mg BID — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 390,
   '### Supplement Recommendation
- Antioxidants:
    - Vitamin E 100 iu bid
    - Vitamin C 500 mg bid
    - CoQ-10 60 mg bid
    - Selenium 100 mcg bid
    - Alpha lipolic acid 200 mg bid'),

  (23,
   'Selenium 100 mcg BID — antioxidant for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 400,
   '### Supplement Recommendation
- Antioxidants:
    - Vitamin E 100 iu bid
    - Vitamin C 500 mg bid
    - CoQ-10 60 mg bid
    - Selenium 100 mcg bid
    - Alpha lipolic acid 200 mg bid'),

  (30,
   'Alpha-lipoic acid 200 mg BID — Ashley''s personal favorite for blood sugar regulation.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Supplement Recommendation', 410,
   '### Supplement Recommendation
- Antioxidants:
    - Alpha lipolic acid 200 mg bid - personal favorite of Ashley''s');

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Herbs contraindicated or cautious for insulin resistance (personal) ──────
  (1160,
   'Blueberry/Huckleberry Leaf — hypoglycemic that works via inhibiting liver gluconeogenesis (release of glucose from glycogen); does not increase insulin sensitivity. Could potentially cause liver damage (anthraquinones). Use cautiously or avoid in insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Herbs Contraindicated for Insulin Resistance', 420,
   '### Herbs used for Diabetes that may be contraindicated for insulin resistance
#### Blueberry/Huckleberry Leaf
- Hypoglycemic that works via inhibiting liver gluconeogenesis (release of glucose from glycogen)
- Does not increase insulin sensitivity
- Could potentially cause liver damage (athraquinones)
#### Goat''s Rue
- Galegine (alkaloid) was template for metformin
- Lowers blood sugar by inhibiting intestinal absorption of glucose, enhances glucose uptake by fat, liver, and muscle tissue
#### Gymnema
- Increases insulin levels rather than enhancing insulin sensitivity
- Use for type 1 and type 2 insulin dependent diabetes — lowers blood sugar levels, improves glycemic control, reduces A1C levels'),

  (1122,
   'Goat''s Rue (Galega officinalis) — galegine alkaloid was template for metformin. Lowers blood sugar by inhibiting intestinal glucose absorption and enhancing glucose uptake by fat, liver, and muscle tissue.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Herbs Contraindicated for Insulin Resistance', 430,
   '### Herbs used for Diabetes that may be contraindicated for insulin resistance
#### Goat''s Rue
- Galegine (alkaloid) was template for metformin
- Lowers blood sugar by inhibiting intestinal absorption of glucose, enhances glucose uptake by fat, liver, and muscle tissue'),

  (2232,
   'Gymnema — increases insulin levels rather than enhancing insulin sensitivity. Use for type 1 and type 2 insulin-dependent diabetes — lowers blood sugar levels, improves glycemic control, reduces A1C levels. Not ideal for pure insulin resistance.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Herbs Contraindicated for Insulin Resistance', 440,
   '### Herbs used for Diabetes that may be contraindicated for insulin resistance
#### Gymnema
- Increases insulin levels rather than enhancing insulin sensitivity
- Use for type 1 and type 2 insulin dependent diabetes — lowers blood sugar levels, improves glycemic control, reduces A1C levels'),

  -- Blood Sugar Case Study (personal) ───────────────────────────────────────
  (2233,
   'Hibiscus — lukewarm infusion; lowers blood sugar, blood pressure, and cooling. Selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 450,
   '#### Ashley
- Hibiscus - lukewarm infusion — lowers blood sugar, BP, and cooling
- Tulsi - carminative
- Wild Yam - gut antispasmodic
- bitter melon - digestive tonic, cooling
- lemon balm - nervine
- euphoric formula - nervine tincture to wean off of cannabis
    - blue lotus, blue vervain, damiana
- supplements: ALA, mag, C and D
- protein bowls 160g/day
- ACV, clothing the carbs for BS regulation
- turns out had undiagnosed elevated BP, cusp of type II diabetes, so added:
    - hawthorn and linden
    - Antioxidant foods'),

  (13,
   'Tulsi (Holy Basil) — carminative; selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 460,
   '#### Ashley
- Hibiscus - lukewarm infusion — lowers blood sugar, BP, and cooling
- Tulsi - carminative
- Wild Yam - gut antispasmodic'),

  (74,
   'Wild Yam — gut antispasmodic; selected for blood sugar case study patient with nighttime stomach cramps.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 470,
   '#### Ashley
- Wild Yam - gut antispasmodic
- bitter melon - digestive tonic, cooling'),

  (2556,
   'Bitter Melon — digestive tonic, cooling; selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 480,
   '#### Ashley
- bitter melon - digestive tonic, cooling'),

  (134,
   'Lemon Balm — nervine; selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 490,
   '#### Ashley
- lemon balm - nervine'),

  (983,
   'Blue Vervain — in euphoric nervine formula to wean off cannabis for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 500,
   '#### Ashley
- euphoric formula - nervine tincture to wean off of cannabis
    - blue lotus, blue vervain, damiana'),

  (144,
   'Damiana — in euphoric nervine formula to wean off cannabis for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 510,
   '#### Ashley
- euphoric formula - nervine tincture to wean off of cannabis
    - blue lotus, blue vervain, damiana'),

  (73,
   'Hawthorn — added when patient found to have undiagnosed elevated blood pressure at cusp of type II diabetes.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 520,
   '#### Ashley
- turns out had undiagnosed elevated BP, cusp of type II diabetes, so added:
    - hawthorn and linden'),

  (90,
   'Linden — added when patient found to have undiagnosed elevated blood pressure at cusp of type II diabetes.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 530,
   '#### Ashley
- turns out had undiagnosed elevated BP, cusp of type II diabetes, so added:
    - hawthorn and linden');

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Case study supplements (personal) ──────────────────────────────────────
  (30,
   'Alpha-lipoic acid (ALA) — supplement selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 540,
   '#### Ashley
- supplements: ALA, mag, C and D'),

  (21,
   'Magnesium — supplement selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 550,
   '#### Ashley
- supplements: ALA, mag, C and D'),

  (10,
   'Vitamin C — supplement selected for blood sugar case study patient.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 560,
   '#### Ashley
- supplements: ALA, mag, C and D'),

  (11,
   'Vitamin D — supplement selected for blood sugar case study patient. Note: inadequate Vitamin D linked to increased insulin resistance and increase in all autoimmune disease; isn''t just a vitamin, it''s a hormone.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Blood Sugar Case Study', 570,
   '#### Ashley
- supplements: ALA, mag, C and D

### Diabetes Mellitus Type II
- Vitamin D - inadequate Vitamin D linked to increase insulin resistance and increase in all autoimmune disease (isn''t just a vitamin it''s a hormone)'),

  (26,
   'L-Carnitine — burns fat for fuel and helps maintain muscle mass; supplement for Type 2 diabetes treatment. Critical given risk of lean muscle mass loss with GLP-1 medications like Ozempic/Trulicity.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Type 2 Diabetes Treatment', 580,
   '### Type II Holistic Treatment
- Supplements:
    - Magnesium
    - L-Carnitine - burn your fat for fuel and maintain muscle mass
    - Alpha-lipolic acid (excellent for diabetic retinopathy-start at 100mg and increase to 300)
    - More serious side effects of heart failure and anemia
    - Vitamin C supplement
    - Vitamin D - inadequate Vitamin D linked to increase insulin resistance and increase in all autoimmune disease');

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Tulsi Plant Sit (personal, afternoon) ───────────────────────────────────
  (13,
   'Tulsi (Holy Basil) plant sit: grounding yet heart-opening, not like Valerian. Tinctured with glycerin to maintain aromatics. Helps with brain fog in gut and brain — can help dispel and gain clarity. Protective, gently cooling overactive thyroid. Air of beauty, aphrodisiac quality. Centered in cold infusion.',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Tulsi Plant Sit', 590,
   '## Tulsi plant sit
- centered - cold infusion
- quiet strength
- Rose and Tulsi - atmospheric space
- sweet tincture with bitters
- tinctured with glycerin to maintain aromatics
- brain fog in gut and brain - can help dispel and gain clarity
- oil for skin care
- protective
- deity - offerings of honey and sweets
- grounding but not like Valerian, more heart opening, see beauty in mundane things
- air of beauty - aphrodisiac
- gently cooling overactive thyroid
    - shifting those states gradually over time'),

  (850,
   'Rose — paired with Tulsi in Tulsi plant sit as "Rose and Tulsi - atmospheric space."',
   'BHC - Class 73 - Blood Sugar and Stroke Case Study Presentations',
   'personal', 'Tulsi Plant Sit', 600,
   '## Tulsi plant sit
- Rose and Tulsi - atmospheric space
- sweet tincture with bitters');

END $$;

-- ─── Keywords ───────────────────────────────────────────────────────────────

-- Cinnamon (id=167)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (167, 'blood sugar dysregulation', 'ailment'),
  (167, 'metabolic syndrome', 'ailment'),
  (167, 'insulin resistance', 'ailment'),
  (167, 'type 2 diabetes', 'ailment'),
  (167, 'hyperlipidemia', 'ailment'),
  (167, 'fatty liver disease', 'ailment'),
  (167, 'PCOS', 'ailment'),
  (167, 'immunoregulatory', 'action'),
  (167, 'hypoglycemic', 'action'),
  (167, 'carminative', 'action'),
  (167, 'circulatory tonic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Fenugreek (id=91)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (91, 'blood sugar dysregulation', 'ailment'),
  (91, 'insulin resistance', 'ailment'),
  (91, 'type 2 diabetes', 'ailment'),
  (91, 'hyperlipidemia', 'ailment'),
  (91, 'hypoglycemic', 'action'),
  (91, 'carminative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Astragalus (id=225)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (225, 'blood sugar dysregulation', 'ailment'),
  (225, 'insulin resistance', 'ailment'),
  (225, 'wasting and thirsting syndrome', 'ailment'),
  (225, 'immune support', 'ailment'),
  (225, 'hypoglycemic', 'action'),
  (225, 'nephroprotective', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginseng (id=14)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14, 'blood sugar dysregulation', 'ailment'),
  (14, 'insulin resistance', 'ailment'),
  (14, 'type 2 diabetes', 'ailment'),
  (14, 'metabolic syndrome', 'ailment'),
  (14, 'stress', 'ailment'),
  (14, 'hypoglycemic', 'action'),
  (14, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- American Ginseng (id=15)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (15, 'blood sugar dysregulation', 'ailment'),
  (15, 'insulin resistance', 'ailment'),
  (15, 'type 2 diabetes', 'ailment'),
  (15, 'metabolic syndrome', 'ailment'),
  (15, 'stress', 'ailment'),
  (15, 'hypoglycemic', 'action'),
  (15, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goldenseal (id=30)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (30, 'blood sugar dysregulation', 'ailment'),
  (30, 'insulin resistance', 'ailment'),
  (30, 'type 1 diabetes', 'ailment'),
  (30, 'hypoglycemic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oregon Grape (id=33)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (33, 'blood sugar dysregulation', 'ailment'),
  (33, 'insulin resistance', 'ailment'),
  (33, 'hypoglycemic', 'action'),
  (33, 'alterative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Barberry (id=158)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (158, 'blood sugar dysregulation', 'ailment'),
  (158, 'insulin resistance', 'ailment'),
  (158, 'hyperlipidemia', 'ailment'),
  (158, 'hypoglycemic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bitter Melon (id=2556)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2556, 'blood sugar dysregulation', 'ailment'),
  (2556, 'insulin resistance', 'ailment'),
  (2556, 'type 2 diabetes', 'ailment'),
  (2556, 'type 1 diabetes', 'ailment'),
  (2556, 'diabetic neuropathy', 'ailment'),
  (2556, 'hyperlipidemia', 'ailment'),
  (2556, 'metabolic syndrome', 'ailment'),
  (2556, 'hypoglycemic', 'action'),
  (2556, 'anti-inflammatory', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gymnema (id=2232)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2232, 'blood sugar dysregulation', 'ailment'),
  (2232, 'type 1 diabetes', 'ailment'),
  (2232, 'type 2 diabetes', 'ailment'),
  (2232, 'insulin resistance', 'ailment'),
  (2232, 'hypoglycemic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Eleuthero (id=9)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (9, 'blood sugar dysregulation', 'ailment'),
  (9, 'insulin resistance', 'ailment'),
  (9, 'metabolic syndrome', 'ailment'),
  (9, 'adrenal fatigue', 'ailment'),
  (9, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Guduchi (id=18)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (18, 'blood sugar dysregulation', 'ailment'),
  (18, 'insulin resistance', 'ailment'),
  (18, 'metabolic syndrome', 'ailment'),
  (18, 'hyperlipidemia', 'ailment'),
  (18, 'gout', 'ailment'),
  (18, 'arthritis', 'ailment'),
  (18, 'anti-inflammatory', 'action'),
  (18, 'alterative', 'action'),
  (18, 'adaptogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hibiscus (id=2233)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2233, 'blood sugar dysregulation', 'ailment'),
  (2233, 'type 2 diabetes', 'ailment'),
  (2233, 'hypertension', 'ailment'),
  (2233, 'hypoglycemic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Holy Basil / Tulsi (id=13)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (13, 'blood sugar dysregulation', 'ailment'),
  (13, 'insulin resistance', 'ailment'),
  (13, 'stress', 'ailment'),
  (13, 'digestive health', 'ailment'),
  (13, 'adaptogen', 'action'),
  (13, 'carminative', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wolfberry / Goji (id=1548)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1548, 'blood sugar dysregulation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Devil's Club (id=591)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (591, 'blood sugar dysregulation', 'ailment'),
  (591, 'substance withdrawal', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Maitake (id=2633)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2633, 'blood sugar dysregulation', 'ailment'),
  (2633, 'insulin resistance', 'ailment'),
  (2633, 'metabolic syndrome', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Green Tea (id=149)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (149, 'blood sugar dysregulation', 'ailment'),
  (149, 'metabolic syndrome', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bilberry / Blueberry Leaf (id=1160)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1160, 'blood sugar dysregulation', 'ailment'),
  (1160, 'type 1 diabetes', 'ailment'),
  (1160, 'type 2 diabetes', 'ailment'),
  (1160, 'hypoglycemic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goat's Rue (id=1122)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1122, 'blood sugar dysregulation', 'ailment'),
  (1122, 'type 2 diabetes', 'ailment'),
  (1122, 'insulin resistance', 'ailment'),
  (1122, 'hypoglycemic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dong Quai (id=1009)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1009, 'blood sugar dysregulation', 'ailment'),
  (1009, 'insulin resistance', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wild Yam (id=74)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (74, 'muscle spasms', 'ailment'),
  (74, 'antispasmodic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Kudzu (id=1547)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1547, 'blood sugar dysregulation', 'ailment'),
  (1547, 'type 2 diabetes', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hawthorn berry (id=73)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73, 'blood sugar dysregulation', 'ailment'),
  (73, 'hypertension', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Linden (id=90)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (90, 'hypertension', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Turmeric (id=203)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (203, 'metabolic syndrome', 'ailment'),
  (203, 'hyperlipidemia', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Flax (id=180)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (180, 'constipation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Marshmallow (id=45)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'constipation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rehmannia (id=223)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (223, 'blood sugar dysregulation', 'ailment'),
  (223, 'insulin resistance', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nigella sativa (new)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, k, cat FROM herbal.herbs, (VALUES
  ('blood sugar dysregulation', 'ailment'),
  ('metabolic syndrome', 'ailment'),
  ('hyperlipidemia', 'ailment'),
  ('asthma', 'ailment'),
  ('GI inflammation', 'ailment'),
  ('antibacterial', 'action'),
  ('anti-inflammatory', 'action'),
  ('hepatoprotective', 'action'),
  ('hypoglycemic', 'action'),
  ('carminative', 'action')
) AS t(k, cat)
WHERE latin_name = 'Nigella sativa'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Prickly Pear (new)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, k, cat FROM herbal.herbs, (VALUES
  ('blood sugar dysregulation', 'ailment'),
  ('type 2 diabetes', 'ailment'),
  ('inflammation', 'ailment'),
  ('anti-inflammatory', 'action'),
  ('hypoglycemic', 'action')
) AS t(k, cat)
WHERE latin_name = 'Opuntia spp.'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cacao (new)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, k, cat FROM herbal.herbs, (VALUES
  ('blood sugar dysregulation', 'ailment'),
  ('cardiovascular disease', 'ailment')
) AS t(k, cat)
WHERE latin_name = 'Theobroma cacao'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chinese Yam (new)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT id, k, cat FROM herbal.herbs, (VALUES
  ('blood sugar dysregulation', 'ailment'),
  ('insulin resistance', 'ailment'),
  ('hypoglycemic', 'action')
) AS t(k, cat)
WHERE latin_name = 'Dioscorea opposita'
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplements
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (49, 'blood sugar dysregulation', 'ailment'),
  (49, 'metabolic syndrome', 'ailment'),
  (21, 'blood sugar dysregulation', 'ailment'),
  (21, 'insulin resistance', 'ailment'),
  (21, 'metabolic syndrome', 'ailment'),
  (24, 'blood sugar dysregulation', 'ailment'),
  (24, 'hypothyroidism', 'ailment'),
  (48, 'blood sugar dysregulation', 'ailment'),
  (16, 'blood sugar dysregulation', 'ailment'),
  (16, 'insulin resistance', 'ailment'),
  (16, 'metabolic syndrome', 'ailment'),
  (35, 'blood sugar dysregulation', 'ailment'),
  (35, 'insulin resistance', 'ailment'),
  (12, 'blood sugar dysregulation', 'ailment'),
  (10, 'blood sugar dysregulation', 'ailment'),
  (32, 'blood sugar dysregulation', 'ailment'),
  (32, 'metabolic syndrome', 'ailment'),
  (23, 'blood sugar dysregulation', 'ailment'),
  (30, 'blood sugar dysregulation', 'ailment'),
  (30, 'insulin resistance', 'ailment'),
  (30, 'diabetic neuropathy', 'ailment'),
  (30, 'diabetic retinopathy', 'ailment'),
  (26, 'blood sugar dysregulation', 'ailment'),
  (26, 'type 2 diabetes', 'ailment'),
  (26, 'muscle wasting', 'ailment'),
  (11, 'blood sugar dysregulation', 'ailment'),
  (11, 'insulin resistance', 'ailment'),
  (11, 'autoimmune disease', 'ailment'),
  (33, 'blood sugar dysregulation', 'ailment'),
  (33, 'inflammation', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ─── New ailment keywords → ailment_search_terms ────────────────────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('diabetic neuropathy',
   ARRAY['diabetes nerve damage', 'diabetic nerve pain', 'peripheral neuropathy diabetes', 'neuropathy diabetes']),
  ('diabetic retinopathy',
   ARRAY['diabetes eye damage', 'diabetic eye disease', 'retinopathy diabetes', 'diabetes macular degeneration']),
  ('wasting and thirsting syndrome',
   ARRAY['xiao ke', 'TCM diabetes', 'polyuria polydipsia polyphagia', '3 Ps diabetes', 'wasting thirsting']),
  ('type 1 diabetes',
   ARRAY['juvenile onset diabetes', 'insulin dependent diabetes', 'T1D', 'autoimmune diabetes', 'IDDM'])
ON CONFLICT (ailment_keyword) DO NOTHING;
