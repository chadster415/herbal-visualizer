-- Migration 213: Priest & Priest Pairings data
-- Source: Priest & Priest, Herbal Medication (1982), Materia Medica Schedules pp. 56-78
--
-- Herb ID reference (key mappings from book names to DB):
--   Capsicum minimum       -> Capsicum annuum (47)
--   Myrcia cerifera        -> Myrica cerifera (119)
--   Xanthoxylum americanum -> Zanthoxylum americanum (123)
--   Betonica officinalis   -> Stachys officinalis (207)
--   Cola vera              -> Cola acuminata (150)
--   Anemone pulsatilla     -> Pulsatilla vulgaris (36)
--   Cimicifuga racemosa    -> Actaea racemosa (25)
--   Matricaria chamomilla  -> Matricaria recutita (84)
--   Phytolacca decandra    -> Phytolacca americana (35)
--   Barosma betulina       -> Agathosma betulina (181)
--   Ulmus fulva            -> Ulmus rubra (92)
--   Crataegus oxycantha    -> Crataegus spp. (73)
--   Trifoleum pratense     -> Trifolium pratense (42)
--   Berberis aquifolium    -> Mahonia aquifolium (33)
--   Cassia angustifolia    -> Senna alexandrina (216)
--   Rheum officinalis      -> Rheum palmatum (154)
--   Spiraea ulmaria        -> Filipendula ulmaria (75)
--   Chionanthes virginica  -> Chionanthus virginicus (24)
--   Uva ursi               -> Arctostaphylos uva-ursi (46)
--   Serenoa serrulata      -> Serenoa repens (186)
--   Equisetum purpureum    -> Equisetum arvense (151) [close relative]
--   Tr. Myrrh / Myrrha     -> Commiphora molmol (99)
--   Carduus                -> Silybum marianum (206)
--   Triticum repens        -> Elymus repens (179)

INSERT INTO herbal.priest_pairings
  (herb_id, partner_herb_id, partner_name_raw, combination_context, sort_order)
VALUES

-- ============================================================
-- GENERAL STIMULANTS
-- ============================================================

-- Capsicum annuum (47) [book: Capsicum minimum]
(47, 167, 'Cinnamomum spp.',       'With Cinnamomum and Syzygium aromaticum (Clove) for warming, diffusive stimulant action', 1),
(47, 111, 'Syzygium aromaticum',   'With Cinnamomum and Syzygium aromaticum (Clove) for warming, diffusive stimulant action', 2),
(47, 132, 'Lobelia inflata',       'Lobelia inflata renders Capsicum more diffusive; also combined as local liniment', 3),

-- Zanthoxylum americanum (123) [book: Xanthoxylum americanum]
(123, 35, 'Phytolacca',            'With Phytolacca americana for chronic rheumatic and neurasthenic conditions', 1),

-- ============================================================
-- GENERAL RELAXANTS
-- ============================================================

-- Lobelia inflata (132)
(132, 72,  'Caulophyllum',         'With Caulophyllum thalictroides (Blue Cohosh) to enhance relaxation of tension and spasm', 1),
(132, 136, 'Nepeta cataria',       'As enema with Nepeta cataria (1:2, Lobelia:Nepeta, 4 drams powder in 3 pints water) for intestinal relaxation', 2),
(132, 47,  'Capsicum annuum',      'As local plaster with Capsicum annuum for topical antispasmodic and diffusive action', 3),

-- Dioscorea villosa (74)
(74, 145, 'Valeriana officinalis', 'With Valeriana officinalis and Actaea racemosa (Black Cohosh) as nervine antispasmodic for neuralgic and vegetative conditions', 1),
(74, 25,  'Actaea racemosa',       'With Valeriana officinalis and Actaea racemosa (Black Cohosh) as nervine antispasmodic for neuralgic and vegetative conditions', 2),
(74, 93,  'Viburnum opulus',       'With Viburnum opulus (Cramp Bark) and Mitchella repens for pelvic antispasmodic and uterine support', 3),
(74, 188, 'Mitchella repens',      'With Viburnum opulus (Cramp Bark) and Mitchella repens for pelvic antispasmodic and uterine support', 4),

-- Asclepias tuberosa (67)
(67, 132, 'Lobelia inflata',       'With Lobelia inflata and Zingiber officinale for respiratory relaxation and peripheral capillary diffusion', 1),
(67, 124, 'Zingiber officinale',   'With Lobelia inflata and Zingiber officinale for respiratory relaxation and peripheral capillary diffusion', 2),
(67, 74,  'Dioscorea villosa',     'With Dioscorea villosa and Zingiber officinale as antispasmodic for pleurisy and intercostal rheumatism', 3),
(67, 124, 'Zingiber officinale',   'With Dioscorea villosa and Zingiber officinale as antispasmodic for pleurisy and intercostal rheumatism', 4),
(67, 58,  'Solidago virgaurea',    'With Solidago virgaurea and Zingiber officinale for catarrhal respiratory conditions', 5),
(67, 124, 'Zingiber officinale',   'With Solidago virgaurea and Zingiber officinale for catarrhal respiratory conditions', 6),
(67, 212, 'Ballota nigra',         'With Ballota nigra (Black Horehound) for antispasmodic and expectorant support', 7),

-- ============================================================
-- GENERAL ASTRINGENTS
-- ============================================================

-- Euphrasia spp. (51) [book: Euphrasia officinalis]
(51, 30, 'Hydrastis canadensis',   'Locally with Hydrastis canadensis (Goldenseal) as anti-inflammatory wash for conjunctivitis and sinusitis', 1),

-- Geranium maculatum (52)
(52, 30, 'Hydrastis canadensis',   'With Hydrastis canadensis (Goldenseal) for tonic astringent effect on mucous membranes and passive haemorrhages', 1),

-- Hamamelis virginiana (79)
(79, 92,  'Ulmus fulva',           'With Ulmus rubra (Slippery Elm) for soothing and astringent effect on inflamed venous and haemorrhoidal conditions', 1),
(79, 70,  'Calendula officinalis', 'With Calendula officinalis or Stellaria media for compresses on bruised soreness and venous congestion', 2),
(79, 88,  'Stellaria media',       'With Calendula officinalis or Stellaria media for compresses on bruised soreness and venous congestion', 3),

-- Rubus idaeus (155)
(155, 119, 'Myrica cerifera',      'With Myrica cerifera (Bayberry) or Hydrastis canadensis (Goldenseal) for tonic astringent support in dysentery and menorrhagia', 1),
(155, 30,  'Hydrastis canadensis', 'With Myrica cerifera (Bayberry) or Hydrastis canadensis (Goldenseal) for tonic astringent support in dysentery and menorrhagia', 2),
(155, 79,  'Hamamelis virginiana', 'As astringent lotion with Hamamelis virginiana for ophthalmia and inflamed conditions', 3),

-- Salvia officinalis (56)
(56, 99, 'Tr. Myrrh',             'As gargle with Myrrh (Commiphora molmol) for sore and ulcerated throat', 1),

-- ============================================================
-- ALTERATIVES
-- ============================================================

-- Arctium lappa (22)
(22, 37,  'Rumex crispus',         'Oral and topical with Rumex crispus (Yellow Dock) for skin eruptions and scrofulous conditions', 1),
(22, 124, 'Zingiber officinale',   'With Zingiber officinale (Ginger) for diffusive effects in skin and eliminative conditions', 2),
(22, 30,  'Hydrastis canadensis',  'With Hydrastis canadensis (Goldenseal) for tonic effects on mucous membranes in alterative preparations', 3),

-- Baptisia tinctoria (23)
(23, 99,  'Myrrha',                'With Myrrh (Commiphora molmol) for offensive secretions and putrescence in septic conditions', 1),
(23, 35,  'Phytolacca americana',  'As gargle with Phytolacca americana (Poke Root) for tonsillitis, quinsy and throat conditions', 2),
(23, 70,  'Calendula officinalis', 'As local tampon with Calendula officinalis for cervical erosion and surface ulceration', 3),
(23, 92,  'Ulmus fulva',           'As poultice with Ulmus rubra (Slippery Elm) for surface ulceration and tissue degeneration', 4),

-- Echinacea angustifolia (221)
(221, 23, 'Baptisia tinctoria',    'With Baptisia tinctoria and Hydrastis canadensis (Goldenseal) for septic infections, septicaemia and blood conditions', 1),
(221, 30, 'Hydrastis canadensis',  'With Baptisia tinctoria and Hydrastis canadensis (Goldenseal) for septic infections, septicaemia and blood conditions', 2),
(221, 30, 'Hydrastis canadensis',  'With Hydrastis canadensis (Goldenseal) as antiseptic for mucous membrane infections', 3),

-- Iris versicolor (31)
(31, 30,  'Hydrastis canadensis',  'With Hydrastis canadensis (Goldenseal) and Chelone glabra for hepatic congestion and lymphatic stasis', 1),
(31, 171, 'Chelone glabra',        'With Hydrastis canadensis (Goldenseal) and Chelone glabra for hepatic congestion and lymphatic stasis', 2),

-- Phytolacca americana (35) [book: Phytolacca decandra]
(35, 25,  'Actaea racemosa',       'With Actaea racemosa (Black Cohosh) and Zanthoxylum americanum (Prickly Ash) for chronic rheumatism, arthritis and tonsillitis', 1),
(35, 123, 'Zanthoxylum americanum','With Actaea racemosa (Black Cohosh) and Zanthoxylum americanum (Prickly Ash) for chronic rheumatism, arthritis and tonsillitis', 2),
(35, 99,  'Myrrha',               'Oral and as gargle with Myrrh (Commiphora) for putrescent and ulcerative conditions', 3),

-- Rumex crispus (37)
(37, 122, 'Syr. Taraxacum',        'With Taraxacum officinale (Dandelion) syrup for iron-deficiency anaemia and skin conditions', 1),

-- Scrophularia nodosa (39)
(39, 35, 'Phytolacca decandra',    'With Phytolacca americana and Iris versicolor for enlarged glands, mammary tumours and skin diseases', 1),
(39, 31, 'Iris versicolor',        'With Phytolacca americana and Iris versicolor for enlarged glands, mammary tumours and skin diseases', 2),

-- ============================================================
-- GENERAL TONICS
-- ============================================================

-- Agrimonia eupatoria (148)
(148, 71,  'Capsella bursa-pastoris', 'With Capsella bursa-pastoris (Shepherd''s Purse) for bladder atony and urinary incontinence', 1),
(148, 171, 'Chelone glabra',          'With Chelone glabra (Balmony) for intestinal weakness and hepatic atrophy', 2),

-- Stachys officinalis (207) [book: Betonica officinalis]
(207, 25,  'Actaea racemosa',      'With Actaea racemosa (Black Cohosh) and Scutellaria lateriflora (Skullcap) for nervous tension and ischaemic headache', 1),
(207, 142, 'Scutellaria lateriflora', 'With Actaea racemosa (Black Cohosh) and Scutellaria lateriflora (Skullcap) for nervous tension and ischaemic headache', 2),
(207, 25,  'Actaea racemosa',      'With Actaea racemosa (Black Cohosh) specifically for sclerotic vascular changes and neuralgic conditions', 3),
(207, 109, 'Rosmarinus officinalis','With Rosmarinus officinalis (Rosemary) or Silybum marianum (Milk Thistle/Carduus) for gastric and hepatic support', 4),
(207, 206, 'Carduus (Silybum marianus)', 'With Rosmarinus officinalis (Rosemary) or Silybum marianum (Milk Thistle/Carduus) for gastric and hepatic support', 5),

-- Cola acuminata (150) [book: Cola vera]
(150, 207, 'Betonica officinalis', 'Used adjunctively with Stachys officinalis (Wood Betony) as cerebro-spinal stimulating tonic', 1),
(150, 36,  'Pulsatilla vulgaris',  'With Pulsatilla vulgaris (Pasqueflower) for neurasthenic and melancholic conditions', 2),

-- Hydrastis canadensis (30)
(30, 174, 'Juglans cinerea',       'With Juglans cinerea (Butternut) or Leptandra virginica (Black Root) for gastro-intestinal catarrhal conditions', 1),
(30, 175, 'Leptandra virginica',   'With Juglans cinerea (Butternut) or Leptandra virginica (Black Root) for gastro-intestinal catarrhal conditions', 2),
(30, 117, 'Eupatorium purpureum',  'With Eupatorium purpureum (Gravel Root) for renal catarrhal conditions', 3),
(30, 188, 'Mitchella repens',      'With Mitchella repens (Partridgeberry) for genital and uterine conditions', 4),

-- Populus tremuloides (86)
(86, 71, 'Capsella bursa-pastoris', 'With Capsella bursa-pastoris (Shepherd''s Purse) or Arctostaphylos uva-ursi (Bearberry) for catarrh of the bladder and atonic conditions', 1),
(86, 46, 'Uva-ursi',               'With Capsella bursa-pastoris (Shepherd''s Purse) or Arctostaphylos uva-ursi (Bearberry) for catarrh of the bladder and atonic conditions', 2),

-- ============================================================
-- NERVINES
-- ============================================================

-- Pulsatilla vulgaris (36) [book: Anemone pulsatilla]
(36, 25,  'Actaea racemosa',       'With Actaea racemosa (Black Cohosh) or Aletris farinosa (True Unicorn Root) for functional neuroses and pelvic conditions', 1),
(36, NULL, 'Aletris farinosa',     'With Actaea racemosa (Black Cohosh) or Aletris farinosa (True Unicorn Root) for functional neuroses and pelvic conditions', 2),
(36, 93,  'Viburnum opulus',       'With Viburnum opulus (Cramp Bark) or Viburnum prunifolium (Black Haw) for dysmenorrhoea and spasmodic conditions', 3),
(36, 94,  'Viburnum prunifolium',  'With Viburnum opulus (Cramp Bark) or Viburnum prunifolium (Black Haw) for dysmenorrhoea and spasmodic conditions', 4),
(36, 51,  'Euphrasia officinalis', 'With Euphrasia spp. (Eyebright) for catarrhal ophthalmic and vasomotor instability', 5),
(36, 61,  'Verbascum thapsus',     'With Verbascum thapsus (Mullein) for respiratory and catarrhal conditions', 6),

-- Avena sativa (178)
(178, NULL, 'Aletris farinosa',    'With Aletris farinosa (True Unicorn Root) or Mitchella repens (Partridgeberry) for nervous weakness with female debility', 1),
(178, 188, 'Mitchella repens',     'With Aletris farinosa (True Unicorn Root) or Mitchella repens (Partridgeberry) for nervous weakness with female debility', 2),
(178, 142, 'Scutellaria lateriflora', 'With Scutellaria lateriflora (Skullcap) for nervous exhaustion, insomnia and neurasthenia', 3),

-- Actaea racemosa (25) [book: Cimicifuga racemosa]
(25, NULL, 'Cypripedium pubescens', 'With Cypripedium pubescens (Lady''s Slipper) and Caulophyllum thalictroides (Blue Cohosh) for pelvic spasms and uterine conditions', 1),
(25, 72,   'Caulophyllum thalictroides', 'With Cypripedium pubescens (Lady''s Slipper) and Caulophyllum thalictroides (Blue Cohosh) for pelvic spasms and uterine conditions', 2),
(25, 123,  'Zanthoxylum americanum', 'With Zanthoxylum americanum (Prickly Ash) for muscular and crampy pains, rheumatism and sciatica', 3),
(25, 131,  'Leonurus cardiaca',    'With Leonurus cardiaca (Motherwort) and supporting tonics for uterine atony and cardiac nervous conditions', 4),
(25, NULL, 'Cinchona officinalis', 'With Cinchona officinalis or Zanthoxylum americanum (Prickly Ash) as supportive tonic in neuralgic conditions', 5),
(25, 123,  'Zanthoxylum americanum', 'With Cinchona officinalis or Zanthoxylum americanum (Prickly Ash) as supportive tonic in neuralgic conditions', 6),

-- Humulus lupulus (129)
(129, 145, 'Valeriana officinalis', 'With Valeriana officinalis (Valerian) for nervous exhaustion, insomnia and facial neuralgia', 1),

-- Passiflora incarnata (137)
(137, 129, 'Humulus lupulus',      'With Humulus lupulus (Hops) for nervous agitation, restlessness and insomnia in infants and the elderly', 1),

-- Scutellaria lateriflora (142)
(142, 36, 'Pulsatilla vulgaris',   'With Pulsatilla vulgaris or Actaea racemosa (Black Cohosh) for nervous exhaustion and cerebrospinal conditions', 1),
(142, 25, 'Actaea racemosa',       'With Pulsatilla vulgaris or Actaea racemosa (Black Cohosh) for nervous exhaustion and cerebrospinal conditions', 2),
(142, 137, 'Passiflora incarnata', 'With Passiflora incarnata (Passionflower) for insomnia, nightmares and convulsive states', 3),

-- Turnera diffusa (144)
(144, 142, 'Scutellaria lateriflora', 'With Scutellaria lateriflora (Skullcap) for anxiety neurosis and nervous debility affecting the generative system', 1),

-- Valeriana officinalis (145)
(145, 137, 'Passiflora incarnata', 'With Passiflora incarnata (Passionflower) for nervous excitability and insomnia', 1),
(145, 129, 'Humulus lupulus',      'With Humulus lupulus (Hops) for nervous excitability and insomnia', 2),
(145, 163, 'Convallaria majalis',  'With Convallaria majalis (Lily of the Valley) for nervous palpitations with cardiac involvement', 3),
(145, 74,  'Dioscorea villosa',    'With Dioscorea villosa (Wild Yam) and Zingiber officinale (Ginger) for intestinal cramping and nervous colic', 4),
(145, 124, 'Zingiber officinale',  'With Dioscorea villosa (Wild Yam) and Zingiber officinale (Ginger) for intestinal cramping and nervous colic', 5),
(145, 36,  'Pulsatilla vulgaris',  'With Pulsatilla vulgaris for menopausal dysfunction and retarded/scanty menstruation', 6),

-- Viburnum opulus (93)
(93, 74, 'Dioscorea villosa',      'With Dioscorea villosa (Wild Yam) for colicky pains and spasms of tubular organs in the gastro-intestinal and genito-urinary tracts', 1),

-- Viscum album (211)
(211, 73, 'Crataegus spp.',        'With Crataegus spp. (Hawthorn) and Tilia platyphyllos (Linden) for hypertension and cardiac neurosis', 1),
(211, 90, 'Tilia platyphyllos',    'With Crataegus spp. (Hawthorn) and Tilia platyphyllos (Linden) for hypertension and cardiac neurosis', 2),

-- ============================================================
-- DIURETICS
-- ============================================================

-- Agathosma betulina (181) [book: Barosma betulina]
(181, 103, 'Juniperus communis',   'With Juniperus communis (Juniper) for greater stimulation of renal circulation in dropsical and atonic conditions', 1),
(181, 45,  'Althaea officinalis',  'With Althaea officinalis (Marshmallow) as soothing demulcent for urinary tract irritation', 2),

-- Equisetum arvense (151) [book: Equisetum purpureum — close relative]
(151, 188, 'Mitchella repens',     'With Mitchella repens (Partridgeberry) for uterine and vaginal irritation with urinary involvement', 1),

-- Galium aparine (28)
(28, 181, 'Agathosma betulina',    'With Agathosma betulina (Buchu) or Arctostaphylos uva-ursi (Bearberry) for urinary infections and cystic irritation', 1),
(28, 46,  'Uva-ursi',             'With Agathosma betulina (Buchu) or Arctostaphylos uva-ursi (Bearberry) for urinary infections and cystic irritation', 2),
(28, 45,  'Althaea officinalis',   'With Althaea officinalis (Marshmallow) as soothing demulcent for scalding micturition and irritable bladder', 3),
(28, NULL, 'Rhus aromatica',       'With Rhus aromatica for enuresis and skin eruptions from urinary dysfunction', 4),

-- Juniperus communis (103)
(103, 45, 'Althaea officinalis',   'Combined with Althaea officinalis (Marshmallow) and Arctostaphylos uva-ursi (Bearberry) to counter renal irritability in elderly patients', 1),
(103, 46, 'Uva-ursi',             'Combined with Althaea officinalis (Marshmallow) and Arctostaphylos uva-ursi (Bearberry) to counter renal irritability in elderly patients', 2),

-- Zea mays (95)
(95, 45,  'Althaea officinalis',   'Always combined with Althaea officinalis (Marshmallow) to soothe renal and cystic irritation', 1),
(95, 148, 'Agrimonia eupatoria',   'With Agrimonia eupatoria (Agrimony) and Capsella bursa-pastoris (Shepherd''s Purse) for bladder weakness and enuresis', 2),
(95, 71,  'Capsella bursa-pastoris', 'With Agrimonia eupatoria (Agrimony) and Capsella bursa-pastoris (Shepherd''s Purse) for bladder weakness and enuresis', 3),

-- ============================================================
-- DIAPHORETICS
-- ============================================================

-- Achillea millefolium (44)
(44, 57,  'Sambucus nigra',        'In hot infusion with Sambucus nigra (Elder) and Myrica cerifera (Bayberry) to generate heat and induce perspiration in colds and influenza', 1),
(44, 119, 'Myrica cerifera',       'In hot infusion with Sambucus nigra (Elder) and Myrica cerifera (Bayberry) to generate heat and induce perspiration in colds and influenza', 2),
(44, 55,  'Mentha piperita',       'With Mentha piperita (Peppermint) or Trifolium pratense (Red Clover) for respiratory catarrh and acute stage of colds', 3),
(44, 42,  'Trifolium pratense',    'With Mentha piperita (Peppermint) or Trifolium pratense (Red Clover) for respiratory catarrh and acute stage of colds', 4),
(44, 71,  'Capsella bursa-pastoris', 'With Capsella bursa-pastoris (Shepherd''s Purse) for uterine haemorrhage and profuse menstruation', 5),

-- Eupatorium perfoliatum (50)
(50, 44,  'Achillea millefolium',  'With Achillea millefolium (Yarrow) for the first stage of influenza; Pulsatilla vulgaris during the third stage', 1),
(50, 36,  'Pulsatilla vulgaris',   'With Achillea millefolium (Yarrow) for the first stage of influenza; Pulsatilla vulgaris during the third stage', 2),
(50, 67,  'Asclepias tuberosa',    'With Asclepias tuberosa (Pleurisy Root) and Inula helenium (Elecampane) for pulmonary inflammation and catarrh', 3),
(50, 54,  'Inula helenium',        'With Asclepias tuberosa (Pleurisy Root) and Inula helenium (Elecampane) for pulmonary inflammation and catarrh', 4),
(50, 171, 'Chelone glabra',        'With Chelone glabra (Balmony) and Juglans cinerea (Butternut) syrup for post-influenzal gastric irritation and biliousness', 5),
(50, 174, 'Syr. Juglans',          'With Chelone glabra (Balmony) and Juglans cinerea (Butternut) syrup for post-influenzal gastric irritation and biliousness', 6),

-- Nepeta cataria (136)
(136, 124, 'Zingiber officinale',  'With Zingiber officinale (Ginger) as diffusive stimulant for childhood fevers', 1),
(136, 74,  'Dioscorea villosa',    'As rectal injection with Dioscorea villosa (Wild Yam) for flatulent colic and colonic pain', 2),
(136, 84,  'Matricaria recutita',  'With Matricaria recutita (Chamomile) for nervous irritation and restlessness in children', 3),

-- Sambucus nigra (57)
(57, 44,  'Achillea millefolium',  'With Achillea millefolium (Yarrow) and Pulsatilla vulgaris for colds and fevers with dry, hot skin', 1),
(57, 36,  'Pulsatilla vulgaris',   'With Achillea millefolium (Yarrow) and Pulsatilla vulgaris for colds and fevers with dry, hot skin', 2),
(57, 36,  'Pulsatilla vulgaris',   'With Pulsatilla vulgaris specifically for dry coryza and spasmodic croup', 3),
(57, 42,  'Trifolium pratense',    'With Trifolium pratense (Red Clover) for skin eruptions from metabolic disturbance', 4),
(57, 56,  'Salvia officinalis',    'With Salvia officinalis (Sage) for weakening night sweats', 5),

-- ============================================================
-- DEMULCENTS
-- ============================================================

-- Althaea officinalis (45)
(45, 70,  'Calendula officinalis', 'Cold water infusion with Calendula officinalis or Hydrastis canadensis (Goldenseal) for respiratory and digestive inflammation', 1),
(45, 30,  'Hydrastis canadensis',  'Cold water infusion with Calendula officinalis or Hydrastis canadensis (Goldenseal) for respiratory and digestive inflammation', 2),
(45, 99,  'Myrrh',                'Infusion with Myrrh (Commiphora) as gargle for inflammation of mouth and throat', 3),
(45, 92,  'Ulmus fulva',          'With Ulmus rubra (Slippery Elm) as poultice for abscesses, boils and gangrenous wounds', 4),

-- Symphytum officinale (89)
(89, 30, 'Hydrastis canadensis',   'With Hydrastis canadensis (Goldenseal) aqueous extract for gastric and duodenal ulcer and intestinal inflammation', 1),
(89, 70, 'Calendula officinalis',  'With Calendula officinalis aqueous extract for chronic suppurative ulcerations and wounds', 2),

-- Ulmus rubra (92) [book: Ulmus fulva]
(92, 45,  'Althaea officinalis',   'As poultice with Althaea officinalis (Marshmallow) or Lobelia inflata for swollen glands, abscesses and inflamed tissue', 1),
(92, 132, 'Lobelia inflata',       'As poultice with Althaea officinalis (Marshmallow) or Lobelia inflata for swollen glands, abscesses and inflamed tissue', 2),
(92, 35,  'Phytolacca rad.',       'As poultice with Phytolacca americana (Poke Root) root for mastitis and mammary congestion', 3),

-- ============================================================
-- ORGAN REMEDIES: HEART
-- ============================================================

-- Convallaria majalis (163)
(163, 131, 'Leonurus cardiaca',    'With Leonurus cardiaca (Motherwort) for cardiac weakness, incipient decompensation and autonomic nervous conditions', 1),
(163, 221, 'Echinacea angustifolia', 'With Echinacea angustifolia and Phytolacca americana for endocarditis and immune support alongside cardiac tonic action', 2),
(163, 35,  'Phytolacca americana', 'With Echinacea angustifolia and Phytolacca americana for endocarditis and immune support alongside cardiac tonic action', 3),

-- Crataegus spp. (73) [book: Crataegus oxycantha]
(73, 47,  'Capsicum annuum',       'With Capsicum annuum (Cayenne) or Cactus grandiflorus to sustain cardiac function and arterial force', 1),
(73, NULL, 'Cactus grandiflorus',  'With Capsicum annuum (Cayenne) or Cactus grandiflorus to sustain cardiac function and arterial force', 2),
(73, 211, 'Viscum album',          'With Viscum album (Mistletoe), Tilia platyphyllos (Linden) and Scutellaria lateriflora (Skullcap) for hypertension and cardiac neurosis', 3),
(73, 90,  'Tilia platyphyllos',    'With Viscum album (Mistletoe), Tilia platyphyllos (Linden) and Scutellaria lateriflora (Skullcap) for hypertension and cardiac neurosis', 4),
(73, 142, 'Scutellaria lateriflora', 'With Viscum album (Mistletoe), Tilia platyphyllos (Linden) and Scutellaria lateriflora (Skullcap) for hypertension and cardiac neurosis', 5),
(73, 163, 'Convallaria majalis',   'With Convallaria majalis (Lily of the Valley) or Pulsatilla vulgaris for cardiac decompensation and tachycardia', 6),
(73, 36,  'Pulsatilla vulgaris',   'With Convallaria majalis (Lily of the Valley) or Pulsatilla vulgaris for cardiac decompensation and tachycardia', 7),

-- Leonurus cardiaca (131)
(131, 1058, 'Senecio aureus',      'With Senecio aureus (Life Root) or Mitchella repens (Partridgeberry) for pre-menstrual tension and uterine conditions', 1),
(131, 188,  'Mitchella repens',    'With Senecio aureus (Life Root) or Mitchella repens (Partridgeberry) for pre-menstrual tension and uterine conditions', 2),
(131, NULL, 'Aletris farinosa',    'With Aletris farinosa (True Unicorn Root) or Pulsatilla vulgaris for anaemic nervousness and uterine conditions', 3),
(131, 36,   'Pulsatilla vulgaris', 'With Aletris farinosa (True Unicorn Root) or Pulsatilla vulgaris for anaemic nervousness and uterine conditions', 4),
(131, 163,  'Convallaria majalis', 'With Convallaria majalis (Lily of the Valley) or Melissa officinalis (Lemon Balm) for cardiac and vegetative neuroses', 5),
(131, 134,  'Melissa officinalis', 'With Convallaria majalis (Lily of the Valley) or Melissa officinalis (Lemon Balm) for cardiac and vegetative neuroses', 6),
(131, 133,  'Lycopus spp.',        'With Lycopus spp. (Bugleweed) for hyperthyroid cardiac reactions and tachycardia', 7),
(131, 72,   'Caulophyllum thalictroides', 'With Caulophyllum thalictroides (Blue Cohosh) and Zingiber officinale (Ginger) for dysmenorrhoea and uterine stimulation', 8),
(131, 124,  'Zingiber officinale', 'With Caulophyllum thalictroides (Blue Cohosh) and Zingiber officinale (Ginger) for dysmenorrhoea and uterine stimulation', 9),

-- ============================================================
-- ORGAN REMEDIES: PULMONARY
-- ============================================================

-- Inula helenium (54)
(54, 89,  'Symphytum officinale',  'With Symphytum officinale (Comfrey) for chronic catarrhal and bronchial conditions', 1),
(54, 42,  'Trifolium pratense',    'With Trifolium pratense (Red Clover) for pulmonary expectoration and chronic bronchitis', 2),
(54, NULL, 'Sticta pulmonaria',    'With Sticta pulmonaria (Lung Lichen) for dry, hacking cough with pulmonary irritation', 3),

-- Lycopus spp. (133) [book: Lycopus virginicus]
(133, 54,  'Inula helenium',       'With Inula helenium (Elecampane) or Symphytum officinale (Comfrey) for phthisis and passive pulmonary haemorrhage', 1),
(133, 89,  'Symphytum officinale', 'With Inula helenium (Elecampane) or Symphytum officinale (Comfrey) for phthisis and passive pulmonary haemorrhage', 2),
(133, 163, 'Convallaria majalis',  'With Convallaria majalis (Lily of the Valley) for hyperthyroid tachycardia and palpitation', 3),

-- Marrubium vulgare (160)
(160, 54,  'Inula helenium',       'With Inula helenium (Elecampane) or Prunus serotina (Wild Cherry) for catarrhal and bronchial conditions with moist expectoration', 1),
(160, 140, 'Prunus serotina',      'With Inula helenium (Elecampane) or Prunus serotina (Wild Cherry) for catarrhal and bronchial conditions with moist expectoration', 2),

-- Prunus serotina (140)
(140, 119, 'Myrica cerifera',      'As decoction with Myrica cerifera (Bayberry) for chronic bronchitis with debility', 1),
(140, 58,  'Solidago virgaurea',   'With Solidago virgaurea (Goldenrod) as throat pastille for weak throat and chronic hoarseness', 2),

-- Trifolium pratense (42) [book: Trifoleum pratense]
(42, 132, 'Syr. Lobel. acet.',     'With Lobelia inflata (syrup preparation) for spasmodic, croupy coughs and pertussis', 1),
(42, 58,  'Solidago virgaurea',    'With Solidago virgaurea (Goldenrod) as gargle for pharyngeal inflammation and infection', 2),
(42, 22,  'Arctium lappa rad.',    'With Arctium lappa (Burdock) root or Rumex crispus (Yellow Dock) for chronic skin eruptions', 3),
(42, 37,  'Rumex crispus',         'With Arctium lappa (Burdock) root or Rumex crispus (Yellow Dock) for chronic skin eruptions', 4),

-- Tussilago farfara (60)
(60, 54, 'Inula helenium',         'With Inula helenium (Elecampane) or Verbascum thapsus (Mullein) for chronic emphysema, silicosis and persistent cough', 1),
(60, 61, 'Verbascum thapsus',      'With Inula helenium (Elecampane) or Verbascum thapsus (Mullein) for chronic emphysema, silicosis and persistent cough', 2),

-- Verbascum thapsus (61)
(61, 57, 'Sambucus nigra',         'With Sambucus nigra (Elder) or Trifolium pratense (Red Clover) for paroxysmal laryngeal cough and hay fever', 1),
(61, 42, 'Trifoleum pratense',      'With Sambucus nigra (Elder) or Trifolium pratense (Red Clover) for paroxysmal laryngeal cough and hay fever', 2),
(61, 199, 'Grindelia camporum',    'With Grindelia camporum (Gumweed) for irritable chronic bronchitis and asthma', 3),

-- ============================================================
-- ORGAN REMEDIES: GASTRO-INTESTINAL
-- ============================================================

-- Mahonia aquifolium (33) [book: Berberis aquifolium]
(33, 37, 'Rumex crispus',          'With Rumex crispus (Yellow Dock) or Arctium lappa (Burdock) root for eczema, herpes and scrofulous skin conditions', 1),
(33, 22, 'Arctium lappa rad.',     'With Rumex crispus (Yellow Dock) or Arctium lappa (Burdock) root for eczema, herpes and scrofulous skin conditions', 2),

-- Collinsonia canadensis (182)
(182, 75,  'Filipendula ulmaria',  'With Filipendula ulmaria (Meadowsweet) or Rubus idaeus (Raspberry) for gastro-enteritis with diarrhoea', 1),
(182, 155, 'Rubus idaeus',         'With Filipendula ulmaria (Meadowsweet) or Rubus idaeus (Raspberry) for gastro-enteritis with diarrhoea', 2),
(182, 30,  'Hydrastis canadensis', 'With Hydrastis canadensis (Goldenseal) and Myrrh (Commiphora) for haemorrhoids and laryngeal catarrh', 3),
(182, 99,  'Myrrha',              'With Hydrastis canadensis (Goldenseal) and Myrrh (Commiphora) for haemorrhoids and laryngeal catarrh', 4),
(182, 30,  'Hydrastis canadensis', 'With Hydrastis canadensis (Goldenseal) and Leptandra virginica (Black Root) for alimentary mucous membrane conditions and haemorrhoids', 5),
(182, 175, 'Leptandra virginica',  'With Hydrastis canadensis (Goldenseal) and Leptandra virginica (Black Root) for alimentary mucous membrane conditions and haemorrhoids', 6),

-- Gentiana lutea (102)
(102, 182, 'Collinsonia canadensis', 'With Collinsonia canadensis (Stoneroot) or Hydrastis canadensis (Goldenseal) for portal congestion and biliousness — small doses only', 1),
(102, 30,  'Hydrastis canadensis', 'With Collinsonia canadensis (Stoneroot) or Hydrastis canadensis (Goldenseal) for portal congestion and biliousness — small doses only', 2),

-- Juglans cinerea (174)
(174, 124, 'Zingiber officinale',  'With Zingiber officinale (Ginger) in aqueous extract to prevent griping and stimulate hepatic action', 1),
(174, 182, 'Collinsonia canadensis', 'With Collinsonia canadensis (Stoneroot) for bowel and portal conditions', 2),
(174, 171, 'Chelone glabra',       'With Chelone glabra (Balmony) for chronic constipation and hepatic dysfunction', 3),
(174, 122, 'Taraxacum officinale', 'With Taraxacum officinale (Dandelion) for skin eruptions from faulty elimination', 4),

-- Rhamnus purshiana (205)
(205, 174, 'Syr. Juglans',         'With Juglans cinerea (Butternut) syrup for chronic constipation and hepatic torpor', 1),

-- Rheum palmatum (154) [book: Rheum officinalis]
(154, 74,  'Dioscorea villosa',    'With Dioscorea villosa (Wild Yam) or Zingiber officinale (Ginger) to prevent griping and assist cathartic action', 1),
(154, 124, 'Zingiber officinale',  'With Dioscorea villosa (Wild Yam) or Zingiber officinale (Ginger) to prevent griping and assist cathartic action', 2),
(154, 30,  'Hydrastis canadensis', 'With Hydrastis canadensis (Goldenseal) and Leptandra virginica (Black Root) as tonic to cleanse and tone the bowel', 3),
(154, 175, 'Leptandra virginica',  'With Hydrastis canadensis (Goldenseal) and Leptandra virginica (Black Root) as tonic to cleanse and tone the bowel', 4),

-- Filipendula ulmaria (75) [book: Spiraea ulmaria]
(75, 148, 'Agrimonia eupatoria',   'With Agrimonia eupatoria (Agrimony) for bowel disturbance, summer diarrhoea and dyspepsia with hyperchlorydia', 1),

-- ============================================================
-- ORGAN REMEDIES: LIVER, GALL-BLADDER, PANCREAS
-- ============================================================

-- Berberis vulgaris (158)
(158, 140, 'Prunus serotina',      'With Prunus serotina (Wild Cherry) or Populus tremuloides (Aspen) for biliary catarrh, biliousness and hepatic conditions', 1),
(158, 86,  'Populus tremuloides',  'With Prunus serotina (Wild Cherry) or Populus tremuloides (Aspen) for biliary catarrh, biliousness and hepatic conditions', 2),

-- Chionanthus virginicus (24) [book: Chionanthes virginica]
(24, 158, 'Berberis vulgaris',     'With Berberis vulgaris (Barberry) for duodenal catarrh, catarrhal jaundice and gallstones', 1),

-- Leptandra virginica (175)
(175, 182, 'Collinsonia canadensis', 'With Collinsonia canadensis (Stoneroot) for hepatitis and chronic hepatic torpor', 1),

-- ============================================================
-- ORGAN REMEDIES: KIDNEYS AND BLADDER
-- ============================================================

-- Arctostaphylos uva-ursi (46) [book: Uva ursi]
(46, NULL, 'Rhus aromatica',       'With Rhus aromatica for chronic urinary conditions and atonic leucorrhoea', 1),
(46, 188,  'Mitchella repens',     'With Mitchella repens (Partridgeberry) for chronic vesical irritation and genital atony', 2),

-- ============================================================
-- ORGAN REMEDIES: GENITAL
-- ============================================================

-- Caulophyllum thalictroides (72)
(72, 142, 'Scutellaria lateriflora', 'With Scutellaria lateriflora (Skullcap) for antispasmodic and nervine support in uterine conditions', 1),
(72, 25,  'Actaea racemosa',       'With Actaea racemosa (Black Cohosh) for dysmenorrhoea, metritis and uterine spasm', 2),

-- Mitchella repens (188)
(188, 178, 'Avena sativa',         'With Avena sativa (Oat) for neurasthenia and irritability in women', 1),
(188, NULL, 'Aletris farinosa',    'With Aletris farinosa (True Unicorn Root) or Chamaelirium luteum (False Unicorn Root) for enlarged atonic uterus', 2),
(188, NULL, 'Helonias dioica',     'With Aletris farinosa (True Unicorn Root) or Chamaelirium luteum (False Unicorn Root) for enlarged atonic uterus', 3),
(188, 72,  'Caulophyllum thalictroides', 'With Caulophyllum thalictroides (Blue Cohosh) for uterine weakness and to facilitate parturition', 4),

-- Senecio aureus (1058)
(1058, 93, 'Viburnum opulus',      'With Viburnum opulus (Cramp Bark) or Caulophyllum thalictroides (Blue Cohosh) for atonic uterine conditions and menstrual dysfunction', 1),
(1058, 72, 'Caulophyllum thalictroides', 'With Viburnum opulus (Cramp Bark) or Caulophyllum thalictroides (Blue Cohosh) for atonic uterine conditions and menstrual dysfunction', 2),

-- Viburnum prunifolium (94)
(94, 1058, 'Senecio aureus',       'With Senecio aureus (Life Root) for uterine prolapse and atonic amenorrhoea', 1);
