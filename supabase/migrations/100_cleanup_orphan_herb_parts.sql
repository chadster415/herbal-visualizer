-- Migration 100: Clean up 3 orphan herb entries that have no plant_part set
-- and were created before the plant_part system (migrations 087-091).
--
-- Orphans and their disposition:
--   1792 (Taraxacum officinale, NULL part, neutral energetics) — zero uses → DELETE
--   1793 (Urtica dioica, NULL part, neutral energetics) — used in Musculoskeletal
--          prescriptions (Myalgia, Osteoporosis) and specific remedy (Osteoarthritis)
--          as a rubefacient/urtication herb → re-point to Nettles leaf (id 43), then DELETE
--   1863 (Verbascum thapsus, NULL part, neutral energetics) — used in Musculoskeletal
--          prescriptions (Cayenne Poultice, Mullein Liniment) → re-point to Mullein leaf
--          (id 61), then DELETE

SET search_path TO herbal, public;

DO $$
DECLARE
  v_nettle_leaf_id  INTEGER := 43;   -- Urtica dioica leaf
  v_mullein_leaf_id INTEGER := 61;   -- Verbascum thapsus leaf
BEGIN

  -- ── Urtica dioica 1793 ───────────────────────────────────────────────────────

  -- Re-point prescription_herbs to Nettles leaf
  UPDATE herbal.prescription_herbs
  SET herb_id = v_nettle_leaf_id
  WHERE herb_id = 1793;

  RAISE NOTICE 'Re-pointed prescription_herbs 1793 → %', v_nettle_leaf_id;

  -- Re-point disorder_specific_remedies to Nettles leaf
  -- Use INSERT+DELETE pattern to handle the (disorder_id, herb_id) unique constraint
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  SELECT disorder_id, v_nettle_leaf_id, description, sort_order
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = 1793
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.disorder_specific_remedies WHERE herb_id = 1793;

  RAISE NOTICE 'Re-pointed disorder_specific_remedies 1793 → %', v_nettle_leaf_id;

  -- ── Verbascum thapsus 1863 ───────────────────────────────────────────────────

  -- Re-point prescription_herbs to Mullein leaf
  UPDATE herbal.prescription_herbs
  SET herb_id = v_mullein_leaf_id
  WHERE herb_id = 1863;

  RAISE NOTICE 'Re-pointed prescription_herbs 1863 → %', v_mullein_leaf_id;

  -- ── Delete all three orphans ─────────────────────────────────────────────────

  DELETE FROM herbal.herbs WHERE id IN (1792, 1793, 1863);

  RAISE NOTICE 'Deleted orphan herbs 1792, 1793, 1863';
  RAISE NOTICE 'Done.';

END $$;
