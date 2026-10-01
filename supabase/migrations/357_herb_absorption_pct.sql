-- Add absorption_pct to herbal.herbs
-- Conservative ("safe estimate") absorption % per plant part, from the Menstruum Calculator chart.
-- Used to plan how much extra menstruum to prepare to account for herb absorption.

SET search_path TO herbal, public;

ALTER TABLE herbal.herbs
  ADD COLUMN IF NOT EXISTS absorption_pct SMALLINT;

COMMENT ON COLUMN herbal.herbs.absorption_pct IS
  'Conservative % of menstruum absorbed by dried herb. Based on plant-part absorption chart. NULL = unknown.';

-- ── Mass-populate by plant_part (case-insensitive) ───────────────────────────

-- Leaf: 20%
UPDATE herbal.herbs SET absorption_pct = 20
WHERE LOWER(TRIM(plant_part)) IN ('leaf','leaves','blade','needles');

-- Flower / fruit / berry: 20%
UPDATE herbal.herbs SET absorption_pct = 20
WHERE LOWER(TRIM(plant_part)) IN ('flower','flowers','flower bud','flower buds','petal','petals','calyx','hips','berry','fruit');

-- Aerial parts / soft stems: 22%
UPDATE herbal.herbs SET absorption_pct = 22
WHERE LOWER(TRIM(plant_part)) IN ('aerial parts','flowering tops','flowering herb','leaf & flower','whole herb','stem','straw','milky oats');

-- Seeds (non-mucilaginous): 20%
UPDATE herbal.herbs SET absorption_pct = 20
WHERE LOWER(TRIM(plant_part)) IN ('seed','seeds');

-- High mucilage seeds: 45%
UPDATE herbal.herbs SET absorption_pct = 45
WHERE LOWER(TRIM(plant_part)) IN ('seed husk');

-- Roots / rhizomes / tubers (moderate density): 30%
UPDATE herbal.herbs SET absorption_pct = 30
WHERE LOWER(TRIM(plant_part)) IN ('root','rhizome','tuber');

-- Bark / woody material: 35%
UPDATE herbal.herbs SET absorption_pct = 35
WHERE LOWER(TRIM(plant_part)) IN ('bark','root bark');

-- Compound plant_parts where bark dominates
UPDATE herbal.herbs SET absorption_pct = 35
WHERE LOWER(TRIM(plant_part)) IN ('bark, fruit','root bark, berry');

-- Resinous material: 30%
UPDATE herbal.herbs SET absorption_pct = 30
WHERE LOWER(TRIM(plant_part)) = 'gum resin';

-- Fungal fruiting bodies (not on chart — estimated 25%)
UPDATE herbal.herbs SET absorption_pct = 25
WHERE LOWER(TRIM(plant_part)) = 'fruiting body';

-- Thallus (seaweed, lichen — estimated 20%)
UPDATE herbal.herbs SET absorption_pct = 20
WHERE LOWER(TRIM(plant_part)) = 'thallus';

-- Processed forms (colloidal oat — estimated 20%)
UPDATE herbal.herbs SET absorption_pct = 20
WHERE LOWER(TRIM(plant_part)) = 'colloidal';

-- ── Per-herb overrides for special cases ─────────────────────────────────────

-- Dense roots: 32%
UPDATE herbal.herbs SET absorption_pct = 32
WHERE latin_name IN (
  'Symphytum officinale',    -- Comfrey
  'Echinacea purpurea',
  'Echinacea angustifolia',
  'Ligusticum porteri'       -- Osha (dense resinous root)
);

-- Mucilaginous roots / bark: 40%
UPDATE herbal.herbs SET absorption_pct = 40
WHERE latin_name IN (
  'Althaea officinalis',     -- Marshmallow
  'Ulmus rubra',             -- Slippery Elm
  'Ulmus fulva'
);

-- High mucilage seeds: 45%
UPDATE herbal.herbs SET absorption_pct = 45
WHERE latin_name IN (
  'Linum usitatissimum',     -- Flax seed
  'Salvia hispanica'         -- Chia seed
);

-- ── Verification query (informational, run separately if desired) ─────────────
-- SELECT plant_part, absorption_pct, COUNT(*) FROM herbal.herbs
-- WHERE plant_part IS NOT NULL
-- GROUP BY plant_part, absorption_pct ORDER BY plant_part;
