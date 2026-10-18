-- user_tags: canonical tag names per user
CREATE TABLE herbal.user_tags (
  id         SERIAL PRIMARY KEY,
  user_id    UUID   NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  tag_text   TEXT   NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, tag_text)
);

CREATE INDEX idx_user_tags_user ON herbal.user_tags(user_id);

ALTER TABLE herbal.user_tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_tags_select" ON herbal.user_tags
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "user_tags_insert" ON herbal.user_tags
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "user_tags_update" ON herbal.user_tags
  FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "user_tags_delete" ON herbal.user_tags
  FOR DELETE USING (auth.uid() = user_id);

GRANT SELECT, INSERT, UPDATE, DELETE ON herbal.user_tags TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE herbal.user_tags_id_seq TO authenticated;

-- user_herb_tag_assignments: which herbs have which tags per user
CREATE TABLE herbal.user_herb_tag_assignments (
  id         SERIAL PRIMARY KEY,
  user_id    UUID    NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  herb_id    INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  tag_id     INTEGER NOT NULL REFERENCES herbal.user_tags(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, herb_id, tag_id)
);

CREATE INDEX idx_uhta_user ON herbal.user_herb_tag_assignments(user_id);
CREATE INDEX idx_uhta_herb ON herbal.user_herb_tag_assignments(herb_id);
CREATE INDEX idx_uhta_tag  ON herbal.user_herb_tag_assignments(tag_id);

ALTER TABLE herbal.user_herb_tag_assignments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "uhta_select" ON herbal.user_herb_tag_assignments
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "uhta_insert" ON herbal.user_herb_tag_assignments
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "uhta_delete" ON herbal.user_herb_tag_assignments
  FOR DELETE USING (auth.uid() = user_id);

GRANT SELECT, INSERT, DELETE ON herbal.user_herb_tag_assignments TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE herbal.user_herb_tag_assignments_id_seq TO authenticated;
