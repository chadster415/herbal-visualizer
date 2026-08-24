SET search_path TO herbal, public;

-- ============================================================
-- Bitter Melon (Momordica charantia) — herb data enrichment
-- Added fresh by migration 208 (id = 2556); this migration adds
-- constituent profiles, general constituents, inferred energetics,
-- contraindications, and menstruum.
-- MM Materia Medica: confirmed absent
-- Stockley's Drug Interactions: confirmed absent
-- ============================================================

-- Block 1 — Constituent profiles (constituent_profiles table)
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Momordica charantia');
BEGIN
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Momordica charantia not found — skipping'; RETURN; END IF;

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes)
  VALUES
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'charantin',      'Saponin',    'Steroidal saponin',             'High',         'Marker',  'Mixture of sitosterol and stigmasterol glucosides; primary hypoglycemic compound; lowers blood glucose by increasing uptake in muscle and liver'),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'polypeptide-p',  'Protein',    'Insulin-like polypeptide',       'High',         'Marker',  'Plant insulin analog unique to Momordica spp.; acts via insulin receptors to lower blood glucose; water-soluble, denatured by ethanol'),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'momordicin',     'Terpenoid',  'Cucurbitane-type triterpenoid',  'High',         'Major',   'Primary bitter principle of the fruit; anti-inflammatory and antitumor activity'),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'vicine',         'Alkaloid',   'Pyrimidine glycoside',           'Moderate',     'Major',   'Hypoglycemic activity; can cause hemolytic anemia in individuals with G6PD deficiency'),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'quercetin',      'Flavonoid',  'Flavonol',                       'Moderate',     'Present', NULL),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'kaempferol',     'Flavonoid',  'Flavonol',                       'Low-Moderate', 'Present', NULL),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'luteolin',       'Flavonoid',  'Flavone',                        'Low-Moderate', 'Present', NULL),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'beta-sitosterol','Sterol',     'Phytosterol',                    'Moderate',     'Present', NULL),
    (v_herb_id, 'Bitter Melon', 'Momordica charantia', 'fruit', 'linoleic acid',  'Fatty acid', 'Omega-6 fatty acid',             'Moderate',     'Present', 'Found in seed oil; also present in fruit')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 1 done — constituent_profiles';
END $$;

-- Block 2 — General constituents (herb_constituents)
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Momordica charantia');
  v_c INTEGER;
BEGIN
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Momordica charantia not found — skipping'; RETURN; END IF;

  -- New: charantin — steroidal saponin; key hypoglycemic marker
  v_c := herbal.ensure_constituent(
    'charantin',
    'steroidal saponin',
    'Steroidal saponin mixture (sitosterol + stigmasterol glucosides) that lowers blood glucose by stimulating uptake in muscle and liver; primary hypoglycemic marker of Bitter Melon.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Marker compound. Defining hypoglycemic constituent; found in fruit, leaves, and seeds.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- New: polypeptide-p — plant insulin analog
  v_c := herbal.ensure_constituent(
    'polypeptide-p',
    'insulin-like polypeptide',
    'Plant insulin-like protein unique to Momordica species; acts at insulin receptors to lower blood glucose; requires aqueous extraction and is denatured by ethanol.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Marker compound. Water-soluble only — not extracted in alcohol tinctures; present in fresh juice and decoctions.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- New: momordicin — cucurbitane triterpenoid / bitter principle
  v_c := herbal.ensure_constituent(
    'momordicin',
    'cucurbitane triterpenoid',
    'Cucurbitane-type triterpenoid responsible for the intense bitterness of Bitter Melon fruit; exhibits anti-inflammatory and antitumor activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Primary bitter principle; extracts in moderate alcohol (40–60%).', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- New: vicine — pyrimidine glycoside
  v_c := herbal.ensure_constituent(
    'vicine',
    'pyrimidine glycoside',
    'Pyrimidine glycoside with hypoglycemic activity; can cause hemolytic anemia in individuals with G6PD deficiency by generating oxidative stress in red blood cells.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Contraindicated in G6PD deficiency.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Existing: quercetin
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Existing: kaempferol
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Existing: luteolin
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Existing: beta-sitosterol
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Existing: linoleic acid
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'linoleic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'concentrated in seed oil', 90)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Block 2 done — herb_constituents';
END $$;

-- Block 3 — Inferred energetics
-- Temperature: no rule fires (cucurbitane triterpenoids not in rule set;
--   flavonols at moderate only, not major/primary — rule requires dominant flavonols).
--   Leave temperature unset.
-- Moisture: moistening (moderate confidence) — steroidal saponin (charantin) at major
--   with no volatile terpenoids fires the saponin → moistening rule;
--   phytosterol (beta-sitosterol) at moderate with no volatile terpenoids corroborates.
-- Taste: no rule fires — primary bitter principle (cucurbitane triterpenoids) is not
--   in the rule set; vicine does not reach major threshold. Leave taste unset.
DO $$
BEGIN
  UPDATE herbal.herbs
  SET moisture          = 'moistening',
      moisture_inferred = true
  WHERE latin_name = 'Momordica charantia';

  RAISE NOTICE 'Block 3 done — inferred energetics (moisture only)';
END $$;

-- Block 4 — Contraindications
DO $$
BEGIN
  UPDATE herbal.herbs
  SET contraindications        = 'Contraindicated in pregnancy — traditionally used as an abortifacient; may stimulate uterine contractions. Avoid in G6PD deficiency — the constituent vicine can cause hemolytic anemia (favism-like reaction). May potentiate hypoglycemic medications; monitor blood glucose carefully when combining with insulin or oral hypoglycemics. Seeds reported to cause severe hypoglycemia in young children; avoid in pediatric use. Insufficient safety data for breastfeeding — caution advised.',
      contraindications_source = 'general herbal literature'
  WHERE latin_name = 'Momordica charantia';

  RAISE NOTICE 'Block 4 done — contraindications';
END $$;

-- Block 5 — Menstruum
-- Conflicting extraction signals: polypeptide-p (water-soluble; denatured by ethanol)
-- vs. momordicin/cucurbitane triterpenoids (60–75% alcohol) vs. steroidal saponins
-- (40–60% + vinegar). Practical compromise: 40–60% tincture captures saponins and
-- triterpenoids; polypeptide-p fraction requires fresh juice or aqueous decoction.
-- needs_review = true (conflicting signals between peptide and lipophilic constituents).
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Momordica charantia',
    40::INTEGER,
    60::INTEGER,
    NULL::INTEGER,
    5::INTEGER,
    true,
    '40–60% alcohol + 5% vinegar, or fresh juice',
    'Steroidal saponins (charantin) and cucurbitane triterpenoids (momordicin) extract in moderate alcohol; 5% vinegar improves steroidal saponin solubility. Polypeptide-p (plant insulin analog) is water-soluble and denatured by ethanol — only present in fresh juice or cold water extraction. Traditional use favors fresh juice or bitter tea. For tinctures, hypoglycemic activity is primarily from charantin and vicine fractions.',
    true,   -- needs_review
    false,  -- powder_effective
    false   -- oil_effective
  );

  RAISE NOTICE 'Block 5 done — menstruum';
END $$;
