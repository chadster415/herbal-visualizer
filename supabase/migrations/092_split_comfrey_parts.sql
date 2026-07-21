-- Migration 092: Split Comfrey into root and leaf herb entries
--
-- Comfrey root: Demulcent, Vulnerary, Astringent, Relaxing Expectorant, Anti-inflammatory,
--               Emollient, Tonic. Rich in allantoin and pyrrolizidine alkaloids (PAs).
--               Internal use of root is restricted in modern practice due to hepatotoxic PAs.
--               All GI disorder references (Hiatus Hernia, Peptic Ulcers, Ulcerative Colitis),
--               the Varicose Veins external lotion, and postpartum perineal tear ointments
--               all reference root — matching the source material's traditional usage.
-- Comfrey leaf: Lower PA content; used as food/nutritive herb (pregnancy anemia).
--               Also has Demulcent and Vulnerary properties (allantoin and mucilage present,
--               though less than root).
--
-- Strategy:
--   • Convert existing id 89 → root (holds all existing actions, disorder refs, constituent data)
--   • Create leaf entry; seed Demulcent and Vulnerary actions (body-system-matched from root)
--   • Move Pregnancy Anemia specific remedy to leaf (explicitly "Leafy herb that can be added to salads")
--   • All other disorder_specific_remedies and disorder_action_herbs stay on root
--   • All constituent_profiles already tagged plant_part = 'Root' — stay on root, no changes
--   • All prescription_herbs stay on root (blank-note GI/external uses are root contexts)
--   • Set same monograph URL on leaf

SET search_path TO herbal, public;

DO $$
DECLARE
  v_root_id INTEGER := 89;
  v_leaf_id INTEGER;
BEGIN

  -- 1. Convert existing Comfrey entry to root
  UPDATE herbal.herbs
  SET plant_part = 'root'
  WHERE id = v_root_id AND latin_name = 'Symphytum officinale';

  RAISE NOTICE 'Comfrey (id 89) → Comfrey root';

  -- 2. Create Comfrey leaf entry
  v_leaf_id := herbal.ensure_herb('Symphytum officinale', 'Comfrey', 'leaf');

  UPDATE herbal.herbs
  SET temperature   = 'cooling',
      moisture      = 'moistening',
      tone          = 'neutral',
      monograph_url = (SELECT monograph_url FROM herbal.herbs WHERE id = v_root_id)
  WHERE id = v_leaf_id;

  RAISE NOTICE 'Created Comfrey leaf (id %)', v_leaf_id;

  -- 3. Seed leaf with Demulcent and Vulnerary (present in both parts, less than root)
  --    Copy all body-system variants of those two actions from root → leaf
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)
  SELECT v_leaf_id, hpa.primary_action_id, hpa.body_system_id,
         hpa.relative_strength, hpa.body_system_note
  FROM herbal.herb_primary_actions hpa
  JOIN herbal.primary_actions pa ON pa.id = hpa.primary_action_id
  WHERE hpa.herb_id = v_root_id
    AND pa.name IN ('Demulcent', 'Vulnerary')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- 4. Move Pregnancy Anemia specific remedy to leaf
  --    Description: "Leafy herb that can be added to salads, cooked as a vegetable..."
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description)
  SELECT disorder_id, v_leaf_id, description
  FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_root_id
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Pregnancy - First Trimester - Anemia'
        AND bs.name = 'Reproductive - Female'
    )
  ON CONFLICT (disorder_id, herb_id) DO NOTHING;

  DELETE FROM herbal.disorder_specific_remedies
  WHERE herb_id = v_root_id
    AND disorder_id = (
      SELECT d.id FROM herbal.disorders d
      JOIN herbal.body_systems bs ON bs.id = d.body_system_id
      WHERE d.name = 'Pregnancy - First Trimester - Anemia'
        AND bs.name = 'Reproductive - Female'
    );

  RAISE NOTICE 'Moved Pregnancy Anemia specific remedy → leaf';

  -- Remaining on root: all disorder_action_herbs (Hiatus Hernia, Peptic Ulcers, Ulcerative Colitis,
  -- Aging/Digestive), all other specific_remedies (IBS, Hiatus Hernia, Peptic Ulcers, Acute Bronchitis,
  -- Postpartum Perineal Tears), all prescription_herbs (GI formulas + external lotion),
  -- all constituent_profiles (plant_part = 'Root'), pyrrolizidine alkaloids herb_constituent.

  RAISE NOTICE 'Done. Comfrey root = 89, Comfrey leaf = %', v_leaf_id;

END $$;
