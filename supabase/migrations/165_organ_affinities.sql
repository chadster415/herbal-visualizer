SET search_path TO herbal, public;

-- Source: Herbal Academy "Herbal Affinities" course worksheet.
-- Maps 26 organ categories to existing body systems using 'Organ Affinity' action.
-- Organ → body system mapping:
--   Adrenal glands → Endocrine       Blood → Cardiovascular
--   Bone → Musculoskeletal           Brain → Nervous
--   Breast → Reproductive - Female   Hair → Skin
--   Heart → Cardiovascular           Intestines → Digestive
--   Joints → Musculoskeletal         Kidneys → Urinary
--   Liver → Digestive                Lymphatic system → Immune
--   Mouth → Digestive                Mucous membranes → Respiratory
--   Muscle → Musculoskeletal         Nervous system → Nervous
--   Prostate → Reproductive - Male   Respiratory system → Respiratory
--   Sinuses → Respiratory - Upper    Skin → Skin
--   Stomach → Digestive              Testes → Reproductive - Male
--   Throat → Respiratory - Upper     Thyroid → Endocrine
--   Urinary tract → Urinary          Uterus → Reproductive - Female
--   Vasculature → Cardiovascular

DO $$
DECLARE
  v_aff  INTEGER;  -- Organ Affinity action id
  v_cv   INTEGER;  -- Cardiovascular
  v_dig  INTEGER;  -- Digestive
  v_end  INTEGER;  -- Endocrine
  v_imm  INTEGER;  -- Immune
  v_msk  INTEGER;  -- Musculoskeletal
  v_nrv  INTEGER;  -- Nervous
  v_rf   INTEGER;  -- Reproductive - Female
  v_rm   INTEGER;  -- Reproductive - Male
  v_res  INTEGER;  -- Respiratory
  v_ru   INTEGER;  -- Respiratory - Upper
  v_skn  INTEGER;  -- Skin
  v_uri  INTEGER;  -- Urinary
  h      INTEGER;
BEGIN
  SELECT id INTO v_aff FROM herbal.primary_actions  WHERE name = 'Organ Affinity';
  SELECT id INTO v_cv  FROM herbal.body_systems WHERE name = 'Cardiovascular';
  SELECT id INTO v_dig FROM herbal.body_systems WHERE name = 'Digestive';
  SELECT id INTO v_end FROM herbal.body_systems WHERE name = 'Endocrine';
  SELECT id INTO v_imm FROM herbal.body_systems WHERE name = 'Immune';
  SELECT id INTO v_msk FROM herbal.body_systems WHERE name = 'Musculoskeletal';
  SELECT id INTO v_nrv FROM herbal.body_systems WHERE name = 'Nervous';
  SELECT id INTO v_rf  FROM herbal.body_systems WHERE name = 'Reproductive - Female';
  SELECT id INTO v_rm  FROM herbal.body_systems WHERE name = 'Reproductive - Male';
  SELECT id INTO v_res FROM herbal.body_systems WHERE name = 'Respiratory';
  SELECT id INTO v_ru  FROM herbal.body_systems WHERE name = 'Respiratory - Upper';
  SELECT id INTO v_skn FROM herbal.body_systems WHERE name = 'Skin';
  SELECT id INTO v_uri FROM herbal.body_systems WHERE name = 'Urinary';

  -- ── ADRENAL GLANDS → Endocrine ─────────────────────────────────────────────
  h := herbal.ensure_herb('Eleutherococcus senticosus', 'Eleuthero');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Rhodiola rosea', 'Rhodiola');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Ocimum tenuiflorum', 'Tulsi');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Adrenal glands done.';

  -- ── BLOOD → Cardiovascular ─────────────────────────────────────────────────
  h := herbal.ensure_herb('Angelica archangelica', 'Angelica');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Capsicum annuum', 'Cayenne');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Cinnamomum spp.', 'Cinnamon');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Angelica sinensis', 'Dong Quai');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Urtica dioica', 'Nettle', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Curcuma longa', 'Turmeric');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Rumex crispus', 'Yellow Dock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Blood done.';

  -- ── BONE → Musculoskeletal ─────────────────────────────────────────────────
  h := herbal.ensure_herb('Symphytum officinale', 'Comfrey', 'root');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Urtica dioica', 'Nettle', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Avena sativa', 'Oat', 'milky oats');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Rubus idaeus', 'Raspberry', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Bone done.';

  -- ── BRAIN → Nervous ────────────────────────────────────────────────────────
  h := herbal.ensure_herb('Bacopa monnieri', 'Bacopa');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Ginkgo biloba', 'Ginkgo');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Centella asiatica', 'Gotu Kola', 'aerial parts');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salvia rosmarinus', 'Rosemary');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Betonica officinalis', 'Wood Betony');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Brain done.';

  -- ── BREAST → Reproductive - Female ────────────────────────────────────────
  h := herbal.ensure_herb('Foeniculum vulgare', 'Fennel');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Trigonella foenum-graecum', 'Fenugreek');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Humulus lupulus', 'Hops');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Trifolium pratense', 'Red Clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Viola spp.', 'Violet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Vitex agnus-castus', 'Vitex');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Breast done.';

  -- ── HAIR → Skin ────────────────────────────────────────────────────────────
  h := herbal.ensure_herb('Matricaria chamomilla', 'Chamomile');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Urtica dioica', 'Nettle', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Avena sativa', 'Oat', 'milky oats');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salvia rosmarinus', 'Rosemary');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Hair done.';

  -- ── HEART → Cardiovascular ─────────────────────────────────────────────────
  h := herbal.ensure_herb('Allium sativum', 'Garlic');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Camellia sinensis', 'Green Tea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'berry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Melissa officinalis', 'Lemon Balm');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Tilia spp.', 'Linden');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Leonurus cardiaca', 'Motherwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Heart done.';

  -- ── INTESTINES → Digestive ─────────────────────────────────────────────────
  h := herbal.ensure_herb('Cynara scolymus', 'Artichoke');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Arctium lappa', 'Burdock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Codonopsis pilosula', 'Codonopsis');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Foeniculum vulgare', 'Fennel');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Althaea officinalis', 'Marshmallow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Mentha x piperita', 'Peppermint');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Betonica officinalis', 'Wood Betony');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Rumex crispus', 'Yellow Dock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Intestines done.';

  -- ── JOINTS → Musculoskeletal ───────────────────────────────────────────────
  h := herbal.ensure_herb('Symphytum officinale', 'Comfrey', 'root');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Polygonatum biflorum', 'Solomon''s Seal');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Curcuma longa', 'Turmeric');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salix spp.', 'Willow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Joints done.';

  -- ── KIDNEYS → Urinary ──────────────────────────────────────────────────────
  h := herbal.ensure_herb('Arctium lappa', 'Burdock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Codonopsis pilosula', 'Codonopsis');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Solidago spp.', 'Goldenrod');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Juniperus communis', 'Juniper');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Althaea officinalis', 'Marshmallow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Urtica dioica', 'Nettle', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Kidneys done.';

  -- ── LIVER → Digestive ──────────────────────────────────────────────────────
  h := herbal.ensure_herb('Eupatorium perfoliatum', 'Boneset');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Taraxacum officinale', 'Dandelion', 'root');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Silybum marianum', 'Milk Thistle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Smilax spp.', 'Sarsaparilla');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Schisandra chinensis', 'Schisandra');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Lentinula edodes', 'Shiitake');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Verbena spp.', 'Vervain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Liver done.';

  -- ── LYMPHATIC SYSTEM → Immune ──────────────────────────────────────────────
  h := herbal.ensure_herb('Arctium lappa', 'Burdock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Galium aparine', 'Cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Echinacea spp.', 'Echinacea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Trifolium pratense', 'Red Clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Prunella vulgaris', 'Self Heal');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Viola spp.', 'Violet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_imm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Lymphatic system done.';

  -- ── MOUTH → Digestive ──────────────────────────────────────────────────────
  h := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Zingiber officinale', 'Ginger');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Mentha x piperita', 'Peppermint');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Zanthoxylum americanum', 'Prickly Ash');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salvia officinalis', 'Sage');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Mouth done.';

  -- ── MUCOUS MEMBRANES → Respiratory ────────────────────────────────────────
  h := herbal.ensure_herb('Astragalus mongholicus', 'Astragalus');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Berberis aquifolium', 'Oregon Grape');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Glycyrrhiza glabra', 'Licorice');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Althaea officinalis', 'Marshmallow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Plantago spp.', 'Plantain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salvia officinalis', 'Sage');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Mucous membranes done.';

  -- ── MUSCLE → Musculoskeletal ───────────────────────────────────────────────
  h := herbal.ensure_herb('Withania somnifera', 'Ashwagandha');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Actaea racemosa', 'Black Cohosh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Piper methysticum', 'Kava');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salvia officinalis', 'Sage');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Scutellaria lateriflora', 'Skullcap');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Valeriana officinalis', 'Valerian');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Verbena spp.', 'Vervain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_msk) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Muscle done.';

  -- ── NERVOUS SYSTEM → Nervous ───────────────────────────────────────────────
  h := herbal.ensure_herb('Eschscholzia californica', 'California Poppy');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Humulus lupulus', 'Hops');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Piscidia piscipula', 'Jamaican Dogwood');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Melissa officinalis', 'Lemon Balm');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Tilia spp.', 'Linden');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Avena sativa', 'Oat', 'milky oats');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Passiflora incarnata', 'Passionflower');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Scutellaria lateriflora', 'Skullcap');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Hypericum perforatum', 'St. John''s Wort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_nrv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Nervous system done.';

  -- ── PROSTATE → Reproductive - Male ────────────────────────────────────────
  h := herbal.ensure_herb('Zea mays', 'Corn');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Juniperus communis', 'Juniper');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Urtica dioica', 'Nettle', 'root');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Serenoa repens', 'Saw Palmetto');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Prostate done.';

  -- ── RESPIRATORY SYSTEM → Respiratory ──────────────────────────────────────
  h := herbal.ensure_herb('Inula helenium', 'Elecampane');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Marrubium vulgare', 'Horehound');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Hyssopus officinalis', 'Hyssop');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Verbascum thapsus', 'Mullein', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Schisandra chinensis', 'Schisandra');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Aralia racemosa', 'Spikenard');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Ocimum tenuiflorum', 'Tulsi');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Usnea spp.', 'Usnea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Prunus serotina', 'Wild Cherry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_res) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Respiratory system done.';

  -- ── SINUSES → Respiratory - Upper ─────────────────────────────────────────
  h := herbal.ensure_herb('Nepeta cataria', 'Catnip');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Sambucus nigra', 'Elder', 'flower');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Zingiber officinale', 'Ginger');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Armoracia rusticana', 'Horseradish');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Plantago spp.', 'Plantain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Sinuses done.';

  -- ── SKIN → Skin ────────────────────────────────────────────────────────────
  h := herbal.ensure_herb('Arctium lappa', 'Burdock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Stellaria media', 'Chickweed');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Galium aparine', 'Cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Berberis aquifolium', 'Oregon Grape');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Plantago spp.', 'Plantain');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Trifolium pratense', 'Red Clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Hypericum perforatum', 'St. John''s Wort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Rumex crispus', 'Yellow Dock');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_skn) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Skin done.';

  -- ── STOMACH → Digestive ────────────────────────────────────────────────────
  h := herbal.ensure_herb('Angelica archangelica', 'Angelica');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Piper nigrum', 'Black Pepper');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Elettaria cardamomum', 'Cardamom');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Nepeta cataria', 'Catnip');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Melissa officinalis', 'Lemon Balm');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Filipendula ulmaria', 'Meadowsweet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Citrus spp.', 'Orange');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Acmella oleracea', 'Spilanthes', 'Aerial parts');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Betonica officinalis', 'Wood Betony');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_dig) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Stomach done.';

  -- ── TESTES → Reproductive - Male ──────────────────────────────────────────
  h := herbal.ensure_herb('Withania somnifera', 'Ashwagandha');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Smilax spp.', 'Sarsaparilla');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Serenoa repens', 'Saw Palmetto');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Schisandra chinensis', 'Schisandra');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Aralia racemosa', 'Spikenard');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rm) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Testes done.';

  -- ── THROAT → Respiratory - Upper ──────────────────────────────────────────
  h := herbal.ensure_herb('Calendula officinalis', 'Calendula');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Echinacea spp.', 'Echinacea');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Scrophularia nodosa', 'Figwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Althaea officinalis', 'Marshmallow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Trifolium pratense', 'Red Clover');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Salvia officinalis', 'Sage');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Prunella vulgaris', 'Self Heal');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Viola spp.', 'Violet');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_ru) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Throat done.';

  -- ── THYROID → Endocrine ────────────────────────────────────────────────────
  h := herbal.ensure_herb('Withania somnifera', 'Ashwagandha');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Fucus vesiculosus', 'Bladderwrack');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Commiphora guggul', 'Guggul');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Melissa officinalis', 'Lemon Balm');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Leonurus cardiaca', 'Motherwort');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_end) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Thyroid done.';

  -- ── URINARY TRACT → Urinary ────────────────────────────────────────────────
  h := herbal.ensure_herb('Galium aparine', 'Cleavers');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Zea mays', 'Corn');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Elymus repens', 'Couch Grass');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Solidago spp.', 'Goldenrod');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Equisetum arvense', 'Horsetail');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Petroselinum crispum', 'Parsley');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Arctostaphylos uva-ursi', 'Uva Ursi');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_uri) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Urinary tract done.';

  -- ── UTERUS → Reproductive - Female ────────────────────────────────────────
  h := herbal.ensure_herb('Actaea racemosa', 'Black Cohosh');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Viburnum opulus', 'Cramp Bark');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Turnera diffusa', 'Damiana');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Angelica sinensis', 'Dong Quai');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Alchemilla vulgaris', 'Lady''s Mantle');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Rubus idaeus', 'Raspberry', 'leaf');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Asparagus racemosus', 'Shatavari');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Vitex agnus-castus', 'Vitex');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_rf) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Uterus done.';

  -- ── VASCULATURE → Cardiovascular ──────────────────────────────────────────
  h := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'berry');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Crataegus spp.', 'Hawthorn', 'leaf & flower');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Aesculus hippocastanum', 'Horse Chestnut');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Hamamelis spp.', 'Witch Hazel');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  h := herbal.ensure_herb('Achillea millefolium', 'Yarrow');
  INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id) VALUES (h, v_aff, v_cv) ON CONFLICT (herb_id, primary_action_id, body_system_id) DO NOTHING;
  RAISE NOTICE 'Vasculature done.';

END $$;

DO $$ BEGIN RAISE NOTICE 'Migration 165 (organ affinities) complete.'; END $$;
