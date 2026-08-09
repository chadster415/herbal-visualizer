SET search_path TO herbal, public;

-- Respiratory - Lower case study: Subjective and Objective SOAP notes.
-- Continues from migration 135.

-- Block 4: Subjective notes (sort_order 200–590)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES

    -- Primary Health Concerns
    (v_dis_id, 'Chronic asthma since childhood, exercise-induced and worsened by stress and seasonal changes',                       210, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Wheezing (especially on exhalation) and chest tightness; flare-ups often turn into wet coughs',                     220, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Mostly dry coughs; sometimes clear mucus, some yellow in the mornings',                                             230, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Three ER visits in the past year for severe asthma attacks; lives in fear of another episode',                      240, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Seasonal allergies triggered by dust, animal dander, and pollution',                                                 250, 'subjective', 'Primary Health Concerns'),
    (v_dis_id, 'Lives near an oil refinery — chronic high pollution exposure',                                                       260, 'subjective', 'Primary Health Concerns'),

    -- Lifestyle & Environment
    (v_dis_id, 'Regular bike riding and commuting to work; sometimes shortness of breath that turns into an asthma attack',          280, 'subjective', 'Lifestyle & Environment'),
    (v_dis_id, 'High stress from work; maintains a positive outlook on life',                                                        290, 'subjective', 'Lifestyle & Environment'),
    (v_dis_id, 'Actively involved in community mutual aid and artistic expression',                                                  300, 'subjective', 'Lifestyle & Environment'),
    (v_dis_id, 'Tends to run cold, easily overwhelmed; grew up in a city with little exposure to nature',                           310, 'subjective', 'Lifestyle & Environment'),

    -- Energy and Mental State
    (v_dis_id, 'Anxiety and panic attacks; difficulty winding down',                                                                 320, 'subjective', 'Energy and Mental State'),
    (v_dis_id, 'Feels "wired but tired" — poor sleep (5–6 hours per night)',                                                        330, 'subjective', 'Energy and Mental State'),
    (v_dis_id, 'Often gets sick after stressful situations; fatigue and reduced energy during exacerbations',                       340, 'subjective', 'Energy and Mental State'),

    -- Other Symptoms
    (v_dis_id, 'Bloating, digestive discomfort, gas',                                                                               360, 'subjective', 'Other Symptoms'),
    (v_dis_id, 'Muscle tightness',                                                                                                  370, 'subjective', 'Other Symptoms'),

    -- Nutrition
    (v_dis_id, 'Morning: smoothies, oatmeal with fruit/nuts/yogurt, coffee',                                                        390, 'subjective', 'Nutrition'),
    (v_dis_id, 'Daytime: sporadic eating, snacks more than full meals',                                                              400, 'subjective', 'Nutrition'),
    (v_dis_id, 'Lunch: salads, sandwiches (meat and cheese), pasta with vegetables',                                                 410, 'subjective', 'Nutrition'),
    (v_dis_id, 'Dinner: salads, various meats (chicken, fish, beef, pork) with grains',                                             420, 'subjective', 'Nutrition'),
    (v_dis_id, 'Drinks: water (probably not enough), lemonade, sodas',                                                              430, 'subjective', 'Nutrition'),

    -- Current Medications
    (v_dis_id, 'Rescue inhaler (albuterol) — daily use for sudden symptoms',                                                        450, 'subjective', 'Current Medications'),
    (v_dis_id, 'Occasionally smokes cannabis',                                                                                      460, 'subjective', 'Current Medications')

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Respiratory - Lower case study: Subjective notes inserted';
END $$;

-- Block 5: Objective notes (sort_order 600–790)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';
  SELECT id INTO v_dis_id FROM herbal.disorders WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order, section, heading) VALUES
    (v_dis_id, 'No laboratory values or formal diagnoses provided at intake', 600, 'objective', NULL)
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Respiratory - Lower case study: Objective notes inserted';
END $$;
