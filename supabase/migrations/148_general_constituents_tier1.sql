SET search_path TO herbal, public;

-- Migration 148: Link shared constituents to 17 herbs missing herb_constituents rows.
--
-- These herbs already exist in the `herbs` table and the constituent names used here
-- already exist in the `constituents` table (added in earlier migrations). This file
-- only calls herbal.link_constituent() — no ensure_constituent() calls are needed.
--
-- Source: constituent_profiles data cross-referenced against shared constituents already
-- present in the DB. Concentration levels follow the standard mapping used since
-- migration 103 (Marker/High → major, Major/Moderate → moderate, Present → minor,
-- Reported → trace).


-- ── Korean Mint / Huo Xiang (Agastache rugosa) ───────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Agastache rugosa', 'acacetin',        'major', 10);
  PERFORM herbal.link_constituent('Agastache rugosa', 'rosmarinic acid', 'major', 20);
  PERFORM herbal.link_constituent('Agastache rugosa', 'pulegone',        'trace', 30);

  RAISE NOTICE 'Korean Mint (Agastache rugosa) constituents linked.';
END $$;


-- ── Lemon Verbena (Aloysia citrodora) ────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Aloysia citrodora', 'apigenin',        'minor',    10);
  PERFORM herbal.link_constituent('Aloysia citrodora', 'limonene',        'moderate', 20);
  PERFORM herbal.link_constituent('Aloysia citrodora', 'rosmarinic acid', 'minor',    30);

  RAISE NOTICE 'Lemon Verbena (Aloysia citrodora) constituents linked.';
END $$;


-- ── Gotu Kola (Centella asiatica) ────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Centella asiatica', 'kaempferol', 'minor', 10);
  PERFORM herbal.link_constituent('Centella asiatica', 'quercetin',  'minor', 20);

  RAISE NOTICE 'Gotu Kola (Centella asiatica) constituents linked.';
END $$;


-- ── Pipsissewa (Chimaphila umbellata) ────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Chimaphila umbellata', 'arbutin',      'major',    10);
  PERFORM herbal.link_constituent('Chimaphila umbellata', 'hyperoside',   'moderate', 20);
  PERFORM herbal.link_constituent('Chimaphila umbellata', 'ursolic acid', 'moderate', 30);

  RAISE NOTICE 'Pipsissewa (Chimaphila umbellata) constituents linked.';
END $$;


-- ── Chicory (Cichorium intybus) ──────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Cichorium intybus', 'inulin',           'major',    10);
  PERFORM herbal.link_constituent('Cichorium intybus', 'lactucin',         'major',    20);
  PERFORM herbal.link_constituent('Cichorium intybus', 'lactucopicrin',    'major',    30);
  PERFORM herbal.link_constituent('Cichorium intybus', 'chlorogenic acid', 'moderate', 40);
  PERFORM herbal.link_constituent('Cichorium intybus', 'cichoric acid',    'moderate', 50);

  RAISE NOTICE 'Chicory (Cichorium intybus) constituents linked.';
END $$;


-- ── Zedoary (Curcuma zedoaria) ───────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Curcuma zedoaria', 'curcumin', 'minor', 10);

  RAISE NOTICE 'Zedoary (Curcuma zedoaria) constituents linked.';
END $$;


-- ── Gumweed (Grindelia squarrosa) ────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Grindelia squarrosa', 'quercetin', 'moderate', 10);
  PERFORM herbal.link_constituent('Grindelia squarrosa', 'luteolin',  'moderate', 20);

  RAISE NOTICE 'Gumweed (Grindelia squarrosa) constituents linked.';
END $$;


-- ── Gymnema (Gymnema sylvestre) ──────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Gymnema sylvestre', 'quercetin', 'minor', 10);

  RAISE NOTICE 'Gymnema (Gymnema sylvestre) constituents linked.';
END $$;


-- ── Hibiscus / Roselle (Hibiscus sabdariffa) ─────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Hibiscus sabdariffa', 'cyanidin-3-sambubioside', 'major',    10);
  PERFORM herbal.link_constituent('Hibiscus sabdariffa', 'chlorogenic acid',        'moderate', 20);
  PERFORM herbal.link_constituent('Hibiscus sabdariffa', 'quercetin',               'minor',    30);

  RAISE NOTICE 'Hibiscus (Hibiscus sabdariffa) constituents linked.';
END $$;


-- ── Kelp (Laminaria digitata) ────────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Laminaria digitata', 'alginic acid', 'major', 10);

  RAISE NOTICE 'Kelp (Laminaria digitata) constituents linked.';
END $$;


-- ── Lovage (Levisticum officinale) ───────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Levisticum officinale', 'butylidenephthalide', 'major',    10);
  PERFORM herbal.link_constituent('Levisticum officinale', 'sedanolide',          'moderate', 20);

  RAISE NOTICE 'Lovage (Levisticum officinale) constituents linked.';
END $$;


-- ── Japanese Honeysuckle (Lonicera japonica) ─────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Lonicera japonica', 'chlorogenic acid', 'major',    10);
  PERFORM herbal.link_constituent('Lonicera japonica', 'loganin',          'moderate', 20);

  RAISE NOTICE 'Japanese Honeysuckle (Lonicera japonica) constituents linked.';
END $$;


-- ── Psyllium (Plantago ovata) ────────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Plantago ovata', 'aucubin', 'minor', 10);

  RAISE NOTICE 'Psyllium (Plantago ovata) constituents linked.';
END $$;


-- ── White Oak (Quercus alba) ─────────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Quercus alba', 'ellagic acid', 'moderate', 10);
  PERFORM herbal.link_constituent('Quercus alba', 'catechin',     'minor',    20);

  RAISE NOTICE 'White Oak (Quercus alba) constituents linked.';
END $$;


-- ── Sugar Kelp (Saccharina latissima) ────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Saccharina latissima', 'alginic acid', 'major', 10);

  RAISE NOTICE 'Sugar Kelp (Saccharina latissima) constituents linked.';
END $$;


-- ── Thyme (Thymus spp.) ──────────────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Thymus spp.', 'thymol',        'major',    10);
  PERFORM herbal.link_constituent('Thymus spp.', 'carvacrol',     'major',    20);
  PERFORM herbal.link_constituent('Thymus spp.', 'linalool',      'moderate', 30);
  PERFORM herbal.link_constituent('Thymus spp.', 'rosmarinic acid', 'moderate', 40);
  PERFORM herbal.link_constituent('Thymus spp.', 'luteolin',      'minor',    50);

  RAISE NOTICE 'Thyme (Thymus spp.) constituents linked.';
END $$;


-- ── Grape (Vitis vinifera) ───────────────────────────────────────────────────

DO $$
BEGIN
  PERFORM herbal.link_constituent('Vitis vinifera', 'catechin',    'moderate', 10);
  PERFORM herbal.link_constituent('Vitis vinifera', 'epicatechin', 'moderate', 20);
  PERFORM herbal.link_constituent('Vitis vinifera', 'gallic acid', 'moderate', 30);

  RAISE NOTICE 'Grape (Vitis vinifera) constituents linked.';
END $$;
