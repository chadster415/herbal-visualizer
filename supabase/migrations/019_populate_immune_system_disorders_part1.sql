-- Populate Immune System disorders and data - Part 1
-- This includes: system notes, Overall disorder, Autoimmune Diseases, and Elimination/Detox

SET search_path TO herbal, public;

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================
CREATE OR REPLACE FUNCTION herbal.ensure_herb(p_latin_name TEXT, p_common_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, p_common_name)
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION herbal.ensure_action(p_action_name TEXT)
RETURNS INTEGER AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- IMMUNE SYSTEM GENERAL NOTES
-- ============================================================================
-- Note: System-level notes (not disorder-specific) are stored as a special
-- disorder called "System Notes" or similar, or we could add them to a
-- disorder named "Overall" with sort_order 0

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  -- Get Immune system ID
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  -- ============================================================================
  -- CREATE "OVERALL" DISORDER FOR GENERAL IMMUNE SUPPORT
  -- ============================================================================
  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Overall', v_immune_system_id, 0)
  RETURNING id INTO v_disorder_id;

  -- Add general system notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Herbal medicine is as limited as orthodox medicine if it is used only to affect T- and B-lymphocyte function, without the benefit of a broader holistic context.', 1),
    (v_disorder_id, 'Human immunity is ecology in action. In other words, there is a multifactorial relationship at play between individuals and their environment.', 2),
    (v_disorder_id, 'Immunity represents an ecological interface between inner and outer environments.', 3),
    (v_disorder_id, 'In human ecology, the immune system is governed by a complex of processes that allow resistance and embrace at the same time. To focus on only one side of this profound interaction is to miss the point and compromise understanding of the whole.', 4),
    (v_disorder_id, 'Immunity is an expression of homeostasis. We now know that in the presence of stress, a large and complex array of mechanical, chemical, and immune changes take place, as the body attempts to defend itself or restore homeostasis.', 5),
    (v_disorder_id, 'The term psychoneuroimmunology comes from our growing understanding of these mind-body connections. Psycho denotes thinking, emotions, and mood states; neuro implies involvement of the neurological and neuroendocrine systems; and immunology refers to cellular structures and the immune system.', 6),
    (v_disorder_id, 'Consider, for example, the commonly held belief in the Western herbal community that Panax ginseng is for men and Angelica sinensis (dong quai) is for women. This is simply not the case. Panax is the strongest yang tonic, while A. sinensis is the most yielding yin tonic. This leads to entirely different therapeutic implications.', 7),
    (v_disorder_id, 'It is too easy to discard the insights of traditional approaches in favor of research published in peer-reviewed journals. This is imprudent, because important insights may be gained when one takes into account the herbal wisdom garnered through generations of experience.', 8),
    (v_disorder_id, 'Herbal medicine is ecological medicine; it is based on an ecological relationship that has evolved through geological time.', 9),
    (v_disorder_id, 'In both the laboratory and the clinic, a growing number of herbal remedies have been shown to have marked effects upon the immune system. Some stimulate immune system responses, but most can best be described as modulators. That is, these remedies facilitate greater immune system flexibility in the body''s natural response to disease.', 10),
    (v_disorder_id, 'Nonspecific immunostimulants do not affect immune system memory cells, and because their pharmacological effects fade relatively quickly, they must be administered either at intervals or continuously.', 11),
    (v_disorder_id, 'The protective immunity conferred by immunostimulants happens quickly and has been termed paramunity.', 12),
    (v_disorder_id, 'Immunomodulation and immunoregulation are terms that have been proposed to denote any effect on immune system responsiveness. For example, herbs may also stimulate T-suppressor cells and thereby reduce immune resistance.', 13),
    (v_disorder_id, 'Immunoadjuvants are substances that enhance the production of antibodies without acting as antigens themselves. The effects of adjuvants are often thymus-dependent.', 14),
    (v_disorder_id, 'Herbalist Christopher Hobbs identifies three relevant levels of herbal activity: • Deep immune activation • Surface immune activation • Adaptogenic action or hormonal modulation', 15),
    (v_disorder_id, 'Autoimmune diseases are conditions in which lymphocytes produce antibodies that attack the body''s own cells and tissues as if they were foreign substances, thus causing pathological damage.', 16),
    (v_disorder_id, 'Conditions thought to have an autoimmune basis include rheumatoid arthritis, polyarthritis, chronic active hepatitis, multiple sclerosis, and psoriasis.', 17),
    (v_disorder_id, 'The real question involves knowing when to use immunostimulant herbs and, even more important, when not to. Stimulating immune system activity may be inappropriate in some conditions and vital in others.', 18),
    (v_disorder_id, 'In general, it seems safe to say that immunostimulant plants should be avoided in conditions that involve inappropriate activity of some aspect of the immune complex. In autoimmune conditions, for example, any stimulation might increase the production or pathological impact of antibodies.', 19);

  -- Add action herbs for Overall immune support
  -- Immunomodulator herbs
  v_action_id := herbal.ensure_action('Immunomodulator');

  v_herb_id := herbal.ensure_herb('Astragalus membranaceus', 'astragalus');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Codonopsis tangshen', 'codonopsis');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Ganoderma lucidum', 'reishi');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  v_herb_id := herbal.ensure_herb('Lentinus edodes', 'shiitake');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  v_herb_id := herbal.ensure_herb('Ligustrum lucidum', 'privet');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Schisandra chinensis', 'schisandra');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  -- Antimicrobials
  v_action_id := herbal.ensure_action('Antimicrobial');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Allium sativum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Baptisia tinctoria';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'calendula');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Commiphora molmol';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 4);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 5);

  v_herb_id := herbal.ensure_herb('Thuja occidentalis', 'thuja');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 6);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Usnea spp.';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 7);

  RAISE NOTICE 'Overall immune disorder created with % notes', 19;

END $$;

-- ============================================================================
-- AUTOIMMUNE DISEASES
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Autoimmune Diseases', v_immune_system_id, 1)
  RETURNING id INTO v_disorder_id;

  -- Add disorder-specific notes
  INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order)
  VALUES
    (v_disorder_id, 'Autoimmune diseases are conditions in which lymphocytes produce antibodies that attack the body''s own cells and tissues as if they were foreign substances, thus causing pathological damage.', 1),
    (v_disorder_id, 'Conditions thought to have an autoimmune basis include rheumatoid arthritis, polyarthritis, chronic active hepatitis, multiple sclerosis, and psoriasis.', 2),
    (v_disorder_id, 'The real question involves knowing when to use immunostimulant herbs and, even more important, when not to. Stimulating immune system activity may be inappropriate in some conditions and vital in others.', 3),
    (v_disorder_id, 'In general, it seems safe to say that immunostimulant plants should be avoided in conditions that involve inappropriate activity of some aspect of the immune complex. In autoimmune conditions, for example, any stimulation might increase the production or pathological impact of antibodies.', 4);

  RAISE NOTICE 'Autoimmune Diseases disorder created';
END $$;

-- ============================================================================
-- ELIMINATION AND DETOX ISSUES
-- ============================================================================

DO $$
DECLARE
  v_immune_system_id INTEGER;
  v_disorder_id INTEGER;
  v_herb_id INTEGER;
  v_action_id INTEGER;
BEGIN
  SELECT id INTO v_immune_system_id FROM herbal.body_systems WHERE name = 'Immune';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order)
  VALUES ('Elimination and Detox Issues', v_immune_system_id, 2)
  RETURNING id INTO v_disorder_id;

  -- Alterative action
  v_action_id := herbal.ensure_action('Alterative');

  v_herb_id := herbal.ensure_herb('Arctium lappa', 'burdock');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Urtica dioica';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Aperient/laxative
  v_action_id := herbal.ensure_action('Aperient');

  v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Diaphoretic
  v_action_id := herbal.ensure_action('Diaphoretic');

  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  v_herb_id := herbal.ensure_herb('Eupatorium perfoliatum', 'boneset');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Diuretic
  v_action_id := herbal.ensure_action('Diuretic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Expectorant
  v_action_id := herbal.ensure_action('Expectorant');

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'horehound');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Verbascum thapsus';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  v_herb_id := herbal.ensure_herb('Tussilago farfara', 'coltsfoot');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  -- Hepatic
  v_action_id := herbal.ensure_action('Hepatic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Taraxacum officinale';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Silybum marianum';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  -- Lymphatic tonic
  v_action_id := herbal.ensure_action('Lymphatic tonic');

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Calendula officinalis';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 1);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Galium aparine';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 2);

  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = 'Trifolium pratense';
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
  VALUES (v_disorder_id, v_herb_id, v_action_id, 3);

  RAISE NOTICE 'Elimination and Detox Issues disorder created';
END $$;

-- Clean up helper functions (will be recreated in next part)
DROP FUNCTION IF EXISTS herbal.ensure_herb(TEXT, TEXT);
DROP FUNCTION IF EXISTS herbal.ensure_action(TEXT);
