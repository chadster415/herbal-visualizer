-- Aging body system with disorders, elder-recommended herbs, and aging_herbs table.
-- Creates the aging_herbs table used by the frontend to show 🧓 on Tonic action herb cards
-- and on Filter Herbs result cards when the Tonic action is selected.

SET search_path TO herbal, public;

-- ============================================================================
-- 1. AGING BODY SYSTEM
-- ============================================================================
INSERT INTO herbal.body_systems (name) VALUES ('Aging')
ON CONFLICT (name) DO NOTHING;

-- ============================================================================
-- 2. AGING HERBS TABLE
-- Flat list of herb IDs recommended for elders (from Aging.md).
-- Queried by frontend to render the Elder (🧓) badge.
-- ============================================================================
CREATE TABLE IF NOT EXISTS herbal.aging_herbs (
  herb_id INTEGER PRIMARY KEY REFERENCES herbal.herbs(id) ON DELETE CASCADE
);

COMMENT ON TABLE herbal.aging_herbs IS
  'Herbs recommended for elders/aging. Used by frontend to show 🧓 on Tonic herb cards.';

GRANT ALL ON herbal.aging_herbs TO postgres, anon, authenticated, service_role;

-- ============================================================================
-- 3. DISORDERS UNDER AGING
-- ============================================================================
DO $$
DECLARE
  v_aging_id INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';

  INSERT INTO herbal.disorders (name, body_system_id, sort_order) VALUES
    ('Cardiovascular System Issues', v_aging_id, 1),
    ('Respiratory System Issues',    v_aging_id, 2),
    ('Nervous System Issues',        v_aging_id, 3),
    ('Digestive System Issues',      v_aging_id, 4),
    ('Urinary System Issues',        v_aging_id, 5),
    ('Reproductive System Issues',   v_aging_id, 6),
    ('Musculoskeletal System Issues',v_aging_id, 7),
    ('Skin Issues',                  v_aging_id, 8)
  ON CONFLICT (name, body_system_id) DO NOTHING;

  RAISE NOTICE 'Aging disorders created.';
END $$;

-- ============================================================================
-- 4. DISORDER NOTES (guarded against re-run duplicates)
-- ============================================================================
DO $$
DECLARE
  v_aging_id  INTEGER;
  v_dis_id    INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';

  -- Cardiovascular notes
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Cardiovascular System Issues' AND body_system_id = v_aging_id;
  IF NOT EXISTS (SELECT 1 FROM herbal.disorder_notes WHERE disorder_id = v_dis_id) THEN
    INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
      (v_dis_id, 'An important exception may be the use of Cytisus scoparius (Scotch broom) in the treatment of hypotension. It may prove too strong for some elderly people, and so should be avoided.', 1),
      (v_dis_id, 'More than with any other age group, it is essential to avoid the inappropriate use of cardiac glycoside-containing herbs in elders.', 2);
  END IF;

  -- Nervous System notes
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Nervous System Issues' AND body_system_id = v_aging_id;
  IF NOT EXISTS (SELECT 1 FROM herbal.disorder_notes WHERE disorder_id = v_dis_id) THEN
    INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
      (v_dis_id, 'A caution must be voiced about the use of Valeriana with elders. A very small number of people experience a paradoxical reaction — instead of a relaxing or hypnotic effect, they have a caffeinelike stimulation. If this happens, Valeriana should be avoided. If a paradoxical reaction does occur, Scutellaria will ease the unpleasant symptoms quite effectively.', 1),
      (v_dis_id, 'Note that Humulus lupulus was not included in the list of relevant hypnotics, as it has a tendency to induce depression if used consistently.', 2),
      (v_dis_id, 'Ginkgo biloba: while it has a popular reputation as a "memory" herb, it should be considered a cardiovascular remedy in the treatment of cerebrovascular dysfunction and peripheral vascular disorders. Studies confirm the efficacy of ginkgo extract for treating disturbances of cerebrovascular function.', 3);
  END IF;

  -- Digestive notes
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Digestive System Issues' AND body_system_id = v_aging_id;
  IF NOT EXISTS (SELECT 1 FROM herbal.disorder_notes WHERE disorder_id = v_dis_id) THEN
    INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
      (v_dis_id, 'Herbs have much to offer for general symptomatic relief of digestive upsets. This is especially the case when digestive symptoms are related to side effects of essential allopathic medications.', 1);
  END IF;

  -- Musculoskeletal notes
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Musculoskeletal System Issues' AND body_system_id = v_aging_id;
  IF NOT EXISTS (SELECT 1 FROM herbal.disorder_notes WHERE disorder_id = v_dis_id) THEN
    INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
      (v_dis_id, 'There is usually no need to resort to intense treatments for musculoskeletal problems in elders, as the milder antirheumatic herbs are often effective, given time.', 1),
      (v_dis_id, 'Make it a priority to address any digestive symptoms present in older patients with rheumatic conditions. Any such symptoms indicate that digestion, assimilation, and elimination are not functioning at optimal levels.', 2);
  END IF;

  -- Skin notes
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Skin Issues' AND body_system_id = v_aging_id;
  IF NOT EXISTS (SELECT 1 FROM herbal.disorder_notes WHERE disorder_id = v_dis_id) THEN
    INSERT INTO herbal.disorder_notes (disorder_id, note_text, sort_order) VALUES
      (v_dis_id, 'The topical anti-inflammatory activity of Calendula officinalis and Hypericum perforatum are particularly valuable.', 1),
      (v_dis_id, 'The emphasis should be on gentle alteratives and tonics, with extra focus on general liver, digestive, and kidney function.', 2),
      (v_dis_id, 'Many essential oils are also helpful when applied topically.', 3);
  END IF;

  RAISE NOTICE 'Aging disorder notes created.';
END $$;

-- ============================================================================
-- 5. CARDIOVASCULAR HERBS
-- herb_primary_actions: Tonic / Cardiovascular
-- disorder_action_herbs: Cardiovascular System Issues / Tonic
-- aging_herbs
-- ============================================================================
DO $$
DECLARE
  v_aging_id    INTEGER;
  v_cv_id       INTEGER;
  v_tonic_id    INTEGER;
  v_dis_id      INTEGER;
  v_herb_id     INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_cv_id    FROM herbal.body_systems WHERE name = 'Cardiovascular';
  v_tonic_id := herbal.ensure_action('Tonic');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Cardiovascular System Issues' AND body_system_id = v_aging_id;

  -- Helper macro: insert herb, link to Tonic/Cardiovascular, mark as aging, add to disorder
  -- (repeated inline since SQL lacks macros)

  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Aesculus hippocastanum', 'horse chestnut');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Crataegus spp.', 'hawthorn');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Ginkgo biloba', 'ginkgo');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Tilia spp.', 'linden');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 8) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Vaccinium myrtillus', 'bilberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 9) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_cv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 10) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Cardiovascular aging herbs done.';
END $$;

-- ============================================================================
-- 6. RESPIRATORY HERBS
-- herb_primary_actions: Tonic / Respiratory
-- ============================================================================
DO $$
DECLARE
  v_aging_id  INTEGER;
  v_resp_id   INTEGER;
  v_tonic_id  INTEGER;
  v_expec_id  INTEGER;
  v_dis_id    INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_resp_id  FROM herbal.body_systems WHERE name = 'Respiratory';
  v_tonic_id := herbal.ensure_action('Tonic');
  v_expec_id := herbal.ensure_action('Stimulating Expectorant');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Respiratory System Issues' AND body_system_id = v_aging_id;

  -- Respiratory tonics
  v_herb_id := herbal.ensure_herb('Allium sativum', 'garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Asclepias tuberosa', 'pleurisy root');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Chondrus crispus', 'Irish moss');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Inula helenium', 'elecampane');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Marrubium vulgare', 'horehound');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Prunus serotina', 'wild cherry bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 8) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Thymus vulgaris', 'thyme');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 9) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Verbascum thapsus', 'mullein');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_resp_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 10) ON CONFLICT DO NOTHING;

  -- Stronger effectors (Stimulating Expectorant)
  v_herb_id := herbal.ensure_herb('Grindelia camporum', 'gumweed');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
    VALUES (v_herb_id, v_tonic_id, v_resp_id, 'strong') ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_expec_id, 11) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Lobelia inflata', 'lobelia');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
    VALUES (v_herb_id, v_tonic_id, v_resp_id, 'strong') ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_expec_id, 12) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Sanguinaria canadensis', 'bloodroot');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
    VALUES (v_herb_id, v_tonic_id, v_resp_id, 'strong') ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_expec_id, 13) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Respiratory aging herbs done.';
END $$;

-- ============================================================================
-- 7. NERVOUS SYSTEM HERBS
-- herb_primary_actions: Tonic / Nervous
-- disorder_action_herbs: grouped by Nervine Tonic / Nervine Relaxant / Hypnotic / Antidepressant
-- ============================================================================
DO $$
DECLARE
  v_aging_id      INTEGER;
  v_nerv_id       INTEGER;
  v_tonic_id      INTEGER;
  v_nvtonic_id    INTEGER;
  v_nvrelax_id    INTEGER;
  v_hypnotic_id   INTEGER;
  v_antidep_id    INTEGER;
  v_dis_id        INTEGER;
  v_herb_id       INTEGER;
BEGIN
  SELECT id INTO v_aging_id  FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_nerv_id   FROM herbal.body_systems WHERE name = 'Nervous';
  v_tonic_id   := herbal.ensure_action('Tonic');
  v_nvtonic_id := herbal.ensure_action('Nervine Tonic');
  v_nvrelax_id := herbal.ensure_action('Nervine Relaxant');
  v_hypnotic_id:= herbal.ensure_action('Hypnotic');
  v_antidep_id := herbal.ensure_action('Antidepressant');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Nervous System Issues' AND body_system_id = v_aging_id;

  -- Nervine Tonics
  v_herb_id := herbal.ensure_herb('Avena sativa', 'oats');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvtonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvtonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Scutellaria lateriflora', 'skullcap');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvtonic_id, 3) ON CONFLICT DO NOTHING;

  -- Nervine Relaxants
  v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hyssopus officinalis', 'hyssop');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 8) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Melissa officinalis', 'lemon balm');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 9) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Tilia spp.', 'linden');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_nvrelax_id, 10) ON CONFLICT DO NOTHING;

  -- Hypnotics
  v_herb_id := herbal.ensure_herb('Eschscholzia californica', 'California poppy');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_hypnotic_id, 11) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  -- already in aging_herbs; disorder_action_herbs for Hypnotic is distinct from Nervine Relaxant
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_hypnotic_id, 12) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Passiflora incarnata', 'passionflower');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_hypnotic_id, 13) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Valeriana officinalis', 'valerian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_hypnotic_id, 14) ON CONFLICT DO NOTHING;

  -- Antidepressants
  v_herb_id := herbal.ensure_herb('Avena sativa', 'oats');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antidep_id, 15) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Artemisia vulgaris', 'mugwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antidep_id, 16) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antidep_id, 17) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Lavandula spp.', 'lavender');
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antidep_id, 18) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Verbena officinalis', 'vervain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_nerv_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antidep_id, 19) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Nervous system aging herbs done.';
END $$;

-- ============================================================================
-- 8. DIGESTIVE HERBS
-- herb_primary_actions: Tonic / Digestive
-- ============================================================================
DO $$
DECLARE
  v_aging_id  INTEGER;
  v_dig_id    INTEGER;
  v_tonic_id  INTEGER;
  v_dis_id    INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_dig_id   FROM herbal.body_systems WHERE name = 'Digestive';
  v_tonic_id := herbal.ensure_action('Tonic');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Digestive System Issues' AND body_system_id = v_aging_id;

  v_herb_id := herbal.ensure_herb('Agrimonia eupatoria', 'agrimony');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Althaea officinalis', 'marshmallow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Chondrus crispus', 'Irish moss');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Filipendula ulmaria', 'meadowsweet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Foeniculum vulgare', 'fennel');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Gentiana lutea', 'gentian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Matricaria recutita', 'chamomile');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Mentha piperita', 'peppermint');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 8) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Rumex crispus', 'yellow dock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 9) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Silybum marianum', 'milk thistle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 10) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Symphytum officinale', 'comfrey');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 11) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Ulmus rubra', 'slippery elm');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_dig_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 12) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Digestive aging herbs done.';
END $$;

-- ============================================================================
-- 9. URINARY HERBS
-- herb_primary_actions: Tonic / Urinary
-- ============================================================================
DO $$
DECLARE
  v_aging_id  INTEGER;
  v_uri_id    INTEGER;
  v_tonic_id  INTEGER;
  v_dis_id    INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_uri_id   FROM herbal.body_systems WHERE name = 'Urinary';
  v_tonic_id := herbal.ensure_action('Tonic');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Urinary System Issues' AND body_system_id = v_aging_id;

  v_herb_id := herbal.ensure_herb('Achillea millefolium', 'yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Arctostaphylos uva-ursi', 'bearberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Elymus repens', 'couch grass');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Sambucus nigra', 'elder');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Taraxacum officinale', 'dandelion leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Vaccinium macrocarpon', 'cranberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_uri_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 7) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Urinary aging herbs done.';
END $$;

-- ============================================================================
-- 10. REPRODUCTIVE HERBS
-- herb_primary_actions: Tonic / Reproductive
-- ============================================================================
DO $$
DECLARE
  v_aging_id  INTEGER;
  v_rep_id    INTEGER;
  v_tonic_id  INTEGER;
  v_dis_id    INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_rep_id   FROM herbal.body_systems WHERE name = 'Reproductive';
  v_tonic_id := herbal.ensure_action('Tonic');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Reproductive System Issues' AND body_system_id = v_aging_id;

  v_herb_id := herbal.ensure_herb('Caulophyllum thalictroides', 'blue cohosh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Leonurus cardiaca', 'motherwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Mitchella repens', 'partridgeberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Serenoa repens', 'saw palmetto');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Viburnum opulus', 'cramp bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Viburnum prunifolium', 'black haw');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Vitex agnus-castus', 'chasteberry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_rep_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 8) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Reproductive aging herbs done.';
END $$;

-- ============================================================================
-- 11. MUSCULOSKELETAL HERBS
-- herb_primary_actions: Tonic / Musculoskeletal
-- ============================================================================
DO $$
DECLARE
  v_aging_id    INTEGER;
  v_musc_id     INTEGER;
  v_tonic_id    INTEGER;
  v_antirheum_id INTEGER;
  v_dis_id      INTEGER;
  v_herb_id     INTEGER;
BEGIN
  SELECT id INTO v_aging_id  FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_musc_id   FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  v_tonic_id     := herbal.ensure_action('Tonic');
  v_antirheum_id := herbal.ensure_action('Antirheumatic');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Musculoskeletal System Issues' AND body_system_id = v_aging_id;

  -- Main tonics
  v_herb_id := herbal.ensure_herb('Apium graveolens', 'celery seed');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Angelica archangelica', 'angelica');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Betula spp.', 'birch');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Cimicifuga racemosa', 'black cohosh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Dioscorea villosa', 'wild yam');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Filipendula ulmaria', 'meadowsweet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Menyanthes trifoliata', 'bogbean');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Salix spp.', 'willow bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 8) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_musc_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_tonic_id, 9) ON CONFLICT DO NOTHING;

  -- Stronger effectors (Antirheumatic)
  v_herb_id := herbal.ensure_herb('Guaiacum officinale', 'guaiacum');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
    VALUES (v_herb_id, v_tonic_id, v_musc_id, 'strong') ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antirheum_id, 10) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Harpagophytum procumbens', 'devil''s claw');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
    VALUES (v_herb_id, v_tonic_id, v_musc_id, 'strong') ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antirheum_id, 11) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Zanthoxylum americanum', 'prickly ash');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)
    VALUES (v_herb_id, v_tonic_id, v_musc_id, 'strong') ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_antirheum_id, 12) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Musculoskeletal aging herbs done.';
END $$;

-- ============================================================================
-- 12. SKIN HERBS
-- herb_primary_actions: Tonic / Skin
-- ============================================================================
DO $$
DECLARE
  v_aging_id  INTEGER;
  v_skin_id   INTEGER;
  v_tonic_id  INTEGER;
  v_alter_id  INTEGER;
  v_dis_id    INTEGER;
  v_herb_id   INTEGER;
BEGIN
  SELECT id INTO v_aging_id FROM herbal.body_systems WHERE name = 'Aging';
  SELECT id INTO v_skin_id  FROM herbal.body_systems WHERE name = 'Skin';
  v_tonic_id := herbal.ensure_action('Tonic');
  v_alter_id := herbal.ensure_action('Alterative');
  SELECT id INTO v_dis_id FROM herbal.disorders
    WHERE name = 'Skin Issues' AND body_system_id = v_aging_id;

  v_herb_id := herbal.ensure_herb('Calendula officinalis', 'calendula');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 1) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Galium aparine', 'cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 2) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Hypericum perforatum', 'St. John''s wort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 3) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Plantago major', 'plantain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 4) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Stellaria media', 'chickweed');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 5) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Trifolium pratense', 'red clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 6) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Urtica dioica', 'nettle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 7) ON CONFLICT DO NOTHING;

  v_herb_id := herbal.ensure_herb('Viola tricolor', 'heartsease');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id)
    VALUES (v_herb_id, v_tonic_id, v_skin_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.aging_herbs VALUES (v_herb_id) ON CONFLICT DO NOTHING;
  INSERT INTO herbal.disorder_action_herbs (disorder_id, herb_id, primary_action_id, sort_order)
    VALUES (v_dis_id, v_herb_id, v_alter_id, 8) ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Skin aging herbs done.';
END $$;
