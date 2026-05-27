-- Consolidate near-duplicate primary_actions records.
-- Each block: delete conflicting child rows, remap remaining references to the
-- canonical ID, then delete the duplicate action record (CASCADE handles any
-- remaining child rows).
--
-- Merges (duplicate → canonical):
--   178 Anticatarhal       → 3   Anticatarrhal
--   389 Circulatory stimulant → 29  Circulatory Stimulant
--    95 Immune support     → 25  Immune Support
--   133 Immune stimulant   → 40  Immunostimulant
--   234 Nervine relaxant   → 23  Nervine Relaxant
--   327 Nervine stimulant  → 24  Nervine Stimulant
--   238 Nervine tonic      → 22  Nervine Tonic
--   394 Vascular tonic     → 42  Vascular Tonic

DO $$
DECLARE
  merges INT[][] := ARRAY[
    ARRAY[178, 3],
    ARRAY[389, 29],
    ARRAY[95,  25],
    ARRAY[133, 40],
    ARRAY[234, 23],
    ARRAY[327, 24],
    ARRAY[238, 22],
    ARRAY[394, 42]
  ];
  dup_id   INT;
  canon_id INT;
  pair     INT[];
BEGIN
  FOREACH pair SLICE 1 IN ARRAY merges LOOP
    dup_id   := pair[1];
    canon_id := pair[2];

    -- herb_primary_actions: unique (herb_id, primary_action_id, body_system_id)
    DELETE FROM herbal.herb_primary_actions dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.herb_primary_actions canon
        WHERE canon.herb_id        = dup.herb_id
          AND canon.primary_action_id = canon_id
          AND canon.body_system_id    = dup.body_system_id
      );
    UPDATE herbal.herb_primary_actions
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- action_descriptions: no compound unique constraint, just remap
    UPDATE herbal.action_descriptions
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- disorder_action_herbs: unique (disorder_id, herb_id, primary_action_id)
    DELETE FROM herbal.disorder_action_herbs dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.disorder_action_herbs canon
        WHERE canon.disorder_id      = dup.disorder_id
          AND canon.herb_id          = dup.herb_id
          AND canon.primary_action_id = canon_id
      );
    UPDATE herbal.disorder_action_herbs
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- disorder_actions_indicated: unique (disorder_id, primary_action_id)
    DELETE FROM herbal.disorder_actions_indicated dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.disorder_actions_indicated canon
        WHERE canon.disorder_id      = dup.disorder_id
          AND canon.primary_action_id = canon_id
      );
    UPDATE herbal.disorder_actions_indicated
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- prescription_herb_actions: unique (prescription_herb_id, primary_action_id)
    DELETE FROM herbal.prescription_herb_actions dup
    WHERE dup.primary_action_id = dup_id
      AND EXISTS (
        SELECT 1 FROM herbal.prescription_herb_actions canon
        WHERE canon.prescription_herb_id = dup.prescription_herb_id
          AND canon.primary_action_id     = canon_id
      );
    UPDATE herbal.prescription_herb_actions
      SET primary_action_id = canon_id
      WHERE primary_action_id = dup_id;

    -- Remove the duplicate action (CASCADE cleans up any orphaned child rows)
    DELETE FROM herbal.primary_actions WHERE id = dup_id;

    RAISE NOTICE 'Merged primary_action % into %', dup_id, canon_id;
  END LOOP;
END $$;
