'use client';

import { useEffect, useState, useRef } from 'react';
import { MagnifyingGlassIcon } from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';

interface HerbOption {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
}

interface ConstituentRow {
  constituent: string;
  class: string | null;
  subclass: string | null;
  importance: string | null;
  status: string | null;
}

interface MenstruumData {
  alcohol_pct_min: number | null;
  alcohol_pct_max: number | null;
  glycerin_pct: number | null;
  vinegar_pct: number | null;
  primary_label: string;
  notes: string | null;
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
}

// ---- Solubility classification ----
const WATER_SOLUBLE_CLASSES = ['Polysaccharide', 'Mucilage'];
const ALCOHOL_SOLUBLE_CLASSES = ['Triterpene', 'Triterpenoid saponin', 'Saponin', 'Alkaloid', 'Alkylamide', 'Flavonoid', 'Resin', 'Volatile oil', 'Essential oil'];
const BOTH_CLASSES = ['Tannin', 'Phenolic acid', 'Polyphenol', 'Anthocyanin', 'Glycoside', 'Iridoid', 'Phenylpropanoid'];

function classifySolubility(cls: string | null): 'water' | 'alcohol' | 'both' | 'unknown' {
  if (!cls) return 'unknown';
  if (WATER_SOLUBLE_CLASSES.some((c) => cls.toLowerCase().includes(c.toLowerCase()))) return 'water';
  if (ALCOHOL_SOLUBLE_CLASSES.some((c) => cls.toLowerCase().includes(c.toLowerCase()))) return 'alcohol';
  if (BOTH_CLASSES.some((c) => cls.toLowerCase().includes(c.toLowerCase()))) return 'both';
  return 'unknown';
}

function statusRank(s: string | null) {
  return s === 'Marker' ? 0 : s === 'Major' ? 1 : s === 'Present' ? 2 : 3;
}

// ---- Recommendation logic ----
interface Recommendation {
  minPct: number;
  maxPct: number;
  defaultPct: number;
  reason: string;
  isDualExtract: boolean;
}

function getRecommendation(constituents: ConstituentRow[]): Recommendation {
  const hasHighPoly = constituents.some(
    (c) => c.class === 'Polysaccharide' && (c.status === 'Marker' || c.status === 'Major' || c.importance === 'High')
  );
  const hasPoly = constituents.some((c) => c.class === 'Polysaccharide');
  const hasTannin = constituents.some(
    (c) => c.class === 'Tannin' && (c.status === 'Marker' || c.status === 'Major')
  );
  const hasAlcohol = constituents.some(
    (c) => classifySolubility(c.class) === 'alcohol' && (c.status === 'Marker' || c.status === 'Major')
  );

  if (hasHighPoly && hasAlcohol) {
    return {
      minPct: 25, maxPct: 38, defaultPct: 30,
      reason: 'This herb has significant polysaccharides AND alcohol-soluble constituents — classic dual extraction territory. Polysaccharides fall out of solution above ~40%; keep final alcohol at or below 35–38%.',
      isDualExtract: true,
    };
  }
  if (hasPoly) {
    return {
      minPct: 25, maxPct: 40, defaultPct: 30,
      reason: 'This herb contains polysaccharides, which require water extraction. Keeping the final alcohol below 40% ensures they stay in solution.',
      isDualExtract: true,
    };
  }
  if (hasTannin) {
    return {
      minPct: 30, maxPct: 45, defaultPct: 38,
      reason: 'Tannins extract well in 25–45% alcohol and may precipitate above 50%. A moderate final percentage captures both the tannin and any alcohol-soluble companions.',
      isDualExtract: false,
    };
  }
  return {
    minPct: 25, maxPct: 50, defaultPct: 35,
    reason: 'No specific polysaccharide or tannin data found. Standard dual-extract range applies. Keep above 25% to prevent spoilage and below 50% to preserve water-soluble compounds.',
    isDualExtract: false,
  };
}

// ---- Calculation ----
interface Calc {
  alcoholInTincture: number;
  waterInTincture: number;
  glycerinInTincture: number;
  finalVol: number;
  totalWaterInFinal: number;
  decoctionToAdd: number;
  startDecoctionVol: number;
  actualAlcoholPct: number;
  actualRatio: number | null;
  isValidDecoction: boolean;
}

function calculate(
  tincVol: number,
  alcoholPct: number,
  glycerinPct: number,
  targetAlcPct: number,
  herbWeight: number | null
): Calc | null {
  if (tincVol <= 0 || alcoholPct <= 0 || targetAlcPct <= 0) return null;
  if (targetAlcPct >= alcoholPct) return null; // can't dilute to higher than starting

  const alcoholInTincture = tincVol * (alcoholPct / 100);
  const waterInTincture = tincVol * ((100 - alcoholPct - glycerinPct) / 100);
  const glycerinInTincture = tincVol * (glycerinPct / 100);

  // Final volume derived from alcohol target (exact)
  const finalVol = alcoholInTincture / (targetAlcPct / 100);
  const decoctionToAdd = finalVol - tincVol;
  const startDecoctionVol = decoctionToAdd * 2;
  const totalWaterInFinal = finalVol - alcoholInTincture - glycerinInTincture;
  const actualAlcoholPct = (alcoholInTincture / finalVol) * 100;
  const actualRatio = herbWeight && herbWeight > 0 ? finalVol / herbWeight : null;

  return {
    alcoholInTincture,
    waterInTincture,
    glycerinInTincture,
    finalVol,
    totalWaterInFinal,
    decoctionToAdd,
    startDecoctionVol,
    actualAlcoholPct,
    actualRatio,
    isValidDecoction: decoctionToAdd > 0,
  };
}

function fmt(n: number, decimals = 1) {
  return n.toFixed(decimals);
}

// ---- Alcohol safety indicator ----
function AlcoholBar({ pct, minSafe = 25, maxSafe = 50, polysaccharideMax }: { pct: number; minSafe?: number; maxSafe?: number; polysaccharideMax?: number }) {
  const clampedPct = Math.max(0, Math.min(100, pct));
  const isSafe = pct >= minSafe && pct <= maxSafe;
  const isPolyWarning = polysaccharideMax !== undefined && pct > polysaccharideMax;

  return (
    <div className="space-y-1">
      <div className="relative h-5 rounded-full bg-gray-100 overflow-hidden">
        {/* Safe zone shading */}
        <div
          className="absolute top-0 h-full bg-green-100"
          style={{ left: `${minSafe}%`, width: `${maxSafe - minSafe}%` }}
        />
        {/* Polysaccharide warning zone */}
        {polysaccharideMax !== undefined && polysaccharideMax < maxSafe && (
          <div
            className="absolute top-0 h-full bg-amber-100"
            style={{ left: `${polysaccharideMax}%`, width: `${maxSafe - polysaccharideMax}%` }}
          />
        )}
        {/* Marker */}
        <div
          className={`absolute top-0 h-full w-1.5 rounded-full ${isPolyWarning ? 'bg-amber-500' : isSafe ? 'bg-green-600' : 'bg-red-500'}`}
          style={{ left: `calc(${clampedPct}% - 3px)` }}
        />
        {/* Labels */}
        <span className="absolute left-1 top-0 text-[9px] text-gray-400 leading-5">0%</span>
        <span className="absolute right-1 top-0 text-[9px] text-gray-400 leading-5">100%</span>
      </div>
      <div className="flex items-center gap-3 text-xs">
        <span className="flex items-center gap-1">
          <span className="w-3 h-3 rounded bg-green-100 border border-green-300 inline-block" />
          Safe zone (25–{polysaccharideMax ?? 50}%)
        </span>
        {polysaccharideMax !== undefined && polysaccharideMax < maxSafe && (
          <span className="flex items-center gap-1 text-amber-700">
            <span className="w-3 h-3 rounded bg-amber-100 border border-amber-300 inline-block" />
            Poly risk ({polysaccharideMax}–{maxSafe}%)
          </span>
        )}
      </div>
    </div>
  );
}

// ---- Mixing diagram ----
function MixingDiagram({ tincVol, decoctionVol, finalVol, alcoholPct, tincAlcPct }: { tincVol: number; decoctionVol: number; finalVol: number; alcoholPct: number; tincAlcPct: number }) {
  const tincPct = (tincVol / finalVol) * 100;
  const decocPct = (decoctionVol / finalVol) * 100;
  // Within the tincture's fill level, split by composition
  const tincAlcHeight = Math.min(100, tincPct) * (tincAlcPct / 100);
  const tincWaterHeight = Math.min(100, tincPct) * ((100 - tincAlcPct) / 100);

  return (
    <div className="flex items-center gap-3 flex-wrap">
      {/* Tincture flask */}
      <div className="text-center">
        <div className="text-xs text-gray-500 mb-1 font-medium">Tincture</div>
        <div className="w-16 h-20 border-2 border-amber-400 rounded-b-xl rounded-t-sm bg-white relative overflow-hidden flex flex-col justify-end">
          <div className="bg-sky-200" style={{ height: `${tincWaterHeight}%` }} />
          <div className="bg-amber-300" style={{ height: `${tincAlcHeight}%` }} />
        </div>
        <div className="h-8 mt-1 flex flex-col items-center justify-start">
          <div className="text-xs text-amber-700 font-mono">{fmt(tincVol)} mL</div>
        </div>
      </div>

      <div className="text-2xl text-gray-400 font-light pb-4">+</div>

      {/* Decoction */}
      <div className="text-center">
        <div className="text-xs text-gray-500 mb-1 font-medium">Decoction</div>
        <div className="w-16 h-20 border-2 border-sky-400 rounded-b-xl rounded-t-sm bg-sky-50 relative overflow-hidden flex flex-col justify-end">
          <div className="bg-sky-300" style={{ height: `${Math.min(100, decocPct)}%` }} />
        </div>
        <div className="h-8 mt-1 flex flex-col items-center justify-start">
          <div className="text-xs text-sky-700 font-mono">{fmt(decoctionVol)} mL</div>
        </div>
      </div>

      <div className="text-2xl text-gray-400 font-light pb-4">=</div>

      {/* Final product */}
      <div className="text-center">
        <div className="text-xs text-gray-500 mb-1 font-medium">Final Extract</div>
        <div className="w-16 h-20 border-2 border-green-500 rounded-b-xl rounded-t-sm bg-green-50 relative overflow-hidden flex flex-col justify-end">
          <div className="bg-sky-200" style={{ height: `${100 - alcoholPct}%` }} />
          <div className="bg-amber-300" style={{ height: `${alcoholPct}%` }} />
        </div>
        <div className="h-8 mt-1 flex flex-col items-center justify-start">
          <div className="text-xs text-green-700 font-mono">{fmt(finalVol)} mL</div>
          <div className="text-[10px] text-green-600">{fmt(alcoholPct)}% alc</div>
        </div>
      </div>

      {/* Legend */}
      <div className="flex flex-col gap-1 text-[10px] text-gray-600 pb-4">
        <span className="flex items-center gap-1"><span className="w-3 h-2 bg-amber-300 rounded inline-block" />Alcohol</span>
        <span className="flex items-center gap-1"><span className="w-3 h-2 bg-sky-200 rounded inline-block" />Water</span>
      </div>
    </div>
  );
}

export function DoubleExtractionCalculatorModal({ isOpen, onClose }: Props) {
  const [allHerbs, setAllHerbs] = useState<HerbOption[]>([]);
  const [search, setSearch] = useState('');
  const [showDropdown, setShowDropdown] = useState(false);
  const [selectedHerb, setSelectedHerb] = useState<HerbOption | null>(null);
  const [constituents, setConstituents] = useState<ConstituentRow[]>([]);
  const [menstruum, setMenstruum] = useState<MenstruumData | null>(null);
  const [loadingHerbData, setLoadingHerbData] = useState(false);

  // Tincture inputs
  const [herbWeight, setHerbWeight] = useState('');
  const [tincRatio, setTincRatio] = useState<'1:3' | '1:4'>('1:3');
  const [alcoholPct, setAlcoholPct] = useState('75');
  const [glycerinPct, setGlycerinPct] = useState('0');
  const [vinegarPct, setVinegarPct] = useState('0');
  const [tincVol, setTincVol] = useState('');
  const [targetAlcPct, setTargetAlcPct] = useState('30');

  const searchRef = useRef<HTMLInputElement>(null);

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

  useEffect(() => {
    if (!selectedHerb) { setConstituents([]); setMenstruum(null); return; }
    setLoadingHerbData(true);
    Promise.all([
      supabase
        .from('constituent_profiles')
        .select('constituent, class, subclass, importance, status')
        .eq('herb_id', selectedHerb.id)
        .not('class', 'is', null),
      supabase
        .from('herb_menstruum')
        .select('alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, primary_label, notes')
        .eq('herb_id', selectedHerb.id)
        .maybeSingle(),
    ]).then(([cpRes, mmRes]) => {
      const rows = (cpRes.data ?? []) as ConstituentRow[];
      rows.sort((a, b) => statusRank(a.status) - statusRank(b.status));
      setConstituents(rows);
      setMenstruum((mmRes.data ?? null) as MenstruumData | null);

      // Pre-fill target alcohol from recommendation
      const rec = getRecommendation(rows);
      setTargetAlcPct(String(rec.defaultPct));

      // Pre-fill tincture alcohol from menstruum if available
      if (mmRes.data?.alcohol_pct_max) {
        setAlcoholPct(String(mmRes.data.alcohol_pct_max));
      } else {
        setAlcoholPct('75');
      }
      // Pre-fill glycerin
      if (mmRes.data?.glycerin_pct) {
        setGlycerinPct(String(mmRes.data.glycerin_pct));
      } else {
        setGlycerinPct('0');
      }
      setLoadingHerbData(false);
    });
  }, [selectedHerb]);

  const filteredHerbs = allHerbs.filter((h) => {
    const q = search.toLowerCase();
    return h.common_name.toLowerCase().includes(q) || h.latin_name.toLowerCase().includes(q);
  }).slice(0, 60);

  function selectHerb(h: HerbOption) {
    setSelectedHerb(h);
    setSearch(h.common_name);
    setShowDropdown(false);
    setTincVol('');
    setHerbWeight('');
  }

  // Parsed values
  const tincVolNum = parseFloat(tincVol) || 0;
  const alcNum = parseFloat(alcoholPct) || 0;
  const glycNum = parseFloat(glycerinPct) || 0;
  const vinegarNum = parseFloat(vinegarPct) || 0;
  const targetNum = parseFloat(targetAlcPct) || 0;
  const herbWeightNum = parseFloat(herbWeight) || 0;

  // Validation
  const waterPct = Math.max(0, 100 - alcNum - glycNum - vinegarNum);
  const menstruumSumOk = alcNum + glycNum + vinegarNum <= 100;

  const rec = getRecommendation(constituents);
  const calc = tincVolNum > 0 && alcNum > 0 && targetNum > 0 && targetNum < alcNum
    ? calculate(tincVolNum, alcNum, glycNum, targetNum, herbWeightNum > 0 ? herbWeightNum : null)
    : null;

  const polysaccharideMax = rec.isDualExtract ? 40 : undefined;
  const alcSafe = targetNum >= 25 && targetNum <= 50;
  const alcPolyWarning = polysaccharideMax !== undefined && targetNum > polysaccharideMax;

  if (!isOpen) return null;

  return (
    <div
      className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4"
      onClick={onClose}
    >
      <div
        className="bg-white dark:bg-gray-900 rounded-xl shadow-2xl w-full max-w-2xl max-h-[92vh] overflow-y-auto"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="sticky top-0 bg-white dark:bg-gray-900 border-b border-gray-100 dark:border-gray-700 px-6 py-4 flex items-start justify-between rounded-t-xl z-10">
          <div>
            <h2 className="text-xl font-bold text-green-800 dark:text-green-300">Double Extraction Calculator</h2>
            <p className="text-xs text-gray-400 mt-0.5">Water decoction + alcohol tincture → dual extract</p>
          </div>
          <button onClick={onClose} className="ml-4 shrink-0 text-gray-400 hover:text-gray-600 transition-colors text-2xl leading-none">×</button>
        </div>

        <div className="px-6 py-5 space-y-6 text-sm text-gray-700 dark:text-gray-300">

          {/* === HERB SELECTION === */}
          <section>
            <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-2">1. Select Herb</h3>
            <div className="relative">
              <div className="relative">
                <MagnifyingGlassIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                <input
                  ref={searchRef}
                  type="text"
                  value={search}
                  placeholder="Search by common or Latin name…"
                  onChange={(e) => { setSearch(e.target.value); setShowDropdown(true); if (!e.target.value) setSelectedHerb(null); }}
                  onFocus={() => setShowDropdown(true)}
                  className="w-full pl-9 pr-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:border-gray-600 dark:text-gray-100"
                />
              </div>
              {showDropdown && search.length > 0 && (
                <div className="absolute top-full mt-1 left-0 right-0 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-600 rounded-lg shadow-lg max-h-48 overflow-y-auto z-20">
                  {filteredHerbs.length === 0 ? (
                    <div className="px-4 py-3 text-gray-400 text-xs">No herbs found</div>
                  ) : filteredHerbs.map((h) => (
                    <button
                      key={h.id}
                      className="w-full text-left px-4 py-2 hover:bg-green-50 dark:hover:bg-gray-700 transition-colors"
                      onMouseDown={() => selectHerb(h)}
                    >
                      <span className="font-medium">{h.common_name}</span>
                      <span className="text-gray-400 ml-2 text-xs italic">{h.latin_name}</span>
                      {h.plant_part && <span className="text-gray-400 ml-1 text-xs">· {h.plant_part}</span>}
                    </button>
                  ))}
                </div>
              )}
            </div>
          </section>

          {/* === CONSTITUENT PROFILE === */}
          {selectedHerb && (
            <section>
              <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-2">2. Constituent Profile</h3>

              {loadingHerbData ? (
                <div className="text-gray-400 text-xs py-2">Loading…</div>
              ) : (
                <>
                  {constituents.length === 0 ? (
                    <div className="bg-amber-50 border border-amber-200 rounded-lg px-4 py-3 text-xs text-amber-800">
                      No constituent profile data for this herb yet. Target alcohol % will default to 30%.
                      {menstruum && (
                        <span className="block mt-1 text-gray-600">Menstruum on record: <strong>{menstruum.primary_label}</strong>{menstruum.notes ? ` — ${menstruum.notes}` : ''}</span>
                      )}
                    </div>
                  ) : (
                    <div className="space-y-3">
                      {/* Water-soluble group */}
                      {(['water', 'alcohol', 'both'] as const).map((solType) => {
                        const group = constituents.filter((c) => classifySolubility(c.class) === solType);
                        if (group.length === 0) return null;
                        const label = solType === 'water' ? 'Water-soluble (decoction)' : solType === 'alcohol' ? 'Alcohol-soluble (tincture)' : 'Both (tincture + decoction)';
                        const headerColor = solType === 'water' ? 'bg-sky-50 text-sky-800 border-sky-200' : solType === 'alcohol' ? 'bg-amber-50 text-amber-800 border-amber-200' : 'bg-purple-50 text-purple-800 border-purple-200';
                        return (
                          <div key={solType} className={`border rounded-lg overflow-hidden ${headerColor.split(' ').slice(2).join(' ')}`}>
                            <div className={`px-3 py-1.5 text-xs font-semibold ${headerColor}`}>{label}</div>
                            <div className="divide-y divide-gray-100">
                              {group.map((c, i) => (
                                <div key={i} className="px-3 py-1.5 flex items-center justify-between gap-2">
                                  <span className="font-medium text-gray-800">{c.constituent}</span>
                                  <div className="flex items-center gap-1.5 shrink-0">
                                    {c.subclass && <span className="text-[10px] text-gray-400 italic">{c.subclass}</span>}
                                    {c.status && (
                                      <span className={`text-[10px] px-1.5 py-0.5 rounded font-medium ${c.status === 'Marker' ? 'bg-green-100 text-green-800' : c.status === 'Major' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-600'}`}>
                                        {c.status}
                                      </span>
                                    )}
                                    {c.importance && (
                                      <span className="text-[10px] text-gray-400">{c.importance}</span>
                                    )}
                                  </div>
                                </div>
                              ))}
                            </div>
                          </div>
                        );
                      })}

                      {/* Recommendation box */}
                      <div className={`border rounded-lg px-4 py-3 text-xs ${rec.isDualExtract ? 'bg-green-50 border-green-200 text-green-900' : 'bg-gray-50 border-gray-200 text-gray-800'}`}>
                        <div className="font-semibold mb-1">
                          {rec.isDualExtract ? '✓ Good dual extraction candidate' : 'Dual extraction may apply'}
                          {' — '}Suggested final alcohol: <strong>{rec.minPct}–{rec.maxPct}%</strong>
                        </div>
                        <p className="leading-relaxed">{rec.reason}</p>
                        <div className="mt-2 text-[10px] text-gray-500">
                          Water-soluble: Polysaccharides, inulin &nbsp;·&nbsp; Alcohol-soluble: Triterpenes, alkaloids, alkylamides, flavonoids
                        </div>
                      </div>
                    </div>
                  )}
                </>
              )}
            </section>
          )}

          {/* === TINCTURE SETUP === */}
          <section>
            <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-3">3. Your Tincture</h3>
            <div className="space-y-4">

              {/* Herb weight */}
              <div className="flex items-center gap-3">
                <label className="w-40 text-xs text-gray-600 shrink-0">Herb weight (g) <span className="text-gray-400">optional</span></label>
                <input
                  type="number" min="0" step="1"
                  value={herbWeight}
                  onChange={(e) => setHerbWeight(e.target.value)}
                  placeholder="e.g. 100"
                  className="w-28 px-3 py-1.5 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:border-gray-600"
                />
                <span className="text-xs text-gray-400">Used to show final ratio (e.g. 1:5)</span>
              </div>

              {/* Tincture ratio */}
              <div className="flex items-center gap-3">
                <label className="w-40 text-xs text-gray-600 shrink-0">Tincture ratio</label>
                <div className="flex gap-2">
                  {(['1:3', '1:4'] as const).map((r) => (
                    <button
                      key={r}
                      onClick={() => setTincRatio(r)}
                      className={`px-4 py-1.5 rounded-lg text-sm border transition-all ${tincRatio === r ? 'bg-green-600 text-white border-green-600' : 'bg-white border-gray-200 text-gray-700 hover:border-green-400'}`}
                    >
                      {r}
                    </button>
                  ))}
                </div>
                <span className="text-xs text-gray-400">{tincRatio === '1:4' ? 'For fluffy plant material (e.g. Reishi)' : 'Standard'}</span>
              </div>

              {/* Menstruum composition */}
              <div className="border border-gray-100 rounded-lg p-3 space-y-2 bg-gray-50 dark:bg-gray-800 dark:border-gray-700">
                <div className="text-xs font-medium text-gray-600 dark:text-gray-300 mb-1">Menstruum composition</div>
                <div className="grid grid-cols-2 gap-x-4 gap-y-2">
                  <div className="flex items-center gap-2">
                    <label className="text-xs text-amber-700 w-20 shrink-0">Alcohol %</label>
                    <input
                      type="number" min="0" max="100" step="1"
                      value={alcoholPct}
                      onChange={(e) => setAlcoholPct(e.target.value)}
                      className="w-20 px-2 py-1 border border-gray-200 rounded text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-700 dark:border-gray-600"
                    />
                  </div>
                  <div className="flex items-center gap-2">
                    <label className="text-xs text-purple-700 w-20 shrink-0">Glycerin %</label>
                    <input
                      type="number" min="0" max="100" step="1"
                      value={glycerinPct}
                      onChange={(e) => setGlycerinPct(e.target.value)}
                      className="w-20 px-2 py-1 border border-gray-200 rounded text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-700 dark:border-gray-600"
                    />
                  </div>
                  <div className="flex items-center gap-2">
                    <label className="text-xs text-orange-700 w-20 shrink-0">Vinegar %</label>
                    <input
                      type="number" min="0" max="100" step="1"
                      value={vinegarPct}
                      onChange={(e) => setVinegarPct(e.target.value)}
                      className="w-20 px-2 py-1 border border-gray-200 rounded text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-700 dark:border-gray-600"
                    />
                  </div>
                  <div className="flex items-center gap-2">
                    <label className="text-xs text-sky-700 w-20 shrink-0">Water %</label>
                    <div className={`w-20 px-2 py-1 rounded text-sm font-mono ${menstruumSumOk ? 'text-sky-700' : 'text-red-500'}`}>{waterPct}%</div>
                  </div>
                </div>
                {!menstruumSumOk && (
                  <p className="text-xs text-red-500">Alcohol + glycerin + vinegar exceeds 100%. Adjust values.</p>
                )}
                {glycNum > 0 && (
                  <p className="text-xs text-purple-600 mt-1">Glycerin note: glycerin does not contribute to ethanol content and may help stabilize polysaccharides in solution. Calculations show ethanol % only.</p>
                )}
                {vinegarNum > 0 && (
                  <p className="text-xs text-orange-600 mt-1">Vinegar note: ACV (~5% acetic acid) contains no ethanol — treated as water for alcohol calculations.</p>
                )}
              </div>

              {/* Measured tincture volume */}
              <div className="flex items-center gap-3">
                <label className="w-40 text-xs text-gray-600 shrink-0">Measured tincture volume <span className="text-red-400">*</span></label>
                <input
                  type="number" min="0" step="1"
                  value={tincVol}
                  onChange={(e) => setTincVol(e.target.value)}
                  placeholder="mL after pressing"
                  className="w-36 px-3 py-1.5 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:border-gray-600"
                />
                <span className="text-xs text-gray-400">Measure after pressing the marc</span>
              </div>
            </div>
          </section>

          {/* === TARGET === */}
          <section>
            <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-3">4. Final Extract Target</h3>
            <div className="space-y-3">
              <div className="flex items-center gap-3">
                <label className="w-40 text-xs text-gray-600 shrink-0">Target final alcohol %</label>
                <input
                  type="range" min="25" max="50" step="1"
                  value={targetAlcPct}
                  onChange={(e) => setTargetAlcPct(e.target.value)}
                  className="flex-1 accent-green-600"
                />
                <input
                  type="number" min="1" max="99" step="1"
                  value={targetAlcPct}
                  onChange={(e) => setTargetAlcPct(e.target.value)}
                  className="w-16 px-2 py-1 border border-gray-200 rounded text-sm text-center focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:border-gray-600"
                />
                <span className="text-xs text-gray-400">%</span>
              </div>
              <AlcoholBar pct={targetNum} polysaccharideMax={polysaccharideMax} />
              {!alcSafe && targetNum > 0 && (
                <p className="text-xs text-red-600">⚠ Outside safe range (25–50%). Below 25% risks spoilage; above 50% may precipitate polysaccharides and tannins.</p>
              )}
              {alcPolyWarning && alcSafe && (
                <p className="text-xs text-amber-700">⚠ Above 40% — polysaccharides may begin to fall out of solution. Recommend keeping at or below 38% for this herb.</p>
              )}
              {targetNum >= alcNum && targetNum > 0 && (
                <p className="text-xs text-red-600">⚠ Target alcohol must be lower than original tincture alcohol ({alcNum}%) — you cannot concentrate by adding water.</p>
              )}
            </div>
          </section>

          {/* === CALCULATIONS === */}
          {calc ? (
            <section>
              <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-3">5. Step-by-Step Calculations</h3>
              <div className="space-y-2">

                {/* Step A: alcohol in tincture */}
                <div className="flex items-start gap-3 p-3 bg-amber-50 rounded-lg border border-amber-100">
                  <span className="shrink-0 w-6 h-6 rounded-full bg-amber-400 text-white text-xs flex items-center justify-center font-bold">A</span>
                  <div className="flex-1">
                    <div className="font-medium text-amber-800 text-xs">Alcohol in your tincture</div>
                    <div className="font-mono text-sm mt-0.5 text-amber-900">
                      {fmt(tincVolNum)} mL × {alcNum}% = <strong>{fmt(calc.alcoholInTincture)} mL alcohol</strong>
                    </div>
                    <div className="text-xs text-amber-600 mt-0.5">This is the total ethanol you are working with — it will not change when you add the decoction.</div>
                  </div>
                </div>

                {/* Step B: water in tincture */}
                <div className="flex items-start gap-3 p-3 bg-sky-50 rounded-lg border border-sky-100">
                  <span className="shrink-0 w-6 h-6 rounded-full bg-sky-400 text-white text-xs flex items-center justify-center font-bold">B</span>
                  <div className="flex-1">
                    <div className="font-medium text-sky-800 text-xs">Water already in your tincture</div>
                    <div className="font-mono text-sm mt-0.5 text-sky-900">
                      {fmt(tincVolNum)} mL × {waterPct}% = <strong>{fmt(calc.waterInTincture)} mL water</strong>
                    </div>
                    {glycNum > 0 && (
                      <div className="font-mono text-xs text-purple-700 mt-0.5">
                        + {fmt(calc.glycerinInTincture)} mL glycerin (remains in final product)
                      </div>
                    )}
                  </div>
                </div>

                {/* Step C: final volume */}
                <div className="flex items-start gap-3 p-3 bg-green-50 rounded-lg border border-green-100">
                  <span className="shrink-0 w-6 h-6 rounded-full bg-green-500 text-white text-xs flex items-center justify-center font-bold">C</span>
                  <div className="flex-1">
                    <div className="font-medium text-green-800 text-xs">Required final volume (to hit {targetNum}% alcohol)</div>
                    <div className="font-mono text-sm mt-0.5 text-green-900">
                      {fmt(calc.alcoholInTincture)} mL ÷ {targetNum}% = <strong>{fmt(calc.finalVol)} mL total</strong>
                    </div>
                    {calc.actualRatio && (
                      <div className="text-xs text-green-700 mt-0.5">
                        Effective ratio: 1:{fmt(calc.actualRatio, 1)} (herb weight {herbWeight} g)
                      </div>
                    )}
                  </div>
                </div>

                {/* Step D: total water needed */}
                <div className="flex items-start gap-3 p-3 bg-sky-50 rounded-lg border border-sky-100">
                  <span className="shrink-0 w-6 h-6 rounded-full bg-sky-500 text-white text-xs flex items-center justify-center font-bold">D</span>
                  <div className="flex-1">
                    <div className="font-medium text-sky-800 text-xs">Total water volume in final product</div>
                    <div className="font-mono text-sm mt-0.5 text-sky-900">
                      {fmt(calc.finalVol)} mL × {fmt(100 - targetNum - (calc.glycerinInTincture / calc.finalVol) * 100, 1)}% = <strong>{fmt(calc.totalWaterInFinal)} mL water</strong>
                    </div>
                  </div>
                </div>

                {/* Step E: decoction */}
                <div className="flex items-start gap-3 p-3 bg-teal-50 rounded-lg border border-teal-200">
                  <span className="shrink-0 w-6 h-6 rounded-full bg-teal-500 text-white text-xs flex items-center justify-center font-bold">E</span>
                  <div className="flex-1">
                    <div className="font-medium text-teal-800 text-xs">Decoction to add</div>
                    <div className="font-mono text-sm mt-0.5 text-teal-900">
                      {fmt(calc.finalVol)} mL − {fmt(tincVolNum)} mL = <strong>{fmt(calc.decoctionToAdd)} mL decoction</strong>
                    </div>
                    <div className="text-xs text-teal-700 mt-0.5">
                      This equals total water in final ({fmt(calc.totalWaterInFinal)} mL) minus water already in tincture ({fmt(calc.waterInTincture)} mL)
                      {glycNum > 0 ? ', adjusted for glycerin' : ''}.
                    </div>
                  </div>
                </div>

                {/* Step F: starting decoction */}
                <div className="flex items-start gap-3 p-3 bg-teal-100 rounded-lg border border-teal-300">
                  <span className="shrink-0 w-6 h-6 rounded-full bg-teal-600 text-white text-xs flex items-center justify-center font-bold">F</span>
                  <div className="flex-1">
                    <div className="font-medium text-teal-900 text-xs">Starting decoction volume (reduce by half)</div>
                    <div className="font-mono text-sm mt-0.5 text-teal-900">
                      {fmt(calc.decoctionToAdd)} mL × 2 = <strong>{fmt(calc.startDecoctionVol)} mL starting water</strong>
                    </div>
                    <div className="text-xs text-teal-700 mt-0.5">
                      Add the pressed marc to {fmt(calc.startDecoctionVol)} mL water. Decoct (simmer) until reduced to {fmt(calc.decoctionToAdd)} mL.
                    </div>
                  </div>
                </div>
              </div>

              {/* Visual mixing diagram */}
              <div className="mt-4 p-4 border border-gray-100 rounded-lg bg-gray-50">
                <div className="text-xs font-medium text-gray-500 mb-3">Volume breakdown</div>
                <MixingDiagram
                  tincVol={tincVolNum}
                  decoctionVol={calc.decoctionToAdd}
                  finalVol={calc.finalVol}
                  alcoholPct={calc.actualAlcoholPct}
                  tincAlcPct={alcNum}
                />
              </div>

              {/* Results summary */}
              <div className={`mt-4 p-4 rounded-lg border-2 ${calc.actualAlcoholPct >= 25 && calc.actualAlcoholPct <= 50 ? 'border-green-400 bg-green-50' : 'border-red-400 bg-red-50'}`}>
                <div className="font-semibold text-sm mb-2 text-gray-800">Results Summary</div>
                <div className="grid grid-cols-2 gap-x-8 gap-y-1 text-xs">
                  <div className="text-gray-600">Add decoction</div>
                  <div className="font-mono font-semibold text-teal-700">{fmt(calc.decoctionToAdd)} mL</div>
                  <div className="text-gray-600">Start with water (for decoction)</div>
                  <div className="font-mono font-semibold text-teal-800">{fmt(calc.startDecoctionVol)} mL → reduce by ½</div>
                  <div className="text-gray-600">Final volume</div>
                  <div className="font-mono font-semibold">{fmt(calc.finalVol)} mL</div>
                  <div className="text-gray-600">Final alcohol %</div>
                  <div className={`font-mono font-semibold ${calc.actualAlcoholPct < 25 || calc.actualAlcoholPct > 50 ? 'text-red-600' : alcPolyWarning ? 'text-amber-600' : 'text-green-700'}`}>
                    {fmt(calc.actualAlcoholPct)}%
                    {calc.actualAlcoholPct >= 25 && calc.actualAlcoholPct <= 50 ? ' ✓' : ' ✗'}
                  </div>
                  {calc.actualRatio && (
                    <>
                      <div className="text-gray-600">Effective ratio</div>
                      <div className="font-mono font-semibold">1:{fmt(calc.actualRatio, 1)}</div>
                    </>
                  )}
                </div>
                {alcPolyWarning && calc.actualAlcoholPct <= 50 && (
                  <p className="text-xs text-amber-700 mt-2">⚠ Above 40% — polysaccharides may precipitate. Lower target to 35% or below for best results.</p>
                )}
              </div>
            </section>
          ) : tincVolNum > 0 && (
            <div className="text-xs text-gray-400 bg-gray-50 rounded-lg p-3">
              {targetNum >= alcNum
                ? `Target alcohol (${targetNum}%) must be less than tincture alcohol (${alcNum}%).`
                : 'Enter a valid target alcohol % to see calculations.'}
            </div>
          )}

          {/* === PROCESS REMINDER === */}
          <section className="border-t border-gray-100 pt-4">
            <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-3">Process Reference</h3>
            <ol className="space-y-2 text-xs text-gray-600 leading-relaxed list-decimal list-inside">
              <li>Weigh your plant material. Tincture at <strong>1:3</strong> (or 1:4 for fluffy material like Reishi), <strong>75% alcohol</strong>. Macerate 2–4 weeks.</li>
              <li>When ready, press out the extract and <strong>measure tincture volume</strong> — enter it above in step 3.</li>
              <li>Enter your target final alcohol % (step 4). Use the constituent data to guide this choice.</li>
              <li>Read off decoction volume and starting water above.</li>
              <li>Decoct the pressed marc in {calc ? `${fmt(calc.startDecoctionVol)} mL` : '(starting decoction volume)'} of water until reduced by half to {calc ? `${fmt(calc.decoctionToAdd)} mL` : '(decoction volume)'}.</li>
              <li><strong>Always add the tincture (alcohol) to the decoction (water)</strong> — never the reverse.</li>
              <li>Bottle and store in a cool, dark place.</li>
            </ol>
            <div className="mt-3 p-2.5 bg-blue-50 border border-blue-100 rounded text-xs text-blue-800">
              <strong>Safe range:</strong> Above 25% prevents spoilage. Above 40%, polysaccharides begin to precipitate. Above 50%, tannins and other polyphenols may precipitate. Typical target: 25–40%.
            </div>
          </section>

        </div>
      </div>
    </div>
  );
}
