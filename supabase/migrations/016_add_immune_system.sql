-- Add Immune System as a body system

SET search_path TO herbal, public;

-- Add Immune System to body_systems table
INSERT INTO herbal.body_systems (name)
VALUES ('Immune')
ON CONFLICT (name) DO NOTHING;
