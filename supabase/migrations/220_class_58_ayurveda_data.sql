-- Migration 220: Class 58 Ayurveda — snippets, keywords, ailment search synonyms
-- Files parsed:
--   BHC - Class 58 - Ayurveda - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 58 - Ayurveda - Lisa.md             (note_type = 'personal')
-- Herb normalisations:
--   Schisandra / schisandra → Schizandra (Schisandra chinensis, id=17)
--   SJW / St. John's Wort  → St. John's Wort (Hypericum perforatum, id=81)
--   dan root                → Dandelion root (Taraxacum officinale root, id=122)
--   haw berry               → Hawthorn berry (Crataegus spp. berry, id=73)
-- Skipped (not in DB):
--   Staphysagria  — homeopathic remedy, no herb DB entry
--   ginsengs      — vague category reference, not a specific herb
-- Section header cleaning:
--   "## Formula for Chemical Sensitivity" + "## Example Plant Uses and Dosage Range"
--     both → 'Chemical Sensitivity'; source blocks concatenated with bold labels
-- Merge decisions (new vs existing ailment keywords):
--   All new keywords are distinct clinical concepts; none merged into existing keywords

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────
-- Snippets
-- ─────────────────────────────────────────────
DO $$
DECLARE
  v_class TEXT := 'BHC - Class 58 - Ayurveda';
  v_gen_kapha_block TEXT;
  v_gen_chem_block  TEXT;
  v_per_kapha_block TEXT;
  v_per_chem_block  TEXT;
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = 'BHC - Class 58 - Ayurveda') THEN
    RAISE NOTICE 'Class 58 snippets already loaded, skipping';
    RETURN;
  END IF;

  v_gen_kapha_block := $blk$### Kapha

* Prone to fluid issues
	* congestion, edema, hypothyroid disorders
* Emotional tendencies
	* melancholy, denial
* Symptomatic relief
	* stimulating, purgatives, **Schisandra**$blk$;

  v_gen_chem_block := $blk$**Formula for Chemical Sensitivity:**
- Focus on individual: eight-year-old cis female
- Conditions: chemical sensitivity, constipation, depression
- Factors to consider:
	- Age, vitality, height, weight
	- Acute vs. chronic, severity

### Treatment Actions
- Amphoteric, Alterative, Hepatic, Nervine actions
- Example plants:
	- **Eucalyptus**
	- **Staphysagria**

### Prioritizing Therapeutic Dosing
- Ensure therapeutic dose achieved for all included herbs
- Energetic vs. physical change focus
- Importance of amounts in formulation

**Example Plant Uses and Dosage Range:**
- **Milk Thistle**
	- Detox, bile, bowel movement stimulant
	- Ranges: 20–60 drops, focus on 40–60 drops
- **Yellow Dock**
	- Addressing chemicals and constipation
	- Ranges: prioritize 50 drops
- **St. John's Wort**
	- Mood stabilization
	- Ranges: 60–100 drops
- **Linden**
	- Mood support, drowsiness caution
	- Ranges: adjust for balance$blk$;

  v_per_kapha_block := $blk$- **Kapha**
    - prone to congestion and mucus buildup
    - possible edema
    - boggy lymph, maybe lumpy
    - prone toward hypoglandular disorders (Hashimoto)
    - low BP (fluid is stagnant, not necessarily low volume; maybe lightheaded when stand up)
    - prone to sleep apnea
    - may look pale; maybe bloating after meals
    - fatigue
    - emotions tend toward melancholy or denial
    - love juicing, spicy, raw; flavors are sour and pungent — sour liquifies mucus, pungent is heating and expectorating
    - plants: stimulating (ginsengs), sour (schisandra), expectorating, purgative$blk$;

  v_per_chem_block := $blk$chemical sensitivity
- headaches, exhaustion with exposure
constipation
depression

actions: alteratives, hepatics, nervines, mucilagenous, adaptogens, bitters

stimulating bile:
- burdock
- milk thistle — with chemical exposure, complex accumulation in the body; also long term pharma use, alcohol exposure
- yellow dock — mild laxative; bitter but also gentle laxative
- licorice
- red clover
- dan root (dandelion root)

detox / bowel movements / mood:
- lemon balm
- ginger — migrating motor complex; gets things moving in the bowel
- SJW (St. John's Wort)
- linden

Formula drop doses (Tilgner / MM / MH):
Milk Thistle: 20–40d 5×/day, 20–60 4×/day
Yellow Dock: 30–75d 3×/day, 10–40d 1–4×/day, 30–60d 3×/day
St John's Wort: 20–30d 3×/day, 20–60d 4×/day, 60–120 3×/day
Linden: 20–40d 1–4×/day, 75–150d 3×/day

Focus on detox: prioritize milk thistle 40–50d, yellow dock 50–60d, SJW 60d; adjust to 5 ml dose

Tea blend for chemical sensitivity: chicory, sarsaparilla, cinnamon, haw berry, elder berry$blk$;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Generated notes — Kapha
    (17,
     'Schisandra — symptomatic relief for Kapha: used as a sour, stimulating herb for congestion, edema, and hypothyroid disorders.',
     v_class, 'generated', 'Kapha', 10, v_gen_kapha_block),

    -- Generated notes — Chemical Sensitivity
    (101,
     'Eucalyptus — example plant for chemical sensitivity formula; indicated actions include amphoteric, alterative, hepatic, nervine.',
     v_class, 'generated', 'Chemical Sensitivity', 10, v_gen_chem_block),
    (206,
     'Milk Thistle — detox, bile, bowel movement stimulant; dosage ranges 20–60 drops, focus on 40–60 drops.',
     v_class, 'generated', 'Chemical Sensitivity', 20, v_gen_chem_block),
    (37,
     'Yellow Dock — addresses chemicals and constipation; prioritize 50 drops.',
     v_class, 'generated', 'Chemical Sensitivity', 30, v_gen_chem_block),
    (81,
     'St. John''s Wort — mood stabilization in chemical sensitivity formula; ranges 60–100 drops.',
     v_class, 'generated', 'Chemical Sensitivity', 40, v_gen_chem_block),
    (90,
     'Linden — mood support for chemical sensitivity formula; drowsiness caution; adjust for balance.',
     v_class, 'generated', 'Chemical Sensitivity', 50, v_gen_chem_block),

    -- Personal notes — Kapha
    (17,
     'Kapha plants: sour (schisandra) — for congestion, edema, fatigue, stagnancy; sour flavor liquifies mucus.',
     v_class, 'personal', 'Kapha', 10, v_per_kapha_block),

    -- Personal notes — Chemical Sensitivity
    (22,
     'Burdock — stimulating bile; hepatic/alterative herb in chemical sensitivity detox protocol.',
     v_class, 'personal', 'Chemical Sensitivity', 10, v_per_chem_block),
    (206,
     'Milk Thistle — for complex accumulation with chemical exposure, long-term pharma use, alcohol exposure; prioritize 40–50 drops.',
     v_class, 'personal', 'Chemical Sensitivity', 20, v_per_chem_block),
    (37,
     'Yellow Dock — mild laxative; bitter but also a gentle laxative; 50–60 drops for constipation and chemical detox.',
     v_class, 'personal', 'Chemical Sensitivity', 30, v_per_chem_block),
    (78,
     'Licorice — bile-stimulating; included in hepatic/alterative protocol for chemical sensitivity.',
     v_class, 'personal', 'Chemical Sensitivity', 40, v_per_chem_block),
    (42,
     'Red Clover — bile-stimulating; included in hepatic/alterative protocol for chemical sensitivity and detox.',
     v_class, 'personal', 'Chemical Sensitivity', 50, v_per_chem_block),
    (122,
     'Dandelion root (dan root) — bile-stimulating, hepatic; part of detox protocol for chemical sensitivity.',
     v_class, 'personal', 'Chemical Sensitivity', 60, v_per_chem_block),
    (134,
     'Lemon Balm — mood/nervine support; for depression associated with chemical sensitivity.',
     v_class, 'personal', 'Chemical Sensitivity', 70, v_per_chem_block),
    (124,
     'Ginger — activates the migrating motor complex; gets things moving in the bowel; indicated for constipation.',
     v_class, 'personal', 'Chemical Sensitivity', 80, v_per_chem_block),
    (81,
     'St. John''s Wort — mood/depression support in chemical sensitivity formula; 60 drops after adjustment.',
     v_class, 'personal', 'Chemical Sensitivity', 90, v_per_chem_block),
    (90,
     'Linden — nervine/mood support in chemical sensitivity formula.',
     v_class, 'personal', 'Chemical Sensitivity', 100, v_per_chem_block),
    (2227,
     'Chicory root — tea blend for chemical sensitivity case; bitter digestive and detox support.',
     v_class, 'personal', 'Chemical Sensitivity', 110, v_per_chem_block),
    (40,
     'Sarsaparilla — tea blend for chemical sensitivity case.',
     v_class, 'personal', 'Chemical Sensitivity', 120, v_per_chem_block),
    (167,
     'Cinnamon — tea blend for chemical sensitivity case; warming, aromatic.',
     v_class, 'personal', 'Chemical Sensitivity', 130, v_per_chem_block),
    (73,
     'Hawthorn berry (haw berry) — tea blend for chemical sensitivity case.',
     v_class, 'personal', 'Chemical Sensitivity', 140, v_per_chem_block),
    (1651,
     'Elder berry — tea blend for chemical sensitivity case.',
     v_class, 'personal', 'Chemical Sensitivity', 150, v_per_chem_block);

  RAISE NOTICE 'Class 58 snippets inserted';
END $$;

-- ─────────────────────────────────────────────
-- Keywords
-- ─────────────────────────────────────────────
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Schisandra (id=17) — Kapha
  (17,   'congestion',         'symptom'),
  (17,   'fatigue',            'symptom'),

  -- Eucalyptus (id=101) — Chemical Sensitivity
  (101,  'chemical sensitivity', 'ailment'),

  -- Milk Thistle (id=206)
  (206,  'chemical sensitivity', 'ailment'),
  (206,  'constipation',         'symptom'),

  -- Yellow Dock (id=37)
  (37,   'chemical sensitivity', 'ailment'),
  (37,   'constipation',         'symptom'),

  -- St. John's Wort (id=81)
  (81,   'chemical sensitivity', 'ailment'),
  (81,   'depression',           'ailment'),

  -- Linden (id=90)
  (90,   'chemical sensitivity', 'ailment'),
  (90,   'depression',           'ailment'),

  -- Burdock (id=22)
  (22,   'chemical sensitivity', 'ailment'),
  (22,   'liver support',        'ailment'),
  (22,   'bile flow',            'ailment'),

  -- Licorice (id=78)
  (78,   'chemical sensitivity', 'ailment'),
  (78,   'liver support',        'ailment'),

  -- Red Clover (id=42)
  (42,   'chemical sensitivity', 'ailment'),
  (42,   'liver support',        'ailment'),

  -- Dandelion root (id=122)
  (122,  'chemical sensitivity', 'ailment'),
  (122,  'liver support',        'ailment'),
  (122,  'bile flow',            'ailment'),

  -- Lemon Balm (id=134)
  (134,  'chemical sensitivity', 'ailment'),
  (134,  'depression',           'ailment'),

  -- Ginger (id=124)
  (124,  'chemical sensitivity', 'ailment'),
  (124,  'constipation',         'symptom'),

  -- Chicory root (id=2227)
  (2227, 'chemical sensitivity', 'ailment'),

  -- Sarsaparilla (id=40)
  (40,   'chemical sensitivity', 'ailment'),

  -- Cinnamon (id=167)
  (167,  'chemical sensitivity', 'ailment'),

  -- Hawthorn berry (id=73)
  (73,   'chemical sensitivity', 'ailment'),

  -- Elder berry (id=1651)
  (1651, 'chemical sensitivity', 'ailment')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ─────────────────────────────────────────────
-- Ailment search synonyms (new ailment keywords only)
-- ─────────────────────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('chemical sensitivity',
   ARRAY['multiple chemical sensitivity', 'MCS', 'environmental sensitivity', 'environmental illness', 'chemical intolerance', 'toxic exposure sensitivity']),
  ('depression',
   ARRAY['major depressive disorder', 'MDD', 'low mood', 'melancholy', 'mood disorder', 'dysthymia'])
ON CONFLICT (ailment_keyword) DO NOTHING;
