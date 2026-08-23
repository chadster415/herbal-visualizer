-- Batch E: tannin-dominant herbs (11 herbs)
-- Rule: 25–45% alcohol; water effective for most.
-- Tannins (condensed and hydrolysable) are amphipathic: readily extracted in water
-- and low-moderate alcohol. Higher alcohol (>50%) begins to precipitate protein–tannin
-- complexes and can reduce yield. Water decoction is the traditional preparation for
-- most of these herbs and remains clinically effective.
-- 9 herbs via set_menstruum; 2 plant-part-specific entries via direct INSERT.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Bistort (Polygonum bistorta):
  -- Gallotannins, ellagitannins, mucilage, starch
  -- Water decoction is the traditional preparation; low-moderate alcohol concentrates tannin fraction
  PERFORM herbal.set_menstruum(
    'Polygonum bistorta', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water decoction',
    'Very high in gallotannins and ellagitannins; mucilage also water-soluble. Water decoction is the classical preparation for astringent use; 25–40% alcohol extracts the full tannin fraction without precipitating protein–tannin complexes.',
    false
  );

  -- Black Catechu (Acacia catechu):
  -- Catechin, epicatechin, catechutannic acid (condensed tannins)
  -- Very high condensed tannin content; water and low-moderate alcohol both effective
  PERFORM herbal.set_menstruum(
    'Acacia catechu', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Very high in condensed tannins (catechin, epicatechin, catechutannic acid). Both water decoction and 25–45% alcohol effectively extract the astringent principles. Used traditionally as a water-extracted catechu preparation.',
    false
  );

  -- Butternut (Juglans cinerea):
  -- Juglandin (naphthoquinone-type), tannins, anthraquinone-type cathartics
  -- Juglandin has some lipophilicity; 25–50% covers tannin and the naphthoquinone fraction
  PERFORM herbal.set_menstruum(
    'Juglans cinerea', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water decoction',
    'Contains tannins, juglandin (naphthoquinone-type constituent), and mild anthraquinone-like cathartics. The tannin and cathartic fractions are water-extractable; the upper range (40–50%) improves extraction of the lipophilic juglandin components.',
    false
  );

  -- Cranesbill (Geranium maculatum):
  -- Gallic acid, ellagic acid, hydrolysable tannins (up to ~30% dry weight)
  -- Water very effective; low-moderate alcohol for full tannin extraction
  PERFORM herbal.set_menstruum(
    'Geranium maculatum', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water decoction',
    'One of the highest tannin-content herbs in the Western materia medica, with gallic acid and ellagic acid (hydrolysable tannins) comprising up to ~30% dry weight. Water decoction is highly effective; 25–40% alcohol extracts the full tannin and phenolic acid complement.',
    false
  );

  -- Indian Gooseberry / Amla (Phyllanthus emblica):
  -- Hydrolysable tannins (emblicanin A & B, punigluconin, pedunculagin), vitamin C, flavonoids
  -- High vitamin C is water-soluble; tannins extract well in water and low-moderate alcohol
  PERFORM herbal.set_menstruum(
    'Phyllanthus emblica', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Rich in hydrolysable tannins (emblicanin A & B, punigluconin) and vitamin C. Both water decoction and 25–45% alcohol extract the tannin and polyphenol fraction effectively; vitamin C is water-soluble. Traditionally prepared as fresh juice, decoction, or churna (powder).',
    false
  );

  -- Oak (Quercus spp.):
  -- Bark very high in ellagitannins, gallotannins, condensed tannins
  -- Water decoction is the traditional preparation; low-moderate alcohol for tincture
  PERFORM herbal.set_menstruum(
    'Quercus spp.', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water decoction',
    'Bark very high in ellagitannins and gallotannins. Water decoction is the traditional preparation for astringent topical and internal use; 25–40% alcohol is effective for tincture preparation. Higher alcohol risks precipitation of tannin–protein complexes.',
    false
  );

  -- Rhatany (Krameria triandra):
  -- Rhataniatannin (proanthocyanidins), ratanhiaphenol neolignans
  -- Very high condensed tannin content; neolignan fraction may need slightly higher alcohol
  PERFORM herbal.set_menstruum(
    'Krameria triandra', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Root very high in condensed tannins (rhataniatannin / proanthocyanidins); also contains ratanhiaphenol neolignans. Water and 25–45% alcohol effectively extract the tannin astringent fraction; the upper range improves neolignan extraction.',
    false
  );

  -- Stonebreaker (Phyllanthus amarus):
  -- Lignans (phyllanthin, hypophyllanthin), geraniin (ellagitannin), flavonoids
  -- Lignans need moderate alcohol; tannins and flavonoids also water-extractable
  PERFORM herbal.set_menstruum(
    'Phyllanthus amarus', 30, 50, NULL, NULL, true,
    '30–50% alcohol or water decoction',
    'Contains lignans (phyllanthin, hypophyllanthin) alongside ellagitannin (geraniin) and flavonoids. The lignan fraction requires low-moderate alcohol (30–50%); tannin and flavonoid fractions are also water-extractable. Water decoction is the traditional Ayurvedic preparation.',
    false
  );

  -- Wild Cherry Bark (Prunus serotina):
  -- Prunasin (cyanogenic glycoside), tannins, benzaldehyde (from prunasin hydrolysis)
  -- Cyanogenic glycosides are water-soluble; tannins extract in low-moderate alcohol
  PERFORM herbal.set_menstruum(
    'Prunus serotina', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Prunasin (cyanogenic glycoside) and tannins are the primary actives. Prunasin is water-soluble and extracts readily in both water and alcohol preparations; tannins extract well in 25–40% alcohol. Water preparations may yield higher prunasin content for antitussive use.',
    false
  );

  RAISE NOTICE 'Batch E (tannin-dominant herbs — set_menstruum): 9 records inserted/updated.';
END $$;

-- ── Direct INSERTs for plant-part-specific entries ──

-- Grape Seed (Vitis vinifera, seed, herb_id 2230):
-- OPCs (oligomeric proanthocyanidins), catechins, epicatechin, gallic acid
-- Proanthocyanidins are amphipathic; 40–60% captures the full OPC fraction
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2230, 40, 60, true,
  '40–60% alcohol or water',
  'Very high in OPCs (oligomeric proanthocyanidins), catechins, and epicatechin. While proanthocyanidins are water-extractable, 40–60% alcohol more fully extracts the condensed tannin and gallic acid fraction and improves shelf stability of the OPC-rich extract.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- White Oak (Quercus alba, bark, herb_id 2241):
-- Gallic acid, ellagic acid, ellagitannins, condensed tannins
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2241, 25, 40, true,
  '25–40% alcohol or water decoction',
  'Bark very high in ellagitannins, gallotannins, and condensed tannins. Water decoction is the traditional preparation for astringent internal and topical use; 25–40% alcohol effective for tincture. Higher alcohol risks precipitation of tannin–protein complexes.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;
