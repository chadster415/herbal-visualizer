SET search_path TO herbal, public;

-- Add vitexin, isovitexin, gramine, and scopoletin to Oat Straw (herb_id=2287).

DO $$
DECLARE
  v_gramine_id INTEGER;
BEGIN
  -- vitexin — major C-glycosyl flavone, signature of oat straw
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, 756, 'major', 60)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- isovitexin — paired C-glycosyl flavone
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, 757, 'major', 70)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- gramine — indole alkaloid; contributes to nervine/calming activity
  v_gramine_id := herbal.ensure_constituent('gramine', 'indole alkaloid',
    'Indole alkaloid characteristic of oat straw; contributes to nervine and calming activity');
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, v_gramine_id, 'moderate', 80)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  -- scopoletin — coumarin; calming and antispasmodic action
  INSERT INTO herbal.herb_constituents (herb_id, constituent_id, concentration_level, sort_order)
  VALUES (2287, 905, 'moderate', 90)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;

  RAISE NOTICE 'Added vitexin, isovitexin, gramine, scopoletin to Oat Straw';
END $$;
