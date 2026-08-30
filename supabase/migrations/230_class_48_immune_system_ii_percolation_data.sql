-- Migration 230: Class 48 — Immune System II and Percolation
-- Source: BHC - Class 48 - Immune System II and Percolation
-- Date: 2026-07-29

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Herb snippets
-- ============================================================
DO $$
DECLARE
  v_class       CONSTANT TEXT := 'BHC - Class 48 - Immune System II and Percolation';

  v_ashwagandha INTEGER;
  v_cinnamon    INTEGER;
  v_shepherd    INTEGER;
  v_marshmallow INTEGER;
  v_mullein     INTEGER;
  v_shatavari   INTEGER;
  v_vitex       INTEGER;
  v_echinacea   INTEGER;
  v_astragalus  INTEGER;

  v_src_case_formula CONSTANT TEXT := $blk$
### Lisa prescription for Digestive Case Study
- Adaptogen-Nervine Tincture:
    - Shatavari 40-80 drops / 60ml
    - Milky Oats 25-50 drops / 40ml
    - Gotu Kola 15-30 drops / 20ml
    - started with Ashwagandha, but switched out because made irritable and aggravated
    - for dosing - start by writing out what it says per-herb dose
- Reproductive Tincture:
    - Vitex - 30d / 30ml
    - White Peony - 55d / 30ml
    - Licorice - 20d / 25ml
    - Yarrow - 30d / 35ml
    - total 120ml — dosage: 2 droppers / 3x day
- ashwagandha better as fluid extract, and best in milk
    - 1/2 tsp powder, or 15-30 drops in milk
$blk$;

  v_src_clinical CONSTANT TEXT := $blk$
## Remaining Digestive Case Study Presentations
- cinnamon - slows peristalsis (can use Ginger if warming is needed)
    - cinnamon is indicated for heavy bleeding though
- shepherd's purse
    - acute bleeding remedy, even to the point of clotting
    - but not really a constitutional tonic
- mineral overnight infusion needs to start with heat, cold infusion (mucopolysaccharides) = no heat to start, put in fridge overnight
- can try bitters as a "cocktail" to shift into parasympathetic state rather than a quick medicinal spray, more joyful
$blk$;

  v_src_percolation CONSTANT TEXT := $blk$
## Percolations (afternoon - Rose)
- another alcohol extraction method
- tincture in 48 hours, hands on
- some say a more potent extraction
- more frontend work though
- use a little more alcohol
- can only percolate dried herbs
- can't do resinous herbs
- fluffy herbs won't work — mullein, marshmallow

## Review: Alcohol Extractions
- folk method
- ratio method with fresh: 1:2, 95% or 75% (lower water plants = 75%)
- ratio method with dried: 1:5, >35%
- alkaloids: vinegar extraction
- high tannins or aromatics: add glycerin (e.g., cinnamon)
$blk$;

  v_src_immune_gen CONSTANT TEXT := $blk$
## Immune Modulators — Constituent Mapping (generated notes)
- Phenols: oregano, clove, thyme, rosemary
- Alkaloids: berberine, valerian, passionflower
- Saponins: wild yam
- Glycoproteins: echinacea, goji berries, Salvia miltiorrhiza, ginseng
- Terpenoids: reishi, Centella asiatica, bacopa
- Fatty acids: purslane, flax, hemp seeds
- Polysaccharides: astragalus
$blk$;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 48 snippets already loaded — skipping';
    RETURN;
  END IF;

  SELECT id INTO v_ashwagandha FROM herbal.herbs WHERE latin_name = 'Withania somnifera';
  SELECT id INTO v_cinnamon    FROM herbal.herbs WHERE latin_name = 'Cinnamomum spp.';
  SELECT id INTO v_shepherd    FROM herbal.herbs WHERE latin_name = 'Capsella bursa-pastoris';
  SELECT id INTO v_marshmallow FROM herbal.herbs WHERE latin_name = 'Althaea officinalis';
  SELECT id INTO v_mullein     FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  SELECT id INTO v_shatavari   FROM herbal.herbs WHERE latin_name = 'Asparagus racemosus';
  SELECT id INTO v_vitex       FROM herbal.herbs WHERE latin_name = 'Vitex agnus-castus';
  SELECT id INTO v_echinacea   FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  SELECT id INTO v_astragalus  FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- ── Administration / Formulation ──────────────────────────────────────
    (v_ashwagandha, 'Ashwagandha is best as a fluid extract, ideally administered in milk — 1/2 tsp powder or 15–30 drops. Can cause irritability and aggravation in some people; if this occurs, switch to a different adaptogen.',
     v_class, 'personal', 'Administration / Formulation', 10, v_src_case_formula),

    -- ── Clinical Notes ────────────────────────────────────────────────────
    (v_cinnamon,    'Cinnamon slows peristalsis — use Ginger instead if warming digestive support is needed without this slowing effect.',
     v_class, 'personal', 'Clinical Notes', 20, v_src_clinical),

    (v_cinnamon,    'Cinnamon is indicated for heavy bleeding, making it clinically relevant in reproductive formulas for this specific presentation.',
     v_class, 'personal', 'Clinical Notes', 30, v_src_clinical),

    (v_shepherd,    'Shepherd''s Purse is a powerful acute bleeding remedy — acts even to the point of clotting. It is not a constitutional tonic; reserve it for acute bleeding presentations.',
     v_class, 'personal', 'Clinical Notes', 40, v_src_clinical),

    -- ── Percolation / Infusion ────────────────────────────────────────────
    (v_marshmallow, 'Marshmallow is too fluffy to percolate — use maceration instead. For mucopolysaccharide extraction (cold infusion): no heat at all; place directly in the fridge overnight. Contrast with mineral infusions, which need to start with heat.',
     v_class, 'personal', 'Percolation / Cold Infusion', 50, v_src_percolation),

    (v_mullein,     'Mullein is too fluffy to percolate — use maceration instead. Percolation doesn''t work with fluffy or resinous herbs.',
     v_class, 'personal', 'Percolation', 60, v_src_percolation),

    -- ── Case Study Formula ────────────────────────────────────────────────
    (v_shatavari,   'In Lisa''s adaptogen-nervine formula (digestive case): Shatavari 40–80 drops (60 mL), Milky Oats 25–50 drops (40 mL), Gotu Kola 15–30 drops (20 mL). Therapeutic dose = 4 dropper-fulls (120 drops). Originally included Ashwagandha, switched out due to irritability.',
     v_class, 'personal', 'Case Study Formula', 70, v_src_case_formula),

    (v_vitex,       'In Lisa''s reproductive formula: Vitex 30 drops (30 mL), White Peony 55 drops (30 mL), Licorice 20 drops (25 mL), Yarrow 30 drops (35 mL). Dosing: 2 dropper-fulls 3× per day (total 120 mL).',
     v_class, 'personal', 'Case Study Formula', 80, v_src_case_formula),

    -- ── Immune Modulators (generated) ─────────────────────────────────────
    (v_echinacea,   'Echinacea modulates immunity primarily through glycoproteins, which stimulate immune cell activation. Other immune-modulating constituent classes: glycoproteins (goji, ginseng), polysaccharides (astragalus), terpenoids (reishi, gotu kola, bacopa), phenols (thyme, oregano).',
     v_class, 'generated', 'Immune Modulators', 10, v_src_immune_gen),

    (v_astragalus,  'Astragalus modulates immunity via polysaccharides — the primary constituent class responsible for its immune-tonic activity.',
     v_class, 'generated', 'Immune Modulators', 20, v_src_immune_gen)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 48 snippets: done.';
END $$;


-- ============================================================
-- Block 2: Herb keywords
-- ============================================================
DO $$
DECLARE
  v_ashwagandha INTEGER;
  v_cinnamon    INTEGER;
  v_shepherd    INTEGER;
  v_echinacea   INTEGER;
  v_astragalus  INTEGER;
  v_vitex       INTEGER;
  v_shatavari   INTEGER;

BEGIN
  SELECT id INTO v_ashwagandha FROM herbal.herbs WHERE latin_name = 'Withania somnifera';
  SELECT id INTO v_cinnamon    FROM herbal.herbs WHERE latin_name = 'Cinnamomum spp.';
  SELECT id INTO v_shepherd    FROM herbal.herbs WHERE latin_name = 'Capsella bursa-pastoris';
  SELECT id INTO v_echinacea   FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  SELECT id INTO v_astragalus  FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus';
  SELECT id INTO v_vitex       FROM herbal.herbs WHERE latin_name = 'Vitex agnus-castus';
  SELECT id INTO v_shatavari   FROM herbal.herbs WHERE latin_name = 'Asparagus racemosus';

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    -- Action keywords
    (v_ashwagandha, 'adaptogen',             'action'),
    (v_ashwagandha, 'nervine',               'action'),
    (v_cinnamon,    'hemostatic',            'action'),
    (v_cinnamon,    'astringent',            'action'),
    (v_shepherd,    'hemostatic',            'action'),
    (v_shepherd,    'astringent',            'action'),
    (v_echinacea,   'immune modulator',      'action'),
    (v_echinacea,   'immune amphoteric',     'action'),
    (v_astragalus,  'immune modulator',      'action'),
    (v_vitex,       'hormone balancing',     'action'),
    (v_shatavari,   'adaptogen',             'action'),
    (v_shatavari,   'reproductive tonic',    'action'),
    -- Ailment keywords
    (v_ashwagandha, 'hypothyroidism',        'ailment'),
    (v_cinnamon,    'heavy bleeding',        'ailment'),
    (v_shepherd,    'heavy bleeding',        'ailment'),
    (v_echinacea,   'common cold',           'ailment'),
    (v_echinacea,   'influenza',             'ailment'),
    (v_echinacea,   'immune support',        'ailment'),
    (v_echinacea,   'mast cell activation syndrome', 'ailment'),
    (v_vitex,       'amenorrhea',            'ailment'),
    (v_vitex,       'dysmenorrhea',          'ailment'),
    (v_shatavari,   'hormonal support',      'ailment'),
    (v_shatavari,   'reproductive support',  'ailment')

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 48 herb keywords: done.';
END $$;


-- ============================================================
-- Block 3: Ailment search terms (new terms only)
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
    ('mast cell activation syndrome', ARRAY['MCAS', 'mast cell disorder', 'mast cell hyperactivation', 'histamine intolerance']),
    ('eosinophilic esophagitis',      ARRAY['EoE', 'eosinophilic esophageal disease', 'esophageal eosinophilia', 'esophageal hypersensitivity']),
    ('autoimmune disease',            ARRAY['autoimmunity', 'autoimmune disorder', 'immune dysregulation', 'self-immunity'])

  ON CONFLICT (ailment_keyword) DO NOTHING;

  RAISE NOTICE 'Class 48 ailment search terms: done.';
END $$;
