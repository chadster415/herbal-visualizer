-- Create a dedicated schema for herbal medicine data
CREATE SCHEMA IF NOT EXISTS herbal;

-- Set search path to use the herbal schema
SET search_path TO herbal, public;

-- Create herbs table
CREATE TABLE herbal.herbs (
  id SERIAL PRIMARY KEY,
  latin_name TEXT NOT NULL UNIQUE,
  common_name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create primary actions table
CREATE TABLE herbal.primary_actions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create secondary actions table
CREATE TABLE herbal.secondary_actions (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create body systems table
CREATE TABLE herbal.body_systems (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create relative strength enum in the herbal schema
CREATE TYPE herbal.strength_level AS ENUM ('mild', 'strong', 'very_strong');

-- Junction table: herbs to primary actions with body system and strength
CREATE TABLE herbal.herb_primary_actions (
  id SERIAL PRIMARY KEY,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  body_system_id INTEGER REFERENCES herbal.body_systems(id) ON DELETE CASCADE,
  body_system_note TEXT,
  relative_strength herbal.strength_level,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(herb_id, primary_action_id, body_system_id)
);

-- Junction table: herbs to secondary actions
CREATE TABLE herbal.herb_secondary_actions (
  id SERIAL PRIMARY KEY,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  secondary_action_id INTEGER REFERENCES herbal.secondary_actions(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(herb_id, secondary_action_id)
);

-- Create indexes for better query performance
CREATE INDEX idx_herb_primary_actions_herb ON herbal.herb_primary_actions(herb_id);
CREATE INDEX idx_herb_primary_actions_action ON herbal.herb_primary_actions(primary_action_id);
CREATE INDEX idx_herb_primary_actions_system ON herbal.herb_primary_actions(body_system_id);
CREATE INDEX idx_herb_secondary_actions_herb ON herbal.herb_secondary_actions(herb_id);
CREATE INDEX idx_herb_secondary_actions_action ON herbal.herb_secondary_actions(secondary_action_id);
CREATE INDEX idx_herbs_latin_name ON herbal.herbs(latin_name);
CREATE INDEX idx_herbs_common_name ON herbal.herbs(common_name);

-- Grant permissions (adjust if you have specific roles)
GRANT USAGE ON SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;

-- Insert body systems
INSERT INTO herbal.body_systems (name) VALUES 
  ('Cardiovascular'),
  ('Respiratory'),
  ('Digestive'),
  ('Urinary'),
  ('Reproductive'),
  ('Musculoskeletal'),
  ('Nervous'),
  ('Skin');

COMMENT ON SCHEMA herbal IS 'Schema for herbal medicine visualization data';
COMMENT ON TABLE herbal.herbs IS 'Medicinal herbs with Latin and common names';
COMMENT ON TABLE herbal.primary_actions IS 'Primary herbal action categories (Alteratives, Adaptogens, etc.)';
COMMENT ON TABLE herbal.body_systems IS 'Body systems affected by herbs';
COMMENT ON COLUMN herbal.herb_primary_actions.relative_strength IS 'Strength rating: mild, strong, or very_strong';
