-- Migration 189: Add herb_constituents for batch 10 (final batch)
-- Herbs: Bupleurum chinense, Eucommia ulmoides, Laminaria digitata,
--        Saccharina latissima, Euonymus atropurpureus, Yucca spp., Albizia julibrissin
-- Uses herbal.ensure_constituent(name, category, description) and
--      herbal.link_constituent(latin_name, constituent_name, level, sort_order)
-- link_constituent is ON CONFLICT DO NOTHING (silent no-op if herb or link not found)

SET search_path TO herbal, public;

DO $$
BEGIN

-- ============================================================
-- BLOCK 1: Bupleurum chinense (Bupleurum root / Chai Hu)
-- Existing: triterpenoid saponins (major, sort 10)
-- New: specific saikosaponins (EP/BP quality markers) + flavonoids
-- ============================================================
RAISE NOTICE 'Block 1: Bupleurum chinense';

PERFORM herbal.ensure_constituent(
  'saikosaponin a',
  'oleanane triterpenoid saponin',
  'Primary bioactive saponin of Bupleurum chinense root and principal EP/BP quality marker for Bupleuri Radix (European Pharmacopoeia monograph 1523, 10th edition); a bidesmosidic glycoside with a 13β,28-epoxy oleanane skeleton. Minimum 0.3% total saikosaponins (expressed as saikosaponin A+D by HPLC) required by EP; immunomodulatory (upregulates NK and T-cell activity), hepatoprotective, and anti-inflammatory via NF-κB inhibition.'
);

PERFORM herbal.ensure_constituent(
  'saikosaponin d',
  'oleanane triterpenoid saponin',
  'Co-primary EP/BP quality marker for Bupleuri Radix, quantified alongside saikosaponin a in the European Pharmacopoeia HPLC assay. Differs from saikosaponin a by hydroxyl stereochemistry at C-16; shares hepatoprotective and immunostimulant pharmacology but is significantly more cytotoxic against tumour cell lines in vitro. Ratio of a:d varies with geographic origin and drying conditions.'
);

PERFORM herbal.ensure_constituent(
  'saikosaponin b2',
  'oleanane triterpenoid saponin',
  'A dehydrated (Δ-13(18)-ene) saikosaponin formed by partial thermal conversion of saikosaponin a during drying and processing; also present endogenously in fresh root. Antiviral activity (inhibits hepatitis C NS5B polymerase in cell-based assays — the most antiviral of the saikosaponin series). Elevated b2:a ratio is used as a processing/ageing quality indicator.'
);

PERFORM herbal.ensure_constituent(
  'saikosaponin c',
  'oleanane triterpenoid saponin',
  'A saikosaponin of B. chinense root bearing an additional 6′-O-acetyl group on the outer glucose residue; anti-inflammatory and immunomodulatory. Contributes to the species-specific HPLC fingerprint alongside saikosaponins a and d, helping distinguish B. chinense from B. falcatum.'
);

PERFORM herbal.ensure_constituent(
  'saikogenin G',
  'oleanane triterpenoid aglycone',
  'The primary triterpenoid aglycone (sapogenin) of the saikosaponin glycoside series; the 13β,28-epoxy oleanolic acid scaffold defining the saikosaponin structural class. Present as a trace free aglycone in intact root from partial enzymatic hydrolysis; the aglycone of saikosaponin a. Direct anti-inflammatory activity via 5-lipoxygenase inhibition and hepatocyte-protective at low concentrations.'
);

-- Link constituents to Bupleurum chinense
PERFORM herbal.link_constituent('Bupleurum chinense', 'saikosaponin a',  'primary',  0);
PERFORM herbal.link_constituent('Bupleurum chinense', 'saikosaponin d',  'primary',  10);
-- existing triterpenoid saponins (generic) stays at sort 10 — not removed, serves as class wrapper
PERFORM herbal.link_constituent('Bupleurum chinense', 'saikosaponin b2', 'moderate', 20);
PERFORM herbal.link_constituent('Bupleurum chinense', 'saikosaponin c',  'moderate', 30);
PERFORM herbal.link_constituent('Bupleurum chinense', 'saikogenin G',    'minor',    40);
PERFORM herbal.link_constituent('Bupleurum chinense', 'rutin',           'minor',    50);
PERFORM herbal.link_constituent('Bupleurum chinense', 'isoquercitrin',   'minor',    60);
PERFORM herbal.link_constituent('Bupleurum chinense', 'quercetin',       'minor',    70);

RAISE NOTICE 'Block 1 complete: Bupleurum chinense — 5 ensure + 8 link calls';


-- ============================================================
-- BLOCK 2: Eucommia ulmoides (Du Zhong / Hardy Rubber Tree)
-- Existing: aucubin (major, sort 0)
-- New: iridoids (geniposidic acid primary EP marker), lignans (pinoresinol diglucoside ChP marker)
-- ============================================================
RAISE NOTICE 'Block 2: Eucommia ulmoides';

PERFORM herbal.ensure_constituent(
  'geniposidic acid',
  'iridoid glycoside',
  'The quantitatively dominant iridoid of Eucommia ulmoides bark (~0.5–1.5% dry bark in most studies); the primary HPLC authentication marker and key quality control parameter for Du Zhong (Chinese Pharmacopoeia). Anti-inflammatory (inhibits NF-κB and COX-2), hypotensive, and renal-protective in rodent models; a secoiridoid glucoside and biosynthetic precursor to genipin.'
);

PERFORM herbal.ensure_constituent(
  'pinoresinol diglucoside',
  'furofuran lignan diglucoside',
  '(+)-Pinoresinol-4,4′-di-O-β-D-glucopyranoside; the principal pharmacologically active lignan of E. ulmoides and primary standardisation marker mandated by the Chinese Pharmacopoeia (minimum 0.10% dry bark by HPLC). Antihypertensive (inhibits ACE and directly relaxes vascular smooth muscle in rodent models), bone-anabolic (promotes osteoblast activity, inhibits osteoclastogenesis), and anti-inflammatory. More concentrated in the leaf than the bark.'
);

PERFORM herbal.ensure_constituent(
  'medioresinol',
  'furofuran lignan',
  'A furofuran-type lignan aglycone with three methoxy groups on its phenyl rings, distinguishing it from pinoresinol; present as the free aglycone and as medioresinol diglucoside in E. ulmoides bark (~0.05–0.2% dry bark). Antioxidant, anti-inflammatory, and neuroprotective in vitro; contributes to the overall antihypertensive and connective-tissue-supportive lignan activity of Du Zhong.'
);

PERFORM herbal.ensure_constituent(
  'syringaresinol diglucoside',
  'furofuran lignan diglucoside',
  '(+)-Syringaresinol-4,4′-di-O-β-D-glucopyranoside; also known in the literature as liriodendrin. Co-occurs with pinoresinol diglucoside as a secondary lignan diglucoside in E. ulmoides bark (~0.05–0.15% dry bark). Antihypertensive, antioxidant, and anti-inflammatory; identical to eleutheroside E of Eleutherococcus senticosus.'
);

PERFORM herbal.ensure_constituent(
  'geniposide',
  'iridoid glycoside',
  'A glucoside iridoid co-occurring with geniposidic acid in E. ulmoides bark (~0.05–0.2% dry bark). Anti-inflammatory, hepatoprotective, and neuroprotective; used as an identity marker in HPLC quality control of Du Zhong preparations alongside geniposidic acid and aucubin. Structurally related to geniposidic acid but lacking the carboxymethyl side chain.'
);

-- Link constituents to Eucommia ulmoides
PERFORM herbal.link_constituent('Eucommia ulmoides', 'geniposidic acid',        'primary',  0);
-- aucubin already linked at sort 0; call silently skipped (ON CONFLICT DO NOTHING)
PERFORM herbal.link_constituent('Eucommia ulmoides', 'aucubin',                 'major',    10);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'pinoresinol diglucoside', 'primary',  20);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'medioresinol',            'moderate', 30);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'syringaresinol diglucoside', 'moderate', 40);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'geniposide',              'moderate', 50);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'isoquercitrin',           'minor',    60);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'chlorogenic acid',        'moderate', 70);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'quercetin',               'minor',    80);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'rutin',                   'minor',    90);
PERFORM herbal.link_constituent('Eucommia ulmoides', 'kaempferol',              'minor',    100);

RAISE NOTICE 'Block 2 complete: Eucommia ulmoides — 5 ensure + 11 link calls';


-- ============================================================
-- BLOCK 3: Laminaria digitata (Kelp / Oarweed)
-- Existing: alginic acid (major, sort 10)
-- All new constituents already in DB (added in earlier batches) — link only
-- ============================================================
RAISE NOTICE 'Block 3: Laminaria digitata';

-- fucoidan, laminarin, fucoxanthin, phlorotannins, iodine, mannitol all already in herbal.constituents
PERFORM herbal.link_constituent('Laminaria digitata', 'iodine',       'primary',  0);
-- alginic acid already linked at sort 10
PERFORM herbal.link_constituent('Laminaria digitata', 'fucoidan',     'primary',  20);
PERFORM herbal.link_constituent('Laminaria digitata', 'laminarin',    'major',    30);
PERFORM herbal.link_constituent('Laminaria digitata', 'fucoxanthin',  'moderate', 40);
PERFORM herbal.link_constituent('Laminaria digitata', 'phlorotannins','moderate', 50);
PERFORM herbal.link_constituent('Laminaria digitata', 'mannitol',     'major',    60);

RAISE NOTICE 'Block 3 complete: Laminaria digitata — 0 ensure + 6 link calls';


-- ============================================================
-- BLOCK 4: Saccharina latissima (Sugar Kelp)
-- Existing: alginic acid (major, sort 10)
-- Identical chemistry to Laminaria digitata — all link only
-- ============================================================
RAISE NOTICE 'Block 4: Saccharina latissima';

PERFORM herbal.link_constituent('Saccharina latissima', 'iodine',        'primary',  0);
-- alginic acid already linked at sort 10
PERFORM herbal.link_constituent('Saccharina latissima', 'fucoidan',      'primary',  20);
PERFORM herbal.link_constituent('Saccharina latissima', 'laminarin',     'major',    30);
PERFORM herbal.link_constituent('Saccharina latissima', 'fucoxanthin',   'moderate', 40);
PERFORM herbal.link_constituent('Saccharina latissima', 'phlorotannins', 'moderate', 50);
PERFORM herbal.link_constituent('Saccharina latissima', 'mannitol',      'major',    60);

RAISE NOTICE 'Block 4 complete: Saccharina latissima — 0 ensure + 6 link calls';


-- ============================================================
-- BLOCK 5: Euonymus atropurpureus (Wahoo / Burning Bush)
-- Existing: cardiac glycosides (major, sort 10) — generic class entry kept
-- New: specific cardenolide glycosides + sesquiterpene pyridine alkaloids
-- SAFETY: All constituents carry narrow-TI or toxic-profile flags
-- ============================================================
RAISE NOTICE 'Block 5: Euonymus atropurpureus (Wahoo)';

PERFORM herbal.ensure_constituent(
  'evobioside',
  'cardenolide glycoside',
  'The principal cardiac glycoside of Euonymus atropurpureus bark; a cardenolide diglycoside and the primary pharmacologically active cardiac glycoside of this species. SAFETY: Na⁺/K⁺-ATPase inhibitor with the same mechanism as digitalis glycosides; narrow therapeutic index — cathartic, emetic, and potentially cardiotoxic in overdose. Principal contributor to Wahoo''s toxic profile; requires skilled practitioner dispensing.'
);

PERFORM herbal.ensure_constituent(
  'evonoside',
  'cardenolide glycoside',
  'A second cardenolide cardiac glycoside co-occurring with evobioside in E. atropurpureus bark; a monoglycoside or structurally related diglycoside variant. Shares the Na⁺/K⁺-ATPase inhibitory mechanism of action. SAFETY: Contributes alongside evobioside to cumulative cardiotoxic and emetic potential; both glycosides must be considered together in any dosing assessment.'
);

PERFORM herbal.ensure_constituent(
  'euonymoside A',
  'cardenolide glycoside',
  'A cardenolide glycoside reported in Euonymus species; documented primarily in E. europaeus with reported but less definitively confirmed presence in E. atropurpureus specifically. If present, contributes to the cardiac glycoside mixture and associated cardiotoxic potential. NOTE: species-specific confirmation for E. atropurpureus is pending; flagged for review.'
);

PERFORM herbal.ensure_constituent(
  'evonimine',
  'sesquiterpene pyridine alkaloid',
  'The principal sesquiterpene pyridine alkaloid of the Euonymus genus; a macrocyclic polyester alkaloid built on a sesquiterpene core esterified with multiple acid units including nicotinic acid — the defining alkaloid class of family Celastraceae. SAFETY: Causes purgative, emetic, and CNS effects independently of the cardiac glycosides; evonimine and the cardenolide fraction act synergistically to produce Wahoo''s full toxic profile. Key genus authentication marker.'
);

PERFORM herbal.ensure_constituent(
  'alatamine',
  'sesquiterpene pyridine alkaloid',
  'A sesquiterpene pyridine alkaloid of the Euonymus genus, co-occurring with evonimine as a secondary member of the polyester alkaloid series in E. atropurpureus bark; named from E. alatus but distributed across Euonymus species. SAFETY: Potentially purgative and emetic — contributes to the cumulative alkaloid toxic burden alongside evonimine.'
);

-- Link constituents to Euonymus atropurpureus
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'evobioside',      'primary',  0);
-- cardiac glycosides (generic) stays at sort 10 as class wrapper
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'evonoside',       'major',    20);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'evonimine',       'moderate', 30);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'euonymoside A',   'minor',    40);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'alatamine',       'minor',    50);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'beta-sitosterol', 'minor',    60);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'quercetin',       'minor',    70);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'kaempferol',      'minor',    80);
PERFORM herbal.link_constituent('Euonymus atropurpureus', 'tannins',         'minor',    90);

RAISE NOTICE 'Block 5 complete: Euonymus atropurpureus — 5 ensure + 9 link calls';


-- ============================================================
-- BLOCK 6: Yucca spp. (Yucca root)
-- Existing: steroidal saponins (major, sort 10) — generic class entry kept
-- New: specific sapogenins, intact glycoside saponins, resveratrol
-- ============================================================
RAISE NOTICE 'Block 6: Yucca spp.';

PERFORM herbal.ensure_constituent(
  'yuccagenin',
  'steroidal sapogenin',
  'The primary steroidal sapogenin aglycone of Yucca root; a spirostanol-type compound and the principal hydrolysis product of the major Yucca saponin glycosides. Typically constitutes 2–6% of the total sapogenin fraction in dried root; mediates the anti-inflammatory and COX-inhibitory actions attributed to Yucca root extracts, relevant to use in arthritis and joint conditions.'
);

PERFORM herbal.ensure_constituent(
  'gitogenin',
  'steroidal sapogenin',
  'A furostanol-type sapogenin found alongside yuccagenin in Yucca root; structurally related to tigogenin and neotigogenin. Present in smaller amounts than yuccagenin; contributes to the saponin complex with documented surface-active membrane effects relevant to antiparasitic and anti-inflammatory activity.'
);

PERFORM herbal.ensure_constituent(
  'markogenin',
  'steroidal sapogenin',
  'A spirostanol sapogenin isolated from Yucca schidigera and Y. glauca; structurally similar to smilagenin but with a distinct hydroxylation pattern. Minor component of the total sapogenin fraction; contributes to the overall surface-active saponin complex of Yucca root.'
);

PERFORM herbal.ensure_constituent(
  'yuccoside A',
  'steroidal saponin glycoside',
  'A glycosidic saponin from Yucca root in which yuccagenin is the aglycone; documented from Y. glauca and Y. schidigera. One of the characterised intact saponin forms (before hydrolysis to free sapogenins); exhibits haemolytic and surface-active properties typical of steroidal saponins.'
);

PERFORM herbal.ensure_constituent(
  'yuccoside B',
  'steroidal saponin glycoside',
  'A related intact glycoside saponin from Yucca root differing from yuccoside A in sugar chain composition; reported from Y. glauca. Less well-characterised quantitatively than yuccoside A; part of the complex saponin mixture responsible for Yucca anti-inflammatory and immunoadjuvant properties.'
);

PERFORM herbal.ensure_constituent(
  'resveratrol',
  'stilbenoid',
  'A phenolic stilbene documented in Yucca schidigera bark and root; reported at up to ~0.5 mg/g dry weight in some studies. Well-known antioxidant and phytoalexin with anti-inflammatory, cardioprotective, and chemopreventive activity in vitro; less prominent in Yucca than in grapes but pharmacologically significant in the overall polyphenol fraction.'
);

-- Link constituents to Yucca spp.
PERFORM herbal.link_constituent('Yucca spp.', 'yuccagenin',    'major',    0);
-- steroidal saponins (generic) stays at sort 10
PERFORM herbal.link_constituent('Yucca spp.', 'gitogenin',     'moderate', 20);
PERFORM herbal.link_constituent('Yucca spp.', 'markogenin',    'minor',    30);
PERFORM herbal.link_constituent('Yucca spp.', 'yuccoside A',   'minor',    40);
PERFORM herbal.link_constituent('Yucca spp.', 'yuccoside B',   'trace',    50);
PERFORM herbal.link_constituent('Yucca spp.', 'resveratrol',   'minor',    60);
PERFORM herbal.link_constituent('Yucca spp.', 'smilagenin',    'minor',    70);
PERFORM herbal.link_constituent('Yucca spp.', 'sarsaponin',    'minor',    80);
PERFORM herbal.link_constituent('Yucca spp.', 'beta-sitosterol','minor',   90);
PERFORM herbal.link_constituent('Yucca spp.', 'stigmasterol',  'minor',    100);
PERFORM herbal.link_constituent('Yucca spp.', 'diosgenin',     'trace',    110);
PERFORM herbal.link_constituent('Yucca spp.', 'tannins',       'minor',    120);

RAISE NOTICE 'Block 6 complete: Yucca spp. — 6 ensure + 12 link calls';


-- ============================================================
-- BLOCK 7: Albizia julibrissin (Silk Tree / He Huan Pi)
-- Existing: kaempferol (minor, sort 0)
-- New: julibroside triterpenoid saponins (primary bioactives), chalcone, non-protein AA
-- ============================================================
RAISE NOTICE 'Block 7: Albizia julibrissin';

PERFORM herbal.ensure_constituent(
  'julibroside J1',
  'oleanane triterpenoid saponin',
  'The primary cytotoxic triterpenoid saponin of Albizia julibrissin bark (He Huan Pi); an oleanolic acid glycoside with a complex oligosaccharide chain. Demonstrated significant cytotoxicity against multiple cancer cell lines at low micromolar IC50 values; the principal bioactive marker compound for A. julibrissin bark in modern pharmacological research. Contributes to the sedative and anti-inflammatory profile of He Huan Pi.'
);

PERFORM herbal.ensure_constituent(
  'julibroside J2',
  'oleanane triterpenoid saponin',
  'A closely related oleanane saponin co-isolated with julibroside J1 from A. julibrissin bark; shares the same aglycone (oleanolic acid) with a variant oligosaccharide chain. Exhibits cytotoxic and anti-inflammatory activity comparable to J1; part of the characteristic julibroside fraction that defines this species in the Chinese Pharmacopoeia context.'
);

PERFORM herbal.ensure_constituent(
  'julibroside J3',
  'oleanane triterpenoid saponin',
  'The third major component of the julibroside series from A. julibrissin bark; anti-proliferative against cancer cell lines in vitro. Less abundant than julibroside J1 but contributes to the total saponin bioactivity of He Huan Pi bark extract.'
);

PERFORM herbal.ensure_constituent(
  'albiziasaponin A',
  'oleanane triterpenoid saponin',
  'A triterpenoid saponin from A. julibrissin bark structurally related to the julibroside series; isolated and characterised from Chinese Pharmacopoeia-quality He Huan Pi. Contributes to the sedative, anxiolytic, and anti-inflammatory pharmacological profile of the bark used in TCM for calming the spirit (Shen, "collective happiness").'
);

PERFORM herbal.ensure_constituent(
  'albizziin',
  'non-protein amino acid',
  'A free non-protein amino acid (alpha-amino-beta-ureidopropionic acid) characteristic of Albizia species; present in seeds and to a lesser extent in bark. Structurally analogous to asparagine with a ureido group. SAFETY: Exhibits neurotoxic activity in animal models at high doses; relevant to safety assessment for internal use of bark preparations, particularly at high doses or in prolonged use.'
);

PERFORM herbal.ensure_constituent(
  'quercitrin',
  'flavonol glycoside',
  'The 3-O-rhamnoside of quercetin; documented in bark and flowers of A. julibrissin (He Huan Hua). Anti-inflammatory, antioxidant, and mildly sedative; more water-soluble than free quercetin, enhancing bioavailability in the traditional aqueous decoction of He Huan Pi. Distinct from isoquercitrin (quercetin-3-O-glucoside) and from rutin (quercetin-3-O-rutinoside).'
);

PERFORM herbal.ensure_constituent(
  'okanin',
  'chalcone',
  'A hydroxychalcone flavonoid reported from A. julibrissin flowers (He Huan Hua). Exhibits anti-inflammatory and monoamine oxidase (MAO) inhibitory activity relevant to the herb''s traditional anxiolytic and mood-elevating use in TCM — He Huan literally meaning "collective happiness". Contributes to the flavonoid fraction alongside acacetin and the flavonol glycosides.'
);

-- Link constituents to Albizia julibrissin
PERFORM herbal.link_constituent('Albizia julibrissin', 'julibroside J1',    'major',    10);
PERFORM herbal.link_constituent('Albizia julibrissin', 'julibroside J2',    'moderate', 20);
PERFORM herbal.link_constituent('Albizia julibrissin', 'julibroside J3',    'minor',    30);
PERFORM herbal.link_constituent('Albizia julibrissin', 'albiziasaponin A',  'moderate', 40);
PERFORM herbal.link_constituent('Albizia julibrissin', 'albizziin',         'minor',    50);
PERFORM herbal.link_constituent('Albizia julibrissin', 'quercitrin',        'minor',    60);
PERFORM herbal.link_constituent('Albizia julibrissin', 'isoquercitrin',     'minor',    70);
PERFORM herbal.link_constituent('Albizia julibrissin', 'okanin',            'minor',    80);
PERFORM herbal.link_constituent('Albizia julibrissin', 'acacetin',          'minor',    90);
-- kaempferol already linked at sort 0; call silently skipped (ON CONFLICT DO NOTHING)
PERFORM herbal.link_constituent('Albizia julibrissin', 'kaempferol',        'minor',    100);
PERFORM herbal.link_constituent('Albizia julibrissin', 'quercetin',         'minor',    110);
PERFORM herbal.link_constituent('Albizia julibrissin', 'rutin',             'minor',    120);
PERFORM herbal.link_constituent('Albizia julibrissin', 'oleanolic acid',    'minor',    130);
PERFORM herbal.link_constituent('Albizia julibrissin', 'beta-sitosterol',   'minor',    140);
PERFORM herbal.link_constituent('Albizia julibrissin', 'tannins',           'minor',    150);

RAISE NOTICE 'Block 7 complete: Albizia julibrissin — 7 ensure + 15 link calls';

RAISE NOTICE 'Migration 189 complete: batch 10 (final batch) — 7 herbs processed';

END $$;
