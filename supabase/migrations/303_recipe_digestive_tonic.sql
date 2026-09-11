-- Recipe: Digestive Tonic
-- Herb IDs: Dandelion=122, Fennel=76, Ginger=124, Peppermint=55, Spearmint=2607
-- Body systems: Digestive=11 (covers both "digestive" and "liver")

WITH new_recipe AS (
  INSERT INTO herbal.recipes (name, description, preparation_label, instructions, taste, herbal_actions, sort_order)
  VALUES (
    'Digestive Tonic',
    E'Drinking this delicious tonic — especially prior to or immediately following a meal — helps balance the digestive system and relieve digestive upset. This is a basic, all-purpose digestive system tea that is designed to be drunk daily, and the herbs are easy to grow in your home garden. Supporting digestion is one of the best things you can do for daily health. A healthy digestive system can prevent many diseases over the long term. \n\nIf you experience occasional or persistent acid reflux, make sure you add the marshmallow root. With a sweet, thick texture, marshmallow root is a mucilaginous herb that is cooling and soothing to the throat and stomach. This tea has helped reduce acid reflux in many of my customers and friends.\n\nDandelion root, with its bitter-tasting compounds, helps stimulate the release of bile into the stomach and provides support to the liver. Ginger, one of the most powerful and important herbs used worldwide since antiquity, both warms the digestive system and relieves stomachaches, gas, nausea, and congestion. Both dandelion root and ginger support your digestive fire, allowing food to break down thoroughly in your stomach. The quicker your food is fully digested, the quicker nutrients are readily available to your cells. Strong, healthy digestion also ensures waste products are quickly eliminated from the body. The ideal transit time from eating to excreting is 18 to 24 hours. Fennel is a fabulous carminative herb, helping the body absorb excess gas in the digestive tract. Lesser known is fennel’s ability to assist in relaxation. Fennel also soothes inflamed tissues and offers a slightly sweet licorice taste. Mint is calming, helping the body to relax after a meal, and adds a nice flavor to the tea.',
    'Steeping',
    '[
      {"label": "Hot Infusion", "text": "Pour 1.5 cups hot water over 2 tablespoons tea. Steep for 10 to 15 minutes."},
      {"label": "Cold Infusion", "text": "Combine 2 cups cold water and 1 to 2 tablespoons tea in a lidded jar. Shake the jar to make sure all the tea is saturated. Place in the refrigerator or a cool place for at least 2 hours."}
    ]'::jsonb,
    'sweet, spicy, minty',
    ARRAY['carminative', 'liver support', 'digestive'],
    40
  )
  RETURNING id
),
sys AS (
  INSERT INTO herbal.recipe_body_systems (recipe_id, body_system_id)
  SELECT id, unnest(ARRAY[11]) FROM new_recipe
  RETURNING recipe_id
)
INSERT INTO herbal.recipe_herbs (recipe_id, herb_id, quantity, sort_order)
SELECT id, herb_id, qty, ord
FROM new_recipe,
  (VALUES
    (122, '3 parts', 10),
    (76,  '1 part',  20),
    (124, '1 part',  30),
    (55,  '1 part',  40),
    (2607,'1 part',  50)
  ) AS v(herb_id, qty, ord);
