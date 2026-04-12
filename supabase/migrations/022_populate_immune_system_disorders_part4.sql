-- Populate Immune System disorders and data - Part 4
-- This includes: Prostatitis, Boils, Fungal Skin Infections, Cancer

SET search_path TO herbal, public;

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
-- PROSTATITIS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Prostatitis', v_immune_system_id, 8)
  RETURNING id INTO v_disorder_id;

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'that work well in the urinary system are fundamental to treatment success.', 1);

  v_action_id := herbal.ensure_action('Tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Prostate tonics are indicated, as for benign prostatic hyperplasia.', 2);

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Diuretics will promote voiding of urine. However, they may be contraindicated if there is marked blockage due to prostate swelling.', 3);

  v_action_id := herbal.ensure_action('Demulcent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'Demulcents that soothe the urinary system (demulcent diuretics) can help alleviate some of the symptoms.', 4);

  -- Specific Remedies
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful antimicrobial', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful antimicrobial', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Elymus repens';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful antimicrobial', 3);

  -- Note: The source has "Serena repens" but this is likely a typo for "Serenoa repens"
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Serenoa repens';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful prostatic tonic', 4);

  v_herb_id := herbal.ensure_herb('Hydrangea arborescens', 'hydrangea');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'useful prostatic tonic', 5);

  v_herb_id := herbal.ensure_herb('Turnera diffusa', 'damiana');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 6);

  v_herb_id := herbal.ensure_herb('Smilax spp.', 'sarsaparilla');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 7);

  -- Prescription (tincture + infusion)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Tincture', 'Dosage: up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of equal parts of dried Zea mays and Achillea millefolium throughout the day.', 1)
  RETURNING id INTO v_prescription_id;

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Serenoa repens';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zea mays';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 5);

  -- Action Herbs section
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  -- Prostate tonic
  v_action_id := herbal.ensure_action('Prostate tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Serenoa repens';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  -- Diuretic
  v_action_id := herbal.ensure_action('Diuretic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctostaphylos uva-ursi';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Agathosma betulina';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zea mays';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Achillea millefolium';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  -- Demulcent
  v_action_id := herbal.ensure_action('Demulcent');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Zea mays';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  RAISE NOTICE 'Prostatitis disorder created';
END $$;

-- ============================================================================
-- BOILS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Boils', v_immune_system_id, 9)
  RETURNING id INTO v_disorder_id;

  -- Disorder notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Also known as furuncles, are infections that manifest as localized abscesses starting in the hair follicles.', 1),
    (v_disorder_id, 'When deeper furuncles form and coalesce, the term carbuncle applies. A carbuncle may drain at several openings in the same region. The shoulders, face, scalp, buttocks, and armpits are common sites for carbuncles.', 2);

  -- Actions Indicated
  v_action_id := herbal.ensure_action('Alterative');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'offer the most benefit in the treatment of boils, although I am unable to give a satisfactory explanation of how they work or why!', 1);

  v_action_id := herbal.ensure_action('Antimicrobial');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'help the body rid itself of the infection. In this case, it is difficult to say whether they work through direct bactericidal effects or indirect stimulation of the immune response.', 2);

  v_action_id := herbal.ensure_action('Lymphatic tonic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'promote the general drainage of fluid.', 3);

  v_action_id := herbal.ensure_action('Diuretic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are especially important in supporting the eliminative work of the kidneys.', 4);

  v_action_id := herbal.ensure_action('Hepatic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'are similarly helpful for the liver.', 5);

  v_action_id := herbal.ensure_action('Vulnerary');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 6);

  v_action_id := herbal.ensure_action('Anti-inflammatory');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 7);

  v_action_id := herbal.ensure_action('Antipruritic');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 8);

  v_action_id := herbal.ensure_action('Astringent');
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, v_action_id, 'herbs may all be helpful topically.', 9);

  -- Specific Remedies + note
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id, 'The stronger hepatic alteratives are often considered specifics. Their strength highlights the need to take care with dosage. Important examples of hepatic alteratives are listed here. In addition, Echinacea is strongly indicated.', 3);

  v_herb_id := herbal.ensure_herb('Iris versicolor', 'blue flag');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Larrea tridentata';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 2);

  v_herb_id := herbal.ensure_herb('Phytolacca americana', 'poke');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 3);

  v_herb_id := herbal.ensure_herb('Pulsatilla vulgaris', 'pasqueflower');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 4);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Tincture + Infusion', 'Dosage: up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of Urtica dioica (preferably made from fresh herb) twice a day.', 1)
  RETURNING id INTO v_prescription_id;

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '3 parts', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '2 parts', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 4);

  -- Action Herbs
  v_action_id := herbal.ensure_action('Alterative');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_action_id := herbal.ensure_action('Lymphatic tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_action_id := herbal.ensure_action('Diuretic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_action_id := herbal.ensure_action('Hepatic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  RAISE NOTICE 'Boils disorder created';
END $$;

-- ============================================================================
-- FUNGAL SKIN INFECTIONS
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_prescription_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Fungal Skin Infections', v_immune_system_id, 10)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'myrrh essential oil', 2);

  v_herb_id := herbal.ensure_herb('Melaleuca spp.', 'tea tree');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, 'tea tree oil', 3);

  -- Prescription (Lavender + Myrrh EO)
  INSERT INTO herbal.disorder_prescriptions (disorder_id, title, instructions, sort_order)
  VALUES (v_disorder_id, 'Essential Oil Blend', 'A combination of equal parts lavender and myrrh essential oils is a long-standing treatment for athlete''s foot among aromatherapists in the United Kingdom. Myrrh is fungicidal and lavender is anti-inflammatory and vulnerary. For the first few days of treatment, dissolve the oils in rubbing alcohol and apply to skin until the skin no longer seems moist or weepy. Continue treatment with an ointment or cream containing 3% to 5% essential oil until the skin is completely clear. If the skin is deeply cracked and painful, calendula oil can be valuable as well.', 1)
  RETURNING id INTO v_prescription_id;

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'essential oil', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, note, sort_order)
  VALUES (v_prescription_id, v_herb_id, '1 part', 'essential oil', 2);

  RAISE NOTICE 'Fungal Skin Infections disorder created';
END $$;

-- ============================================================================
-- CANCER
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Cancer', v_immune_system_id, 11)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Arctium lappa';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Hydrastis canadensis';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Iris versicolor';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 5);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Larrea tridentata';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 6);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Phytolacca americana';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 7);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Rumex crispus';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 8);

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 9);

  v_herb_id := herbal.ensure_herb('Scrophularia nodosa', 'figwort');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 10);

  v_herb_id := herbal.ensure_herb('Stillingia sylvatica', 'queen''s delight');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 11);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Thuja occidentalis';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 12);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Trifolium pratense';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 13);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 14);

  v_herb_id := herbal.ensure_herb('Viola odorata', 'sweet violet');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 15);

  v_herb_id := herbal.ensure_herb('Viscum album', 'mistletoe');
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, v_herb_id, '', 16);

  RAISE NOTICE 'Cancer disorder created';
END $$;

-- Clean up helper functions
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);

RAISE NOTICE '====================================================================';
RAISE NOTICE 'IMMUNE SYSTEM DATA INGESTION COMPLETE';
RAISE NOTICE '====================================================================';
RAISE NOTICE 'All Immune System disorders have been successfully populated:';
RAISE NOTICE '1. Overall (with general immune system notes)';
RAISE NOTICE '2. Autoimmune Diseases';
RAISE NOTICE '3. Elimination and Detox Issues';
RAISE NOTICE '4. Postoperative Recovery';
RAISE NOTICE '5. Infection';
RAISE NOTICE '6. Antibiotic Recovery';
RAISE NOTICE '7. Vaginitis';
RAISE NOTICE '8. Genitourinary Tract Infections';
RAISE NOTICE '9. Prostatitis';
RAISE NOTICE '10. Boils';
RAISE NOTICE '11. Fungal Skin Infections';
RAISE NOTICE '12. Cancer';
RAISE NOTICE '====================================================================';
