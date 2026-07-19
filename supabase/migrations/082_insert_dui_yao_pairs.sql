SET search_path TO herbal, public;

-- Insert 122 Dui Yao pairs with indications and herb properties.
-- Herb IDs are looked up by latin_name at runtime.
-- Re-runnable: ON CONFLICT DO NOTHING on all inserts.

-- Pair 1: Bai He & Zhi Mu (p.15)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Bulbus Lilii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Anemarrhenae Aspheloidis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Bulbus Lilii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Anemarrhenae Aspheloidis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 15, 'image00031.jpg', 'One moistens, while the other clears. One supplements, while the other drains. Together they moisten the lungs and clear heat, nourish the heart and quiet the spirit.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vexation and agitation, insomnia, vertigo, thirst related to a warm disease which has damaged heart yin or due to yin vacuity with vacuity heat', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dry cough, vexation and agitation after a warm disease', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lily disease (mental depression with anxiety, taciturnity, desire to sleep without being able to)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes heart yin and quiets the spirit', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears & moistens the lungs, stops coughing', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet & cold but moistens without being slimy', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tends to supplement', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-30g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and drains fire', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Enriches yin and moistens dryness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter & cold but drains fire without drying', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to drain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 2: Bai Ji & San Qi (p.16)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Bletillae Striatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Pseudoginseng';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Bletillae Striatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Pseudoginseng';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 16, 'image00032.jpg', 'One is fixed, while the other is traveling. One is astringing; the other is draining. Together they effectively dispel stasis, stop bleeding, and engender muscle (flesh) without producing blood stasis.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hemoptysis', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hematemesis', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Bleeding caused by trauma', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops bleeding by astringing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses swelling, promotes granulation and engenders muscles (flesh)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly treats diseases of the lungs & stomach', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops bleeding, quickens the blood, dispels stasis', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses swelling', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats all kinds of bleeding', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 3: Bai Ji Li & Sha Yuan Zi (p.16)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Tribuli Terrestris';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Astragali Complanati';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Tribuli Terrestris';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Astragali Complanati';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 16, 'image00032.jpg', 'One upbears; the other downbears. One is channeled towards the liver; the other towards the kidneys. Together they regulate upbearing and downbearing, course the liver and rectify the qi, resolve depression and calm the liver, and supplement harmoniously the liver and kidneys.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, unclear vision due to liver and kidney vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lumbar pain, seminal emission, premature ejaculation, frequent urination due to kidney vacuity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abnormal vaginal discharge due to kidney vacuity', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, bitter, upbearing, dispersing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Key tropism: the liver', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Calms the liver and resolves depression', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind heat from liver channel and brightens the eyes', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly treats repletion', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, mild, supplementing, astringing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Key tropism: the kidneys', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys and secures the essence', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the liver and brightens the eyes', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Evenly supplements yin & yang harmoniously', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mainly treats vacuity', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 7);

END $$;

-- Pair 4: Bai Qian & Qian Hu (p.17)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Cynanchi Stautonii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Peucedani';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Cynanchi Stautonii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Peucedani';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 17, 'image00033.jpg', 'One downbears; the other diffuses. Together they mutually reinforce each other to disperse phlegm and complement each other to downbear and diffuse the lung qi in order to effectively treat cough.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough with abundant phlegm or phlegm which is difficult to expectorate, itchy throat, chest oppression due to blockage of the lung qi and lung qi counterflow', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains the lungs', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats cough and asthma due to accumulation of phlegm with counterflow of lung qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind and diffuses the lung qi', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats cough due to wind heat blocking the lung qi and causing qi counterflow', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 5: Bai Shao & Chai Hu (p.18)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Albus Paeoniae Lactiflorae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Bupleuri';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Albus Paeoniae Lactiflorae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Bupleuri';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 18, 'image00034.jpg', 'One is astringent; the other is dissipating. Both are directed toward the liver channel. Together they drain the liver without damaging liver yin, nourish the liver without causing liver depression qi stagnation, regulate the spleen and stop pain effectively. They harmonize the exterior and interior while constraining yin and upbearing yang.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Liver depression qi stagnation causing disharmony between the qi and blood', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, unclear vision, chest and lateral costal oppression, pain, and distention due to liver depression qi stagnation or disharmony between the exterior and interior', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Menstrual irregularities, dysmenorrhea, breast distention, low-grade fever during the menses, premenstrual syndrome, and fibrocystic breasts caused by liver depression qi stagnation or disharmony between the liver and spleen', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, cold, astringent', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood and constrains yin', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the constructive', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Calms & emolliates the liver', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Relieves tension', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops pain', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the yin division', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 8);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, slightly cold, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains the liver and resolves depression', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the shao yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the liver & spleen', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Abates heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Upbears clear yang', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-15g', 7);

END $$;

-- Pair 6: Bai Shao & Chi Shao (p.20)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Albus Paeoniae Lactiflorae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Rubrus Paeoniae Lactiflorae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Albus Paeoniae Lactiflorae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Rubrus Paeoniae Lactiflorae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 20, 'image00036.jpg', 'One constrains; the other drains. One supplements; the other drains. Together they nourish the blood, constrain yin, and cool the blood without engendering blood stasis. They drain and nourish the liver and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Persistent low-grade fever due to heat in blood', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dry mouth and tongue, eyes red and painful due to insufficiency of fluids or yin caused by residual heat', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lateral and chest pain, abdominal pain and conglomerations due to blood stasis or liver depression qi stagnation', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Menstrual irregularities or amenorrhea caused by blood stasis, blood vacuity, and/or liver depression qi stagnation', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood and constrains yin', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Emolliates the liver and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes liver yin (blood)', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats disease of liver qi counterflowing upward caused by liver blood (yin) vacuity', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements & constrains and does not drain', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and cools the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and dispels stasis', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains liver fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats disease of heat in the blood or blood stasis', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains and does not supplement', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 7: Bai Shao & Gan Cao (p.21)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Albus Paeoniae Lactiflorae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Glycyrrhizae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Albus Paeoniae Lactiflorae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Glycyrrhizae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 21, 'image00037.jpg', 'One is sour, while the other is sweet. One focuses on the liver; the other on the spleen. Sweet and sour engender yin. Together they calm the liver and tonify the spleen, supplement the qi and blood, harmonize the liver and spleen, and soothe the sinews to stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Weakness in the lower limbs, spasms and pain in the limbs due to disharmony between the qi and blood causing inadequate nourishment of the sinews and vessels', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abdominal pain due to liver-spleen disharmony', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headaches due to blood vacuity', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood and constrains yin', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Soothes and calms the liver', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Relieves tension and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sour — focused on the liver, treats wood', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Method of preparation: wine mix-fried', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g (up to 60g)', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the central qi', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes other medicinals', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Soothes the sinews and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet — focused on the spleen, treats earth', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Method of preparation: honey mix-fried', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 8: Bai Shao & Gui Zhi (p.22)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Albus Paeoniae Lactiflorae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Ramulus Cinnamomi Cassiae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Albus Paeoniae Lactiflorae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Ramulus Cinnamomi Cassiae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 22, 'image00038.jpg', 'One is cool and sour, while the other is warm and acrid. One is astringent, while the other is scattering. One assists yin; the other assists yang. Together they regulate the qi and blood, and the constructive and defensive.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Common cold with fever, shivers, slight perspiration, headache, and floating moderate pulse — wind cold exterior pattern with disharmony between the constructive and defensive', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spontaneous perspiration and/or night sweats with fear of wind and cold, frequent colds, due to disharmony between the constructive and defensive', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest and cardiac area pain due to heart yang vacuity and disharmony between the qi and blood', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abdominal pain with spasms and cramps due to vacuity cold and disharmony between the qi and blood', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain and/or numbness of the limbs due to disharmony between the qi and blood', 5);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vomiting and weakness during pregnancy accompanied by fear of cold, lack of appetite, nausea due to disharmony of the spleen and stomach and between the constructive and defensive', 6);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Weakness in the elderly, during convalescence, postpartum, and post-operatively with fatigue, fear of wind, and slight perspiration', 7);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, sour, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the constructive qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Constrains & protects yin', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood and constrains yin without attracting nor blocking evils in the interior', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the yin division', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes stomach yin', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, sweet, warm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the constructive qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Promotes perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Promotes perspiration and resolves the exterior without damaging yin', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the blood division', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the channels and quickens the network vessels', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements spleen yang', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 8);

END $$;

-- Pair 9: Bai Zhu & Fu Ling (p.24)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Atractylodis Macrocephalae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Sclerotium Poriae Cocos';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Atractylodis Macrocephalae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Sclerotium Poriae Cocos';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 24, 'image00040.jpg', 'One supplements, while the other percolates. One is drying, the other disinhibits urination. Together they effectively supplement the spleen and dry dampness, percolate dampness and disinhibit urination.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Edema due to accumulation of dampness caused by spleen vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Fatigue, weakness in limbs, lack of appetite, loose stools or diarrhea caused by spleen vacuity with accumulation of dampness', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, blurred vision, and/or heart palpitations due to phlegm dampness', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic cough due to phlegm dampness and spleen vacuity', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, warm, supplementing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strongly supplements the spleen & qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits water', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Superior in supplementing the spleen and drying dampness', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, bland, disinhibits urination', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mildly supplements the spleen & middle burner', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Percolates dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits water', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Superior for percolating dampness and disinhibiting urination without injuring the correct qi', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 6);

END $$;

-- Pair 10: Bai Zhu & Huang Qin (p.25)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Atractylodis Macrocephalae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Scutellariae Baicalensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Atractylodis Macrocephalae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Scutellariae Baicalensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 25, 'image00041.jpg', 'One is warm, while the other is cold. One supplements; the other drains. Together they clear heat stirring the fetus, dry dampness, and fortify the spleen to contain the blood and the fetus. They effectively quiet the fetus.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Uterine bleeding during pregnancy, threatened miscarriage, nausea and vomiting during pregnancy caused by heat or damp heat associated with spleen vacuity', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the qi & the middle burner', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen to maintain the blood within its vessels', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries cold dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quiets & secures the fetus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains lung, liver, gallbladder & large intestine fire', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears and eliminates damp heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and quiets the fetus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 5);

END $$;

-- Pair 11: Bai Zhu & Zhi Shi (p.26)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Atractylodis Macrocephalae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Immaturus Citri Aurantii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Atractylodis Macrocephalae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Immaturus Citri Aurantii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 26, 'image00042.jpg', 'One supplements, while the other drains. One is moderate, while the other is drastic. One is fixed; the other is mobile. Together they supplement without producing stagnation and drain without damaging the correct qi. They fortify the spleen, disperse food stagnation, and effectively eliminate accumulations and distention.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Accumulation of food, distention and fullness of the abdomen and epigastrium, difficult bowel movements due to spleen qi vacuity and qi stagnation', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Splenomegaly and hepatomegaly due to qi vacuity and stagnation', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Ptosis of the organs (stomach, uterus, and anus) due to central qi vacuity', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, warm, moderately supplementing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses swelling', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the center', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quiets the fetus', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fixed in nature', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, warm, drastically draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Breaks the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses accumulations & distention', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses food stagnation and frees the flow of stools', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Traveling in nature', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 6);

END $$;

-- Pair 12: Bai Zi Ren & Suan Zao Ren (p.27)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Biotae Orientalis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Zizyphi Spinosae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Biotae Orientalis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Zizyphi Spinosae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 27, 'image00043.jpg', 'Together they reinforce each other''s actions, effectively nourishing both the liver and heart, tranquilizing the heart and quieting the spirit.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Heart palpitations, profuse dreams, and insomnia due to heart blood (and qi) vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation with dry stools due to blood vacuity or intestinal fluid insufficiency', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the heart qi & blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quiets the hun, po & shen', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Superior for supplementing the heart', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats heart palpitations caused by heart vacuity', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Boosts the intelligence', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens the intestines', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes heart yin & blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quiets the hun & shen', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Superior for supplementing the liver & gallbladder', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats heart palpitations due to gallbladder vacuity', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes liver blood', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops perspiration by astringing', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 7);

END $$;

-- Pair 13: Ban Lan Gen & Shan Dou Gen (p.28)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Isatidis Seu Baphicacanthi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Sophorae Subprostratae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Isatidis Seu Baphicacanthi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Sophorae Subprostratae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 28, 'image00044.jpg', 'Together they reinforce each other to clear heat, resolve toxins, and strongly disinhibit the throat.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Painful, red, and swollen throat due to replete heat', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Toothache and painful, swollen gums due to replete heat', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Oral ulcers due to replete heat', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits the throat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tends to treat heat toxins in the blood division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Very bitter, very cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses swelling and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits the throat', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to treat fire toxins rising upward', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 6);

END $$;

-- Pair 14: Ban Lan Gen & Xuan Shen (p.29)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Isatidis Seu Baphicacanthi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Scrophulariae Ningpoensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Isatidis Seu Baphicacanthi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Scrophulariae Ningpoensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 29, 'image00045.jpg', 'One clears, while the other nourishes. One clears heat, the other downbears fire. Together they clear heat and resolve toxins, cool the blood and nourish yin, downbear fire and disinhibit the throat, disperse swelling and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Painful, red, swollen throat with dry, red tongue and fine, rapid pulse due to yin vacuity fire or replete fire which damages yin', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cools the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits the throat and disperses swelling', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes yin, drains fire (and floating fire), and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Cools the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits the throat', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 5);

END $$;

-- Pair 15: Ban Xia & Chen Pi (p.29)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Pinelliae Ternatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Pericarpium Citri Reticulatae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Pinelliae Ternatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pericarpium Citri Reticulatae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 29, 'image00045.jpg', 'Together they mutually reinforce one another, fortifying the spleen, rectifying the qi, drying dampness, transforming phlegm and stopping vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough due to accumulation of phlegm dampness', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest oppression, nausea, and vomiting due to stomach disharmony and phlegm damp stagnation', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters nodulation', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears qi and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Rectifies the qi and moderately fortifies the spleen', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dries dampness and transforms phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the stomach and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 4);

END $$;

-- Pair 16: Ban Xia & Huang Lian (p.31)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Tuber Pinelliae Ternatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Tuber Pinelliae Ternatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 31, 'image00047.jpg', 'One is warm, while the other is cold. Acrid and bitter, cool and warm harmonize upbearing and downbearing, yin and yang. Together they clear heat and dry dampness, transform phlegm and stop vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea, vomiting, chest and epigastric fullness and distention, thick yellow phlegm, yellow slimy tongue fur, and a wiry slippery pulse due to damp heat, turbid phlegm, and/or mixed cold and heat causing stomach disharmony', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, drying, frees the flow', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears qi counterflow', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees the flow of and eliminates dampness accumulated in the middle burner', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold, drying, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears the stomach, liver & heart', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains and eliminates heat accumulated in the middle burner', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 17: Ban Xia & Huang Qin (p.31)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Pinelliae Ternatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Scutellariae Baicalensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Pinelliae Ternatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Scutellariae Baicalensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 31, 'image00047.jpg', 'One is warm, the other is cold. One is acrid and frees the flow; the other is bitter and drains. Together they harmonize and re-establish the interaction between yin and yang, effectively clear heat and drain fire, harmonize the stomach and stop vomiting, and scatter nodulation.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vomiting and nausea due to shao yang pattern', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Phlegm heat', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lack of appetite, nausea, vomiting, and distention and sensation of fullness in the stomach, diaphragm, and chest caused by a pattern of mixed cold and heat', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the stomach and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters nodulation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears qi counterflow', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops bleeding and quiets the fetus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 5);

END $$;

-- Pair 18: Ban Xia & Sheng Jiang (p.32)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Pinelliae Ternatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Uncooked Rhizoma Zingiberis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Pinelliae Ternatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Uncooked Rhizoma Zingiberis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 32, 'image00048.jpg', 'One downbears, while the other drains. One dries; the other warms. Together they transform phlegm and downbear counterflow, harmonize the stomach and stop vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea, vomiting with no thirst, and slimy tongue fur due to phlegm dampness stagnating in the middle burner', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Enduring cough with white, watery, and profuse phlegm', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears qi counterflow and stops vomiting', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats vomiting due to accumulation of phlegm in the stomach', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the center and stops vomiting', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains yin fluids accumulated in the center', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats vomiting caused by cold in the stomach', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 4);

END $$;

-- Pair 19: Ban Xia & Shu Mi (p.33)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Pinelliae Ternatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Panici Miliacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Pinelliae Ternatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Panici Miliacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 33, 'image00049.jpg', 'Together they transform phlegm, harmonize the stomach, and quiet the spirit.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Insomnia with heart palpitations, nausea, and cough with thin phlegm due to phlegm dampness accumulation in the middle burner causing stomach disharmony', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses food stagnation', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the stomach', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears counterflowing qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the stomach qi', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the stomach', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quiets the spirit', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 12g', 5);

END $$;

-- Pair 20: Ban Xia & Zhu Ru (p.34)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Pinelliae Ternatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Caulis Bambusae In Taeniis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Pinelliae Ternatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Caulis Bambusae In Taeniis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 34, 'image00050.jpg', 'One is warm, while the other is cool. Together they mutually reinforce each other, effectively dry dampness, clear heat, transform phlegm, harmonize the stomach, and stop vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hiccup, nausea, and vomiting due to disharmony of the constructive qi', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, agitation, and insomnia due to phlegm turbidity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea and vomiting during pregnancy due to disharmony of the stomach, phlegm heat, or heat in the stomach', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears the qi and stops vomiting', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warm — transforms cold phlegm dampness which is profuse and easy to expectorate', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats vomiting due to accumulation of phlegm dampness and stomach disharmony', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and stops vomiting', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the qi and eliminates phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Cool — eliminates thick and sticky phlegm heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats vomiting due to stomach heat and counterflow of stomach qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 21: Bie Jia & Gui Ban (p.35)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Carapax Amydae Sinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Plastrum Testudinis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Carapax Amydae Sinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Plastrum Testudinis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 35, 'image00051.jpg', 'Together they make yin and yang interact, enrich yin and clear vacuity heat, subdue yang, extinguish wind, and stop tremors.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Tidal fever, steaming bones, and night sweats due to vacuity heat caused by yin vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Weakness of the limbs, involuntary trembling of the hands and feet, and red tongue with little or no fur due to a warm disease which has damaged the fluids and causes internal wind of the vacuity type', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headaches, vertigo, head distention, and tinnitus due to ascendant hyperactivity of liver yang', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hypertension due to yin vacuity which causes yang to rise', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abdominal conglomeration such as hepatomegaly and splenomegaly', 5);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Salty, slightly cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Turtle shell (dorsal carapax)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches yin and subdues yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches yin and clears heat from the yin division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels stasis and scatters nodulations', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-30g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, salty, neutral', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Land tortoise shell (primarily the ventral plastrum)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Enriches yin and subdues yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys and strengthens bones', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Makes the heart & kidneys and ren mai & du mai communicate', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-30g', 6);

END $$;

-- Pair 22: Bing Lang & Mu Xiang (p.36)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Arecae Catechu';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Auklandiae Lappae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Arecae Catechu';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Auklandiae Lappae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 36, 'image00052.jpg', 'Together they effectively move the qi, disperse food stagnation, and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lack of appetite, no desire for food, abdominal and epigastric distention and pain aggravated by pressure, difficult defecation or dry stools due to food stagnating in the stomach and intestines', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dysentery or diarrhea with tenesmus and abdominal pain due to qi stagnation', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation or difficult defecation due to qi stagnation', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, bitter, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Breaks & downbears the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees the flow of the stools', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses food stagnation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-12g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, warm, fragrant, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses food stagnation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 5);

END $$;

-- Pair 23: Bing Lang & Nan Gua Zi (p.37)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Arecae Catechu';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Cucurbitae Moschatae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Arecae Catechu';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Cucurbitae Moschatae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 37, 'image00053.jpg', 'Together they effectively expel the head and the body of tapeworms.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Intestinal parasites, particularly tapeworms', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Kills parasites', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears the qi and frees the flow of stools', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Expels the head (hook) of tapeworms', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-100g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Kills parasites', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Expels the body of tapeworms', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 30-120g', 3);

END $$;

-- Pair 24: Bu Gu Zhi & Hu Tao Ren (p.37)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Psoraleae Corylifoliae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Juglandis Regiae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Psoraleae Corylifoliae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Juglandis Regiae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 37, 'image00053.jpg', 'Together they supplement metal and water, effectively constrain the lung qi and promote the intake of qi by the kidneys, stop cough and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough, dyspnea, and asthma due to kidney yang vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lumbago, impotence, seminal emission, constipation, frequent and abundant urination, and enuresis due to kidney qi vacuity', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the kidneys and invigorates yang', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Promotes the intake of qi (by the kidneys)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strengthens true yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the cinnabar field', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the spleen and stops diarrhea', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys and invigorates yang', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Constrains the lung qi, warms the lungs, calms or levels asthma', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms and supplements the life gate', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 25: Bu Gu Zhi & Rou Dou Kou (p.38)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Psoraleae Corylifoliae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Myristicae Fragrantis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Psoraleae Corylifoliae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Myristicae Fragrantis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 38, 'image00054.jpg', 'One is warming; the other is astringing. One supplements the kidneys; the other supplements the spleen. Together they effectively supplement spleen and kidney yang, secure the intestines and stop daybreak (cock-crow) diarrhea.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic diarrhea due to spleen-kidney yang vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Daybreak diarrhea with abdominal pain and rumbling noises due to spleen-kidney yang vacuity', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the kidneys and invigorates yang', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the spleen and stops diarrhea', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the essence and controls urination', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Especially supplements the kidneys', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the spleen and scatters cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Astringes the intestines and stops diarrhea', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi and disperses distention', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Especially supplements the spleen', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 26: Cang Er Zi & Xin Yi Hua (p.39)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Xanthii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Flos Magnoliae Liliflorae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Xanthii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Magnoliae Liliflorae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 39, 'image00055.jpg', 'Together they effectively dispel wind, diffuse the lung qi, and open the portals of the nose.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Common cold with headache, nasal congestion, and runny nose due to wind cold', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Deep source nasal congestion with headache, nasal congestion, loss of smell, and turbid nasal phlegm', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic or acute rhinitis, allergic rhinitis, hypertrophic rhinitis, sinusitis, parasinusitis, and frontal sinusitis', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, bitter, warm, draining, drying', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind & wind dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Opens the portals of the nose', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, warm, fragrant, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind and resolves the exterior', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the portals of the nose', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-6g', 4);

END $$;

-- Pair 27: Cang Zhu & Huang Bai (p.40)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Atractylodis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cortex Phellodendri';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Atractylodis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Phellodendri';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 40, 'image00056.jpg', 'One is warm, while the other is cold. One is drying; the other clears. Together they complement and reinforce each other, effectively clear heat and dry dampness, disperse swelling and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Wilting of the lower extremities with pain in the sinews and bones due to damp heat pouring downward to the lower part of the body', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abnormal vaginal discharge, external vaginal itching, and cloudy, scanty urination due to damp heat', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Red, swollen, hot, painful joints due to wind, damp, heat impediment', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, bitter, warm, drying, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Upbearing (clears the turbid) and downbearing (the turbid)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind and dries dampness (mainly in the middle burner and exterior)', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen and stops diarrhea', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold, clearing, drying', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sinking and downbearing', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness (mainly in the lower burner)', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and resolves toxins', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 28: Chai Hu & Huang Qin (p.41)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Bupleuri';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Scutellariae Baicalensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Bupleuri';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Scutellariae Baicalensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 41, 'image00057.jpg', 'One dispels; the other drains. One upbears clear yang; the other downbears turbidity. One dispels external evils; the other drains internal evils. Together they harmonize the interior with the exterior, the shao yang, and liver and gallbladder. They also clear the liver and resolve depression as well as clear and eliminate dampness and heat particularly in the liver and gallbladder.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Alternating fever and chills, bitter taste in the mouth, dry throat, pain and fullness in the chest and lateral costal regions, nausea, and lack of appetite due to a shao yang pattern', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Malaria due to a shao yang pattern', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Liver depression transforming into fire', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains the liver', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves depression', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates heat by harmonizing', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Upbears yang qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains the evils located in the external part of the shao yang', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 5-15g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops bleeding and quiets the fetus', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears turbid yin', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains the evils located in the internal part of the shao yang', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 6);

END $$;

-- Pair 29: Chai Hu & Sheng Ma (p.42)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Bupleuri';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Cimicifugae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Bupleuri';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Cimicifugae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 42, 'image00058.jpg', 'One is for the left; the other for the right. One enters the shao yang; the other the yang ming. Together they complement and mutually reinforce each other, upbearing liver, stomach, and spleen yang qi.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Uterine prolapse, rectal prolapse, gastric ptosis due to central qi fall', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Metrorrhagia and abnormal vaginal discharge due to central qi fall', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic diarrhea or chronic dysentery due to central qi fall', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Shortness of breath and dyspnea with feeling of oppression and downward falling of the lungs due to qi fall', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the exterior and clears heat', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Courses the liver and resolves depression', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Upbears yang qi more moderately than Sheng Ma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Upbears shao yang clear qi (liver-gallbladder)', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees the flow of qi on the left side of the body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 2-15g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Resolves the exterior and clears heat', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Out-thrusts eruptions', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Upbears yang qi more strongly than Chai Hu', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Upbears yang ming and spleen clear qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees the flow of qi on the right side of the body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-12g', 6);

END $$;

-- Pair 30: Chan Tui & Shi Chang Pu (p.43)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Periostracum Cicadae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Acori Graminei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Periostracum Cicadae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Acori Graminei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 43, 'image00059.jpg', 'Together they reinforce each other, effectively arouse the spirit and open the portals.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, tinnitus, and deafness due to obstruction of the clear portals', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Light, clearing, upbearing, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits the throat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the portals of the lungs and increases the voice', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Aromatic, drying, opening', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Arouses the spirit', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the portals', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 5);

END $$;

-- Pair 31: Chen Pi & He Zi (p.44)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Pericarpium Citri Reticulatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Terminaliae Chebulae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pericarpium Citri Reticulatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Terminaliae Chebulae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 44, 'image00060.jpg', 'One dissipates, while the other astringes. Together they complement each other, effectively constrain the lung qi, rectify the qi, and increase the voice.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hoarse voice, loss of voice, and chronic cough (vacuity type) with loss of voice and phlegm in the throat', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Rectifies and moves the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sour, astringent, bitter, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Secures and downbears the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits the throat and opens the voice', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 4);

END $$;

-- Pair 32: Chen Pi & Qing Pi (p.44)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Pericarpium Citri Reticulatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Pericarpium Citri Reticulatae Viride';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pericarpium Citri Reticulatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pericarpium Citri Reticulatae Viride';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 44, 'image00060.jpg', 'One is for the right, the other for the left. One is upbearing; the other is downbearing. One is floating; the other is sinking. Together they effectively soothe the liver and regulate the stomach, harmonize liver and spleen, harmonize liver and stomach, and rectify the qi and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Epigastric and abdominal distention and pain, chest and lateral costal region distention and pain due to disharmony of the liver and spleen, liver and stomach, or a liver depression qi stagnation', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, dissipating, upbearing, floating, moderate', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Rectifies and regulates the lung, spleen, and stomach qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the middle burner', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Rectifies the qi on the right side of the body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Outer skin of the ripe fruit of the mandarin orange tree', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, acrid, sour, draining, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sinking, drastic', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains the liver and gallbladder qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses lump glomus and food accumulations', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi on the left side of the body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Outer skin of the immature fruit of the mandarin orange tree', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 7);

END $$;

-- Pair 33: Chen Pi & Sang Bai Pi (p.46)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Pericarpium Citri Reticulatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cortex Radicis Mori Albi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pericarpium Citri Reticulatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Radicis Mori Albi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 46, 'image00062.jpg', 'One transforms phlegm; the other drains the lungs. One prevents the production of phlegm; the other clears the lungs. Together they effectively clear the lungs and transform phlegm, rectify the qi, stop coughing, and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and asthma due to lung heat with abundant yellow phlegm', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen and harmonizes the stomach', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Rectifies the qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: spleen, lungs', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the lungs', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops cough and calms asthma', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination and disperses swelling', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: lungs', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 34: Chen Pi & Zhu Ru (p.47)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Pericarpium Citri Reticulatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Caulis Bambusae In Taeniis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pericarpium Citri Reticulatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Caulis Bambusae In Taeniis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 47, 'image00063.jpg', 'One is warm, while the other is cold. Together they clear and warm simultaneously, eliminating mixed cold and heat in the stomach. They effectively harmonize the stomach, downbear qi counterflow, and stop vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea, vomiting, and epigastric and abdominal distention due to spleen-stomach vacuity mixed with cold and heat', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea and vomiting during pregnancy', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Rectifies the qi and fortifies the spleen', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the stomach and downbears qi counterflow', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears qi counterflow and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm heat', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 35: Chuan Bei Mu & Xing Ren (p.47)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Bulbus Fritillariae Cirrhosae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Pruni Armeniacae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Bulbus Fritillariae Cirrhosae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Pruni Armeniacae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 47, 'image00063.jpg', 'One moistens, while the other downbears. Together they effectively clear and moisten the lungs, enrich yin and drain fire, transform phlegm and stop cough.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic cough and/or dry cough with little or no phlegm, difficulty expectorating, and dry throat due to lung vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Relentless cough with expectoration of yellow phlegm due to external evils or accumulation of phlegm heat in the lungs', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, bitter, cool', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: upper burner — lungs, heart', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens the lungs', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops the cough', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, slightly warm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Diffuses the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the lung qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops cough and calms asthma', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 36: Chuan Bei Mu & Zhi Mu (p.48)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Bulbus Fritillariae Cirrhosae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Anemarrhenae Aspheloidis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Bulbus Fritillariae Cirrhosae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Anemarrhenae Aspheloidis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 48, 'image00064.jpg', 'Together they effectively clear and moisten the lungs, enrich yin and drain fire, transform phlegm and stop cough.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Enduring dry cough with little phlegm and difficult expectoration, sometimes fever, dry mouth, and dry red tongue due to water vacuity causing rising fire or due to lung yin vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough due to lung heat which causes lung dryness', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, bitter, cool', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: upper burner — lungs, heart', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens the lungs', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops cough', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: upper burner — lungs; middle burner — stomach; lower burner — kidneys', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Enriches yin and moistens dryness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and drains fire', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 5);

END $$;

-- Pair 37: Chuan Lian Zi & Yan Hu Suo (p.49)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Meliae Toosendan';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Corydalis Yanhusuo';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Meliae Toosendan';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Corydalis Yanhusuo';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 49, 'image00065.jpg', 'One is for the qi, while the other is for the blood. One drains heat from the qi; the other moves the blood and dispels stasis. Together they effectively clear heat and eliminate dampness, course the liver and move the qi, quicken the blood and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain in the chest, epigastrium, abdomen, and lateral costal regions due to liver depression qi stagnation sometimes associated with liver blood stasis', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Liver depression qi stagnation transforming into liver heat or fire', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dysmenorrhea and menstrual irregularities due to qi stagnation and/or blood stasis', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Heart pain due to qi stagnation and blood stasis', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Inguinal hernia or diseases of the scrotum or testicles due to qi stagnating in the liver channel', 5);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hepatitis, cholecystitis, and angiocholitis due to damp heat in the liver and gallbladder', 6);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold, downbearing, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears & eliminates dampness & heat and clears the liver', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Works in the qi division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, warm, dissipating, and frees the flow', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and dispels stasis', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Rectifies the qi and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Works in the blood division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-15g', 5);

END $$;

-- Pair 38: Chuan Xiong & Dang Gui (p.50)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Ligustici Wallicii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Angelicae Sinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Ligustici Wallicii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Angelicae Sinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 50, 'image00066.jpg', 'One quickens the blood; the other nourishes the blood. Together they move the qi and quicken the blood without damaging the blood. Conversely, they nourish the blood without producing stasis. In addition, they dispel stasis and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Menstrual irregularities, dysmenorrhea, and postpartum abdominal pain due to blood stasis that may be mixed with qi stagnation', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Rheumatic pain due to wind dampness and blood vacuity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headaches due to blood vacuity and/or blood stasis', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Wounds, ulcers, or enduring cutaneous inflammations due to qi and blood vacuity with qi stagnation and blood stasis', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, upbearing, dissipating, drying', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi and quickens the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats the qi within the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels stasis and stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'In the upper body, goes towards the head & eyes; in the lower body, towards the sea of blood (uterus)', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly quickens the blood', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind and stops pain', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 8);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, acrid, warm, moving, moistening', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the blood and quickens the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats the blood within the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the blood', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Regulates menstruation and stops pain', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels stasis and disperses swelling', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mainly nourishes the blood', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 8);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 9);

END $$;

-- Pair 39: Chuan Xiong & Shi Gao (p.52)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Ligustici Wallicii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Ligustici Wallicii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 52, 'image00068.jpg', 'One is for the blood, while the other is for the qi. One is warm; the other is cold. One dissipates; the other drains. Together they dispel wind, clear and drain heat, quicken the blood and move the qi, and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headaches due to wind heat or replete heat (particularly located on the shao yang or jue yin channels)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, fragrant, dissipating, upbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi and quickens the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'In the upper body, directed toward head and eyes', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, acrid, cold, heavy, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the qi division', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains internal heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates heat from the muscle aspect and from the exterior', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 30-60g', 5);

END $$;

-- Pair 40: Ci Shi & Shi Chang Pu (p.53)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Magnetitum';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Acori Graminei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Magnetitum';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Acori Graminei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 53, 'image00069.jpg', 'One enriches, while the other opens. Together they enrich the kidneys and calm the liver, diffuse impediment and open the portals, and sharpen the hearing.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Tinnitus and/or deafness due to yin vacuity or vacuity fire causing yin vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headaches, vertigo, heart palpitations, vexation and agitation, and insomnia due to yin vacuity causing yang hyperactivity', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches the kidneys and calms the liver', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Subdues yang and quiets the spirit', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sharpens the hearing', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-30g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Arouses the spirit and quiets the spirit', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Diffuses impediment', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the portal or orifices', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 4);

END $$;

-- Pair 41: Da Huang & Fu Zi (p.54)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Et Rhizoma Rhei';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Lateralis Praeparatus Aconiti Carmichaeli';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Et Rhizoma Rhei';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Lateralis Praeparatus Aconiti Carmichaeli';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 54, 'image00070.jpg', 'One is cold, while the other is hot. One drains; the other supplements. One clears; the other warms. One precipitates the accumulation; the other drains cold. Together they warm the interior, precipitate accumulation of cold, and evacuate the stools.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation, abdominal pain, fear of cold, and cold limbs due to accumulation of internal replete cold', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold, precipitating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Precipitates the stools', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses accumulations', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Operates within the blood division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, hot, warming', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the interior and invigorates yang', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains cold and rescues yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Operates within the qi division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 42: Da Huang & Mang Xiao (p.55)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Et Rhizoma Rhei';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Mirabilium';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Et Rhizoma Rhei';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Mirabilium';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 55, 'image00071.jpg', 'One frees the flow of the stools; the other softens the stools. Together they complement and reinforce each other, effectively precipitate replete heat and internal accumulation and free the flow of the stools.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation with hard, dry stools and abdominal pain which worsens with pressure due to heat accumulation in the yang ming bowels', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation with hard, dry stools, high fever, delirium and mental confusion, and dry yellow tongue fur due to replete heat in the yang ming bowels', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic or severe constipation due to heat', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold, discharging, precipitating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees the flow of the stools and promotes defecation', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and dispels stasis', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses accumulations in the intestines (heat, damp heat, food)', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-15g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Salty, cold, moistening, softening', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens dryness, softens the hard, and frees the flow of the stools', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and drains fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses swelling, stops pain, disperses food accumulation (external use)', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-15g', 5);

END $$;

-- Pair 43: Da Zao & Sheng Jiang (p.57)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Zizyphi Jujubae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Uncooked Rhizoma Zingiberis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Zizyphi Jujubae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Uncooked Rhizoma Zingiberis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 57, 'image00073.jpg', 'Together they move the defensive qi, nourish the constructive qi, and harmonize the constructive and defensive. They also fortify the spleen and harmonize the middle burner.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Perspiration, fear of wind, and fever due to disharmony between the constructive and defensive qi', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Fatigue, lack of strength, abdominal pain, and lack of appetite due to disharmony between the constructive and defensive qi', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, nourishing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the middle burner & qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the action of other medicinal substances', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 2-5 fruits', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, moving', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind cold', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the middle burner', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 5);

END $$;

-- Pair 44: Da Zao & Ting Li Zi (p.58)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Zizyphi Jujubae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Lepidii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Zizyphi Jujubae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Lepidii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 58, 'image00074.jpg', 'Together they powerfully drain the lungs, disinhibit urination, and drastically evacuate phlegm without damaging yin and the stomach. Together, they downbear the qi and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Asthma, cough with stertor, wheezing, a swollen face, and oliguria due to accumulation of phlegm in the lungs', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, nourishing, harmonizing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the middle burner', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes & moderates the action of other medicinal substances', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes & protects the stomach', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 5 fruits', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, draining, bitter, cold, sinking, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains the lungs', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Expels phlegm and calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Powerful and drastic therapeutic action which tends to damage yin and the stomach', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 6);

END $$;

-- Pair 45: Dan Dou Chi & Zhi Zi (p.59)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Praeparatum Sojae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Gardeniae Jasminoidis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Praeparatum Sojae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Gardeniae Jasminoidis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 59, 'image00075.jpg', 'One resolves; the other clears. Together they use the clearing and diffusing-and-out-thrusting method to eliminate evils from the exterior and interior. They effectively promote perspiration, drain evils from the exterior, clear and out-thrust heat from the interior, and eliminate vexation due to replete heat.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vexation and agitation, insomnia, and irritability during or after a warm disease', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'External contraction of wind heat or a febrile disease', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, bitter, cold, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the exterior and promotes perspiration', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses and out-thrusts external evils from the exterior', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates vexation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains heart, liver, and stomach fire', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat toxins from the three burners', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and eliminates vexation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 5);

END $$;

-- Pair 46: Dan Nan Xing & Xuan Fu Hua (p.60)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Pulvis Arisaematis Cum Felle Bovis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Flos Inulae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pulvis Arisaematis Cum Felle Bovis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Inulae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 60, 'image00076.jpg', 'One clears, while the other diffuses. Together they clear heat and transform phlegm, stop cough and calm asthma. They also extinguish wind and wash away phlegm in the channels and network vessels.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough, asthma, and chest oppression due to phlegm damp obstruction, phlegm heat, or stubborn phlegm heat in the lungs', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Numbness in the limbs due to phlegm (wind) in the channels and network vessels', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears & transforms phlegm heat', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Extinguishes wind and settles convulsions', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates phlegm wind', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm and stops cough', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Diffuses the lung qi and calms asthma', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the qi and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 4);

END $$;

-- Pair 47: Dan Shen & Mu Dan Pi (p.61)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Salviae Miltiorrhizae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cortex Radicis Moutan';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Salviae Miltiorrhizae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Radicis Moutan';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 61, 'image00076.jpg', 'Dan Shen quickens the blood more strongly, while Mu Dan Pi cools the blood more strongly. Together they complement and reinforce each other, effectively quicken the blood and dispel stasis, cool the blood and eliminate vacuity heat.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hematemesis, epistaxis, metrorrhagia, purpura, rubella and pruritus due to heat in the blood division', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Menstrual irregularities, dysmenorrhea, amenorrhea, dark purple menstrual blood with clots, and postpartum abdominal pain due to heat in the blood which causes blood vacuity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Continuous, low-grade fever due to yin vacuity which causes vacuity heat', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hot, red, swollen, painful joints due to heat bi or impediment', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and dispels stasis', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cools the blood and clears heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates stasis and engenders new tissue', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses swelling and stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and dispels stasis', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat, cools the blood, and clears the liver', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates vacuity heat lodged in the yin division', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops bleeding', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 48: Dan Shen & San Qi (p.61)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Salviae Miltiorrhizae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Pseudoginseng';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Salviae Miltiorrhizae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Pseudoginseng';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 61, 'image00077.jpg', 'Together they complement and reinforce each other. They effectively quicken the blood and dispel stasis, nourish the heart and open the network vessels, stop pain and settle palpitations.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest bi or impediment — cardiac problems with pain and severe palpitations', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and dispels stasis', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates stasis and engenders new tissue', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses swelling and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the heart and quiets the spirit', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and dispels stasis', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops bleeding', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses swelling', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 49: Dan Shen & Tan Xiang (p.62)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Salviae Miltiorrhizae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Lignum Santali Albi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Salviae Miltiorrhizae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Lignum Santali Albi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 62, 'image00078.jpg', 'One is for the blood, while the other is for the qi. Together they effectively regulate the qi and blood, move the qi and quicken the blood, free the flow of the network vessels and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest bi or impediment, heart diseases with severe cardiac pain due to qi and blood stasis and stagnation', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Stomach pain due to qi and blood stasis and stagnation', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the blood division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels stasis', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the qi division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses qi stagnation', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Scatters cold and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-6g', 4);

END $$;

-- Pair 50: Dang Gui & Huang Qi (p.63)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Angelicae Sinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Angelicae Sinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 63, 'image00079.jpg', 'One is for the blood; the other is for the qi. Together they supplement the qi to strongly engender, effectively supplement the qi and blood.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Delayed menstruation, long menstrual cycle, postpartum weakness, agalactia due to qi and blood vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Low-grade fever caused by blood vacuity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Sores and welling abscesses which do not heal due to qi and blood vacuity', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Numbness of the limbs due to blood vacuity not nourishing the sinews', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Various hemorrhages due to qi not containing the blood within the vessels', 5);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels blood stasis hindering the engenderment of new blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-9g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Fortifies the spleen & middle burner', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the qi to engender and transform the blood and to control the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Engenders muscles (flesh)', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-30g', 4);

END $$;

-- Pair 51: Dang Gui & Shu Di (p.64)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Angelicae Sinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cooked Radix Rehmanniae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Angelicae Sinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cooked Radix Rehmanniae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 64, 'image00080.jpg', 'Together they nourish the blood and enrich yin, supplement the liver and kidneys. Together, they downbear the qi and promote the qi intake by the kidneys, stop cough and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic cough and/or asthma due to yin vacuity of the kidneys associated with blood vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Blood vacuity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation due to blood vacuity', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood and balances the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and dispels stasis', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mobile by nature', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears the qi, stops cough, and calms asthma', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens the intestines and frees the flow of the stools', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the blood, yin, and essence', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Enriches the kidneys and nourishes the liver', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Fixed by nature', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Promotes the qi intake function of the kidneys and calms asthma', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-15g', 5);

END $$;

-- Pair 52: Dang Shen & Huang Qi (p.65)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Codonopsitis Pilosulae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Codonopsitis Pilosulae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 65, 'image00081.jpg', 'One is for the interior; the other for the exterior. One is for the middle burner qi; the other for the defensive qi. One is for yin; the other for yang. Together they powerfully supplement the qi of the middle burner and the exterior defensive.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic illness leading to qi vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Rectal and uterine prolapse and gastric ptosis due to central qi fall', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lack of appetite, loose stools, fatigue, lack of strength, and spontaneous perspiration due to qi vacuity', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Low-grade fever due to qi vacuity', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the spleen & stomach', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the qi and promotes the engenderment of blood and fluids', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, neutral, fixed — tends to supplement the middle burner & yin', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the qi and upbears yang', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Secures the exterior and stops perspiration', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Promotes tissue regeneration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, warm, mobile — tends to supplement the exterior & yang', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 5);

END $$;

-- Pair 53: Di Gu Pi & Sang Bai Pi (p.67)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Cortex Radicis Lycii Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cortex Radicis Mori Albi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Radicis Lycii Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Radicis Mori Albi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 67, 'image00083.jpg', 'One is for the yin; the other for the qi. Together they combine the yin and qi divisions, effectively clear heat from the lungs, drain fire from the lungs, eliminate vacuity fire damaging the lungs, stop cough and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and asthma with expectoration of yellow, sticky, and thick phlegm, fever, and thirst due to lung heat', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough accompanied by evening fever or low but persistent fever with skin warm to the touch due to vacuity heat damaging the lungs', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: kidneys, lungs & yin division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire from the lungs', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and cools the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates vacuity heat', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates evils from the yin division', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: lungs & qi division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the lungs without damaging the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination and disperses swelling without damaging yin', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates evils from the qi division', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 54: Ding Xiang & Shi Di (p.68)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Flos Caryophylli';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Calx Khaki';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Caryophylli';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Calx Khaki';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 68, 'image00084.jpg', 'One disperses, while the other moves downward. Together they complement each other, effectively warm the middle burner and scatter cold, downbear qi counterflow and stop hiccup.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hiccup due to cold in the stomach', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea and vomiting due to vacuity cold in the spleen and stomach', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the center and stops hiccup and vomiting', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters cold and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, neutral, astringent', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops hiccup', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 4);

END $$;

-- Pair 55: Du Huo & Qiang Huo (p.69)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Angelicae Pubescentis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Et Rhizoma Notopterygii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Angelicae Pubescentis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Et Rhizoma Notopterygii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 69, 'image00085.jpg', 'One treats the lower part of the body, while the other treats the upper part. Together they dispel wind, cold, and dampness and treat bi over the whole body.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Moving rheumatic pains all over the body', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Common cold with fever, shivers, headache, back of the neck pain, back pain, and joint pain due to wind, cold, and dampness', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Joint running wind due to wind, cold, and dampness penetrating the channels and network vessels', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: lower part of the body, lumbar area, knees, legs, feet & shao yin', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moderate in action', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind and resolves the exterior', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates wind dampness and treats bi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats hidden wind or wind which is more internal and fixed', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: upper part of the body, occiput, nape of the neck, shoulders, upper limbs & tai yang', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Powerful in action', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains wind, cold, and dampness and resolves the exterior', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates wind dampness and treats bi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats floating wind or wind which is more at the exterior and mobile', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 6);

END $$;

-- Pair 56: Du Zhong & Xu Duan (p.70)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Cortex Eucommiae Ulmoidis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Dipsaci';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Eucommiae Ulmoidis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Dipsaci';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 70, 'image00086.jpg', 'Together they mutually reinforce each other, effectively supplement the liver and kidneys, strengthen the sinews and bones, stop metrorrhagia during pregnancy and quiet the fetus.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Aches and pains, stiffness, lumbar pain, and weakness of lower limbs due to liver-kidney vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Knee and lumbar pain due to wind dampness', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Metrorrhagia during pregnancy and threatened miscarriage accompanied by lumbar pains due to kidney vacuity', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Traumatic lumbar pain', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the liver & kidneys', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strengthens sinews & bones', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the chong mai', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quiets the fetus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Lowers the blood pressure', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-12g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the liver & kidneys', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Strengthens sinews & bones', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops metrorrhagia during pregnancy', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quiets the fetus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Knits the sinews & bones', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-12g', 6);

END $$;

-- Pair 57: E Jiao & Huang Lian (p.71)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Gelatinum Corii Asini';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gelatinum Corii Asini';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 71, 'image00087.jpg', 'One nourishes, while the other clears. One supplements; the other drains. Together they drain fire and enrich yin according to the method of draining the south (fire) and supplementing the north (water), and re-establish the interaction between the heart and kidneys. Together, they quiet the spirit and treat dysentery damaging yin.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vexation and agitation and insomnia due to febrile disease which has damaged yin, vacuity fire, or heart and kidneys not interacting anymore', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dysentery which damages yin with pus and blood in the stools due to damp heat in the large intestine', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches yin', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens dryness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops bleeding', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears & drains heart fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears & drains the stomach, liver & intestines', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 4-6g', 5);

END $$;

-- Pair 58: E Zhu & San Leng (p.72)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Curcumae Zedoariae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Sparganii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Curcumae Zedoariae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Sparganii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 72, 'image00088.jpg', 'One is for the qi; the other for the blood. Together they strongly and effectively break both the qi and blood, regulate and rectify the qi and blood, stop pain and disperse food accumulation.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abdominal lump glomus, hepatomegaly, and splenomegaly due to blood stasis and/or qi stagnation', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Amenorrhea, dysmenorrhea, clots in the menstrual flow, and infertility due to blood stasis', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abdominal pain due to food accumulation', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: liver, spleen & qi division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Breaks the qi (1)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats qi stagnation which causes blood stasis', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats the blood within the qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses food accumulation', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 5-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: liver, spleen & blood division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Breaks the blood and moves the qi (1)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats blood stasis which causes qi stagnation', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats the qi within the blood', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 5);

END $$;

-- Pair 59: Fang Feng & Huang Qi (p.73)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Ledebouriellae Divaricatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Ledebouriellae Divaricatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 73, 'image00089.jpg', 'One dissipates, while the other supplements. One opens; the other secures. Together Huang Qi supplements the defensive qi without retaining external evils within the body, while Fang Feng drains external evils without damaging correct qi and without causing perspiration. Together they effectively secure the exterior and supplement the defensive qi, dispel or prevent invasion by external evils and stop perspiration.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spontaneous perspiration due to exterior vacuity', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Tendency to catch cold frequently due to defensive qi vacuity', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind and resolves the exterior', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves tremors', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Expels external evils', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, warm, supplementing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the qi and upbears yang', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Secures the exterior and stops perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination and disperses swelling', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supports the correct qi', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-20g', 6);

END $$;

-- Pair 60: Fu Ling & Yi Zhi Ren (p.74)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Sclerotium Poriae Cocos';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Alpiniae Oxyphyllae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Sclerotium Poriae Cocos';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Alpiniae Oxyphyllae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 74, 'image00090.jpg', 'One eliminates; the other secures. Both supplement. Together they complement each other to fortify the spleen, secure the kidneys, reduce urination and stop diarrhea.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Strangury with chyluria, milky, turbid urine, and dysuria due to vacuity cold of the kidneys or kidney qi not securing with imbalance in the function of transformation of the bladder', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Diarrhea due to vacuity cold of the spleen and kidneys', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen and supplements the center', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Percolates dampness and disinhibits urination', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tranquilizes the heart and quiets the spirit', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements and eliminates', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the spleen and stops diarrhea', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys and secures the essence', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Contains the drool and spit and constrains the urine', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms and secures', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 61: Fu Xiao Mai & Huang Qi (p.74)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Levis Tritici Aestivi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Levis Tritici Aestivi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 74, 'image00090.jpg', 'Together they supplement the qi and nourish the heart, clear heat, secure the exterior, and stop perspiration.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spontaneous perspiration and night sweats due to qi vacuity or yin vacuity with vacuity heat', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, fresh, astringent', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the qi and nourishes the heart', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the exterior and stops perspiration', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-30g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, warm, supplementing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Replenishes the interstices, secures the exterior, and stops perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 4);

END $$;

-- Pair 62: Fu Xiao Mai & Ma Huang Gen (p.75)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Levis Tritici Aestivi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Ephedrae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Levis Tritici Aestivi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Ephedrae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 75, 'image00091.jpg', 'When these two medicinals are combined together, they effectively supplement the qi and nourish the heart, secure the exterior, clear heat and stop perspiration.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spontaneous or profuse perspiration due to qi vacuity (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Night sweats due to vacuity heat or yin vacuity (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, cool', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops perspiration', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the heart, ''Perspiration is the fluid of the heart''', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the qi and nourishes the heart', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat, stops perspiration, and eliminates vexation', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-30g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, neutral', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops perspiration', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the lungs, ''The lungs control the skin and are associated with the defensive qi.'' It is directed to the skin, replenishes the exterior, secures the defensive qi, and stops perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 4);

END $$;

-- Pair 63: Fu Zi & Gan Jiang (p.76)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Lateralis Praeparatus Aconiti Carmichaeli';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Dry Rhizoma Zingiberis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Lateralis Praeparatus Aconiti Carmichaeli';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Dry Rhizoma Zingiberis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 76, 'image00092.jpg', 'When these two medicinals are combined together, they effectively reinforce each other, return yang, and stem counterflow.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Loss of consciousness, cold spontaneous perspiration, cold limbs, and a minute pulse due to yang desertion (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain and a feeling of cold in the stomach and abdomen, vomiting, and diarrhea due to spleen vacuity cold (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, very hot', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mobile', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the yang in the 12 channels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'In the exterior, it is directed to the skin to drain cold; in the interior, it is directed to the three burners to drain cold', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Makes the yang return and relieves from counterflow', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, hot', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Fixed', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the spleen & stomach and drains cold', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the lungs and transforms phlegm cold', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Reinforces Fu Zi', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Makes yang return and relieves from counterflow', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 7);

END $$;

-- Pair 64: Fu Zi & Huang Qi (p.77)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Lateralis Praeparatus Aconiti Carmichaeli';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Lateralis Praeparatus Aconiti Carmichaeli';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 77, 'image00093.jpg', 'One is for yang, while the other is for the qi. One is for collapse; the other for perspiration. When these two medicinals are combined together, they complement and reinforce each other. Together, they effectively supplement the qi and warm yang, return yang, secure the exterior, and stop perspiration.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cold spontaneous perspiration accompanied by fear of cold, cold limbs, lassitude of the spirit, a pale tongue with white fur, and a fine, weak pulse, and in severe cases, profuse perspiration, loss of consciousness, and a minute pulse due to yang vacuity or yang collapse (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Returns yang and stems counterflow', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the kidneys and invigorates yang', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains cold and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strongly supplements yang', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats collapse', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the qi and upbears yang', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Secures the exterior and stops perspiration', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination and disperses swelling', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Strongly supplements the qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats perspiration', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 6);

END $$;

-- Pair 65: Gan Cao & Hua Shi (p.78)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Glycyrrhizae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Talcum';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Glycyrrhizae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Talcum';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 78, 'image00094.jpg', 'When these two medicinals are combined together, they clear heat, eliminate summerheat, and disinhibit urination without damaging the middle burner. Together, they disinhibit urination and free strangury.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Fever, vexation and agitation, thirst, vomiting, diarrhea, and dysuria due to attack of summerheat with internal and external heat (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Turbid strangury', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Stone and/or sand strangury', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moderates the cold nature of Hua Shi and protects the middle burner', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Slippery in nature, disinhibiting (1)', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Above, it clears the origin of water (i.e., the lungs) and downbears the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Below, it frees the flow of the water passageways and opens the bladder', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates evil heat in the six bowels', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains summerheat and eliminates vexation', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Prevents stasis due to the sweet flavor of Gan Cao', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-18g', 7);

END $$;

-- Pair 66: Gan Cao & Jie Geng (p.79)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Glycyrrhizae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Platycodi Grandiflori';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Glycyrrhizae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Platycodi Grandiflori';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 79, 'image00095.jpg', 'One clears, while the other diffuses. One moderates; the other drains. When these two medicinals are combined together, they effectively clear heat and transform phlegm, disinhibit the throat and stop pain, evacuate pus and resolve toxins.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pulmonary abscess with cough, expectoration of profuse, purulent phlegm, and chest oppression and pain due to heat stasis in the chest (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain, redness, and swelling of the throat due to heat (vacuity or repletion, external or internal) (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Loss of voice and/or hoarse or husky voice (2)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, harmonizing, cool', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens the lungs', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Relieves tension and stops pain', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes other medicinal substances and protects the middle burner', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 5-10g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid and dissipating, bitter and draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Diffuses and frees the flow of the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits the throat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Evacuates pus', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Guides other medicinal substances towards the upper part of the body and towards the lungs', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 9-15g', 7);

END $$;

-- Pair 67: Gan Jiang & Huang Lian (p.80)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Dry Rhizoma Zingiberis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Dry Rhizoma Zingiberis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 80, 'image00096.jpg', 'One is acrid and frees the flow, while the other is bitter and drains. One is warm and dissipating; the other is cold and downbearing. One supplements spleen yang; the other clears replete heat. When these two medicinals are combined together, they eliminate cold accumulation and depressive heat. Together, they effectively drain mixed cold and heat in order to stop vomiting and diarrhea.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vomiting, acid regurgitation, belching, epigastric pain or distention, and clamoring stomach due to a mixture of heat and cold in the stomach (3) (4)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Diarrhea, dysentery, and stomach rumbling due to mixed heat and cold and/or disharmony between the stomach and intestines (4)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Glossitis, stomatitis, and chronic, recalcitrant mouth ulcers due to spleen yang vacuity and stomach fire', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, frees the flow and opens', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the middle burner and drains cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Returns yang and frees the flow of the channels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats diarrhea and vomiting due to cold', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g (1)', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold, downbearing, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats diarrhea and vomiting due to heat', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g (1)', 5);

END $$;

-- Pair 68: Gan Jiang & Wu Wei Zi (p.81)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Dry Rhizoma Zingiberis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Schisandrae Chinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Dry Rhizoma Zingiberis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Schisandrae Chinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 81, 'image00097.jpg', 'One drains; the other secures. One frees the flow; the other astringes. One treats the root; the other treats the branch. When these two medicinals are combined together, they mutually complement each other. Together, they effectively warm the lungs and transform phlegm, stop cough and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and/or asthma accompanied by profuse, clear, and white phlegm due to cold in the lungs, lung yang vacuity, or phlegm cold (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, dissipating, warm, frees the flow', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the spleen and drains cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the lungs and transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sour, astringent', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Secures the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops coughs and calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 4);

END $$;

-- Pair 69: Gao Liang Jiang & Xiang Fu (p.82)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Alpiniae Officinari';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Cyperi Rotundi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Alpiniae Officinari';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Cyperi Rotundi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 82, 'image00098.jpg', 'One warms, while the other moves. When these two medicinals are combined together, they effectively warm the stomach and drain cold, move the qi and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain in the epigastrium alleviated by warmth and pressure, chest and lateral costal distention, and nausea due to cold in the stomach and qi stagnation (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the stomach', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops pain & vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains the liver', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 4);

END $$;

-- Pair 70: Ge Gen & Sheng Ma (p.82)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Puerariae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Cimicifugae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Puerariae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Cimicifugae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 82, 'image00098.jpg', 'When these two medicinals are combined together, they resolve the exterior and muscle aspect, clear heat and resolve toxins, and out-thrust rashes in the whole body.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Skin rashes which have difficulty coming out accompanied by headache and fever due to an exterior pattern (1) (3)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Measles in the initial stage (1) with eruptions which have difficulty coming out and fever sometimes accompanied by lack of perspiration or perspiration which has difficulty in coming out (2) due to an exterior pattern (3)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the muscle aspect', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Out-thrusts rashes', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Engenders fluids and stops thirst', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tends to reach externally and horizontally, and therefore, out-thrusts rashes on the back and middle part of the body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Resolves the exterior', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Out-thrusts rashes', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Upbears yang qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to be upbearing, raising and reaching evils in the upper part of the body, and therefore, out-thrusts eruptions on the neck and face', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-6g', 6);

END $$;

-- Pair 71: Gou Qi Zi & Ju Hua (p.83)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Lycii Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Flos Chrysanthemi Morifolii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Lycii Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Chrysanthemi Morifolii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 83, 'image00099.jpg', 'One nourishes, while the other brightens. One supplements; the other calms. When these two medicinals are combined together, they effectively nourish and supplement the liver and kidneys, clear heat and calm the liver, and brighten the eyes.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Blurred vision, diminished visual acuity, ''moving black spots in front of the eyes'', fire sparks in the eyes, photophobia, dry eyes with distention and headache, and pain in the lower back and knees due to liver-kidney vacuity (1) (2) (3)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishing & moistening in nature', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the kidneys and fills the essence', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes liver blood and brightens the eyes', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Light & upbearing in nature', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind and clears heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Calms the liver and brightens the eyes', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 4);

END $$;

-- Pair 72: Gua Lou & Xie Bai (p.84)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Trichosanthis Kirlowii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Bulbus Allii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Trichosanthis Kirlowii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Bulbus Allii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 84, 'image00100.jpg', 'One moistens, while the other dissipates. One loosens; the other frees the flow. When these two medicinals are combined together, they effectively free the flow of yang and move the qi, loosen the chest and clear the lungs, transform phlegm and scatter nodulation, stop pain, and moisten the intestines and free the flow of the stools.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation due to fluid dryness of the large intestine and/or to qi stagnation (4)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Yin binding constipation (1) (4)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest bi with oppression of the chest and epigastrium, cough, profuse phlegm, piercing pain in the chest radiating towards the back, and shortness of breath due to accumulation of turbid phlegm blocking the qi and yang of the chest (2)(5)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet and cold, moistening, clearing, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears the lungs', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Loosens the chest and scatters nodulations', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens dryness and moistens the intestines', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Loosens the chest & diaphragm and frees the flow of impediment', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-20g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid and warm, frees the flow, dissipating, moving', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the chest and frees the flow of yang', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the portals of the heart', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi and scatters nodulation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and stops pain', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats chest bi and yin binding or qi stagnation constipation', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-15g', 7);

END $$;

-- Pair 73: Gui Zhi & Ma Huang (p.86)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Ramulus Cinnamomi Cassiae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Ephedrae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Ramulus Cinnamomi Cassiae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Ephedrae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 86, 'image00102.jpg', 'When these two medicinals are combined together, they act to mutually reinforce each other''s floating and dispelling characteristics. Together, they effectively open the pores of the skin, strongly provoke perspiration, resolve the muscles, and scatter wind cold of the replete type.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Colds, influenza with fever, fear of cold, severe shivering, absence of perspiration, headache, and general body aches caused by wind cold of the replete type (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Rheumatic pains due to wind, cold, and dampness (1)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and asthma due to wind cold obstructing the lung qi (1)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Directed towards the heart channel and the blood (& constructive) division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, sweet, warm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels evils and harmonizes the constructive qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the muscles and dispels wind evils (moderate diaphoretic)', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Directed towards the lung channel and the qi (& defensive) division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, bitter', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the interstices and scatters cold evils', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Resolves the muscles and scatters cold (powerful diaphoretic)', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 74: Gui Zhi & Shi Gao (p.87)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Ramulus Cinnamomi Cassiae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Ramulus Cinnamomi Cassiae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 87, 'image00103.jpg', 'One is warm, while the other is very cold. One moves; the other clears. Both are acrid. When these two medicinals are combined together, they clear heat and free the flow of the network vessels, stop pain and treat heat bi or impediment.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Rheumatic pain of the heat type with redness, heat, swelling and severe pain in the joints (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warm, acrid, dissipating, moving', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Directed towards the blood division', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the muscles and expels wind', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the channels and quickens the network vessels', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Very cold, acrid, clearing, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Directed towards the qi division', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Diffuses the lung qi and promotes perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the muscles & internal heat', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 20-30g', 5);

END $$;

-- Pair 75: Hai Jin Sha & Ji Nei Jin (p.88)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Spora Lygodii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Endothelium Corneum Gigeriae Galli';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Spora Lygodii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Endothelium Corneum Gigeriae Galli';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 88, 'image00104.jpg', 'One drains, while the other transforms. When these two medicinals are combined together, they free strangury, transform stones, and, therefore, treat stone strangury.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Stone strangury and urinary lithiasis due to damp heat', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees strangury', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains damp heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Softens, transforms, and disperses stones', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees strangury', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses food stagnation', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 4);

END $$;

-- Pair 76: Hai Jin Sha & Jin Qian Cao (p.88)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Spora Lygodii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Desmodii Seu Lysimachiae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Spora Lygodii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Desmodii Seu Lysimachiae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 88, 'image00104.jpg', 'When these two medicinals are combined together, they complement and mutually reinforce each other. Together, they strongly clear heat and eliminate dampness, disinhibit urination and free strangury, and expel stones.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Stone and/or sand strangury, renal lithiasis, bladder lithiasis (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Gallstones due to damp heat in the gallbladder (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat from the small intestine, bladder & blood division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees strangury', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and eliminates dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits the gallbladder and treats jaundice', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination and frees strangury', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Expels stones and stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 5);

END $$;

-- Pair 77: Hai Tong Pi & Qin Jiao (p.89)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Cortex Erythrinae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Gentianae Macrophyllae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Erythrinae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Gentianae Macrophyllae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 89, 'image00105.jpg', 'One treats the upper, while the other treats the lower. When these two medicinals are combined together, they free the flow and quicken the 12 channels in the upper and lower parts of the body, dispel wind dampness and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Myalgia in the whole body, lumbar pain, pain in the legs, joint pain, and cramps due to wind dampness or wind, dampness, and heat which produces impediment of the qi in the channels (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'The sequelae of infantile paralysis', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind and eliminates dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Frees the flow of the network vessels and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears & eliminates dampness & heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'A bark, it treats pain in the upper part of the body', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees the flow of the network vessels', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Soothes the sinews and frees the flow of the channels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'A root, it treats pain in the lower part of the body', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 5);

END $$;

-- Pair 78: Han Fang Ji & Huang Qi (p.90)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Stephaniae Tetrandrae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Stephaniae Tetrandrae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 90, 'image00106.jpg', 'One drains, the other supplements. When these two medicinals are combined together, they simultaneously drain and supplement. They support the correct qi and drain evil qi at the same time. One downbears; the other upbears. Together, they regulate the upbearing and downbearing of the qi mechanism and strongly promote diuresis.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Edema due to wind water with fever, fear of wind, edema predominantly in the upper body and face, joint pain, scanty urination, and a floating pulse (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Rheumatic pain due to damp bi with heavy limbs, joint numbness, and sometimes swollen joints (1) (3)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic nephritis and cardiac disease with edema due to qi vacuity and accumulation of dampness (1)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold, downbearing, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the channels', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Opens the pores of the skin', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Opens the nine portals or orifices', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination and disperses swelling', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind dampness and stops pain', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains evil qi', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 8);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, warm, upbearing, supplementing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the middle burner and upbears yang', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Secures the exterior and stops perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the qi and disinhibits urination', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses swelling', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Promotes tissue regeneration', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the correct qi', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 8);

END $$;

-- Pair 79: Han Lian Cao & Nu Zhen Zi (p.91)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Ecliptae Prostratae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Ligustri Lucidi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Ecliptae Prostratae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Ligustri Lucidi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 91, 'image00107.jpg', 'When these two medicinals are combined together, they reinforce one another. Together, they effectively supplement the liver and kidneys, cool the blood and stop bleeding, and blacken the hair.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Liver-kidney vacuity with vacuity heat (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, dizziness, tinnitus, insomnia, and loss of memory due to liver-kidney vacuity with yin and blood not nourishing the upper part of the body (1)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Premature greying of hair and beard due to kidney essence vacuity (1)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nosebleed, bleeding gums, hemoptysis, hematemesis, hematuria, and metrorrhagia due to vacuity heat (1) (2)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the liver and supplements the kidneys', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cools the blood and stops bleeding', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches yin and blackens the hair', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the lower & upper parts', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Is harvested during the summer solstice', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the liver and supplements the kidneys', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears vacuity heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes liver yin and brightens the eyes', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Fills the essence and blackens the hair', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Is harvested during the winter solstice', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 80: Hong Hua & Tao Ren (p.92)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Flos Carthami Tinctorii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Pruni Persicae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Carthami Tinctorii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Pruni Persicae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 92, 'image00108.jpg', 'When these two medicinals are combined together, they complement and reinforce each other. Together, they effectively quicken the blood and dispel stasis, engender the blood and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cardiac and chest pain due to heart blood stasis (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Amenorrhea, dysmenorrhea, menstrual irregularities, and dark menstrual blood with clots due to blood stasis (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Fixed, stabbing, and severe pain aggravated by pressure due to blood stasis (3)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'All conditions with pain and swelling due to blood stasis (4)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and opens the channels', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels stasis and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the blood more strongly compared to Tao Ren', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Promotes blood engenderment', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tends to dispel stasis in the upper part of the body and in the channels', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Breaks blood (stasis)', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens dryness and lubricates the intestines', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels stasis more strongly compared to Hong Hua', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the blood very slightly', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to dispel stasis in the lower part of the body, in the abdomen, and in the organs', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 81: Huang Bai & Ze Xie (p.93)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Cortex Phellodendri';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Alismatis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Phellodendri';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Alismatis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 93, 'image00109.jpg', 'One drains dampness, while the other percolates dampness. One drains fire from the lower burner; the other drains dampness from the lower burner. When these two medicinals are combined together, they effectively clear and downbear vacuity fire due to yin vacuity. Together, they also clear and eliminate dampness and heat.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Steaming bones, night sweats, and seminal emission due to vacuity fire (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Inhibited urination and pricking, painful urination due to damp heat in the lower burner (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears vacuity heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire from the lower burner', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat from the yin division', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits urination and percolates dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire from the liver, kidney, and bladder channels', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears damp heat from the lower burner', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the qi division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 82: Huang Bai & Zhi Mu (p.93)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Cortex Phellodendri';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Anemarrhenae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Phellodendri';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Anemarrhenae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 93, 'image00109.jpg', 'When these two medicinals are combined together, they reinforce and complement each other. Together, they clear heat and enrich yin, drain vacuity fire, resolve toxins, and eliminate dampness in the lower burner.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Evening fever, steaming bones, and night sweats caused by yin vacuity (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Seminal emission, premature ejaculation, easy erection (in men), and women''s excessive thinking about sexual desire due to vacuity fire and hyperactive ministerial fire (2) (3)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dysuria due to yin vacuity and to yang losing its ability to transform (at the level of the bladder) (4)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Consolidates yin (1)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears vacuity heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tends to eliminate dampness from the lower burner', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys, moistens dryness, enriches yin', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and drains fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears the qi division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to drain vacuity fire from the lower burner', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 83: Huang Lian & Huang Qin (p.95)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Scutellariae Baicalensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Scutellariae Baicalensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 95, 'image00111.jpg', 'When these two medicinals are combined together, they effectively clear heat and dry dampness, drain fire and resolve toxins from the upper, middle, and lower burners.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Red, swollen, painful eyes, toothache with red, swollen gums, oral ulcers, and glossitis due to replete heat in the upper and middle burners (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vexation and agitation in warm disease with a breakdown in communication between the heart and kidneys (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Diarrhea and dysentery due to damp heat (3)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Hematemesis and epistaxis due to heat in the blood (1)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains heart, stomach & large intestine fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears and stops bleeding', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly clears the middle burner but also the upper & lower burners', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat generated by dampness', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains lung & large intestine fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and quiets the fetus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and stops bleeding', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mainly clears the upper burner but also the middle & lower burners', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates dampness generated by heat', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 8);

END $$;

-- Pair 84: Huang Lian & Mu Xiang (p.96)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Auklandiae Lappae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Auklandiae Lappae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 96, 'image00112.jpg', 'One is cold and drains; the other is warm and disperses. When these two medicinals are combined together, they effectively rectify the qi, drain heat, dry dampness, and treat dysentery.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Diarrhea, bloody and purulent dysentery, abdominal pain, and tenesmus due to damp heat and qi stagnation in the large intestine (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears the liver, stomach & heart', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter: thickens the intestines and stops diarrhea', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cold: cools the blood, resolves toxins, and treats diarrhea or bloody and purulent dysentery', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Arouses the spleen and disperses food stagnation', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi, disperses distention, and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter and aromatic: dries dampness', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid: disperses qi stagnation in the stomach and intestines and treats diarrhea with abdominal pain and tenesmus', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 85: Huang Lian & Rou Gui (p.96)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cortex Cinnamomi Cassiae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cortex Cinnamomi Cassiae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 96, 'image00112.jpg', 'One is cold; the other is hot. One is yin; the other is yang. One is for the upper burner and the heart; the other is for the middle burner and the kidneys. When these two medicinals are combined together, they harmonize yin and yang, drain the south (i.e., heart fire) and supplement the north (i.e., kidney yang), and re-establish the interaction between the heart and kidneys.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Insomnia, vexation and agitation due to heart and kidneys not interacting (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Glossitis, oral ulcers, heart palpitations together with fear of cold, long, clear urination, impotence, and seminal emission due to simultaneous heart fire and kidney yang vacuity', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears the heart', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains heart fire', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, hot', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the middle burner and scatters cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements kidney yang & life gate fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Returns fire to its source (1)', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-6g', 5);

END $$;

-- Pair 86: Huang Lian & Wu Zhu Yu (p.98)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Evodiae Rutecarpae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Evodiae Rutecarpae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 98, 'image00114.jpg', 'One is cold, while the other is hot. One drains, while the other opens. When these two medicinals are combined together, they effectively drain liver fire, harmonize the stomach, downbear counterflow, and stop pain, acid regurgitation, and vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Lateral costal pain and distention, nausea, vomiting, acid regurgitation, belching, clamoring stomach, and a bitter taste in the mouth due to liver depression transforming into fire which disturbs the stomach (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Diarrhea and dysentery due to damp heat', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and eliminates vexation', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'As the ruler', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears stomach heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats vomiting and acid regurgitation due to liver-stomach disharmony', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire from the liver channel', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter & cold: drains fire', 8);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g (1)', 9);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the middle burner and scatters cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears counterflow and stops vomiting', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains the liver and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warm but not hot; acrid but not drying; moistening but not cold', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to disperse qi stagnation in the lungs, moisten the lungs, and disperse phlegm stagnating in the lungs', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire from the liver channel', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Reinforces the action of Huang Lian to treat vomiting and acid regurgitation', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid and hot: opens and frees the flow', 8);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 2-5g (1)', 9);

END $$;

-- Pair 87: Huang Lian & Zi Su (p.99)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Coptidis Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Folium Et Caulis Perillae Frutescentis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Coptidis Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Folium Et Caulis Perillae Frutescentis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 99, 'image00115.jpg', 'One is bitter and cold; the other is acrid and warm. One clears and dries; the other moves and downbears. When these two medicinals are combined together, they clear stomach heat and, dry dampness, rectify the qi and stop vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vomiting and nausea due to stomach heat or damp heat in the middle burner along with qi stagnation in the middle burner (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vomiting during pregnancy due to heat or damp heat along with qi stagnation in the middle burner (1)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold, drying, clearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dries dampness', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears stomach & liver fire', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, warm, moving, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Resolves the toxicity of fish & crab', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 88: Huang Qi & Mu Li (p.100)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Astragali Membranacei';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Concha Ostreae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Astragali Membranacei';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Concha Ostreae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 100, 'image00116.jpg', 'One is a supplement; the other is an astringent. One supplements the qi; the other constrains yin. When these two medicinals are combined together, they effectively supplement the qi and constrain yin, secure the exterior and stop perspiration.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spontaneous perspiration due to qi or yang vacuity (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Night sweats due to yin vacuity (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spontaneous and nighttime perspiration due to qi and yin vacuity (1)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, warm, supplementing, upbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the qi and upbears yang', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the exterior and stops perspiration', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination and disperses swelling', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops perspiration by supplementing the exterior and filling the pores of the skin', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-30g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Salty, neutral, astringent, descending', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quiets the spirit by its heavy nature', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Astringent, holds what is escaping', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Calms the liver and subdues yang', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops perspiration by constraining yin and subduing yang', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-30g', 6);

END $$;

-- Pair 89: Huo Xiang & Pei Lan (p.101)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Agastachis Seu Pogostemi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Eupatorii Fortunei';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Agastachis Seu Pogostemi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Eupatorii Fortunei';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 101, 'image00117.jpg', 'When these two medicinals are combined together, they effectively transform dampness and turbidity, harmonize the middle burner, stop vomiting, eliminate summerheat (and dampness), and stop diarrhea.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, head distention, fever with or without perspiration, chest oppression, epigastric distention, nausea, vomiting, abdominal pain, and diarrhea due to external attack of summerheat dampness', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Spleen pure heat (1)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, aromatic', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strongly clears summerheat (mainly summerheat dampness)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the exterior', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms dampness and moves the qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the stomach and arouses the spleen', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, aromatic', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates summerheat (summerheat dampness and damp heat patterns of warm disease)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms dampness & turbidity', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the stomach and arouses the spleen', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Goes to the head', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 90: Ji Nei Jin & Mang Xiao (p.102)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Endothelium Corneum Gigeriae Galli';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Mirabilitum';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Endothelium Corneum Gigeriae Galli';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Mirabilitum';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 102, 'image00118.jpg', 'When these two medicinals are combined together, they strongly and effectively soften the hard and disperse accumulation, clear heat and transform stones.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Renal lithiasis, urethral lithiasis, and bladder lithiasis (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen & stomach', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses food stagnation', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the essence and reduces urination', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms stones', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens dryness and softens the hard', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains fire and disperses swelling', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Precipitates downward and frees the flow of the stools', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Softens & transforms stones', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 91: Jie Geng & Xing Ren (p.102)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Platycodi Grandiflori';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Pruni Armeniacae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Platycodi Grandiflori';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Pruni Armeniacae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 102, 'image00118.jpg', 'One upbears; the other downbears. One diffuses; the other drains. When these two medicinals are combined together, they effectively regulate the lungs'' function of diffusion and downbearing, transform and disperse phlegm, stop cough and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and/or asthma with chest oppression, profuse phlegm, sore throat, and aphonia due to an attack of external wind (wind cold or wind heat) that disturbs the diffusing and downbearing function of the lungs (3)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, diffusing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lung qi (1)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses phlegm (2)', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits the throat and stops cough', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly upbears, but also downbears', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly regulates the upper burner', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Guides other medicinals towards the lungs', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 8);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears lung qi (1)', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm (2)', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Calms asthma and stops cough', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 92: Jie Geng & Zhi Ke (p.103)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Platycodi Grandiflori';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Citri Aurantii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Platycodi Grandiflori';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Citri Aurantii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 103, 'image00119.jpg', 'One upbears; the other downbears. When these two medicinals are combined together, they effectively regulate upbearing and downbearing, regulate the upper and middle burners, diffuse the lung qi, and loosen the chest and diaphragm.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest and diaphragm oppression and distention or chest bi due to accumulation of phlegm and qi stagnation (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Epigastric distention, stomach rumbling, and difficult defecation due to disturbance of upbearing and downbearing (2) (3)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lungs and loosens the diaphragm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits the throat and stops cough', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly upbears, but also downbears', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly regulates the upper burner', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Guides other medicinals towards the lungs', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Loosens the chest & diaphragm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Rectifies the qi and moves phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi and disperses distention', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mainly downbears, but also upbears', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mainly regulates the middle burner but also the upper burner', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 6);

END $$;

-- Pair 93: Jin Yin Hua & Lian Qiao (p.104)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Flos Lonicerae Japonicae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Forsythiae Suspensae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Lonicerae Japonicae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Forsythiae Suspensae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 104, 'image00120.jpg', 'Both these medicinals are light, clearing, floating, diffusing, and dissipating. When they are combined together, they strongly and effectively clear heat and resolve toxins.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Colds and influenza due to wind heat (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Warm diseases with internal heat (1) (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headache, eye pain, toothache, sinusitis, and painful, swollen throat due to wind heat (2)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Skin eruptions with pruritus due to wind heat (2)', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Skin inflammation due to heat toxins (2)', 5);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, cold, light, fragrant', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat & wind heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves toxins from the blood division', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cools the blood and stops dysentery', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates heat from the upper part of the body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cool, light, floating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears the heart and upper burner fire', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Scatters nodulation and disperses swelling', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats skin inflammations', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates heat from the whole body', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 6);

END $$;

-- Pair 94: Jin Ying Zi & Qian Shi (p.105)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Rosae Laevigatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Euryalis Ferocis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Rosae Laevigatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Euryalis Ferocis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 105, 'image00121.jpg', 'One is more astringent; the other is more supplementing. When these two medicinals are combined together, they effectively secure the kidneys, secure the essence, and reduce urination, fortify the spleen and stop diarrhea and abnormal vaginal discharge.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic diarrhea due to spleen-kidney vacuity (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Urinary incontinence, enuresis, frequent micturition, and nocturia due to kidney qi vacuity (1) (3)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic white vaginal discharge due to spleen-kidney vacuity (1) (3)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Seminal emission and premature ejaculation due to kidney qi not securing (1) (3)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sour, astringent, holds what is escaping', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Reduces urination', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the essence', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops diarrhea and abnormal vaginal discharge', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-12g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Fortifies the spleen and stops diarrhea and abnormal vaginal discharge', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys, secures the essence, and reduces urination', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 3);

END $$;

-- Pair 95: Ju He & Li Zhi He (p.107)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Citri Reticulatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Litchi Chinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Citri Reticulatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Litchi Chinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 107, 'image00123.jpg', 'One is directed towards the qi division; the other towards the blood division. When these two medicinals are combined together, they are directed towards the liver channel and especially to the region of the pelvis. They effectively scatter cold, scatter nodulation, and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Inguinal hernia, swelling and pain of the testicles, and scrotal hernia all due to cold qi congealing and stagnating in the liver channel (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Piercing pain in the pelvis due to qi stagnation and blood stasis (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Masses in the pelvis (chronic salpingitis, chronic salpingo-ovartitis, chronic adnexitis, ovarian cysts, endometriosis, and fibroids) due to qi stagnation and blood stasis (2)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abnormal vaginal discharge due to vacuity cold (2)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters nodulation', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Directed towards the jue yin channel and the qi division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Directed towards the lower burner, into the kidney channel, and treats shan (1)', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi (& blood)', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Scatters cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Directed towards the jue yin channel and the blood division', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Directed towards the lower burner, the kidney channel, and treats shan (1)', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 96: Ju Hong & Zi Wan (p.108)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Epicarpium Rubrum Citri Reticulatae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Asteris Tatarici';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Epicarpium Rubrum Citri Reticulatae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Asteris Tatarici';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 108, 'image00124.jpg', 'One dries; the other moistens. One moves the qi; the other downbears the qi. One transforms phlegm; the other disperses phlegm. When these two medicinals are combined together, they effectively dry dampness and transform phlegm without drying the lungs, rectify the qi and stop cough.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough with profuse phlegm and chest oppression due to accumulation of phlegm and qi stagnating in the lungs (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough with white, low-grade fever, fear of cold, and profuse phlegm due to wind evils attacking the lungs (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough of internal or external origin due to cold or heat, repletion or vacuity (1)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters cold and rectifies the qi', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the exterior', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dries dampness and transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses food stagnation and disperses distention', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warm, drying, aromatic: tends to dry dampness and transform phlegm causing cough and moves the qi to the lungs', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the lungs and downbears counterflow', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates phlegm and stops cough', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains lung heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warm but not hot; acrid but not drying; moistening but not cold', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tends to disperse qi stagnation in the lungs, moisten the lungs, and disperse phlegm stagnating in the lungs', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 97: Ju Hua & Sang Ye (p.109)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Flos Chrysanthemi Morifolii';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Folium Mori Albi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Flos Chrysanthemi Morifolii';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Folium Mori Albi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 109, 'image00125.jpg', 'One mainly clears heat; the other mainly dispels wind. One is for the liver; the other is for the lungs. When these two medicinals are combined together, they effectively dispel wind heat, clear the liver and brighten the eyes, clear heat and stop cough.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Fever, slight fear of wind, light perspiration, cough, headache, and slight thirst due to wind heat attacking the lungs (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headache, vertigo, photophobia, and red, swollen, painful eyes due to ascendant hyperactivity of liver yang (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and dispels wind', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears the liver, brightens the eyes, and clears the head', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Calms the liver and extinguishes wind', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Directed to the eyes & liver channel', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Superior for clearing heat & the liver', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind heat', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Diffuses the lungs and drains heat from the lungs, moistens the lungs and stops cough', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears the liver and brightens the eyes', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Directed to the lungs network vessels', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Superior for dispelling wind', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 98: Lian Zi & Qian Shi (p.110)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Nelumbinis Nuciferae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Euryalis Ferocis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Nelumbinis Nuciferae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Euryalis Ferocis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 110, 'image00126.jpg', 'When these two medicinals are combined together, they mutually reinforce each other. Together, they effectively fortify the spleen and stop diarrhea, supplement the kidneys and secure the essence, reduce urination and stop abnormal vaginal discharge.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Enduring diarrhea due to spleen vacuity (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Abnormal vaginal discharge due to spleen vacuity causing accumulation of dampness (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Seminal emission and premature ejaculation due to kidney qi vacuity (3)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Frequent urination, incontinence, and enuresis due to kidney qi vacuity (4)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, astringent', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fortifies the spleen and stops diarrhea', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the kidneys and secures the essence', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the heart and quiets the spirit', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Promotes the interaction between the heart & kidneys', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Superior for supplementing the spleen and nourishing the heart', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-12g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, astringent', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys, secures the essence, and reduces urination', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Fortifies the spleen and stops diarrhea', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates dampness and stops vaginal discharge', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Superior for supplementing the kidneys and securing the essence', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 6);

END $$;

-- Pair 99: Long Gu & Mu Li (p.111)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Os Draconis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Concha Ostreae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Os Draconis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Concha Ostreae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 111, 'image00127.jpg', 'When these two medicinals are combined together, they mutually reinforce each other. Together, they effectively calm the liver and subdue yang, quiet the spirit, soften the hard and scatter nodulations, and hold and constrain (abnormal discharge).')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vexation and agitation, heart palpitations, insomnia, loss of memory, dizziness, vertigo, photophobia, and tinnitus due to liver yang hyperactivity harassing the spirit (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Arterial high blood pressure due to yin vacuity causing liver yang hyperactivity (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Continuous diarrhea or dysentery (3)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Urinary incontinence, spermatorrhea, abnormal vaginal discharge, and excessive perspiration due to vacuity (3)', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain and distention in the lateral costal region (4)', 5);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, astringent, neutral', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Fossilized bone and, therefore, heavy by nature', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Calms the liver and subdues yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quiets the spirit & ethereal soul with its heavy nature', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops tremors', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops perspiration and secures the essence', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops bleeding and stops diarrhea', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Promotes tissue regeneration and speeds up healing', 8);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Normal dosage: 15-30g', 9);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Salty, astringent, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'A shell and, therefore, heavy by nature', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Calms the liver and subdues yang', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quiets the spirit & corporeal soul with its heavy nature', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops tremors', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops perspiration and secures the essence', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Softens the hard and scatters nodulations', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats gastric hyperacidity', 8);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Normal dosage: 15-30g', 9);

END $$;

-- Pair 100: Ma Huang & She Gan (p.112)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Ephedrae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Belamcandae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Ephedrae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Belamcandae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 112, 'image00128.jpg', 'One is warm; the other is cold. One diffuses; the other downbears. When these two medicinals are combined together, they combine the diffusion and downbearing methods. Together, they diffuse the lungs and downbear the qi, disperse phlegm and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Asthma with asthmatic wheezing due to accumulation of phlegm rheum that blocks the circulation of lung qi which then counterflows (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Scatters cold and resolves the exterior', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lung qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Calms asthma', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination and disperses swelling', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-6g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, cold, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and resolves toxins', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the lung qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses phlegm', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disinhibits the throat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 101: Ma Huang & Shi Gao (p.113)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Ephedrae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Ephedrae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 113, 'image00129.jpg', 'One is warm; the other is cold. One scatters cold; the other clears heat. One diffuses; the other downbears. When these two medicinals are combined together, they complement and mutually reinforce one another. Together, they effectively diffuse the lungs and calm asthma, disinhibit urination and disperse swelling, clear heat and drain fire.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Wind water or edema with fever, fear of wind, edema of the face, eyes, and limbs, joint pain, oliguria, and a floating pulse due to external wind (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Generalized edema with abdominal repletion, dyspnea, and a deep, slow pulse due to spleen-kidney yang vacuity (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Stone water or stone edema with the pelvis swollen and hard as a stone, pain and distention in the lateral costal region, edema, abdominal distention, and a deep pulse due to accumulation of yin cold in the liver and kidneys (2)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough, asthma with fast breathing, sometimes fever and perspiration, thirst, a red tongue with yellow fur, and a slippery, rapid pulse due to lung heat (3)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm, floating, diffusing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Its stem is hollow; its tendency is to diffuse', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lung qi and calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Opens the interstices and promotes perspiration', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms and transforms the bladder (i.e., urination)', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination and disperses swelling', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, cold, downbearing, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Its body is heavy; its tendency is to downbear', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and drains fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Resolves heat from the muscles', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains lung heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears stomach heat', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Engenders fluids and stops thirst', 7);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-60g', 8);

END $$;

-- Pair 102: Ma Huang & Shu Di (p.114)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Ephedrae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cooked Radix Rehmanniae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Ephedrae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cooked Radix Rehmanniae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 114, 'image00130.jpg', 'One dissipates; the other nourishes. One dries; the other moistens. One is for the lungs; the other is for the kidneys. When these two medicinals are combined together, metal and water generate each other. Together, they simultaneously address the branch manifestations and root cause. Together, they supplement the kidneys and boost the essence, diffuse the lungs and calm asthma, and scatter nodulations and disperse lumps.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic asthma with yin (or blood) vacuity (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Asthma in women during menstruation (1)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic asthma with kidney vacuity cold (1)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Subcutaneous nodules, carbuncles, abscesses, toe gangrene due to arterial sclerosis, thromboangiitis obliterans, and swollen, painful knees of the yin type due to cold and dampness obstructing the channels (2)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, warm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sudorific, resolves the exterior', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lungs and calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits urination and disperses swelling', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strong dissipating property which tends to damage the correct qi', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-9g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, warm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the blood and engenders fluids', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the liver and enriches the kidneys', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the kidneys and boosts the essence', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishing and greasy property which tends to engender dampness and cause stomach qi stagnation', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-15g', 6);

END $$;

-- Pair 103: Ma Huang & Xing Ren (p.115)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Ephedrae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Pruni Armeniacae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Ephedrae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Pruni Armeniacae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 115, 'image00131.jpg', 'One diffuses; the other downbears. When these two medicinals are combined together, they complement and mutually assist each other. Together, they rectify the lungs qi, stop cough, and calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Wind cold pattern (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and asthma due to wind cold (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and asthma due to lung heat (3)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, dissipating', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Diffuses the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Induces perspiration and resolves the exterior', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears the lung qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops cough and calms asthma', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 104: Mai Men Dong & Tian Men Dong (p.116)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Tuber Ophiopogonis Japonici';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Tuber Aspargi Cochinensis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Tuber Ophiopogonis Japonici';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Tuber Aspargi Cochinensis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 116, 'image00132.jpg', 'When these two medicinals are combined together, sweet and cold clear and moisten. Together, they nourish yin and moisten dryness, clear vacuity heat (or replete heat damaging yin) of the lungs, stomach, and kidneys.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Dry mouth, thirst, dry cough with little phlegm, fever, and vexation due to vacuity heat (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough with hemoptysis due to heat damaging the network vessels of the lungs (1)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Upper thirsting & wasting with excessive drinking, thirst, and dry throat and tongue due to lung heat damaging the fluids', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Whooping cough damaging lung yin (2)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, slightly cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and nourishes yin', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens the lungs, stops cough, and transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the stomach and engenders fluids', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears the heart and eliminates vexation', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes, moistens & clears the upper & middle burners', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 7);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Sweet, very cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and nourishes yin', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the lungs and stops cough', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the kidneys and downbears vacuity fire', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes, moistens & clears the upper and lower burners', 6);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-15g', 7);

END $$;

-- Pair 105: Mo Yao & Ru Xiang (p.117)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Resina Myrrhae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Resina Olibani';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Resina Myrrhae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Resina Olibani';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 117, 'image00133.jpg', 'One tends to rectify the blood; the other to rectify the qi. When these two medicinals are combined together, they complement and mutually reinforce each other. Together, they effectively move the qi and quicken the blood, dispel stasis, free the flow of the viscera and bowels or channels and network vessels, quicken the network vessels, disperse swelling, stop pain, and constrain (weeping) sores and engender muscle (i.e., flesh).')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain in the epigastrium, abdomen, hypochondria, and/or heart due to qi and blood stasis and stagnation in the viscera and bowels or channels and network vessels', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Amenorrhea, dysmenorrhea, or postpartum abdominal pain due to blood stasis', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Rheumatic complaints due to wind dampness causing qi and blood stagnation and stasis in the network vessels', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Wounds, scars, and skin inflammations with blood stasis and necrotic tissue', 4);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Traumatic injuries with pain, swelling, and redness due to qi stagnation and blood stasis (1)', 5);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Neutral, bitter, draining', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and breaks stasis', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses swelling and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Mainly quickens the blood and dispels stasis', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warm, aromatic, acrid, moving', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the blood and qi, quickens the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Soothes the sinews and frees the flow of the network vessels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses swelling and stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Mainly moves the qi and quickens the blood', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 6);

END $$;

-- Pair 106: Pu Gong Ying & Zi Hua Di Ding (p.118)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Herba Taraxaci Mongolici Cum Radice';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Violae Yedoensis Cum Radice';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Taraxaci Mongolici Cum Radice';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Violae Yedoensis Cum Radice';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 118, 'image00134.jpg', 'When these two medicinals are combined together, they mutually reinforce each other. Together, they effectively clear heat and resolve toxins, disperse and scatter welling abscesses and swelling, and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pyogenic cutaneous inflammations and erysipelas due to heat toxins (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Mastitis and appendicitis due to heat toxins (1)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Urinary tract infection due to heat toxins (1)', 3);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pyogenic inflammatory illnesses due to heat toxins (1) (2) (3)', 4);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Bitter, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the qi division', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disperses welling abscesses, softens the hard, and scatters nodulation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-30g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, acrid, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the blood division', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat, cools the blood, and resolves toxins', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses and scatters welling abscesses & swelling', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 5);

END $$;

-- Pair 107: Pu Huang & Wu Ling Zhi (p.119)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Pollen Typhae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Feces Trogopterori Seu Pteromi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Pollen Typhae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Feces Trogopterori Seu Pteromi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 119, 'image00135.jpg', 'When these two medicinals are combined together, they effectively quicken the blood, dispel stasis, and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Epigastric, cardiac, abdominal, and lateral costal pain due to qi stagnation and blood stasis (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Menstrual irregularities, amenorrhea, dysmenorrhea, postpartum abdominal pain, and retention of the lochia due to blood stasis (1) (3)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cools the blood and stops bleeding by astringing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood and dispels stasis', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Superior for stopping bleeding', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Better for treating pain due to blood stasis of the heat type', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and dispels stasis, stops bleeding by dispelling stasis', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Superior for stopping pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Better for treating pain due to blood stasis of the cold type', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-12g', 5);

END $$;

-- Pair 108: Sang Ji Sheng & Sang Zhi (p.120)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Ramulus Loranthi Seu Visci';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Ramulus Mori Albi';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Ramulus Loranthi Seu Visci';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Ramulus Mori Albi';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 120, 'image00136.jpg', 'One supplements; the other dispels. One nourishes; the other frees the flow. When these medicinals are combined together, they supplement the liver and kidneys, strengthen the sinews and bones, dispel wind dampness, free the flow of the channels.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Low back and limb pain, numbness of the limbs, loss of joint mobility, and rheumatic pain due to wind damp bi and kidney or blood vacuity in turn due to malnourishment of the sinews', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Arterial hypertension with headache, vertigo, tinnitus, and heart palpitations due to liver-kidney yin vacuity causing liver yang hyperactivity', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the liver & kidneys', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Strengthens the sinews, bones, and lumbus', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Supplements the blood and nourishes the vessels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels wind dampness', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-30g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees the four limbs and disinhibits the joints', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees the flow of the channels and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind, dampness, and heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-30g', 4);

END $$;

-- Pair 109: Sha Ren & Shu Di (p.120)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Amomi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cooked Radix Rehmanniae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Amomi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cooked Radix Rehmanniae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 120, 'image00136.jpg', 'When these two medicinals are combined together, they strongly nourish the blood, essence, and yin without giving rise to qi stagnation or loss of appetite.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Liver-kidney yin or essence vacuity, blood vacuity associated with weakness of the spleen and stomach, particularly due to loss of control over their movement and transformation functions (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi and rectifies the middle burner', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms dampness and warms the middle burner', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Arouses the spleen and stimulates the appetite', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Guides the qi towards the kidneys', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 2-5g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the blood and nourishes fluids and humors', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the liver and enriches the kidneys', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Boosts the essence and fills the bone marrow', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Slimy and rich in nature, difficult to assimilate, tends to block the stomach qi', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 5);

END $$;

-- Pair 110: Sheng Di & Shi Gao (p.121)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Uncooked Radix Rehmanniae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Uncooked Radix Rehmanniae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 121, 'image00137.jpg', 'One is for the blood division; the other is for the qi division. When these two medicinals are combined together, they clear heat from the qi and blood divisions.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'High fever, great thirst, eruption of reddish macula, hemorrhage, mental confusion, a red tongue, and scarlet, dry lips due to heat in qi and blood divisions (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Bleeding gums, gingivitis, oral ulcers, toothache, and thirst due to stomach heat damaging kidney yin (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Goes towards the blood division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Cools the blood and stops bleeding', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes yin and clears heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heart fire', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-30g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Goes towards the qi division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears yang ming & qi division heat', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Drains lung & stomach heat', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-60g', 4);

END $$;

-- Pair 111: Sheng Di & Shu Di (p.122)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Uncooked Radix Rehmanniae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Cooked Radix Rehmanniae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Uncooked Radix Rehmanniae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Cooked Radix Rehmanniae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 122, 'image00138.jpg', 'When these two medicinals are combined together, they mutually reinforce each other. Together, they enrich liver-kidney yin, boost the essence and fill the bone marrow, supplement the blood and engender blood, cool the blood and clear heat.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Persistent, low-grade fever due to warm disease damaging yin (fluids)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Tidal fever and steaming bones due to yin (essence) vacuity or blood vacuity', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Vertigo, insomnia, menstrual irregularities, oligomenorrhea, and metrorrhagia due to liver-kidney blood and essence vacuity', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and cools the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches yin, engenders fluids, and nourishes the blood', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 10-15g', 3);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements blood & yin', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the liver & kidneys', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Boosts the essence and fills the bone marrow', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 10-30g', 4);

END $$;

-- Pair 112: Sheng Di & Xi Xin (p.123)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Uncooked Radix Rehmanniae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Asari Cum Radice';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Uncooked Radix Rehmanniae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Asari Cum Radice';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 123, 'image00139.jpg', 'When these two medicinals are combined together, Xi Xin, which is acrid, dispelling, and upbearing, carries Sheng Di, which is sweet, cold, and downbearing, towards the upper burner to clear heat. Together, they dispel wind, clear heat, and stop pain without drying.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headache and toothache due to wind fire or vacuity fire (1)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and cools the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Enriches yin and engenders fluids', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Nourishes the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops bleeding', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the interior', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind and stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees the flow of the network vessels and stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dosage: 1-3g', 5);

END $$;

-- Pair 113: Sheng Jiang & Zhu Ru (p.124)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Uncooked Rhizoma Zingiberis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Caulis Bambusae In Taeniis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Uncooked Rhizoma Zingiberis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Caulis Bambusae In Taeniis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 124, 'image00140.jpg', 'One is warm; the other is cold. When these two medicinals are combined together, they effectively harmonize the stomach and downbear stomach qi counterflow, transform phlegm, eliminate cold and heat, and stop vomiting.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Nausea, vomiting, and hiccup due to stomach disharmony and stomach qi counterflow due to mixed cold and heat in the stomach or accumulation of phlegm in the stomach', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms the middle burner and transforms phlegm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the stomach and drains cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Downbears counterflow and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat and transforms phlegm', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Harmonizes the stomach and clears the stomach', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Downbears counterflow and stops vomiting', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 4);

END $$;

-- Pair 114: Shi Chang Pu & Yuan Zhi (p.124)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Acori Graminei';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Radix Polygalae Tenuifoliae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Acori Graminei';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Polygalae Tenuifoliae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 124, 'image00140.jpg', 'When these two medicinals are combined together, they go to the heart, transform phlegm, and open the portals of the heart. They re-establish the interaction between the heart and kidneys, boost the intelligence, and arouse the spirit.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Mental confusion, mental retardation, decrease of intellectual acuity, vertigo, insomnia, and mental agitation due to heart and kidneys not interacting or phlegm confounding the orifices of the heart (1) (2)', 1);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Opens the orifices or portals of the heart', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Transforms phlegm confounding the portals of the heart', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Rectifies the qi and transforms phlegm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Arouses & quiets the spirit', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Re-establishes the interaction between the heart & kidneys', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Supplements the heart qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quiets the spirit and boosts the intelligence', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Transforms phlegm and opens the orifices', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 5);

END $$;

-- Pair 115: Shi Gao & Xi Xin (p.125)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Asari Cum Radice';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Asari Cum Radice';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 125, 'image00141.jpg', 'One is cold; the other is hot. Thus their opposite natures combine and complement each other. Xi Xin, acrid, dispelling, and upbearing, carries Shi Gao, cold, clearing, and draining, towards the upper burner to clear heat. When these two medicinals are combined together, they clear heat and drain fire, free the flow of the network vessels and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Toothache, bleeding gums, swollen, painful gums, oral ulcers, and glossitis due to stagnation of heat in the stomach', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Headache due to wind heat entering the clear orifices', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, very cold, heavy, draining, downbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat and drains fire', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Resolves the muscle aspect', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates vexation and stops thirst', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains stomach & lung heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-30g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, warm, light, dispelling, upbearing', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind cold', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels floating heat from the orifices of the upper burner', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Frees the flow of the network vessels and stops the pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 1-3g', 5);

END $$;

-- Pair 116: Shi Gao & Zhi Mu (p.126)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Anemarrhenae Aspheloidis';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Anemarrhenae Aspheloidis';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 126, 'image00142.jpg', 'One tends to clear; the other to moisten. When these two medicinals are combined together, they strongly clear replete heat while protecting fluids and yin. Together, they effectively clear replete heat from the lungs and stomach.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Persistent high fever, great thirst and desire for cold drinks, a dry tongue, vexation, profuse perspiration, and a surging, big pulse due to heat in the qi division (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Upper thirsting & wasting with polydipsia, a dry mouth and tongue, and great thirst due to replete lung heat damaging fluids (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sweet, acrid, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Heavy body and downbearing property', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears replete heat from the qi division and yang ming channels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat from the lungs & stomach', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Only treats replete heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-30g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Bitter, sweet, cold, moistening', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Rich body and moistening property', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes yin, moistens dryness, and drains ministerial fire', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the lungs & stomach', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats replete & vacuity heat', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 117: Shi Gao & Zhu Ye (p.128)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Gypsum Fibrosum';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Folium Bambusae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Gypsum Fibrosum';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Folium Bambusae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 128, 'image00144.jpg', 'One is heavy, while the other is light. One is downbearing; the other is upbearing. One is draining; the other is dispelling. When these two medicinals are combined together, they clear heat in the upper and lower parts of the body as well as in both the interior and exterior. Together they effectively clear heat in the lungs, stomach, and heart, eliminate vexation and stop thirst.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Persistent fever due to retained heat in the lungs and stomach damaging the qi and yin, as in the terminal phase of a warm disease, with vexation, heat, chest oppression, nausea, vomiting, and thirst (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough, a sensation of heat in the chest, and thirst due to heat in the lungs', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Glossitis, oral ulcers, stomatitis, foul breath, and thirst due to stomach heat', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Acrid, sweet, very cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Heavy, downbearing, draining', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains fire and clears the qi division', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Clears heat from the lungs & stomach', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Eliminates vexation and stops thirst', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 15-60g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, sweet, cold', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Light, floating, dispelling', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels wind heat, clears the defensive', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Clears heat from the lungs & heart', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates vexation and stops thirst', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-15g', 6);

END $$;

-- Pair 118: Tao Ren & Xing Ren (p.129)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Semen Pruni Persicae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Semen Pruni Armeniacae';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Pruni Persicae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Semen Pruni Armeniacae';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 129, 'image00145.jpg', 'One is for the blood division; the other is for the qi division. When these two medicinals are combined together, they quicken the blood, move the qi, and stop pain, moisten the intestines and free the flow of the stools.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chest, epigastric, and lower abdominal pain due to qi stagnation and blood stasis (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation of the vacuity type due to dryness in the large intestine (2)', 2);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Constipation of the repletion type due to qi stagnation (3)', 3);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Oleaginous seed from the peach', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moistens dryness and lubricates the intestines', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Quickens the blood, dispels stasis, stops pain', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Treats constipation due to large intestine fluid dryness', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 6-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Oleaginous seed from the apricot', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moistens the intestines and frees the flow of the stools', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and downbears the qi', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Eliminates phlegm and stops cough', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Treats constipation due to qi stagnation and dryness', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 6-10g', 6);

END $$;

-- Pair 119: Wu Wei Zi & Xi Xin (p.130)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Fructus Schisandrae Chinensis';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Asari Cum Radice';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Schisandrae Chinensis';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Asari Cum Radice';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 130, 'image00146.jpg', 'One is sour and astringing; the other is acrid and dispelling. One constrains; the other opens. When these two medicinals are combined together, they complement each other and combine the methods of diffusion and constraint. Together, they effectively transform phlegm and diffuse the lung qi, stop cough, constrain the lung qi, calm asthma.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Cough and asthma due to wind cold and/or accumulation of phlegm cold in the lungs (1) (2)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Chronic cough and asthma due to lung-kidney vacuity (3)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Sour, astringent, secures and holds', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Constrains the lung qi and nourishes the kidneys', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Engenders fluids', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops perspiration', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Secures the essence and stops diarrhea', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 6);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Acrid, dispelling, warm, frees the flow', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Warms the lungs and transforms phlegm', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Scatters cold and resolves the exterior', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Expels wind and stops pain', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Opens the nose orifices', 5);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 1-3g', 6);

END $$;

-- Pair 120: Wu Yao & Yan Hu Suo (p.131)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Radix Linderae Strychnifoliae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Corydalis Yanhusuo';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Radix Linderae Strychnifoliae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Corydalis Yanhusuo';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 131, 'image00147.jpg', 'One rectifies the qi; the other the blood. When these two medicinals are combined together, they effectively quicken the blood and dispel stasis, move the qi and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Epigastric and abdominal pain due to qi stagnation and blood stasis (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Inguinal hernia and scrotal pain and distention (i.e., shan) due to qi and cold stagnation in the liver and kidney channels (2)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the qi division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Warms & scatters cold in the liver & kidney channels', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Stops pain, particularly in the epigastric and lower abdominal areas', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the blood division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and moves the qi', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain efficiently', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Stops pain in the whole body — the upper & lower, interior & exterior', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 3-10g', 5);

END $$;

-- Pair 121: Xiang Fu & Yi Mu Cao (p.132)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Rhizoma Cyperi Rotundi';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Herba Leonuri Heterophylli';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Rhizoma Cyperi Rotundi';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Herba Leonuri Heterophylli';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 132, 'image00148.jpg', 'One is for the qi; the other is for the blood. These are two key medicinals for gynecological problems. When these two medicinals are combined together, they effectively move the qi and resolve depression, quicken the blood and dispel stasis, and regulate the menses.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Menstrual irregularities, abdominal pain and distention before the period, postpartum abdominal pain, and dysmenorrhea due to qi stagnation (liver) and blood stasis (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Traumatic injury', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the qi division but also the blood', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Drains the liver and resolves depression', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Harmonizes the qi & blood, moves the qi to quicken the blood, regulates the menses', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 3-10g', 4);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the blood division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Quickens the blood and regulates the menses', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Dispels stasis without damaging the blood', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Nourishes the blood without engendering stasis', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 15-30g', 5);

END $$;

-- Pair 122: Yu Jin & Zhi Ke (p.133)
DO $$
DECLARE
  v_herb1_id INTEGER;
  v_herb2_id INTEGER;
  v_pair_id  INTEGER;
BEGIN
  SELECT id INTO v_herb1_id FROM herbal.herbs WHERE latin_name = 'Tuber Curcumae';
  SELECT id INTO v_herb2_id FROM herbal.herbs WHERE latin_name = 'Fructus Immaturus Citri Aurantii';

  IF v_herb1_id IS NULL THEN
    RAISE WARNING 'Herb not found: Tuber Curcumae';
    RETURN;
  END IF;
  IF v_herb2_id IS NULL THEN
    RAISE WARNING 'Herb not found: Fructus Immaturus Citri Aurantii';
    RETURN;
  END IF;

  INSERT INTO herbal.dui_yao_pairs
    (herb1_id, herb2_id, book_page, image_file, combined_summary)
  VALUES
    (v_herb1_id, v_herb2_id, 133, 'image00149.jpg', 'One is for the blood division; the other is for the qi division. When these two medicinals are combined together, they complement each other. Together, they effectively move the qi and quicken the blood, resolve depression and stop pain.')
  ON CONFLICT (herb1_id, herb2_id) DO UPDATE
    SET book_page = EXCLUDED.book_page,
        image_file = EXCLUDED.image_file,
        combined_summary = EXCLUDED.combined_summary
  RETURNING id INTO v_pair_id;

  -- Indications
  DELETE FROM herbal.dui_yao_indications WHERE pair_id = v_pair_id;
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Piercing pain and distention in the lateral costal region due to liver depression qi stagnation causing liver blood stasis (1)', 1);
  INSERT INTO herbal.dui_yao_indications (pair_id, indication, sort_order)
  VALUES (v_pair_id, 'Pain and distention of the epigastrium and lateral costal region due to liver-stomach disharmony with qi stagnation which progressively produces blood stasis (1)', 2);

  -- Herb 1 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb1_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Tropism: the blood & qi divisions', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Dispels stasis and stops pain', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Moves the qi and resolves liver depression', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Disinhibits the gallbladder and treats jaundice', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb1_id, 'Usual dosage: 9-15g', 5);

  -- Herb 2 properties
  DELETE FROM herbal.dui_yao_herb_properties WHERE pair_id = v_pair_id AND herb_id = v_herb2_id;
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Tropism: the qi division', 1);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Moves the qi and disperses distention', 2);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Loosens the chest & diaphragm', 3);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Disperses food accumulation', 4);
  INSERT INTO herbal.dui_yao_herb_properties (pair_id, herb_id, property, sort_order)
  VALUES (v_pair_id, v_herb2_id, 'Usual dosage: 5-10g', 5);

END $$;

DO $$ BEGIN
  RAISE NOTICE 'Migration 082 complete: % Dui Yao pairs inserted',
    (SELECT count(*) FROM herbal.dui_yao_pairs);
END $$;