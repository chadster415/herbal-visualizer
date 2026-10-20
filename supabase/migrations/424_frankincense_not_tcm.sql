-- Migration 424: Mark Frankincense (Boswellia / Resina Olibani, id=1597) as non-TCM
-- Frankincense is a pan-cultural resin used in Ayurveda, Middle Eastern, and western traditions,
-- not solely a TCM herb. Setting is_tcm = false makes it visible in the western herb browser.

SET search_path TO herbal, public;

UPDATE herbal.herbs
SET is_tcm = false
WHERE id = 1597;
