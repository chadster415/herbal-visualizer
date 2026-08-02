-- Migration 096: Musculoskeletal System
-- Body system: Musculoskeletal
-- 17 body-system notes, 11 primary actions, 8 disorders:
-- Overall, Myalgia, Osteoarthritis, Rheumatoid Arthritis, Osteoporosis,
-- Gout, Bursitis and Tendonitis, Restless Legs Syndrome

SET search_path TO herbal, public;


-- ============================================================
-- BLOCK 0: Ensure Musculoskeletal body system exists
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.body_systems (name)
    VALUES ('Musculoskeletal')
    ON CONFLICT (name) DO NOTHING;
END $$;


-- ============================================================
-- BLOCK 1: Body System Notes (17 notes from # Notes section)
-- ============================================================
DO $$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  INSERT INTO herbal.body_system_notes (body_system_id, note_text, sort_order) VALUES
    (v_id, 'Extensive skeletal misalignment can impair the function of the neurological system and other organs and disrupt the harmony of the whole body. Osteopathic or chiropractic techniques can be of great value in realigning the body, as can methods of psychophysical adjustment, such as rolfing, the Alexander technique, and Feldenkrais.', 10),
    (v_id, 'If our biochemical and metabolic processes are out of tune, the body will be under much strain to remove waste and toxins. If this condition persists unnoticed for years - as it often does - toxins can build up in the connective tissue of the joints. This can sow the seeds for the development of rheumatism and arthritis, particularly if there is a genetic disposition to such conditions.', 20),
    (v_id, 'Rheumatism is a very general term used to describe any of various conditions characterized by inflammation or pain in muscles, joints, or connective tissue. Arthritis, on the other hand, specifically describes inflammation of joints.', 30),
    (v_id, 'Systemic factors so often lay the foundation for degenerative musculoskeletal conditions. Thus, the primary actions of the truly healing antirheumatic herbs can usually be identified as alterative, diuretic, or some other systemically beneficial action. In general, anti-inflammatory herbs simply improve the symptom picture. As desirable as this is for the patient, it does not usually indicate a beneficial alteration in the disease process.', 40),
    (v_id, 'More than 100 conditions are technically classified as rheumatic diseases. The conditions that make up this group of health problems share many common symptoms, including pain, stiffness, and swelling of joints and the supporting structures of the body, such as muscles, tendons, ligaments, and bones.', 50),
    (v_id, 'The word arthritis literally means "joint inflammation," and is correctly applied to describe the swelling, redness, heat, and pain caused by tissue injury or joint disease. About one in seven Americans exhibits some form of arthritis, which is usually characterized by inflammation in the affected tissue.', 60),
    (v_id, 'Some rheumatic diseases are described as connective tissue diseases because they primarily affect the body''s connective tissues — the supporting framework of the body and its internal organs.', 70),
    (v_id, 'Other rheumatic conditions are classified as autoimmune diseases because they are associated with a systemic problem in which the immune system harms the body''s own healthy tissues.', 80),
    (v_id, 'Take NSAIDs with food, and drink six to eight glasses of water each day to decrease gastrointestinal side effects. Also, the patient should not recline within a half hour of taking NSAIDs.', 90),
    (v_id, 'Diet: Weight control is particularly important here, because extra weight puts pressure on some joints and can aggravate arthritis.', 100),
    (v_id, 'Diet: Dietary measures are especially essential for people with gout. These patients should avoid alcohol and foods high in purines, such as organ meats (liver, kidney), sardines, and anchovies.', 110),
    (v_id, 'Glucosamine sulfate is a nutritional supplement that may enhance the reconstruction and healing of cartilage. Amino sugars are the building blocks of very large molecules called glycosaminoglycans (GAGs), also known as mucopolysaccharides. GAGs are large, spongy, water-holding molecules that form the gel-like matrix of ground substance, or the "glue" that holds our bodies together. This substance is found in all connective tissue and mucous membranes. Glucosamine macromolecules are the basic substrate of cartilage, ligaments, tendons, and bones. The normal diet is not a good source of glucosamine, so the body synthesizes it from glucose and the amino acid glutamine. The suggested dose for osteoarthritis is 500 mg three times a day.', 120),
    (v_id, 'Arthritis and Friction: When trying to create an environment conducive to healing within the body, as much attention must be paid to emotional and mental harmony as to diet and herbal medicine. An outlook on life that is tight, defensive, and lacking in vulnerability and openness will tend to feed the rheumatism. On the other hand, initiating an inner process of relaxation to reduce emotional friction, allow free interaction with other people, and open up emotions and beliefs sets the stage for the miracle of self-healing to occur. Herbs can facilitate this process.', 130),
    (v_id, 'With rheumatic and arthritic problems, perhaps more than with any other condition, it is essential to treat the whole person. Otherwise, improvement will be only slight or temporary.', 140),
    (v_id, 'Systemic lupus erythematosus (also known as lupus or SLE) is an autoimmune disease in which the immune system harms the body''s tissues.', 150),
    (v_id, 'Ankylosing Spondylitis is a type of arthritis that primarily affects the spine, but it may also impact the hips, shoulders, and knees. The tendons and ligaments around the bones and joints in the spine become inflamed, resulting in pain and stiffness, especially in the lower back.', 160),
    (v_id, 'Psoriatic Arthritis is a form of arthritis that affects some patients with psoriasis, a common scaling skin disorder. Psoriatic arthritis often affects the joints at the ends of the fingers and is accompanied by changes in the fingernails and toenails.', 170)
  ON CONFLICT (body_system_id, sort_order) DO NOTHING;
  RAISE NOTICE 'Musculoskeletal system notes inserted.';
END $$;


-- ============================================================
-- BLOCK 2: Primary Actions (from ## Action Herbs, Disorder: Overall)
-- ============================================================
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  -- Antirheumatic
  v_action_id := herbal.ensure_action('Antirheumatic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium',       'yarrow'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Angelica archangelica',      'angelica'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Apium graveolens',           'celery seed'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctium lappa',              'burdock'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctostaphylos uva-ursi',    'bearberry'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Armoracia rusticana',        'horseradish'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Arnica montana',             'arnica'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Artemisia absinthium',       'wormwood'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Artemisia vulgaris',         'mugwort'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Betula spp.',                'birch'),         v_action_id, v_sys_id),
    (herbal.ensure_herb('Brassica spp.',              'mustard'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Capsicum annuum',            'cayenne'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Cimicifuga racemosa',        'black cohosh'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Dioscorea villosa',          'wild yam'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium perfoliatum',     'boneset'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium purpureum',       'gravel root'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Filipendula ulmaria',        'meadowsweet'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Fucus vesiculosus',          'bladderwrack'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Gaultheria procumbens',      'wintergreen'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Guaiacum officinale',        'guaiacum'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Harpagophytum procumbens',   'devil''s claw'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Iris versicolor',            'blue flag'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Juniperus communis',         'juniper'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Mahonia aquifolium',         'Oregon grape'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Menyanthes trifoliata',      'bogbean'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Myrica cerifera',            'bayberry'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Petroselinum crispum',       'parsley'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Phytolacca americana',       'poke root'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Populus tremuloides',        'aspen'),         v_action_id, v_sys_id),
    (herbal.ensure_herb('Rosmarinus officinalis',     'rosemary'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Rumex crispus',              'yellow dock'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Salix spp.',                 'willow'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Smilax spp.',                'sarsaparilla'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Tanacetum parthenium',       'feverfew'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Taraxacum officinale',       'dandelion'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Urtica dioica',              'nettle'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Viburnum opulus',            'cramp bark'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Zanthoxylum americanum',     'prickly ash'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Zingiber officinale',        'ginger'),        v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Analgesic
  v_action_id := herbal.ensure_action('Analgesic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Filipendula ulmaria',   'meadowsweet'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Guaiacum officinale',   'guaiacum'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Hypericum perforatum',  'St. John''s wort'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Piscidia erythrina',    'Jamaica dogwood'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Salix spp.',            'willow'),         v_action_id, v_sys_id),
    (herbal.ensure_herb('Valeriana officinalis', 'valerian'),       v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Anti-inflammatory
  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Angelica archangelica',      'angelica'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Apium graveolens',           'celery seed'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Betula spp.',                'birch'),         v_action_id, v_sys_id),
    (herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Cimicifuga racemosa',        'black cohosh'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Dioscorea villosa',          'wild yam'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Filipendula ulmaria',        'meadowsweet'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Gaultheria procumbens',      'wintergreen'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Guaiacum officinale',        'guaiacum'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Harpagophytum procumbens',   'devil''s claw'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Menyanthes trifoliata',      'bogbean'),       v_action_id, v_sys_id),
    (herbal.ensure_herb('Populus tremuloides',        'aspen'),         v_action_id, v_sys_id),
    (herbal.ensure_herb('Salix spp.',                 'willow'),        v_action_id, v_sys_id),
    (herbal.ensure_herb('Tanacetum parthenium',       'feverfew'),      v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Alterative
  v_action_id := herbal.ensure_action('Alterative');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Arctium lappa',         'burdock'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Cimicifuga racemosa',   'black cohosh'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Guaiacum officinale',   'guaiacum'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Iris versicolor',       'blue flag'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Mahonia aquifolium',    'Oregon grape'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Menyanthes trifoliata', 'bogbean'),      v_action_id, v_sys_id),
    (herbal.ensure_herb('Rumex crispus',         'yellow dock'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Smilax spp.',           'sarsaparilla'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Cimicifuga racemosa',  'black cohosh'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Valeriana officinalis','valerian'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Viburnum opulus',      'cramp bark'),   v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Bitter tonic
  v_action_id := herbal.ensure_action('Bitter tonic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium', 'yarrow'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Artemisia absinthium', 'wormwood'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Gentiana lutea',       'gentian'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Hydrastis canadensis', 'goldenseal'), v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Circulatory stimulant
  v_action_id := herbal.ensure_action('Circulatory stimulant');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Capsicum annuum',       'cayenne'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Phytolacca americana',  'poke root'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Rosmarinus officinalis','rosemary'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Zanthoxylum americanum','prickly ash'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Zingiber officinale',   'ginger'),      v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Diuretic
  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Achillea millefolium',   'yarrow'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Angelica archangelica',  'angelica'),   v_action_id, v_sys_id),
    (herbal.ensure_herb('Apium graveolens',       'celery seed'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Arctostaphylos uva-ursi','bearberry'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium perfoliatum', 'boneset'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Eupatorium purpureum',   'gravel root'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Petroselinum crispum',   'parsley'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Taraxacum officinale',   'dandelion'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Urtica dioica',          'nettle'),     v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Hepatic
  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Rheum palmatum',       'rhubarb root'),v_action_id, v_sys_id),
    (herbal.ensure_herb('Rumex crispus',        'yellow dock'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Taraxacum officinale', 'dandelion'),   v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Rubefacient
  v_action_id := herbal.ensure_action('Rubefacient');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Armoracia rusticana',   'horseradish'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Brassica spp.',         'mustard'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Capsicum annuum',       'cayenne'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Gaultheria procumbens', 'wintergreen'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Mentha piperita',       'peppermint'),  v_action_id, v_sys_id),
    (herbal.ensure_herb('Rosmarinus officinalis','rosemary'),    v_action_id, v_sys_id),
    (herbal.ensure_herb('Senecio jacobaea',      'ragwort'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Zingiber officinale',   'ginger'),      v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  -- Nervine
  v_action_id := herbal.ensure_action('Nervine');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES
    (herbal.ensure_herb('Apium graveolens',     'celery seed'),     v_action_id, v_sys_id),
    (herbal.ensure_herb('Piscidia erythrina',   'Jamaica dogwood'), v_action_id, v_sys_id),
    (herbal.ensure_herb('Valeriana officinalis','valerian'),        v_action_id, v_sys_id)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Musculoskeletal primary actions inserted.';
END $$;


-- ============================================================
-- BLOCK 3: Disorder — Overall
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Overall', v_sys_id, 10)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Overall' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'External applications containing hot spices (such as cayenne, mustard, and ginger) should not be used by patients with rheumatoid arthritis.', 10)
  ON CONFLICT DO NOTHING;

  -- Prescription: Black Mustard Poultice
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Black Mustard Poultice',
      'Mustard seeds can be applied externally to ease acute local pain, sciatica, and gout. Prepare a poultice by mixing powdered mustard seeds with warm water to form a paste. Spread onto brown paper and apply to affected area. For rheumatic pain, mustard oil, a powerful local irritant, may be incorporated into liniments for application to affected areas. This treatment should not be used in rheumatoid arthritis.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Brassica nigra', 'black mustard'), '', 10)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: White Mustard Poultice
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'White Mustard Poultice',
      'Poultices made with mustard flowers, bread crumbs and vinegar are a traditional treatment for rheumatic and sciatic pains. As an alternative, mix white mustard seeds with black mustard seeds. Although mustard poultices may redden the skin, they are very stimulating and efficient.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Brassica alba', 'white mustard'), '', 10)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: Cayenne Poultice
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Cayenne Poultice',
      'Mix ingredients to make a poultice. If the cayenne causes too powerful a burning sensation, cover the skin with vegetable oil before applying poultice.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Capsicum annuum',  'cayenne'),      '1 part', 10),
      (v_rx_id, herbal.ensure_herb('Verbascum thapsus','mullein'),      '1 part', 20),
      (v_rx_id, herbal.ensure_herb('Ulmus rubra',      'slippery elm'), '1 part', 30)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: Cayenne and Glycerin Liniment
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Cayenne and Glycerin Liniment',
      'Mix equal parts of cayenne tincture and glycerin, shake well, and apply to painful joints. If cayenne causes a burning sensation, apply vegetable oil first. Cayenne powder or tincture may also be rubbed on inflamed areas for added relief.',
      40)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Capsicum annuum', 'cayenne'), '1 part', 10)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: Lavender Essential Oil Anti-Inflammatory
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Lavender Essential Oil Anti-Inflammatory',
      'A small amount of essential oil of lavender, added to a fixed oil (such as almond oil) is a useful anti-inflammatory for the treatment of rheumatic complaints.',
      50)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lavandula spp.', 'lavender'), '', 10)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: Lobelia Liniment
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Lobelia Liniment',
      'Infuse herbs for one week in 1 quart of brandy in a closely corked, wide-necked bottle. Shake well daily. Strain, press out clear liquid, and rub mixture on affected areas.',
      60)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Lobelia inflata',        'lobelia'),      '1 ounce',   'crushed seed and herb', 10),
      (v_rx_id, herbal.ensure_herb('Symplocarpus foetidus',  'skunk cabbage'),'1 ounce',   'root and rhizome',      20),
      (v_rx_id, herbal.ensure_herb('Scutellaria lateriflora','skullcap'),     '1 ounce',   'herb',                  30),
      (v_rx_id, herbal.ensure_herb('Commiphora molmol',      'myrrh'),        '1 ounce',   'gum',                   40),
      (v_rx_id, herbal.ensure_herb('Valeriana officinalis',  'valerian'),     '1 ounce',   'root',                  50),
      (v_rx_id, herbal.ensure_herb('Capsicum annuum',        'cayenne'),      '1/2 ounce', 'dried fruit',           60)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: Mullein Liniment
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Mullein Liniment',
      'Mullein combines well with Cimicifuga racemosa and Lobelia inflata in liniments. For swollen joints, and to relieve the aches and pains of arthritis and rheumatism, rub mullein oil thoroughly into skin, or saturate a piece of cotton with the mullein oil, apply to skin, and cover with a dry dressing. Prepare mullein oil by infusing mullein flowers in olive oil. For the treatment of painful and swollen joints, pour boiling vinegar over a small quantity of mullein, cover, and simmer slowly for 20 to 30 minutes. Strain; add a small amount of tinctures of cayenne and lobelia. Apply to affected areas.',
      70)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Verbascum thapsus',   'mullein'),      '', 10),
      (v_rx_id, herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh'), '', 20),
      (v_rx_id, herbal.ensure_herb('Lobelia inflata',     'lobelia'),      '', 30)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription: Sassafras Rheumatism Liniment
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Sassafras Rheumatism Liniment',
      'A traditional North American liniment for rheumatic problems. Shake ingredients together well and apply to affected parts.',
      80)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Sassafras albidum',    'sassafras'),   '1 ounce', 'tincture', 10),
      (v_rx_id, herbal.ensure_herb('Zanthoxylum americanum','prickly ash'),'1 ounce', 'tincture', 20),
      (v_rx_id, herbal.ensure_herb('Capsicum annuum',      'cayenne'),     '1 ounce', 'tincture', 30),
      (v_rx_id, herbal.ensure_herb('Commiphora molmol',    'myrrh'),       '1 ounce', 'tincture', 40)
    ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Musculoskeletal: Overall disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 4: Disorder — Myalgia
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Myalgia', v_sys_id, 20)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Myalgia' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Fibromyalgia causes pain and stiffness throughout the tissues that support and move the bones and joints. Pain and localized tender points occur in the muscles and tendons, particularly those of the neck, spine, shoulders, and hips.', 10),
    (v_disorder_id, 'Myalgia, also generally called rheumatism, is a notoriously vague and misused description for aches and pains in the musculature. Since these symptoms are also common to the early stages of many infections and a range of autoimmune conditions, they may call for a more detailed differential diagnosis. A safe rule of thumb is to consider the problem more deeply if symptoms cannot be eased to some degree within two weeks.', 20),
    (v_disorder_id, 'Treatment: An important aspect of treatment is to support the musculoskeletal system by using appropriate tonics.', 30),
    (v_disorder_id, 'Sports injuries: If myalgia is the result of long-standing sports injuries, the addition of antispasmodics can help loosen the muscles.', 40),
    (v_disorder_id, 'Digestive disorders: If the patient has a history of digestive problems, appropriate digestive tonics are indicated.', 50),
    (v_disorder_id, 'Cardiovascular issues: Cardiovascular tonics should be added if the patient has hypertension or overt heart disease.', 60),
    (v_disorder_id, 'Stress: Long-standing stress can lead to the development of tension and tightness in the muscles. This, in turn, may hold the joints too tightly, resulting in friction.', 70)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antirheumatic'),
      'help because of their general value for this body system.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'are especially indicated if there is much sensitivity to touch.', 20),
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'are indicated if there is a suspicion of a systemic problem.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'ease any associated muscular tension, often the core of this problem.', 40),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'may help by increasing local circulation; however, they are usually best used in the form of rubefacients.', 50),
    (v_disorder_id, herbal.ensure_action('Rubefacient'),
      'stimulate circulatory activity, thus increasing removal of tissue waste and the local supply of oxygen and nutrients.', 60),
    (v_disorder_id, herbal.ensure_action('Analgesic'),
      'are of limited, symptomatic value only.', 70),
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'appear to be very effective in easing vague rheumatic aches and pains.', 80),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'may be indicated.', 90)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Filipendula ulmaria',   'meadowsweet'),
      'Most of the salicylate-containing anti-inflammatory herbs are considered specifics in the various folk traditions of the world. External applications will often help — rubefacients, circulatory stimulants, salicin-containing essential oils, or antispasmodic herbs.', 10),
    (v_disorder_id, herbal.ensure_herb('Gaultheria procumbens', 'wintergreen'),
      'Most of the salicylate-containing anti-inflammatory herbs are considered specifics in the various folk traditions of the world.', 20),
    (v_disorder_id, herbal.ensure_herb('Populus tremuloides',   'aspen'),
      'Most of the salicylate-containing anti-inflammatory herbs are considered specifics in the various folk traditions of the world.', 30),
    (v_disorder_id, herbal.ensure_herb('Salix spp.',            'willow'),
      'Most of the salicylate-containing anti-inflammatory herbs are considered specifics in the various folk traditions of the world.', 40),
    (v_disorder_id, herbal.ensure_herb('Angelica archangelica', 'angelica'),
      'In addition to salicylate-containing herbs, all of the herbs in the general antirheumatic category may be considered.', 50),
    (v_disorder_id, herbal.ensure_herb('Apium graveolens',      'celery seed'),
      'In addition to salicylate-containing herbs, all of the herbs in the general antirheumatic category may be considered.', 60)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: A Prescription for Myalgia
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Myalgia',
      'Dosage: up to 5 ml of tincture three times a day. The internal treatment supplies a basic range of anti-rheumatic herbs that provide salicylate anti-inflammatory actions, along with support for the digestive process and more generalized alterative effects.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Salix spp.', 'willow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Angelica archangelica', 'angelica');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))          ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))   ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: An Antispasmodic Rub
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'An Antispasmodic Rub',
      'Rub tincture mixture into painful muscles as needed.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))     ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Musculoskeletal: Myalgia disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 5: Disorder — Osteoarthritis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Osteoarthritis', v_sys_id, 30)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Osteoarthritis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Osteoarthritis primarily affects cartilage, the tissue that cushions the ends of bones in the joints. The condition occurs when cartilage begins to fray, wear, and decay.', 10),
    (v_disorder_id, 'Osteoarthritis causes joint pain, reduced joint motion, loss of function, and disability.', 20),
    (v_disorder_id, 'In osteoarthritis, the surface layer of cartilage breaks down and wears away. The bones under the cartilage are then able to rub together, causing pain, swelling, and loss of motion.', 30),
    (v_disorder_id, 'Although osteoarthritis can occur in any joint, it most often affects the ends of the fingers, thumbs, neck, lower back, knees, and hips.', 40),
    (v_disorder_id, 'Exercise is an essential component of any treatment plan for osteoarthritis. Strength training with exercise bands is useful for resistance training. Aerobic exercise helps keep the lungs and circulatory system in shape. Range of motion exercises help keep the joints limber. Agility activities help the patient maintain daily living skills.', 50)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antirheumatic'),
      'will usually help, but selection must be based on a sound therapeutic rationale.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'are fundamental here, as their use not only eases the symptom picture but also helps arrest degenerative changes to bony tissue. Salicylate-based herbs, such as Filipendula ulmaria, are especially helpful.', 20),
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'are the key to any attempt to transform systemic problems (if present). However, if the osteoarthritis is associated primarily with physical wear-and-tear, alteratives are not quite as fundamental. In cases like this, Menyanthes trifoliata is primarily indicated.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'lessen the impact of physical friction by relaxing the muscular envelope around the arthroses. Cimicifuga racemosa proves effective here.', 40),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'support the healing process by increasing blood flow through the tissue. The bark and berries of Zanthoxylum americanum are good choices.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Menyanthes trifoliata',   'bogbean'),
      'Both bogbean and devil''s claw could be considered specifics here. However, because of the multifactorial etiology of osteoarthritis, it is unlikely that there will be any one specific remedy.', 10),
    (v_disorder_id, herbal.ensure_herb('Harpagophytum procumbens','devil''s claw'),
      'Both bogbean and devil''s claw could be considered specifics here. However, because of the multifactorial etiology of osteoarthritis, it is unlikely that there will be any one specific remedy.', 20),
    (v_disorder_id, herbal.ensure_herb('Urtica dioica',           'nettle'),
      'A traditional European remedy that is both taken internally and used externally as a rubefacient.', 30)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: A Prescription for Osteoarthritis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Osteoarthritis',
      'Dosage: up to 5 ml of tincture three times a day. In addition, use external treatments as indicated. If the patient experiences stomach irritation related to Menyanthes, add Althaea.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Menyanthes trifoliata', 'bogbean');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter tonic'))      ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Filipendula ulmaria', 'meadowsweet');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 1/2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))     ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Zanthoxylum americanum', 'prickly ash');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Circulatory stimulant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery seed');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Angelica archangelica', 'angelica');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 70);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter tonic')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: A Warming, Stimulating Liniment
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Warming, Stimulating Liniment',
      'Mix equal parts of glycerin and tincture of cayenne. Rub into the affected joints or muscles. Care must be taken not to use the liniment on broken skin or on the sensitive skin of the face, as it will cause a burning sensation.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Capsicum annuum', 'cayenne'), '1 part', 10)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: St. John's Wort Oil
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'St. John''s Wort Oil',
      'Make St. John''s wort oil in late summer by picking fresh blossoms and putting them into oil. Crush the flowers in a tablespoon of the oil and place in a clear glass container. Pour the rest of the oil over the flowers and mix well. Leave the container open in a warm place for three to five days, then seal and place in sunshine or another warm place for three to six weeks. Shake daily until the oil takes on a bright red color. Press through a cloth and let stand for a day to allow the oil to separate from the water. Carefully pour off the oil and store in an airtight, opaque container. May be rubbed on areas of rheumatic pain, used for neuralgic or sciatic pains, or applied to minor burns.',
      30)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort'), '100 g', 'fresh blossoms', 10)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 4: Supplements for Osteoarthritis (no herbs)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Supplements for Osteoarthritis',
      'In Textbook of Natural Medicine, Drs. Pizzorno and Murray suggest: Glucosamine sulfate 1,500 mg/day; Vitamin E 600 IU/day; Vitamin A 5,000 IU/day; Vitamin C 1 to 3 g/day; Vitamin B6 50 mg/day; Pantothenic acid 12.5 mg/day; Methionine 400 mg 3x/day; Zinc 45 mg/day; Copper 1 mg/day.',
      40)
    ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Musculoskeletal: Osteoarthritis disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 6: Disorder — Rheumatoid Arthritis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Rheumatoid Arthritis', v_sys_id, 40)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Rheumatoid Arthritis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Rheumatoid arthritis is an inflammatory disease of the lining of the joint that results in pain, stiffness, swelling, deformity, and loss of joint function. The inflammation most often affects joints of the hands and feet and tends to occur equally on both sides of the body.', 10),
    (v_disorder_id, 'Rheumatoid arthritis is a chronic inflammatory condition that involves not only the joints, but other connective tissue as well. About 2.1 million Americans, or 1% of the adult population of the United States, have rheumatoid arthritis.', 20),
    (v_disorder_id, 'Rheumatoid arthritis is one of several autoimmune arthritic diseases.', 30),
    (v_disorder_id, 'The joint destruction that occurs in severe rheumatoid arthritis is caused by inflammation of the synovial membrane, the thin, smooth capsule that lines the joints.', 40),
    (v_disorder_id, 'Rheumatoid arthritis generally occurs symmetrically. That is, if one knee or hand is involved, the other will be also. The disease often affects the wrist joints and the finger joints closest to the hand.', 50),
    (v_disorder_id, 'For about 5% to 10% of rheumatoid arthritis patients, the arthritis is mild or limited to one or two episodes. Another 25% have an erratic pattern of prolonged remissions and periods of relapse. In the majority, however, the clinical course is progressive with intermittent flare-ups. About 10% of patients progress to severe permanent joint deformity, limitation of movement, or serious disability.', 60),
    (v_disorder_id, 'Treatment: Potentially, every system and organ of the body may need tonic support in this autoimmune condition that so severely affects connective tissue.', 70),
    (v_disorder_id, 'Because of the nature of the inflammation in rheumatoid arthritis, phytosterol-containing anti-inflammatory herbs, such as Dioscorea villosa (wild yam), come into their own. However, the salicylate-containing herbs are still helpful. Filipendula ulmaria (meadowsweet) fits perfectly. Phytosterol- and salicylate-containing herbs complement one another well.', 80),
    (v_disorder_id, 'The complex of potential causes of this autoimmune condition includes aspects of psychology. Anxiety and depression are major aggravating factors for rheumatoid arthritis. Nervine relaxants also help as antispasmodics, and nervine tonics will ease the constant stress caused by the pain and discomfort.', 90),
    (v_disorder_id, 'Broader context of treatment: Exercise maintains healthy and strong muscles, preserving joint mobility and flexibility. Exercise can also help with sleep problems, reduce pain, foster a positive attitude, and facilitate weight loss.', 100)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antirheumatic'),
      'will help, but their selection must be based on a rationale that takes into account the individual''s unique issues.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'are very important here, as much of the symptom picture is the direct result of the inflammatory process.', 20),
    (v_disorder_id, herbal.ensure_action('Alterative'),
      'play a pivotal role in any immune system work. Menyanthes trifoliata is essential.', 30),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'such as Cimicifuga racemosa, will ease any associated muscular tension.', 40),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'are not as crucial in rheumatoid arthritis as they are in osteoarthritis.', 50),
    (v_disorder_id, herbal.ensure_action('Rubefacient'),
      'are not as relevant here as in osteoarthritis, and, in fact, can aggravate symptoms of rheumatoid arthritis.', 60),
    (v_disorder_id, herbal.ensure_action('Analgesic'),
      'will ease both the pain and the stress response to the pain.', 70),
    (v_disorder_id, herbal.ensure_action('Nervine'),
      'are especially relevant, considering the acknowledged psychosomatic contribution to this problem.', 80),
    (v_disorder_id, herbal.ensure_action('Nervine relaxant'),
      'help as antispasmodics.', 90),
    (v_disorder_id, herbal.ensure_action('Hypnotic'),
      'will help with sleep in the face of pain.', 100)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Menyanthes trifoliata',   'bogbean'),
      'There are no specific remedies for rheumatoid arthritis. However, alterative-based antirheumatic herbs are of special relevance here, with an emphasis on the alterative action.', 10),
    (v_disorder_id, herbal.ensure_herb('Harpagophytum procumbens','devil''s claw'),
      'Alterative-based antirheumatic herbs are of special relevance here, with an emphasis on the alterative action.', 20),
    (v_disorder_id, herbal.ensure_herb('Arctium lappa',           'burdock'),
      'Alterative-based antirheumatic herbs are of special relevance here, with an emphasis on the alterative action.', 30),
    (v_disorder_id, herbal.ensure_herb('Guaiacum officinale',     'guaiacum'),
      'Especially useful as an anti-inflammatory.', 40),
    (v_disorder_id, herbal.ensure_herb('Dioscorea villosa',       'wild yam'),
      'Especially useful as an anti-inflammatory.', 50),
    (v_disorder_id, herbal.ensure_herb('Tanacetum parthenium',    'feverfew'),
      'Can be very helpful for some people.', 60)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription 1: A Prescription for Rheumatoid Arthritis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Rheumatoid Arthritis',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Menyanthes trifoliata', 'bogbean');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter tonic'))      ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Filipendula ulmaria', 'meadowsweet');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 1/2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Dioscorea villosa', 'wild yam');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 1/2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Guaiacum officinale', 'guaiacum');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))        ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))     ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery seed');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 70);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))      ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative'))   ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Angelica archangelica', 'angelica');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 80);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative'))       ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 90);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))     ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Bitter tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 100);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine tonic'))  ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antidepressant')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: A Prescription for Sleep and Pain Relief
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Sleep and Pain Relief',
      'Dosage: 5 to 15 ml of tincture one-half hour before retiring.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Piscidia erythrina', 'Jamaica dogwood');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Analgesic'))        ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Passiflora incarnata', 'passionflower');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hypnotic'))         ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Nervine relaxant')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 3: Supplements for Rheumatoid Arthritis (no herbs)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Supplements for Rheumatoid Arthritis',
      'In Textbook of Natural Medicine, Drs. Pizzorno and Murray suggest: DHEA 50 to 200 mg/day; EPA 1.8 g/day or Flaxseed oil 1 tablespoon/day; Pantothenic acid 500 mg four times a day; Quercetin 250 mg three times a day between meals; Vitamin C 1 to 3 g/day; Vitamin E 400 IU/day; Copper 1 mg/day; Manganese 15 mg/day; Selenium 200 mcg/day; Zinc 45 mg/day.',
      30)
    ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Musculoskeletal: Rheumatoid Arthritis disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 7: Disorder — Osteoporosis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Osteoporosis', v_sys_id, 50)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Osteoporosis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Osteoporosis is a disease that weakens bones to the point at which they break easily, especially those in the hip, spine, and wrist.', 10),
    (v_disorder_id, 'Normally, 6% to 12% of an adult''s total skeleton is replaced each year. After skeletal mass peaks — usually around the age of 35 — bones begin to lose calcium faster than they can replace it.', 20),
    (v_disorder_id, 'Certain conditions that impair the body''s ability to absorb calcium, such as kidney disease, Cushing''s syndrome, and hyperthyroidism, can also lead to osteoporosis.', 30),
    (v_disorder_id, 'Osteoporosis is preventable. A diet rich in calcium, vitamin D, and phytoestrogens and a lifestyle that includes regular exercise are thought to be the best ways to prevent osteoporosis.', 40),
    (v_disorder_id, 'Calcium: Calcium-rich foods, such as dairy products, are the preferred source of calcium. Phosphorus-rich foods should be avoided, as they can promote bone loss. High-phosphorus foods include red meats, soft drinks, and foods containing phosphate additives. Overconsumption of alcohol and caffeine is thought to impair calcium absorption.', 50),
    (v_disorder_id, 'Vitamin D and Magnesium: Adequate vitamin D is essential for optimal calcium absorption. Magnesium is also necessary to help the body absorb calcium.', 60),
    (v_disorder_id, 'Exercise: Weight-bearing exercises that put stress on bones, such as dancing, running, walking, stair climbing, and aerobics, reduce bone loss and help prevent osteoporosis. Three times a week for 30 to 45 minutes is recommended.', 70),
    (v_disorder_id, 'Taking into account the physiological processes that underlie osteoporosis, herbal hormonal normalizers may be helpful if started early enough. Antirheumatic herbs can help with pain in the joints and muscles, and anti-inflammatory herbs will similarly reduce the discomfort associated with this problem.', 80)
  ON CONFLICT DO NOTHING;

  -- Prescription 1: A Prescription for Osteoporosis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Osteoporosis',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES
      (v_rx_id, herbal.ensure_herb('Vitex agnus-castus', 'chasteberry'), '2 parts', 10),
      (v_rx_id, herbal.ensure_herb('Equisetum arvense',  'horsetail'),   '1 part',  20),
      (v_rx_id, herbal.ensure_herb('Avena sativa',       'oats'),        '1 part',  30),
      (v_rx_id, herbal.ensure_herb('Urtica dioica',      'nettle'),      '1 part',  40)
    ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: Supplements for Osteoporosis (no herbs)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Supplements for Osteoporosis',
      'In Textbook of Natural Medicine, Drs. Pizzorno and Murray suggest: High-potency multiple vitamin and mineral formula 1 pill; Calcium 800 to 1,200 mg/day; Vitamin D 400 IU/day; Magnesium 400 to 800 mg/day; Boron (as sodium tetrahydraborate) 3 to 5 mg/day.',
      20)
    ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Musculoskeletal: Osteoporosis disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 8: Disorder — Gout
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Gout', v_sys_id, 60)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Gout' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'This form of arthritis is caused by deposits of needlelike crystals of uric acid in the connective tissue, joint spaces, or both. These crystals cause inflammation, swelling, and pain in the affected joint. The joint most commonly affected is the big toe.', 10),
    (v_disorder_id, 'Gout is one of the most painful of the rheumatic diseases. When uric acid crystals are ingested by white blood cells, the cells release enzymes that generate inflammation.', 20),
    (v_disorder_id, 'Normally, uric acid is dissolved in the blood and passes through the kidneys into the urine, where it is eliminated. If the body increases its production of uric acid or if the kidneys do not eliminate enough uric acid, uric acid builds up, resulting in hyperuricemia. Hyperuricemia may also occur when a person eats too many high-purine foods, such as liver, dried beans and peas, anchovies, and gravies.', 30),
    (v_disorder_id, 'Gout appears to be common among people who eat diets that include meat and animal fats, but is unusual in people who follow vegetarian diets. Rapid weight-loss diets may also increase uric acid levels in the blood.', 40),
    (v_disorder_id, 'Cherries are particularly effective in lowering uric acid levels and preventing attacks of gout. Cherries, hawthorn berries, blueberries, and other dark red-blue berries are rich sources of anthocyanidins and proanthocyanidins, which have the ability to prevent breakdown of collagen in connective tissue.', 50)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Diuretic'),
      'play a pivotal role in any attempt to go beyond mere symptom relief, as they can help flush the urates from the body.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'may help, but probably not nearly as much as the patient would like. Inflammation is an appropriate body response to the presence of crystals.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription: A Prescription for Gout
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Gout',
      'Dosage: up to 5 ml of tincture three times a day. In addition, a strong infusion of Urtica dioica should be drunk often.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Eupatorium purpureum', 'gravel root');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Elymus repens', 'couch grass');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery seed');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Diuretic'))          ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Guaiacum officinale', 'guaiacum');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative'))        ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Musculoskeletal: Gout disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 9: Disorder — Bursitis and Tendonitis
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
  v_herb_id     INTEGER;
  v_ph_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Bursitis and Tendonitis', v_sys_id, 70)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Bursitis and Tendonitis' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'Bursitis is a condition involving inflammation of the bursae, small, fluid-filled sacs that serve to reduce friction between bones and other moving structures in the joints. The inflammation may result from arthritis in the joint or from injury to or infection of the bursae.', 10),
    (v_disorder_id, 'Tendonitis refers to inflammation of tendons (tough cords of tissue that connect muscle to bone) caused by overuse, injury, or related rheumatic conditions.', 20),
    (v_disorder_id, 'A bursa is a pocket of connective tissue adjacent to a joint. Lined by a smooth inner surface, the bursa facilitates the gliding movements of muscles and tendons over bony protuberances. Bursitis is inflammation of a bursa that results in pain, tenderness, stiffness, and, in some cases, swelling and redness. The inflammatory process may affect any bursa, but bursitis is most common in the shoulder, elbow, hip, and knee.', 30),
    (v_disorder_id, 'When acute (often due to an accident or injury), the best treatment is to use a compress or stimulating liniment on the affected area.', 40),
    (v_disorder_id, 'Bursitis is associated with strenuous activity, particularly among manual workers and athletes. Tendinitis is most commonly caused by repetitive stress — using the same joint for the same stressful movement again and again.', 50),
    (v_disorder_id, 'Left untreated, chronic bursitis can lead to the formation of calcium deposits in soft tissues, and may even cause permanent limitation of motion in the affected joint. Treatment goals are to restore painless movement to the joint and to maintain the strength of surrounding muscles while giving the injured tissues time to heal. Adequate rest is crucial.', 60)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_action('Antirheumatic'),
      'often help; the choice will depend upon the practitioner''s interpretation of the patient''s total picture.', 10),
    (v_disorder_id, herbal.ensure_action('Anti-inflammatory'),
      'provide the primary action needed for symptomatic relief. Salix is an example.', 20),
    (v_disorder_id, herbal.ensure_action('Antispasmodic'),
      'such as Viburnum opulus, ease local muscle tension.', 30),
    (v_disorder_id, herbal.ensure_action('Circulatory stimulant'),
      'contribute by increasing local blood circulation.', 40),
    (v_disorder_id, herbal.ensure_action('Rubefacient'),
      'contribute by increasing local blood circulation.', 50),
    (v_disorder_id, herbal.ensure_action('Analgesic'),
      'may help with pain. However, the legal herbal analgesics can do very little in such cases, so pain relief is best achieved with anti-inflammatories and antispasmodics.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Prescription 1: A Prescription for Bursitis or Tendinitis
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'A Prescription for Bursitis or Tendinitis',
      'Dosage: up to 5 ml of tincture three times a day.',
      10)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Salix spp.', 'willow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery seed');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic'))     ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Zanthoxylum americanum', 'prickly ash');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Circulatory stimulant')) ON CONFLICT DO NOTHING;
  END IF;

  -- Prescription 2: An Antispasmodic Rub
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'An Antispasmodic Rub',
      'Rub tincture mixture into painful muscles as needed.',
      20)
    ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order) VALUES (v_rx_id, v_herb_id, '1 part', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Musculoskeletal: Bursitis and Tendonitis disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 10: Disorder — Restless Legs Syndrome
-- ============================================================
DO $$
DECLARE
  v_sys_id      INTEGER;
  v_disorder_id INTEGER;
  v_rx_id       INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
    VALUES ('Restless Legs Syndrome', v_sys_id, 80)
    ON CONFLICT (name, body_system_id) DO NOTHING;
  SELECT id INTO v_disorder_id FROM herbal.disorders
    WHERE name = 'Restless Legs Syndrome' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
    (v_disorder_id, 'The syndrome is characterized by tingling or crawling sensations deep in the legs, associated with an overwhelming desire to move the legs to relieve the discomfort. The symptoms often worsen at night.', 10),
    (v_disorder_id, 'Research shows that caffeine can aggravate symptoms. The syndrome has also been linked to iron or folic acid deficiency, especially in people with kidney disease.', 20)
  ON CONFLICT DO NOTHING;

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order) VALUES
    (v_disorder_id, herbal.ensure_herb('Passiflora incarnata',   'passionflower'),
      'Herbs with strong relaxing qualities may be effective in reducing muscle tension and relieving pain.', 10),
    (v_disorder_id, herbal.ensure_herb('Valeriana officinalis',  'valerian'),
      'Herbs with strong relaxing qualities may be effective in reducing muscle tension and relieving pain.', 20),
    (v_disorder_id, herbal.ensure_herb('Piper methysticum',      'kava kava'),
      'Herbs with strong relaxing qualities may be effective in reducing muscle tension and relieving pain.', 30),
    (v_disorder_id, herbal.ensure_herb('Cimicifuga racemosa',    'black cohosh'),
      'Herbs with strong relaxing qualities may be effective in reducing muscle tension and relieving pain.', 40),
    (v_disorder_id, herbal.ensure_herb('Viburnum opulus',        'cramp bark'),
      'May also help relax muscles.', 50)
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  -- Prescription: Supplements for Restless Legs Syndrome (no herbs)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_disorder_id,
      'Supplements for Restless Legs Syndrome',
      'In Textbook of Natural Medicine, Drs. Pizzorno and Murray suggest: Multivitamin containing iron 1 pill; Vitamin E 15 mg/day; B complex 1 pill; Folic acid 400 to 1,000 mcg/day.',
      10)
    ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Musculoskeletal: Restless Legs Syndrome disorder inserted.';
END $$;


-- ============================================================
-- BLOCK 11: Sync — push prescription herb actions into herb_primary_actions
-- ============================================================
DO $$
DECLARE
  v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Musculoskeletal: herb_primary_actions synced from prescription data.';
END $$;
