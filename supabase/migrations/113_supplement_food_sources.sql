-- Migration 113: Fill in missing dietary_sources for vitamins, minerals, and other supplements
SET search_path TO herbal, public;

DO $$ BEGIN RAISE NOTICE 'Adding food sources to supplements...'; END $$;

UPDATE herbal.supplements SET dietary_sources = 'Beef liver, sweet potatoes, carrots, dark leafy greens (kale, spinach), egg yolks, butter, cod liver oil'
  WHERE name = 'Vitamin A' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Beef liver, lamb, milk, yogurt, almonds, mushrooms, eggs, quinoa, spinach'
  WHERE name = 'Vitamin B2 (Riboflavin)' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Beef liver, sunflower seeds, salmon, avocado, portobello mushrooms, eggs, sweet potato, lentils'
  WHERE name = 'Vitamin B5 (Pantothenic Acid)' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Turkey, chicken breast, tuna, salmon, beef, chickpeas, potatoes, bananas, pistachios'
  WHERE name = 'Vitamin B6 (Pyridoxine)' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Dark leafy greens (spinach, romaine), asparagus, brussels sprouts, avocado, broccoli, citrus fruits, beans, lentils'
  WHERE name = 'Vitamin B9 (Folic Acid)' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Bell peppers, citrus fruits (oranges, grapefruit), kiwi, strawberries, broccoli, tomatoes, brussels sprouts, papaya'
  WHERE name = 'Vitamin C' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Fatty fish (salmon, mackerel, tuna, sardines), egg yolks, mushrooms exposed to UV light, fortified dairy and plant milks'
  WHERE name = 'Vitamin D' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Sunflower seeds, almonds, hazelnuts, avocado, spinach, wheat germ oil, olive oil, peanut butter'
  WHERE name = 'Vitamin E' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Dairy products (milk, yogurt, cheese), sardines, salmon (with bones), dark leafy greens, tofu, almonds, fortified plant milks, sesame seeds'
  WHERE name = 'Calcium' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Broccoli, whole grains, grape juice, potatoes, lean beef, turkey, green beans, basil'
  WHERE name = 'Chromium' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Beef liver, oysters, cashews, sesame seeds, dark chocolate, lobster, shiitake mushrooms, sunflower seeds'
  WHERE name = 'Copper' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Seaweed (nori, kelp), cod, shrimp, eggs, tuna, iodized salt, dairy products, scallops'
  WHERE name = 'Iodine' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Found in trace amounts in grains, vegetables, nuts, and drinking water; not a significant dietary source'
  WHERE name = 'Lithium' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Pumpkin seeds, dark chocolate, black beans, quinoa, spinach, almonds, avocado, swiss chard, edamame'
  WHERE name = 'Magnesium' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Eggs, sesame seeds, Brazil nuts, fish, meat, dairy, hemp seeds, sunflower seeds'
  WHERE name = 'Methionine' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Beef, chicken, fish, eggs, dairy, cabbage, raw spinach, tofu, miso (mostly destroyed by cooking)'
  WHERE name = 'L-Glutamine' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Chicken, turkey, eggs, dairy, sunflower seeds, oats, wheat germ (cysteine-rich foods the body converts to NAC)'
  WHERE name = 'N-Acetyl-Cysteine (NAC)' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Broccoli, spinach, brewer''s yeast, beef liver, kidney (trace amounts; most dietary ALA is converted from other fats)'
  WHERE name = 'Alpha Lipoic Acid' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Not directly found in food; body converts tryptophan → 5-HTP. Tryptophan sources: turkey, chicken, milk, eggs, cheese, tuna, nuts, seeds'
  WHERE name = '5-HTP' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Beef heart, pork, chicken, salmon, herring, sardines, mackerel, cauliflower, broccoli (amounts are small; supplementation is usually necessary)'
  WHERE name = 'CoQ10 / Ubiquinol' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Fatty fish (salmon, mackerel, herring, sardines, anchovies), walnuts, flaxseed, chia seeds, hemp seeds, algae (plant-based DHA source)'
  WHERE name = 'Fish Oils (Omega-3)' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Not found in food; naturally derived from shellfish exoskeletons; bone broth contains some joint-supporting compounds'
  WHERE name = 'Glucosamine Sulfate' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Cantaloupe, citrus fruits, beans, whole grains, nuts, wheat bran, brown rice, corn'
  WHERE name = 'Inositol' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Not obtained from food; synthesized in the body from methionine. Methionine sources: eggs, meat, fish, sesame seeds, Brazil nuts'
  WHERE name = 'SAM-E' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Papaya (papain), pineapple (bromelain), kiwi, ginger, asparagus, sauerkraut (natural enzyme sources)'
  WHERE name = 'Proteolytic Enzymes' AND dietary_sources IS NULL;

UPDATE herbal.supplements SET dietary_sources = 'Red meat, poultry, fish, dairy products; also produced by the body from lysine and methionine'
  WHERE name = 'L-Carnitine' AND dietary_sources IS NULL;

DO $$ BEGIN RAISE NOTICE 'Migration 113 complete.'; END $$;
