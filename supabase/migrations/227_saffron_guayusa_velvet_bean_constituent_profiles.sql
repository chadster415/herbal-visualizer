-- Migration 227: constituent_profiles for Saffron, Guayusa, and Velvet Bean
-- herb_constituents (general) were added in migration 226.
-- This migration adds the user-authoritative constituent_profiles rows.

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- Saffron (Crocus sativus) — stigma
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Crocus sativus');
  v_ed      CONSTANT TEXT    := 'Crocus sativus stigma is exceptionally well defined by its apocarotenoids and monoterpenoid derivatives: crocins provide the characteristic color, picrocrocin the bitterness, and safranal the aroma. These same compounds account for much of saffron''s antioxidant and neuroactive reputation, making the four-compound profile substantially more informative than adding less diagnostic flavonoids.';
BEGIN
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Crocus sativus not found — skipping'; RETURN; END IF;

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Saffron', 'Crocus sativus', 'Stigma', 'Crocin',      'Terpenoid', 'Apocarotenoid glycoside', 'High', 'Marker', 'Principal water-soluble pigment contributing antidepressant, neuroprotective, and antioxidant activity.',                        v_ed),
    (v_herb_id, 'Saffron', 'Crocus sativus', 'Stigma', 'Crocetin',    'Terpenoid', 'Apocarotenoid',           'High', 'Major',  'Carotenoid-derived aglycone underlying the crocin family and contributing antioxidant and neuroprotective activity.',            v_ed),
    (v_herb_id, 'Saffron', 'Crocus sativus', 'Stigma', 'Picrocrocin', 'Glycoside', 'Monoterpene glycoside',   'High', 'Marker', 'Characteristic bitter principle and precursor involved in formation of saffron''s aroma constituent safranal.',                   v_ed),
    (v_herb_id, 'Saffron', 'Crocus sativus', 'Stigma', 'Safranal',    'Terpenoid', 'Monoterpenoid aldehyde',  'High', 'Marker', 'Principal aroma constituent contributing antidepressant, neuroactive, antioxidant, and characteristic sensory effects.',          v_ed)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Saffron constituent_profiles: done.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Guayusa (Ilex guayusa) — leaf
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Ilex guayusa');
  v_ed      CONSTANT TEXT    := 'Ilex guayusa combines an unusually caffeine-rich methylxanthine fraction with abundant mono- and dicaffeoylquinic acids, accounting respectively for its traditional stimulant use and substantial antioxidant activity. The profile intentionally emphasizes these two well-characterized fractions rather than lower-level flavonoids, providing a useful chemical basis for comparison with yerba mate, yaupon, coffee, and other caffeinated herbs.';
BEGIN
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Ilex guayusa not found — skipping'; RETURN; END IF;

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Guayusa', 'Ilex guayusa', 'Leaf', 'Caffeine',                  'Alkaloid',   'Purine alkaloid',     'High',     'Marker', 'Dominant methylxanthine responsible for the pronounced CNS-stimulant and ergogenic activity.',             v_ed),
    (v_herb_id, 'Guayusa', 'Ilex guayusa', 'Leaf', '5-O-Caffeoylquinic acid',   'Polyphenol', 'Caffeoylquinic acid', 'High',     'Major',  'Principal chlorogenic acid contributing substantially to the leaf''s antioxidant activity.',               v_ed),
    (v_herb_id, 'Guayusa', 'Ilex guayusa', 'Leaf', '3,5-Dicaffeoylquinic acid', 'Polyphenol', 'Caffeoylquinic acid', 'High',     'Major',  'Abundant dicaffeoylquinic acid complementing the major phenolic fraction.',                                v_ed),
    (v_herb_id, 'Guayusa', 'Ilex guayusa', 'Leaf', '3-O-Caffeoylquinic acid',   'Polyphenol', 'Caffeoylquinic acid', 'Moderate', 'Major',  'Major caffeoylquinic acid contributing to the characteristic antioxidant phenolic profile.',               v_ed),
    (v_herb_id, 'Guayusa', 'Ilex guayusa', 'Leaf', 'Theobromine',               'Alkaloid',   'Purine alkaloid',     'Moderate', 'Major',  'Secondary methylxanthine complementing caffeine within the stimulant alkaloid fraction.',                  v_ed)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Guayusa constituent_profiles: done.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- Velvet Bean (Mucuna pruriens) — seed
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Mucuna pruriens');
  v_ed      CONSTANT TEXT    := 'Mucuna pruriens seed is pharmacologically dominated by L-DOPA, whose unusually high natural concentration accounts for the herb''s dopaminergic and antiparkinsonian reputation. Several minor alkaloids are retained to represent its broader nitrogenous chemistry, but their lower importance ratings deliberately reflect the enormous disparity between these compounds and the defining L-DOPA fraction.';
BEGIN
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Mucuna pruriens not found — skipping'; RETURN; END IF;

  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Mucuna (Velvet Bean)', 'Mucuna pruriens', 'Seed', 'L-DOPA',       'Nitrogenous compound', 'Amino acid derivative', 'High',         'Marker',  'Dominant bioactive constituent and dopamine precursor responsible for the seed''s characteristic dopaminergic and antiparkinsonian activity.', v_ed),
    (v_herb_id, 'Mucuna (Velvet Bean)', 'Mucuna pruriens', 'Seed', 'Mucunine',     'Alkaloid',             'Alkaloid',              'Low–Moderate', 'Present', 'Mucuna-associated minor alkaloid accompanying the overwhelmingly dominant L-DOPA fraction.',                                                   v_ed),
    (v_herb_id, 'Mucuna (Velvet Bean)', 'Mucuna pruriens', 'Seed', 'Mucunadine',   'Alkaloid',             'Alkaloid',              'Low–Moderate', 'Present', 'Characteristic minor seed alkaloid contributing to the broader nitrogenous chemistry.',                                                       v_ed),
    (v_herb_id, 'Mucuna (Velvet Bean)', 'Mucuna pruriens', 'Seed', 'Prurienine',   'Alkaloid',             'Alkaloid',              'Low–Moderate', 'Present', 'Minor alkaloid reported from M. pruriens seeds.',                                                                                              v_ed),
    (v_herb_id, 'Mucuna (Velvet Bean)', 'Mucuna pruriens', 'Seed', 'Prurieninine', 'Alkaloid',             'Alkaloid',              'Low–Moderate', 'Present', 'Minor species-associated alkaloid complementing the seed alkaloid fraction.',                                                                  v_ed)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Velvet Bean constituent_profiles: done.';
END $$;
