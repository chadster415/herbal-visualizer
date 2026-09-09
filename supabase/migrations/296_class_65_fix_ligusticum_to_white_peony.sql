-- Migration 296: Correct Class 65 — Ligusticum wallichii → White Peony
-- The Generated Notes mistranscribed the PCOS materia medica entry as "Ligusticum wallichii"
-- with "blood and yin tonic / nourishes uterus." Lisa's notes correctly identify this herb
-- as Paeonia lactiflora (White Peony), consistent with the same class context.
--
-- Fixes:
--   1. Delete the incorrect Ligusticum wallichii (herb_id=1525) snippet from generated notes
--   2. Add the correct White Peony (herb_id=2238) snippet to generated notes Fertility Support
--   3. Replace quiz question #7 (sort_order=70) which incorrectly asked about Ligusticum wallichii

SET search_path TO herbal, public;

-- 1. Remove incorrect snippet
DELETE FROM herbal.class_note_snippets
WHERE herb_id = 1525
  AND class_name = 'BHC - Class 65 - Fertility and Pregnancy'
  AND note_type = 'generated';

-- 2. Add correct White Peony snippet to generated notes Fertility Support
INSERT INTO herbal.class_note_snippets
  (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
VALUES
  (2238,
   'White Peony (Paeonia lactiflora) — blood and yin tonic, nourishes the uterus. Used in PCOS treatments.',
   'BHC - Class 65 - Fertility and Pregnancy', 'generated', 'Fertility Support', 230,
   '## Fertility Support

- **Panax ginseng**
	- qi tonic
	- supports adrenal hormone
	- caution: avoid if not well-nourished
		- can lead to burnout
		- nervous system response: wound too tight, jumpy

- **Viburnum** *(V. opulus, V. prunifolium)*
	- supports miscarriage-prone individuals
	- Cramp Bark *(V. opulus)*
	- Black Haw *(V. prunifolium)*
		- useful for high blood pressure

- **Red Clover**
	- prevention-oriented
	- avoid Red Raspberry for miscarriage concerns
		- astringency can tighten uterus

- **Urtica** *(U. urens, U. dioica)*
	- reduces elevated testosterone
	- high in protein, iron, vitamins, minerals

- PCOS Treatments
	- *Serenoa repens* (Saw Palmetto)
	- Vitex: supports progesterone
	- *Salvia officinalis*: suppresses prolactin
	- White Peony (Paeonia lactiflora)
		- blood and yin tonic
		- nourishes uterus');

-- 3. Fix quiz question — replace Ligusticum wallichii question with White Peony question
DELETE FROM herbal.class_quiz_questions
WHERE class_name = 'BHC - Class 65 - Fertility and Pregnancy'
  AND sort_order = 70;

INSERT INTO herbal.class_quiz_questions
  (class_name, question_text, option_a, option_b, option_c, option_d,
   correct_option, explanation, snippet_text, section_header, sort_order)
VALUES
  ('BHC - Class 65 - Fertility and Pregnancy',
   'White Peony (Paeonia lactiflora) is listed in the PCOS materia medica. What is its role?',
   'Suppresses prolactin and restores menses via dopamine agonism',
   'Reduces elevated testosterone by blocking androgen receptors',
   'Blood and yin tonic that nourishes the uterus; also mast cell stabilizing',
   'Smooth muscle antispasmodic specific for uterine cramping',
   'c',
   'Lisa''s notes describe White Peony as "blood and yin tonic / mast cell stabilizing / calms fibroblast production" — the same tonic role attributed to it in the generated notes Fertility Support section.',
   'White Peony (Paeonia lactiflora) — blood and yin tonic, nourishes the uterus. Used in PCOS treatments.',
   'Fertility Support', 70);
