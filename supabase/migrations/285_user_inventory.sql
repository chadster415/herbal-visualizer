-- Migration 285: Personal herb inventory per user
-- Users can track which herbs they have in stock, what plant part, and any notes.

SET search_path TO herbal, public;

CREATE TABLE herbal.user_inventory (
  id           SERIAL PRIMARY KEY,
  user_id      UUID    NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  herb_id      INTEGER NOT NULL REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  in_stock     BOOLEAN NOT NULL DEFAULT false,
  plant_part   TEXT    NOT NULL DEFAULT '',
  notes        TEXT    NOT NULL DEFAULT '',
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, herb_id)
);

CREATE INDEX idx_user_inventory_user ON herbal.user_inventory(user_id);
CREATE INDEX idx_user_inventory_herb ON herbal.user_inventory(herb_id);

ALTER TABLE herbal.user_inventory ENABLE ROW LEVEL SECURITY;

CREATE POLICY "user_inventory_select" ON herbal.user_inventory
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "user_inventory_insert" ON herbal.user_inventory
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_inventory_update" ON herbal.user_inventory
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "user_inventory_delete" ON herbal.user_inventory
  FOR DELETE USING (auth.uid() = user_id);

GRANT SELECT, INSERT, UPDATE, DELETE ON herbal.user_inventory TO authenticated;
GRANT USAGE ON SEQUENCE herbal.user_inventory_id_seq TO authenticated;
