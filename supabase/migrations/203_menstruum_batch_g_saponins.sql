-- Batch G: saponin-dominant herbs (20 DB records / 19 herbs)
-- Rule: 40–60% alcohol for triterpenoid saponins; 50–65% for steroidal saponins
-- (more lipophilic spirostanol/furostanol aglycones require higher alcohol).
-- Saponin glycosides are amphipathic (surfactant) so water extracts the polar glycoside
-- fraction, but the sapogenin aglycone fraction needs moderate-to-high alcohol.
-- 15 herbs via set_menstruum; 5 plant-part-specific or shared-latin-name entries
-- via direct INSERT: both Oplopanax elatus (shared latin name), Bupleurum chinense root,
-- Gymnema leaf, Yucca root.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Bupleurum (Bupleurum falcatum):
  -- Saikosaponins a, b2, c, d (oleanane-type triterpenoid saponins)
  -- Saikosaponins are moderately polar; 45–65% for reliable extraction
  PERFORM herbal.set_menstruum(
    'Bupleurum falcatum', 45, 65, NULL, NULL, true,
    '45–65% alcohol or water decoction',
    'Saikosaponins a, b2, c, and d (oleanane-type triterpenoid saponins) are the primary actives. Moderately polar; water decoction is the traditional TCM preparation but 45–65% alcohol more fully extracts the sapogenin-enriched fraction. Higher end of range recommended for maximum saikosaponin yield.',
    false
  );

  -- False Solomon''s Seal (Smilacina racemosa):
  -- Steroidal saponins, steroidal alkaloids, flavonoids, mucilage
  -- Steroidal saponins require moderate-to-high alcohol for full extraction
  PERFORM herbal.set_menstruum(
    'Smilacina racemosa', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Contains steroidal saponins alongside flavonoids and mucilage. Steroidal saponin aglycones are lipophilic and require moderate-to-high alcohol (50–65%); the glycoside and mucilage fractions are water-extractable. Root is the primary medicinal part.',
    false
  );

  -- Hydrangea (Hydrangea arborescens):
  -- Hydrangin (coumarin), saponins, resins, flavonoids
  -- Coumarins and saponins both extract well in 40–60% alcohol
  PERFORM herbal.set_menstruum(
    'Hydrangea arborescens', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Contains hydrangin (coumarin), saponins, and resins. Coumarins and saponin glycosides extract well in 40–60% alcohol; the higher range improves resin extraction. Water decoction also used traditionally. Root and rhizome are the medicinal parts.',
    false
  );

  -- Japanese Angelica Tree (Aralia elata):
  -- Araliosides I–VII (oleanane-type triterpenoid saponins), diterpene glycosides, flavonoids
  PERFORM herbal.set_menstruum(
    'Aralia elata', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Araliosides I–VII (oleanane-type triterpenoid saponins) and diterpene glycosides are the primary actives. Triterpenoid saponin glycosides are amphipathic and extractable in water; 40–60% alcohol captures the full saponin and sapogenin fraction. Bark is the medicinal part.',
    false
  );

  -- Manchurian Aralia (Aralia manshurica):
  -- Araliosides (oleanane-type triterpenoid saponins), similar to Aralia elata
  PERFORM herbal.set_menstruum(
    'Aralia manshurica', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Contains araliosides (oleanane-type triterpenoid saponins) similar in profile to Aralia elata and Aralia racemosa. Saponin glycosides extract in both water and 40–60% alcohol; moderate alcohol preferred for full-spectrum extraction. Root bark is the medicinal part.',
    false
  );

  -- Poke Root (Phytolacca americana):
  -- Phytolaccasaponins (oleanane-type triterpenoids), phytolaccine (alkaloid), lectins (pokeweed
  -- mitogens — proteins, extracted only in cold water, NOT in alcohol preparations)
  -- TOXIC: use only in very small doses under expert supervision
  PERFORM herbal.set_menstruum(
    'Phytolacca americana', 40, 60, NULL, NULL, false,
    '40–60% alcohol (homeopathic / drop doses only)',
    'Phytolaccasaponins (oleanane triterpenoids) and phytolaccine (alkaloid) extract in 40–60% alcohol. Pokeweed mitogens (lectins) are water-soluble proteins not captured in alcohol tinctures. TOXIC: therapeutic use only in very small drop doses (1–5 drops) under expert supervision — the root is powerfully toxic; toxic at any substantial dose and potentially lethal in overdose.',
    false
  );

  -- Sakhalin Spikenard (Aralia schmidtii):
  -- Araliosides (oleanane-type triterpenoid saponins), similar to other Aralia spp.
  PERFORM herbal.set_menstruum(
    'Aralia schmidtii', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Contains araliosides (oleanane-type triterpenoid saponins) consistent with the Aralia genus. Saponin glycosides are amphipathic and extractable in water; 40–60% alcohol preferred for full-spectrum extraction including the less-polar sapogenin fraction.',
    false
  );

  -- Sarsaparilla (Smilax spp.):
  -- Steroidal saponins: sarsasaponin (parillin), smilasaponin; sapogenin: sarsasapogenin
  -- Steroidal saponins — more lipophilic aglycones require higher alcohol
  PERFORM herbal.set_menstruum(
    'Smilax spp.', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Steroidal saponins (sarsasaponin/parillin, smilasaponin) and steroidal sapogenin sarsasapogenin are the primary actives. The sapogenin aglycone is lipophilic and requires moderate-to-high alcohol (50–65%); the saponin glycosides are also water-extractable. Root is the medicinal part.',
    false
  );

  -- Seneca Snakeroot (Polygala senega):
  -- Senegasaponins A–D (oleanane-type triterpenoids), presenegin, Z-2-methyl coumarates
  -- Triterpenoid saponins are amphipathic; 40–60% for full extraction
  PERFORM herbal.set_menstruum(
    'Polygala senega', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Senegasaponins A–D (oleanane-type triterpenoid saponins) and Z-2-methyl coumarates are the primary actives. The saponin glycosides are amphipathic and water-extractable; 40–60% alcohol improves extraction of the less-polar sapogenin fraction and coumarin constituents.',
    false
  );

  -- Shatavari (Asparagus racemosus):
  -- Shatavarins I–IV (furostanol-type steroidal saponins), asparagosides, sarsasapogenin
  -- Furostanol steroidal saponins require moderate-high alcohol; sapogenin is lipophilic
  PERFORM herbal.set_menstruum(
    'Asparagus racemosus', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Shatavarins I–IV (furostanol-type steroidal saponins) and asparagosides are the primary actives. Furostanol saponin aglycones are moderately lipophilic and require 50–65% alcohol for full extraction; the glycoside fraction is also water-extractable. Traditionally prepared as a milk decoction (shatavari kalpa) in Ayurveda.',
    false
  );

  -- Silk Tree (Albizia julibrissin):
  -- Julibrosides I–IV (oleanane-type triterpenoid saponins), flavonoids, tannins
  PERFORM herbal.set_menstruum(
    'Albizia julibrissin', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Julibrosides I–IV (oleanane-type triterpenoid saponins) alongside flavonoids and tannins. Triterpenoid saponin glycosides are amphipathic and extractable in water; 40–60% alcohol preferred for the full saponin and flavonoid complement. Bark is the primary medicinal part in TCM (He Huan Pi).',
    false
  );

  -- Solomon''s Seal (Polygonatum biflorum):
  -- Steroidal saponins (polygonatoside), flavonoid glycosides, mucilage, allantoin
  -- Mixed polar profile; 40–60% covers saponin and mucilage fractions
  PERFORM herbal.set_menstruum(
    'Polygonatum biflorum', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Contains steroidal saponins (polygonatoside), flavonoid glycosides, mucilage, and allantoin. Water decoction extracts the mucilage and polar glycoside fraction; 40–60% alcohol also captures the steroidal saponin and less-polar flavonoid aglycones. Root is the medicinal part.',
    false
  );

  -- Spikenard (Aralia racemosa):
  -- Triterpenoid saponins (aralioside-type), diterpenes, resins, volatile oils
  PERFORM herbal.set_menstruum(
    'Aralia racemosa', 40, 65, NULL, NULL, true,
    '40–65% alcohol or water decoction',
    'Contains triterpenoid saponins (aralioside-type), diterpenes, resins, and volatile oils. The saponin glycosides are amphipathic; 40–65% alcohol captures the full saponin, diterpene, and resin fraction. Root and rhizome are the medicinal parts.',
    false
  );

  -- Wild Yam (Dioscorea villosa):
  -- Steroidal saponins: dioscin, gracillin; sapogenin: diosgenin (lipophilic)
  -- Diosgenin is markedly lipophilic; 50–65% required for meaningful sapogenin extraction
  PERFORM herbal.set_menstruum(
    'Dioscorea villosa', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water decoction',
    'Steroidal saponins (dioscin, gracillin) and the sapogenin diosgenin are the primary actives. Diosgenin is markedly lipophilic (the phytochemical precursor to synthetic steroidal hormones) and requires moderate-to-high alcohol (50–65%) for significant extraction; the saponin glycosides are also water-extractable. Root is the medicinal part.',
    false
  );

  -- Wu Jia Pi (Acanthopanax sessiliflorum):
  -- Acanthosides (triterpenoid saponins), syringin (phenylpropanoid), sesamine (lignan)
  -- Triterpenoid saponins and phenylpropanoids extract well in 40–60%
  PERFORM herbal.set_menstruum(
    'Acanthopanax sessiliflorum', 40, 60, NULL, NULL, true,
    '40–60% alcohol or water decoction',
    'Contains acanthosides (triterpenoid saponins), syringin (phenylpropanoid), and sesamine (lignan). Saponin glycosides and phenylpropanoids are amphipathic and water-extractable; 40–60% alcohol preferred for full-spectrum extraction including the lignan fraction. Root bark is the medicinal part (Wu Jia Pi in TCM).',
    false
  );

  RAISE NOTICE 'Batch G (saponin-dominant herbs — set_menstruum): 15 records inserted/updated.';
END $$;

-- ── Direct INSERTs ──
-- Oplopanax elatus entries share a latin name (two plant parts) → both must use herb_id.
-- Bupleurum chinense root, Gymnema leaf, and Yucca root use direct INSERT for plant-part clarity.

-- Asian Devil's Club root bark (Oplopanax elatus, herb_id 2226):
-- Polyynes (falcarinol-type), triterpenoid saponins, volatile compounds
-- Root bark is the most concentrated medicinal part; 40–60% alcohol
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2226, 40, 60, true,
  '40–60% alcohol or water decoction',
  'Root bark contains polyynes (falcarinol-type cytotoxic compounds), triterpenoid saponins, and volatile constituents. The saponin and polyyne fractions require 40–60% alcohol for full extraction; water decoction is less complete but traditionally used. Root bark is the most potent medicinal part — more concentrated than stem bark.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Asian Devil's Club bark (Oplopanax elatus, herb_id 8):
-- Same species; stem bark used similarly but generally considered less potent than root bark
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  8, 40, 60, true,
  '40–60% alcohol or water decoction',
  'Stem bark contains polyynes (falcarinol-type), triterpenoid saponins, and volatile constituents, mirroring the root bark profile but at lower concentration. The saponin and polyyne fractions require 40–60% alcohol; water decoction is the traditional preparation. Root bark (herb_id 2226) is generally preferred medicinally.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Bupleurum chinense root (Bupleurum chinense, herb_id 2247):
-- Saikosaponins a, b2, c, d — same primary constituents as Bupleurum falcatum
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2247, 45, 65, true,
  '45–65% alcohol or water decoction',
  'Saikosaponins a, b2, c, and d (oleanane-type triterpenoid saponins) are the primary actives, identical in class to Bupleurum falcatum. Water decoction is the traditional TCM preparation (Chai Hu); 45–65% alcohol more fully extracts the sapogenin-enriched fraction. Root is the sole medicinal part.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Gymnema leaf (Gymnema sylvestre, herb_id 2232):
-- Gymnemic acids I–VII (oleanane-type triterpenoid saponins), gymnemosides (saponins)
-- Gymnemic acids are triterpenic saponin acids — moderately polar; 40–60%
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2232, 40, 60, true,
  '40–60% alcohol or water decoction',
  'Gymnemic acids I–VII (oleanane-type triterpenoid saponins) are the primary actives responsible for sweet-taste suppression and glucose-transport modulation. Moderately polar; 40–60% alcohol extracts the full gymnemic acid and gymnenoside complement. Water decoction is also used traditionally.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;

-- Yucca root (Yucca spp., herb_id 2244):
-- Steroidal saponins: yuccaols (phenolic saponins), sarsasaponin; sapogenin: sarsasapogenin
-- Steroidal saponins — lipophilic aglycones require higher alcohol
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2244, 50, 65, true,
  '50–65% alcohol or water decoction',
  'Root contains steroidal saponins (yuccaols, sarsasaponin) with steroidal sapogenin sarsasapogenin. The sapogenin aglycone is lipophilic and requires moderate-to-high alcohol (50–65%) for significant extraction; saponin glycosides are also water-extractable. Root is the medicinal part; traditionally used by indigenous peoples as a soap plant.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;
