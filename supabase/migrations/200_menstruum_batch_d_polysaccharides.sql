-- Batch D: polysaccharide / mucilage / seaweed herbs (14 herbs)
-- Rule: water decoction is effective or primary; use dual extraction (alcohol + water)
-- when the herb also contains saponins, depsides/depsidones, or lipophilic lignans.
-- Three seaweed Kelp entries (different species / plant parts) use direct INSERT
-- to avoid any ambiguity; all others use set_menstruum.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Panax quinquefolius (American Ginseng):
  -- Polysaccharides (immune-modulating) need water; triterpenoid saponins (ginsenosides)
  -- + polyacetylenes need moderate alcohol → dual extraction
  PERFORM herbal.set_menstruum(
    'Panax quinquefolius', 40, 60, NULL, NULL, true,
    'dual extraction: 40–60% alcohol + water decoction',
    'Triterpenoid ginsenosides and polyacetylenes require moderate alcohol; polysaccharides require hot water decoction. Dual extraction recommended for full-spectrum activity. Extraction profile mirrors Panax ginseng.',
    false
  );

  -- Codonopsis pilosula: polysaccharides + polyacetylenes + fructo-oligosaccharides
  -- Polyacetylenes need some alcohol; polysaccharides need water
  PERFORM herbal.set_menstruum(
    'Codonopsis pilosula', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water decoction',
    'Polysaccharides and fructo-oligosaccharides extract in water decoction; polyacetylenes require low-moderate alcohol. Water decoction is the traditional TCM preparation.',
    false
  );

  -- Tussilago farfara (Coltsfoot):
  -- Polysaccharides (mucilage) + flavonol glycosides + hydroxycinnamic acids
  -- Water extraction is the classic preparation; some alcohol for flavonoid concentration
  PERFORM herbal.set_menstruum(
    'Tussilago farfara', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Polysaccharides (mucilage) extract in water; flavonol glycosides and hydroxycinnamic acids also water-extractable. Low-moderate alcohol concentrates the flavonoid fraction. Leaf infusion is the traditional preparation.',
    false
  );

  -- Symphytum officinale (Comfrey, leaf):
  -- Polysaccharides (allantoin-rich mucilage) + rosmarinic acid (hydroxycinnamic acid)
  -- Note: contains pyrrolizidine alkaloids — leaf < root, but both are cautionary
  PERFORM herbal.set_menstruum(
    'Symphytum officinale', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Allantoin and polysaccharides extract in water; rosmarinic acid (hydroxycinnamic acid) also water-extractable. Low-moderate alcohol used for fuller flavonoid extraction. Leaf preparation preferred over root — contains lower pyrrolizidine alkaloid levels; avoid internal use during pregnancy.',
    false
  );

  -- Linum usitatissimum (Flax):
  -- Mucilage polysaccharides + secoisolariciresinol diglucoside (lignan)
  -- Mucilage is water-extractable; lignan needs low-moderate alcohol
  PERFORM herbal.set_menstruum(
    'Linum usitatissimum', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water infusion',
    'Mucilage polysaccharides extract in cold or warm water; secoisolariciresinol diglucoside (lignan) extracts in low-moderate alcohol. Seeds are often used as whole food rather than tincture; cold-water maceration is the standard aqueous preparation.',
    false
  );

  -- Cetraria islandica (Iceland Moss):
  -- Lichenan / isolichenan (polysaccharides) need water;
  -- fumarprotocetraric acid, usnic acid (depside/depsidone) need moderate alcohol
  -- → dual extraction
  PERFORM herbal.set_menstruum(
    'Cetraria islandica', 25, 40, NULL, NULL, true,
    'dual extraction: 25–40% alcohol + water decoction',
    'Lichenan and isolichenan (polysaccharides) require hot water decoction; fumarprotocetraric acid and usnic acid (depside/depsidone lichen acids) extract in low-moderate alcohol. Dual extraction captures both the immune-modulating polysaccharide and antimicrobial lichen acid fractions.',
    false
  );

  -- Chondrus crispus (Irish Moss):
  -- Carrageenan (sulfated polysaccharide) + phycobiliproteins → water only
  -- High alcohol would precipitate and destroy the polysaccharide structure
  PERFORM herbal.set_menstruum(
    'Chondrus crispus', NULL, NULL, NULL, NULL, true,
    'water decoction or cold infusion',
    'Carrageenan (sulfated polysaccharide) and phycobiliproteins extract in water; high alcohol precipitates and destroys the polysaccharide gel structure. Traditionally prepared as a warm water decoction or cold gel extract.',
    false
  );

  -- Malva sylvestris (Mallow):
  -- Mucilage (polysaccharide) + flavonols + hydroxycinnamic acids
  -- Cold water is best for mucilage (heat partially degrades it); some alcohol for flavonoids
  PERFORM herbal.set_menstruum(
    'Malva sylvestris', 25, 40, NULL, NULL, true,
    'cold water infusion or 25–40% alcohol',
    'Mucilage polysaccharides extract best in cold water (heat partially degrades them); flavonols and hydroxycinnamic acids also extract in water. Low alcohol can be used to concentrate the flavonoid fraction. Cold maceration in water is the preferred traditional preparation.',
    false
  );

  -- Plantago ovata (Psyllium, seed husk):
  -- Primarily mucilage (arabinoxylan polysaccharide) → water only
  -- Not used as an internal tincture; fibre/mucilage function requires aqueous medium
  PERFORM herbal.set_menstruum(
    'Plantago ovata', NULL, NULL, NULL, NULL, true,
    'water (aqueous suspension)',
    'Arabinoxylan mucilage polysaccharides require water to form the gel that provides the therapeutic fibre/demulcent effect. Not used as an alcohol tincture — the mucilage action is only expressed in an aqueous medium.',
    false
  );

  -- Lentinus edodes (Shiitake):
  -- Beta-glucan polysaccharides (lentinan) need water decoction;
  -- phytosterols and lipophilic organosulfur compounds need some alcohol → dual extraction
  PERFORM herbal.set_menstruum(
    'Lentinus edodes', 25, 40, NULL, NULL, true,
    'dual extraction: 25–40% alcohol + water decoction',
    'Beta-glucan polysaccharides (lentinan) require hot water decoction for immune-modulating activity; phytosterols and lipophilic organosulfur compounds extract in low-moderate alcohol. Dual extraction recommended, as for other medicinal mushrooms.',
    false
  );

  -- Usnea spp.:
  -- Usnic acid (depside) + depsidone acids (stictic acid) → 40–60% alcohol
  -- Polysaccharides (usnean) → water decoction → dual extraction
  PERFORM herbal.set_menstruum(
    'Usnea spp.', 40, 60, NULL, NULL, true,
    'dual extraction: 40–60% alcohol + water decoction',
    'Usnic acid (depside) and depsidone acids (stictic acid) extract in moderate alcohol; usnean polysaccharides require hot water decoction. Dual extraction recommended for full-spectrum antimicrobial and immune-modulating activity.',
    false
  );

  RAISE NOTICE 'Batch D (polysaccharide / mucilage / seaweed herbs — set_menstruum): 11 records inserted/updated.';
END $$;

-- ── Direct INSERTs for Kelp species (unique latin names, but explicit herb_ids safer) ──

-- Fucus vesiculosus (Kelp, herb_id 118):
-- Alginates, fucoidan (sulfated polysaccharide) → water only
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  118, true,
  'water decoction',
  'Fucoidan (sulfated polysaccharide), alginates, and phlorotannins extract in water; high alcohol precipitates the polysaccharide fraction. Mineral and iodine content also water-extractable. Traditionally used as a food/decoction.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Laminaria digitata (Kelp — Laminaria, herb_id 2248, thallus):
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  2248, true,
  'water decoction',
  'Laminarin and alginates (polysaccharides) and fucoidan (sulfated polysaccharide) extract in water. Mineral and iodine content also water-extractable. Used primarily as a food or water preparation.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Saccharina latissima (Kelp — Saccharina, herb_id 2249, blade):
INSERT INTO herbal.herb_menstruum
  (herb_id, water_effective, primary_label, notes, needs_review)
VALUES (
  2249, true,
  'water decoction',
  'Laminarin, alginates, and fucoidan (polysaccharides) extract in water. Mineral and iodine content also water-extractable. Used primarily as a food or water preparation.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;
