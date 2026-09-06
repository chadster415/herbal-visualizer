CREATE TABLE herbal.herb_images (
  id          SERIAL PRIMARY KEY,
  herb_id     INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  image_key   TEXT NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(herb_id, image_key)
);

CREATE INDEX ON herbal.herb_images(herb_id);
