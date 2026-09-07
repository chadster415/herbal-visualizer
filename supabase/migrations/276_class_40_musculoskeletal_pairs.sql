-- Migration 276: BHC Class 40 — Musculoskeletal I and II — herb pairs
--
-- New pairs from class notes (Jamaican Dogwood pairing notes, Valerian/Cal Poppy note):
--   Jamaican Dogwood (2461) + Willow (87)          — AI for pain reduction
--   Jamaican Dogwood (2461) + Meadowsweet (75)     — AI for pain reduction
--   Jamaican Dogwood (2461) + Wild Lettuce (130)   — recent injury / insomnia
--   Jamaican Dogwood (2461) + Kava (138)           — recent injury / muscle relaxation
--   Jamaican Dogwood (2461) + Hops (129)           — insomnia from body aches
--   Jamaican Dogwood (2461) + Skullcap (142)       — insomnia from body aches
--   Jamaican Dogwood (2461) + Black Cohosh (25)    — skeletal pain
--   Valerian (145) + California Poppy (128)         — mitigate Valerian palpitations in dry constitutions

SET search_path TO herbal, public;

-- Jamaican Dogwood + Willow (AI for pain)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 87), GREATEST(2461, 87),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs well with anti-inflammatory herbs like White Willow to reduce the sensation of pain while Jamaican Dogwood addresses smooth muscle pain and nervous irritability.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 87) AND herb2_id = GREATEST(2461, 87);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Smooth muscle pain with inflammation', 10),
    ('Chronic musculoskeletal pain', 20),
    ('Rheumatoid arthritis with nerve involvement', 30)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Targets smooth muscle pain, nervous irritability, and face pain; sedative component', 10),
    (87,   'Provides salicylate-based anti-inflammatory and analgesic action, especially effective as decoction', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Jamaican Dogwood + Meadowsweet (AI for pain)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 75), GREATEST(2461, 75),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs well with Meadowsweet as an anti-inflammatory companion to reduce pain sensation while Jamaican Dogwood targets smooth muscle pain and nervous irritability.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 75) AND herb2_id = GREATEST(2461, 75);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Smooth muscle pain with inflammation', 10),
    ('Chronic musculoskeletal pain', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Targets smooth muscle pain and nervous irritability; sedative', 10),
    (75,   'Anti-inflammatory via salicylates; gastro-protective and gentle', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Jamaican Dogwood + Wild Lettuce (recent injury / insomnia)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 130), GREATEST(2461, 130),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs well with Wild Lettuce for recent injury — both are analgesic and sedating, with Jamaican Dogwood specific for smooth muscle pain and Wild Lettuce for nervous system calming and sleep.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 130) AND herb2_id = GREATEST(2461, 130);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Recent injury with pain and insomnia', 10),
    ('Acute musculoskeletal pain with sleep disruption', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Smooth muscle pain, insomnia with spasms, nervous irritability', 10),
    (130,  'Nervous system calming, mild analgesic, sleep support', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Jamaican Dogwood + Kava (recent injury / muscle relaxation)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 138), GREATEST(2461, 138),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs well with Kava for recent injury — both are skeletal muscle relaxants and analgesics, together addressing smooth and skeletal muscle pain, spasm, and nervous irritability.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 138) AND herb2_id = GREATEST(2461, 138);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Recent injury with muscle pain and spasm', 10),
    ('Acute musculoskeletal pain', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Smooth muscle pain, nervous irritability, sedative', 10),
    (138,  'Skeletal muscle relaxant, antispasmodic, sleep support', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Jamaican Dogwood + Hops (insomnia from body aches)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 129), GREATEST(2461, 129),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs with Hops for insomnia due to body aches — Jamaican Dogwood addresses the spasm and nervous irritability causing wakefulness while Hops provides sedation and analgesic support.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 129) AND herb2_id = GREATEST(2461, 129);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Insomnia due to body aches and muscle spasms', 10),
    ('Chronic pain disrupting sleep', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Smooth muscle pain, insomnia with spasms, nervous irritability', 10),
    (129,  'Sedative, analgesic, bitter — promotes sleep and reduces pain sensitivity', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Jamaican Dogwood + Skullcap (insomnia from body aches)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 142), GREATEST(2461, 142),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs with Skullcap for insomnia due to body aches — Jamaican Dogwood targets the muscular pain and spasm while Skullcap calms nervous system hyperactivity and promotes sleep.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 142) AND herb2_id = GREATEST(2461, 142);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Insomnia due to body aches and nervous irritability', 10),
    ('Chronic pain with nervous system dysregulation', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Smooth muscle pain, insomnia with spasms, nervous irritability, sedative', 10),
    (142,  'Nervine tonic, sedative — calms nervous system hyperactivity and restores sleep', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Jamaican Dogwood + Black Cohosh (skeletal pain)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(2461, 25), GREATEST(2461, 25),
    'BHC Apprenticeship class notes',
    'Jamaican Dogwood pairs with Black Cohosh for skeletal pain — Black Cohosh is specific for dull, aching, rheumatic pains while Jamaican Dogwood addresses the smooth muscle and nerve pain component.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(2461, 25) AND herb2_id = GREATEST(2461, 25);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Skeletal and rheumatic pain', 10),
    ('Chronic musculoskeletal pain', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (2461, 'Smooth muscle and nerve pain; sedative; targets face pain and nervous irritability', 10),
    (25,   'THE rheumatoid arthritis remedy; specific for dull, aching muscular pain and acute inflammatory rheumatic pains', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;

-- Valerian + California Poppy (mitigate palpitations in dry constitutions)
DO $$
DECLARE v_pair_id int;
BEGIN
  INSERT INTO herbal.herb_pairs (herb1_id, herb2_id, source, combined_summary)
  VALUES (
    LEAST(145, 128), GREATEST(145, 128),
    'BHC Apprenticeship class notes',
    'Valerian can cause heart palpitations in dry constitutions; pairing with California Poppy eases this possibility while maintaining the analgesic, antispasmodic, and sedative effect.'
  )
  ON CONFLICT (herb1_id, herb2_id) DO NOTHING;

  SELECT id INTO v_pair_id FROM herbal.herb_pairs
  WHERE herb1_id = LEAST(145, 128) AND herb2_id = GREATEST(145, 128);

  INSERT INTO herbal.herb_pair_indications (pair_id, indication, sort_order)
  SELECT v_pair_id, ind, ord FROM (VALUES
    ('Muscle pain, spasm, and insomnia in dry constitutions', 10),
    ('Chronic pain with anxiety in dry/vata types', 20)
  ) AS t(ind, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_indications WHERE pair_id = v_pair_id);

  INSERT INTO herbal.herb_pair_herb_properties (pair_id, herb_id, property, sort_order)
  SELECT v_pair_id, hid, prop, ord FROM (VALUES
    (145, 'Antispasmodic, pain reliever, sedative — can cause palpitations in dry constitutions', 10),
    (128, 'Nervine, analgesic for smooth and skeletal muscles — mitigates Valerian palpitations', 10)
  ) AS t(hid, prop, ord)
  WHERE NOT EXISTS (SELECT 1 FROM herbal.herb_pair_herb_properties WHERE pair_id = v_pair_id);
END $$;
