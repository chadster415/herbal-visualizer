-- Populate Respiratory Systems - Part 1
-- This includes Lower and Upper Respiratory system disorders
-- File: Respiratory System.md

SET search_path TO herbal, public;

-- ============================================================================
-- ADD NEW BODY SYSTEMS
-- ============================================================================
-- Add Lower Respiratory and Upper Respiratory as separate systems

INSERT INTO herbal.body_systems (name)
VALUES ('Lower Respiratory'), ('Upper Respiratory')
ON CONFLICT (name) DO NOTHING;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - OVERALL
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create "Overall" disorder for Lower Respiratory
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Overall', v_lower_resp_id, 0)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'The lungs sit within the thoracic cage, where they stretch from the trachea (commonly called the windpipe) to below the heart.', 1),
    (v_disorder_id, 'About 10% of the lung is solid tissue and the rest is filled with air and blood.', 2),
    (v_disorder_id, 'The lungs'' main function is to rapidly exchange oxygen from inhaled air with carbon dioxide from the blood', 3),
    (v_disorder_id, 'The two main bronchi extend from the trachea into each lung, where they divide into smaller bronchi, and then a great number of smaller bronchioles. The bronchioles divide into a network of about 3 million alveolar ducts containing alveoli, commonly called air sacs.', 4),
    (v_disorder_id, 'Specific nerve sites located in the brain and the neck, called respi vatory centers, coordinate the performance of the ventila-tory apparatus. The respiratory centers respond to changes in oxygen, carbon dioxide, and acid levels in the blood.', 5),
    (v_disorder_id, 'Gas exchange between inhaled air and blood takes place in the alveoli. A very thin membrane separates the blood from the air in the alveoli and allows oxygen and nitrogen to diffuse into the blood. This barrier is 50 times thinner than a sheet of tissue paper, but a large surface area (80 square meters, or about as large as a tennis court) is available for gas exchange. In the resting state, it takes just about a minute for the total blood volume of the body to pass through the lungs. It takes a red cell a fraction of a second to pass through the capillary network. Gas exchange occurs almost instantaneously during this short time period', 6),
    (v_disorder_id, 'We are not only what we eat, but also what we breathe.', 7),
    (v_disorder_id, 'Many pathological tissue changes can be prevented if the environmental milieu of the cells is constantly rich in oxygen.', 8),
    (v_disorder_id, 'Air pollution in the country may be caused by dust from tractors plowing fields, trucks and cars driving on dirt or gravel roads, and rock quarries, as well as by smoke from wood and crop fires.', 9),
    (v_disorder_id, 'Ground-level ozone is created when engine and fuel gases that have already been released into the air interact in the presence of sunlight.', 10),
    (v_disorder_id, 'Ozone irritates the respiratory tract and eyes, and exposure to high levels results in chest tightness, coughing, and wheezing.', 11),
    (v_disorder_id, 'For every eight smokers, one nonsmoker dies from the effects of secondhand smoke.', 12),
    (v_disorder_id, 'Smoking is responsible for 32% of deaths due to cancer.', 13),
    (v_disorder_id, 'Smoking causes nearly 90% of all lung and throat cancers.', 14),
    (v_disorder_id, 'Alcohol is also a risk factor for some cancers, and the combination of alcohol and smoking greatly increases cancer risk.', 15),
    (v_disorder_id, 'Smoking decreases the strength of the sphincter muscle between the throat and stomach, which allows stomach contents to reflux, or flow backward, into the esophagus.', 16),
    (v_disorder_id, 'Smoking seems to affect the liver, too, by changing the way it handles drugs and alcohol.', 17),
    (v_disorder_id, 'Peptic ulcer disease is more likely to occur in smokers than in nonsmokers, and ulcers heal less readily and are more likely to recur in smokers.', 18),
    (v_disorder_id, 'Smoking has a direct effect on the growth of the fetus.', 19),
    (v_disorder_id, 'Natural menopause occurs earlier in smokers than in nonsmokers by one to two years.', 20),
    (v_disorder_id, 'Cigarettes and oral contraceptives are a dangerous combination that increases the risk of heart attacks, strokes, and other vascular complications.', 21),
    (v_disorder_id, 'A decrease of blood flow in the small vessels of the skin that may damage skin components, leading to skin wrinkling and an appearance of premature aging.', 22),
    (v_disorder_id, 'The respiratory zone, the actual site of gas exchange, is composed of the respiratory bronchioles, alveolar ducts, and alveoli. The conducting zone, sometimes called the dead air space, includes all other respiratory passageways, which serve as fairly rigid conduits to allow air to reach the gas exchange sites. The conducting zone organs also purify, humidify, and warm the incoming air.', 23),
    (v_disorder_id, 'The lower respiratory system consists of the respiratory zone, the alveoli, and respiratory bronchioles. The air-conducting bronchi and trachea are anatomically part of this system. The upper respiratory system consists of the conducting zone, made up of the nose, sinuses, pharynx, and larynx.', 24),
    (v_disorder_id, 'Expectorants are herbs that facilitate or accelerate the removal of bronchial secretions from the bronchi and trachea.', 25),
    (v_disorder_id, 'Stimulating Expectorants: For any given stimulating expectorant, either or both of the following mechanisms may be at play. Irritation of the bronchioles stimulates the expulsion of any material present. Liquefaction of viscid sputum encourages clearing by coughing.', 26),
    (v_disorder_id, 'The particular form of stimulation offered by this group of expectorants makes them relevant for productive coughs, in which sputum should be removed from the airways.', 27),
    (v_disorder_id, 'Relaxing expectorants may also act by reflex, but here the herbs work to soothe bronchial spasm and loosen mucous secretions.', 28),
    (v_disorder_id, 'They facilitate the production of a less viscous mucous secretion, which helps lift up stickier material from below. This makes relaxing expectorants useful for dry, irritating coughs. You will notice that this action is similar in some respects to that of demulcents, and both actions owe a lot to their content of mucilage and occasionally volatile oils.', 29),
    (v_disorder_id, 'Herbs known as pulmonaries, or amphoteric expectorants, have a beneficial effect upon both lung tissue and function.', 30),
    (v_disorder_id, 'We can generalize here that Inula has stimulant expectorant effects and Verbascum is more of a relaxing expectorant. Tussilago is the best of the three for children.', 31),
    (v_disorder_id, 'To avoid any potential toxicity problems, leaf and flower formulations of Tussilago should not be taken for more than one consecutive month, and root products should not be used internally.', 32),
    (v_disorder_id, 'Dyspnea, defined as an unpleasant sensation of difficulty in breathing.', 33);

  -- Add Action Herbs for Overall Lower Respiratory
  -- Pulmonary tonic
  v_action_id := herbal.ensure_action('Pulmonary tonic');
  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Stimulating expectorant
  v_action_id := herbal.ensure_action('Stimulating expectorant');
  v_herb_id := herbal.ensure_herb('Cephaelis ipecacuanha', 'ipecac');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'white horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  -- Relaxing expectorant
  v_action_id := herbal.ensure_action('Relaxing expectorant');
  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Cetraria islandica', 'Iceland moss');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Plantago spp.', 'plantain');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  -- Antispasmodic
  v_action_id := herbal.ensure_action('Antispasmodic');
  v_herb_id := herbal.ensure_herb('Drosera rotundifolia', 'sundew');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Euphorbia pilulifera', 'pill-bearing spurge');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Lactuca virosa', 'wild lettuce');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Papaver spp.', 'poppy');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  -- Antimicrobial
  v_action_id := herbal.ensure_action('Antimicrobial');
  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Eucalyptus spp.', 'eucalyptus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Immune support
  v_action_id := herbal.ensure_action('Immune support');
  v_herb_id := herbal.ensure_herb('Echinacea spp.', 'echinacea');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  -- Anticatarrhal
  v_action_id := herbal.ensure_action('Anticatarrhal');
  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Cardiotonic
  v_action_id := herbal.ensure_action('Cardiotonic');
  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Tilia platyphyllos', 'linden');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Nervine
  v_action_id := herbal.ensure_action('Nervine');
  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Lactuca virosa', 'wild lettuce');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  RAISE NOTICE 'Lower Respiratory - Overall disorder created with action herbs';
END $$;

-- ============================================================================
-- LOWER RESPIRATORY SYSTEM - COUGH
-- ============================================================================

DO $$
DECLARE
  v_lower_resp_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_action_id INTEGER;
  v_herb_id INTEGER;
  v_presc_herb_id INTEGER;
BEGIN
  SELECT id INTO v_lower_resp_id FROM herbal.body_systems WHERE name = 'Lower Respiratory';

  -- Create Cough disorder
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cough', v_lower_resp_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Add disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'For treating coughs, always select the appropriate approach for the individual''s unique case. The key to treatment is achieving a correct balance among the various stimulating, demul-cent, antimicrobial, and antitussive herbs available. Treat the person and his or her experience, not just the cough.', 1),
    (v_disorder_id, 'Coughing is a reflex response that represents an attempt by the body to clear the airways. Usually, blockages are caused by mucus secreted by membranes lining the respiratory tract. These mucous secretions help to protect the respiratory tract from all kinds of irritants by trapping and flushing out smoke particles, bacteria, and viruses. Any cough that lasts more than a few days, does not respond to treatment, or produces blood should be investigated further, as it may be a sign of serious organic disease.', 2),
    (v_disorder_id, 'Cough may be related to gastroesophageal reflux disease (GERD). In this condition, acid reflux from the stomach backs up into the throat, causing either heartburn or cough.', 3),
    (v_disorder_id, 'Treatment: Acute inflammatory conditions of the respiratory system are primarily treated with mucilage-rich demulcents, which soothe inflamed tissue. It is difficult to explain the mechanism at play here, as the mucopolysaccharide molecules in demulcent herbs do not enter the bloodstream and thus cannot be directly active in the respiratory tissue.', 4),
    (v_disorder_id, 'Stimulant, saponin-containing expectorants are best used for subacute or chronic bronchitis, for which active expectoration is indicated.', 5);

  -- Prescription: Cough formula
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, NULL, 'Infuse 1 teaspoon of dried herb mixture in 1 cup of freshly boiled water; drink often until symptoms subside.', 1)
  RETURNING id INTO v_prescription_id;

  -- Add herbs to prescription
  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 1);

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 2);

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 3);

  v_herb_id := herbal.ensure_herb('Glycyrrhiza glabra', 'licorice');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  v_herb_id := herbal.ensure_herb('Pimpinella anisum', 'anise');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 5);

  RAISE NOTICE 'Lower Respiratory - Cough disorder created with prescription';
END $$;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This migration adds:
-- 1. Lower Respiratory and Upper Respiratory body systems
-- 2. Lower Respiratory - Overall disorder with extensive notes and action herbs
-- 3. Lower Respiratory - Cough disorder with prescription
--
-- Subsequent migrations will add remaining disorders and prescriptions
