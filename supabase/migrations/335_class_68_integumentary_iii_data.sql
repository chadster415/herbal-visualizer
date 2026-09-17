-- Migration 335: Class 68 - Integumentary III
-- Files parsed:
--   BHC - Class 68 - Integumentary III - Generated Notes.md (note_type = 'generated')
--   BHC - Class 68 - Integumentary III - Lisa.md (note_type = 'personal')
--
-- Herb name normalizations:
--   Eleuthero → Siberian Ginseng (id 9)
--   Tulsi → Holy Basil (id 13)
--   SJW / St. John's wort → St. John's Wort (id 81)
--   Schisandra → Schizandra (id 17)
--   Oat straw → Oat straw (id 2287)
--   Milky oat(s) → Oat milky oats (id 178)
--   Bleeding heart → Turkey Corn/Dicentra eximia (id 2612; closest DB match, related Dicentra species)
--   Gotu Kola → Gotu Kola (id 2229)
--   Baical/Baikal Skullcap → Chinese Skullcap (id 2274)
--   Hawthorn flowers/leaf → Hawthorn leaf & flower (id 1652)
--   OGR → Oregon Grape (id 33)
--   AI = Anti-inflammatory, AO = Antioxidant, NS = Nervous System, FE = flower essence
--   Vit = Vitamin, AFAB = Assigned Female at Birth
--
-- Herbs skipped (not in DB):
--   Lemongrass (Cymbopogon citratus), Sumac (Rhus spp.), Maravilla seeds,
--   Pine Needles (generic), Cedar, Agarita (Berberis trifoliolata),
--   Bidens (Bidens spp.), Neem (Azadirachta indica), Beebalm (Monarda spp.),
--   Jojoba, Tanacetum sinensis (unrecognized species)
--
-- Keyword merge decisions:
--   "alopecia" → existing `hair loss`
--   "connective tissue support" → existing `connective tissue disorders`
--   "wound care" → existing `wound healing`
--   "jaw tension", "muscle tension" → existing `muscle spasms`
--   "tissue dryness" → existing `perimenopause` or new `post-menopause`
--
-- New ailment keywords: eczema, psoriasis, dermatitis, rosacea, post-menopause
-- New action keywords: vulnerary, alterative, mast cell stabilizing, circulatory stimulant,
--                      connective tissue tonic, emmenagogue, hepatic, adaptogen
-- New general keywords: grief support
-- New symptom keywords: teeth grinding

SET search_path TO herbal, public;

-- ============================================================
-- GENERATED NOTES SNIPPETS
-- ============================================================

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 68 - Integumentary III') THEN
    RAISE NOTICE 'Class 68 snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === NOURISHING TEA FORMULA ===
  (43, 'Three parts nettle in nourishing tea formula targeting bone density and nervous system support. Long overnight infusion with hot water.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Nourishing Tea Formula', 10,
   '## Nourishing Tea Formula
- Target: Bone density, nervous system support
  * Ingredients:
    * Three parts nettle
    * Three parts oat straw
    * One part red clover
    * Two parts horsetail
    * One part lemongrass
- Method:
  * Long overnight infusion
  * Hot water, sit overnight'),

  (2287, 'Three parts oat straw in nourishing tea formula for bone density and nervous system support. Long overnight infusion with hot water.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Nourishing Tea Formula', 20,
   '## Nourishing Tea Formula
- Target: Bone density, nervous system support
  * Ingredients:
    * Three parts nettle
    * Three parts oat straw
    * One part red clover
    * Two parts horsetail
    * One part lemongrass
- Method:
  * Long overnight infusion
  * Hot water, sit overnight'),

  (42, 'One part red clover in nourishing tea formula for bone density and nervous system support. Hot water infusion required to break cell walls.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Nourishing Tea Formula', 30,
   '## Nourishing Tea Formula
- Target: Bone density, nervous system support
  * Ingredients:
    * Three parts nettle
    * Three parts oat straw
    * One part red clover
    * Two parts horsetail
    * One part lemongrass
- Method:
  * Long overnight infusion
  * Hot water, sit overnight'),

  (151, 'Two parts horsetail in nourishing tea formula for bone density and nervous system support. Long overnight infusion.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Nourishing Tea Formula', 40,
   '## Nourishing Tea Formula
- Target: Bone density, nervous system support
  * Ingredients:
    * Three parts nettle
    * Three parts oat straw
    * One part red clover
    * Two parts horsetail
    * One part lemongrass
- Method:
  * Long overnight infusion
  * Hot water, sit overnight'),

  -- === GOLDEN MILK PAIN TEA ===
  (87, 'White willow bark in golden milk pain tea for morning routine pain relief. Use in acute pain only; can be drying, reserve for specific moments.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Golden Milk Pain Tea', 50,
   '### Golden Milk Pain Tea
- Ingredients:
  * White willow bark
  * Ginger
  * Turmeric
  * Black pepper
- Note: Consider nutmeg for evening calming
- Purpose: Morning routine, pain relief
### White Willow Bark
- Use in acute pain only
- Can be drying, reserve for specific moments'),

  (124, 'Ginger in golden milk pain tea for pain relief. Also used as ginger glycerite for digestive system stimulation.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Golden Milk Pain Tea', 60,
   '### Golden Milk Pain Tea
- Ingredients:
  * White willow bark
  * Ginger
  * Turmeric
  * Black pepper
- Note: Consider nutmeg for evening calming
- Purpose: Morning routine, pain relief'),

  (203, 'Turmeric in golden milk pain tea for pain relief. Anti-inflammatory option; can compare with white willow for anti-inflammation.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Golden Milk Pain Tea', 70,
   '### Golden Milk Pain Tea
- Ingredients:
  * White willow bark
  * Ginger
  * Turmeric
  * Black pepper
- Note: Consider nutmeg for evening calming
- Purpose: Morning routine, pain relief'),

  -- === STRESS SUPPORT ===
  (9, 'Siberian Ginseng (eleuthero) in stress tincture at equal parts with tulsi (Holy Basil) for anxiety and emotional support.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress Support', 80,
   '## Stress and Sleep Tinctures
- Stress tincture:
  * Equal parts eleuthero, tulsi
  * For anxiety, emotional support
- Sleep tincture:
  * Passionflower
  * Ashwagandha
  * Promotes sleep, reduces anxiety'),

  (13, 'Holy Basil (tulsi) in stress tincture at equal parts with Siberian Ginseng (eleuthero) for anxiety and emotional support.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress Support', 90,
   '## Stress and Sleep Tinctures
- Stress tincture:
  * Equal parts eleuthero, tulsi
  * For anxiety, emotional support
- Sleep tincture:
  * Passionflower
  * Ashwagandha
  * Promotes sleep, reduces anxiety'),

  (137, 'Passionflower in sleep tincture with ashwagandha; promotes sleep, reduces anxiety. Better as a "sleep tonic" taken throughout the day so you are ready for the night, rather than only at bedtime.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress Support', 100,
   '## Stress and Sleep Tinctures
- Stress tincture:
  * Equal parts eleuthero, tulsi
  * For anxiety, emotional support
- Sleep tincture:
  * Passionflower
  * Ashwagandha
  * Promotes sleep, reduces anxiety'),

  (20, 'Ashwagandha in sleep tincture with passionflower for sleep and anxiety. Described as a "cozy bathrobe" — grounding but not directly sleep-inducing.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress Support', 110,
   '## Stress and Sleep Tinctures
- Stress tincture:
  * Equal parts eleuthero, tulsi
  * For anxiety, emotional support
- Sleep tincture:
  * Passionflower
  * Ashwagandha
  * Promotes sleep, reduces anxiety'),

  -- === NUTRITIVE TEA ===
  (885, 'Alfalfa in nutritive tea for calcium, potassium; supports bones, hair, teeth. High nutrient content.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Nutritive Tea', 120,
   '## Nutritive Tea
- Ingredients:
  * Alfalfa
  * Gotu kola
  * Nettle
  * Oat straw
  * Sumac
  * Fennel
- Benefits:
  * Calcium, potassium
  * Supports bones, hair, teeth
  * Manages inflammation and insulin'),

  (2229, 'Gotu kola in nutritive tea; manages inflammation and insulin. Also useful for brain fog and tissue building. Anti-inflammatory, cerebral tonic, supports detoxification.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Nutritive Tea', 130,
   '## Nutritive Tea
- Ingredients:
  * Alfalfa
  * Gotu kola
  * Nettle
  * Oat straw
  * Sumac
  * Fennel
- Benefits:
  * Calcium, potassium
  * Supports bones, hair, teeth
  * Manages inflammation and insulin
### Gotu Kola
- Brain fog and tissue building'),

  -- === SLEEP SUPPORT ===
  (138, 'Kava combined with passionflower for insomnia. Good quality kava makes you drool; mouth feels tingly numb. Add chamomile or spearmint to balance bitterness.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Sleep Support', 140,
   '## Sleep Support
- Passionflower and kava for insomnia
- Daytime tincture:
  * St. John''s wort (depression)
  * Blue vervain (neck/shoulders tension)
  * Bacopa (brain fog)
### Kava
- Good quality makes you drool
- Mouth feels tingly numb
- Add chamomile or spearmint to balance bitterness'),

  (81, 'St. John''s wort in daytime tincture for depression and nervous system tonic; anti-inflammatory. Also used as SJW oil for gua sha and stress relief.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Sleep Support', 150,
   '## Sleep Support
- Passionflower and kava for insomnia
- Daytime tincture:
  * St. John''s wort (depression)
  * Blue vervain (neck/shoulders tension)
  * Bacopa (brain fog)'),

  (983, 'Blue vervain in daytime tincture for neck/shoulders tension and stress. Also for jaw tension, stress, anxiety; hepatic, nourishes liver.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Sleep Support', 160,
   '## Sleep Support
- Passionflower and kava for insomnia
- Daytime tincture:
  * St. John''s wort (depression)
  * Blue vervain (neck/shoulders tension)
  * Bacopa (brain fog)'),

  (2381, 'Bacopa in daytime tincture for brain fog. Reduces inflammation, nourishes nervous system and heart. Useful addition to complex tonics addressing cognitive decline.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Sleep Support', 170,
   '## Sleep Support
- Passionflower and kava for insomnia
- Daytime tincture:
  * St. John''s wort (depression)
  * Blue vervain (neck/shoulders tension)
  * Bacopa (brain fog)
### Bacopa Addition
- Useful for brain fog
- Reduces inflammation
- Nourishes nervous system and heart'),

  -- === STRESS AND GRIEF FORMULATIONS ===
  (2285, 'Mimosa bark for stress relief and grief support. Also as mast cell stabilizer in eczema formula. Can be added to complex formulas addressing grief and emotional processing.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress and Grief Formulations', 180,
   '## Stress and Grief Formulations
- Ingredients:
  * Mimosa bark for stress relief
  * Skullcap (anti-spasmodic)
  * Passionflower for calming
  * Ashwagandha for adaptogenic support
  * Milky oat (nervous system restore)
  * Lemon balm (sedative nervine)'),

  (142, 'Skullcap as antispasmodic in stress/grief formula. Also in sleep tincture (formula: blue vervain + passionflower + skullcap for restlessness before sleep).',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress and Grief Formulations', 190,
   '## Stress and Grief Formulations
- Ingredients:
  * Mimosa bark for stress relief
  * Skullcap (anti-spasmodic)
  * Passionflower for calming
  * Ashwagandha for adaptogenic support
  * Milky oat (nervous system restore)
  * Lemon balm (sedative nervine)'),

  (178, 'Milky oat for nervous system restore in stress/grief formula. Muscle tension associated with loss of emolliency and not enough fats — milky oats helps.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress and Grief Formulations', 200,
   '## Stress and Grief Formulations
- Ingredients:
  * Mimosa bark for stress relief
  * Skullcap (anti-spasmodic)
  * Passionflower for calming
  * Ashwagandha for adaptogenic support
  * Milky oat (nervous system restore)
  * Lemon balm (sedative nervine)'),

  (134, 'Lemon balm as sedative nervine in stress/grief formula. Also calming for emotional processing and liver connection; helps with feeling stuck or decision-making difficulties.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Stress and Grief Formulations', 210,
   '## Stress and Grief Formulations
- Ingredients:
  * Mimosa bark for stress relief
  * Skullcap (anti-spasmodic)
  * Passionflower for calming
  * Ashwagandha for adaptogenic support
  * Milky oat (nervous system restore)
  * Lemon balm (sedative nervine)'),

  -- === PEDICULARIS ===
  (2624, 'Pedicularis: tension release, first-line in some formulas. Formula: Pedicularis + Black Cohosh + Ginger for acute muscle tension.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Specific Herbs Discussed', 220,
   '### Specific Herbs Discussed
- Pedicularis: Tension release, first-line in some formulas
- St. John''s wort: Nervous system tonic, anti-inflammatory
- Gotu Kola: Brain fog and tissue building'),

  -- === HERBAL TINCTURE FORMULATION (MORNING 2) ===
  (25, 'Black Cohosh: anti-inflammatory, alterative, eases muscle tension. Specific for back tension. Maximum 25 drops per dose is best; can actually cause headaches if dose too high.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Herbal Tincture Formulation', 230,
   '## Herbal Tincture Formulation
- Gotu Kola — Anti-inflammatory, cerebral tonic, supports detoxification
- Black Cohosh — Anti-inflammatory, alterative, eases muscle tension
- Blue Vervain — Jaw tension, stress, anxiety; hepatic, nourishes liver
- White Willow vs. Turmeric — Anti-inflammation options
- Ginger Glycerite — Digestive system stimulation
## Formulation Considerations
- Black Cohosh dosage limits
- Separate California Poppy option for muscle tension'),

  (131, 'Motherwort: cooling to aggravated heat thyroid; supportive in agitation. Also for grief support alongside mimosa and bleeding heart.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Herb and Tincture Recommendations', 240,
   '## Herb and Tincture Recommendations
- Chamomile glycerite — nervine use
- Motherwort — cooling to aggravated heat thyroid; supportive in agitation
- Sleep tincture: Lavender, passionflower, skullcap, lemon balm
- Tonic tincture: Milky oats, hawthorn leaf and flower, shatavari, gotu kola, bleeding heart, black cohosh, linden glycerite'),

  (82, 'Lavender in sleep tincture (with passionflower, skullcap, lemon balm). Essential oil before bed helps nervous system shift gears.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Herb and Tincture Recommendations', 250,
   '## Herb and Tincture Recommendations
- Sleep tincture: Lavender, passionflower, skullcap, lemon balm
- Tonic tincture: Milky oats, hawthorn leaf and flower, shatavari, gotu kola, bleeding heart, black cohosh, linden glycerite'),

  (852, 'Shatavari in tonic tincture with milky oats, hawthorn, gotu kola, bleeding heart, black cohosh, linden. Formula for post-menopausal dryness: shatavari + ashwagandha + gotu kola (+ licorice as demulcent).',
   'BHC - Class 68 - Integumentary III', 'generated', 'Herb and Tincture Recommendations', 260,
   '## Herb and Tincture Recommendations
- Tonic tincture: Milky oats, hawthorn leaf and flower, shatavari, gotu kola, bleeding heart, black cohosh, linden glycerite
- Formula for post-menopausal dryness: shatavari + ashwagandha + gotu kola (+ licorice as demulcent)'),

  (1652, 'Hawthorn leaf and flower in tonic tincture; for grief and heart support. Different parts (flowers) especially noted for grief.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Herb and Tincture Recommendations', 270,
   '## Herb and Tincture Recommendations
- Tonic tincture: Milky oats, hawthorn leaf and flower, shatavari, gotu kola, bleeding heart, black cohosh, linden glycerite
## Additional Herbs & Tincture Options
- Hawthorn — Grief and heart support — Different parts like flowers'),

  (2612, 'Bleeding Heart (Turkey Corn, Dicentra eximia): energetically supportive of grief. Reference: Michael Moore''s Materia Medica. Part of tonic tincture alongside hawthorn and mimosa for grief support.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Bleeding Heart', 280,
   '### Bleeding Heart
- Energetically supportive of grief
- Reference: Michael Moore''s Materia Medica'),

  (90, 'Linden (glycerite) in tonic tincture with milky oats, hawthorn, shatavari, gotu kola, bleeding heart, black cohosh.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Herb and Tincture Recommendations', 290,
   '## Herb and Tincture Recommendations
- Tonic tincture: Milky oats, hawthorn leaf and flower, shatavari, gotu kola, bleeding heart, black cohosh, linden glycerite'),

  -- === POST-MENOPAUSE ===
  (129, 'Hops: nourishes aging estrogen. Estrogenic — avoid in breast cancer and endometriosis. Also avoid red clover (also estrogenic) in same contraindicated populations.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Post-Menopause', 300,
   '## Additional Herbs & Tincture Options
- Astragalus, Panax Ginseng, Red Clover — Immunomodulating, adaptogen; estrogen influence of hops & red clover
## Post-Menopause Considerations
- Tissue dryness (estrogen-related)
- Adaptogenic and estrogenic herbs
- Consider moistening adaptogens like astragalus
- Hops: nourish aging estrogen (but avoid in breast cancer and endometriosis, as well as avoid Red Clover, also estrogenic)'),

  (225, 'Astragalus: moistening adaptogen for post-menopausal dryness. Immunomodulating. Consider when patient needs moisture plus immune support.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Post-Menopause', 310,
   '## Post-Menopause Considerations
- Tissue dryness (estrogen-related)
- Adaptogenic and estrogenic herbs
- Consider moistening adaptogens like astragalus'),

  -- === PROTEIN AND GUT HEALTH ===
  (1597, 'Frankincense (boswellic acid): reduces volatile acids, combats chronic joint inflammation. Used in salve with arnica for topical anti-inflammatory application.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Protein and Gut Health', 320,
   '## Protein and Gut Health
- Salve version with frankincense — reduces volatile acids, combats chronic joint inflammation
- Magnesium — helps with calcium and vitamin D absorption'),

  -- === HAIR CARE (AFTERNOON 1) ===
  (2229, 'Gotu kola enhances circulation for hair health. Combined with prickly ash for circulatory support to hair follicles. Also topical methods: oiling, gua sha on scalp, lymphatic drainage.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Hair Care', 330,
   '### Herbs for Hair Strength
- Alfalfa — high nutrient content
- Gotu kola and prickly ash — enhance circulation
- Topical methods: oiling, gua sha on scalp, lymphatic drainage
### Hair Loss and Metabolic Issues
- Premature hair loss linked to metabolic hormone issues and thyroid/reproductive hormone imbalance'),

  (123, 'Prickly ash enhances circulation to hair follicles, combined with gotu kola for hair strength.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Hair Care', 340,
   '### Herbs for Hair Strength
- Alfalfa — high nutrient content
- Gotu kola and prickly ash — enhance circulation
- Topical methods: oiling, gua sha on scalp, lymphatic drainage'),

  (885, 'Alfalfa for hair strength: high nutrient content. Also in nutritive tea for calcium, potassium, bones, hair, teeth.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Hair Care', 350,
   '### Herbs for Hair Strength
- Alfalfa — high nutrient content
- Gotu kola and prickly ash — enhance circulation'),

  (1139, 'Evening primrose oil used for gray hair recovery (premature gray).',
   'BHC - Class 68 - Integumentary III', 'generated', 'Hair Care', 360,
   '### Alopecia and Hair Loss
- Associated with trauma, stress
- Long recovery, includes: follicle massage, nervous system nourishment, nutritional strategies, acupuncture
- Evening primrose oil used for gray hair recovery'),

  -- === INTEGUMENTARY MATERIA MEDICA ===
  (165, 'Ginkgo biloba for skin: dry plant tincture 1:5 60%, dose 30-60 drops up to 3x/day; standard infusion 2-4 oz 3x/day. Specific for skin lesions due to vascular or circulatory insufficiency (including lymph). For wounds or lesions that have gone into the dermal layer.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Integumentary Materia Medica', 370,
   '#### Ginkgo biloba
- Dry plant tincture 1:5, 60%
- Dose: 30-60 drops up to 3x / day
- Standard infusion: 2-4 oz, 3x / day
- Specific for skin lesions due to vascular insufficiency or circulatory insufficiency (i.e. lymph)
- For wounds or lesions that have gone into the dermal layer'),

  (1009, 'Dong Quai for skin: Fresh plant 1:2, Dry root 1:5 60%, dose 10-60 drops 2-4x/day. Used topically (tincture or decoction) to increase photosensitivity. Circulatory stimulant; warming, moistening, stimulating. Blood builder; nourishes follicular phase. Emmenagogue. Contraindications: blood thinning agents, pregnancy, heavy menstrual bleeding.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Integumentary Materia Medica', 380,
   '#### Dong quai
- Angelica sinensis
- Root
- Fresh Plant 1:2
- Dry Root 1:5, 60%
- Dose: 10-60 drops 2-4 x day
- Contraindications: Blood thinning agents, Pregnancy, Heavy menstrual bleeding
- Can be used topically (tincture or decoction) to increase photosensitivity
- Emmenagogue
- Blood builder - nourished Follicular phase
- Circulatory stimulant
- Warming, moistening and stimulating'),

  (2229, 'Gotu Kola for skin: Fresh plant 1:2, Dry 1:5 50%, dose 15-40 drops up to 4x/day. Specific for dry scaly eruptions. Connective tissue tonic; repairs connective tissue and prevents keloids. Can be used internally and/or topically. Contraindication: pregnancy.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Integumentary Materia Medica', 390,
   '#### Centella asiatica
- Gotu Kola
- Leaves
- Fresh plant tincture: 1:2
- Dry plant tincture 1:5, 50%
- Standard Infusion
- Dose: 15-40 drops up to 4 x day
- Contraindication: Pregnancy
- Specific to treating dry scaly eruptions
- Connective tissue tonic
- Repair connective tissue and prevent keloids
- Internally and/or topically'),

  (70, 'Calendula for skin: Fresh plant 1:2, Dry 1:5 60%, dose tincture 1-4ml 3x/day; infusion 3x/day. Improves skin''s protective barrier, supports collagen synthesis. For poorly healing stasis wounds and people with wounds and poor circulation. Use topically or internally.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Integumentary Materia Medica', 400,
   '#### Calendula officinalis
- Calendula, Pot Marigold
- Petals, Flower head
- Fresh Plant 1:2
- Dry Plant 1:5, 60%
- Dose: Tincture: 1-4 ml 3 x day
- Infusion: 3 x day
- Helps improve skin''s protective barrier
- Helps support collagen synthesis
- Poorly healing stasis wounds
- People that have wounds outside, poor circulation
- Topically or internally'),

  -- === ECZEMA ===
  (2238, 'White peony as mast cell stabilizer for eczema; reduces allergic response in the skin.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 410,
   '### Herbal actions for Eczema
- Reduce allergic response — mast cell stabilizing:
  * White peony
  * Baikal skullcap
  * Mimosa
- Anti-inflammatory: licorice topically (solvent extract); use in flares, rotate in and out; decoction/wash
- Tissue healing, collagen production: gotu kola
- Alterative
- Digestives: bitter, carminative'),

  (2274, 'Chinese (Baikal) Skullcap as mast cell stabilizer for eczema; reduces allergic response in the skin. Also in David Hoffmann psoriasis formula.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 420,
   '### Herbal actions for Eczema
- Reduce allergic response — mast cell stabilizing:
  * White peony
  * Baikal skullcap
  * Mimosa
- Anti-inflammatory: licorice topically (solvent extract); use in flares, rotate in and out'),

  (2285, 'Mimosa as mast cell stabilizer for eczema; reduces allergic response in the skin.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 430,
   '### Herbal actions for Eczema
- Reduce allergic response — mast cell stabilizing:
  * White peony
  * Baikal skullcap
  * Mimosa'),

  (78, 'Licorice for eczema: apply topically as solvent extract; use during flares, rotate in and out; make a wash via decoction. Caution: internally can cause a flare (worse before better).',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 440,
   '### Eczema Materia medica
- Licorice — internally can cause a flare; worse before it gets better; use topically as solvent extract
- Poke root — small doses as lymphatic: 1 drop, then 2, up to 5; low and slow to not cause a flare
- Comfrey as a wash; some like it as an oil, especially in "itch that rashes" phase
### Herbal actions for Eczema
- Anti-inflammatory: licorice topically (solvent extract); use in flares, rotate in and out; decoction, make a wash'),

  (121, 'Feverfew in eczema materia medica.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 450,
   '### Eczema Materia medica
- Astragalus
- Calendula
- Gotu kola
- Licorice
- Nettle
- Feverfew
- Celery seed — help the body liquify and eliminate waste through the bowel'),

  (66, 'Celery seed in eczema materia medica: helps the body liquify and eliminate waste through the bowel.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 460,
   '### Eczema Materia medica
- Celery seed — help the body liquify and eliminate waste through the bowel'),

  (35, 'Poke root for eczema as lymphatic: small doses — 1 drop, then 2, up to 5. Low and slow to not cause a flare.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 470,
   '### Eczema Materia medica
- Poke root as a lymphatic — low and slow to not cause a flare — 1 drop, then 2, up to 5
- Comfrey as a wash — some like it as an oil, find it soothing especially when in "itch that rashes" phase'),

  (1650, 'Comfrey for eczema: used as a wash or oil; soothing especially in the "itch that rashes" phase. Also as vulnerary for shallow wounds.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Eczema', 480,
   '### Eczema Materia medica
- Comfrey as a wash — some like it as an oil, find it soothing especially when in "itch that rashes" phase'),

  -- === DERMATITIS FORMULA ===
  (70, 'Calendula in dermatitis formula with licorice, dong quai, gotu kola.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Dermatitis', 490,
   '### Dermatitis formula
- Calendula
- Licorice
- Dong quai
- Gotu kola'),

  (78, 'Licorice in dermatitis formula with calendula, dong quai, gotu kola.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Dermatitis', 500,
   '### Dermatitis formula
- Calendula
- Licorice
- Dong quai
- Gotu kola'),

  (1009, 'Dong Quai in dermatitis formula with calendula, licorice, gotu kola.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Dermatitis', 510,
   '### Dermatitis formula
- Calendula
- Licorice
- Dong quai
- Gotu kola'),

  (2229, 'Gotu kola in dermatitis formula with calendula, licorice, dong quai.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Dermatitis', 520,
   '### Dermatitis formula
- Calendula
- Licorice
- Dong quai
- Gotu kola'),

  -- === PSORIASIS ===
  (11, 'Reishi Mushroom helpful as immune adaptogen for psoriasis; reduce immune response in skin.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Psoriasis', 530,
   '### Herbal Actions for Psoriasis
- Reduce immune response in skin
- Anti-inflammatory, antioxidant
- Alterative, hepatic
- Immune modulation: Reishi helpful as an immune adaptogen
- Specifically liver support
- Supplement with Omega 3 Fatty acid
### Chronic Skin Conditions — Psoriasis
- Autoimmune disorder, thickened skin; affects nail integrity
- Aggravated by smoking and viral infections'),

  (22, 'Burdock in David Hoffmann psoriasis formula (with Yellow Dock and Baical Skullcap). Alterative herb for skin/liver conditions.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Psoriasis', 540,
   '### Psoriasis
- David Hoffmann''s formula: Burdock, Yellow dock, Skullcap
### Psoriasis Materia Medica
- Astragalus membranaceus
- Calendula officinalis
- Centella officinalis
- Glycyrrhiza glabra
- Smilax ornata
- Curcuma longa
- Very similar to eczema formula, but adding sarsaparilla'),

  (37, 'Yellow Dock in David Hoffmann psoriasis formula (with Burdock and Baical Skullcap).',
   'BHC - Class 68 - Integumentary III', 'generated', 'Psoriasis', 550,
   '### Psoriasis
- David Hoffmann''s formula: Burdock, Yellow dock, Skullcap'),

  (40, 'Sarsaparilla added to psoriasis formula to buffer Poke Root and support liver. Psoriasis materia medica (Smilax ornata).',
   'BHC - Class 68 - Integumentary III', 'generated', 'Psoriasis', 560,
   '### Psoriasis Materia Medica
- Smilax ornata (sarsaparilla) — added to buffer Poke and liver
- Very similar to eczema formula, but adding sarsaparilla'),

  (203, 'Turmeric in psoriasis materia medica (Curcuma longa) for anti-inflammatory support.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Psoriasis', 570,
   '### Psoriasis Materia Medica
- Curcuma longa (turmeric)'),

  (206, 'Milk Thistle for psoriasis: always a liver support picture. Go straight for milk thistle when there is a liver support picture.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Psoriasis', 580,
   '### Psoriasis
- Sometimes go straight for Milk Thistle — always a liver support picture'),

  -- === LIVER SUPPORT (AFTERNOON 3) ===
  (206, 'Milk thistle (Silybum marianum) for liver deficiency: fatigue, poor digestion, hormonal imbalances, difficulty processing emotions.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Liver Support', 590,
   '### Herbs for Liver Support
- Milk thistle (Silybum marianum)
- Dandelion root (Taraxacum officinale)
- Schisandra (Schisandra chinensis)
### Emotional Processing and Liver Connection
- Liver associated with processing emotions, particularly anger
- Calming herbs: lemon balm, passionflower'),

  (122, 'Dandelion root (Taraxacum officinale) for liver support; goji berry + dandelion root for bitter liver support and nourishment.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Liver Support', 600,
   '### Herbs for Liver Support
- Milk thistle (Silybum marianum)
- Dandelion root (Taraxacum officinale)
- Schisandra (Schisandra chinensis)'),

  (17, 'Schizandra (Schisandra chinensis) for liver support in liver deficiency conditions.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Liver Support', 610,
   '### Herbs for Liver Support
- Milk thistle (Silybum marianum)
- Dandelion root (Taraxacum officinale)
- Schisandra (Schisandra chinensis)');

END $$;

-- ============================================================
-- PERSONAL NOTES SNIPPETS (Lisa.md)
-- ============================================================

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE class_name = 'BHC - Class 68 - Integumentary III'
               AND note_type = 'personal') THEN
    RAISE NOTICE 'Class 68 personal snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- === MUSCULO CASE STUDY ===
  (2624, 'Pedicularis for teeth grinding: higher dose to start to unwind (60mL), then taper off to 35-40mL. First-line for tension release; also in formula Pedicularis + Black Cohosh + Ginger for acute muscle tension.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 10,
   '- pedicularis - for teeth grinding, higher dose to start to unwind, then taper off - 60mL -> 35-40mL in that
- Pedicularis + Black Cohosh + Ginger -> acute muscle tension
- pedicularis - higher dose than 20d'),

  (42, 'Red clover improves bone density in post-menopause. Complex herb — hot water infusion necessary to break cell walls.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 20,
   '- red clover - improves bone density in post-menopause
- red clover - complex, so hot water necessary to break cell walls (infusion)'),

  (2287, 'Oat straw: need to break the cell walls to get it out — requires heat and long infusion. Needs to be green and freshly dried.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 30,
   '- oat straw - need to break the cell walls to get it out with heat - long infusion
- Oat Straw - really needs to be green and freshly dried'),

  (54, 'Elecampane: targeting the lungs but not cough specifically. If cough is present, add Wild Cherry.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 40,
   '- elecampane - targeting the lungs but not cough specifically
  - with cough = Wild Cherry'),

  (140, 'Wild Cherry Bark: added to elecampane formula specifically when cough is present.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 50,
   '- elecampane - targeting the lungs but not cough specifically
  - with cough = Wild Cherry'),

  (58, 'Goldenrod: astringent and anti-inflammatory for allergies.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 60,
   '- goldenrod = astringent and AI - allergies'),

  (25, 'Black cohosh: specific for back tension. Maximum 25 drops per dose is best. Can actually cause headaches if dose too high. In acute muscle tension formula: Pedicularis + Black Cohosh + Ginger.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 70,
   '- black cohosh - specific for back tension
- black cohosh - can actually cause headaches if dose too high
- Black Cohosh - max 25 drops/dose is best
- Pedicularis + Black Cohosh + Ginger -> acute muscle tension'),

  (61, 'Mullein: prefer flowers over leaf for nourishing and moistening. Mullein leaf hairs cause irritation when not well-strained.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 80,
   '- prefer mullein flowers to leaf - for nourishing and moistening
  - mullein leaf hairs when not well-strained'),

  (81, 'St. John''s Wort oil: used in gua sha with CBD for stress relief. Also used as oilination (SJW oilination -> relieve stress).',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 90,
   '- gua sha with SJW oil and CBD
- SJW oilination -> relieve stress'),

  (11, 'Reishi mushroom: needs water in the extraction — alcohol only, you lose the complexity of the constituents.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 100,
   '- reishi - you need water in the extraction
  - alcohol only, you lose the complexity of the constituents'),

  (1597, 'Frankincense: boswellic acid for joint inflammation. Salve with frankincense and arnica for topical anti-inflammatory application.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 110,
   '- frankincense - boswellic acid - joint inflammation
  - salve with that and arnica'),

  (114, 'Arnica in salve with frankincense for topical joint inflammation treatment.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 120,
   '- frankincense - boswellic acid - joint inflammation
  - salve with that and arnica'),

  (131, 'Motherwort: cooling to the thyroid if heat agitation. Also for grief support alongside mimosa and bleeding heart.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 130,
   '- motherwort cooling to the thyroid, if heat agitation
- bleeding heart -> grief support
  - mimosa and motherwort as well'),

  (2285, 'Mimosa for grief support alongside bleeding heart and motherwort.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 140,
   '- bleeding heart -> grief support
  - mimosa and motherwort as well'),

  (850, 'Rose flower essence (FE) for grief support.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 150,
   '- Rose FE -> grief'),

  (1548, 'Wolfberry fruit (goji berry) combined with dandelion root for bitter liver support and nourishment; adds depth and flavor to mineral tea.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 160,
   '- Goji berry + dandelion root -> bitter liver support and nourishment, depth and flavor to mineral tea'),

  (14, 'Panax Ginseng as adaptogen/immunomodulator; use as long as patient is resourced and getting enough other nourishment.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 170,
   '- Panax Ginseng - as long as resourced and getting enough other nourishment'),

  -- === LISA PATIENT CASE ===
  (178, 'Lisa patient case — tonic tincture: milky oats, hawthorn leaf/flower, shatavari, gotu kola, bleeding heart, black cohosh, linden glycerite. Would add Bacopa and Mimosa now (anti-inflammatory, nourishing the heart and nervous system). Patient: loss of tissue flexibility, grief, creativity block.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Lisa (Patient Case)', 180,
   '## Lisa
- Loss of tissue flexibility
- Prioritize grief piece
- Holding back on exploring creativity
- Tincture:
  - Milky oats
  - Hawthorn leaf/flower
  - Shatavari
  - Gotu kola
  - Bleeding heart
  - Black cohosh
  - Linden glycerite
  - (would add Bacopa now and Mimosa)
    - AI and nourishing the heart and NS
- Sleep tincture:
  - Pedicularis
  - Jamaican Dogwood
  - Catnip glycerite'),

  (2461, 'Jamaican Dogwood in Lisa''s sleep tincture with Pedicularis and Catnip glycerite.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Lisa (Patient Case)', 190,
   '## Lisa
- Sleep tincture:
  - Pedicularis
  - Jamaican Dogwood
  - Catnip glycerite'),

  (136, 'Catnip glycerite in Lisa''s sleep tincture with Pedicularis and Jamaican Dogwood.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Lisa (Patient Case)', 200,
   '## Lisa
- Sleep tincture:
  - Pedicularis
  - Jamaican Dogwood
  - Catnip glycerite'),

  -- === HAIR AND NAILS (AFTERNOON) ===
  (151, 'Horsetail for hair strength.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Hair Care', 210,
   '### Hair and Nails
- hair strength:
  - horsetail
  - rosemary
  - alfalfa
  - gotu kola
  - prickly ash
- hair loss in AFAB: metabolic, thyroid hormones
- brushing hair has a great effect on the hair shaft strength'),

  (109, 'Rosemary for hair strength. Also antimicrobial in wound wash context.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Hair Care', 220,
   '### Hair and Nails
- hair strength:
  - horsetail
  - rosemary
  - alfalfa
  - gotu kola
  - prickly ash'),

  -- === SKIN pH AND OILINATION ===
  (70, 'Calendula infused oilination for skin pH maintenance and tissue nourishment.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Skin pH and Oilination', 230,
   '### pH
- 4.2 - 4.0 best pH
- Oilination helps the skin maintain its pH and nourish the tissues:
  - Calendula infused oilination
  - Coconut oil topically (may penetrate biofilms of fungus)
  - Gotu Kola oil
  - Mugwort added to oils
  - Rosehip oil — specific for holding that pH
  - Jojoba'),

  (115, 'Mugwort added to skin oils for pH maintenance and antimicrobial benefit.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Skin pH and Oilination', 240,
   '### pH
- Oilination helps the skin maintain its pH and nourish the tissues:
  - Mugwort added to oils'),

  (849, 'Rosehip oil: specific for holding skin pH (4.2-4.0). Use in oilination protocols to maintain acid mantle.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Skin pH and Oilination', 250,
   '### pH
- Rosehip oil — specific for holding that pH
- Oilination helps the skin maintain its pH and nourish the tissues'),

  -- === WOUND WASH — ASTRINGENTS ===
  (46, 'Bearberry (Arctostaphylos/uva ursi family): astringent for wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 260,
   '### Wound Wash
- Astringent: Arctostaphylos family (uva ursi, etc), Witch Hazel, Rose family, Oak, Green Tea, Sage, Chamomile, Red Root, Willow, Yarrow
- Antimicrobial: Mugwort, Chaparral, Myrrh, Goldenseal, Garlic, Baptisia, Tea tree, Yarrow, Lavender, Rosemary, Tansy, Coptis, Thyme, Chamomile, Barberry, Oregon Grape, Yerba Mansa, Spilanthes, Hops
- Vulnerary: Gotu kola, Plantain, Calendula, Lavender, Burdock, Helichrysum, Golden Rod, Chamomile, Self Heal, Chickweed, St Johns Wort, Marshmallow, Comfrey (for shallow stuff)
### Concepts from the Wound Care Clinic
- "Harm Reduction Protocol" actions: antimicrobial, vulnerary, astringent (and warmth to stimulate circulation)'),

  (79, 'Witch Hazel: astringent for wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 270,
   '### Wound Wash
- Astringent: Arctostaphylos family (uva ursi, etc), Witch Hazel, Rose family, Oak, Green Tea, Sage, Chamomile, Red Root, Willow, Yarrow'),

  (153, 'Oak: astringent for wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 280,
   '### Wound Wash
- Astringent: Oak, Green Tea, Sage, Chamomile, Red Root, Willow, Yarrow'),

  (149, 'Green Tea (Camellia sinensis): astringent for wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 290,
   '### Wound Wash
- Astringent: Green Tea, Sage, Chamomile, Red Root, Willow, Yarrow'),

  (981, 'Red Root: astringent for wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 300,
   '### Wound Wash
- Astringent: Red Root, Willow, Yarrow'),

  (44, 'Yarrow: astringent and antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 310,
   '### Wound Wash
- Astringent: Willow, Yarrow
- Antimicrobial: Yarrow'),

  -- WOUND WASH — ANTIMICROBIALS
  (32, 'Chaparral: antimicrobial in wound wash. Also antioxidant for chronic skin conditions; beware — hard on liver.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 320,
   '### Wound Wash
- Antimicrobial: Mugwort, Chaparral, Myrrh, Goldenseal, Garlic, Baptisia, Tea tree, Yarrow, Lavender, Rosemary, Tansy, Coptis, Thyme, Chamomile, Barberry, Oregon Grape, Yerba Mansa, Spilanthes, Hops
### More herbal actions
- Antioxidant: great example — Chaparral (beware hard on liver)'),

  (99, 'Myrrh: antimicrobial in wound wash and immune stimulant for complex skin conditions (dermatitis, eczema, psoriasis).',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 330,
   '### Wound Wash
- Antimicrobial: Myrrh
### More herbal actions
- Immune stimulant: Frankincense, Myrrh'),

  (30, 'Goldenseal: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 340,
   '### Wound Wash
- Antimicrobial: Goldenseal'),

  (23, 'Wild Indigo (Baptisia): antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 350,
   '### Wound Wash
- Antimicrobial: Baptisia Tea tree'),

  (302, 'Tea Tree: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 360,
   '### Wound Wash
- Antimicrobial: Baptisia Tea tree'),

  (161, 'Tansy: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 370,
   '### Wound Wash
- Antimicrobial: Tansy'),

  (1561, 'Coptis Rhizome: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 380,
   '### Wound Wash
- Antimicrobial: Coptis'),

  (158, 'Barberry: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 390,
   '### Wound Wash
- Antimicrobial: Barberry, Oregon Grape, Yerba Mansa, Spilanthes'),

  (33, 'Oregon Grape: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 400,
   '### Wound Wash
- Antimicrobial: Oregon Grape, Yerba Mansa, Spilanthes'),

  (309, 'Yerba Mansa: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 410,
   '### Wound Wash
- Antimicrobial: Yerba Mansa, Spilanthes'),

  (2363, 'Spilanthes: antimicrobial in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 420,
   '### Wound Wash
- Antimicrobial: Spilanthes'),

  -- WOUND WASH — VULNERARIES
  (85, 'Plantain: vulnerary in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 430,
   '### Wound Wash
- Vulnerary: Gotu kola, Plantain, Calendula, Lavender, Burdock, Helichrysum, Golden Rod, Chamomile, Self Heal, Chickweed, St Johns Wort, Marshmallow, Comfrey (for shallow stuff)'),

  (831, 'Helichrysum: vulnerary in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 440,
   '### Wound Wash
- Vulnerary: Helichrysum, Golden Rod, Chamomile, Self Heal, Chickweed, St Johns Wort, Marshmallow, Comfrey'),

  (2437, 'Self Heal (Prunella vulgaris): vulnerary in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 450,
   '### Wound Wash
- Vulnerary: Self Heal, Chickweed, St Johns Wort, Marshmallow, Comfrey'),

  (88, 'Chickweed: vulnerary in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 460,
   '### Wound Wash
- Vulnerary: Chickweed, St Johns Wort, Marshmallow, Comfrey'),

  (45, 'Marshmallow: vulnerary in wound wash.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Wound Care', 470,
   '### Wound Wash
- Vulnerary: Marshmallow, Comfrey (for shallow stuff)'),

  -- === ECZEMA (PERSONAL NOTES) ===
  (225, 'Astragalus in eczema and psoriasis materia medica.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Eczema', 480,
   '### Eczema Materia medica
- Astragalus
- Calendula
- Gotu kola
- Licorice
- Nettle
- Feverfew
- Celery seed — help the body liquify and eliminate waste through the bowel'),

  (43, 'Nettle in eczema materia medica.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Eczema', 490,
   '### Eczema Materia medica
- Nettle'),

  -- === PSORIASIS (PERSONAL NOTES) ===
  (2274, 'Chinese (Baical) Skullcap in David Hoffmann psoriasis prescription. Also add Vervain if anxiety present. If no change in tissue, add Poke Root 1 drop increasing, with Sarsaparilla to buffer.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Psoriasis', 500,
   '### Herbal Actions for Psoriasis
- David Hoffman Prescription:
  - Burdock
  - Yellow Dock
  - Baical Skullcap
  - if with anxiety: add Verbena (Vervain)
  - if no change in tissue, add Poke 1 drop, then 2.. and add Sarsaparilla to buffer the Poke and liver
- Sometimes go straight for Milk Thistle — always a liver support picture
- Topical: Juniper — maybe shampoo'),

  (146, 'Vervain added to David Hoffmann psoriasis formula when anxiety is present alongside psoriasis.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Psoriasis', 510,
   '### Herbal Actions for Psoriasis
- David Hoffman Prescription:
  - Burdock, Yellow Dock, Baical Skullcap
  - if with anxiety: add Verbena (Vervain)'),

  (103, 'Juniper topically for psoriasis — maybe as shampoo for scalp psoriasis.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Psoriasis', 520,
   '### Herbal Actions for Psoriasis
- Topical: Juniper — maybe shampoo');

END $$;

-- ============================================================
-- SUPPLEMENT SNIPPETS
-- ============================================================

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE supplement_id = 21
               AND class_name = 'BHC - Class 68 - Integumentary III') THEN
    RAISE NOTICE 'Class 68 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
  (21, 'Magnesium (Natural Calm) at night: helps with calcium and vitamin D absorption. Weight training recommended alongside for bone density.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Protein and Gut Health', 10,
   '## Protein and Gut Health
- Supplements: Magnesium — helps with calcium and vitamin D absorption
- Magnesium "Natural Calm" at night'),

  (11, 'Vitamin D: test levels and supplement if needed. Skin activates vitamin D when sun hits.',
   'BHC - Class 68 - Integumentary III', 'generated', 'Protein and Gut Health', 20,
   '## Testing and Results
- Tested for vitamin D levels — recommended supplement if needed
### Skin Function
- Activates vitamin D when sun hits the skin'),

  (33, 'Fish oil: on the road to moistening (but add moistening herbs too).',
   'BHC - Class 68 - Integumentary III', 'personal', 'Musculo Case Study', 30,
   '- Fish oil -> on the road to moistening (but add moistening herbs too)'),

  (42, 'Evening primrose oil for premature gray hair recovery.',
   'BHC - Class 68 - Integumentary III', 'personal', 'Hair Care', 40,
   '- gray hair — evening primrose oil for premature gray');

END $$;

-- ============================================================
-- HERB KEYWORDS
-- ============================================================

-- Nourishing Tea / Bone density
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43,   'bone density',       'ailment'),
  (43,   'mineral support',    'ailment'),
  (2287, 'bone density',       'ailment'),
  (2287, 'mineral support',    'ailment'),
  (42,   'bone density',       'ailment'),
  (42,   'post-menopause',     'ailment'),
  (151,  'bone density',       'ailment'),
  (151,  'mineral support',    'ailment'),
  (151,  'hair loss',          'ailment'),
  (885,  'bone density',       'ailment'),
  (885,  'mineral support',    'ailment'),
  (885,  'hair loss',          'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pain / anti-inflammatory
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (87,   'chronic pain',       'ailment'),
  (87,   'anti-inflammatory',  'action'),
  (124,  'chronic pain',       'ailment'),
  (124,  'anti-inflammatory',  'action'),
  (203,  'chronic pain',       'ailment'),
  (203,  'anti-inflammatory',  'action'),
  (203,  'psoriasis',          'ailment'),
  (203,  'eczema',             'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Stress / anxiety / sleep
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (9,    'stress',             'ailment'),
  (9,    'anxiety',            'ailment'),
  (9,    'adaptogen',          'action'),
  (13,   'stress',             'ailment'),
  (13,   'anxiety',            'ailment'),
  (13,   'adaptogen',          'action'),
  (137,  'insomnia',           'symptom'),
  (137,  'sleep support',      'ailment'),
  (137,  'anxiety',            'ailment'),
  (20,   'sleep support',      'ailment'),
  (20,   'anxiety',            'ailment'),
  (20,   'adaptogen',          'action'),
  (138,  'sleep support',      'ailment'),
  (138,  'insomnia',           'symptom'),
  (81,   'depression',         'ailment'),
  (81,   'anti-inflammatory',  'action'),
  (983,  'muscle spasms',      'ailment'),
  (983,  'stress',             'ailment'),
  (983,  'hepatic',            'action'),
  (2381, 'brain fog',          'ailment'),
  (2381, 'anti-inflammatory',  'action'),
  (2285, 'stress',             'ailment'),
  (2285, 'grief support',      'general'),
  (2285, 'eczema',             'ailment'),
  (2285, 'mast cell stabilizing', 'action'),
  (142,  'muscle spasms',      'ailment'),
  (142,  'sleep support',      'ailment'),
  (178,  'muscle spasms',      'ailment'),
  (178,  'stress',             'ailment'),
  (134,  'stress',             'ailment'),
  (134,  'liver support',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Grief support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2612, 'grief support',      'general'),
  (1652, 'grief support',      'general'),
  (1652, 'cardiovascular disease', 'ailment'),
  (131,  'grief support',      'general'),
  (131,  'hyperthyroidism',    'ailment'),
  (850,  'grief support',      'general')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pedicularis / muscle
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2624, 'muscle spasms',      'ailment'),
  (2624, 'teeth grinding',     'symptom'),
  (2624, 'chronic pain',       'ailment'),
  (2624, 'sleep support',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Black cohosh
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (25,   'muscle spasms',      'ailment'),
  (25,   'anti-inflammatory',  'action'),
  (25,   'alterative',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Post-menopause / hormonal
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (129,  'post-menopause',     'ailment'),
  (129,  'estrogen support',   'ailment'),
  (129,  'sleep support',      'ailment'),
  (225,  'post-menopause',     'ailment'),
  (225,  'adaptogen',          'action'),
  (852,  'post-menopause',     'ailment'),
  (852,  'perimenopause',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Frankincense / arnica / joint
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1597, 'arthritis',          'ailment'),
  (1597, 'chronic pain',       'ailment'),
  (1597, 'anti-inflammatory',  'action'),
  (1597, 'psoriasis',          'ailment'),
  (1597, 'eczema',             'ailment'),
  (114,  'arthritis',          'ailment'),
  (114,  'chronic pain',       'ailment'),
  (114,  'wound healing',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hair care
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2229, 'hair loss',          'ailment'),
  (2229, 'connective tissue disorders', 'ailment'),
  (2229, 'connective tissue tonic', 'action'),
  (2229, 'eczema',             'ailment'),
  (2229, 'psoriasis',          'ailment'),
  (2229, 'dermatitis',         'ailment'),
  (2229, 'wound healing',      'ailment'),
  (123,  'hair loss',          'ailment'),
  (123,  'circulatory stimulant', 'action'),
  (123,  'poor circulation',   'ailment'),
  (885,  'hair loss',          'ailment'),
  (1139, 'hair loss',          'ailment'),
  (151,  'hair loss',          'ailment'),
  (109,  'hair loss',          'ailment'),
  (109,  'skin infection',     'ailment'),
  (109,  'antimicrobial',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Skin / integumentary
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70,   'eczema',             'ailment'),
  (70,   'rosacea',            'ailment'),
  (70,   'dermatitis',         'ailment'),
  (70,   'psoriasis',          'ailment'),
  (70,   'wound healing',      'ailment'),
  (70,   'vulnerary',          'action'),
  (200,  'skin conditions',    'ailment'),
  (165,  'skin conditions',    'ailment'),
  (165,  'wound healing',      'ailment'),
  (165,  'circulatory stimulant', 'action'),
  (165,  'poor circulation',   'ailment'),
  (78,   'eczema',             'ailment'),
  (78,   'dermatitis',         'ailment'),
  (78,   'psoriasis',          'ailment'),
  (78,   'anti-inflammatory',  'action'),
  (849,  'skin conditions',    'ailment'),
  (115,  'antimicrobial',      'action'),
  (115,  'skin conditions',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dong Quai integumentary
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1009, 'circulatory stimulant', 'action'),
  (1009, 'emmenagogue',        'action'),
  (1009, 'eczema',             'ailment'),
  (1009, 'dermatitis',         'ailment'),
  (1009, 'photosensitivity',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Eczema herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2238, 'eczema',             'ailment'),
  (2238, 'mast cell stabilizing', 'action'),
  (2274, 'eczema',             'ailment'),
  (2274, 'psoriasis',          'ailment'),
  (2274, 'mast cell stabilizing', 'action'),
  (121,  'eczema',             'ailment'),
  (66,   'eczema',             'ailment'),
  (35,   'eczema',             'ailment'),
  (35,   'psoriasis',          'ailment'),
  (35,   'lymphatic support',  'ailment'),
  (1650, 'eczema',             'ailment'),
  (1650, 'wound healing',      'ailment'),
  (1650, 'vulnerary',          'action'),
  (43,   'eczema',             'ailment'),
  (225,  'eczema',             'ailment'),
  (225,  'psoriasis',          'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Psoriasis herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11,   'psoriasis',          'ailment'),
  (11,   'eczema',             'ailment'),
  (11,   'autoimmune disease', 'ailment'),
  (22,   'psoriasis',          'ailment'),
  (22,   'alterative',         'action'),
  (22,   'vulnerary',          'action'),
  (37,   'psoriasis',          'ailment'),
  (37,   'alterative',         'action'),
  (40,   'psoriasis',          'ailment'),
  (206,  'psoriasis',          'ailment'),
  (206,  'liver support',      'ailment'),
  (146,  'psoriasis',          'ailment'),
  (103,  'psoriasis',          'ailment'),
  (103,  'skin conditions',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Wound wash herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (46,   'wound healing',      'ailment'),
  (46,   'astringent',         'action'),
  (79,   'wound healing',      'ailment'),
  (79,   'astringent',         'action'),
  (153,  'wound healing',      'ailment'),
  (153,  'astringent',         'action'),
  (149,  'wound healing',      'ailment'),
  (149,  'astringent',         'action'),
  (56,   'wound healing',      'ailment'),
  (56,   'astringent',         'action'),
  (84,   'wound healing',      'ailment'),
  (84,   'astringent',         'action'),
  (84,   'vulnerary',          'action'),
  (84,   'antimicrobial',      'action'),
  (981,  'wound healing',      'ailment'),
  (981,  'astringent',         'action'),
  (44,   'wound healing',      'ailment'),
  (44,   'astringent',         'action'),
  (44,   'antimicrobial',      'action'),
  (115,  'wound healing',      'ailment'),
  (32,   'wound healing',      'ailment'),
  (32,   'antimicrobial',      'action'),
  (99,   'wound healing',      'ailment'),
  (99,   'antimicrobial',      'action'),
  (30,   'wound healing',      'ailment'),
  (30,   'antimicrobial',      'action'),
  (23,   'wound healing',      'ailment'),
  (23,   'antimicrobial',      'action'),
  (302,  'wound healing',      'ailment'),
  (302,  'antimicrobial',      'action'),
  (161,  'wound healing',      'ailment'),
  (161,  'antimicrobial',      'action'),
  (1561, 'wound healing',      'ailment'),
  (1561, 'antimicrobial',      'action'),
  (158,  'wound healing',      'ailment'),
  (158,  'antimicrobial',      'action'),
  (33,   'wound healing',      'ailment'),
  (33,   'antimicrobial',      'action'),
  (309,  'wound healing',      'ailment'),
  (309,  'antimicrobial',      'action'),
  (2363, 'wound healing',      'ailment'),
  (2363, 'antimicrobial',      'action'),
  (129,  'wound healing',      'ailment'),
  (129,  'antimicrobial',      'action'),
  (85,   'wound healing',      'ailment'),
  (85,   'vulnerary',          'action'),
  (831,  'wound healing',      'ailment'),
  (831,  'vulnerary',          'action'),
  (2437, 'wound healing',      'ailment'),
  (2437, 'vulnerary',          'action'),
  (88,   'wound healing',      'ailment'),
  (88,   'vulnerary',          'action'),
  (81,   'wound healing',      'ailment'),
  (81,   'vulnerary',          'action'),
  (45,   'wound healing',      'ailment'),
  (45,   'vulnerary',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Liver support
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (206,  'liver support',      'ailment'),
  (122,  'liver support',      'ailment'),
  (17,   'liver support',      'ailment'),
  (134,  'liver support',      'ailment'),
  (1548, 'liver support',      'ailment'),
  (37,   'liver support',      'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Elecampane / wild cherry
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (54,   'chronic lung disease', 'ailment'),
  (54,   'respiratory infection', 'ailment'),
  (140,  'chronic cough',      'ailment'),
  (140,  'respiratory infection', 'ailment'),
  (58,   'hay fever',          'ailment'),
  (58,   'astringent',         'action'),
  (58,   'anti-inflammatory',  'action'),
  (58,   'vulnerary',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi (skin/immune)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11,   'immune support',     'ailment'),
  (11,   'adaptogen',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Sleep tincture herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2461, 'sleep support',      'ailment'),
  (2461, 'muscle spasms',      'ailment'),
  (136,  'sleep support',      'ailment'),
  (136,  'anxiety',            'ailment'),
  (90,   'sleep support',      'ailment'),
  (90,   'stress',             'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Supplement keywords
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (21,  'bone density',        'ailment'),
  (21,  'mineral support',     'ailment'),
  (11,  'bone density',        'ailment'),
  (11,  'hair loss',           'ailment'),
  (33,  'perimenopause',       'ailment'),
  (33,  'post-menopause',      'ailment'),
  (33,  'inflammation',        'ailment'),
  (42,  'hair loss',           'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- ============================================================
-- AILMENT SEARCH TERMS (new keywords only)
-- ============================================================

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('eczema',
   ARRAY['atopic dermatitis', 'atopic eczema', 'itch that rashes', 'skin inflammation', 'dermatitis eczema']),
  ('psoriasis',
   ARRAY['plaque psoriasis', 'autoimmune skin condition', 'scaly skin', 'skin plaques', 'psoriatic disease']),
  ('dermatitis',
   ARRAY['contact dermatitis', 'skin inflammation', 'allergic skin reaction', 'skin rash', 'eczematous dermatitis']),
  ('rosacea',
   ARRAY['facial redness', 'facial flushing', 'skin redness', 'acne rosacea']),
  ('post-menopause',
   ARRAY['postmenopause', 'post menopausal', 'after menopause', 'menopausal', 'climacteric'])
ON CONFLICT (ailment_keyword) DO NOTHING;
