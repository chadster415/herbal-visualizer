-- Populate GI/Digestive System Disorders Data - Part 3 (FINAL)
-- Continuation of 011_populate_gi_disorders_part2.sql
-- Data extracted from GI.md - Liver/Gallbladder disorders and Hemorrhoids

SET search_path TO herbal, public;

-- Recreate helper functions
CREATE OR REPLACE FUNCTION get_or_create_herb(p_latin_name TEXT, p_common_name TEXT DEFAULT NULL)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
  v_common_name TEXT;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    v_common_name := COALESCE(p_common_name, INITCAP(SPLIT_PART(p_latin_name, ' ', 1)));
    INSERT INTO herbal.herbs (latin_name, common_name)
    VALUES (p_latin_name, v_common_name)
    RETURNING id INTO v_herb_id;
  END IF;
  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_or_create_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  IF v_action_id IS NULL THEN
    INSERT INTO herbal.primary_actions (name)
    VALUES (p_action_name)
    RETURNING id INTO v_action_id;
  END IF;
  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
  v_digestive_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
BEGIN
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';

  -- ============================================================================
  -- DISORDER: Jaundice
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Jaundice', v_digestive_id, 14)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'),
    'In Europe, has traditionally been considered specific', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Verbena officinalis', 'Vervain'),
    'In Europe, has traditionally been considered specific', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'),
    'because can help regenerate liver cells, this herb can help ensure that bile buildup does not cause hepatotoxicity', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), '', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), '', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 2.5 ml of tincture combination three times a day, building up to 5 ml three times a day. An infusion of Stellaria media or distilled witch hazel may be applied topically to relieve itching.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '2 parts', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Verbena officinalis', 'Vervain'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Peumus boldus', 'Boldo'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Verbena officinalis', 'Vervain'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Hepatic'), 5);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Tonic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Stellaria media', 'Chickweed'), get_or_create_action('Antipruritic'), 1);

  -- ============================================================================
  -- DISORDER: Chronic Hepatitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Chronic Hepatitis', v_digestive_id, 15)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'The term hepatitis embraces a number of specific syndromes with a range of causes and prognoses. They all share a core pathology of an inflammatory response in liver cells (hepatocytes) that can lead to cellular necrosis.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'In chronic hepatitis, the necrosis and inflammation lasts longer than six months to a year.', 2);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'help support and improve liver function and metabolism.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will be critical if the hepatitis has an infectious basis, and will help with surface immune support even if no infection is present.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'help with whole-system toning.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Cholagogue'),
    'have a direct impact on the secretion and release of bile, and thus may be indicated if jaundice is present.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'will help the whole body deal with the buildup of bilirubin and other metabolites, Laxatives, diuretics, and diaphoretics are the primary actions to consider.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Lymphatic'),
    'promote tissue drainage.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'may be needed for symptomatic support,', 9);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'),
    'Because of its regenerative potential, comes closest to being a textbook specific', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'),
    'The tonic hepatics are all relevant', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'),
    'The tonic hepatics are all relevant', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'),
    'The tonic hepatics are all relevant', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'),
    'The tonic hepatics are all relevant', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'),
    'The tonic hepatics are all relevant', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 2.5 ml of tincture three times a day, building up to 5 ml three times a day. Artemisia vulgaris is included as a bitter nervine, but this herb could be replaced with Verbena officianalis or another appropriate nervine.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '2 parts', 'root', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Hepatic'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Antihepatotoxic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Bitter'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'), get_or_create_action('Tonic'), 2);

  -- ============================================================================
  -- DISORDER: Viral Hepatitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Viral Hepatitis', v_digestive_id, 16)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hypericum perforatum', 'St. John''s Wort'),
    'The use in this kind of viral infection is worth exploring. The compounds hypericin and pseudohypericin are known to disrupt viral replication by damaging the integrity of the lipid envelope.', 1);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Dosage: 5 ml with water four times a day', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Echinacea angustifolia', 'Narrow-leaf Echinacea'), '35 ml', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hypericum perforatum', 'St. John''s Wort'), '25 ml', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '20 ml', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Phyllanthus amarus', 'Stonebreaker'), '20 ml', 4);

  -- Action Herbs (comprehensive list from the file)
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Eleutherococcus senticosus', 'Siberian Ginseng'), get_or_create_action('Adaptogen'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Glycyrrhiza glabra', 'Licorice'), get_or_create_action('Adaptogen'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Panax ginseng', 'Asian Ginseng'), get_or_create_action('Adaptogen'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Rehmannia glutinosa', 'Rehmannia'), get_or_create_action('Adaptogen'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Withania somnifera', 'Ashwagandha'), get_or_create_action('Adaptogen'), 5);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Avena sativa', 'Oat'), get_or_create_action('Antidepressant'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hypericum perforatum', 'St. John''s Wort'), get_or_create_action('Antidepressant'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Verbena officinalis', 'Vervain'), get_or_create_action('Antidepressant'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Bupleurum falcatum', 'Bupleurum'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Curcuma longa', 'Turmeric'), get_or_create_action('Anti-inflammatory'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Allium sativum', 'Garlic'), get_or_create_action('Antioxidant'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ginkgo biloba', 'Ginkgo'), get_or_create_action('Antioxidant'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), get_or_create_action('Antioxidant'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Astragalus membranaceus', 'Astragalus'), get_or_create_action('Antiviral'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Lentinus edodes', 'Shiitake'), get_or_create_action('Antiviral'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Phyllanthus amarus', 'Stonebreaker'), get_or_create_action('Antiviral'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Picrorrhiza kurroa', 'Kutki'), get_or_create_action('Antiviral'), 4);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Thuja occidentalis', 'Thuja'), get_or_create_action('Antiviral'), 5);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Schisandra chinensis', 'Schisandra'), get_or_create_action('Detoxifying'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Detoxifying'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Cynara scolymus', 'Artichoke'), get_or_create_action('Antihepatotoxic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Echinacea spp.', 'Echinacea'), get_or_create_action('Immunostimulant'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ganoderma lucidum', 'Reishi'), get_or_create_action('Immunostimulant'), 2);

  -- ============================================================================
  -- DISORDER: Cirrhosis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cirrhosis', v_digestive_id, 17)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'The condition is characterized by widespread death of liver cells, accompanied by progressive fibrosis and distortion of liver architecture. This can be due to many causes, but in the United States and Europe is most commonly related to alcohol abuse.', 1);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'support and improve liver function and metabolism.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Cholagogue'),
    'have a direct upon the secretion and release of bile', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'will help the whole body deal with the buildup of bilirubin and other metabolites. Laxatives, diuretics, and diaphoretics are the primary actions to consider.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'help with whole-system toning.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Lymphatic'),
    'promote systemic tissue drainage.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'will support any psychological work needed in alcohol withdrawal.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will be helpful for surface immune support, even if no infection is present.', 8);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'),
    'comes closest to being a textbook specific, because of its regenerative potential. This wonderful remedy is essential to any treatment of cirrhosis.', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'),
    'the tonic hepatic herbs are all relevant', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Peumus boldus', 'Boldo'),
    'the tonic hepatic herbs are all relevant', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'),
    'the tonic hepatic herbs are all relevant', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'),
    'the tonic hepatic herbs are all relevant', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'),
    'the tonic hepatic herbs are all relevant', 6);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'),
    'may be useful', 7);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Cynara scolymus', 'Artichoke'),
    'may be useful', 8);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 2.5 ml of tincture three times a day, building up to 5 ml three times a day. The alcohol base of tinctures may pose a problem. If these remedies cannot be obtained in an alcohol-free glycerite form, the medicine can be put into a small amount of hot water; the alcohol will evaporate and leave behind the herbal component.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Verbena officinalis', 'Vervain'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chelone glabra', 'Balmony'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 4);

  -- ============================================================================
  -- DISORDER: Cholecystitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cholecystitis', v_digestive_id, 18)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Cholecystitis, or gallbladder inflammation, is characterized by severe pain that becomes localized in the upper right quadrant of the abdomen, radiating to the right lower shoulder blade. Nausea and vomiting are common symptoms. Cholecystitis may be associated with gallstones, but the stones constitute a separate condition.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Even though people can tolerate the absence of the gallbladder, a healthy gallbladder helps ensure efficient digestion, which directly decreases the risks of developing arte-riosclerosis, irritable bowel syndrome, hypertension, heart disease, stroke, and other major diseases.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Diet and stress management are critical. Strong chemical pain relief may be indicated for severe cases.', 3);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'support the work of the liver and so will have a positive metabolic effect.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'may help reduce the severity of swelling.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'help ease colic in the gallbladder or ducts.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'must be provided to help the whole body deal with the repercussions of digestive distress and systemic problems.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease the strain from pain and general worry.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will provide surface immune support even if no infection is present.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'Caution: Bitters and strong cholagogues are contraindicated, because they increase the strength of peristaltic muscular contractions.', 8);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 5 ml of tincture three times a day. An infusion of a carminative, antispasmodic nervine, such as Matricaria recu-tita, should be taken regularly throughout the day. In addition, the patient should take Silybum marianum tablets or capsules standardized to 80% silymarin. Recommended dosage is 1 capsule containing 140 mg of silymarin three times daily. NOTE: This prescription supplies antispasmodic, hepatic, nervine, and preventive antilithic actions. Many other herbs could have been used. Consider Chelone glabra, Verbena officinalis, and Mahonia aquifolium. The Eclectic physicians would have suggested that small amounts of Hydrastis canadensis and Lobelia inflata be added to such a mixture.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '2 parts', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '1 part', 'root', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Leptandra virginica', 'Black Root'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Alterative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Alterative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Tonic'), 2);

  -- ============================================================================
  -- DISORDER: Cholelithiasis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cholelithiasis', v_digestive_id, 19)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Gallstones appear to be caused by a combination of factors, including inherited body chemistry, body weight, gallbladder movement, and diet.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Diet and stress management are critical. Strong chemical pain relief may be indicated for severe cases.', 2);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antilithic'),
    'have a long tradition of use in moving or even dissolving gallstones and easing pain.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Hepatic'),
    'support the work of the liver and have a positive metabolic effect.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'relieve colic in the gallbladder or ducts.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'ease the strain from pain and general worry.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'must be provided to help the whole body deal with the repercussions of digestive distress and systemic problems.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Alterative'),
    'support the whole body in its healing work.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Tonic'),
    'support the whole body in its healing work.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'will help with surface immune support, even if no infection is present.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'Caution: Bitters and strong cholagogues are contraindicated, because they increase the strength of peristaltic muscular contractions.', 9);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: up to 5 ml of tincture three times a day. An infusion of a carminative, antispasmodic, nervine herb should be taken regularly throughout the day (for example, Matricaria recutita).', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chelone glabra', 'Balmony'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Leptandra virginica', 'Black Root'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), '1 part', 5);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), get_or_create_action('Hepatic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Hepatic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Leptandra virginica', 'Black Root'), get_or_create_action('Hepatic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), get_or_create_action('Antilithic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chionanthus virginicus', 'Fringetree'), get_or_create_action('Antilithic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Antispasmodic'), 2);

  -- ============================================================================
  -- DISORDER: Hemorrhoids
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Hemorrhoids', v_digestive_id, 20)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Hemorrhoids are caused by increased pressure in the veins of the anus.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Avoidance or elimination of constipation is often the key to alleviating hemorrhoids.', 2);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vascular Tonic'),
    'will help with the muscular tone and general state of well-being of the veins involved.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'will reduce bleeding, if present, and tighten the tissue locally. However, if they are used internally, take care to avoid constipation.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'assist digestive and eliminative processes and facilitate bowel motions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Aperient'),
    'ensure easier bowel movements.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Laxative'),
    'ensure easier bowel movements.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'speed local healing of inflamed tissues.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Emollient'),
    'soothe irritated tissue if applied externally.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'soothe inflamed tissues.', 7);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ranunculus ficaria', 'Pilewort'),
    'In Europe, nothing matches the action of the aptly named pilewort! Apart from this plant, most astringent or anti-inflammatory herbs will help if applied topically.', 1);

  -- Prescription 1: Internal
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id, 'Dosage: 5 ml of tincture three times a day', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Ginkgo biloba', 'Ginkgo'), '1 part', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Aesculus hippocastanum', 'Horse Chestnut'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), '1 part', 5);

  -- Prescription 2: Topical
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Topical application',
    'Apply this combination after every bowel movement and as needed. Salves containing any of many possible herbs may also be used. Useful herbs include Calendula officinalis, Hypericum perforatum, Matricaria recutita, Plantago spp., and Achillea millefolium.', 2)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Aesculus hippocastanum', 'Horse Chestnut'), '10 ml', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Hamamelis virginiana', 'Witch Hazel'), '80 ml', 'distilled', 2);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Ginkgo biloba', 'Ginkgo'), get_or_create_action('Vascular Tonic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Aesculus hippocastanum', 'Horse Chestnut'), get_or_create_action('Vascular Tonic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Geranium maculatum', 'Cranesbill'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), get_or_create_action('Aperient'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Hydrastis canadensis', 'Goldenseal'), get_or_create_action('Aperient'), 2);

END $$;

-- Cleanup helper functions
DROP FUNCTION IF EXISTS get_or_create_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS get_or_create_action(TEXT);

-- ============================================================================
-- COMPLETE! All 20 GI/Digestive disorders have been migrated.
--
-- Summary of disorders added in this file (Part 3):
-- 14. Jaundice
-- 15. Chronic Hepatitis
-- 16. Viral Hepatitis
-- 17. Cirrhosis
-- 18. Cholecystitis
-- 19. Cholelithiasis
-- 20. Hemorrhoids
--
-- Combined with Parts 1 and 2, all GI disorders from GI.md are now in the database!
-- ============================================================================
