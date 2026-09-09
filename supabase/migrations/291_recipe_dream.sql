-- First recipe: DREAM tea blend
-- Herb IDs: Chamomile=84, Catnip=136, Skullcap=142, Peppermint=55, Licorice=78, Hops=129
-- Body systems: Nervous=15, Musculoskeletal=14

WITH new_recipe AS (
  INSERT INTO herbal.recipes (name, description, preparation_label, instructions, taste, herbal_actions, sort_order)
  VALUES (
    'Dream',
    E'This simple tea promotes relaxation and sleep. I adore this blend because anyone can easily grow each of these herbs in the backyard, and because the herbs are gentle and effective for quieting a chattery mind, releasing muscle tension, and promoting general relaxation so that your body naturally feels tired and falls asleep.\n\nI often use Dream tea during the day when I am experiencing a period of intense stress. Kids also respond really well to this blend as a calming bedtime tea.',
    'Steeping',
    '[
      {"label": "Hot Infusion", "text": "Pour 1.5 cups hot water over 2 tablespoons tea. Steep for 10 to 15 minutes."},
      {"label": "Cold Infusion", "text": "Combine 2 cups cold water and 1 to 2 tablespoons tea in a lidded jar. Shake the jar to make sure all the tea is saturated. Place in the refrigerator or a cool place for at least 2 hours."}
    ]'::jsonb,
    'earthy, bittersweet, with a hint of mint',
    ARRAY['nervine', 'restorative'],
    10
  )
  RETURNING id
),
sys AS (
  INSERT INTO herbal.recipe_body_systems (recipe_id, body_system_id)
  SELECT id, unnest(ARRAY[15, 14]) FROM new_recipe
  RETURNING recipe_id
)
INSERT INTO herbal.recipe_herbs (recipe_id, herb_id, quantity, sort_order)
SELECT id, herb_id, qty, ord
FROM new_recipe,
  (VALUES
    (84,  '1.25 parts',  10),
    (136, '1 part',      20),
    (142, '1 part',      30),
    (55,  '1 part',      40),
    (78,  '0.375 parts', 50),
    (129, '0.25 parts',  60)
  ) AS v(herb_id, qty, ord);
