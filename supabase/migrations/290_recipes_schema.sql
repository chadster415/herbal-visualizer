-- Recipes feature: schema

CREATE TABLE herbal.recipes (
  id                SERIAL PRIMARY KEY,
  name              TEXT NOT NULL,
  description       TEXT,
  preparation_label TEXT,
  instructions      JSONB NOT NULL DEFAULT '[]'::jsonb,
  taste             TEXT,
  herbal_actions    TEXT[],
  sort_order        INTEGER NOT NULL DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE herbal.recipes ENABLE ROW LEVEL SECURITY;
CREATE POLICY public_read ON herbal.recipes FOR SELECT TO anon, authenticated USING (true);

-- Many-to-many: recipes ↔ body systems
CREATE TABLE herbal.recipe_body_systems (
  recipe_id      INTEGER NOT NULL REFERENCES herbal.recipes(id) ON DELETE CASCADE,
  body_system_id INTEGER NOT NULL REFERENCES herbal.body_systems(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, body_system_id)
);

ALTER TABLE herbal.recipe_body_systems ENABLE ROW LEVEL SECURITY;
CREATE POLICY public_read ON herbal.recipe_body_systems FOR SELECT TO anon, authenticated USING (true);

-- Herbs used in a recipe (herb_id nullable for ingredients not in the DB)
CREATE TABLE herbal.recipe_herbs (
  id                 SERIAL PRIMARY KEY,
  recipe_id          INTEGER NOT NULL REFERENCES herbal.recipes(id) ON DELETE CASCADE,
  herb_id            INTEGER REFERENCES herbal.herbs(id) ON DELETE SET NULL,
  herb_name_override TEXT,
  quantity           TEXT NOT NULL,
  sort_order         INTEGER NOT NULL DEFAULT 0,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE herbal.recipe_herbs ENABLE ROW LEVEL SECURITY;
CREATE POLICY public_read ON herbal.recipe_herbs FOR SELECT TO anon, authenticated USING (true);

-- One image per recipe (stored in S3, key tracked here)
CREATE TABLE herbal.recipe_images (
  id         SERIAL PRIMARY KEY,
  recipe_id  INTEGER NOT NULL REFERENCES herbal.recipes(id) ON DELETE CASCADE,
  image_key  TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

GRANT SELECT, INSERT, DELETE ON herbal.recipe_images TO anon, authenticated;
GRANT SELECT ON herbal.recipes TO anon, authenticated;
GRANT SELECT ON herbal.recipe_body_systems TO anon, authenticated;
GRANT SELECT ON herbal.recipe_herbs TO anon, authenticated;
