-- Migration 293: Class 65 — Fertility and Pregnancy
-- Files parsed:
--   BHC - Class 65 - Fertility and Pregnancy - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 65 - Fertility and Pregnancy - Lisa.md             (note_type = 'personal')
--   BHC - Class 65 - Fertility and Pregnancy - Transcript.md       (ignored per playbook)
--
-- Normalisations applied:
--   Vitex → Chasteberry (Vitex agnus-castus, id=190)
--   Dong quai / Angelica sinensis → Dong Quai (id=1009)
--   Urtica / nettles / Urtica urens → Nettle (Urtica dioica leaf, id=43)
--   Panax ginseng → Ginseng (Panax ginseng, id=14)
--   Viburnum opulus → Cramp Bark (id=93); V. prunifolium → Black Haw (id=94)
--   Ligusticum wallichii → Szechuan Lovage Root / Ligusticum (id=1525)
--   Milk oats / Milky Oats → Oat milky oats (Avena sativa, id=178)
--   Red Raspberry / raspberry leaf → Raspberry (Rubus idaeus leaf, id=155)
--   Reishi → Reishi Mushroom (Ganoderma lucidum, id=11)
--   Rose petal → Rose petal (id=850); rose hips → Rose hips (id=849)
--   Paeonia lactiflora / White Peony → White Peony (id=2238)
--   Salvia officinalis → Sage (id=56)
--   Serenoa repens → Saw Palmetto (id=186)
--   "Dragon" in Generated Notes fertility tea → unresolvable, skipped (Lisa's notes confirm Astragalus)
--   Astragalus listed in Lisa's notes for the same tea → Astragalus (id=225)
--
-- Keyword merge decisions:
--   "hormone balance" → existing 'hormonal support'
--   "uterine wellness" → existing 'uterine tonic'
--   "menorrhagia" → existing 'heavy bleeding'
--   "PMOS" → existing 'PCOS'
--   "insomnia" → existing 'sleep support'
--   "pre-eclampsia / preeclampsia" → new 'pregnancy support' (broader) + existing 'hypertension'
--   "nervine" → existing 'stress'
--   "cardioprotective" → existing 'cardiovascular disease'
--
-- Herbs skipped (not in DB):
--   Pomegranate, Black cherry, Goji berries (food/juice ingredients, Iron Tonic Syrup)
--   Dried apricots, Molasses (food items, Iron Tonic Syrup)
--   Carob, Cacao (food items, Lisa's tea)
--   Dragon (Generated Notes tea — unresolvable)
--   CBD (mentioned for nausea — not an herb in DB)
--   Ylang Ylang mentioned for miscarriage protocol in Generated Notes afternoon — it is in DB (id=745)
--     but note only says "Cramp Bark and Ylang Ylang" for smooth muscle antispasmodics without further detail;
--     included below in Miscarriage section of generated notes.

SET search_path TO herbal, public;

-- ============================================================
-- GUARD: skip if already loaded
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 65 - Fertility and Pregnancy'
      AND herb_id IS NOT NULL
  ) THEN
    RAISE NOTICE 'Class 65 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ============================================================
  -- GENERATED NOTES SNIPPETS
  -- ============================================================
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === Ginger (section: "Ginger") ===
  (124,
   'Ginger for bowel support — simple, accessible, moves naturally. Good for those who run cold.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Ginger', 10,
   '## Grand Floral Essential Oils and Ginger

- Grand Floral essential oils in Warrior blend (morning shift)
- Ginger for bowel support
	- Simple, accessible
	- Moves naturally
	- Good for those who run cold'),

  -- === Liver Health ===
  (122,
   'Liver support: dandelion root — used to support liver health for metabolising fats and hormones.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Liver Health', 20,
   '### Fats and Liver Health

- High-quality fats: olive oil, avocado
- Liver support: dandelion root, milk thistle
- Colorful vegetables for phytonutrients'),

  (206,
   'Milk thistle for liver support — aids in metabolising high-quality fats and processing hormones.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Liver Health', 30,
   '### Fats and Liver Health

- High-quality fats: olive oil, avocado
- Liver support: dandelion root, milk thistle
- Colorful vegetables for phytonutrients'),

  -- === Nutritional Herbs ===
  (155,
   'Red raspberry as a nutritional herb for fertility — complement with moistening herbs if needed.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nutritional Herbs', 40,
   '### Nutritional Herbs

- Red raspberry, lemon balm, red clover
	- Complement with moistening herbs if needed'),

  (134,
   'Lemon balm as a nutritional herb for fertility support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nutritional Herbs', 50,
   '### Nutritional Herbs

- Red raspberry, lemon balm, red clover
	- Complement with moistening herbs if needed'),

  (42,
   'Red clover as a nutritional herb for fertility support — complement with moistening herbs if needed.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nutritional Herbs', 60,
   '### Nutritional Herbs

- Red raspberry, lemon balm, red clover
	- Complement with moistening herbs if needed'),

  -- === Hormone Balance ===
  (1009,
   'Dong quai (emmenagogue) — used in the follicular phase (2 weeks) to build and stimulate circulation. Rotate with vitex bi-weekly for hormone balance.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Hormone Balance', 70,
   '### Adaptogens and Hormone Balance

- Support HPA axis, adaptogens for person-specific needs
- Balance follicular and luteal phases
	- Herbs: dong quai (emmenagogue) and vitex (dopamine agonist)
	- Rotate herbs bi-weekly'),

  (190,
   'Vitex (dopamine agonist) — targets the pituitary, used in the luteal phase (2 weeks). Rotate with dong quai bi-weekly for hormone balance.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Hormone Balance', 80,
   '### Adaptogens and Hormone Balance

- Support HPA axis, adaptogens for person-specific needs
- Balance follicular and luteal phases
	- Herbs: dong quai (emmenagogue) and vitex (dopamine agonist)
	- Rotate herbs bi-weekly'),

  -- === Fertility Tea ===
  (78,
   'Licorice in fertility tea — one of the legume-family herbs used for fertility support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Tea', 90,
   '## Tea for Fertility

- Ingredients for fertility tea
	- Dragon [unresolved herb, skipped]
	- Licorice
	- Alfalfa
	- Red clover
	- Yarrow if available'),

  (885,
   'Alfalfa in fertility tea — one of the legume-family herbs supportive for fertility.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Tea', 100,
   '## Tea for Fertility

- Ingredients for fertility tea
	- Dragon [unresolved herb, skipped]
	- Licorice
	- Alfalfa
	- Red clover
	- Yarrow if available'),

  (42,
   'Red clover in fertility tea — supportive for fertility.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Tea', 110,
   '## Tea for Fertility

- Ingredients for fertility tea
	- Dragon [unresolved herb, skipped]
	- Licorice
	- Alfalfa
	- Red clover
	- Yarrow if available'),

  (44,
   'Yarrow in fertility tea — included when available.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Tea', 120,
   '## Tea for Fertility

- Ingredients for fertility tea
	- Dragon [unresolved herb, skipped]
	- Licorice
	- Alfalfa
	- Red clover
	- Yarrow if available'),

  -- === Benefits and Actions (Morning 2) ===
  (885,
   'Alfalfa (Medicago) — highly nutritious, contains phytosterols and inositol, supports hormonal regulation.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Benefits and Actions', 130,
   '## Benefits and Actions

- Inositol
	- May improve insulin resistance
	- Supports fat metabolism
	- Anti-inflammatory
	- Anti-spasmodic on uterus
	- Reduces testosterone and prolactin
		- Reduces elevated testosterone
		- Restores menses
		- Alternative treatment to spironolactone

- **Alfalfa** (*Medicago*)
	- Highly nutritious
	- Contains phytosterols and inositol
	- Hormonal regulation

- **Red Clover**
	- Supports menopausal prevention
	- Blood mover for stagnation
		- Tendency towards clots and menses
	- Significant phytoestrogen capacity
		- Avoid in hyperestrogenic conditions
			- Ovarian cancer
			- Estrogen-responsive cancers
			- Endometrial hyperplasia'),

  (42,
   'Red clover — supports menopausal prevention, blood mover for stagnation (tendency toward clots and menses). Significant phytoestrogen capacity — avoid in hyperestrogenic conditions (ovarian cancer, estrogen-responsive cancers, endometrial hyperplasia).',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Benefits and Actions', 140,
   '## Benefits and Actions

- Inositol
	- May improve insulin resistance
	- Supports fat metabolism
	- Anti-inflammatory
	- Anti-spasmodic on uterus
	- Reduces testosterone and prolactin
		- Reduces elevated testosterone
		- Restores menses
		- Alternative treatment to spironolactone

- **Alfalfa** (*Medicago*)
	- Highly nutritious
	- Contains phytosterols and inositol
	- Hormonal regulation

- **Red Clover**
	- Supports menopausal prevention
	- Blood mover for stagnation
		- Tendency towards clots and menses
	- Significant phytoestrogen capacity
		- Avoid in hyperestrogenic conditions
			- Ovarian cancer
			- Estrogen-responsive cancers
			- Endometrial hyperplasia'),

  -- === Fertility Support (Morning 3) ===
  (14,
   'Panax ginseng — qi tonic, supports adrenal hormone. Caution: avoid if not well-nourished — can lead to burnout, nervous system wound too tight, jumpy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 150,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (93,
   'Cramp Bark (Viburnum opulus) — supports miscarriage-prone individuals as a smooth muscle antispasmodic.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 160,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (94,
   'Black Haw (Viburnum prunifolium) — supports miscarriage-prone individuals; useful for high blood pressure.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 170,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (42,
   'Red clover — prevention-oriented for miscarriage-prone individuals. Note: avoid Red Raspberry for miscarriage concerns as astringency can tighten the uterus.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 180,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (43,
   'Urtica (U. urens, U. dioica) — reduces elevated testosterone; high in protein, iron, vitamins, minerals. Used for PCOS/PMOS.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 190,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (186,
   'Saw Palmetto (Serenoa repens) — PCOS treatment for elevated testosterone.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 200,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (190,
   'Vitex — supports progesterone production. Used in PCOS treatments.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 210,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (56,
   'Salvia officinalis (Sage) — suppresses prolactin levels. Used in PCOS treatments.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 220,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  (1525,
   'Ligusticum wallichii — blood and yin tonic, nourishes the uterus. Used in PCOS treatments.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 230,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- **Ligusticum wallichii**
		- blood and yin tonic
		- nourishes uterus'),

  -- === Treatments During Pregnancy (nausea) ===
  (124,
   'Ginger for pregnancy nausea — tea, candy, or capsules. Effective for morning sickness.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nausea and Vomiting', 240,
   '## Treatments During Pregnancy

- Support with focus on nutrition
- Address nausea with:
	- snacks before rising
	- ginger tea, candy, capsules
	- CBD in small doses'),

  -- === Headaches and Cramps ===
  (55,
   'Peppermint for headaches and digestive symptoms during pregnancy — use as tea, avoid essential oil.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Headaches and Cramps', 250,
   '## Headaches and Cramps

- **Peppermint**
	- for headaches and digestive symptoms
	- avoid essential oil
- **Wild Yam**
	- smooth muscle antispasmodic
	- useful if history of pregnancy loss
- **Chamomile**
	- calming, anti-inflammatory
	- binds to GABA receptors for anxiety'),

  (74,
   'Wild yam — smooth muscle antispasmodic during pregnancy. Useful if history of pregnancy loss.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Headaches and Cramps', 260,
   '## Headaches and Cramps

- **Peppermint**
	- for headaches and digestive symptoms
	- avoid essential oil
- **Wild Yam**
	- smooth muscle antispasmodic
	- useful if history of pregnancy loss
- **Chamomile**
	- calming, anti-inflammatory
	- binds to GABA receptors for anxiety'),

  (84,
   'Chamomile — calming and anti-inflammatory during pregnancy; binds to GABA receptors for anxiety.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Headaches and Cramps', 270,
   '## Headaches and Cramps

- **Peppermint**
	- for headaches and digestive symptoms
	- avoid essential oil
- **Wild Yam**
	- smooth muscle antispasmodic
	- useful if history of pregnancy loss
- **Chamomile**
	- calming, anti-inflammatory
	- binds to GABA receptors for anxiety'),

  -- === Digestive Support and Iron ===
  (45,
   'Marshmallow root for constipation during pregnancy — moisturizes the bowel.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Digestive Support', 280,
   '## Digestive Support and Iron

- Constipation remedies:
	- marshmallow root (moisturizes bowel)
	- dandelion root
	- yellow dock (iron-rich, gentle)

- Iron-deficiency considerations
	- iron-rich foods: lentils, beef, molasses, dried figs, alfalfa
	- *Urtica* (nettles) for iron
	- avoid tannins, alkaloids, strong volatile oils'),

  (122,
   'Dandelion root for constipation during pregnancy — escalate from marshmallow root.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Digestive Support', 290,
   '## Digestive Support and Iron

- Constipation remedies:
	- marshmallow root (moisturizes bowel)
	- dandelion root
	- yellow dock (iron-rich, gentle)

- Iron-deficiency considerations
	- iron-rich foods: lentils, beef, molasses, dried figs, alfalfa
	- *Urtica* (nettles) for iron
	- avoid tannins, alkaloids, strong volatile oils'),

  (37,
   'Yellow dock — iron-rich and gentle laxative for constipation during pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Digestive Support', 300,
   '## Digestive Support and Iron

- Constipation remedies:
	- marshmallow root (moisturizes bowel)
	- dandelion root
	- yellow dock (iron-rich, gentle)

- Iron-deficiency considerations
	- iron-rich foods: lentils, beef, molasses, dried figs, alfalfa
	- *Urtica* (nettles) for iron
	- avoid tannins, alkaloids, strong volatile oils'),

  (43,
   'Urtica (nettles) for iron deficiency during pregnancy — avoid tannins, alkaloids, and strong volatile oils with iron supplementation.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Digestive Support', 310,
   '## Digestive Support and Iron

- Constipation remedies:
	- marshmallow root (moisturizes bowel)
	- dandelion root
	- yellow dock (iron-rich, gentle)

- Iron-deficiency considerations
	- iron-rich foods: lentils, beef, molasses, dried figs, alfalfa
	- *Urtica* (nettles) for iron
	- avoid tannins, alkaloids, strong volatile oils'),

  -- === Immune Support ===
  (26,
   'Echinacea — safe during pregnancy for immune support. Avoid roots; prefer nourishing broths as a more complete approach.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Immune Support', 320,
   '## Cold and Immune System Support

- **Echinacea**
	- safe during pregnancy
	- supports immune system
	- avoid roots, prefer nourishing broths'),

  -- === Blood Pressure in Pregnancy ===
  (93,
   'Cramp Bark for relaxation in hypertension during pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Blood Pressure in Pregnancy', 330,
   '## Blood Pressure in Pregnancy

- Monitor for increased blood volume, preeclampsia signs
- RhoGAM and **Cramp Bark** for relaxation in hypertension
- **Black cohosh** for blood pressure regulation
- Rest on the left side to improve circulation
- Signs of preeclampsia: protein in urine, headache, swelling
- Magnesium for seizures, poorly understood condition
- Protein and magnesium preventative'),

  (25,
   'Black cohosh for blood pressure regulation during pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Blood Pressure in Pregnancy', 340,
   '## Blood Pressure in Pregnancy

- Monitor for increased blood volume, preeclampsia signs
- RhoGAM and **Cramp Bark** for relaxation in hypertension
- **Black cohosh** for blood pressure regulation
- Rest on the left side to improve circulation
- Signs of preeclampsia: protein in urine, headache, swelling
- Magnesium for seizures, poorly understood condition
- Protein and magnesium preventative'),

  -- === Sleep and Insomnia ===
  (128,
   'California poppy for sleep support during and after pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Sleep and Insomnia', 350,
   '## Sleep and Insomnia

- Importance of sleep during and post-pregnancy
	- Nutritional adequacy critical
- Late-night carbohydrates and root vegetables for relaxation
- Herbs for sleep:
	- California poppy
	- Passionflower
	- Milk oats
- Rotating remedies to avoid adaptation
- Sleep hygiene: bath, meditation, journaling'),

  (137,
   'Passionflower for sleep support during and after pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Sleep and Insomnia', 360,
   '## Sleep and Insomnia

- Importance of sleep during and post-pregnancy
	- Nutritional adequacy critical
- Late-night carbohydrates and root vegetables for relaxation
- Herbs for sleep:
	- California poppy
	- Passionflower
	- Milk oats
- Rotating remedies to avoid adaptation
- Sleep hygiene: bath, meditation, journaling'),

  (178,
   'Milky oats for sleep support during and after pregnancy — rotate remedies to avoid adaptation.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Sleep and Insomnia', 370,
   '## Sleep and Insomnia

- Importance of sleep during and post-pregnancy
	- Nutritional adequacy critical
- Late-night carbohydrates and root vegetables for relaxation
- Herbs for sleep:
	- California poppy
	- Passionflower
	- Milk oats
- Rotating remedies to avoid adaptation
- Sleep hygiene: bath, meditation, journaling'),

  -- === Postpartum Care ===
  (850,
   'Rose petal for postpartum healing — used topically for tissue repair.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Postpartum Care', 380,
   '## Postpartum Care

- Proper planning during pregnancy for postpartum support
- Essentials:
	- Nutrition
	- Hydration
	- Rest
- Use of **rose petal**, **calendula**, **yarrow** for healing
- Postpartum community and doula support
- Traditional practices like cuarentena for recovery'),

  (70,
   'Calendula for postpartum healing — used topically for tissue repair.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Postpartum Care', 390,
   '## Postpartum Care

- Proper planning during pregnancy for postpartum support
- Essentials:
	- Nutrition
	- Hydration
	- Rest
- Use of **rose petal**, **calendula**, **yarrow** for healing
- Postpartum community and doula support
- Traditional practices like cuarentena for recovery'),

  (44,
   'Yarrow for postpartum healing — used topically for tissue repair.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Postpartum Care', 400,
   '## Postpartum Care

- Proper planning during pregnancy for postpartum support
- Essentials:
	- Nutrition
	- Hydration
	- Rest
- Use of **rose petal**, **calendula**, **yarrow** for healing
- Postpartum community and doula support
- Traditional practices like cuarentena for recovery'),

  -- === Labor and Childbirth — Miscarriage protocol ===
  (93,
   'Cramp Bark — smooth muscle antispasmodic for miscarriage protocol. Dosage: 1/2 to 1 tsp every 30–60 min.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Threatened Miscarriage', 410,
   '## Labor and Childbirth

- Miscarriage protocol using Cramp Bark and Ylang Ylang
	- Smooth muscle antispasmodics
	- Specific dosage instructions: 1/2 to 1 teaspoon every 30-60 min'),

  (745,
   'Ylang Ylang — smooth muscle antispasmodic included in miscarriage protocol alongside Cramp Bark.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Threatened Miscarriage', 420,
   '## Labor and Childbirth

- Miscarriage protocol using Cramp Bark and Ylang Ylang
	- Smooth muscle antispasmodics
	- Specific dosage instructions: 1/2 to 1 teaspoon every 30-60 min');

  -- ============================================================
  -- PERSONAL NOTES SNIPPETS (Lisa)
  -- ============================================================
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === Nutritional Herbs and Balance ===
  (155,
   'Red Raspberry as nutritional tea for fertility — mix in moistening herbs like Calendula if needed.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 10,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (70,
   'Calendula — used as a moistening herb alongside Red Raspberry in nutritional fertility teas.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 20,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (43,
   'Nettle as nutritional tea for fertility support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 30,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (2287,
   'Oat straw as nutritional tea for fertility support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 40,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (134,
   'Lemon balm as nutritional tea for fertility support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 50,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (42,
   'Red clover as nutritional tea for fertility support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 60,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (1009,
   'Dong Quai — anabolic, building and circulation stimulating. Used in follicular phase (2 weeks), then rotate with Vitex for hormone balance. Can be very effective.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 70,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  (190,
   'Vitex — targets the pituitary as a dopamine agonist, promotes a sense of safety for ovulation, calms elevated prolactin levels. Used in luteal phase (2 weeks), rotate with Dong Quai.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nutritional Herbs', 80,
   '## What to do when things are out of balance?
- Nutritional herbs
    - nutrient rich teas
        - Red Raspberry, but mix in moistening stuff, like Calendula
        - Nettle
        - Oat straw
        - Lemon Balm
        - Red Clover
- Nourish the HPA Axis
    - Adaptogens
    - be detailed about the perfect one for the person in front of you
    - are they dry, hot, sluggish?
- Balance Hormones
    - nourish the Follicular phase, and nourish the Luteal phase
        - Dong Quai (anabolic, building + circ stim), 2 weeks, Vitex (more targets the pituitary as a dopamine agonist - sense of safety to promote ovulation - can then calm elevated prolactin levels), 2 weeks, rotate
        - can be very effective
- Support Lifestyle changes (if needed)
    - specifically how are we nourishing the parasympathetic response?
    - rest and digest
    - feel the safety of that state, more spaciousness and relaxation'),

  -- === Fertility Tea (Lisa's) ===
  (225,
   'Astragalus in fertility tea — protects from oxidative stress, AI, circ stim, immune modulating. Supports sperm motility and semen quality. Contains isoflavones and saponin triterpenes (hormone modulating).',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Fertility Tea', 90,
   '## Tea
Astragalus
Licorice
Alfalfa
(wanted Red Clover)
(Carob would be nice)
(Cacao)
(Kudzu)
- all legumes - supportive for fertility

- legumes contain large amount of inositol
    - supports metabolic function

Astragalus
    - protects from oxidative stress
    - AI
    - circ stim
    - immune mod
    - supports sperm motility and semen quality
    - isofalvones + saponin triterpens (hormone mod)
Licorice
- adaptogen
- steroidal compounds supporting adrena function
- regulate cortisol levels
- saponins and inositol
- may improve insulin levels and support fat metabolism
- AI and AS on the uterus
- reduces testosterone and prolactin levels
- reduce elevated testosterone and restore menses

Alfalfa
- highly nutritive
- support hormone regulation and metabolism
- rich in chlorophyll
- cardioprotective
- if it''s not dried rich green, it''s not the best

Red Clover
- supportive for miscarriage prevention
- blood mover for stagnation and tendency toward clots
- significanyt phytoestrgenic capacity
    - avoid in cancer and endometriosis fibriods
        - also avoids hops for this reason

Kudzu
- rejuvenation tonic in Thailand
- ?? endocrine function'),

  (78,
   'Licorice — adaptogen; steroidal compounds support adrenal function; regulates cortisol; saponins and inositol; may improve insulin and fat metabolism; AI and antispasmodic on the uterus; reduces testosterone and prolactin; restores menses.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Fertility Tea', 100,
   '## Tea
Astragalus
Licorice
Alfalfa
(wanted Red Clover)
(Carob would be nice)
(Cacao)
(Kudzu)
- all legumes - supportive for fertility

- legumes contain large amount of inositol
    - supports metabolic function

Astragalus
    - protects from oxidative stress
    - AI
    - circ stim
    - immune mod
    - supports sperm motility and semen quality
    - isofalvones + saponin triterpens (hormone mod)
Licorice
- adaptogen
- steroidal compounds supporting adrena function
- regulate cortisol levels
- saponins and inositol
- may improve insulin levels and support fat metabolism
- AI and AS on the uterus
- reduces testosterone and prolactin levels
- reduce elevated testosterone and restore menses

Alfalfa
- highly nutritive
- support hormone regulation and metabolism
- rich in chlorophyll
- cardioprotective
- if it''s not dried rich green, it''s not the best

Red Clover
- supportive for miscarriage prevention
- blood mover for stagnation and tendency toward clots
- significanyt phytoestrgenic capacity
    - avoid in cancer and endometriosis fibriods
        - also avoids hops for this reason

Kudzu
- rejuvenation tonic in Thailand
- ?? endocrine function'),

  (885,
   'Alfalfa — highly nutritive, supports hormone regulation and metabolism, rich in chlorophyll, cardioprotective. Must be dried a rich green to be of good quality.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Fertility Tea', 110,
   '## Tea
Astragalus
Licorice
Alfalfa
(wanted Red Clover)
(Carob would be nice)
(Cacao)
(Kudzu)
- all legumes - supportive for fertility

- legumes contain large amount of inositol
    - supports metabolic function

Astragalus
    - protects from oxidative stress
    - AI
    - circ stim
    - immune mod
    - supports sperm motility and semen quality
    - isofalvones + saponin triterpens (hormone mod)
Licorice
- adaptogen
- steroidal compounds supporting adrena function
- regulate cortisol levels
- saponins and inositol
- may improve insulin levels and support fat metabolism
- AI and AS on the uterus
- reduces testosterone and prolactin levels
- reduce elevated testosterone and restore menses

Alfalfa
- highly nutritive
- support hormone regulation and metabolism
- rich in chlorophyll
- cardioprotective
- if it''s not dried rich green, it''s not the best

Red Clover
- supportive for miscarriage prevention
- blood mover for stagnation and tendency toward clots
- significanyt phytoestrgenic capacity
    - avoid in cancer and endometriosis fibriods
        - also avoids hops for this reason

Kudzu
- rejuvenation tonic in Thailand
- ?? endocrine function'),

  (42,
   'Red clover — supportive for miscarriage prevention; blood mover for stagnation and tendency toward clots; significant phytoestrogenic capacity — avoid in cancer and endometriosis/fibroids.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Fertility Tea', 120,
   '## Tea
Astragalus
Licorice
Alfalfa
(wanted Red Clover)
(Carob would be nice)
(Cacao)
(Kudzu)
- all legumes - supportive for fertility

- legumes contain large amount of inositol
    - supports metabolic function

Astragalus
    - protects from oxidative stress
    - AI
    - circ stim
    - immune mod
    - supports sperm motility and semen quality
    - isofalvones + saponin triterpens (hormone mod)
Licorice
- adaptogen
- steroidal compounds supporting adrena function
- regulate cortisol levels
- saponins and inositol
- may improve insulin levels and support fat metabolism
- AI and AS on the uterus
- reduces testosterone and prolactin levels
- reduce elevated testosterone and restore menses

Alfalfa
- highly nutritive
- support hormone regulation and metabolism
- rich in chlorophyll
- cardioprotective
- if it''s not dried rich green, it''s not the best

Red Clover
- supportive for miscarriage prevention
- blood mover for stagnation and tendency toward clots
- significanyt phytoestrgenic capacity
    - avoid in cancer and endometriosis fibriods
        - also avoids hops for this reason

Kudzu
- rejuvenation tonic in Thailand
- ?? endocrine function'),

  (1547,
   'Kudzu — rejuvenation tonic (Thailand); possible endocrine function support.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Fertility Tea', 130,
   '## Tea
Astragalus
Licorice
Alfalfa
(wanted Red Clover)
(Carob would be nice)
(Cacao)
(Kudzu)
- all legumes - supportive for fertility

- legumes contain large amount of inositol
    - supports metabolic function

Astragalus
    - protects from oxidative stress
    - AI
    - circ stim
    - immune mod
    - supports sperm motility and semen quality
    - isofalvones + saponin triterpens (hormone mod)
Licorice
- adaptogen
- steroidal compounds supporting adrena function
- regulate cortisol levels
- saponins and inositol
- may improve insulin levels and support fat metabolism
- AI and AS on the uterus
- reduces testosterone and prolactin levels
- reduce elevated testosterone and restore menses

Alfalfa
- highly nutritive
- support hormone regulation and metabolism
- rich in chlorophyll
- cardioprotective
- if it''s not dried rich green, it''s not the best

Red Clover
- supportive for miscarriage prevention
- blood mover for stagnation and tendency toward clots
- significanyt phytoestrgenic capacity
    - avoid in cancer and endometriosis fibriods
        - also avoids hops for this reason

Kudzu
- rejuvenation tonic in Thailand
- ?? endocrine function'),

  -- === Materia Medica (Lisa) ===
  (1009,
   'Angelica sinensis / Dong Quai — classic fertility herb.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 140,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (14,
   'Panax ginseng — caution if not well-resourced; can be a shortcut to burnout. Use carefully in fertility context.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 150,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (93,
   'Cramp Bark (Viburnum opulus) — for those prone to miscarriages. Avoid Red Raspberry for miscarriage-prone patients (astringency can tighten uterus). Take if miscarriage sensations begin.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 160,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (94,
   'Black Haw (Viburnum prunifolium) — for miscarriage-prone patients; preferred over Cramp Bark if high blood pressure is also present.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 170,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (43,
   'Urtica (nettles) — for suspected anovulatory issues; helps with elevated testosterone and PCOS/PMOS hormone regulation issues. Used as food, vinegar, or tea.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 180,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (186,
   'Saw Palmetto (Serenoa repens) — for elevated testosterone in PCOS/PMOS.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 190,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (190,
   'Vitex agnus-castus — fertility support (mechanism under investigation in notes).',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 200,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (56,
   'Sage (Salvia officinalis) — suppresses prolactin levels. Also used after pregnancy loss to dry up lactation.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 210,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  (2238,
   'White Peony (Paeonia lactiflora) — blood and yin tonic; mast cell stabilizing; calms fibroblast production.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Materia Medica', 220,
   '## Materia medica
- Angelica sinensis
    - Dong quai
- Panax ginseng
    - caution if not well-resourced
    - shortcut to burnout
    - jumpy
- Viburnum opulus
    - Cramp Bark and Black Haw (also Wild Yam)
        - Black Haw if high BP issues as well
    - for those prone to miscarriages
        - very much avoid Red Raspberry - astringency can tighten the uterus
    - take after pregnancy, if start to have miscarriage sensations
- Urtica urens, U. dioica
    - nettles, if suspect anovulatory issues
    - help with elevated testosterone
        - with the hormone regulation issues of PMOS
    - as a food, vinegar, tea
- Serenoa repens
    - Saw Palmetto, also if elevated testosterone
- Vitex agnus-castus
    - support ??
- Salvia officinalis
    - Sage
    - suppress prolactin levels
- Paeonia lactiflora
    - White Peony
    - blood and yin tonic
    - mast cell stabilizing
    - calms fibroblast production'),

  -- === Nausea and Vomiting (Lisa) ===
  (124,
   'Ginger for morning sickness — sips of tea, candies, or capsules; rotate the type of preparation.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nausea and Vomiting', 230,
   '### Nausea and vomiting
- morning sickness: digestive secretions increase overnight
- effective to have a snack right by the bed, for when wake up
- can interrupt this morning sickness cycle
- if herbs needed:
    - Ginger - sips of tea, candies, capsules
        - can rotate the type of preparation
    - Peppermint
        - for delicate pregnancies
        - tea, glycerite, avoid EO'),

  (55,
   'Peppermint for morning sickness in delicate pregnancies — tea or glycerite; avoid essential oil.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Nausea and Vomiting', 240,
   '### Nausea and vomiting
- morning sickness: digestive secretions increase overnight
- effective to have a snack right by the bed, for when wake up
- can interrupt this morning sickness cycle
- if herbs needed:
    - Ginger - sips of tea, candies, capsules
        - can rotate the type of preparation
    - Peppermint
        - for delicate pregnancies
        - tea, glycerite, avoid EO'),

  -- === Stomach Cramps (Lisa) ===
  (84,
   'Chamomile for stomach cramps in pregnancy — nip in the bud to prevent triggering uterine cramps.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Stomach Cramps', 250,
   '### Stomach Cramps
- nip these in the bud, can trigger uterine cramps
- herbs:
    - Chamomile
    - Peppermint
    - Wild Yam, if those not successful, or if history of miscarriage, jump right here'),

  (55,
   'Peppermint for stomach cramps in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Stomach Cramps', 260,
   '### Stomach Cramps
- nip these in the bud, can trigger uterine cramps
- herbs:
    - Chamomile
    - Peppermint
    - Wild Yam, if those not successful, or if history of miscarriage, jump right here'),

  (74,
   'Wild yam for stomach cramps in pregnancy — escalate if chamomile/peppermint insufficient, or jump directly here if history of miscarriage.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Stomach Cramps', 270,
   '### Stomach Cramps
- nip these in the bud, can trigger uterine cramps
- herbs:
    - Chamomile
    - Peppermint
    - Wild Yam, if those not successful, or if history of miscarriage, jump right here'),

  -- === Digestive Support (Lisa) ===
  (45,
   'Marshmallow root for digestive support in pregnancy — nourishing and moistening the bowel.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Digestive Support', 280,
   '### Digestive support
- herbs:
    - marshmallow root - nourishing and moistening the bowel
    - dandelion root - escalate to here
    - yellow dock - finally, escalate to here
        - get sufficient iron, and gentle laxative'),

  (122,
   'Dandelion root for constipation in pregnancy — escalate from marshmallow root.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Digestive Support', 290,
   '### Digestive support
- herbs:
    - marshmallow root - nourishing and moistening the bowel
    - dandelion root - escalate to here
    - yellow dock - finally, escalate to here
        - get sufficient iron, and gentle laxative'),

  (37,
   'Yellow dock for constipation in pregnancy — iron-rich and gentle laxative; final escalation from marshmallow root and dandelion.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Digestive Support', 300,
   '### Digestive support
- herbs:
    - marshmallow root - nourishing and moistening the bowel
    - dandelion root - escalate to here
    - yellow dock - finally, escalate to here
        - get sufficient iron, and gentle laxative'),

  -- === Heartburn (Lisa) ===
  (45,
   'Marshmallow root for heartburn in pregnancy — soothing, anti-inflammatory, mucilaginous; helps when stomach acids migrate up.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Heartburn', 310,
   '### Heartburn
- herbs:
    - marshmallow root - stomach acids can migrate up
        - soothing AI and mucilage'),

  -- === Anemia (Lisa) ===
  (885,
   'Alfalfa for anemia support in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Anemia', 320,
   '### Anemia
- first start with iron rich foods
    - lentils (legumes)
    - pumpkin seeds
    - beets
    - molasses
    - dried figs
        - stewed fruits
- herbs:
    - alfalfa
    - nettles
    - yellow dock
    - red raspberry'),

  (43,
   'Nettles for anemia support in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Anemia', 330,
   '### Anemia
- first start with iron rich foods
    - lentils (legumes)
    - pumpkin seeds
    - beets
    - molasses
    - dried figs
        - stewed fruits
- herbs:
    - alfalfa
    - nettles
    - yellow dock
    - red raspberry'),

  (37,
   'Yellow dock for anemia support in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Anemia', 340,
   '### Anemia
- first start with iron rich foods
    - lentils (legumes)
    - pumpkin seeds
    - beets
    - molasses
    - dried figs
        - stewed fruits
- herbs:
    - alfalfa
    - nettles
    - yellow dock
    - red raspberry'),

  (155,
   'Red raspberry for anemia support in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Anemia', 350,
   '### Anemia
- first start with iron rich foods
    - lentils (legumes)
    - pumpkin seeds
    - beets
    - molasses
    - dried figs
        - stewed fruits
- herbs:
    - alfalfa
    - nettles
    - yellow dock
    - red raspberry'),

  -- === Immune Support (Lisa) ===
  (26,
   'Echinacea for immune support in pregnancy — super safe, can take proactively; nourishing broths are more complete.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Immune Support', 360,
   '### Immune support
- not good to be sick and have to give birth, so try and avoid that
- herbs:
    - echinacea
        - super safe, can take it proactively, but nourishing broths more complete
    - usnea
        - safe and penetrating to the tissues
- avoid anything with tannins, alkaloids, too much volatile oils (peppermint on the edge)'),

  (112,
   'Usnea for immune support in pregnancy — safe and penetrating to the tissues.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Immune Support', 370,
   '### Immune support
- not good to be sick and have to give birth, so try and avoid that
- herbs:
    - echinacea
        - super safe, can take it proactively, but nourishing broths more complete
    - usnea
        - safe and penetrating to the tissues
- avoid anything with tannins, alkaloids, too much volatile oils (peppermint on the edge)'),

  -- === Iron Tonic Syrup (Lisa) ===
  (43,
   'Nettle (4 T dried) — ingredient in Iron Tonic Syrup for pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Iron Tonic Syrup', 380,
   '## Iron Tonic Syrup
- 4 T dried nettle
- 3 T alfalfa
- 2 T raspberry leaf
- 1 T dried yellow dock
- 1 T hawthorn berries
- 1 T goji berries
- 1 tsp rose hips
- 1/2 c dried apricots
- 2 c molasses
- 1 c organic pomegranate or black cherry concentrate (not juice)

- keep in fridge, last a few weeks before fermenting'),

  (885,
   'Alfalfa (3 T) — ingredient in Iron Tonic Syrup for pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Iron Tonic Syrup', 390,
   '## Iron Tonic Syrup
- 4 T dried nettle
- 3 T alfalfa
- 2 T raspberry leaf
- 1 T dried yellow dock
- 1 T hawthorn berries
- 1 T goji berries
- 1 tsp rose hips
- 1/2 c dried apricots
- 2 c molasses
- 1 c organic pomegranate or black cherry concentrate (not juice)

- keep in fridge, last a few weeks before fermenting'),

  (155,
   'Raspberry leaf (2 T) — ingredient in Iron Tonic Syrup for pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Iron Tonic Syrup', 400,
   '## Iron Tonic Syrup
- 4 T dried nettle
- 3 T alfalfa
- 2 T raspberry leaf
- 1 T dried yellow dock
- 1 T hawthorn berries
- 1 T goji berries
- 1 tsp rose hips
- 1/2 c dried apricots
- 2 c molasses
- 1 c organic pomegranate or black cherry concentrate (not juice)

- keep in fridge, last a few weeks before fermenting'),

  (37,
   'Yellow dock (1 T dried) — ingredient in Iron Tonic Syrup for pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Iron Tonic Syrup', 410,
   '## Iron Tonic Syrup
- 4 T dried nettle
- 3 T alfalfa
- 2 T raspberry leaf
- 1 T dried yellow dock
- 1 T hawthorn berries
- 1 T goji berries
- 1 tsp rose hips
- 1/2 c dried apricots
- 2 c molasses
- 1 c organic pomegranate or black cherry concentrate (not juice)

- keep in fridge, last a few weeks before fermenting'),

  (73,
   'Hawthorn berries (1 T) — ingredient in Iron Tonic Syrup for pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Iron Tonic Syrup', 420,
   '## Iron Tonic Syrup
- 4 T dried nettle
- 3 T alfalfa
- 2 T raspberry leaf
- 1 T dried yellow dock
- 1 T hawthorn berries
- 1 T goji berries
- 1 tsp rose hips
- 1/2 c dried apricots
- 2 c molasses
- 1 c organic pomegranate or black cherry concentrate (not juice)

- keep in fridge, last a few weeks before fermenting'),

  (849,
   'Rose hips (1 tsp) — ingredient in Iron Tonic Syrup for pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Iron Tonic Syrup', 430,
   '## Iron Tonic Syrup
- 4 T dried nettle
- 3 T alfalfa
- 2 T raspberry leaf
- 1 T dried yellow dock
- 1 T hawthorn berries
- 1 T goji berries
- 1 tsp rose hips
- 1/2 c dried apricots
- 2 c molasses
- 1 c organic pomegranate or black cherry concentrate (not juice)

- keep in fridge, last a few weeks before fermenting'),

  -- === Blood Pressure in Pregnancy (Lisa) ===
  (73,
   'Hawthorn (decoction) — first-line herb for blood pressure in pregnancy to avoid preeclampsia.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Blood Pressure in Pregnancy', 440,
   '### Reduce Blood Pressure
- increased blood volume moving through the system
- want to make sure not too much pressure on the systems of the body
- want to avoid pre-eclampsia
- "left side lie"
    - circulation of the blood at its most unencumbered
    - 10 mins, if high BP doesn''t abate, proceed with clinical assessment of preeclampsia
    - treatment is magnesium
    - sufficient protein can calm the body ahead of time, avoid the whole thing
- herbs:
    - Hawthorn
        - decoction
    - Reishi
        - next choice
        - research on beneficial effects of hypertension
        - part. protective against oxidative stress
        - metabolize some of the endocrine disrupting chemicals
        - use just as food, not powders, during pregnancies
            - mushrooms can be a little hard on the liver to process
    - Cramp Bark
        - relax the tissues
    - Black Haw
        - first choice over Cramp Bark'),

  (11,
   'Reishi — second choice for hypertension in pregnancy. Research supports beneficial effects; partially protective against oxidative stress; helps metabolize endocrine-disrupting chemicals. Use as food (not powders) during pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Blood Pressure in Pregnancy', 450,
   '### Reduce Blood Pressure
- increased blood volume moving through the system
- want to make sure not too much pressure on the systems of the body
- want to avoid pre-eclampsia
- "left side lie"
    - circulation of the blood at its most unencumbered
    - 10 mins, if high BP doesn''t abate, proceed with clinical assessment of preeclampsia
    - treatment is magnesium
    - sufficient protein can calm the body ahead of time, avoid the whole thing
- herbs:
    - Hawthorn
        - decoction
    - Reishi
        - next choice
        - research on beneficial effects of hypertension
        - part. protective against oxidative stress
        - metabolize some of the endocrine disrupting chemicals
        - use just as food, not powders, during pregnancies
            - mushrooms can be a little hard on the liver to process
    - Cramp Bark
        - relax the tissues
    - Black Haw
        - first choice over Cramp Bark'),

  (93,
   'Cramp Bark for hypertension in pregnancy — relaxes the tissues.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Blood Pressure in Pregnancy', 460,
   '### Reduce Blood Pressure
- increased blood volume moving through the system
- want to make sure not too much pressure on the systems of the body
- want to avoid pre-eclampsia
- "left side lie"
    - circulation of the blood at its most unencumbered
    - 10 mins, if high BP doesn''t abate, proceed with clinical assessment of preeclampsia
    - treatment is magnesium
    - sufficient protein can calm the body ahead of time, avoid the whole thing
- herbs:
    - Hawthorn
        - decoction
    - Reishi
        - next choice
        - research on beneficial effects of hypertension
        - part. protective against oxidative stress
        - metabolize some of the endocrine disrupting chemicals
        - use just as food, not powders, during pregnancies
            - mushrooms can be a little hard on the liver to process
    - Cramp Bark
        - relax the tissues
    - Black Haw
        - first choice over Cramp Bark'),

  (94,
   'Black Haw — first choice over Cramp Bark for hypertension in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Blood Pressure in Pregnancy', 470,
   '### Reduce Blood Pressure
- increased blood volume moving through the system
- want to make sure not too much pressure on the systems of the body
- want to avoid pre-eclampsia
- "left side lie"
    - circulation of the blood at its most unencumbered
    - 10 mins, if high BP doesn''t abate, proceed with clinical assessment of preeclampsia
    - treatment is magnesium
    - sufficient protein can calm the body ahead of time, avoid the whole thing
- herbs:
    - Hawthorn
        - decoction
    - Reishi
        - next choice
        - research on beneficial effects of hypertension
        - part. protective against oxidative stress
        - metabolize some of the endocrine disrupting chemicals
        - use just as food, not powders, during pregnancies
            - mushrooms can be a little hard on the liver to process
    - Cramp Bark
        - relax the tissues
    - Black Haw
        - first choice over Cramp Bark'),

  -- === Sleep and Insomnia (Lisa) ===
  (128,
   'California Poppy for insomnia in pregnancy — rotate remedies once no longer effective.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Sleep and Insomnia', 480,
   '### Insomnia
- want people to be well-rested at birth time
- slow carbs nice in the evening
- unless you figure out the issue, your body will overcome the remedy
    - so rotate as soon as it''s not as effective
- herbs:
    - California Poppy
    - Passionflower
    - Milky Oats
    - Lemon Balm
    - Chamomile'),

  (137,
   'Passionflower for insomnia in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Sleep and Insomnia', 490,
   '### Insomnia
- want people to be well-rested at birth time
- slow carbs nice in the evening
- unless you figure out the issue, your body will overcome the remedy
    - so rotate as soon as it''s not as effective
- herbs:
    - California Poppy
    - Passionflower
    - Milky Oats
    - Lemon Balm
    - Chamomile'),

  (178,
   'Milky Oats for insomnia in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Sleep and Insomnia', 500,
   '### Insomnia
- want people to be well-rested at birth time
- slow carbs nice in the evening
- unless you figure out the issue, your body will overcome the remedy
    - so rotate as soon as it''s not as effective
- herbs:
    - California Poppy
    - Passionflower
    - Milky Oats
    - Lemon Balm
    - Chamomile'),

  (134,
   'Lemon Balm for insomnia in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Sleep and Insomnia', 510,
   '### Insomnia
- want people to be well-rested at birth time
- slow carbs nice in the evening
- unless you figure out the issue, your body will overcome the remedy
    - so rotate as soon as it''s not as effective
- herbs:
    - California Poppy
    - Passionflower
    - Milky Oats
    - Lemon Balm
    - Chamomile'),

  (84,
   'Chamomile for insomnia in pregnancy.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Sleep and Insomnia', 520,
   '### Insomnia
- want people to be well-rested at birth time
- slow carbs nice in the evening
- unless you figure out the issue, your body will overcome the remedy
    - so rotate as soon as it''s not as effective
- herbs:
    - California Poppy
    - Passionflower
    - Milky Oats
    - Lemon Balm
    - Chamomile'),

  -- === Threatened Miscarriage (Lisa) ===
  (93,
   'Cramp Bark for threatened miscarriage — 2 parts, combined with 1 part Wild Yam. Dose: 1/2–1 tsp every 30–60 min for up to 4 hours; repeat up to 2x/day for up to 3 days.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Threatened Miscarriage', 530,
   '### Threatened miscarriage
- want to calm the uterus with smooth muscle antispasmodics
- herbs:
    - 2p Cramp Bark
    - 1p Wild Yam
    - 1/2 - 1 tsp every 30-60 mins for up to 4 hours
        - depends on severity of the symptoms
    - repeat up to 2x in a day for up to 3 days
    - if you get to more than once per day or more than 1 day, likelihood of pregnancy loss
    - shot of whiskey also helps'),

  (74,
   'Wild Yam for threatened miscarriage — 1 part, combined with 2 parts Cramp Bark. Autonomic nerve relaxant, smooth muscle antispasmodic.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Threatened Miscarriage', 540,
   '### Threatened miscarriage
- want to calm the uterus with smooth muscle antispasmodics
- herbs:
    - 2p Cramp Bark
    - 1p Wild Yam
    - 1/2 - 1 tsp every 30-60 mins for up to 4 hours
        - depends on severity of the symptoms
    - repeat up to 2x in a day for up to 3 days
    - if you get to more than once per day or more than 1 day, likelihood of pregnancy loss
    - shot of whiskey also helps'),

  -- === Pregnancy Loss (Lisa) ===
  (155,
   'Red Raspberry after pregnancy loss — to tonify the uterus.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Pregnancy Loss', 550,
   '## Pregnancy Loss
- Miscarriage
- Abortion
- Late term loss
- goals:
    - tending the heart
    - thinking about the tissues
        - tonify the uterus
        - Red Raspberry
    - support the nervous system
    - make sure the body has enough nourishment to recover
    - Sage = specific for drying up the lactation'),

  (56,
   'Sage — specific for drying up lactation after pregnancy loss.',
   'BHC - Class 65 - Fertility and Pregnancy', 'personal', 'Pregnancy Loss', 560,
   '## Pregnancy Loss
- Miscarriage
- Abortion
- Late term loss
- goals:
    - tending the heart
    - thinking about the tissues
        - tonify the uterus
        - Red Raspberry
    - support the nervous system
    - make sure the body has enough nourishment to recover
    - Sage = specific for drying up the lactation');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS (separate guard)
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE supplement_id IS NOT NULL
      AND class_name = 'BHC - Class 65 - Fertility and Pregnancy'
  ) THEN
    RAISE NOTICE 'Class 65 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  (35,
   'Inositol — found in legumes; supports metabolic function, insulin resistance, hormone imbalance, PCOS. May improve insulin resistance, fat metabolism; AI and antispasmodic on the uterus; reduces elevated testosterone and prolactin; restores menses. Alternative to spironolactone.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Legumes and Fertility Support', 10,
   '## Legumes and Fertility Support

- Legumes for fertility
	- Contain inositol
		- Important for:
			- metabolic function
			- insulin resistance
			- hormone imbalance
			- support for PCOS'),

  (23,
   'Selenium supplementation recommended for fertility — along with zinc and vitamin D.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nutritional Guidelines', 20,
   '### Hydration and Gut Health

- Warm, cooked foods
	- Nourish digestive/reproductive hearth
- Fermented vegetables for microbiome
- Selenium, zinc, vitamin D supplementation'),

  (24,
   'Zinc supplementation recommended for fertility — along with selenium and vitamin D.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nutritional Guidelines', 30,
   '### Hydration and Gut Health

- Warm, cooked foods
	- Nourish digestive/reproductive hearth
- Fermented vegetables for microbiome
- Selenium, zinc, vitamin D supplementation'),

  (11,
   'Vitamin D supplementation recommended for fertility — along with selenium and zinc.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Nutritional Guidelines', 40,
   '### Hydration and Gut Health

- Warm, cooked foods
	- Nourish digestive/reproductive hearth
- Fermented vegetables for microbiome
- Selenium, zinc, vitamin D supplementation'),

  (19,
   'Iron — ferrous sulfate prescribed in pregnancy is extremely constipating; liquid iron preferred. Vitamin C enhances absorption; calcium blocks it.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Iron Absorption', 50,
   '## Iron Absorption

- Importance of vitamin C with iron
	- Calcium blocks iron absorption
- Ferrous sulfate prescribed in pregnancy
	- Causes constipation
- Liquid iron support as an alternative
	- Pomegranate paste as an iron source'),

  (21,
   'Magnesium — used for seizures in preeclampsia (poorly understood condition). Protein and magnesium preventative for preeclampsia.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Blood Pressure in Pregnancy', 60,
   '## Blood Pressure in Pregnancy

- Monitor for increased blood volume, preeclampsia signs
- Magnesium for seizures, poorly understood condition
- Protein and magnesium preventative');

END $$;

-- ============================================================
-- HERB KEYWORDS
-- ============================================================

-- Ginger
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'morning sickness', 'ailment'),
  (124, 'nausea', 'symptom'),
  (124, 'pregnancy support', 'ailment'),
  (124, 'digestive tonic', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dandelion root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (122, 'liver support', 'ailment'),
  (122, 'constipation', 'ailment'),
  (122, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Milk Thistle
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (206, 'liver support', 'ailment'),
  (206, 'fat metabolism', 'action'),
  (206, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Raspberry leaf
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (155, 'fertility support', 'ailment'),
  (155, 'anemia', 'ailment'),
  (155, 'iron deficiency', 'ailment'),
  (155, 'uterine tonic', 'ailment'),
  (155, 'postpartum support', 'ailment'),
  (155, 'pregnancy loss', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lemon Balm
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (134, 'fertility support', 'ailment'),
  (134, 'sleep support', 'ailment'),
  (134, 'stress', 'ailment'),
  (134, 'anxiety', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Clover
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (42, 'fertility support', 'ailment'),
  (42, 'hormonal support', 'ailment'),
  (42, 'heavy bleeding', 'ailment'),
  (42, 'endometriosis', 'ailment'),
  (42, 'fibroids', 'ailment'),
  (42, 'perimenopause', 'ailment'),
  (42, 'blood stagnation', 'action'),
  (42, 'phytoestrogen', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dong Quai
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1009, 'fertility support', 'ailment'),
  (1009, 'hormonal support', 'ailment'),
  (1009, 'emmenagogue', 'action'),
  (1009, 'circulation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chasteberry / Vitex
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (190, 'fertility support', 'ailment'),
  (190, 'hormonal support', 'ailment'),
  (190, 'PCOS', 'ailment'),
  (190, 'pituitary support', 'ailment'),
  (190, 'hyperprolactinemia', 'ailment'),
  (190, 'progesterone support', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alfalfa
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (885, 'fertility support', 'ailment'),
  (885, 'anemia', 'ailment'),
  (885, 'iron deficiency', 'ailment'),
  (885, 'hormonal support', 'ailment'),
  (885, 'nutritional support', 'general'),
  (885, 'cardiovascular disease', 'ailment'),
  (885, 'PCOS', 'ailment'),
  (885, 'SIBO', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginseng (Panax)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14, 'fertility support', 'ailment'),
  (14, 'adrenal fatigue', 'ailment'),
  (14, 'energy support', 'ailment'),
  (14, 'qi tonic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cramp Bark
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (93, 'threatened miscarriage', 'ailment'),
  (93, 'hypertension', 'ailment'),
  (93, 'muscle spasms', 'ailment'),
  (93, 'dysmenorrhea', 'ailment'),
  (93, 'smooth muscle antispasmodic', 'action'),
  (93, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Black Haw
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (94, 'threatened miscarriage', 'ailment'),
  (94, 'hypertension', 'ailment'),
  (94, 'muscle spasms', 'ailment'),
  (94, 'dysmenorrhea', 'ailment'),
  (94, 'smooth muscle antispasmodic', 'action'),
  (94, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle (leaf)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43, 'anemia', 'ailment'),
  (43, 'iron deficiency', 'ailment'),
  (43, 'PCOS', 'ailment'),
  (43, 'low testosterone', 'ailment'),
  (43, 'fertility support', 'ailment'),
  (43, 'nutritional support', 'general'),
  (43, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Saw Palmetto
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (186, 'PCOS', 'ailment'),
  (186, 'low testosterone', 'ailment'),
  (186, 'hyperprolactinemia', 'ailment'),
  (186, 'fertility support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Sage
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (56, 'hyperprolactinemia', 'ailment'),
  (56, 'hormonal support', 'ailment'),
  (56, 'PCOS', 'ailment'),
  (56, 'postpartum support', 'ailment'),
  (56, 'pregnancy loss', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Szechuan Lovage Root / Ligusticum wallichii
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1525, 'fertility support', 'ailment'),
  (1525, 'uterine tonic', 'ailment'),
  (1525, 'PCOS', 'ailment'),
  (1525, 'blood stagnation', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Peppermint
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (55, 'morning sickness', 'ailment'),
  (55, 'nausea', 'symptom'),
  (55, 'headache', 'ailment'),
  (55, 'digestive tonic', 'ailment'),
  (55, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wild Yam
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (74, 'threatened miscarriage', 'ailment'),
  (74, 'muscle spasms', 'ailment'),
  (74, 'smooth muscle antispasmodic', 'action'),
  (74, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chamomile
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (84, 'morning sickness', 'ailment'),
  (84, 'nausea', 'symptom'),
  (84, 'anxiety', 'ailment'),
  (84, 'sleep support', 'ailment'),
  (84, 'inflammation', 'ailment'),
  (84, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Marshmallow
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'constipation', 'ailment'),
  (45, 'heartburn', 'symptom'),
  (45, 'digestive tonic', 'ailment'),
  (45, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yellow Dock
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (37, 'anemia', 'ailment'),
  (37, 'iron deficiency', 'ailment'),
  (37, 'constipation', 'ailment'),
  (37, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Echinacea
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26, 'immune support', 'ailment'),
  (26, 'pregnancy support', 'ailment'),
  (26, 'common cold', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Black Cohosh
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (25, 'hypertension', 'ailment'),
  (25, 'hormonal support', 'ailment'),
  (25, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- California Poppy
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (128, 'sleep support', 'ailment'),
  (128, 'anxiety', 'ailment'),
  (128, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Passionflower
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (137, 'sleep support', 'ailment'),
  (137, 'anxiety', 'ailment'),
  (137, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Milky Oats
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (178, 'sleep support', 'ailment'),
  (178, 'stress', 'ailment'),
  (178, 'anxiety', 'ailment'),
  (178, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oat Straw
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2287, 'fertility support', 'ailment'),
  (2287, 'nutritional support', 'general'),
  (2287, 'stress', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'postpartum support', 'ailment'),
  (70, 'wound healing', 'ailment'),
  (70, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Astragalus
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (225, 'fertility support', 'ailment'),
  (225, 'immune support', 'ailment'),
  (225, 'inflammation', 'ailment'),
  (225, 'circulation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Licorice
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78, 'fertility support', 'ailment'),
  (78, 'hormonal support', 'ailment'),
  (78, 'adrenal fatigue', 'ailment'),
  (78, 'PCOS', 'ailment'),
  (78, 'insulin resistance', 'ailment'),
  (78, 'hyperprolactinemia', 'ailment'),
  (78, 'fat metabolism', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Kudzu Root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1547, 'hormonal support', 'ailment'),
  (1547, 'fertility support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- White Peony
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2238, 'fertility support', 'ailment'),
  (2238, 'hormonal support', 'ailment'),
  (2238, 'mast cell activation syndrome', 'ailment'),
  (2238, 'blood stagnation', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Usnea
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (112, 'immune support', 'ailment'),
  (112, 'pregnancy support', 'ailment'),
  (112, 'antimicrobial', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hawthorn berry
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (73, 'hypertension', 'ailment'),
  (73, 'cardiovascular disease', 'ailment'),
  (73, 'pregnancy support', 'ailment'),
  (73, 'iron deficiency', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi Mushroom
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11, 'hypertension', 'ailment'),
  (11, 'cardiovascular disease', 'ailment'),
  (11, 'pregnancy support', 'ailment'),
  (11, 'antioxidant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose petal
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (850, 'postpartum support', 'ailment'),
  (850, 'wound healing', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rose hips
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (849, 'iron deficiency', 'ailment'),
  (849, 'anemia', 'ailment'),
  (849, 'pregnancy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yarrow
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44, 'postpartum support', 'ailment'),
  (44, 'wound healing', 'ailment'),
  (44, 'fertility support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ylang Ylang
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (745, 'threatened miscarriage', 'ailment'),
  (745, 'smooth muscle antispasmodic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- SUPPLEMENT KEYWORDS
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (35, 'fertility support', 'ailment'),
  (35, 'PCOS', 'ailment'),
  (35, 'insulin resistance', 'ailment'),
  (35, 'hormonal support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (23, 'fertility support', 'ailment'),
  (23, 'antioxidant', 'action')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (24, 'fertility support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (11, 'fertility support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (19, 'anemia', 'ailment'),
  (19, 'iron deficiency', 'ailment'),
  (19, 'pregnancy support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (21, 'hypertension', 'ailment'),
  (21, 'pregnancy support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- AILMENT SEARCH SYNONYMS
-- New ailment keywords introduced by this class:
--   fertility support, threatened miscarriage, morning sickness,
--   pregnancy support, postpartum support, hyperprolactinemia,
--   pregnancy loss, anemia (already keyword, missing from search terms)
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('fertility support',
   ARRAY['infertility', 'conception support', 'trying to conceive', 'TTC', 'subfertility', 'anovulation']),
  ('threatened miscarriage',
   ARRAY['miscarriage prevention', 'pregnancy loss prevention', 'spotting in pregnancy', 'uterine cramping in pregnancy', 'premature labor risk']),
  ('morning sickness',
   ARRAY['pregnancy nausea', 'nausea of pregnancy', 'hyperemesis gravidarum', 'vomiting in pregnancy', 'first trimester nausea']),
  ('pregnancy support',
   ARRAY['prenatal support', 'herbs during pregnancy', 'safe herbs for pregnancy', 'antenatal support', 'pregnancy wellness']),
  ('postpartum support',
   ARRAY['after birth recovery', 'postnatal support', 'postpartum recovery', 'after delivery', 'fourth trimester', 'new parent support']),
  ('hyperprolactinemia',
   ARRAY['high prolactin', 'elevated prolactin', 'prolactin excess', 'galactorrhea', 'prolactin dysregulation']),
  ('pregnancy loss',
   ARRAY['miscarriage recovery', 'after miscarriage', 'after abortion', 'stillbirth recovery', 'uterine recovery after loss']),
  ('anemia',
   ARRAY['low hemoglobin', 'low iron anemia', 'iron deficiency anemia', 'blood deficiency', 'low red blood cells'])
ON CONFLICT (ailment_keyword) DO NOTHING;
