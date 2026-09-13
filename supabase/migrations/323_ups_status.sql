-- Add United Plant Savers (UPS) conservation status to herbs
CREATE TYPE herbal.ups_status AS ENUM ('critical', 'at_risk', 'in_review');

ALTER TABLE herbal.herbs
  ADD COLUMN ups_status herbal.ups_status,
  ADD COLUMN ups_url TEXT;

-- Critical
UPDATE herbal.herbs SET ups_status = 'critical', ups_url = 'https://unitedplantsavers.org/false-unicorn-root-chamaelirium-luteum/' WHERE id = 2617; -- False Unicorn
UPDATE herbal.herbs SET ups_status = 'critical', ups_url = 'https://unitedplantsavers.org/sundew-drosera-spp-2/'                     WHERE id = 126;  -- Sundew
UPDATE herbal.herbs SET ups_status = 'critical', ups_url = 'https://unitedplantsavers.org/peyote-lophophora-williamsii-2/'           WHERE id = 2350; -- Peyote
UPDATE herbal.herbs SET ups_status = 'critical', ups_url = 'https://unitedplantsavers.org/sandalwood-santalum-spp/'                  WHERE id = 413;  -- Sandalwood
UPDATE herbal.herbs SET ups_status = 'critical', ups_url = 'https://unitedplantsavers.org/trillium-trillium-spp/'                   WHERE id = 2626; -- Trillium

-- At-Risk
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/black-cohosh-actaea-racemosa/'            WHERE id = 25;   -- Black Cohosh
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/true-unicorn-root-aletris-farinosa/'     WHERE id = 2610; -- Aletris / True Unicorn
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/yerba-mansa-anemopsis-californica/'      WHERE id = 309;  -- Yerba Mansa
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/spikenard-aralia-racemosa/'              WHERE id = 2479; -- Spikenard
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/butterfly-weed-asclepias-tuberosa/'      WHERE id = 67;   -- Pleurisy Root / Butterfly Weed
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/wild-indigo-baptisia-tinctoria/'         WHERE id = 23;   -- Wild Indigo
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = NULL                                                                     WHERE id = 158;  -- Barberry (Berberis spp. / Oregon Root — no specific monograph)
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/blue-cohosh-caulophyllum-thalictroides-2/' WHERE id = 72;  -- Blue Cohosh
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/pipsissewa-chimaphila-umbellata/'        WHERE id = 2239; -- Pipsissewa
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/stone-root-collinsonia-canadensis/'      WHERE id = 182;  -- Stoneroot
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/wild-yam-dioscorea-villosa/'             WHERE id = 74;   -- Wild Yam
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/echinacea-echinacea-spp-2/'              WHERE id = 26;   -- Echinacea spp.
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/echinacea-echinacea-spp-2/'              WHERE id = 221;  -- Echinacea angustifolia
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/yerba-santa-eriodictyon-californicum/'   WHERE id = 590;  -- Yerba Santa
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/gentian-gentiana-spp/'                   WHERE id = 102;  -- Gentian
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/goldenseal-hydrastis-canadensis-2/'      WHERE id = 30;   -- Goldenseal
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/osha-ligusticum-porteri/'                WHERE id = 104;  -- Osha
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/lomatium-lomatium-dissectum/'            WHERE id = 980;  -- Lomatium
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/kava-kava-piper-methysticum/'            WHERE id = 138;  -- Kava
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/mayapple-podophyllum-peltatum/'          WHERE id = 2605; -- Podophyllum / Mayapple
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/partridge-berry-mitchella-repens/'       WHERE id = 188;  -- Partridgeberry
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/american-ginseng-panax-quinquefolius-2/' WHERE id = 15;   -- American Ginseng
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/bloodroot-sanguinaria-canadensis-2/'     WHERE id = 38;   -- Bloodroot
UPDATE herbal.herbs SET ups_status = 'at_risk',  ups_url = 'https://unitedplantsavers.org/slippery-elm-ulmus-rubra'               WHERE id = 92;   -- Slippery Elm

-- In Review
UPDATE herbal.herbs SET ups_status = 'in_review', ups_url = 'https://unitedplantsavers.org/arnica-arnica-spp/'           WHERE id = 114;  -- Arnica
UPDATE herbal.herbs SET ups_status = 'in_review', ups_url = 'https://unitedplantsavers.org/eyebright-euphrasia-spp-2/'   WHERE id = 51;   -- Eyebright
UPDATE herbal.herbs SET ups_status = 'in_review', ups_url = 'https://unitedplantsavers.org/indian-tobacco-lobelia-inflata/' WHERE id = 132; -- Lobelia
UPDATE herbal.herbs SET ups_status = 'in_review', ups_url = NULL                                                           WHERE id = 1252; -- Solomon's Seal (no monograph)
UPDATE herbal.herbs SET ups_status = 'in_review', ups_url = NULL                                                           WHERE id = 140;  -- Wild Cherry Bark (no monograph)
UPDATE herbal.herbs SET ups_status = 'in_review', ups_url = NULL                                                           WHERE id = 143;  -- Skunk Cabbage (no monograph)
