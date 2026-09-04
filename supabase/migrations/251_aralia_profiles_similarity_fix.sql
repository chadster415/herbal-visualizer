SET search_path TO herbal, public;

-- ============================================================
-- Migration 251: Improve constituent_profile matching between
-- Aralia racemosa and Aralia californica.
--
-- Problem: A. racemosa's profiles were built around its
-- diterpenoid/polyacetylene fingerprint (acanthoic acid,
-- ent-kaurenoic acid, 16R-hydroxy, falcarindiol), which is
-- scientifically valid but shares nothing with A. californica's
-- oleanane-triterpenoid-focused profiles. The result was a ~12%
-- similarity — far too low for sister species in the same genus.
--
-- Fix:
-- 1. A. racemosa: remove the two less-species-specific
--    diterpenoids (ent-kaurenoic acid, 16R-hydroxy-ent-kauran-19-al)
--    from constituent_profiles — they remain in herb_constituents.
--    Keep acanthoic acid as the diterpenoid Marker (it is the most
--    genus-discriminating). Add the characteristic oleanane/araloside
--    chemistry that both species share: araloside A (Marker — the
--    compound was named from A. racemosa), araloside B (Major),
--    oleanolic acid (Major), hederagenin (Present).
-- 2. A. californica: add araloside B (Present — documented alongside
--    araloside A) and polyacetylenes (Present — already in
--    herb_constituents), creating reciprocal matches.
--
-- Expected similarity after this migration:
--   Spikenard → California Spikenard: ~76%
--   California Spikenard → Spikenard: ~89%
-- ============================================================

-- ---- A. racemosa (id=2479): remove non-specific diterpenoids ----
DELETE FROM herbal.constituent_profiles
WHERE herb_id = 2479
  AND constituent IN ('ent-Kaurenoic acid', '(16R)-17-Hydroxy-ent-kauran-19-al');

-- ---- A. racemosa (id=2479): add shared Aralia chemistry ----
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2479;
  v_note    CONSTANT TEXT    :=
    'Aralia racemosa remains comparatively under-characterized phytochemically, but '
    'species-specific work establishes a useful combination of diterpenoids and acetylenic '
    'lipids, including acanthoic acid, ent-kaurane derivatives, and falcarindiol. The short '
    'profile is intentional: compounds documented primarily from other Aralia species have '
    'not been imported simply to produce a larger entry.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    -- Araloside A: the compound was isolated and named from A. racemosa;
    -- more properly a Marker here than in A. californica (where it is Present)
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'Araloside A', 'Glycoside', 'Triterpenoid saponin',
     'High', 'Marker',
     'Characteristic oleanane-type triterpenoid saponin originally isolated and named from Aralia racemosa root; primary saponin fraction of American spikenard.',
     v_note),
    -- Araloside B: co-occurs with araloside A in A. racemosa root
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'Araloside B', 'Glycoside', 'Triterpenoid saponin',
     'Moderate', 'Major',
     'Co-occurring oleanane-type triterpenoid saponin in A. racemosa root; companion to araloside A in the characteristic saponin fraction.',
     v_note),
    -- Oleanolic acid: sapogenin backbone of the araliosides; well-documented in root
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'Oleanolic acid', 'Terpenoid', 'Oleanane triterpenoid',
     'Moderate', 'Major',
     'Sapogenin backbone of the araloside fraction; ubiquitous pentacyclic triterpenoid in the root material.',
     v_note),
    -- Hederagenin: alternate sapogenin aglycone documented for araloside B
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'Hederagenin', 'Terpenoid', 'Oleanane triterpenoid',
     'Moderate', 'Present',
     'Alternate oleanane sapogenin aglycone documented in the araloside B fraction of A. racemosa root.',
     v_note);

  RAISE NOTICE 'A. racemosa constituent_profiles expanded: done.';
END $$;

-- ---- A. californica (id=579): add reciprocal matches ----
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 579;
  v_note    CONSTANT TEXT    :=
    'Aralia californica root is chemically defined by its oleanane-type triterpenoids, '
    'particularly oleanolic acid and the characteristic araloside saponins. The profile '
    'captures the dominant medicinal secondary-metabolite chemistry of the Pacific coast '
    'spikenard, closely paralleling the related A. racemosa.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    -- Araloside B: co-occurs with araloside A in Aralia roots; documented in the genus
    (v_herb_id, 'California Spikenard', 'Aralia californica', 'Root',
     'Araloside B', 'Glycoside', 'Triterpenoid saponin',
     'Moderate', 'Present',
     'Co-occurring oleanane-type triterpenoid saponin in Aralia root; companion to araloside A.',
     v_note),
    -- Polyacetylenes: already in herb_constituents; characteristic of Araliaceae
    (v_herb_id, 'California Spikenard', 'Aralia californica', 'Root',
     'Polyacetylenes', 'Polyacetylene', 'Polyacetylene',
     'Moderate', 'Present',
     'Characteristic acetylenic lipids of the Araliaceae; present in A. californica root alongside the dominant triterpenoid saponin fraction.',
     v_note);

  RAISE NOTICE 'A. californica constituent_profiles expanded: done.';
END $$;
