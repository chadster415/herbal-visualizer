-- Populate GI/Digestive System Disorders Data - Part 2
-- Continuation of 010_populate_gi_disorders.sql
-- Data extracted from GI.md

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
  v_prescription_herb_id INTEGER;
BEGIN
  SELECT id INTO v_digestive_id FROM herbal.body_systems WHERE name = 'Digestive';

  -- ============================================================================
  -- DISORDER: Irritable Bowel Syndrome
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Irritable Bowel Syndrome', v_digestive_id, 10)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Irritable bowel syndrome (IBS) is a common disorder characterized by cramping pain, gassiness, bloating, and changes in bowel habits. Symptoms can include constipation or diarrhea, or may alternate between constipation and diarrhea.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'While stress, anxiety, and other psychological issues are often pivotal, they are but components in a multifactorial matrix. Another factor to consider is intolerance to such common foods as wheat, corn, dairy products, coffee, tea, and citrus fruit.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Occasionally, infectious or parasitic organisms are involved', 3);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Stress-reduction training or counseling and support can help relieve IBS symptoms.', 4);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'The intensity is often related to the number of calories and the amount of fat in the meal. Fat, whether animal or vegetable, is a strong stimulus for colonic contractions.', 5);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'reverse the diarrhea and reduce any pathological mucus production.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Bitter'),
    'promote appropriate digestive secretions, and often will normalize bowel function on their own.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce localized mucosal reactions.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'help with any flatulence or colic.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'other than carminatives may be indicated if cramping is severe.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'are indicated if there is any hint of damage to the lining of the colon.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'help ease background stress.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Aperient'),
    'may be indicated temporarily if constipation is present. Do not use strong herbs, however, as there may be a rapid swing back to diarrhea.', 8);

  -- Specific Remedies (Action Herbs section mentions specific herbs)
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'),
    'can have a direct impact on IBS', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'),
    'can have a direct impact on IBS', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Myrica cerifera', 'Bayberry'),
    'astringent', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'),
    'wound-healing remedy', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Plantago major', 'Plantain'),
    'wound-healing remedy', 5);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'),
    'colic-relieving antispasmodic', 6);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. In addition, a warm infusion of an appropriate carminative nervine should be drunk frequently.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '1 part', 5);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 6);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Artemisia vulgaris', 'Mugwort'), get_or_create_action('Bitter'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Bitter'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Antispasmodic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 2);

  -- ============================================================================
  -- DISORDER: Ulcerative Colitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Ulcerative Colitis', v_digestive_id, 11)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Inflammatory bowel disease (IBD) refers to two chronic intestinal disorders: Crohn''s disease and ulcerative colitis', 1);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Astringent'),
    'may help stem blood loss.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Demulcent'),
    'soothe surface irritation.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Vulnerary'),
    'promote healing of ulcerations in the mucosal lining.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'aid the body in its attempt to control inappropriate inflammatory reactions.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'help relieve abdominal discomfort.', 5);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'help ease the muscular cramping in the bowel that causes much of the pain.', 6);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Immune Support'),
    'essential and must cover the whole range of issues involved.', 7);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'help combat any secondary infection that might arise.', 8);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Eliminative Support'),
    'must be given to the other organs of elimination.', 9);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'will help address the psychological components of the condition.', 10);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. At least 1 clove of raw garlic should be eaten every day, and a warm infusion of an appropriate carminative nervine should be drunk often.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), '2 parts', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 4);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), '1 part', 5);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), '1 part', 6);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Myrica cerifera', 'Bayberry'), get_or_create_action('Astringent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Agrimonia eupatoria', 'Agrimony'), get_or_create_action('Astringent'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Astringent'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Demulcent'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Symphytum officinale', 'Comfrey'), get_or_create_action('Vulnerary'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Vulnerary'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Matricaria recutita', 'Chamomile'), get_or_create_action('Nervine'), 2);

  -- ============================================================================
  -- DISORDER: Diverticulitis
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Diverticulitis', v_digestive_id, 12)
  RETURNING id INTO v_disorder_id;

  -- Notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'A diverticulum is a small, saclike pouch or hernation of the colonic mucosa that bulges outward through a weak spot in the colon wall; these are collectively known as di-verticula. About half of all Americans aged 60 to 80 and almost everyone over the age of 80 has diverticulosis, or the condition characterized by the presence of diverticula.', 1);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'When diverticula become inflamed, the disorder is called diverticulitis. This happens in 10% to 25% of people with diverticulosis.', 2);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Pain and tenderness associated with constipation that alternates with diarrhea.', 3);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Diverticulitis is common in industrialized countries where low-fiber diets are the norm, but rare in countries where people eat high-fiber diets rich in vegetables.', 4);

  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES (v_disorder_id,
    'Straining due to constipation increases pressure in the colon, which causes weak spots to bulge out and become diverticula.', 5);

  -- Actions Indicated
  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antispasmodic'),
    'help relieve abdominal pain caused by cramping around diverticula.', 1);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Anti-inflammatory'),
    'reduce the generalized inflammatory response within the colon.', 2);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Antimicrobial'),
    'help the body deal with any infection that might be present.', 3);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Carminative'),
    'lessen discomfort due to flatulence.', 4);

  INSERT INTO herbal.disorder_actions_indicated (disorder_id, primary_action_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_action('Nervine'),
    'ease stress, which may be either causal or a result of the condition.', 5);

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'),
    'is a very useful specific here. It is a good antispasmodic and anti-inflammatory herb, but also has a specific impact upon this condition.', 1);

  -- Prescription
  INSERT INTO herbal.disorder_prescriptions (disorder_id, instructions, sort_order)
  VALUES (v_disorder_id,
    'Dosage: 5 ml of tincture combination three times a day. An infusion of Matricaria or Mentha piperita sipped slowly throughout the day will help. One clove a day of garlic (Allium sativum) should be eaten raw as part of the diet, or an equivalent amount taken in supplement form. The supplement should be a 600 mg oil "perle" containing 6 mg of allicin.', 1)
  RETURNING id INTO v_prescription_id;

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), '2 parts', 1);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), '1 part', 2);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Viburnum opulus', 'Cramp Bark'), '1 part', 3);

  INSERT INTO herbal.prescription_herbs (prescription_id, herb_id, parts, sort_order)
  VALUES (v_prescription_id, get_or_create_herb('Mentha piperita', 'Peppermint'), '1 part', 4);

  -- Action Herbs
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Antispasmodic'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Viburnum opulus', 'Cramp Bark'), get_or_create_action('Antispasmodic'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Antispasmodic'), 3);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Dioscorea villosa', 'Wild Yam'), get_or_create_action('Anti-inflammatory'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Anti-inflammatory'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Allium sativum', 'Garlic'), get_or_create_action('Antimicrobial'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Carminative'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Carminative'), 2);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Valeriana officinalis', 'Valerian'), get_or_create_action('Nervine'), 1);

  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Mentha piperita', 'Peppermint'), get_or_create_action('Nervine'), 2);

  -- ============================================================================
  -- DISORDER: Liver Disease
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Liver Disease', v_digestive_id, 13)
  RETURNING id INTO v_disorder_id;

  -- Specific Remedies
  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Taraxacum officinale', 'Dandelion'), '', 1);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Silybum marianum', 'Milk Thistle'), '', 2);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Chelone glabra', 'Balmony'), '', 3);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Schisandra chinensis', 'Schisandra'), '', 4);

  INSERT INTO herbal.disorder_specific_remedies (disorder_id, herb_id, description, sort_order)
  VALUES (v_disorder_id, get_or_create_herb('Glycyrrhiza glabra', 'Licorice'), '', 5);

END $$;

-- Cleanup helper functions
DROP FUNCTION IF EXISTS get_or_create_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS get_or_create_action(TEXT);

-- ============================================================================
-- NOTE: Part 2 contains disorders 10-13
-- Remaining disorders to be added in part 3:
-- - Jaundice
-- - Chronic Hepatitis
-- - Viral Hepatitis
-- - Cirrhosis
-- - Cholecystitis
-- - Cholelithiasis
-- - Hemorrhoids
-- ============================================================================
