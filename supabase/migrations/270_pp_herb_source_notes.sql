-- Priest & Priest (1982) herb source notes
-- Populates herb_source_notes with SPECIAL CHARACTERISTICS, INDIVIDUAL INDICATIONS,
-- and COMBINATIONS AND TECHNIQUE for all PP herbs matched in DB.
-- Also adds source_id column to herb_primary_actions.
-- source_id = 1 (priest_priest)

SET search_path TO herbal, public;

ALTER TABLE herbal.herb_primary_actions
  ADD COLUMN IF NOT EXISTS source_id INTEGER REFERENCES herbal.sources(id);

CREATE INDEX IF NOT EXISTS herb_primary_actions_source_id_idx
  ON herbal.herb_primary_actions (source_id);

INSERT INTO herbal.herb_source_notes (herb_id, source_id, section_type, content) VALUES

-- ============================================================
-- GENERAL STIMULANTS
-- ============================================================

-- Capsicum annuum (47)
(47, 1, 'special_characteristics',
'Vaso-motor and neural stimulant. Stimulates the heart and increases arterial force and frequency.
Centrifugal action extending to capillaries. Indicated where reaction is tardy and there is general lethargy.
Increases secretory and motor activity of gastro-intestinal system.
Rubefacient and vaso-dilator (topical).'),
(47, 1, 'individual_indications',
'Colds, chills, congestion — very sensitive to cold and damp.
Cold extremities with cyanosis.
Rheumatism, lumbago, neuralgia.
Shock of injury, cold sweats.
Nervous depression.
Delirium tremens.
Uterine and ovarian congestion.
Sprains, bruises, joint pains.'),
(47, 1, 'combinations_technique',
'Generally give small frequent doses for cumulative reaction.
With Cinnamomum spp. and Syzygium aromaticum.
In very small doses + nervines.
Lobelia renders more diffusive.
As liniment with Lobelia.'),

-- Myrica cerifera (119)
(119, 1, 'special_characteristics',
'Positive diffusive stimulant — assures circulation and eliminative organs.
Indicated for a soft, compressible pulse and peripheral laxity.
For heavy catarrhal states of mucous membranes; removes thick, viscid secretions from gastro-intestinal tract.
Positive influence upon the uterus and the venous system.'),
(119, 1, 'individual_indications',
'Colds and acute febrile reactions.
Scrofulous, tuberculous tendency.
Pulmonary.
Haemorrhoids.
Leucorrhoea, atonic mucosa.
Gastro-intestinal catarrh.
Nasal polyp.'),
(119, 1, 'combinations_technique',
'As Elix. Myrica comp. to generate heat and induce perspiration.
As douche.
Powdered herb as snuff.'),

-- Zanthoxylum americanum (123)
(123, 1, 'special_characteristics',
'Chronic rheumatic conditions.
Neurasthenia — poor assimilation.
Gastric distension, eructations and flatulence.
Loss of sensitivity in injured nerves.'),
(123, 1, 'individual_indications',
'Chronic rheumatic conditions.
Neurasthenia — poor assimilation.
Gastric distension, eructations and flatulence.
Loss of sensitivity in injured nerves.'),
(123, 1, 'combinations_technique',
'With Phytolacca.'),

-- Zingiber officinale (124)
(124, 1, 'special_characteristics',
'Gentle diffusive stimulant for simple atony of alimentary organs and circulation.
Gentle diffusive effects suitable for children and the elderly.'),
(124, 1, 'individual_indications',
'Colds and chills.
Flatulence and internal congestion, painful alimentary spasms.
Diarrhoea from over-relaxation.'),
(124, 1, 'combinations_technique',
'As initial stimulant diaphoretic.'),

-- ============================================================
-- GENERAL RELAXANTS
-- ============================================================

-- Lobelia inflata (132)
(132, 1, 'special_characteristics',
'General systemic relaxant with diffusive stimulation — best where arterial action is strong. Equalises circulation and relieves vascular tension.
More stimulant — increases the activity of vegetative processes.
Influences glandular system and respiratory tubuli.
Contra-indicated in nervous prostration, shock and paralysis. Of brief continuance in asthenic conditions.'),
(132, 1, 'individual_indications',
'Dislocations, trauma, hernias.
Spasmodic and membranous croup, pertussis, bronchial asthma, bronchitis, pleurisy.
Hepatitis, jaundice, nausea, vomiting.
Convulsions.
High blood pressure, intestinal obstruction, neurasthenia.
Sprains, boils, swollen joints.'),
(132, 1, 'combinations_technique',
'To relax tension and spasm, add more or less stimulation.
As Syr. Lobel. acet. (Lobelia inflata syrup).
As emetic.
With Caulophyllum.
As enema: Lobelia 1, Nepeta 2 (4 dr. powder to 3 pints water).
As local plaster with Capsicum.'),

-- Dioscorea villosa (74)
(74, 1, 'special_characteristics',
'Autonomic nerve relaxant, especially suitable for gastro-intestinal conditions, vegetative neuroses and hyperesthesias.
Rheumatic syndromes arising from hepatic and intestinal dysfunction.'),
(74, 1, 'individual_indications',
'Bilious colic, flatulence, gastro-intestinal irritation.
Neuralgic conditions.
Dysmenorrhoea, uterine pains.
Nervousness, restlessness and pains of pregnancy.'),
(74, 1, 'combinations_technique',
'With Valeriana + Cimicifuga.
With Viburnum opulus + Mitchella.'),

-- Asclepias tuberosa (67)
(67, 1, 'special_characteristics',
'Peripheral and capillary relaxant: influences a flow towards the surface.
Autonomic stimulant: slows heartbeat, increases volume and frequency of respiration.
Influences skin, mucous and serous structures.'),
(67, 1, 'individual_indications',
'Catarrhal complaints from cold and damp: hard, dry cough.
Bronchitis, pleurisy, peritonitis.
Pneumonia.
Influenza.
Intercostal rheumatism.
Eruptive diseases.'),
(67, 1, 'combinations_technique',
'With Lobelia + Zingiber.
With Dioscorea + Zingiber.
With Solidago + Zingiber.
With Ballota nigra.
Generally in hot infusion.'),

-- ============================================================
-- GENERAL ASTRINGENTS
-- ============================================================

-- Euphrasia spp. (51)
(51, 1, 'special_characteristics',
'Mild stimulating, astringent: vaso-constrictive vessels of small mucous and conjunctival mucous membranes.
Specific for congestive conditions of the eyes with profuse lachrymation.
Scrofulous eyes in children.'),
(51, 1, 'individual_indications',
'Catarrhal blepharitis, rhinitis, sinusitis and conjunctivitis.
Hay fever, acute coryza, irritable sneezing and lachrymation.
Rheumatic chorioditis and corneal opacity.'),
(51, 1, 'combinations_technique',
'Local bathing/douching with a weak decoction.
Locally, with Hydrastis.'),

-- Geranium maculatum (52)
(52, 1, 'special_characteristics',
'Positive tonic astringent for treatment of discharges due to over-relaxation.
Excessive mucous discharges, passive haemorrhages and ulceration of the alimentary mucous membranes.
Pulmonary and urogenital haemorrhages.'),
(52, 1, 'individual_indications',
'Catarrhal gastritis, summer diarrhoea, chronic dysentery.
Menorrhagia, metrorrhagia, post-partum haemorrhage, leucorrhoea, due to atonic conditions.
Bleeding wounds, teeth sockets.'),
(52, 1, 'combinations_technique',
'With Hydrastis. Oral and local.
Powdered root as local styptic.'),

-- Hamamelis virginiana (79)
(79, 1, 'special_characteristics',
'Mild, diffusive, cleansing astringent.
Passive haemorrhages of pulmonary, gastro-intestinal and genital organs.
Bruised soreness of affected parts, especially from relaxed conditions.
Venous congestion, atony or laxity.'),
(79, 1, 'individual_indications',
'Diarrhoea and dysentery.
Protruding, bleeding haemorrhoids.
Vulval bruising after childbirth.
Vaginal laxity with tenderness.
Inflamed sore throat.
Varicose veins.
Sore and bloodshot eyes.'),
(79, 1, 'combinations_technique',
'With Ulmus rubra.
With Calendula or Stellaria.
Locally as compresses or cream with Calendula.'),

-- Rubus idaeus (155)
(155, 1, 'special_characteristics',
'Mild, soothing, astringent tonic — allays nausea, sustains the nerves and tones the mucous membranes.
Preparatory parturient (contra-indicated where there is a history of precipitate labour).'),
(155, 1, 'individual_indications',
'Acute and chronic dysentery.
Summer diarrhoea in children.
Uterine haemorrhage, menorrhagia.
Leucorrhoea.
Ophthalmia.
Sore throat and hoarseness.'),
(155, 1, 'combinations_technique',
'Oral and rectal injection.
With Myrica or Hydrastis.
As douche of the weak decoction.
As lotion with Hamamelis.
As gargle with dilute Acetum.'),

-- Salvia officinalis (56)
(56, 1, 'special_characteristics',
'Carminative, stimulating astringent-expectorant: suitable for weak, pale, atonic patients.
Cold preparations check excessive perspiration from circulatory debility.'),
(56, 1, 'individual_indications',
'Gastric debility and flatulence.
Night sweats.
Sore, ulcerated throat.'),
(56, 1, 'combinations_technique',
'As gargle with Commiphora myrrha (Tr. Myrrh), or honey and raspberry vinegar.'),

-- ============================================================
-- ALTERATIVES
-- ============================================================

-- Arctium lappa (22)
(22, 1, 'special_characteristics',
'General alterative: influences skin, kidneys, mucous and serous membranes, to remove accumulated waste products.
Specific for eruptions on the head, face and neck, and for acute irritable and inflammatory conditions.'),
(22, 1, 'individual_indications',
'Eczema, psoriasis, dermatitis.
Boils, carbuncles, styes, sores.
Rheumatism, gout and sciatica.
Vaginal tissue laxity.'),
(22, 1, 'combinations_technique',
'Oral and topical — with Rumex crispus.
Generally prefer the seeds for skin diseases and scrofulous conditions.
Combine with Zingiber for diffusive effects; Hydrastis for tonic effects.'),

-- Baptisia tinctoria (23)
(23, 1, 'special_characteristics',
'Stimulating antiseptic alterative: specific for septic conditions with ulceration and tissue degeneration.
Influences the glandular system and both sides of metabolism.
Suitable for atonic conditions.'),
(23, 1, 'individual_indications',
'Ulcerative colitis, amoebic dysentery, intestinal toxaemia.
Tonsillitis and quinsy.
Erosion of cervix.
Surface ulceration.
After typhoid inoculations.'),
(23, 1, 'combinations_technique',
'With Commiphora myrrha (Myrrha) for offensive secretions and putrescence.
As gargle with Phytolacca americana (as eructant preparation).
As local tampon with Calendula.
As poultice with Ulmus rubra.'),

-- Echinacea angustifolia (221)
(221, 1, 'special_characteristics',
'Stimulating alterative: promotes suppuration and increases natural resistance to infections.
Specific for endotoxaemia, cotoxaemia, toxaemic and cancerous cachexia, and malignant degeneration of acute toxic conditions.'),
(221, 1, 'individual_indications',
'Septic infections, septicaemia.
Furunculosis, carbuncles.
Ulcerative pharyngitis, tonsillitis and stomatitis.
Eczema from blood conditions.
Gastric and duodenal ulcers.
Enteritis.'),
(221, 1, 'combinations_technique',
'Oral, and local poultices.
As gargle or spray.
With Baptisia + Hydrastis.
With Hydrastis, antiseptic.
To control putrefactive changes.'),

-- Fucus vesiculosus (118)
(118, 1, 'special_characteristics',
'Gently stimulating alterative: suited to cold, torpid and fatty conditions.
Influences mucous and serous membranes, lymphatics and thyroid gland.
Improves nutrition in supplying trace elements, iodine and minerals.'),
(118, 1, 'individual_indications',
'Hypothyroid obesity, myxoedema.
Plethoric dropsy (fluid imbalance).
Rheumatism and arthritis (associated with emotional shock or thyroid disturbance).'),
(118, 1, 'combinations_technique',
'Commence with small dose and gradually increase.'),

-- Iris versicolor (31)
(31, 1, 'special_characteristics',
'Positive alterative for chronic, torpid conditions: influences the glandular system, lymphatics, liver and gall ducts, and intestinal glands.
Vaso-constrictor to the mesenteric circulation.
Indicated for hepatic congestion due to venous or lymphatic stasis.'),
(31, 1, 'individual_indications',
'Chronic hepatic and rheumatic conditions, toxic sciatica.
Scrofulous skin conditions, herpes, eczema, psoriasis.
Enlarged thyroid gland.
Uterine fibroids.'),
(31, 1, 'combinations_technique',
'Iris is an excellent alterative addition to hepatic preparations.
With Hydrastis and Chelone.'),

-- Phytolacca americana (35)
(35, 1, 'special_characteristics',
'Stimulating and relaxing alterative: promotes the removal of catabolic wastes and the products of fatty degeneration.
Specific for skeletal compositions, and for serous and glandular tissues.'),
(35, 1, 'individual_indications',
'Chronic rheumatism and arthritis, neuralgia and lumbago.
Tonsillitis and parotids.
Mastitis, mammary congestion.
Ovaritis, orchitis.
Enlarged thyroid and lymphatics.'),
(35, 1, 'combinations_technique',
'With Cimicifuga + Xanthoxylum.
Oral and gargle — with Commiphora myrrha.
As poultice, liniment or plaster.'),

-- Rumex crispus (37)
(37, 1, 'special_characteristics',
'General tonic alterative with special influence upon skin eruptions.
Natural source of iron salts.'),
(37, 1, 'individual_indications',
'Simple deficiency anaemia.
Eczema, psoriasis, urticaria.
Prurigo.
Itching haemorrhoids.'),
(37, 1, 'combinations_technique',
'With Taraxacum officinale syrup.
Oral, and local suppository.'),

-- Scrophularia nodosa (39)
(39, 1, 'special_characteristics',
'Gently stimulating and relaxing alterative with lower abdominal and pelvic emphasis.
Deobstruent to enlarged and engorged lymph glands.'),
(39, 1, 'individual_indications',
'Chronic skin diseases, eczema and psoriasis.
Mammary tumours and nodosities, enlarged glands.
Haemorrhoids.'),
(39, 1, 'combinations_technique',
'Combine with hepatics and stimulating diuretics.
With Phytolacca, Iris.
Local ointment of herb digested in a suitable base.'),

-- ============================================================
-- GENERAL TONICS
-- ============================================================

-- Agrimonia eupatoria (148)
(148, 1, 'special_characteristics',
'Gently stimulating tonic with gastro-intestinal emphasis: suitable for infants and the elderly.
Influences mucous membranes, promotes assimilation, and restores debilitated conditions.'),
(148, 1, 'individual_indications',
'General alimentary weakness, murmurs, hepatic atrophy.
Enuresis (atonic), relaxed bowel, leucorrhoea (relaxed states); urinary incontinence.
Rheumatism and arthritis.'),
(148, 1, 'combinations_technique',
'Combine according to location: Intestinal — with hepatics; Generative — with uterine tonics; Bronchi — with pectorals; Bladder — with Capsella bursa-pastoris.
With Chelone.'),

-- Stachys officinalis (207)
(207, 1, 'special_characteristics',
'Gently stimulating tonic with emphasis upon the cerebral circulation.
Increases excitation of nerve supply.
Especially indicated for neuralgic and ischaemic conditions affecting the head.'),
(207, 1, 'individual_indications',
'Gastralgia, dyspepsia.
Chronic rheumatism and sciatica.
Phrenitis, ischaemic headache.
Hysteria, pains in the head and face, neuralgia.
Lack of concentration, forgetful.'),
(207, 1, 'combinations_technique',
'With Cimicifuga + Scutellaria.
With Cimicifuga for sclerotic changes.
With Rosmarinus or Silybum marianum.'),

-- Cola acuminata (150)
(150, 1, 'special_characteristics',
'Cerebro-spinal stimulating tonic and trophorestorative: counters fatigue, increases respiration and stimulates voluntary muscles.
Suitable for neuromuscular hypotension arising from illness or depression.'),
(150, 1, 'individual_indications',
'Neurasthenic, melancholia.
Chronic neuralgia.
Convalescence.
To sustain physical and mental exertions.'),
(150, 1, 'combinations_technique',
'Adjunctive to Betonica (Stachys officinalis).
With Pulsatilla.
Use small doses for cumulative influence as restorative.'),

-- Hydrastis canadensis (30)
(30, 1, 'special_characteristics',
'Mild, positive, permanently stimulating vaso-tonic: with especial influence upon the portal system, entire venous system and right heart.
Trophorestorative to mucous membranes when irritated, inflamed or ulcerated.'),
(30, 1, 'individual_indications',
'Catarrhal conditions of mucous membranes — especially gastritis.
Orificial soreness or discharge, conjunctivitis, keratitis, tonsillitis, pharyngitis, vaginitis, cervicitis (topical).'),
(30, 1, 'combinations_technique',
'Combine according to location: Gastro-intestinal — Juglans/Leptandra; Renal — Eupatorium purpureum; Genital — Mitchella; Portal — with hepatics.'),

-- Populus tremuloides (86)
(86, 1, 'special_characteristics',
'Bitter tonic for all general uses. Especially for post-febrile debility.
Stimulates appetite and aids digestion.
Suitable for the elderly.'),
(86, 1, 'individual_indications',
'Dyspepsia, flatulence (debility).
Uterine, vaginal, and weakness.
Diarrhoea, dysentery (atonic).
Catarrh of the bladder.'),
(86, 1, 'combinations_technique',
'With Capsella bursa-pastoris or Arctostaphylos uva-ursi.'),

-- ============================================================
-- NERVINES
-- ============================================================

-- Pulsatilla vulgaris (36)
(36, 1, 'special_characteristics',
'Stimulating and relaxing nervine with especial reference to the organs of special sense.
Stimulates gastro-intestinal and hepatic functions.'),
(36, 1, 'individual_indications',
'Functional neuroses: heart and pelvic organs.
Vasomotor instability, dysmenorrhoea.
Amenorrhoea, leucorrhoea, menopausal flushes.
Nervous exhaustion, neurasthenia.
Neural irritation, head neuralgia.
Catarrhal ophthalmic.
Catarrhal otitis.'),
(36, 1, 'combinations_technique',
'With Cimicifuga/Aletris farinosa.
With Viburnum opulus / Viburnum prunifolium.
With Euphrasia.
With Verbascum.'),

-- Avena sativa (178)
(178, 1, 'special_characteristics',
'Gently stimulating nervine tonic and general trophorestorative, especially for weakly and anaemic conditions.
Indicated for reflex nervous irritation from other disorders.'),
(178, 1, 'individual_indications',
'Irritation and depression with dysmenorrhoea.
Hysteria, insomnia.
Neurasthenia and neuroses.
Nervous exhaustion and debility from chronic disease.'),
(178, 1, 'combinations_technique',
'With Aletris farinosa or Mitchella.
Frequent doses at short intervals.
With Scutellaria.'),

-- Actaea racemosa (25)
(25, 1, 'special_characteristics',
'Stimulating and relaxing diffusive nervine, meningeal relaxant and cerebrospinal trophorestorative.
Influences autonomic activity: increase of secretory and peristaltic action.
Trophorestorative to pelvic viscera.
Especially indicated for spasmodic symptoms of toxic origin.'),
(25, 1, 'individual_indications',
'Muscular and crampy pains, general spasticity, flatulence.
Pertussis, asthma, chorea.
Rheumatism, sciatica, neuralgia, rheumatoid arthritis.
Atonic uterus, ovarian neuralgia, leucorrhoea, dysmenorrhoea.
Tinnitis aurium.'),
(25, 1, 'combinations_technique',
'With Cypripedium + Caulophyllum.
With Xanthoxylum.
With Leonurus and tonics.
With Cinchona officinalis or Xanthoxylum.'),

-- Humulus lupulus (129)
(129, 1, 'special_characteristics',
'Stimulating and relaxing nervine cerebrospinal trophorestorative.
Toxic relaxant to the nervous system, especially used for cerebral and biliary/gall ducts.
Allays irritation and promotes sleep.'),
(129, 1, 'individual_indications',
'Hysteria, dysmenorrhoea.
Nervous exhaustion.
Nymphomania.
Facial and brachial neuralgia.
Local inflammatory and irritable conditions.'),
(129, 1, 'combinations_technique',
'With Valeriana.
With hepatic tonics.
As poultice.'),

-- Hypericum perforatum (81)
(81, 1, 'special_characteristics',
'Sedative nervine for muscular twitching and choreiform movements: especially indicated for nerve injuries to the extremities and teeth/gums.
Promotes elimination of catabolic waste products.'),
(81, 1, 'individual_indications',
'Painful injuries to sacral spine and coccyx. Traumatic shock.
Haemorrhoids with pain bleeding.
Facial neuralgia after dental extractions, toothache.'),
(81, 1, 'combinations_technique',
'Massage face with diluted oil.'),

-- Matricaria recutita (84)
(84, 1, 'special_characteristics',
'Stimulating nervine: indicated for conditions of neural irritability with sthenic background.'),
(84, 1, 'individual_indications',
'Flatulence, colic, abdominal distension and spasms.
Premenstrual irritability and spasmodic dysmenorrhoea.
Infantile convulsions from colic, teething, earache, etc.'),
(84, 1, 'combinations_technique',
'(none listed)'),

-- Passiflora incarnata (137)
(137, 1, 'special_characteristics',
'Relaxing nervine, cerebral vasodilator and trophorestorative.
Indicated for conditions of agitation and exhaustion with muscular twitching.'),
(137, 1, 'individual_indications',
'Mild convulsive or tremulous states — unrest and agitation.
Restlessness and wakefulness in infants and the elderly.
Childhood convulsions, spasms and teething.'),
(137, 1, 'combinations_technique',
'With Humulus.'),

-- Scutellaria lateriflora (142)
(142, 1, 'special_characteristics',
'Diffusive, stimulating and relaxing nervine — cerebral vasodilator and trophorestorative.
Indicated for nervous irritation of the cerebrospinal nervous system.'),
(142, 1, 'individual_indications',
'Functional nervous exhaustion, postfebrile nervous weakness.
Chorea, hysteria, agitation and epileptiform convulsions.
Insomnia, nightmares, restless sleep.'),
(142, 1, 'combinations_technique',
'With Pulsatilla or Cimicifuga.
With Passiflora.'),

-- Turnera diffusa (144)
(144, 1, 'special_characteristics',
'Stimulating tonic nervine and spinal trophorestorative with especial influence upon the generative system.'),
(144, 1, 'individual_indications',
'Frigidity, impotence, senile decline.
To establish normal menstruation at puberty.
Anxiety neurosis.'),
(144, 1, 'combinations_technique',
'With Scutellaria.'),

-- Valeriana officinalis (145)
(145, 1, 'special_characteristics',
'Soothing, diffusive, relaxing and stimulating nervine.
Indicated for states of nervous irritation, and to support atonic and functional nervous disorders.'),
(145, 1, 'individual_indications',
'Nervous excitability.
Nervous insomnia.
Nervous palpitations.
Flatulent colic, abdominal cramp, gastrodyna, diarrhoea.
Menopausal dysfunction, retarded and scanty menstruation.
Nervousness of children, chorea.'),
(145, 1, 'combinations_technique',
'With Passiflora. With Humulus. With Convallaria.
With Dioscorea and Zingiber. With Pulsatilla.'),

-- Verbena officinalis (146)
(146, 1, 'special_characteristics',
'Relaxing and stimulating nervine with especial influence on hepatic and renal autonomic function.
Indicated for catarrhal conditions of gastro-intestinal and auxiliary organs.'),
(146, 1, 'individual_indications',
'Nervous depression and weakness convalescence and debility.
Acute catarrhs of bronchitis and pertussis.
Amenorrhoea, dysmenorrhoea and difficult menstruation.'),
(146, 1, 'combinations_technique',
'(none listed)'),

-- Viburnum opulus (93)
(93, 1, 'special_characteristics',
'Relaxing and stimulating nervine, cerebrospinal vaso-stimulant.
Restores sympathetic/parasympathetic balance — has a specific action to relieve voluntary and involuntary muscular spasms.'),
(93, 1, 'individual_indications',
'Colicky pains and spasms of tubular organs: gastro-intestinal and genito-urinary.
Atonic conditions of pelvic organs: menses scanty and delayed.'),
(93, 1, 'combinations_technique',
'With Dioscorea.'),

-- Viscum album (211)
(211, 1, 'special_characteristics',
'Stimulating and relaxing nervine.
Motor and vasomotor relaxant to gastro-intestinal and genito-urinary functions from parasympathetic action.'),
(211, 1, 'individual_indications',
'Metrorrhagia, post-partum haemorrhage, endometritis.
Congestive headache, hypertension and cardiac hypertrophy.
Rheumatic and gouty syndromes, neuralgia and sciatica.'),
(211, 1, 'combinations_technique',
'With Crataegus and Tilia platyphyllos.'),

-- ============================================================
-- DIURETICS
-- ============================================================

-- Agathosma betulina (181)
(181, 1, 'special_characteristics',
'Diffusive, stimulating and toning diuretic: indicated for the first stage of acute febrile reactions.
For atonic and relaxed tissues where there is free discharge or passive haemorrhage of bright red blood.
Cold preparations stimulate the appetite and tone the digestive organs.'),
(181, 1, 'individual_indications',
'Dropsical conditions, gravel.
Chronic atonic conditions.
Mucopurulent discharge, gleet, cystitis, urethritis.
Vesico-renal irritations in the elderly.
Pelvic congestion.'),
(181, 1, 'combinations_technique',
'With Juniperus for greater stimulation.
With Althaea as demulcent.
With uterine tonics.'),

-- Galium aparine (28)
(28, 1, 'special_characteristics',
'Mild, relaxing and diffusive diuretic: increases aqueous excretion, corrects inability to pass normal catabolic wastes, and relieves irritation.
Preferred diuretic for exanthemas.'),
(28, 1, 'individual_indications',
'Dropsy, renal obstructions.
Bladder stone, gravel, calculi.
Scalding micturition, dysuria, irritable bladder, cystitis.
Enuresis in children.
Skin eruptions, eczema, psoriasis.'),
(28, 1, 'combinations_technique',
'With Agathosma betulina or Arctostaphylos uva-ursi.
With Althaea as demulcent.'),

-- Juniperus communis (103)
(103, 1, 'special_characteristics',
'Stimulating diuretic: indicated for renal torpidity and scanty secretion of urine in the elderly.
Produces renal vaso-dilation. Contra-indicated in the young.
Indicated for frequency of micturition due to atonic conditions.'),
(103, 1, 'individual_indications',
'Dropsy from renal suppression.
Cystic catarrh, renal congestion.
Atonic amenorrhoea, dysmenorrhoea from sluggish conditions.
Rheumatic pain in muscles and joints, gout, sciatica.'),
(103, 1, 'combinations_technique',
'Use small dosages, and combine with Althaea, Arctostaphylos uva-ursi, etc. to counter irritability.
Oral, and local liniment of oil.'),

-- Zea mays (95)
(95, 1, 'special_characteristics',
'Soothing and toning demulcent diuretic, suitable for conditions in children.
Frees the circulation of urea and relieves cystic irritation arising from excess of urates and phosphates.'),
(95, 1, 'individual_indications',
'Renal/cystic inflammatory states.
Enuresis.
Ammonia in the urine in infants.
Enlarged prostate with retention or suppression of urine.'),
(95, 1, 'combinations_technique',
'Always with Althaea.
With Agrimonia + Capsella bursa-pastoris.'),

-- ============================================================
-- DIAPHORETICS
-- ============================================================

-- Achillea millefolium (44)
(44, 1, 'special_characteristics',
'Mild, slow and stimulating diaphoretic: indicated for the first stage of acute febrile reactions.
For atonic and relaxed tissues where there is free discharge or passive haemorrhage of bright red blood.
Cold preparations stimulate the appetite and tone the digestive organs.'),
(44, 1, 'individual_indications',
'Acute stage of colds, influenza and respiratory catarrh.
Chronic diarrhoea and dysentery.
Epistaxis, intestinal haemorrhage and bleeding haemorrhoids.
Uterine haemorrhage, profuse and protracted menstruation.
Leucorrhoea, vaginal laxity.'),
(44, 1, 'combinations_technique',
'In hot infusion — with Sambucus and Myrica.
With Mentha piperita / Trifolium pratense.
Cold preparations.
With Capsella bursa-pastoris. With uterine tonics.'),

-- Eupatorium perfoliatum (50)
(50, 1, 'special_characteristics',
'Stimulating, tonic and antispasmodic diaphoretic: indicated for influenzal epidemics and febrile conditions arising in marshy districts.
Acts upon the gastro-hepatic organs and promotes secretion and excretion of bile.'),
(50, 1, 'individual_indications',
'Influenza colds and fevers with night sweats and aching bones.
Pulmonary inflammation/catarrh with cough and chest soreness.
Post-influenzal gastric irritation with biliousness/constipation.
Skin diseases and eruptive fevers of hepatic origin.'),
(50, 1, 'combinations_technique',
'With Achillea for first stage and Pulsatilla during third stage.
With Asclepias and Inula.
With Chelone and Juglans cinerea syrup.
With stimulants.'),

-- Nepeta cataria (136)
(136, 1, 'special_characteristics',
'Relaxing and diffusive nervine: produces free perspiration without increasing internal heat.
Influences the circulation, soothes the nervous system, relieves irritation.
Especially suitable for conditions in infants and children.'),
(136, 1, 'individual_indications',
'Childhood fevers.
Flatulent colic, abdominal congestion, colonic pain and invagination.
Restlessness, nervous irritation.
Functional menstrual disturbances, amenorrhoea and dysmenorrhoea.
Convulsions, hysteria, insomnia.'),
(136, 1, 'combinations_technique',
'With Zingiber as required.
Rectal injections of a weak infusion with Dioscorea.
With Matricaria.'),

-- Sambucus nigra (57)
(57, 1, 'special_characteristics',
'Mild diffusive and relaxing diaphoretic with alterative properties: indicated for children subject to frequent febrile reactions.
Soothing to tubuli: influences nervosa, soothes the mucous membrane.
Relaxing to the eliminative organs, soothing to the nervous system and gently laxative.'),
(57, 1, 'individual_indications',
'Colds/fevers with dry, hot skin.
Chronic nasal catarrh/sinusitis.
Dry coryza, spasmodic croup.
Weakening night sweats.
Skin eruptions from metabolic disturbance, eczema, dermatitis.'),
(57, 1, 'combinations_technique',
'With Achillea and Pulsatilla.
With Trifolium pratense. With Salvia.
Excellent addition to alteratives.'),

-- ============================================================
-- DEMULCENTS
-- ============================================================

-- Althaea officinalis (45)
(45, 1, 'special_characteristics',
'Soothing demulcent: indicated for inflamed and irritated states of mucous membranes.
Particularly suitable for the elderly with chronic inflammatory conditions affecting the gastro-intestinal system or genito-urinary tract.'),
(45, 1, 'individual_indications',
'Acute respiratory disease.
Gastro-intestinal ulcer, cystitis, urethritis.
Inflammation of mouth and throat.
Inflamed haemorrhoids, ophthalmia.
Inflamed and gangrenous wounds.
Burns and scalds. Bedsores. Abscesses, boils, ulcers.'),
(45, 1, 'combinations_technique',
'As demulcent syrup to support pectorals and expectorants.
Cold water infusion with aqueous Calendula/Hydrastis as a drink.
Infusion with Commiphora myrrha as gargle.
Compresses of decoction. With Ulmus as poultice.
Dressing of paste with Ol. lini. Poultice or ointment.'),

-- Symphytum officinale (89)
(89, 1, 'special_characteristics',
'Soothing demulcent: gently stimulating tonic to the mucous membrane, allays irritation and stimulates cell growth (allantoin content).
Increases expectoration and tones the bronchi, especially suitable for conditions involving capillary haemorrhage or excessive mucus.'),
(89, 1, 'individual_indications',
'Coughs and colds.
Gastric and duodenal ulcer.
Gastro-intestinal inflammation.
Haematemesis.
Chronic suppurative ulcerations.
Bruised and damaged joints and muscles, pulled tendons.
Delayed union of fractures.
Traumatic injury to the eye.'),
(89, 1, 'combinations_technique',
'Valuable addition to cough syrups.
With aqueous Hydrastis. With aqueous Calendula.
Local compresses. Chronic: poultice or ointment.
Infusion of the leaves or plaster of the powdered root.
Local plaster. Local compresses of decoction.'),

-- Ulmus rubra (92)
(92, 1, 'special_characteristics',
'The best demulcent for internal and external use: lubricates and soothes the alimentary mucosa, relieves intestinal irritation, and quietens the nervous system.'),
(92, 1, 'individual_indications',
'Acute gastric and duodenal ulcer, gastritis, gastric weakness.
Diarrhoea, dysentery, enteritis.
Inflammation of mouth and throat. Vaginitis.
Burns, scalds, abrasions.
Haemorrhoids, orificial fissures. Varicose ulcers.
Abscesses, boils, carbuncles. Inflamed wounds and ulcers.
Swollen glands.'),
(92, 1, 'combinations_technique',
'As gruel of the powdered bark.
Infusion as rectal injection.
Infusion as mouthwash or gargle.
Dressing of paste with Ol. lini. Compresses of mucilage.
Poultice — free of pus. Poultice or ointment.
Poultice — with Althaea/Lobelia. Poultice — with Phytolacca rad.'),

-- ============================================================
-- ORGAN REMEDIES: HEART
-- ============================================================

-- Convallaria majalis (163)
(163, 1, 'special_characteristics',
'Cardiac tonic and ganglionic trophorestorative: increases coronary circulation and myocardial action.
Suitable for all cases of cardiac disturbances, but especially indicated in conditions of incipient decompensation.'),
(163, 1, 'individual_indications',
'Acute heart failure with oedema.
Dyspnoea, orthopnoea, anaemia.
Congestive heart failure.
Cardiac asthma, anginal syndromes.
Endocarditis.
Mitral insufficiency, dilatation.'),
(163, 1, 'combinations_technique',
'Tinct. Convallaria flor.
With Leonurus.
With Echinacea and/or Phytolacca.'),

-- Crataegus spp. (73)
(73, 1, 'special_characteristics',
'Cardiac tonic trophorestorative: increases and sustains action of heart muscle in elderly.
Improves coronary circulation, restores myocardial reserve, and regulates disturbances of rhythm.'),
(73, 1, 'individual_indications',
'Myocardial degeneration and/or coronary sclerosis in elderly.
Hypertension.
Cardiac weakness after infections.
Acute myocardial insufficiency.
Tachycardia, extra-systoles.
Angina, palpitation, vertigo.
Fatty degeneration, hypertrophy.'),
(73, 1, 'combinations_technique',
'With sufficient Cactus grandiflorus/Capsicum to sustain function.
With Viscum-Tilia platyphyllos-Scutellaria.
Following Digitalis purpurea therapy.
With Convallaria/Pulsatilla.'),

-- Leonurus cardiaca (131)
(131, 1, 'special_characteristics',
'Diffusive, stimulating and relaxing, antispasmodic nervine: indicated for reflex conditions affecting cardiac function, and as a simple cardiac tonic.
Influences pre-menstrual nerve tension and muscular rigidity.'),
(131, 1, 'individual_indications',
'Anaemic nervousness and insomnia.
Chlorotic hysteria/palpitation.
Cardiac debility, tachycardia.
Cardiac and vegetative neuroses.
Hyperthyroid cardiac reactions.
Pre-menstrual tension, congestive amenorrhoea or dysmenorrhoea.'),
(131, 1, 'combinations_technique',
'With Senecio/Mitchella. With alteratives.
With Aletris farinosa/Pulsatilla.
With Convallaria/Melissa officinalis.
With Lycopus spp. With Caulophyllum/Zingiber.'),

-- ============================================================
-- ORGAN REMEDIES: PULMONARY
-- ============================================================

-- Inula helenium (54)
(54, 1, 'special_characteristics',
'Gently stimulating tonic expectorant for chronic catarrhal conditions: warming and cleansing to pulmonary mucous membranes.
Indicated for chronic pectoral conditions.'),
(54, 1, 'individual_indications',
'Bronchial and gastric catarrh.
Chronic bronchitis, tuberculosis.
Pneumoconiosis, silicosis.
Pertussis. Emphysematous conditions.
Chronic cough in the elderly.'),
(54, 1, 'combinations_technique',
'With Symphytum. With demulcents.
With Trifolium pratense. With Sticta pulmonaria.'),

-- Lycopus spp. (133)
(133, 1, 'special_characteristics',
'Aromatic and toning astringent, tonic and slowly stimulating in the mucous membrane. Has a specific pulmonary influence, equalises the circulation and balances the autonomic nervous system.
Vascular sedative and haemostatic.'),
(133, 1, 'individual_indications',
'Phthisis with free expectoration.
Passive haemorrhages: epistaxis, haemoptysis.
Chronic circulatory.
Hyperthyroid conditions, nervous tachycardia and palpitation.'),
(133, 1, 'combinations_technique',
'With Inula/Symphytum.
With Convallaria.'),

-- Marrubium vulgare (160)
(160, 1, 'special_characteristics',
'Gently diffusive tonic expectorant: relieves hyperaemia and congestion, decreases discharge where secretion is too free.'),
(160, 1, 'individual_indications',
'Colds, bronchitis, catarrh.
Asthma, with moist expectoration, aphonia and dyspnoea.
Catarrhal dyspepsia.'),
(160, 1, 'combinations_technique',
'With Inula or Prunus.
Cold infusion as a general tonic.'),

-- Prunus serotina (140)
(140, 1, 'special_characteristics',
'Mild, soothing, stimulating astringent: tonic expectorant for acute irritable coughs, quietens nervous irritability and relieves arterial excitement.
Sedative for conditions of prolonged irritation.'),
(140, 1, 'individual_indications',
'Chronic bronchitis with debility.
Catarrhal dyspepsia, weak digestion in the elderly.
Chronic diarrhoea. Weak throat. Ophthalmia.'),
(140, 1, 'combinations_technique',
'With Myrica as decoction.
With Solidago as throat pastille.
As lotion to soothe and tone.'),

-- Pulmonaria officinalis (200)
(200, 1, 'special_characteristics',
'Demulcent pectoral tonic for general pulmonary conditions where a gentle tonic is required.'),
(200, 1, 'individual_indications',
'Coughs, colds, influenza.
Bronchial and catarrhal states.
Inflammation of throat or lungs.'),
(200, 1, 'combinations_technique',
'(none listed)'),

-- Solidago virgaurea (58)
(58, 1, 'special_characteristics',
'Stimulating and slightly astringent tonic antiseptic to the mucous membrane. Specific for bronchial disease in the elderly. Suitable for bronchial disease in children.
Vaso-constricting: indicated for frequency of micturition due to atonic conditions.
Promotes renal flow of fluid.'),
(58, 1, 'individual_indications',
'Influenza, repeated colds.
Suppressed menstruation.
Pulmonary expectoration.
Naso-pharyngeal catarrh with sneezing and excessive mucus.
Acute/chronic nephritis with albuminaemia/haematuria.'),
(58, 1, 'combinations_technique',
'Acetous infusion as gargle.'),

-- Trifolium pratense (42)
(42, 1, 'special_characteristics',
'Mild, stimulating and relaxing antispasmodic: especially indicated for the throat and salivary glands.
Especially indicated for debilitated children with chronic bronchial or throat conditions.'),
(42, 1, 'individual_indications',
'Salivary gland congestion.
Spasmodic or croupy coughs.
Pertussis.
Pharyngeal inflammation/infection.
Chronic skin eruptions.'),
(42, 1, 'combinations_technique',
'With Lobelia inflata syrup (Syr. Lobel. acet.).
With Solidago as gargle.
With Arctium lappa root / Rumex.'),

-- Tussilago farfara (60)
(60, 1, 'special_characteristics',
'Diffusive expectorant, sedative and demulcent: suitable for debilitated and chronic conditions, especially where there is a tubercular tendency.'),
(60, 1, 'individual_indications',
'Chronic pulmonary conditions.
Chronic emphysema and silicosis.
Pertussis, asthma.'),
(60, 1, 'combinations_technique',
'With Inula/Verbascum.
To ease persistent cough.
Supportive as demulcent and expectorant.'),

-- Verbascum thapsus (61)
(61, 1, 'special_characteristics',
'Demulcent and alterative: soothing, relaxing and stimulating in pulmonary conditions.
Influences mucous, serous and glandular structures.'),
(61, 1, 'individual_indications',
'Paroxysmal laryngeal cough.
Irritable chronic bronchitis.
Pleurisy with exudation.
Hay fever, asthma.'),
(61, 1, 'combinations_technique',
'With Sambucus/Trifolium pratense.
With Grindelia camporum.'),

-- ============================================================
-- ORGAN REMEDIES: GASTRO-INTESTINAL
-- ============================================================

-- Mahonia aquifolium (33)
(33, 1, 'special_characteristics',
'Mildly stimulating tonic hepatic and alterative: influences alimentary mucous membrane, stimulates glandular elements and improves nutrition.
Promotes the elimination of catabolic residues and stimulates recuperation.'),
(33, 1, 'individual_indications',
'Catarrhal disorders of stomach, intestines and urinary organs.
Hepatic torpor, bilious headache.
Eczema, herpes, psoriasis, acne, facial blotches and pimples.'),
(33, 1, 'combinations_technique',
'With Rumex/Arctium lappa root.'),

-- Senna alexandrina (216)
(216, 1, 'special_characteristics',
'Intestinal ganglionic vaso-relaxant; specific influence upon lower bowel to restrict fluid reabsorption.
Excites colicky contractions.'),
(216, 1, 'individual_indications',
'To produce rapid catharsis.
Tonsillitis, diphtheria, eruptive diseases (from constipation).
Recurrent/intermittent fevers.
Acute haemorrhoids: to ease liver and gall-bladder function.'),
(216, 1, 'combinations_technique',
'Single full dose.
As first dose, and to abort development of condition.
Regulate to keep bowel free.
Small doses every 3 hours.'),

-- Collinsonia canadensis (182)
(182, 1, 'special_characteristics',
'Stimulates, cleanses and tones the alimentary mucous membrane — slightly astringent to the mucous membrane: suitable for catarrhal and atonic conditions.
Vaso-contracting to the portal system; indicated for frequency of micturition secondary to portal back-pressure and venous stasis.'),
(182, 1, 'individual_indications',
'Gastro-enteritis with diarrhoea.
Haemorrhoids.
Laryngeal inflammation/catarrh.
Influenza, acute/chronic pleural, colds and fevers.
Leucorrhoea.'),
(182, 1, 'combinations_technique',
'With Filipendula ulmaria / Rubus idaeus.
With Hydrastis/Commiphora myrrha.
With Hydrastis/Leptandra.'),

-- Gentiana lutea (102)
(102, 1, 'special_characteristics',
'Intense, bitter, stimulating tonic: influences digestive organs, mucous membranes, and the portal circulation.
Specific action upon lower bowel, particularly promotes peristalsis and assimilation.
Indicated for atonic and sub-acid states; slowly promotes peristalsis and facilitates assimilation.'),
(102, 1, 'individual_indications',
'Languid conditions and general debility, anorexia, alimentary insufficiency.
Portal congestion.
Biliousness and jaundice.'),
(102, 1, 'combinations_technique',
'Best in small doses combined with milder agents and carminatives.
With Collinsonia/Hydrastis.'),

-- Juglans cinerea (174)
(174, 1, 'special_characteristics',
'Gently stimulating hepatic tonic and trophorestorative: influences pelvic organs and the alimentary mucous membrane and tones the nervous system.
Specific action upon the lower bowel, and the portal system.
Relieves flatulence.'),
(174, 1, 'individual_indications',
'Chronic constipation.
Diarrhoea and dysentery.
Skin eruptions from faulty elimination.
Pin/thread worms in children.'),
(174, 1, 'combinations_technique',
'Aqueous extract — add Zingiber to prevent griping.
With Collinsonia. With Chelone.
With Taraxacum officinale.'),

-- Rhamnus purshiana (205)
(205, 1, 'special_characteristics',
'Very bitter tonic: slow, mild hepatic influence upon stomach, liver, gall-ducts and bowel.
Specifically indicated for mechanical insufficiency of the lower bowel.'),
(205, 1, 'individual_indications',
'Chronic constipation.
Chronic dyspepsia with liver torpor.
Chronic dyspepsia with hepatic torpor.
Jaundice.'),
(205, 1, 'combinations_technique',
'With Juglans cinerea syrup.'),

-- Rheum palmatum (154)
(154, 1, 'special_characteristics',
'Mild stimulating tonic to alimentary mucous membrane, liver and gall-ducts: removes visceral mucus.'),
(154, 1, 'individual_indications',
'Full catharsis.
Diarrhoea and dysentery, summer diarrhoea.
Functional dyspepsia.'),
(154, 1, 'combinations_technique',
'Add Dioscorea/Zingiber.
As tonic to cleanse and tone the bowel.
With Hydrastis/Leptandra.'),

-- Rosmarinus officinalis (109)
(109, 1, 'special_characteristics',
'Diffusive stimulant and relaxing tonic with special influence upon the nervous system, cerebrum and cerebellum: soothes the nervous system.
Indicated for conditions of gastric stress such as hepatic hypotension.
Suitable tonic for the elderly.'),
(109, 1, 'individual_indications',
'Atonic conditions of the stomach.
Gastric headache.
Adolescent hypotonia, asthenia with pallid complexion.
Circulatory weakness following stress or illness.'),
(109, 1, 'combinations_technique',
'(none listed)'),

-- Filipendula ulmaria (75)
(75, 1, 'special_characteristics',
'Mild stomachic/urinary astringent: relieves genito-urinary irritation.
Restores normal balance to gastric/secretory function.'),
(75, 1, 'individual_indications',
'Summer diarrhoea in children.
Diarrhoea, bowel disturbance.
Dyspepsia with hyperchlorydia.
Eructations, oesophageal burning.
Febrile conditions with excessive heat.'),
(75, 1, 'combinations_technique',
'With Agrimonia.
Strong infusion — small cup every 2-3 hours.'),

-- ============================================================
-- ORGAN REMEDIES: LIVER, GALL-BLADDER, PANCREAS
-- ============================================================

-- Berberis vulgaris (158)
(158, 1, 'special_characteristics',
'Stimulating tonic hepatic: influences the mucosa generally, removing mucoid accumulations and controlling excess secretion.
Improves appetite, digestion and assimilation.
Indicated for gouty constitutions.'),
(158, 1, 'individual_indications',
'Biliary catarrh with constipation and jaundice.
Gastritis, biliousness.
Debility in convalescence.
Ulcerative stomatitis.
Eczema of the hands.'),
(158, 1, 'combinations_technique',
'Small doses — with Prunus/Populus.
Small dose — with alteratives.
Mouth wash of decoction.'),

-- Chelidonium majus (170)
(170, 1, 'special_characteristics',
'Active cholagogue with influence upon the spleen and pancreas, and affects mesentery and lymphatics.
Indicated for lethargic states subject to weather changes.
Specifically for gall-ducts and bronchi.'),
(170, 1, 'individual_indications',
'Hepatitis, jaundice, obstruction — from obstructive pathology.
Indigestion, spastic constipation.
Intestinal putrefaction.
Eczema and scrofulous diseases.
Ophthalmia, conjunctivitis.'),
(170, 1, 'combinations_technique',
'Oral and local.
Lotion of infusion.'),

-- Chelone glabra (171)
(171, 1, 'special_characteristics',
'A mild cholagogue: influencing the mucous membranes: stimulates the appetite and tones the stomach.
Suitable for children and the elderly.
Indicated for gastro-intestinal disturbances after prolonged illness.'),
(171, 1, 'individual_indications',
'Atonic conditions, malaise and debility, convalescence.
Dyspepsia, mal-assimilation.
Round and thread worms.
Colitis from hepatic dysfunction.
Chronic jaundice.'),
(171, 1, 'combinations_technique',
'Use freely with more stimulating agents.
With suitable alteratives.
Frequent doses until purgation.'),

-- Chionanthus virginicus (24)
(24, 1, 'special_characteristics',
'Relaxing and stimulating hepatic and cholagogue: promotes digestion of bile, promotes digestion of fats.
Corrects excessive discharge of mucus into the gastro-intestinal tract.'),
(24, 1, 'individual_indications',
'Duodenal catarrh, hepatic torpor, catarrhal jaundice, gallstones.
Alimentary glycosuria.
Pancreatic disease and glandular disorders.
Chronic disease of liver/spleen.'),
(24, 1, 'combinations_technique',
'With Berberis.'),

-- Leptandra virginica (175)
(175, 1, 'special_characteristics',
'Mild relaxing hepatic: for torpid and congestive conditions: influences the alimentary tract via tubuli to assist secretion of bile, cleanses the alimentary tract of mucoid mucus.'),
(175, 1, 'individual_indications',
'Hepatitis, cholecystitis.
Chronic hepatic torpor.
Non-obstructive jaundice.
Febrile states (to clear bowel).
Rectal prolapse/haemorrhoids.
Skin eruptions.'),
(175, 1, 'combinations_technique',
'Combine with stimulating agents.
With diffusives. With Collinsonia. With alteratives.'),

-- ============================================================
-- ORGAN REMEDIES: KIDNEYS AND BLADDER
-- ============================================================

-- Equisetum arvense (151)
(151, 1, 'special_characteristics',
'Principal action on the bladder: increases connective tissue tone and resistance.
Stimulating toning diuretic, gradually increasing the flow of urine.
Controls inflammatory conditions.
Astringent in passive haemorrhages.'),
(151, 1, 'individual_indications',
'Acute cystitis with stricture and urethritis.
Enuresis/incontinence in children and the elderly.
Haematuria.
Oedematous catarrhal congestion of pelvic organs and tissues.
Renal calculi. Dropsy. Metabolic oedema of legs.
Enlarged/inflamed prostate gland.'),
(151, 1, 'combinations_technique',
'With Zea mays or Elymus repens for demulcent support.
Infusion of the green herb.
Cold water infusion.'),

-- Arctostaphylos uva-ursi (46)
(46, 1, 'special_characteristics',
'Increases renal circulation and stimulates tubular function.
Restores mucous membrane of urinary and genital structures, especially when pale, flabby and oedematous.
Indicated for chronic conditions.'),
(46, 1, 'individual_indications',
'Chronic vesical irritation with pain and catarrhal discharge.
Chronic urethritis.
Cystitis, haematuria.
Atonic leucorrhoea, profuse menstruation, uterine prolapse.
Rectal prolapse, vaginal laxity.'),
(46, 1, 'combinations_technique',
'With Rhus aromatica.
With Mitchella.'),

-- ============================================================
-- ORGAN REMEDIES: GENITAL
-- ============================================================

-- Caulophyllum thalictroides (72)
(72, 1, 'special_characteristics',
'Positive diffusive stimulant: uterine vaso-dilator, antispasmodic in all spastic and irritable conditions.
Indicated for atonic conditions and for deficient contractions in parturition.
Uterine trophorestorative (topical).'),
(72, 1, 'individual_indications',
'Metritis, endometritis, dysmenorrhoea.
Dysmenorrhoeic colic.
Urethritis, vaginitis, thrush.
Restlessness during pregnancy.
Menopausal pains and dysmenorrhoea.
Uterine sub-involution.'),
(72, 1, 'combinations_technique',
'Oral, and local douche.
With Scutellaria. With Cimicifuga.'),

-- Mitchella repens (188)
(188, 1, 'special_characteristics',
'Moderately stimulating tonic for weak and feeble conditions: influences the pelvic organs, stomach, bowels, kidneys and nervous system.
Indicated for female weakness: improves the neuromuscular/vascular tone of uterus.'),
(188, 1, 'individual_indications',
'Neurasthenia, irritability.
Enlarged atonic uterus.
To facilitate parturition.
Uterine bleeding from weakness, post-partum haemorrhage.
Spermatorrhoea.
Leucorrhoea.'),
(188, 1, 'combinations_technique',
'With Avena sativa.
With Aletris farinosa / Chamaelirium luteum.
With Caulophyllum.'),

-- Nymphaea odorata (2242)
(2242, 1, 'special_characteristics',
'Mild astringent tonic: reduces mucous discharge.
Indicated for weakness of the pelvic organs.'),
(2242, 1, 'individual_indications',
'Arid leucorrhoea, ulceration of the cervix, vaginal laxity.
Prostatitis.
Cystic catarrh, prostatitis.
Aphthous sore mouth.
Purulent ophthalmia.
Diarrhoea, dysentery.'),
(2242, 1, 'combinations_technique',
'Local douche or suppository.
Decoction as mouthwash.
Decoction as lotion/wash.'),

-- Salix spp. (87)
(87, 1, 'special_characteristics',
'Genito-urinary tonic; allays irritation and restores vigour to the generative structures of both sexes.
Positive bitter tonic nervine.'),
(87, 1, 'individual_indications',
'Cystitis, ovaritis, prostatitis.
Vaginitis, leucorrhoea.
Spermatorrhoea.'),
(87, 1, 'combinations_technique',
'As douche of decoction.
As rectal injection of decoction.'),

-- Senecio aureus (1058)
(1058, 1, 'special_characteristics',
'Specific tonic to the nervous and muscular structures of the uterus: reduces muscular and tonic hypertonia: slowly stimulating in hypotonic and atonic conditions.
Uterine ganglionic vaso-relaxant.'),
(1058, 1, 'individual_indications',
'Dysmenorrhoea (anaemic/atonic).
Menses retarded or suppressed.
Menses premature or too profuse.
Functional amenorrhoea (asthenic).
Atonic leucorrhoea.
Functional tubal dysfunctions.
Prostatic enlargement (atonic).'),
(1058, 1, 'combinations_technique',
'With Viburnum opulus / Caulophyllum.
With more positive emmenagogues.'),

-- Serenoa repens (186)
(186, 1, 'special_characteristics',
'Genito-urinary tonic alterative: general action on the mucous tissues and mucous membranes.
Indicated for wasting diseases and conditions: promotes tissue nutrition.'),
(186, 1, 'individual_indications',
'Atony of pelvic organs.
Wasting of testes, impotence, undeveloped mammary glands.
Enuresis/incontinence in children and the elderly.'),
(186, 1, 'combinations_technique',
'Use small doses frequently for trophic action.'),

-- Viburnum prunifolium (94)
(94, 1, 'special_characteristics',
'Soothing, stimulating astringent tonic: especially influencing the genito-urinary system.
Indicated for spasms of tubular organs: stomach, intestines, bladder, uterus.'),
(94, 1, 'individual_indications',
'Uterine prolapse, vaginal laxity.
Atonic amenorrhoea.
Passive/menopausal amenorrhoea.
Morning sickness, false labour pains, threatened abortion.
Excessive lochial discharge.'),
(94, 1, 'combinations_technique',
'With Senecio aureus.')

ON CONFLICT (herb_id, source_id, section_type) DO NOTHING;
