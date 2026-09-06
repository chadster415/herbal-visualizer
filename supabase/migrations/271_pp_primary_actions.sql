-- Priest & Priest (1982) primary action assignments
-- Maps PP AUXILIARY classifications to existing primary_actions.
-- Body system = PP category context (not action-specific inference).
-- Only uses existing primary_action IDs — no new actions created.
-- source_id = 1 (priest_priest)
--
-- Primary action ID reference (subset used here):
--   2=Alterative, 5=Antimicrobial, 7=Antispasmodic, 8=Astringent
--   9=Bitter, 10=Cardiotonic, 11=Carminative, 12=Cholagogue
--   13=Demulcent, 14=Diuretic, 15=Emmenagogue, 19=Hepatic
--   22=Nervine Tonic, 23=Nervine Relaxant, 28=Vulnerary, 29=Circulatory Stimulant
--   31=Aperient, 33=Tonic, 39=Detoxifying, 43=Laxative
--   44=Emollient, 51=Diaphoretic, 53=Expectorant, 90=Pulmonary Tonic
--   167=Analgesic, 1158=Styptic, 1162=Nutritive, 1242=Anthelmintic
--   1248=Digestive Tonic, 1259=Sedative
--
-- Body system ID reference:
--   9=Cardiovascular, 10=Respiratory, 11=Digestive, 12=Urinary
--   13=Reproductive, 15=Nervous, 21=All

SET search_path TO herbal, public;

INSERT INTO herbal.herb_primary_actions
  (herb_id, primary_action_id, body_system_id, source_id)
VALUES

-- ============================================================
-- GENERAL STIMULANTS (body_system 21 = All)
-- ============================================================
-- Capsicum annuum (47): Antispasmodic / Tonic
(47, 7, 21, 1),
(47, 33, 21, 1),

-- Myrica cerifera (119): Astringent / Diaphoretic / Tonic
(119, 8, 21, 1),
(119, 51, 21, 1),
(119, 33, 21, 1),

-- Zanthoxylum americanum (123): Alterative / Diaphoretic / Tonic
(123, 2, 21, 1),
(123, 51, 21, 1),
(123, 33, 21, 1),

-- Zingiber officinale (124): Carminative / Expectorant
(124, 11, 21, 1),
(124, 53, 21, 1),

-- ============================================================
-- GENERAL RELAXANTS (body_system 15 = Nervous)
-- ============================================================
-- Lobelia inflata (132): Stimulant / Diaphoretic / Expectorant [Emetic skipped]
(132, 29, 15, 1),
(132, 51, 15, 1),
(132, 53, 15, 1),

-- Dioscorea villosa (74): Antispasmodic / Diaphoretic [Ambitious skipped]
(74, 7, 15, 1),
(74, 51, 15, 1),

-- Asclepias tuberosa (67): Expectorant / Antispasmodic
(67, 53, 15, 1),
(67, 7, 15, 1),

-- ============================================================
-- GENERAL ASTRINGENTS (body_system 21 = All)
-- ============================================================
-- Euphrasia spp. (51): Tonic
(51, 33, 21, 1),

-- Geranium maculatum (52): Styptic / Tonic
(52, 1158, 21, 1),
(52, 33, 21, 1),

-- Hamamelis virginiana (79): Sedative / Tonic
(79, 1259, 21, 1),
(79, 33, 21, 1),

-- Rubus idaeus (155): Stimulant
(155, 29, 21, 1),

-- Salvia officinalis (56): Stimulant / Carminative
(56, 29, 21, 1),
(56, 11, 21, 1),

-- ============================================================
-- ALTERATIVES (body_system 21 = All)
-- ============================================================
-- Arctium lappa (22): Diuretic / Diaphoretic
(22, 14, 21, 1),
(22, 51, 21, 1),

-- Baptisia tinctoria (23): Antiseptic [Discutient skipped]
(23, 5, 21, 1),

-- Echinacea angustifolia (221): Antiseptic / Antibiotic → Antimicrobial; Antitoxin → Detoxifying
(221, 5, 21, 1),
(221, 39, 21, 1),

-- Fucus vesiculosus (118): Diuretic [Deobstruent skipped]
(118, 14, 21, 1),

-- Iris versicolor (31): Diuretic / Cholagogue / Stimulant
(31, 14, 21, 1),
(31, 12, 21, 1),
(31, 29, 21, 1),

-- Phytolacca americana (35): Cathartic → Laxative [Emetic skipped]
(35, 43, 21, 1),

-- Rumex crispus (37): Tonic / Laxative
(37, 33, 21, 1),
(37, 43, 21, 1),

-- Scrophularia nodosa (39): Diuretic / Depurative → Detoxifying / Anodyne → Analgesic
(39, 14, 21, 1),
(39, 39, 21, 1),
(39, 167, 21, 1),

-- ============================================================
-- GENERAL TONICS (body_system 21 = All)
-- ============================================================
-- Agrimonia eupatoria (148): Diuretic / Astringent [Deobstruent skipped]
(148, 14, 21, 1),
(148, 8, 21, 1),

-- Stachys officinalis (207): Nervine / Stomachic
(207, 22, 21, 1),
(207, 1248, 21, 1),

-- Cola acuminata (150): Nervine / Cardiac / Diuretic
(150, 22, 21, 1),
(150, 10, 21, 1),
(150, 14, 21, 1),

-- Hydrastis canadensis (30): Alterative / Laxative / Antiseptic
(30, 2, 21, 1),
(30, 43, 21, 1),
(30, 5, 21, 1),

-- Populus tremuloides (86): Diuretic
(86, 14, 21, 1),

-- ============================================================
-- NERVINES (body_system 15 = Nervous)
-- ============================================================
-- Pulsatilla vulgaris (36): Sedative / Alterative / Anodyne
(36, 1259, 15, 1),
(36, 2, 15, 1),
(36, 167, 15, 1),

-- Avena sativa (178): Stimulant / Nutrient
(178, 29, 15, 1),
(178, 1162, 15, 1),

-- Actaea racemosa (25): Alterative / Antispasmodic / Sedative
(25, 2, 15, 1),
(25, 7, 15, 1),
(25, 1259, 15, 1),

-- Humulus lupulus (129): Sedative / Anodyne [Anaphrodisiac skipped]
(129, 1259, 15, 1),
(129, 167, 15, 1),

-- Hypericum perforatum (81): Sedative / Alterative / Vulnerary
(81, 1259, 15, 1),
(81, 2, 15, 1),
(81, 28, 15, 1),

-- Matricaria recutita (84): Carminative / Antispasmodic
(84, 11, 15, 1),
(84, 7, 15, 1),

-- Passiflora incarnata (137): Antispasmodic / Sedative / Anodyne
(137, 7, 15, 1),
(137, 1259, 15, 1),
(137, 167, 15, 1),

-- Scutellaria lateriflora (142): Sedative / Antispasmodic
(142, 1259, 15, 1),
(142, 7, 15, 1),

-- Turnera diffusa (144): Tonic [Aphrodisiac skipped]
(144, 33, 15, 1),

-- Valeriana officinalis (145): Sedative / Antispasmodic
(145, 1259, 15, 1),
(145, 7, 15, 1),

-- Verbena officinalis (146): Alterative / Tonic / Antispasmodic
(146, 2, 15, 1),
(146, 33, 15, 1),
(146, 7, 15, 1),

-- Viburnum opulus (93): Antispasmodic / Tonic
(93, 7, 15, 1),
(93, 33, 15, 1),

-- Viscum album (211): Antispasmodic
(211, 7, 15, 1),

-- ============================================================
-- DIURETICS (body_system 12 = Urinary)
-- ============================================================
-- Agathosma betulina (181): Tonic / Carminative / Antiseptic
(181, 33, 12, 1),
(181, 11, 12, 1),
(181, 5, 12, 1),

-- Galium aparine (28): Aperient
(28, 31, 12, 1),

-- Juniperus communis (103): Stimulant / Carminative / Antiseptic
(103, 29, 12, 1),
(103, 11, 12, 1),
(103, 5, 12, 1),

-- Zea mays (95): Demulcent / Antiseptic
(95, 13, 12, 1),
(95, 5, 12, 1),

-- ============================================================
-- DIAPHORETICS (body_system 21 = All)
-- ============================================================
-- Achillea millefolium (44): Astringent / Stimulant / Tonic
(44, 8, 21, 1),
(44, 29, 21, 1),
(44, 33, 21, 1),

-- Eupatorium perfoliatum (50): Stimulant / Tonic / Antispasmodic
(50, 29, 21, 1),
(50, 33, 21, 1),
(50, 7, 21, 1),

-- Nepeta cataria (136): Diaphoretic / Antispasmodic / Carminative
(136, 51, 21, 1),
(136, 7, 21, 1),
(136, 11, 21, 1),

-- Sambucus nigra (57): Alterative / Diuretic
(57, 2, 21, 1),
(57, 14, 21, 1),

-- ============================================================
-- DEMULCENTS (body_system 11 = Digestive)
-- ============================================================
-- Althaea officinalis (45): Emollient / Expectorant
(45, 44, 11, 1),
(45, 53, 11, 1),

-- Symphytum officinale (89): Astringent
(89, 8, 11, 1),

-- Ulmus rubra (92): Emollient / Pectoral → Pulmonary Tonic / Diuretic
(92, 44, 11, 1),
(92, 90, 11, 1),
(92, 14, 11, 1),

-- ============================================================
-- ORGAN REMEDIES: HEART (body_system 9 = Cardiovascular)
-- ============================================================
-- Convallaria majalis (163): Diuretic
(163, 14, 9, 1),

-- Crataegus spp. (73): Tonic / Diuretic
(73, 33, 9, 1),
(73, 14, 9, 1),

-- Leonurus cardiaca (131): Nervine / Emmenagogue
(131, 22, 9, 1),
(131, 15, 9, 1),

-- ============================================================
-- ORGAN REMEDIES: PULMONARY (body_system 10 = Respiratory)
-- ============================================================
-- Inula helenium (54): Diaphoretic / Diuretic / Alterative
(54, 51, 10, 1),
(54, 14, 10, 1),
(54, 2, 10, 1),

-- Lycopus spp. (133): Astringent / Tonic / Sedative
(133, 8, 10, 1),
(133, 33, 10, 1),
(133, 1259, 10, 1),

-- Marrubium vulgare (160): Pectoral → Pulmonary Tonic / Diuretic / Stomachic → Digestive Tonic
(160, 90, 10, 1),
(160, 14, 10, 1),
(160, 1248, 10, 1),

-- Prunus serotina (140): Astringent / Expectorant / Sedative
(140, 8, 10, 1),
(140, 53, 10, 1),
(140, 1259, 10, 1),

-- Pulmonaria officinalis (200): Demulcent / Tonic
(200, 13, 10, 1),
(200, 33, 10, 1),

-- Solidago virgaurea (58): Antiseptic / Diaphoretic / Diuretic
(58, 5, 10, 1),
(58, 51, 10, 1),
(58, 14, 10, 1),

-- Trifolium pratense (42): Antispasmodic / Sedative / Expectorant
(42, 7, 10, 1),
(42, 1259, 10, 1),
(42, 53, 10, 1),

-- Tussilago farfara (60): Stimulant / Relaxant → Nervine Relaxant
(60, 29, 10, 1),
(60, 23, 10, 1),

-- Verbascum thapsus (61): Astringent / Diuretic
(61, 8, 10, 1),
(61, 14, 10, 1),

-- ============================================================
-- ORGAN REMEDIES: GASTRO-INTESTINAL (body_system 11 = Digestive)
-- ============================================================
-- Mahonia aquifolium (33): Alterative / Tonic
(33, 2, 11, 1),
(33, 33, 11, 1),

-- Senna alexandrina (216): Tonic / Laxative [Cathartic = Laxative, not duplicated]
(216, 33, 11, 1),
(216, 43, 11, 1),

-- Collinsonia canadensis (182): Alterative / Diuretic / Tonic
(182, 2, 11, 1),
(182, 14, 11, 1),
(182, 33, 11, 1),

-- Gentiana lutea (102): Cholagogue / Anthelmintic / Emmenagogue
(102, 12, 11, 1),
(102, 1242, 11, 1),
(102, 15, 11, 1),

-- Juglans cinerea (174): Hepatic / Diuretic / Vermifuge → Anthelmintic
(174, 19, 11, 1),
(174, 14, 11, 1),
(174, 1242, 11, 1),

-- Rhamnus purshiana (205): Tonic / Laxative
(205, 33, 11, 1),
(205, 43, 11, 1),

-- Rheum palmatum (154): Cathartic → Laxative / Astringent
(154, 43, 11, 1),
(154, 8, 11, 1),

-- Rosmarinus officinalis (109): Nervine / Astringent / Diuretic
(109, 22, 11, 1),
(109, 8, 11, 1),
(109, 14, 11, 1),

-- Filipendula ulmaria (75): Stomachic → Digestive Tonic / Alterative / Diuretic
(75, 1248, 11, 1),
(75, 2, 11, 1),
(75, 14, 11, 1),

-- ============================================================
-- ORGAN REMEDIES: LIVER, GALL-BLADDER, PANCREAS (body_system 11 = Digestive)
-- ============================================================
-- Berberis vulgaris (158): Alterative / Antiseptic / Laxative
(158, 2, 11, 1),
(158, 5, 11, 1),
(158, 43, 11, 1),

-- Chelidonium majus (170): Alterative / Diuretic / Demulcent
(170, 2, 11, 1),
(170, 14, 11, 1),
(170, 13, 11, 1),

-- Chelone glabra (171): Cholagogue / Tonic / Vermifuge → Anthelmintic
(171, 12, 11, 1),
(171, 33, 11, 1),
(171, 1242, 11, 1),

-- Chionanthus virginicus (24): Cholagogue / Tonic / Diuretic
(24, 12, 11, 1),
(24, 33, 11, 1),
(24, 14, 11, 1),

-- Leptandra virginica (175): Cholagogue / Cathartic → Laxative / Antiseptic
(175, 12, 11, 1),
(175, 43, 11, 1),
(175, 5, 11, 1),

-- ============================================================
-- ORGAN REMEDIES: KIDNEYS AND BLADDER (body_system 12 = Urinary)
-- ============================================================
-- Equisetum arvense (151): Diuretic / Stimulant / Tonic / Astringent
(151, 14, 12, 1),
(151, 29, 12, 1),
(151, 33, 12, 1),
(151, 8, 12, 1),

-- Arctostaphylos uva-ursi (46): Astringent / Tonic / Antiseptic
(46, 8, 12, 1),
(46, 33, 12, 1),
(46, 5, 12, 1),

-- ============================================================
-- ORGAN REMEDIES: GENITAL (body_system 13 = Reproductive)
-- ============================================================
-- Caulophyllum thalictroides (72): Nervine / Antispasmodic / Diuretic
(72, 22, 13, 1),
(72, 7, 13, 1),
(72, 14, 13, 1),

-- Mitchella repens (188): Tonic / Diuretic / Astringent
(188, 33, 13, 1),
(188, 14, 13, 1),
(188, 8, 13, 1),

-- Nymphaea odorata (2242): Demulcent / Antiseptic
(2242, 13, 13, 1),
(2242, 5, 13, 1),

-- Salix spp. (87): Nervine / Astringent [Anaphodisiac skipped]
(87, 22, 13, 1),
(87, 8, 13, 1),

-- Senecio aureus (1058): Diuretic / Emmenagogue
(1058, 14, 13, 1),
(1058, 15, 13, 1),

-- Serenoa repens (186): Diuretic / Sedative
(186, 14, 13, 1),
(186, 1259, 13, 1),

-- Viburnum prunifolium (94): Nervine / Antispasmodic / Astringent / Diuretic
(94, 22, 13, 1),
(94, 7, 13, 1),
(94, 8, 13, 1),
(94, 14, 13, 1)

ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
