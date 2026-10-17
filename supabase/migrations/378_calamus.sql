-- Migration 378: Add Calamus (Acorus calamus)
-- Encountered in Class 22 notes (Monks Tea Blend Tincture with Wood Betony)
-- MM: RHIZOME/ROOT, Tincture [FRESH 1:2, DRY 1:5, 60% alcohol], 15–45 drops to 4x/day
-- Stockley's p.114: carminative, spasmolytic; β-asarone toxicity concern in non-North-American varieties
-- Easley / Hoffmann / Tilgner: not found
SET search_path TO herbal, public;

INSERT INTO herbal.herbs (common_name, latin_name, plant_part, synonyms)
VALUES (
  'Calamus',
  'Acorus calamus',
  'rhizome',
  ARRAY['Sweet Flag', 'Myrtle Flag', 'Sweet Sedge', 'Calamus aromaticus']
)
ON CONFLICT DO NOTHING;

-- Contraindications from Stockley's p.114:
-- β-Asarone (isoasarone) is toxic in animal studies; oils containing β-asarone should be avoided.
-- North American diploid variety contains no β-asarone; Indian tetraploid contains ~96%.
UPDATE herbal.herbs
SET contraindications = 'β-Asarone (isoasarone) is considered toxic based on animal studies; oils containing this substance should be avoided. Tetraploid (Indian) varieties contain ~96% β-asarone; North American diploid varieties contain none. Traditional use as carminative and spasmolytic predates the β-asarone safety concern.',
    contraindications_source = 'Stockley''s'
WHERE latin_name = 'Acorus calamus';
