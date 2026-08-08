-- Migration 114: Remove "Flagged for detail" placeholder text and add food sources
SET search_path TO herbal, public;

DO $$ BEGIN RAISE NOTICE 'Cleaning up flagged supplements...'; END $$;

-- Strip the placeholder text from all descriptions in one pass
UPDATE herbal.supplements
  SET description = REPLACE(description, ' Flagged for detail.', '')
  WHERE description LIKE '% Flagged for detail.';

-- Add dietary sources and flesh out details for each formerly-flagged supplement

UPDATE herbal.supplements SET
  dietary_sources = 'Fresh garlic cloves; whole garlic bulbs (raw or cooked)',
  dose_range = '1–2 raw cloves/day, or 600–1,200 mg aged garlic extract/day',
  absorption_notes = 'Allicin — the active compound — is released when garlic is crushed or chopped and destroyed by heat. Raw garlic is most potent; aged garlic extract preserves many benefits.'
  WHERE name = 'Garlic';

UPDATE herbal.supplements SET
  dietary_sources = 'Brewer''s yeast itself; nutritional yeast (similar profile); beer contains trace amounts',
  dose_range = '1–2 tablespoons/day of powder or flakes',
  absorption_notes = 'Excellent source of B vitamins, chromium, and selenium. Nutritional yeast is a deactivated form with similar nutrient content.'
  WHERE name = 'Brewer''s Yeast';

UPDATE herbal.supplements SET
  dietary_sources = 'Red and yellow onions (richest source), capers, apples (skin on), berries, red grapes, broccoli, citrus fruits, green tea, kale',
  dose_range = '500–1,000 mg/day',
  absorption_notes = 'Absorbed better when taken with bromelain (pineapple enzyme). Fat-soluble; take with a meal containing fat.'
  WHERE name = 'Quercetin';

UPDATE herbal.supplements SET
  dietary_sources = 'Sweet potatoes, carrots, butternut squash, dark leafy greens (kale, spinach), red bell peppers, apricots, cantaloupe',
  dose_range = '15,000–25,000 IU/day (mixed carotenoids)',
  absorption_notes = 'Fat-soluble; absorption significantly increased when consumed with dietary fat. Preferred over retinol (preformed Vitamin A) as the body converts only as much as needed.'
  WHERE name = 'Beta-Carotene';

UPDATE herbal.supplements SET
  dietary_sources = 'Not a significant dietary food source; found in evening primrose plant seeds — not commonly eaten. GLA is also found in borage oil and black currant seed oil.',
  dose_range = '3–6 g/day GLA',
  absorption_notes = 'Anti-inflammatory via prostaglandin E1 pathway. Useful for PMS, eczema, diabetic neuropathy, and rheumatoid arthritis.'
  WHERE name = 'Evening Primrose Oil';

UPDATE herbal.supplements SET
  dietary_sources = 'Not found in food; produced by the adrenal glands from cholesterol. Levels decline significantly after age 30.',
  dose_range = '25–50 mg/day (use with caution; test levels first)',
  absorption_notes = 'Converted to estrogen and testosterone in peripheral tissues. Should only be used under guidance of a practitioner due to hormonal effects.'
  WHERE name = 'DHEA';

UPDATE herbal.supplements SET
  dietary_sources = 'Beef, pork, poultry, fish (especially cod and sardines), eggs, dairy, soybeans, quinoa, legumes',
  dose_range = '1,000–3,000 mg/day (for herpes suppression)',
  absorption_notes = 'Competes with arginine for absorption — high-arginine foods (nuts, chocolate, seeds) can reduce lysine''s antiviral effectiveness.'
  WHERE name = 'Lysine';

UPDATE herbal.supplements SET
  dietary_sources = 'Yogurt, kefir, fermented vegetables (sauerkraut, kimchi), miso, tempeh, buttermilk',
  dose_range = '1–10 billion CFU/day',
  absorption_notes = 'Survives stomach acid better when taken with food. Refrigerate live-culture products. Supports gut flora balance, immune function, and bile metabolism.'
  WHERE name = 'Lactobacillus acidophilus';

UPDATE herbal.supplements SET
  dietary_sources = 'Beef liver (richest source), egg yolks, soybeans, beef, chicken breast, fish (cod, salmon), shiitake mushrooms, cruciferous vegetables',
  dose_range = '425–550 mg/day (women); 550 mg/day (men)',
  absorption_notes = 'Essential for liver function, phosphatidylcholine synthesis, and methyl group metabolism. Deficiency can impair liver function and fat metabolism.'
  WHERE name = 'Choline';

UPDATE herbal.supplements SET
  dietary_sources = 'Flaxseeds (ground), flaxseed oil — the most concentrated ALA source. Chia seeds and walnuts also provide ALA but at lower concentrations.',
  dose_range = '1–2 tablespoons ground flaxseed or 1 teaspoon flaxseed oil/day',
  absorption_notes = 'ALA must be converted to EPA/DHA in the body — conversion rate is low. Keep refrigerated; highly prone to oxidation. Ground flaxseed preferred over whole seeds for absorption.'
  WHERE name = 'Flaxseed Oil';

UPDATE herbal.supplements SET
  dietary_sources = 'Mussels, wheat germ, tofu, brown rice, hazelnuts, pecans, pineapple, black and green tea, spinach, chickpeas',
  dose_range = '2–5 mg/day',
  absorption_notes = 'Cofactor for superoxide dismutase (antioxidant enzyme) and enzymes involved in bone and connective tissue formation. High calcium and iron intake can inhibit absorption.'
  WHERE name = 'Manganese';

UPDATE herbal.supplements SET
  dietary_sources = 'Whole grains, dark leafy greens, meat, fish, eggs, legumes, dairy — covers the range of individual B vitamins. No single food is rich in all B vitamins.',
  dose_range = 'Varies by formulation (B-50 or B-100 refers to mcg/mg of each B vitamin per capsule)',
  absorption_notes = 'Water-soluble; excess is excreted. B vitamins work synergistically — a complex is often more effective than individual B vitamins in isolation. Take with food to reduce nausea.'
  WHERE name = 'Vitamin B Complex';

-- CoQ10 was the only supplement labeled 'oil-soluble'; reclassify to 'fat-soluble' for consistency
UPDATE herbal.supplements SET solubility = 'fat-soluble' WHERE name = 'CoQ10 / Ubiquinol';

DO $$ BEGIN RAISE NOTICE 'Migration 114 complete.'; END $$;
