-- Migration 314: Class 34 – Skin 2 and AMAB Repro System
-- Files parsed:
--   BHC - Class 34 - Skin 2 and AMAB Repro System - Lisa Ashley.md (note_type = 'personal')
--   No Generated Notes file exists for this class.
--
-- Herb normalizations applied:
--   "Vitex"                  → Chasteberry (Vitex agnus-castus, id=190)
--   "Eleuthero"              → Siberian Ginseng (Eleutherococcus senticosus, id=9)
--   "OGR" / "Oregon Grape Root" → Oregon Grape (Mahonia aquifolium, id=33)
--   "nettle root"            → Nettle root (Urtica dioica, root, id=1649)
--   "nettles"                → Nettle (Urtica dioica, leaf, id=43)
--   "Goji berry"             → Wolfberry Fruit (Fructus Lycii Chinensis, id=1548)
--   "Fo Ti"                  → Fo Ti (Polygonum multiflorum, root, id=2625)
--   "Processed/Prepared Rehmannia" → Prepared Rehmannia Root (Cooked Radix Rehmanniae, id=1614)
--   "Ceanothus"              → Red Root (Ceanothus americanus, id=981)
--
-- Herbs skipped (not in DB):
--   Madrone (Arbutus menziesii) – added in migration 316 (run 316 after this to link class 34 snippets)
--   Horny Goat Weed (Epimedium spp.) – not in DB
--   Bentonite Clay, Honey – not herbal medicines
--
-- Keyword merge decisions:
--   "wound care" → existing "wound healing"
--   "slow healing wounds" → existing "wound healing"
--   "skin eruptions" → existing "skin conditions"
--   "vitality" → existing "energy support"
--   "allergic tendencies / allergies expressed through skin" → new keyword "allergies"
--     (distinct from existing "hay fever" which is seasonal/respiratory)
--   "scar tissue" → new symptom keyword
--   "bee sting" → skipped; covered by "wound healing" and "first aid" context
--   "atopic dermatitis" → synonym for new keyword "eczema"

SET search_path TO herbal, public;

-- =====================================================================
-- SNIPPETS
-- =====================================================================
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 34 - Skin 2 and AMAB Repro System') THEN
    RAISE NOTICE 'Class 34 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ---- Wound Care ----
  (109, 'Rosemary: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 10,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  (82, 'Lavender: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 20,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  (70, 'Calendula: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 30,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  (84, 'Chamomile: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 40,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  (850, 'Rose petals: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 50,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  (56, 'Sage: wound wash herb — Astringent, Antimicrobial, Vulnerary.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 60,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  (85, 'Plantain: specific for bee stings (not clay).',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Wound Care', 70,
   'Wound Wash herbs: (Astringent, Antimicrobial, Vulnerary)
- Rosemary
- Lavender
- Calendula
- Chamomile
- Rose petals
- Sage

Food grade Bentonite Clay
- reason - we want closed wounds to drain without having to lance
- when using regular water to hydrate clay, in a sealed container - won''t rot
- want it to stay moist, wrap in Cohesive bandage or Tegaderm
- don''t press it, want the clay to maintain its volume above the infection
- if when removed, pus is removed, move on to the Wound Wash strategy
- wet wipe everything, then wound wash

Bee sting = Plantain, not necessarily clay
Honey = necrotized tissue and burns'),

  -- ---- Alteratives for Skin ----
  (22, 'Burdock: alterative for skin conditions — used Internally for Blood and Kidneys; root is prebiotic.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 80,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (33, 'Oregon Grape Root: alterative for skin conditions — Topical and Internally — liver, gut, blood.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 90,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (24, 'Fringetree: alterative for skin conditions — used Internally for the gallbladder.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 100,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (28, 'Cleavers: alterative for skin conditions — Topically and Internally — lymph.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 110,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (26, 'Echinacea: alterative for skin conditions — Topically and Internally — lymph and blood.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 120,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (39, 'Figwort: alterative for skin conditions — used Internally for kidneys.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 130,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (40, 'Sarsaparilla: alterative for skin conditions — used Internally for liver.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 140,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (37, 'Yellow Dock: alterative for skin conditions — Topical and Internally — GI and liver.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 150,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  (42, 'Red Clover: alterative for skin conditions — used Internally for lymph.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Alteratives for Skin', 160,
   'Alteratives for Skin Conditions
- Burdock - Internally - Blood and Kidneys, root is prebiotic
- Oregon Grape Root - Topical and Internally - liver, gut, blood
- Fringe tree - Internally - gallbladder
- Cleavers - Topically and Internally - lymph
- Echinacea - Topically and Internally - lymph and blood
- Figwort - Internally - kidneys
- Sarsaparilla - Internally - liver
- Yellow Dock - Topical and Internally - GI and liver
- Red Clover - Internally - lymph

- open the organs of elimination
- pick from the above based on other organs they may be having issues with
- Lisa: we all need alteratives in an urban environment'),

  -- ---- Acne ----
  (40, 'Sarsaparilla: liver support for acne — indicated when the liver is stressed from hormone processing.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 170,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  (37, 'Yellow Dock: liver support for acne — indicated when the liver is stressed from hormone processing.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 180,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  (33, 'Oregon Grape Root: liver support for acne — indicated when the liver is stressed from hormone processing.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 190,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  (190, 'Chasteberry (Vitex): hormone balancing for acne — calms circulating androgens.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 200,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  (186, 'Saw Palmetto: hormone balancing for acne — calms circulating androgens.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 210,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  (1649, 'Nettle root: hormone balancing for acne — calms circulating androgens.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 220,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  (70, 'Calendula: vulnerary for acne — specifically indicated to reduce scar tissue.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Acne', 230,
   'Disorder: Acne
- hypersensitivity of the sebaceous glands, often hormonal response to circulating androgens
- sebaceous sweat glands become vulnerable to the resident microbes on the skin
- causes: food triggers (refined sugars, dairy), stress, some skin products, some medications, insulin resistance
- maybe a liver picture, if the liver is stressed from hormone processing
    - alterative and liver support: Sarsaparilla, Yellow Dock, Oregon Grape Root
- testosterone stimulates sweat more profusely than estrogen
- can migrate to the hair follicles — more extreme situations require deeper treatment
- Herbal actions for Acne:
    - alterative
    - hormone balancing — calm the androgens: Vitex, Saw Palmetto, Nettle root
    - antimicrobial
    - vulnerary — to reduce scar tissue — specifically Calendula'),

  -- ---- Saw Palmetto ----
  (186, 'Saw Palmetto (Serenoa repens): Fresh 1:2, Dry 1:5 80%, Dose: 30–90 drops up to 3x/day.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Saw Palmetto', 240,
   'Saw Palmetto
- Serenoa repens
- Parts used: berries
- Fresh 1:2
- Dry 1:5 80%
- Dose: 30-90 drops up to 3x / day'),

  -- ---- Hibiscus ----
  (2233, 'Hibiscus: stimulates reepithelization in wounds — knits tissues; good for acne in skin wash; stimulates hyaluronan production to help skin hold hydration.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Hibiscus', 250,
   'Hibiscus
- stimulates reepithelization in wounds — knit tissues
- good for acne in skin wash
- stimulate hyaluronan production — skin to hold hydration'),

  -- ---- Rashes and Itching ----
  (153, 'Oak: astringent for contact dermatitis / poison oak — dries out and inactivates the oils.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Rashes and Itching', 260,
   'Rashes and Itching
- in response to allergens or irritants
- contact dermatitis — caused by external contact
    - any sudsing saponin will remove poison oak from the skin
    - in the moment, don''t touch anything else with that affected part
    - Oak, Madrone, Manzanita — astringency will dry out and inactivate the oils
        - tinctures: Manzanita, Madrone, Ceanothus — spray on the spot
- atopic dermatitis — happening inside the body
    - want to tonify and dry these pustules, so they don''t spread
- squamous layer can get deranged, leading to excessive loss of fluids
    - stay hydrated
    - tonify the tight junctions
- herbal actions: astringent, alterative, liver support, anti-inflammatory, antihistamine, anodyne, antioxidant'),

  (1253, 'Manzanita: astringent tincture sprayed on contact dermatitis / poison oak to dry out and inactivate the oils.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Rashes and Itching', 270,
   'Rashes and Itching
- in response to allergens or irritants
- contact dermatitis — caused by external contact
    - any sudsing saponin will remove poison oak from the skin
    - in the moment, don''t touch anything else with that affected part
    - Oak, Madrone, Manzanita — astringency will dry out and inactivate the oils
        - tinctures: Manzanita, Madrone, Ceanothus — spray on the spot
- atopic dermatitis — happening inside the body
    - want to tonify and dry these pustules, so they don''t spread
- squamous layer can get deranged, leading to excessive loss of fluids
    - stay hydrated
    - tonify the tight junctions
- herbal actions: astringent, alterative, liver support, anti-inflammatory, antihistamine, anodyne, antioxidant'),

  (981, 'Red Root (Ceanothus): astringent tincture sprayed on contact dermatitis / poison oak to dry out and inactivate the oils.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Rashes and Itching', 280,
   'Rashes and Itching
- in response to allergens or irritants
- contact dermatitis — caused by external contact
    - any sudsing saponin will remove poison oak from the skin
    - in the moment, don''t touch anything else with that affected part
    - Oak, Madrone, Manzanita — astringency will dry out and inactivate the oils
        - tinctures: Manzanita, Madrone, Ceanothus — spray on the spot
- atopic dermatitis — happening inside the body
    - want to tonify and dry these pustules, so they don''t spread
- squamous layer can get deranged, leading to excessive loss of fluids
    - stay hydrated
    - tonify the tight junctions
- herbal actions: astringent, alterative, liver support, anti-inflammatory, antihistamine, anodyne, antioxidant'),

  -- ---- Calendula (standalone) ----
  (70, 'Calendula: supports collagen synthesis below the dermis; improves the protective squamous barrier; use topically and internally; good as an eye wash.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Calendula', 290,
   'Calendula
- supports collagen synthesis, right below the dermis
- eye wash as well
- use topically and internally
- improves the protective squamous barrier'),

  -- ---- Licorice ----
  (78, 'Licorice: anti-inflammatory; indicated for allergic and atopic tendencies, food-triggered skin eruptions, hives in stress or heat, chronic eczema, autoimmune psoriasis, slow healing wounds, viral skin eruptions including herpes (solid extract turns emerging herpes sores around).',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Licorice', 300,
   'Licorice
- anti-inflammatory
- useful for allergic and atopic tendencies
- food triggers
- skin eruptions
- hives in stress or heat
- chronic eczema
- autoimmune: psoriasis
- slow healing wounds
- viral skin eruptions: herpes
    - solid extract turns emerging herpes sores around
- can stimulate a bit of a healing crisis'),

  -- ---- Dermatitis ----
  (70, 'Calendula: in Dermatitis formula — eliminates waste, slows histamine response, reduces mast cell activation. Dose: 1–2 tsp, 3–4x/day during acute phase.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 310,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (78, 'Licorice: in Dermatitis formula — slows histamine response, reduces mast cell activation. Dose: 1–2 tsp, 3–4x/day during acute phase.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 320,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (1009, 'Dong Quai: in Dermatitis formula — eliminates waste, slows histamine response. Dose: 1–2 tsp, 3–4x/day during acute phase.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 330,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (2229, 'Gotu Kola: in Dermatitis formula — eliminates waste, slows histamine response. Dose: 1–2 tsp, 3–4x/day during acute phase.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 340,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (42, 'Red Clover: alterative and blood buffer used alongside Dermatitis formula to support liver and bowel function.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 350,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (43, 'Nettle leaf: alterative and blood buffer used alongside Dermatitis formula to support liver and bowel function.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 360,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (134, 'Lemon Balm: alterative and blood buffer used alongside Dermatitis formula to support liver and bowel function.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 370,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  (885, 'Alfalfa: alterative and blood buffer (minerals) used alongside Dermatitis formula to support liver and bowel function.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dermatitis', 380,
   'Dermatitis formula - EP
- Calendula
- Licorice
- Dong quai
- Gotu kola

- eliminate waste
- slows the histamine response
- reduces mast cell activation
- 1-2 tsp, 3-4 x/day, during the acute phase

- also want to support the liver
- bowel function
- alteratives and blood buffers (minerals):
    - Red Clover
    - Nettles
    - Lemon Balm
    - Alfalfa
- check on thyroid issues'),

  -- ---- Dong Quai (standalone) ----
  (1009, 'Dong Quai (Angelica sinensis, root): used internally to reduce allergic tendencies, particularly chronic dermatitis; induces photosensitivity which can support and nourish psoriasis; specific for allergies expressed through the skin.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Dong Quai', 390,
   'Dong Quai (Angelica sinensis) — root
- used internally to reduce allergic tendencies, particularly chronic dermatitis
- inducing photosensitivity can support and nourish psoriasis
- specific for allergies expressed through the skin'),

  -- ---- Boils ----
  (26, 'Echinacea: antimicrobial for boils — used Internally and Topically; think blood and lymph circulation.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Boils', 400,
   'Disorder: Boils
- when a hair follicle gets invaded by microbes
- often a chronic condition for those with blood stagnancy
- think of blood and lymph circulation
- pus-filled skin lesion = furuncle
- herbal actions: alterative, antimicrobial, lymphagogue
- antimicrobials: Echinacea (Internally and topically), Oregon Grape Root (Internally and topically), Yarrow (Internally and topically)
- could be a decoction wash or tincture on the boil while also treating internally
    - add 2 drops of Poke to maybe 3 dropperfuls of the above tincture'),

  (33, 'Oregon Grape Root: antimicrobial for boils — used Internally and Topically; think blood and lymph circulation.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Boils', 410,
   'Disorder: Boils
- when a hair follicle gets invaded by microbes
- often a chronic condition for those with blood stagnancy
- think of blood and lymph circulation
- pus-filled skin lesion = furuncle
- herbal actions: alterative, antimicrobial, lymphagogue
- antimicrobials: Echinacea (Internally and topically), Oregon Grape Root (Internally and topically), Yarrow (Internally and topically)
- could be a decoction wash or tincture on the boil while also treating internally
    - add 2 drops of Poke to maybe 3 dropperfuls of the above tincture'),

  (44, 'Yarrow: antimicrobial for boils — used Internally and Topically; think blood and lymph circulation.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Boils', 420,
   'Disorder: Boils
- when a hair follicle gets invaded by microbes
- often a chronic condition for those with blood stagnancy
- think of blood and lymph circulation
- pus-filled skin lesion = furuncle
- herbal actions: alterative, antimicrobial, lymphagogue
- antimicrobials: Echinacea (Internally and topically), Oregon Grape Root (Internally and topically), Yarrow (Internally and topically)
- could be a decoction wash or tincture on the boil while also treating internally
    - add 2 drops of Poke to maybe 3 dropperfuls of the above tincture'),

  (35, 'Poke Root: added in small doses (2 drops per 3 dropperfuls of tincture) for internal treatment of boils alongside antimicrobials.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Boils', 430,
   'Disorder: Boils
- when a hair follicle gets invaded by microbes
- often a chronic condition for those with blood stagnancy
- think of blood and lymph circulation
- pus-filled skin lesion = furuncle
- herbal actions: alterative, antimicrobial, lymphagogue
- antimicrobials: Echinacea (Internally and topically), Oregon Grape Root (Internally and topically), Yarrow (Internally and topically)
- could be a decoction wash or tincture on the boil while also treating internally
    - add 2 drops of Poke to maybe 3 dropperfuls of the above tincture'),

  -- ---- Prostate ----
  (144, 'Damiana: indicated for prostate support — relaxing to tissues, grounding, addresses lymph drainage around the prostate.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Prostate', 440,
   '**Prostate: Medicine''s Most Pathologized Pleasure Organ:**
- surrounds the urethra; adds prostatic fluid; contains enzymes for sperm motility
- smooth muscle for rhythmic contraction; sensitive to hormones
- there are lymph areas around it, need stimulation as well to move the lymph
- Herbs: Damiana, Ginger

**Prostate (swollen):**
- located close to the anus
- when swollen, can push on urethra — always need to go, or incomplete voiding, or incontinence
- Herb: Horsetail'),

  (124, 'Ginger: indicated for prostate support — circulatory stimulation and warming; addresses lymph drainage around the prostate.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Prostate', 450,
   '**Prostate: Medicine''s Most Pathologized Pleasure Organ:**
- surrounds the urethra; adds prostatic fluid; contains enzymes for sperm motility
- smooth muscle for rhythmic contraction; sensitive to hormones
- there are lymph areas around it, need stimulation as well to move the lymph
- Herbs: Damiana, Ginger

**Prostate (swollen):**
- located close to the anus
- when swollen, can push on urethra — always need to go, or incomplete voiding, or incontinence
- Herb: Horsetail'),

  (151, 'Horsetail: indicated for urinary incontinence caused by swollen prostate pressing on the urethra.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Prostate', 460,
   '**Prostate: Medicine''s Most Pathologized Pleasure Organ:**
- surrounds the urethra; adds prostatic fluid; contains enzymes for sperm motility
- smooth muscle for rhythmic contraction; sensitive to hormones
- there are lymph areas around it, need stimulation as well to move the lymph
- Herbs: Damiana, Ginger

**Prostate (swollen):**
- located close to the anus
- when swollen, can push on urethra — always need to go, or incomplete voiding, or incontinence
- Herb: Horsetail'),

  -- ---- Jing and Vitality ----
  (2625, 'Fo Ti (Polygonum multiflorum, root): TCM Jing tonic — restores Jing; said to reverse graying hair.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Jing and Vitality', 470,
   'Jing and Vitality (TCM concept)
- Jing = essence / constitutional vitality / reproductive reserve / foundational life substance
- Jing is the body''s deepest material reserve — governs growth, reproduction, aging and regeneration
- everyone is born with a certain amount of Jing; too much ejaculation depletes jing
- very frequent ejaculation over long time periods can reduce vitality, lower immune function, and affect the entire body
- Jing tonics: Processed Rehmannia, Fo Ti, Goji berry, Horny Goat Weed (not in DB), Ashwagandha, Schizandra, Eleuthero
- Prepared Rehmannia tincture: grounding, kidneys, balance blood sugar (unprepared = for Heat in the Blood)
- "Leaky Jing Gate":
    - urinary incontinence, hard to control fluids
    - Schizandra = astringent to the Jing — premature ejaculation, night sweats'),

  (1614, 'Prepared Rehmannia Root: TCM Jing tonic — grounding, supports kidneys, balances blood sugar. (Unprepared Rehmannia is for Heat in the Blood — different application.)',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Jing and Vitality', 480,
   'Jing and Vitality (TCM concept)
- Jing = essence / constitutional vitality / reproductive reserve / foundational life substance
- Jing is the body''s deepest material reserve — governs growth, reproduction, aging and regeneration
- everyone is born with a certain amount of Jing; too much ejaculation depletes jing
- very frequent ejaculation over long time periods can reduce vitality, lower immune function, and affect the entire body
- Jing tonics: Processed Rehmannia, Fo Ti, Goji berry, Horny Goat Weed (not in DB), Ashwagandha, Schizandra, Eleuthero
- Prepared Rehmannia tincture: grounding, kidneys, balance blood sugar (unprepared = for Heat in the Blood)
- "Leaky Jing Gate":
    - urinary incontinence, hard to control fluids
    - Schizandra = astringent to the Jing — premature ejaculation, night sweats'),

  (1548, 'Wolfberry (Goji berry): TCM Jing tonic — reproductive reserve and vitality support.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Jing and Vitality', 490,
   'Jing and Vitality (TCM concept)
- Jing = essence / constitutional vitality / reproductive reserve / foundational life substance
- Jing is the body''s deepest material reserve — governs growth, reproduction, aging and regeneration
- everyone is born with a certain amount of Jing; too much ejaculation depletes jing
- very frequent ejaculation over long time periods can reduce vitality, lower immune function, and affect the entire body
- Jing tonics: Processed Rehmannia, Fo Ti, Goji berry, Horny Goat Weed (not in DB), Ashwagandha, Schizandra, Eleuthero
- Prepared Rehmannia tincture: grounding, kidneys, balance blood sugar (unprepared = for Heat in the Blood)
- "Leaky Jing Gate":
    - urinary incontinence, hard to control fluids
    - Schizandra = astringent to the Jing — premature ejaculation, night sweats'),

  (20, 'Ashwagandha: TCM Jing tonic — reproductive reserve and vitality support.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Jing and Vitality', 500,
   'Jing and Vitality (TCM concept)
- Jing = essence / constitutional vitality / reproductive reserve / foundational life substance
- Jing is the body''s deepest material reserve — governs growth, reproduction, aging and regeneration
- everyone is born with a certain amount of Jing; too much ejaculation depletes jing
- very frequent ejaculation over long time periods can reduce vitality, lower immune function, and affect the entire body
- Jing tonics: Processed Rehmannia, Fo Ti, Goji berry, Horny Goat Weed (not in DB), Ashwagandha, Schizandra, Eleuthero
- Prepared Rehmannia tincture: grounding, kidneys, balance blood sugar (unprepared = for Heat in the Blood)
- "Leaky Jing Gate":
    - urinary incontinence, hard to control fluids
    - Schizandra = astringent to the Jing — premature ejaculation, night sweats'),

  (17, 'Schizandra: TCM Jing tonic — "astringent to the Jing"; specific for premature ejaculation and night sweats ("Leaky Jing Gate").',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Jing and Vitality', 510,
   'Jing and Vitality (TCM concept)
- Jing = essence / constitutional vitality / reproductive reserve / foundational life substance
- Jing is the body''s deepest material reserve — governs growth, reproduction, aging and regeneration
- everyone is born with a certain amount of Jing; too much ejaculation depletes jing
- very frequent ejaculation over long time periods can reduce vitality, lower immune function, and affect the entire body
- Jing tonics: Processed Rehmannia, Fo Ti, Goji berry, Horny Goat Weed (not in DB), Ashwagandha, Schizandra, Eleuthero
- Prepared Rehmannia tincture: grounding, kidneys, balance blood sugar (unprepared = for Heat in the Blood)
- "Leaky Jing Gate":
    - urinary incontinence, hard to control fluids
    - Schizandra = astringent to the Jing — premature ejaculation, night sweats'),

  (9, 'Siberian Ginseng (Eleuthero): TCM Jing tonic — reproductive reserve and vitality support.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'Jing and Vitality', 520,
   'Jing and Vitality (TCM concept)
- Jing = essence / constitutional vitality / reproductive reserve / foundational life substance
- Jing is the body''s deepest material reserve — governs growth, reproduction, aging and regeneration
- everyone is born with a certain amount of Jing; too much ejaculation depletes jing
- very frequent ejaculation over long time periods can reduce vitality, lower immune function, and affect the entire body
- Jing tonics: Processed Rehmannia, Fo Ti, Goji berry, Horny Goat Weed (not in DB), Ashwagandha, Schizandra, Eleuthero
- Prepared Rehmannia tincture: grounding, kidneys, balance blood sugar (unprepared = for Heat in the Blood)
- "Leaky Jing Gate":
    - urinary incontinence, hard to control fluids
    - Schizandra = astringent to the Jing — premature ejaculation, night sweats'),

  -- ---- AMAB Reproductive Support ----
  (180, 'Flax seeds: mucilaginous when exposed to water and heat; decoct 5–10 mins stirring constantly; strain loosely. Shelf life 3–4 days in fridge.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 530,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (144, 'Damiana: tincture option for AMAB reproductive support — relaxing to the tissues, grounding, embodiment.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 540,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (124, 'Ginger: tincture option for AMAB reproductive support — use sparingly for circulatory stimulation and warming.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 550,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (2363, 'Spilanthes: tincture option for AMAB reproductive support — tingling, antifungal and antimicrobial.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 560,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (109, 'Rosemary: tincture option for AMAB reproductive support — circulatory stimulant, for AM use.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 570,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (138, 'Kava: tincture option for AMAB reproductive support — antispasmodic, opening the heart, mild numbing.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 580,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (852, 'Shatavari: tincture option for AMAB reproductive support — moistening to the tissues, over time.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 590,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (70, 'Calendula: optional addition to AMAB reproductive support tincture blends.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 600,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (82, 'Lavender: optional addition to AMAB reproductive support tincture blends.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 610,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (45, 'Marshmallow: optional addition to AMAB reproductive support tincture blends — demulcent/emollient.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 620,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder'),

  (30, 'Goldenseal powder: antimicrobial option for AMAB reproductive support.',
   'BHC - Class 34 - Skin 2 and AMAB Repro System', 'personal', 'AMAB Reproductive Support', 630,
   'AMAB reproductive support — tincture and preparation options (afternoon practical)
Flax seeds — mucilaginous when exposed to water and heat
- Decoction: simmer 5–10 mins, stirring constantly; don''t oversimmer or it becomes solid mucilage
- Strain loosely; 3–4 day shelf life in fridge

Tincture options:
- Damiana — relaxing to the tissues, grounding, embodiment
- Ginger — use sparingly — circulatory stimulation and warming
- Spilanthes — tingling, antifungal and antimicrobial
- Rosemary — circulatory stimulant, AM use
- Kava — antispasmodic, opening the heart, mild numbing
- Shatavari — moistening to the tissues, over time
- Could also use: Calendula, Lavender, Marshmallow
- For antimicrobial: Goldenseal powder');

  RAISE NOTICE 'Class 34 snippets loaded.';
END $$;

-- =====================================================================
-- KEYWORDS
-- =====================================================================

-- Wound Care
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'wound healing', 'ailment'), (109, 'antimicrobial', 'action'), (109, 'astringent', 'action'), (109, 'vulnerary', 'action'),
  (82,  'wound healing', 'ailment'), (82,  'antimicrobial', 'action'), (82,  'astringent', 'action'), (82,  'vulnerary', 'action'),
  (70,  'wound healing', 'ailment'), (70,  'antimicrobial', 'action'), (70,  'astringent', 'action'), (70,  'vulnerary', 'action'),
  (84,  'wound healing', 'ailment'), (84,  'antimicrobial', 'action'), (84,  'astringent', 'action'), (84,  'vulnerary', 'action'),
  (850, 'wound healing', 'ailment'), (850, 'astringent', 'action'),
  (56,  'wound healing', 'ailment'), (56,  'antimicrobial', 'action'), (56,  'astringent', 'action'),
  (85,  'wound healing', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Alteratives for Skin
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (22,  'skin conditions', 'ailment'), (22,  'alterative', 'action'), (22,  'lymphatic support', 'ailment'),
  (33,  'skin conditions', 'ailment'), (33,  'alterative', 'action'), (33,  'liver support', 'ailment'),
  (24,  'skin conditions', 'ailment'), (24,  'alterative', 'action'),
  (28,  'skin conditions', 'ailment'), (28,  'alterative', 'action'), (28,  'lymphatic support', 'ailment'),
  (26,  'skin conditions', 'ailment'), (26,  'alterative', 'action'), (26,  'lymphatic support', 'ailment'),
  (39,  'skin conditions', 'ailment'), (39,  'alterative', 'action'),
  (40,  'skin conditions', 'ailment'), (40,  'alterative', 'action'), (40,  'liver support', 'ailment'),
  (37,  'skin conditions', 'ailment'), (37,  'alterative', 'action'), (37,  'liver support', 'ailment'),
  (42,  'skin conditions', 'ailment'), (42,  'alterative', 'action'), (42,  'lymphatic support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Acne
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (40,   'acne', 'ailment'), (40,   'hormonal support', 'ailment'),
  (37,   'acne', 'ailment'), (37,   'hormonal support', 'ailment'),
  (33,   'acne', 'ailment'),
  (190,  'acne', 'ailment'), (190,  'hormonal support', 'ailment'),
  (186,  'acne', 'ailment'), (186,  'hormonal support', 'ailment'), (186, 'prostate health', 'ailment'), (186, 'BPH', 'ailment'),
  (1649, 'acne', 'ailment'), (1649, 'hormonal support', 'ailment'), (1649, 'prostate health', 'ailment'), (1649, 'BPH', 'ailment'),
  (70,   'acne', 'ailment'), (70,   'scar tissue', 'symptom')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hibiscus
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2233, 'acne', 'ailment'), (2233, 'wound healing', 'ailment'), (2233, 'skin conditions', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Rashes and Itching
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (153,  'rashes', 'ailment'), (153,  'contact dermatitis', 'ailment'), (153,  'astringent', 'action'),
  (1253, 'rashes', 'ailment'), (1253, 'contact dermatitis', 'ailment'), (1253, 'astringent', 'action'),
  (981,  'rashes', 'ailment'), (981,  'contact dermatitis', 'ailment'), (981,  'lymphatic support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula (standalone)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'skin conditions', 'ailment'), (70, 'eczema', 'ailment'), (70, 'vulnerary', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Licorice
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78, 'eczema', 'ailment'), (78, 'hives', 'ailment'), (78, 'psoriasis', 'ailment'),
  (78, 'herpes', 'ailment'), (78, 'allergies', 'ailment'), (78, 'skin conditions', 'ailment'),
  (78, 'wound healing', 'ailment'), (78, 'anti-inflammatory', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dermatitis formula
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70,   'eczema', 'ailment'),
  (78,   'eczema', 'ailment'),
  (1009, 'eczema', 'ailment'), (1009, 'allergies', 'ailment'), (1009, 'psoriasis', 'ailment'), (1009, 'skin conditions', 'ailment'), (1009, 'photosensitivity', 'ailment'),
  (2229, 'eczema', 'ailment'), (2229, 'skin conditions', 'ailment'),
  (42,   'eczema', 'ailment'),
  (43,   'eczema', 'ailment'), (43,  'skin conditions', 'ailment'),
  (134,  'skin conditions', 'ailment'),
  (885,  'skin conditions', 'ailment'), (885, 'mineral support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Boils
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26,  'boils', 'ailment'), (26,  'antimicrobial', 'action'), (26, 'lymphatic support', 'ailment'),
  (33,  'boils', 'ailment'), (33,  'antimicrobial', 'action'),
  (44,  'boils', 'ailment'), (44,  'antimicrobial', 'action'),
  (35,  'boils', 'ailment'), (35,  'lymphatic support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Prostate
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (144, 'prostate health', 'ailment'), (144, 'reproductive support', 'ailment'),
  (124, 'prostate health', 'ailment'), (124, 'circulation', 'ailment'),
  (151, 'urinary incontinence', 'ailment'), (151, 'BPH', 'ailment'), (151, 'prostate health', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Jing and Vitality
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2625, 'reproductive support', 'ailment'), (2625, 'energy support', 'ailment'),
  (1614, 'reproductive support', 'ailment'), (1614, 'energy support', 'ailment'), (1614, 'kidney support', 'ailment'),
  (1548, 'reproductive support', 'ailment'), (1548, 'energy support', 'ailment'),
  (20,   'reproductive support', 'ailment'), (20,   'energy support', 'ailment'),
  (17,   'premature ejaculation', 'ailment'), (17,   'night sweats', 'ailment'), (17,   'urinary incontinence', 'ailment'), (17, 'reproductive support', 'ailment'),
  (9,    'reproductive support', 'ailment'), (9,    'energy support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- AMAB Reproductive Support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (180,  'reproductive support', 'ailment'), (180, 'mucous membrane support', 'ailment'),
  (144,  'reproductive support', 'ailment'),
  (124,  'reproductive support', 'ailment'),
  (2363, 'antimicrobial', 'action'), (2363, 'antifungal', 'action'), (2363, 'reproductive support', 'ailment'),
  (109,  'circulation', 'ailment'), (109,  'reproductive support', 'ailment'),
  (138,  'reproductive support', 'ailment'),
  (852,  'reproductive support', 'ailment'),
  (45,   'reproductive support', 'ailment'),
  (30,   'antimicrobial', 'action'), (30,   'reproductive support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- =====================================================================
-- AILMENT SEARCH SYNONYMS (new keywords introduced by this class)
-- =====================================================================
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('acne',
   ARRAY['pimples', 'breakouts', 'blemishes', 'hormonal acne', 'cystic acne', 'sebaceous gland dysfunction']),
  ('boils',
   ARRAY['furuncle', 'carbuncle', 'skin abscess', 'infected hair follicle', 'suppurative skin infection']),
  ('rashes',
   ARRAY['skin rash', 'dermatitis', 'urticaria', 'skin eruption', 'skin inflammation', 'itchy skin']),
  ('eczema',
   ARRAY['atopic dermatitis', 'atopic eczema', 'chronic eczema', 'infantile eczema', 'weeping eczema', 'dry itchy skin']),
  ('psoriasis',
   ARRAY['plaque psoriasis', 'autoimmune skin condition', 'scaly skin', 'skin plaque', 'psoriatic lesions']),
  ('hives',
   ARRAY['urticaria', 'welts', 'wheals', 'allergic hives', 'stress hives', 'heat hives']),
  ('herpes',
   ARRAY['herpes simplex', 'cold sores', 'fever blisters', 'oral herpes', 'genital herpes', 'viral skin eruption']),
  ('contact dermatitis',
   ARRAY['poison oak', 'poison ivy', 'allergic contact dermatitis', 'irritant contact dermatitis', 'skin reaction to irritant']),
  ('premature ejaculation',
   ARRAY['early ejaculation', 'rapid ejaculation', 'leaky jing gate', 'poor ejaculatory control']),
  ('urinary incontinence',
   ARRAY['bladder leakage', 'loss of bladder control', 'leaky bladder', 'overactive bladder', 'inability to hold urine']),
  ('night sweats',
   ARRAY['nocturnal sweating', 'sweating at night', 'sleep sweats', 'hyperhidrosis at night']),
  ('allergies',
   ARRAY['allergic reaction', 'allergic tendencies', 'systemic allergies', 'food allergies', 'skin allergies', 'hypersensitivity'])
ON CONFLICT (ailment_keyword) DO NOTHING;

