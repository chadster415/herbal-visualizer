SET search_path TO herbal, public;

-- Add a "Supplements" prescription to the Digestive and Immune case studies,
-- linking supplements from the treatment plan via prescription_supplements.

-- Digestive case study (Carla): Magnesium citrate
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
  v_rx_id  INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = v_dis_id AND title = 'Supplements';

  IF v_rx_id IS NULL THEN
    INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_dis_id, 'Supplements', 'As directed per supplement.', 30)
    RETURNING id INTO v_rx_id;
  END IF;

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, note, sort_order)
  VALUES (v_rx_id, 21, 'max 2 tsp', 'Magnesium citrate — mix with black salt for tenacious constipation', 10)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Digestive case study: Supplements prescription done (rx_id=%)', v_rx_id;
END $$;

-- Immune case study (Peter): Quercetin
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
  v_rx_id  INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  SELECT id INTO v_rx_id FROM herbal.disorder_prescriptions
  WHERE disorder_id = v_dis_id AND title = 'Supplements';

  IF v_rx_id IS NULL THEN
    INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
    VALUES (v_dis_id, 'Supplements', 'As directed per supplement.', 20)
    RETURNING id INTO v_rx_id;
  END IF;

  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_rx_id, 40, '50mg 2× daily', 10)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Immune case study: Supplements prescription done (rx_id=%)', v_rx_id;
END $$;
