-- Migration 281: BHC Class 40 — Supplemental snippets for Japanese Knotweed and Pedicularis
-- These herbs were skipped in migration 275 because they were not yet in the DB.
-- Herb IDs: Japanese Knotweed = 2623, Pedicularis densiflora = 2624
--
-- Source file parsed: BHC - Class 40 - Musculoskeletal I and II - Lisa.md (personal notes)
-- class_name: 'BHC - Class 40 - Musculoskeletal I and II'
--
-- Herb context:
--   Japanese Knotweed — mentioned in Chronic Pain section as part of Stephen Buhner's
--     stealth-virus/long-covid protocol (not a standalone herb section).
--   Pedicularis — mentioned in the Kava section (as its unrivaled skeletal muscle relaxant
--     comparator) and in the Jamaican Dogwood section (as a pairing herb for skeletal pain).
--
-- New ailment keyword: 'stealth virus' (not in ailment_search_terms yet)
-- Existing ailment keywords reused: 'long covid', 'muscle spasms', 'chronic pain'

SET search_path TO herbal, public;

-- ── Snippets ──────────────────────────────────────────────────────────────────
DO $$
DECLARE
  src_cp   TEXT;
  src_kava TEXT;
  src_jdog TEXT;
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE herb_id = 2623
      AND class_name = 'BHC - Class 40 - Musculoskeletal I and II'
  ) THEN
    RAISE NOTICE 'Class 40 Knotweed/Pedicularis snippets already loaded, skipping.';
    RETURN;
  END IF;

  src_cp := $blk$### Chronic Pain
- nociceptic pain
- myofascial pain
- inflammatory pain
- psychogenic pain
    - NS so out of balance that people start to amplify their sensory experience
    - touch pain, sounds
    - Calcium/Vit D depletion? dryness
- mechanical pain
    - fractures
    - tumors impairing free movement
    - malignancies

- common causes:
    - systemic inflammation
        - immune function
        - gut thing
        - nutrient malabsorption
    - nutrient deficiencies
    - toxic accumulation
    - blood stagnation or poor circulation
    - structural imbalance
    - digestive disturbance
    - stealth viruses
        - herpes
        - Epstein-Barr
        - Covid/long covid
            - Steven Buhner's work
                - Baical Skullcap
                - Salvia ..rhiz - Reg Sage
                - Reishi
                - Licorice
                - Red root
                - Japanese Knotweed
                - cilia dessicates in long covid, tissues get overwhelmed with stuff
                    - cause buildup in the tissues, cilia isn't removing stuff
                    - mast cells lock down (overwhelm) and don't respond effectively
                    - amyloid plaque - filters into the bloodstream
        - = achy body$blk$;

  src_kava := $blk$#### Kava
- one of the very few skeletal muscle relaxants that rivals Pedicularis
    - Ped. is only in the wild, parasitic plant
- nervine that helps with sleep
- antispasmodic - muscle cramps$blk$;

  src_jdog := $blk$#### Jamaican Dogwood
- "Florida fish poison tree"
- generally, specific for smooth muscle pain
- phantom pains (amputations)
- insomnia with spasms
- nervous irritability
- tachycardia
- general body pains
- sedative, by degrees are diff perspectives
- pretty well tolerated, no side-effects
- pairs well with AI, to reduce sensation of pain, like willow or meadowsweet
- pairs well with recent injury + wild lettuce or Kava
- insomnia due to body aches + Hops or skullcap
- skeletal pain + black cohosh, pedicularis
- targets face pain$blk$;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Japanese Knotweed: Buhner protocol for stealth-virus musculoskeletal pain
    (2623,
     'Japanese Knotweed is part of Stephen Buhner''s protocol for stealth-virus-related musculoskeletal pain, including long COVID. Used alongside Baical Skullcap, Salvia, Reishi, Licorice, and Red Root. In long COVID, the respiratory cilia desiccate, tissues become overwhelmed with debris, mast cells lock down, and amyloid plaque enters the bloodstream — producing a chronically achy body. Treatment focus is moistening tissues and clearing stagnation.',
     'BHC - Class 40 - Musculoskeletal I and II', 'personal', 'Chronic Pain', 290, src_cp),

    -- Pedicularis: strongest skeletal muscle relaxant, wild-harvested and parasitic
    (2624,
     'Pedicularis is one of the strongest skeletal muscle relaxants available, rivaling Kava. It is wild-harvested and parasitic — it cannot be cultivated and requires specific host plants in intact ecosystems. Species include Indian Warrior (Pedicularis densiflora), Elephant Head, and Parrot''s Beak. Because of its wild status, Kava is considered one of the few sustainable alternatives.',
     'BHC - Class 40 - Musculoskeletal I and II', 'personal', 'Kava', 300, src_kava),

    -- Pedicularis: pairing note from Jamaican Dogwood section
    (2624,
     'Pedicularis is paired with Jamaican Dogwood for skeletal muscle pain, often alongside Black Cohosh. Jamaican Dogwood addresses smooth muscle pain and nervous irritability while Pedicularis contributes direct skeletal muscle relaxation.',
     'BHC - Class 40 - Musculoskeletal I and II', 'personal', 'Jamaican Dogwood', 310, src_jdog);

END $$;

-- ── Keywords ──────────────────────────────────────────────────────────────────
-- Japanese Knotweed
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2623, 'long covid',        'ailment'),
  (2623, 'stealth virus',     'ailment'),
  (2623, 'chronic pain',      'ailment'),
  (2623, 'antiviral',         'action'),
  (2623, 'anti-inflammatory', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pedicularis
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2624, 'skeletal muscle relaxant', 'action'),
  (2624, 'antispasmodic',            'action'),
  (2624, 'muscle spasms',            'ailment'),
  (2624, 'muscle cramps',            'symptom'),
  (2624, 'chronic pain',             'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ── Ailment search synonyms (new keyword only) ────────────────────────────────
-- 'stealth virus' is new; 'long covid' and 'chronic pain' already in ailment_search_terms
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('stealth virus', ARRAY['latent virus', 'herpes virus', 'Epstein-Barr', 'EBV', 'viral persistence', 'chronic viral infection', 'post-viral syndrome'])
ON CONFLICT (ailment_keyword) DO NOTHING;
