-- Migration 463: herb_drug_interactions table + itmonline source data
-- Source: "Checking for Possible Herb-Drug Interactions" by Subhuti Dharmananda, Ph.D.
-- Institute for Traditional Medicine (ITM Online), 2003

-- 1. Add url column to sources table
ALTER TABLE herbal.sources ADD COLUMN IF NOT EXISTS url text;

-- 2. Create herb_drug_interactions table
CREATE TABLE herbal.herb_drug_interactions (
  id         serial PRIMARY KEY,
  herb_id    integer NOT NULL REFERENCES herbal.herbs(id),
  source_id  integer NOT NULL REFERENCES herbal.sources(id),
  drug_or_class  text NOT NULL,
  interaction_text text NOT NULL,
  severity   text,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE herbal.herb_drug_interactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "anon_read" ON herbal.herb_drug_interactions FOR SELECT USING (true);

-- 3. Insert itmonline source
INSERT INTO herbal.sources (short_name, display_name, full_title, authors, year, url)
VALUES (
  'itmonline',
  'ITM Online',
  'Checking for Possible Herb-Drug Interactions',
  'Subhuti Dharmananda, Ph.D.',
  2003,
  'http://www.itmonline.org/arts/herbdrug2.htm'
);

-- 4. Insert interactions
DO $$
DECLARE v_src integer;
BEGIN
  SELECT id INTO v_src FROM herbal.sources WHERE short_name = 'itmonline';

  -- Cayenne (47)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (47, v_src, 'Topical medications / General',
   'External: potential for skin ulceration and blistering with greater than 2 days of topical use. Internal: overuse may cause severe hypothermia.');

  -- Echinacea (26)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (26, v_src, 'Anabolic steroids, Methotrexate',
   'May cause inflammation of the liver if used with certain other medications, such as anabolic steroids, methotrexate, or others.');

  -- Ma Huang / Ephedra (448)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (448, v_src, 'Antidepressants, Antihypertensives',
   'May interact with certain antidepressant medications or certain high blood pressure medications to cause dangerous elevation in blood pressure or heart rate. Could cause death in certain individuals.');

  -- Feverfew (121)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (121, v_src, 'Anticoagulants / Antiplatelets',
   'May increase bleeding, especially in patients already taking certain anti-clotting medications. Listed as an antiplatelet herb by Rountree (2001) and Abebe (2002).');

  -- Garlic (21)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (21, v_src, 'Anticoagulants / Antiplatelets',
   'May increase bleeding, especially in patients already taking certain anti-clotting medications. Garlic has antiplatelet activity; avoid concentrated extracts or monitor bleeding time carefully while on anticoagulant therapy. Fresh garlic in food is generally considered safe at moderate levels.'),
  (21, v_src, 'Warfarin',
   'A suspected interaction between garlic and Warfarin may increase blood thinning effect. One review lists garlic among herbs with interactions (increased blood thinning with bleeding) confirmed by laboratory studies; however, clinical case reports are limited.');

  -- Ginger (124)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (124, v_src, 'Anticoagulants / Antiplatelets',
   'May increase bleeding, especially in patients already taking certain anti-clotting medications. Ginger has antiplatelet activity. Fresh ginger in food or a cup of tea is generally considered safe at moderate levels; avoid concentrated extracts while on anticoagulant therapy.');

  -- Ginkgo (165) — three entries
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (165, v_src, 'Anticoagulants (Warfarin), Antiplatelets (aspirin, dipyridamole, ticlopidine)',
   'Ginkgo inhibits platelet aggregation. Preferably avoid use in patients on antiplatelet or anticoagulant therapy. Monitor bleeding time and prothrombin time (PT) if taken concurrently. At least three cases of brain hemorrhage have been attributed to ginkgo. The most common potential herb-drug interaction in one elderly memory clinic population study was ginkgo and aspirin (8 of 11 identified interactions). Avoid concentrated standardized extracts (e.g., 50:1 concentrate) while taking anticoagulants; a cup of ginkgo tea or a dropperful of tincture is less likely to cause problems. Ginkgo antiplatelet cautions appear based on case reports that still require verification.'),
  (165, v_src, 'Monoamine Oxidase Inhibitors (MAOIs)',
   'Ginkgo may increase the activity or toxicity of monoamine oxidase inhibitors.'),
  (165, v_src, 'Trazodone',
   'A potential interaction between ginkgo and trazodone has been identified in an elderly memory clinic population (Dergal et al., Drugs and Aging, 2002).');

  -- Ginseng (14)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (14, v_src, 'Anticoagulants, Antihypertensives',
   'May cause decreased effectiveness of certain anti-clotting medications. May also cause increased heart rate or high blood pressure. May cause bleeding in women after menopause. A potential interaction between ginseng and amlodipine (a calcium channel blocker) has been identified in an elderly memory clinic population (Dergal et al., 2002). Ginseng has antiplatelet activity; avoid concentrated forms while on anticoagulant therapy.');

  -- Goldenseal (30)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (30, v_src, 'Antihypertensives, Anticoagulants (pro-coagulant risk)',
   'May worsen swelling and/or high blood pressure. Goldenseal contains berberine, a pro-coagulant compound that may counteract the effect of anticoagulants by decreasing blood-clotting time, potentially reducing Warfarin effectiveness.');

  -- Kava (138)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (138, v_src, 'Anticonvulsants, Anesthetics, Alcohol, CNS medications',
   'May increase the effects of certain anti-seizure medications and/or prolong the effects of certain anesthetic agents. Can enhance the effects of alcohol. May increase the risk of suicide for people with certain types of depression.');

  -- Licorice (78)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (78, v_src, 'Antihypertensives, Diuretics',
   'Certain licorice compounds may cause high blood pressure, swelling, or electrolyte imbalances, potentially interfering with antihypertensive or diuretic therapies.');

  -- Saw Palmetto (186)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (186, v_src, 'Hormone therapies',
   'People using saw palmetto may see additive or opposing effects with other hormone therapies.');

  -- St. John's Wort (81) — three entries
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (81, v_src, 'Anesthetics',
   'May prolong the effect of certain anesthetic agents.'),
  (81, v_src, 'Cyclosporin (immunosuppressants)',
   'Hazardous pharmacokinetic interaction: St. John''s Wort may cause a sudden, remarkable decrease in cyclosporin trough concentrations. Low cyclosporin levels are associated with increased risk of organ transplant rejection. In one reported case, a kidney transplant patient on cyclosporin for many years experienced a sudden drop in trough concentrations upon starting St. John''s Wort; re-challenge gave similar results. St. John''s Wort has been blamed for several instances of transplant rejection. Use of St. John''s Wort declined dramatically after this interaction was identified. (Mai et al., International Journal of Clinical Pharmacology and Therapeutics, 2000.)'),
  (81, v_src, 'Warfarin (anticoagulants)',
   'May increase blood thinning effect, with risk of bleeding. St. John''s Wort is the most common herbal product reported in drug-herb interactions. Its constituents (including hypericin) affect drug-metabolizing enzymes such as cytochrome P450, which can alter plasma levels of many drugs. St. John''s Wort has the strongest evidence base of any herb for clinically significant drug interactions.');

  -- Valerian (145)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (145, v_src, 'Anticonvulsants, Anesthetics, Benzodiazepines',
   'May increase the effects of certain anti-seizure medications or prolong the effects of certain anesthetic agents. A potential interaction between valerian and lorazepam (a benzodiazepine) has been identified in an elderly memory clinic population (Dergal et al., Drugs and Aging, 2002).');

  -- Dan Shen (956)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (956, v_src, 'Warfarin (anticoagulants)',
   'Danshen (salvia, Salvia miltiorrhiza) may cause excessive blood thinning when combined with Warfarin, leading to bleeding risk. In a pharmacology study, rats received 5 g/kg body weight — a very large dose. Informally reported clinical cases of bleeding have been associated with this combination, though formal published case reports are limited. Also listed as having anticoagulant and antiplatelet activity in Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986).');

  -- Dong Quai (1009)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1009, v_src, 'Warfarin (anticoagulants)',
   'Dong quai (tang-kuei, Angelica sinensis) has anti-coagulant activity and contains coumarin compounds. It may interact with Warfarin, increasing blood thinning effect. Interaction is suspected based on pharmacology studies; the dosage threshold in clinical practice remains unclear. One review lists dong quai among herbs with suspected or confirmed interactions (increased blood thinning/bleeding) with Warfarin.');

  -- Chamomile (84)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (84, v_src, 'Warfarin (anticoagulants)',
   'Chamomile has anti-coagulant activity via coumarin content, which may interact with Warfarin or other anticoagulants, enhancing blood-thinning effects. Listed in the anti-coagulant herb category by Rountree (2001).');

  -- Horse Chestnut (62)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (62, v_src, 'Warfarin (anticoagulants)',
   'Horse chestnut has anti-coagulant activity via coumarin content, which may interact with Warfarin or other anticoagulants, enhancing blood-thinning effects. Listed in the anti-coagulant herb category by Rountree (2001).');

  -- Bilberry (1160)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1160, v_src, 'NSAIDs (aspirin), Anticoagulants / Antiplatelets',
   'Bilberry has antiplatelet activity, which may enhance the risk of bleeding when used with NSAIDs (particularly aspirin), antiplatelet drugs, or anticoagulants such as Warfarin. Listed in the antiplatelet herb category by Rountree (2001) and Abebe (2002).');

  -- Tea / Green Tea (149)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (149, v_src, 'Anticoagulants / Antiplatelets',
   'Green tea has antiplatelet activity. A daily cup or two is generally considered safe; however, higher intake may interact with anticoagulants or antiplatelet drugs. Listed in the antiplatelet herb category by Rountree (2001).');

  -- Meadowsweet (75)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (75, v_src, 'NSAIDs (aspirin), Anticoagulants / Antiplatelets',
   'Meadowsweet has antiplatelet activity and contains coumarin, which may enhance the risk of bleeding when used with NSAIDs (particularly aspirin), antiplatelet drugs, or anticoagulants such as Warfarin. Listed in both the antiplatelet and coumarin herb categories by Rountree (2001) and Abebe (2002).');

  -- Motherwort (131)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (131, v_src, 'NSAIDs (aspirin), Anticoagulants / Antiplatelets',
   'Motherwort has antiplatelet activity and contains coumarin, which may enhance the risk of bleeding when used with NSAIDs (particularly aspirin), antiplatelet drugs, or anticoagulants such as Warfarin. Listed in both the antiplatelet and coumarin herb categories by Rountree (2001) and Abebe (2002).');

  -- Turmeric (203)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (203, v_src, 'NSAIDs (aspirin), Anticoagulants / Antiplatelets',
   'Turmeric has antiplatelet activity, which may enhance the risk of bleeding when used with NSAIDs (particularly aspirin), antiplatelet drugs, or anticoagulants such as Warfarin. Listed in the antiplatelet herb category by Rountree (2001) and Abebe (2002), and in the TCM anticoagulant/antiplatelet herb list in Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986).');

  -- Oregon Grape (33)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (33, v_src, 'Anticoagulants (Warfarin)',
   'Oregon grape root has pro-coagulant properties, likely because it contains berberine. Berberine may counteract the effect of anticoagulants by decreasing blood-clotting time, potentially reducing Warfarin effectiveness. Listed in the pro-coagulant herb category by Rountree (2001).');

  -- Shepherd''s Purse (71)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (71, v_src, 'Anticoagulants (Warfarin)',
   'Shepherd''s purse has pro-coagulant properties, possibly because it contains vitamin K. This may interfere with anticoagulants such as Warfarin by counteracting their blood-thinning effect. Listed in the pro-coagulant herb category by Rountree (2001).');

  -- Cinnamon (167)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (167, v_src, 'Anticoagulants / Antiplatelets',
   'Cinnamon bark has anticoagulant and antiplatelet activity per Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986), which may interact with anticoagulants or antiplatelet drugs.');

  -- Zedoary Rhizome (1539) and Zedoary (2245) — same plant, both DB entries
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1539, v_src, 'Anticoagulants / Antiplatelets',
   'Zedoaria (Curcuma zedoaria) has anticoagulant and antiplatelet activity per Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986), which may interact with anticoagulants or antiplatelet drugs.'),
  (2245, v_src, 'Anticoagulants / Antiplatelets',
   'Zedoaria (Curcuma zedoaria) has anticoagulant and antiplatelet activity per Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986), which may interact with anticoagulants or antiplatelet drugs.');

  -- Safflower / Carthamus (1557)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1557, v_src, 'Anticoagulants / Antiplatelets',
   'Carthamus (safflower, hong hua) has anticoagulant and antiplatelet activity per Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986), which may interact with anticoagulants or antiplatelet drugs.');

  -- Kudzu Root (1547)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1547, v_src, 'Anticoagulants / Antiplatelets',
   'Pueraria (kudzu root, ge gen) has anticoagulant and antiplatelet activity per Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986), which may interact with anticoagulants or antiplatelet drugs.');

  -- Pseudoginseng / Notoginseng (1599)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1599, v_src, 'Anticoagulants / Antiplatelets',
   'Tien-chi (san qi, Panax notoginseng) has anticoagulant and antiplatelet activity per Pharmacology and Applications of Chinese Materia Medica (Chang & But, 1986), which may interact with anticoagulants or antiplatelet drugs.');

END $$;
