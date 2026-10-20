-- Migration 422: Class 3 - Herbal Actions II — snippets, keywords, ailment search terms
-- Source files parsed:
--   BHC - Class 3 - Herbal Actions II - Shereel Ashley.md (personal, note_type='personal')
-- No generated notes file exists for Class 3.
--
-- Herb name normalisations:
--   mint → Peppermint (Mentha piperita, id=55)
--   Elderflower → Elder (Sambucus nigra, flower, id=57)
--   Elderberry → Elder (Sambucus nigra, berry, id=1651)
--   Red Root / Ceanothus → Red Root (Ceanothus americanus, id=981)
--   comfrey → Comfrey leaf (Symphytum officinale, leaf, id=1650) — unspecified part, defaulted to leaf
--   nettle → Nettle (Urtica dioica, leaf, id=43) — unspecified part, defaulted to leaf
--   orange peel → Sweet Orange (Citrus sinensis, id=748)
--   rose → Rose petal (Rosa spp., id=850)
--
-- Herbs skipped (not in DB or not appropriate to add):
--   Calea (Calea zacatechichi) — not in herbal.herbs; very brief/tentative mention
--   Blue Lotus — not in herbal.herbs; tentative mention
--   Figs, Pomegranates, Olive Oil, Mandrakes — foods/preparations or historical-only; no DB entry
--   "bitter herbs" (lettuce, horseradish) — not in herbal.herbs as described
--
-- New ailment keywords: lactation support, cirrhosis
-- Keyword merge decisions:
--   "cleansing/purification" (Hyssop biblical) → skipped; ritual/historical context, not clinical
--   "heat excess headaches" (Feverfew) → headache (existing)
--   "delayed menstruation" (Mugwort) → amenorrhea (existing)
--   "addiction recovery" (hypnotics section) → substance withdrawal (existing)
--   "blood pressure creeping up" (Linden) → hypertension (existing)
--   "congealed blood" (emmenagogues) → dysmenorrhea (existing)

SET search_path TO herbal, public;

-- ─── Snippets ────────────────────────────────────────────────────────────────

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 3 - Herbal Actions II') THEN
    RAISE NOTICE 'Class 3 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- ── Herb Tasting ──────────────────────────────────────────────────────────
  (748,
   'Orange peel - glycerite tasting. Glycerites from palm/coconut triglycerides. Alcohol is constitutionally hot and dry by itself — take that into account. Different menstruums: broth, animal fats, salt, molasses, vinegar.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 10,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!

- different menstruums:
    - broth?
    - animal fats?
    - salt?
    - molasses?
    - vinegar?
- use what you have, doesn''t have to be super-expensive
- take your time to get to know a plant, slow, observe
- what solvents then speak to you

#### Tasting/Experiencing Herbs
- both fresh and dry
- chew slowly, notice dry, wet, spicy, bitter, sweet, aroma
- sit in your mouth and notice
- take notes'),

  (84,
   'Chamomile - glycerite tasting. Tasting both fresh and dry; chew slowly, notice dry, wet, spicy, bitter, sweet, aroma.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 20,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!

- different menstruums:
    - broth?
    - animal fats?
    - salt?
    - molasses?
    - vinegar?
- use what you have, doesn''t have to be super-expensive
- take your time to get to know a plant, slow, observe
- what solvents then speak to you

#### Tasting/Experiencing Herbs
- both fresh and dry
- chew slowly, notice dry, wet, spicy, bitter, sweet, aroma
- sit in your mouth and notice
- take notes'),

  (136,
   'Catnip - glycerite tasting.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 30,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!

- different menstruums:
    - broth?
    - animal fats?
    - salt?
    - molasses?
    - vinegar?
- use what you have, doesn''t have to be super-expensive'),

  (167,
   'Cinnamon - glycerite tasting; described as fiery.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 40,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!'),

  (55,
   'Mint - glycerite tasting.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 50,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!'),

  (850,
   'Rose - glycerite tasting.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 60,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!'),

  (124,
   'Ginger - glycerite tasting.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herb Tasting', 70,
   'herb tastings:
orange peel - glycerite
chamomile - glycerite
catnip - glycerite
cinnamon - glycerite - fiery
mint - glycerite
rose - glycerite
ginger - glycerite

protocols:
place dropper on back of hand to taste
notice and record
this is the scientific method!

Glycerites - triglycerides from palm/coconut
Tinctures with alcohol - alcohol is constitutionally hot and dry by itself, take that into account!'),

  -- ── Bible Herbs ───────────────────────────────────────────────────────────
  (53,
   'Hyssop - cleansing, purification. Used in biblical context for ritual cleansing.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Bible Herbs', 80,
   '#### Herbs Mentioned in the Bible
- Hyssop - cleansing, purification
- Myrrh and Frankincense - prized resins, anointing tabernacle, temple, body, burial
- Balm of Gilead - desert shrub resin, wound healing
- Olive Oil - anointing, cooking, unfiltered/cloudy
- Figs - nourishment, skin conditions
- Pomegranates - nourishment, leaves and fruit, constipation
- Mandrakes - psychoactive properties linked to fertility
- Cinnamon - anointing and perfumes
- Bitter herbs - lettuce, horseradish, urinary help, joint pain'),

  (99,
   'Myrrh and Frankincense - prized resins, anointing tabernacle, temple, body, burial.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Bible Herbs', 90,
   '#### Herbs Mentioned in the Bible
- Hyssop - cleansing, purification
- Myrrh and Frankincense - prized resins, anointing tabernacle, temple, body, burial
- Balm of Gilead - desert shrub resin, wound healing
- Olive Oil - anointing, cooking, unfiltered/cloudy
- Figs - nourishment, skin conditions
- Pomegranates - nourishment, leaves and fruit, constipation
- Mandrakes - psychoactive properties linked to fertility
- Cinnamon - anointing and perfumes
- Bitter herbs - lettuce, horseradish, urinary help, joint pain'),

  (1597,
   'Frankincense - prized resin alongside Myrrh, used for anointing tabernacle, temple, body, burial.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Bible Herbs', 100,
   '#### Herbs Mentioned in the Bible
- Hyssop - cleansing, purification
- Myrrh and Frankincense - prized resins, anointing tabernacle, temple, body, burial
- Balm of Gilead - desert shrub resin, wound healing
- Olive Oil - anointing, cooking, unfiltered/cloudy
- Figs - nourishment, skin conditions
- Pomegranates - nourishment, leaves and fruit, constipation
- Mandrakes - psychoactive properties linked to fertility
- Cinnamon - anointing and perfumes
- Bitter herbs - lettuce, horseradish, urinary help, joint pain'),

  (196,
   'Balm of Gilead - desert shrub resin, wound healing.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Bible Herbs', 110,
   '#### Herbs Mentioned in the Bible
- Hyssop - cleansing, purification
- Myrrh and Frankincense - prized resins, anointing tabernacle, temple, body, burial
- Balm of Gilead - desert shrub resin, wound healing
- Olive Oil - anointing, cooking, unfiltered/cloudy
- Figs - nourishment, skin conditions
- Pomegranates - nourishment, leaves and fruit, constipation
- Mandrakes - psychoactive properties linked to fertility
- Cinnamon - anointing and perfumes
- Bitter herbs - lettuce, horseradish, urinary help, joint pain'),

  -- ── Herbalism in Europe ───────────────────────────────────────────────────
  (1651,
   'Elderberry — listed as one of the essential herbs of the Middle Ages in western Europe; wild-harvested.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 120,
   '#### Europe
- The Middle Ages
    - earliest record of herbalism, first century BCE in western Europe
    - plant knowledge necessary for survival without prescription drugs
    - essential herbs:
        - elderberry
        - wild sage
        - rose hips
        - plantain
        - calendula
        - comfrey
        - yarrow
        - nettle
        - many more
    - majority of herbs were wild-harvested
    - Hops and the Beer Hall laws were employed by the Catholic Church
        - turned people away from multi-herb knowledge to just hops
    - when you suppress herbal knowledge, you suppress and annihilate people'),

  (56,
   'Sage — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 130,
   '#### Europe
- The Middle Ages
    - earliest record of herbalism, first century BCE in western Europe
    - plant knowledge necessary for survival without prescription drugs
    - essential herbs:
        - elderberry
        - wild sage
        - rose hips
        - plantain
        - calendula
        - comfrey
        - yarrow
        - nettle
        - many more
    - majority of herbs were wild-harvested
    - Hops and the Beer Hall laws were employed by the Catholic Church
        - turned people away from multi-herb knowledge to just hops
    - when you suppress herbal knowledge, you suppress and annihilate people'),

  (849,
   'Rose hips — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 140,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested
    - Hops and the Beer Hall laws were employed by the Catholic Church — turned people away from multi-herb knowledge to just hops
    - when you suppress herbal knowledge, you suppress and annihilate people'),

  (85,
   'Plantain — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 150,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested
    - Hops and the Beer Hall laws were employed by the Catholic Church — turned people away from multi-herb knowledge to just hops
    - when you suppress herbal knowledge, you suppress and annihilate people'),

  (70,
   'Calendula — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 160,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested'),

  (1650,
   'Comfrey — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 170,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested'),

  (44,
   'Yarrow — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 180,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested'),

  (43,
   'Nettle — listed as one of the essential herbs of the Middle Ages in western Europe.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 190,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested'),

  (129,
   'Hops and the Beer Hall laws were employed by the Catholic Church — turned people away from multi-herb knowledge to just hops.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Herbalism in Europe', 200,
   '#### Europe
- The Middle Ages
    - essential herbs: elderberry, wild sage, rose hips, plantain, calendula, comfrey, yarrow, nettle, and many more
    - majority of herbs were wild-harvested
    - Hops and the Beer Hall laws were employed by the Catholic Church
        - turned people away from multi-herb knowledge to just hops
    - when you suppress herbal knowledge, you suppress and annihilate people'),

  -- ── Broader Herbal Traditions ─────────────────────────────────────────────
  (203,
   'Turmeric — Ayurvedic medicine used many herbs including turmeric, maybe as early as 1000 BCE.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Broader Herbal Traditions', 210,
   '#### Broader Herbal Traditions
- India
    - Ayurvedic medicine used many herbs (ie turmeric) maybe as early as 1000 BCE
    - Rig Veda and Atharva Veda some of the earliest medical detail forming the Ayurvedic system
    - Sushruta Samhita - 6th cent BCE: 700 medicinal plant and biological material'),

  -- ── Diaphoretics ─────────────────────────────────────────────────────────
  (57,
   'Elderflower — diaphoretic example; note that elder berries are antiviral.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diaphoretics', 220,
   '### Diaphoretics
- encourage elimination through sweat
- most will induce sweat at any time, giving the body a pleasant feeling of warmth
- used when client needs to sweat, and release heat
- ex: Elderflower (berries are antiviral), catnip, yarrow in its way as well
- heat excess headaches? Feverfew'),

  (136,
   'Catnip — diaphoretic.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diaphoretics', 230,
   '### Diaphoretics
- encourage elimination through sweat
- most will induce sweat at any time, giving the body a pleasant feeling of warmth
- used when client needs to sweat, and release heat
- ex: Elderflower (berries are antiviral), catnip, yarrow in its way as well
- heat excess headaches? Feverfew'),

  (44,
   'Yarrow — diaphoretic (noted as diaphoretic "in its way as well").',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diaphoretics', 240,
   '### Diaphoretics
- encourage elimination through sweat
- most will induce sweat at any time, giving the body a pleasant feeling of warmth
- used when client needs to sweat, and release heat
- ex: Elderflower (berries are antiviral), catnip, yarrow in its way as well
- heat excess headaches? Feverfew'),

  (121,
   'Feverfew — noted for heat excess headaches.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diaphoretics', 250,
   '### Diaphoretics
- encourage elimination through sweat
- most will induce sweat at any time, giving the body a pleasant feeling of warmth
- used when client needs to sweat, and release heat
- ex: Elderflower (berries are antiviral), catnip, yarrow in its way as well
- heat excess headaches? Feverfew'),

  -- ── Diuretics ─────────────────────────────────────────────────────────────
  (217,
   'Coffee is a diuretic; will slowly deplete your body of important electrolytes (potassium) through the urine.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diuretics', 260,
   '### Diuretics
- gently promote elimination of water through the kidneys, as urine
- coffee is a diuretic, and will slowly deplete your body of important electrolytes (potassium) through the urine
- Dandelion leaf is a notable exception, contains so many minerals it leaves your body with a net gain - minerals = longer hot infusion
- (Dandelion root bitter liver cholagogue)'),

  (1648,
   'Dandelion leaf is a notable exception among diuretics — contains so many minerals it leaves your body with a net gain; minerals = longer hot infusion.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diuretics', 270,
   '### Diuretics
- gently promote elimination of water through the kidneys, as urine
- coffee is a diuretic, and will slowly deplete your body of important electrolytes (potassium) through the urine
- Dandelion leaf is a notable exception, contains so many minerals it leaves your body with a net gain - minerals = longer hot infusion
- (Dandelion root bitter liver cholagogue)'),

  (122,
   'Dandelion root — bitter liver cholagogue.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Diuretics', 280,
   '### Diuretics
- gently promote elimination of water through the kidneys, as urine
- coffee is a diuretic, and will slowly deplete your body of important electrolytes (potassium) through the urine
- Dandelion leaf is a notable exception, contains so many minerals it leaves your body with a net gain - minerals = longer hot infusion
- (Dandelion root bitter liver cholagogue)'),

  -- ── Emmenagogues ──────────────────────────────────────────────────────────
  (115,
   'Mugwort — emmenagogue; promotes menstruation by slightly irritating the uterine lining. Used topically as antispasmodic. Pillow use for wild, lucid, vivid dreams. Severely contraindicated during pregnancy.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Emmenagogues', 290,
   '### Emmenagogues
- promote menstruation usually by slightly irritating the uterine lining
    - delayed menstruation, congealed blood
- severely contraindicated during pregnancy
- ex: mugwort
    - pillow, topically (antispasmodic)
    - wild, lucid, vivid dreams
    - add Calea - south american dream plant, maybe add Blue Lotus
        - dreamwork, meditation, spiritual development
    - Basil and Chamomile can sweeten dreams if nightmares'),

  (420,
   'Basil — Basil and Chamomile can sweeten dreams if nightmares (in context of Mugwort dreamwork use).',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Emmenagogues', 300,
   '### Emmenagogues
- promote menstruation usually by slightly irritating the uterine lining
    - delayed menstruation, congealed blood
- severely contraindicated during pregnancy
- ex: mugwort
    - pillow, topically (antispasmodic)
    - wild, lucid, vivid dreams
    - add Calea - south american dream plant, maybe add Blue Lotus
        - dreamwork, meditation, spiritual development
    - Basil and Chamomile can sweeten dreams if nightmares'),

  (84,
   'Chamomile — mentioned with Basil to sweeten dreams if nightmares (in context of Mugwort dreamwork use).',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Emmenagogues', 310,
   '### Emmenagogues
- promote menstruation usually by slightly irritating the uterine lining
    - delayed menstruation, congealed blood
- severely contraindicated during pregnancy
- ex: mugwort
    - pillow, topically (antispasmodic)
    - wild, lucid, vivid dreams
    - add Calea - south american dream plant, maybe add Blue Lotus
        - dreamwork, meditation, spiritual development
    - Basil and Chamomile can sweeten dreams if nightmares'),

  -- ── Expectorants ──────────────────────────────────────────────────────────
  (21,
   'Garlic — expectorant; also antiviral and antifungal.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Expectorants', 320,
   '### Expectorants
- encourages loosening and removal of old mucus deposits, esp after a few days of a cold or bronchial infection, will prevent this condition from setting in
- ex: Garlic (also antiviral and antifungal)
- Lobelia - broncho-dilator, opens the capillaries to allow more expectorant efficacy
- Osha - tincture sample, stimulating expectorant
- important to use the herb here to match the constitution - dry for wet, wet for dry
- Elecampane - swiss army knife for all constitutions - stimulating and relaxing'),

  (132,
   'Lobelia — broncho-dilator; opens the capillaries to allow more expectorant efficacy.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Expectorants', 330,
   '### Expectorants
- encourages loosening and removal of old mucus deposits, esp after a few days of a cold or bronchial infection, will prevent this condition from setting in
- ex: Garlic (also antiviral and antifungal)
- Lobelia - broncho-dilator, opens the capillaries to allow more expectorant efficacy
- Osha - tincture sample, stimulating expectorant
- important to use the herb here to match the constitution - dry for wet, wet for dry
- Elecampane - swiss army knife for all constitutions - stimulating and relaxing'),

  (104,
   'Osha — stimulating expectorant.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Expectorants', 340,
   '### Expectorants
- encourages loosening and removal of old mucus deposits, esp after a few days of a cold or bronchial infection, will prevent this condition from setting in
- ex: Garlic (also antiviral and antifungal)
- Lobelia - broncho-dilator, opens the capillaries to allow more expectorant efficacy
- Osha - tincture sample, stimulating expectorant
- important to use the herb here to match the constitution - dry for wet, wet for dry
- Elecampane - swiss army knife for all constitutions - stimulating and relaxing'),

  (54,
   'Elecampane — "swiss army knife for all constitutions" — both stimulating and relaxing expectorant. Match herb to constitution: dry for wet, wet for dry.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Expectorants', 350,
   '### Expectorants
- encourages loosening and removal of old mucus deposits, esp after a few days of a cold or bronchial infection, will prevent this condition from setting in
- ex: Garlic (also antiviral and antifungal)
- Lobelia - broncho-dilator, opens the capillaries to allow more expectorant efficacy
- Osha - tincture sample, stimulating expectorant
- important to use the herb here to match the constitution - dry for wet, wet for dry
- Elecampane - swiss army knife for all constitutions - stimulating and relaxing'),

  -- ── Galactagogues ─────────────────────────────────────────────────────────
  (91,
   'Fenugreek — galactagogue; encourages production of breast milk especially in first few days after birth. Also carminative (spice).',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Galactagogues', 360,
   '### Galactagogues
- encourage the production of breast milk, esp first few days after birth
- ex: Fenugreek - sweet, carminative as well (spice)'),

  -- ── Hepatoprotectants ─────────────────────────────────────────────────────
  (206,
   'Milk Thistle — hepatoprotectant; slows alcohol absorption when drinking. Seeds used — must leach starches first before silymarin comes out; a very milky tincture is low potency. Cooling. Useful in hepatitis, jaundice, cirrhosis, chemical sensitivities.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Hepatoprotectants', 370,
   '### Hepatoprotectants
- liver "hepatos" in Greek, so this action implies strong liver protection
- useful in cases of poisoning, hepatitis, jaundice and cirrhosis, can be used to help with chemical sensitivities
- ex: Milk Thistle - also slow down alcohol absorption when drinking
    - seeds used - have to leach the starches first, before the silimarin and other good stuff comes out, so a very milky tincture is low potency
    - cooling'),

  -- ── Hypnotics ─────────────────────────────────────────────────────────────
  (128,
   'California Poppy — hypnotic; trance-inducing, a little more than simple sedatives. Useful for sleep conditions, headaches, tension, addiction recovery. Do not use with sedative medication. Most hypnotics are also hypotensives.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Hypnotics', 380,
   '### Hypnotics
- trance-inducing, a little more than simple sedatives
- can be very relaxing, useful in sleep conditions, headaches, tension, and for addiction recovery
- don''t used with sedative medication already
- most are also hypotensives - lower blood pressure
- ex: California Poppy'),

  -- ── Hypotensives ──────────────────────────────────────────────────────────
  (90,
   'Linden — hypotensive; heart-shaped leaves = blood pressure. Use semi-preventatively when blood pressure starts to creep up; not in acute conditions.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Hypotensives', 390,
   '### Hypotensives
- lower blood pressure by acting either on the heart, arteries, capillaries, or the water balance in the body
- use semi-preventatively, when the blood pressure starts to creep up, not in acute conditions
- ex: Linden - heart shaped leaves = blood pressure'),

  -- ── Laxatives ─────────────────────────────────────────────────────────────
  (216,
   'Senna — laxative; can easily become habit-forming, so not for more than a few days at most.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Laxatives', 400,
   '### Laxatives
- can easily become habit-forming, so not for more than a few days at most
- Senna (Cassia senna) is the most well known'),

  -- ── Lymphatics ────────────────────────────────────────────────────────────
  (28,
   'Cleavers — lymphatic; moves toxins and byproducts of cellular metabolism and infection from the body via the lymph system.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Lymphatics', 410,
   '### Lymphatics
- the lymph system, consisting of the spaces between the cells that drain fluid into lymphatic vessels, on to lymph nodes, and from there are returned to the bloodstream
- responsible for moving many toxins and byproducts of cellular metabolism and infection from the body
- ex: Cleavers, Ceanothus (Red Root)'),

  (981,
   'Red Root (Ceanothus) — lymphatic.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Lymphatics', 420,
   '### Lymphatics
- the lymph system, consisting of the spaces between the cells that drain fluid into lymphatic vessels, on to lymph nodes, and from there are returned to the bloodstream
- responsible for moving many toxins and byproducts of cellular metabolism and infection from the body
- ex: Cleavers, Ceanothus (Red Root)'),

  -- ── Rubefacients ──────────────────────────────────────────────────────────
  (43,
   'Nettle — rubefacient ("making red"); external, topical irritant that stimulates blood flow and relieves pain and improves circulation.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Rubefacients', 430,
   '### Rubefacients
- "making red"
- usually external, topical irritants, stimulate blood flow and relieve pain and improve circulation
- ex: Nettle'),

  -- ── Sialogogues ───────────────────────────────────────────────────────────
  (2363,
   'Spilanthes — sialogogue; stimulates saliva flow, activating the whole digestive process beginning in the mouth. The bitter flavor is a notable sialogogue.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Sialogogues', 440,
   '### Sialogogues
- stimulate saliva flow
- will activate the whole digestive process which begins in the mouth
- the bitter flavor is a notable sialogogue
- ex: Spilanthes'),

  -- ── Sedatives ─────────────────────────────────────────────────────────────
  (137,
   'Passionflower — nervine sedative; reduces the "chatter" of the nervous system, encouraging sleep. Use usually not encouraged except in hours before bed. Nervines: Relaxants, Sedatives, Stimulants.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Sedatives', 450,
   '### Sedatives
- reduce the "chatter" of the nervous system, encouraging sleep most directly
- use is usually not encouraged except in hours before bed
- ex: Passionflower
- Nervines:
    - Relaxants
    - Sedatives
    - Stimulants
- Chamomile hot extraction - mild sedative'),

  (84,
   'Chamomile hot extraction — mild sedative.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Sedatives', 460,
   '### Sedatives
- reduce the "chatter" of the nervous system, encouraging sleep most directly
- use is usually not encouraged except in hours before bed
- ex: Passionflower
- Nervines:
    - Relaxants
    - Sedatives
    - Stimulants
- Chamomile hot extraction - mild sedative'),

  -- ── Vulneraries ───────────────────────────────────────────────────────────
  (70,
   'Calendula — vulnerary; heals wounds, stops bleeding, disinfects. Normally also astringent, anodyne, and antibacterial. Applied externally for cuts, scrapes, wounds; can be used internally on softer tissues (ulcers).',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Vulneraries', 470,
   '### Vulneraries
- heal wounds, stop bleeding and disinfect
- normally also astringent, anodyne and antibacterial
- applied externally for cuts scrapes and wounds
- can also be used internally on softer tissues (ulcers)
- ex: Calendula
- Cayenne, Coffee, Yarrow, Shepherd''s Purse are styptics'),

  (47,
   'Cayenne — styptic (stops bleeding); listed alongside Coffee, Yarrow, and Shepherd''s Purse.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Vulneraries', 480,
   '### Vulneraries
- heal wounds, stop bleeding and disinfect
- normally also astringent, anodyne and antibacterial
- applied externally for cuts scrapes and wounds
- can also be used internally on softer tissues (ulcers)
- ex: Calendula
- Cayenne, Coffee, Yarrow, Shepherd''s Purse are styptics'),

  (217,
   'Coffee — styptic (stops bleeding); listed alongside Cayenne, Yarrow, and Shepherd''s Purse.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Vulneraries', 490,
   '### Vulneraries
- heal wounds, stop bleeding and disinfect
- normally also astringent, anodyne and antibacterial
- applied externally for cuts scrapes and wounds
- can also be used internally on softer tissues (ulcers)
- ex: Calendula
- Cayenne, Coffee, Yarrow, Shepherd''s Purse are styptics'),

  (44,
   'Yarrow — styptic (stops bleeding); listed alongside Cayenne, Coffee, and Shepherd''s Purse.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Vulneraries', 500,
   '### Vulneraries
- heal wounds, stop bleeding and disinfect
- normally also astringent, anodyne and antibacterial
- applied externally for cuts scrapes and wounds
- can also be used internally on softer tissues (ulcers)
- ex: Calendula
- Cayenne, Coffee, Yarrow, Shepherd''s Purse are styptics'),

  (71,
   'Shepherd''s Purse — styptic (stops bleeding); listed alongside Cayenne, Coffee, and Yarrow.',
   'BHC - Class 3 - Herbal Actions II', 'personal', 'Vulneraries', 510,
   '### Vulneraries
- heal wounds, stop bleeding and disinfect
- normally also astringent, anodyne and antibacterial
- applied externally for cuts scrapes and wounds
- can also be used internally on softer tissues (ulcers)
- ex: Calendula
- Cayenne, Coffee, Yarrow, Shepherd''s Purse are styptics');

END $$;

-- ─── Keywords ────────────────────────────────────────────────────────────────

INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  -- Balm of Gilead
  (196, 'wound healing', 'ailment'),

  -- Elder flower
  (57, 'diaphoretic', 'action'),
  (57, 'fever', 'ailment'),
  (57, 'common cold', 'ailment'),
  (57, 'influenza', 'ailment'),

  -- Elder berry
  (1651, 'antiviral', 'action'),
  (1651, 'influenza', 'ailment'),
  (1651, 'immune support', 'ailment'),

  -- Catnip
  (136, 'diaphoretic', 'action'),
  (136, 'fever', 'ailment'),
  (136, 'common cold', 'ailment'),

  -- Yarrow
  (44, 'diaphoretic', 'action'),
  (44, 'fever', 'ailment'),
  (44, 'styptic', 'action'),
  (44, 'wound healing', 'ailment'),
  (44, 'vulnerary', 'action'),

  -- Feverfew
  (121, 'headache', 'ailment'),

  -- Coffee
  (217, 'diuretic', 'action'),
  (217, 'styptic', 'action'),
  (217, 'wound healing', 'ailment'),

  -- Dandelion leaf
  (1648, 'diuretic', 'action'),
  (1648, 'edema', 'ailment'),
  (1648, 'mineral support', 'ailment'),
  (1648, 'kidney support', 'ailment'),

  -- Dandelion root
  (122, 'cholagogue', 'action'),
  (122, 'liver support', 'ailment'),
  (122, 'bile flow', 'ailment'),
  (122, 'digestive health', 'ailment'),

  -- Mugwort
  (115, 'emmenagogue', 'action'),
  (115, 'antispasmodic', 'action'),
  (115, 'amenorrhea', 'ailment'),
  (115, 'dysmenorrhea', 'ailment'),
  (115, 'sleep support', 'ailment'),

  -- Basil
  (420, 'sleep support', 'ailment'),

  -- Chamomile
  (84, 'sedative', 'action'),
  (84, 'sleep support', 'ailment'),
  (84, 'anxiety', 'ailment'),

  -- Garlic
  (21, 'expectorant', 'action'),
  (21, 'antiviral', 'action'),
  (21, 'antifungal', 'action'),
  (21, 'antimicrobial', 'action'),
  (21, 'respiratory infection', 'ailment'),
  (21, 'common cold', 'ailment'),
  (21, 'influenza', 'ailment'),

  -- Lobelia
  (132, 'expectorant', 'action'),
  (132, 'bronchodilator', 'action'),
  (132, 'asthma', 'ailment'),
  (132, 'respiratory congestion', 'ailment'),
  (132, 'bronchitis', 'ailment'),

  -- Osha
  (104, 'expectorant', 'action'),
  (104, 'respiratory infection', 'ailment'),
  (104, 'cough', 'ailment'),

  -- Elecampane
  (54, 'expectorant', 'action'),
  (54, 'respiratory infection', 'ailment'),
  (54, 'chronic lung disease', 'ailment'),
  (54, 'cough', 'ailment'),

  -- Fenugreek
  (91, 'galactagogue', 'action'),
  (91, 'carminative', 'action'),
  (91, 'lactation support', 'ailment'),
  (91, 'postpartum support', 'ailment'),

  -- Milk Thistle
  (206, 'hepatoprotectant', 'action'),
  (206, 'hepatitis', 'ailment'),
  (206, 'jaundice', 'ailment'),
  (206, 'cirrhosis', 'ailment'),
  (206, 'liver support', 'ailment'),
  (206, 'chemical sensitivity', 'ailment'),

  -- California Poppy
  (128, 'hypnotic', 'action'),
  (128, 'hypotensive', 'action'),
  (128, 'sleep support', 'ailment'),
  (128, 'headache', 'ailment'),
  (128, 'substance withdrawal', 'ailment'),
  (128, 'hypertension', 'ailment'),

  -- Linden
  (90, 'hypotensive', 'action'),
  (90, 'hypertension', 'ailment'),
  (90, 'cardiovascular disease', 'ailment'),

  -- Senna
  (216, 'laxative', 'action'),
  (216, 'constipation', 'ailment'),

  -- Cleavers
  (28, 'lymphatic', 'action'),
  (28, 'lymphatic support', 'ailment'),

  -- Red Root
  (981, 'lymphatic', 'action'),
  (981, 'lymphatic support', 'ailment'),

  -- Nettle (rubefacient context)
  (43, 'rubefacient', 'action'),
  (43, 'poor circulation', 'ailment'),
  (43, 'chronic pain', 'ailment'),

  -- Spilanthes
  (2363, 'sialogogue', 'action'),
  (2363, 'indigestion', 'ailment'),
  (2363, 'digestive health', 'ailment'),

  -- Passionflower
  (137, 'sedative', 'action'),
  (137, 'sleep support', 'ailment'),
  (137, 'anxiety', 'ailment'),

  -- Calendula
  (70, 'vulnerary', 'action'),
  (70, 'wound healing', 'ailment'),
  (70, 'skin conditions', 'ailment'),

  -- Cayenne
  (47, 'styptic', 'action'),
  (47, 'wound healing', 'ailment'),

  -- Shepherd's Purse
  (71, 'styptic', 'action'),
  (71, 'wound healing', 'ailment'),
  (71, 'heavy bleeding', 'ailment')

ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ─── Ailment search synonyms (new keywords only) ─────────────────────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('lactation support',
   ARRAY['breastfeeding support', 'milk production', 'nursing support', 'insufficient milk supply', 'postpartum milk', 'galactagogue support']),
  ('cirrhosis',
   ARRAY['liver cirrhosis', 'liver fibrosis', 'liver scarring', 'hepatic cirrhosis', 'end-stage liver disease', 'hepatic fibrosis'])
ON CONFLICT (ailment_keyword) DO NOTHING;
