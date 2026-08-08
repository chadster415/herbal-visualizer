-- Migration 107: Add contraindications column, new primary actions, and populate
-- body system links / energetics / contraindications for herbs added in migration 106.
-- Run AFTER migration 106.

SET search_path TO herbal, public;

-- ── 1. Add contraindications column to herbs ─────────────────────────────────
ALTER TABLE herbal.herbs ADD COLUMN IF NOT EXISTS contraindications TEXT;

-- ── 2. New primary actions ───────────────────────────────────────────────────
DO $$
BEGIN
  PERFORM herbal.ensure_action('Nootropic');    -- cognitive enhancement / memory
  PERFORM herbal.ensure_action('Hypoglycemic'); -- blood sugar lowering
  PERFORM herbal.ensure_action('Styptic');      -- arrests bleeding (distinct from Astringent)
  RAISE NOTICE 'New primary actions ensured.';
END $$;

-- ── 3. Gotu Kola (Centella asiatica) ─────────────────────────────────────────
DO $$
DECLARE
  v_herb_id  INTEGER;
  v_sys_id   INTEGER;
  v_action_id INTEGER;
  v_all_id   INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Centella asiatica';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Gotu Kola not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    temperature    = 'cooling',
    contraindications = 'Contraindicated in pregnancy due to emmenagogue and abortifacient effects, unless used under the guidance of a qualified health care practitioner.'
  WHERE id = v_herb_id;

  -- Cardiovascular
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Circulatory Stimulant';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Used for phlebitis, varicose veins, leg ulcers, and hemorrhoids; improves ankle swelling, edema, and leg circulation', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Vascular Tonic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Normalizes connective tissue metabolism; enhances glycosaminoglycan synthesis without excessive collagen buildup; prevents and treats varicose veins and venous/arterial debility', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Anti-Inflammatory';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Reduces inflammation in venous and connective tissue; used for edema, leg heaviness, phlebitis, and stretch marks', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Nervous
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Nervous';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Nootropic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Improves memory and mental performance; acts as CNS depressant by elevating GABA levels; useful as part of a formula for head trauma recovery', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Nervine Relaxant';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Calming and supportive effect on the nervous system; calms mental chatter and reduces anxiety; used for impaired mental performance and stress', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Adaptogen';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Anti-stress herb shown to decrease adrenal enlargement; possesses corticosteroid-sparing effects and reduces stress-induced ulcers', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Skin
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Vulnerary';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Accelerates healing of wounds, burns, and ulcers; decreases keloid buildup after injury; applied as juice or poultice externally', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antimicrobial';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Asiaticoside constituent is antimicrobial; used for infected wounds and skin ulcers both topically and internally', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Urinary
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Diuretic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Supports fluid balance and helps reduce edema, particularly in venous conditions', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Digestive
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Laxative';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Used for sluggish digestion; also reduces stress-induced gastric ulcers', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Analgesic', 'Vulnerary', 'Adaptogen')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Gotu Kola: done.';
END $$;

-- ── 4. Gumweed (Grindelia squarrosa) ─────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Grindelia squarrosa';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Grindelia not found — run migration 106 first'; RETURN;
  END IF;

  UPDATE herbal.herbs SET
    contraindications = 'Large doses may produce kidney and stomach irritation. All resinous liquid extracts will precipitate in water and stick to the container.'
  WHERE id = v_herb_id;

  -- Respiratory - Lower
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Expectorant';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Used for coughs, generalized bronchial congestion, and asthma; useful in acute and subacute bronchitis with little secretion', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antispasmodic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Specific for individuals who stop breathing as they fall asleep and wake gasping; helpful for exercise-induced asthma taken one hour prior to exertion', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antimicrobial';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Used for all infectious respiratory illness with spasmodic coughs; also applied topically for poison oak and ivy rash', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Grindelia (Gumweed): done.';
END $$;

-- ── 5. Gymnema (Gymnema sylvestre) ───────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
  v_all_id    INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Gymnema sylvestre';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Gymnema not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    temperature    = 'cooling',
    contraindications = 'Do not use in cases of hypoglycemia — will exacerbate symptoms. Blood sugar must be monitored for rapid drops. Oral hypoglycemic drug or insulin dosages often need to be decreased when Gymnema is used. Gymnema desensitizes taste buds to sweet and bitter foods for approximately 3 hours; take in capsule form to avoid this effect.'
  WHERE id = v_herb_id;

  -- Digestive (primary mechanism: inhibits intestinal glucose absorption)
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Hypoglycemic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Inhibits glucose absorption from the intestine by binding glucose transport receptors; raises insulin sensitivity and may regenerate pancreatic beta cells; primary use is Type II diabetes management', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Cardiovascular (lipid/atherosclerosis effects)
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antioxidant';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Increases fecal excretion of cholesterol; reduces LDL oxidation; demonstrated antiatherosclerotic activity', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Anti-inflammatory')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Gymnema: done.';
END $$;

-- ── 6. Hibiscus (Hibiscus sabdariffa) ────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
  v_all_id    INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hibiscus sabdariffa';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Hibiscus not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    moisture       = 'drying',
    contraindications = 'Contraindicated in people with low blood pressure and orthostatic hypotension. Co-administration with hydrochlorothiazide is contraindicated — significantly increases urine volume, alters electrolytes, and raises plasma concentration of the drug. At very high doses (research doses) may elevate liver enzymes and creatinine in animals.'
  WHERE id = v_herb_id;

  -- Cardiovascular
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Cardiovascular';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Hypotensive';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Reduces blood pressure through ACE inhibition, calcium channel blocking, and vasodilation via nitric oxide; comparable to lisinopril in clinical trials; one cup of tea twice daily is the standard dose', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Cardiotonic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Supports endothelial nitric oxide production; anthocyanins inhibit LDL-C oxidation, protecting against atherosclerosis; modulates aldosterone for natriuretic and potassium-sparing effects', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Urinary
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Diuretic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Diuretic and natriuretic activity mediated by anthocyanins and chlorogenic acid via aldosterone modulation; reduces serum sodium without electrolyte imbalance; longer duration than hydrochlorothiazide', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Hypotensive', 'Anti-inflammatory', 'Cardiotonic', 'Diuretic')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Hibiscus: done.';
END $$;

-- ── 7. Pipsissewa (Chimaphila umbellata) ─────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
  v_all_id    INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Chimaphila umbellata';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Pipsissewa not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    temperature    = 'cooling',
    moisture       = 'drying',
    contraindications = 'Contraindicated during pregnancy. This is a slow-growing plant and could easily become endangered — source sustainably.'
  WHERE id = v_herb_id;

  -- Urinary
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Urinary';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antimicrobial';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Contains ~7.5% arbutin, which hydrolyzes to hydroquinone — an effective antimicrobial in alkaline urine; specific for scanty painful urination with mucus', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Diuretic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Increases renal circulation and stimulates tubular function; used for atonic chronic conditions with catarrh; also for prostatitis and BPH', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Immune (lymphatic)
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Lymphatic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Indicated for chronic genitourinary catarrh with lymphatic congestion; symptoms worse from damp weather and sitting on cold surfaces', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Astringent', 'Diuretic')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Pipsissewa: done.';
END $$;

-- ── 8. Psyllium (Plantago ovata) ─────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
  v_all_id    INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Plantago ovata';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Psyllium not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    moisture       = 'moistening',
    contraindications = 'Contraindicated in bowel obstruction, abnormal intestinal narrowing, and esophageal stenosis. Must always be taken with adequate water (at least 8 oz per dose). Oral drugs or herbs taken simultaneously may have delayed or decreased absorption due to mucilage content. May cause bloating and pain from slowed intestinal gas transit.'
  WHERE id = v_herb_id;

  -- Digestive
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Demulcent';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'High in mucilaginous fiber; soothes gastrointestinal mucosa; retains water in the intestine to ease defecation; water-insoluble husk supports beneficial colonic bacteria and short-chain fatty acid production', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Laxative';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Bulking agent used for both constipation and diarrhea; alters the colonic environment; also reduces serum cholesterol and improves glycemic control in diabetes', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Demulcent', 'Laxative')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Psyllium: done.';
END $$;

-- ── 9. White Oak (Quercus alba) ───────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
  v_all_id    INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Quercus alba';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'White Oak not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    moisture       = 'drying',
    contraindications = 'Contraindicated for external use with extensive skin surface damage. Strong full baths are contraindicated in cardiac insufficiency stages III and IV, febrile infectious disorders, and weeping eczema over a large body area.'
  WHERE id = v_herb_id;

  -- Digestive (GI ulcers, diarrhea, hemorrhoids, rectal prolapse)
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Astringent';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Specific for exhausted, atonic, and relaxed tissues; used for gastrointestinal ulcers, diarrhea, hemorrhoids, anal fissures, and rectal prolapse; indicated when there is bluish-yellow coloration of nodular varicosities', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Styptic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Arrests passive hemorrhages and venous laxity; used for bleeding hemorrhoids and other varicosities', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Skin (wounds, eczema, leg ulcers)
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Astringent';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Used for mucous membrane irritation, weeping excretions, gum ulcerations, sore throats, sinus congestion, weeping eczema, and leg ulcers; can be used as a compress for eye inflammation', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Immune (spleen and lymphatic support)
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Astringent';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Benefits the spleen and lymphatic system; indicated when there are symptoms from spleen or lymph node removal, or in states of splenitis or lymphatic congestion', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Astringent', 'Tonic')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'White Oak: done.';
END $$;

-- ── 10. Yohimbe (Pausinystalia johimbe) ──────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Pausinystalia johimbe';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Yohimbe not found — run migration 106 first'; RETURN;
  END IF;

  UPDATE herbal.herbs SET
    contraindications = 'CAUTION: This is a potentially dangerous herb. Side effects of yohimbine include high blood pressure, increased heart rate, manic reactions, bronchospasm, palpitations, insomnia, anxiety, and hypertensive crisis. Contraindicated with MAO inhibitors, tricyclic antidepressants, phenothiazines, antipsychotics, and blood pressure medications. Contraindicated in kidney disease, schizophrenia, anxiety, depression, PTSD, and bipolar disorder. 15–20 mg yohimbine can induce hypertension; 12 mg can induce hypertensive crisis with tricyclics; 10 mg can induce mania in bipolar disease.'
  WHERE id = v_herb_id;

  -- Reproductive - Male
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Male';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Nervine Stimulant';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Used for male erectile dysfunction via alpha-2 adrenergic receptor blockade in the brain and enhanced nitric oxide release from cavernosal endothelial cells; also used for orthostatic hypotension and narcolepsy', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Yohimbe: done.';
END $$;

-- ── 11. Yucca (Yucca spp.) ───────────────────────────────────────────────────
DO $$
DECLARE
  v_herb_id   INTEGER;
  v_sys_id    INTEGER;
  v_action_id INTEGER;
  v_all_id    INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Yucca spp.';
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'Yucca not found — run migration 106 first'; RETURN;
  END IF;
  SELECT id INTO v_all_id FROM herbal.body_systems WHERE name = 'All';

  UPDATE herbal.herbs SET
    temperature    = 'cooling',
    contraindications = 'Contraindicated during pregnancy unless used under the guidance of a qualified health professional.'
  WHERE id = v_herb_id;

  -- Musculoskeletal
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Musculoskeletal';

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Anti-Inflammatory';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Commonly used for both osteoarthritis and rheumatoid arthritis; believed to work by correcting intestinal bacterial balance, eliminating bad bacteria, and reducing systemic inflammation', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = 'Antispasmodic';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (v_herb_id, v_action_id, v_sys_id,
    'Saponins reduce inflammation and may reduce protozoa in the gut and ammonia formation; provides antispasmodic relief in arthritic conditions', NULL)
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Secondary
  INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id, body_system_id)
  SELECT v_herb_id, sa.id, v_all_id
  FROM herbal.secondary_actions sa
  WHERE sa.name IN ('Anti-inflammatory', 'Antispasmodic')
  ON CONFLICT (herb_id, secondary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Yucca: done.';
END $$;
