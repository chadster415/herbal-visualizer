-- Migration to add disorders system (generic for all body systems)
-- This supports the clinical application of herbal medicine by body system

SET search_path TO herbal, public;

-- ============================================================================
-- DISORDERS TABLE
-- ============================================================================
-- Stores all disorders/conditions across all body systems
CREATE TABLE herbal.disorders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  body_system_id INTEGER REFERENCES herbal.body_systems(id) ON DELETE CASCADE,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(name, body_system_id)
);

CREATE INDEX idx_disorders_body_system ON herbal.disorders(body_system_id);
CREATE INDEX idx_disorders_name ON herbal.disorders(name);

COMMENT ON TABLE herbal.disorders IS 'Clinical disorders/conditions organized by body system';
COMMENT ON COLUMN herbal.disorders.sort_order IS 'Display order within body system';

-- ============================================================================
-- DISORDER NOTES
-- ============================================================================
-- Stores free-form notes/context for each disorder (## Notes sections)
CREATE TABLE herbal.disorder_notes (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  note_text TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_disorder_notes_disorder ON herbal.disorder_notes(disorder_id);

COMMENT ON TABLE herbal.disorder_notes IS 'Clinical notes and context for disorders';

-- ============================================================================
-- ACTIONS INDICATED
-- ============================================================================
-- Describes which herbal actions are therapeutically indicated for a disorder
CREATE TABLE herbal.disorder_actions_indicated (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(disorder_id, primary_action_id)
);

CREATE INDEX idx_disorder_actions_indicated_disorder ON herbal.disorder_actions_indicated(disorder_id);
CREATE INDEX idx_disorder_actions_indicated_action ON herbal.disorder_actions_indicated(primary_action_id);

COMMENT ON TABLE herbal.disorder_actions_indicated IS 'Therapeutic rationale for why specific actions are indicated for each disorder';

-- ============================================================================
-- DISORDER ACTION HERBS
-- ============================================================================
-- Links herbs to disorders via their therapeutic actions
CREATE TABLE herbal.disorder_action_herbs (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  note TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(disorder_id, herb_id, primary_action_id)
);

CREATE INDEX idx_disorder_action_herbs_disorder ON herbal.disorder_action_herbs(disorder_id);
CREATE INDEX idx_disorder_action_herbs_herb ON herbal.disorder_action_herbs(herb_id);
CREATE INDEX idx_disorder_action_herbs_action ON herbal.disorder_action_herbs(primary_action_id);

COMMENT ON TABLE herbal.disorder_action_herbs IS 'Herbs organized by their therapeutic action for specific disorders';

-- ============================================================================
-- SPECIFIC REMEDIES
-- ============================================================================
-- Highlights particularly effective herbs for a disorder (specific remedies)
CREATE TABLE herbal.disorder_specific_remedies (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  description TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(disorder_id, herb_id)
);

CREATE INDEX idx_disorder_specific_remedies_disorder ON herbal.disorder_specific_remedies(disorder_id);
CREATE INDEX idx_disorder_specific_remedies_herb ON herbal.disorder_specific_remedies(herb_id);

COMMENT ON TABLE herbal.disorder_specific_remedies IS 'Particularly effective herbs (specific remedies) for each disorder';

-- ============================================================================
-- PRESCRIPTIONS
-- ============================================================================
-- Stores herbal formulas/prescriptions for disorders
CREATE TABLE herbal.disorder_prescriptions (
  id SERIAL PRIMARY KEY,
  disorder_id INTEGER REFERENCES herbal.disorders(id) ON DELETE CASCADE,
  title TEXT, -- e.g., "Mouthwash", "Internal use", "Gum application"
  instructions TEXT NOT NULL, -- Dosage and preparation instructions
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_disorder_prescriptions_disorder ON herbal.disorder_prescriptions(disorder_id);

COMMENT ON TABLE herbal.disorder_prescriptions IS 'Herbal formulas/prescriptions for treating disorders';
COMMENT ON COLUMN herbal.disorder_prescriptions.title IS 'Optional title like "Internal use", "Mouthwash", "Topical application"';

-- ============================================================================
-- PRESCRIPTION HERBS
-- ============================================================================
-- Individual herbs within a prescription formula with their proportions
CREATE TABLE herbal.prescription_herbs (
  id SERIAL PRIMARY KEY,
  prescription_id INTEGER REFERENCES herbal.disorder_prescriptions(id) ON DELETE CASCADE,
  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,
  parts TEXT NOT NULL, -- e.g., "1 part", "2 parts", "35 ml"
  note TEXT, -- e.g., "root" for specific plant part
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_prescription_herbs_prescription ON herbal.prescription_herbs(prescription_id);
CREATE INDEX idx_prescription_herbs_herb ON herbal.prescription_herbs(herb_id);

COMMENT ON TABLE herbal.prescription_herbs IS 'Individual herbs in prescriptions with their proportions';
COMMENT ON COLUMN herbal.prescription_herbs.parts IS 'Proportion like "1 part", "2 parts", "35 ml"';
COMMENT ON COLUMN herbal.prescription_herbs.note IS 'Specific plant part or other notes like "root", "leaf"';

-- ============================================================================
-- PRESCRIPTION HERB ACTIONS
-- ============================================================================
-- Links herbs in prescriptions to their therapeutic role (actions) in that formula
-- This enables showing what each herb is doing in the formula
CREATE TABLE herbal.prescription_herb_actions (
  id SERIAL PRIMARY KEY,
  prescription_herb_id INTEGER REFERENCES herbal.prescription_herbs(id) ON DELETE CASCADE,
  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(prescription_herb_id, primary_action_id)
);

CREATE INDEX idx_prescription_herb_actions_prescription_herb ON herbal.prescription_herb_actions(prescription_herb_id);
CREATE INDEX idx_prescription_herb_actions_action ON herbal.prescription_herb_actions(primary_action_id);

COMMENT ON TABLE herbal.prescription_herb_actions IS 'Links herbs in formulas to their therapeutic actions/roles';

-- ============================================================================
-- PERMISSIONS
-- ============================================================================
GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA herbal TO postgres, anon, authenticated, service_role;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- This schema supports:
-- 1. Disorders organized by body system
-- 2. Clinical notes for context
-- 3. Actions indicated (therapeutic rationale)
-- 4. Action herbs (herbs grouped by their actions for a disorder)
-- 5. Specific remedies (particularly effective herbs)
-- 6. Prescriptions (herbal formulas with dosage instructions)
-- 7. Prescription herbs (individual herbs with proportions)
-- 8. Prescription herb actions (what each herb does in the formula)
--
-- This design is fully generic and reusable for all body systems
