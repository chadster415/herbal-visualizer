# Inferring Energetics from Constituents

When adding a new herb that lacks energetics data, use the rules below to assign a first-pass value and mark it as inferred (`temperature_inferred = true`, etc.) in the migration. All inferred energetics render at reduced opacity in the UI so they remain visually distinct from source-confirmed data.

These rules were derived by comparing 315 herbs that had both constituent data and confirmed energetics against the `herb_constituents` and `constituent_profiles` tables (August 2026).

---

## How to set inferred energetics in a migration

```sql
UPDATE herbal.herbs
SET temperature = 'warming', temperature_inferred = true
WHERE latin_name = 'Example herb';
```

Or combine with an `ensure_herb` insert:

```sql
UPDATE herbal.herbs
SET temperature = 'warming', temperature_inferred = true,
    moisture = 'drying', moisture_inferred = true
WHERE latin_name = 'Example herb';
```

---

## Temperature Rules

### High confidence

| Rule | Signal | Data support |
|---|---|---|
| **Anthraquinones → cooling** | Presence of any anthraquinone constituent | 0 warming / 6 cooling herbs — no counter-examples |
| **Iridoid or secoiridoid glycosides → cooling** | Iridoid glycoside or secoiridoid glycoside as a major or primary constituent | 1 warming (edge case) vs 14+ cooling herbs; secoiridoids (sweroside, gentiopicroside) are the same bitter-cooling class | 
| **Sesquiterpene lactones → cooling** | Sesquiterpene lactone as a major or primary constituent AND no co-occurring monoterpenes or strong volatile terpenoids | Bitter tonics (cnicin, lactucin, lactucopicrin) pattern strongly with cooling; counter-examples exist when SLs accompany volatile terpenoids (e.g. Elecampane) |
| **Phenylpropanoids → warming** | Phenylpropanoid as a moderate, major, or primary constituent | 11 warming vs 1 cooling herb |
| **Multiple volatile terpenoids → warming** | 3+ distinct subcategories from: monoterpene, bicyclic monoterpene, sesquiterpene, monoterpene alcohol, monoterpene ketone, monoterpene oxide, monoterpene phenol, resin, phenylpropanoid | Terpenoid class: 55.6% warming vs 33.9% cooling |

### Moderate confidence

| Rule | Signal | Data support |
|---|---|---|
| **Resins → warming** | Any resin constituent at moderate or above | 8 warming / 0 cooling herbs |
| **Polyphenol/tannin-dominant, no terpenoids → cooling** | Tannin or polyphenol as primary AND no volatile terpenoid categories present | Polyphenol class: 54% cooling vs 35% warming |
| **Flavonols as dominant constituent, no terpenoids → cooling** | Flavonol at major/primary AND no volatile terpenoids | 33.9% cooling vs 19.2% warming |

### Low confidence (use only as a tiebreaker)

| Rule | Signal | Data support |
|---|---|---|
| **Purine alkaloids → warming** | Caffeine, theobromine, or similar stimulant purines | 5 warming / 1 cooling (small n) |

---

## Moisture Rules

### High confidence (use freely)

| Rule | Signal | Data support |
|---|---|---|
| **Polysaccharides/mucilage → moistening** | Polysaccharide or mucilage at major or primary concentration | 7:1 ratio — strongest single predictor in the dataset |
| **Monoterpenes → drying** | Any monoterpene, monoterpene alcohol, or bicyclic monoterpene ketone constituent | 0 moistening herbs contain these; 14–28 drying herbs do |
| **Flavan-3-ols → drying** | Flavan-3-ol (catechins, epicatechin, etc.) at moderate or above | 22 drying vs 1 moistening herb |

### Moderate confidence

| Rule | Signal | Data support |
|---|---|---|
| **Phytosterols → moistening** | Phytosterol at moderate/major, no volatile terpenoids | 14% moistening vs 2.6% drying |
| **Saponins → moistening** | Saponin at major/primary, no volatile terpenoids | 14% moistening vs 4.1% drying |
| **Isoflavones → moistening** | Isoflavone present (estrogenic/tissue-building mechanism) | 8.8% moistening vs 2.1% drying |
| **Coumarins → moistening** | Coumarin at moderate or above, no volatile terpenoids | 12.3% moistening vs 3.6% drying |

### Low confidence

| Rule | Signal | Data support |
|---|---|---|
| **Fatty acids → moistening** | Fatty acid present | 3 moistening / 0 drying (small n) |

---

## Combined patterns

These combinations are strong enough to assign both dimensions confidently:

| Constituent profile | Temperature | Moisture |
|---|---|---|
| Volatile oil-rich (monoterpenes, phenylpropanoids, sesquiterpenes) | warming | drying |
| Mucilage-dominant (polysaccharides primary) | neutral (check other constituents) | moistening |
| Tannin-dominant, no volatile terpenoids | cooling | drying |
| Iridoid/secoiridoid glycoside-dominant | cooling | check other constituents |
| Sesquiterpene lactone-dominant, no volatile terpenoids | cooling | check other constituents |
| Saponin/phytosterol-dominant, no volatile terpenoids | neutral/cooling | moistening |
| Isoflavone-dominant | neutral | moistening |
| Anthraquinone present | cooling | check other constituents |

---

## When NOT to infer

Do not auto-assign energetics when:

- **Both warming and cooling signals are present at comparable concentrations** — leave both fields as their existing value (or `neutral`) and do not set `_inferred = true` unless you are sure.
- **Constituent data is absent or sparse** (fewer than 3 constituents in the DB for this herb) — too little signal.
- **The only signals are from ubiquitous categories** like hydroxycinnamic acids, flavones, or pentacyclic triterpenoids — these appear in nearly every herb and have no predictive value alone.

Known herbs with genuinely contradictory profiles (already assigned correctly as neutral):
- **Chasteberry** — iridoid glycosides (cooling signal) + bicyclic monoterpenes (warming signal)
- **Elecampane** — volatile sesquiterpene lactones (drying) + major mucilage polysaccharides (moistening) — the warming/drying assignment is defensible but note the tension
- **White Pond Lily** — tannins (drying) + mucilage (moistening)
- **White Peony** — paeoniflorin/iridoid glycosides (cooling) + paeonol/phenylpropanoid (warming) at comparable importance

---

## Candidate rules (insufficient data — do not apply yet)

These patterns were observed during the August 2026 analysis but the herb count is too small to treat as confirmed rules. Add to the main tables once 5+ supporting herbs can be verified.

| Candidate rule | Signal | Current support |
|---|---|---|
| **Glucosinolates → warming** | Glucosinolate (sinigrin, sinalbin) as a marker constituent | 2 herbs (Black Mustard, White Mustard) — hydrolyze to pungent isothiocyanates; empirically warming/rubefacient but n too small |

---

## Tone (toning/relaxing)

No strong constituent-level rules were found for tone. Tone is best assigned from clinical source data only. Do not infer tone from constituents.
