-- Migration 358: Class 72 – Stroke (data migration)
-- Parsed from:
--   BHC - Class 72 - Stroke - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 72 - Stroke - Shereel.md           (note_type = 'personal')
--
-- Herb name normalisations applied:
--   SJW       → St. John's Wort (Hypericum perforatum, id=81)
--   AI        → Anti-inflammatory (Turmeric context)
--   NS        → Nervous System (Oat straw context)
--   Oat straw → Oat (Avena sativa, straw, id=2287)
--
-- Skipped (not in DB / not appropriate to add):
--   animal fats / DHA / ghee / salmon — food items, not herbs or supplements
--   NAD+ / GLOW peptides — synthetic compounds, not in herbal.supplements
--   Nutritional Support — vague category word
--
-- New ailment keywords introduced:
--   stroke recovery   (new)
--   memory support    (new)
--
-- Keyword merge decisions:
--   "cognitive function"   → existing 'cognitive support'
--   "blood pressure herbs" → existing 'hypertension'
--   "calm focus"           → 'nervous system support' (general category, new)

SET search_path TO herbal, public;

-- ─── HERB SNIPPETS ──────────────────────────────────────────────────────────
DO $$
DECLARE
  v_gen_herbal_support TEXT;
  v_gen_herb_drug      TEXT;
  v_gen_sleep          TEXT;
  v_gen_instructor     TEXT;
  v_pers_herbal        TEXT;
  v_pers_case_study    TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 72 - Stroke') THEN
    RAISE NOTICE 'Class 72 snippets already loaded, skipping';
    RETURN;
  END IF;

  v_gen_herbal_support :=
    '## Herbal Support for Stroke Recovery' || E'\n' ||
    '- **Bacopa**: supports memory, cognitive function' || E'\n' ||
    '- **Ginkgo**: circulation and cognition aid' || E'\n' ||
    '- **Rosemary**: not recommended due to anticoagulant properties' || E'\n' ||
    '- **Nutritional Support**: emphasis on animal fats, DHA, omega-3';

  v_gen_herb_drug :=
    '**Herb-Drug Interactions and Care Considerations:**' || E'\n' ||
    '- Anticoagulants like warfarin' || E'\n' ||
    E'\t- Avoid **ginkgo**, garlic, **ginger** — increase bleeding risk' || E'\n' ||
    '- Herb-drug combinations could be problematic' || E'\n' ||
    '- Consultation with care team advised' || E'\n\n' ||
    '**Herbal and Medication Interactions:**' || E'\n' ||
    '- Check herb-drug interactions' || E'\n' ||
    '- Avoid alongside St. John''s Wort with certain meds' || E'\n' ||
    '- Caution with herbs for blood pressure like **linden**, **nettle**, cleavers, oat straw';

  v_gen_sleep :=
    '## Sleep and Relaxation' || E'\n' ||
    '- Time sleep herbs between 5:00 and 7:00 PM' || E'\n' ||
    '- Relaxation techniques to reduce nocturnal hypertension' || E'\n' ||
    '- Use of **valerian** and **hops** for sleep encouragement';

  v_gen_instructor :=
    '## Instructor Advice' || E'\n' ||
    '- Less is more with herbs due to multiple medications' || E'\n' ||
    '- Pay attention to drug-herb interactions' || E'\n' ||
    '- Focus on single herbs where possible, e.g., **burdock**' || E'\n' ||
    '- Use external applications cautiously with herbs like **St. John''s Wort**';

  v_pers_herbal :=
    '### Herbal support: promise and care' || E'\n' ||
    '- Ginkgo biloba - circulation and cognition' || E'\n' ||
    '- animal fats - vital for building and maintaining brain cell structure; support cognitive function and emotional balance; help with brain fog and cognitive decline' || E'\n' ||
    '- Turmeric/curcumin - AI (anti-inflammatory)' || E'\n' ||
    '- Oat straw - supports NS vitality, promotes calm focus, nourishes bones with calcium and silica. Contains minerals and antioxidants like avenanthramides, which may aid in circulation.' || E'\n' ||
    '- Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being.' || E'\n' ||
    '    - oil with Bacopa and Ginkgo and massage the head' || E'\n' ||
    '- Care' || E'\n' ||
    '    - Ginkgo, garlic (raw, supplement or tea) and ginger (raw, supplement, or tea) can increase bleeding risk - do not combine with blood thinners. Wait 3 or more hours after meds before using' || E'\n' ||
    '    - some fish oils can be a bleeding risk as well' || E'\n' ||
    '    - be mindful of herb/drug interactions' || E'\n' ||
    '    - discuss herbs and supplements with the care team';

  v_pers_case_study :=
    '## Case Study' || E'\n' ||
    'African American Male, 60 years, 6''3"' || E'\n\n' ||
    '- Primary Concerns and Goals' || E'\n' ||
    '    - Support for multi-stroke recovery' || E'\n' ||
    '    - Muscle stiffness and spasticity' || E'\n' ||
    '    - Brain fog, Neurofatigue, Anxiety' || E'\n' ||
    '    - Attain healthy blood pressure levels between 110 and 130' || E'\n' ||
    '    - Kidney support - improve GFR' || E'\n' ||
    '    - Improve brain function signaling' || E'\n\n' ||
    '- Clinical History' || E'\n' ||
    '    - April & November 2025: strokes in both hemispheres with micro hemorrhaging, Aphasia, short-term memory impact, right hand hemiparesis' || E'\n' ||
    '    - Diagnosed with atrial fibrillation as a result of chronic hypertension' || E'\n' ||
    '    - Classified with stage 4 chronic kidney disease due to long-term hypertension' || E'\n\n' ||
    '- Medications' || E'\n' ||
    '    - Beta Blocker (Carvedilol) 6.25 mg 2x/day' || E'\n' ||
    '    - Anticoagulant (Eliquis) 10 mg 2x/day' || E'\n' ||
    '    - Cholesterol lowering (Zetia) 1x/day' || E'\n' ||
    '    - Diuretic (Lasix) 20 mg 1x/day' || E'\n' ||
    '    - Vasodilator (Hydralazine) 10 mg 2 tabs, 2x/day' || E'\n' ||
    '    - Antiseizure (Keppra) 500 mg 2x/day' || E'\n' ||
    '    - Antihypertensive (Losartan) 25 mg 2x/day' || E'\n' ||
    '    - Heart protectant (Jardiance) 1/2 tab' || E'\n\n' ||
    '- Goals: reduce muscle tension and spasticity; attain healthy blood pressure levels between 110 and 130; kidney support - improve GFR (45-60); brain function signaling' || E'\n\n' ||
    '- Caution:' || E'\n' ||
    '    - SJW — don''t take with meds' || E'\n' ||
    '    - Linden could lower BP too much' || E'\n' ||
    '    - No coffee because of the beta-blockers' || E'\n\n' ||
    '- Herbs:' || E'\n' ||
    '    - Hibiscus' || E'\n' ||
    '    - Nettle' || E'\n' ||
    '    - Cleavers' || E'\n' ||
    '    - Oat Straw' || E'\n' ||
    '    - Meds in the morning and evening — herbs in the midday' || E'\n' ||
    '    - Sleep 5-7pm, then meds right before bed' || E'\n' ||
    '    - Sleep apnea related to hypertension';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- ── Generated: Stroke Recovery - Herbal Support ──────────────────────────
    (2381,
     '**Bacopa**: supports memory, cognitive function',
     'BHC - Class 72 - Stroke', 'generated', 'Stroke Recovery - Herbal Support', 10,
     v_gen_herbal_support),

    (165,
     '**Ginkgo**: circulation and cognition aid',
     'BHC - Class 72 - Stroke', 'generated', 'Stroke Recovery - Herbal Support', 20,
     v_gen_herbal_support),

    (109,
     '**Rosemary**: not recommended due to anticoagulant properties',
     'BHC - Class 72 - Stroke', 'generated', 'Stroke Recovery - Herbal Support', 30,
     v_gen_herbal_support),

    -- ── Generated: Herb-Drug Interactions (merged from two headers) ───────────
    (165,
     'Anticoagulants like warfarin — avoid **ginkgo**, garlic, ginger — increase bleeding risk',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 40,
     v_gen_herb_drug),

    (21,
     'Anticoagulants like warfarin — avoid ginkgo, **garlic**, ginger — increase bleeding risk',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 50,
     v_gen_herb_drug),

    (124,
     'Anticoagulants like warfarin — avoid ginkgo, garlic, **ginger** — increase bleeding risk',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 60,
     v_gen_herb_drug),

    (81,
     'Avoid alongside **St. John''s Wort** with certain meds due to herb-drug interactions',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 70,
     v_gen_herb_drug),

    (90,
     'Caution with herbs for blood pressure like **linden**, nettle, cleavers, oat straw',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 80,
     v_gen_herb_drug),

    (43,
     'Caution with herbs for blood pressure like linden, **nettle**, cleavers, oat straw',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 90,
     v_gen_herb_drug),

    (28,
     'Caution with herbs for blood pressure like linden, nettle, **cleavers**, oat straw',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 100,
     v_gen_herb_drug),

    (2287,
     'Caution with herbs for blood pressure like linden, nettle, cleavers, **oat straw**',
     'BHC - Class 72 - Stroke', 'generated', 'Herb-Drug Interactions', 110,
     v_gen_herb_drug),

    -- ── Generated: Sleep Support ──────────────────────────────────────────────
    (145,
     'Time sleep herbs between 5:00 and 7:00 PM — **valerian** and hops for sleep encouragement',
     'BHC - Class 72 - Stroke', 'generated', 'Sleep Support', 120,
     v_gen_sleep),

    (129,
     'Time sleep herbs between 5:00 and 7:00 PM — valerian and **hops** for sleep encouragement',
     'BHC - Class 72 - Stroke', 'generated', 'Sleep Support', 130,
     v_gen_sleep),

    -- ── Generated: Instructor Advice ─────────────────────────────────────────
    (22,
     'Less is more with herbs due to multiple medications. Focus on single herbs where possible, e.g., **burdock**',
     'BHC - Class 72 - Stroke', 'generated', 'Instructor Advice', 140,
     v_gen_instructor),

    (81,
     'Use external applications cautiously with herbs like **St. John''s Wort**; less is more with multiple medications',
     'BHC - Class 72 - Stroke', 'generated', 'Instructor Advice', 150,
     v_gen_instructor),

    -- ── Personal: Stroke Recovery - Herbal Support ────────────────────────────
    (165,
     'Ginkgo biloba - circulation and cognition',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 10,
     v_pers_herbal),

    (203,
     'Turmeric/curcumin - anti-inflammatory (AI)',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 20,
     v_pers_herbal),

    (2287,
     'Oat straw - supports nervous system (NS) vitality, promotes calm focus, nourishes bones with calcium and silica. Contains minerals and antioxidants like avenanthramides, which may aid in circulation.',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 30,
     v_pers_herbal),

    (2381,
     'Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being. Oil with Bacopa and Ginkgo and massage the head.',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 40,
     v_pers_herbal),

    (21,
     'Care: garlic (raw, supplement or tea) can increase bleeding risk — do not combine with blood thinners. Wait 3 or more hours after meds before using.',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 50,
     v_pers_herbal),

    (124,
     'Care: ginger (raw, supplement, or tea) can increase bleeding risk — do not combine with blood thinners. Wait 3 or more hours after meds before using.',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 60,
     v_pers_herbal),

    -- ── Personal: Case Study ──────────────────────────────────────────────────
    (2233,
     'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): **Hibiscus**, Nettle, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
     'BHC - Class 72 - Stroke', 'personal', 'Case Study', 80,
     v_pers_case_study),

    (43,
     'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, **Nettle**, Cleavers, Oat Straw — meds in the morning and evening, herbs in the midday',
     'BHC - Class 72 - Stroke', 'personal', 'Case Study', 90,
     v_pers_case_study),

    (28,
     'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, Nettle, **Cleavers**, Oat Straw — meds in the morning and evening, herbs in the midday',
     'BHC - Class 72 - Stroke', 'personal', 'Case Study', 100,
     v_pers_case_study),

    (2287,
     'Herbs for stroke recovery patient (hypertension, atrial fibrillation, stage 4 CKD): Hibiscus, Nettle, Cleavers, **Oat Straw** — meds in the morning and evening, herbs in the midday',
     'BHC - Class 72 - Stroke', 'personal', 'Case Study', 110,
     v_pers_case_study),

    (90,
     'Caution: Linden could lower BP too much (patient on multiple blood pressure medications: Losartan, Hydralazine, Lasix)',
     'BHC - Class 72 - Stroke', 'personal', 'Case Study', 120,
     v_pers_case_study),

    (81,
     'Caution: St. John''s Wort (SJW) — do not take with medications due to drug interactions',
     'BHC - Class 72 - Stroke', 'personal', 'Case Study', 130,
     v_pers_case_study);

END $$;

-- ─── SUPPLEMENT SNIPPET (Fish Oils) ─────────────────────────────────────────
DO $$
DECLARE
  v_pers_herbal TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE supplement_id = 33
               AND class_name = 'BHC - Class 72 - Stroke') THEN
    RAISE NOTICE 'Class 72 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  v_pers_herbal :=
    '### Herbal support: promise and care' || E'\n' ||
    '- Ginkgo biloba - circulation and cognition' || E'\n' ||
    '- animal fats - vital for building and maintaining brain cell structure; support cognitive function and emotional balance; help with brain fog and cognitive decline' || E'\n' ||
    '- Turmeric/curcumin - AI (anti-inflammatory)' || E'\n' ||
    '- Oat straw - supports NS vitality, promotes calm focus, nourishes bones with calcium and silica. Contains minerals and antioxidants like avenanthramides, which may aid in circulation.' || E'\n' ||
    '- Bacopa - supports memory, cognitive function, and reduces anxiety. It has been used traditionally in Ayurvedic medicine for its potential benefits on brain health and emotional well-being.' || E'\n' ||
    '    - oil with Bacopa and Ginkgo and massage the head' || E'\n' ||
    '- Care' || E'\n' ||
    '    - Ginkgo, garlic (raw, supplement or tea) and ginger (raw, supplement, or tea) can increase bleeding risk - do not combine with blood thinners. Wait 3 or more hours after meds before using' || E'\n' ||
    '    - some fish oils can be a bleeding risk as well' || E'\n' ||
    '    - be mindful of herb/drug interactions' || E'\n' ||
    '    - discuss herbs and supplements with the care team';

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (33,
     'Care: some fish oils can be a bleeding risk — be mindful of herb/drug interactions when using with anticoagulants',
     'BHC - Class 72 - Stroke', 'personal', 'Stroke Recovery - Herbal Support', 70,
     v_pers_herbal);

END $$;

-- ─── HERB KEYWORDS ───────────────────────────────────────────────────────────
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Bacopa
  (2381, 'stroke recovery',   'ailment'),
  (2381, 'memory support',    'ailment'),
  (2381, 'cognitive support', 'ailment'),
  (2381, 'anxiety',           'ailment'),
  -- Ginkgo
  (165, 'stroke recovery',   'ailment'),
  (165, 'cognitive support', 'ailment'),
  (165, 'circulation',       'ailment'),
  -- Rosemary
  (109, 'anticoagulant', 'action'),
  -- Garlic
  (21, 'anticoagulant', 'action'),
  -- Ginger
  (124, 'anticoagulant', 'action'),
  -- Turmeric
  (203, 'stroke recovery',     'ailment'),
  (203, 'anti-inflammatory',   'action'),
  -- Oat (straw)
  (2287, 'stroke recovery',        'ailment'),
  (2287, 'nervous system support', 'general'),
  (2287, 'bone density',           'ailment'),
  -- Linden
  (90, 'hypertension', 'ailment'),
  -- Nettle (leaf)
  (43, 'hypertension',   'ailment'),
  (43, 'stroke recovery', 'ailment'),
  -- Cleavers
  (28, 'hypertension',    'ailment'),
  (28, 'stroke recovery', 'ailment'),
  -- Valerian
  (145, 'sleep support', 'ailment'),
  -- Hops
  (129, 'sleep support', 'ailment'),
  -- Hibiscus
  (2233, 'hypertension',    'ailment'),
  (2233, 'stroke recovery', 'ailment'),
  (2233, 'kidney support',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ─── SUPPLEMENT KEYWORDS ─────────────────────────────────────────────────────
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (33, 'stroke recovery',       'ailment'),
  (33, 'cardiovascular disease', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ─── AILMENT SEARCH TERMS (new keywords only) ────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('stroke recovery',
   ARRAY['CVA recovery', 'cerebrovascular accident recovery', 'post-stroke rehabilitation',
         'brain injury recovery', 'ischemic stroke recovery', 'hemorrhagic stroke recovery']),
  ('memory support',
   ARRAY['memory loss', 'forgetfulness', 'poor memory', 'cognitive decline', 'amnesia'])
ON CONFLICT (ailment_keyword) DO NOTHING;
