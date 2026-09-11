-- Recipe: Respite Nervine Tea
-- Herb IDs: Peppermint=55, Nettle=43, Chamomile=84, Rose=849, Lavender=82,
--           Skullcap=142, Raspberry=155, Catnip=136, Licorice=78
-- Body systems: Nervous=15, Musculoskeletal=14

WITH new_recipe AS (
  INSERT INTO herbal.recipes (name, description, preparation_label, instructions, taste, herbal_actions, sort_order)
  VALUES (
    'Respite Nervine Tea',
    E'This is a great mineral tonic with a nervine quality. I often make it when I feel a little frazzled by a busy day or have a stressful experience. Each of the herbs feeds the nervous system and supports healthy bones, blood, and muscles. This tea is cooling, so add some fresh grated ginger or cinnamon if you are already feeling energetically cold.\n\nThe base for Respite is similar to Strength with the addition of three slightly bitter herbs (chamomile, catnip, and skullcap) along with licorice to reduce their intensity on your palate. When it comes to herbal teas, it benefits the drinker to learn to appreciate strong flavors. Bitter herbs are often really bitter and the herbs we use to sweeten a tea tend to be overwhelmingly sweet. Medicinal herbs are a lot less understanding of our sensitive human palate than the culinary herbs we have selected and bred into softer, more pleasing versions of their wild brethren. As a tea formulator you will learn to constantly negotiate the intensity of the various herbs you use.',
    'Steeping',
    '[
      {"label": "Hot Infusion", "text": "Pour 1.5 cups hot water over 2 tablespoons tea. Steep for 10 to 15 minutes."},
      {"label": "Cold Infusion", "text": "Combine 2 cups cold water and 1 to 2 tablespoons tea in a lidded jar. Shake the jar to make sure all the tea is saturated. Place in the refrigerator or a cool place for at least 2 hours."}
    ]'::jsonb,
    'smooth, palatable combination of bitter and sweet',
    ARRAY['nervine', 'restorative'],
    20
  )
  RETURNING id
),
sys AS (
  INSERT INTO herbal.recipe_body_systems (recipe_id, body_system_id)
  SELECT id, unnest(ARRAY[15, 14]) FROM new_recipe
  RETURNING recipe_id
),
named AS (
  INSERT INTO herbal.recipe_herbs (recipe_id, herb_id, herb_name_override, quantity, sort_order)
  SELECT id, NULL, override, qty, ord
  FROM new_recipe,
    (VALUES
      ('Anise Seeds or Fennel', '1.5 parts', 10),
      ('Rose Petals (or 0.25 part Lavender Blossoms)', '1 part', 50)
    ) AS v(override, qty, ord)
)
INSERT INTO herbal.recipe_herbs (recipe_id, herb_id, quantity, sort_order)
SELECT id, herb_id, qty, ord
FROM new_recipe,
  (VALUES
    (55,  '1.5 parts',  20),
    (43,  '1 part',     30),
    (84,  '1 part',     40),
    (142, '1 part',     60),
    (155, '0.5 parts',  70),
    (136, '0.5 parts',  80),
    (78,  '0.25 parts', 90)
  ) AS v(herb_id, qty, ord);
