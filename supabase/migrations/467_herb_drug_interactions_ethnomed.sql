-- Migration 467: herb_drug_interactions — EthnoMed (UW Medicine)
-- Source: "Chinese and Western Herbal Medicine: A Guide to Potential Risks and Drug Interactions"
-- EthnoMed, Harborview Medical Center, University of Washington
-- Originally published 2004; updated January 2021
-- https://ethnomed.org/resource/chinese-and-western-herbal-medicine-a-guide-to-potential-risks-and-drug-interactions/
--
-- Article covers TCM and Western herb-drug interactions organized by drug class.
-- The main reference table is a linked PDF; body text is the source for all rows here.
-- Herbs without a confirmed DB match (Ligusticum chuanxiong / Chuan Xiong,
-- Polyporus umbellatus / Zhu Ling, Scrophularia ningpoensis / Xuan Shen) are skipped.

INSERT INTO herbal.sources (short_name, display_name, full_title, authors, year, url)
VALUES (
  'ethnomed',
  'EthnoMed (UW Medicine)',
  'Chinese and Western Herbal Medicine: A Guide to Potential Risks and Drug Interactions',
  'EthnoMed, Harborview Medical Center, University of Washington',
  2004,
  'https://ethnomed.org/resource/chinese-and-western-herbal-medicine-a-guide-to-potential-risks-and-drug-interactions/'
);

GRANT SELECT ON herbal.herb_drug_interactions TO anon, authenticated;

DO $$
DECLARE v_src integer;
BEGIN
  SELECT id INTO v_src FROM herbal.sources WHERE short_name = 'ethnomed';

  -- === Anticoagulants / Warfarin ===
  -- Listed as TCM herbs with the greatest potential for interfering with anticoagulants

  -- Dan Shen (956)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (956, v_src, 'Anticoagulants / Warfarin (Coumadin)', 'Dan Shen (Salvia miltiorrhiza) is a TCM herb with the greatest potential for interfering with anticoagulants. Combining with Coumadin (warfarin) should be avoided unless under guidance of an experienced healthcare professional.');

  -- Dong Quai (1009)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1009, v_src, 'Anticoagulants / Warfarin (Coumadin)', 'Dang Gui (Angelica sinensis) is a TCM herb with the greatest potential for interfering with anticoagulants. Combining with Coumadin (warfarin) should be avoided unless under guidance of an experienced healthcare professional.');

  -- Safflower / Hong Hua (1557)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1557, v_src, 'Anticoagulants / Warfarin (Coumadin)', 'Hong Hua (Carthamus tinctorius) is a TCM herb with the greatest potential for interfering with anticoagulants. Combining with Coumadin (warfarin) should be avoided unless under guidance of an experienced healthcare professional.');

  -- Peach / Tao Ren (320) — interaction applies specifically to peach kernel (Semen persicae)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (320, v_src, 'Anticoagulants / Warfarin (Coumadin)', 'Tao Ren (Semen persicae — peach kernel) is a TCM herb with the greatest potential for interfering with anticoagulants. Combining with Coumadin (warfarin) should be avoided unless under guidance of an experienced healthcare professional.');

  -- === Sympathomimetic / Cardiovascular drugs ===

  -- Ma Huang / Ephedra (448)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (448, v_src, 'Sympathomimetic drugs / Cardiovascular drugs', 'Ephedra (Ma Huang) contains ephedrine and pseudoephedrine, which interfere with sympathomimetic and cardiovascular drugs.'),
  (448, v_src, 'Narrow therapeutic index drugs (warfarin, digoxin, theophylline, lithium)', 'As a herbal stimulant, Ephedra (Ma Huang) should not be combined with drugs with a narrow therapeutic range such as warfarin, digitalis, theophylline, and lithium.');

  -- === Diuretic drugs ===

  -- Alisma / Ze Xie (1638)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1638, v_src, 'Diuretic drugs', 'Ze Xie (Alisma orientalis) is used in TCM for its diuretic effects and may increase or decrease the effects of diuretic drugs when taken concurrently.');

  -- === Antidiabetic drugs ===

  -- Anemarrhena / Zhi Mu (1640)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1640, v_src, 'Antidiabetic drugs', 'Zhi Mu (Anemarrhena asphodeloides) is used in TCM for blood sugar regulation and may interact with antidiabetic drugs; blood glucose should be monitored.');

  -- Black Atractylodes / Cang Zhu (1518)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1518, v_src, 'Antidiabetic drugs', 'Cang Zhu (Black Atractylodes) is used in TCM for blood sugar regulation and may interact with antidiabetic drugs; blood glucose should be monitored.');

  -- Chinese Yam / Shan Yao (2750)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (2750, v_src, 'Antidiabetic drugs', 'Shan Yao (Dioscorea opposita) is used in TCM for blood sugar regulation and may interact with antidiabetic drugs; blood glucose should be monitored.');

  -- Astragalus / Huang Qi (225)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (225, v_src, 'Antidiabetic drugs', 'Huang Qi (Astragalus membranaceus) is used in TCM for blood sugar regulation and may interact with antidiabetic drugs; blood glucose should be monitored.');

  -- === Narrow therapeutic index drugs ===
  -- Potassium-lowering herbs should not be combined with warfarin, digitalis, theophylline, lithium

  -- Licorice (78)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (78, v_src, 'Narrow therapeutic index drugs (warfarin, digoxin, theophylline, lithium)', 'The potassium-lowering effect of licorice should not be combined with drugs with a narrow therapeutic range including warfarin (Coumadin), digitalis, theophylline, and lithium.');

  -- Aloe (202) — applies to oral laxative use
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (202, v_src, 'Narrow therapeutic index drugs (warfarin, digoxin, theophylline, lithium)', 'The potassium-lowering effect of oral aloe laxative use should not be combined with drugs with a narrow therapeutic range including warfarin (Coumadin), digitalis, theophylline, and lithium.');

  -- Guarana (218)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (218, v_src, 'Narrow therapeutic index drugs / Stimulant drugs', 'As a herbal stimulant containing caffeine, guarana should not be combined with drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium) or other stimulant medications.');

  -- Green Tea / Tea (149)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (149, v_src, 'Narrow therapeutic index drugs / Stimulant drugs', 'Green tea, as a caffeinated herbal stimulant, should not be combined with drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium) or other stimulant medications.');

  -- === Antiplatelet herbs ===
  -- Should not be combined with anticoagulants or narrow therapeutic index drugs

  -- Ginkgo (165)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (165, v_src, 'Antiplatelet agents / Anticoagulants', 'Ginkgo is identified as an antiplatelet herb and should not be combined with anticoagulants or drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium).');

  -- Bilberry (1160)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1160, v_src, 'Antiplatelet agents / Anticoagulants', 'Bilberry leaf is identified as an antiplatelet herb and should not be combined with anticoagulants or drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium).');

  -- Ginger (124)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (124, v_src, 'Antiplatelet agents / Anticoagulants', 'Ginger is identified as an antiplatelet herb and should not be combined with anticoagulants or drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium).');

  -- Black Cohosh (25)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (25, v_src, 'Antiplatelet agents / Anticoagulants', 'Black cohosh is identified as an antiplatelet herb and should not be combined with anticoagulants or drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium).');

  -- Chamomile (84)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (84, v_src, 'Antiplatelet agents / Anticoagulants', 'Chamomile is identified as an antiplatelet herb and should not be combined with anticoagulants or drugs with a narrow therapeutic range (warfarin, digitalis, theophylline, lithium).');

END $$;
