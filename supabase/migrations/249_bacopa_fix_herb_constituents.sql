SET search_path TO herbal, public;

-- ============================================================
-- Migration 249: Fix Bacopa herb_constituents
--
-- "Bacoside A" and "Bacoside B" were entered as single
-- constituents in migration 178. The authoritative phytochemical
-- literature establishes that bacoside A is a mixture of four
-- principal dammarane saponins (A3, bacopaside II, bacopaside X,
-- bacopasaponin C), each entered individually below.
-- Bacoside B is also a mixture and is omitted per the same logic.
-- Both are only referenced by Bacopa, so their constituents
-- dictionary entries are deleted after delinking.
-- ============================================================

DO $$
DECLARE
  v_herb_id  CONSTANT INTEGER := 2381;  -- Bacopa monnieri
  v_cat      CONSTANT TEXT    := 'dammarane triterpenoid saponins';
  v_old_a    INTEGER;
  v_old_b    INTEGER;
  v_c        INTEGER;
BEGIN
  -- 1. Remove the incorrect single-compound entries from herb_constituents
  SELECT constituent_id INTO v_old_a
  FROM herbal.herb_constituents hc
  JOIN herbal.constituents c ON c.id = hc.constituent_id
  WHERE hc.herb_id = v_herb_id AND c.name = 'bacoside A';

  SELECT constituent_id INTO v_old_b
  FROM herbal.herb_constituents hc
  JOIN herbal.constituents c ON c.id = hc.constituent_id
  WHERE hc.herb_id = v_herb_id AND c.name = 'bacoside B';

  DELETE FROM herbal.herb_constituents
  WHERE herb_id = v_herb_id
    AND constituent_id IN (v_old_a, v_old_b);

  -- 2. Remove the dictionary entries (only Bacopa used these)
  DELETE FROM herbal.constituents WHERE id IN (v_old_a, v_old_b);

  -- 3. Shift existing minor constituents to sort_order 50-90
  --    to make room for the new Marker/Major compounds at 0-40
  UPDATE herbal.herb_constituents
  SET sort_order = sort_order + 30
  WHERE herb_id = v_herb_id;

  -- 4. Add individual bacoside A components at concentration 'major'
  --    (four co-equal markers; none is singular enough for 'primary')
  v_c := herbal.ensure_constituent(
    'bacoside A3', v_cat,
    'Jujubogenin-type dammarane triterpenoid saponin; one of the four principal neuroactive saponins comprising the bacoside A complex of Bacopa monnieri.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Marker. One of four principal jujubogenin-type components of the bacoside A complex.', 0)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent(
    'bacopaside II', v_cat,
    'Pseudojujubogenin-type dammarane triterpenoid saponin and principal neuroactive component of the bacoside A complex.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Marker. Principal pseudojujubogenin-type component of the bacoside A complex.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent(
    'bacopaside X', v_cat,
    'Jujubogenin-type dammarane triterpenoid saponin; one of the four components conventionally grouped as bacoside A.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Marker. Jujubogenin-type saponin; one of the four principal bacoside A components.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent(
    'bacopasaponin C', v_cat,
    'Pseudojujubogenin-type dammarane triterpenoid saponin; one of the four principal components of the bacoside A complex.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Marker. Major pseudojujubogenin-type saponin; one of the four principal bacoside A components.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- 5. Add bacopaside I at 'moderate' (Major, Moderate importance)
  v_c := herbal.ensure_constituent(
    'bacopaside I', v_cat,
    'Sulfated pseudojujubogenin glycoside used in phytochemical characterization of Bacopa monnieri alongside the major bacoside A components.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Bacopa herb_constituents: replaced bacoside A/B with individual components.';
END $$;
