-- Batch B: resin / balsam herbs
-- All require high alcohol (70–90%); water is ineffective for the resin fraction.
-- Gumweed is slightly lower (65–80%) as its diterpene resin acids are less viscous
-- than true phenylpropanoid balsams.

SET search_path TO herbal, public;

DO $$
BEGIN

  -- Myroxylon balsamum var. pereirae (Balsam of Peru):
  -- cinnamein (benzyl benzoate + benzyl cinnamate) + resin — highly lipophilic
  PERFORM herbal.set_menstruum(
    'Myroxylon balsamum var. pereirae', 70, 90, NULL, NULL, false,
    '70–90% alcohol',
    'Benzyl benzoate and benzyl cinnamate (phenylpropanoid esters) are highly lipophilic; the resin fraction requires high alcohol. Water is ineffective.',
    false
  );

  -- Styrax benzoin (Benzoin):
  -- benzoic acid, cinnamic acid, benzyl benzoate, coniferyl benzoate + resin matrix
  PERFORM herbal.set_menstruum(
    'Styrax benzoin', 70, 90, NULL, NULL, false,
    '70–90% alcohol',
    'Benzoic acid, cinnamic acid, benzyl benzoate, and coniferyl benzoate require high alcohol; the resin matrix is insoluble in water. Classic preparation is compound tincture of benzoin in high-proof alcohol.',
    false
  );

  -- Guaiacum officinale: guaiaconic acid, guaiaretic acid (lignan resin acids),
  -- guaiacol (phenol) — oleoresin matrix requires high alcohol
  PERFORM herbal.set_menstruum(
    'Guaiacum officinale', 70, 85, NULL, NULL, false,
    '70–85% alcohol',
    'Guaiaconic acid and guaiaretic acid (lignan resin acids) and guaiacol (phenol) require high alcohol; the oleoresin is poorly water-soluble. Traditional hot wood decoction extracts poorly; resin tincture in high alcohol is the preferred western preparation.',
    false
  );

  -- Commiphora mukul (Guggul):
  -- guggulsterones + oleoresin — highly lipophilic
  PERFORM herbal.set_menstruum(
    'Commiphora mukul', 70, 90, NULL, NULL, false,
    '70–90% alcohol',
    'Guggulsterones (diterpenoid sterols) and the oleoresin fraction are highly lipophilic and require high alcohol; water is ineffective for meaningful extraction of active constituents.',
    false
  );

  -- Grindelia camporum (Gumweed):
  -- grindelic acid + other diterpene resin acids — less viscous than true balsams
  PERFORM herbal.set_menstruum(
    'Grindelia camporum', 65, 80, NULL, NULL, false,
    '65–80% alcohol',
    'Grindelic acid and other diterpene resin acids require moderate-high alcohol; the resin fraction is poorly water-soluble. The gumweed resin is less viscous than phenylpropanoid balsams, so 65–80% alcohol is sufficient.',
    false
  );

  -- Myroxylon balsamum var. balsamum (Tolu Balsam):
  -- essentially the same phenylpropanoid ester + resin profile as Balsam of Peru
  PERFORM herbal.set_menstruum(
    'Myroxylon balsamum var. balsamum', 70, 90, NULL, NULL, false,
    '70–90% alcohol',
    'Benzyl benzoate, benzyl cinnamate, and cinnamic acid (phenylpropanoid esters) are highly lipophilic; the resin fraction requires high alcohol. Extraction profile is essentially identical to Balsam of Peru.',
    false
  );

  RAISE NOTICE 'Batch B (resin / balsam herbs): 6 menstruum records inserted/updated.';
END $$;
