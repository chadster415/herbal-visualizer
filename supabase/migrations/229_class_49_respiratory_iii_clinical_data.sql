-- Migration 229: Class 49 — Respiratory III and Clinical
-- Source: BHC - Class 49 - Respiratory III and Clinical
-- Date: 2026-07-30

SET search_path TO herbal, public;

-- ============================================================
-- Block 1: Class 49 herb snippets
-- ============================================================
DO $$
DECLARE
  v_class CONSTANT TEXT := 'BHC - Class 49 - Respiratory III and Clinical';

  v_schizandra  INTEGER;
  v_elecampane  INTEGER;
  v_mullein     INTEGER;
  v_prince_seng INTEGER;
  v_reishi      INTEGER;
  v_astragalus  INTEGER;
  v_lomatium    INTEGER;
  v_osha        INTEGER;
  v_goldenrod   INTEGER;
  v_motherwort  INTEGER;
  v_hawthorn    INTEGER;
  v_lobelia     INTEGER;
  v_wild_cherry INTEGER;
  v_angelica    INTEGER;
  v_yerba_mansa INTEGER;
  v_licorice    INTEGER;
  v_gotu_kola   INTEGER;
  v_spikenard   INTEGER;

  v_src_tropho CONSTANT TEXT := $blk$
### Tonics / Trophorestoratives
- Astragalus
- Aralia
- Schisandra
    - ability to liquify hardened accumulated lung material
- Reishi
    - supportive for chronic cough
- Goldenseal
- Elecampane
    - think deep structures - where alveola is ghummed up and gas exchange not happening properly
- Devil's Club
- Cordyceps
- Prince Seng
    - specific for lung tissue restoration
- Mullein
    - flowers, Lisa doesn't mess with the leaves and the hairs
    - moistening and nourishing to the tissues
$blk$;

  v_src_antiviral CONSTANT TEXT := $blk$
### Antiviral
- Garlic
- Elecampane
- Lomatium
    - the big one here
    - the most potent antiviral, so effective that sometimes people get rashes when they take it, so be careful about dosing
    - viral shedding that pushes waste out of the skin
- Osha & Oshala
    - but very drying, so balance out with moistening herbs
    - can dry out the tissues and kill the microbes, but cough may result from that
- Aralia
$blk$;

  v_src_anticatarrhal CONSTANT TEXT := $blk$
### Anticatarrhal
- if someone is overproducing mucus, something wants to come up and out, but let it play out before trying to dry it up
- Yerba Mansa, Goldenseal, Garlic, Boneset, Goldenrod
- goldenrod = runny nose that won't stop, so makes sense here
$blk$;

  v_src_nervines CONSTANT TEXT := $blk$
### Bronchodilator
- Osha
- Lobelia
- Pine
- Aralia
### Antitussive
- Wild Cherry Bark
- Thyme
- Lobelia
### Nervines
- Motherwort
- Hawthorn
- both circ stim as well, support the blood flow gas exchange
- there may be other nervines not circ stim useful for the person though
$blk$;

  v_src_antispasmodic CONSTANT TEXT := $blk$
### Antispasmodic
- Wild Cherry Bark, Lobelia

[from generated notes]
- Lobelia: Relaxes structures, can cause vomiting; Used in asthma, anaphylaxis; Dilates other structures (e.g., cervix); Low dose: 5-30 drops
$blk$;

  v_src_hay_fever CONSTANT TEXT := $blk$
## Hay Fever
### Herbs to use
- Yerba Mansa - sometimes little bit of decoction in neti pot
- prepping the terrain of the body through the winter
    - reishi, astragalus, licorice (?ratio in audio)
        - lessens allergic responses in the spring, esp licorice tea
    - want to mineralize the body, take from acidic allergies to alkaline
    - liver issues tend to have more seasonal allergies
$blk$;

  v_src_bronchitis CONSTANT TEXT := $blk$
## Bronchitis
- also support with demulcents
- symptoms:
    - tightness or burning in chest
    - productive cough
    - maybe fever, general feeling of malaise
    - maybe gray or blue on their lips due to poor tissue oxygenation
    - if fever spikes, be alert of advance to pneumonia
    - most common cause is viral, can then leave lungs vulnerable to bacterial infection
- once the airway is inflamed, it can take up to a month to recover
- also support deep connective tissue (Gotu Kola)
    - gas exchange and integrity of those tissues
$blk$;

  v_src_asthma CONSTANT TEXT := $blk$
## Asthma
- an immune response, in response to perceived antigens
- bronchial smooth muscles get inflamed, thickened, puckered, and hypertonic — restricts flow, influences air exchange and waste buildup
- sulfur compounds in cruciferous veggies helpful; alliums too
### Herbs
- Antispasmodics - add Angelica
- Relaxing expectorant - Elecampane added
- Pulmonary tonics: astragalus used the most + Elecampane and Yerba Mansa
$blk$;

  v_src_dosing_gen CONSTANT TEXT := $blk$
## Dosing Guidelines (generated notes, afternoon)
- Astragalus: 2-4 mL, around 80 drops
- Leonurus cardiaca (Motherwort): 1-4 mL
- Lobelia: Low dose, 5-30 drops
- Acute conditions: frequent dosing, high therapeutic range
- Chronic/tonic: medium-low range, less frequent
$blk$;

  v_src_percolation_gen CONSTANT TEXT := $blk$
## Percolation and Tincture Making (generated notes, afternoon)
- Percolation has more astringent quality than standard maceration
- Glycerin holds tannins — tannins stronger with glycerin
- Color indicates extraction quality — darker tincture better
- Cherry bark: harvested and prepped with brandy and honey, strained for use
$blk$;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_class) THEN
    RAISE NOTICE 'Class 49 snippets already loaded — skipping';
    RETURN;
  END IF;

  SELECT id INTO v_schizandra  FROM herbal.herbs WHERE latin_name = 'Schisandra chinensis';
  SELECT id INTO v_elecampane  FROM herbal.herbs WHERE latin_name = 'Inula helenium';
  SELECT id INTO v_mullein     FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  SELECT id INTO v_prince_seng FROM herbal.herbs WHERE latin_name = 'Pseudostellaria heterophylla';
  SELECT id INTO v_reishi      FROM herbal.herbs WHERE latin_name = 'Ganoderma lucidum';
  SELECT id INTO v_astragalus  FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus';
  SELECT id INTO v_lomatium    FROM herbal.herbs WHERE latin_name = 'Lomatium dissectum';
  SELECT id INTO v_osha        FROM herbal.herbs WHERE latin_name = 'Ligusticum porteri';
  SELECT id INTO v_goldenrod   FROM herbal.herbs WHERE latin_name = 'Solidago virgaurea';
  SELECT id INTO v_motherwort  FROM herbal.herbs WHERE latin_name = 'Leonurus cardiaca';
  SELECT id INTO v_hawthorn    FROM herbal.herbs WHERE latin_name = 'Crataegus spp.' AND plant_part = 'berry';
  SELECT id INTO v_lobelia     FROM herbal.herbs WHERE latin_name = 'Lobelia inflata';
  SELECT id INTO v_wild_cherry FROM herbal.herbs WHERE latin_name = 'Prunus serotina';
  SELECT id INTO v_angelica    FROM herbal.herbs WHERE latin_name = 'Angelica archangelica';
  SELECT id INTO v_yerba_mansa FROM herbal.herbs WHERE latin_name = 'Anemopsis californica';
  SELECT id INTO v_licorice    FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
  SELECT id INTO v_gotu_kola   FROM herbal.herbs WHERE latin_name = 'Centella asiatica';
  SELECT id INTO v_spikenard   FROM herbal.herbs WHERE latin_name = 'Aralia racemosa';

  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    -- Trophorestoratives
    (v_schizandra,  'Schizandra has a specific ability to liquify hardened, accumulated lung material — useful for deep, chronic lung congestion.',
     v_class, 'personal', 'Tonics / Trophorestoratives', 10, v_src_tropho),

    (v_elecampane,  'Think deep lung structures with elecampane — where the alveoli are gummed up and gas exchange is not happening properly. Elecampane root is indicated for fibrocystic pulmonary disease.',
     v_class, 'personal', 'Tonics / Trophorestoratives', 20, v_src_tropho),

    (v_mullein,     'Lisa prefers mullein flowers over the leaves — the leaf hairs are irritating. Flowers are moistening and nourishing to the lung tissues.',
     v_class, 'personal', 'Tonics / Trophorestoratives', 30, v_src_tropho),

    (v_prince_seng, 'Prince Seng (Pseudostellaria heterophylla) is specific for lung tissue restoration.',
     v_class, 'personal', 'Tonics / Trophorestoratives', 40, v_src_tropho),

    (v_reishi,      'Reishi is supportive for chronic cough as a pulmonary trophorestorative.',
     v_class, 'personal', 'Tonics / Trophorestoratives', 50, v_src_tropho),

    (v_astragalus,  'Astragalus is the primary pulmonary trophorestorative and the most-used herb in asthma. Stop during acute illness; resume for prevention and tonic use. Dosing: 2–4 mL (approximately 80 drops).',
     v_class, 'personal', 'Tonics / Trophorestoratives', 60, v_src_tropho),

    -- Antiviral
    (v_lomatium,    'Lomatium is the most potent antiviral in the respiratory materia medica. It can be so effective that viral shedding pushes waste out through the skin as a rash — start low and be careful with dosing.',
     v_class, 'personal', 'Antiviral', 70, v_src_antiviral),

    (v_osha,        'Osha and Oshala are very drying antivirals — always balance with moistening herbs. Overuse can dry the tissues, kill the microbes, but then produce a cough from the resulting dryness.',
     v_class, 'personal', 'Antiviral', 80, v_src_antiviral),

    -- Anticatarrhal
    (v_goldenrod,   'Goldenrod as anticatarrhal is specifically for the runny nose that won''t stop. When mucus is overproducing, let it play out before reaching for anticatarrhals — something wants to come up and out.',
     v_class, 'personal', 'Anticatarrhal', 90, v_src_anticatarrhal),

    -- Nervines
    (v_motherwort,  'Motherwort serves double duty in respiratory support: nervine for the emotional and stress dimension of breathing, and circulatory stimulant supporting blood flow and gas exchange. Dosing: 1–4 mL.',
     v_class, 'personal', 'Nervines', 100, v_src_nervines),

    (v_hawthorn,    'Hawthorn is both nervine and circulatory stimulant — supporting the blood flow underlying lung gas exchange. Use when circulation is part of the respiratory picture.',
     v_class, 'personal', 'Nervines', 110, v_src_nervines),

    -- Antispasmodic / Bronchodilator
    (v_lobelia,     'Lobelia is the key antispasmodic and bronchodilator — relaxes bronchial structures and can cause vomiting at higher doses. Used in asthma and anaphylaxis; also dilates other structures such as the cervix. Low dose: 5–30 drops.',
     v_class, 'personal', 'Antispasmodic / Bronchodilator', 120, v_src_antispasmodic),

    (v_wild_cherry, 'Wild Cherry Bark is both antitussive and antispasmodic — the primary herb for calming spasmodic cough.',
     v_class, 'personal', 'Antispasmodic / Antitussive', 130, v_src_nervines),

    -- Asthma
    (v_angelica,    'Angelica is added to the antispasmodic formula in asthma, and also serves as a relaxing expectorant and bronchodilator. Multiple respiratory roles.',
     v_class, 'personal', 'Asthma', 140, v_src_asthma),

    -- Hay Fever
    (v_yerba_mansa, 'For hay fever, Yerba Mansa can be used as a decoction — sometimes a small amount added to the neti pot as a local anticatarrhal.',
     v_class, 'personal', 'Hay Fever', 150, v_src_hay_fever),

    (v_licorice,    'Hay fever terrain preparation through winter: licorice tea (with reishi and astragalus) lessens allergic responses in the spring. Licorice helps shift the body from acidic (allergic) toward alkaline. Liver issues correlate with stronger seasonal allergies.',
     v_class, 'personal', 'Hay Fever', 160, v_src_hay_fever),

    (v_reishi,      'Hay fever terrain: prepare through winter with reishi, astragalus, and licorice to lessen spring allergic responses and mineralize the body.',
     v_class, 'personal', 'Hay Fever', 170, v_src_hay_fever),

    -- Bronchitis
    (v_gotu_kola,   'In bronchitis recovery, support deep connective tissue with Gotu Kola — targeting gas exchange and the integrity of alveolar tissues. Airway inflammation can take up to a month to fully recover.',
     v_class, 'personal', 'Bronchitis', 180, v_src_bronchitis),

    -- Bronchodilator / Antiviral
    (v_spikenard,   'Aralia (Spikenard, Aralia racemosa) serves as bronchodilator and antiviral in respiratory formulas — often prepared in syrup form.',
     v_class, 'personal', 'Bronchodilator / Antiviral', 190, v_src_antiviral),

    -- Generated snippets
    (v_wild_cherry, 'Percolation has a more astringent quality than standard maceration. Glycerin holds tannins more strongly. Darker color indicates better extraction. Cherry bark example: harvested and prepped with brandy and honey, then strained.',
     v_class, 'generated', 'Percolation Notes', 10, v_src_percolation_gen),

    (v_astragalus,  'Acute dosing: frequent and at the high therapeutic range. Chronic/tonic dosing: medium-low and consistent — prevention is best medicine.',
     v_class, 'generated', 'Dosing Notes', 20, v_src_dosing_gen)

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 49 snippets: done.';
END $$;


-- ============================================================
-- Block 2: Class 49 herb keywords
-- ============================================================
DO $$
DECLARE
  v_schizandra  INTEGER;
  v_elecampane  INTEGER;
  v_mullein     INTEGER;
  v_prince_seng INTEGER;
  v_reishi      INTEGER;
  v_astragalus  INTEGER;
  v_lomatium    INTEGER;
  v_osha        INTEGER;
  v_goldenrod   INTEGER;
  v_motherwort  INTEGER;
  v_hawthorn    INTEGER;
  v_lobelia     INTEGER;
  v_wild_cherry INTEGER;
  v_angelica    INTEGER;
  v_yerba_mansa INTEGER;
  v_licorice    INTEGER;
  v_gotu_kola   INTEGER;
  v_spikenard   INTEGER;

BEGIN
  SELECT id INTO v_schizandra  FROM herbal.herbs WHERE latin_name = 'Schisandra chinensis';
  SELECT id INTO v_elecampane  FROM herbal.herbs WHERE latin_name = 'Inula helenium';
  SELECT id INTO v_mullein     FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  SELECT id INTO v_prince_seng FROM herbal.herbs WHERE latin_name = 'Pseudostellaria heterophylla';
  SELECT id INTO v_reishi      FROM herbal.herbs WHERE latin_name = 'Ganoderma lucidum';
  SELECT id INTO v_astragalus  FROM herbal.herbs WHERE latin_name = 'Astragalus membranaceus';
  SELECT id INTO v_lomatium    FROM herbal.herbs WHERE latin_name = 'Lomatium dissectum';
  SELECT id INTO v_osha        FROM herbal.herbs WHERE latin_name = 'Ligusticum porteri';
  SELECT id INTO v_goldenrod   FROM herbal.herbs WHERE latin_name = 'Solidago virgaurea';
  SELECT id INTO v_motherwort  FROM herbal.herbs WHERE latin_name = 'Leonurus cardiaca';
  SELECT id INTO v_hawthorn    FROM herbal.herbs WHERE latin_name = 'Crataegus spp.' AND plant_part = 'berry';
  SELECT id INTO v_lobelia     FROM herbal.herbs WHERE latin_name = 'Lobelia inflata';
  SELECT id INTO v_wild_cherry FROM herbal.herbs WHERE latin_name = 'Prunus serotina';
  SELECT id INTO v_angelica    FROM herbal.herbs WHERE latin_name = 'Angelica archangelica';
  SELECT id INTO v_yerba_mansa FROM herbal.herbs WHERE latin_name = 'Anemopsis californica';
  SELECT id INTO v_licorice    FROM herbal.herbs WHERE latin_name = 'Glycyrrhiza glabra';
  SELECT id INTO v_gotu_kola   FROM herbal.herbs WHERE latin_name = 'Centella asiatica';
  SELECT id INTO v_spikenard   FROM herbal.herbs WHERE latin_name = 'Aralia racemosa';

  INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
    -- Action keywords
    (v_schizandra,  'trophorestorative',      'action'),
    (v_elecampane,  'trophorestorative',      'action'),
    (v_elecampane,  'expectorant',            'action'),
    (v_elecampane,  'antiviral',              'action'),
    (v_mullein,     'expectorant',            'action'),
    (v_mullein,     'demulcent',              'action'),
    (v_mullein,     'trophorestorative',      'action'),
    (v_prince_seng, 'trophorestorative',      'action'),
    (v_reishi,      'trophorestorative',      'action'),
    (v_reishi,      'immune tonic',           'action'),
    (v_astragalus,  'trophorestorative',      'action'),
    (v_astragalus,  'immune tonic',           'action'),
    (v_lomatium,    'antiviral',              'action'),
    (v_osha,        'antiviral',              'action'),
    (v_osha,        'bronchodilator',         'action'),
    (v_osha,        'expectorant',            'action'),
    (v_goldenrod,   'anticatarrhal',          'action'),
    (v_motherwort,  'nervine',                'action'),
    (v_motherwort,  'circulatory stimulant',  'action'),
    (v_hawthorn,    'circulatory stimulant',  'action'),
    (v_hawthorn,    'nervine',                'action'),
    (v_lobelia,     'antispasmodic',          'action'),
    (v_lobelia,     'bronchodilator',         'action'),
    (v_lobelia,     'antitussive',            'action'),
    (v_wild_cherry, 'antitussive',            'action'),
    (v_wild_cherry, 'antispasmodic',          'action'),
    (v_angelica,    'antispasmodic',          'action'),
    (v_angelica,    'bronchodilator',         'action'),
    (v_angelica,    'expectorant',            'action'),
    (v_yerba_mansa, 'anticatarrhal',          'action'),
    (v_gotu_kola,   'connective tissue',      'action'),
    (v_spikenard,   'bronchodilator',         'action'),
    (v_spikenard,   'antiviral',              'action'),
    -- Ailment keywords
    (v_lomatium,    'bronchitis',             'ailment'),
    (v_lomatium,    'influenza',              'ailment'),
    (v_lomatium,    'common cold',            'ailment'),
    (v_osha,        'bronchitis',             'ailment'),
    (v_osha,        'influenza',              'ailment'),
    (v_osha,        'common cold',            'ailment'),
    (v_lobelia,     'bronchitis',             'ailment'),
    (v_astragalus,  'hay fever',              'ailment'),
    (v_elecampane,  'bronchitis',             'ailment'),
    (v_elecampane,  'influenza',              'ailment'),
    (v_reishi,      'hay fever',              'ailment'),
    (v_reishi,      'chronic cough',          'ailment'),
    (v_mullein,     'bronchitis',             'ailment'),
    (v_mullein,     'chronic cough',          'ailment'),
    (v_goldenrod,   'hay fever',              'ailment'),
    (v_yerba_mansa, 'hay fever',              'ailment'),
    (v_licorice,    'hay fever',              'ailment'),
    (v_wild_cherry, 'bronchitis',             'ailment'),
    (v_wild_cherry, 'chronic cough',          'ailment'),
    (v_gotu_kola,   'bronchitis',             'ailment'),
    (v_prince_seng, 'chronic lung disease',   'ailment'),
    (v_prince_seng, 'bronchitis',             'ailment'),
    (v_schizandra,  'bronchitis',             'ailment'),
    (v_schizandra,  'chronic lung disease',   'ailment'),
    (v_angelica,    'bronchitis',             'ailment'),
    (v_angelica,    'asthma',                 'ailment')

  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Class 49 herb keywords: done.';
END $$;


-- ============================================================
-- Block 3: Ailment search terms
-- ============================================================
DO $$
BEGIN
  INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
    ('bronchitis',          ARRAY['acute bronchitis', 'bronchial infection', 'chest infection', 'productive cough']),
    ('hay fever',           ARRAY['allergic rhinitis', 'seasonal allergies', 'pollen allergy', 'spring allergies']),
    ('common cold',         ARRAY['cold', 'rhinovirus', 'upper respiratory infection', 'URI']),
    ('influenza',           ARRAY['flu', 'influenza virus', 'viral flu', 'influenza A', 'influenza B']),
    ('chronic cough',       ARRAY['persistent cough', 'chronic bronchitis', 'lingering cough']),
    ('chronic lung disease',ARRAY['fibrocystic lung disease', 'pulmonary disease', 'lung disease', 'chronic respiratory disease'])

  ON CONFLICT (ailment_keyword) DO NOTHING;

  RAISE NOTICE 'Class 49 ailment search terms: done.';
END $$;
