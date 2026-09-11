-- Link recipes to primary_actions via a join table.
-- Also normalizes herbal_actions text[] to match actual primary_action names.

CREATE TABLE herbal.recipe_primary_actions (
  recipe_id INTEGER NOT NULL REFERENCES herbal.recipes(id) ON DELETE CASCADE,
  action_id INTEGER NOT NULL REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, action_id)
);

ALTER TABLE herbal.recipe_primary_actions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can view recipe_primary_actions"
  ON herbal.recipe_primary_actions FOR SELECT USING (true);

-- Normalize herbal_actions text[] to match primary_action names exactly
UPDATE herbal.recipes
  SET herbal_actions = ARRAY['Nervine Tonic', 'Tonic']
  WHERE name IN ('Dream', 'Respite Nervine Tea');

UPDATE herbal.recipes
  SET herbal_actions = ARRAY['Detoxifying', 'Tonic']
  WHERE name = 'Glow: Beauty Tea';

UPDATE herbal.recipes
  SET herbal_actions = ARRAY['Carminative', 'Liver Tonic', 'Digestive Tonic']
  WHERE name = 'Digestive Tonic';

-- Populate join table from the normalized herbal_actions array
INSERT INTO herbal.recipe_primary_actions (recipe_id, action_id)
SELECT r.id, a.id
FROM herbal.recipes r
CROSS JOIN LATERAL unnest(r.herbal_actions) AS action_name
JOIN herbal.primary_actions a ON a.name = action_name;
