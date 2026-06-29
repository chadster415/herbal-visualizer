SET search_path TO herbal, public;

-- ═══════════════════════════════════════════════════════════════════════════════
-- Migration 067 — Constituent seed data, herbs H–Z
-- Continues from 066. All helper functions defined in 065.
-- ═══════════════════════════════════════════════════════════════════════════════

-- ─── Hamamelis virginiana (witch hazel) ──────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('hamamelitannin',  'hydrolyzable tannin', 'Astringent; anti-inflammatory; found in witch hazel bark');
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'hamamelitannin',    'primary', 10);
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'gallotannins',      'primary', 20);
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'ellagitannins',     'major',   30);
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'proanthocyanidins', 'major',   40);
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'quercetin',         'moderate',50);
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'kaempferol',        'moderate',60);
  PERFORM herbal.link_constituent('Hamamelis virginiana', 'safrole',           'trace',   70, 'In volatile fraction; avoid in large doses');
  PERFORM herbal.set_menstruum('Hamamelis virginiana', 14, 15, NULL, NULL, TRUE,
    'water or 14–15% alcohol (distillate)', 'Commercial witch hazel is a water distillate (~14% alcohol). Bark tincture at 25–40% for fuller tannin extraction.');
  RAISE NOTICE 'Hamamelis virginiana done';
END $$;

-- ─── Harpagophytum procumbens (devil''s claw) ─────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'harpagoside',   'primary', 10);
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'harpagide',     'major',   20);
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'procumbide',    'moderate',30);
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'luteolin',      'moderate',40);
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'quercetin',     'moderate',50);
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'kaempferol',    'moderate',60);
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'tannins',       'moderate',70);
  PERFORM herbal.ensure_constituent('procumbide', 'iridoid glycoside', 'Found in devil''s claw');
  PERFORM herbal.link_constituent('Harpagophytum procumbens', 'procumbide',    'moderate',30);
  PERFORM herbal.set_menstruum('Harpagophytum procumbens', 30, 60, NULL, NULL, TRUE,
    '30–60% alcohol or water', 'Iridoid glycosides are water-soluble; moderate alcohol captures flavonoids too. Decoction traditional.');
  RAISE NOTICE 'Harpagophytum procumbens done';
END $$;

-- ─── Humulus lupulus (hops) ───────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Humulus lupulus', 'humulone',              'primary', 10);
  PERFORM herbal.link_constituent('Humulus lupulus', 'lupulone',              'primary', 20);
  PERFORM herbal.link_constituent('Humulus lupulus', '2-methyl-3-buten-2-ol', 'major',   30, 'Major sedative; breakdown product of humulone');
  PERFORM herbal.link_constituent('Humulus lupulus', '8-prenylnaringenin',    'major',   40);
  PERFORM herbal.link_constituent('Humulus lupulus', 'isoxanthohumol',        'major',   50);
  PERFORM herbal.link_constituent('Humulus lupulus', 'xanthohumol',           'major',   60);
  PERFORM herbal.link_constituent('Humulus lupulus', 'linalool',              'moderate',70);
  PERFORM herbal.link_constituent('Humulus lupulus', 'myrcene',               'major',   80);
  PERFORM herbal.link_constituent('Humulus lupulus', 'tannins',               'moderate',90);
  PERFORM herbal.link_constituent('Humulus lupulus', 'linarin',               'moderate',100);
  PERFORM herbal.set_menstruum('Humulus lupulus', 60, 70, NULL, NULL, FALSE,
    '60–70% alcohol', 'Alpha and beta acids and prenylated flavanones require moderate-high alcohol.');
  RAISE NOTICE 'Humulus lupulus done';
END $$;

-- ─── Hydrastis canadensis (goldenseal) ───────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Hydrastis canadensis', 'berberine',     'primary', 10, '~4% of root');
  PERFORM herbal.link_constituent('Hydrastis canadensis', 'hydrastine',    'primary', 20, '~2–4% of root');
  PERFORM herbal.link_constituent('Hydrastis canadensis', 'canadine',      'major',   30);
  PERFORM herbal.link_constituent('Hydrastis canadensis', 'meconine',      'moderate',40);
  PERFORM herbal.link_constituent('Hydrastis canadensis', 'chlorogenic acid','moderate',50);
  PERFORM herbal.link_constituent('Hydrastis canadensis', 'caffeic acid',  'minor',   60);
  PERFORM herbal.set_menstruum('Hydrastis canadensis', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Isoquinoline alkaloids require moderate alcohol; water extraction is partial but less effective for berberine.');
  RAISE NOTICE 'Hydrastis canadensis done';
END $$;

-- ─── Hypericum perforatum (St. John''s Wort) ──────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Hypericum perforatum', 'hypericin',       'primary', 10);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'pseudohypericin', 'primary', 20);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'hyperforin',      'primary', 30);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'adhyperforin',    'major',   40);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'amentoflavone',   'major',   50);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'hyperoside',      'major',   60);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'rutin',           'major',   70);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'quercetin',       'major',   80);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'isoquercitrin',   'major',   90);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'caffeic acid',    'moderate',100);
  PERFORM herbal.link_constituent('Hypericum perforatum', 'chlorogenic acid','moderate',110);
  PERFORM herbal.set_menstruum('Hypericum perforatum', 60, 75, NULL, NULL, FALSE,
    '60–75% alcohol (fresh flower)', 'Hyperforin is highly lipophilic; requires high alcohol. Hypericins need moderate-high alcohol. Fresh flowering tops tincture preferred.');
  RAISE NOTICE 'Hypericum perforatum done';
END $$;

-- ─── Hyssopus officinalis (hyssop) ───────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'pinocamphone',    'primary', 10);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'isopinocamphone', 'primary', 20);
  PERFORM herbal.link_constituent('Hyssopus officinalis', '1,8-cineole',     'major',   30);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'beta-pinene',     'moderate',40);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'diosmin',         'major',   50);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'hesperidin',      'major',   60);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'apigenin',        'moderate',70);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'marrubiin',       'moderate',80);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'tannins',         'moderate',90);
  PERFORM herbal.link_constituent('Hyssopus officinalis', 'rosmarinic acid', 'moderate',100);
  PERFORM herbal.set_menstruum('Hyssopus officinalis', 40, 60, NULL, NULL, TRUE,
    '40–60% alcohol or water', 'Volatile monoterpenes captured in moderate alcohol; flavonoids and marrubiin also extract in water.');
  RAISE NOTICE 'Hyssopus officinalis done';
END $$;

-- ─── Inula helenium (elecampane) ─────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Inula helenium', 'inulin',           'primary', 10, 'Up to 44% of root by dry weight');
  PERFORM herbal.link_constituent('Inula helenium', 'alantolactone',    'primary', 20);
  PERFORM herbal.link_constituent('Inula helenium', 'isoalantolactone', 'major',   30);
  PERFORM herbal.link_constituent('Inula helenium', 'azulene',          'major',   40);
  PERFORM herbal.link_constituent('Inula helenium', 'camphor',          'moderate',50);
  PERFORM herbal.link_constituent('Inula helenium', 'mucilage',         'major',   60);
  PERFORM herbal.link_constituent('Inula helenium', 'tannins',          'moderate',70);
  PERFORM herbal.link_constituent('Inula helenium', 'resins',           'moderate',80);
  PERFORM herbal.set_menstruum('Inula helenium', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water decoction', 'Inulin in water; sesquiterpene lactones in moderate alcohol. Root decoction traditional for respiratory use.');
  RAISE NOTICE 'Inula helenium done';
END $$;

-- ─── Juniperus communis (juniper berry) ──────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('alpha-terpinen-4-ol', 'monoterpene alcohol', 'Diuretic; antimicrobial; primary urinary active of juniper');
  PERFORM herbal.link_constituent('Juniperus communis', 'alpha-terpinen-4-ol','primary', 10);
  PERFORM herbal.link_constituent('Juniperus communis', 'alpha-pinene',       'major',   20);
  PERFORM herbal.link_constituent('Juniperus communis', 'sabinene',           'major',   30);
  PERFORM herbal.link_constituent('Juniperus communis', 'myrcene',            'moderate',40);
  PERFORM herbal.link_constituent('Juniperus communis', 'limonene',           'moderate',50);
  PERFORM herbal.link_constituent('Juniperus communis', 'terpinen-4-ol',      'major',   60);
  PERFORM herbal.link_constituent('Juniperus communis', 'catechin',           'moderate',70);
  PERFORM herbal.link_constituent('Juniperus communis', 'proanthocyanidins',  'moderate',80);
  PERFORM herbal.link_constituent('Juniperus communis', 'amentoflavone',      'moderate',90);
  PERFORM herbal.set_menstruum('Juniperus communis', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol', 'Volatile terpenes require moderate-high alcohol. Not for use in kidney disease.');
  RAISE NOTICE 'Juniperus communis done';
END $$;

-- ─── Lactuca virosa (wild lettuce) ───────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Lactuca virosa', 'lactucin',      'primary', 10);
  PERFORM herbal.link_constituent('Lactuca virosa', 'lactucopicrin', 'primary', 20);
  PERFORM herbal.link_constituent('Lactuca virosa', 'lactucic acid', 'major',   30);
  PERFORM herbal.link_constituent('Lactuca virosa', 'coumarins',     'moderate',40);
  PERFORM herbal.link_constituent('Lactuca virosa', 'flavonoids',    'moderate',50);
  PERFORM herbal.ensure_constituent('lactucic acid', 'organic acid', 'Found in wild lettuce');
  PERFORM herbal.ensure_constituent('coumarins',     'coumarin',     'General coumarin class');
  PERFORM herbal.ensure_constituent('flavonoids',    'flavonoid',    'General flavonoid class');
  PERFORM herbal.link_constituent('Lactuca virosa', 'lactucic acid', 'major',   30);
  PERFORM herbal.link_constituent('Lactuca virosa', 'coumarins',     'moderate',40);
  PERFORM herbal.link_constituent('Lactuca virosa', 'flavonoids',    'moderate',50);
  PERFORM herbal.set_menstruum('Lactuca virosa', 60, 70, NULL, NULL, FALSE,
    '60–70% alcohol', 'Bitter sesquiterpene lactones require moderate-high alcohol. Fresh plant latex strongest.');
  RAISE NOTICE 'Lactuca virosa done';
END $$;

-- ─── Lavandula spp. (lavender) ───────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Lavandula spp.', 'linalool',        'primary', 10, '25–45% of essential oil');
  PERFORM herbal.link_constituent('Lavandula spp.', 'linalyl acetate', 'primary', 20, '25–45% of essential oil');
  PERFORM herbal.link_constituent('Lavandula spp.', 'terpinen-4-ol',   'major',   30);
  PERFORM herbal.link_constituent('Lavandula spp.', 'camphor',         'moderate',40, 'Higher in lavandin');
  PERFORM herbal.link_constituent('Lavandula spp.', '1,8-cineole',     'minor',   50);
  PERFORM herbal.link_constituent('Lavandula spp.', 'ocimene',         'moderate',60);
  PERFORM herbal.link_constituent('Lavandula spp.', 'rosmarinic acid', 'moderate',70);
  PERFORM herbal.link_constituent('Lavandula spp.', 'luteolin',        'moderate',80);
  PERFORM herbal.link_constituent('Lavandula spp.', 'apigenin',        'moderate',90);
  PERFORM herbal.set_menstruum('Lavandula spp.', 60, 80, NULL, NULL, FALSE,
    '60–80% alcohol', 'Volatile monoterpenes require high alcohol for flower tincture; aromatic herb.');
  RAISE NOTICE 'Lavandula spp. done';
END $$;

-- ─── Leonurus cardiaca (motherwort) ──────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'leonurine',     'primary', 10, 'Uterotonic; cardioactive');
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'stachydrine',   'primary', 20);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'leonuride',     'major',   30);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'betonicine',    'major',   40);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'rutin',         'major',   50);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'quercetin',     'major',   60);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'hyperoside',    'major',   70);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'isoquercitrin', 'moderate',80);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'caffeic acid',  'moderate',90);
  PERFORM herbal.link_constituent('Leonurus cardiaca', 'tannins',       'moderate',100);
  PERFORM herbal.set_menstruum('Leonurus cardiaca', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Alkaloids and flavonoids extract in moderate alcohol; fresh plant tincture at 25–40% preferred.');
  RAISE NOTICE 'Leonurus cardiaca done';
END $$;

-- ─── Lobelia inflata ─────────────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Lobelia inflata', 'lobeline',      'primary', 10);
  PERFORM herbal.link_constituent('Lobelia inflata', 'lobelanine',    'major',   20);
  PERFORM herbal.link_constituent('Lobelia inflata', 'lobelanidine',  'major',   30);
  PERFORM herbal.link_constituent('Lobelia inflata', 'norlobelanine', 'moderate',40);
  PERFORM herbal.link_constituent('Lobelia inflata', 'chelidonic acid','moderate',50);
  PERFORM herbal.link_constituent('Lobelia inflata', 'resins',        'moderate',60);
  PERFORM herbal.ensure_constituent('norlobelanine', 'piperidine alkaloid', 'Found in lobelia');
  PERFORM herbal.ensure_constituent('chelidonic acid','pyranone dicarboxylic acid', 'Found in lobelia');
  PERFORM herbal.link_constituent('Lobelia inflata', 'norlobelanine', 'moderate',40);
  PERFORM herbal.set_menstruum('Lobelia inflata', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol', 'Piperidine alkaloids require moderate-high alcohol. Narrow therapeutic window—use with care.');
  RAISE NOTICE 'Lobelia inflata done';
END $$;

-- ─── Mahonia aquifolium (Oregon grape) ───────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'berberine',     'primary', 10, '~3–5% of root bark');
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'berbamine',     'major',   20);
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'oxyacanthine',  'major',   30);
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'columbamine',   'moderate',40);
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'jatrorrhizine', 'moderate',50);
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'palmatine',     'moderate',60);
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'tannins',       'moderate',70);
  PERFORM herbal.ensure_constituent('oxyacanthine', 'isoquinoline alkaloid', 'Bisbenzylisoquinoline alkaloid; antimicrobial');
  PERFORM herbal.link_constituent('Mahonia aquifolium', 'oxyacanthine',  'major',   30);
  PERFORM herbal.set_menstruum('Mahonia aquifolium', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Isoquinoline alkaloids require moderate alcohol. Root bark tincture.');
  RAISE NOTICE 'Mahonia aquifolium done';
END $$;

-- ─── Matricaria recutita (chamomile) ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Matricaria recutita', 'chamazulene',       'primary', 10, 'Formed from matricine during steam distillation');
  PERFORM herbal.link_constituent('Matricaria recutita', 'alpha-bisabolol',   'primary', 20);
  PERFORM herbal.link_constituent('Matricaria recutita', 'bisabolol oxide A', 'major',   30);
  PERFORM herbal.link_constituent('Matricaria recutita', 'bisabolol oxide B', 'major',   40);
  PERFORM herbal.link_constituent('Matricaria recutita', 'apigenin',          'primary', 50);
  PERFORM herbal.link_constituent('Matricaria recutita', 'apigenin-7-glucoside','primary',60);
  PERFORM herbal.link_constituent('Matricaria recutita', 'luteolin',          'major',   70);
  PERFORM herbal.link_constituent('Matricaria recutita', 'quercetin',         'major',   80);
  PERFORM herbal.link_constituent('Matricaria recutita', 'herniarin',         'major',   90);
  PERFORM herbal.link_constituent('Matricaria recutita', 'umbelliferone',     'moderate',100);
  PERFORM herbal.link_constituent('Matricaria recutita', 'mucilaginous polysaccharides','moderate',110);
  PERFORM herbal.set_menstruum('Matricaria recutita', 40, 60, NULL, NULL, TRUE,
    '40–60% alcohol or water', 'Apigenin and volatile oils in moderate alcohol; water infusion captures water-soluble flavonoid glycosides and mucilage.');
  RAISE NOTICE 'Matricaria recutita done';
END $$;

-- ─── Melissa officinalis (lemon balm) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Melissa officinalis', 'rosmarinic acid', 'primary', 10, 'Primary antiviral and anti-inflammatory constituent');
  PERFORM herbal.link_constituent('Melissa officinalis', 'caffeic acid',    'major',   20);
  PERFORM herbal.link_constituent('Melissa officinalis', 'chlorogenic acid','major',   30);
  PERFORM herbal.link_constituent('Melissa officinalis', 'citral',          'major',   40, 'Also called neral+geranial');
  PERFORM herbal.link_constituent('Melissa officinalis', 'citronellal',     'major',   50);
  PERFORM herbal.link_constituent('Melissa officinalis', 'linalool',        'moderate',60);
  PERFORM herbal.link_constituent('Melissa officinalis', 'geraniol',        'moderate',70);
  PERFORM herbal.link_constituent('Melissa officinalis', 'luteolin',        'major',   80);
  PERFORM herbal.link_constituent('Melissa officinalis', 'apigenin',        'moderate',90);
  PERFORM herbal.link_constituent('Melissa officinalis', 'tannins',         'moderate',100);
  PERFORM herbal.set_menstruum('Melissa officinalis', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Rosmarinic acid water-soluble; volatile oils need moderate alcohol. Fresh plant preferred.');
  RAISE NOTICE 'Melissa officinalis done';
END $$;

-- ─── Mentha piperita (peppermint) ────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Mentha piperita', 'menthol',         'primary', 10, '30–55% of essential oil');
  PERFORM herbal.link_constituent('Mentha piperita', 'menthone',        'primary', 20, '14–32% of essential oil');
  PERFORM herbal.link_constituent('Mentha piperita', 'menthyl acetate', 'major',   30);
  PERFORM herbal.link_constituent('Mentha piperita', 'menthofuran',     'moderate',40, 'Hepatotoxic in large amounts');
  PERFORM herbal.link_constituent('Mentha piperita', 'pulegone',        'minor',   50, 'Toxic in large doses');
  PERFORM herbal.link_constituent('Mentha piperita', '1,8-cineole',     'moderate',60);
  PERFORM herbal.link_constituent('Mentha piperita', 'rosmarinic acid', 'moderate',70);
  PERFORM herbal.link_constituent('Mentha piperita', 'luteolin',        'moderate',80);
  PERFORM herbal.link_constituent('Mentha piperita', 'apigenin',        'moderate',90);
  PERFORM herbal.link_constituent('Mentha piperita', 'hesperidin',      'moderate',100);
  PERFORM herbal.set_menstruum('Mentha piperita', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or water', 'Menthol and volatile oils in moderate alcohol; water infusion captures menthol partially and is traditional.');
  RAISE NOTICE 'Mentha piperita done';
END $$;

-- ─── Mitchella repens (partridgeberry) ───────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Mitchella repens', 'tannins',          'major',   10);
  PERFORM herbal.link_constituent('Mitchella repens', 'saponins',         'moderate',20);
  PERFORM herbal.link_constituent('Mitchella repens', 'alkaloids',        'minor',   30, 'Partridgeberry alkaloids; minor');
  PERFORM herbal.link_constituent('Mitchella repens', 'mucilage',         'moderate',40);
  PERFORM herbal.link_constituent('Mitchella repens', 'caffeic acid',     'minor',   50);
  PERFORM herbal.ensure_constituent('alkaloids', 'alkaloid', 'General alkaloid class');
  PERFORM herbal.link_constituent('Mitchella repens', 'alkaloids',        'minor',   30);
  PERFORM herbal.set_menstruum('Mitchella repens', 25, 50, NULL, NULL, TRUE,
    '25–50% alcohol or water', NULL, TRUE);
  RAISE NOTICE 'Mitchella repens done';
END $$;

-- ─── Nepeta cataria (catnip) ──────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('nepetalactone', 'iridoid monoterpene', 'Insect repellent; found in catnip; behavioral effect in cats');
  PERFORM herbal.ensure_constituent('nepetol',       'monoterpene alcohol', 'Found in catnip');
  PERFORM herbal.link_constituent('Nepeta cataria', 'nepetalactone',  'primary', 10);
  PERFORM herbal.link_constituent('Nepeta cataria', 'nepetol',        'major',   20);
  PERFORM herbal.link_constituent('Nepeta cataria', 'rosmarinic acid','major',   30);
  PERFORM herbal.link_constituent('Nepeta cataria', 'caffeic acid',   'moderate',40);
  PERFORM herbal.link_constituent('Nepeta cataria', 'luteolin',       'moderate',50);
  PERFORM herbal.link_constituent('Nepeta cataria', 'apigenin',       'moderate',60);
  PERFORM herbal.link_constituent('Nepeta cataria', 'tannins',        'moderate',70);
  PERFORM herbal.set_menstruum('Nepeta cataria', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Gentle herb; water infusion is traditional and effective. Fresh plant tincture captures nepetalactone better.');
  RAISE NOTICE 'Nepeta cataria done';
END $$;

-- ─── Panax ginseng (Korean ginseng) ──────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Panax ginseng', 'ginsenosides',         'primary', 10, 'Rb1, Rb2, Rc, Rd (Rb group); Rg1, Re, Rf (Rg group)');
  PERFORM herbal.link_constituent('Panax ginseng', 'polysaccharides',      'major',   20);
  PERFORM herbal.link_constituent('Panax ginseng', 'polyacetylenes',       'moderate',30);
  PERFORM herbal.link_constituent('Panax ginseng', 'beta-sitosterol',      'moderate',40);
  PERFORM herbal.link_constituent('Panax ginseng', 'caffeic acid',         'minor',   50);
  PERFORM herbal.link_constituent('Panax ginseng', 'peptidoglycans',       'moderate',60);
  PERFORM herbal.ensure_constituent('peptidoglycans', 'glycoprotein', 'Immunomodulatory; found in ginseng');
  PERFORM herbal.link_constituent('Panax ginseng', 'peptidoglycans',       'moderate',60);
  PERFORM herbal.set_menstruum('Panax ginseng', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or water decoction', 'Ginsenosides extract in moderate alcohol; polysaccharides in water decoction. Both needed for full activity.');
  RAISE NOTICE 'Panax ginseng done';
END $$;

-- ─── Passiflora incarnata (passionflower) ────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Passiflora incarnata', 'vitexin',       'primary', 10);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'isovitexin',    'primary', 20);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'orientin',      'major',   30);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'isoorientin',   'major',   40);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'chrysin',       'major',   50);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'luteolin',      'moderate',60);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'apigenin',      'moderate',70);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'linarin',       'moderate',80);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'harmane',       'trace',   90, 'Trace beta-carbolines; activity disputed');
  PERFORM herbal.link_constituent('Passiflora incarnata', 'harmine',       'trace',   100);
  PERFORM herbal.link_constituent('Passiflora incarnata', 'GABA',          'moderate',110);
  PERFORM herbal.set_menstruum('Passiflora incarnata', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Flavone C-glycosides are water-soluble; moderate alcohol captures chrysin and lipophilic flavones.');
  RAISE NOTICE 'Passiflora incarnata done';
END $$;

-- ─── Piper methysticum (kava kava) ───────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Piper methysticum', 'kavain',              'primary', 10);
  PERFORM herbal.link_constituent('Piper methysticum', 'dihydrokavain',       'primary', 20);
  PERFORM herbal.link_constituent('Piper methysticum', 'methysticin',         'primary', 30);
  PERFORM herbal.link_constituent('Piper methysticum', 'dihydromethysticin',  'major',   40);
  PERFORM herbal.link_constituent('Piper methysticum', 'yangonin',            'major',   50);
  PERFORM herbal.link_constituent('Piper methysticum', 'desmethoxyyangonin',  'moderate',60);
  PERFORM herbal.link_constituent('Piper methysticum', 'kavalactones',        'primary', 5, 'Collective term for all 6 major kavalactones');
  PERFORM herbal.ensure_constituent('desmethoxyyangonin', 'alpha-pyrone', 'Found in kava');
  PERFORM herbal.link_constituent('Piper methysticum', 'desmethoxyyangonin',  'moderate',60);
  PERFORM herbal.set_menstruum('Piper methysticum', 30, 60, NULL, NULL, TRUE,
    '30–60% alcohol or water+fat emulsion', 'Kavalactones are lipophilic; traditional preparation is water + coconut milk (fat emulsification). Moderate alcohol tincture also effective.');
  RAISE NOTICE 'Piper methysticum done';
END $$;

-- ─── Piscidia erythrina (Jamaica dogwood) ────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('piscidin',       'isoflavone', 'Found in Jamaica dogwood; analgesic');
  PERFORM herbal.ensure_constituent('piscidic acid',  'tartrate ester', 'Found in Jamaica dogwood');
  PERFORM herbal.ensure_constituent('rotenone',       'isoflavanone', 'Found in Jamaica dogwood; ichthyotoxic');
  PERFORM herbal.link_constituent('Piscidia erythrina', 'piscidin',       'primary', 10);
  PERFORM herbal.link_constituent('Piscidia erythrina', 'piscidic acid',  'major',   20);
  PERFORM herbal.link_constituent('Piscidia erythrina', 'rotenone',       'major',   30, 'Use in low doses; toxic in excess');
  PERFORM herbal.link_constituent('Piscidia erythrina', 'formononetin',   'moderate',40);
  PERFORM herbal.link_constituent('Piscidia erythrina', 'biochanin A',    'moderate',50);
  PERFORM herbal.link_constituent('Piscidia erythrina', 'tannins',        'moderate',60);
  PERFORM herbal.set_menstruum('Piscidia erythrina', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Isoflavones and organic acids require moderate alcohol. Root bark preparation.');
  RAISE NOTICE 'Piscidia erythrina done';
END $$;

-- ─── Plantago spp. (plantain) ────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Plantago spp.', 'aucubin',                  'primary', 10);
  PERFORM herbal.link_constituent('Plantago spp.', 'catalpol',                 'major',   20);
  PERFORM herbal.link_constituent('Plantago spp.', 'mucilaginous polysaccharides','primary',30);
  PERFORM herbal.link_constituent('Plantago spp.', 'allantoin',                'major',   40);
  PERFORM herbal.link_constituent('Plantago spp.', 'caffeic acid',             'major',   50);
  PERFORM herbal.link_constituent('Plantago spp.', 'chlorogenic acid',         'major',   60);
  PERFORM herbal.link_constituent('Plantago spp.', 'neochlorogenic acid',      'moderate',70);
  PERFORM herbal.link_constituent('Plantago spp.', 'luteolin',                 'major',   80);
  PERFORM herbal.link_constituent('Plantago spp.', 'apigenin',                 'moderate',90);
  PERFORM herbal.link_constituent('Plantago spp.', 'tannins',                  'moderate',100);
  PERFORM herbal.ensure_constituent('neochlorogenic acid', 'hydroxycinnamic acid', 'Found in plantain');
  PERFORM herbal.link_constituent('Plantago spp.', 'neochlorogenic acid',      'moderate',70);
  PERFORM herbal.set_menstruum('Plantago spp.', NULL, NULL, 60, NULL, TRUE,
    'cold water or glycerin', 'Mucilage and iridoid glycosides extract in cold water or glycerin; heat degrades mucilage. Fresh plant juice also effective.');
  RAISE NOTICE 'Plantago spp. done';
END $$;

-- ─── Rosmarinus officinalis (rosemary) ───────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'rosmarinic acid', 'primary', 10);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'carnosic acid',   'primary', 20);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'carnosol',        'major',   30);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'rosmanol',        'major',   40);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', '1,8-cineole',     'primary', 50, '35–45% of essential oil');
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'camphor',         'major',   60, '10–20% of essential oil');
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'alpha-pinene',    'major',   70);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'borneol',         'moderate',80);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'bornyl acetate',  'moderate',90);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'luteolin',        'major',   100);
  PERFORM herbal.link_constituent('Rosmarinus officinalis', 'apigenin',        'moderate',110);
  PERFORM herbal.set_menstruum('Rosmarinus officinalis', 60, 75, NULL, NULL, FALSE,
    '60–75% alcohol', 'Diterpene phenols and volatile oils require moderate-high alcohol. Water captures rosmarinic acid well.');
  RAISE NOTICE 'Rosmarinus officinalis done';
END $$;

-- ─── Rubus idaeus (raspberry leaf) ───────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('fragarine', 'alkaloid', 'Uterine tonic alkaloid; found in raspberry leaf');
  PERFORM herbal.link_constituent('Rubus idaeus', 'tannins',       'primary', 10, 'Including ellagitannins');
  PERFORM herbal.link_constituent('Rubus idaeus', 'ellagitannins', 'major',   20);
  PERFORM herbal.link_constituent('Rubus idaeus', 'fragarine',     'major',   30);
  PERFORM herbal.link_constituent('Rubus idaeus', 'quercetin',     'major',   40);
  PERFORM herbal.link_constituent('Rubus idaeus', 'kaempferol',    'major',   50);
  PERFORM herbal.link_constituent('Rubus idaeus', 'rutin',         'major',   60);
  PERFORM herbal.link_constituent('Rubus idaeus', 'caffeic acid',  'moderate',70);
  PERFORM herbal.link_constituent('Rubus idaeus', 'vitamin C',     'moderate',80);
  PERFORM herbal.set_menstruum('Rubus idaeus', 25, 45, NULL, NULL, TRUE,
    '25–45% alcohol or water', 'Tannins and flavonoids extract readily in water or low alcohol; traditional as tea.');
  RAISE NOTICE 'Rubus idaeus done';
END $$;

-- ─── Rumex crispus (yellow dock) ─────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Rumex crispus', 'emodin',        'primary', 10);
  PERFORM herbal.link_constituent('Rumex crispus', 'chrysophanol',  'primary', 20);
  PERFORM herbal.link_constituent('Rumex crispus', 'physcion',      'major',   30);
  PERFORM herbal.link_constituent('Rumex crispus', 'tannins',       'major',   40);
  PERFORM herbal.link_constituent('Rumex crispus', 'oxalates',      'major',   50, 'Highest in leaves; lower in root');
  PERFORM herbal.link_constituent('Rumex crispus', 'rutin',         'moderate',60);
  PERFORM herbal.link_constituent('Rumex crispus', 'iron',          'moderate',70);
  PERFORM herbal.set_menstruum('Rumex crispus', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water decoction', 'Anthraquinone glycosides extract in moderate alcohol; root decoction also effective.');
  RAISE NOTICE 'Rumex crispus done';
END $$;

-- ─── Salvia officinalis (sage) ────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Salvia officinalis', 'thujone',       'major',   10, 'Convulsant in large doses; avoid prolonged high-dose use');
  PERFORM herbal.link_constituent('Salvia officinalis', 'camphor',       'major',   20);
  PERFORM herbal.link_constituent('Salvia officinalis', '1,8-cineole',   'major',   30);
  PERFORM herbal.link_constituent('Salvia officinalis', 'borneol',       'moderate',40);
  PERFORM herbal.link_constituent('Salvia officinalis', 'rosmarinic acid','primary', 50);
  PERFORM herbal.link_constituent('Salvia officinalis', 'carnosic acid', 'major',   60);
  PERFORM herbal.link_constituent('Salvia officinalis', 'carnosol',      'major',   70);
  PERFORM herbal.link_constituent('Salvia officinalis', 'luteolin',      'major',   80);
  PERFORM herbal.link_constituent('Salvia officinalis', 'apigenin',      'moderate',90);
  PERFORM herbal.link_constituent('Salvia officinalis', 'tannins',       'moderate',100);
  PERFORM herbal.set_menstruum('Salvia officinalis', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or water', 'Diterpene phenols need moderate alcohol; rosmarinic acid extracts in water. Fresh-dried leaf preferred.');
  RAISE NOTICE 'Salvia officinalis done';
END $$;

-- ─── Sambucus nigra (elder flower/berry) ─────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Sambucus nigra', 'cyanidin-3-glucoside',    'primary', 10, 'Highest in berries');
  PERFORM herbal.link_constituent('Sambucus nigra', 'cyanidin-3-sambubioside', 'primary', 20);
  PERFORM herbal.link_constituent('Sambucus nigra', 'anthocyanins',            'primary', 30);
  PERFORM herbal.link_constituent('Sambucus nigra', 'quercetin',               'major',   40);
  PERFORM herbal.link_constituent('Sambucus nigra', 'rutin',                   'major',   50);
  PERFORM herbal.link_constituent('Sambucus nigra', 'kaempferol',              'major',   60);
  PERFORM herbal.link_constituent('Sambucus nigra', 'chlorogenic acid',        'major',   70);
  PERFORM herbal.link_constituent('Sambucus nigra', 'sambunigrin',             'moderate',80, 'Toxic raw; destroyed by heat or fermentation');
  PERFORM herbal.link_constituent('Sambucus nigra', 'mucilage',                'moderate',90, 'Higher in flowers');
  PERFORM herbal.link_constituent('Sambucus nigra', 'tannins',                 'moderate',100);
  PERFORM herbal.set_menstruum('Sambucus nigra', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol, water, or glycerin', 'Anthocyanins (berry) and flavonoids extract in water, glycerin, or moderate alcohol. Flower glycerite effective. Always heat berries to destroy sambunigrin.');
  RAISE NOTICE 'Sambucus nigra done';
END $$;

-- ─── Scutellaria lateriflora (skullcap) ──────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'baicalin',      'primary', 10);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'baicalein',     'primary', 20);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'scutellarein',  'major',   30);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'wogonin',       'major',   40);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'luteolin',      'major',   50);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'apigenin',      'moderate',60);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'tannins',       'moderate',70);
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'iridoids',      'moderate',80);
  PERFORM herbal.ensure_constituent('iridoids', 'iridoid', 'General iridoid class');
  PERFORM herbal.link_constituent('Scutellaria lateriflora', 'iridoids',      'moderate',80);
  PERFORM herbal.set_menstruum('Scutellaria lateriflora', 50, 60, NULL, NULL, FALSE,
    '50–60% alcohol (fresh plant)', 'Baicalin is water-soluble but baicalein requires alcohol. Fresh plant tincture at 50–60% captures full spectrum. Adulteration with Teucrium common—verify source.');
  RAISE NOTICE 'Scutellaria lateriflora done';
END $$;

-- ─── Serenoa repens (saw palmetto) ───────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Serenoa repens', 'saw palmetto fatty acids','primary', 10, 'Lauric, oleic, myristic, linoleic; inhibit 5-alpha-reductase');
  PERFORM herbal.link_constituent('Serenoa repens', 'phytosterols',            'primary', 20);
  PERFORM herbal.link_constituent('Serenoa repens', 'beta-sitosterol',         'major',   30);
  PERFORM herbal.link_constituent('Serenoa repens', 'stigmasterol',            'moderate',40);
  PERFORM herbal.link_constituent('Serenoa repens', 'polysaccharides',         'moderate',50);
  PERFORM herbal.link_constituent('Serenoa repens', 'tannins',                 'minor',   60);
  PERFORM herbal.set_menstruum('Serenoa repens', 80, 95, NULL, NULL, FALSE,
    '80–95% alcohol or lipid extract', 'Lipophilic fatty acids and sterols require high-% alcohol or oil/lipid extraction. Supercritical CO₂ extract is gold standard.');
  RAISE NOTICE 'Serenoa repens done';
END $$;

-- ─── Silybum marianum (milk thistle) ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Silybum marianum', 'silymarin',      'primary', 10, 'Complex of silybin, silydianin, silychristin');
  PERFORM herbal.link_constituent('Silybum marianum', 'silybin',        'primary', 20, 'Most bioactive component; also called silibinin');
  PERFORM herbal.link_constituent('Silybum marianum', 'silydianin',     'major',   30);
  PERFORM herbal.link_constituent('Silybum marianum', 'silychristin',   'major',   40);
  PERFORM herbal.link_constituent('Silybum marianum', 'taxifoline',     'major',   50);
  PERFORM herbal.link_constituent('Silybum marianum', 'quercetin',      'moderate',60);
  PERFORM herbal.link_constituent('Silybum marianum', 'fatty acids',    'moderate',70);
  PERFORM herbal.ensure_constituent('taxifoline', 'dihydroflavonol', 'Antioxidant; found in milk thistle');
  PERFORM herbal.link_constituent('Silybum marianum', 'taxifoline',     'major',   50);
  PERFORM herbal.set_menstruum('Silybum marianum', 70, 80, NULL, NULL, FALSE,
    '70–80% alcohol', 'Silymarin flavonolignans are poorly water-soluble; require high alcohol. Standardized seed extract common. Phospholipid complex improves bioavailability.');
  RAISE NOTICE 'Silybum marianum done';
END $$;

-- ─── Symphytum officinale (comfrey) ──────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Symphytum officinale', 'allantoin',                'primary', 10);
  PERFORM herbal.link_constituent('Symphytum officinale', 'mucilaginous polysaccharides','primary',20);
  PERFORM herbal.link_constituent('Symphytum officinale', 'rosmarinic acid',          'major',   30);
  PERFORM herbal.link_constituent('Symphytum officinale', 'chlorogenic acid',         'moderate',40);
  PERFORM herbal.link_constituent('Symphytum officinale', 'pyrrolizidine alkaloids',  'major',   50, 'Highest in root; hepatotoxic—internal use of root restricted');
  PERFORM herbal.link_constituent('Symphytum officinale', 'symphytine',               'major',   60, 'Primary pyrrolizidine alkaloid');
  PERFORM herbal.link_constituent('Symphytum officinale', 'tannins',                  'moderate',70);
  PERFORM herbal.link_constituent('Symphytum officinale', 'steroidal saponins',       'moderate',80);
  PERFORM herbal.set_menstruum('Symphytum officinale', NULL, NULL, 60, NULL, TRUE,
    'cold water or glycerin (leaf only)', 'Allantoin and mucilage extract in cold water; glycerin also effective. Avoid internal use of root preparations due to pyrrolizidine alkaloids.');
  RAISE NOTICE 'Symphytum officinale done';
END $$;

-- ─── Tanacetum parthenium (feverfew) ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'parthenolide',  'primary', 10, '0.2–0.9% of dry leaf; primary anti-migraine constituent');
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'camphor',       'major',   20);
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'chrysanthemyl acetate','moderate',30);
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'luteolin',      'major',   40);
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'apigenin',      'moderate',50);
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'quercetin',     'moderate',60);
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'tannins',       'minor',   70);
  PERFORM herbal.ensure_constituent('chrysanthemyl acetate', 'monoterpene ester', 'Found in feverfew and chrysanthemum');
  PERFORM herbal.link_constituent('Tanacetum parthenium', 'chrysanthemyl acetate','moderate',30);
  PERFORM herbal.set_menstruum('Tanacetum parthenium', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol (fresh plant)', 'Parthenolide is lipophilic; requires moderate-high alcohol. Fresh leaf tincture preferred; parthenolide degrades in dried herb.');
  RAISE NOTICE 'Tanacetum parthenium done';
END $$;

-- ─── Taraxacum officinale (dandelion) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Taraxacum officinale', 'taraxacin',        'primary', 10);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'taraxacerin',      'major',   20);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'taraxasterol',     'major',   30);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'inulin',           'primary', 40, 'Up to 40% of root in autumn');
  PERFORM herbal.link_constituent('Taraxacum officinale', 'beta-sitosterol',  'moderate',50);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'caffeic acid',     'major',   60);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'chlorogenic acid', 'major',   70);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'potassium',        'primary', 80, 'Abundant in leaves; contributes to diuretic effect');
  PERFORM herbal.link_constituent('Taraxacum officinale', 'beta-carotene',    'major',   90, 'Especially in leaves');
  PERFORM herbal.link_constituent('Taraxacum officinale', 'luteolin',         'moderate',100);
  PERFORM herbal.link_constituent('Taraxacum officinale', 'quercetin',        'moderate',110);
  PERFORM herbal.set_menstruum('Taraxacum officinale', 25, 50, NULL, NULL, TRUE,
    '25–50% alcohol or water', 'Bitter sesquiterpenes and polyphenols in moderate alcohol; inulin and minerals in water. Root decoction or leaf infusion both traditional.');
  RAISE NOTICE 'Taraxacum officinale done';
END $$;

-- ─── Thymus vulgaris (thyme) ──────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Thymus vulgaris', 'thymol',         'primary', 10, '20–55% of essential oil; potent antimicrobial');
  PERFORM herbal.link_constituent('Thymus vulgaris', 'carvacrol',      'primary', 20, '1–10% of essential oil');
  PERFORM herbal.link_constituent('Thymus vulgaris', 'p-cymene',       'major',   30);
  PERFORM herbal.link_constituent('Thymus vulgaris', 'linalool',       'moderate',40);
  PERFORM herbal.link_constituent('Thymus vulgaris', 'rosmarinic acid','major',   50);
  PERFORM herbal.link_constituent('Thymus vulgaris', 'luteolin',       'major',   60);
  PERFORM herbal.link_constituent('Thymus vulgaris', 'apigenin',       'major',   70);
  PERFORM herbal.link_constituent('Thymus vulgaris', 'naringenin',     'moderate',80);
  PERFORM herbal.link_constituent('Thymus vulgaris', 'tannins',        'moderate',90);
  PERFORM herbal.set_menstruum('Thymus vulgaris', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or water', 'Thymol and carvacrol require moderate alcohol; water infusion captures volatile oils via steam and is traditional for respiratory use.');
  RAISE NOTICE 'Thymus vulgaris done';
END $$;

-- ─── Tilia platyphyllos / spp. (linden) ─────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('tiliroside',   'kaempferol glycoside', 'Anti-inflammatory; found in linden flower');
  PERFORM herbal.ensure_constituent('farnesol',     'sesquiterpene alcohol', 'Sedative; found in linden flower volatile fraction');
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'tiliroside',   'primary', 10);
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'quercetin',    'major',   20);
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'kaempferol',   'major',   30);
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'rutin',        'major',   40);
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'mucilage',     'primary', 50, 'Abundant in bract; demulcent');
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'farnesol',     'major',   60);
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'tannins',      'moderate',70);
  PERFORM herbal.link_constituent('Tilia platyphyllos', 'caffeic acid', 'moderate',80);
  PERFORM herbal.set_menstruum('Tilia platyphyllos', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Mucilage and flavonoid glycosides extract in water or low alcohol; gentle warm infusion traditional.');
  RAISE NOTICE 'Tilia platyphyllos done';
END $$;

-- ─── Trifolium pratense (red clover) ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Trifolium pratense', 'formononetin',   'primary', 10);
  PERFORM herbal.link_constituent('Trifolium pratense', 'biochanin A',    'primary', 20);
  PERFORM herbal.link_constituent('Trifolium pratense', 'daidzein',       'major',   30);
  PERFORM herbal.link_constituent('Trifolium pratense', 'genistein',      'major',   40);
  PERFORM herbal.link_constituent('Trifolium pratense', 'kaempferol',     'moderate',50);
  PERFORM herbal.link_constituent('Trifolium pratense', 'quercetin',      'moderate',60);
  PERFORM herbal.link_constituent('Trifolium pratense', 'coumarins',      'moderate',70);
  PERFORM herbal.link_constituent('Trifolium pratense', 'caffeic acid',   'moderate',80);
  PERFORM herbal.set_menstruum('Trifolium pratense', 40, 60, NULL, NULL, TRUE,
    '40–60% alcohol or water', 'Isoflavones partially water-soluble; moderate alcohol for better extraction of formononetin and biochanin A.');
  RAISE NOTICE 'Trifolium pratense done';
END $$;

-- ─── Ulmus rubra (slippery elm) ───────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Ulmus rubra', 'mucilaginous polysaccharides','primary', 10, 'Inner bark ~60% mucilage');
  PERFORM herbal.link_constituent('Ulmus rubra', 'arabinogalacturonan',        'primary', 20);
  PERFORM herbal.link_constituent('Ulmus rubra', 'tannins',                    'moderate',30);
  PERFORM herbal.link_constituent('Ulmus rubra', 'beta-sitosterol',            'minor',   40);
  PERFORM herbal.link_constituent('Ulmus rubra', 'zinc',                       'minor',   50);
  PERFORM herbal.ensure_constituent('zinc', 'mineral', 'Wound healing; immune support');
  PERFORM herbal.link_constituent('Ulmus rubra', 'zinc',                       'minor',   50);
  PERFORM herbal.set_menstruum('Ulmus rubra', NULL, NULL, 60, NULL, TRUE,
    'cold water or glycerin', 'Mucilage is destroyed by alcohol and heat; cold-water preparation or glycerite only. Denatured by boiling.');
  RAISE NOTICE 'Ulmus rubra done';
END $$;

-- ─── Urtica dioica (nettle) ───────────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Urtica dioica', 'urtica dioica agglutinin','primary', 10, 'Lectin in root; immunomodulatory; inhibits SHBG binding');
  PERFORM herbal.link_constituent('Urtica dioica', 'quercetin',               'major',   20);
  PERFORM herbal.link_constituent('Urtica dioica', 'kaempferol',              'major',   30);
  PERFORM herbal.link_constituent('Urtica dioica', 'isorhamnetin',            'moderate',40);
  PERFORM herbal.link_constituent('Urtica dioica', 'caffeic acid',            'major',   50);
  PERFORM herbal.link_constituent('Urtica dioica', 'chlorogenic acid',        'major',   60);
  PERFORM herbal.link_constituent('Urtica dioica', 'beta-sitosterol',         'moderate',70, 'Especially in root');
  PERFORM herbal.link_constituent('Urtica dioica', 'lignans',                 'moderate',80, 'Especially in root; anti-androgenic');
  PERFORM herbal.link_constituent('Urtica dioica', 'formic acid',             'major',   90, 'In stinging hairs of fresh leaf');
  PERFORM herbal.link_constituent('Urtica dioica', 'histamine',               'major',   100,'In stinging hairs; destroyed by drying/cooking');
  PERFORM herbal.link_constituent('Urtica dioica', 'serotonin',               'moderate',110,'In stinging hairs');
  PERFORM herbal.link_constituent('Urtica dioica', 'iron',                    'major',   120,'High in leaf; nutritive');
  PERFORM herbal.link_constituent('Urtica dioica', 'silica',                  'moderate',130);
  PERFORM herbal.link_constituent('Urtica dioica', 'potassium',               'major',   140,'Contributes to diuretic effect');
  PERFORM herbal.set_menstruum('Urtica dioica', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Flavonoids and minerals extract in water; root lectins and lignans in moderate alcohol. Fresh plant juice also effective for leaf.');
  RAISE NOTICE 'Urtica dioica done';
END $$;

-- ─── Valeriana officinalis (valerian) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Valeriana officinalis', 'valerenic acid',        'primary', 10, 'GABA-A receptor modulator; primary sedative constituent');
  PERFORM herbal.link_constituent('Valeriana officinalis', 'acetoxyvalerenic acid', 'primary', 20);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'isovaleric acid',       'major',   30, 'Characteristic odor; sedative');
  PERFORM herbal.link_constituent('Valeriana officinalis', 'valepotriates',         'primary', 40, 'In fresh root only; degrade in dried herb');
  PERFORM herbal.link_constituent('Valeriana officinalis', 'valtrate',              'major',   50);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'didrovaltrate',         'major',   60);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'valeranol',             'moderate',70);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'bornyl acetate',        'major',   80);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'borneol',               'moderate',90);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'GABA',                  'moderate',100);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'linarin',               'major',   110);
  PERFORM herbal.link_constituent('Valeriana officinalis', 'hesperidin',            'moderate',120);
  PERFORM herbal.set_menstruum('Valeriana officinalis', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol (fresh root)', 'Valerenic acids and valepotriates require moderate alcohol; valepotriates degrade in water and dried herb. Fresh root tincture captures full profile.');
  RAISE NOTICE 'Valeriana officinalis done';
END $$;

-- ─── Verbena officinalis / hastata (vervain) ─────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.ensure_constituent('verbenalin',  'iridoid glycoside', 'Found in vervain; bitter; liver-stimulating');
  PERFORM herbal.ensure_constituent('hastatoside', 'iridoid glycoside', 'Found in blue vervain');
  PERFORM herbal.link_constituent('Verbena officinalis', 'verbenalin',    'primary', 10);
  PERFORM herbal.link_constituent('Verbena officinalis', 'hastatoside',   'major',   20);
  PERFORM herbal.link_constituent('Verbena officinalis', 'aucubin',       'major',   30);
  PERFORM herbal.link_constituent('Verbena officinalis', 'tannins',       'major',   40);
  PERFORM herbal.link_constituent('Verbena officinalis', 'caffeic acid',  'moderate',50);
  PERFORM herbal.link_constituent('Verbena officinalis', 'luteolin',      'moderate',60);
  PERFORM herbal.link_constituent('Verbena officinalis', 'quercetin',     'moderate',70);
  PERFORM herbal.set_menstruum('Verbena officinalis', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Iridoid glycosides water-soluble; tannins also extract in water. Moderate alcohol tincture of fresh plant preferred.');
  RAISE NOTICE 'Verbena officinalis done';
END $$;

-- ─── Viburnum opulus (cramp bark) ────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Viburnum opulus', 'scopoletin',    'primary', 10, 'Antispasmodic; serotonin antagonist');
  PERFORM herbal.link_constituent('Viburnum opulus', 'scopoline',     'major',   20);
  PERFORM herbal.link_constituent('Viburnum opulus', 'aesculetin',    'major',   30);
  PERFORM herbal.link_constituent('Viburnum opulus', 'arbutin',       'major',   40);
  PERFORM herbal.link_constituent('Viburnum opulus', 'tannins',       'major',   50);
  PERFORM herbal.link_constituent('Viburnum opulus', 'valerianic acid','moderate',60);
  PERFORM herbal.link_constituent('Viburnum opulus', 'salicin',       'moderate',70);
  PERFORM herbal.link_constituent('Viburnum opulus', 'resins',        'moderate',80);
  PERFORM herbal.ensure_constituent('scopoline',     'coumarin alkaloid', 'Found in cramp bark');
  PERFORM herbal.ensure_constituent('valerianic acid','organic acid', 'Antispasmodic; found in cramp bark and valerian');
  PERFORM herbal.link_constituent('Viburnum opulus', 'scopoline',     'major',   20);
  PERFORM herbal.link_constituent('Viburnum opulus', 'valerianic acid','moderate',60);
  PERFORM herbal.set_menstruum('Viburnum opulus', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Coumarins and resins require moderate alcohol; bark tincture standard preparation.');
  RAISE NOTICE 'Viburnum opulus done';
END $$;

-- ─── Viburnum prunifolium (black haw) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'scopoletin',  'primary', 10);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'aesculetin',  'major',   20);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'salicin',     'major',   30);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'arbutin',     'major',   40);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'tannins',     'major',   50);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'valerianic acid','moderate',60);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'resins',      'moderate',70);
  PERFORM herbal.link_constituent('Viburnum prunifolium', 'chlorogenic acid','moderate',80);
  PERFORM herbal.set_menstruum('Viburnum prunifolium', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', 'Similar to cramp bark; coumarins and resins require moderate alcohol. Bark or root bark tincture.');
  RAISE NOTICE 'Viburnum prunifolium done';
END $$;

-- ─── Vitex agnus-castus (chasteberry) ────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'aucubin',      'primary', 10);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'agnuside',     'primary', 20);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'casticin',     'primary', 30);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'vitexin',      'major',   40);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'isovitexin',   'major',   50);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'luteolin',     'major',   60);
  PERFORM herbal.link_constituent('Vitex agnus-castus', '1,8-cineole',  'major',   70);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'sabinene',     'moderate',80);
  PERFORM herbal.link_constituent('Vitex agnus-castus', 'alpha-pinene', 'moderate',90);
  PERFORM herbal.set_menstruum('Vitex agnus-castus', 60, 70, NULL, NULL, FALSE,
    '60–70% alcohol', 'Diterpenes and volatile oils require moderate-high alcohol. Berry tincture; long-term use required for effect (3–6 months).');
  RAISE NOTICE 'Vitex agnus-castus done';
END $$;

-- ─── Withania somnifera (ashwagandha) ─────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Withania somnifera', 'withanolides',    'primary', 10, '0.001–0.5% of dry root');
  PERFORM herbal.link_constituent('Withania somnifera', 'withaferin A',    'primary', 20);
  PERFORM herbal.link_constituent('Withania somnifera', 'withanosides',    'major',   30);
  PERFORM herbal.link_constituent('Withania somnifera', 'alkaloids',       'major',   40, 'Somniferine, somnine, somniferinine, withananine');
  PERFORM herbal.link_constituent('Withania somnifera', 'steroidal saponins','moderate',50);
  PERFORM herbal.link_constituent('Withania somnifera', 'beta-sitosterol', 'moderate',60);
  PERFORM herbal.link_constituent('Withania somnifera', 'iron',            'moderate',70);
  PERFORM herbal.set_menstruum('Withania somnifera', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or milk decoction', 'Withanolides extract in moderate alcohol; traditional use is milk decoction (fat helps absorption of lipophilic withanolides). Dual extraction ideal.');
  RAISE NOTICE 'Withania somnifera done';
END $$;

-- ─── Zingiber officinale (ginger) ────────────────────────────────────────────
DO $$ BEGIN
  PERFORM herbal.link_constituent('Zingiber officinale', 'gingerols',    'primary', 10, 'Highest in fresh root; 6-gingerol primary');
  PERFORM herbal.link_constituent('Zingiber officinale', '6-gingerol',   'primary', 20);
  PERFORM herbal.link_constituent('Zingiber officinale', 'shogaols',     'primary', 30, 'Formed from gingerols on drying; more potent anti-inflammatory');
  PERFORM herbal.link_constituent('Zingiber officinale', 'zingerone',    'major',   40);
  PERFORM herbal.link_constituent('Zingiber officinale', 'zingiberene',  'primary', 50);
  PERFORM herbal.link_constituent('Zingiber officinale', 'bisabolene',   'moderate',60);
  PERFORM herbal.link_constituent('Zingiber officinale', 'borneol',      'moderate',70);
  PERFORM herbal.link_constituent('Zingiber officinale', 'camphor',      'moderate',80);
  PERFORM herbal.link_constituent('Zingiber officinale', 'caffeic acid', 'minor',   90);
  PERFORM herbal.set_menstruum('Zingiber officinale', 40, 70, NULL, NULL, TRUE,
    '40–70% alcohol or water', 'Gingerols and shogaols in moderate alcohol; ginger tea (water) is highly effective for volatile gingerols and is traditional. Fresh root tincture at 60–70% for maximum potency.');
  RAISE NOTICE 'Zingiber officinale done';
END $$;

-- ─── Remaining herbs (needs_review flagged) ──────────────────────────────────
-- Less-studied or regionally-specific herbs; data is sparser.

DO $$ BEGIN
  -- Agathosma betulina (buchu)
  PERFORM herbal.ensure_constituent('diosphenol',  'monoterpenoid', 'Primary diuretic volatile of buchu');
  PERFORM herbal.ensure_constituent('pulegone',    'monoterpene ketone');
  PERFORM herbal.link_constituent('Agathosma betulina', 'diosphenol',    'primary', 10);
  PERFORM herbal.link_constituent('Agathosma betulina', 'pulegone',      'major',   20);
  PERFORM herbal.link_constituent('Agathosma betulina', 'quercetin',     'moderate',30);
  PERFORM herbal.link_constituent('Agathosma betulina', 'diosmin',       'moderate',40);
  PERFORM herbal.link_constituent('Agathosma betulina', 'rutin',         'moderate',50);
  PERFORM herbal.set_menstruum('Agathosma betulina', 60, 70, NULL, NULL, FALSE,
    '60–70% alcohol', 'Volatile diosphenol requires moderate-high alcohol.');

  -- Anemopsis californica (yerba mansa)
  PERFORM herbal.link_constituent('Anemopsis californica', 'methyleugenol',  'major',   10, NULL, TRUE);
  PERFORM herbal.link_constituent('Anemopsis californica', 'piperol A',      'major',   20, NULL, TRUE);
  PERFORM herbal.link_constituent('Anemopsis californica', 'tannins',        'major',   30);
  PERFORM herbal.link_constituent('Anemopsis californica', 'caffeic acid',   'moderate',40, NULL, TRUE);
  PERFORM herbal.ensure_constituent('piperol A', 'phenylpropanoid', 'Found in yerba mansa; antimicrobial');
  PERFORM herbal.link_constituent('Anemopsis californica', 'piperol A',      'major',   20, NULL, TRUE);
  PERFORM herbal.set_menstruum('Anemopsis californica', 40, 70, NULL, NULL, FALSE,
    '40–70% alcohol', NULL, TRUE);

  -- Aralia californica (California spikenard)
  PERFORM herbal.ensure_constituent('araloside A', 'triterpenoid saponin', 'Found in Aralia spp.');
  PERFORM herbal.link_constituent('Aralia californica', 'araloside A',      'major',   10, NULL, TRUE);
  PERFORM herbal.link_constituent('Aralia californica', 'triterpenoid saponins','major', 20, NULL, TRUE);
  PERFORM herbal.link_constituent('Aralia californica', 'caffeic acid',     'moderate',30, NULL, TRUE);
  PERFORM herbal.link_constituent('Aralia californica', 'polyacetylenes',   'moderate',40, NULL, TRUE);
  PERFORM herbal.set_menstruum('Aralia californica', 40, 60, NULL, NULL, FALSE,
    '40–60% alcohol', NULL, TRUE);

  -- Lomatium dissectum
  PERFORM herbal.ensure_constituent('furanocoumarins (lomatium)', 'furanocoumarin', 'Antiviral; found in Lomatium; can cause rash');
  PERFORM herbal.link_constituent('Lomatium dissectum', 'furanocoumarins (lomatium)', 'primary', 10);
  PERFORM herbal.link_constituent('Lomatium dissectum', 'galbanic acid',    'major',   20, NULL, TRUE);
  PERFORM herbal.link_constituent('Lomatium dissectum', 'resins',           'major',   30);
  PERFORM herbal.link_constituent('Lomatium dissectum', 'polyacetylenes',   'moderate',40);
  PERFORM herbal.ensure_constituent('galbanic acid', 'furanocoumarin', 'Antiviral; found in Lomatium');
  PERFORM herbal.link_constituent('Lomatium dissectum', 'galbanic acid',    'major',   20, NULL, TRUE);
  PERFORM herbal.set_menstruum('Lomatium dissectum', 60, 80, NULL, NULL, FALSE,
    '60–80% alcohol', 'Resins and furanocoumarins require moderate-high alcohol. Fresh root.', TRUE);

  RAISE NOTICE 'Remaining herbs (needs_review) done';
END $$;

-- ─── Also-ran herbs: link shared constituents for cross-herb lookups ──────────
-- Several herbs in the DB share well-known constituents; add those here.

DO $$ BEGIN
  -- Elymus repens (couch grass) — polysaccharides + minerals
  PERFORM herbal.link_constituent('Elymus repens', 'mucilaginous polysaccharides','primary', 10);
  PERFORM herbal.link_constituent('Elymus repens', 'silica',      'major',   20);
  PERFORM herbal.link_constituent('Elymus repens', 'potassium',   'moderate',30);
  PERFORM herbal.link_constituent('Elymus repens', 'saponins',    'moderate',40);
  PERFORM herbal.set_menstruum('Elymus repens', NULL, NULL, NULL, NULL, TRUE,
    'water decoction', 'Mucilage and silica extract in water decoction; rhizome.');

  -- Eupatorium perfoliatum (boneset) — sesquiterpene lactones + polysaccharides
  PERFORM herbal.ensure_constituent('eupatorin', 'flavone', 'Found in boneset; anti-inflammatory');
  PERFORM herbal.link_constituent('Eupatorium perfoliatum', 'eupatorin',   'primary', 10);
  PERFORM herbal.link_constituent('Eupatorium perfoliatum', 'echinacea polysaccharides','major',20);
  PERFORM herbal.link_constituent('Eupatorium perfoliatum', 'caffeic acid','moderate',30);
  PERFORM herbal.link_constituent('Eupatorium perfoliatum', 'quercetin',   'moderate',40);
  PERFORM herbal.set_menstruum('Eupatorium perfoliatum', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Bitter flavones and polysaccharides extract in water or moderate alcohol.');

  -- Ginkgo biloba
  PERFORM herbal.link_constituent('Ginkgo biloba', 'ginkgolides',                 'primary', 10);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'ginkgolide B',                'primary', 20);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'ginkgolide A',                'major',   30);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'bilobalide',                  'primary', 40);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'flavonol glycosides (ginkgo)','primary', 50);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'quercetin',                   'major',   60);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'kaempferol',                  'major',   70);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'isorhamnetin',                'major',   80);
  PERFORM herbal.link_constituent('Ginkgo biloba', 'proanthocyanidins',           'moderate',90);
  PERFORM herbal.set_menstruum('Ginkgo biloba', 60, 70, NULL, NULL, FALSE,
    '60–70% alcohol', 'Ginkgolides and bilobalide require moderate-high alcohol. Standardized extract (24% flavone glycosides, 6% terpene lactones) is the research form.');

  -- Solidago virgaurea (goldenrod)
  PERFORM herbal.ensure_constituent('leiocarposide', 'phenolic glycoside', 'Anti-inflammatory; diuretic; found in goldenrod');
  PERFORM herbal.link_constituent('Solidago virgaurea', 'leiocarposide',  'primary', 10);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'quercetin',      'major',   20);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'rutin',          'major',   30);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'kaempferol',     'major',   40);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'caffeic acid',   'moderate',50);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'chlorogenic acid','moderate',60);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'saponins',       'moderate',70);
  PERFORM herbal.link_constituent('Solidago virgaurea', 'tannins',        'moderate',80);
  PERFORM herbal.set_menstruum('Solidago virgaurea', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Phenolic glycosides and flavonoids extract in water or moderate alcohol; traditional as tea.');

  -- Stellaria media (chickweed)
  PERFORM herbal.link_constituent('Stellaria media', 'saponins',       'major',   10);
  PERFORM herbal.link_constituent('Stellaria media', 'mucilage',       'major',   20);
  PERFORM herbal.link_constituent('Stellaria media', 'coumarins',      'moderate',30);
  PERFORM herbal.link_constituent('Stellaria media', 'quercetin',      'moderate',40);
  PERFORM herbal.link_constituent('Stellaria media', 'rutin',          'moderate',50);
  PERFORM herbal.link_constituent('Stellaria media', 'vitamin C',      'moderate',60);
  PERFORM herbal.set_menstruum('Stellaria media', NULL, NULL, NULL, NULL, TRUE,
    'fresh plant juice or cold water', 'Demulcent saponins and mucilage in fresh plant; primarily a topical or fresh-juice herb.');

  -- Verbascum thapsus (mullein)
  PERFORM herbal.ensure_constituent('verbascosaponin', 'triterpenoid saponin', 'Expectorant; found in mullein');
  PERFORM herbal.link_constituent('Verbascum thapsus', 'verbascosaponin',     'primary', 10);
  PERFORM herbal.link_constituent('Verbascum thapsus', 'mucilaginous polysaccharides','primary',20);
  PERFORM herbal.link_constituent('Verbascum thapsus', 'aucubin',             'major',   30);
  PERFORM herbal.link_constituent('Verbascum thapsus', 'caffeic acid',        'moderate',40);
  PERFORM herbal.link_constituent('Verbascum thapsus', 'luteolin',            'moderate',50);
  PERFORM herbal.link_constituent('Verbascum thapsus', 'apigenin',            'moderate',60);
  PERFORM herbal.link_constituent('Verbascum thapsus', 'tannins',             'moderate',70);
  PERFORM herbal.set_menstruum('Verbascum thapsus', NULL, NULL, 60, NULL, TRUE,
    'water or glycerin', 'Mucilage and saponins extract in water or glycerin; avoid high alcohol which precipitates mucilage.');

  -- Zea mays (corn silk)
  PERFORM herbal.ensure_constituent('maysin',       'flavone C-glycoside', 'Found in corn silk; anti-inflammatory');
  PERFORM herbal.ensure_constituent('stigmasterol', 'phytosterol');
  PERFORM herbal.link_constituent('Zea mays', 'maysin',       'primary', 10);
  PERFORM herbal.link_constituent('Zea mays', 'potassium',    'major',   20, 'Contributes to diuretic effect');
  PERFORM herbal.link_constituent('Zea mays', 'saponins',     'moderate',30);
  PERFORM herbal.link_constituent('Zea mays', 'tannins',      'moderate',40);
  PERFORM herbal.link_constituent('Zea mays', 'caffeic acid', 'moderate',50);
  PERFORM herbal.link_constituent('Zea mays', 'stigmasterol', 'minor',   60);
  PERFORM herbal.set_menstruum('Zea mays', 25, 60, NULL, NULL, TRUE,
    '25–60% alcohol or water', 'Flavone glycosides and minerals extract in water or low-moderate alcohol; tea is traditional.');

  RAISE NOTICE 'Additional herbs done';
END $$;

