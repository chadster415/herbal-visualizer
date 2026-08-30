-- Migration 226: Full herb data for Saffron, Guayusa, and Velvet Bean
-- Stubs added in migration 224; class 52 snippets/keywords added in migration 225.
-- Sources:
--   Saffron energetics + dosage: Easley's Modern Herbal Dispensatory (warming, drying; 5–20 drops)
--   Saffron MM entry: *CROCUS (True Saffron) — confirmed in MM Materia Medica
--   Guayusa + Velvet Bean: no entry in Easley's, Hoffmann's, MM, or Stockley's
--   Constituent data: published phytochemical literature (PubChem, Moshiri 2015, Pardau 2017, Dhanasekaran et al.)
-- Energetics inference:
--   Saffron: confirmed warming/drying (Easley's) — no _inferred flags
--   Guayusa: inferred warming/drying from caffeine (primary) + methylxanthine dominance
--   Velvet Bean: inferred warming from L-DOPA dominance; moisture left unset (conflicting:
--     gallic acid → drying, Ayurvedic rasayana classification → moistening)

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. SAFFRON (Crocus sativus, id=2573)
-- ─────────────────────────────────────────────────────────────────────────────

-- Energetics (confirmed from Easley's Dispensatory)
UPDATE herbal.herbs
SET temperature          = 'warming',
    temperature_inferred = false,
    moisture             = 'drying',
    moisture_inferred    = false
WHERE latin_name = 'Crocus sativus';

-- Contraindications
UPDATE herbal.herbs
SET contraindications        = 'Contraindicated in pregnancy (emmenagogue). Do not combine with SSRIs due to serotonin syndrome risk. Use caution with anticoagulants.',
    contraindications_source = 'Easley'
WHERE latin_name = 'Crocus sativus';

-- Synonyms
UPDATE herbal.herbs
SET synonyms = ARRAY['Crocus', 'True Saffron', 'Kesar', 'Zafran', 'Za''faran', 'Autumn Crocus (disambiguation — not Colchicum)']
WHERE latin_name = 'Crocus sativus';

-- Body system action: Nervous — Antidepressant
DO $$
DECLARE
  v_herb_id  INTEGER;
  v_sys_id   INTEGER;
  v_act_id   INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs    WHERE latin_name = 'Crocus sativus';
  SELECT id INTO v_sys_id  FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_act_id  FROM herbal.primary_actions WHERE name = 'Antidepressant';

  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Modulates serotonergic and dopaminergic neurotransmission via crocin and safranal; clinical evidence supports use for mild to moderate depression at doses of 5–20 drops tincture or 2–3 stigma tea.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Saffron actions: done.';
END $$;

-- Constituents
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Crocus sativus');
  v_c INTEGER;
BEGIN
  -- Crocin — PRIMARY marker
  v_c := herbal.ensure_constituent(
    'crocin',
    'carotenoid glycoside',
    'Water-soluble diglucosyl ester of crocetin that modulates serotonergic and dopaminergic reuptake, producing antidepressant and neuroprotective effects.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Marker. Defines saffron quality (ISO 3632); up to ~12% dry weight in high-grade stigma. Primary antidepressant constituent.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Picrocrocin — MAJOR
  v_c := herbal.ensure_constituent(
    'picrocrocin',
    'monoterpenoid glucoside',
    'Principal bitter compound of saffron that hydrolyzes to safranal on drying and inhibits acetylcholinesterase activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Marker. ISO 3632 bitterness marker (1–4% dry weight); precursor to safranal; increases as stigma dries.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Safranal — MODERATE
  v_c := herbal.ensure_constituent(
    'safranal',
    'monoterpene aldehyde',
    'Primary aromatic volatile of saffron that acts as a GABA-A receptor agonist and demonstrates anticonvulsant and antidepressant activity.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Marker. Defines saffron aroma (ISO 3632); degradation product of picrocrocin during drying; volatile — preserve in alcohol or sealed preparations.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Crocetin — MINOR
  v_c := herbal.ensure_constituent(
    'crocetin',
    'apocarotenoid',
    'Lipophilic aglycone of crocin that crosses the blood-brain barrier, inhibiting NF-κB signaling and reducing neuroinflammation.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Present primarily as aglycone of crocin; free form increases post-hydrolysis. Greater BBB penetration than crocin.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Kaempferol — MINOR (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Saffron constituents: done.';
END $$;

-- Energetics inference: confirmed source — skipping _inferred fields (already set above)
-- Taste inference: safranal (bitter/aromatic volatile) + picrocrocin (bitter) → bitter
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Crocus sativus' AND taste IS NULL;

-- Menstruum
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Crocus sativus',
    40::INTEGER,                           -- alcohol_pct_min
    60::INTEGER,                           -- alcohol_pct_max
    NULL::INTEGER,                         -- glycerin_pct
    NULL::INTEGER,                         -- vinegar_pct
    true,                                  -- water_effective
    '40–60% alcohol or water infusion',    -- primary_label
    'Crocin and picrocrocin are water-soluble; safranal volatile is preserved in moderate alcohol. Easley recommends 1:10, 40% by percolation; traditional use as 2–3 stigma tea infusion is effective. Higher alcohol (up to 60%) improves safranal extraction.',
    false,                                 -- needs_review
    false,                                 -- powder_effective
    false                                  -- oil_effective
  );
  RAISE NOTICE 'Saffron menstruum: done.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. GUAYUSA (Ilex guayusa, id=2574)
-- ─────────────────────────────────────────────────────────────────────────────

-- Energetics (inferred from constituent profile: caffeine primary → warming/drying)
UPDATE herbal.herbs
SET temperature          = 'warming',
    temperature_inferred = true,
    moisture             = 'drying',
    moisture_inferred    = true
WHERE latin_name = 'Ilex guayusa';

-- Synonyms
UPDATE herbal.herbs
SET synonyms = ARRAY['Wayusa', 'Amazon tea', 'Runa tea', 'Ecuadorian holly']
WHERE latin_name = 'Ilex guayusa';

-- Body system actions: Nervous — Nervine Stimulant + Nootropic
DO $$
DECLARE
  v_herb_id  INTEGER;
  v_sys_id   INTEGER;
  v_act_id   INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs        WHERE latin_name = 'Ilex guayusa';
  SELECT id INTO v_sys_id  FROM herbal.body_systems WHERE name = 'Nervous';

  SELECT id INTO v_act_id  FROM herbal.primary_actions WHERE name = 'Nervine Stimulant';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'High caffeine content (2.5–3.5% dry weight) provides sustained CNS stimulation; L-theanine modulates caffeine-induced anxiety, producing calm, focused alertness.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_act_id  FROM herbal.primary_actions WHERE name = 'Nootropic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Caffeine + L-theanine synergy improves working memory, attention, and reaction time; chlorogenic acids add antioxidant neuroprotection.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Guayusa actions: done.';
END $$;

-- Constituents
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Ilex guayusa');
  v_c INTEGER;
BEGIN
  -- Caffeine — PRIMARY (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Marker for genus Ilex; 2.5–3.5% dry weight — among the highest of any plant leaf; primary therapeutic constituent.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Chlorogenic acid — MAJOR (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'chlorogenic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major', 'Dominant phenolic fraction (4–8% dry weight); contributes antioxidant, hypoglycemic, and anti-inflammatory activity.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Rutin — MODERATE (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rutin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- L-theanine — MINOR (new)
  v_c := herbal.ensure_constituent(
    'L-theanine',
    'non-protein amino acid',
    'Glutamate analogue that promotes alpha-wave brain activity and modulates GABAergic and glutamatergic transmission, dampening stimulant-induced anxiety.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Present at lower levels than in Camellia sinensis but documented; synergizes with caffeine to produce calm-focus effect characteristic of guayusa.', 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Theobromine — MINOR (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'theobromine';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', 'Contributes sustained, gentler cardiovascular stimulation and bronchodilation alongside caffeine.', 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Ursolic acid — MINOR (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'ursolic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Guayusa constituents: done.';
END $$;

-- Taste: caffeine (bitter alkaloid) + chlorogenic acids (bitter) → bitter
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Ilex guayusa' AND taste IS NULL;

-- Menstruum
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Ilex guayusa',
    50::INTEGER,
    70::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    'water infusion or 50–70% alcohol',
    'Caffeine, theobromine, and chlorogenic acids all extract readily in hot water; moderate-high alcohol improves extraction of ursolic acid and preserves the preparation. Traditionally prepared as a hot leaf infusion (like yerba mate). Alcohol tincture preferred when aiming for standardized caffeine + theanine content.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Guayusa menstruum: done.';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. VELVET BEAN (Mucuna pruriens, id=2575)
-- ─────────────────────────────────────────────────────────────────────────────

-- Energetics (temperature inferred from L-DOPA dominance; moisture left unset —
-- gallic acid suggests drying, Ayurvedic rasayana classification suggests moistening)
UPDATE herbal.herbs
SET temperature          = 'warming',
    temperature_inferred = true
WHERE latin_name = 'Mucuna pruriens';

-- Contraindications
UPDATE herbal.herbs
SET contraindications        = 'Caution with dopaminergic medications (levodopa drugs, MAO inhibitors) due to additive effects. Raw seed can cause nausea at therapeutic doses; traditional processing in milk or decoction reduces GI side effects. Avoid in pregnancy.',
    contraindications_source = 'phytochemical literature'
WHERE latin_name = 'Mucuna pruriens';

-- Synonyms
UPDATE herbal.herbs
SET synonyms = ARRAY['Mucuna', 'Kapikachhu', 'Kapikachu', 'Atmagupta', 'Cowhage', 'Cowitch', 'Kiwanch', 'Nescafé plant']
WHERE latin_name = 'Mucuna pruriens';

-- Body system actions: Nervous — Adaptogen + Nootropic
DO $$
DECLARE
  v_herb_id  INTEGER;
  v_sys_id   INTEGER;
  v_act_id   INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs        WHERE latin_name = 'Mucuna pruriens';
  SELECT id INTO v_sys_id  FROM herbal.body_systems WHERE name = 'Nervous';

  SELECT id INTO v_act_id  FROM herbal.primary_actions WHERE name = 'Adaptogen';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Reduces cortisol and restores HPA axis function under chronic stress; Ayurvedic rasayana herb used to rebuild nervous system vitality.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_act_id  FROM herbal.primary_actions WHERE name = 'Nootropic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'L-DOPA directly restores dopaminergic tone; indicated for low motivation, poor concentration, and reduced pleasure. Clinical use in Parkinson''s support.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Velvet Bean actions: done.';
END $$;

-- Constituents
DO $$
DECLARE
  v_herb_id CONSTANT INTEGER := (SELECT id FROM herbal.herbs WHERE latin_name = 'Mucuna pruriens');
  v_c INTEGER;
BEGIN
  -- L-DOPA — PRIMARY marker
  v_c := herbal.ensure_constituent(
    'L-DOPA',
    'catecholamine precursor',
    'Direct biochemical precursor to dopamine that crosses the blood-brain barrier via amino acid transporters and is decarboxylated to dopamine in dopaminergic neurons.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary', 'Marker. 3–6% dry weight in mature seeds (up to 9% in some ecotypes) — highest natural plant source. Defines the herb''s dopaminergic therapeutic action.', 10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Serotonin — MODERATE (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'serotonin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', 'Present in seed coat; contributes GI motility modulation and peripheral serotonergic effects.', 20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Mucunine (beta-carboline alkaloids) — TRACE
  v_c := herbal.ensure_constituent(
    'mucunine',
    'beta-carboline alkaloid',
    'Species-specific indole alkaloid with mild MAO-inhibiting activity that may potentiate dopaminergic and serotonergic effects of the whole-seed preparation.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'trace', 'Marker for M. pruriens; also present: mucunadine, prurieninine. Concentrations in published literature are sparse — needs review.', 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Gallic acid — MINOR (existing)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'gallic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Velvet Bean constituents: done.';
END $$;

-- Taste: L-DOPA + gallic acid → bitter
UPDATE herbal.herbs
SET taste = 'bitter', taste_inferred = true
WHERE latin_name = 'Mucuna pruriens' AND taste IS NULL;

-- Menstruum
DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Mucuna pruriens',
    50::INTEGER,
    70::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '50–70% alcohol or water decoction',
    'L-DOPA is water-soluble and extracts in both water and dilute alcohol; beta-carboline alkaloids (mucunine) require higher alcohol (50–70%). Traditional Ayurvedic use as seed powder in warm milk or aqueous decoction. Alcohol tincture useful when aiming for standardized L-DOPA content.',
    false,
    false,
    false
  );
  RAISE NOTICE 'Velvet Bean menstruum: done.';
END $$;
