-- Migration 334: Add rosmarinic acid to Motherwort (Leonurus cardiaca, id=131)
-- Rosmarinic acid is characteristic of Lamiaceae; present in Motherwort and
-- responsible for its calming effect on T3 uptake in hyperthyroidism (BHC Class 67).
-- Constituent id=783, concentration: moderate.

SET search_path TO herbal, public;

INSERT INTO herbal.herb_constituents
  (herb_id, constituent_id, concentration_level, notes, sort_order)
VALUES
  (131, 783, 'moderate',
   'Characteristic Lamiaceae phenylpropanoid; contributes to anti-thyroid action by calming T3 uptake into tissues',
   110)
ON CONFLICT (herb_id, constituent_id) DO NOTHING;
