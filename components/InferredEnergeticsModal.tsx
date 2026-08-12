'use client';

interface ConstituentProfile {
  id: number;
  herb_id: number | null;
  constituent: string;
  class: string | null;
  subclass: string | null;
  importance: string | null;
  status: string | null;
}

interface HerbConstituent {
  constituents: { name: string; category: string | null };
  concentration_level: string;
}

interface InferredSignal {
  rule: string;
  confidence: 'High' | 'Moderate' | 'Low';
  constituents: string[];
  direction: 'warming' | 'cooling' | 'moistening' | 'drying';
}

const LEVEL_WEIGHT: Record<string, number> = {
  trace: 0, minor: 1, moderate: 2, major: 3, primary: 4,
};

const HIGH_IMPORTANCE = new Set(['High', 'Moderate']);
const SIGNIFICANT_STATUS = new Set(['Marker', 'Major', 'Present']);

// Volatile terpenoid categories (both from herb_constituents and constituent_profiles subclasses)
const VOLATILE_TERPENOID_CATEGORIES = new Set([
  'monoterpene', 'bicyclic monoterpene', 'sesquiterpene',
  'monoterpene alcohol', 'bicyclic monoterpene alcohol', 'bicyclic monoterpene ester',
  'monoterpene ketone', 'bicyclic monoterpene ketone',
  'monoterpene oxide', 'monoterpene phenol', 'resin', 'phenylpropanoid',
]);

const VOLATILE_TERPENOID_SUBCLASSES = new Set([
  'Monoterpene', 'Monoterpene alcohol', 'Monoterpene aldehyde', 'Monoterpene ester',
  'Monoterpene ketone', 'Monoterpene oxide', 'Monoterpenoid', 'Monoterpenoid phenol',
  'Sesquiterpene', 'Sesquiterpene alcohol', 'Sesquiterpenoid',
  'Phenylpropene', 'Phenylpropanoid ester', 'Aromatic aldehyde', 'Aromatic ester',
]);

function analyzeTemperature(
  herbConstituents: HerbConstituent[],
  profiles: ConstituentProfile[],
): InferredSignal[] {
  const signals: InferredSignal[] = [];

  // --- Warming signals ---

  // Phenylpropanoid class at moderate+ importance (constituent_profiles)
  const phenylpropanoidProfiles = profiles.filter(
    (p) =>
      p.class === 'Phenylpropanoid' &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (phenylpropanoidProfiles.length > 0) {
    signals.push({
      rule: 'Phenylpropanoid at Moderate or High importance → warming',
      confidence: 'High',
      constituents: phenylpropanoidProfiles.map((p) => `${p.constituent} (${p.subclass ?? p.class})`),
      direction: 'warming',
    });
  }

  // Phenylpropanoid category in herb_constituents at moderate+
  const phenylpropanoidHC = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'phenylpropanoid' &&
      LEVEL_WEIGHT[hc.concentration_level] >= 2,
  );
  if (phenylpropanoidHC.length > 0 && phenylpropanoidProfiles.length === 0) {
    signals.push({
      rule: 'Phenylpropanoid constituent at moderate+ concentration → warming',
      confidence: 'High',
      constituents: phenylpropanoidHC.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
      direction: 'warming',
    });
  }

  // Resins at moderate+ (herb_constituents)
  const resins = herbConstituents.filter(
    (hc) => hc.constituents.category === 'resin' && LEVEL_WEIGHT[hc.concentration_level] >= 2,
  );
  if (resins.length > 0) {
    signals.push({
      rule: 'Resin at moderate+ concentration → warming',
      confidence: 'Moderate',
      constituents: resins.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
      direction: 'warming',
    });
  }

  // Multiple volatile terpenoid subcategories (3+)
  const volatileCategories = new Set<string>();
  for (const hc of herbConstituents) {
    if (VOLATILE_TERPENOID_CATEGORIES.has(hc.constituents.category ?? '')) {
      volatileCategories.add(hc.constituents.category!);
    }
  }
  for (const p of profiles) {
    if (VOLATILE_TERPENOID_SUBCLASSES.has(p.subclass ?? '')) {
      volatileCategories.add(p.subclass!);
    }
  }
  if (volatileCategories.size >= 3) {
    signals.push({
      rule: `${volatileCategories.size} distinct volatile terpenoid subcategories present → warming`,
      confidence: 'High',
      constituents: [...volatileCategories],
      direction: 'warming',
    });
  }

  // Purine alkaloids (caffeine, theobromine)
  const purines = herbConstituents.filter(
    (hc) => hc.constituents.category === 'purine alkaloid',
  );
  const purineProfiles = profiles.filter((p) => p.subclass === 'Purine alkaloid');
  if (purines.length + purineProfiles.length > 0) {
    signals.push({
      rule: 'Purine alkaloid (stimulant) → warming',
      confidence: 'Low',
      constituents: [
        ...purines.map((hc) => hc.constituents.name),
        ...purineProfiles.map((p) => p.constituent),
      ],
      direction: 'warming',
    });
  }

  // --- Cooling signals ---

  // Anthraquinones (herb_constituents)
  const anthraquinones = herbConstituents.filter((hc) =>
    (hc.constituents.category ?? '').includes('anthraquinone'),
  );
  const anthraquinoneProfiles = profiles.filter(
    (p) => p.class === 'Anthraquinone' || p.class === 'Quinone',
  );
  if (anthraquinones.length + anthraquinoneProfiles.length > 0) {
    signals.push({
      rule: 'Anthraquinone constituent → cooling',
      confidence: 'High',
      constituents: [
        ...anthraquinones.map((hc) => hc.constituents.name),
        ...anthraquinoneProfiles.map((p) => p.constituent),
      ],
      direction: 'cooling',
    });
  }

  // Iridoid / secoiridoid glycosides
  const iridoids = herbConstituents.filter((hc) =>
    ['iridoid glycoside', 'secoiridoid glycoside', 'secoiridoid'].includes(
      hc.constituents.category ?? '',
    ),
  );
  const iridoidProfiles = profiles.filter((p) =>
    p.subclass === 'Iridoid glycoside' || p.subclass === 'Secoiridoid glycoside',
  );
  if (iridoids.length + iridoidProfiles.length > 0) {
    signals.push({
      rule: 'Iridoid or secoiridoid glycoside → cooling',
      confidence: 'High',
      constituents: [
        ...iridoids.map((hc) => hc.constituents.name),
        ...iridoidProfiles.map((p) => p.constituent),
      ],
      direction: 'cooling',
    });
  }

  // Sesquiterpene lactones (only cooling if no volatile terpenoids present)
  const sqLactones = herbConstituents.filter(
    (hc) => hc.constituents.category === 'sesquiterpene lactone' && LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const sqLactoneProfiles = profiles.filter(
    (p) => p.subclass === 'Sesquiterpene lactone' && HIGH_IMPORTANCE.has(p.importance ?? ''),
  );
  if ((sqLactones.length + sqLactoneProfiles.length > 0) && volatileCategories.size < 2) {
    signals.push({
      rule: 'Sesquiterpene lactone (major/primary, no co-occurring volatile terpenoids) → cooling',
      confidence: 'High',
      constituents: [
        ...sqLactones.map((hc) => hc.constituents.name),
        ...sqLactoneProfiles.map((p) => p.constituent),
      ],
      direction: 'cooling',
    });
  }

  // Polyphenol/tannin dominant, no volatile terpenoids
  const tannins = herbConstituents.filter(
    (hc) =>
      ['condensed tannin', 'hydrolyzable tannin', 'gallotannin', 'ellagitannin'].includes(
        hc.constituents.category ?? '',
      ) && LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const tanninProfiles = profiles.filter(
    (p) =>
      (p.class === 'Tannin' || p.subclass === 'Condensed tannin' || p.subclass === 'Gallotannin') &&
      HIGH_IMPORTANCE.has(p.importance ?? ''),
  );
  if ((tannins.length + tanninProfiles.length > 0) && volatileCategories.size === 0) {
    signals.push({
      rule: 'Tannin-dominant, no volatile terpenoids → cooling',
      confidence: 'Moderate',
      constituents: [
        ...tannins.map((hc) => hc.constituents.name),
        ...tanninProfiles.map((p) => p.constituent),
      ],
      direction: 'cooling',
    });
  }

  return signals;
}

function analyzeMoisture(
  herbConstituents: HerbConstituent[],
  profiles: ConstituentProfile[],
): InferredSignal[] {
  const signals: InferredSignal[] = [];

  // --- Moistening signals ---

  // Polysaccharides / mucilage at major/primary
  const polysaccharides = herbConstituents.filter(
    (hc) =>
      ['polysaccharide', 'mucilage', 'acidic polysaccharide'].includes(hc.constituents.category ?? '') &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const polysaccharideProfiles = profiles.filter(
    (p) =>
      p.class === 'Polysaccharide' &&
      HIGH_IMPORTANCE.has(p.importance ?? ''),
  );
  if (polysaccharides.length + polysaccharideProfiles.length > 0) {
    signals.push({
      rule: 'Polysaccharide or mucilage (major+) → moistening',
      confidence: 'High',
      constituents: [
        ...polysaccharides.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...polysaccharideProfiles.map((p) => p.constituent),
      ],
      direction: 'moistening',
    });
  }

  // Phytosterols at moderate+ (no volatile terpenoids)
  const phytosterols = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'phytosterol' && LEVEL_WEIGHT[hc.concentration_level] >= 2,
  );
  const phytosterolProfiles = profiles.filter(
    (p) => p.subclass === 'Phytosterol' && HIGH_IMPORTANCE.has(p.importance ?? ''),
  );
  if (phytosterols.length + phytosterolProfiles.length > 0) {
    signals.push({
      rule: 'Phytosterol at moderate+ (no volatile terpenoids) → moistening',
      confidence: 'Moderate',
      constituents: [
        ...phytosterols.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...phytosterolProfiles.map((p) => p.constituent),
      ],
      direction: 'moistening',
    });
  }

  // Saponins at major/primary
  const saponins = herbConstituents.filter(
    (hc) =>
      ['saponin', 'triterpenoid saponin', 'steroidal saponin'].includes(hc.constituents.category ?? '') &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const saponinProfiles = profiles.filter(
    (p) =>
      (p.class === 'Saponin' || p.subclass === 'Triterpenoid saponin') &&
      HIGH_IMPORTANCE.has(p.importance ?? ''),
  );
  if (saponins.length + saponinProfiles.length > 0) {
    signals.push({
      rule: 'Saponin (major+, no volatile terpenoids) → moistening',
      confidence: 'Moderate',
      constituents: [
        ...saponins.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...saponinProfiles.map((p) => p.constituent),
      ],
      direction: 'moistening',
    });
  }

  // Isoflavones
  const isoflavoneProfiles = profiles.filter((p) => p.subclass === 'Isoflavone');
  const isoflavoneHC = herbConstituents.filter((hc) => hc.constituents.category === 'isoflavone');
  if (isoflavoneHC.length + isoflavoneProfiles.length > 0) {
    signals.push({
      rule: 'Isoflavone → moistening',
      confidence: 'Moderate',
      constituents: [
        ...isoflavoneHC.map((hc) => hc.constituents.name),
        ...isoflavoneProfiles.map((p) => p.constituent),
      ],
      direction: 'moistening',
    });
  }

  // Coumarins at moderate+
  const coumarins = herbConstituents.filter(
    (hc) =>
      ['coumarin', 'coumarin glycoside', 'furanocoumarin'].includes(hc.constituents.category ?? '') &&
      LEVEL_WEIGHT[hc.concentration_level] >= 2,
  );
  const coumarinProfiles = profiles.filter(
    (p) =>
      p.class === 'Coumarin' &&
      HIGH_IMPORTANCE.has(p.importance ?? ''),
  );
  if (coumarins.length + coumarinProfiles.length > 0) {
    signals.push({
      rule: 'Coumarin at moderate+ → moistening',
      confidence: 'Moderate',
      constituents: [
        ...coumarins.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...coumarinProfiles.map((p) => p.constituent),
      ],
      direction: 'moistening',
    });
  }

  // --- Drying signals ---

  // Monoterpenes (any level)
  const monoterpenes = herbConstituents.filter((hc) =>
    ['monoterpene', 'bicyclic monoterpene', 'monoterpene alcohol',
     'bicyclic monoterpene alcohol', 'monoterpene ketone', 'bicyclic monoterpene ketone',
     'monoterpene oxide', 'monoterpene ester', 'bicyclic monoterpene ester'].includes(
      hc.constituents.category ?? '',
    ),
  );
  const monoterpeneProfiles = profiles.filter((p) =>
    ['Monoterpene', 'Monoterpene alcohol', 'Monoterpene ketone', 'Monoterpene oxide',
     'Monoterpene ester', 'Monoterpenoid', 'Monoterpenoid phenol'].includes(p.subclass ?? ''),
  );
  if (monoterpenes.length + monoterpeneProfiles.length > 0) {
    signals.push({
      rule: 'Monoterpene constituent → drying',
      confidence: 'High',
      constituents: [
        ...monoterpenes.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...monoterpeneProfiles.map((p) => p.constituent),
      ],
      direction: 'drying',
    });
  }

  // Flavan-3-ols at moderate+
  const flavan3ols = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'flavan-3-ol' && LEVEL_WEIGHT[hc.concentration_level] >= 2,
  );
  const flavan3olProfiles = profiles.filter(
    (p) => p.subclass === 'Flavan-3-ol' && LEVEL_WEIGHT[p.importance === 'High' ? 3 : p.importance === 'Moderate' ? 2 : 1] >= 2,
  );
  if (flavan3ols.length + flavan3olProfiles.length > 0) {
    signals.push({
      rule: 'Flavan-3-ol (catechins) at moderate+ → drying',
      confidence: 'High',
      constituents: [
        ...flavan3ols.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...flavan3olProfiles.map((p) => p.constituent),
      ],
      direction: 'drying',
    });
  }

  return signals;
}

const CONFIDENCE_COLOR: Record<InferredSignal['confidence'], string> = {
  High:     'bg-green-50 border-green-200 text-green-800',
  Moderate: 'bg-yellow-50 border-yellow-200 text-yellow-800',
  Low:      'bg-gray-50 border-gray-200 text-gray-700',
};

const DIRECTION_LABEL: Record<InferredSignal['direction'], string> = {
  warming:   '🔥 Warming',
  cooling:   '❄️ Cooling',
  moistening: '💧 Moistening',
  drying:    '🌵 Drying',
};

interface Props {
  isOpen: boolean;
  onClose: () => void;
  herbName: string;
  temperatureInferred: boolean;
  moistureInferred: boolean;
  herbConstituents: HerbConstituent[];
  profiles: ConstituentProfile[];
}

export function InferredEnergeticsModal({
  isOpen,
  onClose,
  herbName,
  temperatureInferred,
  moistureInferred,
  herbConstituents,
  profiles,
}: Props) {
  if (!isOpen) return null;

  const tempSignals = temperatureInferred ? analyzeTemperature(herbConstituents, profiles) : [];
  const moistSignals = moistureInferred ? analyzeMoisture(herbConstituents, profiles) : [];
  const allSignals = [...tempSignals, ...moistSignals];

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg max-h-[80vh] flex flex-col">
        {/* Header */}
        <div className="flex items-start justify-between p-5 border-b border-gray-100">
          <div>
            <h2 className="text-lg font-semibold text-gray-900">Inferred Energetics</h2>
            <p className="text-sm text-gray-500 mt-0.5">{herbName}</p>
          </div>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition-colors ml-4 mt-0.5"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        {/* Body */}
        <div className="overflow-y-auto p-5 space-y-5 flex-1">
          <p className="text-sm text-gray-600">
            Energetics marked as <span className="italic">inferred</span> were assigned automatically
            from {herbName}&apos;s constituent profile using documented rules — not from a clinical
            source. They reflect constituent chemistry, not confirmed clinical observation.
          </p>

          {allSignals.length === 0 && (
            <p className="text-sm text-amber-700 bg-amber-50 border border-amber-200 rounded-lg px-4 py-3">
              The constituent data in the database is sparse for this herb. The energetic was inferred
              from constituent profile data (CSV import) that may not be fully reflected in this view.
            </p>
          )}

          {allSignals.length > 0 && (
            <div className="space-y-3">
              <h3 className="text-xs font-semibold uppercase tracking-wider text-gray-400">
                Constituent signals found
              </h3>
              {allSignals.map((signal, i) => (
                <div
                  key={i}
                  className={`rounded-lg border px-4 py-3 ${CONFIDENCE_COLOR[signal.confidence]}`}
                >
                  <div className="flex items-center justify-between gap-2 mb-1">
                    <span className="font-medium text-sm">{DIRECTION_LABEL[signal.direction]}</span>
                    <span className="text-xs opacity-70">{signal.confidence} confidence</span>
                  </div>
                  <p className="text-xs opacity-80 mb-2">{signal.rule}</p>
                  <div className="flex flex-wrap gap-1">
                    {signal.constituents.map((c) => (
                      <span key={c} className="text-xs bg-white/60 rounded px-1.5 py-0.5 border border-current/20">
                        {c}
                      </span>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}

          <p className="text-xs text-gray-400 border-t border-gray-100 pt-4">
            Rules source: <span className="font-mono">docs/inferring-energetics-from-constituents.md</span>.
            Tone is never inferred from constituents.
          </p>
        </div>
      </div>
    </div>
  );
}
