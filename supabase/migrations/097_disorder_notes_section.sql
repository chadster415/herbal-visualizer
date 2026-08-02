-- Migration 097: Add section column to disorder_notes; tag RA Actions Indicated notes;
-- add disorder_actions_indicated for Overall (Musculoskeletal)

SET search_path TO herbal, public;


-- ============================================================
-- BLOCK 0: Add section column to disorder_notes
-- ============================================================
DO $$
BEGIN
  ALTER TABLE herbal.disorder_notes
    ADD COLUMN IF NOT EXISTS section TEXT NOT NULL DEFAULT 'general';
  RAISE NOTICE 'disorder_notes.section column ready.';
END $$;


-- ============================================================
-- BLOCK 1: Tag Rheumatoid Arthritis Actions Indicated notes
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Rheumatoid Arthritis' AND body_system_id = v_sys_id;

  UPDATE herbal.disorder_notes
    SET section = 'actions_indicated'
    WHERE disorder_id = v_disorder_id AND sort_order IN (80, 90);

  RAISE NOTICE 'Rheumatoid Arthritis: Actions Indicated notes tagged.';
END $$;


-- ============================================================
-- BLOCK 2: disorder_actions_indicated for Overall disorder
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Overall' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antirheumatic'),
      '',
      10),
    (v_disorder_id, herbal.ensure_action('Analgesic'),
      'These, of course, should be used only as one part of an approach designed to treat the cause of disease.',
      20),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      '',
      30),
    (v_disorder_id, herbal.ensure_action('Alterative'),
      '',
      40),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      '',
      50),
    (v_disorder_id, herbal.ensure_action('Bitter tonic'),
      'The digestive system must be in good working order, as nutrients must be properly absorbed in order for the musculoskeletal system to operate at its peak. Bitter tonics may be helpful here.',
      60),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'Another way to cleanse the body of toxins is by stimulating blood circulation, which increases blood flow to muscles and joints.',
      70),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'Diuretics support the work of the kidneys in eliminating metabolic wastes, toxins, and the products of inflammation. This action is essential in musculoskeletal conditions, as these waste products and toxins lie at the root of many problems, including arthritis and rheumatism.',
      80),
    (v_disorder_id, herbal.ensure_action('Hepatic'),
      'If the patient is troubled by constipation, laxatives may be indicated, especially those that act by stimulating the liver.',
      90),
    (v_disorder_id, herbal.ensure_action('Rubefacient'),
      'Rubefacients are herbs that, when applied to the skin, stimulate circulation in that area, increasing blood supply and relieving congestion and inflammation. This action makes rubefacients particularly useful in liniments for muscular rheumatism and similar conditions.',
      100),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      '',
      110)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Musculoskeletal Overall: disorder_actions_indicated inserted.';
END $$;


-- ============================================================
-- BLOCK 3: Fix herb_primary_actions — re-point spurious plant_part=NULL
--          dandelion and nettle entries to their correct leaf/root forms.
--          (Block 2 of migration 096 used 2-arg ensure_herb which created
--          generic NULL-part entries after migrations 088/089 split those herbs.)
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_null_td_id  INTEGER;
  v_root_td_id  INTEGER;
  v_leaf_td_id  INTEGER;
  v_null_ud_id  INTEGER;
  v_leaf_ud_id  INTEGER;
BEGIN
  SELECT id INTO v_sys_id    FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_null_td_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale' AND plant_part IS NULL;
  SELECT id INTO v_root_td_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'root';
  SELECT id INTO v_leaf_td_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'leaf';
  SELECT id INTO v_null_ud_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica'         AND plant_part IS NULL;
  SELECT id INTO v_leaf_ud_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica'         AND plant_part = 'leaf';

  -- Dandelion: move root actions (Antirheumatic, Hepatic) → root herb,
  --            move Diuretic → leaf herb, then remove NULL-part entries.
  IF v_null_td_id IS NOT NULL THEN
    IF v_root_td_id IS NOT NULL THEN
      INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
        SELECT v_root_td_id, primary_action_id, body_system_id
        FROM herbal.herb_primary_actions
        WHERE herb_id = v_null_td_id AND body_system_id = v_sys_id
          AND primary_action_id IN (
            SELECT id FROM herbal.primary_actions WHERE name IN ('Antirheumatic', 'Hepatic')
          )
        ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
    END IF;
    IF v_leaf_td_id IS NOT NULL THEN
      INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
        SELECT v_leaf_td_id, primary_action_id, body_system_id
        FROM herbal.herb_primary_actions
        WHERE herb_id = v_null_td_id AND body_system_id = v_sys_id
          AND primary_action_id IN (
            SELECT id FROM herbal.primary_actions WHERE name = 'Diuretic'
          )
        ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
    END IF;
    DELETE FROM herbal.herb_primary_actions
      WHERE herb_id = v_null_td_id AND body_system_id = v_sys_id;
    RAISE NOTICE 'Dandelion (plant_part=NULL) Musculoskeletal actions re-pointed.';
  ELSE
    RAISE NOTICE 'No spurious Taraxacum officinale (plant_part=NULL) found; skipping.';
  END IF;

  -- Nettle: all Musculoskeletal actions → leaf herb.
  IF v_null_ud_id IS NOT NULL AND v_leaf_ud_id IS NOT NULL THEN
    INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
      SELECT v_leaf_ud_id, primary_action_id, body_system_id
      FROM herbal.herb_primary_actions
      WHERE herb_id = v_null_ud_id AND body_system_id = v_sys_id
      ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
    DELETE FROM herbal.herb_primary_actions
      WHERE herb_id = v_null_ud_id AND body_system_id = v_sys_id;
    RAISE NOTICE 'Nettle (plant_part=NULL) Musculoskeletal actions re-pointed to leaf.';
  ELSE
    RAISE NOTICE 'No spurious Urtica dioica (plant_part=NULL) found; skipping.';
  END IF;
END $$;


-- ============================================================
-- BLOCK 4: disorder_action_herbs for Overall (Musculoskeletal)
--          Source: ## Action Herbs section under # Disorder: Overall
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_action_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Overall' AND body_system_id = v_sys_id;

  -- Antirheumatic (40 herbs; dandelion root, nettle leaf per part conventions)
  v_action_id := herbal.ensure_action('Antirheumatic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Achillea millefolium',       'yarrow'),           v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Angelica archangelica',      'angelica'),         v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Apium graveolens',           'celery seed'),      v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Arctium lappa',              'burdock'),          v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Arctostaphylos uva-ursi',    'bearberry'),        v_action_id, 50),
    (v_disorder_id, herbal.ensure_herb('Armoracia rusticana',        'horseradish'),      v_action_id, 60),
    (v_disorder_id, herbal.ensure_herb('Arnica montana',             'arnica'),           v_action_id, 70),
    (v_disorder_id, herbal.ensure_herb('Artemisia absinthium',       'wormwood'),         v_action_id, 80),
    (v_disorder_id, herbal.ensure_herb('Artemisia vulgaris',         'mugwort'),          v_action_id, 90),
    (v_disorder_id, herbal.ensure_herb('Betula spp.',                'birch'),            v_action_id, 100),
    (v_disorder_id, herbal.ensure_herb('Brassica spp.',              'mustard'),          v_action_id, 110),
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum',            'cayenne'),          v_action_id, 120),
    (v_disorder_id, herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh'),      v_action_id, 130),
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',        'black cohosh'),     v_action_id, 140),
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',          'wild yam'),         v_action_id, 150),
    (v_disorder_id, herbal.ensure_herb('Eupatorium perfoliatum',     'boneset'),          v_action_id, 160),
    (v_disorder_id, herbal.ensure_herb('Eupatorium purpureum',       'gravel root'),      v_action_id, 170),
    (v_disorder_id, herbal.ensure_herb('Filipendula ulmaria',        'meadowsweet'),      v_action_id, 180),
    (v_disorder_id, herbal.ensure_herb('Fucus vesiculosus',          'bladderwrack'),     v_action_id, 190),
    (v_disorder_id, herbal.ensure_herb('Gaultheria procumbens',      'wintergreen'),      v_action_id, 200),
    (v_disorder_id, herbal.ensure_herb('Guaiacum officinale',        'guaiacum'),         v_action_id, 210),
    (v_disorder_id, herbal.ensure_herb('Harpagophytum procumbens',   'devil''s claw'),    v_action_id, 220),
    (v_disorder_id, herbal.ensure_herb('Iris versicolor',            'blue flag'),        v_action_id, 230),
    (v_disorder_id, herbal.ensure_herb('Juniperus communis',         'juniper'),          v_action_id, 240),
    (v_disorder_id, herbal.ensure_herb('Mahonia aquifolium',         'Oregon grape'),     v_action_id, 250),
    (v_disorder_id, herbal.ensure_herb('Menyanthes trifoliata',      'bogbean'),          v_action_id, 260),
    (v_disorder_id, herbal.ensure_herb('Myrica cerifera',            'bayberry'),         v_action_id, 270),
    (v_disorder_id, herbal.ensure_herb('Petroselinum crispum',       'parsley'),          v_action_id, 280),
    (v_disorder_id, herbal.ensure_herb('Phytolacca americana',       'poke root'),        v_action_id, 290),
    (v_disorder_id, herbal.ensure_herb('Populus tremuloides',        'aspen'),            v_action_id, 300),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis',     'rosemary'),         v_action_id, 310),
    (v_disorder_id, herbal.ensure_herb('Rumex crispus',              'yellow dock'),      v_action_id, 320),
    (v_disorder_id, herbal.ensure_herb('Salix spp.',                 'willow'),           v_action_id, 330),
    (v_disorder_id, herbal.ensure_herb('Smilax spp.',                'sarsaparilla'),     v_action_id, 340),
    (v_disorder_id, herbal.ensure_herb('Tanacetum parthenium',       'feverfew'),         v_action_id, 350),
    (v_disorder_id, herbal.ensure_herb('Taraxacum officinale',       'Dandelion', 'root'),v_action_id, 360),
    (v_disorder_id, herbal.ensure_herb('Urtica dioica',              'Nettles',   'leaf'),v_action_id, 370),
    (v_disorder_id, herbal.ensure_herb('Viburnum opulus',            'cramp bark'),       v_action_id, 380),
    (v_disorder_id, herbal.ensure_herb('Zanthoxylum americanum',     'prickly ash'),      v_action_id, 390),
    (v_disorder_id, herbal.ensure_herb('Zingiber officinale',        'ginger'),           v_action_id, 400)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Analgesic (6 herbs — combined from "Analgesics" and "Analgesic" entries in source)
  v_action_id := herbal.ensure_action('Analgesic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Filipendula ulmaria',   'meadowsweet'),      v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Guaiacum officinale',   'guaiacum'),         v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Hypericum perforatum',  'St. John''s wort'), v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Piscidia erythrina',    'Jamaica dogwood'),  v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Salix spp.',            'willow'),           v_action_id, 50),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis', 'valerian'),         v_action_id, 60)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Anti-inflammatory (14 herbs)
  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Angelica archangelica',      'angelica'),      v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Apium graveolens',           'celery seed'),   v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Betula spp.',                'birch'),         v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh'),   v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',        'black cohosh'),  v_action_id, 50),
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',          'wild yam'),      v_action_id, 60),
    (v_disorder_id, herbal.ensure_herb('Filipendula ulmaria',        'meadowsweet'),   v_action_id, 70),
    (v_disorder_id, herbal.ensure_herb('Gaultheria procumbens',      'wintergreen'),   v_action_id, 80),
    (v_disorder_id, herbal.ensure_herb('Guaiacum officinale',        'guaiacum'),      v_action_id, 90),
    (v_disorder_id, herbal.ensure_herb('Harpagophytum procumbens',   'devil''s claw'), v_action_id, 100),
    (v_disorder_id, herbal.ensure_herb('Menyanthes trifoliata',      'bogbean'),       v_action_id, 110),
    (v_disorder_id, herbal.ensure_herb('Populus tremuloides',        'aspen'),         v_action_id, 120),
    (v_disorder_id, herbal.ensure_herb('Salix spp.',                 'willow'),        v_action_id, 130),
    (v_disorder_id, herbal.ensure_herb('Tanacetum parthenium',       'feverfew'),      v_action_id, 140)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Alterative (8 herbs)
  v_action_id := herbal.ensure_action('Alterative');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Arctium lappa',         'burdock'),      v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',   'black cohosh'), v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Guaiacum officinale',   'guaiacum'),     v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Iris versicolor',       'blue flag'),    v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Mahonia aquifolium',    'Oregon grape'), v_action_id, 50),
    (v_disorder_id, herbal.ensure_herb('Menyanthes trifoliata', 'bogbean'),      v_action_id, 60),
    (v_disorder_id, herbal.ensure_herb('Rumex crispus',         'yellow dock'),  v_action_id, 70),
    (v_disorder_id, herbal.ensure_herb('Smilax spp.',           'sarsaparilla'), v_action_id, 80)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Antispasmodic (3 herbs)
  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',  'black cohosh'), v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),     v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Viburnum opulus',      'cramp bark'),   v_action_id, 30)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Bitter tonic (4 herbs)
  v_action_id := herbal.ensure_action('Bitter tonic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Achillea millefolium', 'yarrow'),     v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Artemisia absinthium', 'wormwood'),   v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Gentiana lutea',       'gentian'),    v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Hydrastis canadensis', 'goldenseal'), v_action_id, 40)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Circulatory stimulant (5 herbs)
  v_action_id := herbal.ensure_action('Circulatory stimulant');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum',       'cayenne'),     v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Phytolacca americana',  'poke root'),   v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis','rosemary'),    v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Zanthoxylum americanum','prickly ash'), v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Zingiber officinale',   'ginger'),      v_action_id, 50)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Diuretic (7 herbs; dandelion leaf per source "dandelion leaf")
  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Achillea millefolium',     'yarrow'),              v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Apium graveolens',         'celery seed'),         v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Arctostaphylos uva-ursi',  'bearberry'),           v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Eupatorium perfoliatum',   'boneset'),             v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Eupatorium purpureum',     'gravel root'),         v_action_id, 50),
    (v_disorder_id, herbal.ensure_herb('Petroselinum crispum',     'parsley'),             v_action_id, 60),
    (v_disorder_id, herbal.ensure_herb('Taraxacum officinale',     'Dandelion', 'leaf'),   v_action_id, 70)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Hepatic (3 herbs; dandelion root per source "dandelion root")
  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Rheum palmatum',      'rhubarb root'),           v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Rumex crispus',       'yellow dock'),            v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Taraxacum officinale','Dandelion', 'root'),      v_action_id, 30)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Rubefacient (8 herbs)
  v_action_id := herbal.ensure_action('Rubefacient');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Armoracia rusticana',   'horseradish'), v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Brassica spp.',         'mustard'),     v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Capsicum annuum',       'cayenne'),     v_action_id, 30),
    (v_disorder_id, herbal.ensure_herb('Gaultheria procumbens', 'wintergreen'), v_action_id, 40),
    (v_disorder_id, herbal.ensure_herb('Mentha piperita',       'peppermint'),  v_action_id, 50),
    (v_disorder_id, herbal.ensure_herb('Rosmarinus officinalis','rosemary'),    v_action_id, 60),
    (v_disorder_id, herbal.ensure_herb('Senecio jacobaea',      'ragwort'),     v_action_id, 70),
    (v_disorder_id, herbal.ensure_herb('Zingiber officinale',   'ginger'),      v_action_id, 80)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Nervine (3 herbs)
  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Apium graveolens',     'celery seed'),     v_action_id, 10),
    (v_disorder_id, herbal.ensure_herb('Piscidia erythrina',   'Jamaica dogwood'), v_action_id, 20),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis','valerian'),        v_action_id, 30)
  ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Musculoskeletal Overall: disorder_action_herbs inserted.';
END $$;
