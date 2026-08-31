SET search_path TO herbal, public;

-- ============================================================
-- Case Study: Reproductive - Female
-- Primary: Uterine fibroids, vaginitis
-- Patient: 47F, 150 lbs, 5'4"
-- is_case_study and heading columns already exist (migrations 119, 120)
-- ============================================================

-- Block 1 — Disorder, lifestyle notes, and actions indicated
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- General / Plan notes (green Notes box, sort_order 10–190)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'Vitamin D 5000 IU daily for 6 months, then reduce to 2000 IU — supports hormone regulation and immune function', 10, 'general'),
    (v_dis_id, 'Calcium citrate supplementation', 20, 'general'),
    (v_dis_id, 'Flax seed 2 tablespoons daily — lignans modulate estrogen metabolism; also provides omega-3 fatty acids for inflammation', 30, 'general'),
    (v_dis_id, '4–5 cups vegetables daily', 40, 'general'),
    (v_dis_id, 'Minimum 54 g protein per day; chickpeas are lysine-rich but low in methionine — pair with grains (brown rice, barley, whole-wheat pita) or tahini/sesame to complete the amino acid profile', 50, 'general'),
    (v_dis_id, 'Bitter formula before meals — stimulates liver function for hormone clearance and improves digestive output', 60, 'general'),
    (v_dis_id, '3–4× per week fermented foods with meals (sauerkraut) — supports gut flora alongside existing vaginal probiotic supplement', 70, 'general'),
    (v_dis_id, '¼ tsp gray salt in water daily', 80, 'general'),
    (v_dis_id, 'Oilination (self-massage with warm oil) 1× per week — addresses dry skin and supports lymphatic and circulatory flow', 90, 'general'),
    (v_dis_id, 'Dry brushing 1× per week — supports lymphatic drainage and skin health', 100, 'general'),
    (v_dis_id, 'Sitz bath 1–2× per week with Calendula, Elecampane, Rose petals, and Yarrow — topical antimicrobial and anti-inflammatory support for vaginitis', 110, 'general'),
    (v_dis_id, 'Plan 2 weeks of menus — build structure and routine around meal preparation to address poor appetite and irregular eating habits', 120, 'general'),
    (v_dis_id, 'Add warming spices to foods — supports digestion and circulation', 130, 'general'),
    (v_dis_id, 'Make dedicated mealtime a priority — ritualized eating may improve poor appetite and digestive engagement', 140, 'general'),
    (v_dis_id, 'Add Magnesium to supplement regimen — addresses muscle tension, restless sleep, and anxiety', 150, 'general'),
    (v_dis_id, 'Avoid cold foods; emphasize warm and wet foods — supports digestion and circulation', 160, 'general'),
    (v_dis_id, 'As care deepens: castor oil packs, low-level heat, and gua sha on the abdomen to address fibroid tissue directly', 170, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions indicated
  v_action_id := herbal.ensure_action('Hormonal Regulator');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Addresses the root hormonal imbalance driving fibroid growth: Vitex normalizes LH and progesterone ratios; White Peony improves the DHEA-to-cortisol ratio to promote progesterone production; Licorice provides synergistic flavone action for estrogen balance.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Alterative');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Red Clover provides phytoestrogenic support and helps clear metabolic waste from circulation — classically indicated for tissue conditions including fibroids.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antispasmodic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Reduces cramping and heavy menstrual bleeding associated with fibroids; White Peony relaxes uterine smooth muscle tension.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Calms inflammation in uterine tissue; Licorice and White Peony address systemic and local inflammation; Cinnamon improves local circulation and adds anti-inflammatory action.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Adaptogen');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Licorice modulates the cortisol-DHEA ratio — a key mechanism in its synergy with White Peony for hormone balance; supports adrenal function already partially addressed by her supplement blend.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Carminative');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Addresses persistent gas, bloating, and abdominal pain — digestive symptoms aggravated by stress and likely compounded by dietary factors including whey protein.', 60)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Cinnamon in the tincture provides internal antimicrobial action; sitz bath with Calendula, Elecampane, Rose petals, and Yarrow addresses vaginitis topically.', 70)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs (herb bubbles under each action in the UI)

  -- Hormonal Regulator: Vitex (Chasteberry), White Peony, Licorice
  v_action_id := herbal.ensure_action('Hormonal Regulator');
  v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'Chasteberry');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony', 'root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Alterative: Red Clover
  v_action_id := herbal.ensure_action('Alterative');
  v_herb_id := herbal.ensure_herb('Trifolium pratense', 'Red Clover');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Antispasmodic: White Peony, Cinnamon
  v_action_id := herbal.ensure_action('Antispasmodic');
  v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony', 'root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Cinnamomum spp.', 'Cinnamon');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Anti-inflammatory: Licorice, White Peony
  v_action_id := herbal.ensure_action('Anti-inflammatory');
  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony', 'root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Adaptogen: Licorice
  v_action_id := herbal.ensure_action('Adaptogen');
  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Carminative: Cinnamon
  v_action_id := herbal.ensure_action('Carminative');
  v_herb_id := herbal.ensure_herb('Cinnamomum spp.', 'Cinnamon');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Antimicrobial: Cinnamon (internal tincture), Calendula, Yarrow (sitz bath)
  v_action_id := herbal.ensure_action('Antimicrobial');
  v_herb_id := herbal.ensure_herb('Cinnamomum spp.', 'Cinnamon');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Block 1 done — Reproductive Female Case Study';
END $$;

-- Block 2 — Prescriptions
DO $$
DECLARE
  v_sys_id  INTEGER;
  v_dis_id  INTEGER;
  v_rx_id   INTEGER;
  v_herb_id INTEGER;
  v_ph_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- ─── Fibroid & Hormone Tincture ─────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Fibroid & Hormone Tincture', '2 tsp 3× daily.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Red Clover 3 parts — Alterative
    v_herb_id := herbal.ensure_herb('Trifolium pratense', 'Red Clover');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '3 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Alterative')) ON CONFLICT DO NOTHING;

    -- Vitex (Chasteberry) 3 parts — Hormonal Regulator
    v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'Chasteberry');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '3 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;

    -- White Peony root 2 parts — Antispasmodic, Hormonal Regulator
    v_herb_id := herbal.ensure_herb('Paeonia lactiflora', 'White Peony', 'root');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '2 parts', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antispasmodic')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;

    -- Cinnamon 2 parts — Carminative, Anti-inflammatory
    v_herb_id := herbal.ensure_herb('Cinnamomum spp.', 'Cinnamon');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '2 parts', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Carminative')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;

    -- Licorice 1 part — Adaptogen, Hormonal Regulator
    v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '1 part', 'synergistic with White Peony for hormone modulation', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Adaptogen')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hormonal Regulator')) ON CONFLICT DO NOTHING;
  END IF;

  -- ─── Sitz Bath ──────────────────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Sitz Bath', 'Steep equal parts as a strong tea; use warm (not hot) water in a shallow sitz basin. Soak for 15–20 minutes, 1–2× per week.', 20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    -- Calendula — Anti-inflammatory, Vulnerary
    v_herb_id := herbal.ensure_herb('Calendula officinalis', 'Calendula');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Anti-inflammatory')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;

    -- Elecampane — Antimicrobial
    v_herb_id := herbal.ensure_herb('Inula helenium', 'Elecampane');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    -- Rose (petal) — Astringent, Demulcent
    v_herb_id := herbal.ensure_herb('Rosa spp.', 'Rose', 'petal');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Demulcent')) ON CONFLICT DO NOTHING;

    -- Yarrow — Astringent, Antimicrobial
    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Astringent')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Block 2 done — prescriptions';
END $$;

-- Block 3 — Sync herb_primary_actions from prescription_herb_actions
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
  SELECT DISTINCT ph.herb_id, pha.primary_action_id, v_sys_id
  FROM herbal.prescription_herb_actions pha
  JOIN herbal.prescription_herbs ph ON ph.id = pha.prescription_herb_id
  JOIN herbal.disorder_prescriptions dp ON dp.id = ph.prescription_id
  JOIN herbal.disorders d ON d.id = dp.disorder_id
  WHERE d.body_system_id = v_sys_id AND d.is_case_study = TRUE
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Block 3 done — synced herb_primary_actions';
END $$;

-- Block 4 — Subjective notes (sort_order 200–590)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    -- Demographics (NULL heading → renders as intro paragraph)
    (v_dis_id, 'Patient is 47 years old, 150 lbs, 5''4"', 200, 'subjective', NULL),
    -- Primary Health Concerns
    (v_dis_id, 'Uterine fibroids', 210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Vaginitis (recurring)', 220, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Heavy menses', 230, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Recurring UTI', 240, 'subjective', 'Primary Health Concerns'),
    -- Nutrition
    (v_dis_id, 'Avoids beef, chicken, pork, dairy, and gluten', 250, 'subjective', 'Nutrition'),
    (v_dis_id, 'Protein from chickpea powder and whey shakes; poor appetite', 260, 'subjective', 'Nutrition'),
    (v_dis_id, 'Chickpeas are high in lysine but low in methionine — pair with grains (brown rice, barley, pita) or tahini to complete the amino acid profile', 270, 'subjective', 'Nutrition'),
    (v_dis_id, 'Whey protein may be contributing to digestive distress despite otherwise avoiding dairy', 280, 'subjective', 'Nutrition'),
    -- Digestive Symptoms
    (v_dis_id, 'Loose stools 1–2× per day; prone to stress diarrhea', 290, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'Gas, bloating, and abdominal pain', 300, 'subjective', 'Digestive Symptoms'),
    (v_dis_id, 'Hemorrhoids', 310, 'subjective', 'Digestive Symptoms'),
    -- Other Symptoms
    (v_dis_id, 'Anxiety and depression', 320, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Restless sleep and muscle tension', 330, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Lack of sex drive', 340, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Sinus headaches and general headaches', 350, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Dry skin and brittle fingernails', 360, 'subjective', 'Other Symptoms'),
    -- Current Supplements
    (v_dis_id, 'Lo Loestrin Fe (oral contraceptive) — may be thickening cervical mucus and contributing to vaginitis; headaches are a listed side effect', 370, 'subjective', 'Current Supplements'),
    (v_dis_id, 'Garden of Life Vaginal Care Probiotics', 380, 'subjective', 'Current Supplements'),
    (v_dis_id, 'MegaFood Blood Builder (iron) — appropriate given heavy menses', 390, 'subjective', 'Current Supplements'),
    (v_dis_id, 'Garden of Life Adrenal Support (Ashwagandha, Rhodiola, Shatavari) — already receiving adaptogenic and estrogenic support; Shatavari is a phytoestrogenic herb; coordinate with new formula', 400, 'subjective', 'Current Supplements')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 4 done — subjective notes';
END $$;

-- Block 5 — Objective notes (sort_order 600–790)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'No lab work available', 600, 'objective', NULL)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 5 done — objective notes';
  RAISE NOTICE 'Migration 244 complete — Reproductive Female case study inserted.';
END $$;
