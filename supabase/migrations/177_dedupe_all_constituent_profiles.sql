-- Deduplicate constituent_profiles for all herbs with duplicate (herb_id, constituent) pairs.
-- 116 duplicate rows found across 25 herbs (Bearberry, Dan Shen, Dandelion, Devil's Claw,
-- Echinacea, Hawthorn, Hops, Horehound, Horse Chestnut, Horsetail, Hyssop, Iceland Moss,
-- Juniper, Kava, Lavender, Lemon Balm, Licorice, Linden, Lobelia, Lungwort, Ma Huang,
-- Maca, Marshmallow, Meadowsweet, Mistletoe, Reishi, Shepherd's Purse, Tea, Vervain, Violet).
--
-- Strategy: keep the row ranked highest by (Marker>Major>Present>Reported, High>Moderate>Low–Moderate>Low, lower id).
-- For 9 cases where the winner lacks an editorial note but the loser has one, copy it first.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Step 1: copy editorial notes from losers → winners where winner has none
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 139)   WHERE id = 1048 AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 381)   WHERE id = 1304 AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 1314)  WHERE id = 388  AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 422)   WHERE id = 416  AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 1408)  WHERE id = 529  AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 1426)  WHERE id = 553  AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 1480)  WHERE id = 618  AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 1534)  WHERE id = 671  AND (editorial_note IS NULL OR editorial_note = '');
  UPDATE herbal.constituent_profiles SET editorial_note = (SELECT editorial_note FROM herbal.constituent_profiles WHERE id = 700)   WHERE id = 440  AND (editorial_note IS NULL OR editorial_note = '');

  RAISE NOTICE 'Step 1 complete: editorial notes copied to winners where needed';

  -- Step 2: delete all duplicate losers
  -- Winner = highest (status rank, importance rank, lowest id) per (herb_id, constituent).
  DELETE FROM herbal.constituent_profiles
  WHERE id IN (
    SELECT id FROM (
      SELECT id,
        ROW_NUMBER() OVER (
          PARTITION BY herb_id, constituent
          ORDER BY
            CASE status
              WHEN 'Marker'   THEN 4
              WHEN 'Major'    THEN 3
              WHEN 'Present'  THEN 2
              ELSE 1
            END DESC,
            CASE importance
              WHEN 'High'         THEN 4
              WHEN 'Moderate'     THEN 3
              WHEN 'Low–Moderate' THEN 2
              ELSE 1
            END DESC,
            id ASC
        ) AS rn,
        COUNT(*) OVER (PARTITION BY herb_id, constituent) AS cnt
      FROM herbal.constituent_profiles
      WHERE herb_id IS NOT NULL
    ) sub
    WHERE rn > 1 AND cnt > 1
  );

  RAISE NOTICE 'Step 2 complete: duplicate constituent_profiles removed';

END $$;
