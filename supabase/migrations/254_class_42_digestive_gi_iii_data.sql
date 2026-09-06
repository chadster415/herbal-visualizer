-- Migration 254: BHC Class 42 — Digestive System III and Medicine-Making Review
-- class_name: 'BHC - Class 42 - Digestive System III and Medicine-Making Review'
-- Class date: 2026-07-15
--
-- Files parsed:
--   BHC - Class 42 - … - Generated Notes.md  (note_type = 'generated')
--   BHC - Class 42 - … - Lisa and Mer.md      (note_type = 'personal')
--   BHC - Class 42 - … - Transcript.md        IGNORED
--   Afternoon section (Mer) is screenshots only — no text herb content captured.
--
-- Herb normalisations:
--   "grape root" in diarrhea immune context → Oregon Grape (Mahonia aquifolium, id=33)
--   "marsh root" / "marsh cold infusion" → Slippery Elm (Ulmus rubra, id=92)
--       (personal notes explicitly: "slippery elm (marsh root)")
--   "SJW" → St. John's Wort (Hypericum perforatum, id=81)
--   "Rubus family" → Blackberry (id=156) + Raspberry (id=155) separately
--   "baptisia" → Wild Indigo (Baptisia tinctoria, id=23)
--
-- Skipped — not in DB:
--   Probiotics / Lactobacillus — mentioned generally as microbiome support
--   Ghee — food, mentioned re: tight junctions; not an herb or supplement
--   Tryptophan — amino acid for serotonin; not in supplements table
--   Ocotillo (Fouquieria splendens, id=1248) — IS in DB → included for constipation/lymph
--
-- No herb pairs: all herb groupings are categorical lists (astringents, antispasmodics);
--   no instructor-attributed two-herb classic pairing noted.
--
-- New ailment keywords introduced this class:
--   constipation, diarrhea
--
-- Keyword merge decisions:
--   "smooth muscle relaxant" → 'muscle spasms' (existing)
--   "lymph congestion" → 'lymphatic support' (existing)
--   "pelvic circulation" → 'poor circulation' (existing)
--   "nourish peristaltic triggers" → 'digestive tonic' (existing)
--   "microbial gastroenteritis" → 'diarrhea' (new)

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Snippets
-- ============================================================
DO $$
DECLARE
  v_class CONSTANT TEXT := 'BHC - Class 42 - Digestive System III and Medicine-Making Review';

  -- Herb IDs
  v_cramp_bark     INTEGER;
  v_wild_yam       INTEGER;
  v_rhubarb        INTEGER;
  v_yellow_dock    INTEGER;
  v_cascara        INTEGER;
  v_senna          INTEGER;
  v_psyllium       INTEGER;
  v_eucalyptus     INTEGER;
  v_ginger         INTEGER;
  v_cardamom       INTEGER;
  v_slippery_elm   INTEGER;
  v_burdock        INTEGER;
  v_blue_vervain   INTEGER;
  v_cinnamon       INTEGER;
  v_blackberry     INTEGER;
  v_raspberry      INTEGER;
  v_yarrow         INTEGER;
  v_meadowsweet    INTEGER;
  v_fennel         INTEGER;
  v_catnip         INTEGER;
  v_chamomile      INTEGER;
  v_peppermint     INTEGER;
  v_echinacea      INTEGER;
  v_baptisia       INTEGER;
  v_oregon_grape   INTEGER;
  v_reishi         INTEGER;
  v_astragalus     INTEGER;
  v_sjw            INTEGER;
  v_ocotillo       INTEGER;

  -- Source blocks
  v_sb_gen_neuro        TEXT;
  v_sb_gen_nightshift   TEXT;
  v_sb_gen_psyllium     TEXT;
  v_sb_gen_diarrhea     TEXT;
  v_sb_gen_pelvic       TEXT;
  v_sb_per_stomach      TEXT;
  v_sb_per_constipation TEXT;
  v_sb_per_diarrhea     TEXT;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 42 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ── Resolve herb IDs ────────────────────────────────────────────────────────
  SELECT id INTO v_cramp_bark   FROM herbal.herbs WHERE latin_name = 'Viburnum opulus'              LIMIT 1;
  SELECT id INTO v_wild_yam     FROM herbal.herbs WHERE latin_name = 'Dioscorea villosa'             LIMIT 1;
  SELECT id INTO v_rhubarb      FROM herbal.herbs WHERE latin_name = 'Rheum palmatum'                LIMIT 1;
  SELECT id INTO v_yellow_dock  FROM herbal.herbs WHERE latin_name = 'Rumex crispus'                 LIMIT 1;
  SELECT id INTO v_cascara      FROM herbal.herbs WHERE latin_name = 'Rhamnus purshiana'             LIMIT 1;
  SELECT id INTO v_senna        FROM herbal.herbs WHERE latin_name = 'Senna alexandrina'             LIMIT 1;
  SELECT id INTO v_psyllium     FROM herbal.herbs WHERE latin_name = 'Plantago ovata'                LIMIT 1;
  SELECT id INTO v_eucalyptus   FROM herbal.herbs WHERE latin_name = 'Eucalyptus spp.'               LIMIT 1;
  SELECT id INTO v_ginger       FROM herbal.herbs WHERE latin_name = 'Zingiber officinale'           LIMIT 1;
  SELECT id INTO v_cardamom     FROM herbal.herbs WHERE latin_name = 'Elettaria cardamomum'          LIMIT 1;
  SELECT id INTO v_slippery_elm FROM herbal.herbs WHERE latin_name = 'Ulmus rubra'                   LIMIT 1;
  SELECT id INTO v_burdock      FROM herbal.herbs WHERE latin_name = 'Arctium lappa'                 LIMIT 1;
  SELECT id INTO v_blue_vervain FROM herbal.herbs WHERE latin_name = 'Verbena hastata'               LIMIT 1;
  SELECT id INTO v_cinnamon     FROM herbal.herbs WHERE latin_name = 'Cinnamomum spp.'               LIMIT 1;
  SELECT id INTO v_blackberry   FROM herbal.herbs WHERE latin_name = 'Rubus villosus'                LIMIT 1;
  SELECT id INTO v_raspberry    FROM herbal.herbs
    WHERE latin_name = 'Rubus idaeus' AND plant_part = 'leaf'                                        LIMIT 1;
  SELECT id INTO v_yarrow       FROM herbal.herbs WHERE latin_name = 'Achillea millefolium'          LIMIT 1;
  SELECT id INTO v_meadowsweet  FROM herbal.herbs WHERE latin_name = 'Filipendula ulmaria'           LIMIT 1;
  SELECT id INTO v_fennel       FROM herbal.herbs WHERE latin_name = 'Foeniculum vulgare'            LIMIT 1;
  SELECT id INTO v_catnip       FROM herbal.herbs WHERE latin_name = 'Nepeta cataria'                LIMIT 1;
  SELECT id INTO v_chamomile    FROM herbal.herbs WHERE latin_name = 'Matricaria recutita'           LIMIT 1;
  SELECT id INTO v_peppermint   FROM herbal.herbs WHERE latin_name = 'Mentha piperita'               LIMIT 1;
  SELECT id INTO v_echinacea    FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'                LIMIT 1;
  SELECT id INTO v_baptisia     FROM herbal.herbs WHERE latin_name = 'Baptisia tinctoria'            LIMIT 1;
  SELECT id INTO v_oregon_grape FROM herbal.herbs WHERE latin_name = 'Mahonia aquifolium'            LIMIT 1;
  SELECT id INTO v_reishi       FROM herbal.herbs WHERE latin_name = 'Ganoderma lucidum'             LIMIT 1;
  SELECT id INTO v_astragalus   FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus'       LIMIT 1;
  SELECT id INTO v_sjw          FROM herbal.herbs WHERE latin_name = 'Hypericum perforatum'          LIMIT 1;
  SELECT id INTO v_ocotillo     FROM herbal.herbs WHERE latin_name = 'Fouquieria splendens'          LIMIT 1;

  -- ── Define source blocks ────────────────────────────────────────────────────

  v_sb_gen_neuro := $blk$## Neurodigestive Impact & Circadian Rhythm
- Disrupted sleep leads to disrupted bowel
	- People with night shifts experience chronic sleep disruption
		- Disrupted circadian rhythm affects bowel function
- Nervous system relationship with large intestine
	- Serotonin affected by lack of vegetable fiber
	- Stress can compound digestive issues
- Addressing constipation
	- Warming, moistening nervines preferred
	- Consider relaxing smooth muscles
		- Use cramp bark or wild yam as smooth muscle relaxants$blk$;

  v_sb_gen_nightshift := $blk$## Supporting Night Shift Workers
- Recommendations for night shift workers
	- Dry brushing for lymph movement
	- Leg elevation for venous return
	- Pelvic steams and sitz baths for circulation
- Herbals starting with demulcents and carminatives
	- Nourishing and moistening the tissues
- Gentle laxatives
	- Rhubarb root and yellow dock root as gentle, bitter laxatives
	- Cascara sagrada or senna as last resort, potent laxatives$blk$;

  v_sb_gen_psyllium := $blk$## Psyllium Use
- Psyllium requires plenty of water
	- Lack of water causes issues
		- Can become reliant on psyllium
	- Not intended for lifelong use
		- Aim for natural peristaltic urge$blk$;

  v_sb_gen_diarrhea := $blk$## Diarrhea Causes & Management
- Causes include:
	- Gut inflammation, infections (salmonella, norovirus)
	- Food intolerances (lactose intolerance)
	- Colitis, Celiac (autoimmune gluten allergy)
	- SIBO, bile disorder, pancreatitis, hyperthyroidism
	- Diabetes, Addison's disease, cystic fibrosis
	- Hormones from tumors
- Fluid and nutrient loss is a critical concern
	- Electrolyte hydration necessary
	- Nutritional teas for nutrient replenishing
- Slowing peristalsis with:
	- Foods (bananas, bread)
	- Astringents for tonifying tissues
		- Includes Fagaceae family, raspberry root, yarrow, meadowsweet
- Antispasmodic herbs for spasmodic state
	- Fennel, catnip, chamomile, cinnamon, peppermint, ginger
	- Wild yam or cramp bark for severe cases
- Immune support for microbial causes
	- Echinacea, baptisia, grape root
	- Chronic support with reishi, astragalus$blk$;

  v_sb_gen_pelvic := $blk$## Pelvic Floor & Immune Stimulation
- Buildup of waste in large intestine leads to sluggish immunity
- Coordination of pelvic floor impacts lymph movement
	- *Eucalyptus* supports pelvic circulation and lymphatic flow
- Physical trauma can lead to pelvic floor disconnect
- Importance of pelvic floor PT for reconnecting body sensations
- Occupational and lifestyle factors affecting circulation$blk$;

  v_sb_per_stomach := $blk$#### Stomach
- where we start to digest proteins and fats

- start with the warming carminatives
    - ginger
    - marsh cold infusion + cinnamon + cardamom first
    - slippery elm (marsh root) + burdock root + rhubarb
        - demulcent, nourishing, alterative, fiber (good gut impacts)
- bitters are fundamentally cooling to the system
    - blue vervain - gentler than gentian$blk$;

  v_sb_per_constipation := $blk$### Constipation
- Possible causes
    - dehydration
        - and lubrication, of the tissues
    - metabolic
    - neurological
    - medication
    - want to think about SIBO as well
        - see it in relation to a lot of other stress factors
        - bacteria buildup causes constipation
        - alternating with diarrhea
- support
    - nourish peristaltic triggers: food/fiber, flora, hormones, water, electrolytes, circadian rhythm
        - lack of sleep can really impact digestion
    - NS
        - relation between the large intestine/serotonin - and the NS
        - warming, moistening nervines
    - GI Musculature (tone)
        - cramp bark, wild yam = smooth muscle relaxants
    - Immune stimulation
        - if there is a buildup of waste in the LI
        - can stimulate lymph congestion = ocotillo
    - pelvic floor coordination
        - PT to reconnect to the sensations of their body
    - circulation
        - jobs where sitting a lot, truck drivers
- herbs
    - carminatives - nourishing
    - demulcents - moistening
    - bitters: rhubarb, yellow dock - gentler laxatives
    - laxatives: Cascara, senna
- psyllium ok to shift patterns, but not a permanent strategy$blk$;

  v_sb_per_diarrhea := $blk$### Diarrhea
- possible causes:
    - inflammation
    - infection
    - food intolerances
    - colitis
    - celiac's
    - SIBO
        - once migrated to large intestine
    - Bile disorder
    - Pancreatitis
    - Hyperthyroidism
    - Diabetes
    - Addison's
        - Pituitary disorder - excess cortisol
    - cystic fibrosis
    - hormone secreting tumors
- support:
    - rehydrate with electrolytes
    - remove triggers
    - slow peristalsis
        - blackberry root
        - bananas
        - bread
- herbs:
    - Astringents: Rubus family, Yarrow, Meadowsweet
    - Antispasmodics: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger
    - Demulcents
    - Immune support
    - Nervines
        - as long as not contraindicated: SJW
    - Antimicrobials$blk$;

  -- ── Generated Note Snippets ─────────────────────────────────────────────────

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

  -- Neurodigestive Impact and Circadian Rhythm
  (v_cramp_bark,
   'Consider relaxing smooth muscles for constipation — use cramp bark or wild yam as smooth muscle relaxants.',
   v_class, 'generated', 'Neurodigestive Impact and Circadian Rhythm', 10, v_sb_gen_neuro),

  (v_wild_yam,
   'Consider relaxing smooth muscles for constipation — use cramp bark or wild yam as smooth muscle relaxants.',
   v_class, 'generated', 'Neurodigestive Impact and Circadian Rhythm', 20, v_sb_gen_neuro),

  -- Supporting Night Shift Workers
  (v_rhubarb,
   'Rhubarb root and yellow dock root as gentle, bitter laxatives for constipation.',
   v_class, 'generated', 'Supporting Night Shift Workers', 10, v_sb_gen_nightshift),

  (v_yellow_dock,
   'Rhubarb root and yellow dock root as gentle, bitter laxatives for constipation.',
   v_class, 'generated', 'Supporting Night Shift Workers', 20, v_sb_gen_nightshift),

  (v_cascara,
   'Cascara sagrada or senna as last resort, potent laxatives for constipation.',
   v_class, 'generated', 'Supporting Night Shift Workers', 30, v_sb_gen_nightshift),

  (v_senna,
   'Cascara sagrada or senna as last resort, potent laxatives for constipation.',
   v_class, 'generated', 'Supporting Night Shift Workers', 40, v_sb_gen_nightshift),

  -- Psyllium Use
  (v_psyllium,
   'Psyllium requires plenty of water — lack of water causes issues; can become reliant on psyllium; not intended for lifelong use — aim for natural peristaltic urge.',
   v_class, 'generated', 'Psyllium Use', 10, v_sb_gen_psyllium),

  -- Diarrhea Causes and Management
  (v_raspberry,
   'Astringents for tonifying tissues in diarrhea — includes Fagaceae family, raspberry root, yarrow, meadowsweet.',
   v_class, 'generated', 'Diarrhea Causes and Management', 10, v_sb_gen_diarrhea),

  (v_yarrow,
   'Astringents for tonifying tissues in diarrhea — includes Fagaceae family, raspberry root, yarrow, meadowsweet.',
   v_class, 'generated', 'Diarrhea Causes and Management', 20, v_sb_gen_diarrhea),

  (v_meadowsweet,
   'Astringents for tonifying tissues in diarrhea — includes Fagaceae family, raspberry root, yarrow, meadowsweet.',
   v_class, 'generated', 'Diarrhea Causes and Management', 30, v_sb_gen_diarrhea),

  (v_fennel,
   'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, peppermint, ginger.',
   v_class, 'generated', 'Diarrhea Causes and Management', 40, v_sb_gen_diarrhea),

  (v_catnip,
   'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, peppermint, ginger.',
   v_class, 'generated', 'Diarrhea Causes and Management', 50, v_sb_gen_diarrhea),

  (v_chamomile,
   'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, peppermint, ginger.',
   v_class, 'generated', 'Diarrhea Causes and Management', 60, v_sb_gen_diarrhea),

  (v_cinnamon,
   'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, peppermint, ginger.',
   v_class, 'generated', 'Diarrhea Causes and Management', 70, v_sb_gen_diarrhea),

  (v_peppermint,
   'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, peppermint, ginger.',
   v_class, 'generated', 'Diarrhea Causes and Management', 80, v_sb_gen_diarrhea),

  (v_ginger,
   'Antispasmodic herbs for spasmodic state in diarrhea — fennel, catnip, chamomile, cinnamon, peppermint, ginger.',
   v_class, 'generated', 'Diarrhea Causes and Management', 90, v_sb_gen_diarrhea),

  (v_wild_yam,
   'Wild yam or cramp bark for severe antispasmodic support in diarrhea.',
   v_class, 'generated', 'Diarrhea Causes and Management', 100, v_sb_gen_diarrhea),

  (v_cramp_bark,
   'Wild yam or cramp bark for severe antispasmodic support in diarrhea.',
   v_class, 'generated', 'Diarrhea Causes and Management', 110, v_sb_gen_diarrhea),

  (v_echinacea,
   'Immune support for microbial causes of diarrhea — Echinacea, baptisia, grape root.',
   v_class, 'generated', 'Diarrhea Causes and Management', 120, v_sb_gen_diarrhea),

  (v_baptisia,
   'Immune support for microbial causes of diarrhea — Echinacea, baptisia, grape root.',
   v_class, 'generated', 'Diarrhea Causes and Management', 130, v_sb_gen_diarrhea),

  (v_oregon_grape,
   'Immune support for microbial causes of diarrhea — Echinacea, baptisia, grape root (Oregon Grape).',
   v_class, 'generated', 'Diarrhea Causes and Management', 140, v_sb_gen_diarrhea),

  (v_reishi,
   'Chronic immune support for diarrhea — reishi, astragalus.',
   v_class, 'generated', 'Diarrhea Causes and Management', 150, v_sb_gen_diarrhea),

  (v_astragalus,
   'Chronic immune support for diarrhea — reishi, astragalus.',
   v_class, 'generated', 'Diarrhea Causes and Management', 160, v_sb_gen_diarrhea),

  -- Pelvic Floor and Immune Stimulation
  (v_eucalyptus,
   'Eucalyptus supports pelvic circulation and lymphatic flow; recommended for buildup of waste in large intestine causing sluggish immunity and lymph congestion.',
   v_class, 'generated', 'Pelvic Floor and Immune Stimulation', 10, v_sb_gen_pelvic),

  -- ── Personal Note Snippets ──────────────────────────────────────────────────

  -- Stomach (treatment approach)
  (v_ginger,
   'Start with the warming carminatives — ginger for digestive warming and stimulation.',
   v_class, 'personal', 'Stomach', 10, v_sb_per_stomach),

  (v_cinnamon,
   'Warming carminative approach: marsh cold infusion + cinnamon + cardamom first.',
   v_class, 'personal', 'Stomach', 20, v_sb_per_stomach),

  (v_cardamom,
   'Warming carminative approach: marsh cold infusion + cinnamon + cardamom first.',
   v_class, 'personal', 'Stomach', 30, v_sb_per_stomach),

  (v_slippery_elm,
   'Slippery elm (marsh root) + burdock root + rhubarb — demulcent, nourishing, alterative, fiber (good gut impacts).',
   v_class, 'personal', 'Stomach', 40, v_sb_per_stomach),

  (v_burdock,
   'Slippery elm (marsh root) + burdock root + rhubarb — demulcent, nourishing, alterative, fiber (good gut impacts).',
   v_class, 'personal', 'Stomach', 50, v_sb_per_stomach),

  (v_rhubarb,
   'Slippery elm (marsh root) + burdock root + rhubarb — demulcent, nourishing, alterative, fiber (good gut impacts).',
   v_class, 'personal', 'Stomach', 60, v_sb_per_stomach),

  (v_blue_vervain,
   'Bitters are fundamentally cooling to the system — blue vervain, gentler than gentian.',
   v_class, 'personal', 'Stomach', 70, v_sb_per_stomach),

  -- Constipation
  (v_cramp_bark,
   'GI Musculature (tone): cramp bark, wild yam = smooth muscle relaxants for constipation.',
   v_class, 'personal', 'Constipation', 10, v_sb_per_constipation),

  (v_wild_yam,
   'GI Musculature (tone): cramp bark, wild yam = smooth muscle relaxants for constipation.',
   v_class, 'personal', 'Constipation', 20, v_sb_per_constipation),

  (v_ocotillo,
   'Immune stimulation for constipation: if there is a buildup of waste in the LI that can stimulate lymph congestion = ocotillo.',
   v_class, 'personal', 'Constipation', 30, v_sb_per_constipation),

  (v_rhubarb,
   'Bitters: rhubarb, yellow dock — gentler laxatives for constipation.',
   v_class, 'personal', 'Constipation', 40, v_sb_per_constipation),

  (v_yellow_dock,
   'Bitters: rhubarb, yellow dock — gentler laxatives for constipation.',
   v_class, 'personal', 'Constipation', 50, v_sb_per_constipation),

  (v_cascara,
   'Laxatives: Cascara, senna — for constipation.',
   v_class, 'personal', 'Constipation', 60, v_sb_per_constipation),

  (v_senna,
   'Laxatives: Cascara, senna — for constipation.',
   v_class, 'personal', 'Constipation', 70, v_sb_per_constipation),

  (v_psyllium,
   'Psyllium ok to shift patterns, but not a permanent strategy.',
   v_class, 'personal', 'Constipation', 80, v_sb_per_constipation),

  -- Diarrhea
  (v_blackberry,
   'Slow peristalsis for diarrhea: blackberry root (alongside bananas and bread).',
   v_class, 'personal', 'Diarrhea', 10, v_sb_per_diarrhea),

  (v_raspberry,
   'Astringents for diarrhea: Rubus family (including raspberry), Yarrow, Meadowsweet.',
   v_class, 'personal', 'Diarrhea', 20, v_sb_per_diarrhea),

  (v_yarrow,
   'Astringents for diarrhea: Rubus family, Yarrow, Meadowsweet.',
   v_class, 'personal', 'Diarrhea', 30, v_sb_per_diarrhea),

  (v_meadowsweet,
   'Astringents for diarrhea: Rubus family, Yarrow, Meadowsweet.',
   v_class, 'personal', 'Diarrhea', 40, v_sb_per_diarrhea),

  (v_fennel,
   'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.',
   v_class, 'personal', 'Diarrhea', 50, v_sb_per_diarrhea),

  (v_catnip,
   'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.',
   v_class, 'personal', 'Diarrhea', 60, v_sb_per_diarrhea),

  (v_chamomile,
   'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.',
   v_class, 'personal', 'Diarrhea', 70, v_sb_per_diarrhea),

  (v_cinnamon,
   'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.',
   v_class, 'personal', 'Diarrhea', 80, v_sb_per_diarrhea),

  (v_peppermint,
   'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.',
   v_class, 'personal', 'Diarrhea', 90, v_sb_per_diarrhea),

  (v_ginger,
   'Antispasmodics for diarrhea: Fennel, Catnip, Chamomile, Cinnamon, Peppermint, Ginger.',
   v_class, 'personal', 'Diarrhea', 100, v_sb_per_diarrhea),

  (v_sjw,
   'Nervines for diarrhea: as long as not contraindicated — SJW (St. John''s Wort).',
   v_class, 'personal', 'Diarrhea', 110, v_sb_per_diarrhea)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 42 snippets: done.';
END $$;


-- ============================================================
-- Block 2: Herb keywords
-- ============================================================
DO $$
DECLARE
  v_cramp_bark     INTEGER;
  v_wild_yam       INTEGER;
  v_rhubarb        INTEGER;
  v_yellow_dock    INTEGER;
  v_cascara        INTEGER;
  v_senna          INTEGER;
  v_psyllium       INTEGER;
  v_eucalyptus     INTEGER;
  v_ginger         INTEGER;
  v_cardamom       INTEGER;
  v_slippery_elm   INTEGER;
  v_burdock        INTEGER;
  v_blue_vervain   INTEGER;
  v_cinnamon       INTEGER;
  v_blackberry     INTEGER;
  v_raspberry      INTEGER;
  v_yarrow         INTEGER;
  v_meadowsweet    INTEGER;
  v_fennel         INTEGER;
  v_catnip         INTEGER;
  v_chamomile      INTEGER;
  v_peppermint     INTEGER;
  v_echinacea      INTEGER;
  v_baptisia       INTEGER;
  v_oregon_grape   INTEGER;
  v_reishi         INTEGER;
  v_astragalus     INTEGER;
  v_sjw            INTEGER;
  v_ocotillo       INTEGER;
BEGIN
  SELECT id INTO v_cramp_bark   FROM herbal.herbs WHERE latin_name = 'Viburnum opulus'              LIMIT 1;
  SELECT id INTO v_wild_yam     FROM herbal.herbs WHERE latin_name = 'Dioscorea villosa'             LIMIT 1;
  SELECT id INTO v_rhubarb      FROM herbal.herbs WHERE latin_name = 'Rheum palmatum'                LIMIT 1;
  SELECT id INTO v_yellow_dock  FROM herbal.herbs WHERE latin_name = 'Rumex crispus'                 LIMIT 1;
  SELECT id INTO v_cascara      FROM herbal.herbs WHERE latin_name = 'Rhamnus purshiana'             LIMIT 1;
  SELECT id INTO v_senna        FROM herbal.herbs WHERE latin_name = 'Senna alexandrina'             LIMIT 1;
  SELECT id INTO v_psyllium     FROM herbal.herbs WHERE latin_name = 'Plantago ovata'                LIMIT 1;
  SELECT id INTO v_eucalyptus   FROM herbal.herbs WHERE latin_name = 'Eucalyptus spp.'               LIMIT 1;
  SELECT id INTO v_ginger       FROM herbal.herbs WHERE latin_name = 'Zingiber officinale'           LIMIT 1;
  SELECT id INTO v_cardamom     FROM herbal.herbs WHERE latin_name = 'Elettaria cardamomum'          LIMIT 1;
  SELECT id INTO v_slippery_elm FROM herbal.herbs WHERE latin_name = 'Ulmus rubra'                   LIMIT 1;
  SELECT id INTO v_burdock      FROM herbal.herbs WHERE latin_name = 'Arctium lappa'                 LIMIT 1;
  SELECT id INTO v_blue_vervain FROM herbal.herbs WHERE latin_name = 'Verbena hastata'               LIMIT 1;
  SELECT id INTO v_cinnamon     FROM herbal.herbs WHERE latin_name = 'Cinnamomum spp.'               LIMIT 1;
  SELECT id INTO v_blackberry   FROM herbal.herbs WHERE latin_name = 'Rubus villosus'                LIMIT 1;
  SELECT id INTO v_raspberry    FROM herbal.herbs
    WHERE latin_name = 'Rubus idaeus' AND plant_part = 'leaf'                                        LIMIT 1;
  SELECT id INTO v_yarrow       FROM herbal.herbs WHERE latin_name = 'Achillea millefolium'          LIMIT 1;
  SELECT id INTO v_meadowsweet  FROM herbal.herbs WHERE latin_name = 'Filipendula ulmaria'           LIMIT 1;
  SELECT id INTO v_fennel       FROM herbal.herbs WHERE latin_name = 'Foeniculum vulgare'            LIMIT 1;
  SELECT id INTO v_catnip       FROM herbal.herbs WHERE latin_name = 'Nepeta cataria'                LIMIT 1;
  SELECT id INTO v_chamomile    FROM herbal.herbs WHERE latin_name = 'Matricaria recutita'           LIMIT 1;
  SELECT id INTO v_peppermint   FROM herbal.herbs WHERE latin_name = 'Mentha piperita'               LIMIT 1;
  SELECT id INTO v_echinacea    FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'                LIMIT 1;
  SELECT id INTO v_baptisia     FROM herbal.herbs WHERE latin_name = 'Baptisia tinctoria'            LIMIT 1;
  SELECT id INTO v_oregon_grape FROM herbal.herbs WHERE latin_name = 'Mahonia aquifolium'            LIMIT 1;
  SELECT id INTO v_reishi       FROM herbal.herbs WHERE latin_name = 'Ganoderma lucidum'             LIMIT 1;
  SELECT id INTO v_astragalus   FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus'       LIMIT 1;
  SELECT id INTO v_sjw          FROM herbal.herbs WHERE latin_name = 'Hypericum perforatum'          LIMIT 1;
  SELECT id INTO v_ocotillo     FROM herbal.herbs WHERE latin_name = 'Fouquieria splendens'          LIMIT 1;

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES

  -- ── Cramp Bark ───────────────────────────────────────────────────────────────
  (v_cramp_bark, 'constipation',           'ailment'),
  (v_cramp_bark, 'diarrhea',              'ailment'),
  (v_cramp_bark, 'muscle spasms',         'ailment'),
  (v_cramp_bark, 'IBS',                   'ailment'),
  (v_cramp_bark, 'antispasmodic',         'action'),
  (v_cramp_bark, 'smooth muscle relaxant','action'),

  -- ── Wild Yam ─────────────────────────────────────────────────────────────────
  (v_wild_yam,   'constipation',           'ailment'),
  (v_wild_yam,   'diarrhea',              'ailment'),
  (v_wild_yam,   'muscle spasms',         'ailment'),
  (v_wild_yam,   'IBS',                   'ailment'),
  (v_wild_yam,   'antispasmodic',         'action'),
  (v_wild_yam,   'smooth muscle relaxant','action'),

  -- ── Rhubarb ──────────────────────────────────────────────────────────────────
  (v_rhubarb,    'constipation',           'ailment'),
  (v_rhubarb,    'digestive tonic',        'ailment'),
  (v_rhubarb,    'laxative',              'action'),
  (v_rhubarb,    'digestive bitter',       'action'),
  (v_rhubarb,    'alterative',            'action'),

  -- ── Yellow Dock ──────────────────────────────────────────────────────────────
  (v_yellow_dock,'constipation',           'ailment'),
  (v_yellow_dock,'digestive tonic',        'ailment'),
  (v_yellow_dock,'laxative',              'action'),
  (v_yellow_dock,'digestive bitter',       'action'),
  (v_yellow_dock,'alterative',            'action'),

  -- ── Cascara Sagrada ──────────────────────────────────────────────────────────
  (v_cascara,    'constipation',           'ailment'),
  (v_cascara,    'laxative',              'action'),

  -- ── Senna ────────────────────────────────────────────────────────────────────
  (v_senna,      'constipation',           'ailment'),
  (v_senna,      'laxative',              'action'),

  -- ── Psyllium ─────────────────────────────────────────────────────────────────
  (v_psyllium,   'constipation',           'ailment'),
  (v_psyllium,   'digestive tonic',        'ailment'),
  (v_psyllium,   'dry gut',               'ailment'),

  -- ── Eucalyptus ───────────────────────────────────────────────────────────────
  (v_eucalyptus, 'lymphatic support',      'ailment'),
  (v_eucalyptus, 'poor circulation',       'ailment'),
  (v_eucalyptus, 'circulatory stimulant',  'action'),

  -- ── Ginger ───────────────────────────────────────────────────────────────────
  (v_ginger,     'digestive tonic',        'ailment'),
  (v_ginger,     'diarrhea',              'ailment'),
  (v_ginger,     'constipation',           'ailment'),
  (v_ginger,     'carminative',           'action'),
  (v_ginger,     'antispasmodic',         'action'),
  (v_ginger,     'warming',              'action'),

  -- ── Cardamom ─────────────────────────────────────────────────────────────────
  (v_cardamom,   'digestive tonic',        'ailment'),
  (v_cardamom,   'carminative',           'action'),
  (v_cardamom,   'warming',              'action'),

  -- ── Slippery Elm ─────────────────────────────────────────────────────────────
  (v_slippery_elm,'digestive tonic',       'ailment'),
  (v_slippery_elm,'dry gut',              'ailment'),
  (v_slippery_elm,'constipation',          'ailment'),
  (v_slippery_elm,'demulcent',            'action'),
  (v_slippery_elm,'mucilaginous',         'action'),

  -- ── Burdock ──────────────────────────────────────────────────────────────────
  (v_burdock,    'digestive tonic',        'ailment'),
  (v_burdock,    'alterative',            'action'),
  (v_burdock,    'demulcent',             'action'),

  -- ── Blue Vervain ─────────────────────────────────────────────────────────────
  (v_blue_vervain,'digestive tonic',       'ailment'),
  (v_blue_vervain,'digestive bitter',      'action'),
  (v_blue_vervain,'nervine',              'action'),

  -- ── Blackberry ───────────────────────────────────────────────────────────────
  (v_blackberry, 'diarrhea',              'ailment'),
  (v_blackberry, 'GI inflammation',       'ailment'),
  (v_blackberry, 'astringent',            'action'),

  -- ── Raspberry ────────────────────────────────────────────────────────────────
  (v_raspberry,  'diarrhea',              'ailment'),
  (v_raspberry,  'GI inflammation',       'ailment'),
  (v_raspberry,  'astringent',            'action'),

  -- ── Yarrow ───────────────────────────────────────────────────────────────────
  (v_yarrow,     'diarrhea',              'ailment'),
  (v_yarrow,     'GI inflammation',       'ailment'),
  (v_yarrow,     'astringent',            'action'),

  -- ── Meadowsweet ──────────────────────────────────────────────────────────────
  (v_meadowsweet,'diarrhea',              'ailment'),
  (v_meadowsweet,'GI inflammation',       'ailment'),
  (v_meadowsweet,'astringent',            'action'),
  (v_meadowsweet,'anti-inflammatory',     'action'),

  -- ── Fennel ───────────────────────────────────────────────────────────────────
  (v_fennel,     'diarrhea',              'ailment'),
  (v_fennel,     'digestive tonic',        'ailment'),
  (v_fennel,     'antispasmodic',         'action'),
  (v_fennel,     'carminative',           'action'),

  -- ── Catnip ───────────────────────────────────────────────────────────────────
  (v_catnip,     'diarrhea',              'ailment'),
  (v_catnip,     'digestive tonic',        'ailment'),
  (v_catnip,     'antispasmodic',         'action'),
  (v_catnip,     'carminative',           'action'),

  -- ── Chamomile ────────────────────────────────────────────────────────────────
  (v_chamomile,  'diarrhea',              'ailment'),
  (v_chamomile,  'digestive tonic',        'ailment'),
  (v_chamomile,  'antispasmodic',         'action'),
  (v_chamomile,  'carminative',           'action'),

  -- ── Cinnamon ─────────────────────────────────────────────────────────────────
  (v_cinnamon,   'diarrhea',              'ailment'),
  (v_cinnamon,   'digestive tonic',        'ailment'),
  (v_cinnamon,   'constipation',           'ailment'),
  (v_cinnamon,   'antispasmodic',         'action'),
  (v_cinnamon,   'carminative',           'action'),
  (v_cinnamon,   'warming',              'action'),

  -- ── Peppermint ───────────────────────────────────────────────────────────────
  (v_peppermint, 'diarrhea',              'ailment'),
  (v_peppermint, 'digestive tonic',        'ailment'),
  (v_peppermint, 'IBS',                   'ailment'),
  (v_peppermint, 'antispasmodic',         'action'),
  (v_peppermint, 'carminative',           'action'),

  -- ── Echinacea ────────────────────────────────────────────────────────────────
  (v_echinacea,  'diarrhea',              'ailment'),
  (v_echinacea,  'immune support',         'ailment'),
  (v_echinacea,  'antimicrobial',         'action'),

  -- ── Baptisia / Wild Indigo ───────────────────────────────────────────────────
  (v_baptisia,   'diarrhea',              'ailment'),
  (v_baptisia,   'immune support',         'ailment'),
  (v_baptisia,   'antimicrobial',         'action'),

  -- ── Oregon Grape ─────────────────────────────────────────────────────────────
  (v_oregon_grape,'diarrhea',             'ailment'),
  (v_oregon_grape,'immune support',        'ailment'),
  (v_oregon_grape,'antimicrobial',        'action'),

  -- ── Reishi ───────────────────────────────────────────────────────────────────
  (v_reishi,     'diarrhea',              'ailment'),
  (v_reishi,     'immune support',         'ailment'),
  (v_reishi,     'immune modulator',       'action'),

  -- ── Astragalus ───────────────────────────────────────────────────────────────
  (v_astragalus, 'diarrhea',              'ailment'),
  (v_astragalus, 'immune support',         'ailment'),
  (v_astragalus, 'immune modulator',       'action'),

  -- ── St. John's Wort ──────────────────────────────────────────────────────────
  (v_sjw,        'diarrhea',              'ailment'),
  (v_sjw,        'IBS',                   'ailment'),
  (v_sjw,        'nervine',              'action'),

  -- ── Ocotillo ─────────────────────────────────────────────────────────────────
  (v_ocotillo,   'constipation',           'ailment'),
  (v_ocotillo,   'lymphatic support',      'ailment'),
  (v_ocotillo,   'circulatory stimulant',  'action')

  ON CONFLICT (herb_id, keyword) DO NOTHING;

  RAISE NOTICE 'Class 42 herb keywords: done.';
END $$;


-- ============================================================
-- Block 3: Ailment search terms (new keywords only)
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES

    ('constipation',
     ARRAY['hard stools', 'dry stools', 'infrequent bowel movements', 'difficulty defecating',
           'bowel irregularity', 'slow bowel transit', 'straining to defecate']),

    ('diarrhea',
     ARRAY['loose stools', 'watery stools', 'frequent bowel movements', 'loose bowels',
           'gastroenteritis', 'GI infection', 'rapid bowel transit'])

  ON CONFLICT (ailment_keyword) DO NOTHING;

  RAISE NOTICE 'Class 42 ailment search terms: done.';
END $$;
