SET search_path TO herbal, public;

-- General Constituents (herb_constituents) for the 11 non-TCM herbs.
-- These are the supporting chemistry beyond the specific markers already
-- in constituent_profiles (migration 155). Run after migration 156 which
-- removed the incorrect data from migration 154.
--
-- New constituents created here:
--   oxalic acid (organic acid)       — Spinach
--   phylloquinone (quinone)          — Spinach
--   sinapic acid (hydroxycinnamic acid) — Black & White Mustard
--   erucic acid (fatty acid)         — Black & White Mustard
--   tocopherol (tocopherol)          — Oat colloidal
--
-- Pre-existing constituents re-used by ID:
--   oleanolic acid (855), ursolic acid (854), beta-sitosterol (857),
--   quercetin (741), kaempferol (746), luteolin (739), caffeic acid (784),
--   gallic acid (789), mucilage (994), silica (996), GABA (968),
--   lutein (992), zeaxanthin (993), beta-carotene (991), iron (998)

-- ============================================================
-- Asian Devil's Club — Oplopanax elatus, root bark — id 2226
-- Triterpenoid saponins accompany the polyacetylene markers in the root.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2226;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'oleanolic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Triterpenoid saponin aglycone present in Oplopanax root alongside the polyacetylenes.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'ursolic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Pentacyclic triterpenoid contributing to the root''s anti-inflammatory activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Phytosterol present in Oplopanax root bark.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Asian Devil''s Club (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Black Mustard — Brassica nigra, seed — id 1860
-- Fixed oil and characteristic phenolics accompany sinigrin.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1860;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('sinapic acid', 'hydroxycinnamic acid',
    'Characteristic hydroxycinnamic acid of Brassica species; antioxidant and anti-inflammatory');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Characteristic Brassica phenolic; present in seed as sinapine ester.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('erucic acid', 'fatty acid',
    'Long-chain monounsaturated fatty acid (C22:1) dominant in Brassica seed oils');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Dominant fatty acid in the seed fixed oil.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavonol present in Brassica seed coat.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Phytosterol in the seed fixed oil fraction.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Black Mustard (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Cashew — Anacardium occidentale, nut shell — id 2341
-- Tannins and flavonoids accompany the dominant phenolic lipids.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2341;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'gallic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Hydroxybenzoic acid present as part of the tannin fraction in cashew shell.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavonol contributing to the antioxidant profile of the shell.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Phytosterol present alongside the phenolic lipids.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Cashew (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Chinese Skullcap — Scutellaria baicalensis, root — id 2274
-- Sterols and phenolic acids complement the dominant flavone profile.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2274;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Hydroxycinnamic acid present in the root alongside the dominant flavones.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Phytosterol present in the root.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Chinese Skullcap (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Comfrey leaf — Symphytum officinale, leaf — id 1650
-- Mucilaginous polysaccharides are a major functional fraction of the leaf.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1650;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'mucilage';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Major functional constituent; mucilaginous polysaccharides underlie the leaf''s soothing and demulcent properties.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Phenolic acid contributing to anti-inflammatory activity alongside rosmarinic acid.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'silica';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Silica present in leaf tissue; contributes to connective-tissue support action.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Comfrey leaf (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Mulberry Leaf — Morus alba — id 2338
-- GABA, flavones, and phytosterols complement the DNJ and flavonol markers.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2338;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'GABA';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Gamma-aminobutyric acid present in notably high concentrations in mulberry leaf.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavone contributing anti-inflammatory activity alongside the flavonol glycosides.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavonol aglycone base of the isoquercitrin and rutin present in the leaf.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Phytosterol present in mulberry leaf.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Mulberry Leaf (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Oat colloidal — Avena sativa, grain — id 2288
-- Tocopherols and caffeic acid derivatives support the avenanthramide markers.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2288;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('tocopherol', 'tocopherol',
    'Vitamin E-active lipid-soluble antioxidant; present in oat grain as alpha- and gamma-tocopherol');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Lipid-soluble antioxidant contributing to shelf stability and antioxidant activity of colloidal oatmeal.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Hydroxycinnamic acid present in oat grain alongside the avenanthramides.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'silica';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Silica present in oat grain; contributes to the physical texture of colloidal oatmeal preparations.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Oat colloidal (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Peyote — Lophophora williamsii, aerial stem — id 2350
-- Alkaloid profile is comprehensive in constituent_profiles; only sterols added here.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2350;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Phytosterol present in the cactus tissue alongside the dominant alkaloid fraction.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Peyote (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Ragwort — Senecio jacobaea — id 1855
-- Flavonoids accompany the dominant PA profile in the aerial parts.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1855;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavonol present in ragwort aerial parts alongside the dominant PA fraction.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavone present in ragwort aerial parts.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Flavonol present in ragwort aerial parts.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Phytosterol present in the aerial parts.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Ragwort (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Spinach — Spinacia oleracea, leaf — id 2352
-- Clinically important carotenoids, vitamin K1, iron, and oxalic acid.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2352;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'lutein';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Dominant carotenoid in spinach leaf; major contributor to macular pigment and eye health.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'zeaxanthin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Carotenoid co-occurring with lutein; contributes to macular protection.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-carotene';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Major provitamin A carotenoid in spinach leaf.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('phylloquinone', 'quinone',
    'Vitamin K1; fat-soluble naphthoquinone essential for coagulation and bone metabolism; abundant in green leafy vegetables');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Vitamin K1; spinach is one of the richest dietary sources — clinically significant for patients on anticoagulants.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'iron';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Non-haem iron in substantial quantity; bioavailability reduced by co-occurring oxalic acid.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('oxalic acid', 'organic acid',
    'Dicarboxylic acid that forms insoluble calcium oxalate salts; abundant in spinach and other Oxalidaceae relatives; limits mineral bioavailability');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Major safety consideration; binds calcium and iron reducing their bioavailability; contraindicated in high-oxalate kidney stones.', 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Spinach (id %) general constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- White Mustard — Sinapis alba (DB: Brassica alba), seed — id 1861
-- Same fixed oil and phenolic profile as black mustard, different glucosinolate.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1861;
  v_c INTEGER;
BEGIN
  -- sinapic acid created above (if run in same session, ensure_constituent is idempotent)
  v_c := herbal.ensure_constituent('sinapic acid', 'hydroxycinnamic acid',
    'Characteristic hydroxycinnamic acid of Brassica species; antioxidant and anti-inflammatory');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Characteristic Brassica phenolic; present in seed as sinapine ester.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('erucic acid', 'fatty acid',
    'Long-chain monounsaturated fatty acid (C22:1) dominant in Brassica seed oils');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Dominant fatty acid in the seed fixed oil.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Phytosterol in the seed fixed oil fraction.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'White Mustard (id %) general constituents loaded', v_herb_id;
END $$;
