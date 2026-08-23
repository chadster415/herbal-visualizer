-- Batch F: anthraquinone / cardiac glycoside herbs (9 herbs)
-- Rule: 25–50% alcohol or water; anthraquinone glycosides are polar and water-soluble,
-- so water decoction is often clinically effective. Moderate alcohol (25–50%) captures
-- both the glycoside forms and the less-polar aglycone fraction.
-- Cardiac glycoside herbs (Lily of the Valley, Squill) have narrow therapeutic windows —
-- safety notes included in each record.
-- 8 herbs via set_menstruum; 1 plant-part-specific entry (Madder root) via direct INSERT.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Aloe (Aloe vera):
  -- Aloin / barbaloin (anthraquinone C-glycoside), hydroxyanthraquinones in latex;
  -- mucopolysaccharides in the gel (water-based, not a tincture constituent)
  -- Anthraquinone glycosides are quite water-soluble; 25–40% alcohol extracts latex fraction
  PERFORM herbal.set_menstruum(
    'Aloe vera', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Aloin (anthraquinone C-glycoside) in the latex is water-soluble and extracts in both water and 25–40% alcohol. The gel mucopolysaccharides are aqueous and not captured in a standard tincture. Tincture of the whole leaf or dried latex; note that aloin is a harsh stimulant cathartic — use with caution.',
    false
  );

  -- Buckthorn (Rhamnus cathartica):
  -- Anthraquinone glycosides (rhamnicoside, emodin glycosides, frangula-emodin)
  -- Glycosides are polar and water-soluble; 25–45% alcohol for full-spectrum extraction
  PERFORM herbal.set_menstruum(
    'Rhamnus cathartica', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Anthraquinone glycosides (rhamnicoside, emodin-type) are polar and water-extractable; 25–45% alcohol captures both glycoside and free anthraquinone fractions. Berries are the medicinal part. Stimulant cathartic; fresh fruit can cause intense purging — dried or processed material preferred.',
    false
  );

  -- Cascara Sagrada (Rhamnus purshiana):
  -- Cascarosides A–D (anthraquinone glycosides), aloin, emodin
  -- Cascarosides are very water-soluble; 25–45% alcohol used for tincture
  PERFORM herbal.set_menstruum(
    'Rhamnus purshiana', 25, 45, NULL, NULL, true,
    '25–45% alcohol or water decoction',
    'Cascarosides A–D (anthraquinone O-glycosides), aloin, and emodin are the active laxative constituents. Cascarosides are highly water-soluble; both water decoction and 25–45% alcohol are effective. Aged bark (1+ year) is required — fresh bark contains anthraquinone aglycones that cause severe cramping.',
    false
  );

  -- Lily of the Valley (Convallaria majalis):
  -- Cardiac glycosides: convallatoxin, convalloside, convallotoxol (bufadienolide-type)
  -- NARROW THERAPEUTIC WINDOW — cardiac glycosides have a steep dose–response curve
  PERFORM herbal.set_menstruum(
    'Convallaria majalis', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Cardiac glycosides (convallatoxin, convalloside, convallotoxol) are water-soluble and extract in water and 25–40% alcohol. NARROW THERAPEUTIC WINDOW: cardiac glycosides have a steep dose–response curve with risk of toxicity at supertherapeutic doses. Clinical use requires expert supervision; not appropriate for self-treatment.',
    false
  );

  -- Rhubarb (Rheum palmatum):
  -- Anthraquinone glycosides (sennosides, rhein, emodin, aloe-emodin), tannins
  -- Dual character: cathartic anthraquinones + astringent tannins; both fractions water-extractable
  PERFORM herbal.set_menstruum(
    'Rheum palmatum', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water decoction',
    'Contains anthraquinone glycosides (sennosides, rhein, emodin) alongside tannins. Both fractions are water-extractable; the upper range (40–50%) better captures the less-polar free anthraquinone aglycones. At lower doses the tannins predominate and produce an astringent effect; at higher doses the anthraquinones produce catharsis — dose-dependent action.',
    false
  );

  -- Senna (Senna alexandrina):
  -- Sennosides A & B (anthraquinone diglycosides), rhein glycosides
  -- Sennosides are very water-soluble; infusion or decoction is the primary preparation
  PERFORM herbal.set_menstruum(
    'Senna alexandrina', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water infusion',
    'Sennosides A & B (anthraquinone diglycosides) and rhein glycosides are highly water-soluble; water infusion is the traditional and most clinically used preparation (cold or warm). Alcohol at 25–40% is used for tincture. Stimulant cathartic; avoid prolonged use and do not use in intestinal obstruction.',
    false
  );

  -- Squill (Urginea maritima):
  -- Bufadienolide cardiac glycosides: proscillaridin A, scillarens A & B
  -- NARROW THERAPEUTIC WINDOW — similar toxicological profile to digitalis
  PERFORM herbal.set_menstruum(
    'Urginea maritima', 25, 40, NULL, NULL, true,
    '25–40% alcohol or water',
    'Bufadienolide cardiac glycosides (proscillaridin A, scillarens A & B) are water-soluble and extract in water and 25–40% alcohol. NARROW THERAPEUTIC WINDOW: toxicological profile similar to digitalis — risk of cardiac toxicity at supertherapeutic doses. Clinical use requires expert supervision.',
    false
  );

  -- Wahoo (Euonymus atropurpureus):
  -- Cardenolide cardiac glycosides (evobioside, evomonoside), sesquiterpene alkaloids (evonine)
  -- Glycosides and alkaloids are polar; 25–50% alcohol used for tincture
  PERFORM herbal.set_menstruum(
    'Euonymus atropurpureus', 25, 50, NULL, NULL, true,
    '25–50% alcohol or water decoction',
    'Contains cardenolide cardiac glycosides (evobioside, evomonoside) and sesquiterpene alkaloids (evonine). Both classes are polar and water-extractable; 25–50% alcohol for full-spectrum tincture. The cardiac glycoside content warrants cautious dosing; toxic in overdose.',
    false
  );

  RAISE NOTICE 'Batch F (anthraquinone / cardiac glycoside herbs — set_menstruum): 8 records inserted/updated.';
END $$;

-- ── Direct INSERT for plant-part-specific entry ──

-- Madder (Rubia tinctorum, root, herb_id 2237):
-- Anthraquinone glycosides (alizarin-primeveroside, rubiadin primeveroside),
-- free anthraquinones (alizarin, purpurin, munjistin)
-- Glycosides are water-soluble; free anthraquinones (aglycones) need moderate alcohol
INSERT INTO herbal.herb_menstruum
  (herb_id, alcohol_pct_min, alcohol_pct_max, water_effective, primary_label, notes, needs_review)
VALUES (
  2237, 25, 50, true,
  '25–50% alcohol or water decoction',
  'Root contains anthraquinone glycosides (alizarin-primeveroside, rubiadin primeveroside) alongside free anthraquinone aglycones (alizarin, purpurin, munjistin). The glycosides are water-soluble; the upper range (40–50%) improves extraction of the less-polar free anthraquinone pigments. Historically used as a dye plant; traditional medicinal use as a diuretic and for urinary calculi.',
  false
)
ON CONFLICT (herb_id) DO NOTHING;
