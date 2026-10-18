-- Migration 389: Add Antifungal primary action to 6 herbs
--
-- Source: BHC class notes and Final Exam herb tables.
--   Black Walnut  — Final Exam: "Antifungal, Anthelmintic, Antimicrobial" (first-listed)
--   Calendula     — Final Exam: "Antifungal, Vulnerary, Antimicrobial (mild)..." (first-listed)
--   Goldenseal    — Final Exam antifungal category table; herb table includes Antifungal
--   Chaparral     — Class 70 instructor: "potently antifungal — we use it in the wound care clinic"
--   Pau D'arco    — Case Study 5: "Pau D'arco - Antifungal (Antimicrobial)"
--   Oregon Grape  — Class 5: "Berberine — anti-fungal, antimicrobial, Blood sugar regulation"
--
-- primary_action_id 1245 = Antifungal (verified against live DB)
-- body_system 16 = Skin, 17 = Immune

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Black Walnut (id=288) — juglone potently inhibits Candida, dermatophytes, and intestinal fungi
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (288, 1245, 17, 'Antifungal; juglone inhibits Candida, dermatophytes, and intestinal fungi', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Calendula (id=70) — topical antifungal for skin and nail conditions
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (70, 1245, 16, 'Antifungal; topical use for skin, nail, and mucosal fungal infections', 'moderate')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Goldenseal (id=30) — berberine inhibits Candida and mucosal fungi
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (30, 1245, 17, 'Antifungal; berberine inhibits Candida and mucosal fungi', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Chaparral (id=32) — NDGA potently inhibits fungi; used in wound and nail care
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (32, 1245, 16, 'Antifungal; NDGA potently inhibits fungi; applied topically for wound and nail fungal infections', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Pau D'arco (id=291) — lapachol and beta-lapachone active against Candida and systemic fungi
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (291, 1245, 17, 'Antifungal; lapachol and beta-lapachone active against Candida and systemic fungi', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  -- Oregon Grape (id=33) — berberine inhibits Candida and intestinal fungi
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, body_system_note, relative_strength)
  VALUES (33, 1245, 17, 'Antifungal; berberine inhibits Candida and intestinal fungi', 'strong')
  ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;

  RAISE NOTICE 'Migration 389 done — Antifungal added to Black Walnut, Calendula, Goldenseal, Chaparral, Pau D''arco, Oregon Grape';

END $$;
