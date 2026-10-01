'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import { XMarkIcon } from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';
import type { HerbMenstruum } from '@/types/database';

interface HerbOption {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
}

// Canonical chart categories — single source of truth for labels + percentages
const ABSORPTION_CATEGORIES = [
  { label: 'Leaf',                       pct: 20 },
  { label: 'Flower',                     pct: 20 },
  { label: 'Aerial parts (leaf + stem)', pct: 22 },
  { label: 'Soft stems',                 pct: 22 },
  { label: 'Seeds (non-mucilaginous)',   pct: 20 },
  { label: 'Roots (moderate density)',   pct: 30 },
  { label: 'Dense roots',               pct: 32 },
  { label: 'Bark (cut)',                 pct: 35 },
  { label: 'Woody material (twigs)',     pct: 35 },
  { label: 'Resinous roots/barks',       pct: 30 },
  { label: 'Mucilaginous roots',         pct: 40 },
  { label: 'High mucilage seeds',        pct: 45 },
  { label: 'Fungal fruiting body (est.)', pct: 25 },
  { label: 'Thallus / seaweed (est.)',   pct: 20 },
] as const;

type AbsorptionLabel = typeof ABSORPTION_CATEGORIES[number]['label'];

// plant_part → canonical category label
const ABSORPTION_BY_PLANT_PART: Record<string, AbsorptionLabel> = {
  // Leaves
  'leaf': 'Leaf', 'leaves': 'Leaf', 'blade': 'Leaf', 'needles': 'Leaf',
  // Flowers / fruit / berry
  'flower': 'Flower', 'flowers': 'Flower', 'flower bud': 'Flower', 'flower buds': 'Flower',
  'petal': 'Flower', 'petals': 'Flower', 'calyx': 'Flower',
  'hips': 'Flower', 'berry': 'Flower', 'fruit': 'Flower',
  // Aerial / stems
  'aerial parts': 'Aerial parts (leaf + stem)', 'flowering tops': 'Aerial parts (leaf + stem)',
  'flowering herb': 'Aerial parts (leaf + stem)', 'leaf & flower': 'Aerial parts (leaf + stem)',
  'whole herb': 'Aerial parts (leaf + stem)',
  'stem': 'Soft stems', 'straw': 'Soft stems', 'milky oats': 'Soft stems',
  // Seeds
  'seed': 'Seeds (non-mucilaginous)', 'seeds': 'Seeds (non-mucilaginous)',
  'seed husk': 'High mucilage seeds',
  // Roots
  'root': 'Roots (moderate density)', 'rhizome': 'Roots (moderate density)',
  'tuber': 'Roots (moderate density)',
  // Bark
  'bark': 'Bark (cut)', 'root bark': 'Bark (cut)',
  'bark, fruit': 'Bark (cut)', 'root bark, berry': 'Bark (cut)',
  // Resinous
  'gum resin': 'Resinous roots/barks',
  // Fungal / algal
  'fruiting body': 'Fungal fruiting body (est.)',
  'thallus': 'Thallus / seaweed (est.)',
  'colloidal': 'Thallus / seaweed (est.)',
};

// Latin name overrides for special cases plant_part alone can't capture
const ABSORPTION_OVERRIDES: Record<string, AbsorptionLabel> = {
  'Symphytum officinale':   'Dense roots',
  'Echinacea purpurea':     'Dense roots',
  'Echinacea angustifolia': 'Dense roots',
  'Ligusticum porteri':     'Dense roots',
  'Althaea officinalis':    'Mucilaginous roots',
  'Ulmus rubra':            'Mucilaginous roots',
  'Ulmus fulva':            'Mucilaginous roots',
  'Linum usitatissimum':    'High mucilage seeds',
  'Salvia hispanica':       'High mucilage seeds',
};

function guessAbsorptionLabel(plantPart: string | null, latinName: string): AbsorptionLabel | null {
  if (ABSORPTION_OVERRIDES[latinName]) return ABSORPTION_OVERRIDES[latinName];
  if (!plantPart) return null;
  return ABSORPTION_BY_PLANT_PART[plantPart.toLowerCase().trim()] ?? null;
}

const RATIO_PRESETS = [2, 3, 4, 5, 6, 8];
const FALLBACK_ALCOHOL_MIN = 40;
const FALLBACK_ALCOHOL_MAX = 95;
const DEFAULT_STARTING_ETOH = 95;
const DEFAULT_TARGET_ALCOHOL = 60;
const DEFAULT_ABSORPTION_PCT = 25; // fallback when no category is selected

function ResultRow({ label, value, color }: { label: string; value: number | null; color: string }) {
  return (
    <div className="flex items-center justify-between text-sm">
      <span className="text-green-600 dark:text-green-400">{label}</span>
      <span className={`font-bold tabular-nums ${color}`}>
        {value != null ? `${value.toFixed(1)} mL` : '—'}
      </span>
    </div>
  );
}

export function MenstruumCalculatorModal({ isOpen, onClose }: Props) {
  const [allHerbs, setAllHerbs] = useState<HerbOption[]>([]);
  const [search, setSearch] = useState('');
  const [showDropdown, setShowDropdown] = useState(false);
  const [highlightedIndex, setHighlightedIndex] = useState(-1);
  const [selectedHerb, setSelectedHerb] = useState<HerbOption | null>(null);
  // undefined = not yet loaded, null = loaded but no row
  const [menstruum, setMenstruum] = useState<HerbMenstruum | null | undefined>(undefined);

  const [grams, setGrams] = useState(100);
  const [gramsInput, setGramsInput] = useState('100');
  const [ratioX, setRatioX] = useState(5);
  const [customRatioInput, setCustomRatioInput] = useState('');
  const [targetAlcohol, setTargetAlcohol] = useState(DEFAULT_TARGET_ALCOHOL);
  const [startingEtoh, setStartingEtoh] = useState(DEFAULT_STARTING_ETOH);
  const [startingEtohInput, setStartingEtohInput] = useState(String(DEFAULT_STARTING_ETOH));
  const [useGlycerin, setUseGlycerin] = useState(false);
  const [useVinegar, setUseVinegar] = useState(false);

  // '' = not yet selected / unrecognised
  const [absorptionLabel, setAbsorptionLabel] = useState<AbsorptionLabel | ''>('');
  const [absorptionAutoDetected, setAbsorptionAutoDetected] = useState(false);

  const [desiredYield, setDesiredYield] = useState<number | null>(null);
  const [desiredYieldInput, setDesiredYieldInput] = useState('');

  const searchRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    document.body.style.overflow = isOpen ? 'hidden' : '';
    return () => { document.body.style.overflow = ''; };
  }, [isOpen]);

  useEffect(() => {
    if (!isOpen) return;
    supabase
      .from('herbs')
      .select('id, common_name, latin_name, plant_part')
      .order('common_name')
      .then(({ data }) => setAllHerbs((data ?? []) as HerbOption[]));
  }, [isOpen]);

  const filteredHerbs = useMemo(() => {
    if (!search.trim()) return [];
    const term = search.toLowerCase();
    return allHerbs
      .filter(h =>
        h.common_name.toLowerCase().includes(term) ||
        h.latin_name.toLowerCase().includes(term),
      )
      .slice(0, 10);
  }, [allHerbs, search]);

  useEffect(() => { setHighlightedIndex(-1); }, [filteredHerbs]);

  useEffect(() => {
    if (highlightedIndex < 0 || !dropdownRef.current) return;
    (dropdownRef.current.children[highlightedIndex] as HTMLElement)?.scrollIntoView({ block: 'nearest' });
  }, [highlightedIndex]);

  const selectHerb = async (herb: HerbOption) => {
    setSelectedHerb(herb);
    setSearch('');
    setShowDropdown(false);
    setMenstruum(undefined);
    setUseGlycerin(false);
    setUseVinegar(false);

    const guessed = guessAbsorptionLabel(herb.plant_part, herb.latin_name);
    setAbsorptionLabel(guessed ?? '');
    setAbsorptionAutoDetected(guessed !== null);

    const { data } = await supabase
      .from('herb_menstruum')
      .select('*')
      .eq('herb_id', herb.id)
      .maybeSingle();

    const m = data as HerbMenstruum | null;
    setMenstruum(m);

    if (m?.alcohol_pct_min != null) {
      const lo = m.alcohol_pct_min;
      const hi = m.alcohol_pct_max ?? lo;
      setTargetAlcohol(Math.round((lo + hi) / 2));
    } else {
      setTargetAlcohol(DEFAULT_TARGET_ALCOHOL);
    }
  };

  // Derived absorption % from the selected category
  const absorptionPct = absorptionLabel
    ? (ABSORPTION_CATEGORIES.find(c => c.label === absorptionLabel)?.pct ?? DEFAULT_ABSORPTION_PCT)
    : DEFAULT_ABSORPTION_PCT;

  // Slider bounds
  const sliderMin = menstruum?.alcohol_pct_min ?? FALLBACK_ALCOHOL_MIN;
  const sliderMax = menstruum?.alcohol_pct_max ?? FALLBACK_ALCOHOL_MAX;
  const clampedTarget = Math.min(Math.max(targetAlcohol, sliderMin), sliderMax);

  // Core calculations
  const baseTotalMl = grams * ratioX;
  const absorptionFraction = absorptionPct / 100;

  const usingDesiredYield = desiredYield != null && absorptionFraction < 1;
  const effectiveTotalMl = usingDesiredYield
    ? desiredYield! / (1 - absorptionFraction)
    : baseTotalMl;
  const effectiveGrams = effectiveTotalMl / ratioX;
  const expectedYieldMl = effectiveTotalMl * (1 - absorptionFraction);

  const etohMl = startingEtoh > 0 ? (clampedTarget / 100 * effectiveTotalMl) / (startingEtoh / 100) : 0;
  const aqueousMl = effectiveTotalMl - etohMl;
  const glycerinMl = useGlycerin && menstruum?.glycerin_pct != null
    ? (menstruum.glycerin_pct / 100) * aqueousMl : 0;
  const vinegarMl = useVinegar && menstruum?.vinegar_pct != null
    ? (menstruum.vinegar_pct / 100) * aqueousMl : 0;
  const waterMl = aqueousMl - glycerinMl - vinegarMl;
  const isValid = startingEtoh >= clampedTarget && waterMl >= -0.01;

  if (!isOpen) return null;

  const hasHerb = selectedHerb !== null && grams > 0;

  const resultsPanel = hasHerb ? (
    <div className="space-y-4">
      <div className="bg-white dark:bg-gray-800 rounded-xl border border-green-100 dark:border-gray-700 p-4 text-center">
        <div className="text-3xl font-bold text-green-800 dark:text-green-200 tabular-nums">
          {effectiveTotalMl.toFixed(0)}
        </div>
        <div className="text-xs text-green-500 mt-0.5">mL to prepare</div>
        <div className="text-xs text-green-400 mt-1.5 border-t border-green-50 dark:border-gray-700 pt-1.5">
          → yields ~<span className="font-semibold text-green-600 dark:text-green-400">{expectedYieldMl.toFixed(0)} mL</span>
          {' '}after {absorptionPct}% absorption
        </div>
      </div>

      {usingDesiredYield && (
        <div className="bg-teal-50 dark:bg-teal-900/20 border border-teal-200 dark:border-teal-700 rounded-lg px-3 py-2 text-xs text-teal-700 dark:text-teal-300 space-y-0.5">
          <div className="font-semibold">Planned for {desiredYield} mL yield</div>
          <div>Herb needed: <span className="font-semibold">{effectiveGrams.toFixed(1)} g</span> at 1:{ratioX}</div>
        </div>
      )}

      {!isValid && (
        <div className="text-xs text-amber-700 bg-amber-50 border border-amber-200 rounded-lg p-3 leading-relaxed">
          Starting ETOH % must be ≥ target alcohol %. Increase starting ETOH or lower the target.
        </div>
      )}

      <div>
        <div className="text-sm font-semibold text-green-800 dark:text-green-300 mb-2">Ingredients to combine</div>
        <div className="bg-white dark:bg-gray-800 rounded-xl border border-green-100 dark:border-gray-700 p-3 space-y-2">
          <ResultRow
            label={`${startingEtoh}% ETOH`}
            value={isValid ? etohMl : null}
            color="text-purple-700 dark:text-purple-300"
          />
          {useGlycerin && menstruum?.glycerin_pct != null && (
            <ResultRow
              label={`Glycerin (${menstruum.glycerin_pct}%)`}
              value={glycerinMl}
              color="text-pink-600 dark:text-pink-400"
            />
          )}
          {useVinegar && menstruum?.vinegar_pct != null && (
            <ResultRow
              label={`Vinegar (${menstruum.vinegar_pct}%)`}
              value={vinegarMl}
              color="text-yellow-600 dark:text-yellow-400"
            />
          )}
          <div className="border-t border-green-100 dark:border-gray-700 pt-2">
            <ResultRow
              label="Water"
              value={isValid ? Math.max(0, waterMl) : null}
              color="text-blue-600 dark:text-blue-400"
            />
          </div>
        </div>
      </div>

      <p className="text-xs text-green-400 dark:text-green-600 leading-relaxed">
        {clampedTarget}% final alcohol · from {startingEtoh}% ETOH stock
      </p>
    </div>
  ) : (
    <div className="text-center py-8 text-green-300">
      <p className="text-sm">Select an herb and enter grams to see results</p>
    </div>
  );

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center p-2 sm:p-6 overflow-y-auto">
      <div className="absolute inset-0 bg-black/50" onClick={onClose} aria-hidden="true" />

      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-3xl my-4 flex flex-col md:max-h-[88vh]">

        {/* Header */}
        <div className="shrink-0 flex items-center justify-between px-6 py-4 border-b border-green-100 dark:border-gray-700 bg-gradient-to-r from-green-50 to-emerald-50 dark:from-gray-800 dark:to-gray-800 rounded-t-2xl">
          <div>
            <h2 className="text-xl font-bold text-green-900 dark:text-green-300">Menstruum Calculator</h2>
            <p className="text-xs text-green-600 dark:text-green-400 mt-0.5">
              Calculate solvent volumes for alcohol tincture preparation
            </p>
          </div>
          <button onClick={onClose} className="text-green-400 hover:text-green-700 transition-colors p-1">
            <XMarkIcon className="w-6 h-6" />
          </button>
        </div>

        {/* Body */}
        <div className="flex-1 md:min-h-0 md:overflow-hidden md:flex md:flex-row">

          {/* Left column: inputs */}
          <div className="flex-1 md:overflow-y-auto p-6 space-y-5 min-w-0">

            {/* Herb selector */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Herb
              </label>
              {selectedHerb ? (
                <div className="flex items-center justify-between bg-green-50 dark:bg-gray-800 border border-green-200 dark:border-gray-600 rounded-lg px-4 py-2.5">
                  <div className="min-w-0">
                    <span className="font-medium text-green-900 dark:text-green-200">{selectedHerb.common_name}</span>
                    {selectedHerb.plant_part && (
                      <span className="text-xs text-green-600 dark:text-green-400 ml-1.5">({selectedHerb.plant_part})</span>
                    )}
                    <span className="text-xs text-green-500 ml-2 italic">{selectedHerb.latin_name}</span>
                  </div>
                  <button
                    onClick={() => { setSelectedHerb(null); setMenstruum(undefined); setSearch(''); setAbsorptionLabel(''); }}
                    className="ml-3 text-xs text-green-500 hover:text-red-500 transition-colors font-medium shrink-0"
                  >
                    Change
                  </button>
                </div>
              ) : (
                <div className="relative">
                  <input
                    ref={searchRef}
                    type="text"
                    value={search}
                    onChange={(e) => { setSearch(e.target.value); setShowDropdown(true); }}
                    onFocus={() => setShowDropdown(true)}
                    onBlur={() => setTimeout(() => setShowDropdown(false), 180)}
                    onKeyDown={(e) => {
                      if (!showDropdown || filteredHerbs.length === 0) return;
                      if (e.key === 'ArrowDown') { e.preventDefault(); setHighlightedIndex(i => Math.min(i + 1, filteredHerbs.length - 1)); }
                      else if (e.key === 'ArrowUp') { e.preventDefault(); setHighlightedIndex(i => Math.max(i - 1, 0)); }
                      else if (e.key === 'Enter' && highlightedIndex >= 0) { e.preventDefault(); selectHerb(filteredHerbs[highlightedIndex]); }
                      else if (e.key === 'Escape') setShowDropdown(false);
                    }}
                    placeholder="Search by common or Latin name…"
                    className="w-full border border-green-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:border-gray-600 dark:text-white"
                  />
                  {showDropdown && filteredHerbs.length > 0 && (
                    <div
                      ref={dropdownRef}
                      className="absolute top-full mt-1 left-0 right-0 bg-white dark:bg-gray-800 border border-green-200 dark:border-gray-600 rounded-lg shadow-lg z-20 max-h-52 overflow-y-auto"
                    >
                      {filteredHerbs.map((h, idx) => (
                        <button
                          key={h.id}
                          onMouseDown={() => selectHerb(h)}
                          onMouseEnter={() => setHighlightedIndex(idx)}
                          className={`w-full text-left px-4 py-2.5 transition-all flex items-center gap-2 ${idx === highlightedIndex ? 'bg-green-50 dark:bg-gray-700' : 'hover:bg-green-50 dark:hover:bg-gray-700'}`}
                        >
                          <span className="font-medium text-green-900 dark:text-green-200">{h.common_name}</span>
                          {h.plant_part && (
                            <span className="text-xs text-green-600 dark:text-green-400">({h.plant_part})</span>
                          )}
                          <span className="text-xs text-green-500 ml-auto italic">{h.latin_name}</span>
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              )}
              {selectedHerb && menstruum === undefined && (
                <p className="text-xs text-green-400 italic mt-1.5">Loading menstruum data…</p>
              )}
              {selectedHerb && menstruum === null && (
                <p className="text-xs text-amber-500 italic mt-1.5">No menstruum data on file — using manual range (40–95%)</p>
              )}
            </div>

            {/* Absorption category selector — shown once herb is selected */}
            {selectedHerb && (
              <div>
                <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                  Plant type <span className="font-normal text-green-500">(for absorption estimate)</span>
                </label>
                <select
                  value={absorptionLabel}
                  onChange={(e) => setAbsorptionLabel(e.target.value as AbsorptionLabel | '')}
                  className="w-full border border-green-300 dark:border-gray-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:text-white bg-white"
                >
                  <option value="">— select plant type —</option>
                  {ABSORPTION_CATEGORIES.map(c => (
                    <option key={c.label} value={c.label}>
                      {c.label} ({c.pct}% absorbed)
                    </option>
                  ))}
                </select>
                {!absorptionLabel && (
                  <p className="text-xs text-amber-500 mt-1">Select plant type to refine absorption estimate</p>
                )}
                {absorptionLabel && absorptionAutoDetected && (
                  <p className="text-xs text-green-500 mt-1">Auto-detected from plant part — change if needed</p>
                )}
              </div>
            )}

            {/* Grams */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Herb amount
              </label>
              <div className="flex items-center gap-2">
                <input
                  type="number"
                  min={1}
                  value={gramsInput}
                  onChange={(e) => {
                    setGramsInput(e.target.value);
                    const v = parseFloat(e.target.value);
                    if (!isNaN(v) && v > 0) setGrams(v);
                  }}
                  className="w-28 border border-green-300 dark:border-gray-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:text-white"
                />
                <span className="text-sm text-green-600 dark:text-green-400">grams</span>
              </div>
            </div>

            {/* Ratio */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Ratio (1:x herb to menstruum)
              </label>
              <div className="flex flex-wrap gap-2 items-center">
                {RATIO_PRESETS.map(x => (
                  <button
                    key={x}
                    onClick={() => { setRatioX(x); setCustomRatioInput(''); }}
                    className={`px-3 py-1.5 rounded-lg text-sm font-medium border transition-all ${
                      ratioX === x && customRatioInput === ''
                        ? 'bg-green-600 text-white border-green-600'
                        : 'bg-white dark:bg-gray-700 text-green-800 dark:text-green-200 border-green-300 dark:border-gray-600 hover:border-green-500'
                    }`}
                  >
                    1:{x}
                  </button>
                ))}
                <div className="flex items-center gap-1">
                  <span className="text-sm text-green-600 dark:text-green-400">1:</span>
                  <input
                    type="number"
                    min={1}
                    placeholder="custom"
                    value={customRatioInput}
                    onChange={(e) => {
                      setCustomRatioInput(e.target.value);
                      const v = parseInt(e.target.value);
                      if (!isNaN(v) && v > 0) setRatioX(v);
                    }}
                    className="w-20 border border-green-300 dark:border-gray-600 rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-700 dark:text-white"
                  />
                </div>
              </div>
              {!usingDesiredYield && (
                <p className="text-xs text-green-500 mt-1.5">
                  {grams}g × 1:{ratioX} = {baseTotalMl.toFixed(0)} mL
                  {absorptionLabel && ` → yields ~${(baseTotalMl * (1 - absorptionFraction)).toFixed(0)} mL`}
                </p>
              )}
            </div>

            {/* Desired yield */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Desired yield <span className="font-normal text-green-500">(optional)</span>
              </label>
              <div className="flex items-center gap-2">
                <input
                  type="number"
                  min={1}
                  placeholder="e.g. 120"
                  value={desiredYieldInput}
                  onChange={(e) => {
                    setDesiredYieldInput(e.target.value);
                    const v = parseFloat(e.target.value);
                    setDesiredYield(!isNaN(v) && v > 0 ? v : null);
                  }}
                  className="w-28 border border-green-300 dark:border-gray-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:text-white"
                />
                <span className="text-sm text-green-600 dark:text-green-400">mL finished tincture</span>
              </div>
              {usingDesiredYield && (
                <p className="text-xs text-teal-600 dark:text-teal-400 mt-1.5">
                  Prepare {effectiveTotalMl.toFixed(0)} mL total · {effectiveGrams.toFixed(1)} g herb at 1:{ratioX}
                </p>
              )}
            </div>

            {/* Target alcohol slider */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Target alcohol %
                {menstruum?.alcohol_pct_min != null && (
                  <span className="ml-2 text-xs font-normal text-green-500">
                    (recommended {menstruum.alcohol_pct_min}–{menstruum.alcohol_pct_max ?? menstruum.alcohol_pct_min}%)
                  </span>
                )}
              </label>
              <div className="space-y-1.5">
                <div className="flex justify-between items-center">
                  <span className="text-xs text-green-400">{sliderMin}%</span>
                  <span className="text-sm font-bold text-green-800 dark:text-green-200">{clampedTarget}%</span>
                  <span className="text-xs text-green-400">{sliderMax}%</span>
                </div>
                <input
                  type="range"
                  min={sliderMin}
                  max={sliderMax}
                  value={clampedTarget}
                  onChange={(e) => setTargetAlcohol(parseInt(e.target.value))}
                  className="w-full accent-green-600"
                  disabled={sliderMin === sliderMax}
                />
              </div>
            </div>

            {/* Starting ETOH % */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Starting ETOH %
              </label>
              <div className="flex items-center gap-2 flex-wrap">
                <input
                  type="number"
                  min={1}
                  max={100}
                  value={startingEtohInput}
                  onChange={(e) => {
                    setStartingEtohInput(e.target.value);
                    const v = parseFloat(e.target.value);
                    if (!isNaN(v) && v > 0 && v <= 100) setStartingEtoh(v);
                  }}
                  className="w-24 border border-green-300 dark:border-gray-600 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:text-white"
                />
                <span className="text-sm text-green-600 dark:text-green-400">%</span>
                <span className="text-xs text-green-400">(e.g., 95% grain alcohol, 80% vodka)</span>
              </div>
            </div>

            {/* Glycerin / Vinegar toggles */}
            {selectedHerb && menstruum && (menstruum.glycerin_pct != null || menstruum.vinegar_pct != null) && (
              <div>
                <div className="text-sm font-semibold text-green-800 dark:text-green-300 mb-2">Additional solvents</div>
                <div className="space-y-2">
                  {menstruum.glycerin_pct != null && (
                    <label className="flex items-center gap-3 cursor-pointer">
                      <input
                        type="checkbox"
                        checked={useGlycerin}
                        onChange={(e) => setUseGlycerin(e.target.checked)}
                        className="w-4 h-4 accent-green-600 shrink-0"
                      />
                      <span className="text-sm text-green-800 dark:text-green-200">
                        Add glycerin{' '}
                        <span className="text-green-500">
                          ({menstruum.glycerin_pct}% of water = {((menstruum.glycerin_pct / 100) * aqueousMl).toFixed(1)} mL)
                        </span>
                      </span>
                    </label>
                  )}
                  {menstruum.vinegar_pct != null && (
                    <label className="flex items-center gap-3 cursor-pointer">
                      <input
                        type="checkbox"
                        checked={useVinegar}
                        onChange={(e) => setUseVinegar(e.target.checked)}
                        className="w-4 h-4 accent-green-600 shrink-0"
                      />
                      <span className="text-sm text-green-800 dark:text-green-200">
                        Add vinegar{' '}
                        <span className="text-green-500">
                          ({menstruum.vinegar_pct}% of water = {((menstruum.vinegar_pct / 100) * aqueousMl).toFixed(1)} mL)
                        </span>
                      </span>
                    </label>
                  )}
                </div>
              </div>
            )}

            {/* Menstruum notes */}
            {menstruum?.notes && (
              <div className="bg-green-50 dark:bg-gray-800/50 border border-green-100 dark:border-gray-700 rounded-lg p-3">
                <p className="text-xs text-green-700 dark:text-green-400 leading-relaxed">{menstruum.notes}</p>
              </div>
            )}

            {/* Mobile: results below inputs */}
            <div className="md:hidden border-t border-green-100 dark:border-gray-700 pt-5">
              {resultsPanel}
            </div>
          </div>

          {/* Right column: results (desktop only) */}
          <div className="hidden md:flex flex-col w-72 shrink-0 border-l border-green-100 dark:border-gray-700 md:overflow-y-auto p-6 bg-green-50/20 dark:bg-gray-800/20 rounded-br-2xl">
            {resultsPanel}
          </div>

        </div>
      </div>
    </div>
  );
}
