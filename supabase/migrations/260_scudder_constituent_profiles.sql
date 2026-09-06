-- Migration 260: constituent_profiles (amber Marker cards) for 11 Scudder-source herbs
-- Herb IDs from migration 256; constituent_profiles has no UNIQUE constraint,
-- so each block deletes existing rows for the herb_id before inserting.
-- Gravel Root (2602) intentionally omitted — root-specific profile not yet verified.

SET search_path TO herbal, public;

-- ── 2598 Aconite (Aconitum napellus, Root) ───────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2598;
  v_note CONSTANT TEXT :=
    'Aconitum napellus root is chemically defined by its C19 diterpenoid alkaloids, '
    'particularly aconitine and related ester alkaloids. These compounds produce powerful '
    'effects on voltage-gated sodium channels and account simultaneously for aconite''s '
    'historical pharmacological reputation and its exceptionally narrow safety margin.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Aconite', 'Aconitum napellus', 'Root',
     'Aconitine', 'Alkaloid', 'Diterpenoid alkaloid',
     'High', 'Marker',
     'Principal highly toxic diterpenoid alkaloid responsible for much of aconite''s characteristic sodium-channel activity.',
     v_note),
    (v_herb, 'Aconite', 'Aconitum napellus', 'Root',
     'Mesaconitine', 'Alkaloid', 'Diterpenoid alkaloid',
     'Moderate', 'Major',
     'Potent diester diterpenoid alkaloid contributing to the characteristic neurotoxic and cardiotoxic fraction.',
     v_note),
    (v_herb, 'Aconite', 'Aconitum napellus', 'Root',
     'Hypaconitine', 'Alkaloid', 'Diterpenoid alkaloid',
     'Moderate', 'Major',
     'Related diester diterpenoid alkaloid contributing to aconite toxicity and pharmacological activity.',
     v_note),
    (v_herb, 'Aconite', 'Aconitum napellus', 'Root',
     'Napelline', 'Alkaloid', 'Diterpenoid alkaloid',
     'Moderate', 'Major',
     'Characteristic Aconitum alkaloid particularly associated with A. napellus.',
     v_note);
  RAISE NOTICE 'Aconite (id 2598) constituent_profiles: done.';
END $$;

-- ── 2599 Dogbane (Apocynum cannabinum, Root) ─────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2599;
  v_note CONSTANT TEXT :=
    'Apocynum cannabinum root is characterized primarily by its cardioactive steroidal '
    'glycosides, especially cymarin. This chemically focused profile reflects the fraction '
    'responsible for both the historical cardiac effects and significant toxicity of Dogbane '
    'rather than padding the entry with less diagnostic constituents.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Dogbane', 'Apocynum cannabinum', 'Root',
     'Cymarin', 'Steroid', 'Cardiac glycoside',
     'High', 'Marker',
     'Principal cardenolide glycoside responsible for the characteristic cardiotonic and toxic activity.',
     v_note),
    (v_herb, 'Dogbane', 'Apocynum cannabinum', 'Root',
     'Apocannoside', 'Steroid', 'Cardiac glycoside',
     'High', 'Major',
     'Characteristic cardioactive glycoside of the root and rhizome.',
     v_note),
    (v_herb, 'Dogbane', 'Apocynum cannabinum', 'Root',
     'Cynocannoside', 'Steroid', 'Cardiac glycoside',
     'Moderate', 'Major',
     'Species-associated cardiac glycoside complementing the cymarin-dominated fraction.',
     v_note);
  RAISE NOTICE 'Dogbane (id 2599) constituent_profiles: done.';
END $$;

-- ── 2600 Belladonna (Atropa belladonna, Leaf) ────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2600;
  v_note CONSTANT TEXT :=
    'Atropa belladonna is defined almost entirely by its tropane alkaloids, especially '
    'L-hyoscyamine and scopolamine, whose muscarinic-receptor antagonism accounts for both '
    'its historical medicinal effects and characteristic anticholinergic toxicity. Atropine '
    'is not separately entered because it is the racemate of hyoscyamine rather than a '
    'distinct native phytochemical marker.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Belladonna', 'Atropa belladonna', 'Leaf',
     'L-Hyoscyamine', 'Alkaloid', 'Tropane alkaloid',
     'High', 'Marker',
     'Principal naturally occurring tropane alkaloid responsible for potent antimuscarinic activity.',
     v_note),
    (v_herb, 'Belladonna', 'Atropa belladonna', 'Leaf',
     'Scopolamine', 'Alkaloid', 'Tropane alkaloid',
     'High', 'Major',
     'Characteristic antimuscarinic tropane alkaloid with prominent central and peripheral effects.',
     v_note),
    (v_herb, 'Belladonna', 'Atropa belladonna', 'Leaf',
     'Anisodamine', 'Alkaloid', 'Tropane alkaloid',
     'Low–Moderate', 'Present',
     'Hydroxylated tropane alkaloid occurring within the hyoscyamine-to-scopolamine biosynthetic pathway.',
     v_note);
  RAISE NOTICE 'Belladonna (id 2600) constituent_profiles: done.';
END $$;

-- ── 2601 Cannabis (Cannabis sativa, Aerial parts) ────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2601;
  v_note CONSTANT TEXT :=
    'Cannabis sativa is chemically defined by its phytocannabinoids, particularly the acidic '
    'precursors THCA and CBDA and their decarboxylation products THC and CBD. Chemotype '
    'strongly affects relative abundance, so multiple constituents receive Marker status rather '
    'than assuming a THC-dominant plant. Generic terpenes are omitted to preserve the chemically '
    'diagnostic cannabinoid signal.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Cannabis', 'Cannabis sativa', 'Aerial parts',
     'Δ9-Tetrahydrocannabinolic acid (THCA)', 'Terpenoid', 'Cannabinoid',
     'High', 'Marker',
     'Principal acidic cannabinoid precursor of psychoactive Δ9-THC in THC-dominant chemotypes.',
     v_note),
    (v_herb, 'Cannabis', 'Cannabis sativa', 'Aerial parts',
     'Cannabidiolic acid (CBDA)', 'Terpenoid', 'Cannabinoid',
     'High', 'Marker',
     'Principal acidic precursor of cannabidiol in CBD-dominant chemotypes.',
     v_note),
    (v_herb, 'Cannabis', 'Cannabis sativa', 'Aerial parts',
     'Δ9-Tetrahydrocannabinol (THC)', 'Terpenoid', 'Cannabinoid',
     'High', 'Marker',
     'Psychoactive cannabinoid formed principally through decarboxylation of THCA.',
     v_note),
    (v_herb, 'Cannabis', 'Cannabis sativa', 'Aerial parts',
     'Cannabidiol (CBD)', 'Terpenoid', 'Cannabinoid',
     'High', 'Marker',
     'Major non-intoxicating cannabinoid with broad neuroactive and anti-inflammatory pharmacology.',
     v_note),
    (v_herb, 'Cannabis', 'Cannabis sativa', 'Aerial parts',
     'Cannabigerolic acid (CBGA)', 'Terpenoid', 'Cannabinoid',
     'Moderate', 'Major',
     'Central biosynthetic precursor from which several major cannabinoid families are formed.',
     v_note),
    (v_herb, 'Cannabis', 'Cannabis sativa', 'Aerial parts',
     'Cannabichromenic acid (CBCA)', 'Terpenoid', 'Cannabinoid',
     'Moderate', 'Major',
     'Characteristic acidic phytocannabinoid representing the CBC branch of cannabinoid biosynthesis.',
     v_note);
  RAISE NOTICE 'Cannabis (id 2601) constituent_profiles: done.';
END $$;

-- ── 2603 Ignatia (Strychnos ignatii, Seed) ───────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2603;
  v_note CONSTANT TEXT :=
    'Strychnos ignatii seed is chemically dominated by Strychnos-type indole alkaloids, '
    'particularly strychnine, with brucine and related alkaloids forming a secondary fraction. '
    'This alkaloid family accounts for the seed''s profound CNS activity and extreme toxicity '
    'and provides a strong chemical relationship with Nux Vomica.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Ignatia', 'Strychnos ignatii', 'Seed',
     'Strychnine', 'Alkaloid', 'Strychnos indole alkaloid',
     'High', 'Marker',
     'Dominant highly toxic alkaloid and potent glycine-receptor antagonist responsible for characteristic CNS excitation.',
     v_note),
    (v_herb, 'Ignatia', 'Strychnos ignatii', 'Seed',
     'Brucine', 'Alkaloid', 'Strychnos indole alkaloid',
     'High', 'Major',
     'Closely related toxic alkaloid accompanying strychnine in St. Ignatius bean.',
     v_note),
    (v_herb, 'Ignatia', 'Strychnos ignatii', 'Seed',
     'α-Colubrine', 'Alkaloid', 'Strychnos indole alkaloid',
     'Moderate', 'Major',
     'Characteristic minor Strychnos alkaloid complementing the dominant strychnine fraction.',
     v_note),
    (v_herb, 'Ignatia', 'Strychnos ignatii', 'Seed',
     'Icajine', 'Alkaloid', 'Strychnos indole alkaloid',
     'Moderate', 'Major',
     'Characteristic structurally related alkaloid reported from St. Ignatius bean.',
     v_note),
    (v_herb, 'Ignatia', 'Strychnos ignatii', 'Seed',
     'Vomicine', 'Alkaloid', 'Strychnos indole alkaloid',
     'Low–Moderate', 'Present',
     'Minor Strychnos alkaloid contributing to the broader seed alkaloid profile.',
     v_note);
  RAISE NOTICE 'Ignatia (id 2603) constituent_profiles: done.';
END $$;

-- ── 2604 Nux Vomica (Strychnos nux-vomica, Seed) ─────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2604;
  v_note CONSTANT TEXT :=
    'Strychnos nux-vomica seed is dominated by strychnine and brucine, supported by related '
    'Strychnos alkaloids and a smaller iridoid fraction. The combination creates an unusually '
    'distinctive profile and correctly produces strong chemical similarity to Ignatia while '
    'retaining enough secondary chemistry to distinguish the two species.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Nux Vomica', 'Strychnos nux-vomica', 'Seed',
     'Strychnine', 'Alkaloid', 'Strychnos indole alkaloid',
     'High', 'Marker',
     'Principal highly toxic CNS-stimulant alkaloid acting primarily through glycine-receptor antagonism.',
     v_note),
    (v_herb, 'Nux Vomica', 'Strychnos nux-vomica', 'Seed',
     'Brucine', 'Alkaloid', 'Strychnos indole alkaloid',
     'High', 'Marker',
     'Major structurally related alkaloid contributing pharmacological activity and toxicity.',
     v_note),
    (v_herb, 'Nux Vomica', 'Strychnos nux-vomica', 'Seed',
     'Vomicine', 'Alkaloid', 'Strychnos indole alkaloid',
     'Moderate', 'Major',
     'Characteristic minor alkaloid contributing specificity to the Nux Vomica profile.',
     v_note),
    (v_herb, 'Nux Vomica', 'Strychnos nux-vomica', 'Seed',
     'α-Colubrine', 'Alkaloid', 'Strychnos indole alkaloid',
     'Moderate', 'Major',
     'Characteristic related seed alkaloid within the broader strychnine family.',
     v_note),
    (v_herb, 'Nux Vomica', 'Strychnos nux-vomica', 'Seed',
     'Loganic acid', 'Glycoside', 'Iridoid glycoside',
     'Moderate', 'Major',
     'Important non-alkaloid constituent used analytically alongside strychnine and brucine for seed characterization.',
     v_note),
    (v_herb, 'Nux Vomica', 'Strychnos nux-vomica', 'Seed',
     'Loganin', 'Glycoside', 'Iridoid glycoside',
     'Low–Moderate', 'Present',
     'Iridoid glycoside related biosynthetically to the characteristic Strychnos alkaloid pathway.',
     v_note);
  RAISE NOTICE 'Nux Vomica (id 2604) constituent_profiles: done.';
END $$;

-- ── 2605 Podophyllum (Podophyllum peltatum, Root) ────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2605;
  v_note CONSTANT TEXT :=
    'Podophyllum peltatum root and rhizome are chemically defined by aryltetralin lignans, '
    'especially α-peltatin, β-peltatin, and podophyllotoxin. These highly cytotoxic compounds '
    'account for the plant''s drastic historical effects and pharmacological importance, making '
    'unrelated minor metabolites unnecessary for a representative chemical profile.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Podophyllum', 'Podophyllum peltatum', 'Root',
     'α-Peltatin', 'Lignan', 'Aryltetralin lignan',
     'High', 'Marker',
     'Characteristic cytotoxic lignan and major component of American podophyllum rhizome during dormancy.',
     v_note),
    (v_herb, 'Podophyllum', 'Podophyllum peltatum', 'Root',
     'β-Peltatin', 'Lignan', 'Aryltetralin lignan',
     'High', 'Marker',
     'Major characteristic aryltetralin lignan contributing to the strongly cytotoxic resin chemistry.',
     v_note),
    (v_herb, 'Podophyllum', 'Podophyllum peltatum', 'Root',
     'Podophyllotoxin', 'Lignan', 'Aryltetralin lignan',
     'High', 'Marker',
     'Potent antimitotic lignan and pharmacologically important precursor for semisynthetic anticancer drugs.',
     v_note),
    (v_herb, 'Podophyllum', 'Podophyllum peltatum', 'Root',
     'Desoxypodophyllotoxin', 'Lignan', 'Aryltetralin lignan',
     'Moderate', 'Major',
     'Biosynthetically related lignan and precursor within the characteristic podophyllotoxin pathway.',
     v_note);
  RAISE NOTICE 'Podophyllum (id 2605) constituent_profiles: done.';
END $$;

-- ── 2606 Poison Ivy (Toxicodendron radicans, Leaf) ───────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2606;
  v_note CONSTANT TEXT :=
    'Toxicodendron radicans leaf is defined almost completely by its C15 alk(en)ylcatechols, '
    'collectively known as urushiols. Rather than entering "urushiol" as a mixture, the '
    'principal saturation classes are represented individually. Increasing side-chain '
    'unsaturation is particularly relevant to the potent T-cell-mediated contact allergenicity '
    'that defines Poison Ivy.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Poison Ivy', 'Toxicodendron radicans', 'Leaf',
     '3-Pentadecenylcatechol (15:1)', 'Lipid', 'Alkylcatechol',
     'High', 'Marker',
     'Unsaturated C15 catechol contributing strongly to the characteristic allergenic fraction.',
     v_note),
    (v_herb, 'Poison Ivy', 'Toxicodendron radicans', 'Leaf',
     '3-Pentadecadienylcatechol (15:2)', 'Lipid', 'Alkylcatechol',
     'High', 'Marker',
     'Polyunsaturated urushiol congener associated with potent contact sensitization.',
     v_note),
    (v_herb, 'Poison Ivy', 'Toxicodendron radicans', 'Leaf',
     '3-Pentadecatrienylcatechol (15:3)', 'Lipid', 'Alkylcatechol',
     'High', 'Marker',
     'Highly unsaturated urushiol congener central to the characteristic allergenic chemistry.',
     v_note),
    (v_herb, 'Poison Ivy', 'Toxicodendron radicans', 'Leaf',
     '3-Pentadecylcatechol (15:0)', 'Lipid', 'Alkylcatechol',
     'Moderate', 'Major',
     'Saturated C15 catechol member of the urushiol-related phenolic-lipid fraction.',
     v_note);
  RAISE NOTICE 'Poison Ivy (id 2606) constituent_profiles: done.';
END $$;

-- ── 2607 Spearmint (Mentha spicata, Aerial parts) ────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2607;
  v_note CONSTANT TEXT :=
    'Mentha spicata aerial parts combine a characteristic carvone-rich monoterpenoid fraction '
    'with abundant rosmarinic-acid-derived phenolics. Carvone provides the strongest '
    'chemotaxonomic and sensory signal, while limonene and rosmarinic acid capture complementary '
    'volatile and nonvolatile chemistry; chemotype variation makes additional volatile markers '
    'less universally representative.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Spearmint', 'Mentha spicata', 'Aerial parts',
     '(R)-Carvone', 'Terpenoid', 'Monoterpenoid',
     'High', 'Marker',
     'Principal characteristic volatile of classic spearmint chemotypes responsible for its distinctive aroma and much of its antimicrobial activity.',
     v_note),
    (v_herb, 'Spearmint', 'Mentha spicata', 'Aerial parts',
     'Limonene', 'Terpenoid', 'Monoterpenoid',
     'High', 'Major',
     'Major monoterpene accompanying carvone and contributing to the characteristic volatile profile.',
     v_note),
    (v_herb, 'Spearmint', 'Mentha spicata', 'Aerial parts',
     'Rosmarinic acid', 'Polyphenol', 'Depside',
     'High', 'Major',
     'Principal representative of the abundant nonvolatile rosmarinic-acid-derived phenolic fraction.',
     v_note),
    (v_herb, 'Spearmint', 'Mentha spicata', 'Aerial parts',
     '1,8-Cineole', 'Terpenoid', 'Monoterpenoid',
     'Moderate', 'Major',
     'Common secondary volatile whose abundance varies substantially among chemotypes.',
     v_note);
  RAISE NOTICE 'Spearmint (id 2607) constituent_profiles: done.';
END $$;

-- ── 2608 Veratrum (Veratrum viride, Root) ────────────────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2608;
  v_note CONSTANT TEXT :=
    'Veratrum viride root and rhizome are chemically defined by a complex family of steroidal '
    'alkaloids, including jervine-, veratramine-, and veratridine-related compounds. These '
    'constituents account for the plant''s powerful cardiovascular and neurological effects and '
    'extreme toxicity, while considerable variation in alkaloid abundance argues against '
    'assigning a single compound universal dominance.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Veratrum', 'Veratrum viride', 'Root',
     'Jervine', 'Alkaloid', 'Steroidal alkaloid',
     'High', 'Marker',
     'Characteristic Veratrum alkaloid contributing to the profound toxicological and developmental effects of the genus.',
     v_note),
    (v_herb, 'Veratrum', 'Veratrum viride', 'Root',
     'Veratramine', 'Alkaloid', 'Steroidal alkaloid',
     'High', 'Major',
     'Characteristic steroidal alkaloid contributing cardiovascular and neurotoxic activity.',
     v_note),
    (v_herb, 'Veratrum', 'Veratrum viride', 'Root',
     'Protoveratrine A', 'Alkaloid', 'Steroidal alkaloid',
     'High', 'Major',
     'Potent esterified steroidal alkaloid associated with severe hypotensive and cardiotoxic effects.',
     v_note),
    (v_herb, 'Veratrum', 'Veratrum viride', 'Root',
     'Veratridine', 'Alkaloid', 'Steroidal alkaloid',
     'Moderate', 'Major',
     'Sodium-channel-active steroidal alkaloid contributing characteristic neurotoxicity.',
     v_note),
    (v_herb, 'Veratrum', 'Veratrum viride', 'Root',
     'Cevadine', 'Alkaloid', 'Steroidal alkaloid',
     'Moderate', 'Major',
     'Related ester alkaloid contributing to the broader Veratrum toxicological profile.',
     v_note);
  RAISE NOTICE 'Veratrum (id 2608) constituent_profiles: done.';
END $$;

-- ── 2609 Yellow Parilla (Menispermum canadense, Root) ────────────────────────

DO $$
DECLARE
  v_herb CONSTANT INTEGER := 2609;
  v_note CONSTANT TEXT :=
    'Menispermum canadense root is strongly characterized by its isoquinoline-derived alkaloids, '
    'particularly dauricine-related bisbenzylisoquinolines and the structurally distinctive '
    'acutumine family. This makes Yellow Parilla an unusually useful matching entry: its '
    'chemistry can connect it with other isoquinoline-alkaloid herbs while exact constituent '
    'matches preserve substantial species specificity.';
BEGIN
  DELETE FROM herbal.constituent_profiles WHERE herb_id = v_herb;
  INSERT INTO herbal.constituent_profiles
    (herb_id, common_name, latin_name, plant_part,
     constituent, class, subclass, importance, status, notes, editorial_note)
  VALUES
    (v_herb, 'Yellow Parilla', 'Menispermum canadense', 'Root',
     'Dauricine', 'Alkaloid', 'Bisbenzylisoquinoline alkaloid',
     'High', 'Marker',
     'Prominent bisbenzylisoquinoline alkaloid and one of the most characteristic constituents of Canadian moonseed root.',
     v_note),
    (v_herb, 'Yellow Parilla', 'Menispermum canadense', 'Root',
     'Acutumine', 'Alkaloid', 'Hasubanan alkaloid',
     'High', 'Marker',
     'Structurally distinctive alkaloid contributing strongly to the species-specific root profile.',
     v_note),
    (v_herb, 'Yellow Parilla', 'Menispermum canadense', 'Root',
     'Acutumidine', 'Alkaloid', 'Hasubanan alkaloid',
     'Moderate', 'Major',
     'Closely related characteristic alkaloid complementing acutumine.',
     v_note),
    (v_herb, 'Yellow Parilla', 'Menispermum canadense', 'Root',
     'Daurinoline', 'Alkaloid', 'Bisbenzylisoquinoline alkaloid',
     'Moderate', 'Major',
     'Related bisbenzylisoquinoline alkaloid reinforcing the dauricine-type fraction.',
     v_note),
    (v_herb, 'Yellow Parilla', 'Menispermum canadense', 'Root',
     'Magnoflorine', 'Alkaloid', 'Aporphine alkaloid',
     'Moderate', 'Major',
     'Quaternary aporphine alkaloid representing a complementary structural family in the root.',
     v_note),
    (v_herb, 'Yellow Parilla', 'Menispermum canadense', 'Root',
     'N′-Desmethyldauricine', 'Alkaloid', 'Bisbenzylisoquinoline alkaloid',
     'Moderate', 'Major',
     'Dauricine-related alkaloid contributing specificity to the characteristic root alkaloid profile.',
     v_note);
  RAISE NOTICE 'Yellow Parilla (id 2609) constituent_profiles: done.';
END $$;
