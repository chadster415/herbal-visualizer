SET search_path TO herbal, public;

-- ============================================================
-- Case Study: Skin
-- Primary: Skin lesions (venous stasis / chronic open sores), Athlete's foot
-- Patient: 52M, construction worker and summer river guide
-- ============================================================

-- Block 1 — Disorder, lifestyle notes, and actions indicated
DO $$
DECLARE
  v_sys_id    INTEGER;
  v_dis_id    INTEGER;
  v_action_id INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- General / Plan notes (green Notes box)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section) VALUES
    (v_dis_id, 'Wound wash routine: apply early and often — after showering, upon arriving home from work, and again after evening work; consistency is essential for resolution', 10, 'general'),
    (v_dis_id, 'After wound wash dries, rub the entire affected leg: first Chaparral tincture, then Myrrh tincture — Myrrh stimulates the innate immune response to signal the tissue that "this has to go"', 20, 'general'),
    (v_dis_id, 'Honey gauze patches applied directly to lesions for the first few days — medical-grade honey suppresses infection and maintains a moist wound environment; discontinued when daily upkeep became too complex to maintain', 30, 'general'),
    (v_dis_id, 'After approximately one month of wound care, transition from tincture rub to oilination with Calendula oil — shifts tissue focus from infection clearance to nourishment and regeneration', 40, 'general'),
    (v_dis_id, 'Once leg lesions resolved, shift focus to athlete''s foot: apply Chaparral drops directly into the nail bed for 2 weeks', 50, 'general'),
    (v_dis_id, 'Increase vegetable portions to 8–10 servings daily — broadens micronutrient intake, reduces inflammatory load, and supports tissue repair', 60, 'general'),
    (v_dis_id, 'Experiment with removing gluten, dairy, and/or beer — each may contribute to gut permeability and chronic inflammatory skin conditions', 70, 'general'),
    (v_dis_id, 'Elevate legs against the wall 20 minutes daily after work — reduces venous pressure and supports lymphatic return from the lower extremities', 80, 'general'),
    (v_dis_id, 'Exercycle or low-impact cycling to increase pelvic and leg circulation — improves venous and lymphatic drainage from chronically stagnant lower limbs (patient was resistant; offered as an option)', 90, 'general')
  ON CONFLICT DO NOTHING;

  -- Actions indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Directly targets the bacterial and fungal infection driving the open skin lesions and chronic athlete''s foot; Chaparral and Myrrh provide broad-spectrum topical antimicrobial coverage, while Tea Tree adds potent antifungal and antibacterial action.', 10)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Vulnerary');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Promotes wound closure, reduces inflammation, and supports tissue regeneration in the open sores; Plantain is the cornerstone wound herb here, layered with Calendula, Chamomile, Rose, Yarrow, and Lavender for complementary healing and anti-inflammatory support.', 20)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Immune Stimulant');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Stimulates the innate immune response to actively clear infection; Echinacea provides systemic immune activation while Myrrh stimulates local immune surveillance in the affected tissues.', 30)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Lymphatic Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Clears lymphatic stagnation in the lower extremities — a core driver of poor wound healing and chronic skin infection; Red Root and Ocotillo move lymph drainage and reduce the fluid accumulation keeping the lesions open.', 40)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_dis_id, v_action_id, 'Supports liver clearance of metabolic waste from tissue breakdown and die-off; added when a detox rash emerged on the thighs, indicating the liver needed support to process the increased toxic load as the infection resolved.', 50)
  ON CONFLICT (disorder_id, primary_action_id) DO NOTHING;

  -- Disorder action herbs

  -- Antimicrobial: Tea Tree, Chaparral, Myrrh, Yarrow, Lavender
  v_action_id := herbal.ensure_action('Antimicrobial');
  v_herb_id := herbal.ensure_herb('Melaleuca spp.', 'Tea Tree');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Larrea tridentata', 'Chaparral');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'Myrrh');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 40) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'Lavender');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 50) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Vulnerary: Plantain, Calendula, Chamomile, Rose (petal), Yarrow, Lavender
  v_action_id := herbal.ensure_action('Vulnerary');
  v_herb_id := herbal.ensure_herb('Plantago major', 'Plantain');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'Chamomile');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Rosa spp.', 'Rose', 'petal');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 40) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 50) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'Lavender');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 60) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Immune Stimulant: Echinacea, Myrrh
  v_action_id := herbal.ensure_action('Immune Stimulant');
  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'Echinacea');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Commiphora molmol', 'Myrrh');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Lymphatic Tonic: Red Root, Ocotillo
  v_action_id := herbal.ensure_action('Lymphatic Tonic');
  v_herb_id := herbal.ensure_herb('Ceanothus americanus', 'Red Root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Fouquieria splendens', 'Ocotillo');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  -- Hepatic: Dandelion Root, Burdock Root, Milk Thistle
  v_action_id := herbal.ensure_action('Hepatic');
  v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'Dandelion', 'root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 10) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Arctium lappa', 'Burdock');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 20) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;
  v_herb_id := herbal.ensure_herb('Silybum marianum', 'Milk Thistle');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_dis_id, v_herb_id, v_action_id, 30) ON CONFLICT (disorder_id, herb_id, primary_action_id) DO NOTHING;

  RAISE NOTICE 'Block 1 done — Skin Case Study';
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
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- ─── Wound Wash ──────────────────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Wound Wash', 'Apply topically after showering, upon arriving home from work, and after evening work. Let dry before the tincture rub step.', 10)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Larrea tridentata', 'Chaparral');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Lavandula spp.', 'Lavender');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'EO or infusion', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Plantago major', 'Plantain');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Matricaria recutita', 'Chamomile');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 50);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Rosa spp.', 'Rose', 'petal');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 60);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;
  END IF;

  -- ─── Topical Tincture Rub ─────────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Topical Tincture Rub', 'After wound wash dries, rub the entire affected leg — first Chaparral tincture, then Myrrh tincture. Apply in sequence. After ~1 month, transition to Calendula oil oilination.', 20)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Larrea tridentata', 'Chaparral');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'apply first', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Commiphora molmol', 'Myrrh');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'apply second — stimulates innate immune response', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Antimicrobial')) ON CONFLICT DO NOTHING;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Immune Stimulant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Calendula officinalis', 'Calendula');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'oil — used after ~1 month once infection is cleared', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Vulnerary')) ON CONFLICT DO NOTHING;
  END IF;

  -- ─── Internal Immune Tincture ─────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Internal Immune Tincture', '2 droppers 3–4× daily. Milk Thistle added to this blend after detox rash emerged.', 30)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Echinacea spp.', 'Echinacea');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', '2 parts', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Immune Stimulant')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Ceanothus americanus', 'Red Root');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', '2 parts', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic Tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Fouquieria splendens', 'Ocotillo');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', '1 part', 30);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Lymphatic Tonic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Silybum marianum', 'Milk Thistle');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'added after detox rash emerged', 40);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;
  END IF;

  -- ─── Detox Support Tea ──────────────────────────────────────────
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_dis_id, 'Detox Support Tea', 'Brew as a decoction. Added to the protocol when a detox rash emerged on the thighs, indicating the liver needed additional support.', 40)
  ON CONFLICT DO NOTHING RETURNING id INTO v_rx_id;

  IF v_rx_id IS NOT NULL THEN
    v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'Dandelion', 'root');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 10);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;

    v_herb_id := herbal.ensure_herb('Arctium lappa', 'Burdock');
    INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
    VALUES (v_rx_id, v_herb_id, '', 'root', 20);
    SELECT id INTO v_ph_id FROM herbal.prescription_herbs WHERE prescription_id = v_rx_id AND herb_id = v_herb_id;
    INSERT INTO herbal.prescription_herb_actions VALUES (DEFAULT, v_ph_id, herbal.ensure_action('Hepatic')) ON CONFLICT DO NOTHING;
  END IF;

  RAISE NOTICE 'Block 2 done — prescriptions';
END $$;

-- Block 3 — Sync herb_primary_actions from prescription_herb_actions
DO $$
DECLARE v_sys_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';
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

-- Block 4 — Subjective notes (sort_order 200–270)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, '52 year old cis male', 200, 'subjective', NULL),
    (v_dis_id, 'Worried about skin lesions emerging on the back of his leg', 210, 'subjective', 'Chief Concern'),
    (v_dis_id, 'Lesions are itchy and have been opening up into sores', 220, 'subjective', 'Chief Concern'),
    (v_dis_id, 'Works in construction; serves as a river guide in summer', 230, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Prefers beer and comfort food; limited time to cook', 240, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Some digestive discomfort — not elaborated', 250, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Chronic athlete''s foot', 260, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Lives in a moldy basement apartment — ongoing environmental mold exposure', 270, 'subjective', 'Lifestyle')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 4 done — subjective notes';
END $$;

-- Block 5 — Objective notes (sort_order 600)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Skin';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'No lab work available', 600, 'objective', NULL)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Block 5 done — objective notes';
  RAISE NOTICE 'Migration 349 complete — Skin case study inserted.';
END $$;
