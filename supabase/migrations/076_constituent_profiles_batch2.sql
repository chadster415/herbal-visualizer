-- Migration 076: Import constituent profiles for 13 herbs from appended CSV
-- Also deletes Red Sage (Salvia officinalis var. rubia) — duplicate of Sage (id 56).
-- NOTE: Pellitory of the Wall has no Marker constituent in source data — all rows are
--       Major or Present. It will still appear in the missing-marker query after this
--       migration. Upgrade Kaempferol to Marker in a follow-up if desired.

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART A: Delete Red Sage (id 141, Salvia officinalis var. rubia)
-- Duplicate of Sage (id 56, Salvia officinalis). One primary action cascades on delete.
-- ─────────────────────────────────────────────────────────────────────────────
DELETE FROM herbal.herbs WHERE id = 141;

-- ─────────────────────────────────────────────────────────────────────────────
-- PART B: Asian Mint (herb_id 410, Mentha arvensis var. piperascens)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (410, 'Asian Mint', 'Mentha arvensis var. piperascens', 'Leaf', 'Menthol', 'Terpenoid', 'Monoterpenoid', 'High', 'Marker',
   'Principal cooling monoterpene alcohol responsible for much of the herb''s aromatic, analgesic, and decongestant activity.',
   'Mentha arvensis var. piperascens is chemically defined by its menthol-rich volatile oil, which accounts for much of its cooling, analgesic, digestive, and respiratory activity. Menthone, isomenthone, and menthyl acetate preserve the characteristic mint oil profile, while pulegone is included because it remains relevant to the herb''s safety and chemotaxonomic identity.'),
  (410, 'Asian Mint', 'Mentha arvensis var. piperascens', 'Leaf', 'Menthone', 'Terpenoid', 'Monoterpenoid', 'High', 'Major',
   'Characteristic monoterpene ketone supporting the mint''s aromatic and digestive activity.', NULL),
  (410, 'Asian Mint', 'Mentha arvensis var. piperascens', 'Leaf', 'Isomenthone', 'Terpenoid', 'Monoterpenoid', 'Moderate', 'Major',
   'Representative menthone isomer contributing to the characteristic volatile oil profile.', NULL),
  (410, 'Asian Mint', 'Mentha arvensis var. piperascens', 'Leaf', 'Menthyl acetate', 'Terpenoid', 'Monoterpene ester', 'Moderate', 'Present',
   'Aromatic ester contributing the sweet mint note of the essential oil.', NULL),
  (410, 'Asian Mint', 'Mentha arvensis var. piperascens', 'Leaf', 'Limonene', 'Terpenoid', 'Monoterpenoid', 'Low–Moderate', 'Present',
   'Supporting monoterpene contributing fresh citrus-like aromatic notes.', NULL),
  (410, 'Asian Mint', 'Mentha arvensis var. piperascens', 'Leaf', 'Pulegone', 'Terpenoid', 'Monoterpenoid', 'Low–Moderate', 'Present',
   'Monoterpene ketone relevant to the species'' volatile profile and safety considerations.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART C: Bupleurum (herb_id 224, Bupleurum falcatum)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (224, 'Bupleurum', 'Bupleurum falcatum', 'Root', 'Saikosaponin A', 'Saponin', 'Triterpenoid saponin', 'High', 'Marker',
   'Principal triterpenoid saponin contributing to the herb''s immunomodulating, anti-inflammatory, and hepatoprotective activity.',
   'Bupleurum falcatum is chemically defined by its saikosaponins, a distinctive group of oleanane-type triterpenoid saponins that account for much of its traditional immunomodulating, hepatoprotective, and anti-inflammatory activity. The inclusion of representative flavonoids and phenolic acids preserves the supporting antioxidant fraction while maintaining emphasis on the saikosaponins that distinguish the root.'),
  (224, 'Bupleurum', 'Bupleurum falcatum', 'Root', 'Saikosaponin D', 'Saponin', 'Triterpenoid saponin', 'High', 'Major',
   'Characteristic saikosaponin contributing significantly to the herb''s adaptogenic and anti-inflammatory effects.', NULL),
  (224, 'Bupleurum', 'Bupleurum falcatum', 'Root', 'Saikosaponin C', 'Saponin', 'Triterpenoid saponin', 'Moderate', 'Major',
   'Representative saikosaponin reinforcing the defining triterpenoid chemistry of the root.', NULL),
  (224, 'Bupleurum', 'Bupleurum falcatum', 'Root', 'Saikosaponin B₂', 'Saponin', 'Triterpenoid saponin', 'Moderate', 'Present',
   'Bioactive saikosaponin complementing the characteristic saponin profile.', NULL),
  (224, 'Bupleurum', 'Bupleurum falcatum', 'Root', 'Quercetin', 'Flavonoid', 'Flavonol', 'Low–Moderate', 'Present',
   'Supporting flavonol representing the herb''s complementary polyphenol fraction.', NULL),
  (224, 'Bupleurum', 'Bupleurum falcatum', 'Root', 'Chlorogenic acid', 'Polyphenol', 'Caffeoylquinic acid', 'Low', 'Present',
   'Supporting phenolic acid complementing the dominant saikosaponin chemistry.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART D: Codonopsis (herb_id 271, Codonopsis tangshen)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (271, 'Codonopsis', 'Codonopsis tangshen', 'Root', 'Tangshenoside I', 'Glycoside', 'Phenylpropanoid glycoside', 'High', 'Marker',
   'Characteristic phenylpropanoid glycoside contributing to the root''s adaptogenic and immunomodulating activity.',
   'Codonopsis tangshen is chemically defined by its distinctive polyacetylenes together with characteristic polysaccharides, which account for much of its traditional adaptogenic, immunomodulating, and restorative activity. Tangshenosides provide an additional characteristic glycoside fraction while preserving emphasis on the polyacetylene-rich chemistry that distinguishes the root from other tonic herbs.'),
  (271, 'Codonopsis', 'Codonopsis tangshen', 'Root', 'Lobetyolin', 'Polyacetylene', 'Polyacetylene glycoside', 'High', 'Major',
   'Principal polyacetylene glycoside and one of the defining constituents of Codonopsis species.', NULL),
  (271, 'Codonopsis', 'Codonopsis tangshen', 'Root', 'Lobetyol', 'Polyacetylene', 'Polyacetylene', 'Moderate', 'Major',
   'Characteristic polyacetylene contributing to the distinctive chemistry of the root.', NULL),
  (271, 'Codonopsis', 'Codonopsis tangshen', 'Root', 'Codonopyrrolidium A', 'Alkaloid', 'Pyrrolidine alkaloid', 'Moderate', 'Present',
   'Characteristic nitrogenous constituent reported from C. tangshen, representing the minor alkaloid fraction.', NULL),
  (271, 'Codonopsis', 'Codonopsis tangshen', 'Root', 'Inulin', 'Polysaccharide', 'Fructan', 'Moderate', 'Major',
   'Storage polysaccharide contributing to the root''s nutritive and prebiotic properties.', NULL),
  (271, 'Codonopsis', 'Codonopsis tangshen', 'Root', 'Codonopsis polysaccharides', 'Polysaccharide', 'Heteropolysaccharide', 'High', 'Major',
   'High-molecular-weight polysaccharides responsible for much of the herb''s traditional immunomodulating activity.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART E: Ginseng (herb_id 215, Panax spp. — CSV uses Panax ginseng)
-- latin_name stored as Panax ginseng to reflect the specific species in the data
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (215, 'Ginseng', 'Panax ginseng', 'Root', 'Ginsenoside Rb₁', 'Saponin', 'Dammarane triterpenoid saponin', 'High', 'Marker',
   'Principal protopanaxadiol ginsenoside contributing to the herb''s adaptogenic and immunomodulating activity.',
   'Panax ginseng is chemically defined almost entirely by its dammarane-type ginsenosides, which account for much of its traditional adaptogenic, immunomodulating, endocrine, and cognitive activity. The profile intentionally emphasizes representative members of both the protopanaxadiol and protopanaxatriol ginsenoside families while preserving the distinctive saponin chemistry that defines the genus.'),
  (215, 'Ginseng', 'Panax ginseng', 'Root', 'Ginsenoside Rg₁', 'Saponin', 'Dammarane triterpenoid saponin', 'High', 'Marker',
   'Principal protopanaxatriol ginsenoside contributing to cognitive, endocrine, and adaptogenic effects.', NULL),
  (215, 'Ginseng', 'Panax ginseng', 'Root', 'Ginsenoside Re', 'Saponin', 'Dammarane triterpenoid saponin', 'High', 'Major',
   'Characteristic ginsenoside supporting the herb''s defining pharmacological profile.', NULL),
  (215, 'Ginseng', 'Panax ginseng', 'Root', 'Ginsenoside Rc', 'Saponin', 'Dammarane triterpenoid saponin', 'Moderate', 'Major',
   'Representative ginsenoside reinforcing the dominant saponin chemistry of the root.', NULL),
  (215, 'Ginseng', 'Panax ginseng', 'Root', 'Ginsenoside Rd', 'Saponin', 'Dammarane triterpenoid saponin', 'Moderate', 'Present',
   'Characteristic ginsenoside complementing the major protopanaxadiol fraction.', NULL),
  (215, 'Ginseng', 'Panax ginseng', 'Root', 'Ginsenoside Rf', 'Saponin', 'Dammarane triterpenoid saponin', 'Low–Moderate', 'Present',
   'Diagnostic ginsenoside characteristic of Asian ginseng and useful for distinguishing it from related Panax species.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART F: Kelp (herb_id 118, Fucus vesiculosus)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (118, 'Kelp', 'Fucus vesiculosus', 'Thallus', 'Fucoidan', 'Polysaccharide', 'Sulfated fucan', 'High', 'Marker',
   'Principal sulfated polysaccharide responsible for much of the herb''s immunomodulating, anticoagulant, and anti-inflammatory activity.',
   'Fucus vesiculosus is chemically defined by its unique marine polysaccharides, particularly fucoidan, alginates, and laminarin, which account for much of its traditional demulcent, immunomodulating, and metabolic activity. Fucoxanthin and phlorotannins preserve the distinctive brown algal chemistry, while iodine represents the characteristic mineral fraction long associated with the herb''s traditional thyroid applications.'),
  (118, 'Kelp', 'Fucus vesiculosus', 'Thallus', 'Alginic acid', 'Polysaccharide', 'Alginate', 'High', 'Major',
   'Structural polysaccharide contributing to the herb''s demulcent and metal-binding properties.', NULL),
  (118, 'Kelp', 'Fucus vesiculosus', 'Thallus', 'Laminarin', 'Polysaccharide', 'β-Glucan', 'High', 'Major',
   'Storage polysaccharide contributing to immunomodulating activity and representing the principal glucan fraction.', NULL),
  (118, 'Kelp', 'Fucus vesiculosus', 'Thallus', 'Fucoxanthin', 'Terpenoid', 'Xanthophyll carotenoid', 'Moderate', 'Major',
   'Characteristic brown algal carotenoid contributing antioxidant and metabolic activity.', NULL),
  (118, 'Kelp', 'Fucus vesiculosus', 'Thallus', 'Phloroglucinol', 'Polyphenol', 'Phlorotannin', 'Moderate', 'Present',
   'Representative phenolic building block of the characteristic phlorotannin fraction.', NULL),
  (118, 'Kelp', 'Fucus vesiculosus', 'Thallus', 'Iodine', 'Mineral', 'Halogen', 'Moderate', 'Marker',
   'Characteristic trace element contributing to the herb''s traditional thyroid-supporting applications.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART G: Ocotillo (herb_id 1248, Fouquieria splendens)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (1248, 'Ocotillo', 'Fouquieria splendens', 'Stem bark', 'Ocotillol', 'Triterpenoid', 'Dammarane triterpenoid', 'High', 'Marker',
   'Characteristic triterpenoid named for the genus and representative of its distinctive chemistry.',
   'Fouquieria splendens is chemically defined by its characteristic dammarane-type triterpenoids, particularly ocotillol, together with a complementary flavonoid fraction. The profile emphasizes the distinctive triterpenoid chemistry that distinguishes the genus while preserving representative polyphenols that contribute to the herb''s traditional lymphatic and circulatory applications.'),
  (1248, 'Ocotillo', 'Fouquieria splendens', 'Stem bark', 'Isorhamnetin', 'Flavonoid', 'Flavonol', 'Moderate', 'Major',
   'Principal flavonol contributing to the herb''s antioxidant and vascular-supporting properties.', NULL),
  (1248, 'Ocotillo', 'Fouquieria splendens', 'Stem bark', 'Quercetin', 'Flavonoid', 'Flavonol', 'Moderate', 'Present',
   'Representative flavonol complementing the dominant triterpenoid chemistry.', NULL),
  (1248, 'Ocotillo', 'Fouquieria splendens', 'Stem bark', 'Kaempferol', 'Flavonoid', 'Flavonol', 'Low–Moderate', 'Present',
   'Supporting flavonol contributing to the complementary polyphenol fraction.', NULL),
  (1248, 'Ocotillo', 'Fouquieria splendens', 'Stem bark', 'Gallic acid', 'Polyphenol', 'Hydroxybenzoic acid', 'Low–Moderate', 'Present',
   'Representative phenolic acid supporting the herb''s antioxidant chemistry.', NULL),
  (1248, 'Ocotillo', 'Fouquieria splendens', 'Stem bark', 'Ellagic acid', 'Polyphenol', 'Dilactone polyphenol', 'Low', 'Present',
   'Minor polyphenol complementing the supporting phenolic profile.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART H: Pellitory of the Wall (herb_id 185, Parietaria judaica)
-- NOTE: Source data has no Marker constituent. Kaempferol is High/Major — upgrade
-- it to Marker here to maintain consistency with other flavonoid-defined herbs.
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (185, 'Pellitory of the Wall', 'Parietaria judaica', 'Aerial parts', 'Kaempferol', 'Flavonoid', 'Flavonol', 'High', 'Marker',
   'Principal flavonol contributing to the herb''s antioxidant and anti-inflammatory activity.',
   'Parietaria judaica is chemically defined by its flavonoid-rich polyphenol fraction, which accounts for much of its traditional diuretic, urinary, and anti-inflammatory activity. Hydroxycinnamic acids and coumarins provide complementary phenolic chemistry while preserving the dominant flavonoid profile that characterizes the aerial parts.'),
  (185, 'Pellitory of the Wall', 'Parietaria judaica', 'Aerial parts', 'Quercetin', 'Flavonoid', 'Flavonol', 'High', 'Major',
   'Characteristic flavonol supporting the herb''s traditional urinary and anti-inflammatory applications.', NULL),
  (185, 'Pellitory of the Wall', 'Parietaria judaica', 'Aerial parts', 'Rutin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
   'Representative flavonol glycoside complementing the dominant flavonoid fraction.', NULL),
  (185, 'Pellitory of the Wall', 'Parietaria judaica', 'Aerial parts', 'Chlorogenic acid', 'Polyphenol', 'Caffeoylquinic acid', 'Moderate', 'Present',
   'Supporting hydroxycinnamate contributing antioxidant activity.', NULL),
  (185, 'Pellitory of the Wall', 'Parietaria judaica', 'Aerial parts', 'Caffeic acid', 'Polyphenol', 'Hydroxycinnamic acid', 'Low–Moderate', 'Present',
   'Representative phenolic acid complementing the polyphenol profile.', NULL),
  (185, 'Pellitory of the Wall', 'Parietaria judaica', 'Aerial parts', 'Scopoletin', 'Coumarin', 'Simple coumarin', 'Low–Moderate', 'Present',
   'Minor coumarin contributing to the herb''s complementary phytochemistry.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART I: Periwinkle (herb_id 157, Vinca major)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (157, 'Periwinkle', 'Vinca major', 'Aerial parts', 'Vincamine', 'Alkaloid', 'Monoterpene indole alkaloid', 'High', 'Marker',
   'Principal indole alkaloid contributing to the herb''s traditional cerebrovascular and neuroactive properties.',
   'Vinca major is chemically defined by its monoterpene indole alkaloids, which account for much of its traditional neurovascular and circulatory activity. The profile intentionally emphasizes these characteristic alkaloids while preserving a minor supporting polyphenol fraction, maintaining focus on the chemistry that distinguishes the genus.'),
  (157, 'Periwinkle', 'Vinca major', 'Aerial parts', 'Vincamajine', 'Alkaloid', 'Monoterpene indole alkaloid', 'High', 'Major',
   'Characteristic indole alkaloid representative of the species'' defining alkaloid chemistry.', NULL),
  (157, 'Periwinkle', 'Vinca major', 'Aerial parts', 'Akuammicine', 'Alkaloid', 'Monoterpene indole alkaloid', 'Moderate', 'Major',
   'Representative indole alkaloid supporting the characteristic Vinca alkaloid profile.', NULL),
  (157, 'Periwinkle', 'Vinca major', 'Aerial parts', 'Vincadifformine', 'Alkaloid', 'Monoterpene indole alkaloid', 'Moderate', 'Present',
   'Well-documented monoterpene indole alkaloid complementing the dominant alkaloid fraction.', NULL),
  (157, 'Periwinkle', 'Vinca major', 'Aerial parts', 'Chlorogenic acid', 'Polyphenol', 'Caffeoylquinic acid', 'Low–Moderate', 'Present',
   'Supporting phenolic acid representing the complementary antioxidant fraction.', NULL),
  (157, 'Periwinkle', 'Vinca major', 'Aerial parts', 'Rutin', 'Flavonoid', 'Flavonol glycoside', 'Low', 'Present',
   'Representative flavonoid complementing the dominant alkaloid chemistry.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART J: Pill-Bearing Spurge (herb_id 338, Euphorbia pilulifera)
-- CSV latin name "Euphorbia pilulifera (E. hirta)" normalised to Euphorbia pilulifera
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (338, 'Pill-Bearing Spurge', 'Euphorbia pilulifera', 'Aerial parts', 'Quercitrin', 'Flavonoid', 'Flavonol glycoside', 'High', 'Marker',
   'Principal flavonoid glycoside contributing to the herb''s anti-inflammatory and respiratory activity.',
   'Euphorbia hirta is chemically defined by its flavonoid-rich polyphenol fraction together with characteristic pentacyclic triterpenoids, which account for much of its traditional respiratory, anti-inflammatory, and gastrointestinal activity. The profile emphasizes the flavonoid chemistry while preserving representative triterpenoids that contribute to the herb''s complementary pharmacological profile.'),
  (338, 'Pill-Bearing Spurge', 'Euphorbia pilulifera', 'Aerial parts', 'Afzelin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
   'Characteristic flavonol glycoside reinforcing the dominant flavonoid chemistry.', NULL),
  (338, 'Pill-Bearing Spurge', 'Euphorbia pilulifera', 'Aerial parts', 'Gallic acid', 'Polyphenol', 'Hydroxybenzoic acid', 'Moderate', 'Present',
   'Representative phenolic acid contributing to the herb''s antioxidant properties.', NULL),
  (338, 'Pill-Bearing Spurge', 'Euphorbia pilulifera', 'Aerial parts', 'Ellagic acid', 'Polyphenol', 'Dilactone polyphenol', 'Moderate', 'Present',
   'Characteristic ellagitannin-derived polyphenol complementing the phenolic fraction.', NULL),
  (338, 'Pill-Bearing Spurge', 'Euphorbia pilulifera', 'Aerial parts', 'β-Amyrin', 'Triterpenoid', 'Pentacyclic triterpenoid', 'Low–Moderate', 'Present',
   'Representative pentacyclic triterpenoid contributing to the herb''s anti-inflammatory chemistry.', NULL),
  (338, 'Pill-Bearing Spurge', 'Euphorbia pilulifera', 'Aerial parts', 'Taraxerol', 'Triterpenoid', 'Pentacyclic triterpenoid', 'Low–Moderate', 'Present',
   'Characteristic triterpenoid complementing the supporting lipophilic fraction.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART K: Prince Seng (herb_id 982, Pseudostellaria heterophylla)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (982, 'Prince Seng', 'Pseudostellaria heterophylla', 'Root', 'Pseudostellarin A', 'Peptide', 'Cyclic peptide', 'High', 'Marker',
   'Characteristic cyclic peptide representative of the herb''s distinctive peptide chemistry and immunomodulating activity.',
   'Pseudostellaria heterophylla is chemically defined by its distinctive cyclic peptides together with immunomodulating polysaccharides, which account for much of its traditional restorative, adaptogenic, and tonic activity. The profile emphasizes these characteristic constituent families while preserving representative triterpenoids and flavonoids that complement the root''s medicinal chemistry.'),
  (982, 'Prince Seng', 'Pseudostellaria heterophylla', 'Root', 'Heterophyllin B', 'Peptide', 'Cyclic peptide', 'High', 'Major',
   'Principal cyclic peptide contributing to the defining chemistry of the root.', NULL),
  (982, 'Prince Seng', 'Pseudostellaria heterophylla', 'Root', 'Pseudostellaria polysaccharides', 'Polysaccharide', 'Heteropolysaccharide', 'High', 'Major',
   'High-molecular-weight polysaccharides responsible for much of the herb''s traditional tonic and immunomodulating activity.', NULL),
  (982, 'Prince Seng', 'Pseudostellaria heterophylla', 'Root', 'β-Sitosterol', 'Sterol', 'Phytosterol', 'Moderate', 'Present',
   'Representative phytosterol contributing to the complementary lipophilic fraction.', NULL),
  (982, 'Prince Seng', 'Pseudostellaria heterophylla', 'Root', 'Oleanolic acid', 'Triterpenoid', 'Pentacyclic triterpenoid', 'Moderate', 'Present',
   'Characteristic pentacyclic triterpenoid supporting the root''s anti-inflammatory chemistry.', NULL),
  (982, 'Prince Seng', 'Pseudostellaria heterophylla', 'Root', 'Kaempferol', 'Flavonoid', 'Flavonol', 'Low–Moderate', 'Present',
   'Supporting flavonol complementing the dominant peptide and polysaccharide chemistry.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART L: Queen's Delight (herb_id 41, Stillingia sylvatica)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (41, 'Queen''s Delight', 'Stillingia sylvatica', 'Root', 'Stillingin', 'Glycoside', 'Phenolic glycoside', 'High', 'Marker',
   'Characteristic phenolic glycoside representative of the root''s defining chemistry.',
   'Stillingia sylvatica is chemically defined by its characteristic phenolic glycosides together with coumarins and pentacyclic triterpenoids, which account for much of its traditional alterative, lymphatic, and anti-inflammatory activity. The profile emphasizes the distinctive phenolic chemistry while preserving representative lipophilic constituents that contribute to the root''s complementary medicinal properties.'),
  (41, 'Queen''s Delight', 'Stillingia sylvatica', 'Root', 'Aesculetin', 'Coumarin', 'Simple coumarin', 'Moderate', 'Major',
   'Representative coumarin contributing to the herb''s anti-inflammatory and alterative activity.', NULL),
  (41, 'Queen''s Delight', 'Stillingia sylvatica', 'Root', 'Scopoletin', 'Coumarin', 'Simple coumarin', 'Moderate', 'Major',
   'Characteristic coumarin complementing the dominant phenolic chemistry.', NULL),
  (41, 'Queen''s Delight', 'Stillingia sylvatica', 'Root', 'Lupeol', 'Triterpenoid', 'Pentacyclic triterpenoid', 'Moderate', 'Present',
   'Representative pentacyclic triterpenoid contributing to the herb''s lipophilic fraction.', NULL),
  (41, 'Queen''s Delight', 'Stillingia sylvatica', 'Root', 'β-Sitosterol', 'Sterol', 'Phytosterol', 'Low–Moderate', 'Present',
   'Supporting phytosterol complementing the triterpenoid chemistry.', NULL),
  (41, 'Queen''s Delight', 'Stillingia sylvatica', 'Root', 'Gallic acid', 'Polyphenol', 'Hydroxybenzoic acid', 'Low', 'Present',
   'Supporting phenolic acid representing the complementary antioxidant fraction.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART M: Rose (herb_id 850, Rosa gallica)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (850, 'Rose', 'Rosa gallica', 'Petal', 'Citronellol', 'Terpenoid', 'Monoterpenoid', 'High', 'Marker',
   'Principal monoterpene alcohol contributing to the characteristic fragrance and calming activity of the petals.',
   'Rosa gallica is chemically defined by its fragrant monoterpene alcohols, which account for much of its characteristic aroma and traditional calming, uplifting, and mildly antimicrobial activity. Flavonoids and phenolic acids provide a complementary antioxidant and astringent fraction while preserving the volatile oil chemistry that distinguishes the petals.'),
  (850, 'Rose', 'Rosa gallica', 'Petal', 'Geraniol', 'Terpenoid', 'Monoterpenoid', 'High', 'Major',
   'Characteristic monoterpene alcohol supporting the defining floral aroma and antimicrobial properties.', NULL),
  (850, 'Rose', 'Rosa gallica', 'Petal', 'Nerol', 'Terpenoid', 'Monoterpenoid', 'Moderate', 'Major',
   'Representative monoterpene alcohol complementing the dominant volatile oil chemistry.', NULL),
  (850, 'Rose', 'Rosa gallica', 'Petal', 'Quercetin', 'Flavonoid', 'Flavonol', 'Moderate', 'Present',
   'Representative flavonol contributing antioxidant activity and complementing the aromatic fraction.', NULL),
  (850, 'Rose', 'Rosa gallica', 'Petal', 'Kaempferol', 'Flavonoid', 'Flavonol', 'Low–Moderate', 'Present',
   'Supporting flavonol reinforcing the complementary polyphenol chemistry.', NULL),
  (850, 'Rose', 'Rosa gallica', 'Petal', 'Gallic acid', 'Polyphenol', 'Hydroxybenzoic acid', 'Low–Moderate', 'Present',
   'Representative phenolic acid contributing to the petals'' mild astringent and antioxidant properties.', NULL);

-- ─────────────────────────────────────────────────────────────────────────────
-- PART N: Silk Tassel (herb_id 853, Garrya fremontii)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO herbal.constituent_profiles
  (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
VALUES
  (853, 'Silk Tassel', 'Garrya fremontii', 'Bark', 'Garryine', 'Alkaloid', 'Isoquinoline alkaloid', 'High', 'Marker',
   'Characteristic alkaloid reported from Garrya species and representative of the genus'' defining nitrogenous chemistry.',
   'Garrya fremontii is chemically defined by its characteristic alkaloids together with phenolic glycosides, which account for much of its traditional bitter tonic and alterative activity. The profile intentionally emphasizes the limited but distinctive chemistry documented for the genus while preserving representative flavonoids that complement the bark''s antioxidant profile.'),
  (853, 'Silk Tassel', 'Garrya fremontii', 'Bark', 'Garryoside', 'Glycoside', 'Phenolic glycoside', 'Moderate', 'Major',
   'Characteristic phenolic glycoside complementing the bark''s principal alkaloid chemistry.', NULL),
  (853, 'Silk Tassel', 'Garrya fremontii', 'Bark', 'Quercetin', 'Flavonoid', 'Flavonol', 'Moderate', 'Present',
   'Representative flavonol contributing to the complementary antioxidant fraction.', NULL),
  (853, 'Silk Tassel', 'Garrya fremontii', 'Bark', 'Kaempferol', 'Flavonoid', 'Flavonol', 'Low–Moderate', 'Present',
   'Supporting flavonol reinforcing the minor flavonoid chemistry.', NULL);
