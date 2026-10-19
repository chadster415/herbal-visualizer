-- Migration 415: Class 8 — Immune System I class notes
-- File parsed: BHC - Class 8 - Immune System I - Ashley Rose Mer.md (note_type='personal')
-- No generated notes file exists for this class.
--
-- Normalisations:
--   Eleuthero               → Siberian Ginseng (Eleutherococcus senticosus, id=9)
--   Tulsi                   → Holy Basil (Ocimum sanctum, id=13)
--   Ginsengs                → Ginseng (Panax ginseng, id=14)
--   Bikhail/Baical Skullcap → Chinese Skullcap (Scutellaria baicalensis, id=2274)
--   Reishi                  → Reishi Mushroom (Ganoderma lucidum, id=11)
--   Schisandra              → Schizandra (Schisandra chinensis, id=17)
--   Elderberry              → Elder berry (Sambucus nigra berry, id=1651)
--   Elderflower             → Elder flower (Sambucus nigra flower, id=57)
--   Oregon Grape Root       → Oregon Grape (Mahonia aquifolium, id=33)
--   Nettles                 → Nettle leaf (Urtica dioica, id=43)
--   Dandelion               → Dandelion leaf (Taraxacum officinale, id=1648)
--   Evening Primrose Oil    → supplement id=42 (not herb)
--
-- Skipped (not in DB / not appropriate to add):
--   Wild garlic (Allium ursinum) — different species from A. sativum; mentioned in forage/food context
--   Three-cornered leek (Allium triquetrium) — food herb only, no clinical content
--
-- Keyword merge decisions:
--   "seasonal allergy relief"  → merged into 'allergies' and 'hay fever' (both existing)
--   "lower cortisol"           → 'stress', 'adrenal fatigue' (existing)
--   "autoimmune"               → 'autoimmune disease' (existing)
--   "high BP" (Licorice)       → 'hypertension' (existing)
--   New ailment keyword: 'fungal infection' (covers athlete''s foot, nail fungus, tinea)

SET search_path TO herbal, public;

-- ── Snippets ─────────────────────────────────────────────────────────────────

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM herbal.class_note_snippets
    WHERE class_name = 'BHC - Class 8 - Immune System I'
  ) THEN
    RAISE NOTICE 'Class 8 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- Herb snippets
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES

    -- ── Organs of the Immune System ───────────────────────────────────────────
    (59,
     'Thyme actually has an affinity for the Thymus.',
     'BHC - Class 8 - Immune System I', 'personal', 'Organs of the Immune System', 10,
     '### Organs of the Immune System
- Red Bone Marrow: where immune cells are created
- Spleen: where B cells (mature) and T cells store themselves, stores platelets, filters blood
- Thymus: where white blood cells go to mature
    - training academy for white blood cells
    - T cells (for Thymus)
    - responsible for identifying self vs others
    - Thyme actually has an affinity for the Thymus
- Lymph Nodes: where B cells and T cells live
- Skin: physical barrier that also contains surveillance cells
    - these Langerhans cells are like "golden retriever" look what I found! and recruit other cells
- Mucus Membranes: big barriers that can trap pathogens
- Liver: helps clear out worn out white blood cells
- Blood cells: superstars of the immune system'),

    -- ── What Affects the Immune System ────────────────────────────────────────
    (9,
     'Eleuthero, Tulsi, Ginseng — lower cortisol. Adaptogens that support stress response and immune function.',
     'BHC - Class 8 - Immune System I', 'personal', 'What Affects the Immune System', 30,
     '### What affects the immune system?
- Stress
    - Hypothalamus - "God"
    - Pituitary
    - Adrenal
    - Phases of the Stress response
        - Alarm reaction phase
            - pupils dilate
            - liver starts to convert stored sugar into glucose
            - muscles pump with lactic acid
        - Resistance
            - Adrenaline released
            - Noradrenaline released
        - Cortisol released from the Adrenals to maintain fight or flight
            - when cortisol is high for long times:
                - harden arteries - arteriosclerosis
                - insulin utilization is impaired
                - downregulates the immune system
            - still not turned off?
                - Thyroxine axis
                    - Thyroid coming into play to pump out more stress hormones
    - Eleuthero, Tulsi, Ginseng
        - lower cortisol
    - also Chamomile can support the rest and digest
- Emotions
- Environmental Toxins'),

    (13,
     'Eleuthero, Tulsi, Ginseng — lower cortisol. Tulsi (Holy Basil) supports the stress response and helps modulate immune function.',
     'BHC - Class 8 - Immune System I', 'personal', 'What Affects the Immune System', 40,
     '### What affects the immune system?
- Stress
    - Hypothalamus - "God"
    - Pituitary
    - Adrenal
    - Phases of the Stress response
        - Alarm reaction phase
            - pupils dilate
            - liver starts to convert stored sugar into glucose
            - muscles pump with lactic acid
        - Resistance
            - Adrenaline released
            - Noradrenaline released
        - Cortisol released from the Adrenals to maintain fight or flight
            - when cortisol is high for long times:
                - harden arteries - arteriosclerosis
                - insulin utilization is impaired
                - downregulates the immune system
            - still not turned off?
                - Thyroxine axis
                    - Thyroid coming into play to pump out more stress hormones
    - Eleuthero, Tulsi, Ginseng
        - lower cortisol
    - also Chamomile can support the rest and digest
- Emotions
- Environmental Toxins'),

    (14,
     'Eleuthero, Tulsi, Ginseng — lower cortisol. Ginseng as an adaptogen supports immune function and stress response.',
     'BHC - Class 8 - Immune System I', 'personal', 'What Affects the Immune System', 50,
     '### What affects the immune system?
- Stress
    - Hypothalamus - "God"
    - Pituitary
    - Adrenal
    - Phases of the Stress response
        - Alarm reaction phase
            - pupils dilate
            - liver starts to convert stored sugar into glucose
            - muscles pump with lactic acid
        - Resistance
            - Adrenaline released
            - Noradrenaline released
        - Cortisol released from the Adrenals to maintain fight or flight
            - when cortisol is high for long times:
                - harden arteries - arteriosclerosis
                - insulin utilization is impaired
                - downregulates the immune system
            - still not turned off?
                - Thyroxine axis
                    - Thyroid coming into play to pump out more stress hormones
    - Eleuthero, Tulsi, Ginseng
        - lower cortisol
    - also Chamomile can support the rest and digest
- Emotions
- Environmental Toxins'),

    (84,
     'Chamomile can support the rest and digest response; supportive for stress and immune function.',
     'BHC - Class 8 - Immune System I', 'personal', 'What Affects the Immune System', 60,
     '### What affects the immune system?
- Stress
    - Hypothalamus - "God"
    - Pituitary
    - Adrenal
    - Phases of the Stress response
        - Alarm reaction phase
            - pupils dilate
            - liver starts to convert stored sugar into glucose
            - muscles pump with lactic acid
        - Resistance
            - Adrenaline released
            - Noradrenaline released
        - Cortisol released from the Adrenals to maintain fight or flight
            - when cortisol is high for long times:
                - harden arteries - arteriosclerosis
                - insulin utilization is impaired
                - downregulates the immune system
            - still not turned off?
                - Thyroxine axis
                    - Thyroid coming into play to pump out more stress hormones
    - Eleuthero, Tulsi, Ginseng
        - lower cortisol
    - also Chamomile can support the rest and digest
- Emotions
- Environmental Toxins'),

    -- ── Rose Intro — fresh chamomile preparation ─────────────────────────────
    (84,
     'Fresh chamomile quick cold infusion — zapped with immersion blender. Less sedative than dried infusion. Playful, joyful; follows the sun, opens petals in the sun; harvest when petals are open.',
     'BHC - Class 8 - Immune System I', 'personal', 'Rose Intro (Guest Instructor)', 65,
     '## Rose intro
Rose - alumni, grad 2021
- clinical program
- built the kitchen
- faculty then board 2 years
- Sierra Foothills now
- 5 acres, small herb farm
- Plant Spirit Talk
- stepped back from clinical work to focus on growing the plants
- passion was medicine making
- Golden Rose Botanicals
- land keeping her super busy
- mentor runs the Herb Exchange

- fresh chamomile quick cold infusion
    - zapped with immersion blender
- playful, joyful
- follows the sun, opens petals in the sun
- harvest when petals are open
- less sedative than dried infusion

- Sonoma County Herb Exchange
- with Spring medicine, lots of delicacy
- best to extract? succus
- "pond water": blend it, sit overnight, then mix with honey, etc
- also great in food, of course
- tend toward folk method with spring herbs'),

    -- ── Lymphatics ────────────────────────────────────────────────────────────
    (981,
     'Red root — whole body lymphatic.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 70,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    (28,
     'Cleavers — herbalist badge; affinity for upper third of the body. Preparation: blend and strain and freeze.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 80,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    (39,
     'Figwort — lymphatic herb for dissolving hardened lymph nodes.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 90,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    (35,
     'Poke root — lymphatic; drop dose or low dose only.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 100,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    (1248,
     'Ocotillo — lower body lymphatic affinity; specifically for pelvic floor lymphatic congestion.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 110,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    (198,
     'Violet — lymphatic herb.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 120,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    (70,
     'Calendula — gentle whole-body lymphatic.',
     'BHC - Class 8 - Immune System I', 'personal', 'Lymphatics', 130,
     '#### Lymphatics
- Red root - whole body
- Cleavers - herbalist badge - affinity for upper third
    - blend and strain and freeze
- Figwort - dissolve hardened nodes
- Poke root - drop dose or low dose
- Ocotillo - lower body affinity - pelvic floor lymphatic
- Violet
- Calendula - gentle, whole body'),

    -- ── Immune Amphoterics ────────────────────────────────────────────────────
    (11,
     'Reishi good for autoimmune conditions; classified as an immune amphoteric (balancing: brings down excess, raises deficiency).',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 140,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    (225,
     'Astragalus — TCM herb, very sweet; immune amphoteric. Do not take when sick — specific for chronic conditions, not acute illness.',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 150,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    (20,
     'Ashwagandha — immune amphoteric (deep nourisher).',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 160,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    (14,
     'Ginsengs — immune amphoterics (deep nourishers).',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 170,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    (2646,
     'Cat''s Claw — immune amphoteric (deep nourisher).',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 180,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    (78,
     'Licorice — immune amphoteric; be careful with dosage and high blood pressure.',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 190,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    (17,
     'Schisandra — TCM herb; immune amphoteric. Specifically noted for use in allergic asthma.',
     'BHC - Class 8 - Immune System I', 'personal', 'Immune Amphoterics', 200,
     '#### Immune Amphoterics (Deep Nourishers)
- Amphoteric = Balancing action
    - excess brings down, deficiency brings up
- Medicinal Mushrooms
    - Reishi good for autoimmune
- Astragalus - TCM herb
    - very sweet
    - don''t take when sick
    - specific for chronic, but not for acute
- Ashwagandha
- Ginsengs
- Cat''s Claw
- Licorice - just be careful with dosage and high BP
- Schisandra
    - TCM as well
    - use for allergic asthma'),

    -- ── Immunostimulants ──────────────────────────────────────────────────────
    (50,
     'Boneset — immunostimulant.',
     'BHC - Class 8 - Immune System I', 'personal', 'Immunostimulants', 210,
     '#### Immunostimulants (Immune Strengtheners)
- Boneset
- Elderberry
- Echinacea
    - one of the more famous immunostimulants
    - at the onset
    - if it''s "not working", you may not be taking enough
    - need 2-3 droppers every 2-3 hours
    - depending on species: Angustifolia is stronger than Purpurea
    - tastes like sucking on a penny - sialogogue'),

    (1651,
     'Elderberry — immunostimulant.',
     'BHC - Class 8 - Immune System I', 'personal', 'Immunostimulants', 220,
     '#### Immunostimulants (Immune Strengtheners)
- Boneset
- Elderberry
- Echinacea
    - one of the more famous immunostimulants
    - at the onset
    - if it''s "not working", you may not be taking enough
    - need 2-3 droppers every 2-3 hours
    - depending on species: Angustifolia is stronger than Purpurea
    - tastes like sucking on a penny - sialogogue'),

    (26,
     'Echinacea — one of the more famous immunostimulants; use at onset of illness. If it''s "not working", you may not be taking enough — need 2-3 droppers every 2-3 hours. Tastes like sucking on a penny (sialogogue).',
     'BHC - Class 8 - Immune System I', 'personal', 'Immunostimulants', 230,
     '#### Immunostimulants (Immune Strengtheners)
- Boneset
- Elderberry
- Echinacea
    - one of the more famous immunostimulants
    - at the onset
    - if it''s "not working", you may not be taking enough
    - need 2-3 droppers every 2-3 hours
    - depending on species: Angustifolia is stronger than Purpurea
    - tastes like sucking on a penny - sialogogue'),

    (221,
     'Echinacea angustifolia (Narrow-Leaf Echinacea) is stronger than E. purpurea.',
     'BHC - Class 8 - Immune System I', 'personal', 'Immunostimulants', 240,
     '#### Immunostimulants (Immune Strengtheners)
- Boneset
- Elderberry
- Echinacea
    - one of the more famous immunostimulants
    - at the onset
    - if it''s "not working", you may not be taking enough
    - need 2-3 droppers every 2-3 hours
    - depending on species: Angustifolia is stronger than Purpurea
    - tastes like sucking on a penny - sialogogue'),

    -- ── Antivirals ────────────────────────────────────────────────────────────
    (104,
     'Osha — antiviral (inhibits viral replication).',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 250,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    (980,
     'Lomatium — antiviral (inhibits viral replication).',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 260,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    (1651,
     'Elderberry — antiviral (inhibits viral replication); also listed as an immunostimulant.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 270,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    (2274,
     'Bikhail (Baical/Chinese) Skullcap — antiviral; Chinese species, differs from American Skullcap. Used for infections.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 280,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    (1512,
     'Isatis Root — antiviral (inhibits viral replication).',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 290,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    (2234,
     'Japanese Honeysuckle — antiviral (inhibits viral replication).',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 300,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    (21,
     'Garlic — antiviral; take like a pill every couple of hours. Let it oxidize for a minute before ingestion. Garlic skins are extremely psychic protective — decoction to remove heavy energies.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antivirals', 310,
     '#### Antivirals (Inhibit Viral Replication)
- Osha
- Lomatium
- Elderberry
- Bikhail Skullcap
    - Chinese
    - infections
    - diff than American Skullcap
- Isatis Root
- Japanese Honeysuckle
- Garlic
    - like a pill every couple of hours
    - let it oxidize for a minute before ingestion
    - Garlic skins - extremely psych protective
        - decoction - remove heavy energies'),

    -- ── Diaphoretics ──────────────────────────────────────────────────────────
    (44,
     'Yarrow — diaphoretic (promotes sweating to support fever).',
     'BHC - Class 8 - Immune System I', 'personal', 'Diaphoretics', 320,
     '#### Diaphoretics - promote sweating
- Yarrow
- Catnip
- Elderflower
- Dried Ginger
- Boneset
    - more East Coast herbalists'),

    (136,
     'Catnip — diaphoretic (promotes sweating).',
     'BHC - Class 8 - Immune System I', 'personal', 'Diaphoretics', 330,
     '#### Diaphoretics - promote sweating
- Yarrow
- Catnip
- Elderflower
- Dried Ginger
- Boneset
    - more East Coast herbalists'),

    (57,
     'Elderflower — diaphoretic (promotes sweating to support fever).',
     'BHC - Class 8 - Immune System I', 'personal', 'Diaphoretics', 340,
     '#### Diaphoretics - promote sweating
- Yarrow
- Catnip
- Elderflower
- Dried Ginger
- Boneset
    - more East Coast herbalists'),

    (124,
     'Dried Ginger — diaphoretic (promotes sweating).',
     'BHC - Class 8 - Immune System I', 'personal', 'Diaphoretics', 350,
     '#### Diaphoretics - promote sweating
- Yarrow
- Catnip
- Elderflower
- Dried Ginger
- Boneset
    - more East Coast herbalists'),

    (50,
     'Boneset — diaphoretic; more commonly used by East Coast herbalists.',
     'BHC - Class 8 - Immune System I', 'personal', 'Diaphoretics', 360,
     '#### Diaphoretics - promote sweating
- Yarrow
- Catnip
- Elderflower
- Dried Ginger
- Boneset
    - more East Coast herbalists'),

    -- ── Anticatarrhals ────────────────────────────────────────────────────────
    (30,
     'Goldenseal — anticatarrhal; affinity for working with mucous membranes.',
     'BHC - Class 8 - Immune System I', 'personal', 'Anticatarrhals', 370,
     '#### Anticatarrhals
- Goldenseal
    - affinity for working with mucus membranes
- Yerba Mansa
- Eyebright
    - grows in UK
    - really only works fresh
- Goldenrod
    - good local substitute for Eyebright
    - California Goldenrod'),

    (309,
     'Yerba Mansa — anticatarrhal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Anticatarrhals', 380,
     '#### Anticatarrhals
- Goldenseal
    - affinity for working with mucus membranes
- Yerba Mansa
- Eyebright
    - grows in UK
    - really only works fresh
- Goldenrod
    - good local substitute for Eyebright
    - California Goldenrod'),

    (51,
     'Eyebright — anticatarrhal; grows in UK; really only works fresh.',
     'BHC - Class 8 - Immune System I', 'personal', 'Anticatarrhals', 390,
     '#### Anticatarrhals
- Goldenseal
    - affinity for working with mucus membranes
- Yerba Mansa
- Eyebright
    - grows in UK
    - really only works fresh
- Goldenrod
    - good local substitute for Eyebright
    - California Goldenrod'),

    (58,
     'Goldenrod — anticatarrhal; good local California substitute for Eyebright.',
     'BHC - Class 8 - Immune System I', 'personal', 'Anticatarrhals', 400,
     '#### Anticatarrhals
- Goldenseal
    - affinity for working with mucus membranes
- Yerba Mansa
- Eyebright
    - grows in UK
    - really only works fresh
- Goldenrod
    - good local substitute for Eyebright
    - California Goldenrod'),

    -- ── Antifungals ───────────────────────────────────────────────────────────
    (30,
     'Goldenseal — antifungal; berberine-containing plant. Indicated for athlete''s foot, yeast infection, nail infection.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 410,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (33,
     'Oregon Grape — antifungal; berberine-containing plant.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 420,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (158,
     'Barberry — antifungal; berberine-containing plant.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 430,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (1561,
     'Chinese Coptis (Coptis Rhizome) — antifungal; berberine-containing plant.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 440,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (21,
     'Garlic — antifungal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 450,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (127,
     'Cardamom — antifungal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 460,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (2363,
     'Spilanthes — antifungal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 470,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (112,
     'Usnea — antifungal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 480,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (70,
     'Calendula — antifungal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 490,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    (288,
     'Black Walnut — antifungal.',
     'BHC - Class 8 - Immune System I', 'personal', 'Antifungals', 500,
     '#### Antifungals
- athlete''s foot, yeast infection, nail infection
- Berberine containing plants
    - Goldenseal, Oregon Grape, Barberry, Chinese Coptis
- Garlic
- Cardamom
- Spilanthes
- Usnea
- Calendula
- Black Walnut'),

    -- ── Medicine of Spring ────────────────────────────────────────────────────
    (1648,
     'Dandelion (Taraxacum officinale) — Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 510,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (43,
     'Stinging nettle (Urtica dioica) — Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals); used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is intentional stinging for therapeutic action.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 520,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (88,
     'Chickweed (Stellaria media) — Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally soothing to mucous membranes.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 530,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (198,
     'Violet (Viola spp.) — Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 540,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (85,
     'Plantain (Plantago major / lanceolata) — Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 550,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (42,
     'Red clover (Trifolium pratense) — Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 560,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (28,
     'Cleavers (Galium aparine) — Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 570,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irrigations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.'),

    (151,
     'Horsetail (Equisetum arvense) — Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. High silica content supports all silica-containing structures: bones, cartilage, hair, skin, nails, and mucous membranes. All collagen-containing structures benefit.',
     'BHC - Class 8 - Immune System I', 'personal', 'Medicine of Spring', 580,
     '## Medicine of Spring
Common Spring Herbs
- Dandelion (Taraxacum officinale) - Leaves, roots, flowers. Bitter, diuretic, liver-supportive (stimulates bile), mild digestive tonic, nutritive
- Stinging nettle (Urtica dioica) - Leaves, stems, root. Anti-inflammatory, diuretic, supports seasonal allergy relief (reduces histamine response), nutritive (iron, minerals), used for urinary support and joint pain. Hollow hairs (trichomes) contain histamine, acetylcholine, and serotonin. Urtication is the act of intentionally stinging for therapeutic action.
- Chickweed (Stellaria media) - Aerial parts. Cooling, demulcent, anti-inflammatory; used topically for minor skin irritations; internally it is soothing to mucous membranes.
- Violet (Viola spp.) - Leaves, flowers. Cooling, moistening, lymphatic, mild expectorant, demulcent and soothing for sore throats; flowers used in syrups and teas.
- Plantain (Plantago major / lanceolata) - Leaves. Anti-inflammatory, astringent, antimicrobial; excellent topically for insect bites, minor wounds, and skin inflammation.
- Red clover (Trifolium pratense) - Aerial parts/flowers. Blood-cleanse tradition, used for skin conditions (eczema), menopausal symptom support.
- Wild garlic (Allium ursinum) - Leaves and bulbs. Antimicrobial, cardiovascular-supportive (may modestly reduce blood pressure/lipids), digestive stimulant.
- Three-cornered leek (Allium triquetrium) - All parts of plant edible, leaves are mildest.
- Cleavers (Galium aparine) Lymphatic, diuretic, vulnerary, nutritive, anti-inflammatory, mild astringent
- Horsetail (Equisetum arvense) Astringent, diuretic, hemostatic, vulnerary, kidney tonic, mineralizer. Due to its high level of silica it is used to support all the structures that use silica (bones, cartilage, hair, skin, nails, and mucous membranes). All structures with collagen will be supported by this herb.');

  -- Supplement snippet (Evening Primrose Oil)
  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (42,
     'Evening Primrose Oil — mast cell stabilizer; mast cells release histamine and other chemical mediators in allergic reactions.',
     'BHC - Class 8 - Immune System I', 'personal', 'White Blood Cells', 20,
     '### White Blood Cells
- Myloid stem cell family
    - Monocytes (when in blood) - pac man cells
    - Macrophages (when in tissues)
    - Neutrophil (general attack cell)
    - Eosinophils
        - when molecules are too large to undergo phagocytosis, parasitic infections, contain chemicals to kill parasites
        - cleanup crew
    - Basophils - chronic allergic conditions
    - Mast cells (fixed location) - release inflammatory mediators, responders in allergic reactions
        - release histamine and diff chemical inhibitor
        - Evening Primrose Oil - mast cell stabilizer
- Lymphoid Stem Cell Family
    - B cells - produce antibodies in response to antigens, becomes plasma cells / memory B cells
        - mature in the Bone Marrow
    - T cells - mature in Thymus gland, 2 types:
        - Helper T cells
        - Cytotoxic T cells - help to deactivate other cells
    - Natural Killer Cells - activated by interferon and cytokines, increase inflammation and recruit macrophages, tumor surveillance');

END $$;

-- ── Keywords ─────────────────────────────────────────────────────────────────

-- Thyme
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (59, 'immune support',    'ailment'),
  (59, 'thymus support',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Siberian Ginseng
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (9, 'immune support',  'ailment'),
  (9, 'stress',          'ailment'),
  (9, 'adrenal fatigue', 'ailment'),
  (9, 'adaptogen',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Holy Basil / Tulsi
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (13, 'immune support',  'ailment'),
  (13, 'stress',          'ailment'),
  (13, 'adrenal fatigue', 'ailment'),
  (13, 'adaptogen',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginseng
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (14, 'immune support',  'ailment'),
  (14, 'stress',          'ailment'),
  (14, 'adaptogen',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chamomile
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (84, 'stress',                 'ailment'),
  (84, 'nervous system support', 'ailment'),
  (84, 'immune support',         'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Evening Primrose Oil (supplement)
INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (42, 'mast cell activation syndrome', 'ailment'),
  (42, 'allergies',                     'ailment'),
  (42, 'immune support',                'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Red Root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (981, 'lymphatic support', 'ailment'),
  (981, 'lymphatic',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cleavers
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (28, 'lymphatic support', 'ailment'),
  (28, 'edema',             'ailment'),
  (28, 'lymphatic',         'action'),
  (28, 'diuretic',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Figwort
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (39, 'lymphatic support', 'ailment'),
  (39, 'lymphatic',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Poke Root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (35, 'lymphatic support', 'ailment'),
  (35, 'lymphatic',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ocotillo
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1248, 'lymphatic support', 'ailment'),
  (1248, 'lymphatic',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Violet
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (198, 'lymphatic support', 'ailment'),
  (198, 'sore throat',       'ailment'),
  (198, 'lymphatic',         'action'),
  (198, 'expectorant',       'action'),
  (198, 'demulcent',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Calendula
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (70, 'lymphatic support', 'ailment'),
  (70, 'yeast overgrowth',  'ailment'),
  (70, 'skin conditions',   'ailment'),
  (70, 'fungal infection',  'ailment'),
  (70, 'lymphatic',         'action'),
  (70, 'antifungal',        'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Reishi Mushroom
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (11, 'immune support',    'ailment'),
  (11, 'autoimmune disease','ailment'),
  (11, 'adaptogen',         'action'),
  (11, 'immunomodulator',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Astragalus
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (225, 'immune support',   'ailment'),
  (225, 'immune deficiency','ailment'),
  (225, 'fatigue',          'ailment'),
  (225, 'adaptogen',        'action'),
  (225, 'immunomodulator',  'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ashwagandha
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (20, 'immune support',  'ailment'),
  (20, 'stress',          'ailment'),
  (20, 'adrenal fatigue', 'ailment'),
  (20, 'adaptogen',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cat's Claw
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2646, 'immune support',    'ailment'),
  (2646, 'immunomodulator',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Licorice
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78, 'immune support',  'ailment'),
  (78, 'hypertension',    'ailment'),
  (78, 'adaptogen',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Schizandra
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (17, 'immune support',  'ailment'),
  (17, 'asthma',          'ailment'),
  (17, 'allergies',       'ailment'),
  (17, 'adaptogen',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Boneset
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (50, 'immune support',   'ailment'),
  (50, 'influenza',        'ailment'),
  (50, 'fever',            'ailment'),
  (50, 'immunostimulant',  'action'),
  (50, 'diaphoretic',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Elder berry
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1651, 'immune support',  'ailment'),
  (1651, 'influenza',       'ailment'),
  (1651, 'common cold',     'ailment'),
  (1651, 'immunostimulant', 'action'),
  (1651, 'antiviral',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Echinacea
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (26, 'immune support',  'ailment'),
  (26, 'common cold',     'ailment'),
  (26, 'influenza',       'ailment'),
  (26, 'acute illness',   'ailment'),
  (26, 'immunostimulant', 'action'),
  (26, 'sialogogue',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Narrow-Leaf Echinacea
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (221, 'immune support',  'ailment'),
  (221, 'common cold',     'ailment'),
  (221, 'influenza',       'ailment'),
  (221, 'immunostimulant', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Osha
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (104, 'respiratory infection', 'ailment'),
  (104, 'influenza',             'ailment'),
  (104, 'antiviral',             'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Lomatium
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (980, 'respiratory infection', 'ailment'),
  (980, 'influenza',             'ailment'),
  (980, 'antiviral',             'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chinese Skullcap
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2274, 'respiratory infection', 'ailment'),
  (2274, 'acute illness',         'ailment'),
  (2274, 'antiviral',             'action'),
  (2274, 'antimicrobial',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Isatis Root
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1512, 'respiratory infection', 'ailment'),
  (1512, 'acute illness',         'ailment'),
  (1512, 'antiviral',             'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Japanese Honeysuckle
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2234, 'respiratory infection', 'ailment'),
  (2234, 'antiviral',             'action'),
  (2234, 'antimicrobial',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Garlic
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (21, 'respiratory infection', 'ailment'),
  (21, 'immune support',        'ailment'),
  (21, 'yeast overgrowth',      'ailment'),
  (21, 'fungal infection',      'ailment'),
  (21, 'antiviral',             'action'),
  (21, 'antifungal',            'action'),
  (21, 'antimicrobial',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yarrow
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44, 'fever',       'ailment'),
  (44, 'common cold', 'ailment'),
  (44, 'influenza',   'ailment'),
  (44, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Catnip
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (136, 'fever',       'ailment'),
  (136, 'common cold', 'ailment'),
  (136, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Elder flower
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (57, 'fever',       'ailment'),
  (57, 'common cold', 'ailment'),
  (57, 'influenza',   'ailment'),
  (57, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ginger
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (124, 'fever',       'ailment'),
  (124, 'common cold', 'ailment'),
  (124, 'diaphoretic', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goldenseal
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (30, 'mucous membrane support', 'ailment'),
  (30, 'sinus infection',         'ailment'),
  (30, 'yeast overgrowth',        'ailment'),
  (30, 'fungal infection',        'ailment'),
  (30, 'anticatarrhal',           'action'),
  (30, 'antifungal',              'action'),
  (30, 'antimicrobial',           'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Yerba Mansa
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (309, 'mucous membrane support', 'ailment'),
  (309, 'sinus infection',         'ailment'),
  (309, 'anticatarrhal',           'action'),
  (309, 'antimicrobial',           'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Eyebright
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (51, 'hay fever',    'ailment'),
  (51, 'sinus infection', 'ailment'),
  (51, 'allergies',    'ailment'),
  (51, 'anticatarrhal','action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Goldenrod
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (58, 'hay fever',       'ailment'),
  (58, 'sinus infection', 'ailment'),
  (58, 'allergies',       'ailment'),
  (58, 'anticatarrhal',   'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oregon Grape
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (33, 'fungal infection', 'ailment'),
  (33, 'yeast overgrowth', 'ailment'),
  (33, 'antifungal',       'action'),
  (33, 'antimicrobial',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Barberry
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (158, 'fungal infection', 'ailment'),
  (158, 'yeast overgrowth', 'ailment'),
  (158, 'antifungal',       'action'),
  (158, 'antimicrobial',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chinese Coptis (Coptis Rhizome)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1561, 'fungal infection', 'ailment'),
  (1561, 'yeast overgrowth', 'ailment'),
  (1561, 'antifungal',       'action'),
  (1561, 'antimicrobial',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cardamom
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (127, 'fungal infection', 'ailment'),
  (127, 'antifungal',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Spilanthes
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (2363, 'fungal infection', 'ailment'),
  (2363, 'yeast overgrowth', 'ailment'),
  (2363, 'antifungal',       'action'),
  (2363, 'antimicrobial',    'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Usnea
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (112, 'respiratory infection', 'ailment'),
  (112, 'fungal infection',      'ailment'),
  (112, 'antifungal',            'action'),
  (112, 'antimicrobial',         'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Black Walnut
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (288, 'fungal infection', 'ailment'),
  (288, 'yeast overgrowth', 'ailment'),
  (288, 'antifungal',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Dandelion leaf
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (1648, 'liver support',    'ailment'),
  (1648, 'digestive tonic',  'ailment'),
  (1648, 'edema',            'ailment'),
  (1648, 'diuretic',         'action'),
  (1648, 'nutritive',        'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Nettle leaf
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (43, 'allergies',       'ailment'),
  (43, 'hay fever',       'ailment'),
  (43, 'inflammation',    'ailment'),
  (43, 'edema',           'ailment'),
  (43, 'mineral support', 'ailment'),
  (43, 'iron deficiency', 'ailment'),
  (43, 'diuretic',        'action'),
  (43, 'nutritive',       'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Chickweed
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (88, 'skin conditions',        'ailment'),
  (88, 'mucous membrane support','ailment'),
  (88, 'inflammation',           'ailment'),
  (88, 'demulcent',              'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Plantain
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (85, 'insect bites',    'ailment'),
  (85, 'wound healing',   'ailment'),
  (85, 'skin conditions', 'ailment'),
  (85, 'inflammation',    'ailment'),
  (85, 'antimicrobial',   'action'),
  (85, 'vulnerary',       'action'),
  (85, 'astringent',      'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Red Clover
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (42, 'blood cleansing', 'ailment'),
  (42, 'eczema',          'ailment'),
  (42, 'skin conditions', 'ailment'),
  (42, 'perimenopause',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Horsetail
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (151, 'bone density',              'ailment'),
  (151, 'connective tissue disorders','ailment'),
  (151, 'kidney support',            'ailment'),
  (151, 'mineral support',           'ailment'),
  (151, 'skin conditions',           'ailment'),
  (151, 'diuretic',                  'action'),
  (151, 'vulnerary',                 'action'),
  (151, 'mineralizer',               'action'),
  (151, 'astringent',                'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ── Ailment search synonyms (new keyword only) ────────────────────────────────

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('fungal infection',
   ARRAY['tinea', 'athlete''s foot', 'ringworm', 'nail fungus', 'onychomycosis', 'tinea versicolor'])
ON CONFLICT (ailment_keyword) DO NOTHING;
