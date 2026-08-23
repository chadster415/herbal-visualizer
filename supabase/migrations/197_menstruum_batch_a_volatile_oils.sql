-- Batch A: volatile oil-dominant herbs
-- Two sub-groups:
--   A1 (~18): volatile oils + significant water-soluble fraction → water_effective = true
--   A2 (~19): pure volatile oil / furanocoumarin / phthalide profile → water_effective = false

SET search_path TO herbal, public;

DO $$
BEGIN

  -- ── A1: volatile oils + water-soluble flavonoids / hydroxycinnamic acids ──────

  -- Agastache rugosa (aerial parts): methylchavicol, estragole (monoterpene ketone),
  -- flavones, rosmarinic acid (hydroxycinnamic acid) → 50–65% + water-effective
  PERFORM herbal.set_menstruum(
    'Agastache rugosa', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water infusion',
    'Volatile oils (methylchavicol, estragole) extract in moderate alcohol; flavones and rosmarinic acid extract in both alcohol and water. Infusion is effective and traditionally used.',
    false
  );

  -- Pimpinella anisum (Aniseed): trans-anethole (phenylpropanoid) dominant;
  -- furanocoumarins need alcohol, but anise tea extracts enough anethole for carminative use
  PERFORM herbal.set_menstruum(
    'Pimpinella anisum', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'trans-Anethole (phenylpropanoid) extracts best in moderate-high alcohol; furanocoumarins require alcohol. Water infusion extracts sufficient anethole for carminative use and is traditionally employed.',
    false
  );

  -- Mentha arvensis var. piperascens (Asian Mint): menthol (monoterpene alcohol),
  -- menthone (monoterpene ketone) — menthol is sufficiently water-soluble; mint tea highly effective
  PERFORM herbal.set_menstruum(
    'Mentha arvensis var. piperascens', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'Menthol (monoterpene alcohol) and menthone (monoterpene ketone) extract well in alcohol; menthol is also sufficiently water-soluble that mint tea is highly effective. Both preparations are traditional.',
    false
  );

  -- Ocimum basilicum (Basil): linalool, eugenol, methylchavicol vary by chemotype;
  -- rosmarinic acid and flavonoids water-soluble
  PERFORM herbal.set_menstruum(
    'Ocimum basilicum', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'Volatile oils (linalool, eugenol, methylchavicol — chemotype-dependent) extract in moderate-high alcohol; rosmarinic acid and flavonoids extract in both alcohol and water. Tea is traditional.',
    false
  );

  -- Carum carvi (Caraway): carvone (monoterpene ketone), limonene; caraway tea traditional
  PERFORM herbal.set_menstruum(
    'Carum carvi', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water infusion',
    'Carvone (monoterpene ketone) and limonene extract in moderate alcohol; caraway tea is traditional for carminative use and extracts enough volatile oil to be effective.',
    false
  );

  -- Elettaria cardamomum (Cardamom): 1,8-cineole, α-terpinyl acetate, linalool;
  -- cardamom tea is a traditional preparation
  PERFORM herbal.set_menstruum(
    'Elettaria cardamomum', 60, 70, NULL, NULL, true,
    '60–70% alcohol or water infusion',
    '1,8-Cineole and α-terpinyl acetate extract best in moderate-high alcohol; cardamom tea is traditional and extracts sufficient aromatic compounds for digestive use.',
    false
  );

  -- Salvia sclarea (Clary Sage): linalool, linalyl acetate, rosmarinic acid
  PERFORM herbal.set_menstruum(
    'Salvia sclarea', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'Linalool and linalyl acetate (monoterpene esters) extract in moderate-high alcohol; rosmarinic acid (hydroxycinnamic acid) extracts in both alcohol and water.',
    false
  );

  -- Coriandrum sativum (Coriander): linalool (monoterpene alcohol), camphor (bicyclic
  -- monoterpene ketone), flavonols — coriander tea traditional
  PERFORM herbal.set_menstruum(
    'Coriandrum sativum', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water infusion',
    'Linalool (monoterpene alcohol) and camphor extract in moderate alcohol; flavonols extract in both alcohol and water. Coriander seed tea is traditional for digestive use.',
    false
  );

  -- Anethum graveolens (Dill): carvone, limonene, coumarin; dill-water is traditional
  PERFORM herbal.set_menstruum(
    'Anethum graveolens', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water infusion',
    'Carvone and limonene extract in moderate alcohol; coumarin requires alcohol. Dill-water (infusion) extracts enough volatile oil for carminative use and is a traditional preparation.',
    false
  );

  -- Eucalyptus spp.: 1,8-cineole dominant; cineole has modest water solubility;
  -- steam inhalation from infusion is traditional
  PERFORM herbal.set_menstruum(
    'Eucalyptus spp.', 60, 70, NULL, NULL, true,
    '60–70% alcohol or water infusion',
    '1,8-Cineole (eucalyptol) is the primary constituent and extracts most completely in high alcohol; it also has modest water solubility. Steam inhalation from infusion is a traditional preparation.',
    false
  );

  -- Foeniculum vulgare (Fennel): trans-anethole, fenchone (monoterpenes);
  -- flavonol glycosides; fennel tea widely used
  PERFORM herbal.set_menstruum(
    'Foeniculum vulgare', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'trans-Anethole and fenchone (monoterpenes) extract in moderate alcohol; fennel tea is a widely used traditional preparation with good extraction of volatile carminative compounds.',
    false
  );

  -- Aloysia citrodora (Lemon Verbena, leaf): citral, geraniol (monoterpenes);
  -- flavones and hydroxycinnamic acids; verbena tea traditional
  PERFORM herbal.set_menstruum(
    'Aloysia citrodora', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water infusion',
    'Citral and geraniol (monoterpenes) extract in moderate alcohol; flavones and hydroxycinnamic acids extract in both alcohol and water. Verbena tea is a traditional preparation.',
    false
  );

  -- Origanum majorana (Marjoram): terpinen-4-ol (monoterpene alcohol), thymol
  -- (monoterpene phenol), rosmarinic acid; marjoram tea traditional
  PERFORM herbal.set_menstruum(
    'Origanum majorana', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'Terpinen-4-ol and thymol extract in moderate-high alcohol; rosmarinic acid (hydroxycinnamic acid) extracts in both alcohol and water. Marjoram tea is traditional.',
    false
  );

  -- Origanum vulgare (Oregano): carvacrol, thymol (monoterpene phenols);
  -- rosmarinic acid — oregano tea traditional
  PERFORM herbal.set_menstruum(
    'Origanum vulgare', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'Carvacrol and thymol (monoterpene phenols) extract in moderate-high alcohol; rosmarinic acid extracts in both alcohol and water. Oregano tea is traditional.',
    false
  );

  -- Petroselinum crispum (Parsley): myristicin, apiol (phenylpropanoids) need alcohol;
  -- apigenin (flavone) is water-soluble; parsley tea traditional
  PERFORM herbal.set_menstruum(
    'Petroselinum crispum', 50, 65, NULL, NULL, true,
    '50–65% alcohol or water infusion',
    'Myristicin and apiol (phenylpropanoids) require moderate alcohol; apigenin (flavone) extracts in both alcohol and water. Parsley leaf tea is traditional for urinary support.',
    false
  );

  -- Mentha pulegium (Pennyroyal): pulegone (monoterpene ketone) dominant;
  -- hydroxycinnamic acids also present; tea traditional but hepatotoxic in excess
  PERFORM herbal.set_menstruum(
    'Mentha pulegium', 60, 70, NULL, NULL, true,
    '60–70% alcohol or water infusion',
    'Pulegone (monoterpene ketone) extracts in moderate-high alcohol and partially in hot water. Pennyroyal tea is traditional though pulegone is hepatotoxic at high doses and a potent emmenagogue — use with caution.',
    false
  );

  -- Artemisia abrotanum (Southernwood): camphor, borneol (bicyclic monoterpenes),
  -- coumarin, flavonol glycosides, hydroxycinnamic acids; bitter tea is traditional
  PERFORM herbal.set_menstruum(
    'Artemisia abrotanum', 50, 70, NULL, NULL, true,
    '50–70% alcohol or water infusion',
    'Camphor and borneol (bicyclic monoterpenes) extract in moderate alcohol; flavonol glycosides and hydroxycinnamic acids extract in both alcohol and water. Bitter tea is a traditional preparation.',
    false
  );

  -- Tanacetum vulgare (Tansy): thujone (bicyclic monoterpene ketone), camphor,
  -- monoterpene oxides; flavones, hydroxycinnamic acids also present; toxic in large doses
  PERFORM herbal.set_menstruum(
    'Tanacetum vulgare', 60, 70, NULL, NULL, true,
    '60–70% alcohol or water infusion',
    'Thujone (bicyclic monoterpene ketone) extracts in moderate-high alcohol and partially in hot water; flavones and hydroxycinnamic acids extract in both. Internal use of tansy is potentially toxic — thujone is neurotoxic at high doses.',
    false
  );

  -- ── A2: volatile oils / furanocoumarins / phthalides — alcohol only ──────────

  -- Angelica archangelica: α-pinene, phellandrene (bicyclic monoterpene, monoterpene);
  -- bergapten, xanthotoxin (furanocoumarins) — furanocoumarins are poorly water-soluble
  PERFORM herbal.set_menstruum(
    'Angelica archangelica', 60, 75, NULL, NULL, false,
    '60–75% alcohol',
    'Volatile oils (α-pinene, phellandrene) and furanocoumarins (bergapten, xanthotoxin) require moderate-high alcohol; furanocoumarins are poorly water-soluble. Root tincture is the standard western preparation.',
    false
  );

  -- Citrus aurantium ssp. bergamia (Bergamot): limonene, linalool, linalyl acetate,
  -- bergapten (furanocoumarin); peel-derived; water is ineffective
  PERFORM herbal.set_menstruum(
    'Citrus aurantium ssp. bergamia', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Limonene, linalool, linalyl acetate, and bergapten (furanocoumarin) all require moderate-high alcohol. Primarily a volatile oil peel herb; water extraction is ineffective.',
    false
  );

  -- Apium graveolens (Celery Seed): 3-n-butylphthalide, sedanolide (phthalides);
  -- lipophilic and volatile — need alcohol
  PERFORM herbal.set_menstruum(
    'Apium graveolens', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Phthalides (3-n-butylphthalide, sedanolide) are the primary bioactives and are lipophilic and volatile, requiring moderate-high alcohol. Flavones also present but phthalide extraction drives the choice.',
    false
  );

  -- Cupressus sempervirens (Cypress): α-pinene, camphene (bicyclic monoterpenes);
  -- amentoflavone, hinokiflavone (biflavonoids) — poorly water-soluble
  PERFORM herbal.set_menstruum(
    'Cupressus sempervirens', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'α-Pinene and camphene (bicyclic monoterpenes) are highly lipophilic; biflavonoids (amentoflavone, hinokiflavone) require moderate-high alcohol and are poorly water-soluble.',
    false
  );

  -- Angelica sinensis (Dong Quai): Z-ligustilide, butylidenephthalide (phthalides);
  -- volatile, lipophilic, lost with heating — need alcohol
  PERFORM herbal.set_menstruum(
    'Angelica sinensis', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Phthalides (Z-ligustilide, butylidenephthalide) are volatile and lipophilic; they extract in moderate-high alcohol and are lost with heating in aqueous decoction.',
    false
  );

  -- Pinus pumilio (Dwarf Pine): bornyl acetate (bicyclic monoterpene ester), α-pinene;
  -- highly lipophilic
  PERFORM herbal.set_menstruum(
    'Pinus pumilio', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Bornyl acetate and α-pinene are highly lipophilic and require high alcohol. The essential oil (steam-distilled) is the primary product; high-alcohol tincture captures similar compounds.',
    false
  );

  -- Ammi visnaga (Khella): khellin, visnagin (furanochromones) — poorly water-soluble;
  -- furanocoumarins also present
  PERFORM herbal.set_menstruum(
    'Ammi visnaga', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Khellin and visnagin (furanochromones) are the primary cardioactive and spasmolytic constituents; they are poorly water-soluble and require moderate-high alcohol. Furanocoumarins also need alcohol.',
    false
  );

  -- Citrus limon (Lemon): d-limonene; peel-derived; water extraction is ineffective
  PERFORM herbal.set_menstruum(
    'Citrus limon', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Primarily a peel herb; d-limonene and other terpenes are highly lipophilic and require moderate-high alcohol. Flavanone glycosides (hesperidin, eriocitrin) also present.',
    false
  );

  -- Levisticum officinale (Lovage, root): Z-ligustilide, butyl phthalide, sedanolide;
  -- lipophilic and volatile
  PERFORM herbal.set_menstruum(
    'Levisticum officinale', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Phthalides (Z-ligustilide, butyl phthalide, sedanolide) are the primary diuretic and antispasmodic constituents; they are lipophilic and volatile, requiring high alcohol.',
    false
  );

  -- Citrus aurantium (Neroli): linalool, linalyl acetate, nerolidol (sesquiterpene alcohol);
  -- orange blossom water is a distillate, not an infusion
  PERFORM herbal.set_menstruum(
    'Citrus aurantium', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Linalool, linalyl acetate, and nerolidol (sesquiterpene alcohol) are the primary aromatic compounds and require moderate-high alcohol. Orange blossom water is a steam distillate, not a water infusion.',
    false
  );

  -- Ligusticum porteri (Osha): Z-ligustilide (phthalide), volatile monoterpene alcohols,
  -- phenylpropanoids; hydroxycinnamic acids also present; oxymel is a traditional alternative
  PERFORM herbal.set_menstruum(
    'Ligusticum porteri', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Z-Ligustilide (phthalide) is the primary bioactive and is volatile and lipophilic, requiring high alcohol. Monoterpene alcohols and phenylpropanoids also need moderate-high alcohol. Traditional preparation is high-alcohol tincture or oxymel (honey-vinegar).',
    false
  );

  -- Santalum album (Sandalwood): α-santalol, β-santalol (sesquiterpene alcohols);
  -- furanocoumarins; all lipophilic
  PERFORM herbal.set_menstruum(
    'Santalum album', 60, 75, NULL, NULL, false,
    '60–75% alcohol',
    'α-Santalol and β-santalol (sesquiterpene alcohols) are the primary bioactives and are lipophilic, requiring high alcohol. Furanocoumarins also need alcohol.',
    false
  );

  -- Sassafras albidum: safrole (phenylpropanoid), bicyclic monoterpene ketones,
  -- monoterpene alcohols; safrole is regulated for internal use in the US
  PERFORM herbal.set_menstruum(
    'Sassafras albidum', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Safrole (phenylpropanoid) and bicyclic monoterpenes require moderate-high alcohol and are poorly water-soluble. Note: safrole is classified as a possible carcinogen and is regulated for internal use in the US.',
    false
  );

  -- Pinus sylvestris (Scots Pine): α-pinene, β-pinene, bornyl acetate;
  -- highly lipophilic
  PERFORM herbal.set_menstruum(
    'Pinus sylvestris', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'α-Pinene, β-pinene, and bornyl acetate are highly lipophilic and require high alcohol. Needle or bud tincture in high alcohol is the standard preparation.',
    false
  );

  -- Citrus sinensis (Sweet Orange): d-limonene; hesperidin; peel herb
  PERFORM herbal.set_menstruum(
    'Citrus sinensis', 50, 70, NULL, NULL, false,
    '50–70% alcohol',
    'Primarily a peel herb; d-limonene and other terpenes are highly lipophilic and require moderate-high alcohol. Flavanone glycoside (hesperidin) also present.',
    false
  );

  -- Melaleuca spp. (Tea Tree): terpinen-4-ol (monoterpene alcohol), γ-terpinene, α-pinene;
  -- primarily topical
  PERFORM herbal.set_menstruum(
    'Melaleuca spp.', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Terpinen-4-ol (monoterpene alcohol) is the primary antimicrobial constituent and requires moderate-high alcohol. Primarily used topically as essential oil or high-alcohol tincture.',
    false
  );

  -- Thuja occidentalis: α-thujone, β-thujone (bicyclic monoterpene ketones);
  -- water is ineffective; neurotoxic at high doses
  PERFORM herbal.set_menstruum(
    'Thuja occidentalis', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'α-Thujone and β-thujone (bicyclic monoterpene ketones) are the primary bioactives and require high alcohol; water is ineffective. Thujone is neurotoxic at high doses — internal use requires caution.',
    false
  );

  -- Cananga odorata (Ylang Ylang): benzyl benzoate, benzyl acetate (esters),
  -- linalool, germacrene (sesquiterpene); primarily aromatic / topical
  PERFORM herbal.set_menstruum(
    'Cananga odorata', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Benzyl benzoate, linalool, and germacrene (sesquiterpene) are all lipophilic and require high alcohol. Primarily used as an essential oil; high-alcohol tincture captures similar aromatic compounds.',
    false
  );

  -- Curcuma zedoaria (Zedoary, rhizome): germacrone, curzerenone (sesquiterpene ketones);
  -- curcuminoids; bicyclic monoterpene ketones; all lipophilic
  PERFORM herbal.set_menstruum(
    'Curcuma zedoaria', 60, 70, NULL, NULL, false,
    '60–70% alcohol',
    'Germacrone and curzerenone (sesquiterpene ketones) and curcuminoids are lipophilic and require moderate-high alcohol. Bicyclic monoterpene ketones also need alcohol.',
    false
  );

  RAISE NOTICE 'Batch A (volatile oil herbs): 37 menstruum records inserted/updated.';
END $$;
