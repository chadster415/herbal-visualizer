-- Migration 231: Class 46 — Digestive System IV and Tongue Diagnosis
-- Source: BHC - Class 46 - Digestive System IV and Tongue Diagnosis
-- Date: 2026-07-23

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Herb snippets
-- ============================================================
DO $$
DECLARE
  v_class       CONSTANT TEXT := 'BHC - Class 46 - Digestive System IV and Tongue Diagnosis';

  v_gotu_kola     INTEGER;
  v_yellow_dock   INTEGER;
  v_lemon_balm    INTEGER;
  v_dong_quai     INTEGER;
  v_calendula     INTEGER;
  v_marshmallow   INTEGER;
  v_holy_basil    INTEGER;
  v_dandelion_rt  INTEGER;
  v_prickly_ash   INTEGER;
  v_bupleurum     INTEGER;
  v_shatavari     INTEGER;

  v_src_morning CONSTANT TEXT := $blk$
# Notes - Morning - Lisa

- gotu kola - specific for underfunctioning thyroid
    - can swap out from ashwagandha for good effect
- yellow dock needs decoction and heat to extract
    - as a glycerite or a digestive bitter or a syrup would help with taste
- shatavari + marshmallow + cinnamon + cardamom
    - moistening and nourishing to the gut
- fennel seeds after meals
- lemon balm nutritive replacement for raspberry leaf (which is maybe too drying for dry constitutions)
- when formulating, make sure each dose has a therapeutic dose of drop numbers
- generally 4-5 herbs max in a formula to get to a therapeutic dose for each herb
- 60 drops = 2ml
- wild ginger targets the uterus
- always when digestive issues, default to warm wet foods, regardless of their perceived constitution
$blk$;

  v_src_dong_quai CONSTANT TEXT := $blk$
## Wild Ginger and Reproductive Health
- Wild ginger active in uterus
    - Not significant for gut
    - Warms up uterus
- Dong quai contraindicated with heavy menses
    - Can aggravate heavy bleeding
    - Indicated for light/scant menses
$blk$;

  v_src_cold_infusion CONSTANT TEXT := $blk$
## Calendula and Cold Infusions
- Calendula not extractive in cold infusions
    - Resins need heat to release
- Marshmallow could be better for cold infusion
- Rose hip:
    - Suspicions about cold infusion effectiveness
    - Consider different preparation for rose hips
$blk$;

  v_src_dosing CONSTANT TEXT := $blk$
## Tulsi and Dosing
- Tulsi as a warming adaptogen
    - Soft, uplifting adaptogen
- Peony and Licorice dosing ratio: 3 parts peony to 1 part licorice desired

## Gastrointestinal and Bladder Support
- Support GI tract & stimulate bile flow
    - Dandelion root for liver, GI tract, bile
    - Prickly Ash for circulatory, digestive stimulation
- Dosage
    - Dandelion: 2-4 mL twice daily
    - Prickly Ash: 1-2 mL twice daily

## Understanding Background and Emotional Aspects
- Gotu kola for brain fog, anxiety
    - Dosing 3-6 times daily, especially before meals
- Decoction necessary for yellow dock
$blk$;

  v_src_liver CONSTANT TEXT := $blk$
## Liver herbs and food
- sour, fresh green foods
- Sprouts, asparagus, green apples, lemon, lime juice
- Shu gan san
- Xiao yao san
- Bupleurum (Chai hu)

## Symptoms of Liver Qi Stagnation
- Depression, frustration
- Pain on sides, decision-making issues
- PMS symptoms, hormonal issues linked to liver health
$blk$;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 46 snippets already loaded — skipping';
    RETURN;
  END IF;

  SELECT id INTO v_gotu_kola   FROM herbal.herbs WHERE latin_name = 'Centella asiatica';
  SELECT id INTO v_yellow_dock FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  SELECT id INTO v_lemon_balm  FROM herbal.herbs WHERE latin_name = 'Melissa officinalis';
  SELECT id INTO v_dong_quai   FROM herbal.herbs WHERE latin_name = 'Angelica sinensis';
  SELECT id INTO v_calendula   FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  SELECT id INTO v_marshmallow FROM herbal.herbs WHERE latin_name = 'Althaea officinalis';
  SELECT id INTO v_holy_basil  FROM herbal.herbs WHERE latin_name = 'Ocimum sanctum';
  SELECT id INTO v_dandelion_rt FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'root';
  SELECT id INTO v_prickly_ash FROM herbal.herbs WHERE latin_name = 'Zanthoxylum americanum';
  SELECT id INTO v_bupleurum   FROM herbal.herbs WHERE latin_name = 'Bupleurum falcatum';
  SELECT id INTO v_shatavari   FROM herbal.herbs WHERE latin_name = 'Asparagus racemosus';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- ── Thyroid / Clinical ────────────────────────────────────────────────
    (v_gotu_kola, 'Gotu Kola is specific for an underfunctioning thyroid — can swap it out from Ashwagandha for good effect in thyroid-support formulas.',
     v_class, 'personal', 'Clinical Notes', 10, v_src_morning),

    (v_gotu_kola, 'Gotu Kola for brain fog and anxiety — dose 3–6 times daily, especially before meals.',
     v_class, 'generated', 'Dosing', 20, v_src_dosing),

    -- ── Extraction Methods ────────────────────────────────────────────────
    (v_yellow_dock, 'Yellow Dock requires decoction with heat for proper extraction — the active constituents (esculin, iron-binding compounds) are not water-soluble without heat. A glycerite, digestive bitter formula, or syrup helps mask the difficult taste.',
     v_class, 'personal', 'Extraction Methods', 30, v_src_morning),

    (v_calendula, 'Calendula is not extractive in cold infusions — its resins require heat to release. Use alcohol tincture or hot water infusion; cold water will not adequately extract the active constituents.',
     v_class, 'generated', 'Extraction Methods', 40, v_src_cold_infusion),

    (v_marshmallow, 'Marshmallow is better suited to cold infusion — no heat needed to extract the mucopolysaccharides. Contrast with Calendula, which requires heat for resin extraction.',
     v_class, 'generated', 'Extraction Methods', 50, v_src_cold_infusion),

    -- ── Clinical / Substitution ───────────────────────────────────────────
    (v_lemon_balm, 'Lemon Balm can substitute for Raspberry Leaf as a nutritive herb in dry constitutions — Raspberry Leaf may be too drying for some people.',
     v_class, 'personal', 'Clinical Notes', 60, v_src_morning),

    -- ── Contraindications ────────────────────────────────────────────────
    (v_dong_quai, 'Dong Quai is contraindicated for heavy menses — it can aggravate heavy bleeding. It is specifically indicated for light or scant menses (hypomenorrhea/amenorrhea). Remove it from formulas and shift dosage to Peony when heavy bleeding is present.',
     v_class, 'generated', 'Contraindications', 70, v_src_dong_quai),

    -- ── Adaptogen ────────────────────────────────────────────────────────
    (v_holy_basil, 'Holy Basil (Tulsi) is a warming adaptogen — described as soft and uplifting. Good gentle choice for stress, anxiety, and adrenal support without over-stimulating.',
     v_class, 'generated', 'Clinical Notes', 80, v_src_dosing),

    -- ── Dosing ───────────────────────────────────────────────────────────
    (v_dandelion_rt, 'Dandelion root: 2–4 mL twice daily for liver support, GI tract stimulation, and bile flow. Also used for iron absorption support alongside Yellow Dock.',
     v_class, 'generated', 'Dosing', 90, v_src_dosing),

    (v_prickly_ash, 'Prickly Ash: 1–2 mL twice daily for circulatory and digestive stimulation.',
     v_class, 'generated', 'Dosing', 100, v_src_dosing),

    -- ── Liver Qi / TCM ───────────────────────────────────────────────────
    (v_bupleurum, 'Bupleurum (Chai Hu) is the primary herb for Liver Qi stagnation — used in classical formulas Xiao Yao San and Shu Gan San. Liver Qi sx: depression, frustration, pain in the sides, PMS, decision-making difficulty, hormonal dysregulation.',
     v_class, 'personal', 'Clinical Notes', 110, v_src_liver),

    -- ── Case Study Formula ────────────────────────────────────────────────
    (v_shatavari, 'Shatavari combined with Marshmallow, Cinnamon, and Cardamom creates a moistening and nourishing gut formula — appropriate for dry constitutions with GI inflammation or poor absorption.',
     v_class, 'personal', 'Case Study Formula', 120, v_src_morning)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 46 snippets: done.';
END $$;


-- ============================================================
-- Block 2: Herb keywords
-- ============================================================
DO $$
DECLARE
  v_gotu_kola    INTEGER;
  v_yellow_dock  INTEGER;
  v_lemon_balm   INTEGER;
  v_dong_quai    INTEGER;
  v_calendula    INTEGER;
  v_marshmallow  INTEGER;
  v_holy_basil   INTEGER;
  v_dandelion_rt INTEGER;
  v_prickly_ash  INTEGER;
  v_bupleurum    INTEGER;
  v_shatavari    INTEGER;

BEGIN
  SELECT id INTO v_gotu_kola    FROM herbal.herbs WHERE latin_name = 'Centella asiatica';
  SELECT id INTO v_yellow_dock  FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  SELECT id INTO v_lemon_balm   FROM herbal.herbs WHERE latin_name = 'Melissa officinalis';
  SELECT id INTO v_dong_quai    FROM herbal.herbs WHERE latin_name = 'Angelica sinensis';
  SELECT id INTO v_calendula    FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  SELECT id INTO v_marshmallow  FROM herbal.herbs WHERE latin_name = 'Althaea officinalis';
  SELECT id INTO v_holy_basil   FROM herbal.herbs WHERE latin_name = 'Ocimum sanctum';
  SELECT id INTO v_dandelion_rt FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'root';
  SELECT id INTO v_prickly_ash  FROM herbal.herbs WHERE latin_name = 'Zanthoxylum americanum';
  SELECT id INTO v_bupleurum    FROM herbal.herbs WHERE latin_name = 'Bupleurum falcatum';
  SELECT id INTO v_shatavari    FROM herbal.herbs WHERE latin_name = 'Asparagus racemosus';

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    -- Action keywords
    (v_gotu_kola,    'adaptogen',               'action'),
    (v_gotu_kola,    'thyroid tonic',            'action'),
    (v_gotu_kola,    'nervine',                  'action'),
    (v_yellow_dock,  'alterative',               'action'),
    (v_yellow_dock,  'digestive bitter',         'action'),
    (v_lemon_balm,   'nutritive',                'action'),
    (v_lemon_balm,   'nervine',                  'action'),
    (v_dong_quai,    'blood tonic',              'action'),
    (v_dong_quai,    'emmenagogue',              'action'),
    (v_calendula,    'vulnerary',                'action'),
    (v_calendula,    'anti-inflammatory',        'action'),
    (v_marshmallow,  'demulcent',                'action'),
    (v_marshmallow,  'mucilaginous',             'action'),
    (v_holy_basil,   'adaptogen',                'action'),
    (v_holy_basil,   'nervine',                  'action'),
    (v_dandelion_rt, 'cholagogue',               'action'),
    (v_dandelion_rt, 'alterative',               'action'),
    (v_dandelion_rt, 'digestive bitter',         'action'),
    (v_prickly_ash,  'circulatory stimulant',    'action'),
    (v_prickly_ash,  'digestive stimulant',      'action'),
    (v_prickly_ash,  'sialagogue',               'action'),
    (v_bupleurum,    'hepatoprotective',         'action'),
    (v_bupleurum,    'adaptogen',                'action'),
    (v_shatavari,    'demulcent',                'action'),
    (v_shatavari,    'nutritive',                'action'),
    -- Ailment keywords
    (v_gotu_kola,    'hypothyroidism',           'ailment'),
    (v_gotu_kola,    'brain fog',                'ailment'),
    (v_gotu_kola,    'anxiety',                  'ailment'),
    (v_yellow_dock,  'iron deficiency',          'ailment'),
    (v_yellow_dock,  'constipation',             'ailment'),
    (v_lemon_balm,   'anxiety',                  'ailment'),
    (v_lemon_balm,   'cognitive support',        'ailment'),
    (v_dong_quai,    'light menses',             'ailment'),
    (v_dong_quai,    'amenorrhea',               'ailment'),
    (v_calendula,    'wound healing',            'ailment'),
    (v_calendula,    'inflammation',             'ailment'),
    (v_marshmallow,  'dry gut',                  'ailment'),
    (v_marshmallow,  'GI inflammation',          'ailment'),
    (v_holy_basil,   'stress',                   'ailment'),
    (v_holy_basil,   'anxiety',                  'ailment'),
    (v_holy_basil,   'adrenal fatigue',          'ailment'),
    (v_dandelion_rt, 'liver support',            'ailment'),
    (v_dandelion_rt, 'bile insufficiency',       'ailment'),
    (v_prickly_ash,  'poor circulation',         'ailment'),
    (v_prickly_ash,  'cold extremities',         'ailment'),
    (v_bupleurum,    'liver qi stagnation',      'ailment'),
    (v_bupleurum,    'PMS',                      'ailment'),
    (v_bupleurum,    'depression',               'ailment'),
    (v_shatavari,    'dry gut',                  'ailment'),
    (v_shatavari,    'malabsorption',            'ailment')

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 46 herb keywords: done.';
END $$;


-- ============================================================
-- Block 3: Ailment search terms (new terms only)
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
    ('brain fog',          ARRAY['cognitive fog', 'mental fog', 'difficulty concentrating', 'mental fatigue', 'mental clarity']),
    ('light menses',       ARRAY['scant menses', 'hypomenorrhea', 'light periods', 'scanty menstruation', 'oligomenorrhea']),
    ('liver qi stagnation',ARRAY['liver stagnation', 'liver qi', 'liver constraint', 'emotional stagnation', 'qi constraint']),
    ('hypothyroidism',     ARRAY['underactive thyroid', 'thyroid deficiency', 'low thyroid', 'thyroid hypofunction']),
    ('adrenal fatigue',    ARRAY['adrenal insufficiency', 'HPA axis dysregulation', 'chronic stress response', 'burnout'])

  ON CONFLICT (ailment_keyword) DO NOTHING;

  RAISE NOTICE 'Class 46 ailment search terms: done.';
END $$;
