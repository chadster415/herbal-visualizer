SET search_path TO herbal, public;

-- Table to store search synonyms for inferred ailment keywords.
-- Each row covers one unique keyword from herb_keywords WHERE category='ailment'.
-- Used by the disorder search to surface class-notes ailments alongside real disorders.

CREATE TABLE IF NOT EXISTS herbal.ailment_search_terms (
  ailment_keyword TEXT PRIMARY KEY,
  synonyms        TEXT[] NOT NULL DEFAULT '{}'
);

GRANT ALL ON TABLE herbal.ailment_search_terms TO postgres, anon, authenticated, service_role;
ALTER TABLE herbal.ailment_search_terms ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='ailment_search_terms' AND policyname='anon_read') THEN
    CREATE POLICY "anon_read" ON herbal.ailment_search_terms FOR SELECT USING (true);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='herbal' AND tablename='ailment_search_terms' AND policyname='service_write') THEN
    CREATE POLICY "service_write" ON herbal.ailment_search_terms FOR ALL TO service_role USING (true) WITH CHECK (true);
  END IF;
END $$;

-- Seed synonyms for Class 61 ailment keywords
INSERT INTO herbal.ailment_search_terms (ailment_keyword, synonyms) VALUES
  ('acute illness',          ARRAY['onset illness','cold and flu','acute infection','infection','acute onset']),
  ('anxiety',                ARRAY['stress','anxiety disorder','nervousness','worry','anxiousness','nervous tension']),
  ('bile flow',              ARRAY['biliary support','bile secretion','cholagogue','gallbladder support']),
  ('circulation',            ARRAY['blood flow','vascular support','circulatory support','peripheral circulation']),
  ('digestive support',      ARRAY['digestion','digestive health','GI support','gastrointestinal support']),
  ('digestive tonic',        ARRAY['bitters','GI tonic','gut tonic','digestive support','digestive']),
  ('energy support',         ARRAY['fatigue','low energy','vitality','adrenal support','energy','exhaustion']),
  ('estrogen metabolism',    ARRAY['estrogen processing','estrogen clearance','estrogen detoxification','liver hormones']),
  ('estrogen support',       ARRAY['estrogenic','estrogen balance','estrogen deficiency','phytoestrogen']),
  ('fibroids',               ARRAY['uterine fibroids','fibromyoma','myoma','uterine growths','fibroid']),
  ('gut inflammation',       ARRAY['intestinal inflammation','gut health','leaky gut','IBS','GI inflammation','intestinal']),
  ('heavy bleeding',         ARRAY['menorrhagia','heavy menstrual bleeding','HMB','heavy periods','metrorrhagia','flooding']),
  ('hormonal imbalance',     ARRAY['hormone imbalance','hormonal disruption','endocrine imbalance','dysmenorrhea']),
  ('hormonal support',       ARRAY['hormone support','endocrine support','hormonal health','hormone balance']),
  ('hormone balance',        ARRAY['hormonal balance','hormone regulation','endocrine balance','hormonal health']),
  ('hydration',              ARRAY['fluid balance','moistening','demulcent','dryness','mucous membrane hydration']),
  ('immune support',         ARRAY['immunity','immune system','immune health','immune function','immunomodulator']),
  ('inflammation',           ARRAY['anti-inflammatory','inflammatory response','acute inflammation','chronic inflammation','swelling']),
  ('kidney support',         ARRAY['renal support','kidney health','kidney function','nephroprotective','kidneys']),
  ('liver support',          ARRAY['hepatic support','liver health','liver function','hepatoprotective','hepatitis','liver']),
  ('lymphatic support',      ARRAY['lymph drainage','lymphatic drainage','lymphatic health','lymphatics','lymph']),
  ('mineral support',        ARRAY['mineralization','mineral deficiency','mineral replenishment','nutritive','minerals']),
  ('mucous membrane support',ARRAY['mucosa','mucous membranes','mucosal health','demulcent','mucosal lining','mucous']),
  ('perimenopause',          ARRAY['perimenopausal','menopausal transition','pre-menopause','peri-menopause','menopause']),
  ('pituitary support',      ARRAY['pituitary gland','pituitary function','HPO axis','hypothalamic-pituitary','pituitary']),
  ('premenopause',           ARRAY['pre-menopause','perimenopause','early menopause','menopausal transition','menopause']),
  ('reproductive support',   ARRAY['reproductive health','female reproductive','fertility support','reproductive system']),
  ('stress',                 ARRAY['nervous tension','adrenal stress','HPA axis','chronic stress','tension','anxiety']),
  ('urinary tract infection',ARRAY['UTI','bladder infection','cystitis','urinary infection','bladder inflammation']),
  ('uterine bleeding',       ARRAY['uterine hemorrhage','menorrhagia','abnormal uterine bleeding','AUB','heavy bleeding']),
  ('uterine health',         ARRAY['uterus health','uterine function','womb health','uterine support','uterine tonic']),
  ('uterine support',        ARRAY['uterine health','uterotonic','uterus support','uterine function','womb support']),
  ('uterine tonic',          ARRAY['uterine support','uterotonic','uterine health','womb tonic','uterine']),
  ('UTI',                    ARRAY['urinary tract infection','bladder infection','cystitis','urinary infection']),
  ('vaginitis',              ARRAY['vaginal infection','vaginal inflammation','yeast infection','bacterial vaginosis','BV','vaginal health'])
ON CONFLICT (ailment_keyword) DO NOTHING;
