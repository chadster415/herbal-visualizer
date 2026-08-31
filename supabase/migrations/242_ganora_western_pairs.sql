-- Migration 242: herb_pairs — unified Western herb pairs table with source attribution
--
-- Replaces herbal.priest_pairings (which was Priest & Priest only, no source field).
-- New tables mirror the dui_yao_pairs structure so the same UI components render both.
--
-- Sources loaded in this migration:
--   • Lisa Ganora & Kat Martello, "Ginger & Turmeric: a Classic Pair" (2026)
--   • Priest & Priest, Herbal Medication (1982) — migrated from priest_pairings
--
-- Pairs (herb1_id always = LEAST id, herb2_id always = GREATEST id):
--   Ginger (124) + Turmeric (203)    — Ganora 2026, main subject
--   Capsicum (47) + Lobelia (132)    — Ganora 2026, "One More Pair"
--   Skullcap (142) + Valerian (145)  — Ganora 2026, cited classic pair
--   Goldenseal (30) + Myrrh (99)     — Ganora 2026, cited classic pair
--   ~120 pairs                       — migrated from priest_pairings

SET search_path TO herbal, public;

-- ============================================================
-- SCHEMA
-- ============================================================
CREATE TABLE IF NOT EXISTS herbal.herb_pairs (
  id             SERIAL PRIMARY KEY,
  herb1_id       INTEGER NOT NULL REFERENCES herbal.herbs(id),
  herb2_id       INTEGER NOT NULL REFERENCES herbal.herbs(id),
  source         TEXT NOT NULL,
  combined_summary TEXT,
  created_at     TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE (herb1_id, herb2_id)
);
CREATE INDEX IF NOT EXISTS herb_pairs_herb1_idx ON herbal.herb_pairs(herb1_id);
CREATE INDEX IF NOT EXISTS herb_pairs_herb2_idx ON herbal.herb_pairs(herb2_id);

CREATE TABLE IF NOT EXISTS herbal.herb_pair_indications (
  id         SERIAL PRIMARY KEY,
  pair_id    INTEGER NOT NULL REFERENCES herbal.herb_pairs(id) ON DELETE CASCADE,
  indication TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS herbal.herb_pair_herb_properties (
  id         SERIAL PRIMARY KEY,
  pair_id    INTEGER NOT NULL REFERENCES herbal.herb_pairs(id) ON DELETE CASCADE,
  herb_id    INTEGER NOT NULL REFERENCES herbal.herbs(id),
  property   TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0
);

-- Grants & RLS
GRANT ALL ON TABLE herbal.herb_pairs TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.herb_pairs_id_seq TO postgres, anon, authenticated, service_role;
GRANT ALL ON TABLE herbal.herb_pair_indications TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.herb_pair_indications_id_seq TO postgres, anon, authenticated, service_role;
GRANT ALL ON TABLE herbal.herb_pair_herb_properties TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.herb_pair_herb_properties_id_seq TO postgres, anon, authenticated, service_role;

ALTER TABLE herbal.herb_pairs ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.herb_pair_indications ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.herb_pair_herb_properties ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_pairs' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.herb_pairs FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_pairs' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.herb_pairs FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_pair_indications' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.herb_pair_indications FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_pair_indications' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.herb_pair_indications FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_pair_herb_properties' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.herb_pair_herb_properties FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='herb_pair_herb_properties' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.herb_pair_herb_properties FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

-- ============================================================
-- PAIR 1: Ginger (124) + Turmeric (203)   [124 < 203 ✓]
-- Source: Ganora & Martello 2026
-- ============================================================
DO $$
DECLARE v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (124, 203,
    'Ganora & Martello, "Ginger & Turmeric: a Classic Pair" (2026)',
    'A complementary pair of botanically related warming rhizomes (Zingiberaceae). Both are anti-inflammatory, antioxidant, anticarcinogenic, and circulatory stimulants, reinforcing shared actions while contributing distinct strengths. Turmeric emphasizes hepatobiliary and inflammatory pathways; Ginger adds carminative, antiemetic, and circulatory stimulant actions. Ginger''s moistening energy balances Turmeric''s drying tendency, and Ginger acts as a driving/bioenhancing herb — improving absorption and systemic distribution of Turmeric''s curcuminoids by influencing GI function, membrane transporters, and drug-metabolizing enzymes. Together a multi-target pair for inflammatory patterns involving liver, digestion, circulation, and pain.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING
  RETURNING id INTO v_pair_id;

  IF v_pair_id IS NULL THEN
    SELECT id INTO v_pair_id FROM herbal.herb_pairs WHERE herb1_id = 124 AND herb2_id = 203;
    RAISE NOTICE 'Ginger+Turmeric pair already exists (id=%)', v_pair_id;
    RETURN;
  END IF;
  RAISE NOTICE 'Inserted Ginger+Turmeric pair (id=%)', v_pair_id;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order) VALUES
    (v_pair_id, 'Chronic inflammation presenting with pain, stiffness, poor circulation, or sluggish digestion', 10),
    (v_pair_id, 'Inflammatory patterns involving the liver, hepatobiliary system, and digestion', 20),
    (v_pair_id, 'Long-term inflammation-modulating formula core; add complementary herbs per pattern', 30),
    (v_pair_id, 'Fire cider and oxymel formulas for immune and circulatory support', 40);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order) VALUES
    (v_pair_id, 124, 'Warming, diffusive circulatory stimulant — promotes peripheral circulation and helps distribute the actions of the formula', 10),
    (v_pair_id, 124, 'Carminative and antiemetic; contributes digestive and anti-nausea actions to the pair', 20),
    (v_pair_id, 124, 'Key constituents: gingerols (fresh), shogaols (dried/cooked), paradols, zingerone, and aromatic sesquiterpenes (zingiberene, β-sesquiphellandrene)', 30),
    (v_pair_id, 124, 'Bioenhancer for Turmeric: gingerols and shogaols influence GI function, membrane transporters, and drug-metabolizing enzymes, improving absorption and systemic distribution of curcuminoids', 40),
    (v_pair_id, 124, 'Moistening energy that balances Turmeric''s more drying tendency', 50),
    (v_pair_id, 203, 'Broad anti-inflammatory and antioxidant activity; modulates NF-κB signaling, cytokines, eicosanoids, and oxidative stress responses', 10),
    (v_pair_id, 203, 'Hepatoprotective and hepatobiliary emphasis; bitter and detoxifying', 20),
    (v_pair_id, 203, 'Key constituents: curcuminoids (curcumin, demethoxycurcumin, bisdemethoxycurcumin) and aromatic sesquiterpenes (turmerones, zingiberene, β-sesquiphellandrene)', 30),
    (v_pair_id, 203, 'Curcuminoids have low water solubility and limited bioavailability — extraction in ~70% ethanol and pairing with Ginger improves therapeutic delivery', 40),
    (v_pair_id, 203, 'Immunomodulating polysaccharides (arabinogalactans) also present', 50);
END $$;

-- ============================================================
-- PAIR 2: Capsicum (47) + Lobelia (132)   [47 < 132 ✓]
-- Source: Ganora & Martello 2026
-- ============================================================
DO $$
DECLARE v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (47, 132,
    'Ganora & Martello, "Ginger & Turmeric: a Classic Pair" (2026)',
    'A balancing pair of contrasting actions from the North American Physio-Medical tradition. Lobelia is a potent relaxant, antispasmodic, and expectorant, especially where tension or spasm restricts respiration. Cayenne is warming, stimulating, and vasodilating, counterbalancing Lobelia''s relaxant qualities and maintaining circulatory vitality. Together they illustrate a balancing relationship — relaxation and stimulation, reducing smooth muscle tension without decreasing circulatory vitality. Cayenne also functions as a driving/diffusive herb, promoting peripheral circulation and quickly distributing the effects of the formula.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING
  RETURNING id INTO v_pair_id;

  IF v_pair_id IS NULL THEN
    SELECT id INTO v_pair_id FROM herbal.herb_pairs WHERE herb1_id = 47 AND herb2_id = 132;
    RAISE NOTICE 'Capsicum+Lobelia pair already exists (id=%)', v_pair_id;
    RETURN;
  END IF;
  RAISE NOTICE 'Inserted Capsicum+Lobelia pair (id=%)', v_pair_id;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order) VALUES
    (v_pair_id, 'Respiratory conditions where tension or spasm restricts breathing', 10),
    (v_pair_id, 'Conditions requiring simultaneous relaxation and stimulation without loss of circulatory vitality', 20);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order) VALUES
    (v_pair_id, 47, 'Warming, stimulating, and vasodilating; counterbalances Lobelia''s relaxant qualities', 10),
    (v_pair_id, 47, 'Driving/diffusive herb: promotes peripheral circulation and quickly distributes the effects of the formula', 20),
    (v_pair_id, 132, 'Relaxant, antispasmodic, and expectorant — especially indicated where tension or spasm restricts respiration', 10),
    (v_pair_id, 132, 'Strong relaxing influence; Cayenne counterbalances to prevent excessive relaxation and circulatory depression', 20);
END $$;

-- ============================================================
-- PAIR 3: Skullcap (142) + Valerian (145)   [142 < 145 ✓]
-- Source: Ganora & Martello 2026
-- ============================================================
DO $$
DECLARE v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (142, 145,
    'Ganora & Martello, "Ginger & Turmeric: a Classic Pair" (2026)',
    'A classic Physio-Medical pair still widely used in Western clinical herbalism. Skullcap and Valerian are each nervine antispasmodics used for tension, anxiety, and nervous excitability; their combination reinforces shared nervine and antispasmodic actions and has a long tradition in the North American and British Physio-Medical traditions.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING
  RETURNING id INTO v_pair_id;

  IF v_pair_id IS NULL THEN
    SELECT id INTO v_pair_id FROM herbal.herb_pairs WHERE herb1_id = 142 AND herb2_id = 145;
    RAISE NOTICE 'Skullcap+Valerian pair already exists (id=%)', v_pair_id;
    RETURN;
  END IF;
  RAISE NOTICE 'Inserted Skullcap+Valerian pair (id=%)', v_pair_id;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order) VALUES
    (v_pair_id, 'Nervous tension, anxiety, and nervous excitability with antispasmodic component', 10);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order) VALUES
    (v_pair_id, 142, 'Nervine trophorestorative and antispasmodic; restores and nourishes the nervous system', 10),
    (v_pair_id, 145, 'Nervine, anxiolytic, antispasmodic, and hypnotic; reduces nervous excitability', 10);
END $$;

-- ============================================================
-- PAIR 4: Goldenseal (30) + Myrrh (99)   [30 < 99 ✓]
-- Source: Ganora & Martello 2026
-- ============================================================
DO $$
DECLARE v_pair_id INTEGER;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (30, 99,
    'Ganora & Martello, "Ginger & Turmeric: a Classic Pair" (2026)',
    'A classic Physio-Medical pair used in the North American and British Physio-Medical traditions. Goldenseal is a potent antimicrobial and mucous membrane tonic with strong astringent and anti-inflammatory actions; Myrrh is an antiseptic, vulnerary, and anti-inflammatory resin. Together they act synergistically on infected or inflamed mucous membranes and wounds, combining Goldenseal''s berberine-rich antimicrobial tonic activity with Myrrh''s resinous antiseptic and healing properties.')
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING
  RETURNING id INTO v_pair_id;

  IF v_pair_id IS NULL THEN
    SELECT id INTO v_pair_id FROM herbal.herb_pairs WHERE herb1_id = 30 AND herb2_id = 99;
    RAISE NOTICE 'Goldenseal+Myrrh pair already exists (id=%)', v_pair_id;
    RETURN;
  END IF;
  RAISE NOTICE 'Inserted Goldenseal+Myrrh pair (id=%)', v_pair_id;

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order) VALUES
    (v_pair_id, 'Infections and inflammation of mucous membranes — mouth, throat, GI, respiratory', 10),
    (v_pair_id, 'Infected wounds, ulcers, and inflammatory conditions requiring antimicrobial support', 20);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order) VALUES
    (v_pair_id, 30, 'Antimicrobial (berberine-rich), mucous membrane tonic, and astringent; tones and normalizes inflamed mucosal tissue', 10),
    (v_pair_id, 99, 'Antiseptic, vulnerary, and anti-inflammatory resin; promotes healing of infected and ulcerated tissue', 10);
END $$;

-- ============================================================
-- MIGRATE PRIEST & PRIEST DATA
-- Source: Priest & Priest, Herbal Medication (1982), pp. 56-78
--
-- Strategy:
--   Each unique (LEAST, GREATEST) pair gets one herb_pairs row.
--   Each priest_pairings row (where partner_herb_id IS NOT NULL) becomes one
--   herb_pair_herb_properties row: the combination_context is stored as a
--   property attributed to the originating herb_id.
--   Rows with NULL partner_herb_id (herbs not in DB) are discarded.
-- ============================================================
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.tables
                 WHERE table_schema = 'herbal' AND table_name = 'priest_pairings') THEN
    RAISE NOTICE 'priest_pairings table not found — skipping migration (already done)';
    RETURN;
  END IF;

  -- Step 1: unique pairs
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source)
  SELECT DISTINCT
    LEAST(herb_id, partner_herb_id),
    GREATEST(herb_id, partner_herb_id),
    'Priest & Priest, Herbal Medication (1982)'
  FROM herbal.priest_pairings
  WHERE partner_herb_id IS NOT NULL
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  RAISE NOTICE 'Priest pairs inserted into herb_pairs';

  -- Step 2: per-herb properties from combination_context
  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT
    p.id,
    pp.herb_id,
    pp.combination_context,
    pp.sort_order * 10
  FROM herbal.priest_pairings pp
  JOIN herbal.herb_pairs p ON (
    p.herb1_id = LEAST(pp.herb_id, pp.partner_herb_id)
    AND p.herb2_id = GREATEST(pp.herb_id, pp.partner_herb_id)
  )
  WHERE pp.partner_herb_id IS NOT NULL
    AND pp.combination_context IS NOT NULL;

  RAISE NOTICE 'Priest herb properties inserted into herb_pair_herb_properties';

  -- Step 3: drop old table
  DROP TABLE herbal.priest_pairings;
  RAISE NOTICE 'priest_pairings dropped';
END $$;
