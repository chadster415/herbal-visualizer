'use client';

import { useState, useEffect, useRef, useMemo } from 'react';
import { supabase } from '@/lib/supabase';
import { EnergeticEmojis } from './EnergeticEmojis';
import type { TemperatureEnergetic, MoistureEnergetic, ToneEnergetic, TasteEnergetic, SunRequirement, WaterNeed, SoilFertility } from '@/types/database';

// ─── Types ────────────────────────────────────────────────────────────────────

interface BodySystem { id: number; name: string; }
interface Action { id: number; name: string; }

type MenstruumType = 'water' | 'glycerin' | 'vinegar' | 'low_alcohol' | 'high_alcohol' | 'powder' | 'oil';

interface HerbMenstruumData {
  water_effective: boolean;
  glycerin_pct: number | null;
  vinegar_pct: number | null;
  alcohol_pct_min: number | null;
  alcohol_pct_max: number | null;
  powder_effective: boolean;
  oil_effective: boolean;
}

interface HerbRow {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
  pinyin_name: string | null;
  temperature: TemperatureEnergetic;
  moisture: MoistureEnergetic;
  tone: ToneEnergetic;
  taste: TasteEnergetic | null;
  temperature_inferred: boolean;
  moisture_inferred: boolean;
  tone_inferred: boolean;
  taste_inferred: boolean;
  sun_requirement: SunRequirement | null;
  water_need: WaterNeed | null;
  soil_fertility: SoilFertility | null;
  action_ids: Set<number>;
  system_ids: Set<number>;
  menstruum: HerbMenstruumData | null;
}

export interface HerbFilterPanelProps {
  isOpen: boolean;
  onClose: () => void;
  onHerbSelect: (herbId: number) => void;
  onSystemSelect?: (systemId: number) => void;
}

// ─── Static filter option definitions ────────────────────────────────────────

const TEMP_OPTIONS: { value: TemperatureEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'warming',  label: 'Warming',  emoji: '🔥', on: 'bg-amber-200 border-amber-400 text-amber-900', off: 'bg-amber-50 border-amber-200 text-amber-700 hover:bg-amber-100' },
  { value: 'cooling',  label: 'Cooling',  emoji: '❄️', on: 'bg-sky-200 border-sky-400 text-sky-900',       off: 'bg-sky-50 border-sky-200 text-sky-700 hover:bg-sky-100' },
  { value: 'neutral',  label: 'Neutral',  emoji: '',   on: 'bg-gray-200 border-gray-400 text-gray-900',    off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

const MOISTURE_OPTIONS: { value: MoistureEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'moistening', label: 'Moistening', emoji: '💧', on: 'bg-blue-200 border-blue-400 text-blue-900',   off: 'bg-blue-50 border-blue-200 text-blue-700 hover:bg-blue-100' },
  { value: 'drying',     label: 'Drying',     emoji: '🌵', on: 'bg-orange-200 border-orange-400 text-orange-900', off: 'bg-orange-50 border-orange-200 text-orange-700 hover:bg-orange-100' },
  { value: 'neutral',    label: 'Neutral',    emoji: '',   on: 'bg-gray-200 border-gray-400 text-gray-900',   off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

const TONE_OPTIONS: { value: ToneEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'toning',   label: 'Toning',   emoji: '⚡', on: 'bg-purple-200 border-purple-400 text-purple-900', off: 'bg-purple-50 border-purple-200 text-purple-700 hover:bg-purple-100' },
  { value: 'relaxing', label: 'Relaxing', emoji: '🌊', on: 'bg-teal-200 border-teal-400 text-teal-900',       off: 'bg-teal-50 border-teal-200 text-teal-700 hover:bg-teal-100' },
  { value: 'neutral',  label: 'Neutral',  emoji: '',   on: 'bg-gray-200 border-gray-400 text-gray-900',       off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

const TASTE_OPTIONS: { value: TasteEnergetic; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'sweet',   label: 'Sweet',   emoji: '🍯', on: 'bg-yellow-200 border-yellow-400 text-yellow-900', off: 'bg-yellow-50 border-yellow-200 text-yellow-700 hover:bg-yellow-100' },
  { value: 'bitter',  label: 'Bitter',  emoji: '☕', on: 'bg-stone-200 border-stone-400 text-stone-900',   off: 'bg-stone-50 border-stone-200 text-stone-700 hover:bg-stone-100' },
  { value: 'pungent', label: 'Pungent', emoji: '🌶️', on: 'bg-red-200 border-red-400 text-red-900',         off: 'bg-red-50 border-red-200 text-red-700 hover:bg-red-100' },
  { value: 'salty',   label: 'Salty',   emoji: '🧂', on: 'bg-cyan-200 border-cyan-400 text-cyan-900',       off: 'bg-cyan-50 border-cyan-200 text-cyan-700 hover:bg-cyan-100' },
  { value: 'sour',    label: 'Sour',    emoji: '🍋', on: 'bg-lime-200 border-lime-400 text-lime-900',        off: 'bg-lime-50 border-lime-200 text-lime-700 hover:bg-lime-100' },
];

const MENSTRUUM_OPTIONS: { value: MenstruumType; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'water',        label: 'Water',            emoji: '💧', on: 'bg-blue-200 border-blue-400 text-blue-900',        off: 'bg-blue-50 border-blue-200 text-blue-700 hover:bg-blue-100' },
  { value: 'glycerin',     label: 'Glycerin',         emoji: '🍬', on: 'bg-pink-200 border-pink-400 text-pink-900',        off: 'bg-pink-50 border-pink-200 text-pink-700 hover:bg-pink-100' },
  { value: 'vinegar',      label: 'Vinegar',          emoji: '🍶', on: 'bg-amber-200 border-amber-400 text-amber-900',     off: 'bg-amber-50 border-amber-200 text-amber-700 hover:bg-amber-100' },
  { value: 'low_alcohol',  label: 'Low Alcohol ≤45%', emoji: '🍷', on: 'bg-emerald-200 border-emerald-400 text-emerald-900', off: 'bg-emerald-50 border-emerald-200 text-emerald-700 hover:bg-emerald-100' },
  { value: 'high_alcohol', label: 'High Alcohol ≥60%', emoji: '⚗️', on: 'bg-indigo-200 border-indigo-400 text-indigo-900', off: 'bg-indigo-50 border-indigo-200 text-indigo-700 hover:bg-indigo-100' },
  { value: 'powder',       label: 'Powder',           emoji: '💊', on: 'bg-yellow-200 border-yellow-400 text-yellow-900',  off: 'bg-yellow-50 border-yellow-200 text-yellow-700 hover:bg-yellow-100' },
  { value: 'oil',          label: 'Oil',              emoji: '🫙', on: 'bg-orange-200 border-orange-400 text-orange-900',  off: 'bg-orange-50 border-orange-200 text-orange-700 hover:bg-orange-100' },
];

const SUN_OPTIONS: { value: SunRequirement; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'full_sun',                   label: 'Full Sun',          emoji: '☀️',  on: 'bg-yellow-200 border-yellow-400 text-yellow-900',  off: 'bg-yellow-50 border-yellow-200 text-yellow-700 hover:bg-yellow-100' },
  { value: 'full_sun_to_partial_shade',  label: 'Full Sun / Part Shade', emoji: '🌤️', on: 'bg-amber-100 border-amber-300 text-amber-800',  off: 'bg-amber-50 border-amber-200 text-amber-700 hover:bg-amber-100' },
  { value: 'partial_shade',             label: 'Part Shade',        emoji: '⛅', on: 'bg-zinc-200 border-zinc-400 text-zinc-900',       off: 'bg-zinc-100 border-zinc-300 text-zinc-700 hover:bg-zinc-200' },
  { value: 'partial_shade_to_shade',    label: 'Part Shade / Shade', emoji: '🌥️', on: 'bg-slate-200 border-slate-400 text-slate-900',    off: 'bg-slate-100 border-slate-300 text-slate-700 hover:bg-slate-200' },
  { value: 'shade',                     label: 'Shade',             emoji: '🌑', on: 'bg-gray-300 border-gray-500 text-gray-900',       off: 'bg-gray-100 border-gray-300 text-gray-600 hover:bg-gray-200' },
];

const WATER_OPTIONS: { value: WaterNeed; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'dry',               label: 'Dry',            emoji: '🌵', on: 'bg-rose-100 border-rose-300 text-rose-800',    off: 'bg-rose-50 border-rose-200 text-rose-700 hover:bg-rose-100' },
  { value: 'dry_to_moderate',   label: 'Dry–Moderate',   emoji: '💧', on: 'bg-sky-100 border-sky-300 text-sky-800',       off: 'bg-sky-50 border-sky-200 text-sky-700 hover:bg-sky-100' },
  { value: 'moderate',          label: 'Moderate',       emoji: '💦', on: 'bg-sky-200 border-sky-400 text-sky-900',       off: 'bg-sky-50 border-sky-200 text-sky-700 hover:bg-sky-100' },
  { value: 'moderate_to_moist', label: 'Mod–Moist',      emoji: '🌊', on: 'bg-blue-200 border-blue-400 text-blue-900',   off: 'bg-blue-50 border-blue-200 text-blue-700 hover:bg-blue-100' },
  { value: 'moist',             label: 'Moist',          emoji: '🏞️', on: 'bg-violet-200 border-violet-400 text-violet-900', off: 'bg-violet-50 border-violet-200 text-violet-700 hover:bg-violet-100' },
];

const SOIL_OPTIONS: { value: SoilFertility; label: string; emoji: string; on: string; off: string }[] = [
  { value: 'low',              label: 'Low',          emoji: '🪨', on: 'bg-stone-200 border-stone-400 text-stone-900',  off: 'bg-stone-100 border-stone-300 text-stone-700 hover:bg-stone-200' },
  { value: 'low_to_moderate',  label: 'Low–Moderate', emoji: '🌱', on: 'bg-lime-100 border-lime-300 text-lime-800',     off: 'bg-lime-50 border-lime-200 text-lime-700 hover:bg-lime-100' },
  { value: 'moderate',         label: 'Moderate',     emoji: '🌿', on: 'bg-lime-200 border-lime-400 text-lime-900',     off: 'bg-lime-50 border-lime-200 text-lime-700 hover:bg-lime-100' },
  { value: 'moderate_to_rich', label: 'Mod–Rich',     emoji: '🌾', on: 'bg-green-200 border-green-400 text-green-900', off: 'bg-green-50 border-green-200 text-green-700 hover:bg-green-100' },
  { value: 'rich',             label: 'Rich',         emoji: '🍀', on: 'bg-emerald-200 border-emerald-400 text-emerald-900', off: 'bg-emerald-50 border-emerald-200 text-emerald-700 hover:bg-emerald-100' },
];

// ─── Helpers ──────────────────────────────────────────────────────────────────

function toggle<T>(set: Set<T>, val: T): Set<T> {
  const next = new Set(set);
  next.has(val) ? next.delete(val) : next.add(val);
  return next;
}

function cardBg(temp: TemperatureEnergetic) {
  if (temp === 'warming') return 'bg-amber-50 border-amber-200 hover:bg-amber-100';
  if (temp === 'cooling') return 'bg-sky-50 border-sky-200 hover:bg-sky-100';
  return 'bg-gray-50 border-gray-200 hover:bg-gray-100';
}

function checkPaneScroll(
  el: HTMLDivElement | null,
  setter: (s: { up: boolean; down: boolean }) => void,
) {
  if (!el) return;
  setter({
    up: el.scrollTop > 4,
    down: el.scrollTop + el.clientHeight < el.scrollHeight - 4,
  });
}

// ─── Scroll indicator ─────────────────────────────────────────────────────────

function ScrollArrow({ direction, visible }: { direction: 'up' | 'down'; visible: boolean }) {
  const isUp = direction === 'up';
  return (
    <div
      className={`absolute ${isUp ? 'top-0' : 'bottom-0'} left-0 right-0 h-10 pointer-events-none z-10 flex ${isUp ? 'items-start pt-1.5' : 'items-end pb-1.5'} justify-center transition-opacity duration-200 ${visible ? 'opacity-100' : 'opacity-0'} ${isUp ? 'bg-gradient-to-b' : 'bg-gradient-to-t'} from-white/90 via-white/60 to-transparent`}
    >
      <svg
        className="w-4 h-4 text-gray-400 drop-shadow"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d={isUp ? 'M5 15l7-7 7 7' : 'M19 9l-7 7-7-7'}
        />
      </svg>
    </div>
  );
}

// ─── Section header with chevron ──────────────────────────────────────────────

function SectionHeader({ label, open, onToggle }: { label: string; open: boolean; onToggle: () => void }) {
  return (
    <button
      className="w-full flex items-center justify-between mb-2 group"
      onClick={onToggle}
    >
      <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest">{label}</p>
      <svg
        className={`w-3.5 h-3.5 text-gray-300 group-hover:text-gray-500 transition-transform duration-150 ${open ? '' : '-rotate-90'}`}
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
      >
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
      </svg>
    </button>
  );
}

// ─── Component ────────────────────────────────────────────────────────────────

const DEFAULT_SECTIONS = {
  temperature: true,
  moisture: true,
  tone: true,
  taste: true,
  bodySystem: true,
  action: true,
  menstruum: true,
  sun: true,
  water: true,
  soilFertility: true,
};

export function HerbFilterPanel({ isOpen, onClose, onHerbSelect, onSystemSelect }: HerbFilterPanelProps) {
  const [herbs, setHerbs] = useState<HerbRow[]>([]);
  const [bodySystems, setBodySystems] = useState<BodySystem[]>([]);
  const [actions, setActions] = useState<Action[]>([]);
  const [loading, setLoading] = useState(true);

  const [tempFilter, setTempFilter]             = useState<Set<TemperatureEnergetic>>(new Set());
  const [moistureFilter, setMoistureFilter]     = useState<Set<MoistureEnergetic>>(new Set());
  const [toneFilter, setToneFilter]             = useState<Set<ToneEnergetic>>(new Set());
  const [tasteFilter, setTasteFilter]           = useState<Set<TasteEnergetic>>(new Set());
  const [systemFilter, setSystemFilter]         = useState<Set<number>>(new Set());
  const [actionFilter, setActionFilter]         = useState<Set<number>>(new Set());
  const [menstruumFilter, setMenstruumFilter]   = useState<Set<MenstruumType>>(new Set());
  const [sunFilter, setSunFilter]               = useState<Set<SunRequirement>>(new Set());
  const [waterFilter, setWaterFilter]           = useState<Set<WaterNeed>>(new Set());
  const [soilFilter, setSoilFilter]             = useState<Set<SoilFertility>>(new Set());

  const [sectionsOpen, setSectionsOpen] = useState(DEFAULT_SECTIONS);

  function toggleSection(key: keyof typeof DEFAULT_SECTIONS) {
    setSectionsOpen((prev) => ({ ...prev, [key]: !prev[key] }));
  }

  const filterPaneRef  = useRef<HTMLDivElement>(null);
  const resultsPaneRef = useRef<HTMLDivElement>(null);
  const [filterScroll, setFilterScroll]   = useState({ up: false, down: false });
  const [resultsScroll, setResultsScroll] = useState({ up: false, down: false });

  const [filterPaneHeight, setFilterPaneHeight] = useState(240);
  const [filterPaneOpen, setFilterPaneOpen] = useState(true);
  const bodyRef         = useRef<HTMLDivElement>(null);
  const isDragging      = useRef(false);
  const dragStartY      = useRef(0);
  const dragStartHeight = useRef(0);

  const loaded = useRef(false);

  useEffect(() => {
    if (isOpen && !loaded.current) {
      loaded.current = true;
      fetchData();
    }
  }, [isOpen]);

  useEffect(() => {
    if (!loading) {
      requestAnimationFrame(() => {
        checkPaneScroll(filterPaneRef.current, setFilterScroll);
        checkPaneScroll(resultsPaneRef.current, setResultsScroll);
      });
    }
  }, [loading]);

  async function fetchData() {
    setLoading(true);
    const [herbsRes, systemsRes, actionsRes] = await Promise.all([
      supabase
        .from('herbs')
        .select('id, common_name, latin_name, plant_part, temperature, moisture, tone, taste, temperature_inferred, moisture_inferred, tone_inferred, taste_inferred, pinyin_name, sun_requirement, water_need, soil_fertility, herb_primary_actions(primary_action_id, body_system_id), herb_menstruum(water_effective, glycerin_pct, vinegar_pct, alcohol_pct_min, alcohol_pct_max, powder_effective, oil_effective)')
        .eq('is_tcm', false)
        .order('common_name'),
      supabase.from('body_systems').select('id, name').order('name'),
      supabase.from('primary_actions').select('id, name').order('name'),
    ]);

    if (herbsRes.data) {
      setHerbs(
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        herbsRes.data.map((h: any) => {
          return {
            id: h.id,
            common_name: h.common_name,
            latin_name: h.latin_name,
            plant_part: h.plant_part ?? null,
            temperature: (h.temperature ?? 'neutral') as TemperatureEnergetic,
            moisture:    (h.moisture    ?? 'neutral') as MoistureEnergetic,
            tone:        (h.tone        ?? 'neutral') as ToneEnergetic,
            taste:       (h.taste ?? null) as TasteEnergetic | null,
            temperature_inferred: h.temperature_inferred ?? false,
            moisture_inferred:    h.moisture_inferred    ?? false,
            tone_inferred:        h.tone_inferred        ?? false,
            taste_inferred:       h.taste_inferred       ?? false,
            sun_requirement: (h.sun_requirement ?? null) as SunRequirement | null,
            water_need:      (h.water_need      ?? null) as WaterNeed | null,
            soil_fertility:  (h.soil_fertility  ?? null) as SoilFertility | null,
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            action_ids: new Set<number>(h.herb_primary_actions.map((a: any) => a.primary_action_id).filter(Boolean)),
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            system_ids: new Set<number>(h.herb_primary_actions.map((a: any) => a.body_system_id).filter(Boolean)),
            pinyin_name: h.pinyin_name ?? null,
            menstruum: (Array.isArray(h.herb_menstruum) ? h.herb_menstruum[0] : h.herb_menstruum) ?? null,
          };
        })
      );
    }
    if (systemsRes.data) setBodySystems(systemsRes.data);
    if (actionsRes.data) setActions(actionsRes.data);
    setLoading(false);
  }

  const hasFilters =
    tempFilter.size + moistureFilter.size + toneFilter.size + tasteFilter.size +
    systemFilter.size + actionFilter.size + menstruumFilter.size +
    sunFilter.size + waterFilter.size + soilFilter.size > 0;

  function matchesMenstruum(m: HerbMenstruumData | null, type: MenstruumType): boolean {
    if (!m) return false;
    if (type === 'water')        return m.water_effective === true;
    if (type === 'glycerin')     return m.glycerin_pct != null;
    if (type === 'vinegar')      return m.vinegar_pct != null;
    if (type === 'low_alcohol')  return m.alcohol_pct_max != null && m.alcohol_pct_max <= 45;
    if (type === 'high_alcohol') return m.alcohol_pct_min != null && m.alcohol_pct_min >= 60;
    if (type === 'powder')       return m.powder_effective === true;
    if (type === 'oil')          return m.oil_effective === true;
    return false;
  }

  const filteredHerbs = useMemo(() => {
    return herbs.filter((h) => {
      if (tempFilter.size > 0       && !tempFilter.has(h.temperature))                              return false;
      if (moistureFilter.size > 0   && !moistureFilter.has(h.moisture))                             return false;
      if (toneFilter.size > 0       && !toneFilter.has(h.tone))                                     return false;
      if (tasteFilter.size > 0      && (!h.taste || !tasteFilter.has(h.taste)))                     return false;
      if (systemFilter.size > 0     && ![...systemFilter].some((id) => h.system_ids.has(id)))       return false;
      if (actionFilter.size > 0     && ![...actionFilter].some((id) => h.action_ids.has(id)))       return false;
      if (menstruumFilter.size > 0  && ![...menstruumFilter].some((t) => matchesMenstruum(h.menstruum, t))) return false;
      if (sunFilter.size > 0        && (!h.sun_requirement || !sunFilter.has(h.sun_requirement)))   return false;
      if (waterFilter.size > 0      && (!h.water_need      || !waterFilter.has(h.water_need)))      return false;
      if (soilFilter.size > 0       && (!h.soil_fertility  || !soilFilter.has(h.soil_fertility)))   return false;
      return true;
    });
  }, [herbs, tempFilter, moistureFilter, toneFilter, tasteFilter, systemFilter, actionFilter, menstruumFilter, sunFilter, waterFilter, soilFilter]);

  useEffect(() => {
    requestAnimationFrame(() => checkPaneScroll(resultsPaneRef.current, setResultsScroll));
  }, [filteredHerbs]);

  const systemMap = useMemo(
    () => new Map(bodySystems.map((s) => [s.id, s.name])),
    [bodySystems]
  );

  const usedActionIds = useMemo(
    () => new Set(herbs.flatMap((h) => [...h.action_ids])),
    [herbs]
  );
  const availableActions = useMemo(
    () => actions.filter((a) => usedActionIds.has(a.id)),
    [actions, usedActionIds]
  );

  function clearAll() {
    setTempFilter(new Set());
    setMoistureFilter(new Set());
    setToneFilter(new Set());
    setTasteFilter(new Set());
    setSystemFilter(new Set());
    setActionFilter(new Set());
    setMenstruumFilter(new Set());
    setSunFilter(new Set());
    setWaterFilter(new Set());
    setSoilFilter(new Set());
  }

  return (
    <>
      {/* Backdrop */}
      {isOpen && (
        <div
          className="fixed inset-0 z-30 bg-black/20"
          onClick={onClose}
        />
      )}

      {/* Slideover */}
      <div
        className={`fixed top-0 right-0 h-full w-full sm:w-[500px] z-40 bg-gray-50 shadow-2xl border-l border-gray-200 flex flex-col transition-transform duration-300 ease-in-out ${
          isOpen ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        {/* Header */}
        <div className="px-5 py-4 border-b border-gray-200 bg-white shrink-0">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-bold text-gray-900">Filter Herbs</h2>
            <div className="flex items-center gap-3">
              {hasFilters && (
                <button
                  onClick={clearAll}
                  className="text-sm text-red-500 hover:text-red-700 font-medium transition-colors"
                >
                  Clear all
                </button>
              )}
              <button
                onClick={onClose}
                className="p-2 rounded-lg hover:bg-gray-100 text-gray-400 hover:text-gray-600 transition-colors text-lg leading-none"
              >
                ✕
              </button>
            </div>
          </div>
          <div className="flex flex-wrap items-center gap-2 mt-1.5">
            {TEMP_OPTIONS.filter((opt) => tempFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setTempFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                {opt.emoji && <span className="mr-1">{opt.emoji}</span>}{opt.label}
              </button>
            ))}
            {MOISTURE_OPTIONS.filter((opt) => moistureFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setMoistureFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                {opt.emoji && <span className="mr-1">{opt.emoji}</span>}{opt.label}
              </button>
            ))}
            {TONE_OPTIONS.filter((opt) => toneFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setToneFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                {opt.emoji && <span className="mr-1">{opt.emoji}</span>}{opt.label}
              </button>
            ))}
            {TASTE_OPTIONS.filter((opt) => tasteFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setTasteFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                <span className="mr-1">{opt.emoji}</span>{opt.label}
              </button>
            ))}
            {bodySystems.filter((sys) => systemFilter.has(sys.id)).map((sys) => (
              <button
                key={sys.id}
                onClick={() => setSystemFilter((prev) => toggle(prev, sys.id))}
                className="border rounded-full px-3 py-1 text-sm font-medium transition-all bg-green-200 border-green-400 text-green-900"
              >
                {sys.name}
              </button>
            ))}
            {availableActions.filter((action) => actionFilter.has(action.id)).map((action) => (
              <button
                key={action.id}
                onClick={() => setActionFilter((prev) => toggle(prev, action.id))}
                className="border rounded-full px-3 py-1 text-sm font-medium transition-all bg-violet-200 border-violet-400 text-violet-900"
              >
                {action.name}
              </button>
            ))}
            {MENSTRUUM_OPTIONS.filter((opt) => menstruumFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setMenstruumFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                <span className="mr-1">{opt.emoji}</span>{opt.label}
              </button>
            ))}
            {SUN_OPTIONS.filter((opt) => sunFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setSunFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                <span className="mr-1">{opt.emoji}</span>{opt.label}
              </button>
            ))}
            {WATER_OPTIONS.filter((opt) => waterFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setWaterFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                <span className="mr-1">{opt.emoji}</span>{opt.label}
              </button>
            ))}
            {SOIL_OPTIONS.filter((opt) => soilFilter.has(opt.value)).map((opt) => (
              <button
                key={opt.value}
                onClick={() => setSoilFilter((prev) => toggle(prev, opt.value))}
                className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${opt.on}`}
              >
                <span className="mr-1">{opt.emoji}</span>{opt.label}
              </button>
            ))}
            <p className="text-sm text-gray-500">
              {hasFilters
                ? `${filteredHerbs.length} ${filteredHerbs.length === 1 ? 'herb matches' : 'herbs match'}`
                : `${herbs.length} herbs total`}
            </p>
          </div>
        </div>

        {/* Two-pane body */}
        <div ref={bodyRef} className="flex flex-col flex-1 min-h-0 p-3 gap-2 overflow-hidden">

          {/* Filter controls pane */}
          <div
            className="relative border-2 border-gray-300 rounded-xl bg-white shadow-sm overflow-hidden shrink-0 transition-all duration-200"
            style={{ height: filterPaneOpen ? filterPaneHeight : 44 }}
          >
            {/* Pane header — always visible */}
            <div className="flex items-center justify-between px-5 h-11 border-b border-gray-100">
              <p className="text-xs font-semibold text-gray-400 uppercase tracking-widest">Filters</p>
              <button
                onClick={() => setFilterPaneOpen((prev) => !prev)}
                className="p-1 rounded text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-all"
                aria-label="Toggle filters"
              >
                <svg className={`w-4 h-4 transition-transform duration-200 ${filterPaneOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </button>
            </div>
            {filterPaneOpen && <ScrollArrow direction="up" visible={filterScroll.up} />}
            {filterPaneOpen && (
            <div
              ref={filterPaneRef}
              onScroll={() => checkPaneScroll(filterPaneRef.current, setFilterScroll)}
              className="px-5 py-4 space-y-5 overflow-y-auto rounded-xl"
              style={{ height: filterPaneHeight - 44 }}
            >

              {/* Temperature */}
              <div>
                <SectionHeader label="Temperature" open={sectionsOpen.temperature} onToggle={() => toggleSection('temperature')} />
                {sectionsOpen.temperature && (
                  <div className="flex flex-wrap gap-2">
                    {TEMP_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setTempFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          tempFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        {opt.emoji && <span className="mr-1">{opt.emoji}</span>}
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Moisture */}
              <div>
                <SectionHeader label="Moisture" open={sectionsOpen.moisture} onToggle={() => toggleSection('moisture')} />
                {sectionsOpen.moisture && (
                  <div className="flex flex-wrap gap-2">
                    {MOISTURE_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setMoistureFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          moistureFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        {opt.emoji && <span className="mr-1">{opt.emoji}</span>}
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Tone */}
              <div>
                <SectionHeader label="Tone" open={sectionsOpen.tone} onToggle={() => toggleSection('tone')} />
                {sectionsOpen.tone && (
                  <div className="flex flex-wrap gap-2">
                    {TONE_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setToneFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          toneFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        {opt.emoji && <span className="mr-1">{opt.emoji}</span>}
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Taste */}
              <div>
                <SectionHeader label="Taste" open={sectionsOpen.taste} onToggle={() => toggleSection('taste')} />
                {sectionsOpen.taste && (
                  <div className="flex flex-wrap gap-2">
                    {TASTE_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setTasteFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          tasteFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        <span className="mr-1">{opt.emoji}</span>
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Body System */}
              {bodySystems.length > 0 && (
                <div>
                  <SectionHeader label="Body System" open={sectionsOpen.bodySystem} onToggle={() => toggleSection('bodySystem')} />
                  {sectionsOpen.bodySystem && (
                    <div className="flex flex-wrap gap-2">
                      {bodySystems.map((sys) => (
                        <button
                          key={sys.id}
                          onClick={() => setSystemFilter((prev) => toggle(prev, sys.id))}
                          className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                            systemFilter.has(sys.id)
                              ? 'bg-green-200 border-green-400 text-green-900'
                              : 'bg-green-50 border-green-200 text-green-700 hover:bg-green-100'
                          }`}
                        >
                          {sys.name}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              )}

              {/* Action */}
              {availableActions.length > 0 && (
                <div>
                  <SectionHeader label="Action" open={sectionsOpen.action} onToggle={() => toggleSection('action')} />
                  {sectionsOpen.action && (
                    <div className="flex flex-wrap gap-2">
                      {availableActions.map((action) => (
                        <button
                          key={action.id}
                          onClick={() => setActionFilter((prev) => toggle(prev, action.id))}
                          className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                            actionFilter.has(action.id)
                              ? 'bg-violet-200 border-violet-400 text-violet-900'
                              : 'bg-violet-50 border-violet-200 text-violet-700 hover:bg-violet-100'
                          }`}
                        >
                          {action.name}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              )}

              {/* Menstruum */}
              <div>
                <SectionHeader label="Menstruum" open={sectionsOpen.menstruum} onToggle={() => toggleSection('menstruum')} />
                {sectionsOpen.menstruum && (
                  <div className="flex flex-wrap gap-2">
                    {MENSTRUUM_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setMenstruumFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          menstruumFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        <span className="mr-1">{opt.emoji}</span>
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Sun */}
              <div>
                <SectionHeader label="Sun" open={sectionsOpen.sun} onToggle={() => toggleSection('sun')} />
                {sectionsOpen.sun && (
                  <div className="flex flex-wrap gap-2">
                    {SUN_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setSunFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          sunFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        <span className="mr-1">{opt.emoji}</span>
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Water */}
              <div>
                <SectionHeader label="Water (once established)" open={sectionsOpen.water} onToggle={() => toggleSection('water')} />
                {sectionsOpen.water && (
                  <div className="flex flex-wrap gap-2">
                    {WATER_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setWaterFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          waterFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        <span className="mr-1">{opt.emoji}</span>
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

              {/* Soil Fertility */}
              <div>
                <SectionHeader label="Soil Fertility" open={sectionsOpen.soilFertility} onToggle={() => toggleSection('soilFertility')} />
                {sectionsOpen.soilFertility && (
                  <div className="flex flex-wrap gap-2">
                    {SOIL_OPTIONS.map((opt) => (
                      <button
                        key={opt.value}
                        onClick={() => setSoilFilter((prev) => toggle(prev, opt.value))}
                        className={`border rounded-full px-3 py-1 text-sm font-medium transition-all ${
                          soilFilter.has(opt.value) ? opt.on : opt.off
                        }`}
                      >
                        <span className="mr-1">{opt.emoji}</span>
                        {opt.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>

            </div>
            )}
            {filterPaneOpen && <ScrollArrow direction="down" visible={filterScroll.down} />}
          </div>

          {/* Drag handle — desktop only */}
          <div
            className="hidden sm:flex items-center justify-center h-3 shrink-0 cursor-row-resize group"
            onPointerDown={(e) => {
              isDragging.current = true;
              dragStartY.current = e.clientY;
              dragStartHeight.current = filterPaneHeight;
              e.currentTarget.setPointerCapture(e.pointerId);
            }}
            onPointerMove={(e) => {
              if (!isDragging.current || !bodyRef.current) return;
              const delta = e.clientY - dragStartY.current;
              const containerH = bodyRef.current.getBoundingClientRect().height;
              const maxH = containerH - 24 - 12 - 80;
              setFilterPaneHeight(Math.max(60, Math.min(maxH, dragStartHeight.current + delta)));
            }}
            onPointerUp={() => { isDragging.current = false; }}
            onPointerCancel={() => { isDragging.current = false; }}
          >
            <div className="w-8 h-1 rounded-full bg-gray-300 group-hover:bg-gray-500 transition-colors" />
          </div>

          {/* Results pane */}
          <div className="relative border-2 border-gray-300 rounded-xl bg-white shadow-sm flex-1 min-h-0 flex flex-col overflow-hidden">
            <ScrollArrow direction="up" visible={resultsScroll.up} />
            <div
              ref={resultsPaneRef}
              onScroll={() => checkPaneScroll(resultsPaneRef.current, setResultsScroll)}
              className="flex-1 overflow-y-auto min-h-0"
            >
              {loading ? (
                <div className="flex items-center justify-center h-32 text-gray-400 text-sm">
                  Loading herbs…
                </div>
              ) : (
                <>
                  {hasFilters && filteredHerbs.length === 0 && (
                    <div className="flex flex-col items-center justify-center h-32 gap-1">
                      <p className="text-gray-400 text-sm">No herbs match all these filters.</p>
                      <button onClick={clearAll} className="text-sm text-red-400 hover:text-red-600 underline">
                        Clear filters
                      </button>
                    </div>
                  )}

                  <div className="p-3 space-y-1.5">
                    {filteredHerbs.map((herb) => {
                      const sortedSystemIds = [...herb.system_ids].sort((a, b) => {
                        const aSelected = systemFilter.has(a) ? 0 : 1;
                        const bSelected = systemFilter.has(b) ? 0 : 1;
                        if (aSelected !== bSelected) return aSelected - bSelected;
                        return (systemMap.get(a) ?? '').localeCompare(systemMap.get(b) ?? '');
                      });
                      return (
                        <button
                          key={herb.id}
                          onClick={() => onHerbSelect(herb.id)}
                          className={`w-full text-left border rounded-lg px-4 py-2.5 transition-all hover:shadow-md hover:scale-[1.005] ${cardBg(herb.temperature)}`}
                        >
                          <div className="flex items-center justify-between gap-2">
                            <span className="font-medium text-gray-900 text-sm">{herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}</span>
                            <EnergeticEmojis temperature={herb.temperature} moisture={herb.moisture} tone={herb.tone} taste={herb.taste} temperatureInferred={herb.temperature_inferred} moistureInferred={herb.moisture_inferred} toneInferred={herb.tone_inferred} tasteInferred={herb.taste_inferred} className="text-base leading-none shrink-0" />
                          </div>
                          {herb.pinyin_name && (
                            <div className="text-xs text-gray-500 mt-0.5">{herb.pinyin_name}</div>
                          )}
                          <div className="text-xs italic text-gray-500 mt-0.5">{herb.latin_name}</div>
                          {sortedSystemIds.length > 0 && (
                            <div className="flex items-center flex-wrap gap-1 mt-1.5">
                              {sortedSystemIds.map((sysId) => {
                                const name = systemMap.get(sysId);
                                if (!name) return null;
                                const isActive = systemFilter.has(sysId);
                                return (
                                  <span
                                    key={sysId}
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      onSystemSelect?.(sysId);
                                    }}
                                    className={`text-xs px-2 py-0.5 rounded-full border transition-colors cursor-pointer ${
                                      isActive
                                        ? 'bg-green-200 border-green-400 text-green-900 hover:bg-green-300'
                                        : 'bg-green-50 border-green-200 text-green-700 hover:bg-green-100'
                                    }`}
                                  >
                                    {name}
                                  </span>
                                );
                              })}

                            </div>
                          )}
                        </button>
                      );
                    })}
                  </div>
                </>
              )}
            </div>
            <ScrollArrow direction="down" visible={resultsScroll.down} />
          </div>

        </div>
      </div>
    </>
  );
}
