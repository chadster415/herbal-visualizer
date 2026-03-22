-- Create action descriptions table to store bullet points for each primary action
CREATE TABLE herbal.action_descriptions (
  id SERIAL PRIMARY KEY,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for better query performance
CREATE INDEX idx_action_descriptions_action ON herbal.action_descriptions(primary_action_id);

-- Grant permissions
GRANT ALL ON herbal.action_descriptions TO postgres, anon, authenticated, service_role;
GRANT ALL ON SEQUENCE herbal.action_descriptions_id_seq TO postgres, anon, authenticated, service_role;

COMMENT ON TABLE herbal.action_descriptions IS 'Descriptive bullet points for primary actions';
COMMENT ON COLUMN herbal.action_descriptions.sort_order IS 'Order in which descriptions should be displayed';
