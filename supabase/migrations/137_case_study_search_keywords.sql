SET search_path TO herbal, public;

-- Add 100 search keywords to each case study disorder so they appear
-- in the All Systems & Disorders search box.
-- Keywords are deduced from Subjective, Objective, and Plan of Care content.

-- Immune case study (Peter — Eosinophilic Esophagitis)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  UPDATE herbal.disorders SET search_keywords = ARRAY[
    -- Primary diagnosis
    'eosinophilic esophagitis',
    'EoE',
    'esophageal inflammation',
    'esophagus allergy',
    'allergic esophagitis',
    'esophageal eosinophils',
    'esophageal hypersensitivity',
    -- Cardinal symptom
    'choking first bite',
    'vomiting eating',
    'choking episodes',
    'swallowing difficulty',
    'dysphagia',
    'food impaction risk',
    'hot hungry choking',
    -- Immune/allergic mechanisms
    'mast cell allergy',
    'mast cell stabilizer',
    'mast cell activation',
    'eosinophil mediated',
    'histamine sensitivity',
    'histamine release',
    'histamine intolerance',
    'antihistamine herbs',
    'anti-allergic herbs',
    'Th2 immune response',
    'Th2 dominant pattern',
    'immune dysregulation',
    'immune modulation',
    'allergic signaling',
    'anaphylaxis prevention',
    -- Esophageal treatment
    'esophageal mucosa',
    'mucosal protection',
    'mucosal barrier',
    'esophageal soothing',
    'demulcent herbs',
    'marshmallow root',
    'cold infusion',
    'marshmallow overnight',
    -- Secondary diagnoses
    'hypertension',
    'high blood pressure',
    'elevated blood pressure',
    'blood pressure medication',
    'seasonal allergic rhinitis',
    'allergic rhinitis',
    'seasonal allergies',
    'hay fever',
    'athlete''s foot',
    'tinea pedis',
    'fungal infection foot',
    'hemorrhoids',
    'rectal hemorrhoids',
    'colon polyps',
    'benign polyps',
    'constipation',
    'cold extremities',
    'cold hands feet',
    'poor circulation',
    'delayed urination',
    -- Diet and lifestyle
    'beer drinking',
    'alcohol consumption',
    'fast eating',
    'elimination diet',
    'red meat elimination',
    'beer elimination',
    'food journal',
    'food diary',
    'low histamine diet',
    'high histamine foods',
    'histamine food list',
    'heavy diet',
    'beer burgers diet',
    'cereal breakfast',
    -- Supplements and plan
    'quercetin supplement',
    'quercetin 50mg',
    'flavonoid supplement',
    'flax seed daily',
    'ground flaxseed',
    'sea salt water',
    'salt water morning',
    -- Herbs used
    'White Peony',
    'Paeonia lactiflora',
    'Chinese Skullcap',
    'Scutellaria baicalensis',
    'Astragalus',
    'Astragalus membranaceus',
    'Albizia',
    'Albizia lebbeck',
    -- Actions
    'anti-inflammatory',
    'immune regulation',
    'Th2 allergy',
    'mucosal inflammation',
    -- Patient context
    'sedentary desk job',
    'working from home',
    'Peter case study',
    'EoE tincture',
    'immune case study',
    'refuses medication',
    'declines prescription',
    'Peter',
    '42 year old male',
    'gym exercise'
  ] WHERE id = v_dis_id;

  RAISE NOTICE 'Immune case study: search_keywords set (100 terms)';
END $$;

-- Respiratory - Lower case study (asthma patient)
DO $$
DECLARE
  v_sys_id INTEGER;
  v_dis_id INTEGER;
BEGIN
  SELECT id INTO v_sys_id FROM herbal.body_systems WHERE name = 'Respiratory - Lower';
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Case Study' AND body_system_id = v_sys_id;

  UPDATE herbal.disorders SET search_keywords = ARRAY[
    -- Primary diagnosis
    'asthma',
    'chronic asthma',
    'childhood asthma',
    'exercise-induced asthma',
    'exercise-induced bronchospasm',
    'bronchospasm',
    'bronchial spasm',
    -- Cardinal symptoms
    'wheezing',
    'wheezing exhalation',
    'chest tightness',
    'bronchial tightness',
    'dry cough',
    'wet cough',
    'productive cough',
    'yellow mucus',
    'clear mucus',
    'mucus cough',
    'shortness of breath',
    -- Severity markers
    'ER visit asthma',
    'emergency asthma',
    'severe asthma attack',
    'acute asthma episode',
    'fear of attack',
    -- Triggers
    'seasonal allergies asthma',
    'dust allergy',
    'animal dander',
    'pet dander allergy',
    'pollution asthma',
    'oil refinery',
    'chronic pollution exposure',
    'air quality',
    'exercise trigger',
    'bike riding asthma',
    'work stress asthma',
    'stress-triggered asthma',
    -- Mental and emotional
    'anxiety asthma',
    'asthma anxiety cycle',
    'panic attack asthma',
    'anxiety panic',
    'fear of episode',
    'wired but tired',
    'poor sleep',
    'sleep 5-6 hours',
    'insomnia',
    'fatigue illness',
    'illness after stress',
    'stress immune',
    -- Secondary symptoms
    'bloating gas',
    'digestive discomfort',
    'muscle tightness',
    'easily overwhelmed',
    'runs cold',
    -- Medications
    'rescue inhaler',
    'albuterol',
    'albuterol daily',
    'cannabis smoking',
    -- Lifestyle
    'bike commuter',
    'community involvement',
    'city pollution',
    'high stress job',
    'low energy exacerbation',
    -- Breathing techniques
    'box breathing',
    'breathing exercise',
    '4-4-4-4 breathing',
    'post-exercise breathing',
    -- Actions indicated
    'antispasmodic herbs',
    'expectorant herbs',
    'demulcent herbs',
    'nervine herbs',
    'cough spasm cycle',
    'mucus clearance',
    'airway irritation',
    'mucous membrane',
    'bronchial tissue',
    'airway repair',
    'airway inflammation',
    -- Herbs used
    'Lobelia',
    'Lobelia inflata',
    'Angelica',
    'Angelica archangelica',
    'Passionflower',
    'Passiflora incarnata',
    'Yerba Mansa',
    'Anemopsis californica',
    'Plantain',
    'Plantago major',
    'Calendula',
    'Calendula officinalis',
    'Horsetail',
    'Equisetum arvense',
    -- Prescriptions
    'respiratory tincture',
    'Lobelia tincture',
    'nourishing tea',
    'silica lung repair',
    'connective tissue repair',
    -- Case context
    'lower respiratory',
    'respiratory case study',
    'chronic lower respiratory',
    'bronchial inflammation',
    'airway mucosa'
  ] WHERE id = v_dis_id;

  RAISE NOTICE 'Respiratory - Lower case study: search_keywords set (100 terms)';
END $$;
