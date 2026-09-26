CREATE TABLE herbal.food_items (
  id                    SERIAL PRIMARY KEY,
  name                  TEXT NOT NULL UNIQUE,  -- the search term used (from dietary_sources)
  spoonacular_id        INTEGER,
  spoonacular_name      TEXT,
  aisle                 TEXT,
  image                 TEXT,
  consistency           TEXT,
  estimated_cost_cents  INTEGER,
  possible_units        JSONB,
  nutrients             JSONB,
  properties            JSONB,
  flavonoids            JSONB,
  caloric_breakdown     JSONB,
  weight_per_serving    JSONB,
  category_path         JSONB,
  raw_response          JSONB,
  created_at            TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE herbal.food_items IS 'Food items with aisle and nutrition data from Spoonacular, cached to avoid repeated API calls';
COMMENT ON COLUMN herbal.food_items.name IS 'Lowercase search term matching dietary_sources text';
COMMENT ON COLUMN herbal.food_items.raw_response IS 'Full Spoonacular /ingredients/{id}/information response';
