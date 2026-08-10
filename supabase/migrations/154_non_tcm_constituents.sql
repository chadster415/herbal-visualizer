SET search_path TO herbal, public;

-- Constituent data for the 11 non-TCM herbs that were missing profiles.
-- All data from fresh literature review (August 2026); conservative profiles
-- following the existing style guide.
--
-- New constituent categories introduced:
--   phenolic lipid, phenolic amide, piperidine alkaloid,
--   tetrahydroisoquinoline alkaloid, phenethylamine alkaloid
-- (polyacetylene, pyrrolizidine alkaloid, flavone glucuronide, flavone,
--  flavonol glycoside, glucosinolate, polysaccharide, hydroxycinnamic acid
--  already existed)
--
-- Pre-existing constituents re-used (no ensure_constituent call needed):
--   allantoin (942), baicalein (1001), baicalin (1000), chlorogenic acid (785),
--   echimidine (982), isoquercitrin (744), rosmarinic acid (783),
--   rutin (742), sinigrin (929), symphytine (981), wogonin (1003)
--
-- Skipped: Asian Devil's Club (id 2226) — already has 5 rows in
--   constituent_profiles (falcarindiol, falcarinol, oplopandiol, oplopantriol
--   A & B) from the CSV import. No herb_constituents rows needed.

-- ============================================================
-- Black Mustard — Brassica nigra, seed — id 1860
-- Defined overwhelmingly by sinigrin (already in DB, id 929).
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1860;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'sinigrin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Dominant glucosinolate and precursor of the pungent rubefacient allyl isothiocyanate on hydration.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Black Mustard (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Cashew — Anacardium occidentale, nut shell — id 2341
-- Defined by long-chain phenolic lipids in cashew nutshell liquid.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2341;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('anacardic acid', 'phenolic lipid',
    'Dominant long-chain phenolic lipid of cashew nutshell liquid with antimicrobial, enzyme-inhibitory, and irritant activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Marker. Dominant phenolic lipid in cashew nutshell liquid.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cardol', 'phenolic lipid',
    'Characteristic resorcinolic lipid of cashew nutshell liquid with antioxidant and antimicrobial activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Characteristic resorcinolic lipid of cashew nutshell liquid.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('cardanol', 'phenolic lipid',
    'Phenolic lipid of cashew nutshell liquid contributing antioxidant activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Characteristic phenolic lipid of cashew nutshell liquid.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('2-methylcardol', 'phenolic lipid',
    'Minor characteristic phenolic lipid complementing the cardol fraction of cashew nutshell liquid');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Minor characteristic phenolic lipid complementing the cardol fraction.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Cashew (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Chinese Skullcap — Scutellaria baicalensis, root — id 2274
-- Defined by specialized root flavones and glucuronides.
-- baicalin (1000) and baicalein (1001) and wogonin (1003) already in DB.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2274;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'baicalin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Principal flavone glucuronide; anti-inflammatory, antiviral, and hepatoprotective.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'baicalein';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Major aglycone contributing anti-inflammatory and antioxidant activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('wogonoside', 'flavone glucuronide',
    'Characteristic root flavone glucuronide of Scutellaria baicalensis; glycoside of wogonin');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Characteristic glucuronide complementing baicalin within the root-specific flavone profile.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'wogonin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Characteristic methylated flavone with anti-inflammatory and neuroactive properties.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('oroxylin A', 'flavone',
    'Root-characteristic methylated flavone of Scutellaria baicalensis with anti-inflammatory and neuropharmacological activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Root-characteristic methylated flavone contributing anti-inflammatory and neuropharmacological activity.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Chinese Skullcap (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Comfrey leaf — Symphytum officinale, leaf — id 1650
-- Combines tissue-repair constituents (allantoin, rosmarinic acid) with PAs.
-- allantoin (942), rosmarinic acid (783), symphytine (981),
-- echimidine (982) already in DB.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1650;
  v_c INTEGER;
BEGIN
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'allantoin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Promotes epithelial repair and granulation; central to comfrey''s vulnerary reputation.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rosmarinic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Major phenolic contributing anti-inflammatory and antioxidant activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('intermedine', 'pyrrolizidine alkaloid',
    'Hepatotoxic 1,2-unsaturated pyrrolizidine alkaloid found in Symphytum officinale leaf');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'PA relevant to the leaf''s hepatotoxicological profile.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('lycopsamine', 'pyrrolizidine alkaloid',
    'Characteristic pyrrolizidine alkaloid and important safety constituent of comfrey');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic PA and important safety constituent.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'symphytine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Comfrey-associated PA relevant to safety assessment.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'echimidine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor',
    'Hepatotoxic PA reported in leaf material.', 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Comfrey leaf (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Mulberry Leaf — Morus alba — id 2338
-- Distinguished by iminosugar DNJ alongside chlorogenic acid and flavonols.
-- chlorogenic acid (785), rutin (742), isoquercitrin (744) already in DB.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2338;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('1-deoxynojirimycin', 'piperidine alkaloid',
    'Characteristic iminosugar of Morus alba leaf responsible for potent intestinal alpha-glucosidase inhibition');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Characteristic iminosugar; potent alpha-glucosidase inhibitor underlying postprandial glucose control.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'chlorogenic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Major phenolic contributing antioxidant and glucose-modulating activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rutin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Major flavonoid contributing antioxidant and vascular effects.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'isoquercitrin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic quercetin glycoside contributing antioxidant activity.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('astragalin', 'flavonol glycoside',
    'Kaempferol 3-O-glucoside; contributes to the leaf flavonoid fraction of Morus alba and other herbs');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Kaempferol glycoside complementing the characteristic leaf flavonoid fraction.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Mulberry Leaf (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Oat colloidal — Avena sativa, colloidal — id 2288
-- Defined by avenanthramides and beta-glucan for topical anti-inflammatory action.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2288;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('avenanthramide A', 'phenolic amide',
    'Oat-specific phenolic amide (2-p-coumaroylanthranilic acid) with anti-inflammatory, antipruritic, and antioxidant activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Oat-specific phenolic amide; anti-inflammatory, antipruritic, antioxidant.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('avenanthramide B', 'phenolic amide',
    'Oat-specific phenolic amide (2-feruloylanthranilic acid) contributing suppression of inflammatory signaling and itch');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Characteristic avenanthramide; suppresses inflammatory signaling and itch.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('avenanthramide C', 'phenolic amide',
    'Oat-specific antioxidant phenolic amide (2-caffeoylanthranilic acid) complementing A and B fractions');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Oat-specific antioxidant complementing the principal avenanthramide fraction.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('beta-glucan', 'polysaccharide',
    'Mixed-linkage (1->3)(1->4)-beta-D-glucan; water-binding polysaccharide supporting barrier formation, hydration, and skin soothing');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Water-binding polysaccharide supporting barrier formation and skin hydration.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Oat colloidal (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Peyote — Lophophora williamsii, aerial stem — id 2350
-- Defined by phenethylamine and tetrahydroisoquinoline alkaloids.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2350;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('mescaline', 'phenethylamine alkaloid',
    'Principal psychoactive alkaloid of Lophophora williamsii; acts via serotonin 5-HT2A receptor agonism');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Principal psychoactive alkaloid; serotonergic psychedelic.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('pellotine', 'tetrahydroisoquinoline alkaloid',
    'Major peyote tetrahydroisoquinoline alkaloid with sedative and CNS-active properties');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Major peyote alkaloid; sedative and CNS-active.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('anhalonidine', 'tetrahydroisoquinoline alkaloid',
    'Characteristic peyote tetrahydroisoquinoline alkaloid accompanying mescaline and pellotine');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic peyote alkaloid accompanying mescaline and pellotine.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('anhalonine', 'tetrahydroisoquinoline alkaloid',
    'Characteristic isoquinoline alkaloid contributing to the species-specific alkaloid profile of peyote');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic isoquinoline alkaloid of peyote.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('lophophorine', 'tetrahydroisoquinoline alkaloid',
    'Species-characteristic CNS-active alkaloid of Lophophora williamsii');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Species-characteristic CNS-active alkaloid.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('hordenine', 'phenethylamine alkaloid',
    'Minor phenethylamine alkaloid found in peyote and various other plants; sympathomimetic activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor',
    'Minor phenethylamine complementing the dominant mescaline chemistry.', 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Peyote (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Ragwort — Senecio jacobaea (syn. Jacobaea vulgaris) — id 1855
-- Defined by 1,2-unsaturated PAs; chemotype variation is substantial so
-- both jacobine- and erucifoline-chemotype markers are included.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1855;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('jacobine', 'pyrrolizidine alkaloid',
    'Characteristic hepatotoxic 1,2-unsaturated PA defining the jacobine chemotype of Jacobaea vulgaris');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Characteristic hepatotoxic PA defining the jacobine chemotype.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('senecionine', 'pyrrolizidine alkaloid',
    'Major hepatotoxic 1,2-unsaturated PA shared across multiple Jacobaea chemotypes');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Major hepatotoxic PA shared across important ragwort chemotypes.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('erucifoline', 'pyrrolizidine alkaloid',
    'Characteristic PA defining an important alternative chemotype within Jacobaea vulgaris');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Defines an important alternative chemotype within the species.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('seneciphylline', 'pyrrolizidine alkaloid',
    'Characteristic unsaturated PA contributing to hepatotoxicity in Jacobaea vulgaris');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic unsaturated PA contributing to hepatotoxicity.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('jacoline', 'pyrrolizidine alkaloid',
    'Species-characteristic PA reinforcing the jacobine-related alkaloid profile of ragwort');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Species-characteristic PA reinforcing the jacobine-related profile.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('jacozine', 'pyrrolizidine alkaloid',
    'Characteristic PA contributing to the complex toxic alkaloid fraction of Jacobaea vulgaris');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic PA contributing to the complex toxic alkaloid fraction.', 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Ragwort (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- Spinach — Spinacia oleracea, leaf — id 2352
-- Distinguished by patuletin and spinacetin glycosides rather than
-- ubiquitous nutrients; provides better constituent-based matching.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2352;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('patuletin 3-gentiobioside', 'flavonol glycoside',
    'Characteristic methoxylated flavonol glycoside representing the dominant patuletin family in Spinacia oleracea leaf');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Characteristic patuletin glycoside; representative of the dominant spinach flavonoid family.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('spinacetin 3-gentiobioside', 'flavonol glycoside',
    'Characteristic spinacetin glycoside contributing antioxidant activity in Spinacia oleracea leaf');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Characteristic spinacetin glycoside contributing antioxidant activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('spinacetin 3-glucoside', 'flavonol glycoside',
    'Representative member of the distinctive spinacetin glycoside fraction of spinach leaf');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Representative member of the distinctive spinacetin glycoside fraction.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('jaceidin 4''-glucuronide', 'flavonol glycoside',
    'Characteristic methoxylated flavonol glucuronide of spinach leaves');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Characteristic methoxylated flavonol glucuronide of spinach leaves.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  v_c := herbal.ensure_constituent('patuletin 3-glucosyl-(1-6)-[apiosyl-(1-2)]-glucoside', 'flavonol glycoside',
    'Distinctive complex patuletin glycoside contributing to the diagnostic flavonoid profile of spinach leaf');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate',
    'Distinctive complex patuletin glycoside in the diagnostic spinach flavonoid profile.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Spinach (id %) constituents loaded', v_herb_id;
END $$;

-- ============================================================
-- White Mustard — Sinapis alba (DB: Brassica alba) — id 1861
-- Defined by sinalbin, in clean contrast to sinigrin-dominated black mustard.
-- ============================================================
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 1861;
  v_c INTEGER;
BEGIN
  v_c := herbal.ensure_constituent('sinalbin', 'glucosinolate',
    'Dominant aromatic glucosinolate of Sinapis alba seed; generates p-hydroxybenzyl isothiocyanate on tissue disruption');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Marker. Dominant glucosinolate; clean contrast with sinigrin-dominated black mustard.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'White Mustard (id %) constituents loaded', v_herb_id;
END $$;
