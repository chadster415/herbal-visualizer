-- Migration 466: herb_drug_interactions — American Family Physician (AAFP)
-- Source: "Common Herbal Dietary Supplement–Drug Interactions"
-- Gary N. Asher, Amanda H. Corbett, Roy L. Hawke
-- Am Fam Physician. 2017;96(2):101-107.
-- https://www.aafp.org/afp/2017/0715/p101
--
-- Imports only herbs with specific drug comments from the two interaction tables.
-- Herbs listed with "—" (Cranberry, Saw Palmetto, Valerian) are skipped.

INSERT INTO herbal.sources (short_name, display_name, full_title, authors, year, url)
VALUES (
  'aafp',
  'American Family Physician',
  'Common Herbal Dietary Supplement–Drug Interactions',
  'Gary N. Asher; Amanda H. Corbett; Roy L. Hawke',
  2017,
  'https://www.aafp.org/afp/2017/0715/p101'
);

GRANT SELECT ON herbal.herb_drug_interactions TO anon, authenticated;

DO $$
DECLARE v_src integer;
BEGIN
  SELECT id INTO v_src FROM herbal.sources WHERE short_name = 'aafp';

  -- Black Cohosh (25)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (25, v_src, 'Statins (HMG-CoA reductase inhibitors)', 'May reduce the effectiveness of statins; a single case report described elevated liver enzymes in a patient concurrently taking atorvastatin (Lipitor).');

  -- Ginkgo (165)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (165, v_src, 'Warfarin (Coumadin)', 'Potential increased bleeding risk with warfarin; considered low likelihood of clinically significant interaction based on clinical trial data.');

  -- American Ginseng (15)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (15, v_src, 'Warfarin (Coumadin)', 'May reduce International Normalized Ratio (INR) by approximately 0.2.'),
  (15, v_src, 'Antidiabetic drugs', 'May modestly reduce blood glucose levels; monitor blood glucose when co-administered with antidiabetic drugs.');

  -- Milk Thistle (206)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text) VALUES
  (206, v_src, 'CYP2C9 substrates (warfarin, phenytoin, diazepam)', 'May decrease plasma concentrations of medications metabolized by CYP2C9, including warfarin (Coumadin), phenytoin (Dilantin), and diazepam (Valium).');

  -- Goldenseal (30)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text, severity) VALUES
  (30, v_src, 'Most OTC and prescription medications', 'Strongly recommended to avoid in combination with most over-the-counter and prescription medications due to significant inhibition of drug-metabolizing enzymes.', 'major');

  -- St. John''s Wort (81)
  INSERT INTO herbal.herb_drug_interactions (herb_id, source_id, drug_or_class, interaction_text, severity) VALUES
  (81, v_src, 'Immunosuppressants (cyclosporine, tacrolimus)', 'Can reduce effectiveness of cyclosporine (Sandimmune) and tacrolimus (Prograf); avoid combining.', 'major'),
  (81, v_src, 'Anticoagulants (warfarin)', 'Can reduce effectiveness of warfarin (Coumadin); avoid combining.', 'major'),
  (81, v_src, 'HIV protease inhibitors', 'Can reduce effectiveness of HIV protease inhibitors; avoid combining.', 'major'),
  (81, v_src, 'Antineoplastics / Narrow-index drugs (irinotecan, theophylline, digoxin)', 'Can reduce effectiveness of irinotecan (Camptosar), theophylline, and digoxin; avoid combining.', 'major'),
  (81, v_src, 'Antidepressants (venlafaxine)', 'Can reduce effectiveness of venlafaxine; avoid combining due to risk of reduced efficacy and possible serotonin syndrome.', 'moderate'),
  (81, v_src, 'Oral contraceptives', 'Can reduce effectiveness of oral contraceptives; avoid combining.', 'moderate');

END $$;
