SET search_path TO herbal, public;

-- ============================================================
-- Bitter Melon — capitalize constituent names
-- constituent_profiles.constituent and the 4 new constituents
-- entries were written in lowercase; convention is Title Case.
-- ============================================================

-- Block 1 — Rename the 4 new constituents in the shared constituents table
UPDATE herbal.constituents SET name = 'Charantin'     WHERE name = 'charantin';
UPDATE herbal.constituents SET name = 'Polypeptide-P' WHERE name = 'polypeptide-p';
UPDATE herbal.constituents SET name = 'Momordicin'    WHERE name = 'momordicin';
UPDATE herbal.constituents SET name = 'Vicine'        WHERE name = 'vicine';

-- Block 2 — Fix constituent_profiles.constituent for all Bitter Melon rows
UPDATE herbal.constituent_profiles SET constituent = 'Charantin'     WHERE latin_name = 'Momordica charantia' AND constituent = 'charantin';
UPDATE herbal.constituent_profiles SET constituent = 'Polypeptide-P' WHERE latin_name = 'Momordica charantia' AND constituent = 'polypeptide-p';
UPDATE herbal.constituent_profiles SET constituent = 'Momordicin'    WHERE latin_name = 'Momordica charantia' AND constituent = 'momordicin';
UPDATE herbal.constituent_profiles SET constituent = 'Vicine'        WHERE latin_name = 'Momordica charantia' AND constituent = 'vicine';
UPDATE herbal.constituent_profiles SET constituent = 'Quercetin'     WHERE latin_name = 'Momordica charantia' AND constituent = 'quercetin';
UPDATE herbal.constituent_profiles SET constituent = 'Kaempferol'    WHERE latin_name = 'Momordica charantia' AND constituent = 'kaempferol';
UPDATE herbal.constituent_profiles SET constituent = 'Luteolin'      WHERE latin_name = 'Momordica charantia' AND constituent = 'luteolin';
UPDATE herbal.constituent_profiles SET constituent = 'Beta-Sitosterol' WHERE latin_name = 'Momordica charantia' AND constituent = 'beta-sitosterol';
UPDATE herbal.constituent_profiles SET constituent = 'Linoleic Acid' WHERE latin_name = 'Momordica charantia' AND constituent = 'linoleic acid';
