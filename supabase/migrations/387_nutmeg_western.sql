-- Migration 387: Expose Nutmeg to Western herbalism
--
-- id=1595 was TCM-only (Semen Myristicae Fragrantis / Rou Dou Kou).
-- Update to proper botanical Latin name, add plant_part, and clear is_tcm flag.
-- pinyin_name retained for TCM reference.

SET search_path TO herbal, public;

UPDATE herbal.herbs
SET
  latin_name = 'Myristica fragrans',
  plant_part = 'seed',
  is_tcm     = false
WHERE id = 1595;
