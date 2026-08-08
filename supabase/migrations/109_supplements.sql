-- Migration 109: Nutritional supplements table + prescription links
-- Data source: BHC Class 50 (2026-08-04) – Ashley, Nutritional Supplements
SET search_path TO herbal, public;

-- ─── Tables ──────────────────────────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS herbal.supplements (
  id            SERIAL PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE,
  category      TEXT NOT NULL DEFAULT 'Other',  -- Vitamin | Mineral | Amino Acid | Enzyme | Other
  subcategory   TEXT,          -- e.g. 'B-Vitamin'
  solubility    TEXT,          -- fat-soluble | water-soluble | oil-soluble
  description   TEXT,
  dose_range    TEXT,
  dose_notes    TEXT,
  deficiency_signs  TEXT,
  dietary_sources   TEXT,
  absorption_notes  TEXT,
  drug_depletors    TEXT,
  sort_order    INTEGER NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS herbal.prescription_supplements (
  id              SERIAL PRIMARY KEY,
  prescription_id INTEGER NOT NULL REFERENCES herbal.disorder_prescriptions(id) ON DELETE CASCADE,
  supplement_id   INTEGER NOT NULL REFERENCES herbal.supplements(id) ON DELETE CASCADE,
  dose            TEXT,
  note            TEXT,
  sort_order      INTEGER NOT NULL DEFAULT 0,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(prescription_id, supplement_id)
);

-- ─── Grants + RLS ─────────────────────────────────────────────────────────────

GRANT ALL ON TABLE herbal.supplements TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.supplements_id_seq TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.supplements ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='supplements' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.supplements FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='supplements' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.supplements FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

GRANT ALL ON TABLE herbal.prescription_supplements TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.prescription_supplements_id_seq TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.prescription_supplements ENABLE ROW LEVEL SECURITY;
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='prescription_supplements' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.prescription_supplements FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='prescription_supplements' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.prescription_supplements FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

-- ─── Vitamins ─────────────────────────────────────────────────────────────────

DO $$ BEGIN RAISE NOTICE 'Inserting vitamins...'; END $$;

INSERT INTO herbal.supplements
  (name, category, subcategory, solubility, description, dose_range, deficiency_signs, dietary_sources, absorption_notes, sort_order)
VALUES
  ('Vitamin A', 'Vitamin', NULL, 'fat-soluble',
   'Essential for healthy eyes, mucus membranes, muscles, and immune function. Carotenoids are naturally occurring plant pigments converted by the body to Vitamin A.',
   '5,000–10,000 IU/day (retinol); 15,000–25,000 IU/day (beta carotene / mixed carotenoids)',
   'Immune deficiency, asthma, glaucoma, macular degeneration, premature aged skin. Alcoholism can be a cause.',
   NULL,
   'Crohn''s disease, celiac disease, gallbladder removal, and liver disease can inhibit absorption.',
   10),

  ('Vitamin B1 (Thiamine)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Necessary for production of GABA and acetylcholine (neurotransmitters). Modestly reduces blood pressure in people with elevated blood sugar. May relieve PMS symptoms.',
   '15–30 mg/day',
   'Can be depleted by alcoholism.',
   'Pork, eggs, beef, asparagus, spinach, tuna, green peas, flax seeds, brussels sprouts, sunflower seeds, beans, lentils',
   NULL,
   20),

  ('Vitamin B2 (Riboflavin)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Essential B vitamin involved in energy metabolism and cellular function.',
   '5–15 mg/day',
   'Cracked lips, cracked mucus membranes of tongue and eyes, iron deficiency anemia.',
   NULL,
   'Low levels caused by alcohol abuse.',
   30),

  ('Vitamin B3 (Niacin)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Can help lower inflammation, lower cholesterol, and improve brain function. Can be synthesized from tryptophan.',
   '15–30 mg/day',
   'Reduced metabolic function, anxiety, fatigue, irritability, mood disorders, lack of focus.',
   'Mushrooms (shiitake, cremini), meat, eggs, poultry, asparagus, tomatoes',
   NULL,
   40),

  ('Vitamin B5 (Pantothenic Acid)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Active form (Coenzyme A) is part of the Krebs cycle for ATP production. Involved in cholesterol synthesis, hemoglobin synthesis, adrenal function, and steroid production including sex hormones. Very rare to be deficient.',
   NULL,
   'Deficiency is very rare.',
   NULL,
   NULL,
   50),

  ('Vitamin B6 (Pyridoxine)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Helps stimulate glycogen release from liver and muscles. Important component of myelin sheath. May lessen symptoms of PMS and PMS-related depression.',
   '35–50 mg/day',
   'Eczema, anemia, fatigue.',
   NULL,
   'Smoking, corticosteroids, diuretics, and contraceptives increase secretion of B6.',
   60),

  ('Vitamin B7 (Biotin)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Supports hair, skin, and nails, as well as other metabolic functions. Can help with cholesterol levels. May help control blood sugar for diabetics with poor response to medication.',
   '30–300 mcg/day',
   NULL,
   'Liver, peanuts, egg yolks, cauliflower, garbanzos, navy beans; also made by gut bacteria',
   NULL,
   70),

  ('Vitamin B9 (Folic Acid)', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Needed for producing red blood cells, DNA synthesis and repair, and maintaining fertility. Methylfolate recommended for those with MTHFR gene mutation.',
   '400 mcg–1 mg/day',
   'Emotional instability, diarrhea, anemia, tongue swelling.',
   NULL,
   'Metformin, diuretics, excessive alcohol and coffee use reduce folate. Celiac disease and B12 deficiency increase deficiency risk.',
   80),

  ('Vitamin B12', 'Vitamin', 'B-Vitamin', 'water-soluble',
   'Vital for cellular metabolism, nervous system function, DNA synthesis, and production of blood. Common deficiency with vegan diet and with PCOS.',
   '200–500 mcg/day',
   'Depression, impaired memory, fatigue, sore tongue, menstrual problems, brain and nervous system damage.',
   'Beef liver, sardines, salmon, venison, beef, oysters, cheese, lamb, shrimp, halibut, yogurt, milk',
   NULL,
   90),

  ('Vitamin C', 'Vitamin', NULL, 'water-soluble',
   'Antioxidant and anti-inflammatory. Vital component of bones, ligaments, blood vessels, and skin. Can be taken with metformin to help lower A1C levels.',
   '500 mg–2 g/day',
   NULL,
   NULL,
   'Take smaller doses more frequently (2x/day). Best taken with other antioxidant vitamins.',
   100),

  ('Vitamin D', 'Vitamin', NULL, 'fat-soluble',
   'D3 is the more active form and can be synthesized from sunlight. Protects against cancer, viruses, osteoporosis, diabetes, autoimmune disease, and heart disease.',
   '1,000–5,000 IU/day',
   NULL,
   NULL,
   'Must be taken with food. Taking with dietary fats increases absorption.',
   110),

  ('Vitamin E', 'Vitamin', NULL, 'fat-soluble',
   'Antioxidant vitamin important for immune function, skin health, and protecting cells from oxidative damage.',
   NULL,
   NULL,
   NULL,
   NULL,
   115),

  ('Vitamin K', 'Vitamin', NULL, 'fat-soluble',
   'Found in two forms: K1 (green leafy vegetables; needed for blood coagulation) and K2 (produced by gut bacteria; required for bone metabolism).',
   '750 mcg–2 mg/day',
   NULL,
   'Almonds, walnuts, apricots; K2 also from fermented foods',
   'Chronic bowel disease, bowel resections, and frequent antibiotic use can lead to low Vitamin K.',
   120)
ON CONFLICT (name) DO NOTHING;

-- ─── Minerals ─────────────────────────────────────────────────────────────────

DO $$ BEGIN RAISE NOTICE 'Inserting minerals...'; END $$;

INSERT INTO herbal.supplements
  (name, category, subcategory, solubility, description, dose_range, deficiency_signs, dietary_sources, absorption_notes, sort_order)
VALUES
  ('Boron', 'Mineral', NULL, NULL,
   'Supports healthy bones and teeth through calcium and magnesium metabolism.',
   '1–2 mg/day',
   NULL,
   'Dark green leafy vegetables, raisins, nuts, legumes, beans, avocados',
   NULL,
   130),

  ('Calcium', 'Mineral', NULL, NULL,
   'Stored in bones and teeth. Essential for nerve transmission, vasodilation and vasoconstriction. Requires adequate HCl, Vitamin D, magnesium, potassium, silica, and Vitamin K for absorption.',
   '350–500 mg BID (calcium carbonate)',
   'Osteoporosis, arrhythmia, muscle spasms.',
   NULL,
   'Antacids, corticosteroids, anticonvulsants, thyroid hormones, and HRT can inhibit absorption.',
   140),

  ('Chromium', 'Mineral', NULL, NULL,
   'Essential trace element often lacking in the American diet. Important for insulin binding with cellular receptors — key for addressing insulin resistance.',
   '100–400 mcg/day',
   NULL,
   NULL,
   'Antacids, corticosteroids, PPIs, and achlorhydria can inhibit chromium absorption.',
   150),

  ('Copper', 'Mineral', NULL, NULL,
   'Essential for bone strength, iron transport, brain development, immune function, cholesterol and glucose metabolism, cardiac function, and red/white blood cell development. Deficiency can be an underlying cause of anemia.',
   '2 mg/day',
   'Anemia.',
   NULL,
   'Excessive zinc supplementation can cause copper deficiency.',
   160),

  ('Iodine', 'Mineral', NULL, NULL,
   'Used by the thyroid gland with the amino acid tyrosine to make T3 and T4 thyroid hormones. The only known function of iodine in the body.',
   '150 mcg/day',
   NULL,
   NULL,
   'Iodine antagonists: raw brassicas, unfermented soy, fluorine, bromine, and chlorine.',
   170),

  ('Iron', 'Mineral', NULL, NULL,
   'Essential mineral found in hemoglobin — necessary for oxygen transport by the blood. For people with excess iron, tannin-rich herbs taken with iron-rich foods can inhibit absorption.',
   '18 mg/day',
   NULL,
   'Beans, lentils, molasses, spinach',
   'Taking with Vitamin C significantly increases absorption.',
   180),

  ('Lithium', 'Mineral', NULL, NULL,
   'Best known as a pharmaceutical medication for bipolar disorder. Lithium orotate can be used as a supplement for those weaning off pharmaceutical lithium. Note: avoid mimosa bark or flower for people with bipolar disorder.',
   '10–20 mg/day (lithium orotate)',
   NULL,
   NULL,
   NULL,
   190),

  ('Magnesium', 'Mineral', NULL, NULL,
   'Essential mineral that is often deficient. Needed for healthy blood sugar, metabolism, muscle function, intestinal motility, and neuroprotection. Magnesium biglycinate has the highest absorption rate; magnesium citrate has a more laxative effect.',
   '400–600 mg/day',
   NULL,
   NULL,
   'Deficiency caused by poor absorption, IBD, kidney disease, diabetes, alcoholism, and use of drugs/antibiotics.',
   200),

  ('Potassium', 'Mineral', NULL, NULL,
   'Essential for nerve transmission, brain, heart, and muscle function, electrolyte balance, and protein synthesis. Most people can get enough from their diet.',
   '4,700 mg/day (daily requirement)',
   NULL,
   'Leafy greens, beans, tomato juice, clams, prunes, potatoes, avocado, yogurt, dates',
   'People with magnesium deficiency may need to supplement.',
   210),

  ('Selenium', 'Mineral', NULL, NULL,
   'Important for thyroid health. Needed to convert T4 (storage form) to T3 (active form). Linked to reduced cardiovascular disease risk. May help with bulging eyes in Grave''s disease.',
   '100–200 mcg/day',
   NULL,
   'Brazil nuts (best source)',
   NULL,
   220),

  ('Zinc', 'Mineral', NULL, NULL,
   'Essential for immune function, skin and wound healing, neurotransmitter function, and prostate health.',
   '15–30 mg/day',
   NULL,
   'Oysters, pumpkin seeds, beef shanks, king crab, pork, lobster',
   NULL,
   230)
ON CONFLICT (name) DO NOTHING;

-- ─── Amino Acids ──────────────────────────────────────────────────────────────

DO $$ BEGIN RAISE NOTICE 'Inserting amino acids and other supplements...'; END $$;

INSERT INTO herbal.supplements
  (name, category, subcategory, solubility, description, dose_range, deficiency_signs, dietary_sources, absorption_notes, sort_order)
VALUES
  ('Methionine', 'Amino Acid', NULL, NULL,
   'Essential amino acid involved in protein synthesis and methylation processes in the body.',
   NULL,
   NULL,
   NULL,
   NULL,
   235),

  ('L-Carnitine', 'Amino Acid', NULL, NULL,
   'Amino acid necessary for transport of fatty acids into the mitochondria for energy production.',
   '1–3 g/day',
   NULL,
   'Beef, pork',
   NULL,
   260),

  ('L-Glutamine', 'Amino Acid', NULL, NULL,
   'Useful for enhancing healing of gut mucosa and promoting tight junctions. Helpful for IBS symptoms. Best paired with gut-healing herbs, infusions, and removing irritating foods from diet.',
   '500–1,000 mg TID (3x/day)',
   NULL,
   NULL,
   NULL,
   270),

  ('L-Theanine', 'Amino Acid', NULL, NULL,
   'Non-protein amino acid originally isolated from green tea that promotes feelings of calm and relaxation without sedation.',
   '200 mg, 2–3x/day',
   NULL,
   'Green tea',
   NULL,
   280),

  ('N-Acetyl-Cysteine (NAC)', 'Amino Acid', NULL, NULL,
   'Used in orthodox medicine orally or as an inhalant to thin mucus for easier expectoration in bronchitis, COPD, and pneumonia. Can also be used for PCOS to help with insulin resistance.',
   '200–600 mg/day',
   NULL,
   NULL,
   NULL,
   290),

  -- Other Supplements
  ('Alpha Lipoic Acid', 'Other', NULL, NULL,
   'Antioxidant activity. Can be helpful in enhancing glucose sensitivity in people with metabolic syndrome and Type 2 Diabetes.',
   '200–1,200 mg/day',
   NULL,
   NULL,
   NULL,
   240),

  ('5-HTP', 'Other', NULL, NULL,
   'Precursor for the neurotransmitter serotonin and the neurohormone melatonin. With the help of B6, tryptophan is converted into 5-HTP. Can be helpful for panic disorder, chronic headaches, fibromyalgia, and IBS.',
   '50–400 mg/day',
   NULL,
   NULL,
   'Potential drug interactions — can cause serotonin syndrome.',
   250),

  ('CoQ10 / Ubiquinol', 'Other', NULL, 'oil-soluble',
   'Oil-soluble vitamin essential for mitochondrial and cellular function. Antioxidant that inhibits lipid oxidation and protects against LDL effects. Essential for people on statins. Useful in cardiovascular disease.',
   '100–1,000 mg/day',
   NULL,
   NULL,
   NULL,
   300),

  ('Fish Oils (Omega-3)', 'Other', NULL, NULL,
   'Omega-3 fatty acids help with brain function, cardiovascular disease, memory, seizure reduction, ADHD, neurological issues, dry eyes, and skin disease.',
   '1–6 g/day',
   NULL,
   NULL,
   NULL,
   310),

  ('Glucosamine Sulfate', 'Other', NULL, NULL,
   'Made from shells of oysters and sea creature exoskeletons. Often used with chondroitin and MSM for arthritis. Helpful for arthritis of hips, spine, and wrists. Can reduce symptoms of rheumatoid arthritis.',
   '1,500 mg/day',
   NULL,
   NULL,
   NULL,
   320),

  ('Inositol', 'Other', NULL, NULL,
   'Produced in the kidneys from glucose — not an essential nutrient. Helps with fat and cholesterol metabolism, maintenance of cell membranes, utilization of serotonin, and insulin signaling. Can lower insulin and testosterone levels in PCOS.',
   '2–10 g/day (myo-inositol form)',
   NULL,
   NULL,
   NULL,
   330),

  ('SAM-E', 'Other', NULL, NULL,
   'Useful for seasonal affective disorder (SAD). Helps produce serotonin, dopamine, and melatonin.',
   '400–1,200 mg in the morning on an empty stomach',
   NULL,
   NULL,
   'Avoid with bipolar disorder.',
   340),

  ('Proteolytic Enzymes', 'Enzyme', NULL, NULL,
   'Includes Serrapeptase, Nattokinase, and Lumbrokinase. Dissolve proteins in the body that don''t serve a healthy purpose, such as scar tissue and plaque buildup. Reduce inflammation and break down scar tissue in autoimmune conditions. Nattokinase useful for Mono that won''t resolve. Lumbrokinase is particularly effective for Lyme disease.',
   'Varies by enzyme and condition',
   NULL,
   NULL,
   'Take on an empty stomach for systemic enzyme effect.',
   360)
ON CONFLICT (name) DO NOTHING;

-- ─── Link supplements to Osteoarthritis prescription ──────────────────────────

DO $$
DECLARE
  v_prescription_id INTEGER;
  v_supplement_id   INTEGER;
BEGIN
  SELECT dp.id INTO v_prescription_id
  FROM herbal.disorder_prescriptions dp
  WHERE dp.title = 'Supplements for Osteoarthritis'
  LIMIT 1;

  IF v_prescription_id IS NULL THEN
    RAISE NOTICE 'Osteoarthritis supplement prescription not found — skipping links';
    RETURN;
  END IF;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Glucosamine Sulfate';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '1,500 mg/day', 10)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Vitamin E';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '600 IU/day', 20)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Vitamin A';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '5,000 IU/day', 30)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Vitamin C';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '1–3 g/day', 40)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '50 mg/day', 50)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Vitamin B5 (Pantothenic Acid)';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '12.5 mg/day', 60)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Methionine';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '400 mg TID (3x/day)', 70)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Zinc';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '45 mg/day', 80)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  SELECT id INTO v_supplement_id FROM herbal.supplements WHERE name = 'Copper';
  INSERT INTO herbal.prescription_supplements (prescription_id, supplement_id, dose, sort_order)
  VALUES (v_prescription_id, v_supplement_id, '1 mg/day', 90)
  ON CONFLICT (prescription_id, supplement_id) DO NOTHING;

  RAISE NOTICE 'Osteoarthritis prescription supplement links created.';
END $$;

DO $$ BEGIN RAISE NOTICE 'Migration 109 complete.'; END $$;
