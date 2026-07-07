SET search_path TO herbal, public;

-- Maps each primary action to the physiomedicalist pattern it treats.
-- Deficiency = underactive / depleted / cold → build, strengthen, nourish, stimulate.
-- Excess    = overactive / congested / hot  → drain, cool, calm, sedate, tone.
-- Actions that are neutral or context-dependent are omitted (Analgesic, Carminative, etc.)
-- and will simply not appear in intake assessment herb suggestions.

CREATE TABLE IF NOT EXISTS herbal.action_pattern (
  primary_action_id INTEGER PRIMARY KEY REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,
  pattern           TEXT NOT NULL CHECK (pattern IN ('deficiency', 'excess'))
);

GRANT SELECT ON herbal.action_pattern TO anon, authenticated;

DO $$
BEGIN
  -- Deficiency-treating actions
  INSERT INTO herbal.action_pattern (primary_action_id, pattern)
  SELECT id, 'deficiency'
  FROM herbal.primary_actions
  WHERE name IN (
    'Adaptogen',
    'Antidepressant',
    'Bitter',
    'Cardiotonic',
    'Circulatory stimulant',
    'Demulcent',
    'Digestive support',
    'Emmenagogue',
    'Emollient',
    'Hepatic',
    'Hypertensive',
    'Immune stimulant',
    'Immune support',
    'Nervine stimulant',
    'Nervine tonic',
    'Nervine Tonic',
    'Prostate tonic',
    'Pulmonary tonic',
    'Tonic',
    'Uterine demulcent',
    'Uterine tonic',
    'Vascular tonic',
    'Vulnerary'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Seeded deficiency action patterns: % rows', (SELECT COUNT(*) FROM herbal.action_pattern WHERE pattern = 'deficiency');

  -- Excess-treating actions
  INSERT INTO herbal.action_pattern (primary_action_id, pattern)
  SELECT id, 'excess'
  FROM herbal.primary_actions
  WHERE name IN (
    'Alterative',
    'Anti-inflammatory',
    'Anticatarhal',
    'Anticatarrhal',
    'Antimicrobial',
    'Antipruritic',
    'Antirheumatic',
    'Antispasmodic',
    'Astringent',
    'Diaphoretic',
    'Diuretic',
    'Hormonal normalizer',
    'Hypnotic',
    'Hypotensive',
    'Immunomodulator',
    'Lymphatic',
    'Lymphatic tonic',
    'Nervine',
    'Nervine relaxant',
    'Nervine Relaxant',
    'Peripheral vasodilator',
    'Relaxing expectorant',
    'Stimulating expectorant',
    'Stimulating Expectorant',
    'Uterine astringent'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Seeded excess action patterns: % rows', (SELECT COUNT(*) FROM herbal.action_pattern WHERE pattern = 'excess');
END $$;
