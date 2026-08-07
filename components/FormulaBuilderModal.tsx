'use client';

import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';
import { ArrowLeftIcon, ArrowRightIcon, CheckIcon, InformationCircleIcon, XMarkIcon } from '@heroicons/react/24/outline';

type Stage = 'context' | 'build' | 'review';
type Role = 'base' | 'synergist' | 'specific';

interface Herb {
  id: number;
  latin_name: string;
  common_name: string;
  plant_part: string | null;
  temperature: string | null;
  moisture: string | null;
  tone: string | null;
}

interface Candidate {
  herb: Herb;
  context: string;
  score: number;
}

interface Constitution {
  temperature: 'hot' | 'cold' | 'neutral';
  moisture: 'damp' | 'dry' | 'neutral';
  tone: 'tense' | 'lax' | 'neutral';
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onHerbClick?: (herbId: number) => void;
}

const ENERGETIC_BADGE: Record<string, string> = {
  warming:    'bg-amber-100  text-amber-800  dark:bg-amber-900/30  dark:text-amber-300',
  cooling:    'bg-sky-100    text-sky-800    dark:bg-sky-900/30    dark:text-sky-300',
  moistening: 'bg-blue-100   text-blue-800   dark:bg-blue-900/30   dark:text-blue-300',
  drying:     'bg-orange-100 text-orange-800 dark:bg-orange-900/30 dark:text-orange-300',
  toning:     'bg-violet-100 text-violet-800 dark:bg-violet-900/30 dark:text-violet-300',
  relaxing:   'bg-green-100  text-green-800  dark:bg-green-900/30  dark:text-green-300',
};

const ROLE_CFG = {
  base: {
    label: 'Base',
    sub: 'Nourishing tonic for the body system',
    border: 'border-emerald-400',
    dot: 'bg-emerald-500',
    text: 'text-emerald-600 dark:text-emerald-400',
    headerBg: 'bg-emerald-50 dark:bg-emerald-900/20',
  },
  synergist: {
    label: 'Synergist',
    sub: 'Addresses underlying causes & drives formula',
    border: 'border-violet-400',
    dot: 'bg-violet-500',
    text: 'text-violet-600 dark:text-violet-400',
    headerBg: 'bg-violet-50 dark:bg-violet-900/20',
  },
  specific: {
    label: 'Specific',
    sub: 'Energetically precise for this patient',
    border: 'border-amber-400',
    dot: 'bg-amber-500',
    text: 'text-amber-600 dark:text-amber-400',
    headerBg: 'bg-amber-50 dark:bg-amber-900/20',
  },
} as const;

const ROLE_INFO: Record<Role, string[]> = {
  base: [
    'All herbs linked to the selected body system, filtered to those with at least one tonic or nourishing action.',
    'Qualifying action keywords: tonic, adaptogen, alterative, nutritive, restorative.',
    "Sorted by how closely the herb's energetics oppose the patient's constitution (dots).",
  ],
  synergist: [
    'Herbs drawn from three sources, then deduplicated:',
    '① Herbs recorded under specific therapeutic actions for this disorder.',
    '② Herbs included in any prescription written for this disorder.',
    '③ Herbs linked to the disorder\'s indicated actions within this body system.',
    'Sorted by energetics match.',
  ],
  specific: [
    'Herbs explicitly recorded as specific remedies for this disorder — chosen for their energetic or symptom precision.',
    'The italicised note on each card is the rationale from the source material.',
    'Sorted by energetics match.',
  ],
};

// Herbs with opposing energetics to patient constitution score higher
function scoreHerb(herb: Herb, c: Constitution): number {
  let n = 0;
  if (c.temperature === 'hot'  && herb.temperature === 'cooling')   n++;
  if (c.temperature === 'cold' && herb.temperature === 'warming')   n++;
  if (c.moisture === 'damp'    && herb.moisture    === 'drying')    n++;
  if (c.moisture === 'dry'     && herb.moisture    === 'moistening') n++;
  if (c.tone === 'tense'       && herb.tone        === 'relaxing')  n++;
  if (c.tone === 'lax'         && herb.tone        === 'toning')    n++;
  return n;
}

// Keywords that mark an action as appropriate for the Base (tonic/nourishing) role
const BASE_ACTION_KEYWORDS = ['tonic', 'adaptogen', 'alterative', 'nutritive', 'restorative'];

function isBaseAction(name: string): boolean {
  const lower = name.toLowerCase();
  return BASE_ACTION_KEYWORDS.some((kw) => lower.includes(kw));
}

function buildCandidates(
  rows: { herbs: Herb; primary_actions?: { name: string } }[],
  constitution: Constitution,
  requireBaseAction = false,
): Candidate[] {
  const map = new Map<number, { herb: Herb; actions: string[]; hasBaseAction: boolean }>();
  for (const row of rows) {
    const h = row.herbs;
    const actionName = row.primary_actions?.name ?? '';
    if (!map.has(h.id)) map.set(h.id, { herb: h, actions: [], hasBaseAction: false });
    const entry = map.get(h.id)!;
    if (actionName) entry.actions.push(actionName);
    if (isBaseAction(actionName)) entry.hasBaseAction = true;
  }
  return Array.from(map.values())
    .filter(({ hasBaseAction }) => !requireBaseAction || hasBaseAction)
    .map(({ herb, actions }) => ({
      herb,
      context: actions.filter(Boolean).join(', '),
      score: scoreHerb(herb, constitution),
    }))
    .sort((a, b) => b.score - a.score || a.herb.latin_name.localeCompare(b.herb.latin_name));
}

const ROLES: Role[] = ['base', 'synergist', 'specific'];
const EMPTY_CANDIDATES: Record<Role, Candidate[]> = { base: [], synergist: [], specific: [] };
const EMPTY_SELECTED: Record<Role, Herb | null> = { base: null, synergist: null, specific: null };

export function FormulaBuilderModal({ isOpen, onClose, onHerbClick }: Props) {
  const [stage, setStage] = useState<Stage>('context');
  const [loading, setLoading] = useState(false);
  const [activeRole, setActiveRole] = useState<Role>('base');
  const [showInfo, setShowInfo] = useState(false);
  const [infoOpenRole, setInfoOpenRole] = useState<Role | null>(null);

  // Stage 1
  const [systems, setSystems] = useState<{ id: number; name: string }[]>([]);
  const [disorders, setDisorders] = useState<{ id: number; name: string }[]>([]);
  const [selectedSystem, setSelectedSystem] = useState<{ id: number; name: string } | null>(null);
  const [selectedDisorder, setSelectedDisorder] = useState<{ id: number; name: string } | null>(null);
  const [constitution, setConstitution] = useState<Constitution>({
    temperature: 'neutral',
    moisture: 'neutral',
    tone: 'neutral',
  });

  // Stage 2
  const [candidates, setCandidates] = useState<Record<Role, Candidate[]>>(EMPTY_CANDIDATES);
  const [selected, setSelected] = useState<Record<Role, Herb | null>>(EMPTY_SELECTED);

  useEffect(() => {
    if (!isOpen) return;
    setShowInfo(false);
    supabase
      .from('body_systems')
      .select('id, name')
      .order('name')
      .then(({ data }) => setSystems(data ?? []));
  }, [isOpen]);

  useEffect(() => {
    if (!selectedSystem) { setDisorders([]); setSelectedDisorder(null); return; }
    supabase
      .from('disorders')
      .select('id, name')
      .eq('body_system_id', selectedSystem.id)
      .order('sort_order')
      .then(({ data }) => setDisorders(data ?? []));
  }, [selectedSystem]);

  useEffect(() => {
    if (!isOpen) return;
    const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose(); };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [isOpen, onClose]);

  const fetchCandidates = async () => {
    if (!selectedSystem || !selectedDisorder) return;
    setLoading(true);
    setSelected(EMPTY_SELECTED);
    // Round 1: everything we can fetch in parallel
    const [baseRes, synRes, specRes, prescIdRes, indicatedActionsRes] = await Promise.all([
      supabase
        .from('herb_primary_actions')
        .select('herbs(id, latin_name, common_name, plant_part, temperature, moisture, tone), primary_actions(name)')
        .eq('body_system_id', selectedSystem.id),
      supabase
        .from('disorder_action_herbs')
        .select('herbs(id, latin_name, common_name, plant_part, temperature, moisture, tone), primary_actions(name)')
        .eq('disorder_id', selectedDisorder.id),
      supabase
        .from('disorder_specific_remedies')
        .select('herbs(id, latin_name, common_name, plant_part, temperature, moisture, tone), description')
        .eq('disorder_id', selectedDisorder.id),
      supabase
        .from('disorder_prescriptions')
        .select('id')
        .eq('disorder_id', selectedDisorder.id),
      supabase
        .from('disorder_actions_indicated')
        .select('primary_action_id')
        .eq('disorder_id', selectedDisorder.id),
    ]);

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const prescIds = ((prescIdRes.data ?? []) as any[]).map((p) => p.id as number);
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const indicatedActionIds = ((indicatedActionsRes.data ?? []) as any[]).map((r) => r.primary_action_id as number);

    // Round 2: prescription herbs + indicated-action herbs (needs IDs from round 1)
    const [phRes, ihRes] = await Promise.all([
      prescIds.length > 0
        ? supabase
            .from('prescription_herbs')
            .select('herbs(id, latin_name, common_name, plant_part, temperature, moisture, tone), prescription_herb_actions(primary_actions(name))')
            .in('prescription_id', prescIds)
        : Promise.resolve({ data: [] as unknown[], error: null }),
      indicatedActionIds.length > 0
        ? supabase
            .from('herb_primary_actions')
            .select('herbs(id, latin_name, common_name, plant_part, temperature, moisture, tone), primary_actions(name)')
            .in('primary_action_id', indicatedActionIds)
            .eq('body_system_id', selectedSystem.id)
        : Promise.resolve({ data: [] as unknown[], error: null }),
    ]);

    // Flatten prescription herbs
    const prescHerbRows: { herbs: Herb; primary_actions?: { name: string } }[] = [];
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    for (const ph of (phRes.data ?? []) as any[]) {
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      const actions = (ph.prescription_herb_actions ?? []) as any[];
      if (actions.length === 0) {
        prescHerbRows.push({ herbs: ph.herbs as Herb });
      } else {
        for (const pha of actions) {
          prescHerbRows.push({ herbs: ph.herbs as Herb, primary_actions: pha.primary_actions });
        }
      }
    }

    // Synergist = disorder_action_herbs + prescription herbs + indicated-action herbs (deduplicated in buildCandidates)
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const synRows = [
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      ...((synRes.data ?? []) as any[]),
      ...prescHerbRows,
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      ...((ihRes.data ?? []) as any[]),
    ];

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const specList: Candidate[] = ((specRes.data ?? []) as any[])
      .map((row) => ({
        herb: row.herbs as Herb,
        context: (row.description as string | null) ?? '',
        score: scoreHerb(row.herbs as Herb, constitution),
      }))
      .sort((a: Candidate, b: Candidate) => b.score - a.score || a.herb.latin_name.localeCompare(b.herb.latin_name));

    const synCandidates = buildCandidates(synRows, constitution);
    // Fallback: if no synergist data at all, reuse specific remedies so the column is never empty
    const synFallback: Candidate[] = synCandidates.length === 0
      ? specList.map((c) => ({ ...c, context: c.context ? `${c.context} · from specific remedies` : 'from specific remedies' }))
      : synCandidates;

    setCandidates({
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      base: buildCandidates((baseRes.data ?? []) as any[], constitution, true),
      synergist: synFallback,
      specific: specList,
    });
    setLoading(false);
  };

  const reset = () => {
    setStage('context');
    setSelectedSystem(null);
    setSelectedDisorder(null);
    setConstitution({ temperature: 'neutral', moisture: 'neutral', tone: 'neutral' });
    setSelected(EMPTY_SELECTED);
    setCandidates(EMPTY_CANDIDATES);
    setActiveRole('base');
  };

  if (!isOpen) return null;

  const toggleHerb = (role: Role, herb: Herb) =>
    setSelected((prev) => ({ ...prev, [role]: prev[role]?.id === herb.id ? null : herb }));

  // --- Render helpers ---

  const energeticBadges = (herb: Herb) =>
    [herb.temperature, herb.moisture, herb.tone]
      .filter((v): v is string => !!v && v !== 'neutral')
      .map((v) => (
        <span key={v} className={`text-xs px-1.5 py-0.5 rounded-full ${ENERGETIC_BADGE[v] ?? ''}`}>
          {v}
        </span>
      ));

  const scoreDots = (score: number, dotClass: string) => (
    <div className="flex gap-0.5 flex-shrink-0" title={`${score}/3 energetics match`}>
      {[0, 1, 2].map((i) => (
        <div key={i} className={`w-2 h-2 rounded-full ${i < score ? dotClass : 'bg-gray-200 dark:bg-gray-600'}`} />
      ))}
    </div>
  );

  const candidateCard = (c: Candidate, role: Role) => {
    const cfg = ROLE_CFG[role];
    const isSelected = selected[role]?.id === c.herb.id;
    return (
      <button
        key={c.herb.id}
        onClick={() => toggleHerb(role, c.herb)}
        className={`w-full text-left p-3 rounded-lg border-2 transition-all shadow-sm ${
          isSelected
            ? `${cfg.border} ${cfg.headerBg}`
            : 'border-transparent bg-white dark:bg-gray-800 hover:border-gray-200 dark:hover:border-gray-600'
        }`}
      >
        <div className="flex items-start justify-between gap-2">
          <div className="min-w-0 flex-1">
            <div className="text-sm font-medium italic text-gray-900 dark:text-gray-100 leading-tight">
              {c.herb.latin_name}
            </div>
            <div className="text-xs text-gray-500 dark:text-gray-400">{c.herb.common_name}{c.herb.plant_part ? ` (${c.herb.plant_part})` : ''}</div>
            {c.context && (
              <div title={c.context} className="text-xs text-gray-400 dark:text-gray-500 mt-1 line-clamp-2">{c.context}</div>
            )}
            <div className="flex flex-wrap gap-1 mt-1.5">{energeticBadges(c.herb)}</div>
          </div>
          <div className="pt-0.5">{scoreDots(c.score, cfg.dot)}</div>
        </div>
      </button>
    );
  };

  // --- Info view ---

  const renderInfo = () => (
    <div className="max-w-lg mx-auto space-y-6 py-2 text-sm text-gray-700 leading-relaxed">
      <div>
        <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100">The Art of Herbal Formulation</h2>
        <p className="text-sm text-gray-500 dark:text-gray-400 mt-1 italic">Herbal Formularies, Vol. 3 — Jill Stansbury</p>
      </div>

      <p>
        Rather than prescribing a single herb for a diagnosis, this approach builds a formula around
        at least three herbs that each play a distinct role — forming a <strong>triangle</strong>.
        The aim is to treat the <em>person</em> and their unique presentation, not the diagnosis alone.
      </p>

      <div className="border border-green-200 rounded-lg overflow-hidden">
        <div className="bg-green-50 px-4 py-2 border-b border-green-200">
          <h3 className="font-semibold text-green-800">The Formula Triangle</h3>
        </div>
        <div className="divide-y divide-gray-100">
          <div className="px-4 py-3">
            <div className="flex items-baseline gap-2 mb-1">
              <span className="font-semibold text-emerald-700">Base</span>
              <span className="text-xs text-gray-400 italic">also called Lead herb or Director</span>
            </div>
            <p>
              The nourishing foundation. Choose a tonic, restorative, alterative, adaptogenic, or nutritive herb
              with a strong affinity for the primary organ system. It should be broadly indicated, non-toxic, and
              suited to long-term use — often the herb best known for supporting that system.
            </p>
            <p className="mt-1 text-gray-500 italic text-xs">
              Example: <em>Crataegus</em> for a cardiovascular formula; <em>Withania</em> for exhaustion-driven insomnia.
            </p>
          </div>
          <div className="px-4 py-3">
            <div className="flex items-baseline gap-2 mb-1">
              <span className="font-semibold text-violet-700">Synergist</span>
              <span className="text-xs text-gray-400 italic">also called Adjuvant, Balancer, or Assistant</span>
            </div>
            <p>
              Corrects or complements the base, driving it to the right tissues. Addresses underlying contributing
              factors — other organ systems, energetic imbalances, or constitutional patterns. Requires deeper case
              knowledge than choosing the base.
            </p>
            <p className="mt-1 text-gray-500 italic text-xs">
              Example: <em>Ginkgo</em> added to combat circulatory stress in a hypertensive smoker.
            </p>
          </div>
          <div className="px-4 py-3">
            <div className="flex items-baseline gap-2 mb-1">
              <span className="font-semibold text-amber-700">Specific</span>
              <span className="text-xs text-gray-400 italic">also called Kicker or Energetic Specific</span>
            </div>
            <p>
              Selected not for a diagnosis but for the precise <em>quality and expression</em> of the individual&apos;s
              presentation: pulse, tongue, affect, pathology, etiology, and unique symptoms. This is what makes a
              formula truly individualized.
            </p>
            <p className="mt-1 text-gray-500 italic text-xs">
              Example: <em>Rauwolfia</em> as a specific for hypertension with a throbbing headache in a high-stress person.
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-4">
        <div>
          <h3 className="font-semibold text-gray-800 mb-1">Treat the Person, Not the Diagnosis</h3>
          <p>
            Two people with the same diagnosis may need entirely different formulas. A formula for insomnia with
            exhaustion rests on a chi tonic like <em>Panax</em>, while restless heat-excess insomnia calls for
            something cooling like <em>Avena</em> or <em>Scutellaria</em>. Constitution, life history, and
            presenting symptoms all shape which herbs are most appropriate.
          </p>
        </div>
        <div>
          <h3 className="font-semibold text-gray-800 mb-1">Energetic Fine-Tuning</h3>
          <p>
            Herbs are chosen to match the patient&apos;s energetic state: hot or cold, damp or dry, tense or lax.
            TCM (yin/yang), Ayurveda (doshas), and Western four-elements theory all offer frameworks — but even
            simply noticing whether a patient runs hot or cold and choosing herbs with opposing qualities is a
            powerful guide.
          </p>
        </div>
        <div>
          <h3 className="font-semibold text-gray-800 mb-1">Supporting Vitality</h3>
          <p>
            Herbal medicine takes a <strong>physiologic</strong> approach: gently nourishing and restoring organ
            function over time rather than suppressing symptoms. The goal is to support the body&apos;s innate healing
            capacity — the <em>vital force</em> — rather than opposing disease directly.
          </p>
        </div>
        <div>
          <h3 className="font-semibold text-gray-800 mb-1">How to Use This Builder</h3>
          <p>
            Start by identifying the primary body system and selecting actions you need the formula to perform.
            Candidates for each triangle role are filtered by those actions and scored against the patient&apos;s
            constitutional energetics. Use it as a starting point, then apply clinical judgment to arrive at a
            finely tuned, individualized formula.
          </p>
        </div>
      </div>
    </div>
  );

  // --- Stage: Context ---

  const renderContext = () => (
    <div className="max-w-lg mx-auto space-y-6 py-2">
      <div>
        <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Formula Builder</h2>
        <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">
          Build a herbal triangle formula — base, synergist, and specific — tailored to a patient&apos;s presentation.
        </p>
      </div>

      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
            Body System
          </label>
          <select
            value={selectedSystem?.id ?? ''}
            onChange={(e) => {
              setSelectedSystem(systems.find((s) => s.id === Number(e.target.value)) ?? null);
              setSelectedDisorder(null);
            }}
            className="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 px-3 py-2 text-sm text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-emerald-500"
          >
            <option value="">Select a system…</option>
            {systems.map((s) => <option key={s.id} value={s.id}>{s.name}</option>)}
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
            Disorder / Presentation
          </label>
          <select
            value={selectedDisorder?.id ?? ''}
            onChange={(e) => setSelectedDisorder(disorders.find((d) => d.id === Number(e.target.value)) ?? null)}
            disabled={!selectedSystem || disorders.length === 0}
            className="w-full rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 px-3 py-2 text-sm text-gray-900 dark:text-gray-100 focus:outline-none focus:ring-2 focus:ring-emerald-500 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <option value="">Select a disorder…</option>
            {disorders.map((d) => <option key={d.id} value={d.id}>{d.name}</option>)}
          </select>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
            Patient Constitution
            <span className="font-normal text-gray-400 ml-2 text-xs">
              herbs that balance this constitution rank higher
            </span>
          </label>
          <div className="space-y-2">
            <div className="flex items-center gap-3">
              <span className="text-xs text-gray-500 dark:text-gray-400 w-24 flex-shrink-0">Temperature</span>
              <div className="flex flex-1 rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden text-sm">
                {(['cold', 'neutral', 'hot'] as const).map((v) => (
                  <button
                    key={v}
                    onClick={() => setConstitution((c) => ({ ...c, temperature: v }))}
                    className={`flex-1 py-1.5 transition-colors ${
                      constitution.temperature === v
                        ? v === 'cold' ? 'bg-sky-500 text-white'
                          : v === 'hot' ? 'bg-amber-500 text-white'
                          : 'bg-gray-400 text-white'
                        : 'hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-600 dark:text-gray-400'
                    }`}
                  >
                    {v === 'cold' ? '❄️ Cold' : v === 'hot' ? '🔥 Hot' : 'Neutral'}
                  </button>
                ))}
              </div>
            </div>

            <div className="flex items-center gap-3">
              <span className="text-xs text-gray-500 dark:text-gray-400 w-24 flex-shrink-0">Moisture</span>
              <div className="flex flex-1 rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden text-sm">
                {(['dry', 'neutral', 'damp'] as const).map((v) => (
                  <button
                    key={v}
                    onClick={() => setConstitution((c) => ({ ...c, moisture: v }))}
                    className={`flex-1 py-1.5 transition-colors ${
                      constitution.moisture === v
                        ? v === 'dry' ? 'bg-orange-500 text-white'
                          : v === 'damp' ? 'bg-blue-500 text-white'
                          : 'bg-gray-400 text-white'
                        : 'hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-600 dark:text-gray-400'
                    }`}
                  >
                    {v === 'dry' ? '🌵 Dry' : v === 'damp' ? '💧 Damp' : 'Neutral'}
                  </button>
                ))}
              </div>
            </div>

            <div className="flex items-center gap-3">
              <span className="text-xs text-gray-500 dark:text-gray-400 w-24 flex-shrink-0">Tone</span>
              <div className="flex flex-1 rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden text-sm">
                {(['tense', 'neutral', 'lax'] as const).map((v) => (
                  <button
                    key={v}
                    onClick={() => setConstitution((c) => ({ ...c, tone: v }))}
                    className={`flex-1 py-1.5 transition-colors ${
                      constitution.tone === v
                        ? v === 'tense' ? 'bg-violet-500 text-white'
                          : v === 'lax' ? 'bg-green-500 text-white'
                          : 'bg-gray-400 text-white'
                        : 'hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-600 dark:text-gray-400'
                    }`}
                  >
                    {v === 'tense' ? '⚡ Tense' : v === 'lax' ? '🌊 Lax' : 'Neutral'}
                  </button>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      <button
        onClick={async () => { await fetchCandidates(); setStage('build'); }}
        disabled={!selectedSystem || !selectedDisorder || loading}
        className="w-full py-3 rounded-lg bg-emerald-600 hover:bg-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed text-white font-medium transition-colors"
      >
        {loading ? 'Loading…' : <span className="flex items-center gap-2 justify-center">Build Formula <ArrowRightIcon className="w-4 h-4" /></span>}
      </button>
    </div>
  );

  // --- Stage: Build ---

  const renderBuild = () => {
    const unselected = ROLES.filter((r) => !selected[r]);
    const allSelected = unselected.length === 0;

    return (
      <div className="flex flex-col gap-3 h-full">
        {/* Header */}
        <div className="flex items-start justify-between flex-shrink-0">
          <div>
            <h2 className="text-lg font-bold text-gray-900 dark:text-gray-100">
              {selectedDisorder!.name}
            </h2>
            <p className="text-xs text-gray-500 dark:text-gray-400">
              {selectedSystem!.name}
              {(constitution.temperature !== 'neutral' || constitution.moisture !== 'neutral' || constitution.tone !== 'neutral') && (
                <span className="ml-2">
                  {constitution.temperature === 'hot' ? '🔥' : constitution.temperature === 'cold' ? '❄️' : ''}
                  {constitution.moisture === 'damp' ? '💧' : constitution.moisture === 'dry' ? '🌵' : ''}
                  {constitution.tone === 'tense' ? '⚡' : constitution.tone === 'lax' ? '🌊' : ''}
                  <span className="text-gray-400 ml-1">· dots = energetics match</span>
                </span>
              )}
            </p>
          </div>
          <button
            onClick={() => setStage('context')}
            className="text-xs text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 flex-shrink-0 ml-4 mt-0.5"
          >
            <ArrowLeftIcon className="w-4 h-4" /> back
          </button>
        </div>

        {/* Mobile tabs */}
        <div className="flex rounded-lg border border-gray-200 dark:border-gray-700 overflow-hidden text-sm flex-shrink-0 md:hidden">
          {ROLES.map((r) => {
            const cfg = ROLE_CFG[r];
            return (
              <button
                key={r}
                onClick={() => setActiveRole(r)}
                className={`flex-1 py-2 font-medium transition-colors relative ${
                  activeRole === r
                    ? 'bg-gray-100 dark:bg-gray-700 text-gray-900 dark:text-gray-100'
                    : 'text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800'
                }`}
              >
                {cfg.label}
                {selected[r] && (
                  <span className={`absolute top-1.5 right-2 w-1.5 h-1.5 rounded-full ${cfg.dot}`} />
                )}
              </button>
            );
          })}
        </div>

        {/* Columns */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-3 flex-1 min-h-0">
          {ROLES.map((role) => {
            const cfg = ROLE_CFG[role];
            const list = candidates[role];
            const sel = selected[role];
            const isActiveOnMobile = role === activeRole;

            return (
              <div
                key={role}
                className={`flex flex-col min-h-0 ${!isActiveOnMobile ? 'hidden md:flex' : ''}`}
              >
                <div className={`flex-shrink-0 rounded-t-lg border-t-2 ${cfg.border} ${cfg.headerBg} px-3 py-2 mb-2`}>
                  <div className="flex items-center justify-between gap-1">
                    <div className={`font-semibold text-sm ${cfg.text}`}>{cfg.label}</div>
                    <button
                      onClick={(e) => { e.stopPropagation(); setInfoOpenRole(infoOpenRole === role ? null : role); }}
                      className={`flex-shrink-0 transition-opacity ${infoOpenRole === role ? 'opacity-100' : 'opacity-40 hover:opacity-80'} ${cfg.text}`}
                      title="How this list is built"
                    >
                      <InformationCircleIcon className="w-4 h-4" />
                    </button>
                  </div>
                  <div className="text-xs text-gray-500 dark:text-gray-400">{cfg.sub}</div>
                  {sel && (
                    <div className="text-xs text-gray-600 dark:text-gray-300 font-medium mt-1 italic truncate">
                      <CheckIcon className="w-3 h-3 inline mr-0.5" /> {sel.latin_name}
                    </div>
                  )}
                  {infoOpenRole === role && (
                    <ul className="mt-2 pt-2 border-t border-gray-200 dark:border-gray-600 space-y-1">
                      {ROLE_INFO[role].map((line, i) => (
                        <li key={i} className="text-xs text-gray-600 dark:text-gray-300 leading-snug">{line}</li>
                      ))}
                    </ul>
                  )}
                </div>

                <div className="flex-1 overflow-y-auto space-y-2 pr-0.5">
                  {list.length === 0 ? (
                    <p className="text-xs text-gray-400 dark:text-gray-500 italic p-2">
                      {role === 'base'
                        ? 'No herbs found for this body system.'
                        : role === 'synergist'
                        ? 'No herbs found for this disorder or body system.'
                        : 'No specific remedies recorded — try selecting from the Synergist list.'}
                    </p>
                  ) : (
                    list.map((c) => candidateCard(c, role))
                  )}
                </div>
              </div>
            );
          })}
        </div>

        {/* Continue button */}
        <div className="flex-shrink-0 pt-2 border-t border-gray-200 dark:border-gray-700">
          <button
            onClick={() => setStage('review')}
            disabled={!allSelected}
            className="w-full py-2.5 rounded-lg bg-emerald-600 hover:bg-emerald-700 disabled:opacity-40 disabled:cursor-not-allowed text-white font-medium transition-colors text-sm"
          >
            {allSelected
              ? <span className="flex items-center gap-2 justify-center">Review Formula <ArrowRightIcon className="w-4 h-4" /></span>
              : `Still need: ${unselected.map((r) => ROLE_CFG[r].label).join(', ')}`}
          </button>
        </div>
      </div>
    );
  };

  // --- Stage: Review ---

  const renderReview = () => {
    const herbs = {
      base:      selected.base!,
      synergist: selected.synergist!,
      specific:  selected.specific!,
    };
    const constitutionSet =
      constitution.temperature !== 'neutral' ||
      constitution.moisture !== 'neutral' ||
      constitution.tone !== 'neutral';

    const herbCard = (herb: Herb, role: Role) => {
      const cfg = ROLE_CFG[role];
      return (
        <div className={`rounded-xl border-2 ${cfg.border} p-4 bg-white dark:bg-gray-800`}>
          <div className={`text-xs font-bold uppercase tracking-wider mb-2 ${cfg.text}`}>
            {cfg.label}
          </div>
          <div className="font-semibold italic text-gray-900 dark:text-gray-100 text-sm leading-tight">
            {herb.latin_name}
          </div>
          <div className="text-xs text-gray-500 dark:text-gray-400 mb-2">{herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}</div>
          <div className="flex flex-wrap gap-1">{energeticBadges(herb)}</div>
          {onHerbClick && (
            <button
              onClick={() => { onHerbClick(herb.id); onClose(); }}
              className={`mt-2 text-xs ${cfg.text} hover:underline`}
            >
              View herb <ArrowRightIcon className="w-3 h-3 inline ml-0.5" />
            </button>
          )}
        </div>
      );
    };

    return (
      <div className="max-w-lg mx-auto space-y-5 py-2">
        <div>
          <h2 className="text-xl font-bold text-gray-900 dark:text-gray-100">
            Formula for {selectedDisorder!.name}
          </h2>
          <p className="text-sm text-gray-500 dark:text-gray-400">{selectedSystem!.name} System</p>
        </div>

        {/* Triangle layout: two on top, base below */}
        <div className="space-y-2">
          <div className="grid grid-cols-2 gap-3">
            {herbCard(herbs.synergist, 'synergist')}
            {herbCard(herbs.specific, 'specific')}
          </div>

          {/* Visual convergence */}
          <div className="flex justify-center items-center gap-1 text-gray-300 dark:text-gray-600 select-none py-0.5">
            <div className="h-px flex-1 bg-gradient-to-r from-transparent to-gray-300 dark:to-gray-600" />
            <span className="text-xs text-gray-400 dark:text-gray-500 px-2">▼ base</span>
            <div className="h-px flex-1 bg-gradient-to-l from-transparent to-gray-300 dark:to-gray-600" />
          </div>

          {herbCard(herbs.base, 'base')}
        </div>

        {/* Patient constitution */}
        {constitutionSet && (
          <div className="rounded-lg border border-gray-200 dark:border-gray-700 p-3 bg-gray-50 dark:bg-gray-800/50">
            <div className="text-xs font-medium text-gray-500 dark:text-gray-400 mb-2">Patient constitution</div>
            <div className="flex gap-2 flex-wrap">
              {constitution.temperature !== 'neutral' && (
                <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                  constitution.temperature === 'hot'
                    ? 'bg-amber-100 text-amber-800 dark:bg-amber-900/30 dark:text-amber-300'
                    : 'bg-sky-100 text-sky-800 dark:bg-sky-900/30 dark:text-sky-300'
                }`}>
                  {constitution.temperature === 'hot' ? '🔥' : '❄️'} {constitution.temperature}
                </span>
              )}
              {constitution.moisture !== 'neutral' && (
                <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                  constitution.moisture === 'damp'
                    ? 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-300'
                    : 'bg-orange-100 text-orange-800 dark:bg-orange-900/30 dark:text-orange-300'
                }`}>
                  {constitution.moisture === 'damp' ? '💧' : '🌵'} {constitution.moisture}
                </span>
              )}
              {constitution.tone !== 'neutral' && (
                <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                  constitution.tone === 'tense'
                    ? 'bg-violet-100 text-violet-800 dark:bg-violet-900/30 dark:text-violet-300'
                    : 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300'
                }`}>
                  {constitution.tone === 'tense' ? '⚡' : '🌊'} {constitution.tone}
                </span>
              )}
            </div>
          </div>
        )}

        <div className="flex gap-3">
          <button
            onClick={reset}
            className="flex-1 py-2 rounded-lg border border-gray-300 dark:border-gray-600 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
          >
            Start over
          </button>
          <button
            onClick={() => setStage('build')}
            className="flex-1 py-2 rounded-lg border border-gray-300 dark:border-gray-600 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
          >
            <ArrowLeftIcon className="w-4 h-4 inline mr-0.5" /> Adjust
          </button>
          <button
            onClick={onClose}
            className="flex-1 py-2 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium transition-colors"
          >
            Done
          </button>
        </div>
      </div>
    );
  };

  // --- Main render ---

  const isBuild = stage === 'build';

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
      onClick={onClose}
    >
      <div
        className="relative bg-gray-50 dark:bg-gray-900 rounded-2xl shadow-2xl w-full max-w-4xl flex flex-col"
        style={{ maxHeight: 'calc(100vh - 2rem)', height: isBuild ? 'calc(100vh - 2rem)' : 'auto' }}
        onClick={(e) => e.stopPropagation()}
      >
        {/* Close */}
        <button
          onClick={onClose}
          className="absolute top-4 right-4 z-10 text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
          aria-label="Close"
        >
          <XMarkIcon className="w-5 h-5" />
        </button>

        {/* Progress dots / back link */}
        <div className="flex-shrink-0 px-6 pt-5 pb-3 flex items-center justify-between">
          {showInfo ? (
            <button
              onClick={() => setShowInfo(false)}
              className="flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-800 dark:hover:text-gray-200 transition-colors"
            >
              <ArrowLeftIcon className="w-4 h-4" /> Back to Formula Builder
            </button>
          ) : (
            <div className="flex items-center gap-3">
              {(['context', 'build', 'review'] as Stage[]).map((s, i) => (
                <div key={s} className="flex items-center gap-2">
                  {i > 0 && <div className="w-5 h-px bg-gray-300 dark:bg-gray-600" />}
                  <div className={`w-2 h-2 rounded-full transition-colors ${
                    stage === s ? 'bg-emerald-500' : 'bg-gray-300 dark:bg-gray-600'
                  }`} />
                  <span className={`text-xs transition-colors ${
                    stage === s ? 'text-emerald-600 dark:text-emerald-400 font-medium' : 'text-gray-400'
                  }`}>
                    {s === 'context' ? 'Context' : s === 'build' ? 'Build' : 'Review'}
                  </span>
                </div>
              ))}
            </div>
          )}
          {!showInfo && (
            <button
              onClick={() => setShowInfo(true)}
              title="About this method"
              className="w-6 h-6 rounded-full border border-gray-300 dark:border-gray-600 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 hover:border-gray-400 transition-all text-xs font-bold leading-none flex items-center justify-center mr-8"
            >
              i
            </button>
          )}
        </div>

        {/* Content */}
        <div className={`flex-1 min-h-0 px-6 pb-6 ${(isBuild && !showInfo) ? 'flex flex-col overflow-hidden' : 'overflow-y-auto'}`}>
          {showInfo ? renderInfo() : (
            <>
              {stage === 'context' && renderContext()}
              {stage === 'build'   && renderBuild()}
              {stage === 'review'  && renderReview()}
            </>
          )}
        </div>
      </div>
    </div>
  );
}
