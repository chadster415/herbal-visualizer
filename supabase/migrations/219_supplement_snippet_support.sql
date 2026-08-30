SET search_path TO herbal, public;

-- ─── Supplement support for class_note_snippets and herb_keywords ──────────────
--
-- Adds supplement_id (FK → herbal.supplements) to both tables so vitamins and
-- minerals can be cited in class note snippets and keyword associations, just like
-- herbs. herb_id is made nullable; a CHECK ensures each row has at least one of
-- herb_id or supplement_id set.
--
-- Backwards-compatible: the original UNIQUE CONSTRAINT (herb_id, keyword) on
-- herb_keywords is preserved so existing ON CONFLICT (herb_id, keyword) DO NOTHING
-- patterns in prior migrations continue to work. A new partial unique index covers
-- supplement rows.
--
-- Also inserts: Zinc (supplement id=24) snippets and keywords for Class 60,
-- which was omitted from migration 218 (herb-only) because supplement_id
-- did not yet exist.

-- ─── 1. class_note_snippets ───────────────────────────────────────────────────

ALTER TABLE herbal.class_note_snippets
  ALTER COLUMN herb_id DROP NOT NULL;

ALTER TABLE herbal.class_note_snippets
  ADD COLUMN IF NOT EXISTS supplement_id INTEGER
    REFERENCES herbal.supplements(id) ON DELETE CASCADE;

ALTER TABLE herbal.class_note_snippets
  DROP CONSTRAINT IF EXISTS class_note_snippets_entity_check;

ALTER TABLE herbal.class_note_snippets
  ADD CONSTRAINT class_note_snippets_entity_check
  CHECK (herb_id IS NOT NULL OR supplement_id IS NOT NULL);

CREATE INDEX IF NOT EXISTS idx_class_note_snippets_supplement_id
  ON herbal.class_note_snippets(supplement_id);

-- ─── 2. herb_keywords ────────────────────────────────────────────────────────

ALTER TABLE herbal.herb_keywords
  ALTER COLUMN herb_id DROP NOT NULL;

ALTER TABLE herbal.herb_keywords
  ADD COLUMN IF NOT EXISTS supplement_id INTEGER
    REFERENCES herbal.supplements(id) ON DELETE CASCADE;

ALTER TABLE herbal.herb_keywords
  DROP CONSTRAINT IF EXISTS herb_keywords_entity_check;

ALTER TABLE herbal.herb_keywords
  ADD CONSTRAINT herb_keywords_entity_check
  CHECK (herb_id IS NOT NULL OR supplement_id IS NOT NULL);

-- Partial unique index for supplement rows (herb rows already covered by the
-- existing herb_keywords_herb_id_keyword_key constraint)
CREATE UNIQUE INDEX IF NOT EXISTS herb_keywords_supplement_id_keyword_key
  ON herbal.herb_keywords(supplement_id, keyword)
  WHERE supplement_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_herb_keywords_supplement_id
  ON herbal.herb_keywords(supplement_id);

-- ─── 3. Zinc snippets for Class 60 ───────────────────────────────────────────
--
-- Zinc (supplement id=24) appears in four sections of BHC - Class 60:
--   Generated: "Nutritional and Herbal Approaches" — zinc depleted through semen
--   Generated: "BPH" — zinc content in pumpkin seeds for prostate health
--   Personal:  "Takeaway" — zinc depleted, food sources listed
--   Personal:  "Erectile Dysfunction" — zinc from pumpkin seeds in diet
--
-- Source blocks for the BPH, Takeaway, and Erectile Dysfunction sections are
-- shared with the Pumpkin snippets already in migration 218.

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE supplement_id = 24
      AND class_name = 'BHC - Class 60 - AMAB Health and Lotions'
  ) THEN
    RAISE NOTICE 'Class 60 Zinc supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ── Generated: Nutritional and Herbal Approaches ──────────────────────────
  (24, 'Zinc depletion through semen expression — key mineral for reproductive and prostate health',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'Nutritional and Herbal Approaches', 170,
   '- Antioxidants and astringents
    - Urinary and sexual health
- Importance of lifestyle changes
    - Good nutrition essential — eating vegetables, fruits, fish oil, etc.
    - Zinc depletion through semen expression
- Reproductive tonics
    - Pine pollen for increasing testosterone levels'),

  -- ── Generated: BPH ───────────────────────────────────────────────────────
  (24, 'Zinc content in pumpkin seeds noted as supportive for prostate health in BPH context',
   'BHC - Class 60 - AMAB Health and Lotions', 'generated', 'BPH', 148,
   '**Prostate Health:**
- Processed foods increase risk (bread, sugar, alcohol, caffeine)
- Reduce caffeine gradually (half-cup increments)
- Pumpkin seeds beneficial for sperm health (zinc content)

**BPH:**
- Prostate likened to walnut-sized organ; inflammation narrows urine passage
    - Causes dribbling, urgency, incomplete emptying
- Medication: alpha-blockers, 5-alpha reductase inhibitors
- Herbal support:
    - Saw palmetto, nettle root, green tea, white sage, pumpkin seed oil, pomegranate
        - Anti-inflammatory; suggested product: Gaia Herbs formula'),

  -- ── Personal: Takeaway ───────────────────────────────────────────────────
  (24, 'Zinc is depleted through semen expression — seaweeds, pumpkin seeds, eggs, shellfish as dietary sources',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Takeaway', 211,
   '- zinc is depleted through semen expression
    - seaweeds, pumpkin seeds, eggs, shellfish
- antioxidant-rich foods:
    - berries, cherries, green tea and turmeric'),

  -- ── Personal: Erectile Dysfunction ───────────────────────────────────────
  (24, 'Zinc from pumpkin seeds recommended in diet for erectile dysfunction',
   'BHC - Class 60 - AMAB Health and Lotions', 'personal', 'Erectile Dysfunction', 221,
   '- can be physical reasons; but majority may be emotional, psychological, spiritual
- actions: aphrodisiac, adaptogen, circulatory stimulant, nervine, nutritive/tonic, vasodilator
- lifestyle: regular exercise, kegels, hot/cold showers
- diet:
    - avoid processed food, refined grains, alcohol, sugar, caffeine
    - zinc: pumpkin seeds
    - Rosemary Gladstar: energy-herb balls and power-powder balls');

END $$;

-- ─── 4. Zinc keywords ────────────────────────────────────────────────────────

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (24, 'low testosterone',    'ailment'),
  (24, 'erectile dysfunction','ailment'),
  (24, 'BPH',                'ailment'),
  (24, 'reproductive support','ailment'),
  (24, 'mineral support',    'ailment'),
  (24, 'nutritive',          'action')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;
