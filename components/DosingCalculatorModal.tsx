'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import { TrashIcon, XMarkIcon } from '@heroicons/react/24/outline';
import { MM_MATERIA_MEDICA } from '@/lib/mm-materia-medica';
import { DH_MATERIA_MEDICA } from '@/lib/dh-materia-medica';
import { TE_MATERIA_MEDICA } from '@/lib/te-materia-medica';
import { supabase } from '@/lib/supabase';

interface HerbOption {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
}

interface HerbAction {
  actionName: string;
  systemName: string;
}

interface HerbEntry {
  key: string;
  herbId: number;
  herbName: string;
  latinName: string;
  plantPart: string | null;
  mmMin: number | null;
  mmMax: number | null;
  dhMin: number | null;
  dhMax: number | null;
  teMin: number | null;
  teMax: number | null;
  customMin: number;
  customMax: number;
  selectedDrops: number;
  hasSourceData: boolean;
  actions: HerbAction[] | null; // null = loading
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
  initialHerbs?: HerbOption[];
}

function parseMmDropRange(text: string): { min: number; max: number } | null {
  const ranges: Array<{ min: number; max: number }> = [];
  for (const m of text.matchAll(/(\d+)\s*[-–]\s*(\d+)\s*drops?/gi)) {
    ranges.push({ min: parseInt(m[1]), max: parseInt(m[2]) });
  }
  for (const m of text.matchAll(/(\d+)\s+to\s+(\d+)\s+drops?/gi)) {
    ranges.push({ min: parseInt(m[1]), max: parseInt(m[2]) });
  }
  if (ranges.length > 0) {
    return {
      min: Math.min(...ranges.map((r) => r.min)),
      max: Math.max(...ranges.map((r) => r.max)),
    };
  }
  const single = text.match(/(\d+)\s*drops?/i);
  if (single) {
    const v = parseInt(single[1]);
    return { min: v, max: v };
  }
  return null;
}

function gcd(a: number, b: number): number {
  return b === 0 ? a : gcd(b, a % b);
}

function computePartsArray(drops: number[]): number[] {
  if (drops.length === 0) return [];
  const g = drops.reduce((acc, v) => gcd(acc, v));
  return drops.map((d) => Math.round(d / g));
}

const BOTTLE_SIZES = [30, 60, 120, 240];

export function DosingCalculatorModal({ isOpen, onClose, initialHerbs }: Props) {
  const [allHerbs, setAllHerbs] = useState<HerbOption[]>([]);
  const [herbEntries, setHerbEntries] = useState<HerbEntry[]>([]);
  const [search, setSearch] = useState('');
  const [showDropdown, setShowDropdown] = useState(false);
  const [highlightedIndex, setHighlightedIndex] = useState(-1);
  const [bottleVolumeMl, setBottleVolumeMl] = useState(60);
  const [customVolume, setCustomVolume] = useState('');
  const searchRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!isOpen) return;
    supabase
      .from('herbs')
      .select('id, common_name, latin_name, plant_part')
      .order('common_name')
      .then(({ data }) => setAllHerbs((data ?? []) as HerbOption[]));
  }, [isOpen]);

  useEffect(() => {
    if (!isOpen || !initialHerbs?.length) return;
    setHerbEntries([]);
    initialHerbs.forEach((herb) => addHerb(herb));
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isOpen, initialHerbs]);

  const filteredHerbs = useMemo(() => {
    if (!search.trim()) return [];
    const term = search.toLowerCase();
    return allHerbs
      .filter(
        (h) =>
          h.common_name.toLowerCase().includes(term) ||
          h.latin_name.toLowerCase().includes(term),
      )
      .slice(0, 10);
  }, [allHerbs, search]);

  useEffect(() => { setHighlightedIndex(-1); }, [filteredHerbs]);

  useEffect(() => {
    if (highlightedIndex < 0 || !dropdownRef.current) return;
    const el = dropdownRef.current.children[highlightedIndex] as HTMLElement;
    el?.scrollIntoView({ block: 'nearest' });
  }, [highlightedIndex]);

  const addHerb = async (herb: HerbOption) => {
    const mmText = MM_MATERIA_MEDICA[herb.id];
    const mmRange = mmText ? parseMmDropRange(mmText) : null;
    const dhEntry = DH_MATERIA_MEDICA[herb.id] ?? null;
    const teEntry = TE_MATERIA_MEDICA[herb.id] ?? null;
    const entryKey = `${herb.id}-${Date.now()}`;

    // Combined range across all sources
    const allMins = [mmRange?.min, dhEntry?.min, teEntry?.min].filter((v): v is number => v != null);
    const allMaxs = [mmRange?.max, dhEntry?.max, teEntry?.max].filter((v): v is number => v != null);
    const hasSourceData = allMins.length > 0;
    const combinedMin = hasSourceData ? Math.min(...allMins) : 5;
    const combinedMax = hasSourceData ? Math.max(...allMaxs) : 60;

    const entry: HerbEntry = {
      key: entryKey,
      herbId: herb.id,
      herbName: herb.common_name,
      latinName: herb.latin_name,
      plantPart: herb.plant_part,
      mmMin: mmRange?.min ?? null,
      mmMax: mmRange?.max ?? null,
      dhMin: dhEntry?.min ?? null,
      dhMax: dhEntry?.max ?? null,
      teMin: teEntry?.min ?? null,
      teMax: teEntry?.max ?? null,
      customMin: combinedMin,
      customMax: combinedMax,
      selectedDrops: Math.round((combinedMin + combinedMax) / 2),
      hasSourceData,
      actions: null,
    };

    setHerbEntries((prev) => [...prev, entry]);
    setSearch('');
    setShowDropdown(false);

    const { data } = await supabase
      .from('herb_primary_actions')
      .select('primary_actions(name), body_systems(name)')
      .eq('herb_id', herb.id);

    const actions: HerbAction[] = (data ?? [])
      .map((row: any) => ({
        actionName: row.primary_actions?.name ?? '',
        systemName: row.body_systems?.name ?? 'General',
      }))
      .filter((a: HerbAction) => a.actionName);

    actions.sort(
      (a, b) =>
        a.systemName.localeCompare(b.systemName) ||
        a.actionName.localeCompare(b.actionName),
    );

    setHerbEntries((prev) =>
      prev.map((e) => (e.key === entryKey ? { ...e, actions } : e)),
    );
  };

  const removeHerb = (key: string) => {
    setHerbEntries((prev) => prev.filter((e) => e.key !== key));
  };

  const updateDrops = (key: string, drops: number) => {
    setHerbEntries((prev) =>
      prev.map((e) => (e.key === key ? { ...e, selectedDrops: drops } : e)),
    );
  };

  const updateCustomBound = (
    key: string,
    field: 'customMin' | 'customMax',
    value: number,
  ) => {
    setHerbEntries((prev) =>
      prev.map((e) => {
        if (e.key !== key) return e;
        const updated = { ...e, [field]: value };
        const lo = field === 'customMin' ? value : e.customMin;
        const hi = field === 'customMax' ? value : e.customMax;
        updated.selectedDrops = Math.min(Math.max(updated.selectedDrops, lo), hi);
        return updated;
      }),
    );
  };

  // ── Calculations ──────────────────────────────────────────────
  const totalDrops = herbEntries.reduce((s, e) => s + e.selectedDrops, 0);
  const droppersPerDose = totalDrops > 0 ? totalDrops / 30 : 0;
  const mlPerDose = droppersPerDose;
  const dosesInBottle = mlPerDose > 0 ? bottleVolumeMl / mlPerDose : 0;
  const parts = computePartsArray(herbEntries.map((e) => e.selectedDrops));
  const totalParts = parts.reduce((s, p) => s + p, 0);
  const mlPerPart = totalParts > 0 ? bottleVolumeMl / totalParts : 0;

  if (!isOpen) return null;

  const hasEntries = herbEntries.length > 0;

  // ── Summary panel (reused in mobile + desktop right column) ──
  const summaryPanel = hasEntries ? (
    <div className="space-y-4">
      {/* Bottle volume */}
      <div>
        <div className="text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
          Bottle Volume
        </div>
        <div className="flex flex-wrap gap-2 items-center">
          {BOTTLE_SIZES.map((size) => (
            <button
              key={size}
              onClick={() => { setBottleVolumeMl(size); setCustomVolume(''); }}
              className={`px-3 py-1.5 rounded-lg text-sm font-medium border transition-all ${
                bottleVolumeMl === size && customVolume === ''
                  ? 'bg-green-600 text-white border-green-600'
                  : 'bg-white dark:bg-gray-700 text-green-800 dark:text-green-200 border-green-300 dark:border-gray-600 hover:border-green-500'
              }`}
            >
              {size} mL
            </button>
          ))}
          <div className="flex items-center gap-1.5">
            <input
              type="number"
              min={1}
              placeholder="Custom"
              value={customVolume}
              onChange={(e) => {
                setCustomVolume(e.target.value);
                const v = parseInt(e.target.value);
                if (!isNaN(v) && v > 0) setBottleVolumeMl(v);
              }}
              className="w-20 border border-green-300 dark:border-gray-600 rounded-lg px-2 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-700 dark:text-white"
            />
            <span className="text-sm text-green-600 dark:text-green-400">mL</span>
          </div>
        </div>
      </div>

      {/* Stat boxes */}
      <div className="grid grid-cols-3 gap-2 text-center">
        <div className="bg-white dark:bg-gray-800 rounded-xl border border-green-100 dark:border-gray-700 p-3">
          <div className="text-2xl font-bold text-green-800 dark:text-green-200">{totalDrops}</div>
          <div className="text-xs text-green-500 mt-0.5">drops / dose</div>
        </div>
        <div className="bg-white dark:bg-gray-800 rounded-xl border border-green-100 dark:border-gray-700 p-3">
          <div className="text-2xl font-bold text-green-800 dark:text-green-200">{droppersPerDose.toFixed(1)}</div>
          <div className="text-xs text-green-500 mt-0.5">droppers / dose</div>
        </div>
        <div className="bg-white dark:bg-gray-800 rounded-xl border border-green-100 dark:border-gray-700 p-3">
          <div className="text-2xl font-bold text-green-800 dark:text-green-200">{Math.round(dosesInBottle)}</div>
          <div className="text-xs text-green-500 mt-0.5">doses in bottle</div>
        </div>
      </div>

      {/* Formula breakdown */}
      <div className="bg-white dark:bg-gray-800 rounded-xl border border-green-100 dark:border-gray-700 p-4">
        <div className="flex items-baseline justify-between mb-3">
          <span className="text-sm font-semibold text-green-800 dark:text-green-200">
            Formula breakdown
          </span>
          <span className="text-xs text-green-500">
            {totalParts} parts · {mlPerPart.toFixed(1)} mL/part
          </span>
        </div>
        <div className="space-y-2">
          {herbEntries.map((entry, idx) => {
            const entryParts = parts[idx];
            const mlInBottle = entryParts * mlPerPart;
            return (
              <div key={entry.key} className="flex items-center justify-between text-sm">
                <span className="text-green-700 dark:text-green-300 font-medium truncate mr-2">
                  {entry.herbName}
                </span>
                <div className="flex items-center gap-3 shrink-0">
                  <span className="text-green-400 text-xs">{entry.selectedDrops} drops</span>
                  <span className="font-semibold text-green-800 dark:text-green-200 w-10 text-right">
                    {entryParts}<span className="font-normal text-green-400 text-xs ml-0.5">pt</span>
                  </span>
                  <span className="font-semibold text-green-800 dark:text-green-200 w-14 text-right">
                    {mlInBottle.toFixed(1)}<span className="font-normal text-green-400 text-xs ml-0.5">mL</span>
                  </span>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      <p className="text-xs text-green-400 dark:text-green-600 text-center leading-relaxed">
        1 dropper = 30 drops ≈ 1 mL
        <br />
        {droppersPerDose.toFixed(1)} droppers = {mlPerDose.toFixed(1)} mL per dose
      </p>
    </div>
  ) : null;

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center p-2 sm:p-6 overflow-y-auto">
      <div className="absolute inset-0 bg-black/50" onClick={onClose} aria-hidden="true" />

      {/* Modal: fixed height on desktop for independent column scrolling */}
      <div className="relative bg-white dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl my-4 flex flex-col md:max-h-[88vh]">

        {/* Header */}
        <div className="shrink-0 flex items-center justify-between px-6 py-4 border-b border-green-100 dark:border-gray-700 bg-gradient-to-r from-green-50 to-emerald-50 dark:from-gray-800 dark:to-gray-800 rounded-t-2xl">
          <div>
            <h2 className="text-xl font-bold text-green-900 dark:text-green-300">Dosing Calculator</h2>
            <p className="text-xs text-green-600 dark:text-green-400 mt-0.5">
              Build a tincture formula from effective drop doses per herb
            </p>
          </div>
          <button onClick={onClose} className="text-green-400 hover:text-green-700 transition-colors p-1">
            <XMarkIcon className="w-6 h-6" />
          </button>
        </div>

        {/* Body: two columns on desktop, single column on mobile */}
        <div className="flex-1 md:min-h-0 md:overflow-hidden md:flex md:flex-row">

          {/* Left column: herb search + entries */}
          <div className="flex-1 md:overflow-y-auto p-6 space-y-5 min-w-0">

            {/* Add herb search */}
            <div>
              <label className="block text-sm font-semibold text-green-800 dark:text-green-300 mb-2">
                Add Herb
              </label>
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
                    if (e.key === 'ArrowDown') {
                      e.preventDefault();
                      setHighlightedIndex((i) => Math.min(i + 1, filteredHerbs.length - 1));
                    } else if (e.key === 'ArrowUp') {
                      e.preventDefault();
                      setHighlightedIndex((i) => Math.max(i - 1, 0));
                    } else if (e.key === 'Enter' && highlightedIndex >= 0) {
                      e.preventDefault();
                      addHerb(filteredHerbs[highlightedIndex]);
                    } else if (e.key === 'Escape') {
                      setShowDropdown(false);
                    }
                  }}
                  placeholder="Search by common or Latin name…"
                  className="w-full border border-green-300 rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-400 dark:bg-gray-800 dark:border-gray-600 dark:text-white"
                />
                {showDropdown && filteredHerbs.length > 0 && (
                  <div ref={dropdownRef} className="absolute top-full mt-1 left-0 right-0 bg-white dark:bg-gray-800 border border-green-200 dark:border-gray-600 rounded-lg shadow-lg z-20 max-h-52 overflow-y-auto">
                    {filteredHerbs.map((h, idx) => {
                      const mmRange = MM_MATERIA_MEDICA[h.id] ? parseMmDropRange(MM_MATERIA_MEDICA[h.id]) : null;
                      const dhEntry = DH_MATERIA_MEDICA[h.id] ?? null;
                      const teEntry = TE_MATERIA_MEDICA[h.id] ?? null;
                      const allMins = [mmRange?.min, dhEntry?.min, teEntry?.min].filter((v): v is number => v != null);
                      const allMaxs = [mmRange?.max, dhEntry?.max, teEntry?.max].filter((v): v is number => v != null);
                      const hasAny = allMins.length > 0;
                      return (
                        <button
                          key={h.id}
                          onMouseDown={() => addHerb(h)}
                          onMouseEnter={() => setHighlightedIndex(idx)}
                          className={`w-full text-left px-4 py-2.5 transition-all flex items-center justify-between gap-2 ${idx === highlightedIndex ? 'bg-green-50 dark:bg-gray-700' : 'hover:bg-green-50 dark:hover:bg-gray-700'}`}
                        >
                          <span>
                            <span className="font-medium text-green-900 dark:text-green-200">
                              {h.common_name}
                            </span>
                            {h.plant_part && (
                              <span className="text-xs text-green-600 dark:text-green-400 ml-1">
                                ({h.plant_part})
                              </span>
                            )}
                            <span className="text-xs text-green-500 ml-2 italic">{h.latin_name}</span>
                          </span>
                          {hasAny ? (
                            <span className="text-xs text-teal-600 dark:text-teal-400 font-medium shrink-0">
                              {Math.min(...allMins)}–{Math.max(...allMaxs)} drops
                            </span>
                          ) : (
                            <span className="text-xs text-gray-400 shrink-0">no data</span>
                          )}
                        </button>
                      );
                    })}
                  </div>
                )}
              </div>
            </div>

            {/* Herb entries */}
            {!hasEntries ? (
              <div className="text-center py-10 text-green-300 border-2 border-dashed border-green-100 rounded-xl">
                <p className="text-sm">Search for an herb above to begin</p>
              </div>
            ) : (
              <div className="space-y-3">
                {herbEntries.map((entry, idx) => {
                  const lo = entry.customMin;
                  const hi = entry.customMax;
                  const entryParts = parts[idx];
                  const mlInBottle = entryParts * mlPerPart;

                  // Group actions by body system
                  const actionsBySystem = (entry.actions ?? []).reduce(
                    (acc, { actionName, systemName }) => {
                      if (!acc[systemName]) acc[systemName] = [];
                      acc[systemName].push(actionName);
                      return acc;
                    },
                    {} as Record<string, string[]>,
                  );

                  // Actions JSX — placed right (desktop) or inline (mobile)
                  const actionsJSX =
                    entry.actions === null ? (
                      <p className="text-xs text-green-300 italic">Loading actions…</p>
                    ) : Object.keys(actionsBySystem).length > 0 ? (
                      <div className="space-y-0.5">
                        {Object.entries(actionsBySystem).map(([system, systemActions]) => (
                          <div key={system} className="text-xs leading-snug">
                            <span className="font-semibold text-green-700 dark:text-green-400">
                              {system}:
                            </span>{' '}
                            <span className="text-green-500">{systemActions.join(', ')}</span>
                          </div>
                        ))}
                      </div>
                    ) : null;

                  return (
                    <div
                      key={entry.key}
                      className="border border-green-100 dark:border-gray-700 rounded-xl p-4 bg-green-50/30 dark:bg-gray-800/30"
                    >
                      {/* Card: left controls + right actions on desktop */}
                      <div className="md:flex md:gap-4 md:items-start">

                        {/* Left: name, slider, results */}
                        <div className="md:flex-1 min-w-0">

                          {/* Title row */}
                          <div className="flex items-start justify-between mb-1 gap-2">
                            <div className="min-w-0">
                              <div className="font-semibold text-green-900 dark:text-green-200 leading-snug">
                                {entry.herbName}
                                {entry.plantPart && (
                                  <span className="font-normal text-green-500 dark:text-green-400 ml-1 text-sm">
                                    ({entry.plantPart})
                                  </span>
                                )}
                              </div>
                              <div className="text-xs text-green-500 italic">{entry.latinName}</div>
                            </div>
                            <div className="flex items-center gap-1.5 shrink-0">
                              {entry.mmMin != null && (
                                <span className="group relative text-xs bg-teal-100 text-teal-700 dark:bg-teal-900/40 dark:text-teal-300 px-2 py-0.5 rounded-full font-medium cursor-default">
                                  MM
                                  <span className="pointer-events-none absolute bottom-full left-1/2 -translate-x-1/2 mb-1.5 hidden group-hover:block whitespace-nowrap rounded bg-gray-800 px-2 py-1 text-xs text-white shadow-lg z-50">
                                    {entry.mmMin}–{entry.mmMax} drops
                                  </span>
                                </span>
                              )}
                              {entry.dhMin != null && (
                                <span className="group relative text-xs bg-violet-100 text-violet-700 dark:bg-violet-900/40 dark:text-violet-300 px-2 py-0.5 rounded-full font-medium cursor-default">
                                  DH
                                  <span className="pointer-events-none absolute bottom-full left-1/2 -translate-x-1/2 mb-1.5 hidden group-hover:block whitespace-nowrap rounded bg-gray-800 px-2 py-1 text-xs text-white shadow-lg z-50">
                                    {entry.dhMin}–{entry.dhMax} drops
                                  </span>
                                </span>
                              )}
                              {entry.teMin != null && (
                                <span className="group relative text-xs bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300 px-2 py-0.5 rounded-full font-medium cursor-default">
                                  TE
                                  <span className="pointer-events-none absolute bottom-full left-1/2 -translate-x-1/2 mb-1.5 hidden group-hover:block whitespace-nowrap rounded bg-gray-800 px-2 py-1 text-xs text-white shadow-lg z-50">
                                    {entry.teMin}–{entry.teMax} drops
                                  </span>
                                </span>
                              )}
                              {!entry.hasSourceData && (
                                <span className="text-xs bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300 px-2 py-0.5 rounded-full font-medium">
                                  custom range
                                </span>
                              )}
                              <button
                                onClick={() => removeHerb(entry.key)}
                                className="text-red-300 hover:text-red-500 transition-colors ml-0.5"
                              >
                                <TrashIcon className="w-4 h-4" />
                              </button>
                            </div>
                          </div>

                          {/* Mobile-only: actions inline below title */}
                          {actionsJSX && (
                            <div className="md:hidden mb-3">{actionsJSX}</div>
                          )}

                          {/* Custom range inputs (no source data) */}
                          {!entry.hasSourceData && (
                            <div className="flex gap-3 mb-3">
                              <label className="flex-1">
                                <span className="text-xs text-green-700 dark:text-green-400 font-medium">Min drops</span>
                                <input
                                  type="number"
                                  min={1}
                                  value={entry.customMin}
                                  onChange={(e) =>
                                    updateCustomBound(
                                      entry.key,
                                      'customMin',
                                      Math.max(1, parseInt(e.target.value) || 1),
                                    )
                                  }
                                  className="w-full mt-1 border border-green-200 dark:border-gray-600 rounded px-2 py-1 text-sm dark:bg-gray-700 dark:text-white"
                                />
                              </label>
                              <label className="flex-1">
                                <span className="text-xs text-green-700 dark:text-green-400 font-medium">Max drops</span>
                                <input
                                  type="number"
                                  min={entry.customMin + 1}
                                  value={entry.customMax}
                                  onChange={(e) =>
                                    updateCustomBound(
                                      entry.key,
                                      'customMax',
                                      Math.max(
                                        entry.customMin + 1,
                                        parseInt(e.target.value) || entry.customMin + 1,
                                      ),
                                    )
                                  }
                                  className="w-full mt-1 border border-green-200 dark:border-gray-600 rounded px-2 py-1 text-sm dark:bg-gray-700 dark:text-white"
                                />
                              </label>
                            </div>
                          )}

                          {/* Slider */}
                          <div className="space-y-1">
                            <div className="flex justify-between items-center text-xs">
                              <span className="text-green-400">{lo}</span>
                              <span className="font-bold text-green-800 dark:text-green-200 text-sm">
                                {entry.selectedDrops} drops
                              </span>
                              <span className="text-green-400">{hi}</span>
                            </div>
                            <input
                              type="range"
                              min={lo}
                              max={hi}
                              value={entry.selectedDrops}
                              onChange={(e) => updateDrops(entry.key, parseInt(e.target.value))}
                              className="w-full accent-green-600"
                            />
                          </div>

                          {/* Per-herb inline result */}
                          {totalDrops > 0 && (
                            <div className="mt-2 flex gap-3 text-xs text-green-600 dark:text-green-400">
                              <span>
                                <span className="font-semibold text-green-900 dark:text-green-200">
                                  {entryParts}
                                </span>{' '}
                                {entryParts === 1 ? 'part' : 'parts'}
                              </span>
                              <span className="text-green-300">·</span>
                              <span>
                                <span className="font-semibold text-green-900 dark:text-green-200">
                                  {mlInBottle.toFixed(1)} mL
                                </span>{' '}
                                in bottle
                              </span>
                              <span className="text-green-300">·</span>
                              <span>
                                {((entry.selectedDrops / totalDrops) * 100).toFixed(0)}% of formula
                              </span>
                            </div>
                          )}
                        </div>{/* end left column */}

                        {/* Right column: actions (desktop only) */}
                        {actionsJSX && (
                          <div className="hidden md:block w-44 xl:w-52 shrink-0 border-l border-green-100 dark:border-gray-700 pl-4 pt-0.5">
                            {actionsJSX}
                          </div>
                        )}

                      </div>{/* end md:flex */}
                    </div>
                  );
                })}
              </div>
            )}

            {/* Mobile-only: summary below herbs */}
            {hasEntries && (
              <div className="md:hidden border-t border-green-100 dark:border-gray-700 pt-5">
                {summaryPanel}
              </div>
            )}
          </div>{/* end left column */}

          {/* Right column: summary (desktop only) */}
          {hasEntries && (
            <div className="hidden md:flex flex-col w-80 xl:w-96 shrink-0 border-l border-green-100 dark:border-gray-700 md:overflow-y-auto p-6 bg-green-50/20 dark:bg-gray-800/20 space-y-4">
              {summaryPanel}
            </div>
          )}
        </div>{/* end body */}
      </div>
    </div>
  );
}
