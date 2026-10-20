-- Migration 420: Class 5 - Digestion I — snippets, keywords, ailment search terms
-- Parsed file: BHC - Class 5 - Digestion I - Ashley Claire.md (personal notes)
-- note_type: personal (no Generated Notes file exists for Class 5)
--
-- Normalisations applied:
--   Orange Peel → Sweet Orange (id=748, Citrus sinensis)
--   Schisandra → Schizandra (id=17, Schisandra chinensis)
--   Nettles → Nettle leaf (id=43, Urtica dioica leaf)
--   Oat Straw → Oat straw (id=2287, Avena sativa straw)
--   OGR / Oregon Grape Root → Oregon Grape (id=33, Mahonia aquifolium root)
--   Sarsparilla → Sarsaparilla (id=40, Smilax spp.)
--
-- Skipped (not appropriate to add):
--   Chia seeds — food/seed, playbook exclusion
--   Okra — food, playbook exclusion
--   Honey — preparation material
--   Tobacco — mentioned only as ulcer risk factor, not medicinal herb
--   Vitamin C reference in Rose Hips — describing constituent content, not a separate supplement recommendation
--
-- No herb pairs found meeting criteria (only trios in recipes; no explicit two-herb synergy notes)
--
-- New ailment keywords introduced: acid reflux, indigestion, burnout
-- Merge decisions:
--   "dysbiosis" → microbiome support (existing)
--   "gas/bloating" → bloating (existing)
--   "nervous exhaustion" → synonym under burnout (new)
--   "insomnia" / sleep → sleep support (existing)
--   "blood sugar regulation" → blood sugar dysregulation (existing)

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 5 - Digestion I') THEN
    RAISE NOTICE 'Class 5 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ── Gut-Brain Axis ──────────────────────────────────────────────────────────
  (84,
   'Digestive System/Nervine plants are helpful for gut-brain axis conditions. Chamomile tincture or glycerite — volatile oils are extracted well in both. High dose is 1 tsp at trigger time for almost immediate relief of enteric nervous system triggers.',
   'BHC - Class 5 - Digestion I', 'personal', 'Gut-Brain Axis', 10,
   '### Why do we care about this system?
- Gut brain axis is the interface of NS, Immune system, Endocrine system, Skin
- 90% of body serotonin produced in the gut
- Vagus nerve helps to control the Parasympathetic NS: Rest, Digest, Restore
- Enteric NS is its own thing and can operate without the brain, it controls what we feel
- Digestive System/Nervine plants are helpful here - Chamomile
- Enteric NS has a memory
    - shocking events cause triggers to form
    - Nervine plants can tell our NS that we are ok
    - Chamomile tincture or glycerite (volatile oils are extracted well in glycerite and tincture)
        - high dose is 1 tsp at trigger time, almost immediate relief'),

  -- ── Leaky Gut ───────────────────────────────────────────────────────────────
  (45,
   'Demulcent for leaky gut — soothes and protects gut mucosal lining. Listed alongside flax seeds for gut healing. Full reset and healing may take ~6 months.',
   'BHC - Class 5 - Digestion I', 'personal', 'Leaky Gut', 20,
   '### Stomach (leaky gut section)
- mucosal tissue prevents burning through the stomach tissue
    - leaky gut is when this gets compromised
    - epithelial tissue contains tight junctions; when these lapse, food gets out and immune system responds
    - IBS and certain autoimmune conditions linked to leaky gut
    - the whole body inflames and it never turns off
    - full reset and healing may take ~6 months
- demulcents and astringents would help here
    - chia seeds, okra, marshmallow, flax seeds'),

  (180,
   'Demulcent for leaky gut — listed alongside marshmallow for soothing and protecting gut mucosal lining. Full reset and healing may take ~6 months.',
   'BHC - Class 5 - Digestion I', 'personal', 'Leaky Gut', 30,
   '### Stomach (leaky gut section)
- mucosal tissue prevents burning through the stomach tissue
    - leaky gut is when this gets compromised
    - epithelial tissue contains tight junctions; when these lapse, food gets out and immune system responds
    - IBS and certain autoimmune conditions linked to leaky gut
    - the whole body inflames and it never turns off
    - full reset and healing may take ~6 months
- demulcents and astringents would help here
    - chia seeds, okra, marshmallow, flax seeds'),

  -- ── Peristalsis ─────────────────────────────────────────────────────────────
  (172,
   'Artichoke leaf regulates peristalsis in the small intestine with no unintended side effects elsewhere; amphoteric — slows down or speeds up as needed.',
   'BHC - Class 5 - Digestion I', 'personal', 'Peristalsis', 40,
   '### Small Intestine
- moves through peristalsis
    - artichoke leaf regulates peristalsis in the small intestine, but no unintended side effects elsewhere
        - amphoteric - slows down or speeds up, regulation either way'),

  -- ── GI Bitters ──────────────────────────────────────────────────────────────
  (65,
   'Warming bitter herb for GI support — stimulates digestive secretions including HCL, pancreatic juices, and bile.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Bitters', 50,
   '#### Bitters
- warming: Angelica, Orange Peel
- cooling: Gentian, Wormwood, Dandelion Root, Burdock
Bitter herbs stimulate: production of HCL, pancreatic juices, and bile.'),

  (748,
   'Orange Peel listed as a warming bitter herb for GI support — stimulates digestive secretions.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Bitters', 60,
   '#### Bitters
- warming: Angelica, Orange Peel
- cooling: Gentian, Wormwood, Dandelion Root, Burdock
Bitter herbs stimulate: production of HCL, pancreatic juices, and bile.'),

  (102,
   'Cooling bitter herb for GI support — stimulates digestive secretions including HCL, pancreatic juices, and bile.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Bitters', 70,
   '#### Bitters
- warming: Angelica, Orange Peel
- cooling: Gentian, Wormwood, Dandelion Root, Burdock
Bitter herbs stimulate: production of HCL, pancreatic juices, and bile.'),

  (97,
   'Cooling bitter herb for GI support — stimulates digestive secretions including HCL, pancreatic juices, and bile.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Bitters', 80,
   '#### Bitters
- warming: Angelica, Orange Peel
- cooling: Gentian, Wormwood, Dandelion Root, Burdock
Bitter herbs stimulate: production of HCL, pancreatic juices, and bile.'),

  (122,
   'Cooling bitter herb for GI support — stimulates digestive secretions including HCL, pancreatic juices, and bile.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Bitters', 90,
   '#### Bitters
- warming: Angelica, Orange Peel
- cooling: Gentian, Wormwood, Dandelion Root, Burdock
Bitter herbs stimulate: production of HCL, pancreatic juices, and bile.'),

  (22,
   'Cooling bitter herb for GI support — stimulates digestive secretions including HCL, pancreatic juices, and bile.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Bitters', 100,
   '#### Bitters
- warming: Angelica, Orange Peel
- cooling: Gentian, Wormwood, Dandelion Root, Burdock
Bitter herbs stimulate: production of HCL, pancreatic juices, and bile.'),

  -- ── GI Demulcents ────────────────────────────────────────────────────────────
  (45,
   'GI demulcent — soothes and protects mucous membranes in the digestive tract. When working with the digestive system, alcohol can be irritating; prefer glycerites, honeys, or vinegars.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Demulcents', 110,
   '#### Demulcents
- examples: Marshmallow, Flax, Slippery Elm, Linden (long steep), Chamomile, Chia, Licorice
- when working with the Digestive System, alcohol can be irritating, prefer glycerites, honeys, vinegars'),

  (180,
   'GI demulcent. When working with the digestive system, prefer glycerites, honeys, or vinegars over alcohol.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Demulcents', 120,
   '#### Demulcents
- examples: Marshmallow, Flax, Slippery Elm, Linden (long steep), Chamomile, Chia, Licorice
- when working with the Digestive System, alcohol can be irritating, prefer glycerites, honeys, vinegars'),

  (92,
   'GI demulcent. When working with the digestive system, prefer glycerites, honeys, or vinegars over alcohol.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Demulcents', 130,
   '#### Demulcents
- examples: Marshmallow, Flax, Slippery Elm, Linden (long steep), Chamomile, Chia, Licorice
- when working with the Digestive System, alcohol can be irritating, prefer glycerites, honeys, vinegars'),

  (90,
   'GI demulcent (long steep). When working with the digestive system, prefer glycerites, honeys, or vinegars over alcohol.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Demulcents', 140,
   '#### Demulcents
- examples: Marshmallow, Flax, Slippery Elm, Linden (long steep), Chamomile, Chia, Licorice
- when working with the Digestive System, alcohol can be irritating, prefer glycerites, honeys, vinegars'),

  (84,
   'GI demulcent. When working with the digestive system, prefer glycerites, honeys, or vinegars over alcohol.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Demulcents', 150,
   '#### Demulcents
- examples: Marshmallow, Flax, Slippery Elm, Linden (long steep), Chamomile, Chia, Licorice
- when working with the Digestive System, alcohol can be irritating, prefer glycerites, honeys, vinegars'),

  (78,
   'GI demulcent. When working with the digestive system, prefer glycerites, honeys, or vinegars over alcohol.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Demulcents', 160,
   '#### Demulcents
- examples: Marshmallow, Flax, Slippery Elm, Linden (long steep), Chamomile, Chia, Licorice
- when working with the Digestive System, alcohol can be irritating, prefer glycerites, honeys, vinegars'),

  -- ── GI Carminatives ──────────────────────────────────────────────────────────
  (76,
   'GI carminative rich in volatile oils; good taken after a meal for gas and digestive discomfort.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Carminatives', 170,
   '#### Carminatives
- rich in volatile oils; good for after a meal
- examples: Fennel, Lemon Balm (nervine too), Chamomile (nervine too), Peppermint, Lavender (nervine too), Fenugreek'),

  (134,
   'GI carminative rich in volatile oils, also a nervine; good taken after a meal.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Carminatives', 180,
   '#### Carminatives
- rich in volatile oils; good for after a meal
- examples: Fennel, Lemon Balm (nervine too), Chamomile (nervine too), Peppermint, Lavender (nervine too), Fenugreek'),

  (84,
   'GI carminative rich in volatile oils, also a nervine; good taken after a meal.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Carminatives', 190,
   '#### Carminatives
- rich in volatile oils; good for after a meal
- examples: Fennel, Lemon Balm (nervine too), Chamomile (nervine too), Peppermint, Lavender (nervine too), Fenugreek'),

  (55,
   'GI carminative rich in volatile oils; good taken after a meal for gas and digestive discomfort.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Carminatives', 200,
   '#### Carminatives
- rich in volatile oils; good for after a meal
- examples: Fennel, Lemon Balm (nervine too), Chamomile (nervine too), Peppermint, Lavender (nervine too), Fenugreek'),

  (82,
   'GI carminative rich in volatile oils, also a nervine; good taken after a meal.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Carminatives', 210,
   '#### Carminatives
- rich in volatile oils; good for after a meal
- examples: Fennel, Lemon Balm (nervine too), Chamomile (nervine too), Peppermint, Lavender (nervine too), Fenugreek'),

  (91,
   'GI carminative rich in volatile oils; good taken after a meal for gas and digestive discomfort.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Carminatives', 220,
   '#### Carminatives
- rich in volatile oils; good for after a meal
- examples: Fennel, Lemon Balm (nervine too), Chamomile (nervine too), Peppermint, Lavender (nervine too), Fenugreek'),

  -- ── GI Astringents ───────────────────────────────────────────────────────────
  (85,
   'GI astringent that tones and tightens tissue; indicated for diarrhea. Specifically noted as a great gut healing tea for leaky gut.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Astringents', 230,
   '#### Astringents
- tone and tighten tissue; indicated for diarrhea
- Plantain - great gut healing tea, leaky gut
- Yarrow - also slightly bitter, good, and antimicrobial
- Calendula - also amazing wound healing and astringent, rich in resin
- Blackberry Root - best for diarrhea, food poisoning in the woods; temp acute, then move into elimination herbs
- Cinnamon'),

  (44,
   'GI astringent for diarrhea; also slightly bitter and antimicrobial.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Astringents', 240,
   '#### Astringents
- tone and tighten tissue; indicated for diarrhea
- Plantain - great gut healing tea, leaky gut
- Yarrow - also slightly bitter, good, and antimicrobial
- Calendula - also amazing wound healing and astringent, rich in resin
- Blackberry Root - best for diarrhea, food poisoning in the woods; temp acute, then move into elimination herbs
- Cinnamon'),

  (70,
   'GI astringent for diarrhea; also wound healing, rich in resin.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Astringents', 250,
   '#### Astringents
- tone and tighten tissue; indicated for diarrhea
- Plantain - great gut healing tea, leaky gut
- Yarrow - also slightly bitter, good, and antimicrobial
- Calendula - also amazing wound healing and astringent, rich in resin
- Blackberry Root - best for diarrhea, food poisoning in the woods; temp acute, then move into elimination herbs
- Cinnamon'),

  (156,
   'Blackberry Root — best GI astringent for acute diarrhea and food poisoning; use temporarily for the acute phase, then transition to elimination herbs.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Astringents', 260,
   '#### Astringents
- tone and tighten tissue; indicated for diarrhea
- Plantain - great gut healing tea, leaky gut
- Yarrow - also slightly bitter, good, and antimicrobial
- Calendula - also amazing wound healing and astringent, rich in resin
- Blackberry Root - best for diarrhea, food poisoning in the woods; temp acute, then move into elimination herbs
- Cinnamon'),

  (167,
   'GI astringent that tones and tightens tissue; indicated for diarrhea.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Astringents', 270,
   '#### Astringents
- tone and tighten tissue; indicated for diarrhea
- Plantain - great gut healing tea, leaky gut
- Yarrow - also slightly bitter, good, and antimicrobial
- Calendula - also amazing wound healing and astringent, rich in resin
- Blackberry Root - best for diarrhea, food poisoning in the woods; temp acute, then move into elimination herbs
- Cinnamon'),

  -- ── GI Antispasmodics ────────────────────────────────────────────────────────
  (74,
   'GI antispasmodic; specifically good for stomach cramping.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Antispasmodics', 280,
   '#### Antispasmodics
- Wild Yam - good for stomach cramping
- Cramp Bark
- Skullcap
- Chamomile - superstar of the GI system
    - Chamomile, Lavender, and Yarrow are 3 general GI superstars'),

  (93,
   'GI antispasmodic for cramping and spasm.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Antispasmodics', 290,
   '#### Antispasmodics
- Wild Yam - good for stomach cramping
- Cramp Bark
- Skullcap
- Chamomile - superstar of the GI system
    - Chamomile, Lavender, and Yarrow are 3 general GI superstars'),

  (142,
   'GI antispasmodic for cramping and spasm.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Antispasmodics', 300,
   '#### Antispasmodics
- Wild Yam - good for stomach cramping
- Cramp Bark
- Skullcap
- Chamomile - superstar of the GI system
    - Chamomile, Lavender, and Yarrow are 3 general GI superstars'),

  (84,
   'Chamomile called "superstar of the GI system" — antispasmodic for cramping. Chamomile, Lavender, and Yarrow are 3 general GI superstars.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Antispasmodics', 310,
   '#### Antispasmodics
- Wild Yam - good for stomach cramping
- Cramp Bark
- Skullcap
- Chamomile - superstar of the GI system
    - Chamomile, Lavender, and Yarrow are 3 general GI superstars'),

  -- ── GI Alteratives ───────────────────────────────────────────────────────────
  (40,
   'GI alterative; specifically indicated for leaky gut and food allergies.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Alteratives', 320,
   '#### Alteratives
- Sarsaparilla - leaky gut, food allergies
- Burdock
- Red Clover
- Dandelion Root
- Yellow Dock - also an aperient for stool softening
- Turmeric also'),

  (22,
   'GI alterative — supports the body''s natural detox and elimination processes.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Alteratives', 330,
   '#### Alteratives
- Sarsaparilla - leaky gut, food allergies
- Burdock
- Red Clover
- Dandelion Root
- Yellow Dock - also an aperient for stool softening
- Turmeric also'),

  (42,
   'GI alterative — supports the body''s natural detox and elimination processes.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Alteratives', 340,
   '#### Alteratives
- Sarsaparilla - leaky gut, food allergies
- Burdock
- Red Clover
- Dandelion Root
- Yellow Dock - also an aperient for stool softening
- Turmeric also'),

  (122,
   'GI alterative — supports the body''s natural detox and elimination processes.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Alteratives', 350,
   '#### Alteratives
- Sarsaparilla - leaky gut, food allergies
- Burdock
- Red Clover
- Dandelion Root
- Yellow Dock - also an aperient for stool softening
- Turmeric also'),

  (37,
   'GI alterative; also an aperient for stool softening.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Alteratives', 360,
   '#### Alteratives
- Sarsaparilla - leaky gut, food allergies
- Burdock
- Red Clover
- Dandelion Root
- Yellow Dock - also an aperient for stool softening
- Turmeric also'),

  (203,
   'GI alterative — supports the body''s natural detox and elimination processes.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Alteratives', 370,
   '#### Alteratives
- Sarsaparilla - leaky gut, food allergies
- Burdock
- Red Clover
- Dandelion Root
- Yellow Dock - also an aperient for stool softening
- Turmeric also'),

  -- ── GI Nutritives ────────────────────────────────────────────────────────────
  (43,
   'GI nutritive; best extracted in water or vinegar over long periods. Spagyric process reincorporates minerals otherwise lost in alcohol extraction.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Nutritives', 380,
   '#### Nutritives
- extract in water or vinegar, over long periods of time
- spagyric reincorporates minerals back into the formula (gives you minerals in tincture form; otherwise alcohol wouldn''t extract)
- Examples: Nettle, Horsetail, Alfalfa, Oat Straw'),

  (151,
   'GI nutritive; best extracted in water or vinegar over long periods. Spagyric process reincorporates minerals otherwise lost in alcohol extraction.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Nutritives', 390,
   '#### Nutritives
- extract in water or vinegar, over long periods of time
- spagyric reincorporates minerals back into the formula (gives you minerals in tincture form; otherwise alcohol wouldn''t extract)
- Examples: Nettle, Horsetail, Alfalfa, Oat Straw'),

  (885,
   'GI nutritive; best extracted in water or vinegar over long periods.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Nutritives', 400,
   '#### Nutritives
- extract in water or vinegar, over long periods of time
- spagyric reincorporates minerals back into the formula (gives you minerals in tincture form; otherwise alcohol wouldn''t extract)
- Examples: Nettle, Horsetail, Alfalfa, Oat Straw'),

  (2287,
   'GI nutritive (oat straw); best extracted in water or vinegar over long periods.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Nutritives', 410,
   '#### Nutritives
- extract in water or vinegar, over long periods of time
- spagyric reincorporates minerals back into the formula (gives you minerals in tincture form; otherwise alcohol wouldn''t extract)
- Examples: Nettle, Horsetail, Alfalfa, Oat Straw'),

  -- ── GI Anti-Inflammatories ───────────────────────────────────────────────────
  (75,
   'GI anti-inflammatory.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Anti-Inflammatories', 420,
   '#### GI Anti-inflammatories
- Meadowsweet
- Cat''s Claw - powerful for GI
- Chamomile
- Kudzu Root
- Licorice'),

  (2646,
   'GI anti-inflammatory — described as powerful for GI conditions.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Anti-Inflammatories', 430,
   '#### GI Anti-inflammatories
- Meadowsweet
- Cat''s Claw - powerful for GI
- Chamomile
- Kudzu Root
- Licorice'),

  (84,
   'GI anti-inflammatory.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Anti-Inflammatories', 440,
   '#### GI Anti-inflammatories
- Meadowsweet
- Cat''s Claw - powerful for GI
- Chamomile
- Kudzu Root
- Licorice'),

  (1547,
   'GI anti-inflammatory.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Anti-Inflammatories', 450,
   '#### GI Anti-inflammatories
- Meadowsweet
- Cat''s Claw - powerful for GI
- Chamomile
- Kudzu Root
- Licorice'),

  (78,
   'GI anti-inflammatory.',
   'BHC - Class 5 - Digestion I', 'personal', 'GI Anti-Inflammatories', 460,
   '#### GI Anti-inflammatories
- Meadowsweet
- Cat''s Claw - powerful for GI
- Chamomile
- Kudzu Root
- Licorice'),

  -- ── Bitters Tasting ──────────────────────────────────────────────────────────
  (122,
   'Bitters tasting: Dandelion Root — slightly sweet, LEAST bitter.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 470,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (22,
   'Bitters tasting: Burdock — LEAST bitter. High in inulin, a fiber that feeds gut bacteria (prebiotic).',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 480,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (84,
   'Bitters tasting: Chamomile — LEAST bitter.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 490,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (983,
   'Bitters tasting: Blue Vervain — MEDIUM bitter. Works on the upper third of the body; releases tension; calms thoughts like water surface.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 500,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (44,
   'Bitters tasting: Yarrow — MEDIUM bitter. Strong volatile oil; both bitter and carminative.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 510,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (172,
   'Bitters tasting: Artichoke Leaf — MEDIUM bitter. Very green and verdant; peristalsis stimulated from fresh plant tincture.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 520,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (33,
   'Bitters tasting: Oregon Grape Root — MEDIUM bitter. Bright yellow — contains Berberine; anti-fungal, antimicrobial, blood sugar regulation.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 530,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (65,
   'Bitters tasting: Angelica — MEDIUM bitter, warming. Sinuses cleared during tasting.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 540,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (115,
   'Bitters tasting: Mugwort — MEDIUM bitter. Both carminative and bitter.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 550,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (102,
   'Bitters tasting: Gentian — MOST bitter. Main ingredient in Campari and Aperol; now overharvested; cooling bitter.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 560,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (97,
   'Bitters tasting: Wormwood — MOST bitter. Antiparasitic.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 570,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (2629,
   'Bitters tasting: Andrographis — MOST bitter. Called the "king of bitters." Also recommended for active infection (vs Astragalus which should not be taken during active infection).',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 580,
   '## Bitters Tasting
Dandelion Root - slightly sweet - LEAST
Burdock - LEAST
    - high in inulin - fiber that feeds the gut bacteria - probiotic
Chamomile - LEAST
Blue Vervain - MEDIUM
    - upper third of body - release tension
    - calm thoughts like water surface
Yarrow - MEDIUM
    - strong volatile oil - bitter + carminative
Artichoke Leaf - MEDIUM
    - very green and verdant
    - peristalsis from fresh plant tincture
Oregon Grape Root - MEDIUM
    - bright yellow - Berberine - anti-fungal, antimicrobial, Blood sugar regulation
Angelica - MEDIUM
    - warming bitter
    - sinuses cleared
Mugwort - MEDIUM
    - both carminative and bitter
Gentian - MOST
    - main ingredient in Campari, Aperol
    - now overharvested
    - cooling
Wormwood - MOST
    - antiparasitic
Andrographis - MOST
    - "king of bitters"
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (124,
   'If nauseous from bitters, use carminatives: Ginger, Lemon Balm, or Catnip.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 590,
   '## Bitters Tasting
...
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (134,
   'If nauseous from bitters, use carminatives: Ginger, Lemon Balm, or Catnip.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 600,
   '## Bitters Tasting
...
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  (136,
   'If nauseous from bitters, use carminatives: Ginger, Lemon Balm, or Catnip.',
   'BHC - Class 5 - Digestion I', 'personal', 'Bitters Tasting', 610,
   '## Bitters Tasting
...
-> if nauseous from bitters, do carminatives!
    Ginger
    Lemon Balm
    Catnip'),

  -- ── Decoction Preparation ────────────────────────────────────────────────────
  (84,
   'Chamomile — a washcloth soaked in hot-to-cold infusion can be applied over the face. Also considered for dry eyes.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 620,
   '## Decoctions and Syrups
- chamomile - washcloth soaked in hot to cold infusion over face; drops in eyes? for dry eye?
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (124,
   'Volatile oils in Ginger, Fennel, and Cardamom are not ideal for standard decoction — cover the pot to retain volatile oils.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 630,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (76,
   'Volatile oils in Fennel (along with Ginger and Cardamom) are not ideal for standard decoction — cover the pot to retain volatile oils.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 640,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (127,
   'Volatile oils in Cardamom (along with Ginger and Fennel) are not ideal for standard decoction — cover the pot to retain volatile oils.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 650,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (2231,
   'Resins in Grindelia (along with Yerba Santa, Frankincense, and Myrrh) don''t extract well in water; decoction not appropriate for resin extraction.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 660,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (590,
   'Resins in Yerba Santa (along with Grindelia, Frankincense, and Myrrh) don''t extract well in water; decoction not appropriate for resin extraction.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 670,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (1597,
   'Frankincense resin doesn''t extract well in water; decoction not appropriate when resin is the medicine sought.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 680,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (99,
   'Myrrh resin doesn''t extract well in water; decoction not appropriate when resin is the medicine sought.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 690,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- volatile oils, unless covered: Ginger, Fennel, Cardamom
- resins, they don''t extract well in water: Grindelia, Yerba Santa, frankincense, myrrh
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (45,
   'Mucilage in Marshmallow is damaged by heat; decoction not appropriate when mucilage is the medicine sought. Use cold or room-temperature infusion for mucilage extraction.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 700,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (92,
   'Mucilage in Slippery Elm is damaged by heat; decoction not appropriate when mucilage is the medicine sought.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 710,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  (2233,
   'Hibiscus mucilage is damaged by heat; however, Hibiscus IS good in decoction if you are not after the mucilage.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Preparation', 720,
   '## Decoctions and Syrups
### Decoction not best for plants with:
- mucilage (damaged with heat): Marshmallow, Slippery Elm, Hibiscus
    - Hibiscus is good in decoction, if you are not after the mucilage'),

  -- ── Individual Decocted Herbs ────────────────────────────────────────────────
  (1651,
   'Antiviral: inhibits spread of many viral infections including flu. Alterative: supports body''s natural mechanisms of detox and elimination. Deeply revered in folklore. Always dry berries before using.',
   'BHC - Class 5 - Digestion I', 'personal', 'Elderberries', 730,
   '#### Elderberries - Sambucus nigra
- Antiviral: Inhibit the spread of many viral infections (flu)
- Alterative: Supports the body''s natural mechanisms of detox and elimination
- so much folklore, deeply revered, magical plant
    - Hans Christian Andersen; the realm beyond us, fae realm
- always dry berries before using'),

  (849,
   'Anti-inflammatory (cooling), very high in Vit C, antioxidant. Astringent + demulcent to the digestive system (similar to Plantain). Pleasure medicine — shifts mood for a few seconds. Powerful clearer of lactic acid — good for gym-goers; use as strong decoction or tincture. Dose: 1/2–6 droppers full (very safe). Deseed before use.',
   'BHC - Class 5 - Digestion I', 'personal', 'Rose Hips', 740,
   '#### Rose Hips - Rosa spp.
- Anti-inflammatory (cooling)
- Very high in Vit C
- Antioxidants shield tissues from oxidative stress
- Astringent + Demulcent to the digestive system
    - similar to Plantain in this way
- Pleasure medicine - shifts your mood for a few seconds
- not quite a nervine, but shifts your mood for a few seconds
- pick when ripe, not green, but not shriveled or rotten
- must deseed them first; late fall, early winter; split open, scoop out with thumb
- dose: 1/2-6 droppers full - very safe
- good for gym-goers - powerful clearer of lactic acid; strong decoction or tincture'),

  (73,
   'CV tonic: strengthens vasculature, lowers blood pressure, helpful for arrhythmia and atherosclerosis. Grief support and matters of the heart.',
   'BHC - Class 5 - Digestion I', 'personal', 'Hawthorn Berries', 750,
   '#### Hawthorn Berries - Crataegus monogyna
- CV tonic: strengthens the vasculature, lowers blood pressure, helpful for arrhythmia, atherosclerosis and more
- Grief support, matters of the heart
- none of the mild mischievousness of Elder, but all of the heart support'),

  (11,
   'Calming adaptogen especially for burnout and nervous exhaustion ("tired but wired"). Modulates the immune system. Helpful for insomnia and nightmares long-term (shen disturbance in TCM). Balances blood sugar and androgen hormones.',
   'BHC - Class 5 - Digestion I', 'personal', 'Reishi', 760,
   '#### Reishi - Ganoderma lucidum
- adaptogen (calming) especially for burnout, nervous exhaustion - tired but wired
- modulates the immune system
- helpful for insomnia and nightmares (longer term)
    - shen disturbance in TCM
- balance blood sugar and androgen hormones'),

  (22,
   'Bitter — stimulates digestive secretions; helpful for indigestion and constipation. Enhances liver detox pathways (clearing excess hormones, cellular waste). Supports many skin conditions.',
   'BHC - Class 5 - Digestion I', 'personal', 'Burdock Root', 770,
   '#### Burdock Root - Arctium lappa
- bitter - stimulates digestive secretions (helpful for indigestion, constipation)
- enhances detox pathways in the liver (clearing excess hormones, cellular waste)
- can support many skin conditions'),

  (124,
   'Powerful anti-inflammatory and anti-viral (especially when fresh). Emmenagogue — stimulates delayed menstruation and eases cramps. Carminative — wonderful for nausea and bloating. Diaphoretic — strong ginger decoction added to bath to sweat out illness. Ginger glycerite specifically recommended for nausea.',
   'BHC - Class 5 - Digestion I', 'personal', 'Ginger', 780,
   '#### Ginger - Zingiber off.
- powerful anti-inflammatory
- anti-viral, esp when fresh
- emmenagogue - stim. delayed menstruation, eases cramps
- carminative - wonderful for nausea and bloating
- diaphoretic
    - strong ginger decoction, pour into your bath - sweat out the bug, and you won''t get sick
- Ginger glycerite for nausea'),

  (54,
   'Soothes coughs; anti-microbial. Warming and drying for damp or cold respiratory conditions. Full of inulin — prebiotic digestive support. Bitter. Amphoteric for lung energetics (damp/dry). Gentle expectorant.',
   'BHC - Class 5 - Digestion I', 'personal', 'Elecampane Root', 790,
   '#### Elecampane root - Inula helenium
- soothes coughs
- anti-microbial
- warming and drying - for "damp" or cold respiratory conditions
- full of inulin - prebiotic digestive support
- bitter
- for lung energetics: damp, dry - doesn''t push you in a wrong direction
- gentle expectorant'),

  (17,
   'Called the "5 flavor berry" (sour, sweet, bitter + more). Mildly stimulating adaptogen — mind-pumping, enhances focus and cognitive function. Hepatic: liver protective and regenerative, restores liver after alcohol damage. Lung tonic.',
   'BHC - Class 5 - Digestion I', 'personal', 'Schizandra Berries', 800,
   '#### Schisandra Berries - Schisandra chinensis
- "5 flavor berry" - sour, sweet, bitter, ...
- Adaptogen - mildly stimulating
    - mind-pumping, helps you focus
- Hepatic (liver protective and regenerative)
    - restores liver after alcohol damage
- Enhances focus + cognitive function
- Lung tonic'),

  (852,
   'Described as the feminine counterpart to Ashwagandha. Nourishing, very yin, restorative calming adaptogen. Deeply moistening. Reproductive and fertility tonic, hormone balancing. Aphrodisiac. Traditional preparations combine with fat.',
   'BHC - Class 5 - Digestion I', 'personal', 'Shatavari', 810,
   '#### Shatavari - Asparagus racemosus
- feminine version of Ashwagandha (strengthening yang herb)
- nourishing very yin herb, restorative
- calming adaptogen
- deeply moistening
- reproductive/fertility tonic, hormone balancing
- aphrodisiac
- trad preps combine with fat'),

  (225,
   'Immuno-modulating. Deeply restorative and building after prolonged high-stress. Sweet and moistening. Tonic to lungs and kidneys. Safety note: do NOT take during active infection — pushes the bug deeper. Only take daily when out of infection; use Andrographis for active infection instead.',
   'BHC - Class 5 - Digestion I', 'personal', 'Astragalus', 820,
   '#### Astragalus - Astragalus membranaceus
- immuno-modulating
- after a prolonged high-stress, deeply restorative + building
- sweet and moistening
- tonic to lungs and kidneys
- don''t take after active infection - pushed the bug deeper
    - Andrographis is for active infection
- only take every day out of infection'),

  (37,
   'Bitter, gentle aperient, rich in iron (nutritive), alterative.',
   'BHC - Class 5 - Digestion I', 'personal', 'Yellow Dock', 830,
   '#### Yellow dock - Rumex crispus
- Bitter
- gentle aperient
- rich in iron - nutritive
- alterative'),

  -- ── Decoction Recipes ────────────────────────────────────────────────────────
  (76,
   'Digestion decoction recipe (to 32 oz water): 14g Fennel, 28g Yellow Dock, 28g Elecampane. Add 10-15% tincture for extra medicine and preservation.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 840,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (37,
   'Digestion decoction recipe (to 32 oz water): 14g Fennel, 28g Yellow Dock, 28g Elecampane.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 850,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (54,
   'Digestion decoction recipe (to 32 oz water): 14g Fennel, 28g Yellow Dock, 28g Elecampane.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 860,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (73,
   'Heart decoction recipe (to 32 oz water): 28g Hawthorn berries, 28g Rose Hips, 14g Cinnamon.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 870,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (849,
   'Heart decoction recipe (to 32 oz water): 28g Hawthorn berries, 28g Rose Hips, 14g Cinnamon.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 880,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (167,
   'Heart decoction recipe (to 32 oz water): 28g Hawthorn berries, 28g Rose Hips, 14g Cinnamon.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 890,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (1651,
   'Immune decoction recipe (to 32 oz water): 28g Elderberries, 28g Astragalus, 14g Ginger.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 900,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (225,
   'Immune decoction recipe (to 32 oz water): 28g Elderberries, 28g Astragalus, 14g Ginger.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 910,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality'),

  (124,
   'Immune decoction recipe (to 32 oz water): 28g Elderberries, 28g Astragalus, 14g Ginger.',
   'BHC - Class 5 - Digestion I', 'personal', 'Decoction Recipes', 920,
   '3 Recipes (to 32 oz water):
Digestion: 14g fennel, 28g yellow dock, 28g elecampane
Heart: 28g Hawthorn berries, 28g rose hips, 14g cinnamon
Immune: 28g elderberries, 28g astragalus, 14g ginger
- tip - add 10-15% some kind of tincture to the syrup for extra medicine and preservation quality');

END $$;

-- ── Keywords ────────────────────────────────────────────────────────────────────
-- Ailment keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Chamomile (84)
  (84, 'digestive health', 'ailment'),
  (84, 'nausea', 'ailment'),
  (84, 'bloating', 'ailment'),
  (84, 'gut inflammation', 'ailment'),
  (84, 'leaky gut', 'ailment'),
  (84, 'IBS', 'ailment'),
  (84, 'nervous system support', 'ailment'),
  (84, 'nervous', 'action'),
  (84, 'demulcent', 'action'),
  (84, 'carminative', 'action'),
  (84, 'antispasmodic', 'action'),
  (84, 'anti-inflammatory', 'action'),
  -- Marshmallow (45)
  (45, 'leaky gut', 'ailment'),
  (45, 'gut inflammation', 'ailment'),
  (45, 'IBS', 'ailment'),
  (45, 'demulcent', 'action'),
  -- Flax (180)
  (180, 'leaky gut', 'ailment'),
  (180, 'gut inflammation', 'ailment'),
  (180, 'constipation', 'ailment'),
  (180, 'demulcent', 'action'),
  -- Artichoke (172)
  (172, 'digestive health', 'ailment'),
  (172, 'indigestion', 'ailment'),
  (172, 'constipation', 'ailment'),
  (172, 'bitter tonic', 'action'),
  (172, 'carminative', 'action'),
  -- Angelica (65)
  (65, 'digestive health', 'ailment'),
  (65, 'indigestion', 'ailment'),
  (65, 'bitter tonic', 'action'),
  -- Sweet Orange (748)
  (748, 'digestive health', 'ailment'),
  (748, 'indigestion', 'ailment'),
  (748, 'bitter tonic', 'action'),
  -- Gentian (102)
  (102, 'digestive health', 'ailment'),
  (102, 'indigestion', 'ailment'),
  (102, 'hypochlorhydria', 'ailment'),
  (102, 'bitter tonic', 'action'),
  -- Wormwood (97)
  (97, 'digestive health', 'ailment'),
  (97, 'indigestion', 'ailment'),
  (97, 'antiparasitic', 'action'),
  (97, 'bitter tonic', 'action'),
  -- Dandelion root (122)
  (122, 'digestive health', 'ailment'),
  (122, 'liver support', 'ailment'),
  (122, 'constipation', 'ailment'),
  (122, 'indigestion', 'ailment'),
  (122, 'bitter tonic', 'action'),
  (122, 'alterative', 'action'),
  -- Burdock (22)
  (22, 'digestive health', 'ailment'),
  (22, 'indigestion', 'ailment'),
  (22, 'constipation', 'ailment'),
  (22, 'liver support', 'ailment'),
  (22, 'skin conditions', 'ailment'),
  (22, 'microbiome support', 'ailment'),
  (22, 'bitter tonic', 'action'),
  (22, 'alterative', 'action'),
  -- Slippery Elm (92)
  (92, 'leaky gut', 'ailment'),
  (92, 'gut inflammation', 'ailment'),
  (92, 'IBS', 'ailment'),
  (92, 'demulcent', 'action'),
  -- Linden (90)
  (90, 'digestive health', 'ailment'),
  (90, 'demulcent', 'action'),
  -- Licorice (78)
  (78, 'gut inflammation', 'ailment'),
  (78, 'leaky gut', 'ailment'),
  (78, 'peptic ulcer', 'ailment'),
  (78, 'demulcent', 'action'),
  (78, 'anti-inflammatory', 'action'),
  -- Fennel (76)
  (76, 'bloating', 'ailment'),
  (76, 'nausea', 'ailment'),
  (76, 'indigestion', 'ailment'),
  (76, 'digestive health', 'ailment'),
  (76, 'carminative', 'action'),
  -- Lemon Balm (134)
  (134, 'bloating', 'ailment'),
  (134, 'nausea', 'ailment'),
  (134, 'digestive health', 'ailment'),
  (134, 'nervous system support', 'ailment'),
  (134, 'carminative', 'action'),
  (134, 'nervine', 'action'),
  -- Peppermint (55)
  (55, 'bloating', 'ailment'),
  (55, 'nausea', 'ailment'),
  (55, 'indigestion', 'ailment'),
  (55, 'digestive health', 'ailment'),
  (55, 'carminative', 'action'),
  -- Lavender (82)
  (82, 'bloating', 'ailment'),
  (82, 'digestive health', 'ailment'),
  (82, 'carminative', 'action'),
  (82, 'nervine', 'action'),
  -- Fenugreek (91)
  (91, 'bloating', 'ailment'),
  (91, 'digestive health', 'ailment'),
  (91, 'carminative', 'action'),
  -- Plantain (85)
  (85, 'diarrhea', 'ailment'),
  (85, 'leaky gut', 'ailment'),
  (85, 'gut inflammation', 'ailment'),
  (85, 'wound healing', 'ailment'),
  (85, 'astringent', 'action'),
  -- Yarrow (44)
  (44, 'diarrhea', 'ailment'),
  (44, 'gut inflammation', 'ailment'),
  (44, 'bitter tonic', 'action'),
  (44, 'astringent', 'action'),
  (44, 'antimicrobial', 'action'),
  (44, 'carminative', 'action'),
  -- Calendula (70)
  (70, 'diarrhea', 'ailment'),
  (70, 'gut inflammation', 'ailment'),
  (70, 'wound healing', 'ailment'),
  (70, 'astringent', 'action'),
  -- Blackberry (156)
  (156, 'diarrhea', 'ailment'),
  (156, 'food poisoning', 'ailment'),
  (156, 'astringent', 'action'),
  -- Cinnamon (167)
  (167, 'diarrhea', 'ailment'),
  (167, 'digestive health', 'ailment'),
  (167, 'cardiovascular disease', 'ailment'),
  (167, 'astringent', 'action'),
  -- Wild Yam (74)
  (74, 'muscle spasms', 'ailment'),
  (74, 'digestive health', 'ailment'),
  (74, 'dysmenorrhea', 'ailment'),
  (74, 'antispasmodic', 'action'),
  -- Cramp Bark (93)
  (93, 'muscle spasms', 'ailment'),
  (93, 'digestive health', 'ailment'),
  (93, 'antispasmodic', 'action'),
  -- Skullcap (142)
  (142, 'muscle spasms', 'ailment'),
  (142, 'digestive health', 'ailment'),
  (142, 'antispasmodic', 'action'),
  -- Sarsaparilla (40)
  (40, 'leaky gut', 'ailment'),
  (40, 'food sensitivities', 'ailment'),
  (40, 'alterative', 'action'),
  -- Red Clover (42)
  (42, 'digestive health', 'ailment'),
  (42, 'alterative', 'action'),
  -- Yellow Dock (37)
  (37, 'constipation', 'ailment'),
  (37, 'digestive health', 'ailment'),
  (37, 'liver support', 'ailment'),
  (37, 'anemia', 'ailment'),
  (37, 'bitter tonic', 'action'),
  (37, 'alterative', 'action'),
  (37, 'aperient', 'action'),
  -- Turmeric (203)
  (203, 'gut inflammation', 'ailment'),
  (203, 'liver support', 'ailment'),
  (203, 'digestive health', 'ailment'),
  (203, 'anti-inflammatory', 'action'),
  (203, 'alterative', 'action'),
  -- Nettle leaf (43)
  (43, 'mineral support', 'ailment'),
  (43, 'nutritive', 'action'),
  -- Horsetail (151)
  (151, 'mineral support', 'ailment'),
  (151, 'bone density', 'ailment'),
  (151, 'nutritive', 'action'),
  -- Alfalfa (885)
  (885, 'mineral support', 'ailment'),
  (885, 'nutritive', 'action'),
  -- Oat straw (2287)
  (2287, 'mineral support', 'ailment'),
  (2287, 'nervous system support', 'ailment'),
  (2287, 'nutritive', 'action'),
  -- Meadowsweet (75)
  (75, 'gut inflammation', 'ailment'),
  (75, 'peptic ulcer', 'ailment'),
  (75, 'acid reflux', 'ailment'),
  (75, 'anti-inflammatory', 'action'),
  -- Cat's Claw (2646)
  (2646, 'gut inflammation', 'ailment'),
  (2646, 'leaky gut', 'ailment'),
  (2646, 'anti-inflammatory', 'action'),
  -- Kudzu Root (1547)
  (1547, 'gut inflammation', 'ailment'),
  (1547, 'digestive health', 'ailment'),
  (1547, 'anti-inflammatory', 'action'),
  -- Blue Vervain (983)
  (983, 'nervous system support', 'ailment'),
  (983, 'stress', 'ailment'),
  (983, 'digestive health', 'ailment'),
  (983, 'bitter tonic', 'action'),
  (983, 'nervine', 'action'),
  -- Oregon Grape (33)
  (33, 'digestive health', 'ailment'),
  (33, 'fungal infection', 'ailment'),
  (33, 'blood sugar dysregulation', 'ailment'),
  (33, 'antimicrobial', 'action'),
  (33, 'bitter tonic', 'action'),
  -- Mugwort (115)
  (115, 'digestive health', 'ailment'),
  (115, 'bloating', 'ailment'),
  (115, 'bitter tonic', 'action'),
  (115, 'carminative', 'action'),
  -- Andrographis (2629)
  (2629, 'acute illness', 'ailment'),
  (2629, 'influenza', 'ailment'),
  (2629, 'digestive health', 'ailment'),
  (2629, 'bitter tonic', 'action'),
  (2629, 'antimicrobial', 'action'),
  -- Ginger (124)
  (124, 'nausea', 'ailment'),
  (124, 'bloating', 'ailment'),
  (124, 'dysmenorrhea', 'ailment'),
  (124, 'fever', 'ailment'),
  (124, 'acute illness', 'ailment'),
  (124, 'anti-inflammatory', 'action'),
  (124, 'carminative', 'action'),
  (124, 'emmenagogue', 'action'),
  (124, 'diaphoretic', 'action'),
  (124, 'antiviral', 'action'),
  -- Catnip (136)
  (136, 'nausea', 'ailment'),
  (136, 'digestive health', 'ailment'),
  (136, 'carminative', 'action'),
  -- Elder berry (1651)
  (1651, 'influenza', 'ailment'),
  (1651, 'acute illness', 'ailment'),
  (1651, 'immune support', 'ailment'),
  (1651, 'antiviral', 'action'),
  (1651, 'alterative', 'action'),
  -- Rose hips (849)
  (849, 'inflammation', 'ailment'),
  (849, 'digestive health', 'ailment'),
  (849, 'antioxidant', 'action'),
  (849, 'anti-inflammatory', 'action'),
  (849, 'astringent', 'action'),
  (849, 'demulcent', 'action'),
  -- Hawthorn berry (73)
  (73, 'cardiovascular disease', 'ailment'),
  (73, 'hypertension', 'ailment'),
  (73, 'arrhythmia', 'ailment'),
  -- Reishi Mushroom (11)
  (11, 'burnout', 'ailment'),
  (11, 'sleep support', 'ailment'),
  (11, 'blood sugar dysregulation', 'ailment'),
  (11, 'immune support', 'ailment'),
  (11, 'shen disturbance', 'ailment'),
  (11, 'adaptogen', 'action'),
  -- Elecampane (54)
  (54, 'cough', 'ailment'),
  (54, 'respiratory congestion', 'ailment'),
  (54, 'microbiome support', 'ailment'),
  (54, 'digestive health', 'ailment'),
  (54, 'expectorant', 'action'),
  (54, 'antimicrobial', 'action'),
  (54, 'bitter tonic', 'action'),
  -- Schizandra (17)
  (17, 'liver support', 'ailment'),
  (17, 'cognitive support', 'ailment'),
  (17, 'fatigue', 'ailment'),
  (17, 'adaptogen', 'action'),
  (17, 'hepatic', 'action'),
  -- Shatavari (852)
  (852, 'fertility support', 'ailment'),
  (852, 'hormonal support', 'ailment'),
  (852, 'reproductive support', 'ailment'),
  (852, 'low libido', 'ailment'),
  (852, 'adaptogen', 'action'),
  -- Astragalus (225)
  (225, 'immune support', 'ailment'),
  (225, 'fatigue', 'ailment'),
  (225, 'adrenal fatigue', 'ailment'),
  (225, 'adaptogen', 'action'),
  -- Grindelia (2231)
  (2231, 'respiratory congestion', 'ailment'),
  (2231, 'asthma', 'ailment'),
  -- Hibiscus (2233)
  (2233, 'hypertension', 'ailment'),
  (2233, 'digestive health', 'ailment'),
  -- Cardamom (127)
  (127, 'digestive health', 'ailment'),
  (127, 'bloating', 'ailment'),
  (127, 'carminative', 'action'),
  -- Frankincense (1597)
  (1597, 'inflammation', 'ailment'),
  (1597, 'anti-inflammatory', 'action'),
  -- Myrrh (99)
  (99, 'wound healing', 'ailment'),
  (99, 'antimicrobial', 'action'),
  -- Yerba Santa (590)
  (590, 'respiratory congestion', 'ailment'),
  (590, 'expectorant', 'action'),
  -- Sarsaparilla (40) — additional
  (40, 'skin conditions', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ── New ailment keywords (with search synonyms) ──────────────────────────────
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('acid reflux',  ARRAY['GERD', 'gastroesophageal reflux', 'heartburn', 'reflux', 'esophageal reflux', 'acid indigestion']),
  ('indigestion',  ARRAY['dyspepsia', 'upset stomach', 'poor digestion', 'digestive upset', 'stomach discomfort', 'functional dyspepsia']),
  ('burnout',      ARRAY['nervous exhaustion', 'adrenal burnout', 'chronic exhaustion', 'tired but wired', 'overwork exhaustion'])
ON CONFLICT (ailment_keyword) DO NOTHING;
