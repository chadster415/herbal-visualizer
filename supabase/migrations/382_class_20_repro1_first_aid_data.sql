-- Migration 382: BHC Class 20 — Reproductive System 1 and Herbal First Aid
-- Files parsed:
--   BHC - Class 20 - Reproductive System 1 and Herbal First Aid - Lisa Rose.md (personal, note_type='personal')
--   No generated notes file exists for this class.
--
-- Normalizations applied:
--   Vitex → Chasteberry (id=190)
--   Nettles → Nettle leaf (id=43)
--   Red Raspberry Leaf → Raspberry leaf (id=155)
--   OGR / Oregon Grape Root → Oregon Grape (id=33)
--   SJW → St. John's Wort (id=81)
--   Uva ursi → Bearberry (id=46)
--   Ma huang/ephedra → Ma Huang (id=448)
--   Pulsatilla → Pasqueflower (id=36)
--   Geranium → Cranesbill (id=52)
--   Pine → Pine Needles (id=2643)
--   AI → anti-inflammatory
--   AS → Antispasmodic
--
-- Skipped (not in DB or not appropriate to add):
--   Ghost Pipe — medicinal plant not yet in herb DB
--   Propolis — bee resin product, not in herb DB
--   Bentonite Clay — mineral clay, not an herb
--   Charcoal — not an herb
--   Sweet Woodruff — mentioned only as May Wine ingredient, not medicinal context
--   Rescue Remedy — flower essence blend, not a single herb
--   Marsh (necrosis) — ambiguous identifier in notes, insufficient info to resolve
--   Raw honey, grapeseed/almond oil — food preparations
--   Castor oil — mentioned for anatomical guasha context only
--
-- Keyword merge decisions:
--   "atonic uterus" → uterine tonic (existing)
--   "wound infection" → skin infection (existing)
--   "allergic reactions" → allergies (existing)
--   "follicular support" → fertility support (existing)
--   "menorrhagia" → heavy bleeding (existing)
--
-- New ailment keywords: shock, tick bites, poison oak
-- New symptom keywords: neck pain
-- New ailment_search_terms rows: shock, tick bites, poison oak

SET search_path TO herbal, public;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 20 - Reproductive System 1 and Herbal First Aid') THEN
    RAISE NOTICE 'Class 20 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- ── CINNAMON ───────────────────────────────────────────────────────────────
    (167,
     'Cinnamon as a reproductive tonic: adaptogenic for uterine tissues, nourishing and moistening, tonifying and astringent, hemostatic to calm heavy bleeding, warming to the circulatory process in the uterus. Ceylon cinnamon (Cinn. verum) preferred for medicinal effects. Ellingwood: "decoction for post-partum depression. Atonic conditions, for someone who has not given birth. General flaccid state after delivery."',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cinnamon', 10,
     '### Cinnamon
- reproductive tonic herbs
- adaptogenic for these tissues
- can be both nourishing and moistening
- tonifying and astringent
- hemostatic - calm heavy bleeding
- warming to the circulatory process in the uterus
- Cassia - not true cinnamon - in the market - a bark - very hard
    - Coumarin levels mean don''t take in a long term way, esp with liver issues ("anyone in a city")
- Ceylon - what you really want to get the medicinal effects - more like paper, can crack it by hand
    Cinn. verum
- Eclectics:
    - Ellingwood: "decoction for post-partum depression. Atonic conditions, for someone who has not given birth. General flaccid state after delivery"'),

    (1083,
     'Cassia cinnamon (Cinnamomum aromaticum) — the common market cinnamon, identifiable by its very hard bark. High coumarin levels mean avoid long-term use, especially for those with liver issues. Prefer Ceylon (Cinnamomum verum) for medicinal use.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cinnamon', 20,
     '### Cinnamon
- reproductive tonic herbs
- adaptogenic for these tissues
- can be both nourishing and moistening
- tonifying and astringent
- hemostatic - calm heavy bleeding
- warming to the circulatory process in the uterus
- Cassia - not true cinnamon - in the market - a bark - very hard
    - Coumarin levels mean don''t take in a long term way, esp with liver issues ("anyone in a city")
- Ceylon - what you really want to get the medicinal effects - more like paper, can crack it by hand
    Cinn. verum
- Eclectics:
    - Ellingwood: "decoction for post-partum depression. Atonic conditions, for someone who has not given birth. General flaccid state after delivery"'),

    -- ── MENSTRUAL CYCLE / TRACKING CYCLES ─────────────────────────────────────
    (1009,
     'Dong Quai for follicular support when cycles are shorter than normal. For pregnancy attempts: use first 2 weeks after cycle start to stimulate nourishment to reproductive tissue, then transition to Vitex for weeks 3–4. "Dong Quai stimulates nourishment to the reproductive tissue."',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Cycle', 30,
     '### Tracking cycles
- can be an insight into when you need more support during the cycle
- notice disruptions when values outside of the normal ranges
- are we nourishing the follicular cycle or the luteal cycle?
    - shorter cycle, or shorter in between cycles: follicular support
        - Dong Quai - herb called for
    - longer cycle, or longer in between cycles: luteal support
        - nourish the brains signaling
        - Vitex - herb called for
        - you start to see fewer cycles per year
            - PCOS to watch out for
            - metabolic issue
- therapy for pregnancy attempts:
    - Dong Quai for first 2 weeks after cycle was judged to start, then Vitex for second 2 weeks
        - even if the cycle is every 2 months, start to lay down the foundation for a normal one
        - also work with nutrition for those phases
            - Estrogen and Progesterone are built from cholesterol
                - need good lipids, proteins
    - Dong Quai stimulates nourishment to the reproductive tissue
    - Vitex nourishes the Parasympathetic NS, relaxing
        - form depends on the person
        - flavors very intense, so tincture gets it down quicker, rather than tea'),

    (190,
     'Chasteberry (Vitex) for luteal support when cycles are longer than normal or cycles become fewer per year (PCOS pattern). Use weeks 3–4 for pregnancy attempts. "Vitex nourishes the Parasympathetic NS, relaxing." Tincture preferred over tea due to intense flavor.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Cycle', 40,
     '### Tracking cycles
- can be an insight into when you need more support during the cycle
- notice disruptions when values outside of the normal ranges
- are we nourishing the follicular cycle or the luteal cycle?
    - shorter cycle, or shorter in between cycles: follicular support
        - Dong Quai - herb called for
    - longer cycle, or longer in between cycles: luteal support
        - nourish the brains signaling
        - Vitex - herb called for
        - you start to see fewer cycles per year
            - PCOS to watch out for
            - metabolic issue
- therapy for pregnancy attempts:
    - Dong Quai for first 2 weeks after cycle was judged to start, then Vitex for second 2 weeks
        - even if the cycle is every 2 months, start to lay down the foundation for a normal one
        - also work with nutrition for those phases
            - Estrogen and Progesterone are built from cholesterol
                - need good lipids, proteins
    - Dong Quai stimulates nourishment to the reproductive tissue
    - Vitex nourishes the Parasympathetic NS, relaxing
        - form depends on the person
        - flavors very intense, so tincture gets it down quicker, rather than tea'),

    -- ── HERBAL ALLIES FOR MENSTRUAL HEALTH ────────────────────────────────────
    (124,
     'Ginger: great circulatory stimulant and heater for menstrual health. Addresses circulatory, digestive, and life stagnation — "stirs the pot with heat."',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 50,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    (131,
     'Motherwort: supportive to circulatory, thyroid, and nervous system function. Use in relation to the menstrual cycle, heat, anger, and inflammation — described as a "big bear hug." Complex thyroid interactions covered next class.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 60,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    (43,
     'Nettles: high in protein (only if consumed), iron, vitamins and minerals. Support for anemia and heavy bleeding; hemostatic.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 70,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    (155,
     'Red Raspberry Leaf: tonification, astringent, nutrient. For fibroids causing heavy bleeding — reduces tonic contractions of the uterus; hemostatic when capillaries won''t close down. Also used when uterus hasn''t returned to pre-pregnancy tone after multiple pregnancies.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 80,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    (44,
     'Yarrow: reproductive tonic — hemostatic, circulatory stimulant, to support repro function. Also bitter (digestion), antimicrobial, diaphoretic. For heavy bleeding: blend with nettles and raspberry 2 weeks prior to menses to nourish uterine structures first; takes a few cycles.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 90,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    (122,
     'Dandelion Root: about the liver — the liver produces hormones and metabolizes/detoxes excess hormones. Stacking reproductive symptoms indicates focusing on the liver first.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 100,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    (1248,
     'Ocotillo: specific lymphatic formula for the lower abdomen and extremities. For sedentary individuals; encourages venous return and poor leg circulation. Commit for 3–4 months to shift established body patterns.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Menstrual Health', 110,
     '### Herbal Allies for Menstrual Health
- Ginger
    - great circulatory stimulant and heater
    - circulatory, digestive stagnation, life stagnation -> stirs the pot with heat
- Motherwort
    - supportive to circulatory and thyroid function, NS function
    - use this in relation to the MC, heat, anger, inflammation
    - big bear hug
    - complex thyroid interactions (next class)
- Nettles
    - high in protein (only if consumed), iron, vitamins and minerals
    - support for anemia, heavy bleeding
    - hemostatic
- Red Raspberry Leaf
    - tonification, astringent, nutrient
    - use for someone who has had fibroids causing heavy bleeding, reducing the tonic contractions of the uterus
    - capillaries won''t close down, this hemostatic helps
    - also, in the case of mult pregnancies back to back, uterus couldn''t get back to pre-pregnancy tone
    - cinnamon also
- Yarrow
    - tonic to repro -> hemostatic, circ stim as well, to support repro function
    - bitter for digestion
    - antimicrobial
    - diaphoretic
    - for heavy bleeding as part of a blend with nettles and rasp, 2 weeks prior to menses, to nourish the uterine structures first
    - takes a few cycles
- Dandelion Root
    - about the liver
        - produces the hormones, and metabolizes and detoxes from excess hormones
        - stacking symptoms indicates the liver to focus on first
- (Ocotillo specific lymphatic formula for lower abdomen and extremities)
    - maybe for sedentary indivs
    - encourage venous return, for those with poor leg circulation
    - commit to it for 3-4 months
    - need to shift patterns the body has gotten into, give it new patterns'),

    -- ── BITES, STINGS, AND SPLINTERS ──────────────────────────────────────────
    (44,
     'Yarrow for bites, stings, and splinters: anti-inflammatory, astringent, antimicrobial. Used as salve (only after area is cleaned), compress, tincture, or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Bites, Stings, and Splinters', 120,
     '### Bites Stings and Splinters
- symptoms: inflamed, red skin, itchy, swollen, stiff skin (bites)
- actions: anti-inflammatory, astringent, antimicrobial, antiviral, antifungal, antibacterial
- herbs: Yarrow, Plantain, Bentonite Clay
- preps: salve (only if area is cleaned before, so no chance of infection), compress, tincture, or liniment'),

    (85,
     'Plantain for bites, stings, and splinters: anti-inflammatory, astringent, antimicrobial. Preparations: salve, compress, tincture, or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Bites, Stings, and Splinters', 130,
     '### Bites Stings and Splinters
- symptoms: inflamed, red skin, itchy, swollen, stiff skin (bites)
- actions: anti-inflammatory, astringent, antimicrobial, antiviral, antifungal, antibacterial
- herbs: Yarrow, Plantain, Bentonite Clay
- preps: salve (only if area is cleaned before, so no chance of infection), compress, tincture, or liniment'),

    -- ── BURNS ─────────────────────────────────────────────────────────────────
    (44,
     'Yarrow for burns: anti-inflammatory, demulcent, emollient actions.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Burns', 140,
     '### Burns
- Symptoms: skin is hot, sensitive to the touch, blistered, oozing
- actions: AI, demulcent, emollient
- herbs: Yarrow, Calendula, Aloe vera or Prickly Pear cactus, SJW, raw honey, lavender EO (diluted for sunburn)
    - light oil like grapeseed, almond oil if no nut allergy'),

    (70,
     'Calendula for burns: anti-inflammatory, demulcent, emollient. Used alongside yarrow, aloe, St. John''s wort.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Burns', 150,
     '### Burns
- Symptoms: skin is hot, sensitive to the touch, blistered, oozing
- actions: AI, demulcent, emollient
- herbs: Yarrow, Calendula, Aloe vera or Prickly Pear cactus, SJW, raw honey, lavender EO (diluted for sunburn)
    - light oil like grapeseed, almond oil if no nut allergy'),

    (202,
     'Aloe vera for burns: demulcent, emollient, anti-inflammatory. Can substitute Prickly Pear cactus.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Burns', 160,
     '### Burns
- Symptoms: skin is hot, sensitive to the touch, blistered, oozing
- actions: AI, demulcent, emollient
- herbs: Yarrow, Calendula, Aloe vera or Prickly Pear cactus, SJW, raw honey, lavender EO (diluted for sunburn)
    - light oil like grapeseed, almond oil if no nut allergy'),

    (2748,
     'Prickly Pear cactus for burns: demulcent, emollient — listed as an alternative to Aloe vera.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Burns', 170,
     '### Burns
- Symptoms: skin is hot, sensitive to the touch, blistered, oozing
- actions: AI, demulcent, emollient
- herbs: Yarrow, Calendula, Aloe vera or Prickly Pear cactus, SJW, raw honey, lavender EO (diluted for sunburn)
    - light oil like grapeseed, almond oil if no nut allergy'),

    (81,
     'St. John''s Wort for burns: anti-inflammatory, demulcent. Applied topically.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Burns', 180,
     '### Burns
- Symptoms: skin is hot, sensitive to the touch, blistered, oozing
- actions: AI, demulcent, emollient
- herbs: Yarrow, Calendula, Aloe vera or Prickly Pear cactus, SJW, raw honey, lavender EO (diluted for sunburn)
    - light oil like grapeseed, almond oil if no nut allergy'),

    (82,
     'Lavender EO for burns: diluted in a light oil (grapeseed, almond) for sunburn specifically. Anti-inflammatory, emollient.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Burns', 190,
     '### Burns
- Symptoms: skin is hot, sensitive to the touch, blistered, oozing
- actions: AI, demulcent, emollient
- herbs: Yarrow, Calendula, Aloe vera or Prickly Pear cactus, SJW, raw honey, lavender EO (diluted for sunburn)
    - light oil like grapeseed, almond oil if no nut allergy'),

    -- ── CUTS AND WOUNDS ───────────────────────────────────────────────────────
    (70,
     'Calendula for cuts, scrapes, and open wounds: vulnerary, antimicrobial, anti-inflammatory. Used as tincture, poultice, compress, or salve (salves better for minor cuts; wounds that need to dry out should not be kept moist).',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 200,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (26,
     'Echinacea (external) for cuts and open wounds: antimicrobial, vulnerary, immune-stimulant.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 210,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (33,
     'Oregon Grape Root for cuts and open wounds: antimicrobial (berberine), anti-inflammatory. Applied externally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 220,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (32,
     'Chaparral for cuts and open wounds: antimicrobial, antifungal. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 230,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (112,
     'Usnea for cuts and open wounds: antimicrobial, antifungal. Applied externally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 240,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (99,
     'Myrrh for cuts and open wounds: antimicrobial, astringent, vulnerary. Applied externally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 250,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (2643,
     'Pine for cuts and open wounds: antimicrobial. Applied externally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 260,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (89,
     'Comfrey for cuts and open wounds — "herbal stitches, proliferates cell regeneration." Use a separate Comfrey + Helichrysum salve for skin healing only, after antimicrobial treatment is complete.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 270,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (82,
     'Lavender EO for minor open wounds: vulnerary. Applied topically after cleaning.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 280,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (831,
     'Helichrysum in a Comfrey + Helichrysum salve for skin healing only — used after the antimicrobial treatment phase is complete.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 290,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    (47,
     'Cayenne for profuse bleeding from cuts: styptic action — mentioned alongside yarrow for bleeding profusely.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Cuts and Wounds', 300,
     '### Cuts, scrapes, open wounds
- symptoms: bleeding, oozing, dirty
- actions: styptic, antimicrobial, vulnerary, anti-fungal, AI, bleeding profusely (yarrow, cayenne pepper)
- herbs: calendula, echinacea (ext), oregon grape root, chaparral, usnea, myrrh, pine, comfrey (herbal stitches, proliferates cell regeneration)
- Lavender EO for minor open wounds
- Preparations: tincture, poultice, compress, salves (better for minor cuts and scrapes. You want some wounds to dry out - and salves keep them moist)
- separate Comfrey + helichrysem salve for skin healing only (after the antimicrobial treatment)'),

    -- ── WOUND INFECTIONS ──────────────────────────────────────────────────────
    (32,
     'Chaparral for infected wounds and animal bites: antimicrobial, anti-inflammatory. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 310,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (26,
     'Echinacea for infected wounds: antimicrobial externally; also taken internally to support immune system.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 320,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (21,
     'Garlic for infected wounds and animal bites: antimicrobial. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 330,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (99,
     'Myrrh for infected wounds and animal bites: antimicrobial, astringent. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 340,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (33,
     'Oregon Grape Root for infected wounds: berberine-rich antimicrobial and astringent — "stop further decay of tissues and zap infection." Used both externally and internally. Also specific for abscess alongside goldenseal.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 350,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (44,
     'Yarrow for infected wounds: antimicrobial, astringent, vulnerary. Also listed as a wound-healing vulnerary alongside lavender.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 360,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (153,
     'Oak for infected wounds: astringent, antimicrobial. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 370,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (156,
     'Blackberry for infected wounds: astringent, antimicrobial. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 380,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (52,
     'Cranesbill (Geranium) for infected wounds: astringent, antimicrobial. Applied externally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 390,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (112,
     'Usnea for infected wounds: antimicrobial, antifungal. Applied externally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 400,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (79,
     'Witch Hazel for infected wounds: astringent, anti-inflammatory. Applied externally as tincture or liniment.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 410,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (30,
     'Goldenseal for abscess: "can heal infections inside of a wound." Used with Oregon Grape Root. Berberine-rich antimicrobial.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 420,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (82,
     'Lavender as a wound-healing vulnerary for infected wounds — listed alongside yarrow.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 430,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (201,
     'Thuja EO for tick bites: apply to the tick site — "some say this can stop Lyme." Good to keep in first aid kit. Remove tick carefully (avoid squishing; use q-tip massage around tick or tick tool), then apply Thuja.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 440,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (2629,
     'Andrographis for tick bites: antimicrobial/antiviral support after tick exposure, paired with Astragalus as immune support.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 450,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    (225,
     'Astragalus for tick bites: immune support after tick exposure, used alongside Andrographis.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Wound Infections', 460,
     '### Infections: Cuts, Wounds, Animal bites
- symptoms: inflamed, oozing, red, painful, hot to touch
- actions: absorbent/astringent, analgesic/anodyne, anti-microbial, AI, nervine, astringent
- herbs: (externally as a tincture or liniment) chaparral, echinacea, garlic, myrrh, OGR, yarrow, propolis (creates barrier), oak, blackberry, geranium, usnea, witch hazel, oak, marsh (necrosis)
- internally: OGR, ech
- infections: herbs with berberines and astringent = stop further decay of tissues and zap infection
- abscess = goldenseal (can heal infections inside of a wound) and Oregon Grape Root
- wound healing vulneraries = lavender, yarrow, honey
- support immune system = echinacea
- tick bites = avoid squishing it, use a q-tip to massage the area around the tick to encourage it to let go. Apply thuja EO (good to have in your kit - some say this can stop lyme) cover with wet, soapy cotton ball on tick, or use tick removal tool
- pack with bentonite clay overnight/plantain
- andrographis/astragalus'),

    -- ── PAIN ──────────────────────────────────────────────────────────────────
    (87,
     'Willow bark: analgesic, taken internally for pain.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Pain', 470,
     '### Pain
actions: analgesic, rubefacient, AI, Antispas, circ stim
herbs: (internally) willow bark, SJW (nerve)

hops + teasel combo - spray for neck pain?'),

    (81,
     'St. John''s Wort (SJW): specific for nerve pain, taken internally.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Pain', 480,
     '### Pain
actions: analgesic, rubefacient, AI, Antispas, circ stim
herbs: (internally) willow bark, SJW (nerve)

hops + teasel combo - spray for neck pain?'),

    (129,
     'Hops: noted in combination with Teasel as a spray for neck pain.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Pain', 490,
     '### Pain
actions: analgesic, rubefacient, AI, Antispas, circ stim
herbs: (internally) willow bark, SJW (nerve)

hops + teasel combo - spray for neck pain?'),

    (1630,
     'Teasel Root: noted in combination with Hops as a spray for neck pain.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Pain', 500,
     '### Pain
actions: analgesic, rubefacient, AI, Antispas, circ stim
herbs: (internally) willow bark, SJW (nerve)

hops + teasel combo - spray for neck pain?'),

    -- ── DIGESTIVE UPSET ───────────────────────────────────────────────────────
    (156,
     'Blackberry root/leaf for digestive upset: antidiarrheal, astringent. Used alongside charcoal for acute digestive complaints.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Digestive Upset', 510,
     '### Digestive Upset
Actions: bitters, anti-nausea, carminatives, antispasmodics

- charcoal (stops absorption of all microbes and nutrients)
- blackberry root/leaf'),

    -- ── POISON OAK ────────────────────────────────────────────────────────────
    (1139,
     'Evening Primrose Oil taken internally for Poison Oak: itchy, hot, oozing skin reaction.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Poison Oak', 520,
     '### Poison Oak
itchy, hot, oozing

internally: Evening Primrose Oil'),

    -- ── ASTHMA AND ALLERGIC REACTIONS ─────────────────────────────────────────
    (132,
     'Lobelia for asthma and allergic reactions: acrid, slightly toxic. Can cause vomiting at high doses. Use as drop or low dose.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Asthma and Allergic Reactions', 530,
     '### Asthma/Allergic reactions
- Lobelia - acrid, slightly toxic. Can cause vomiting at high doses
- Yerba santa, gumweed (decongestants)
- Ma huang/ephedra'),

    (590,
     'Yerba Santa: decongestant for asthma and allergic reactions.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Asthma and Allergic Reactions', 540,
     '### Asthma/Allergic reactions
- Lobelia - acrid, slightly toxic. Can cause vomiting at high doses
- Yerba santa, gumweed (decongestants)
- Ma huang/ephedra'),

    (199,
     'Gumweed: decongestant for asthma and allergic reactions.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Asthma and Allergic Reactions', 550,
     '### Asthma/Allergic reactions
- Lobelia - acrid, slightly toxic. Can cause vomiting at high doses
- Yerba santa, gumweed (decongestants)
- Ma huang/ephedra'),

    (448,
     'Ma Huang (Ephedra) for asthma and allergic reactions: bronchodilator, decongestant.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Asthma and Allergic Reactions', 560,
     '### Asthma/Allergic reactions
- Lobelia - acrid, slightly toxic. Can cause vomiting at high doses
- Yerba santa, gumweed (decongestants)
- Ma huang/ephedra'),

    -- ── SHOCK AND ACUTE ANXIETY ───────────────────────────────────────────────
    (142,
     'Skullcap at high dose (4 droppers full) for shock, grief, and acute anxiety.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Shock and Acute Anxiety', 570,
     '### Sleep, stress, anxiety, shock, grief, trauma

rescue remedy FE, high dose of skullcap (4 droppers full)

Pulsatilla is specific for shock - 1-5 drops
    can ground you
but if you want to disassociate (active injury), Ghost Pipe can disassociate you
- even Ghost Pipe + Kava (like for surgeries or procedures)'),

    (36,
     'Pasqueflower (Pulsatilla) is specific for shock: use 1–5 drops, can ground the person. Drop dose — use very small amounts.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Shock and Acute Anxiety', 580,
     '### Sleep, stress, anxiety, shock, grief, trauma

rescue remedy FE, high dose of skullcap (4 droppers full)

Pulsatilla is specific for shock - 1-5 drops
    can ground you
but if you want to disassociate (active injury), Ghost Pipe can disassociate you
- even Ghost Pipe + Kava (like for surgeries or procedures)'),

    (138,
     'Kava for dissociation during active injury or procedures (e.g., surgeries) — noted in combination with Ghost Pipe.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'Shock and Acute Anxiety', 590,
     '### Sleep, stress, anxiety, shock, grief, trauma

rescue remedy FE, high dose of skullcap (4 droppers full)

Pulsatilla is specific for shock - 1-5 drops
    can ground you
but if you want to disassociate (active injury), Ghost Pipe can disassociate you
- even Ghost Pipe + Kava (like for surgeries or procedures)'),

    -- ── UTIs ──────────────────────────────────────────────────────────────────
    (95,
     'Corn Silk as a cold infusion (dried) for UTIs: "make urethra slippery." Prepared as a cold infusion, not hot tea.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'UTIs', 600,
     '### UTIs
- dried corn silk cold infusion tea: make urethra slippery
- Uva ursi, usnea together'),

    (46,
     'Bearberry (Uva ursi) for UTIs: antimicrobial. Used together with Usnea.',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'UTIs', 610,
     '### UTIs
- dried corn silk cold infusion tea: make urethra slippery
- Uva ursi, usnea together'),

    (112,
     'Usnea for UTIs: antimicrobial. Used together with Bearberry (Uva ursi).',
     'BHC - Class 20 - Reproductive System 1 and Herbal First Aid', 'personal', 'UTIs', 620,
     '### UTIs
- dried corn silk cold infusion tea: make urethra slippery
- Uva ursi, usnea together');

END $$;

-- ── KEYWORDS ──────────────────────────────────────────────────────────────────

-- Cinnamon (167)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (167, 'heavy bleeding',   'ailment'),
  (167, 'uterine tonic',    'ailment'),
  (167, 'postpartum support','ailment'),
  (167, 'hemostatic',       'action'),
  (167, 'hormonal support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cinnamon Bark / Cassia (1083) — safety note
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1083, 'heavy bleeding',  'ailment'),
  (1083, 'liver support',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dong Quai (1009)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1009, 'menstrual irregularity', 'ailment'),
  (1009, 'fertility support',      'ailment'),
  (1009, 'hormonal support',       'ailment'),
  (1009, 'light menses',           'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chasteberry (190)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (190, 'PCOS',                'ailment'),
  (190, 'fertility support',   'ailment'),
  (190, 'hormonal support',    'ailment'),
  (190, 'menstrual irregularity','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginger (124)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'dysmenorrhea',         'ailment'),
  (124, 'menstrual irregularity','ailment'),
  (124, 'poor circulation',     'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Motherwort (131)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (131, 'menstrual irregularity', 'ailment'),
  (131, 'dysmenorrhea',           'ailment'),
  (131, 'hormonal support',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle leaf (43)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43, 'anemia',          'ailment'),
  (43, 'heavy bleeding',  'ailment'),
  (43, 'mineral support', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Raspberry leaf (155)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (155, 'heavy bleeding', 'ailment'),
  (155, 'fibroids',       'ailment'),
  (155, 'uterine tonic',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yarrow (44)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44, 'heavy bleeding', 'ailment'),
  (44, 'insect bites',   'ailment'),
  (44, 'burns',          'ailment'),
  (44, 'wound healing',  'ailment'),
  (44, 'skin infection', 'ailment'),
  (44, 'antimicrobial',  'action'),
  (44, 'hemostatic',     'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dandelion root (122)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (122, 'liver support',     'ailment'),
  (122, 'estrogen metabolism','ailment'),
  (122, 'hormonal support',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ocotillo (1248)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1248, 'lymphatic support', 'ailment'),
  (1248, 'poor circulation',  'ailment'),
  (1248, 'edema',             'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Plantain (85)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (85, 'insect bites',  'ailment'),
  (85, 'wound healing', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula (70)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'burns',         'ailment'),
  (70, 'wound healing', 'ailment'),
  (70, 'skin infection','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Aloe (202)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (202, 'burns', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Prickly Pear (2748)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2748, 'burns', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- St. John's Wort (81)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (81, 'burns',      'ailment'),
  (81, 'nerve pain', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lavender (82)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (82, 'burns',         'ailment'),
  (82, 'wound healing', 'ailment'),
  (82, 'skin infection','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Echinacea (26)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26, 'wound healing', 'ailment'),
  (26, 'skin infection','ailment'),
  (26, 'immune support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oregon Grape (33)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (33, 'wound healing', 'ailment'),
  (33, 'skin infection','ailment'),
  (33, 'abscess',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chaparral (32)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (32, 'skin infection', 'ailment'),
  (32, 'wound healing',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Usnea (112)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (112, 'skin infection',        'ailment'),
  (112, 'wound healing',         'ailment'),
  (112, 'urinary tract infection','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Myrrh (99)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (99, 'skin infection', 'ailment'),
  (99, 'wound healing',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pine Needles (2643)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2643, 'skin infection', 'ailment'),
  (2643, 'wound healing',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Comfrey root (89)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (89, 'wound healing',  'ailment'),
  (89, 'skin conditions','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Helichrysum (831)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (831, 'wound healing',  'ailment'),
  (831, 'skin conditions','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cayenne (47)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (47, 'wound healing', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Garlic (21)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (21, 'skin infection', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oak (153)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (153, 'skin infection', 'ailment'),
  (153, 'wound healing',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Blackberry (156)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (156, 'skin infection', 'ailment'),
  (156, 'diarrhea',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cranesbill (52)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (52, 'skin infection', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Witch Hazel (79)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (79, 'skin infection', 'ailment'),
  (79, 'wound healing',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goldenseal (30)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (30, 'abscess',        'ailment'),
  (30, 'skin infection', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Thuja (201)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (201, 'tick bites',  'ailment'),
  (201, 'Lyme disease','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Andrographis (2629)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2629, 'tick bites',  'ailment'),
  (2629, 'Lyme disease','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Astragalus (225)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (225, 'tick bites',  'ailment'),
  (225, 'immune support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Willow (87)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (87, 'chronic pain', 'ailment'),
  (87, 'headache',     'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- St. John's Wort (81) — nerve pain / pain section
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (81, 'chronic pain', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hops (129)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (129, 'neck pain',    'symptom'),
  (129, 'sleep support','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Teasel Root (1630)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1630, 'neck pain', 'symptom')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Evening Primrose (1139)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1139, 'poison oak',    'ailment'),
  (1139, 'skin conditions','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lobelia (132)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (132, 'asthma',   'ailment'),
  (132, 'allergies','ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yerba Santa (590)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (590, 'asthma',                 'ailment'),
  (590, 'respiratory congestion', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Gumweed (199)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (199, 'asthma',                 'ailment'),
  (199, 'respiratory congestion', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ma Huang (448)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (448, 'asthma',                 'ailment'),
  (448, 'respiratory congestion', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Skullcap (142)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (142, 'shock',   'ailment'),
  (142, 'anxiety', 'ailment'),
  (142, 'stress',  'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pasqueflower (36)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (36, 'shock',        'ailment'),
  (36, 'anxiety',      'ailment'),
  (36, 'dissociation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Kava (138)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (138, 'anxiety',      'ailment'),
  (138, 'dissociation', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Corn Silk (95)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (95, 'urinary tract infection', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Bearberry (46)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (46, 'urinary tract infection', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ── AILMENT SEARCH SYNONYMS (new ailment keywords only) ───────────────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('shock',
   ARRAY['acute shock', 'emotional shock', 'physiological shock', 'trauma response', 'acute stress response', 'grounding']),
  ('tick bites',
   ARRAY['tick exposure', 'tick removal', 'arachnid bite', 'lyme prevention', 'deer tick bite', 'tick bite aftermath']),
  ('poison oak',
   ARRAY['poison ivy', 'urushiol rash', 'urushiol exposure', 'contact dermatitis', 'poison sumac', 'poison oak rash'])
ON CONFLICT (ailment_keyword) DO NOTHING;
