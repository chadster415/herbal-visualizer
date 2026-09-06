-- Migration 252: BHC Class 45 — Liver Detox Pathways and Starting an Herbal Business
-- Class date: 2026-07-22
-- class_name: 'BHC - Class 45 - Liver Detox Pathways and Starting an Herbal Business'
--
-- Files parsed:
--   BHC - Class 45 - … - Generated Notes.md (note_type = 'generated')
--   BHC - Class 45 - … - Lisa Lauren.md     (note_type = 'personal')
--   BHC - Class 45 - … - Transcript.md      IGNORED
--
-- Herb normalisations:
--   "Schisandra" / "schisandra"  → Schizandra (Schisandra chinensis, id=17)
--   "OGR (berberine)"            → Oregon Grape (Mahonia aquifolium, id=33)
--   "Orange Peel"                → Sweet Orange (Citrus sinensis, id=748)
--   "Tulsi"                      → Holy Basil (Ocimum sanctum, id=13)
--
-- Skipped — not in DB:
--   Andrographis paniculata — full personal notes materia medica section; not yet in herbs table
--   Berberine — generated notes "## Berberine" section discusses the compound; no standalone
--               herb/supplement entry; clinical content captured via Oregon Grape Root from
--               personal notes (where OGR is named explicitly)
--   Glutathione, cysteine, glycine, taurine — listed as Phase I/II liver nutrients but
--               not in herbal.supplements table
--
-- New ailment keywords introduced this class:
--   hepatitis, fatty liver disease, gallstones, food poisoning, SIBO, liver congestion,
--   jaundice, metabolic syndrome, cancer support, type 2 diabetes, hyperlipidemia, fatigue,
--   sleep support, liver tenderness, biliary pain
--
-- Keyword merge decisions:
--   "acne" / "skin disorders" / "hives from contact allergy" → 'skin conditions' (existing)
--   "exhaustion and debility" / "adrenal insufficiency"       → 'adrenal fatigue' (existing)
--   "mushroom poisoning" / "acetaminophen toxicity"           → 'acute illness' (existing)
--   "hormone clearance"                                        → 'estrogen metabolism' (existing)
--   "MRSA treatment"                                           → 'antimicrobial' action only
--   "candida" / "fungal overgrowth"                            → folded under 'SIBO' (new)
--   "biliary pain"                                             → new symptom keyword
--
-- No herb pairs found: the liver tea formula (Burdock, Astragalus, Dandelion, Orange Peel,
--   Fennel, Licorice) is a multi-herb formula — no qualifying two-herb pair noted.

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Snippets (herbs + supplements)
-- ============================================================
DO $$
DECLARE
  v_class CONSTANT TEXT := 'BHC - Class 45 - Liver Detox Pathways and Starting an Herbal Business';

  -- Herb IDs (resolved below)
  v_dandelion_rt  INTEGER;
  v_burdock       INTEGER;
  v_licorice      INTEGER;
  v_fennel        INTEGER;
  v_sweet_orange  INTEGER;
  v_schizandra    INTEGER;
  v_milk_thistle  INTEGER;
  v_turmeric      INTEGER;
  v_oregon_grape  INTEGER;
  v_astragalus    INTEGER;
  v_nettle_lf     INTEGER;
  v_chamomile     INTEGER;
  v_holy_basil    INTEGER;
  v_lavender      INTEGER;
  v_horsetail     INTEGER;
  v_oat_straw     INTEGER;

  -- Supplement IDs (resolved below)
  v_vit_b2     INTEGER;
  v_vit_b3     INTEGER;
  v_vit_b6     INTEGER;
  v_vit_b12    INTEGER;
  v_vit_b9     INTEGER;
  v_methionine INTEGER;
  v_vit_c      INTEGER;
  v_magnesium  INTEGER;
  v_vit_b_cpx  INTEGER;

  -- Source blocks
  v_sb_gen_liver_support   TEXT;
  v_sb_gen_detox_pathways  TEXT;
  v_sb_gen_liver_treatment TEXT;
  v_sb_gen_milk_thistle    TEXT;
  v_sb_gen_herbs_liver     TEXT;
  v_sb_gen_turmeric        TEXT;
  v_sb_gen_business        TEXT;
  v_sb_per_liver           TEXT;
  v_sb_per_detox_pathways  TEXT;
  v_sb_per_mafld           TEXT;
  v_sb_per_milk_thistle    TEXT;
  v_sb_per_oregon_grape    TEXT;
  v_sb_per_licorice        TEXT;
  v_sb_per_turmeric        TEXT;
  v_sb_per_business        TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 45 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ── Resolve herb IDs ──────────────────────────────────────────────────────
  SELECT id INTO v_dandelion_rt FROM herbal.herbs
    WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'root' LIMIT 1;
  SELECT id INTO v_burdock      FROM herbal.herbs WHERE latin_name = 'Arctium lappa'         LIMIT 1;
  SELECT id INTO v_licorice     FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra'    LIMIT 1;
  SELECT id INTO v_fennel       FROM herbal.herbs WHERE latin_name = 'Foeniculum vulgare'    LIMIT 1;
  SELECT id INTO v_sweet_orange FROM herbal.herbs WHERE latin_name = 'Citrus sinensis'       LIMIT 1;
  SELECT id INTO v_schizandra   FROM herbal.herbs WHERE latin_name = 'Schisandra chinensis'  LIMIT 1;
  SELECT id INTO v_milk_thistle FROM herbal.herbs WHERE latin_name = 'Silybum marianum'      LIMIT 1;
  SELECT id INTO v_turmeric     FROM herbal.herbs WHERE latin_name = 'Curcuma longa'         LIMIT 1;
  SELECT id INTO v_oregon_grape FROM herbal.herbs WHERE latin_name = 'Mahonia aquifolium'    LIMIT 1;
  SELECT id INTO v_astragalus   FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus' LIMIT 1;
  SELECT id INTO v_nettle_lf    FROM herbal.herbs
    WHERE latin_name = 'Urtica dioica' AND plant_part = 'leaf' LIMIT 1;
  SELECT id INTO v_chamomile    FROM herbal.herbs WHERE latin_name = 'Matricaria recutita'   LIMIT 1;
  SELECT id INTO v_holy_basil   FROM herbal.herbs WHERE latin_name = 'Ocimum sanctum'        LIMIT 1;
  SELECT id INTO v_lavender     FROM herbal.herbs WHERE latin_name ILIKE 'Lavandula%'        LIMIT 1;
  SELECT id INTO v_horsetail    FROM herbal.herbs WHERE latin_name = 'Equisetum arvense'     LIMIT 1;
  SELECT id INTO v_oat_straw    FROM herbal.herbs
    WHERE latin_name = 'Avena sativa' AND plant_part = 'straw' LIMIT 1;

  -- ── Resolve supplement IDs ────────────────────────────────────────────────
  SELECT id INTO v_vit_b2     FROM herbal.supplements WHERE name = 'Vitamin B2 (Riboflavin)';
  SELECT id INTO v_vit_b3     FROM herbal.supplements WHERE name = 'Vitamin B3 (Niacin)';
  SELECT id INTO v_vit_b6     FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)';
  SELECT id INTO v_vit_b12    FROM herbal.supplements WHERE name = 'Vitamin B12';
  SELECT id INTO v_vit_b9     FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)';
  SELECT id INTO v_methionine FROM herbal.supplements WHERE name = 'Methionine';
  SELECT id INTO v_vit_c      FROM herbal.supplements WHERE name = 'Vitamin C';
  SELECT id INTO v_magnesium  FROM herbal.supplements WHERE name = 'Magnesium';
  SELECT id INTO v_vit_b_cpx  FROM herbal.supplements WHERE name = 'Vitamin B Complex';

  -- ── Define source blocks ──────────────────────────────────────────────────

  v_sb_gen_liver_support := $blk$## Herbal Remedies for Liver Support
- **Dandelion root**
	- Tonic for liver tenderness
	- Replace coffee with toasted dandelion and burdock
- **Licorice**
	- Supports metabolism
- **Fennel seed** and Orange peel
	- Carminatives, aid digestive function$blk$;

  v_sb_gen_detox_pathways := $blk$## Liver Detoxification Pathways
- Phase I
	- Detoxes fat-soluble substances
	- Utilizes cytochrome P450
	- Requires
		- Vitamins B2, B3, B6, B12
		- Folic acid, glutathione, flavonoids
- Phase II
	- Sulfation, glutathione conjugation
	- Requires
		- Methionine, cysteine, magnesium
		- Vitamin C, glycine, taurine
- Nutrients that aid detox
	- **Schizandra**: antioxidant, hepatoprotective
	- Cruciferous vegetables: broccoli, cabbage
	- Alliums: onions, garlic$blk$;

  v_sb_gen_liver_treatment := $blk$## Liver Treatment Preferences
- Dairy as an inflammatory food
- Choice between **dandelion tea** and **milk thistle extract**
	- History of chronic exposure to toxins$blk$;

  v_sb_gen_milk_thistle := $blk$## Milk Thistle
- Taken for 3-12 months
- Safe with other medications
- Treats tenderness in liver area/enlarged liver$blk$;

  v_sb_gen_herbs_liver := $blk$## Herbs for Liver Support
- **Alternatives**
	- **Milk thistle**
	- **Dandelion**
	- **Burdock**
- Use for inflammation, elimination of waste$blk$;

  v_sb_gen_turmeric := $blk$## Turmeric
- Due to berberine, helpful for:
	- Hepatitis
	- Metabolic-associated fatty liver disease
	- Inflammation modulation
		- Cooling, antioxidant
	- Cholagogue (bile stimulation)$blk$;

  v_sb_gen_business := $blk$### Oxymel Production
- Recipe for oxymel
- 3 oz nettle
	- 1 oz astragalus
- Bottling date: August 1
- Assign batch number (e.g., 080126 for tracking)

### Tea Production Setup (Sleepy Horsey tea)
- Tea ingredients:
	- **Chamomile**
	- **Tulsi**
	- **Lavender**
	- **Horsetail**

### Record Keeping & Claims
- Claims for "Sleepy Horsey" tea:
	- Supports a calm and clear mind
	- Nourishes skin and nails
	- Promotes tranquilizing sleep$blk$;

  v_sb_per_liver := $blk$## Liver
- throwing in a liver tonic improves so many processes in the body
- tea:
    - 2P Burdock
    - 2P Astragalus
    - 1P Dandelion
    - 1P Orange Peel
    - 1P Fennel
    - 1P Licorice

    - Milk Thistle is our most potent support for the liver
        - super safe, higher doses
        - standardized fluid extract, best for serious conditions
            - silymarin, consistent amount in extract
            - but you can use it as food
            - similar to burdock seed
            - pepper grinder, over savory foods
    - Astragalus
        - nourishing supporting hepatoprotective plant
    - Burdock root
        - nourishing, safe for liver
        - cholagogue (bile stim)
        - gallstones and biliary disease
        - optimizes toxin elimination
        - optimizes nutrient absorption esp fat-sol vitamins
        - helps with "fatty liver disease"
        - spec ind:
            - hyperlipidemia
            - chronic acne, skin disorders, hives from contact allergy
            - fatigue and malaise
    - Dandelion Root
        - nourishing hepatoprotective
        - spec ind:
            - jaundice
            - pain in the gallbladder
            - digestive disturbance in general
            - headache due to liver issues
                - forehead (side of heads is dehydration, base of skull, muscle tension or hormonal)
            - tenderness in liver
            - coated tongue
    - Licorice
        - support metabolism
            - for that person who has started to accumulate adipose tissue w/o change in activity
        - adaptogen
        - harmonizer
    - Fennel Seed
    - Orange Peel
        - carminatives
        - get those secretions going in the upper GI
        - allows for more easy absorption in the small intestine, reduces load on liver$blk$;

  v_sb_per_detox_pathways := $blk$## Liver detox pathways

### Phase 1
- from fat-soluble substances, turn into water-soluble
- nutrients needed:
    - methylated B vitamins - "Methyl Pro" - jumpstart on the liver process, support detox
      (for chronic chemical exposure, medicines in the past, drug use, alcohol)
    - Milk Thistle - high in flavonoids
        - Thorn makes a good capsule extract
        - best to stay away from alcohol (tinctures) for liver support

### Phase 2
- from water-soluble
- Sulfation — need cruciferous veggies and alliums
- Amino Acid Conjugation — putting them in a form to be flushed or utilized
- Methylation — key way to metabolize excess hormones

### Elimination
- Phase 1 first line of defense against toxins (alcohol and caffeine)
    - if Phase 1 isn't strong enough, backs everything up
- schisandra good for antioxidant and hepatoprotective
- key thing for liver support is minimizing irritants (cleaning products, food storage, cosmetics)$blk$;

  v_sb_per_mafld := $blk$## Metabolic Associated Fatty Liver Disease
- accumulation of lipids, part of the picture of metabolic dysregulation
- another part of this picture is blood sugar issues, Diabetes
- caused by the body's own metabolic processes being disrupted, not viruses, etc
- go-tos:
    - all the tea herbs
    - turmeric
    - OGR (berberine)
    - fennel EO topical right on the liver, esp. with tenderness$blk$;

  v_sb_per_milk_thistle := $blk$## Silybum marianum (Milk Thistle)
- Common name: Milk Thistle
- Family: Asteraceae
- Parts used: seed
- Preparation: Tincture, Fluid Extract, Capsules
- Dose:
    - FE: 20-40 drops, to 5x/day
    - Tinc: 1/2-1tsp 4x/day (maybe avoid with liver issues — stick with water-soluble)
    - Capsules: 600 mg/day of standardized extract to 80% silymarin
        (sometimes 400mg with each meal)
    - Acute mushroom poisoning: 5g/day
- Actions:
    - Hepatic
    - Galactagogue
    - Hepatoprotective
    - Anti-hepatotoxic (poisoning: snake bites, mushroom poisoning)
    - Flavonoid compounds (stress-reducing)
    - Antisclerotic (scar-reducing)
    - Restore liver function: toxin exposure, acetaminophen
    - Protects the kidneys
    - During and after chemotherapy (maintenance during; lean in after)
    - Low bilirubin or elevated bilirubin
    - "Anabolic cooler" — calms inability to metabolize fats and proteins$blk$;

  v_sb_per_oregon_grape := $blk$## Oregon Grape Root
- Berberis aquifolium, B. nervosa
- Fresh: 1:2 80-95%
- Dry: 1:5 50%
- Actions:
    - Cholagogue
    - Bitter, part in upper GI
    - Broad antimicrobial — gram negative (E. coli, Salmonella); gram positive (Strep, Staph)
    - Spec for liver congestion and low bile
    - Infectious hepatitis — "travellers" (Hep A)
    - Food poisoning
    - Liver tenderness and slow digestion
    - Accompanies skin eruptions (boils, acne) with coated tongue
    - Can penetrate biofilms: entrenched fungal infection or SIBO (candida in the gut)
    - Anti-protozoal
    - Can potentiate some antibiotics → good for MRSA treatment$blk$;

  v_sb_per_licorice := $blk$## Licorice
- Glycyrrhiza glabra
- Family: Fabaceae
- Parts used: dried root
- Prep: decoction, tincture, fluid extract
- Dose:
    - Decoction: 1 tsp root : 1 cup water
    - Tinc or FE: 10-20 drops, 3x/day
- Caution: may aggravate BP in people with potassium imbalance
- Actions:
    - Adapts cortisol regulation (hypo or hyper) when cortisol is a factor in metabolic syndrome
    - Improves insulin resistance
    - Maintains HPA axis communication in hypo and hyper function
    - General for exhaustion and debility
    - Immune modulator
    - Adrenal insufficiency caused by aging (scaffolded by protein/foundation support)$blk$;

  v_sb_per_turmeric := $blk$## Turmeric
- Curcuma longa
- Parts used: Rhizome
- Capsules: up to 500mg 2-4x/day
- Golden milk: 1-2 tsp in milk up to 5x/day
- Enhance absorption with black pepper and some kind of fat
- Actions:
    - Antioxidant (AO)
    - Antilipidemic
    - Cholagogue — stimulate bile release
    - Cancer care: regulate cell signaling, inhibit cell division, induce cell death
    - Promotes Phase 2 detox
    - Can take preventatively before acetaminophen
    - Protects from hepatitis damage (high fat diets)
    - Beneficial effect on liver enzyme levels
    - Improve hormone clearance
    - Improve propensity to fungal infection
    - Good for gallstones
    - Biliary pain$blk$;

  v_sb_per_business := $blk$## Current Good Manufacturing Practices (label example)
- 3 oz nettle leaf (aerial parts) Oshala Farm lot 060126
- -> 12 oz 50% vinegar Braggs lot 335
- 1 oz oat straw Oshala Farm lot 040126
- -> Nettle acetum - batch # 080126 -> sell to Berkeley Bowl$blk$;

  -- ── Generated Note Snippets ───────────────────────────────────────────────

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Liver Support
    (v_dandelion_rt,
     'Dandelion root: tonic for liver tenderness; can replace coffee with toasted dandelion and burdock.',
     v_class, 'generated', 'Liver Support', 10, v_sb_gen_liver_support),

    (v_burdock,
     'Burdock: companion to dandelion root as a liver tonic; noted as a coffee replacement (toasted dandelion and burdock).',
     v_class, 'generated', 'Liver Support', 20, v_sb_gen_liver_support),

    (v_licorice,
     'Licorice: supports metabolism.',
     v_class, 'generated', 'Liver Support', 30, v_sb_gen_liver_support),

    (v_fennel,
     'Fennel seed and orange peel: carminatives, aid digestive function.',
     v_class, 'generated', 'Liver Support', 40, v_sb_gen_liver_support),

    (v_sweet_orange,
     'Orange peel and fennel seed: carminatives, aid digestive function.',
     v_class, 'generated', 'Liver Support', 50, v_sb_gen_liver_support),

    -- Liver Detoxification Pathways (herb)
    (v_schizandra,
     'Schizandra: antioxidant, hepatoprotective; key herb supporting liver detoxification pathways.',
     v_class, 'generated', 'Liver Detoxification Pathways', 60, v_sb_gen_detox_pathways),

    -- Liver Treatment
    (v_dandelion_rt,
     'Choice between dandelion tea and milk thistle extract based on history of chronic toxin exposure — dandelion tea for lighter ongoing liver support.',
     v_class, 'generated', 'Liver Treatment', 70, v_sb_gen_liver_treatment),

    (v_milk_thistle,
     'Choice between dandelion tea and milk thistle extract based on history of chronic toxin exposure — milk thistle extract for more serious or chronic cases.',
     v_class, 'generated', 'Liver Treatment', 80, v_sb_gen_liver_treatment),

    -- Milk Thistle (generated)
    (v_milk_thistle,
     'Milk thistle: taken for 3–12 months; safe with other medications; treats tenderness in liver area and enlarged liver.',
     v_class, 'generated', 'Milk Thistle', 90, v_sb_gen_milk_thistle),

    -- Herbs for Liver Support
    (v_milk_thistle,
     'Milk thistle — alterative for inflammation and elimination of waste in liver disease.',
     v_class, 'generated', 'Herbs for Liver Support', 100, v_sb_gen_herbs_liver),

    (v_dandelion_rt,
     'Dandelion — alterative for inflammation and elimination of waste in liver disease.',
     v_class, 'generated', 'Herbs for Liver Support', 110, v_sb_gen_herbs_liver),

    (v_burdock,
     'Burdock — alterative for inflammation and elimination of waste in liver disease.',
     v_class, 'generated', 'Herbs for Liver Support', 120, v_sb_gen_herbs_liver),

    -- Turmeric (generated)
    (v_turmeric,
     'Turmeric: helpful for hepatitis, metabolic-associated fatty liver disease, and inflammation; cooling, antioxidant, cholagogue (bile stimulation).',
     v_class, 'generated', 'Turmeric', 130, v_sb_gen_turmeric),

    -- Herbal Business (generated)
    (v_nettle_lf,
     'Nettle leaf: used in oxymel formulation example (3 oz nettle, 1 oz astragalus) in herbal business manufacturing context.',
     v_class, 'generated', 'Herbal Business', 140, v_sb_gen_business),

    (v_astragalus,
     'Astragalus: used in oxymel formulation example alongside nettle (3 oz nettle, 1 oz astragalus).',
     v_class, 'generated', 'Herbal Business', 150, v_sb_gen_business),

    (v_chamomile,
     'Chamomile: ingredient in "Sleepy Horsey" tea (chamomile, tulsi, lavender, horsetail); supports calm and clear mind; promotes tranquilizing sleep.',
     v_class, 'generated', 'Herbal Business', 160, v_sb_gen_business),

    (v_holy_basil,
     'Tulsi (Holy Basil): ingredient in "Sleepy Horsey" tea (chamomile, tulsi, lavender, horsetail); supports calm and clear mind; nourishes skin and nails; promotes tranquilizing sleep.',
     v_class, 'generated', 'Herbal Business', 170, v_sb_gen_business),

    (v_lavender,
     'Lavender: ingredient in "Sleepy Horsey" tea (chamomile, tulsi, lavender, horsetail); promotes tranquilizing sleep.',
     v_class, 'generated', 'Herbal Business', 180, v_sb_gen_business),

    (v_horsetail,
     'Horsetail: ingredient in "Sleepy Horsey" tea (chamomile, tulsi, lavender, horsetail); nourishes skin and nails.',
     v_class, 'generated', 'Herbal Business', 190, v_sb_gen_business),

    -- ── Personal Note Snippets ─────────────────────────────────────────────

    -- Liver (personal)
    (v_burdock,
     'Liver tea formula (2P Burdock, 2P Astragalus, 1P Dandelion, 1P Orange Peel, 1P Fennel, 1P Licorice). Burdock root: nourishing, safe for liver; cholagogue (bile stim); gallstones and biliary disease; optimizes toxin elimination and fat-soluble vitamin absorption; helps with fatty liver disease. Spec ind: hyperlipidemia, chronic acne/skin disorders, fatigue and malaise.',
     v_class, 'personal', 'Liver', 10, v_sb_per_liver),

    (v_astragalus,
     'Liver tea formula (2P Burdock, 2P Astragalus, 1P Dandelion, 1P Orange Peel, 1P Fennel, 1P Licorice). Astragalus: nourishing supporting hepatoprotective plant.',
     v_class, 'personal', 'Liver', 20, v_sb_per_liver),

    (v_dandelion_rt,
     'Liver tea formula (2P Burdock, 2P Astragalus, 1P Dandelion, 1P Orange Peel, 1P Fennel, 1P Licorice). Dandelion root: nourishing hepatoprotective. Spec ind: jaundice, pain in the gallbladder, digestive disturbance, headache due to liver issues (forehead), tenderness in liver, coated tongue.',
     v_class, 'personal', 'Liver', 30, v_sb_per_liver),

    (v_sweet_orange,
     'Orange peel (liver tea formula): carminative; gets secretions going in upper GI; allows easier absorption in small intestine; reduces load on liver.',
     v_class, 'personal', 'Liver', 40, v_sb_per_liver),

    (v_fennel,
     'Fennel seed (liver tea formula): carminative; supports secretions in upper GI; aids digestive function.',
     v_class, 'personal', 'Liver', 50, v_sb_per_liver),

    (v_licorice,
     'Licorice (liver tea formula): supports metabolism — for person who has started to accumulate adipose tissue without change in activity; adaptogen; harmonizer.',
     v_class, 'personal', 'Liver', 60, v_sb_per_liver),

    (v_milk_thistle,
     'Milk Thistle: most potent liver support; super safe at higher doses. Standardized fluid extract best for serious conditions (silymarin). Can also be used as food (ground over savory foods like burdock seed).',
     v_class, 'personal', 'Liver', 70, v_sb_per_liver),

    -- Liver Detox Pathways (personal)
    (v_milk_thistle,
     'Phase 1 liver detox: Milk Thistle — high in flavonoids; Thorn capsule extract recommended; best to avoid alcohol (tinctures) for liver support.',
     v_class, 'personal', 'Liver Detox Pathways', 10, v_sb_per_detox_pathways),

    (v_schizandra,
     'Schisandra: antioxidant and hepatoprotective; supports Phase 1 liver detox as a first line of defense against toxins (alcohol and caffeine).',
     v_class, 'personal', 'Liver Detox Pathways', 20, v_sb_per_detox_pathways),

    -- Metabolic Associated Fatty Liver Disease
    (v_turmeric,
     'For metabolic-associated fatty liver disease (MAFLD): turmeric is a go-to alongside the liver tea herbs and Oregon Grape Root.',
     v_class, 'personal', 'Metabolic Associated Fatty Liver Disease', 10, v_sb_per_mafld),

    (v_oregon_grape,
     'Oregon Grape Root (OGR, berberine): go-to for metabolic-associated fatty liver disease alongside turmeric and liver tea herbs.',
     v_class, 'personal', 'Metabolic Associated Fatty Liver Disease', 20, v_sb_per_mafld),

    (v_fennel,
     'Fennel essential oil: applied topically directly on the liver, especially with tenderness, for metabolic-associated fatty liver disease.',
     v_class, 'personal', 'Metabolic Associated Fatty Liver Disease', 30, v_sb_per_mafld),

    -- Milk Thistle (personal materia medica)
    (v_milk_thistle,
     'Milk Thistle (Silybum marianum), seed. Dose: FE 20-40 drops 5x/day; Tinc 1/2-1tsp 4x/day (avoid alcohol prep with active liver disease); Capsules 600mg/day to 80% silymarin; acute mushroom poisoning 5g/day. Actions: hepatoprotective, galactagogue, anti-hepatotoxic, antisclerotic; restores liver from toxins/acetaminophen; protects kidneys; supports during/after chemo; corrects bilirubin levels; "anabolic cooler" for metabolic fat/protein dysregulation.',
     v_class, 'personal', 'Milk Thistle', 10, v_sb_per_milk_thistle),

    -- Oregon Grape Root (personal materia medica)
    (v_oregon_grape,
     'Oregon Grape Root (Berberis aquifolium). Fresh 1:2 80-95%, dry 1:5 50%. Actions: cholagogue, bitter (upper GI), broad antimicrobial (gram neg: E. coli/Salmonella; gram pos: Strep/Staph). Spec ind: liver congestion and low bile, infectious hepatitis (Hep A), food poisoning, liver tenderness with slow digestion, skin eruptions (boils, acne) with coated tongue, SIBO/candida (penetrates biofilms), anti-protozoal, potentiates antibiotics (MRSA).',
     v_class, 'personal', 'Oregon Grape Root', 10, v_sb_per_oregon_grape),

    -- Licorice (personal materia medica)
    (v_licorice,
     'Licorice (Glycyrrhiza glabra), dried root. Dose: decoction 1 tsp root : 1 cup water; Tinc/FE 10-20 drops 3x/day. Caution: may aggravate BP with potassium imbalance. Actions: adapts cortisol regulation (hypo or hyper), improves insulin resistance, maintains HPA axis communication, general exhaustion and debility, immune modulator, adrenal insufficiency from aging.',
     v_class, 'personal', 'Licorice', 10, v_sb_per_licorice),

    -- Turmeric (personal materia medica)
    (v_turmeric,
     'Turmeric (Curcuma longa), rhizome. Dose: capsules 500mg 2-4x/day; golden milk 1-2 tsp 5x/day; enhance absorption with black pepper and fat. Actions: antioxidant, antilipidemic, cholagogue; cancer care (cell signaling, apoptosis); promotes Phase 2 detox; preventative with acetaminophen; protects from hepatitis damage; improves liver enzymes; hormone clearance; good for gallstones and biliary pain.',
     v_class, 'personal', 'Turmeric', 10, v_sb_per_turmeric),

    -- Herbal Business (personal)
    (v_nettle_lf,
     'Nettle leaf: used in manufacturing label example as nettle acetum (3 oz nettle leaf, Oshala Farm lot 060126, in 12 oz 50% vinegar).',
     v_class, 'personal', 'Herbal Business', 10, v_sb_per_business),

    (v_oat_straw,
     'Oat straw: used in manufacturing label example (1 oz oat straw, Oshala Farm lot 040126) as part of nettle acetum batch documentation.',
     v_class, 'personal', 'Herbal Business', 20, v_sb_per_business)

  ON CONFLICT DO NOTHING;

  -- ── Supplement Snippets ───────────────────────────────────────────────────

  -- Phase I liver detox nutrients (generated)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (v_vit_b2,
     'Vitamin B2 (Riboflavin): required for Phase I liver detoxification, which converts fat-soluble toxins to water-soluble via cytochrome P450 and requires B2, B3, B6, B12, folic acid, glutathione, and flavonoids.',
     v_class, 'generated', 'Liver Detoxification Pathways', 10, v_sb_gen_detox_pathways),

    (v_vit_b3,
     'Vitamin B3 (Niacin): required for Phase I liver detoxification, which converts fat-soluble toxins to water-soluble via cytochrome P450 and requires B2, B3, B6, B12, folic acid, glutathione, and flavonoids.',
     v_class, 'generated', 'Liver Detoxification Pathways', 20, v_sb_gen_detox_pathways),

    (v_vit_b6,
     'Vitamin B6 (Pyridoxine): required for Phase I liver detoxification, which converts fat-soluble toxins to water-soluble via cytochrome P450 and requires B2, B3, B6, B12, folic acid, glutathione, and flavonoids.',
     v_class, 'generated', 'Liver Detoxification Pathways', 30, v_sb_gen_detox_pathways),

    (v_vit_b12,
     'Vitamin B12: required for Phase I liver detoxification, which converts fat-soluble toxins to water-soluble via cytochrome P450 and requires B2, B3, B6, B12, folic acid, glutathione, and flavonoids.',
     v_class, 'generated', 'Liver Detoxification Pathways', 40, v_sb_gen_detox_pathways),

    (v_vit_b9,
     'Vitamin B9 (Folic Acid): required for Phase I liver detoxification, which converts fat-soluble toxins to water-soluble via cytochrome P450 and requires B2, B3, B6, B12, folic acid, glutathione, and flavonoids.',
     v_class, 'generated', 'Liver Detoxification Pathways', 50, v_sb_gen_detox_pathways),

    -- Phase II liver detox nutrients (generated)
    (v_methionine,
     'Methionine: required for Phase II liver detoxification (sulfation, glutathione conjugation, methylation); Phase II requires methionine, cysteine, magnesium, vitamin C, glycine, and taurine.',
     v_class, 'generated', 'Liver Detoxification Pathways', 60, v_sb_gen_detox_pathways),

    (v_vit_c,
     'Vitamin C: required for Phase II liver detoxification (sulfation, conjugation, methylation); Phase II requires methionine, cysteine, magnesium, vitamin C, glycine, and taurine.',
     v_class, 'generated', 'Liver Detoxification Pathways', 70, v_sb_gen_detox_pathways),

    (v_magnesium,
     'Magnesium: required for Phase II liver detoxification (sulfation, conjugation, methylation); Phase II requires methionine, cysteine, magnesium, vitamin C, glycine, and taurine.',
     v_class, 'generated', 'Liver Detoxification Pathways', 80, v_sb_gen_detox_pathways),

    -- Methylated B vitamins (personal)
    (v_vit_b_cpx,
     'Methylated B vitamins ("Methyl Pro"): jumpstart the liver process and support Phase 1 detox; especially indicated for chronic chemical exposure, past medicine or drug use, alcohol.',
     v_class, 'personal', 'Liver Detox Pathways', 10, v_sb_per_detox_pathways)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 45 snippets: done.';
END $$;


-- ============================================================
-- Block 2: Herb keywords
-- ============================================================
DO $$
DECLARE
  v_dandelion_rt  INTEGER;
  v_burdock       INTEGER;
  v_licorice      INTEGER;
  v_fennel        INTEGER;
  v_sweet_orange  INTEGER;
  v_schizandra    INTEGER;
  v_milk_thistle  INTEGER;
  v_turmeric      INTEGER;
  v_oregon_grape  INTEGER;
  v_astragalus    INTEGER;
  v_chamomile     INTEGER;
  v_holy_basil    INTEGER;
  v_lavender      INTEGER;
  v_horsetail     INTEGER;

BEGIN
  SELECT id INTO v_dandelion_rt FROM herbal.herbs
    WHERE latin_name = 'Taraxacum officinale' AND plant_part = 'root' LIMIT 1;
  SELECT id INTO v_burdock      FROM herbal.herbs WHERE latin_name = 'Arctium lappa'           LIMIT 1;
  SELECT id INTO v_licorice     FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra'      LIMIT 1;
  SELECT id INTO v_fennel       FROM herbal.herbs WHERE latin_name = 'Foeniculum vulgare'      LIMIT 1;
  SELECT id INTO v_sweet_orange FROM herbal.herbs WHERE latin_name = 'Citrus sinensis'         LIMIT 1;
  SELECT id INTO v_schizandra   FROM herbal.herbs WHERE latin_name = 'Schisandra chinensis'    LIMIT 1;
  SELECT id INTO v_milk_thistle FROM herbal.herbs WHERE latin_name = 'Silybum marianum'        LIMIT 1;
  SELECT id INTO v_turmeric     FROM herbal.herbs WHERE latin_name = 'Curcuma longa'           LIMIT 1;
  SELECT id INTO v_oregon_grape FROM herbal.herbs WHERE latin_name = 'Mahonia aquifolium'      LIMIT 1;
  SELECT id INTO v_astragalus   FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus' LIMIT 1;
  SELECT id INTO v_chamomile    FROM herbal.herbs WHERE latin_name = 'Matricaria recutita'     LIMIT 1;
  SELECT id INTO v_holy_basil   FROM herbal.herbs WHERE latin_name = 'Ocimum sanctum'          LIMIT 1;
  SELECT id INTO v_lavender     FROM herbal.herbs WHERE latin_name ILIKE 'Lavandula%'          LIMIT 1;
  SELECT id INTO v_horsetail    FROM herbal.herbs WHERE latin_name = 'Equisetum arvense'       LIMIT 1;

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    -- ── Dandelion Root ───────────────────────────────────────────────────────
    (v_dandelion_rt, 'liver support',        'ailment'),
    (v_dandelion_rt, 'jaundice',             'ailment'),
    (v_dandelion_rt, 'gallstones',           'ailment'),
    (v_dandelion_rt, 'digestive tonic',      'ailment'),
    (v_dandelion_rt, 'liver congestion',     'ailment'),
    (v_dandelion_rt, 'liver tenderness',     'symptom'),
    (v_dandelion_rt, 'biliary pain',         'symptom'),
    (v_dandelion_rt, 'hepatoprotective',     'action'),
    (v_dandelion_rt, 'alterative',           'action'),
    (v_dandelion_rt, 'cholagogue',           'action'),
    (v_dandelion_rt, 'digestive bitter',     'action'),

    -- ── Burdock ──────────────────────────────────────────────────────────────
    (v_burdock, 'liver support',             'ailment'),
    (v_burdock, 'gallstones',               'ailment'),
    (v_burdock, 'hyperlipidemia',           'ailment'),
    (v_burdock, 'skin conditions',          'ailment'),
    (v_burdock, 'fatigue',                  'ailment'),
    (v_burdock, 'fatty liver disease',      'ailment'),
    (v_burdock, 'cholagogue',               'action'),
    (v_burdock, 'alterative',              'action'),
    (v_burdock, 'hepatoprotective',         'action'),

    -- ── Licorice ─────────────────────────────────────────────────────────────
    (v_licorice, 'liver support',           'ailment'),
    (v_licorice, 'metabolic syndrome',      'ailment'),
    (v_licorice, 'insulin resistance',      'ailment'),
    (v_licorice, 'adrenal fatigue',         'ailment'),
    (v_licorice, 'adaptogen',              'action'),
    (v_licorice, 'immune modulator',        'action'),

    -- ── Fennel ───────────────────────────────────────────────────────────────
    (v_fennel, 'liver support',             'ailment'),
    (v_fennel, 'digestive tonic',           'ailment'),
    (v_fennel, 'fatty liver disease',       'ailment'),
    (v_fennel, 'carminative',              'action'),
    (v_fennel, 'cholagogue',               'action'),

    -- ── Sweet Orange ─────────────────────────────────────────────────────────
    (v_sweet_orange, 'liver support',       'ailment'),
    (v_sweet_orange, 'digestive tonic',     'ailment'),
    (v_sweet_orange, 'carminative',         'action'),

    -- ── Schizandra ───────────────────────────────────────────────────────────
    (v_schizandra, 'liver support',         'ailment'),
    (v_schizandra, 'chemical sensitivity',  'ailment'),
    (v_schizandra, 'hepatoprotective',      'action'),
    (v_schizandra, 'antioxidant',           'action'),

    -- ── Milk Thistle ─────────────────────────────────────────────────────────
    (v_milk_thistle, 'liver support',       'ailment'),
    (v_milk_thistle, 'hepatitis',           'ailment'),
    (v_milk_thistle, 'fatty liver disease', 'ailment'),
    (v_milk_thistle, 'cancer support',      'ailment'),
    (v_milk_thistle, 'acute illness',       'ailment'),
    (v_milk_thistle, 'metabolic syndrome',  'ailment'),
    (v_milk_thistle, 'liver tenderness',    'symptom'),
    (v_milk_thistle, 'hepatoprotective',    'action'),
    (v_milk_thistle, 'galactagogue',        'action'),
    (v_milk_thistle, 'alterative',          'action'),
    (v_milk_thistle, 'antisclerotic',       'action'),
    (v_milk_thistle, 'anti-hepatotoxic',    'action'),

    -- ── Turmeric ─────────────────────────────────────────────────────────────
    (v_turmeric, 'liver support',           'ailment'),
    (v_turmeric, 'hepatitis',               'ailment'),
    (v_turmeric, 'fatty liver disease',     'ailment'),
    (v_turmeric, 'cancer support',          'ailment'),
    (v_turmeric, 'gallstones',              'ailment'),
    (v_turmeric, 'insulin resistance',      'ailment'),
    (v_turmeric, 'type 2 diabetes',         'ailment'),
    (v_turmeric, 'estrogen metabolism',     'ailment'),
    (v_turmeric, 'biliary pain',            'symptom'),
    (v_turmeric, 'cholagogue',              'action'),
    (v_turmeric, 'antioxidant',             'action'),
    (v_turmeric, 'anti-inflammatory',       'action'),
    (v_turmeric, 'antilipidemic',           'action'),

    -- ── Oregon Grape ─────────────────────────────────────────────────────────
    (v_oregon_grape, 'liver support',       'ailment'),
    (v_oregon_grape, 'hepatitis',           'ailment'),
    (v_oregon_grape, 'food poisoning',      'ailment'),
    (v_oregon_grape, 'SIBO',               'ailment'),
    (v_oregon_grape, 'liver congestion',    'ailment'),
    (v_oregon_grape, 'skin conditions',     'ailment'),
    (v_oregon_grape, 'fatty liver disease', 'ailment'),
    (v_oregon_grape, 'cholagogue',          'action'),
    (v_oregon_grape, 'antimicrobial',       'action'),
    (v_oregon_grape, 'alterative',          'action'),
    (v_oregon_grape, 'digestive bitter',    'action'),

    -- ── Astragalus ───────────────────────────────────────────────────────────
    (v_astragalus, 'liver support',         'ailment'),
    (v_astragalus, 'immune support',        'ailment'),
    (v_astragalus, 'hepatoprotective',      'action'),

    -- ── Chamomile ────────────────────────────────────────────────────────────
    (v_chamomile, 'stress',                 'ailment'),
    (v_chamomile, 'anxiety',                'ailment'),
    (v_chamomile, 'sleep support',          'ailment'),

    -- ── Holy Basil (Tulsi) ───────────────────────────────────────────────────
    (v_holy_basil, 'stress',                'ailment'),
    (v_holy_basil, 'anxiety',               'ailment'),
    (v_holy_basil, 'sleep support',         'ailment'),
    (v_holy_basil, 'skin conditions',       'ailment'),
    (v_holy_basil, 'adaptogen',             'action'),

    -- ── Lavender ─────────────────────────────────────────────────────────────
    (v_lavender, 'stress',                  'ailment'),
    (v_lavender, 'anxiety',                 'ailment'),
    (v_lavender, 'sleep support',           'ailment'),

    -- ── Horsetail ────────────────────────────────────────────────────────────
    (v_horsetail, 'skin conditions',        'ailment'),
    (v_horsetail, 'mineral support',        'ailment')

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 45 herb keywords: done.';
END $$;


-- ============================================================
-- Block 3: Supplement keywords
-- ============================================================
DO $$
DECLARE
  v_vit_b2     INTEGER;
  v_vit_b3     INTEGER;
  v_vit_b6     INTEGER;
  v_vit_b12    INTEGER;
  v_vit_b9     INTEGER;
  v_methionine INTEGER;
  v_vit_c      INTEGER;
  v_magnesium  INTEGER;
  v_vit_b_cpx  INTEGER;
BEGIN
  SELECT id INTO v_vit_b2     FROM herbal.supplements WHERE name = 'Vitamin B2 (Riboflavin)';
  SELECT id INTO v_vit_b3     FROM herbal.supplements WHERE name = 'Vitamin B3 (Niacin)';
  SELECT id INTO v_vit_b6     FROM herbal.supplements WHERE name = 'Vitamin B6 (Pyridoxine)';
  SELECT id INTO v_vit_b12    FROM herbal.supplements WHERE name = 'Vitamin B12';
  SELECT id INTO v_vit_b9     FROM herbal.supplements WHERE name = 'Vitamin B9 (Folic Acid)';
  SELECT id INTO v_methionine FROM herbal.supplements WHERE name = 'Methionine';
  SELECT id INTO v_vit_c      FROM herbal.supplements WHERE name = 'Vitamin C';
  SELECT id INTO v_magnesium  FROM herbal.supplements WHERE name = 'Magnesium';
  SELECT id INTO v_vit_b_cpx  FROM herbal.supplements WHERE name = 'Vitamin B Complex';

  INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
    (v_vit_b2,    'liver support',        'ailment'),
    (v_vit_b3,    'liver support',        'ailment'),
    (v_vit_b6,    'liver support',        'ailment'),
    (v_vit_b12,   'liver support',        'ailment'),
    (v_vit_b9,    'liver support',        'ailment'),
    (v_methionine,'liver support',        'ailment'),
    (v_vit_c,     'liver support',        'ailment'),
    (v_magnesium, 'liver support',        'ailment'),
    (v_vit_b_cpx, 'liver support',        'ailment'),
    (v_vit_b_cpx, 'chemical sensitivity', 'ailment')

  ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

  RAISE NOTICE 'Class 45 supplement keywords: done.';
END $$;


-- ============================================================
-- Block 4: Ailment search terms (new keywords only)
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
    ('hepatitis',
     ARRAY['liver inflammation', 'hepatitis A', 'hepatitis B', 'hepatitis C',
           'viral hepatitis', 'infectious hepatitis', 'hepatic inflammation']),
    ('fatty liver disease',
     ARRAY['NAFLD', 'MAFLD', 'non-alcoholic fatty liver', 'metabolic-associated fatty liver',
           'hepatic steatosis', 'fatty liver', 'hepatic lipid accumulation']),
    ('gallstones',
     ARRAY['cholelithiasis', 'biliary calculi', 'gallbladder stones', 'biliary stones',
           'gallstone disease', 'biliary lithiasis']),
    ('food poisoning',
     ARRAY['foodborne illness', 'foodborne infection', 'bacterial gastroenteritis',
           'gastrointestinal infection', 'traveller''s diarrhea', 'gastroenteritis']),
    ('SIBO',
     ARRAY['small intestinal bacterial overgrowth', 'gut dysbiosis', 'intestinal dysbiosis',
           'candida overgrowth', 'fungal gut overgrowth', 'small bowel overgrowth']),
    ('liver congestion',
     ARRAY['hepatic congestion', 'congested liver', 'stagnant liver', 'sluggish liver',
           'liver stagnation', 'low bile', 'bile insufficiency']),
    ('jaundice',
     ARRAY['icterus', 'hyperbilirubinemia', 'yellow skin', 'yellowing of skin',
           'bilirubin elevation', 'elevated bilirubin']),
    ('metabolic syndrome',
     ARRAY['metabolic disorder', 'metabolic dysfunction', 'insulin resistance syndrome',
           'syndrome X', 'cardiometabolic syndrome', 'metabolic dysregulation']),
    ('cancer support',
     ARRAY['oncology support', 'chemotherapy support', 'cancer care', 'anti-cancer',
           'tumor support', 'chemo support', 'adjunctive cancer care']),
    ('type 2 diabetes',
     ARRAY['diabetes mellitus type 2', 'T2DM', 'adult onset diabetes',
           'non-insulin dependent diabetes', 'hyperglycemia', 'diabetes']),
    ('hyperlipidemia',
     ARRAY['high cholesterol', 'hypercholesterolemia', 'dyslipidemia', 'elevated lipids',
           'high triglycerides', 'elevated cholesterol', 'high LDL']),
    ('fatigue',
     ARRAY['chronic fatigue', 'exhaustion', 'tiredness', 'low energy',
           'malaise', 'lethargy', 'chronic exhaustion']),
    ('sleep support',
     ARRAY['insomnia', 'sleep disorders', 'poor sleep', 'sleeplessness',
           'night waking', 'sleep problems', 'difficulty sleeping']),
    ('liver tenderness',
     ARRAY['hepatic tenderness', 'enlarged liver', 'hepatomegaly', 'right upper quadrant pain',
           'liver pain', 'tender liver', 'RUQ tenderness']),
    ('biliary pain',
     ARRAY['biliary colic', 'gallbladder pain', 'gallbladder attack',
           'cholecystitis', 'gallbladder cramps', 'bile duct pain'])

  ON CONFLICT (ailment_keyword) DO NOTHING;

  RAISE NOTICE 'Class 45 ailment search terms: done.';
END $$;
