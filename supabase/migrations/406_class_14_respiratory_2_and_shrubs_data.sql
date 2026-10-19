-- Migration 406: Class 14 - Respiratory 2 and Shrubs (Rose and Mer) — snippets, keywords, ailment synonyms
-- Parsed from: BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer.md (personal notes only)
--
-- Normalisations:
--   Aralia → California Spikenard (Aralia californica, id=579) — respiratory context
--   Licorice root / licorice → Licorice (id=78)
--   Goldenseal Root / goldenseal → Goldenseal (id=30)
--   Eleuthero / Siberian Ginseng → Siberian Ginseng (id=9)
--   Schisandra → Schizandra (id=17)
--   White Willow / willow → Willow (id=87)
--   California Poppy → California Poppy (id=128)
--   Elderberry → Elder berry (id=1651); Elderflower → Elder flower (id=57)
--   Pine (inhalation/bronchodilator) → Pine Needles (id=2643, Pinus spp.)
--   Chinese skullcap → Chinese Skullcap (id=2274)
--   Mint (Four Thieves) → Peppermint (id=55)
--   Oat straw → Oat straw (id=2287)
--   Grindelia → Grindelia (id=2231, Grindelia squarrosa)
--   Blackberry root → Blackberry (id=156)
--
-- Skipped:
--   D hist — branded product, not a simple supplement
--   Medicinal mushrooms (generic) — specific ones (Reishi, Maitake) included
--   Seaweed (generic) — not specific enough
--   Horseradish, onion, peppers in Fire Cider — incidental food ingredients
--   Blueberries, eggs, OJ — lifestyle foods
--
-- New ailment keywords: pneumonia, emphysema, ear infection, sore throat, dandruff, acne
-- New action keywords: pulmonary tonic, anodyne
-- Keyword merges:
--   "allergic rhinitis" → existing "hay fever"
--   "stuffy/runny nose" → existing "respiratory congestion"
--   "nasal congestion" → existing "respiratory congestion"

SET search_path TO herbal, public;

DO $$
DECLARE
  v_cls TEXT := 'BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer';

  v_src_daily_tea TEXT := $src$Daily Tea
5p marshmallow leaf
4p mullein
3p linden
2p rose
1p cinnamon$src$;

  v_src_slides TEXT := $src$essence tasting
- Mullein
    - different medicines in 1:
        - root -> prostrate
        - stem -> back pain, disk disorders
        - leaf -> lung
        - flowers -> oil infusion of dried flowers for ear infection (+ garlic)
    - will meet going up to the mountains in June$src$;

  v_src_bronchitis TEXT := $src$## Bronchitis
- not a condition you can catch
- inflammation response in the bronchi and bronchioles
- can come from a bacterial infection, smoking or a virus
    - when the cells of the bronchial lining tissue are irritated, the cilia that trap and eliminate outside invaders stop functioning
- Herbal Actions Indicated
    - Antimicrobial
    - Antispasmodic - cough
    - Expectorant - get rid of mucus
    - Anti-inflammatory
    - Anti-catarrhal - thin and lessen the phlegm
    - Diaphoretic (if accompanied by fever)
- Herbs to Use
    - Usnea
    - Aralia
    - Elecampane
    - Thyme
    - Ginger (thins mucus)
    - Goldenseal
    - Deep Lung Formula (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha)
    - Pine and Eucalyptus inhalations, also Thyme
        - maybe Rosemary, Oregano - use what you have
        - things that have scent, volatile oils
        - EO? don't use a lot$src$;

  v_src_pneumonia TEXT := $src$## Pneumonia
- 6th most common cause of death, fatal infection acquired in hospitals
- can be caused by virus/bacteria
- inflammatory condition of the alveoli
- as a general rule, let Western Medicine treat (can be dangerous)
- if someone does not have access to western medicine then use:
    - garlic 5-7 cloves a day, raw is best
        - with honey, small pill sized pieces, don't chew
        - honey coats and helps with the digestive part of it
    - elecampane
    - mustard poultice on chest
        - mustard powder, flour and water$src$;

  v_src_asthma TEXT := $src$## Asthma
- long term inflammatory disease characterized by difficulty breathing, wheezing, chest tightness, and coughing
- many triggers: allergies, exercise, stress, environmental pollutants, heartburn, colds, respiratory infections
- herbal support
    - anti-inflammatory: licorice, hawthorn, hyssop
    - antitussives: wild cherry bark, thyme
    - demulcent: mullein, marshmallow, irish moss
    - relaxing expectorant: mullein
    - pulmonary tonics: mullein, irish moss, prince seng, schisandra
    - bronchodilators: lobelia, osha, pine, wild cherry bark
    - antispasmodic: licorice, wild cherry bark
    - cardiotonic: hawthorn, motherwort
    - nervine: motherwort, skullcap, california poppy
    - anticatarrhal: yerba mansa, goldenseal$src$;

  v_src_emphysema TEXT := $src$## Emphysema
- enlargements of the air spaces distal to the terminal non-respiratory bronchioles, accompanied by destructive changes of the alveolar walls
- longterm complication of chronic bronchitis
- type of COPD - umbrella term for making breathing difficult
- herbal support:
    - pulmonary tonics: mullein, prince seng, lobelia
    - expectorants: grindelia, elecampane
    - demulcents: mullein, marshmallow, irish moss, licorice
    - anti-spasmodics: licorice, ephedra
    - cardiotonics: hawthorn and motherwort
    - nervines: motherwort, skullcap, california poppy
    - * no miracle cure, but with consistent use there will be some improvement$src$;

  v_src_hay_fever TEXT := $src$## Hay Fever
- also called allergic rhinitis
- caused by allergies to pollen and dander
- symptoms: itching eyes and throat, sneezing, post nasal drip, headaches, wheezing
- herbs to use:
    - anticatarrhals: goldenrod, eyebright, goldenseal
    - antiallergenic herbs: nettle (fresh), D hist, Vit C (high doses)
    - immunostimulant: echinacea
    - chrysanthemum: itchy eyes (comes from TCM, tea -> eye wash)$src$;

  v_src_common_cold TEXT := $src$### Common Cold
- cause by rhinovirus, often don't have a fever, symptoms don't last as long
- Sore Throat
    - Herbal actions:
        - demulcent: marshmallow, linden, slippery elm
        - antimicrobials: garlic, thyme, sage, lavender
            - lavender salt water gargle
- runny stuffy nose:
    - Herbal actions: anticatarrhal
        - yerba mansa, boneset, herbal nasal spray
- cough:
    - when a cough is productive, don't suppress it
    - is the cough wet, dry, hot, cold?
- antivirals:
    - echinacea (interferes with virus ability to bind to cells)
    - ginger (fresh)
    - elderberry
    - lemon balm
- lymphatics
    - red root
    - cleavers
    - poke root (small doses)
- immune tonics
    - eleuthero, astragalus, rhodiola, medicinal mushrooms$src$;

  v_src_influenza TEXT := $src$### Influenza Virus
- not living, need a host cell to invade
- influenza virus has an affinity to the epithelia cilia cells of the upper resp system
- day 0 asymptomatic, day 1 symptomatic, day 2-3 fever, day 4 feel better, day 5-8 Cytokine response

- Fever
    - herbal action: Diaphoretics
        - yarrow, elderflower, catnip, ginger
- Nausea
    - antiemetics
        - ginger and peppermint
- Aches and pains
    - sedatives and anodynes
        - passionflower, valerian, hops, kava, wild lettuce
        - all pretty sedative and antispasmodic - body aches edge off from the flu
- diarrhea
    - astringents
        - blackberry root, yarrow, willow
- overall immune support
    - antivirals
        - ginger, licorice, osha, chinese skullcap, boneset, andrographis
    - immunostimulants
        - echinacea, elder, andrographis
    - adaptogen/immune tonics
        - wait until after the acute part of the flu
        - reishi, astragalus, maitake, eleuthero
    - lymphatics
        - cleavers, red root
    - try and hit all these actions in one formula$src$;

  v_src_infused_vinegars TEXT := $src$## Infused Vinegars
- vinegars have been herbally infused and flavored for centuries
- Fire Cider - famous cold and flu remedy
    - contains horseradish, garlic, ginger, onion, cayenne, vinegar, honey, peppers
- Four Thieves Vinegar
    - varying recipes contains: Rosemary, Sage, Wormwood, Mint, Lavender, Garlic, Thyme and Cloves - all antimicrobial
    - Folklore: during one of the plagues, robbers were able to steal from the dead and dying without themselves contracting it by using this vinegar
    - tomb raiders and archaeologists use it to protect themselves from deathly mold in burial sites
    - ancient sources say you can use to protect against the spell of a sorceress$src$;

  v_src_cosmetic TEXT := $src$## Cosmetic Use of Infused Vinegars
- hair rinses can be used to leave the hair clean and shining
    - rosemary - dark hair and hair growth
    - sage - darkening grey hair
    - calendula - conditioning
    - nettles - condition hair
- dandruff - massage full-strength vinegar to the scalp
- acne: apple directly, can infuse with onion
- herbal vinegar baths for itchy flakey skin
- face tonic and toners$src$;

  v_src_oxymels TEXT := $src$## Oxymels
- combo of vinegar and honey used to infuse herbs and deliver medicine
- great for masking the flavor of intense or bitter herbs
- common kitchen allies - accessible medicine

## Example of Types of Oxymel
- nutritive
    - nettles, dandelion, seaweed, oat straw, alfalfa
- antimicrobial
    - sage, rosemary, thyme
- digestive
    - bitter herbs: mugwort, angelica$src$;

BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets WHERE class_name = v_cls) THEN
    RAISE NOTICE 'Class 14 snippets already loaded, skipping';
    RETURN;
  END IF;

  -- ===== DAILY TEA =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (45,  'Daily Tea blend: 5p marshmallow leaf, 4p mullein, 3p linden, 2p rose, 1p cinnamon.', v_cls, 'personal', 'Daily Tea', 10,  v_src_daily_tea),
    (61,  'Daily Tea blend: 5p marshmallow leaf, 4p mullein, 3p linden, 2p rose, 1p cinnamon.', v_cls, 'personal', 'Daily Tea', 20,  v_src_daily_tea),
    (90,  'Daily Tea blend: 5p marshmallow leaf, 4p mullein, 3p linden, 2p rose, 1p cinnamon.', v_cls, 'personal', 'Daily Tea', 30,  v_src_daily_tea),
    (850, 'Daily Tea blend: 5p marshmallow leaf, 4p mullein, 3p linden, 2p rose, 1p cinnamon.', v_cls, 'personal', 'Daily Tea', 40,  v_src_daily_tea),
    (167, 'Daily Tea blend: 5p marshmallow leaf, 4p mullein, 3p linden, 2p rose, 1p cinnamon.', v_cls, 'personal', 'Daily Tea', 50,  v_src_daily_tea);

  -- ===== SLIDES (Mullein parts) =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (61, 'Mullein offers different medicines from each part: root → prostate; stem → back pain, disk disorders; leaf → lung; flowers → oil infusion for ear infection (+ garlic).', v_cls, 'personal', 'Slides', 60, v_src_slides),
    (21, 'Garlic combined with mullein flower oil infusion for ear infections.', v_cls, 'personal', 'Slides', 70, v_src_slides);

  -- ===== BRONCHITIS =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (112,  'Usnea: herb for bronchitis. Actions indicated: antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, diaphoretic (if fever).', v_cls, 'personal', 'Bronchitis', 80,  v_src_bronchitis),
    (579,  'Aralia (California Spikenard): herb for bronchitis. Actions indicated: antimicrobial, antispasmodic, expectorant, anti-inflammatory, anti-catarrhal, diaphoretic.', v_cls, 'personal', 'Bronchitis', 90,  v_src_bronchitis),
    (54,   'Elecampane: herb for bronchitis. In the Deep Lung Formula (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 100, v_src_bronchitis),
    (59,   'Thyme: herb for bronchitis; also used in inhalations (Pine and Eucalyptus inhalations, also Thyme).', v_cls, 'personal', 'Bronchitis', 110, v_src_bronchitis),
    (124,  'Ginger: herb for bronchitis (thins mucus).', v_cls, 'personal', 'Bronchitis', 120, v_src_bronchitis),
    (30,   'Goldenseal: herb for bronchitis. Actions indicated include antimicrobial, anti-catarrhal.', v_cls, 'personal', 'Bronchitis', 130, v_src_bronchitis),
    (65,   'Angelica: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 140, v_src_bronchitis),
    (590,  'Yerba Santa: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 150, v_src_bronchitis),
    (44,   'Yarrow: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 160, v_src_bronchitis),
    (73,   'Hawthorn: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 170, v_src_bronchitis),
    (61,   'Mullein: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 180, v_src_bronchitis),
    (309,  'Yerba Mansa: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 190, v_src_bronchitis),
    (21,   'Garlic: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 200, v_src_bronchitis),
    (104,  'Osha: in the Deep Lung Formula for bronchitis (elecampane, angelica, yerba santa, yarrow, hawthorn, mullein, yerba mansa, garlic, osha).', v_cls, 'personal', 'Bronchitis', 210, v_src_bronchitis),
    (2643, 'Pine (inhalation): used as steam inhalation for bronchitis along with Eucalyptus and Thyme — volatile oil plants that break up congestion.', v_cls, 'personal', 'Bronchitis', 220, v_src_bronchitis),
    (101,  'Eucalyptus (inhalation): used as steam inhalation for bronchitis along with Pine and Thyme.', v_cls, 'personal', 'Bronchitis', 230, v_src_bronchitis),
    (109,  'Rosemary: potential inhalation herb for bronchitis ("use what you have" — volatile oil plants with scent).', v_cls, 'personal', 'Bronchitis', 240, v_src_bronchitis),
    (406,  'Oregano: potential inhalation herb for bronchitis ("use what you have" — volatile oil plants with scent).', v_cls, 'personal', 'Bronchitis', 250, v_src_bronchitis);

  -- ===== PNEUMONIA =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (21,  'Garlic for pneumonia when Western Medicine unavailable: 5–7 cloves a day raw, swallowed in honey as small pill-sized pieces without chewing.', v_cls, 'personal', 'Pneumonia', 260, v_src_pneumonia),
    (54,  'Elecampane: herb for pneumonia.', v_cls, 'personal', 'Pneumonia', 270, v_src_pneumonia),
    (116, 'Mustard poultice on chest for pneumonia: mustard powder, flour and water.', v_cls, 'personal', 'Pneumonia', 280, v_src_pneumonia);

  -- ===== ASTHMA =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (78,   'Licorice for asthma: anti-inflammatory and antispasmodic.', v_cls, 'personal', 'Asthma', 290, v_src_asthma),
    (73,   'Hawthorn for asthma: anti-inflammatory and cardiotonic.', v_cls, 'personal', 'Asthma', 300, v_src_asthma),
    (53,   'Hyssop for asthma: anti-inflammatory.', v_cls, 'personal', 'Asthma', 310, v_src_asthma),
    (140,  'Wild Cherry Bark for asthma: antitussive, bronchodilator, and antispasmodic.', v_cls, 'personal', 'Asthma', 320, v_src_asthma),
    (59,   'Thyme for asthma: antitussive.', v_cls, 'personal', 'Asthma', 330, v_src_asthma),
    (61,   'Mullein for asthma: demulcent, relaxing expectorant, and pulmonary tonic.', v_cls, 'personal', 'Asthma', 340, v_src_asthma),
    (45,   'Marshmallow for asthma: demulcent.', v_cls, 'personal', 'Asthma', 350, v_src_asthma),
    (49,   'Irish Moss for asthma: demulcent and pulmonary tonic.', v_cls, 'personal', 'Asthma', 360, v_src_asthma),
    (982,  'Prince Seng for asthma: pulmonary tonic.', v_cls, 'personal', 'Asthma', 370, v_src_asthma),
    (17,   'Schizandra for asthma: pulmonary tonic.', v_cls, 'personal', 'Asthma', 380, v_src_asthma),
    (132,  'Lobelia for asthma: bronchodilator.', v_cls, 'personal', 'Asthma', 390, v_src_asthma),
    (104,  'Osha for asthma: bronchodilator.', v_cls, 'personal', 'Asthma', 400, v_src_asthma),
    (2643, 'Pine for asthma: bronchodilator.', v_cls, 'personal', 'Asthma', 410, v_src_asthma),
    (131,  'Motherwort for asthma: cardiotonic and nervine.', v_cls, 'personal', 'Asthma', 420, v_src_asthma),
    (142,  'Skullcap for asthma: nervine.', v_cls, 'personal', 'Asthma', 430, v_src_asthma),
    (128,  'California Poppy for asthma: nervine.', v_cls, 'personal', 'Asthma', 440, v_src_asthma),
    (309,  'Yerba Mansa for asthma: anticatarrhal.', v_cls, 'personal', 'Asthma', 450, v_src_asthma),
    (30,   'Goldenseal for asthma: anticatarrhal.', v_cls, 'personal', 'Asthma', 460, v_src_asthma);

  -- ===== EMPHYSEMA =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (61,   'Mullein for emphysema (COPD): pulmonary tonic and demulcent. "No miracle cure, but with consistent use there will be some improvement."', v_cls, 'personal', 'Emphysema', 470, v_src_emphysema),
    (982,  'Prince Seng for emphysema: pulmonary tonic.', v_cls, 'personal', 'Emphysema', 480, v_src_emphysema),
    (132,  'Lobelia for emphysema: pulmonary tonic.', v_cls, 'personal', 'Emphysema', 490, v_src_emphysema),
    (2231, 'Grindelia for emphysema: expectorant.', v_cls, 'personal', 'Emphysema', 500, v_src_emphysema),
    (54,   'Elecampane for emphysema: expectorant.', v_cls, 'personal', 'Emphysema', 510, v_src_emphysema),
    (45,   'Marshmallow for emphysema: demulcent.', v_cls, 'personal', 'Emphysema', 520, v_src_emphysema),
    (49,   'Irish Moss for emphysema: demulcent.', v_cls, 'personal', 'Emphysema', 530, v_src_emphysema),
    (78,   'Licorice for emphysema: demulcent and antispasmodic.', v_cls, 'personal', 'Emphysema', 540, v_src_emphysema),
    (448,  'Ephedra (Ma Huang) for emphysema: antispasmodic/bronchodilator.', v_cls, 'personal', 'Emphysema', 550, v_src_emphysema),
    (73,   'Hawthorn for emphysema: cardiotonic (with motherwort).', v_cls, 'personal', 'Emphysema', 560, v_src_emphysema),
    (131,  'Motherwort for emphysema: cardiotonic (with hawthorn) and nervine.', v_cls, 'personal', 'Emphysema', 570, v_src_emphysema),
    (142,  'Skullcap for emphysema: nervine.', v_cls, 'personal', 'Emphysema', 580, v_src_emphysema),
    (128,  'California Poppy for emphysema: nervine.', v_cls, 'personal', 'Emphysema', 590, v_src_emphysema);

  -- ===== HAY FEVER =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (58,   'Goldenrod for hay fever (allergic rhinitis): anticatarrhal.', v_cls, 'personal', 'Hay Fever', 600, v_src_hay_fever),
    (51,   'Eyebright for hay fever: anticatarrhal.', v_cls, 'personal', 'Hay Fever', 610, v_src_hay_fever),
    (30,   'Goldenseal for hay fever: anticatarrhal.', v_cls, 'personal', 'Hay Fever', 620, v_src_hay_fever),
    (43,   'Nettle (fresh) for hay fever: antiallergenic.', v_cls, 'personal', 'Hay Fever', 630, v_src_hay_fever),
    (26,   'Echinacea for hay fever: immunostimulant.', v_cls, 'personal', 'Hay Fever', 640, v_src_hay_fever),
    (1572, 'Chrysanthemum Flower (TCM) for hay fever: itchy eyes; prepared as tea used as an eye wash.', v_cls, 'personal', 'Hay Fever', 650, v_src_hay_fever);

  -- ===== COMMON COLD =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (45,  'Marshmallow for common cold sore throat: demulcent.', v_cls, 'personal', 'Common Cold', 660, v_src_common_cold),
    (90,  'Linden for common cold sore throat: demulcent.', v_cls, 'personal', 'Common Cold', 670, v_src_common_cold),
    (92,  'Slippery Elm for common cold sore throat: demulcent.', v_cls, 'personal', 'Common Cold', 680, v_src_common_cold),
    (21,  'Garlic for common cold sore throat: antimicrobial.', v_cls, 'personal', 'Common Cold', 690, v_src_common_cold),
    (59,  'Thyme for common cold sore throat: antimicrobial.', v_cls, 'personal', 'Common Cold', 700, v_src_common_cold),
    (56,  'Sage for common cold sore throat: antimicrobial.', v_cls, 'personal', 'Common Cold', 710, v_src_common_cold),
    (82,  'Lavender for common cold sore throat: antimicrobial; lavender salt water gargle.', v_cls, 'personal', 'Common Cold', 720, v_src_common_cold),
    (309, 'Yerba Mansa for common cold runny/stuffy nose: anticatarrhal.', v_cls, 'personal', 'Common Cold', 730, v_src_common_cold),
    (50,  'Boneset for common cold runny/stuffy nose: anticatarrhal.', v_cls, 'personal', 'Common Cold', 740, v_src_common_cold),
    (26,  'Echinacea for common cold: antiviral — interferes with virus ability to bind to cells.', v_cls, 'personal', 'Common Cold', 750, v_src_common_cold),
    (124, 'Ginger (fresh) for common cold: antiviral.', v_cls, 'personal', 'Common Cold', 760, v_src_common_cold),
    (1651,'Elder berry for common cold: antiviral.', v_cls, 'personal', 'Common Cold', 770, v_src_common_cold),
    (134, 'Lemon Balm for common cold: antiviral.', v_cls, 'personal', 'Common Cold', 780, v_src_common_cold),
    (981, 'Red Root for common cold: lymphatic support.', v_cls, 'personal', 'Common Cold', 790, v_src_common_cold),
    (28,  'Cleavers for common cold: lymphatic support.', v_cls, 'personal', 'Common Cold', 800, v_src_common_cold),
    (35,  'Poke Root for common cold: lymphatic support — use in small doses only.', v_cls, 'personal', 'Common Cold', 810, v_src_common_cold),
    (9,   'Siberian Ginseng (Eleuthero) for common cold: immune tonic. Note: use tonics after the acute phase resolves.', v_cls, 'personal', 'Common Cold', 820, v_src_common_cold),
    (225, 'Astragalus for common cold: immune tonic.', v_cls, 'personal', 'Common Cold', 830, v_src_common_cold),
    (16,  'Rhodiola for common cold: immune tonic.', v_cls, 'personal', 'Common Cold', 840, v_src_common_cold);

  -- ===== INFLUENZA VIRUS =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (44,   'Yarrow for influenza: diaphoretic for fever; also astringent for flu-related diarrhea.', v_cls, 'personal', 'Influenza Virus', 850, v_src_influenza),
    (57,   'Elder flower for influenza: diaphoretic for fever; also immunostimulant.', v_cls, 'personal', 'Influenza Virus', 860, v_src_influenza),
    (136,  'Catnip for influenza: diaphoretic for fever.', v_cls, 'personal', 'Influenza Virus', 870, v_src_influenza),
    (124,  'Ginger for influenza: diaphoretic for fever and antiemetic for nausea; also antiviral in overall immune support.', v_cls, 'personal', 'Influenza Virus', 880, v_src_influenza),
    (55,   'Peppermint for influenza nausea: antiemetic (with ginger).', v_cls, 'personal', 'Influenza Virus', 890, v_src_influenza),
    (137,  'Passionflower for influenza aches and pains: sedative/anodyne — body aches edge off from the flu.', v_cls, 'personal', 'Influenza Virus', 900, v_src_influenza),
    (145,  'Valerian for influenza aches and pains: sedative/anodyne.', v_cls, 'personal', 'Influenza Virus', 910, v_src_influenza),
    (129,  'Hops for influenza aches and pains: sedative/anodyne.', v_cls, 'personal', 'Influenza Virus', 920, v_src_influenza),
    (138,  'Kava for influenza aches and pains: sedative/anodyne.', v_cls, 'personal', 'Influenza Virus', 930, v_src_influenza),
    (130,  'Wild Lettuce for influenza aches and pains: sedative/anodyne.', v_cls, 'personal', 'Influenza Virus', 940, v_src_influenza),
    (156,  'Blackberry root for influenza diarrhea: astringent.', v_cls, 'personal', 'Influenza Virus', 950, v_src_influenza),
    (87,   'Willow for influenza diarrhea: astringent.', v_cls, 'personal', 'Influenza Virus', 960, v_src_influenza),
    (78,   'Licorice for influenza: antiviral in overall immune support.', v_cls, 'personal', 'Influenza Virus', 970, v_src_influenza),
    (104,  'Osha for influenza: antiviral in overall immune support.', v_cls, 'personal', 'Influenza Virus', 980, v_src_influenza),
    (2274, 'Chinese Skullcap for influenza: antiviral in overall immune support.', v_cls, 'personal', 'Influenza Virus', 990, v_src_influenza),
    (50,   'Boneset for influenza: antiviral in overall immune support.', v_cls, 'personal', 'Influenza Virus', 1000, v_src_influenza),
    (2629, 'Andrographis for influenza: antiviral and immunostimulant.', v_cls, 'personal', 'Influenza Virus', 1010, v_src_influenza),
    (26,   'Echinacea for influenza: immunostimulant.', v_cls, 'personal', 'Influenza Virus', 1020, v_src_influenza),
    (11,   'Reishi Mushroom for influenza immune support: adaptogen/immune tonic — use after the acute phase of the flu resolves.', v_cls, 'personal', 'Influenza Virus', 1030, v_src_influenza),
    (225,  'Astragalus for influenza immune support: immune tonic — use after the acute phase resolves.', v_cls, 'personal', 'Influenza Virus', 1040, v_src_influenza),
    (2633, 'Maitake for influenza immune support: immune tonic — use after the acute phase resolves.', v_cls, 'personal', 'Influenza Virus', 1050, v_src_influenza),
    (9,    'Siberian Ginseng (Eleuthero) for influenza immune support: immune tonic — use after the acute phase resolves.', v_cls, 'personal', 'Influenza Virus', 1060, v_src_influenza),
    (28,   'Cleavers for influenza: lymphatic support.', v_cls, 'personal', 'Influenza Virus', 1070, v_src_influenza),
    (981,  'Red Root for influenza: lymphatic support.', v_cls, 'personal', 'Influenza Virus', 1080, v_src_influenza);

  -- ===== INFUSED VINEGARS (Four Thieves) =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (109, 'Rosemary in Four Thieves Vinegar: antimicrobial — used historically for plague protection.', v_cls, 'personal', 'Infused Vinegars', 1090, v_src_infused_vinegars),
    (56,  'Sage in Four Thieves Vinegar: antimicrobial.', v_cls, 'personal', 'Infused Vinegars', 1100, v_src_infused_vinegars),
    (97,  'Wormwood in Four Thieves Vinegar: antimicrobial.', v_cls, 'personal', 'Infused Vinegars', 1110, v_src_infused_vinegars),
    (55,  'Mint (Peppermint) in Four Thieves Vinegar: antimicrobial.', v_cls, 'personal', 'Infused Vinegars', 1120, v_src_infused_vinegars),
    (82,  'Lavender in Four Thieves Vinegar: antimicrobial.', v_cls, 'personal', 'Infused Vinegars', 1130, v_src_infused_vinegars),
    (21,  'Garlic in Four Thieves Vinegar and Fire Cider: antimicrobial; Fire Cider is a famous cold and flu remedy.', v_cls, 'personal', 'Infused Vinegars', 1140, v_src_infused_vinegars),
    (59,  'Thyme in Four Thieves Vinegar: antimicrobial.', v_cls, 'personal', 'Infused Vinegars', 1150, v_src_infused_vinegars),
    (111, 'Clove in Four Thieves Vinegar: antimicrobial.', v_cls, 'personal', 'Infused Vinegars', 1160, v_src_infused_vinegars);

  -- ===== COSMETIC USE =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (109, 'Rosemary vinegar hair rinse: for dark hair and hair growth.', v_cls, 'personal', 'Cosmetic Use of Infused Vinegars', 1170, v_src_cosmetic),
    (56,  'Sage vinegar hair rinse: for darkening grey hair.', v_cls, 'personal', 'Cosmetic Use of Infused Vinegars', 1180, v_src_cosmetic),
    (70,  'Calendula vinegar hair rinse: conditioning.', v_cls, 'personal', 'Cosmetic Use of Infused Vinegars', 1190, v_src_cosmetic),
    (43,  'Nettle vinegar hair rinse: conditioning.', v_cls, 'personal', 'Cosmetic Use of Infused Vinegars', 1200, v_src_cosmetic);

  -- ===== OXYMELS =====
  INSERT INTO herbal.class_note_snippets
    (herb_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (43,   'Nettle in nutritive oxymel (vinegar + honey infusion): nettles, dandelion, seaweed, oat straw, alfalfa.', v_cls, 'personal', 'Oxymels', 1210, v_src_oxymels),
    (1648, 'Dandelion in nutritive oxymel: nettles, dandelion, seaweed, oat straw, alfalfa.', v_cls, 'personal', 'Oxymels', 1220, v_src_oxymels),
    (2287, 'Oat straw in nutritive oxymel: nettles, dandelion, seaweed, oat straw, alfalfa.', v_cls, 'personal', 'Oxymels', 1230, v_src_oxymels),
    (885,  'Alfalfa in nutritive oxymel: nettles, dandelion, seaweed, oat straw, alfalfa.', v_cls, 'personal', 'Oxymels', 1240, v_src_oxymels),
    (56,   'Sage in antimicrobial oxymel.', v_cls, 'personal', 'Oxymels', 1250, v_src_oxymels),
    (109,  'Rosemary in antimicrobial oxymel.', v_cls, 'personal', 'Oxymels', 1260, v_src_oxymels),
    (59,   'Thyme in antimicrobial oxymel.', v_cls, 'personal', 'Oxymels', 1270, v_src_oxymels),
    (115,  'Mugwort in digestive oxymel: bitter herb.', v_cls, 'personal', 'Oxymels', 1280, v_src_oxymels),
    (65,   'Angelica in digestive oxymel: bitter herb.', v_cls, 'personal', 'Oxymels', 1290, v_src_oxymels);

END $$;

-- ===== SUPPLEMENT SNIPPETS (Vitamin C) =====
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM herbal.class_note_snippets
             WHERE supplement_id = 10
               AND class_name = 'BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer') THEN
    RAISE NOTICE 'Class 14 supplement snippets already loaded, skipping';
    RETURN;
  END IF;

  INSERT INTO herbal.class_note_snippets
    (supplement_id, snippet_text, class_name, note_type, section_header, sort_order, source_block)
  VALUES
    (10, 'Vitamin C (high doses) for hay fever: antiallergenic herb.',
     'BHC - Class 14 - Respiratory 2 and Shrubs - Rose and Mer', 'personal', 'Hay Fever', 1300,
     $src$## Hay Fever
- also called allergic rhinitis
- caused by allergies to pollen and dander
- herbs to use:
    - anticatarrhals: goldenrod, eyebright, goldenseal
    - antiallergenic herbs: nettle (fresh), D hist, Vit C (high doses)
    - immunostimulant: echinacea
    - chrysanthemum: itchy eyes (comes from TCM, tea -> eye wash)$src$);

END $$;

-- ===== HERB KEYWORDS =====

-- Bronchitis herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (112,  'bronchitis',          'ailment'),
  (112,  'antimicrobial',       'action'),
  (112,  'anti-inflammatory',   'action'),
  (579,  'bronchitis',          'ailment'),
  (579,  'respiratory infection','ailment'),
  (54,   'bronchitis',          'ailment'),
  (54,   'expectorant',         'action'),
  (59,   'bronchitis',          'ailment'),
  (59,   'antimicrobial',       'action'),
  (124,  'bronchitis',          'ailment'),
  (30,   'bronchitis',          'ailment'),
  (30,   'anticatarrhal',       'action'),
  (65,   'bronchitis',          'ailment'),
  (590,  'bronchitis',          'ailment'),
  (44,   'bronchitis',          'ailment'),
  (73,   'bronchitis',          'ailment'),
  (61,   'bronchitis',          'ailment'),
  (61,   'pulmonary tonic',     'action'),
  (309,  'bronchitis',          'ailment'),
  (309,  'anticatarrhal',       'action'),
  (21,   'bronchitis',          'ailment'),
  (104,  'bronchitis',          'ailment'),
  (2643, 'bronchitis',          'ailment'),
  (101,  'bronchitis',          'ailment'),
  (109,  'bronchitis',          'ailment'),
  (406,  'bronchitis',          'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Pneumonia herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (21,  'pneumonia',   'ailment'),
  (54,  'pneumonia',   'ailment'),
  (116, 'pneumonia',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Ear infection (Mullein + Garlic)
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (61, 'ear infection', 'ailment'),
  (61, 'earache',       'ailment'),
  (21, 'ear infection', 'ailment'),
  (21, 'earache',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Asthma herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (78,   'asthma',           'ailment'),
  (78,   'anti-inflammatory','action'),
  (78,   'antispasmodic',    'action'),
  (73,   'asthma',           'ailment'),
  (73,   'anti-inflammatory','action'),
  (73,   'cardiotonic',      'action'),
  (53,   'asthma',           'ailment'),
  (53,   'anti-inflammatory','action'),
  (140,  'asthma',           'ailment'),
  (140,  'antitussive',      'action'),
  (140,  'bronchodilator',   'action'),
  (140,  'antispasmodic',    'action'),
  (59,   'asthma',           'ailment'),
  (59,   'antitussive',      'action'),
  (61,   'asthma',           'ailment'),
  (61,   'demulcent',        'action'),
  (61,   'expectorant',      'action'),
  (45,   'asthma',           'ailment'),
  (45,   'demulcent',        'action'),
  (49,   'asthma',           'ailment'),
  (49,   'demulcent',        'action'),
  (49,   'pulmonary tonic',  'action'),
  (982,  'asthma',           'ailment'),
  (982,  'pulmonary tonic',  'action'),
  (17,   'asthma',           'ailment'),
  (17,   'pulmonary tonic',  'action'),
  (132,  'asthma',           'ailment'),
  (132,  'bronchodilator',   'action'),
  (104,  'asthma',           'ailment'),
  (104,  'bronchodilator',   'action'),
  (2643, 'asthma',           'ailment'),
  (2643, 'bronchodilator',   'action'),
  (131,  'asthma',           'ailment'),
  (131,  'cardiotonic',      'action'),
  (131,  'nervine',          'action'),
  (142,  'asthma',           'ailment'),
  (142,  'nervine',          'action'),
  (128,  'asthma',           'ailment'),
  (128,  'nervine',          'action'),
  (309,  'asthma',           'ailment'),
  (30,   'asthma',           'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Emphysema herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (61,   'emphysema',       'ailment'),
  (61,   'COPD',            'ailment'),
  (982,  'emphysema',       'ailment'),
  (982,  'COPD',            'ailment'),
  (132,  'emphysema',       'ailment'),
  (132,  'COPD',            'ailment'),
  (132,  'pulmonary tonic', 'action'),
  (2231, 'emphysema',       'ailment'),
  (2231, 'COPD',            'ailment'),
  (2231, 'expectorant',     'action'),
  (54,   'emphysema',       'ailment'),
  (54,   'COPD',            'ailment'),
  (45,   'emphysema',       'ailment'),
  (49,   'emphysema',       'ailment'),
  (78,   'emphysema',       'ailment'),
  (78,   'COPD',            'ailment'),
  (448,  'emphysema',       'ailment'),
  (448,  'COPD',            'ailment'),
  (448,  'antispasmodic',   'action'),
  (73,   'emphysema',       'ailment'),
  (73,   'COPD',            'ailment'),
  (131,  'emphysema',       'ailment'),
  (131,  'COPD',            'ailment'),
  (142,  'emphysema',       'ailment'),
  (128,  'emphysema',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Hay fever herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (58,   'hay fever',       'ailment'),
  (58,   'allergies',       'ailment'),
  (58,   'anticatarrhal',   'action'),
  (51,   'hay fever',       'ailment'),
  (51,   'allergies',       'ailment'),
  (51,   'anticatarrhal',   'action'),
  (30,   'hay fever',       'ailment'),
  (43,   'hay fever',       'ailment'),
  (43,   'allergies',       'ailment'),
  (26,   'hay fever',       'ailment'),
  (26,   'immunostimulant', 'action'),
  (1572, 'hay fever',       'ailment'),
  (1572, 'allergies',       'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

INSERT INTO herbal.herb_keywords (supplement_id, keyword, category) VALUES
  (10, 'hay fever',   'ailment'),
  (10, 'allergies',   'ailment')
ON CONFLICT (supplement_id, keyword) WHERE supplement_id IS NOT NULL DO NOTHING;

-- Common cold / sore throat herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (45,  'common cold',       'ailment'),
  (45,  'sore throat',       'ailment'),
  (90,  'common cold',       'ailment'),
  (90,  'sore throat',       'ailment'),
  (92,  'common cold',       'ailment'),
  (92,  'sore throat',       'ailment'),
  (21,  'common cold',       'ailment'),
  (21,  'sore throat',       'ailment'),
  (21,  'antimicrobial',     'action'),
  (21,  'antiviral',         'action'),
  (59,  'common cold',       'ailment'),
  (59,  'sore throat',       'ailment'),
  (56,  'common cold',       'ailment'),
  (56,  'sore throat',       'ailment'),
  (56,  'antimicrobial',     'action'),
  (82,  'common cold',       'ailment'),
  (82,  'sore throat',       'ailment'),
  (82,  'antimicrobial',     'action'),
  (309, 'common cold',       'ailment'),
  (309, 'respiratory congestion','ailment'),
  (50,  'common cold',       'ailment'),
  (50,  'respiratory congestion','ailment'),
  (50,  'anticatarrhal',     'action'),
  (26,  'common cold',       'ailment'),
  (26,  'antiviral',         'action'),
  (124, 'common cold',       'ailment'),
  (124, 'antiviral',         'action'),
  (1651,'common cold',       'ailment'),
  (1651,'antiviral',         'action'),
  (134, 'common cold',       'ailment'),
  (134, 'antiviral',         'action'),
  (981, 'common cold',       'ailment'),
  (981, 'lymphatic support', 'action'),
  (28,  'common cold',       'ailment'),
  (28,  'lymphatic support', 'action'),
  (35,  'common cold',       'ailment'),
  (35,  'lymphatic',         'action'),
  (9,   'common cold',       'ailment'),
  (9,   'immune support',    'ailment'),
  (225, 'common cold',       'ailment'),
  (225, 'immune support',    'ailment'),
  (16,  'common cold',       'ailment'),
  (16,  'immune support',    'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Influenza herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (44,   'influenza',         'ailment'),
  (44,   'fever',             'ailment'),
  (44,   'diaphoretic',       'action'),
  (44,   'diarrhea',          'ailment'),
  (44,   'astringent',        'action'),
  (57,   'influenza',         'ailment'),
  (57,   'fever',             'ailment'),
  (57,   'diaphoretic',       'action'),
  (136,  'influenza',         'ailment'),
  (136,  'fever',             'ailment'),
  (136,  'diaphoretic',       'action'),
  (124,  'influenza',         'ailment'),
  (124,  'fever',             'ailment'),
  (124,  'diaphoretic',       'action'),
  (124,  'nausea',            'ailment'),
  (55,   'influenza',         'ailment'),
  (55,   'nausea',            'ailment'),
  (137,  'influenza',         'ailment'),
  (137,  'anodyne',           'action'),
  (137,  'sedative',          'action'),
  (145,  'influenza',         'ailment'),
  (145,  'anodyne',           'action'),
  (129,  'influenza',         'ailment'),
  (129,  'anodyne',           'action'),
  (138,  'influenza',         'ailment'),
  (138,  'anodyne',           'action'),
  (130,  'influenza',         'ailment'),
  (130,  'anodyne',           'action'),
  (156,  'influenza',         'ailment'),
  (156,  'diarrhea',          'ailment'),
  (156,  'astringent',        'action'),
  (87,   'influenza',         'ailment'),
  (87,   'diarrhea',          'ailment'),
  (87,   'astringent',        'action'),
  (78,   'influenza',         'ailment'),
  (78,   'antiviral',         'action'),
  (104,  'influenza',         'ailment'),
  (104,  'antiviral',         'action'),
  (2274, 'influenza',         'ailment'),
  (2274, 'antiviral',         'action'),
  (50,   'influenza',         'ailment'),
  (50,   'antiviral',         'action'),
  (2629, 'influenza',         'ailment'),
  (2629, 'antiviral',         'action'),
  (2629, 'immunostimulant',   'action'),
  (26,   'influenza',         'ailment'),
  (11,   'influenza',         'ailment'),
  (11,   'immune tonic',      'action'),
  (225,  'influenza',         'ailment'),
  (2633, 'influenza',         'ailment'),
  (2633, 'immune tonic',      'action'),
  (9,    'influenza',         'ailment'),
  (28,   'influenza',         'ailment'),
  (981,  'influenza',         'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Four Thieves / antimicrobial vinegar herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'antimicrobial', 'action'),
  (97,  'antimicrobial', 'action'),
  (55,  'antimicrobial', 'action'),
  (111, 'antimicrobial', 'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Cosmetic / hair care
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (109, 'hair loss',  'ailment'),
  (56,  'hair loss',  'ailment'),
  (70,  'hair loss',  'ailment'),
  (43,  'hair loss',  'ailment'),
  (109, 'dandruff',   'ailment'),
  (56,  'dandruff',   'ailment'),
  (43,  'dandruff',   'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Acne
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (56,  'acne', 'ailment'),
  (109, 'acne', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Oxymel herbs
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (115, 'digestive tonic', 'ailment'),
  (115, 'bitter',          'action'),
  (65,  'digestive tonic', 'ailment'),
  (65,  'bitter',          'action')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- Mullein additional parts keywords
INSERT INTO herbal.herb_keywords (herb_id, keyword, category) VALUES
  (61, 'prostate health',  'ailment'),
  (61, 'chronic lung disease', 'ailment')
ON CONFLICT (herb_id, keyword) DO NOTHING;

-- ===== AILMENT SEARCH SYNONYMS (new ailment keywords only) =====

INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('pneumonia', ARRAY['lung infection', 'bacterial pneumonia', 'viral pneumonia', 'alveolar infection', 'respiratory infection']),
  ('emphysema', ARRAY['COPD', 'chronic obstructive pulmonary disease', 'lung disease', 'alveolar damage', 'chronic bronchitis complication']),
  ('ear infection', ARRAY['otitis', 'otitis media', 'otitis externa', 'middle ear infection', 'earache']),
  ('sore throat', ARRAY['pharyngitis', 'strep throat', 'throat pain', 'throat infection', 'tonsillitis']),
  ('dandruff', ARRAY['seborrheic dermatitis', 'scalp flaking', 'scalp condition', 'dry scalp']),
  ('acne', ARRAY['acne vulgaris', 'pimples', 'breakouts', 'skin blemishes', 'cystic acne'])
ON CONFLICT (ailment_keyword) DO NOTHING;
