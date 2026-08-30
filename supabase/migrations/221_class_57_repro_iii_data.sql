-- Migration 221: Class 57 Repro III — snippets, keywords, ailment search synonyms
-- Files parsed:
--   BHC - Class 57 - Repro III - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 57 - Repro III - Lisa.md             (note_type = 'personal')
-- Herb normalisations:
--   Vitex                    → Chasteberry (Vitex agnus-castus, id=190)
--   Nettles / Urtica spp.    → Nettle (Urtica dioica, leaf, id=43)
--   Oat Straw                → Oat (Avena sativa, straw, id=2287)
--   Milky oats / milky oat tops → Oat (Avena sativa, milky oats, id=178)
--   Dong quai / Angelica sinensis → Dong Quai (id=1009)
--   Angelica (warming bitter, digestive) → Angelica archangelica (id=65)
--   Tulsi                    → Holy Basil (Ocimum sanctum, id=13)
--   Schisandra               → Schizandra (Schisandra chinensis, id=17)
--   Althaea bark/flowers     → Marshmallow (Althaea officinalis, id=45)
--   Dogwood                  → Jamaica Dogwood (Piscidia erythrina, id=139)
--   Red raspberry leaf       → Raspberry (Rubus idaeus, leaf, id=155)
--   White peony root         → White Peony (Paeonia lactiflora, root, id=2238)
--   Hawthorn (tea)           → Hawthorn berry (Crataegus spp., id=73)
--   Panax ginseng            → Ginseng (Panax ginseng, id=14)
--   Blackberry root          → Blackberry (Rubus villosus, id=156)
-- Skipped (not in DB):
--   Saffron (Crocus sativus) — not in herb DB
--   Flower essences (blackberry, rose) — not medicinal herbs
-- Section header cleaning:
--   "## Cold Infusions and Temperatures" + "## Uses of Marshmallow Root" both precede the
--     marshmallow herb; snippets attributed to 'Marshmallow Root' section
--   "## Secondary Dysmenorrhea" + "### Helpful Herbs" + "### Role of Calcium" → 'Dysmenorrhea'
--   "## Herbs for Nervous System and Hormonal Support" + "## Hormonal and Sleep Concerns" → 'Nervous System and Hormonal Support'
--   "## Stress, Burnout, and Focus" → 'Stress and Burnout'
--   "### Sleep and Relaxation Support" + "### Sleep and Tea Rituals" → 'Sleep and Relaxation Support'
--   "## Formula Adjustments and Feedback" + "## Clinical Observations and Recommendations" + "## Nervous System and Anxiety" → 'Nervine and Adaptogen Support'
--   "## Formula and Supplementation" → 'PCOS and Blood Sugar'
--   "## ADHD and Long-Term Management" + "### Herbs and Nutrients for ADHD" → 'ADHD'
--   "### Support with herbs" (personal) → 'Adolescent Support'
--   "### Self Care for Fibroids" + "### Formula for Fibroids" (personal) → 'Fibroids' (merged)
-- Merge decisions (existing ailment keywords):
--   menorrhagia → use existing 'heavy bleeding' keyword
--   uterine tone → use existing 'uterine tonic' keyword
--   neuroinflammation → use existing 'inflammation' keyword

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────
-- Snippets
-- ─────────────────────────────────────────────
DO $$
DECLARE
  v_class TEXT := 'BHC - Class 57 - Repro III';

  -- Generated note source blocks
  v_gen_marsh_block TEXT;
  v_gen_teen_block  TEXT;
  v_gen_amen_block  TEXT;
  v_gen_dysmen_block TEXT;
  v_gen_menor_block  TEXT;
  v_gen_fibroid_block TEXT;
  v_gen_endo_block   TEXT;
  v_gen_nshormon_block TEXT;
  v_gen_stress_block TEXT;
  v_gen_sleep_block  TEXT;
  v_gen_bitters_block TEXT;
  v_gen_nootropic_block TEXT;
  v_gen_nervine_block TEXT;
  v_gen_intentional_block TEXT;
  v_gen_pcos_block   TEXT;
  v_gen_adhd_block   TEXT;

  -- Personal note source blocks
  v_per_teen_block   TEXT;
  v_per_amen_block   TEXT;
  v_per_dysmen_block TEXT;
  v_per_menor_block  TEXT;
  v_per_fibroid_block TEXT;
  v_per_endo_block   TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = 'BHC - Class 57 - Repro III') THEN
    RAISE NOTICE 'Class 57 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ── Generated note source blocks ──────────────────────────────────────────

  v_gen_marsh_block := $blk$## Cold Infusions and Temperatures
- Michael Moore's recommendation: cold or room temperature
- Cold often better — puts ice cube on herb, produces rich mucopolysaccharide

## Uses of Marshmallow Root
- Short shelf life (starches and sugars limit preservation; unlike flax, less sugar)
- Community healer's approach
- High desert dehydration remedy$blk$;

  v_gen_teen_block := $blk$### Key Herbs for Teens

- **Lemon Balm**
	- Supports high anxiety
	- Mood elevator
	- Calcium and magnesium content
	- Helps with restlessness, insomnia, PMS

- **Nettles**
	- Infusion or food
	- Rich in nutrients (vitamin A, C, D, E, K)
	- Protein content
	- Supports menstrual cycle, slows bleeding

- **Raspberry Leaf**
	- Combines with nettle for heavy bleeding
	- Nutrient profile includes vitamin A, C, E, calcium, iron, zinc

- **Oats / Oat Straw**
	- Nutritive
	- High in silica
	- Supports hair, nails, bones$blk$;

  v_gen_amen_block := $blk$### Amenorrhea

- Lack of menstruation (primary vs. secondary)
- Check for stress, body fat, HPA axis, thyroid issues
- A cold atonic condition requiring warming, stimulant, and tonifying herbs

### Herbs for Support
- **Vitex** for hormonal regulation
- **Cinnamon** for blood sugar regulation and uterine tone
- **Cramp Bark** for uterine pain relief$blk$;

  v_gen_dysmen_block := $blk$## Secondary Dysmenorrhea
* Starts in third or fourth decade of life
* Associated with endometriosis, ovarian cysts
* Pain usually first 1–3 days of menstruation

### Helpful Herbs
* **Cramp bark** — smooth muscle antispasmodic
* **Black cohosh** — analgesic for pain
* **Motherwort** — sedative

### Role of Calcium
* Modulates pain perception
* Deficiency linked to more painful cycles
	* Calcium-rich plants: **lemon balm**
* Omega-3s support essential fatty acids
* Stretching, pelvic exercises, improve circulation$blk$;

  v_gen_menor_block := $blk$## Menorrhagia
* Heavy bleeding: longer than 7–8 days or soaking pad < 2 hours
* Causes: dysfunctional uterine bleeding, fibroids, PMDD, nutrient deficiencies

### Supporting Tools
* Confirm ovulation: use **Vitex**
* Fibroids: self-palpation for uterine swelling
	* Supported by **Yarrow** and **Nettles** — reduce blood flow
	* **Cinnamon** — reduces flow (strong decoction or essential oil in emergencies)$blk$;

  v_gen_fibroid_block := $blk$## Fibroids
* Benign uterine tumors
* High prevalence — 75% in menstruating individuals
* Risk factors: excess estrogen, nutritional deficiencies (vitamin D, fiber)

### Self-Care
* Balance estrogen
* Increase gut support, exercise, fiber intake
* Helpful herbs:
	* **Yarrow**, **Black cohosh**, **Licorice**, **White peony**, **Cinnamon**, **Vitex**, **Red clover**$blk$;

  v_gen_endo_block := $blk$## Endometriosis
* Hot inflammatory condition
* Endometrium outside uterus; scar tissue causing damage

### Self-Care for Endometriosis
* Anti-inflammatories, dietary fiber, massage
* Pain relieving herbs:
	* **Ginger root**, **Dogwood**, **Cramp bark**, **Devil's claw**, **Turmeric**

### Formula Adjustment
* Cooling inflammation with **turmeric** in place of **cinnamon**
* Add **Gotu kola** for scar tissue support$blk$;

  v_gen_nshormon_block := $blk$## Herbs for Nervous System and Hormonal Support

- **Dong quai** — moves through periods of stagnation; suggested for hormonal support
- **Ashwagandha** — adaptogenic; regulates HPA axis; move to nervine formula for consistent use
- Nervine formula: **Milky oats**, Tulsi, gotu kola — focus on anxiety and sleep
- **Valerian** for digestion issues (separate use)

## Hormonal and Sleep Concerns

- **Gotu kola and bacopa** — nootropic herbs; memory and focus; calm neuroinflammation
- **Tulsi** — adaptogen, carminative, regulates blood sugar, supports HPA axis
- Bitter tincture: **Artichoke leaf** or *Angelica archangelica* for digestive support$blk$;

  v_gen_stress_block := $blk$## Stress, Burnout, and Focus

- Anxiety and sleep formula:
	- **California poppy**, **passionflower**, **skullcap**, **lemon balm**
	- Focus on releasing tension and anxiety

- Constitutional support tincture:
	- **Ashwagandha**, **milky oats**, **gotu kola**, **bacopa**, **Tulsi**
	- Address blood sugar dysregulation

- Digestive support infusion:
	- **Catnip**, **fennel**, **chamomile**, **nettle**, **oat straw**
	- Nurturing and nutritive focus$blk$;

  v_gen_sleep_block := $blk$**Sleep and Relaxation Support:**
- **Tulsi** — adaptogen; blood sugar stabilization; cognition support
- **Angelica sinensis** — calms nerves and mind rebuilding
- **Skullcap** — relaxing nervine
- **Althaea** bark and flowers — grounding and uplifting

**Sleep and Tea Rituals:**
- **Valerian** for heavy sedative effect (separate if necessary)
- **Gotu kola** for cognitive support; anti-inflammatory
- **Passionflower** for relaxing effects$blk$;

  v_gen_bitters_block := $blk$### Bitters and Nervines
- **Angelica** 30 ml — warming bitter, mild nervine — used for hormone balancing
- **Lemon balm** 15 ml — digestive and nervine — indicated for nervousness$blk$;

  v_gen_nootropic_block := $blk$## Other Recommended Supplements
- **Ginkgo** for nootropic effects, best as standardized extract
- **Ashwagandha**, vitamin D, and **schisandra** for daily support$blk$;

  v_gen_nervine_block := $blk$**Adaptogen and Nervine Recommendations:**
- **Ashwagandha** as a modulating adaptogen
- **Gotu kola** for stress response; improves focus
- **Panax ginseng** for brain fog — noted as possibly too stimulating

**Dietary and Supplement Adjustments:**
- **Motherwort** as a bitter
- **Turmeric** for GI and liver support
- **Blackberry root** for diarrhea only when needed

**Nervine for Emotional Depletion:**
- **Skullcap** relaxant for decision-making paralysis
- **Milky oats** for mental scatter and exhaustion
- **Motherwort** for negative self-talk

**Nutritional and Supportive Herbs:**
- **Milky oat tops** and **oat straw** for nervous support
- **Nettles** and **oat straw** for mineral-rich infusions
- **Passionflower** to calm and aid circular thinking
- Enhance formulas with **lemon balm** for carminative effects

**Nervous System and Anxiety:**
- Nervine trophorestoratives for regulation — e.g., **Skullcap**
- HPA axis support with adaptogens$blk$;

  v_gen_intentional_block := $blk$## Plant Spirit Medicine and Intentional Herbalism

- Importance of how plants grow and adapt
- **Lemon balm** adapts to environments
- Grounding with roots like **ashwagandha**
- **Chamomile** hot infusion more sedative
	- Cold infusion less sleepy
	- Consider with sleep patterns$blk$;

  v_gen_pcos_block := $blk$## Formula and Supplementation

- Custom formula "Temple of Devotion":
	- **Schisandra** for liver and energy
	- **Bacopa** for focus and anxiety
	- **Fenugreek** and **bitter melon** for blood sugar
	- **Dong quai** for blood movement
- Incorporate tea: tulsi, linden, hawthorn
- Supplements: vitamin D, omega-3s

## ADHD and Long-Term Management

- Nootropic and nervine herbs: **Bacopa**, **Schisandra**, **Tulsi**
- Gut health and dysbiosis
- PCOS: linked to blood sugar; HPA and hormonal cascade$blk$;

  v_gen_adhd_block := $blk$### Herbs and Nutrients for ADHD

- **Schisandra**, **Bacopa** for ADHD symptoms
- **Ginkgo**, **Tulsi** for focus
- **White peony root** for mood and hormonal support
- Nervines: **milky oats**, **chamomile**, **hawthorn**, **ashwagandha**$blk$;

  -- ── Personal note source blocks ───────────────────────────────────────────

  v_per_teen_block := $blk$### Support with herbs
- keep it simple — body is trying to get its own adulthood cycle
- herbs:
    - Melissa (Lemon Balm)
        - can improve mood and cognitive function
        - rich in calcium and Mg — support for secondary ossification
        - specific for restlessness and insomnia
        - Menarche support
    - Urtica spp (Nettles)
        - infusion and as a food (soups)
        - rich in nutrients, 30% is protein
        - Vit A C D E Omega3,6, K, B-complex, Mg Ca Selenium, Zn and Fe
        - menstrual cycle heavy? helpful to slow bleeding — hemostatic
    - Red Rasp leaf
        - good alone or with nettle — menstrual cramps
        - Vit A C E, Ca, Fe and Potassium
        - generally a uterine tonic; very astringent
    - Oat straw
        - nutritive, high in silica (hair, nails, bones)
        - as a tea; make sure it is still green
        - Milky Oats better for degradation (e.g. MS), not initial building$blk$;

  v_per_amen_block := $blk$### Herbs for Amenorrhea
- Vitex: Promote hormone regulation
    VITEX AGNUS-CASTUS SEEDS. Tincture [1:5, 65% alcohol] 30–60 drops.
    Ground Berries 1/2–1 tsp. in tea, both 1× day in the morning.
    - if trying to establish bi-phasic cycle: Dong Quai 2 weeks then Vitex 2 weeks
    - or just Vitex to get the cycle going

- Cinnamon: Improve pelvic circulation and uterine tone
    CINNAMOMUM BARK. Standard Infusion 2–4 oz. Tincture [1:5, 60% alc, 5% glycerin] 20–50 drops, to 4× a day.

- Crampbark: Relieve pelvic tension
    VIBURNUM (V. opulus, V. prunifolium). Cold Infusion or Strong Decoction, 3–4 oz to 4× a day.
    Tincture [1:5, 50% alcohol] 30–90 drops to 4× a day.

- Red Raspberry Leaf: Improve nutrition
    RUBUS IDAEUS LEAVES. Infusion as needed.
    - tone while bringing nourishment to the body

- Ginger: warming for cold atonic amenorrhea — fresh or dry$blk$;

  v_per_dysmen_block := $blk$### Herbs for dysmenorrhea

Spasmodic Dysmenorrhea:
- Crampbark: Antispasmodic
    VIBURNUM ROOTBARK and BARK. Cold Infusion or Strong Decoction, 3–4 oz to 4× a day.
    Tincture [1:5, 50% alcohol] 30–90 drops to 4× a day.
- Black Cohosh: Anodyne
    CIMICIFUGA RACEMOSA RHIZOME and ROOT. Tincture [Fresh 1:2, Dry 1:5, 80% alc.], 10–25 drops.
    Capsules #00, 1–2, both to 3× a day.
- Motherwort: Sedative
    LEONURUS CARDIACA FLOWERING HERB. Tincture [Fresh 1:2, Dry 1:5, 60% alc.] 30–60 drops to 4× a day.
    Standard Infusion, 2–4 oz.

- calcium — modifies pain perception; deficiency → more painful cycles; calcium-rich = lemon balm
- Omega-3s and essential fatty acids = supportive$blk$;

  v_per_menor_block := $blk$### Herbs for menorrhagia
- Vitex: Hormone Regulator
    VITEX AGNUS-CASTUS SEEDS. Tincture [1:5, 65% alc.] 30–60 drops. Ground Berries 1/2–1 tsp. once in morning.
- Yarrow: Hemostatic, Reduce blood flow
    ACHILLEA WHOLE FLOWERING PLANT. Tincture [FRESH 1:2, DRY 1:5, 50% alc.] 10–40 drops. Infusion 2–4 oz.
- Nettles: Reduce blood flow, Nourishment
    URTICA WHOLE HERB. Cold or Standard infusion, as needed.
- Cinnamon — reduce flow in the moment — strong decoction; 1 drop EO under tongue in emergency
- An-ovulation → beta-carotene$blk$;

  v_per_fibroid_block := $blk$**Self Care for Fibroids:**
- methylation, Rosmarinic acid → Rosemary, Tulsi, Lemon Balm

**Formula for Fibroids:**
- Vitex could be a possibility
- Red Clover = blood mover for stasis, isoflavones, enhance progesterone$blk$;

  v_per_endo_block := $blk$### A formula for Endometriosis
- add Gotu kola for extracellular matrix support$blk$;

  -- ═══════════════════════════════════════════
  -- Generated notes snippets
  -- ═══════════════════════════════════════════

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Marshmallow Root
  (45,  'Marshmallow root cold infusion: produces rich mucopolysaccharide; short shelf life due to starches and sugars; high desert dehydration remedy.',
   v_class, 'generated', 'Marshmallow Root', 10, v_gen_marsh_block),

  -- Adolescent Support
  (134, 'Lemon Balm — supports high anxiety and mood elevation; calcium and magnesium content; helps with restlessness, insomnia, PMS; menarche support.',
   v_class, 'generated', 'Adolescent Support', 10, v_gen_teen_block),
  (43,  'Nettles — infusion or food; rich in vitamins A, C, D, E, K and protein; supports menstrual cycle; hemostatic, slows bleeding.',
   v_class, 'generated', 'Adolescent Support', 20, v_gen_teen_block),
  (155, 'Raspberry Leaf — combines with nettle for heavy bleeding in teens; vitamins A, C, E, calcium, iron, zinc.',
   v_class, 'generated', 'Adolescent Support', 30, v_gen_teen_block),
  (2287,'Oat Straw — nutritive; high in silica; supports hair, nails, bones during puberty.',
   v_class, 'generated', 'Adolescent Support', 40, v_gen_teen_block),

  -- Amenorrhea
  (190, 'Vitex — hormonal regulation for amenorrhea; establishes bi-phasic cycle.',
   v_class, 'generated', 'Amenorrhea', 10, v_gen_amen_block),
  (167, 'Cinnamon — blood sugar regulation and uterine tone for amenorrhea.',
   v_class, 'generated', 'Amenorrhea', 20, v_gen_amen_block),
  (93,  'Cramp Bark — uterine pain relief for amenorrhea; cold atonic condition.',
   v_class, 'generated', 'Amenorrhea', 30, v_gen_amen_block),

  -- Dysmenorrhea
  (93,  'Cramp Bark — smooth muscle antispasmodic for dysmenorrhea.',
   v_class, 'generated', 'Dysmenorrhea', 10, v_gen_dysmen_block),
  (25,  'Black Cohosh — analgesic/anodyne for dysmenorrhea pain.',
   v_class, 'generated', 'Dysmenorrhea', 20, v_gen_dysmen_block),
  (131, 'Motherwort — sedative for dysmenorrhea.',
   v_class, 'generated', 'Dysmenorrhea', 30, v_gen_dysmen_block),
  (134, 'Lemon Balm — calcium-rich; modulates pain perception; calcium deficiency linked to more painful cycles.',
   v_class, 'generated', 'Dysmenorrhea', 40, v_gen_dysmen_block),

  -- Menorrhagia
  (190, 'Vitex — hormone regulator for menorrhagia; confirms ovulation.',
   v_class, 'generated', 'Menorrhagia', 10, v_gen_menor_block),
  (44,  'Yarrow — hemostatic; reduces blood flow for menorrhagia; paired with nettles.',
   v_class, 'generated', 'Menorrhagia', 20, v_gen_menor_block),
  (43,  'Nettles — reduce blood flow and provide nourishment for menorrhagia.',
   v_class, 'generated', 'Menorrhagia', 30, v_gen_menor_block),
  (167, 'Cinnamon — reduces flow in the moment; strong decoction or 1 drop EO under tongue in emergency.',
   v_class, 'generated', 'Menorrhagia', 40, v_gen_menor_block),

  -- Fibroids
  (44,  'Yarrow — self-care herb for fibroids; reduces blood flow.',
   v_class, 'generated', 'Fibroids', 10, v_gen_fibroid_block),
  (25,  'Black Cohosh — helpful herb for fibroids.',
   v_class, 'generated', 'Fibroids', 20, v_gen_fibroid_block),
  (78,  'Licorice — helpful herb for fibroids; estrogen modulation.',
   v_class, 'generated', 'Fibroids', 30, v_gen_fibroid_block),
  (2238,'White Peony — helpful herb for fibroids.',
   v_class, 'generated', 'Fibroids', 40, v_gen_fibroid_block),
  (167, 'Cinnamon — helpful herb for fibroids.',
   v_class, 'generated', 'Fibroids', 50, v_gen_fibroid_block),
  (190, 'Vitex — helpful herb for fibroids; estrogen balance.',
   v_class, 'generated', 'Fibroids', 60, v_gen_fibroid_block),
  (42,  'Red Clover — helpful herb for fibroids; isoflavones; blood mover for stasis.',
   v_class, 'generated', 'Fibroids', 70, v_gen_fibroid_block),

  -- Endometriosis
  (124, 'Ginger root — pain-relieving herb for endometriosis.',
   v_class, 'generated', 'Endometriosis', 10, v_gen_endo_block),
  (139, 'Jamaica Dogwood — pain-relieving herb for endometriosis.',
   v_class, 'generated', 'Endometriosis', 20, v_gen_endo_block),
  (93,  'Cramp Bark — pain relief for endometriosis.',
   v_class, 'generated', 'Endometriosis', 30, v_gen_endo_block),
  (80,  'Devil''s Claw — anti-inflammatory pain relief for endometriosis.',
   v_class, 'generated', 'Endometriosis', 40, v_gen_endo_block),
  (203, 'Turmeric — anti-inflammatory for endometriosis; replaces cinnamon to cool inflammation.',
   v_class, 'generated', 'Endometriosis', 50, v_gen_endo_block),
  (2229,'Gotu Kola — scar tissue support; extracellular matrix for endometriosis.',
   v_class, 'generated', 'Endometriosis', 60, v_gen_endo_block),

  -- Nervous System and Hormonal Support
  (1009,'Dong Quai — moves through periods of stagnation; hormonal support.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 10, v_gen_nshormon_block),
  (20,  'Ashwagandha — adaptogenic; regulates HPA axis; consistent nervine formula use.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 20, v_gen_nshormon_block),
  (178, 'Milky Oats — nervine formula for anxiety and sleep.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 30, v_gen_nshormon_block),
  (13,  'Tulsi (Holy Basil) — adaptogen; carminative; regulates blood sugar; supports HPA axis.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 40, v_gen_nshormon_block),
  (145, 'Valerian — digestive issues (separate use); heavy sedative effect.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 50, v_gen_nshormon_block),
  (2229,'Gotu Kola — nootropic; memory and focus; calms neuroinflammation.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 60, v_gen_nshormon_block),
  (2381,'Bacopa — nootropic; memory and focus; calms neuroinflammation.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 70, v_gen_nshormon_block),
  (172, 'Artichoke — bitter tincture for digestive support.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 80, v_gen_nshormon_block),
  (65,  'Angelica (archangelica) — bitter tincture for digestive support; warming bitter, mild nervine.',
   v_class, 'generated', 'Nervous System and Hormonal Support', 90, v_gen_nshormon_block),

  -- Stress and Burnout
  (128, 'California Poppy — anxiety and sleep formula; releasing tension and anxiety.',
   v_class, 'generated', 'Stress and Burnout', 10, v_gen_stress_block),
  (137, 'Passionflower — anxiety and sleep formula; relaxing effects.',
   v_class, 'generated', 'Stress and Burnout', 20, v_gen_stress_block),
  (142, 'Skullcap — anxiety and sleep formula; releasing tension.',
   v_class, 'generated', 'Stress and Burnout', 30, v_gen_stress_block),
  (134, 'Lemon Balm — anxiety and sleep formula; carminative.',
   v_class, 'generated', 'Stress and Burnout', 40, v_gen_stress_block),
  (20,  'Ashwagandha — constitutional support tincture; blood sugar dysregulation.',
   v_class, 'generated', 'Stress and Burnout', 50, v_gen_stress_block),
  (178, 'Milky Oats — constitutional support tincture.',
   v_class, 'generated', 'Stress and Burnout', 60, v_gen_stress_block),
  (2229,'Gotu Kola — constitutional support; stress response; improves focus.',
   v_class, 'generated', 'Stress and Burnout', 70, v_gen_stress_block),
  (2381,'Bacopa — constitutional support tincture; blood sugar dysregulation.',
   v_class, 'generated', 'Stress and Burnout', 80, v_gen_stress_block),
  (13,  'Tulsi — constitutional support; blood sugar and HPA axis.',
   v_class, 'generated', 'Stress and Burnout', 90, v_gen_stress_block),
  (136, 'Catnip — digestive support infusion; nurturing and nutritive.',
   v_class, 'generated', 'Stress and Burnout', 100, v_gen_stress_block),
  (76,  'Fennel — digestive support infusion.',
   v_class, 'generated', 'Stress and Burnout', 110, v_gen_stress_block),
  (84,  'Chamomile — digestive support infusion; nutritive.',
   v_class, 'generated', 'Stress and Burnout', 120, v_gen_stress_block),
  (43,  'Nettle — digestive support infusion; nutritive.',
   v_class, 'generated', 'Stress and Burnout', 130, v_gen_stress_block),
  (2287,'Oat Straw — digestive support infusion; nutritive.',
   v_class, 'generated', 'Stress and Burnout', 140, v_gen_stress_block),

  -- Sleep and Relaxation Support
  (13,  'Tulsi — adaptogen; blood sugar stabilization; cognition support for sleep and relaxation.',
   v_class, 'generated', 'Sleep and Relaxation Support', 10, v_gen_sleep_block),
  (1009,'Dong Quai (Angelica sinensis) — calms nerves and mind rebuilding; sleep and relaxation.',
   v_class, 'generated', 'Sleep and Relaxation Support', 20, v_gen_sleep_block),
  (142, 'Skullcap — relaxing nervine for sleep.',
   v_class, 'generated', 'Sleep and Relaxation Support', 30, v_gen_sleep_block),
  (45,  'Marshmallow (Althaea bark and flowers) — grounding and uplifting; sleep and relaxation support.',
   v_class, 'generated', 'Sleep and Relaxation Support', 40, v_gen_sleep_block),
  (145, 'Valerian — heavy sedative effect; use separately if needed.',
   v_class, 'generated', 'Sleep and Relaxation Support', 50, v_gen_sleep_block),
  (2229,'Gotu Kola — cognitive support; anti-inflammatory; sleep formula.',
   v_class, 'generated', 'Sleep and Relaxation Support', 60, v_gen_sleep_block),
  (137, 'Passionflower — relaxing effects; aids circular thinking; sleep formula.',
   v_class, 'generated', 'Sleep and Relaxation Support', 70, v_gen_sleep_block),

  -- Bitters and Nervines
  (65,  'Angelica (archangelica) 30 ml — warming bitter, mild nervine; hormone balancing.',
   v_class, 'generated', 'Bitters and Nervines', 10, v_gen_bitters_block),
  (134, 'Lemon Balm 15 ml — digestive and nervine; indicated for nervousness.',
   v_class, 'generated', 'Bitters and Nervines', 20, v_gen_bitters_block),

  -- Nootropic Support
  (165, 'Ginkgo — nootropic effects; best as standardized extract.',
   v_class, 'generated', 'Nootropic Support', 10, v_gen_nootropic_block),
  (17,  'Schizandra — daily support; liver and energy.',
   v_class, 'generated', 'Nootropic Support', 20, v_gen_nootropic_block),

  -- Nervine and Adaptogen Support
  (20,  'Ashwagandha — modulating adaptogen for emotional depletion and burnout.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 10, v_gen_nervine_block),
  (2229,'Gotu Kola — stress response; improves focus.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 20, v_gen_nervine_block),
  (14,  'Panax Ginseng — brain fog; possibly too stimulating.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 30, v_gen_nervine_block),
  (131, 'Motherwort — bitter; for negative self-talk; emotional depletion.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 40, v_gen_nervine_block),
  (203, 'Turmeric — GI and liver support; formula adjustments.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 50, v_gen_nervine_block),
  (156, 'Blackberry root — for diarrhea only when needed.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 60, v_gen_nervine_block),
  (142, 'Skullcap — decision-making paralysis; nervine trophorestorative.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 70, v_gen_nervine_block),
  (178, 'Milky Oats — mental scatter and exhaustion; nervous system support.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 80, v_gen_nervine_block),
  (2287,'Oat Straw — mineral-rich infusions; nervous system support.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 90, v_gen_nervine_block),
  (43,  'Nettle — mineral-rich infusions for nervous system.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 100, v_gen_nervine_block),
  (137, 'Passionflower — calm and aid circular thinking.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 110, v_gen_nervine_block),
  (134, 'Lemon Balm — carminative; enhances nervine formulas.',
   v_class, 'generated', 'Nervine and Adaptogen Support', 120, v_gen_nervine_block),

  -- Intentional Herbalism
  (84,  'Chamomile — hot infusion more sedative; cold infusion less sleepy; consider preparation method with sleep patterns.',
   v_class, 'generated', 'Intentional Herbalism', 10, v_gen_intentional_block),

  -- PCOS and Blood Sugar (Temple of Devotion formula)
  (17,  'Schizandra — "Temple of Devotion" PCOS formula; liver and energy.',
   v_class, 'generated', 'PCOS and Blood Sugar', 10, v_gen_pcos_block),
  (2381,'Bacopa — "Temple of Devotion" PCOS formula; focus and anxiety.',
   v_class, 'generated', 'PCOS and Blood Sugar', 20, v_gen_pcos_block),
  (91,  'Fenugreek — "Temple of Devotion" PCOS formula; blood sugar regulation.',
   v_class, 'generated', 'PCOS and Blood Sugar', 30, v_gen_pcos_block),
  (2556,'Bitter Melon — "Temple of Devotion" PCOS formula; blood sugar regulation.',
   v_class, 'generated', 'PCOS and Blood Sugar', 40, v_gen_pcos_block),
  (1009,'Dong Quai — "Temple of Devotion" PCOS formula; blood movement.',
   v_class, 'generated', 'PCOS and Blood Sugar', 50, v_gen_pcos_block),
  (13,  'Tulsi — tea blend for PCOS formula; adaptogen.',
   v_class, 'generated', 'PCOS and Blood Sugar', 60, v_gen_pcos_block),
  (90,  'Linden — tea blend for PCOS formula.',
   v_class, 'generated', 'PCOS and Blood Sugar', 70, v_gen_pcos_block),
  (73,  'Hawthorn berry — tea blend for PCOS formula; nervine.',
   v_class, 'generated', 'PCOS and Blood Sugar', 80, v_gen_pcos_block),

  -- ADHD
  (2381,'Bacopa — ADHD symptoms; focus and cognitive support.',
   v_class, 'generated', 'ADHD', 10, v_gen_adhd_block),
  (17,  'Schizandra — ADHD symptoms; cognitive support.',
   v_class, 'generated', 'ADHD', 20, v_gen_adhd_block),
  (165, 'Ginkgo — focus for ADHD.',
   v_class, 'generated', 'ADHD', 30, v_gen_adhd_block),
  (13,  'Tulsi — focus and adaptogenic support for ADHD.',
   v_class, 'generated', 'ADHD', 40, v_gen_adhd_block),
  (2238,'White Peony root — mood and hormonal support in ADHD context.',
   v_class, 'generated', 'ADHD', 50, v_gen_adhd_block),
  (178, 'Milky Oats — nervine for ADHD; mental scatter.',
   v_class, 'generated', 'ADHD', 60, v_gen_adhd_block),
  (84,  'Chamomile — nervine for ADHD; calming.',
   v_class, 'generated', 'ADHD', 70, v_gen_adhd_block),
  (73,  'Hawthorn berry — nervine for ADHD; calming.',
   v_class, 'generated', 'ADHD', 80, v_gen_adhd_block),
  (20,  'Ashwagandha — nervine/adaptogen for ADHD.',
   v_class, 'generated', 'ADHD', 90, v_gen_adhd_block),

  -- ═══════════════════════════════════════════
  -- Personal notes snippets
  -- ═══════════════════════════════════════════

  -- Adolescent Support
  (134, 'Melissa (Lemon Balm) — mood and cognitive function; calcium and Mg for secondary ossification; specific for restlessness, insomnia; menarche support.',
   v_class, 'personal', 'Adolescent Support', 10, v_per_teen_block),
  (43,  'Urtica spp (Nettles) — infusion and food; 30% protein; Vit A,C,D,E,K,B-complex, Mg, Ca, Se, Zn, Fe; hemostatic; reduces heavy menstrual flow.',
   v_class, 'personal', 'Adolescent Support', 20, v_per_teen_block),
  (155, 'Red Raspberry leaf — alone or with nettle for menstrual cramps; Vit A,C,E, Ca, Fe, K; uterine tonic; very astringent.',
   v_class, 'personal', 'Adolescent Support', 30, v_per_teen_block),
  (2287,'Oat Straw — nutritive; high in silica (hair, nails, bones); as a tea; must be green.',
   v_class, 'personal', 'Adolescent Support', 40, v_per_teen_block),
  (178, 'Milky Oats — better for nerve degradation (e.g. MS) rather than initial nerve building.',
   v_class, 'personal', 'Adolescent Support', 50, v_per_teen_block),

  -- Amenorrhea
  (190, 'Vitex — promote hormone regulation; 30–60 drops 1× morning; bi-phasic cycle: Dong Quai 2 weeks then Vitex 2 weeks.',
   v_class, 'personal', 'Amenorrhea', 10, v_per_amen_block),
  (167, 'Cinnamon — pelvic circulation and uterine tone; standard infusion or tincture 20–50 drops to 4×/day.',
   v_class, 'personal', 'Amenorrhea', 20, v_per_amen_block),
  (93,  'Cramp Bark (Viburnum) — relieve pelvic tension; cold infusion or decoction 3–4 oz to 4×/day; tincture 30–90 drops.',
   v_class, 'personal', 'Amenorrhea', 30, v_per_amen_block),
  (1009,'Dong Quai — bi-phasic cycle protocol: 2 weeks Dong Quai then 2 weeks Vitex for amenorrhea.',
   v_class, 'personal', 'Amenorrhea', 40, v_per_amen_block),
  (155, 'Red Raspberry Leaf — tone while nourishing for amenorrhea; infusion as needed.',
   v_class, 'personal', 'Amenorrhea', 50, v_per_amen_block),
  (124, 'Ginger — warming for cold atonic amenorrhea; fresh or dry.',
   v_class, 'personal', 'Amenorrhea', 60, v_per_amen_block),

  -- Dysmenorrhea
  (93,  'Cramp Bark — antispasmodic for spasmodic dysmenorrhea; cold infusion or decoction 3–4 oz to 4×/day; tincture 30–90 drops.',
   v_class, 'personal', 'Dysmenorrhea', 10, v_per_dysmen_block),
  (25,  'Black Cohosh — anodyne for dysmenorrhea; tincture 10–25 drops; capsules #00 1–2 to 3×/day.',
   v_class, 'personal', 'Dysmenorrhea', 20, v_per_dysmen_block),
  (131, 'Motherwort — sedative for spasmodic dysmenorrhea; tincture 30–60 drops to 4×/day; infusion 2–4 oz.',
   v_class, 'personal', 'Dysmenorrhea', 30, v_per_dysmen_block),
  (134, 'Lemon Balm — calcium-rich; calcium deficiency → more painful cycles; modulates pain perception in dysmenorrhea.',
   v_class, 'personal', 'Dysmenorrhea', 40, v_per_dysmen_block),

  -- Menorrhagia
  (190, 'Vitex — hormone regulator for menorrhagia; 30–60 drops once in morning.',
   v_class, 'personal', 'Menorrhagia', 10, v_per_menor_block),
  (44,  'Yarrow — hemostatic; reduce blood flow for menorrhagia; Achillea; tincture 10–40 drops; infusion 2–4 oz.',
   v_class, 'personal', 'Menorrhagia', 20, v_per_menor_block),
  (43,  'Nettles — reduce blood flow and nourishment for menorrhagia; cold or standard infusion as needed.',
   v_class, 'personal', 'Menorrhagia', 30, v_per_menor_block),
  (167, 'Cinnamon — reduce flow in the moment; strong decoction; 1 drop EO under tongue in emergency.',
   v_class, 'personal', 'Menorrhagia', 40, v_per_menor_block),

  -- Fibroids
  (109, 'Rosemary — rosmarinic acid for methylation; estrogen metabolism support in fibroids.',
   v_class, 'personal', 'Fibroids', 10, v_per_fibroid_block),
  (13,  'Tulsi — rosmarinic acid for methylation; estrogen metabolism support in fibroids.',
   v_class, 'personal', 'Fibroids', 20, v_per_fibroid_block),
  (134, 'Lemon Balm — rosmarinic acid for methylation; estrogen metabolism support in fibroids.',
   v_class, 'personal', 'Fibroids', 30, v_per_fibroid_block),
  (190, 'Vitex — possible herb for fibroids.',
   v_class, 'personal', 'Fibroids', 40, v_per_fibroid_block),
  (42,  'Red Clover — blood mover for stasis; isoflavones; enhance progesterone for fibroids.',
   v_class, 'personal', 'Fibroids', 50, v_per_fibroid_block),

  -- Endometriosis
  (2229,'Gotu Kola — extracellular matrix support for endometriosis; scar tissue.',
   v_class, 'personal', 'Endometriosis', 10, v_per_endo_block);

  RAISE NOTICE 'Class 57 snippets inserted';
END $$;

-- ─────────────────────────────────────────────
-- Keywords
-- ─────────────────────────────────────────────
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES

  -- Marshmallow (45)
  (45,   'dehydration',               'symptom'),

  -- Adolescent Support herbs
  (134,  'puberty support',           'general'),
  (134,  'insomnia',                  'symptom'),
  (43,   'puberty support',           'general'),
  (43,   'heavy bleeding',            'ailment'),
  (155,  'puberty support',           'general'),
  (155,  'menstrual cramps',          'symptom'),
  (155,  'uterine tonic',             'ailment'),
  (2287, 'puberty support',           'general'),
  (178,  'nervous system support',    'action'),

  -- Amenorrhea herbs
  (190,  'amenorrhea',                'ailment'),
  (190,  'hormonal support',          'ailment'),
  (167,  'amenorrhea',                'ailment'),
  (167,  'uterine tonic',             'ailment'),
  (93,   'amenorrhea',                'ailment'),
  (93,   'dysmenorrhea',              'ailment'),
  (93,   'menstrual cramps',          'symptom'),
  (93,   'endometriosis',             'ailment'),
  (1009, 'amenorrhea',                'ailment'),
  (1009, 'hormonal support',          'ailment'),
  (155,  'amenorrhea',                'ailment'),
  (124,  'amenorrhea',                'ailment'),

  -- Dysmenorrhea herbs
  (25,   'dysmenorrhea',              'ailment'),
  (25,   'menstrual cramps',          'symptom'),
  (25,   'fibroids',                  'ailment'),
  (131,  'dysmenorrhea',              'ailment'),
  (131,  'menstrual cramps',          'symptom'),
  (134,  'dysmenorrhea',              'ailment'),
  (134,  'menstrual cramps',          'symptom'),

  -- Menorrhagia herbs
  (190,  'heavy bleeding',            'ailment'),
  (190,  'fibroids',                  'ailment'),
  (44,   'heavy bleeding',            'ailment'),
  (44,   'fibroids',                  'ailment'),
  (44,   'endometriosis',             'ailment'),
  (43,   'heavy bleeding',            'ailment'),
  (167,  'heavy bleeding',            'ailment'),
  (167,  'fibroids',                  'ailment'),

  -- Fibroids herbs
  (78,   'fibroids',                  'ailment'),
  (78,   'estrogen metabolism',       'ailment'),
  (2238, 'fibroids',                  'ailment'),
  (2238, 'ADHD',                      'ailment'),
  (42,   'fibroids',                  'ailment'),
  (42,   'estrogen metabolism',       'ailment'),
  (109,  'fibroids',                  'ailment'),
  (109,  'estrogen metabolism',       'ailment'),

  -- Endometriosis herbs
  (124,  'endometriosis',             'ailment'),
  (124,  'dysmenorrhea',              'ailment'),
  (139,  'endometriosis',             'ailment'),
  (139,  'dysmenorrhea',              'ailment'),
  (80,   'endometriosis',             'ailment'),
  (80,   'dysmenorrhea',              'ailment'),
  (203,  'endometriosis',             'ailment'),
  (203,  'inflammation',              'ailment'),
  (2229, 'endometriosis',             'ailment'),
  (2229, 'nootropic support',         'action'),
  (2229, 'nervous system support',    'action'),
  (2229, 'stress',                    'ailment'),

  -- Nervous System and Hormonal herbs
  (20,   'stress',                    'ailment'),
  (20,   'hormonal support',          'ailment'),
  (20,   'nervous system support',    'action'),
  (20,   'ADHD',                      'ailment'),
  (20,   'PCOS',                      'ailment'),
  (20,   'blood sugar dysregulation', 'ailment'),
  (178,  'anxiety',                   'ailment'),
  (178,  'insomnia',                  'symptom'),
  (178,  'ADHD',                      'ailment'),
  (13,   'stress',                    'ailment'),
  (13,   'blood sugar dysregulation', 'ailment'),
  (13,   'PCOS',                      'ailment'),
  (13,   'ADHD',                      'ailment'),
  (13,   'hormonal support',          'ailment'),
  (145,  'insomnia',                  'symptom'),
  (145,  'anxiety',                   'ailment'),
  (2381, 'nootropic support',         'action'),
  (2381, 'ADHD',                      'ailment'),
  (2381, 'PCOS',                      'ailment'),
  (2381, 'blood sugar dysregulation', 'ailment'),
  (172,  'digestive support',         'ailment'),
  (65,   'hormonal support',          'ailment'),
  (65,   'digestive support',         'ailment'),

  -- Stress and Burnout herbs
  (128,  'anxiety',                   'ailment'),
  (128,  'insomnia',                  'symptom'),
  (137,  'anxiety',                   'ailment'),
  (137,  'insomnia',                  'symptom'),
  (137,  'nervous system support',    'action'),
  (142,  'anxiety',                   'ailment'),
  (142,  'insomnia',                  'symptom'),
  (142,  'nervous system support',    'action'),
  (142,  'ADHD',                      'ailment'),
  (136,  'digestive support',         'ailment'),
  (76,   'digestive support',         'ailment'),
  (84,   'digestive support',         'ailment'),
  (84,   'insomnia',                  'symptom'),
  (84,   'ADHD',                      'ailment'),

  -- Sleep and Relaxation
  (45,   'insomnia',                  'symptom'),
  (45,   'stress',                    'ailment'),

  -- Nootropic Support
  (165,  'nootropic support',         'action'),
  (165,  'ADHD',                      'ailment'),
  (17,   'nootropic support',         'action'),
  (17,   'PCOS',                      'ailment'),
  (17,   'ADHD',                      'ailment'),

  -- Nervine and Adaptogen Support
  (14,   'nootropic support',         'action'),
  (14,   'ADHD',                      'ailment'),
  (131,  'stress',                    'ailment'),
  (203,  'liver support',             'ailment'),
  (156,  'digestive support',         'ailment'),

  -- PCOS and Blood Sugar formula
  (91,   'PCOS',                      'ailment'),
  (91,   'blood sugar dysregulation', 'ailment'),
  (2556, 'PCOS',                      'ailment'),
  (2556, 'blood sugar dysregulation', 'ailment'),
  (1009, 'PCOS',                      'ailment'),
  (73,   'ADHD',                      'ailment'),
  (73,   'stress',                    'ailment'),

  -- White Peony
  (2238, 'hormonal support',          'ailment'),

  -- Rosemary
  (109,  'estrogen metabolism',       'ailment'),
  (109,  'liver support',             'ailment'),

  -- Oat Straw mineral
  (2287, 'nervous system support',    'action'),
  (2287, 'puberty support',           'general')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ─────────────────────────────────────────────
-- Ailment search synonyms (new ailment keywords only)
-- ─────────────────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('amenorrhea',
   ARRAY['absence of menstruation', 'no period', 'missed periods', 'absent menstruation', 'secondary amenorrhea', 'primary amenorrhea']),
  ('dysmenorrhea',
   ARRAY['menstrual cramps', 'painful periods', 'painful menstruation', 'period pain', 'menstrual pain', 'cramps']),
  ('endometriosis',
   ARRAY['endo', 'endometrial implants', 'endometrial tissue outside uterus', 'uterine endometriosis']),
  ('PCOS',
   ARRAY['polycystic ovarian syndrome', 'polycystic ovary syndrome', 'ovarian cysts', 'anovulation', 'polycystic ovaries']),
  ('ADHD',
   ARRAY['attention deficit hyperactivity disorder', 'ADD', 'attention deficit disorder', 'executive dysfunction', 'hyperactivity', 'attention deficit']),
  ('blood sugar dysregulation',
   ARRAY['hyperglycemia', 'hypoglycemia', 'blood sugar imbalance', 'insulin resistance', 'glucose dysregulation', 'blood sugar fluctuations'])
ON CONFLICT (ailment_keyword) DO NOTHING;
