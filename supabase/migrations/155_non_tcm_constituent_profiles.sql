SET search_path TO herbal, public;

-- Adds the 10 non-TCM herbs to constituent_profiles (the "Constituent Profile
-- Markers" table). Data from fresh literature review (August 2026).
-- Uses WHERE NOT EXISTS since constituent_profiles has no unique constraint
-- on (herb_id, constituent).
--
-- Note: migration 154 added these same herbs to herb_constituents in error;
-- that data can be cleaned up separately if desired.

-- ============================================================
-- Black Mustard — Brassica nigra, Seed — id 1860
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 1860;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Black Mustard', 'Brassica nigra', 'Seed', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Sinigrin', 'Glycoside', 'Glucosinolate', 'High', 'Marker',
     'Dominant glucosinolate and precursor of the pungent rubefacient allyl isothiocyanate.',
     'Brassica nigra seed is unusually well represented by a single dominant glucosinolate, sinigrin. Its enzymatic conversion to allyl isothiocyanate explains the characteristic pungency, counterirritant effect, and antimicrobial activity of wetted mustard preparations.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Black Mustard constituent_profiles loaded';
END $$;

-- ============================================================
-- Cashew — Anacardium occidentale, Nut shell — id 2341
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 2341;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Cashew', 'Anacardium occidentale', 'Nut shell', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Anacardic acid', 'Lipid', 'Phenolic lipid', 'High', 'Marker',
     'Dominant phenolic lipid contributing antimicrobial, enzyme-inhibitory, and irritant activity.',
     'Anacardium occidentale nut shell is chemically defined by its unusual long-chain phenolic lipids, particularly anacardic acids and cardols. These compounds account for much of the shell''s antimicrobial, antioxidant, and strongly irritant activity and distinguish it sharply from the edible cashew kernel.'),
    ('Cardol', 'Lipid', 'Phenolic lipid', 'High', 'Major',
     'Characteristic resorcinolic lipid contributing antioxidant and antimicrobial activity.',
     'Anacardium occidentale nut shell is chemically defined by its unusual long-chain phenolic lipids, particularly anacardic acids and cardols. These compounds account for much of the shell''s antimicrobial, antioxidant, and strongly irritant activity and distinguish it sharply from the edible cashew kernel.'),
    ('Cardanol', 'Lipid', 'Phenolic lipid', 'Moderate', 'Major',
     'Phenolic lipid contributing antioxidant activity and characteristic shell chemistry.',
     'Anacardium occidentale nut shell is chemically defined by its unusual long-chain phenolic lipids, particularly anacardic acids and cardols. These compounds account for much of the shell''s antimicrobial, antioxidant, and strongly irritant activity and distinguish it sharply from the edible cashew kernel.'),
    ('2-Methylcardol', 'Lipid', 'Phenolic lipid', 'Low–Moderate', 'Present',
     'Minor characteristic phenolic lipid complementing the cardol fraction.',
     'Anacardium occidentale nut shell is chemically defined by its unusual long-chain phenolic lipids, particularly anacardic acids and cardols. These compounds account for much of the shell''s antimicrobial, antioxidant, and strongly irritant activity and distinguish it sharply from the edible cashew kernel.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Cashew constituent_profiles loaded';
END $$;

-- ============================================================
-- Chinese Skullcap — Scutellaria baicalensis, Root — id 2274
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 2274;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Chinese Skullcap', 'Scutellaria baicalensis', 'Root', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Baicalin', 'Flavonoid', 'Flavone glycoside', 'High', 'Marker',
     'Principal flavone glucuronide contributing anti-inflammatory, antiviral, and hepatoprotective activity.',
     'Scutellaria baicalensis root is defined overwhelmingly by its specialized flavones and their glucuronides, especially baicalin/baicalein and wogonoside/wogonin. This chemistry explains much of its anti-inflammatory and antimicrobial reputation and clearly separates Chinese Skullcap from S. lateriflora.'),
    ('Baicalein', 'Flavonoid', 'Flavone', 'High', 'Marker',
     'Major aglycone contributing anti-inflammatory and antioxidant activity.',
     'Scutellaria baicalensis root is defined overwhelmingly by its specialized flavones and their glucuronides, especially baicalin/baicalein and wogonoside/wogonin. This chemistry explains much of its anti-inflammatory and antimicrobial reputation and clearly separates Chinese Skullcap from S. lateriflora.'),
    ('Wogonoside', 'Flavonoid', 'Flavone glycoside', 'High', 'Major',
     'Characteristic glucuronide complementing baicalin within the root-specific flavone profile.',
     'Scutellaria baicalensis root is defined overwhelmingly by its specialized flavones and their glucuronides, especially baicalin/baicalein and wogonoside/wogonin. This chemistry explains much of its anti-inflammatory and antimicrobial reputation and clearly separates Chinese Skullcap from S. lateriflora.'),
    ('Wogonin', 'Flavonoid', 'Flavone', 'High', 'Major',
     'Characteristic methylated flavone with anti-inflammatory and neuroactive properties.',
     'Scutellaria baicalensis root is defined overwhelmingly by its specialized flavones and their glucuronides, especially baicalin/baicalein and wogonoside/wogonin. This chemistry explains much of its anti-inflammatory and antimicrobial reputation and clearly separates Chinese Skullcap from S. lateriflora.'),
    ('Oroxylin A', 'Flavonoid', 'Flavone', 'Moderate', 'Major',
     'Root-characteristic methylated flavone contributing anti-inflammatory and neuropharmacological activity.',
     'Scutellaria baicalensis root is defined overwhelmingly by its specialized flavones and their glucuronides, especially baicalin/baicalein and wogonoside/wogonin. This chemistry explains much of its anti-inflammatory and antimicrobial reputation and clearly separates Chinese Skullcap from S. lateriflora.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Chinese Skullcap constituent_profiles loaded';
END $$;

-- ============================================================
-- Comfrey leaf — Symphytum officinale, Leaf — id 1650
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 1650;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Comfrey', 'Symphytum officinale', 'Leaf', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Allantoin', 'Nitrogenous compound', 'Ureide', 'High', 'Marker',
     'Promotes epithelial repair and granulation, central to comfrey''s vulnerary reputation.',
     'Symphytum officinale leaf combines the tissue-repair constituents allantoin and rosmarinic acid with a clinically important pyrrolizidine alkaloid fraction. Including the PAs is essential even though they do not explain the desired vulnerary action, because they materially define the safety profile and distinguish comfrey chemistry from superficially similar wound-healing herbs.'),
    ('Rosmarinic acid', 'Polyphenol', 'Depside', 'High', 'Major',
     'Major phenolic contributing anti-inflammatory and antioxidant activity.',
     'Symphytum officinale leaf combines the tissue-repair constituents allantoin and rosmarinic acid with a clinically important pyrrolizidine alkaloid fraction. Including the PAs is essential even though they do not explain the desired vulnerary action, because they materially define the safety profile and distinguish comfrey chemistry from superficially similar wound-healing herbs.'),
    ('Intermedine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Moderate', 'Major',
     'Pyrrolizidine alkaloid relevant primarily to the leaf''s hepatotoxicological profile.',
     'Symphytum officinale leaf combines the tissue-repair constituents allantoin and rosmarinic acid with a clinically important pyrrolizidine alkaloid fraction. Including the PAs is essential even though they do not explain the desired vulnerary action, because they materially define the safety profile and distinguish comfrey chemistry from superficially similar wound-healing herbs.'),
    ('Lycopsamine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Moderate', 'Major',
     'Characteristic pyrrolizidine alkaloid and important safety constituent.',
     'Symphytum officinale leaf combines the tissue-repair constituents allantoin and rosmarinic acid with a clinically important pyrrolizidine alkaloid fraction. Including the PAs is essential even though they do not explain the desired vulnerary action, because they materially define the safety profile and distinguish comfrey chemistry from superficially similar wound-healing herbs.'),
    ('Symphytine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Moderate', 'Present',
     'Comfrey-associated pyrrolizidine alkaloid relevant to safety assessment.',
     'Symphytum officinale leaf combines the tissue-repair constituents allantoin and rosmarinic acid with a clinically important pyrrolizidine alkaloid fraction. Including the PAs is essential even though they do not explain the desired vulnerary action, because they materially define the safety profile and distinguish comfrey chemistry from superficially similar wound-healing herbs.'),
    ('Echimidine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Low–Moderate', 'Present',
     'Hepatotoxic pyrrolizidine alkaloid reported in leaf material.',
     'Symphytum officinale leaf combines the tissue-repair constituents allantoin and rosmarinic acid with a clinically important pyrrolizidine alkaloid fraction. Including the PAs is essential even though they do not explain the desired vulnerary action, because they materially define the safety profile and distinguish comfrey chemistry from superficially similar wound-healing herbs.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Comfrey leaf constituent_profiles loaded';
END $$;

-- ============================================================
-- Mulberry Leaf — Morus alba, Leaf — id 2338
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 2338;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Mulberry Leaf', 'Morus alba', 'Leaf', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('1-Deoxynojirimycin', 'Alkaloid', 'Piperidine alkaloid', 'High', 'Marker',
     'Characteristic iminosugar responsible for potent intestinal α-glucosidase inhibition.',
     'Morus alba leaf is distinguished by the unusual iminosugar DNJ, whose α-glucosidase inhibition strongly underlies the herb''s reputation for postprandial glucose control. Chlorogenic acid and flavonol glycosides provide a substantial complementary antioxidant fraction.'),
    ('Chlorogenic acid', 'Polyphenol', 'Caffeoylquinic acid', 'High', 'Major',
     'Major phenolic contributing antioxidant and glucose-modulating activity.',
     'Morus alba leaf is distinguished by the unusual iminosugar DNJ, whose α-glucosidase inhibition strongly underlies the herb''s reputation for postprandial glucose control. Chlorogenic acid and flavonol glycosides provide a substantial complementary antioxidant fraction.'),
    ('Rutin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Major flavonoid contributing antioxidant and vascular effects.',
     'Morus alba leaf is distinguished by the unusual iminosugar DNJ, whose α-glucosidase inhibition strongly underlies the herb''s reputation for postprandial glucose control. Chlorogenic acid and flavonol glycosides provide a substantial complementary antioxidant fraction.'),
    ('Isoquercitrin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Characteristic quercetin glycoside contributing antioxidant activity.',
     'Morus alba leaf is distinguished by the unusual iminosugar DNJ, whose α-glucosidase inhibition strongly underlies the herb''s reputation for postprandial glucose control. Chlorogenic acid and flavonol glycosides provide a substantial complementary antioxidant fraction.'),
    ('Astragalin', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Present',
     'Kaempferol glycoside complementing the characteristic leaf flavonoid fraction.',
     'Morus alba leaf is distinguished by the unusual iminosugar DNJ, whose α-glucosidase inhibition strongly underlies the herb''s reputation for postprandial glucose control. Chlorogenic acid and flavonol glycosides provide a substantial complementary antioxidant fraction.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Mulberry Leaf constituent_profiles loaded';
END $$;

-- ============================================================
-- Oat (colloidal) — Avena sativa, Grain — id 2288
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 2288;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Oat', 'Avena sativa', 'Grain', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Avenanthramide A', 'Polyphenol', 'Phenolic amide', 'High', 'Marker',
     'Oat-specific phenolic amide contributing anti-inflammatory, antipruritic, and antioxidant activity.',
     'Colloidal Avena sativa is best represented by avenanthramides and β-glucan, which explain its unusually strong topical anti-inflammatory, antipruritic, barrier-supportive, and water-binding effects. Generic starches, proteins, and fatty acids are abundant in oatmeal but were omitted because they are less useful for medicinal constituent matching.'),
    ('Avenanthramide B', 'Polyphenol', 'Phenolic amide', 'High', 'Marker',
     'Characteristic avenanthramide contributing suppression of inflammatory signaling and itch.',
     'Colloidal Avena sativa is best represented by avenanthramides and β-glucan, which explain its unusually strong topical anti-inflammatory, antipruritic, barrier-supportive, and water-binding effects. Generic starches, proteins, and fatty acids are abundant in oatmeal but were omitted because they are less useful for medicinal constituent matching.'),
    ('Avenanthramide C', 'Polyphenol', 'Phenolic amide', 'High', 'Major',
     'Oat-specific antioxidant complementing the principal avenanthramide fraction.',
     'Colloidal Avena sativa is best represented by avenanthramides and β-glucan, which explain its unusually strong topical anti-inflammatory, antipruritic, barrier-supportive, and water-binding effects. Generic starches, proteins, and fatty acids are abundant in oatmeal but were omitted because they are less useful for medicinal constituent matching.'),
    ('β-Glucan', 'Polysaccharide', 'β-Glucan', 'High', 'Major',
     'Water-binding polysaccharide supporting barrier formation, hydration, and skin soothing.',
     'Colloidal Avena sativa is best represented by avenanthramides and β-glucan, which explain its unusually strong topical anti-inflammatory, antipruritic, barrier-supportive, and water-binding effects. Generic starches, proteins, and fatty acids are abundant in oatmeal but were omitted because they are less useful for medicinal constituent matching.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Oat (colloidal) constituent_profiles loaded';
END $$;

-- ============================================================
-- Peyote — Lophophora williamsii, Aerial stem — id 2350
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 2350;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Peyote', 'Lophophora williamsii', 'Aerial stem', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Mescaline', 'Alkaloid', 'Phenethylamine alkaloid', 'High', 'Marker',
     'Principal psychoactive alkaloid responsible for serotonergic psychedelic activity.',
     'Lophophora williamsii is defined almost entirely by its phenethylamine and tetrahydroisoquinoline alkaloids, with mescaline accounting for its characteristic psychedelic activity. Pellotine and the related isoquinolines provide the species with a broader CNS-active alkaloid signature.'),
    ('Pellotine', 'Alkaloid', 'Tetrahydroisoquinoline alkaloid', 'High', 'Major',
     'Major peyote alkaloid with sedative and CNS-active properties.',
     'Lophophora williamsii is defined almost entirely by its phenethylamine and tetrahydroisoquinoline alkaloids, with mescaline accounting for its characteristic psychedelic activity. Pellotine and the related isoquinolines provide the species with a broader CNS-active alkaloid signature.'),
    ('Anhalonidine', 'Alkaloid', 'Tetrahydroisoquinoline alkaloid', 'Moderate', 'Major',
     'Characteristic peyote alkaloid accompanying mescaline and pellotine.',
     'Lophophora williamsii is defined almost entirely by its phenethylamine and tetrahydroisoquinoline alkaloids, with mescaline accounting for its characteristic psychedelic activity. Pellotine and the related isoquinolines provide the species with a broader CNS-active alkaloid signature.'),
    ('Anhalonine', 'Alkaloid', 'Tetrahydroisoquinoline alkaloid', 'Moderate', 'Major',
     'Characteristic isoquinoline alkaloid contributing to the species-specific alkaloid profile.',
     'Lophophora williamsii is defined almost entirely by its phenethylamine and tetrahydroisoquinoline alkaloids, with mescaline accounting for its characteristic psychedelic activity. Pellotine and the related isoquinolines provide the species with a broader CNS-active alkaloid signature.'),
    ('Lophophorine', 'Alkaloid', 'Tetrahydroisoquinoline alkaloid', 'Moderate', 'Major',
     'Species-characteristic CNS-active alkaloid.',
     'Lophophora williamsii is defined almost entirely by its phenethylamine and tetrahydroisoquinoline alkaloids, with mescaline accounting for its characteristic psychedelic activity. Pellotine and the related isoquinolines provide the species with a broader CNS-active alkaloid signature.'),
    ('Hordenine', 'Alkaloid', 'Phenethylamine alkaloid', 'Low–Moderate', 'Present',
     'Minor phenethylamine complementing the dominant mescaline chemistry.',
     'Lophophora williamsii is defined almost entirely by its phenethylamine and tetrahydroisoquinoline alkaloids, with mescaline accounting for its characteristic psychedelic activity. Pellotine and the related isoquinolines provide the species with a broader CNS-active alkaloid signature.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Peyote constituent_profiles loaded';
END $$;

-- ============================================================
-- Ragwort — Senecio jacobaea (syn. Jacobaea vulgaris), Aerial parts — id 1855
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 1855;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Ragwort', 'Senecio jacobaea', 'Aerial parts', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Jacobine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'High', 'Marker',
     'Characteristic hepatotoxic PA defining the jacobine chemotype.',
     'Ragwort is defined overwhelmingly by its 1,2-unsaturated pyrrolizidine alkaloids, which account for its hepatotoxic and genotoxic reputation rather than a therapeutic action. Chemotype variation is substantial, so the profile includes jacobine-, erucifoline-, and senecionine-related representatives rather than implying one fixed alkaloid ratio.'),
    ('Senecionine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'High', 'Major',
     'Major hepatotoxic PA shared across important ragwort chemotypes.',
     'Ragwort is defined overwhelmingly by its 1,2-unsaturated pyrrolizidine alkaloids, which account for its hepatotoxic and genotoxic reputation rather than a therapeutic action. Chemotype variation is substantial, so the profile includes jacobine-, erucifoline-, and senecionine-related representatives rather than implying one fixed alkaloid ratio.'),
    ('Erucifoline', 'Alkaloid', 'Pyrrolizidine alkaloid', 'High', 'Marker',
     'Defines an important alternative chemotype within the species.',
     'Ragwort is defined overwhelmingly by its 1,2-unsaturated pyrrolizidine alkaloids, which account for its hepatotoxic and genotoxic reputation rather than a therapeutic action. Chemotype variation is substantial, so the profile includes jacobine-, erucifoline-, and senecionine-related representatives rather than implying one fixed alkaloid ratio.'),
    ('Seneciphylline', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Moderate', 'Major',
     'Characteristic unsaturated PA contributing to hepatotoxicity.',
     'Ragwort is defined overwhelmingly by its 1,2-unsaturated pyrrolizidine alkaloids, which account for its hepatotoxic and genotoxic reputation rather than a therapeutic action. Chemotype variation is substantial, so the profile includes jacobine-, erucifoline-, and senecionine-related representatives rather than implying one fixed alkaloid ratio.'),
    ('Jacoline', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Moderate', 'Major',
     'Species-characteristic PA reinforcing the jacobine-related profile.',
     'Ragwort is defined overwhelmingly by its 1,2-unsaturated pyrrolizidine alkaloids, which account for its hepatotoxic and genotoxic reputation rather than a therapeutic action. Chemotype variation is substantial, so the profile includes jacobine-, erucifoline-, and senecionine-related representatives rather than implying one fixed alkaloid ratio.'),
    ('Jacozine', 'Alkaloid', 'Pyrrolizidine alkaloid', 'Moderate', 'Present',
     'Characteristic PA contributing to the complex toxic alkaloid fraction.',
     'Ragwort is defined overwhelmingly by its 1,2-unsaturated pyrrolizidine alkaloids, which account for its hepatotoxic and genotoxic reputation rather than a therapeutic action. Chemotype variation is substantial, so the profile includes jacobine-, erucifoline-, and senecionine-related representatives rather than implying one fixed alkaloid ratio.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Ragwort constituent_profiles loaded';
END $$;

-- ============================================================
-- Spinach — Spinacia oleracea, Leaf — id 2352
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 2352;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'Spinach', 'Spinacia oleracea', 'Leaf', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Patuletin 3-gentiobioside', 'Flavonoid', 'Flavonol glycoside', 'High', 'Marker',
     'Characteristic patuletin glycoside representing one of the dominant spinach flavonoid families.',
     'Spinacia oleracea leaf is better characterized phytochemically by its unusual patuletin and spinacetin glycosides than by ubiquitous nutrients or oxalate. These methoxylated flavonol derivatives provide a surprisingly distinctive antioxidant profile and are much more useful for constituent-based matching than vitamins, minerals, or common phenolic acids.'),
    ('Spinacetin 3-gentiobioside', 'Flavonoid', 'Flavonol glycoside', 'High', 'Marker',
     'Characteristic spinacetin glycoside contributing antioxidant activity.',
     'Spinacia oleracea leaf is better characterized phytochemically by its unusual patuletin and spinacetin glycosides than by ubiquitous nutrients or oxalate. These methoxylated flavonol derivatives provide a surprisingly distinctive antioxidant profile and are much more useful for constituent-based matching than vitamins, minerals, or common phenolic acids.'),
    ('Spinacetin 3-glucoside', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Representative member of the distinctive spinacetin glycoside fraction.',
     'Spinacia oleracea leaf is better characterized phytochemically by its unusual patuletin and spinacetin glycosides than by ubiquitous nutrients or oxalate. These methoxylated flavonol derivatives provide a surprisingly distinctive antioxidant profile and are much more useful for constituent-based matching than vitamins, minerals, or common phenolic acids.'),
    ('Jaceidin 4''-glucuronide', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Characteristic methoxylated flavonol glucuronide of spinach leaves.',
     'Spinacia oleracea leaf is better characterized phytochemically by its unusual patuletin and spinacetin glycosides than by ubiquitous nutrients or oxalate. These methoxylated flavonol derivatives provide a surprisingly distinctive antioxidant profile and are much more useful for constituent-based matching than vitamins, minerals, or common phenolic acids.'),
    ('Patuletin 3-glucosyl-(1→6)-[apiosyl-(1→2)]-glucoside', 'Flavonoid', 'Flavonol glycoside', 'Moderate', 'Major',
     'Distinctive complex patuletin glycoside contributing to spinach''s diagnostic flavonoid profile.',
     'Spinacia oleracea leaf is better characterized phytochemically by its unusual patuletin and spinacetin glycosides than by ubiquitous nutrients or oxalate. These methoxylated flavonol derivatives provide a surprisingly distinctive antioxidant profile and are much more useful for constituent-based matching than vitamins, minerals, or common phenolic acids.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'Spinach constituent_profiles loaded';
END $$;

-- ============================================================
-- White Mustard — Sinapis alba (DB latin: Brassica alba), Seed — id 1861
-- ============================================================
DO $$
DECLARE v_id CONSTANT INTEGER := 1861;
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part, constituent, class, subclass, importance, status, notes, editorial_note)
  SELECT v_id, 'White Mustard', 'Brassica alba', 'Seed', t.constituent, t.class, t.subclass, t.importance, t.status, t.notes, t.editorial_note
  FROM (VALUES
    ('Sinalbin', 'Glycoside', 'Glucosinolate', 'High', 'Marker',
     'Dominant aromatic glucosinolate responsible for the characteristic pungency generated when the seed is hydrated.',
     'Sinapis alba seed is chemically defined primarily by sinalbin, providing a clean contrast with the sinigrin-dominated chemistry of black mustard. Because its pungent isothiocyanate is generated enzymatically after tissue disruption, the native glucosinolate is retained as the representative database constituent rather than filling the profile with processing products.')
  ) AS t(constituent, class, subclass, importance, status, notes, editorial_note)
  WHERE NOT EXISTS (
    SELECT 1 FROM herbal.constituent_profiles
    WHERE herb_id = v_id AND constituent = t.constituent
  );
  RAISE NOTICE 'White Mustard constituent_profiles loaded';
END $$;
