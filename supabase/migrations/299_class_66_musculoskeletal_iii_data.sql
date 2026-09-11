-- Migration 299: Class 66 — Musculoskeletal III
-- Files parsed:
--   BHC - Class 66 - Musculoskeletal III - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 66 - Musculoskeletal III - Lisa.md             (note_type = 'personal')
--   BHC - Class 66 - Musculoskeletal III - Transcript.md       (ignored per playbook)
--
-- Normalisations applied:
--   Iris (general) → Blue Flag (Iris versicolor, id=31); context is digestive/bile/fat metabolism
--   Baikal skullcap → Chinese Skullcap (Scutellaria baicalensis, id=2274)
--   SJW → St. John's Wort (Hypericum perforatum, id=81)
--   Vit D → Vitamin D supplement (supplement_id=11)
--   Reishi → Reishi Mushroom (Ganoderma lucidum, herb_id=11)
--   Nettle root → Nettle root (Urtica dioica root, herb_id=1649)
--
-- Keyword merge decisions:
--   "musculoskeletal pain" → existing 'chronic pain' + 'inflammation'
--   "muscle tension" → existing 'muscle spasms'
--   "joint pain" → existing 'arthritis' + 'inflammation'
--   "fat metabolism" (iris context) → existing 'bile flow'
--
-- New ailment keywords introduced:
--   'fibrosis' — buildup of fibroblasts causing adhesions; distinct from fibromyalgia disease state
--   'bone density' — bone mineralization/remineralization support; distinct from 'osteoporosis'
--
-- Supplements skipped (not in herbal.supplements):
--   Beta-glucan, Bile salts
-- Preparations / foods skipped:
--   Fermented soy, castor oil, guasha, cupping, whey, hemp protein

SET search_path TO herbal, public;

-- ============================================================
-- HERB SNIPPETS
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 66 - Musculoskeletal III'
      AND herb_id IS NOT NULL
  ) THEN
    RAISE NOTICE 'Class 66 herb snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === GENERATED NOTES — Therapeutic Strategy ===

  -- Black Cohosh: serotonin support for fibromyalgia pain
  (25,
   'Serotonin support (e.g., Black cohosh, St. John''s wort)',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Therapeutic Strategy', 10,
   '## Therapeutic Strategy
- Support circulatory and lymphatic systems
- Encourage inflammation reduction
- Promote tissue nourishment
- Vitamin D and zinc for anti-inflammatory
- Serotonin support (e.g., Black cohosh, St. John''s wort)'),

  -- St. John's Wort: serotonin support for fibromyalgia pain
  (81,
   'Serotonin support (e.g., Black cohosh, St. John''s wort)',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Therapeutic Strategy', 20,
   '## Therapeutic Strategy
- Support circulatory and lymphatic systems
- Encourage inflammation reduction
- Promote tissue nourishment
- Vitamin D and zinc for anti-inflammatory
- Serotonin support (e.g., Black cohosh, St. John''s wort)'),

  -- === GENERATED NOTES — Herbal Suggestions ===

  -- White Peony: anti-fibrotic
  (2238,
   'Anti-fibrotics: White peony, ashwagandha',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Herbal Suggestions', 30,
   '### Herbal Suggestions
- Anti-fibrotics: White peony, ashwagandha
- Pro-apoptosis: Beta-glucan, bile salts
- Gut health: Aromatics like ginger, iris
- Nourishment: Hibiscus, marshmallow root'),

  -- Ashwagandha: anti-fibrotic
  (20,
   'Anti-fibrotics: White peony, ashwagandha',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Herbal Suggestions', 40,
   '### Herbal Suggestions
- Anti-fibrotics: White peony, ashwagandha
- Pro-apoptosis: Beta-glucan, bile salts
- Gut health: Aromatics like ginger, iris
- Nourishment: Hibiscus, marshmallow root'),

  -- Ginger: gut health aromatic
  (124,
   'Gut health: Aromatics like ginger, iris',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Herbal Suggestions', 50,
   '### Herbal Suggestions
- Anti-fibrotics: White peony, ashwagandha
- Pro-apoptosis: Beta-glucan, bile salts
- Gut health: Aromatics like ginger, iris
- Nourishment: Hibiscus, marshmallow root'),

  -- Blue Flag (Iris versicolor): gut health aromatic
  (31,
   'Gut health: Aromatics like ginger, iris',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Herbal Suggestions', 60,
   '### Herbal Suggestions
- Anti-fibrotics: White peony, ashwagandha
- Pro-apoptosis: Beta-glucan, bile salts
- Gut health: Aromatics like ginger, iris
- Nourishment: Hibiscus, marshmallow root'),

  -- Hibiscus: tissue nourishment
  (2233,
   'Nourishment: Hibiscus, marshmallow root',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Herbal Suggestions', 70,
   '### Herbal Suggestions
- Anti-fibrotics: White peony, ashwagandha
- Pro-apoptosis: Beta-glucan, bile salts
- Gut health: Aromatics like ginger, iris
- Nourishment: Hibiscus, marshmallow root'),

  -- Marshmallow: tissue nourishment
  (45,
   'Nourishment: Hibiscus, marshmallow root',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Herbal Suggestions', 80,
   '### Herbal Suggestions
- Anti-fibrotics: White peony, ashwagandha
- Pro-apoptosis: Beta-glucan, bile salts
- Gut health: Aromatics like ginger, iris
- Nourishment: Hibiscus, marshmallow root'),

  -- === PERSONAL NOTES — Pathophysiology (fibrosis) ===

  -- Red Clover: phytoestrogen for apoptosis in fibrosis
  (42,
   'Phytoestrogen source to encourage apoptosis — red clover; for fibrosis/fibroblast accumulation',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Pathophysiology', 10,
   '#### Pathophysiology
- injury possibly

AI
AO
Alter
Nervine
Immune mods
Encourage apoptosis
    - nourish beta-astradiols (fermented soy as a primary protein source)
        - phytoestrogen source
            - red clover
            - hops - also supports sleep
Plants that support cell. diff
Antifibrotics
    - White Peony
    - Ashwagandha
    - Astragalus

- think of it as scarring, so treat like that:
    - heat
    - castor oil
    - guasha
    - massage
    - cupping - maybe with gentler rubber cups first then the more serious suction ones later, after progress

Koralla Institute in Millbrae - Pancha Karma'),

  -- Hops: phytoestrogen for apoptosis in fibrosis; also sleep
  (129,
   'Hops - also supports sleep; phytoestrogen source for apoptosis support in fibrosis',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Pathophysiology', 20,
   '#### Pathophysiology
- injury possibly

AI
AO
Alter
Nervine
Immune mods
Encourage apoptosis
    - nourish beta-astradiols (fermented soy as a primary protein source)
        - phytoestrogen source
            - red clover
            - hops - also supports sleep
Plants that support cell. diff
Antifibrotics
    - White Peony
    - Ashwagandha
    - Astragalus

- think of it as scarring, so treat like that:
    - heat
    - castor oil
    - guasha
    - massage
    - cupping - maybe with gentler rubber cups first then the more serious suction ones later, after progress

Koralla Institute in Millbrae - Pancha Karma'),

  -- White Peony: antifibrotic
  (2238,
   'Antifibrotics — White Peony, Ashwagandha, Astragalus',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Pathophysiology', 30,
   '#### Pathophysiology
- injury possibly

AI
AO
Alter
Nervine
Immune mods
Encourage apoptosis
    - nourish beta-astradiols (fermented soy as a primary protein source)
        - phytoestrogen source
            - red clover
            - hops - also supports sleep
Plants that support cell. diff
Antifibrotics
    - White Peony
    - Ashwagandha
    - Astragalus

- think of it as scarring, so treat like that:
    - heat
    - castor oil
    - guasha
    - massage
    - cupping - maybe with gentler rubber cups first then the more serious suction ones later, after progress

Koralla Institute in Millbrae - Pancha Karma'),

  -- Ashwagandha: antifibrotic (Pathophysiology section)
  (20,
   'Antifibrotics — White Peony, Ashwagandha, Astragalus',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Pathophysiology', 40,
   '#### Pathophysiology
- injury possibly

AI
AO
Alter
Nervine
Immune mods
Encourage apoptosis
    - nourish beta-astradiols (fermented soy as a primary protein source)
        - phytoestrogen source
            - red clover
            - hops - also supports sleep
Plants that support cell. diff
Antifibrotics
    - White Peony
    - Ashwagandha
    - Astragalus

- think of it as scarring, so treat like that:
    - heat
    - castor oil
    - guasha
    - massage
    - cupping - maybe with gentler rubber cups first then the more serious suction ones later, after progress

Koralla Institute in Millbrae - Pancha Karma'),

  -- Astragalus: antifibrotic (Pathophysiology section)
  (225,
   'Antifibrotics — White Peony, Ashwagandha, Astragalus',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Pathophysiology', 50,
   '#### Pathophysiology
- injury possibly

AI
AO
Alter
Nervine
Immune mods
Encourage apoptosis
    - nourish beta-astradiols (fermented soy as a primary protein source)
        - phytoestrogen source
            - red clover
            - hops - also supports sleep
Plants that support cell. diff
Antifibrotics
    - White Peony
    - Ashwagandha
    - Astragalus

- think of it as scarring, so treat like that:
    - heat
    - castor oil
    - guasha
    - massage
    - cupping - maybe with gentler rubber cups first then the more serious suction ones later, after progress

Koralla Institute in Millbrae - Pancha Karma'),

  -- === PERSONAL NOTES — Therapeutic Strategies ===

  -- Poke Root: serious lymphatic for fibromyalgia/fibrosis (low dose)
  (35,
   'Circulation: Blood and Lymph — more serious lymphatics: low dose poke root',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 60,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Red Root: serious lymphatic
  (981,
   'Circulation: Blood and Lymph — more serious lymphatics: red root',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 70,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Ocotillo: lymphatic (serious, for fibromyalgia/fibrosis circulation)
  (1248,
   'Circulation: Blood and Lymph — more serious lymphatics: ocotillo maybe',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 80,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Ginger: circulatory stimulant for lymph and blood
  (124,
   'Circulation: Blood and Lymph — generally ginger as circulatory stimulant',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 90,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Burdock: elimination/alterative
  (22,
   'Elimination — burdock, yellow dock',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 100,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Yellow Dock: elimination/alterative
  (37,
   'Elimination — burdock, yellow dock',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 110,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Hibiscus: tissue nourishment, hyaluronic acid / extracellular matrix
  (2233,
   'Tissue nourishment — Hibiscus, in helping the EM with hyaluronic acid',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 120,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Marshmallow: tissue nourishment
  (45,
   'Tissue nourishment — marshmallow root',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 130,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Gentian: gut health / digestive bitter
  (102,
   'Gut health — gentian',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 140,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Blue Flag (Iris versicolor): gut health, fat metabolism
  (31,
   'Gut health — iris, helps body metabolize fats',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 150,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Black Cohosh: serotonin agonist, pain perception modulator
  (25,
   'Support serotonin levels — Black Cohosh, serotonin agonist - alter body''s perception of pain',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 160,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- St. John's Wort: serotonin support
  (81,
   'Support serotonin levels — also SJW (St. John''s Wort)',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 170,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Chinese Skullcap (Baikal skullcap): promote apoptosis
  (2274,
   'Promote apoptosis — Baikal skullcap',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 180,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Nettle root: promote apoptosis
  (1649,
   'Promote apoptosis — Nettle root',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 190,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Ashwagandha: antifibrotic (Therapeutic Strategies section)
  (20,
   'Antifibrotic — ashwagandha, astragalus, white peony',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 200,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Astragalus: antifibrotic (Therapeutic Strategies section)
  (225,
   'Antifibrotic — ashwagandha, astragalus, white peony',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 210,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- White Peony: antifibrotic (Therapeutic Strategies section)
  (2238,
   'Antifibrotic — ashwagandha, astragalus, white peony',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 220,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Gotu Kola: foundational tissue support for autoimmune/ECM/fibromyalgia
  (2229,
   'Autoimmune disease with ECM and Fibromyalgia — Gotu kola, foundational tissue support',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 230,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Calendula: for autoimmune/ECM/fibromyalgia
  (70,
   'Autoimmune disease with ECM and Fibromyalgia — Calendula',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 240,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Reishi Mushroom: for autoimmune/ECM/fibromyalgia, in soups/wet foods
  (11,
   'Autoimmune disease with ECM and Fibromyalgia — Reishi, in soups and wet foods; stay nourished',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 250,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Cleavers: gentle lymphatic for autoimmune/fibromyalgia
  (28,
   'Autoimmune disease with ECM and Fibromyalgia — lymphatics: gentle — cleavers, violet',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 260,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Violet: gentle lymphatic for autoimmune/fibromyalgia
  (198,
   'Autoimmune disease with ECM and Fibromyalgia — lymphatics: gentle — cleavers, violet',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 270,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Black Cohosh: lower dose for autoimmune/ECM/fibromyalgia context
  (25,
   'Autoimmune disease with ECM and Fibromyalgia — lower dose Black Cohosh',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 280,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS
-- ============================================================
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 66 - Musculoskeletal III'
      AND supplement_id IS NOT NULL
  ) THEN
    RAISE NOTICE 'Class 66 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Vitamin D: anti-inflammatory for fibromyalgia (generated notes)
  (11,
   'Vitamin D and zinc for anti-inflammatory',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Therapeutic Strategy', 10,
   '## Therapeutic Strategy
- Support circulatory and lymphatic systems
- Encourage inflammation reduction
- Promote tissue nourishment
- Vitamin D and zinc for anti-inflammatory
- Serotonin support (e.g., Black cohosh, St. John''s wort)'),

  -- Zinc: anti-inflammatory for fibromyalgia (generated notes)
  (24,
   'Vitamin D and zinc for anti-inflammatory',
   'BHC - Class 66 - Musculoskeletal III', 'generated', 'Therapeutic Strategy', 20,
   '## Therapeutic Strategy
- Support circulatory and lymphatic systems
- Encourage inflammation reduction
- Promote tissue nourishment
- Vitamin D and zinc for anti-inflammatory
- Serotonin support (e.g., Black cohosh, St. John''s wort)'),

  -- Vitamin D: tissue nourishment (personal notes - Therapeutic Strategies)
  (11,
   'Tissue nourishment — Vit D',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Therapeutic Strategies', 30,
   '#### Therapeutic Strategies
- Circulation: Blood and Lymph
    - more serious lymphatics:
        - low dose poke root
        - red root
        - ocotillo maybe
        - generally ginger
- Elimination
    - burdock
    - yellow dock
- Tissue nourishment
    - Hibiscus, in helping the EM with hyaluronic acid
    - marshmallow root
    - oilination as well
    - Vit D
- Gut health
    - gentian
    - iris - helps body metabolize fats
- Support serotonin levels
    - Black Cohosh
        - serotonin agonist - alter body''s perception of pain
    - also SJW
- Promote apoptosis
    - Baikal skullcap
    - Nettle root
- Antifibrotic
    - ashwagandha
    - astragalus
    - white peony
- Autoimmune disease, with extracellular matrix and Fibromyalgia?
    - Gotu kola - foundational tissue support
    - Calendula
    - Reishi - in soups and wet foods
        - stay nourished
    - lymphatics
        - gentle - cleavers, violet
    - lower dose Black Cohosh'),

  -- Lysine: current supplement for Mary (postmenopausal, bone density, musculoskeletal)
  (44,
   'Lycine, 2KIU D, and Calcium supplement — current supplements for case study patient (56, postmenopausal, bone density concern)',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Case Study', 40,
   '# Case Study
- Mary, 56 yrs old, Tech Worker (freelance), 155 lbs, 5''11"
- Chief Complaint: Back/Muscle Tension, Improving Bone density, Sleep, Stress Symptoms: Anxiety, Nervousness, Depression, Headaches, Dry Skin, Joint Pain, Teeth Grinding, Weak Ankles, Waking to Urinate, Cold Hands and Feet, Brain Fog, Restless Sleep, Acidic Stomach on Waking, Cravings for Sugary Foods, Allergies
- Postmenopause since 3 years
- no meds
- Lycine, 2KIU D, and Calcium supplement
- tall, thin, looks deficient - catabolic, can''t get enough food, under-resourced'),

  -- Vitamin D: current supplement for Mary (case study)
  (11,
   'Lycine, 2KIU D, and Calcium supplement — current supplements for case study patient (56, postmenopausal, bone density concern)',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Case Study', 50,
   '# Case Study
- Mary, 56 yrs old, Tech Worker (freelance), 155 lbs, 5''11"
- Chief Complaint: Back/Muscle Tension, Improving Bone density, Sleep, Stress Symptoms: Anxiety, Nervousness, Depression, Headaches, Dry Skin, Joint Pain, Teeth Grinding, Weak Ankles, Waking to Urinate, Cold Hands and Feet, Brain Fog, Restless Sleep, Acidic Stomach on Waking, Cravings for Sugary Foods, Allergies
- Postmenopause since 3 years
- no meds
- Lycine, 2KIU D, and Calcium supplement
- tall, thin, looks deficient - catabolic, can''t get enough food, under-resourced'),

  -- Calcium: current supplement for Mary (case study)
  (15,
   'Lycine, 2KIU D, and Calcium supplement — current supplements for case study patient (56, postmenopausal, bone density concern)',
   'BHC - Class 66 - Musculoskeletal III', 'personal', 'Case Study', 60,
   '# Case Study
- Mary, 56 yrs old, Tech Worker (freelance), 155 lbs, 5''11"
- Chief Complaint: Back/Muscle Tension, Improving Bone density, Sleep, Stress Symptoms: Anxiety, Nervousness, Depression, Headaches, Dry Skin, Joint Pain, Teeth Grinding, Weak Ankles, Waking to Urinate, Cold Hands and Feet, Brain Fog, Restless Sleep, Acidic Stomach on Waking, Cravings for Sugary Foods, Allergies
- Postmenopause since 3 years
- no meds
- Lycine, 2KIU D, and Calcium supplement
- tall, thin, looks deficient - catabolic, can''t get enough food, under-resourced');

END $$;

-- ============================================================
-- HERB KEYWORDS
-- ============================================================

-- Black Cohosh (25)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (25, 'fibromyalgia',     'ailment'),
  (25, 'chronic pain',     'ailment'),
  (25, 'depression',       'ailment'),
  (25, 'autoimmune disease','ailment'),
  (25, 'serotonin agonist','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- St. John's Wort (81)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (81, 'fibromyalgia',     'ailment'),
  (81, 'chronic pain',     'ailment'),
  (81, 'depression',       'ailment'),
  (81, 'serotonin agonist','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- White Peony (2238)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2238, 'fibrosis',                 'ailment'),
  (2238, 'fibromyalgia',             'ailment'),
  (2238, 'connective tissue disorders','ailment'),
  (2238, 'anti-fibrotic',            'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ashwagandha (20)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (20, 'fibrosis',                 'ailment'),
  (20, 'fibromyalgia',             'ailment'),
  (20, 'connective tissue disorders','ailment'),
  (20, 'anti-fibrotic',            'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginger (124)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'gut inflammation',  'ailment'),
  (124, 'poor circulation',  'ailment'),
  (124, 'lymphatic support', 'ailment'),
  (124, 'fibromyalgia',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Blue Flag / Iris versicolor (31)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (31, 'gut inflammation', 'ailment'),
  (31, 'bile flow',        'ailment'),
  (31, 'fibromyalgia',     'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hibiscus (2233)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2233, 'connective tissue disorders','ailment'),
  (2233, 'fibromyalgia',              'ailment'),
  (2233, 'inflammation',              'ailment'),
  (2233, 'hydration',                 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Marshmallow (45)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45, 'connective tissue disorders','ailment'),
  (45, 'fibromyalgia',              'ailment'),
  (45, 'mucous membrane support',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Clover (42)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (42, 'fibrosis',        'ailment'),
  (42, 'fibromyalgia',    'ailment'),
  (42, 'estrogen support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hops (129)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (129, 'fibrosis',        'ailment'),
  (129, 'fibromyalgia',    'ailment'),
  (129, 'sleep support',   'ailment'),
  (129, 'estrogen support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Astragalus (225)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (225, 'fibrosis',                 'ailment'),
  (225, 'fibromyalgia',             'ailment'),
  (225, 'connective tissue disorders','ailment'),
  (225, 'immune support',           'ailment'),
  (225, 'anti-fibrotic',            'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Poke Root (35)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (35, 'lymphatic support',          'ailment'),
  (35, 'fibromyalgia',               'ailment'),
  (35, 'connective tissue disorders', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Root (981)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (981, 'lymphatic support', 'ailment'),
  (981, 'fibromyalgia',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ocotillo (1248)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1248, 'lymphatic support', 'ailment'),
  (1248, 'poor circulation',  'ailment'),
  (1248, 'fibromyalgia',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Burdock (22)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (22, 'lymphatic support', 'ailment'),
  (22, 'fibromyalgia',      'ailment'),
  (22, 'inflammation',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yellow Dock (37)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (37, 'lymphatic support', 'ailment'),
  (37, 'fibromyalgia',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gentian (102)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (102, 'gut inflammation', 'ailment'),
  (102, 'bile flow',        'ailment'),
  (102, 'digestive tonic',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chinese Skullcap / Baikal Skullcap (2274)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2274, 'fibrosis',        'ailment'),
  (2274, 'fibromyalgia',    'ailment'),
  (2274, 'inflammation',    'ailment'),
  (2274, 'pro-apoptotic',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle root (1649)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1649, 'fibrosis',      'ailment'),
  (1649, 'fibromyalgia',  'ailment'),
  (1649, 'pro-apoptotic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gotu Kola (2229)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2229, 'connective tissue disorders','ailment'),
  (2229, 'fibromyalgia',              'ailment'),
  (2229, 'autoimmune disease',        'ailment'),
  (2229, 'inflammation',              'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula (70)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'connective tissue disorders','ailment'),
  (70, 'fibromyalgia',              'ailment'),
  (70, 'autoimmune disease',        'ailment'),
  (70, 'inflammation',              'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi Mushroom (11)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11, 'fibromyalgia',    'ailment'),
  (11, 'autoimmune disease','ailment'),
  (11, 'immune support',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cleavers (28)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (28, 'lymphatic support',  'ailment'),
  (28, 'fibromyalgia',       'ailment'),
  (28, 'autoimmune disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Violet (198)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (198, 'lymphatic support',  'ailment'),
  (198, 'fibromyalgia',       'ailment'),
  (198, 'autoimmune disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ============================================================
-- SUPPLEMENT KEYWORDS
-- ============================================================

-- Vitamin D (supplement_id=11)
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (11, 'anti-inflammatory', 'action'),
  (11, 'fibromyalgia',      'ailment'),
  (11, 'bone density',      'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Zinc (supplement_id=24)
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (24, 'anti-inflammatory', 'action'),
  (24, 'fibromyalgia',      'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Lysine (supplement_id=44)
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (44, 'bone density',               'ailment'),
  (44, 'connective tissue disorders','ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Calcium (supplement_id=15)
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (15, 'bone density',    'ailment'),
  (15, 'mineral support', 'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- NEW AILMENT SEARCH SYNONYMS
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('fibrosis',     ARRAY['scarring', 'fibrotic tissue', 'adhesions', 'scar tissue buildup', 'fibroblast accumulation', 'connective tissue scarring']),
  ('bone density', ARRAY['osteopenia', 'bone loss', 'bone mineral density', 'remineralization', 'bone health', 'bone fragility'])
ON CONFLICT (ailment_keyword) DO NOTHING;
