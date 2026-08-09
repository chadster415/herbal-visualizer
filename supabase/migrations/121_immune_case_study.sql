SET search_path TO herbal, public;

-- Immune system case study (Peter) — Subjective and Objective only.
-- Actions, lifestyle notes, and prescriptions to be added in a later migration
-- when the treatment plan is available.

DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  IF v_sys_id IS NULL THEN RAISE EXCEPTION 'Immune body system not found'; END IF;

  INSERT INTO herbal.disorders (name, body_system_id, sort_order, is_case_study)
  VALUES ('Case Study', v_sys_id, 0, TRUE)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  SELECT id INTO v_dis_id FROM herbal.disorders
  WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  -- ── Subjective ─────────────────────────────────────────────────────────────

  -- Demographics (no heading → renders as intro paragraph)
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading)
  VALUES (v_dis_id, 'Peter is 42 years old, 165 lbs, 5''7"', 200, 'subjective', NULL)
  ON CONFLICT DO NOTHING;

  -- Primary Health Concerns
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Vomiting or choking with the first bite of the first meal — once or twice every 2 weeks for the past 3 months; feels hot and hungry when it happens', 210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Does not want to take prescribed Eosinophilic Esophagitis medications', 220, 'subjective', 'Primary Health Concerns')
  ON CONFLICT DO NOTHING;

  -- Nutrition
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Cereal for breakfast', 250, 'subjective', 'Nutrition'),
    (v_dis_id, 'Diet heavy in burgers, burritos, barbecue, and beer', 260, 'subjective', 'Nutrition'),
    (v_dis_id, 'Drinks 10–15 beers per week', 270, 'subjective', 'Nutrition'),
    (v_dis_id, 'Describes himself as eating fast', 280, 'subjective', 'Nutrition'),
    (v_dis_id, 'Normal water intake', 290, 'subjective', 'Nutrition')
  ON CONFLICT DO NOTHING;

  -- Lifestyle
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Desk job working from home in the basement', 310, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Plays golf', 320, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Goes to the gym 2–3 times per week', 330, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Likes to travel', 340, 'subjective', 'Lifestyle'),
    (v_dis_id, 'Enjoys food; loves beer', 350, 'subjective', 'Lifestyle')
  ON CONFLICT DO NOTHING;

  -- Other Symptoms
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'Cold extremities', 400, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Does not urinate until noon', 410, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Allergic rhinitis (seasonal)', 420, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Athlete''s foot', 430, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Hemorrhoids', 440, 'subjective', 'Other Symptoms'),
    (v_dis_id, '2 benign colon polyps', 450, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Tends toward constipation; bowel movement daily', 460, 'subjective', 'Other Symptoms')
  ON CONFLICT DO NOTHING;

  -- ── Objective ──────────────────────────────────────────────────────────────

  -- Vital Signs
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading)
  VALUES (v_dis_id, 'Blood pressure: 170/90 (elevated)', 600, 'objective', 'Vital Signs')
  ON CONFLICT DO NOTHING;

  -- Diagnoses
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading)
  VALUES (v_dis_id, 'Eosinophilic Esophagitis (declines prescribed medication)', 620, 'objective', 'Diagnoses')
  ON CONFLICT DO NOTHING;

  -- Current Medications
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading)
  VALUES (v_dis_id, 'Daily medication for hypertension', 640, 'objective', 'Current Medications')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Immune case study: Subjective and Objective inserted';
END $$;
