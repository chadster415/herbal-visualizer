-- Migration 340: Class 68 - Snippets for newly-added herbs
-- These herbs were absent from the DB when migration 335 ran.
-- Covers: Lemongrass, Sumac, Bee Balm, Bidens, Jojoba, Agarita, Neem,
--         Pine Needles, Maravilla, and Cedar (Thuja id=201, already in DB).
-- Run AFTER migrations 338 and 339.

SET search_path TO herbal, public;

-- ── Generated notes snippets ──────────────────────────────────────────────────
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 68 - Integumentary III'
      AND note_type = 'generated'
      AND herb_id = (SELECT id FROM herbal.herbs WHERE latin_name = 'Cymbopogon citratus')
  ) THEN
    RAISE NOTICE 'Class 68 generated snippets for new herbs already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, class_name, note_type, section_header, snippet_text, source_block, sort_order)
  VALUES

  -- Lemongrass — nourishing tea ingredient
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Cymbopogon citratus'),
   'BHC - Class 68 - Integumentary III', 'generated',
   'Nourishing Tea Formula',
   'One part lemongrass in the nourishing tea formula targeting bone density and nervous system support. Long overnight infusion in hot water.',
   'Nourishing Tea Formula: Three parts nettle, three parts oat straw, one part red clover, two parts horsetail, one part lemongrass.',
   10),

  -- Lemongrass — volatile oils action
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Cymbopogon citratus'),
   'BHC - Class 68 - Integumentary III', 'generated',
   'Ingredients and Actions',
   'Volatile oils for calming. Aids digestion, flavor enhancement.',
   'Lemongrass: volatile oils for calming. Aids digestion, flavor enhancement.',
   20),

  -- Sumac — nutritive tea ingredient
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Rhus glabra'),
   'BHC - Class 68 - Integumentary III', 'generated',
   'Nutritive Tea',
   'Sumac included in the nutritive tea for calcium, potassium; supports bones, hair, teeth; manages inflammation and insulin.',
   'Nutritive Tea ingredients: Alfalfa, Gotu kola, Nettle, Oat straw, Sumac, Fennel. Benefits: calcium, potassium, supports bones, hair, teeth; manages inflammation and insulin.',
   10);

END $$;


-- ── Personal notes snippets ───────────────────────────────────────────────────
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 68 - Integumentary III'
      AND note_type = 'personal'
      AND herb_id = (SELECT id FROM herbal.herbs WHERE latin_name = 'Rhus glabra')
  ) THEN
    RAISE NOTICE 'Class 68 personal snippets for new herbs already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, class_name, note_type, section_header, snippet_text, source_block, sort_order)
  VALUES

  -- Sumac — personal: liquifies dried material in bowel
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Rhus glabra'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Musculo Case Study',
   'Sumac — liquifies dried material in the bowel.',
   'sumac - liquifies dried material in the bowel.',
   10),

  -- Jojoba — oilination for skin pH maintenance
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Simmondsia chinensis'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Skin pH and Oilination',
   'Jojoba listed as an oilination herb to help the skin maintain its pH and nourish the tissues.',
   'Oilination helps the skin maintain its pH and nourish the tissues: Calendula infused oilination, Gotu Kola oil, Mugwort added to oils, Rosehip oil, Jojoba.',
   10),

  -- Jojoba — eczema carrier oil
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Simmondsia chinensis'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Eczema',
   'Jojoba listed as a good carrier oil for eczema preparations alongside sesame and olive.',
   'Good carrier oils for eczema: sesame, olive, jojoba.',
   20),

  -- Pine Needles — wound wash antimicrobial
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Pinus spp.'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Wound Care',
   'Pine Needles listed as an antimicrobial herb for wound wash preparations.',
   'Wound Wash Antimicrobial: Mugwort, Chaparral, Myrrh, Goldenseal, Garlic, Honey, Baptisia, Tea tree, Yarrow, Lavender, Pine Needles, Rosemary, Tansy, Coptis, Thyme, Chamomile, Barberry, Cedar, Agarita, Echinacea, Bidens, Oregon Grape, Yerba Mansa, Spilanthes, Neem, Hops, Beebalm.',
   10),

  -- Cedar (= Thuja occidentalis, id 201) — wound wash antimicrobial
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Thuja occidentalis'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Wound Care',
   'Cedar (Thuja) listed as an antimicrobial herb for wound wash preparations.',
   'Wound Wash Antimicrobial: Mugwort, Chaparral, Myrrh, Goldenseal, Garlic, Honey, Baptisia, Tea tree, Yarrow, Lavender, Pine Needles, Rosemary, Tansy, Coptis, Thyme, Chamomile, Barberry, Cedar, Agarita, Echinacea, Bidens, Oregon Grape, Yerba Mansa, Spilanthes, Neem, Hops, Beebalm.',
   10),

  -- Agarita — wound wash antimicrobial
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Berberis trifoliolata'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Wound Care',
   'Agarita listed as an antimicrobial herb for wound wash preparations. Related to Oregon Grape; berberine content provides broad-spectrum antimicrobial action.',
   'Wound Wash Antimicrobial: Cedar, Agarita, Echinacea, Bidens, Oregon Grape, Yerba Mansa, Spilanthes, Neem, Hops, Beebalm.',
   10),

  -- Bidens — wound wash antimicrobial
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Bidens spp.'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Wound Care',
   'Bidens listed as an antimicrobial herb for wound wash preparations. Strong antimicrobial from polyacetylenes; fresh plant preferred.',
   'Wound Wash Antimicrobial: Cedar, Agarita, Echinacea, Bidens, Oregon Grape, Yerba Mansa, Spilanthes, Neem, Hops, Beebalm.',
   10),

  -- Neem — wound wash antimicrobial
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Azadirachta indica'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Wound Care',
   'Neem listed as an antimicrobial herb for wound wash preparations. Broad-spectrum antimicrobial and antifungal for skin infections.',
   'Wound Wash Antimicrobial: Cedar, Agarita, Echinacea, Bidens, Oregon Grape, Yerba Mansa, Spilanthes, Neem, Hops, Beebalm.',
   10),

  -- Bee Balm — wound wash antimicrobial
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Monarda fistulosa'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Wound Care',
   'Bee Balm listed as an antimicrobial herb for wound wash preparations. Thymol and carvacrol provide potent broad-spectrum antiseptic activity.',
   'Wound Wash Antimicrobial: Cedar, Agarita, Echinacea, Bidens, Oregon Grape, Yerba Mansa, Spilanthes, Neem, Hops, Beebalm.',
   10),

  -- Maravilla — case study: seeds for joint mobility
  ((SELECT id FROM herbal.herbs WHERE latin_name = 'Mirabilis multiflorum'),
   'BHC - Class 68 - Integumentary III', 'personal',
   'Musculo Case Study',
   'Encourage maravilla seeds — relax joint movement. Lignans throughout life.',
   'Encourage maravilla seeds. Relax joint movement. Lignans throughout life.',
   10);

END $$;


-- ── herb_keywords for newly-added herbs ──────────────────────────────────────
INSERT INTO herbal.herb_keywords (herb_id, keyword, category)
SELECT h.id, kw.keyword, kw.category
FROM herbal.herbs h
JOIN (VALUES
  ('Cymbopogon citratus', 'carminative',      'action'),
  ('Cymbopogon citratus', 'antimicrobial',    'action'),
  ('Cymbopogon citratus', 'antifungal',       'action'),
  ('Cymbopogon citratus', 'digestive health', 'ailment'),
  ('Rhus glabra',         'astringent',       'action'),
  ('Rhus glabra',         'bowel health',     'ailment'),
  ('Rhus glabra',         'styptic',          'action'),
  ('Azadirachta indica',  'antimicrobial',    'action'),
  ('Azadirachta indica',  'antifungal',       'action'),
  ('Azadirachta indica',  'skin infection',   'ailment'),
  ('Monarda fistulosa',   'antimicrobial',    'action'),
  ('Monarda fistulosa',   'carminative',      'action'),
  ('Monarda fistulosa',   'antifungal',       'action'),
  ('Bidens spp.',         'antimicrobial',    'action'),
  ('Bidens spp.',         'immunostimulant',  'action'),
  ('Bidens spp.',         'lymphatic',        'action'),
  ('Simmondsia chinensis','emollient',        'action'),
  ('Simmondsia chinensis','carrier oil',      'general'),
  ('Simmondsia chinensis','topical',          'general'),
  ('Berberis trifoliolata','antimicrobial',   'action'),
  ('Berberis trifoliolata','bitter',          'action'),
  ('Berberis trifoliolata','wound wash',      'general'),
  ('Pinus spp.',          'antimicrobial',    'action'),
  ('Pinus spp.',          'expectorant',      'action'),
  ('Pinus spp.',          'wound wash',       'general'),
  ('Mirabilis multiflorum','antifungal',      'action'),
  ('Mirabilis multiflorum','antirheumatic',   'action'),
  ('Mirabilis multiflorum','joint mobility',  'ailment')
) AS kw(latin_name, keyword, category) ON h.latin_name = kw.latin_name
ON CONFLICT (herb_id, keyword) DO NOTHING;
