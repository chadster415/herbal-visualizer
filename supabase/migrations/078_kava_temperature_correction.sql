-- Correct Kava's temperature from cooling to warming
UPDATE herbal.herbs
SET temperature = 'warming'
WHERE id = 138; -- Kava