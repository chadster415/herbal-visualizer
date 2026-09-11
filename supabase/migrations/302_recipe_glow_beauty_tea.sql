-- Recipe: Glow: Beauty Tea
-- Herb IDs: Dandelion=122, Burdock=22, Nettle=43, Licorice=78, Calendula=70
-- Body systems: Digestive=11 (liver), Urinary=12 (kidneys), Skin=16, Endocrine=33

WITH new_recipe AS (
  INSERT INTO herbal.recipes (name, description, preparation_label, instructions, taste, herbal_actions, sort_order)
  VALUES (
    'Glow: Beauty Tea',
    E'This is my most basic detox tea. It supports the liver and kidneys. When these organs are well taken care of, you will notice clear, naturally radiant skin and feel energetic.\n\nBoth dandelion and burdock are gentle and nourishing to the liver and kidneys. They work best if incorporated into your diet regularly. Burdock is energetically a "mover," supporting the excretion of toxins from the body; it also supports beneficial gut flora. As a food, burdock root can be eaten in stews and soups. Dandelion is another common plant that lives pretty much everywhere humans do. Most people consider it a nuisance or a weed, but it works wonders in the body. Dried dandelion root in tea is used to treat high blood pressure, high cholesterol, and abnormal blood sugar. It is also extremely beneficial to the liver, and its bitter taste encourages bile production.\n\nNettles are incredibly nutritious. In spring, fresh local nettles reduce seasonal allergies through their natural antihistamine properties. Abundant and chock-full of vitamins, minerals, protein, and chlorophyll, nettles are a choice herb for mineral tonics. Nettles support kidney health and provide a nourishing quality to this detox tea.',
    'Steeping',
    '[
      {"label": "Decoction", "text": "Combine 3 tablespoons tea and 3 cups cold water in a lidded saucepan. Slowly bring to a simmer without allowing the water to boil over. Let simmer over low heat for at least 20 minutes. Strain and enjoy."}
    ]'::jsonb,
    'earthy, bittersweet',
    ARRAY['detox', 'tonic'],
    30
  )
  RETURNING id
),
sys AS (
  INSERT INTO herbal.recipe_body_systems (recipe_id, body_system_id)
  SELECT id, unnest(ARRAY[11, 12, 16, 33]) FROM new_recipe
  RETURNING recipe_id
)
INSERT INTO herbal.recipe_herbs (recipe_id, herb_id, quantity, sort_order)
SELECT id, herb_id, qty, ord
FROM new_recipe,
  (VALUES
    (122, '1 part',     10),
    (22,  '1 part',     20),
    (43,  '0.5 parts',  30),
    (78,  '0.25 parts', 40),
    (70,  '0.15 parts', 50)
  ) AS v(herb_id, qty, ord);
