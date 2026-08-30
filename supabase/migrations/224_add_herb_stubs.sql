-- Migration 224: Add herb stubs for Saffron, Guayusa, and Velvet Bean
-- These appear in class notes but were not yet in the DB.
-- Full data (body system, actions, energetics, constituents) to be added
-- later via the herb data playbook.

SET search_path TO herbal, public;

DO $$
BEGIN
  -- Saffron (Crocus sativus) — mentioned in class 52 & 57 for GI-based depression;
  -- contraindicated with SSRIs due to serotonin syndrome risk
  PERFORM herbal.ensure_herb('Crocus sativus', 'Saffron');

  -- Guayusa (Ilex guayusa) — stimulant nervine; mentioned in class 52
  PERFORM herbal.ensure_herb('Ilex guayusa', 'Guayusa');

  -- Velvet Bean (Mucuna pruriens) — boosts dopamine; mentioned in class 52
  PERFORM herbal.ensure_herb('Mucuna pruriens', 'Velvet Bean');

  RAISE NOTICE 'Stub herbs inserted (Saffron, Guayusa, Velvet Bean)';
END $$;
