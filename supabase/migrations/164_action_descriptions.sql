SET search_path TO herbal, public;

-- Source: Herbal Academy "Herbal Actions" course worksheet.
-- Block 1: add descriptions to existing primary_actions.
-- Block 2: insert new action types not yet in the DB.

-- ── Block 1: Descriptions on existing actions ─────────────────────────────────

DO $$
BEGIN
  UPDATE herbal.primary_actions SET description = 'Helps maintain homeostasis throughout stressful shifts in our environment by helping to improve resistance to and recovery from stressors.'
    WHERE name = 'Adaptogen' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Works on a general level to tonify the systems of the body involved in waste removal.'
    WHERE name = 'Alterative' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Reduces the sensation of physical pain without causing unconsciousness.'
    WHERE name = 'Analgesic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Reduces the formation of mucus in the body, especially in the sinuses.'
    WHERE name = 'Anticatarrhal' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to elevate the mood.'
    WHERE name = 'Antidepressant' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Eases nausea and vomiting.'
    WHERE name = 'Antiemetic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to keep inflammation at bay when it becomes chronic or overexpressed.'
    WHERE name IN ('Anti-inflammatory', 'Anti-Inflammatory') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to soften or dissolve kidney or gallstones and may decrease the likelihood of stone formation.'
    WHERE name = 'Antilithic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Aids the body in killing or limiting pathogens either through directly destroying pathogens or strengthening the body''s resistance to them.'
    WHERE name = 'Antimicrobial' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Inhibits oxidative damage to healthy cells and tissues in the body.'
    WHERE name = 'Antioxidant' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Eases or minimizes the occurrence of rheumatism.'
    WHERE name = 'Antirheumatic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Relaxes smooth or skeletal muscle spasm.'
    WHERE name = 'Antispasmodic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Depresses the cough reflex.'
    WHERE name = 'Antitussive' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Aids the body in killing or limiting viruses.'
    WHERE name = 'Antiviral' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Gently encourages bowel movement.'
    WHERE name = 'Aperient' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Has a binding effect on tissue.'
    WHERE name = 'Astringent' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Bitter-tasting herb that eases digestive discomfort.'
    WHERE name IN ('Bitter', 'Bitter tonic', 'Bitter Tonic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies and strengthens the cardiovascular system.'
    WHERE name IN ('Cardiotonic', 'Cardioactive', 'Cardiovascular tonic', 'Vascular tonic', 'Vascular Tonic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Eases spasm in the digestive tract.'
    WHERE name = 'Carminative' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Stimulates the flow of bile from the liver and gallbladder; choleretics stimulate production of bile in the liver.'
    WHERE name = 'Cholagogue' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Increases the flow of blood throughout the body and improves the perfusion of tissues with blood.'
    WHERE name IN ('Circulatory Stimulant', 'Circulatory Tonic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Soothes and protects mucous membranes inside the body (demulcent) or external skin and mucosa (emollient).'
    WHERE name IN ('Demulcent', 'Emollient') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Promotes perspiration.'
    WHERE name = 'Diaphoretic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies and supports the digestive system.'
    WHERE name = 'Digestive Support' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Increases the flow of urine from the body.'
    WHERE name = 'Diuretic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Encourages menstruation.'
    WHERE name = 'Emmenagogue' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Assists the body in clearing respiratory tract secretions from the lungs.'
    WHERE name IN ('Expectorant', 'Amphoteric Expectorant', 'Relaxing Expectorant', 'Stimulating Expectorant', 'Pectoral Relaxant') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Supports liver function and health.'
    WHERE name IN ('Hepatic', 'Antihepatotoxic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies and normalizes the endocrine system and hormonal balance.'
    WHERE name IN ('Hormonal Normalizer', 'Hormonal Regulator') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Reduces allergic response in the body.'
    WHERE name IN ('Anti-allergic', 'Antihistamine', 'Antipruritic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps lower blood sugar levels when they are elevated.'
    WHERE name = 'Hypoglycemic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Induces or deepens sleep.'
    WHERE name = 'Hypnotic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps lower blood pressure.'
    WHERE name = 'Hypotensive' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to raise blood pressure.'
    WHERE name = 'Hypertensive' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Stimulates or modulates the immune system response.'
    WHERE name IN ('Immune Support', 'Immune Modulator', 'Immunostimulant', 'Immunomodulator') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to induce bowel movement.'
    WHERE name = 'Laxative' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Encourages clearance of metabolic waste through an effect on the lymphatic system.'
    WHERE name IN ('Lymphatic', 'Lymphatic Tonic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to calm the nervous system.'
    WHERE name IN ('Nervine', 'Nervine relaxant', 'Nervine Relaxant') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Stimulates the nervous system.'
    WHERE name = 'Nervine Stimulant' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies and restores the nervous system.'
    WHERE name IN ('Nervine tonic', 'Nervine Tonic') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Improves cognition and memory.'
    WHERE name = 'Nootropic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Provides nutritional support to the body.'
    WHERE name = 'Nutritive' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Dilates peripheral blood vessels to improve circulation.'
    WHERE name = 'Peripheral Vasodilator' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies and supports prostate health.'
    WHERE name = 'Prostate Tonic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies the respiratory system.'
    WHERE name = 'Pulmonary Tonic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to stimulate circulation when used topically.'
    WHERE name = 'Rubefacient' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Soothes irritated or inflamed tissue.'
    WHERE name = 'Soothing' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Helps to stop bleeding of minor wounds when applied locally.'
    WHERE name = 'Styptic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Restores, tones, and invigorates the body or a specific organ system.'
    WHERE name = 'Tonic' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Tonifies the uterus.'
    WHERE name IN ('Uterine Tonic', 'Uterine Astringent', 'Uterine Demulcent') AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Promotes wound healing.'
    WHERE name = 'Vulnerary' AND (description IS NULL OR description = '');

  UPDATE herbal.primary_actions SET description = 'Supports the body''s natural eliminative and detoxification processes.'
    WHERE name IN ('Eliminative Support', 'Detoxifying') AND (description IS NULL OR description = '');

  RAISE NOTICE 'Block 1: descriptions updated on existing actions.';
END $$;

-- ── Block 2: New actions not yet in DB ────────────────────────────────────────

DO $$
BEGIN
  INSERT INTO herbal.primary_actions (name, description) VALUES
    ('Anthelmintic',             'Aids the body in destroying or resisting pathogenic worms, such as flukes and tapeworms.'),
    ('Antibacterial',            'Aids the body in killing or limiting bacteria.'),
    ('Anticariogenic',           'Assists the body in warding off dental cavities.'),
    ('Antifungal',               'Aids the body in killing or limiting fungi.'),
    ('Antipyretic',              'Lowers body temperature.'),
    ('Cardiovascular System Tonic', 'Tonifies the cardiovascular system.'),
    ('Digestive Tonic',          'Tonifies the digestive system.'),
    ('Galactagogue',             'Brings on or increases the flow of breast milk.'),
    ('Hormonal Tonic',           'Tonifies the endocrine system.'),
    ('Hypolipidemic',            'Helps decrease the level of lipids in the blood.'),
    ('Immune Stimulant',         'Stimulates the immune system.'),
    ('Immune System Tonic',      'Tonifies the immune system.'),
    ('Kidney Tonic',             'Tonifies the kidneys.'),
    ('Liver Tonic',              'Tonifies the liver.'),
    ('Organ Affinity',           'Indicates a traditional affinity of the herb for a specific organ or body system.'),
    ('Radioprotective',          'Ameliorates the effects of radiation.'),
    ('Respiratory System Tonic', 'Tonifies the respiratory system.'),
    ('Sedative',                 'Fosters a deep state of relaxation.'),
    ('Sialogogue',               'Stimulates the salivary glands to increase the production and flow of saliva.'),
    ('Urinary System Tonic',     'Tonifies the urinary system.')
  ON CONFLICT (name) DO UPDATE
    SET description = EXCLUDED.description
    WHERE herbal.primary_actions.description IS NULL OR herbal.primary_actions.description = '';

  RAISE NOTICE 'Block 2: new actions inserted.';
END $$;

DO $$ BEGIN RAISE NOTICE 'Migration 164 (action descriptions) complete.'; END $$;
