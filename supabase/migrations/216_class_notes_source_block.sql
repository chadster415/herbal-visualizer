SET search_path TO herbal, public;

-- Adds source_block column to class_note_snippets.
-- Stores the full raw text of the section that contained each snippet,
-- so the UI can show a collapsible "view in context" block.

ALTER TABLE herbal.class_note_snippets
  ADD COLUMN IF NOT EXISTS source_block TEXT;

-- ─── Populate source_block for Class 61 ──────────────────────────────────────
-- Each UPDATE targets all snippets sharing the same (note_type, section_header)
-- and sets them to the full verbatim text of that section from the source file.

-- Generated: Immune and Respiratory Support
UPDATE herbal.class_note_snippets SET source_block =
'- **Echinacea** for onset of illness
- Honey and tea for throat issues
- Garlic in soups for immunity
- Steaming with ginger for respiratory relief'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Immune and Respiratory Support';

-- Generated: Clinical Cases
UPDATE herbal.class_note_snippets SET source_block =
'- **Ginger** for digestive support
- **Artichoke leaf** and *mullein* for liver and hydration
- **Nettle** and raspberry for uterine tonic
- **Blueberries** as nervine'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Clinical Cases';

-- Generated: Chronic Pain and Nutrition
UPDATE herbal.class_note_snippets SET source_block =
'- Avoid late meals for better digestion
- Use teas for hydration (marshmallow, linden, cinnamon)
- Support nerves with blueberries'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Chronic Pain and Nutrition';

-- Generated: Fibroids and Uterine Health
UPDATE herbal.class_note_snippets SET source_block =
'- **Licorice** for mineral support
- **Reishi** with white peony synergy
- Caution with too many herbs (simplify approach)'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Fibroids and Uterine Health';

-- Generated: Herbal Preparation Tips
UPDATE herbal.class_note_snippets SET source_block =
'- **Shatavari** for hormone balance
- Bitter formula caution for digestive issues'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Herbal Preparation Tips';

-- Generated: Inflammation and Gut Health
UPDATE herbal.class_note_snippets SET source_block =
'- **Marshmallow root** for gut inflammation
    - Prepare in warm infusion
- Marshmallow root blend (with cinnamon, ashwagandha)
    - Mix with hot water or plant milk'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Inflammation and Gut Health';

-- Generated: Balancing Mineral and Herb Effects
UPDATE herbal.class_note_snippets SET source_block =
'- Addition of warming herbs like yarrow with cooling minerals'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Balancing Mineral and Herb Effects';

-- Generated: Pelvic and Thyroid Support
UPDATE herbal.class_note_snippets SET source_block =
'- Pelvic congestion reduction
- Use of cranberry juice for UTI support
- Tincture blends for heavy bleeding control'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Pelvic and Thyroid Support';

-- Generated: Complex Health Interactions
UPDATE herbal.class_note_snippets SET source_block =
'- Preparing teas for optimal plant extraction
- **Vitex** for hormonally induced symptoms
- Avoid **dong quai** for fibroids; consider black cohosh'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Complex Health Interactions';

-- Generated: Comprehensive Care
UPDATE herbal.class_note_snippets SET source_block =
'- Incorporating **turmeric** and **white peony** for fibroid treatment
- Lifestyle: emphasize nutrition, less reliance on smoothies
- **Calendula** for immune and mucous membrane support'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Comprehensive Care';

-- Generated: Adaptogens and Carminatives
UPDATE herbal.class_note_snippets SET source_block =
'- **Alfalfa**
    - Alterative
- *Astragalus*
    - Adaptogen, mentioned as a morning start
- Suggest adaptogens/carminatives to start the day
- Prioritize specific issues and paths'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Adaptogens and Carminatives';

-- Generated: Dandelion and Prebiotics
UPDATE herbal.class_note_snippets SET source_block =
'- Dandelion root
    - Tea tonic, more bitter-specific
- Dandelion leaf
    - Diuretic, supports kidneys
    - Flush out microbes, proteins
- Prebiotic tea and *Astragalus* root
    - Limit complexity in therapy'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Dandelion and Prebiotics';

-- Generated: Anxiety Support (from "## Herb Formula and Anxiety Support")
UPDATE herbal.class_note_snippets SET source_block =
'- Licorice and rosemary
    - Support anxiety
- Eleuthero
    - For energy, adaptogenic
- Cinnamon
    - Astringent, appetite and circulation
- Calendula
    - Immune support, hydrate mucous membranes
- Wild yam
    - Anti-spasmodic, promotes bile flow'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Anxiety Support';

-- Generated: Vaginitis (combines "## Decoction for Vaginitis" + "## Bath for Vaginitis")
UPDATE herbal.class_note_snippets SET source_block =
'**Decoction:**
- Turmeric, ginger, black pepper
    - Anti-inflammatory, synergistic
    - Simmer for 10 minutes, steep 10 minutes
    - Twice a day

**Bath:**
- Calendula, chamomile
    - Infused bath, reduce inflammation
- Milk thistle
    - Supports liver, metabolizes estrogen'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Vaginitis';

-- Generated: Nervous System Support (from "## Nervous System Support and Herbs")
UPDATE herbal.class_note_snippets SET source_block =
'- Ginseng caution
    - Consider nutritional resources
    - Work on foundation first
- Nourishing options like *Astragalus*'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Nervous System Support';

-- Generated: Fibroids and Vaginitis (from "## Tinctures for Fibroids and Vaginitis")
UPDATE herbal.class_note_snippets SET source_block =
'- White ash bark
- Black cohosh
    - Helpful for premenopause
- *Uva ursi*
    - Antimicrobial, anti-inflammatory
- Catnip
    - Sedative
- Add a lymphatic for balance'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Fibroids and Vaginitis';

-- Generated: Regenerative Tea Blend
UPDATE herbal.class_note_snippets SET source_block =
'- Horsetail, corn silk, nettle, yarrow
- Lady''s mantle, hibiscus, red clover
- Large daily infusions
- Healthy fats for nervous system'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Regenerative Tea Blend';

-- Generated: Hormone and Uterine Support (from "## Tinctures for Hormone and Uterine Support")
UPDATE herbal.class_note_snippets SET source_block =
'- Vitex
    - Hormone-balancing
- *Schisandra*
    - Hormone-balancing, astringent
- Red raspberry leaf
    - Uterine tonic'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Hormone and Uterine Support';

-- Generated: Traditional Formulas
UPDATE herbal.class_note_snippets SET source_block =
'- Blue cohosh, periwinkle, black cohosh
    - Uterine tonic, astringents
- Cleavers
    - Lymphatic support
- Stress formula
    - Catnip, lemon balm, chamomile'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Traditional Formulas';

-- Generated: Additional Herbs and Actions
UPDATE herbal.class_note_snippets SET source_block =
'- Perineal wash
    - Calendula, plantain, rose, yarrow
- Magnesium for supplements
- Integrate overarching nourishment strategy'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'generated' AND section_header = 'Additional Herbs and Actions';

-- Personal: Presentations
UPDATE herbal.class_note_snippets SET source_block =
'- in a mineral formula (nettles etc) - minerals are cooling, so add some warming, for example Yarrow
- shepherd''s purse very effective, so effective that it can clot up the uterus - only use it for that in very heavy situations
- flavor does really matter with willingness
- with sleep formulas, your body can outsmart it, have a few formulas and rotate them
- signs of excess estrogen?:
    - dryness
    - fibroids - could play out as fibrosis elsewhere in the body (lungs gut etc)
- signs of deficient estrogen?
    - do they have the resources to produce estrogen?
        - the building blocks - high quality fats
        - supporting the liver
    - xenoestrogens
- vitex - dopamine agonist
    - allows the pituitary to release the hormones
    - doesn''t affect the uterus directly
- anytime heavy bleeding, dong quai can aggravate
    - dong quai is a tissue builder
- castor oil beneficial for fibroids massage
- White peony an anti-fibrotic
- black cohosh indicated for base of skull headaches, but can cause them if too high dose
- Milk Thistle - helps with elimination of all things, enabling hormones to then be better processed and eliminated
- Ginsengs work best when people are already well-resourced
- careful of powders on vaginitis
- oils can change pH of mucus tissues
- wash or sitz bath better, maybe gel
    - aloe as a carrier'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'personal' AND section_header = 'Presentations';

-- Personal: Lisa (Patient Case)
UPDATE herbal.class_note_snippets SET source_block =
'Licorice
White Peony
Trifolium
Vitex
Cinnamon

2 tsp 3x/day
mostly red clover  vitex
white peony cinn
licorice

suppl Vit D 500 for 6 mos, reduce to 2000
Calcium citrate
Flax seed 2T daily
4-5 cups veggies

min 54 g protein per day
bitter formula before meals
3-4 x week fermented foods with meals
    sauer
1/4 tsp gray salt in water
oilination 1x/week
dry brush 1x/week
sitz
    calendula
    elecampane
    rose petals
    yarrow

2 weeks menus
add spices to foods
make time for mealtime

Mg to supplements
avoid cold foods, focus on warm and wet foods

then later,
heat, castor oil and gua sha on the abdominal fibroids
intense'
WHERE class_name = 'BHC - Class 61 - Repro IV Hormonal Matrix'
  AND note_type = 'personal' AND section_header = 'Lisa (Patient Case)';
