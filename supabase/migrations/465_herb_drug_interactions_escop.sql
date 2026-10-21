-- Migration 465: herb_drug_interactions — ESCOP Monographs
-- Source: "Table of herb-drug interactions based on the monographs of ESCOP"
-- European Scientific Cooperative on Phytotherapy (ESCOP)
-- https://www.escop.com/interactions/
--
-- Only herbs with actual (non-"None reported") interactions are imported.
-- Ispaghula husk/seed (Plantago ovata) mapped to Psyllium (id 2240).
-- Barbados Aloes (Aloe barbadensis = Aloe vera) mapped to Aloe (id 202); interaction applies to oral laxative use.
-- ESCOP "Ginseng" = Panax ginseng (id 14); American Ginseng (id 15) is a distinct entry with no ESCOP interactions listed.

INSERT INTO herbal.sources (short_name, display_name, full_title, authors, year, url)
VALUES (
  'escop',
  'ESCOP Monographs',
  'Table of herb-drug interactions based on the monographs of ESCOP',
  'European Scientific Cooperative on Phytotherapy (ESCOP)',
  NULL,
  'https://www.escop.com/interactions/'
);

GRANT SELECT ON herbal.herb_drug_interactions TO anon, authenticated;

DO $$
DECLARE v_src integer;
BEGIN
  SELECT id INTO v_src FROM herbal.sources WHERE short_name = 'escop';

  -- Agnus Castus / Chasteberry (190)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (190, v_src, 'Dopamine agonists / Dopamine antagonists', 'Interactions cannot be excluded due to possible dopaminergic effects of Vitex agnus-castus preparations.'),
  (190, v_src, 'Oestrogens / Antioestrogens', 'Interactions cannot be excluded due to possible oestrogenic effects of Vitex agnus-castus preparations.');

  -- Aloe vera (202) — ESCOP Barbados Aloes entry; Aloe barbadensis Mill. = Aloe vera; applies to oral laxative use
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (202, v_src, 'Cardiac glycosides / Antiarrhythmic drugs', 'Hypokalaemia resulting from long-term laxative use potentiates the action of cardiac glycosides and interacts with antiarrhythmic drugs and drugs which induce reversion to sinus rhythm (e.g. quinidine).'),
  (202, v_src, 'Diuretics / Adrenocorticosteroids', 'Concomitant use with other drugs inducing hypokalaemia (e.g. thiazide diuretics, adrenocorticosteroids) may aggravate electrolyte imbalance.');

  -- Cayenne / Capsicum (47)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (47, v_src, 'Topical analgesics / Rubefacients', 'Not to be applied topically together with other external products (e.g. other rubefacient or pain-relieving gels) at the same application site.');

  -- Cascara Sagrada (205)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (205, v_src, 'Cardiac glycosides / Antiarrhythmic drugs', 'Hypokalaemia resulting from long-term laxative use potentiates the action of cardiac glycosides and interacts with antiarrhythmic drugs and drugs which induce reversion to sinus rhythm (e.g. quinidine).'),
  (205, v_src, 'Diuretics / Adrenocorticosteroids', 'Concomitant use with other drugs inducing hypokalaemia (e.g. thiazide diuretics, adrenocorticosteroids and liquorice root) may aggravate electrolyte imbalance.');

  -- Cranberry (1212)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (1212, v_src, 'Warfarin', 'A pharmacokinetic interaction between cranberry juice and warfarin is highly unlikely, despite some reports involving excessive cranberry consumption.');

  -- Garlic (21)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (21, v_src, 'Anticoagulants (warfarin, fluindione)', 'An increased International Normalized Ratio (INR) has been observed in patients on warfarin or fluindione who used garlic products.'),
  (21, v_src, 'HIV protease inhibitors (saquinavir, ritonavir)', 'The results of pharmacokinetic studies with saquinavir and ritonavir in healthy volunteers remain unclear.');

  -- Ginger (124)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (124, v_src, 'CYP3A4 / CYP2C9 / P-glycoprotein substrates', 'Potential (theoretical) risk of drug interactions via inhibition of CYP3A4, CYP2C9, and P-glycoprotein.'),
  (124, v_src, 'Anticoagulants / Antiplatelets (warfarin, phenprocoumon, dabigatran)', 'Use with caution when co-administered with anticoagulant or antiplatelet agents (e.g. phenprocoumon, warfarin, dabigatran) as well as with nifedipine, antidiabetic drugs, metronidazole, and crizotinib.');

  -- Ginkgo (165)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (165, v_src, 'Anticoagulants / Antiplatelet agents', 'An interaction with substances that inhibit blood coagulation cannot be excluded; however, no such interactions have been observed in controlled clinical studies.');

  -- Ginseng / Panax ginseng (14)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (14, v_src, 'Antidiabetic drugs', 'Ginseng may slightly reduce blood glucose levels; monitor blood glucose when co-administered with antidiabetic drugs.'),
  (14, v_src, 'Warfarin', 'Interaction of ginseng with warfarin is possible.');

  -- Goldenseal (30)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (30, v_src, 'CYP3A4/5 substrates (e.g. midazolam)', 'Investigations in healthy volunteers revealed significant interactions with drugs metabolized by cytochrome P450 3A4/5 (e.g. midazolam).'),
  (30, v_src, 'CYP2D6 substrates (e.g. debrisoquin)', 'Investigations in healthy volunteers revealed significant interactions with drugs metabolized by cytochrome P450 2D6 (e.g. debrisoquin).');

  -- Guarana (218)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (218, v_src, 'Caffeine-containing products / Psychostimulants', 'Due to the caffeine content, concomitant intake of caffeine-containing drinks or psycho-analeptic medicines may produce a stronger caffeine effect.');

  -- Kola (150)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (150, v_src, 'Caffeine-containing products / Psychostimulants', 'Due to the caffeine content, concomitant intake of caffeine-containing drinks or psycho-analeptic medicines may produce a stronger caffeine effect.');

  -- Licorice (78)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (78, v_src, 'Cardiac glycosides / Antiarrhythmic drugs', 'Hypokalaemia resulting from excessive use of liquorice root may potentiate the action of cardiac glycosides and interact with antiarrhythmic drugs or drugs which induce reversion to sinus rhythm (e.g. quinidine).'),
  (78, v_src, 'Potassium-depleting drugs (diuretics, corticosteroids, stimulant laxatives)', 'Concomitant use with thiazide diuretics, adrenocorticosteroids, and stimulant laxatives may aggravate electrolyte imbalance due to additive hypokalaemia.');

  -- Marshmallow (45)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (45, v_src, 'Oral medications (general — absorption delayed)', 'Absorption of concomitantly administered medications may be delayed. Other medications should be taken at least 30-60 minutes before marshmallow root.');

  -- Flax / Linseed (180)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (180, v_src, 'Oral medications (general — absorption delayed)', 'Absorption of concomitantly administered medications may be delayed. Other medications should be taken at least 30-60 minutes before linseed. Diabetics should be aware of a potential delay in glucose absorption.');

  -- Peppermint (55) — peppermint oil use
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (55, v_src, 'H2 receptor blockers / Proton pump inhibitors', 'Patients with achlorhydria caused by H2 receptor blockers should use peppermint oil only in enteric-coated capsules to prevent premature release in the stomach.');

  -- Psyllium (2240) — covers ESCOP Ispaghula husk, Ispaghula seed, and Psyllium seed entries (all Plantago ovata)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (2240, v_src, 'Minerals / Vitamins / Cardiac glycosides / Coumarins', 'Enteral absorption of concomitantly administered minerals (calcium, iron, lithium, zinc), vitamins (B12), cardiac glycosides, and coumarin derivatives may be delayed; other medications should be taken at least 30-60 minutes before psyllium.'),
  (2240, v_src, 'Insulin / Antidiabetic drugs', 'In insulin-dependent diabetics it may be necessary to reduce the insulin dose due to delayed glucose absorption.');

  -- Rhubarb (154)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (154, v_src, 'Cardiac glycosides / Antiarrhythmic drugs', 'Hypokalaemia from long-term laxative abuse potentiates the action of cardiac glycosides and interacts with antiarrhythmic drugs or drugs which induce reversion to sinus rhythm (e.g. quinidine).'),
  (154, v_src, 'Potassium-depleting drugs (thiazide diuretics, corticosteroids)', 'Concomitant use with thiazide diuretics, adrenocorticosteroids, and liquorice root may aggravate hypokalaemia.');

  -- Saw Palmetto (186)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (186, v_src, 'Warfarin', 'Few case reports of suspected interactions with warfarin; increased International Normalized Ratio (INR) values have been described.');

  -- Senna (216) — covers both Senna leaf and Senna pods entries
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (216, v_src, 'Cardiac glycosides / Antiarrhythmic drugs', 'Hypokalaemia from long-term laxative abuse potentiates the action of cardiac glycosides and interacts with antiarrhythmic drugs or drugs which induce reversion to sinus rhythm (e.g. quinidine).'),
  (216, v_src, 'Potassium-depleting drugs (thiazide diuretics, corticosteroids)', 'Concomitant use with thiazide diuretics, adrenocorticosteroids, and liquorice root may aggravate hypokalaemia.');

  -- St. John's Wort (81)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text, severity) VALUES
  (81, v_src, 'CYP450 enzyme induction / P-glycoprotein induction', 'Preparations providing >1000 mg drug equivalent or >1 mg hyperforin daily can induce CYP450 enzymes and P-glycoprotein, reducing plasma concentrations of many co-administered drugs including amitriptyline, fexofenadine, benzodiazepines, methadone, simvastatin, finasteride, and digoxin.', NULL),
  (81, v_src, 'Cyclosporine / Tacrolimus (contraindicated)', 'Concomitant use is contraindicated; CYP450 induction can significantly reduce cyclosporine and tacrolimus plasma concentrations, risking transplant rejection.', 'major'),
  (81, v_src, 'HIV protease inhibitors (amprenavir, indinavir — contraindicated)', 'Concomitant use is contraindicated due to risk of reduced antiretroviral plasma concentrations.', 'major'),
  (81, v_src, 'Irinotecan (contraindicated)', 'Concomitant use is contraindicated due to risk of reduced plasma concentrations of this chemotherapy agent.', 'major'),
  (81, v_src, 'Anticoagulants (warfarin, phenprocoumon — contraindicated)', 'Concomitant use is contraindicated due to risk of reduced anticoagulant plasma concentrations and loss of anticoagulant effect.', 'major'),
  (81, v_src, 'Oral contraceptives', 'Reduction of plasma concentrations of oral contraceptives may cause mid-cycle bleeding; additional contraceptive measures are recommended due to possible reduction in contraceptive efficacy.', 'moderate'),
  (81, v_src, 'Antidepressants (serotonin syndrome risk)', 'Several cases of serotonergic effects have been reported after concomitant use with serotonergic antidepressants; the attribution to St. John''s wort remains unclear.', 'moderate');

  -- White Horehound (160)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (160, v_src, 'Glibenclamide / Sulfonylurea antidiabetics', 'A clinical trial with diabetic patients taking glibenclamide linked consumption of an aqueous White Horehound extract with minor symptoms of nausea, oral dryness or salivation, and dizziness.');

  -- Willow (87) — Willow bark
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (87, v_src, 'Anticoagulants (oral)', 'Willow bark may slightly increase the effects of oral anticoagulants due to its salicylate content.');

END $$;
