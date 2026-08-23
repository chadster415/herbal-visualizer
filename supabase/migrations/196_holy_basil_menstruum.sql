-- Add herb_menstruum record for Holy Basil (Tulsi) — id=13
-- Volatile oils (eugenol, linalool, β-caryophyllene) and triterpenes (ursolic acid)
-- extract in moderate-high alcohol; flavonoids and rosmarinic acid extract in both
-- alcohol and water. Traditional Ayurvedic use is fresh/dried leaf infusion (tea).

INSERT INTO herbal.herb_menstruum (
  herb_id,
  alcohol_pct_min,
  alcohol_pct_max,
  glycerin_pct,
  vinegar_pct,
  water_effective,
  primary_label,
  notes,
  needs_review
) VALUES (
  13,
  50,
  70,
  NULL,
  NULL,
  true,
  '50–70% alcohol or water infusion',
  'Volatile oils (eugenol, linalool, β-caryophyllene) and triterpenes (ursolic acid, oleanolic acid) extract in moderate-high alcohol; flavonoids (luteolin, apigenin, orientin, vicenin) and rosmarinic acid extract in both alcohol and water. Traditional Ayurvedic preparation is fresh or dried leaf infusion; water is genuinely effective for this herb. Fresh plant tincture preferred when available.',
  false
);
