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

type TasteDirection = 'bitter' | 'pungent' | 'sweet' | 'sour' | 'salty';

interface TasteSignal {
  rule: string;
  confidence: 'High' | 'Moderate' | 'Low';
  constituents: string[];
  direction: TasteDirection;
}

const LEVEL_WEIGHT: Record<string, number> = {
  trace: 0, minor: 1, moderate: 2, major: 3, primary: 4,
};

const HIGH_IMPORTANCE = new Set(['High', 'Moderate']);
const SIGNIFICANT_STATUS = new Set(['Marker', 'Major', 'Present']);

const VOLATILE_TERPENOID_CATEGORIES = new Set([
  'monoterpene', 'bicyclic monoterpene', 'sesquiterpene',
  'monoterpene alcohol', 'bicyclic monoterpene alcohol', 'bicyclic monoterpene ester',
  'monoterpene ketone', 'bicyclic monoterpene ketone',
  'monoterpene oxide', 'monoterpene phenol', 'monoterpene ester',
  'monoterpene aldehyde', 'monoterpene furan',
  'resin', 'phenylpropanoid',
]);

const VOLATILE_TERPENOID_SUBCLASSES = new Set([
  'Monoterpene', 'Monoterpene alcohol', 'Monoterpene aldehyde', 'Monoterpene ester',
  'Monoterpene ketone', 'Monoterpene oxide', 'Monoterpenoid', 'Monoterpenoid phenol',
  'Sesquiterpene', 'Sesquiterpene alcohol', 'Sesquiterpenoid',
  'Phenylpropene', 'Phenylpropanoid ester', 'Aromatic aldehyde', 'Aromatic ester',
]);

export function analyzeTaste(
  herbConstituents: HerbConstituent[],
  profiles: ConstituentProfile[],
): TasteSignal[] {
  const signals: TasteSignal[] = [];

  // Count volatile terpenoid subcategories (used as gate for some rules)
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

  // ─── BITTER signals ──────────────────────────────────────────────────

  // Iridoid / secoiridoid / epoxide iridoid glycoside at major+
  const iridoids = herbConstituents.filter((hc) =>
    ['iridoid glycoside', 'secoiridoid glycoside', 'secoiridoid', 'epoxide iridoid'].includes(
      hc.constituents.category ?? '',
    ) && LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const iridoidProfiles = profiles.filter((p) =>
    (p.subclass === 'Iridoid glycoside' || p.subclass === 'Secoiridoid glycoside') &&
    HIGH_IMPORTANCE.has(p.importance ?? '') &&
    SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (iridoids.length + iridoidProfiles.length > 0) {
    signals.push({
      rule: 'Iridoid or secoiridoid glycoside (major+) → bitter',
      confidence: 'High',
      constituents: [
        ...iridoids.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...iridoidProfiles.map((p) => `${p.constituent} (${p.subclass})`),
      ],
      direction: 'bitter',
    });
  }

  // Sesquiterpene lactone at major+
  const sqLactones = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'sesquiterpene lactone' &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const sqLactoneProfiles = profiles.filter(
    (p) =>
      p.subclass === 'Sesquiterpene lactone' &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (sqLactones.length + sqLactoneProfiles.length > 0) {
    signals.push({
      rule: 'Sesquiterpene lactone (major+) → bitter',
      confidence: 'High',
      constituents: [
        ...sqLactones.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...sqLactoneProfiles.map((p) => p.constituent),
      ],
      direction: 'bitter',
    });
  }

  // Anthraquinone (any level)
  const anthraquinones = herbConstituents.filter((hc) =>
    (hc.constituents.category ?? '').includes('anthraquinone'),
  );
  const anthraquinoneProfiles = profiles.filter(
    (p) => p.class === 'Anthraquinone' || p.class === 'Quinone',
  );
  if (anthraquinones.length + anthraquinoneProfiles.length > 0) {
    signals.push({
      rule: 'Anthraquinone constituent → bitter',
      confidence: 'High',
      constituents: [
        ...anthraquinones.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...anthraquinoneProfiles.map((p) => p.constituent),
      ],
      direction: 'bitter',
    });
  }

  // Flavan-3-ol (catechins) at major+
  const flavan3ols = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'flavan-3-ol' && LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const flavan3olProfiles = profiles.filter(
    (p) =>
      p.subclass === 'Flavan-3-ol' &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (flavan3ols.length + flavan3olProfiles.length > 0) {
    signals.push({
      rule: 'Flavan-3-ol (catechin) at major+ → bitter',
      confidence: 'High',
      constituents: [
        ...flavan3ols.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...flavan3olProfiles.map((p) => p.constituent),
      ],
      direction: 'bitter',
    });
  }

  // Alpha/beta hop acids and acylphloroglucinols at major+
  const hopAcids = herbConstituents.filter(
    (hc) =>
      ['alpha acid', 'beta acid', 'acylphloroglucinol'].includes(hc.constituents.category ?? '') &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  if (hopAcids.length > 0) {
    signals.push({
      rule: 'Alpha/beta acid or acylphloroglucinol (major+) → bitter',
      confidence: 'High',
      constituents: hopAcids.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
      direction: 'bitter',
    });
  }

  // Alkaloid at major+ (moderate confidence)
  const alkaloids = herbConstituents.filter(
    (hc) =>
      ['alkaloid', 'quinolizidine alkaloid', 'isoquinoline alkaloid', 'purine alkaloid',
       'beta-carboline alkaloid', 'coumarin alkaloid'].includes(hc.constituents.category ?? '') &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const alkaloidProfiles = profiles.filter(
    (p) =>
      (p.class === 'Alkaloid' || p.subclass === 'Purine alkaloid') &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (alkaloids.length + alkaloidProfiles.length > 0) {
    signals.push({
      rule: 'Alkaloid (major+) → bitter',
      confidence: 'Moderate',
      constituents: [
        ...alkaloids.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...alkaloidProfiles.map((p) => `${p.constituent} (${p.subclass ?? p.class})`),
      ],
      direction: 'bitter',
    });
  }

  // Ellagitannin / condensed tannin at major+
  const ellagitannins = herbConstituents.filter(
    (hc) =>
      ['hydrolyzable tannin', 'ellagitannin', 'condensed tannin'].includes(
        hc.constituents.category ?? '',
      ) && LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const ellagitanninProfiles = profiles.filter(
    (p) =>
      (p.subclass === 'Ellagitannin' || p.subclass === 'Condensed tannin' || p.class === 'Tannin') &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (ellagitannins.length + ellagitanninProfiles.length > 0) {
    signals.push({
      rule: 'Ellagitannin or condensed tannin (major+) → bitter',
      confidence: 'Moderate',
      constituents: [
        ...ellagitannins.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...ellagitanninProfiles.map((p) => p.constituent),
      ],
      direction: 'bitter',
    });
  }

  // ─── PUNGENT signals ─────────────────────────────────────────────────

  // 3+ distinct volatile monoterpene subcategories
  if (volatileCategories.size >= 3) {
    signals.push({
      rule: `${volatileCategories.size} distinct volatile terpenoid subcategories → pungent`,
      confidence: 'High',
      constituents: [...volatileCategories],
      direction: 'pungent',
    });
  }

  // Phenylpropanoid at moderate+
  const phenylpropanoidHC = herbConstituents.filter(
    (hc) =>
      ['phenylpropanoid', 'phenylpropene'].includes(hc.constituents.category ?? '') &&
      LEVEL_WEIGHT[hc.concentration_level] >= 2,
  );
  const phenylpropanoidProfiles = profiles.filter(
    (p) =>
      p.class === 'Phenylpropanoid' &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (phenylpropanoidHC.length + phenylpropanoidProfiles.length > 0) {
    signals.push({
      rule: 'Phenylpropanoid at moderate+ → pungent',
      confidence: 'High',
      constituents: [
        ...phenylpropanoidHC.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...phenylpropanoidProfiles.map((p) => `${p.constituent} (${p.subclass ?? p.class})`),
      ],
      direction: 'pungent',
    });
  }

  // ─── SWEET signals ───────────────────────────────────────────────────

  // Polysaccharide / mucilage at major/primary
  const polysaccharides = herbConstituents.filter(
    (hc) =>
      ['polysaccharide', 'mucilage', 'acidic polysaccharide', 'fructo-oligosaccharide'].includes(
        hc.constituents.category ?? '',
      ) && LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  const polysaccharideProfiles = profiles.filter(
    (p) =>
      p.class === 'Polysaccharide' &&
      HIGH_IMPORTANCE.has(p.importance ?? '') &&
      SIGNIFICANT_STATUS.has(p.status ?? ''),
  );
  if (polysaccharides.length + polysaccharideProfiles.length > 0) {
    signals.push({
      rule: 'Polysaccharide or mucilage (major+) → sweet',
      confidence: 'High',
      constituents: [
        ...polysaccharides.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
        ...polysaccharideProfiles.map((p) => p.constituent),
      ],
      direction: 'sweet',
    });
  }

  // ─── SOUR signals ────────────────────────────────────────────────────

  const organicAcids = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'organic acid' &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  if (organicAcids.length > 0) {
    signals.push({
      rule: 'Organic acid (major+) → sour',
      confidence: 'High',
      constituents: organicAcids.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
      direction: 'sour',
    });
  }

  // ─── SALTY signals ───────────────────────────────────────────────────

  const minerals = herbConstituents.filter(
    (hc) =>
      hc.constituents.category === 'mineral' &&
      LEVEL_WEIGHT[hc.concentration_level] >= 3,
  );
  if (minerals.length > 0) {
    signals.push({
      rule: 'Mineral (major+) → salty',
      confidence: 'Moderate',
      constituents: minerals.map((hc) => `${hc.constituents.name} (${hc.concentration_level})`),
      direction: 'salty',
    });
  }

  return signals;
}

const CONFIDENCE_COLOR: Record<TasteSignal['confidence'], string> = {
  High:     'bg-green-50 border-green-200 text-green-800',
  Moderate: 'bg-yellow-50 border-yellow-200 text-yellow-800',
  Low:      'bg-gray-50 border-gray-200 text-gray-700',
};

const DIRECTION_LABEL: Record<TasteDirection, string> = {
  bitter:  '☕ Bitter',
  pungent: '🌶️ Pungent',
  sweet:   '🍯 Sweet',
  sour:    '🍋 Sour',
  salty:   '🧂 Salty',
};

interface Props {
  isOpen: boolean;
  onClose: () => void;
  herbName: string;
  herbConstituents: HerbConstituent[];
  profiles: ConstituentProfile[];
}

export function InferredTasteModal({
  isOpen,
  onClose,
  herbName,
  herbConstituents,
  profiles,
}: Props) {
  if (!isOpen) return null;

  const signals = analyzeTaste(herbConstituents, profiles);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/40">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-lg max-h-[80vh] flex flex-col">
        {/* Header */}
        <div className="flex items-start justify-between p-5 border-b border-gray-100">
          <div>
            <h2 className="text-lg font-semibold text-gray-900">Inferred Taste</h2>
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
            Taste marked as <span className="italic">inferred</span> was assigned automatically
            from {herbName}&apos;s constituent profile using documented rules — not from a clinical
            taste source. It reflects constituent chemistry, not confirmed organoleptic observation.
          </p>

          {signals.length === 0 && (
            <p className="text-sm text-amber-700 bg-amber-50 border border-amber-200 rounded-lg px-4 py-3">
              The constituent data in the database is sparse for this herb. The taste was inferred
              from constituent profile data (CSV import) that may not be fully reflected in this view.
            </p>
          )}

          {signals.length > 0 && (
            <div className="space-y-3">
              <h3 className="text-xs font-semibold uppercase tracking-wider text-gray-400">
                Constituent signals found
              </h3>
              {signals.map((signal, i) => (
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
            Rules source: <span className="font-mono">docs/inferring-taste-from-constituents.md</span>.
          </p>
        </div>
      </div>
    </div>
  );
}
