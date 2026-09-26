-- Migration 342: Add Asafetida (Ferula asafoetida) and Cat's Claw (Uncaria tomentosa)
--
-- Both herbs appeared in Class 69 (Holistic Cancer Support) and were not yet in the DB.
--
-- External reference checks:
--   MM Materia Medica:
--     Asafetida  — found: mm_key='asafetida', GUM Tincture [1:5, 85% alc] 5–20 drops
--     Cat's Claw — found: mm_key='uncaria tomentosa', ROOT and VINE 5–20 g/day capsules (no tincture drops)
--   Stockley's Drug Interactions:
--     Asafetida  — pp.48–49: additive hypotensive effect (experimental only); warfarin interaction
--                  unlikely (no clinical evidence despite natural coumarins)
--     Cat's Claw — pp.129–131: potent CYP3A4 inhibitor in vitro; additive antihypertensive effect;
--                  antiplatelet additive effect (aspirin/clopidogrel); protease inhibitor interaction
--                  (atazanavir/ritonavir/saquinavir case report); safe with sulfasalazine/HCQ
--   Easley's Dispensatory:
--     Asafetida  — absent
--     Cat's Claw — found: Tincture dried bark (1:5, 60% alc) 3–5 ml (90–150 drops);
--                  Energetics: Cooling and slightly constricting
--   Hoffmann's Medical Herbalism: both absent
--   Tilgner's Heart of the Earth: both absent
--
-- SYNONYM_MAP updates (parse-mm-materia-medica.py):
--   'asafetida': ['ferula asafoetida']   ← add (MM uses common-name header)
--   'uncaria tomentosa': ['uncaria tomentosa']   ← update from []
-- Then: python3 scripts/parse-mm-materia-medica.py
--
-- Post-migration steps (after running this migration to get herb IDs):
--   1. Extract Stockley's images: Asafetida pp.48–49, Cat's Claw pp.129–131
--   2. Update lib/contraindications-manifest.ts with both herb IDs
--   3. Update lib/te-materia-medica.ts: Cat's Claw → { min: 90, max: 150 }
--   4. Update lib/mm-materia-medica.ts: Asafetida → { min: 5, max: 20 } (via parser re-run)

SET search_path TO herbal, public;

-- ============================================================
-- STEP 1: Insert herb rows
-- ============================================================

INSERT INTO herbal.herbs (common_name, latin_name, plant_part)
VALUES
  ('Asafetida',   'Ferula asafoetida', 'gum resin'),
  ('Cat''s Claw', 'Uncaria tomentosa', 'bark')
ON CONFLICT DO NOTHING;

-- ============================================================
-- STEP 2: Synonyms, energetics, contraindications
-- ============================================================

DO $$
DECLARE
  v_asaf_id INTEGER;
  v_claw_id INTEGER;
BEGIN
  SELECT id INTO v_asaf_id FROM herbal.herbs WHERE latin_name = 'Ferula asafoetida';
  SELECT id INTO v_claw_id FROM herbal.herbs WHERE latin_name = 'Uncaria tomentosa';

  IF v_asaf_id IS NULL OR v_claw_id IS NULL THEN
    RAISE NOTICE 'One or more herbs not found — skipping step 2';
    RETURN;
  END IF;

  UPDATE herbal.herbs
  SET synonyms = ARRAY['Asafoetida', 'Devil''s Dung', 'Hing', 'Asant', 'Gum asafetida',
                        'Stinkasant', 'Ferula foetida', 'Ferula asafetida']
  WHERE id = v_asaf_id AND (synonyms IS NULL OR synonyms = '{}');

  UPDATE herbal.herbs
  SET synonyms = ARRAY['Uña de Gato', 'Una de Gato', 'Samento', 'Savéntaro',
                        'Life-giving vine of Peru', 'Uncaria guianensis']
  WHERE id = v_claw_id AND (synonyms IS NULL OR synonyms = '{}');

  -- Asafetida energetics (all inferred — no source confirmed energetics)
  UPDATE herbal.herbs
  SET temperature = 'warming', temperature_inferred = true,
      moisture    = 'drying',  moisture_inferred    = true
  WHERE id = v_asaf_id;

  -- Cat's Claw energetics: temperature + tone confirmed from Easley; moisture inferred from tannins
  UPDATE herbal.herbs
  SET temperature = 'cooling', temperature_inferred = false,
      moisture    = 'drying',  moisture_inferred    = true,
      tone        = 'toning'
  WHERE id = v_claw_id;

  -- Asafetida contraindications (Stockley's pp.48–49)
  UPDATE herbal.herbs
  SET contraindications = 'May have additive hypotensive effects with antihypertensives based on '
    || 'experimental evidence (rat study). Contains natural coumarins; however, available data suggest '
    || 'anticoagulant interaction with warfarin is unlikely and no special precautions appear to be '
    || 'needed. No food or herbal medicine interactions found.',
      contraindications_source = 'Stockley''s'
  WHERE id = v_asaf_id AND contraindications IS NULL;

  -- Cat's Claw contraindications (Easley + Stockley's pp.129–131)
  UPDATE herbal.herbs
  SET contraindications = 'Avoid during pregnancy and while trying to get pregnant. '
    || 'May have additive hypotensive effects with antihypertensives. '
    || 'May increase bleeding risk with antiplatelet drugs (aspirin, clopidogrel); warn patients '
    || 'about prolonged bleeding if combining. Potent inhibitor of CYP3A4 in vitro; '
    || 'case report of raised atazanavir, ritonavir, and saquinavir levels — patients taking '
    || 'protease inhibitors should carefully consider concurrent use. '
    || 'May safely be combined with sulfasalazine or hydroxychloroquine (clinical study).',
      contraindications_source = 'Easley / Stockley''s'
  WHERE id = v_claw_id AND contraindications IS NULL;

  RAISE NOTICE 'Step 2 done: Asafetida id=%, Cat''s Claw id=%', v_asaf_id, v_claw_id;
END $$;

-- ============================================================
-- STEP 3: Body system actions
-- ============================================================

DO $$
DECLARE
  v_asaf_id   INTEGER;
  v_claw_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_asaf_id FROM herbal.herbs WHERE latin_name = 'Ferula asafoetida';
  SELECT id INTO v_claw_id FROM herbal.herbs WHERE latin_name = 'Uncaria tomentosa';
  IF v_asaf_id IS NULL OR v_claw_id IS NULL THEN
    RAISE NOTICE 'Herbs not found — skipping body system actions'; RETURN;
  END IF;

  -- ── Asafetida: Digestive ────────────────────────────────
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Carminative';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_asaf_id, v_action_id, v_sys_id,
    'Classic carminative for intestinal flatulence and colic; specifically indicated for intestinal '
    || 'flatulent colic (Stockley''s). Volatile sulfur compounds relax intestinal smooth muscle.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antispasmodic';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_asaf_id, v_action_id, v_sys_id,
    'Antispasmodic action in the gastrointestinal tract; reduces digestive spasms and cramping. '
    || 'Fatehi et al. demonstrated antispasmodic and hypotensive effects of gum extract.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Asafetida: Nervous ──────────────────────────────────
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Nervine Relaxant';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_asaf_id, v_action_id, v_sys_id,
    'Traditional nervine and sedative; calms the nervous system and reduces pain. '
    || 'BHC class notes specifically cite asafetida as a nervine in cancer care formulas '
    || 'to calm and reduce pain.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Asafetida: Respiratory - Lower ──────────────────────
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Stimulating Expectorant';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_asaf_id, v_action_id, v_sys_id,
    'Antispasmodic and expectorant in chronic bronchitis and pertussis (Stockley''s). '
    || 'Stimulates expectoration while relaxing bronchial spasms.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Cat's Claw: Immune ──────────────────────────────────
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Anti-Inflammatory';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_claw_id, v_action_id, v_sys_id,
    'Broad-spectrum anti-inflammatory via oxindole alkaloids and quinovic acid glycosides; '
    || 'used for bowel inflammation, joint and muscle inflammation, and cancer-associated inflammation.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antimicrobial';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_claw_id, v_action_id, v_sys_id,
    'Broad-spectrum mild antimicrobial (Easley). Used for gonorrhea, herpes zoster, herpes simplex, '
    || 'and HIV supportive therapy (Stockley''s).',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antiviral';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_claw_id, v_action_id, v_sys_id,
    'Antiviral and antimutagenic properties; useful for degenerative diseases and as complementary '
    || 'support during chemotherapy — strengthens the immune system against chemo effects (Easley).',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Immune Amphoteric';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_claw_id, v_action_id, v_sys_id,
    'Balances immune function; immunomodulating properties via alkaloids and polyphenols. '
    || 'Easley: "balances immune function." Stockley''s: immunostimulating and antimutagenic.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Cat's Claw: Musculoskeletal ─────────────────────────
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antirheumatic';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_claw_id, v_action_id, v_sys_id,
    'Used for arthritis; clinical study showed benefit combined with sulfasalazine or '
    || 'hydroxychloroquine for rheumatoid arthritis with no safety concerns (Stockley''s p.121). '
    || 'Easley: addresses inflammation of joints and muscles.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- ── Cat's Claw: All (Antioxidant) ───────────────────────
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'All';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antioxidant';
  INSERT INTO herbal.herb_primary_actions
    (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_claw_id, v_action_id, v_sys_id,
    'Antioxidant from proanthocyanidins, catechin, epicatechin, quercetin, and ursolic acid.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Step 3 done: body system actions loaded.';
END $$;

-- ============================================================
-- STEP 4: Constituents
-- ============================================================

DO $$
DECLARE
  v_asaf_id  INTEGER;
  v_claw_id  INTEGER;
  v_c        INTEGER;
  c_ferulic_acid      CONSTANT INTEGER := 786;
  c_umbelliferone     CONSTANT INTEGER := 904;
  c_resins            CONSTANT INTEGER := 937;
  c_alkaloids         CONSTANT INTEGER := 1103;
  c_proanthocyanidins CONSTANT INTEGER := 778;
  c_catechin          CONSTANT INTEGER := 753;
  c_epicatechin       CONSTANT INTEGER := 754;
  c_quercetin         CONSTANT INTEGER := 741;
  c_ursolic_acid      CONSTANT INTEGER := 854;
  c_beta_sitosterol   CONSTANT INTEGER := 857;
BEGIN
  SELECT id INTO v_asaf_id FROM herbal.herbs WHERE latin_name = 'Ferula asafoetida';
  SELECT id INTO v_claw_id FROM herbal.herbs WHERE latin_name = 'Uncaria tomentosa';
  IF v_asaf_id IS NULL OR v_claw_id IS NULL THEN
    RAISE NOTICE 'Herbs not found — skipping constituents'; RETURN;
  END IF;

  -- ── Asafetida constituents ──────────────────────────────
  v_c := herbal.ensure_constituent(
    'sesquiterpene coumarins',
    'sesquiterpene coumarin',
    'Farnesiferols A, B, C; galbanic acid; saradaferin; gummosin — defining coumarin derivatives '
    || 'of Ferula species; responsible for anti-inflammatory and antispasmodic activity.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_asaf_id, v_c, 'primary', 10,
     'Farnesiferols A, B, C and galbanic acid are the principal coumarin markers of Ferula '
     || 'asafoetida; responsible for much of the antispasmodic and anticarcinogenic activity.')
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_asaf_id, c_ferulic_acid,  'major',    20,
     'Present as free ferulic acid and ferulic acid esters in the gum resin (Stockley''s).'),
    (v_asaf_id, c_umbelliferone, 'moderate', 30,
     'Natural coumarin derivative; one of the assafoetidnols in the gum resin.'),
    (v_asaf_id, c_resins,        'moderate', 40,
     'Gum resin is the primary commercial form; contains asaresinotannols, assafoetidnols, '
     || 'and an essential oil of disulfides, polysulfanes, monoterpenes, and phenylpropanoids.')
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- ── Cat's Claw constituents ─────────────────────────────
  v_c := herbal.ensure_constituent(
    'oxindole alkaloids',
    'oxindole alkaloid',
    'Tetracyclic (isorhynchophylline, rhynchophylline) and pentacyclic ((iso)pteropodine, '
    || '(iso)mitraphylline) oxindole alkaloids; defining pharmacological constituents of '
    || 'Uncaria tomentosa; immunomodulating, hypotensive, and anti-inflammatory activity. '
    || 'Two chemotypes exist with different alkaloid profiles.'
  );
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_claw_id, v_c, 'primary', 10,
     'Two chemotypes: tetracyclic (isorhynchophylline/rhynchophylline — antihypertensive, '
     || 'antiplatelet) and pentacyclic ((iso)pteropodine — immunomodulating). Some preparations '
     || 'are standardized to pentacyclic chemotype; note that tetracyclic alkaloids may antagonize '
     || 'the pentacyclic immunomodulating effect.')
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes)
  VALUES
    (v_claw_id, c_alkaloids,         'major',    20,
     'Indole alkaloids: dihydrocorynantheine, hirsutine, hirsuteine — alongside the defining oxindole alkaloids.'),
    (v_claw_id, c_proanthocyanidins, 'major',    30, NULL),
    (v_claw_id, c_catechin,          'moderate', 40, NULL),
    (v_claw_id, c_epicatechin,       'moderate', 50, NULL),
    (v_claw_id, c_quercetin,         'minor',    60, NULL),
    (v_claw_id, c_ursolic_acid,      'minor',    70, NULL),
    (v_claw_id, c_beta_sitosterol,   'minor',    80, NULL)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Step 4 done: constituents loaded.';
END $$;

-- ============================================================
-- STEP 5: Menstruum
-- ============================================================

DO $$
BEGIN
  PERFORM herbal.set_menstruum(
    'Ferula asafoetida',
    70::INTEGER, 90::INTEGER,
    NULL::INTEGER, NULL::INTEGER,
    false,
    '70–90% alcohol',
    'Sesquiterpene coumarins and gum resins require high-percentage alcohol; volatile sulfur '
    || 'compounds (disulfides, polysulfanes) concentrate in the essential oil fraction. '
    || 'MM recommends 1:5 in 85% alcohol for the gum tincture (5–20 drops). '
    || 'Not effective in water alone — resins precipitate.',
    false, false, false
  );

  PERFORM herbal.set_menstruum(
    'Uncaria tomentosa',
    40::INTEGER, 65::INTEGER,
    NULL::INTEGER, NULL::INTEGER,
    true,
    '40–65% alcohol or water decoction',
    'Dried bark (1:5, 60% alcohol) per Easley; 3–5 ml up to 3× daily. '
    || 'Oxindole and indole alkaloids extract in 40–60% alcohol; quinovic acid glycosides '
    || 'have moderate water solubility. Traditional South American bark decoction is effective '
    || 'and Easley lists standard decoction 6–12 oz 3× daily as a primary preparation.',
    false, false, false
  );

  RAISE NOTICE 'Step 5 done: menstruum set.';
END $$;

-- ============================================================
-- STEP 6: Keywords
-- ============================================================

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('cancer support',    'ailment'),
  ('digestive health',  'ailment'),
  ('lymphatic support', 'ailment'),
  ('carminative',       'action'),
  ('antispasmodic',     'action'),
  ('anti-inflammatory', 'action'),
  ('nervine',           'action'),
  ('antimicrobial',     'action'),
  ('anticarcinogenic',  'action'),
  ('expectorant',       'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Ferula asafoetida'
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
CROSS JOIN (VALUES
  ('cancer support',       'ailment'),
  ('immune support',       'ailment'),
  ('chemotherapy support', 'ailment'),
  ('arthritis',            'ailment'),
  ('inflammation',         'ailment'),
  ('autoimmune disease',   'ailment'),
  ('anti-inflammatory',    'action'),
  ('antimicrobial',        'action'),
  ('antiviral',            'action'),
  ('immune amphoteric',    'action'),
  ('antirheumatic',        'action'),
  ('antioxidant',          'action'),
  ('anticarcinogenic',     'action')
) AS kw(keyword, category)
WHERE h.latin_name = 'Uncaria tomentosa'
ON CONFLICT (herb_id, keyword) DO NOTHING;
