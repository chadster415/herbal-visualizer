-- Migration 279: Japanese Knotweed and Pedicularis — full herb data
-- Synonyms, contraindications (Pedicularis/MM only), primary actions,
-- general constituents, energetics (inferred), taste (inferred), menstruum.
--
-- Run AFTER migration 278.

SET search_path TO herbal, public;

-- ═══════════════════════════════════════════════════════════════
-- JAPANESE KNOTWEED (Reynoutria japonica)
-- Not in MM, Stockley's, Easley's, Hoffmann's, or Tilgner's.
-- ═══════════════════════════════════════════════════════════════
DO $$
DECLARE
  v_herb_id INTEGER;
  v_sys_id  INTEGER;
  v_act_id  INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'reynoutria japonica';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Japanese Knotweed not found — run migration 278 first.'; RETURN; END IF;

  -- Synonyms
  UPDATE herbal.herbs
  SET synonyms = ARRAY['Hu Zhang', 'Tiger Cane', 'Fallopia japonica', 'Polygonum cuspidatum', 'Mexican Bamboo', 'Itadori']
  WHERE id = v_herb_id
    AND (synonyms IS NULL OR synonyms = '{}');

  -- Primary actions
  -- Anti-Inflammatory / Musculoskeletal
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Anti-Inflammatory';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Potent anti-inflammatory for musculoskeletal conditions; resveratrol and emodin inhibit COX-2 and NF-κB pathways; used for Lyme-associated arthritis and inflammatory joint disease.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antiviral / Immune
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Antiviral';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Strongly antiviral via resveratrol and emodin; studied for Lyme disease co-infections and broad antiviral spectrum including herpes viruses.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antimicrobial / Immune
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Antimicrobial';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Antibacterial including against Borrelia burgdorferi; stilbenoids and anthraquinones provide broad-spectrum antimicrobial activity.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antirheumatic / Musculoskeletal
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Antirheumatic';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Anti-inflammatory and antioxidant properties reduce joint pain and stiffness in rheumatic conditions.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Antioxidant / Cardiovascular
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Antioxidant';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Cardiovascular';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Resveratrol provides potent cardiovascular antioxidant protection; supports vascular health and reduces oxidative damage to vascular tissue.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- General constituents
  -- Resveratrol — primary defining stilbenoid (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'resveratrol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'primary',
    'Defining stilbenoid; antioxidant, anti-inflammatory, antiviral, and cardioprotective. Highest in root bark.',
    10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Polydatin — glycoside form of resveratrol (new constituent)
  v_c := herbal.ensure_constituent(
    'polydatin',
    'stilbenoid glycoside',
    'Glycosylated form of resveratrol (piceid; trans-resveratrol-3-O-β-D-glucopyranoside); predominant stilbenoid in Japanese Knotweed root bark with higher water solubility than free resveratrol.'
  );
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Predominant stilbenoid in the root bark; glycoside form of resveratrol.',
    20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Emodin — anthraquinone (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'emodin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Major anthraquinone contributing anti-inflammatory, antiviral, and bitter activity.',
    30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Physcion — co-occurring anthraquinone (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'physcion';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Quercetin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'quercetin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Rutin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'rutin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Catechin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'catechin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Kaempferol (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'kaempferol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Beta-sitosterol (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'beta-sitosterol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 90)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Energetics (inferred)
  -- Anthraquinone present (emodin at major) → cooling (high confidence)
  -- Flavan-3-ol at moderate (catechin) → drying (high confidence)
  UPDATE herbal.herbs
  SET temperature = 'cooling', temperature_inferred = true,
      moisture    = 'drying',  moisture_inferred    = true
  WHERE id = v_herb_id
    AND temperature IS NULL;

  -- Taste (inferred)
  -- Anthraquinone present → bitter (high confidence)
  UPDATE herbal.herbs
  SET taste = 'bitter', taste_inferred = true
  WHERE id = v_herb_id
    AND taste IS NULL;

  -- Menstruum
  PERFORM herbal.set_menstruum(
    'reynoutria japonica',
    50::INTEGER,
    70::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '50–70% alcohol or water decoction',
    'Stilbenoids (resveratrol, polydatin) require 50–70% alcohol for full extraction; resveratrol is poorly water-soluble. Anthraquinones (emodin, physcion) and flavonoids (quercetin, rutin) also extract in water. Traditional TCM decoction (Hu Zhang) is effective for the anthraquinone and flavonoid fraction; alcohol tincture captures the complete stilbenoid profile.',
    false,
    false,
    false
  );

  RAISE NOTICE 'Japanese Knotweed data: done.';
END $$;


-- ═══════════════════════════════════════════════════════════════
-- PEDICULARIS (Pedicularis spp.)
-- Found in MM; not in Stockley's, Easley's, Hoffmann's, or Tilgner's.
-- After migration 278 is applied, re-run scripts/parse-mm-materia-medica.py
-- to add the Pedicularis MM dosage entry to lib/mm-materia-medica.ts.
-- ═══════════════════════════════════════════════════════════════
DO $$
DECLARE
  v_herb_id INTEGER;
  v_sys_id  INTEGER;
  v_act_id  INTEGER;
  v_c       INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'pedicularis spp.';
  IF v_herb_id IS NULL THEN RAISE NOTICE 'Pedicularis not found — run migration 278 first.'; RETURN; END IF;

  -- Synonyms
  UPDATE herbal.herbs
  SET synonyms = ARRAY['Lousewort', 'Betony', 'Elephant Head', 'Parrot Beak', 'Indian Warrior']
  WHERE id = v_herb_id
    AND (synonyms IS NULL OR synonyms = '{}');

  -- Contraindications (MM)
  -- "A semi-parasitic genus, don't use Pedicularis growing on Senecio or toxic legumes."
  UPDATE herbal.herbs
  SET contraindications        = 'Semi-parasitic genus — do not use Pedicularis growing on Senecio or toxic legumes (per MM).',
      contraindications_source = 'MM'
  WHERE id = v_herb_id
    AND contraindications IS NULL;

  -- Primary actions
  -- Antispasmodic / Musculoskeletal
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Antispasmodic';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Primary skeletal muscle relaxant and antispasmodic; used for muscle tension, spasm, and overuse injuries from tightness. Among the most musculoskeletal-specific of the nervine herbs.',
    'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Nervine Relaxant / Nervous
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Nervine Relaxant';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Mild nervine relaxant; settles nervous system tension that drives muscular holding patterns; non-sedating at standard doses.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Analgesic / Musculoskeletal
  SELECT id INTO v_act_id FROM herbal.primary_actions WHERE name = 'Analgesic';
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_act_id, v_sys_id,
    'Reduces musculoskeletal pain from spasm and tension; analgesic effect is secondary to and complementary with the antispasmodic action.',
    'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- General constituents
  -- Aucubin — primary iridoid glycoside (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'aucubin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Primary iridoid glycoside; skeletal muscle relaxant and anti-inflammatory activity.',
    10)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Verbascoside — phenylethanoid glycoside (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'verbascoside';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'major',
    'Phenylethanoid glycoside (acteoside); antioxidant and anti-inflammatory.',
    20)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Luteolin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 30)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Catalpol — co-occurring iridoid glycoside (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'catalpol';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 40)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Luteolin-7-glucoside (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'luteolin-7-glucoside';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'moderate', NULL, 50)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Apigenin (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'apigenin';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Caffeic acid (already in DB)
  SELECT id INTO v_c FROM herbal.constituents WHERE name = 'caffeic acid';
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, notes, sort_order)
  VALUES (v_herb_id, v_c, 'minor', NULL, 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- Energetics (inferred)
  -- Iridoid glycoside at major (aucubin) → cooling (high confidence)
  -- Moisture: no clear signal from this constituent profile → leave unset
  UPDATE herbal.herbs
  SET temperature = 'cooling', temperature_inferred = true
  WHERE id = v_herb_id
    AND temperature IS NULL;

  -- Taste (inferred)
  -- Iridoid glycoside at major (aucubin) → bitter (high confidence)
  UPDATE herbal.herbs
  SET taste = 'bitter', taste_inferred = true
  WHERE id = v_herb_id
    AND taste IS NULL;

  -- Menstruum
  -- MM: "Standard Infusion, 4–8 oz. Tincture [Fresh Plant 1:2, Dry Plant 1:5, 50% alcohol] 1–2 tsp, 3x/day"
  PERFORM herbal.set_menstruum(
    'pedicularis spp.',
    50::INTEGER,
    60::INTEGER,
    NULL::INTEGER,
    NULL::INTEGER,
    true,
    '50% alcohol or water infusion',
    'MM specifies fresh plant (1:2) or dry plant (1:5, 50% alcohol) tincture; standard infusion also recommended. Iridoid glycosides (aucubin, catalpol), phenylethanoid glycosides (verbascoside), and flavonoids (luteolin) all extract in 50% alcohol and water infusion. Prefer fresh plant tincture where available for best skeletal muscle relaxant activity.',
    false,
    false,
    false
  );

  RAISE NOTICE 'Pedicularis data: done.';
END $$;
