SET search_path TO herbal, public;

-- ============================================================
-- Migration 248: constituent_profiles for six herbs that
-- received herb_constituents in migration 178 but had no
-- Marker/profile data yet.
-- Herbs: Bacopa, Black Pepper, Jamaican Dogwood, Nettle (leaf),
--        Self Heal, Spikenard (A. racemosa)
-- ============================================================

-- ---- Bacopa monnieri (id=2381) ----
-- Note: "Bacoside A" is intentionally absent — it is a mixture
-- of the four Marker compounds entered here individually.
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2381;
  v_note    CONSTANT TEXT    :=
    'Bacopa monnieri is chemically defined by its dammarane-type triterpenoid saponins, '
    'particularly jujubogenin- and pseudojujubogenin-based bacosides. "Bacoside A" is '
    'intentionally not entered as a constituent because it is a mixture; its four principal '
    'components are represented individually, preserving chemically meaningful relationships '
    'for matching and comparison.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Bacopa', 'Bacopa monnieri', 'Aerial parts',
     'Bacoside A3', 'Saponin', 'Dammarane triterpenoid saponin',
     'High', 'Marker',
     'Major jujubogenin-type bacoside contributing to Bacopa''s characteristic neuroactive saponin fraction.',
     v_note),
    (v_herb_id, 'Bacopa', 'Bacopa monnieri', 'Aerial parts',
     'Bacopaside II', 'Saponin', 'Dammarane triterpenoid saponin',
     'High', 'Marker',
     'Major pseudojujubogenin-type saponin and principal component of the bacoside A complex.',
     v_note),
    (v_herb_id, 'Bacopa', 'Bacopa monnieri', 'Aerial parts',
     'Bacopaside X', 'Saponin', 'Dammarane triterpenoid saponin',
     'High', 'Marker',
     'Jujubogenin-type saponin forming one of the four principal components conventionally grouped as bacoside A.',
     v_note),
    (v_herb_id, 'Bacopa', 'Bacopa monnieri', 'Aerial parts',
     'Bacopasaponin C', 'Saponin', 'Dammarane triterpenoid saponin',
     'High', 'Marker',
     'Major pseudojujubogenin-type saponin contributing to the characteristic bacoside profile.',
     v_note),
    (v_herb_id, 'Bacopa', 'Bacopa monnieri', 'Aerial parts',
     'Bacopaside I', 'Saponin', 'Dammarane triterpenoid saponin',
     'Moderate', 'Major',
     'Characteristic sulfated pseudojujubogenin glycoside used alongside the major bacosides in phytochemical characterization.',
     v_note);
  RAISE NOTICE 'Bacopa constituent_profiles: done.';
END $$;

-- ---- Piper nigrum (id=2498) ----
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2498;
  v_note    CONSTANT TEXT    :=
    'Piper nigrum fruit is defined by its pungent amide chemistry, overwhelmingly dominated '
    'by piperine and supplemented by related piperamides and N-isobutylamides. This profile '
    'captures both its distinctive pungency and the chemistry relevant to its well-known '
    'effects on drug and phytochemical bioavailability without diluting the entry with '
    'generic volatile terpenes.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Black Pepper', 'Piper nigrum', 'Fruit',
     'Piperine', 'Alkaloid', 'Piperidine alkaloid',
     'High', 'Marker',
     'Principal pungent amide responsible for characteristic sensory activity and important effects on xenobiotic bioavailability.',
     v_note),
    (v_herb_id, 'Black Pepper', 'Piper nigrum', 'Fruit',
     'Piperettine', 'Alkaloid', 'Piperidine alkaloid',
     'Moderate', 'Major',
     'Characteristic piperamide accompanying piperine within the pungent amide fraction.',
     v_note),
    (v_herb_id, 'Black Pepper', 'Piper nigrum', 'Fruit',
     'Piperlonguminine', 'Lipid', 'Alkamide',
     'Moderate', 'Major',
     'Bioactive unsaturated amide contributing to the characteristic piperamide chemistry.',
     v_note),
    (v_herb_id, 'Black Pepper', 'Piper nigrum', 'Fruit',
     'Pellitorine', 'Lipid', 'Alkamide',
     'Moderate', 'Major',
     'Pungent N-isobutylamide contributing sensory and bioactive properties.',
     v_note),
    (v_herb_id, 'Black Pepper', 'Piper nigrum', 'Fruit',
     'Piperolein B', 'Lipid', 'Alkamide',
     'Low–Moderate', 'Present',
     'Minor characteristic amide complementing the dominant piperine fraction.',
     v_note);
  RAISE NOTICE 'Black Pepper constituent_profiles: done.';
END $$;

-- ---- Piscidia piscipula (id=2461) ----
-- Style guide additions: Flavonoid → Prenylated isoflavone,
--   Flavonoid → Isoflavonoid, Flavonoid → Rotenoid
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2461;
  v_note    CONSTANT TEXT    :=
    'Piscidia piscipula root bark is distinguished by a complex isoflavonoid and rotenoid '
    'fraction, including piscidone, piscerythrone, jamaicin, and rotenone. The same chemistry '
    'underlying its traditional fish-poison use also makes toxicological context important; '
    'the profile therefore represents the plant''s characteristic chemistry rather than '
    'attempting to assign its traditional sedative and analgesic actions to a single compound.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Jamaican Dogwood', 'Piscidia piscipula', 'Root bark',
     'Piscidone', 'Flavonoid', 'Prenylated isoflavone',
     'High', 'Marker',
     'Species-characteristic prenylated isoflavonoid contributing to the distinctive root-bark profile.',
     v_note),
    (v_herb_id, 'Jamaican Dogwood', 'Piscidia piscipula', 'Root bark',
     'Piscerythrone', 'Flavonoid', 'Prenylated isoflavone',
     'High', 'Marker',
     'Characteristic isoflavonoid isolated from Jamaican Dogwood root material.',
     v_note),
    (v_herb_id, 'Jamaican Dogwood', 'Piscidia piscipula', 'Root bark',
     'Jamaicin', 'Flavonoid', 'Isoflavonoid',
     'High', 'Major',
     'Characteristic isoflavonoid contributing to the diagnostic chemistry of the medicinal bark.',
     v_note),
    (v_herb_id, 'Jamaican Dogwood', 'Piscidia piscipula', 'Root bark',
     'Ichthynone', 'Flavonoid', 'Isoflavonoid',
     'Moderate', 'Major',
     'Characteristic bark constituent associated with the plant''s distinctive isoflavonoid fraction.',
     v_note),
    (v_herb_id, 'Jamaican Dogwood', 'Piscidia piscipula', 'Root bark',
     'Rotenone', 'Flavonoid', 'Rotenoid',
     'Moderate', 'Major',
     'Potent rotenoid important to both the species'' fish-toxic activity and its toxicological profile.',
     v_note),
    (v_herb_id, 'Jamaican Dogwood', 'Piscidia piscipula', 'Root bark',
     'Lisetin', 'Flavonoid', 'Isoflavonoid',
     'Moderate', 'Major',
     'Structurally unusual isoflavonoid contributing additional specificity to the root chemistry.',
     v_note);
  RAISE NOTICE 'Jamaican Dogwood constituent_profiles: done.';
END $$;

-- ---- Urtica dioica leaf (id=43) ----
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 43;
  v_note    CONSTANT TEXT    :=
    'Urtica dioica leaf is characterized primarily by a polyphenol-rich flavonoid and '
    'caffeoylquinic-acid fraction, with rutin and chlorogenic acid among the most prominent '
    'compounds. Unlike the chemically distinct root, the leaf does not have one overwhelmingly '
    'diagnostic small-molecule marker, so this intentionally compact profile represents its '
    'dominant medicinal secondary-metabolite chemistry rather than its abundant minerals and nutrients.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Nettle', 'Urtica dioica', 'Leaf',
     'Rutin', 'Flavonoid', 'Flavonol glycoside',
     'High', 'Major',
     'Prominent leaf flavonoid contributing antioxidant, anti-inflammatory, and vascular activity.',
     v_note),
    (v_herb_id, 'Nettle', 'Urtica dioica', 'Leaf',
     'Chlorogenic acid', 'Polyphenol', 'Caffeoylquinic acid',
     'High', 'Major',
     'Major leaf phenolic contributing substantially to antioxidant and anti-inflammatory activity.',
     v_note),
    (v_herb_id, 'Nettle', 'Urtica dioica', 'Leaf',
     'Quercetin', 'Flavonoid', 'Flavonol',
     'Moderate', 'Major',
     'Bioactive flavonol contributing antioxidant and inflammatory-modulating effects.',
     v_note),
    (v_herb_id, 'Nettle', 'Urtica dioica', 'Leaf',
     'Kaempferol', 'Flavonoid', 'Flavonol',
     'Moderate', 'Major',
     'Characteristic complementary flavonol of the leaf phenolic fraction.',
     v_note);
  RAISE NOTICE 'Nettle (leaf) constituent_profiles: done.';
END $$;

-- ---- Prunella vulgaris (id=2437) ----
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2437;
  v_note    CONSTANT TEXT    :=
    'Prunella vulgaris combines a prominent rosmarinic-acid fraction with ursane and oleanane '
    'triterpenoids, particularly ursolic and oleanolic acids. Rosmarinic acid is sufficiently '
    'important to serve as a pharmacopoeial quality marker, while the complementary triterpenes '
    'and flavonoids help explain Self Heal''s broad anti-inflammatory, antioxidant, and '
    'tissue-protective reputation.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Self Heal', 'Prunella vulgaris', 'Aerial parts',
     'Rosmarinic acid', 'Polyphenol', 'Depside',
     'High', 'Marker',
     'Dominant phenolic and quality-control marker contributing strongly to antioxidant, anti-inflammatory, and immunomodulatory activity.',
     v_note),
    (v_herb_id, 'Self Heal', 'Prunella vulgaris', 'Aerial parts',
     'Ursolic acid', 'Terpenoid', 'Ursane triterpenoid',
     'High', 'Major',
     'Major pentacyclic triterpenoid contributing anti-inflammatory and tissue-protective activity.',
     v_note),
    (v_herb_id, 'Self Heal', 'Prunella vulgaris', 'Aerial parts',
     'Oleanolic acid', 'Terpenoid', 'Oleanane triterpenoid',
     'High', 'Major',
     'Major pentacyclic triterpenoid complementing ursolic acid within the lipophilic fraction.',
     v_note),
    (v_herb_id, 'Self Heal', 'Prunella vulgaris', 'Aerial parts',
     'Caffeic acid', 'Polyphenol', 'Hydroxycinnamic acid',
     'Moderate', 'Major',
     'Phenolic acid closely related to rosmarinic-acid metabolism and contributing antioxidant activity.',
     v_note),
    (v_herb_id, 'Self Heal', 'Prunella vulgaris', 'Aerial parts',
     'Rutin', 'Flavonoid', 'Flavonol glycoside',
     'Moderate', 'Present',
     'Representative flavonoid contributing antioxidant and vascular-protective activity.',
     v_note),
    (v_herb_id, 'Self Heal', 'Prunella vulgaris', 'Aerial parts',
     'Quercetin-3-O-glucoside', 'Flavonoid', 'Flavonol glycoside',
     'Moderate', 'Present',
     'Representative quercetin glycoside complementing the phenolic-rich aerial-part profile.',
     v_note);
  RAISE NOTICE 'Self Heal constituent_profiles: done.';
END $$;

-- ---- Aralia racemosa (id=2479) ----
-- Conservative profile — only compounds documented from A. racemosa
-- itself; nothing imported from other Aralia species.
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := 2479;
  v_note    CONSTANT TEXT    :=
    'Aralia racemosa remains comparatively under-characterized phytochemically, but '
    'species-specific work establishes a useful combination of diterpenoids and acetylenic '
    'lipids, including acanthoic acid, ent-kaurane derivatives, and falcarindiol. The short '
    'profile is intentional: compounds documented primarily from other Aralia species have '
    'not been imported simply to produce a larger entry.';
BEGIN
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'Acanthoic acid', 'Terpenoid', 'Diterpenoid',
     'Moderate', 'Marker',
     'Species-confirmed diterpenoid contributing to the phytochemical fingerprint of American spikenard.',
     v_note),
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'ent-Kaurenoic acid', 'Terpenoid', 'Diterpenoid',
     'Moderate', 'Major',
     'Kaurane-type diterpenoid forming part of the characteristic diterpenoid fraction.',
     v_note),
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     '(16R)-17-Hydroxy-ent-kauran-19-al', 'Terpenoid', 'Diterpenoid',
     'Moderate', 'Major',
     'Species-confirmed ent-kaurane diterpenoid useful for chemotaxonomic characterization.',
     v_note),
    (v_herb_id, 'Spikenard', 'Aralia racemosa', 'Root/rhizome',
     'Falcarindiol', 'Polyacetylene', 'Polyacetylene',
     'Moderate', 'Major',
     'Bioactive acetylenic lipid contributing to the characteristic Araliaceae polyyne chemistry.',
     v_note);
  RAISE NOTICE 'Spikenard (A. racemosa) constituent_profiles: done.';
END $$;
