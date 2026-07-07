-- Migration 074: Herb data cleanup (continued)
-- Fixes mislabelled Lady's Mantle and Eucalyptus duplicate entries.

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE A: Delete mislabelled Lady's Mantle (id 63, Alchemilla arvensis)
-- Alchemilla arvensis is Parsley Piert, not Lady's Mantle.
-- The single action (Anti-inflammatory/Reproductive) is discarded.
-- Correct Lady's Mantle = id 1014 (Alchemilla vulgaris)
-- Correct Parsley Piert = id 1402 (Aphanes arvensis)
-- ─────────────────────────────────────────────────────────────────────────────
DELETE FROM herbal.herbs WHERE id = 63 AND latin_name = 'Alchemilla arvensis';

-- ─────────────────────────────────────────────────────────────────────────────
-- ISSUE B: Eucalyptus — re-point constituent profiles from Eucalyptus globulus
-- (id 1441) to Eucalyptus spp. (id 101), merge unique action, delete globulus.
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
  v_keep_id   INTEGER := 101;  -- Eucalyptus spp.
  v_drop_id   INTEGER := 1441; -- Eucalyptus globulus
BEGIN
  -- Re-point constituent profiles (NO ACTION FK — must update before delete)
  UPDATE herbal.constituent_profiles
    SET herb_id = v_keep_id
    WHERE herb_id = v_drop_id;

  -- Merge unique action: Antimicrobial/Skin
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT v_keep_id, primary_action_id, body_system_id
  FROM herbal.herb_primary_actions
  WHERE herb_id = v_drop_id
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Delete Eucalyptus globulus (remaining FK refs cascade)
  DELETE FROM herbal.herbs WHERE id = v_drop_id;

  RAISE NOTICE 'Eucalyptus: profiles re-pointed to spp., globulus deleted.';
END $$;
