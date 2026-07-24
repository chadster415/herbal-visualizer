'use client';

import { useEffect, useState } from 'react';
import { EnergeticEmojis } from './EnergeticEmojis';

type BodySystem =
  | 'UPPER_GI'
  | 'LOWER_GI'
  | 'LIVER'
  | 'RENAL'
  | 'LOWER_URINARY'
  | 'REPRODUCTIVE'
  | 'WOMEN'
  | 'MEN'
  | 'RESPIRATORY'
  | 'CARDIOVASCULAR'
  | 'LYMPHATIC'
  | 'SKIN'
  | 'MUCUS';

const BODY_SYSTEMS: BodySystem[] = [
  'UPPER_GI', 'LOWER_GI', 'LIVER', 'RENAL', 'LOWER_URINARY',
  'REPRODUCTIVE', 'WOMEN', 'MEN', 'RESPIRATORY', 'CARDIOVASCULAR',
  'LYMPHATIC', 'SKIN', 'MUCUS',
];

const SYSTEM_LABELS: Record<BodySystem, string> = {
  UPPER_GI: 'Upper GI',
  LOWER_GI: 'Lower GI',
  LIVER: 'Liver',
  RENAL: 'Renal',
  LOWER_URINARY: 'Lower Urinary Tract',
  REPRODUCTIVE: 'Reproductive (All)',
  WOMEN: 'Women',
  MEN: 'Men',
  RESPIRATORY: 'Respiratory',
  CARDIOVASCULAR: 'Cardiovascular',
  LYMPHATIC: 'Lymphatic',
  SKIN: 'Skin',
  MUCUS: 'Mucus Membranes',
};

interface SystemQuestion {
  system: BodySystem;
  indicates: 'excess' | 'deficiency';
  text: string;
}

const SYSTEM_QUESTIONS: SystemQuestion[] = [
  // UPPER GI
  { system: 'UPPER_GI', indicates: 'excess', text: 'Sometimes nausea in mornings' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Sometimes nausea in evenings' },
  { system: 'UPPER_GI', indicates: 'excess', text: 'Sometimes excess salivation' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Mouth frequently too dry' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Duodenal ulcer' },
  { system: 'UPPER_GI', indicates: 'excess', text: 'Stomach ulcer' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Sometimes foul burps' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Butterflies in stomach' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Seldom eat breakfast' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: "Often don't finish meals" },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Often eat to calm down' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Receding gums' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Frequent use of alcohol' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Frequent poor appetite' },
  { system: 'UPPER_GI', indicates: 'excess', text: 'Strong, demanding hunger' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Bitter taste in morning' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: '"Dragon breath" in morning' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Acid indigestion at night' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Frequent mouth or cold sores' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Sometimes difficulty in swallowing' },
  { system: 'UPPER_GI', indicates: 'deficiency', text: 'Indigestion after eating' },
  // LOWER GI
  { system: 'LOWER_GI', indicates: 'excess', text: 'Stools loose with gas' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Constipation with gas' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Frequent constipation' },
  { system: 'LOWER_GI', indicates: 'excess', text: 'Digestion unusually rapid' },
  { system: 'LOWER_GI', indicates: 'excess', text: 'Loose stools when tired/stressed' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Light colored, hard stools' },
  { system: 'LOWER_GI', indicates: 'excess', text: 'Dark, soft stools' },
  { system: 'LOWER_GI', indicates: 'excess', text: 'Quick defecation after eating' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Intestines often bloated' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Constipation w/ hemorrhoids' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Constipation w/ painful defecation' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Constipation w/ hard, marbly stools' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Constipation w/ fully formed stools' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Constipation alternating w/ diarrhea' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Frequent need for laxatives' },
  { system: 'LOWER_GI', indicates: 'deficiency', text: 'Tongue often coated' },
  // LIVER
  { system: 'LIVER', indicates: 'deficiency', text: 'Dry, even scaly skin' },
  { system: 'LIVER', indicates: 'excess', text: 'Moist, sometimes oily skin' },
  { system: 'LIVER', indicates: 'excess', text: 'Hives from food or drugs' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Hay fever or asthma' },
  { system: 'LIVER', indicates: 'excess', text: 'Craves proteins, fats' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Craves fruit or sweets' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Frequent trouble digesting fats' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Acne on face AND buttocks' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Seems to have low blood sugar' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Had hepatitis in the past' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Frequent use of alcohol' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Work with solvents' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Psoriasis, eczema, dermatitis' },
  { system: 'LIVER', indicates: 'deficiency', text: 'Frequent minor illnesses' },
  { system: 'LIVER', indicates: 'excess', text: 'Fever w/ sweat when sick' },
  { system: 'LIVER', indicates: 'deficiency', text: "Don't sweat when sick" },
  // RENAL
  { system: 'RENAL', indicates: 'excess', text: 'Standing too quickly makes pulse roar in ears' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Standing too quickly causes faintness or dizziness' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Wakes up at night to urinate' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Frequent flushing or blushing' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Water retention with change of weather' },
  { system: 'RENAL', indicates: 'excess', text: 'Moderate high blood pressure, craves fats' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Moderate low blood pressure, craves sweets' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Frequent thirst' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Craving for salt' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Urine always light colored' },
  { system: 'RENAL', indicates: 'deficiency', text: 'Urine usually darker' },
  // LOWER URINARY TRACT
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Frequent urination, small amounts' },
  { system: 'LOWER_URINARY', indicates: 'excess', text: 'Infrequent urination, copious' },
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Sometimes dribbles urine afterwards' },
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Frequent bladder infections' },
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Demanding and sudden need to urinate' },
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Mucus in urine' },
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Benign prostatic hypertrophy (males)' },
  { system: 'LOWER_URINARY', indicates: 'deficiency', text: 'Dull ache after urination' },
  // REPRODUCTIVE - ALL
  { system: 'REPRODUCTIVE', indicates: 'excess', text: 'Sweat freely with strong scent' },
  { system: 'REPRODUCTIVE', indicates: 'excess', text: 'Oily skin, facial acne' },
  { system: 'REPRODUCTIVE', indicates: 'deficiency', text: 'Dry skin, cold hands and feet' },
  // WOMEN
  { system: 'WOMEN', indicates: 'deficiency', text: 'Cycle more than 28 days' },
  { system: 'WOMEN', indicates: 'excess', text: 'Cycle less than 28 days' },
  { system: 'WOMEN', indicates: 'excess', text: 'Water retention before menses, hips, breasts' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Water retention before menses, feet, hands' },
  { system: 'WOMEN', indicates: 'excess', text: 'Craves fats, proteins before menses' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Craves sweets before menses' },
  { system: 'WOMEN', indicates: 'excess', text: 'Sides of breasts tender before menses' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Miss some periods' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Menses slow starting with cramps' },
  { system: 'WOMEN', indicates: 'excess', text: 'Palpitations before menses' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Menstruation lengthy, frequent cramps' },
  { system: 'WOMEN', indicates: 'excess', text: 'Menstruation short, defined, few cramps' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Frequent Class II Pap Smears' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'History of PID, cervicitis' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Miscarriages, problem pregnancy' },
  { system: 'WOMEN', indicates: 'excess', text: 'Period early w/ altitude change' },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Period late w/ altitude change' },
  { system: 'WOMEN', indicates: 'deficiency', text: "Tried, but couldn't handle birth control pills" },
  { system: 'WOMEN', indicates: 'deficiency', text: 'Frequent candida/type infections' },
  // MEN
  { system: 'MEN', indicates: 'deficiency', text: 'Frequent cannabis user' },
  { system: 'MEN', indicates: 'deficiency', text: 'Pain or ache after orgasm' },
  { system: 'MEN', indicates: 'deficiency', text: 'Benign prostatic hypertrophy' },
  { system: 'MEN', indicates: 'deficiency', text: 'Difficult to maintain erection even when in mood' },
  // RESPIRATORY
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Short of breath when standing or walking' },
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Tobacco smoker' },
  { system: 'RESPIRATORY', indicates: 'excess', text: 'Easy coughing of mucus' },
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Difficulty swallowing mucus' },
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Rapid, shallow breather' },
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Wake up choking or gasping for breath' },
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Yawns frequently' },
  { system: 'RESPIRATORY', indicates: 'excess', text: 'Sometimes hyperventilates' },
  { system: 'RESPIRATORY', indicates: 'deficiency', text: 'Frequent chest colds' },
  // CARDIOVASCULAR
  { system: 'CARDIOVASCULAR', indicates: 'excess', text: 'Slow, strong pulse' },
  { system: 'CARDIOVASCULAR', indicates: 'deficiency', text: 'Fast, light pulse' },
  { system: 'CARDIOVASCULAR', indicates: 'excess', text: 'Frequent physical activity' },
  { system: 'CARDIOVASCULAR', indicates: 'excess', text: 'Warm bodied' },
  { system: 'CARDIOVASCULAR', indicates: 'deficiency', text: 'Cold bodied' },
  { system: 'CARDIOVASCULAR', indicates: 'deficiency', text: 'Sometimes dizzy or faint' },
  { system: 'CARDIOVASCULAR', indicates: 'excess', text: 'Hands warm, sweaty' },
  { system: 'CARDIOVASCULAR', indicates: 'deficiency', text: 'Hands cold, clammy or dry' },
  { system: 'CARDIOVASCULAR', indicates: 'excess', text: 'Palpitations as an adolescent or before menses' },
  { system: 'CARDIOVASCULAR', indicates: 'excess', text: 'Hypertension, responds to diuretics' },
  { system: 'CARDIOVASCULAR', indicates: 'deficiency', text: 'Hypertension, not responding to diuretics' },
  // LYMPHATIC
  { system: 'LYMPHATIC', indicates: 'excess', text: 'Recuperates quickly if ill' },
  { system: 'LYMPHATIC', indicates: 'deficiency', text: 'Recuperates slowly if ill' },
  { system: 'LYMPHATIC', indicates: 'excess', text: 'Injuries heal quickly' },
  { system: 'LYMPHATIC', indicates: 'deficiency', text: 'Injuries heal slowly' },
  { system: 'LYMPHATIC', indicates: 'deficiency', text: 'Eczema, dermatitis' },
  { system: 'LYMPHATIC', indicates: 'deficiency', text: 'Asthma or hay fever' },
  { system: 'LYMPHATIC', indicates: 'deficiency', text: 'Arthritis or rheumatism' },
  { system: 'LYMPHATIC', indicates: 'excess', text: 'Digests fats easily' },
  { system: 'LYMPHATIC', indicates: 'deficiency', text: 'Digests fats poorly' },
  // SKIN
  { system: 'SKIN', indicates: 'excess', text: 'Skin eruptions superficial, come to a head' },
  { system: 'SKIN', indicates: 'deficiency', text: 'Skin eruptions deep, not coming to a head' },
  { system: 'SKIN', indicates: 'deficiency', text: 'Skin on trunk is dry' },
  { system: 'SKIN', indicates: 'excess', text: 'Oily scalp or hair' },
  { system: 'SKIN', indicates: 'deficiency', text: 'Dry scalp or hair' },
  { system: 'SKIN', indicates: 'deficiency', text: 'Cracks, fissures on heel, feet, slow healing' },
  // MUCUS MEMBRANES
  { system: 'MUCUS', indicates: 'deficiency', text: 'Sores, cracks, on mouth, anus, vagina' },
  { system: 'MUCUS', indicates: 'deficiency', text: 'Lips often dry, chapped' },
  { system: 'MUCUS', indicates: 'deficiency', text: 'Food often causes intestinal pain passing through' },
  { system: 'MUCUS', indicates: 'deficiency', text: 'Gets sore throat easily' },
];

const GENERAL_QUESTIONS: string[] = [
  'Aluminum cooking vessels',
  "Awakens, can't go back to sleep",
  'Bad dreams',
  'Blurred vision',
  'Brown spots, bronzing of skin',
  'Bruises easily',
  "Can't gain weight",
  "Can't lose weight",
  "Can't get started without coffee",
  'Chemical or spray poisoning',
  'Chronic fatigue, depression',
  'Cry easily without seeming cause',
  'Depressed for long periods',
  'Earaches',
  'Eat often or else faint/nervous',
  'Eyes often red, inflamed',
  'Face, eyes get puffy',
  'Facial twitches',
  'Gum problems',
  'Headaches',
  'Headaches in morning, wearing off',
  'Heart palpitations when hungry',
  'Heart palpitations after eating',
  'Highly emotional',
  'Highly controlled',
  'Impaired hearing',
  'Increased in weight (recent)',
  'Lack of sensation somewhere in the body',
  'Likes depressants',
  'Likes stimulants',
  'Lower back pain',
  'Frequent muscle cramps',
  'Nails split, brittle',
  'Nails weak, ridges',
  'Nose bleeds frequently',
  'Pollution heavy in work or home environment',
  'Ringing in ears',
  'Pulse speeds up after meals',
  'Sensitive to cold weather',
  'Sensitive to hot weather',
  'Sensitive to high humidity',
  'Sensitive to low humidity',
  'Sexual desire decreased',
  'Sexual desire increased',
  'Stuffy nose during the day',
  'Stuffy nose in evening, night',
  'Tendency, seemingly, to anemia',
  'Tremors in hands or neck',
  'Varicose veins',
  'Weight gain in upper arms, shoulder, back of neck',
];

type Biology = 'AMAB' | 'AFAB';

type Stage = 'intro' | 'biology' | 'quiz-system' | 'quiz-general-intro' | 'quiz-general' | 'results';

type HerbSuggestion = {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part?: string | null;
  temperature?: string;
  moisture?: string;
  tone?: string;
  strength?: string;
  actions: string[];
};
type SystemHerbMap = Partial<Record<BodySystem, HerbSuggestion[]>>;

// Maps each MM intake system to the existing DB body_systems names that cover it.
const SYSTEM_TO_DB: Partial<Record<BodySystem, string[]>> = {
  UPPER_GI:       ['GI', 'Digestive'],
  LOWER_GI:       ['GI', 'Digestive'],
  LIVER:          ['GI', 'Digestive'],
  RENAL:          ['Urinary'],
  LOWER_URINARY:  ['Urinary'],
  REPRODUCTIVE:   ['Reproductive - Female', 'Reproductive - Male'],
  WOMEN:          ['Reproductive - Female'],
  MEN:            ['Reproductive - Male'],
  RESPIRATORY:    ['Upper Respiratory', 'Lower Respiratory', 'Respiratory'],
  CARDIOVASCULAR: ['Cardiovascular'],
  LYMPHATIC:      ['Immune'],
  SKIN:           ['Skin'],
  MUCUS:          ['GI', 'Skin', 'Digestive'],
};

type SystemScores = Record<BodySystem, { excess: number; deficiency: number }>;

const initialSystemScores = (): SystemScores =>
  Object.fromEntries(BODY_SYSTEMS.map(s => [s, { excess: 0, deficiency: 0 }])) as SystemScores;

interface SystemResult {
  system: BodySystem;
  label: string;
  pattern: 'excess' | 'deficiency' | 'mixed';
  total: number;
  excess: number;
  deficiency: number;
}

const STORAGE_KEY = 'michael-moore-intake-state';

function BiologyScreen({ onSelect }: { onSelect: (b: Biology) => void }) {
  return (
    <div className="flex flex-col gap-6">
      <div>
        <h3 className="font-semibold text-gray-800 dark:text-gray-100 mb-2">Assigned sex at birth</h3>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          This determines which reproductive section you'll see — Women or Men. The rest of the assessment is the same for everyone.
        </p>
      </div>
      <div className="flex flex-col gap-3">
        <button
          onClick={() => onSelect('AFAB')}
          className="w-full py-4 rounded-xl border-2 border-green-200 hover:border-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 font-medium text-gray-700 dark:text-gray-200 transition-all text-left px-5"
        >
          <span className="font-semibold">AFAB</span>
          <span className="block text-sm text-gray-500 dark:text-gray-400 font-normal mt-0.5">Assigned female at birth — includes Women&apos;s section</span>
        </button>
        <button
          onClick={() => onSelect('AMAB')}
          className="w-full py-4 rounded-xl border-2 border-green-200 hover:border-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 font-medium text-gray-700 dark:text-gray-200 transition-all text-left px-5"
        >
          <span className="font-semibold">AMAB</span>
          <span className="block text-sm text-gray-500 dark:text-gray-400 font-normal mt-0.5">Assigned male at birth — includes Men&apos;s section</span>
        </button>
      </div>
    </div>
  );
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onHerbSelect?: (herbId: number) => void;
}

type YesAnswers = Partial<Record<BodySystem, { excess: string[]; deficiency: string[] }>>;

export function IntakeFormModal({ isOpen, onClose, onHerbSelect }: Props) {
  const [stage, setStage] = useState<Stage>('intro');
  const [biology, setBiology] = useState<Biology | null>(null);
  const [sysIndex, setSysIndex] = useState(0);
  const [genIndex, setGenIndex] = useState(0);
  const [systemScores, setSystemScores] = useState<SystemScores>(initialSystemScores());
  const [generalAnswers, setGeneralAnswers] = useState<(0 | 1 | 2)[]>([]);
  const [yesAnswers, setYesAnswers] = useState<YesAnswers>({});
  const [systemHerbs, setSystemHerbs] = useState<SystemHerbMap>({});
  const [herbsLoading, setHerbsLoading] = useState(false);

  useEffect(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      if (saved) {
        const { stage: s, biology: b, sysIndex: si, genIndex: gi, systemScores: ss, generalAnswers: ga, yesAnswers: ya } = JSON.parse(saved);
        setStage(s);
        setBiology(b ?? null);
        setSysIndex(si ?? 0);
        setGenIndex(gi ?? 0);
        setSystemScores(ss ?? initialSystemScores());
        setGeneralAnswers(ga ?? []);
        setYesAnswers(ya ?? {});
      }
    } catch { /* ignore */ }
  }, []);

  useEffect(() => {
    if (stage === 'intro') return;
    localStorage.setItem(STORAGE_KEY, JSON.stringify({ stage, biology, sysIndex, genIndex, systemScores, generalAnswers, yesAnswers }));
  }, [stage, biology, sysIndex, genIndex, systemScores, generalAnswers, yesAnswers]);

  const reset = () => {
    localStorage.removeItem(STORAGE_KEY);
    setStage('intro');
    setBiology(null);
    setSysIndex(0);
    setGenIndex(0);
    setSystemScores(initialSystemScores());
    setGeneralAnswers([]);
    setYesAnswers({});
    setSystemHerbs({});
  };

  useEffect(() => {
    if (stage !== 'results') return;

    const activeResults = BODY_SYSTEMS.flatMap(sys => {
      const s = systemScores[sys];
      const total = s.excess + s.deficiency;
      if (total === 0) return [];
      const pattern: 'excess' | 'deficiency' | 'mixed' =
        s.excess > s.deficiency ? 'excess' : s.deficiency > s.excess ? 'deficiency' : 'mixed';
      return [{ system: sys, pattern }];
    });
    if (activeResults.length === 0) return;

    setHerbsLoading(true);

    (async () => {
      const { supabase } = await import('@/lib/supabase');

      const allDbSystemNames = [...new Set(
        activeResults.flatMap(r => SYSTEM_TO_DB[r.system] ?? [])
      )];

      const [{ data: dbSystems }, { data: actionPatterns }] = await Promise.all([
        supabase.from('body_systems').select('id, name').in('name', allDbSystemNames),
        supabase.from('action_pattern').select('primary_action_id, pattern'),
      ]);

      if (!dbSystems?.length || !actionPatterns?.length) {
        setHerbsLoading(false);
        return;
      }

      const systemIdByName: Record<string, number> = Object.fromEntries(
        dbSystems.map((s: { id: number; name: string }) => [s.name, s.id])
      );
      const defActionIds: number[] = actionPatterns
        .filter((ap: { pattern: string }) => ap.pattern === 'deficiency')
        .map((ap: { primary_action_id: number }) => ap.primary_action_id);
      const exActionIds: number[] = actionPatterns
        .filter((ap: { pattern: string }) => ap.pattern === 'excess')
        .map((ap: { primary_action_id: number }) => ap.primary_action_id);

      const herbMap: SystemHerbMap = {};

      await Promise.all(activeResults.map(async ({ system, pattern }) => {
        const dbNames = SYSTEM_TO_DB[system];
        if (!dbNames) return;
        const dbIds = dbNames.map(n => systemIdByName[n]).filter((id): id is number => id !== undefined);
        if (dbIds.length === 0) return;

        const actionIds = pattern === 'excess' ? exActionIds
          : pattern === 'deficiency' ? defActionIds
          : [...defActionIds, ...exActionIds];

        const { data, error } = await supabase
          .from('herb_primary_actions')
          .select('relative_strength, primary_actions(name), herbs(id, common_name, latin_name, plant_part, temperature, moisture, tone)')
          .in('body_system_id', dbIds)
          .in('primary_action_id', actionIds);

        console.log('[IntakeDebug] rows:', data?.length, 'error:', error, 'first:', JSON.stringify(data?.[0]));
        if (!data) return;
        const strengthRank = (s?: string | null) => {
          switch (s) { case 'very_strong': return 4; case 'strong': return 3; case 'moderate': return 2; case 'mild': return 1; default: return 0; }
        };
        const seen = new Map<number, HerbSuggestion>();
        for (const row of data) {
          const h = row.herbs as unknown as Omit<HerbSuggestion, 'strength' | 'actions'> | null;
          if (!h) continue;
          const rs = (row as { relative_strength?: string | null }).relative_strength ?? undefined;
          const pa = (row as unknown as { primary_actions?: { name: string } | { name: string }[] | null }).primary_actions;
          const actionName = Array.isArray(pa) ? pa[0]?.name : pa?.name;
          const existing = seen.get(h.id);
          if (!existing) {
            seen.set(h.id, { ...h, strength: rs, actions: actionName ? [actionName] : [] });
          } else {
            if (strengthRank(rs) > strengthRank(existing.strength)) existing.strength = rs;
            if (actionName && !existing.actions.includes(actionName)) existing.actions.push(actionName);
          }
        }
        const herbs = [...seen.values()];
        herbs.sort((a, b) => strengthRank(b.strength) - strengthRank(a.strength) || a.common_name.localeCompare(b.common_name));
        herbMap[system] = herbs;
      }));

      setSystemHerbs(herbMap);
      setHerbsLoading(false);
    })();
  }, [stage, systemScores]);

  const filteredSystemQuestions = biology === null
    ? SYSTEM_QUESTIONS
    : SYSTEM_QUESTIONS.filter(q =>
        biology === 'AMAB' ? q.system !== 'WOMEN' : q.system !== 'MEN'
      );

  const answerSystem = (yes: boolean) => {
    if (yes) {
      const q = filteredSystemQuestions[sysIndex];
      setSystemScores(prev => {
        const next = { ...prev, [q.system]: { ...prev[q.system] } };
        next[q.system][q.indicates] += 1;
        return next;
      });
      setYesAnswers(prev => {
        const sys = prev[q.system] ?? { excess: [], deficiency: [] };
        return { ...prev, [q.system]: { ...sys, [q.indicates]: [...sys[q.indicates], q.text] } };
      });
    }
    if (sysIndex + 1 >= filteredSystemQuestions.length) {
      setStage('quiz-general-intro');
    } else {
      setSysIndex(i => i + 1);
    }
  };

  const answerGeneral = (value: 0 | 1 | 2) => {
    setGeneralAnswers(prev => [...prev, value]);
    if (genIndex + 1 >= GENERAL_QUESTIONS.length) {
      setStage('results');
    } else {
      setGenIndex(i => i + 1);
    }
  };

  const getSystemResults = (): SystemResult[] => {
    const results: SystemResult[] = [];
    for (const sys of BODY_SYSTEMS) {
      const scores = systemScores[sys];
      const total = scores.excess + scores.deficiency;
      if (total === 0) continue;
      const pattern: 'excess' | 'deficiency' | 'mixed' =
        scores.excess > scores.deficiency ? 'excess' :
        scores.deficiency > scores.excess ? 'deficiency' : 'mixed';
      results.push({ system: sys, label: SYSTEM_LABELS[sys], pattern, total, excess: scores.excess, deficiency: scores.deficiency });
    }
    return results.sort((a, b) => b.total - a.total);
  };

  const totalQuestions = filteredSystemQuestions.length + GENERAL_QUESTIONS.length;
  const currentProgress =
    stage === 'quiz-system' ? sysIndex :
    stage === 'quiz-general-intro' ? filteredSystemQuestions.length :
    stage === 'quiz-general' ? filteredSystemQuestions.length + genIndex : 0;

  return (
    <div
      className={`fixed top-0 right-0 h-full w-[480px] z-40 bg-white dark:bg-gray-800 shadow-2xl border-l border-gray-200 dark:border-gray-700 flex flex-col transition-transform duration-300 ease-in-out ${isOpen ? 'translate-x-0' : 'translate-x-full'}`}
    >
      <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200 dark:border-gray-700 shrink-0">
        <h2 className="text-lg font-bold text-green-800 dark:text-green-300">📋 Intake Assessment</h2>
        <div className="flex items-center gap-3">
          {stage !== 'intro' && (
            <button
              onClick={reset}
              className="text-xs text-gray-400 hover:text-red-500 dark:hover:text-red-400 transition-colors"
            >
              Start Over
            </button>
          )}
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 text-xl leading-none"
            aria-label="Close"
          >
            ✕
          </button>
        </div>
      </div>

      <div className="flex-1 overflow-y-auto px-6 py-6">
        {stage === 'intro' && <IntroScreen onStart={() => setStage('biology')} />}
        {stage === 'biology' && (
          <BiologyScreen onSelect={(b) => { setBiology(b); setStage('quiz-system'); }} />
        )}
        {stage === 'quiz-system' && (
          <SystemQuizScreen
            question={filteredSystemQuestions[sysIndex]}
            sysIndex={sysIndex}
            totalQuestions={totalQuestions}
            currentProgress={currentProgress}
            onAnswer={answerSystem}
          />
        )}
        {stage === 'quiz-general-intro' && (
          <GeneralIntroScreen onContinue={() => setStage('quiz-general')} />
        )}
        {stage === 'quiz-general' && (
          <GeneralQuizScreen
            question={GENERAL_QUESTIONS[genIndex]}
            genIndex={genIndex}
            totalQuestions={totalQuestions}
            currentProgress={currentProgress}
            onAnswer={answerGeneral}
          />
        )}
        {stage === 'results' && (
          <ResultsScreen
            systemResults={getSystemResults()}
            dominantComplaints={GENERAL_QUESTIONS.filter((_, i) => generalAnswers[i] === 2)}
            mildComplaints={GENERAL_QUESTIONS.filter((_, i) => generalAnswers[i] === 1)}
            systemHerbs={systemHerbs}
            herbsLoading={herbsLoading}
            yesAnswers={yesAnswers}
            onRetake={reset}
            onHerbSelect={onHerbSelect}
          />
        )}
      </div>
    </div>
  );
}

function IntroScreen({ onStart }: { onStart: () => void }) {
  return (
    <div className="flex flex-col gap-5">
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        This assessment is adapted from <strong>Michael Moore's physiomedicalist intake form</strong>, used to identify patterns of excess and deficiency across body systems.
      </p>
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        Answer <strong>Yes</strong> or <strong>No</strong> for each body system symptom. Then rate general complaints as <strong>None</strong>, <strong>Mild</strong>, or <strong>Dominant</strong>. Your responses will reveal which body systems are most active and whether they trend toward excess or deficiency.
      </p>
      <ul className="text-sm text-gray-500 dark:text-gray-400 space-y-1 pl-4 list-disc">
        <li>{SYSTEM_QUESTIONS.length} body system symptoms across 13 systems</li>
        <li>{GENERAL_QUESTIONS.length} general complaint questions</li>
        <li>Progress is saved automatically</li>
      </ul>
      <button
        onClick={onStart}
        className="self-center px-8 py-3 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors"
      >
        Begin →
      </button>
    </div>
  );
}

function ProgressBar({ current, total }: { current: number; total: number }) {
  const pct = Math.round((current / total) * 100);
  return (
    <div>
      <div className="flex justify-between text-xs text-gray-400 mb-1">
        <span>{current} of {total}</span>
        <span>{pct}%</span>
      </div>
      <div className="h-2 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
        <div
          className="h-full bg-green-500 rounded-full transition-all duration-300"
          style={{ width: `${pct}%` }}
        />
      </div>
    </div>
  );
}

function SystemBadge({ system, indicates }: { system: BodySystem; indicates: 'excess' | 'deficiency' }) {
  const skipNote = system === 'WOMEN' || system === 'MEN' ? ' — skip if not applicable' : '';
  return (
    <div className="flex items-center gap-2 flex-wrap">
      <span className="px-2 py-0.5 bg-green-100 dark:bg-green-900/40 text-green-800 dark:text-green-300 rounded text-xs font-medium">
        {SYSTEM_LABELS[system]}{skipNote}
      </span>
      <span className={`px-2 py-0.5 rounded text-xs font-medium ${
        indicates === 'excess'
          ? 'bg-amber-100 dark:bg-amber-900/30 text-amber-800 dark:text-amber-300'
          : 'bg-blue-100 dark:bg-blue-900/30 text-blue-800 dark:text-blue-300'
      }`}>
        → {indicates === 'excess' ? 'Excess' : 'Deficiency'}
      </span>
    </div>
  );
}

function SystemQuizScreen({
  question,
  sysIndex,
  totalQuestions,
  currentProgress,
  onAnswer,
}: {
  question: SystemQuestion;
  sysIndex: number;
  totalQuestions: number;
  currentProgress: number;
  onAnswer: (yes: boolean) => void;
}) {
  return (
    <div className="flex flex-col gap-5">
      <ProgressBar current={currentProgress} total={totalQuestions} />
      <SystemBadge system={question.system} indicates={question.indicates} />

      <div className="rounded-xl border-2 border-green-200 dark:border-green-700 bg-green-50 dark:bg-green-900/30 p-6 min-h-24 flex items-center justify-center">
        <p className="text-lg font-medium text-center text-gray-800 dark:text-gray-100">
          {question.text}
        </p>
      </div>

      <div className="flex gap-4">
        <button
          onClick={() => onAnswer(false)}
          className="flex-1 py-3 rounded-lg border-2 border-gray-200 hover:border-gray-400 hover:bg-gray-50 dark:hover:bg-gray-700 font-medium text-gray-600 dark:text-gray-300 transition-all"
        >
          No
        </button>
        <button
          onClick={() => onAnswer(true)}
          className="flex-1 py-3 rounded-lg border-2 border-green-300 hover:border-green-500 hover:bg-green-50 dark:hover:bg-green-900/30 font-medium text-green-700 dark:text-green-400 transition-all"
        >
          Yes
        </button>
      </div>

      <p className="text-xs text-center text-gray-400 dark:text-gray-500">
        Question {sysIndex + 1} of {SYSTEM_QUESTIONS.length} (body systems)
      </p>
    </div>
  );
}

function GeneralIntroScreen({ onContinue }: { onContinue: () => void }) {
  return (
    <div className="flex flex-col gap-5 items-center text-center">
      <div className="text-4xl">✅</div>
      <h3 className="text-lg font-bold text-gray-800 dark:text-gray-100">Body Systems Complete</h3>
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        Next: <strong>General Complaints</strong>. For each condition, rate how frequently you experience it:
      </p>
      <div className="flex flex-col gap-2 w-full text-left">
        <div className="flex items-center gap-3 px-3 py-2 rounded-lg bg-gray-50 dark:bg-gray-700/50">
          <span className="px-2 py-0.5 bg-gray-200 dark:bg-gray-600 text-gray-700 dark:text-gray-200 rounded text-xs font-medium w-20 text-center">None</span>
          <span className="text-sm text-gray-600 dark:text-gray-300">Not a condition you have</span>
        </div>
        <div className="flex items-center gap-3 px-3 py-2 rounded-lg bg-amber-50 dark:bg-amber-900/20">
          <span className="px-2 py-0.5 bg-amber-200 dark:bg-amber-800/50 text-amber-800 dark:text-amber-300 rounded text-xs font-medium w-20 text-center">Mild</span>
          <span className="text-sm text-gray-600 dark:text-gray-300">Occasional or moderate</span>
        </div>
        <div className="flex items-center gap-3 px-3 py-2 rounded-lg bg-rose-50 dark:bg-rose-900/20">
          <span className="px-2 py-0.5 bg-rose-200 dark:bg-rose-800/50 text-rose-800 dark:text-rose-300 rounded text-xs font-medium w-20 text-center">Dominant</span>
          <span className="text-sm text-gray-600 dark:text-gray-300">Frequent or significant</span>
        </div>
      </div>
      <button
        onClick={onContinue}
        className="px-8 py-3 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors"
      >
        Continue →
      </button>
    </div>
  );
}

function GeneralQuizScreen({
  question,
  genIndex,
  totalQuestions,
  currentProgress,
  onAnswer,
}: {
  question: string;
  genIndex: number;
  totalQuestions: number;
  currentProgress: number;
  onAnswer: (value: 0 | 1 | 2) => void;
}) {
  return (
    <div className="flex flex-col gap-5">
      <ProgressBar current={currentProgress} total={totalQuestions} />
      <span className="px-2 py-0.5 bg-purple-100 dark:bg-purple-900/40 text-purple-800 dark:text-purple-300 rounded text-xs font-medium self-start">
        General Complaints
      </span>

      <div className="rounded-xl border-2 border-green-200 dark:border-green-700 bg-green-50 dark:bg-green-900/30 p-6 min-h-24 flex items-center justify-center">
        <p className="text-lg font-medium text-center text-gray-800 dark:text-gray-100">
          {question}
        </p>
      </div>

      <div className="flex gap-3">
        <button
          onClick={() => onAnswer(0)}
          className="flex-1 py-3 rounded-lg border-2 border-gray-200 hover:border-gray-400 hover:bg-gray-50 dark:hover:bg-gray-700 font-medium text-gray-600 dark:text-gray-300 transition-all text-sm"
        >
          None
        </button>
        <button
          onClick={() => onAnswer(1)}
          className="flex-1 py-3 rounded-lg border-2 border-amber-300 hover:border-amber-500 hover:bg-amber-50 dark:hover:bg-amber-900/20 font-medium text-amber-700 dark:text-amber-400 transition-all text-sm"
        >
          Mild
        </button>
        <button
          onClick={() => onAnswer(2)}
          className="flex-1 py-3 rounded-lg border-2 border-rose-300 hover:border-rose-500 hover:bg-rose-50 dark:hover:bg-rose-900/20 font-medium text-rose-700 dark:text-rose-400 transition-all text-sm"
        >
          Dominant
        </button>
      </div>

      <p className="text-xs text-center text-gray-400 dark:text-gray-500">
        Question {genIndex + 1} of {GENERAL_QUESTIONS.length} (general complaints)
      </p>
    </div>
  );
}

function PatternBadge({ pattern }: { pattern: 'excess' | 'deficiency' | 'mixed' }) {
  if (pattern === 'excess') {
    return (
      <span className="px-2 py-0.5 bg-amber-100 dark:bg-amber-900/30 text-amber-800 dark:text-amber-300 rounded text-xs font-bold">
        Excess
      </span>
    );
  }
  if (pattern === 'deficiency') {
    return (
      <span className="px-2 py-0.5 bg-blue-100 dark:bg-blue-900/30 text-blue-800 dark:text-blue-300 rounded text-xs font-bold">
        Deficiency
      </span>
    );
  }
  return (
    <span className="px-2 py-0.5 bg-purple-100 dark:bg-purple-900/30 text-purple-800 dark:text-purple-300 rounded text-xs font-bold">
      Mixed
    </span>
  );
}

function HerbCardList({ herbs, isExpanded, onToggle, onHerbSelect }: {
  herbs: HerbSuggestion[];
  isExpanded: boolean;
  onToggle: () => void;
  onHerbSelect?: (herbId: number) => void;
}) {
  const visible = isExpanded ? herbs : herbs.slice(0, 10);
  const hasMore = herbs.length > 10;
  return (
    <div className="mt-2">
      <div className="grid grid-cols-2 gap-1.5">
        {visible.map(herb => {
          const cardBg = herb.temperature === 'warming'
            ? 'bg-amber-50 border-amber-200 hover:bg-amber-100 dark:bg-amber-900/20 dark:border-amber-700'
            : herb.temperature === 'cooling'
            ? 'bg-sky-50 border-sky-200 hover:bg-sky-100 dark:bg-sky-900/20 dark:border-sky-700'
            : 'bg-gray-50 border-gray-200 hover:bg-gray-100 dark:bg-gray-800/40 dark:border-gray-600';
          const strengthCls = herb.strength === 'very_strong' ? 'bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-300'
            : herb.strength === 'strong' ? 'bg-orange-100 text-orange-700 dark:bg-orange-900/40 dark:text-orange-300'
            : herb.strength === 'moderate' ? 'bg-yellow-100 text-yellow-700 dark:bg-yellow-900/40 dark:text-yellow-300'
            : herb.strength === 'mild' ? 'bg-green-100 text-green-700 dark:bg-green-900/40 dark:text-green-300'
            : null;
          const Tag = onHerbSelect ? 'button' : 'div';
          return (
            <Tag
              key={herb.id}
              {...(onHerbSelect ? { onClick: () => onHerbSelect(herb.id) } : {})}
              className={`group text-left border rounded-lg py-1.5 px-2.5 transition-all ${cardBg} ${onHerbSelect ? 'cursor-pointer hover:shadow-sm hover:scale-[1.01]' : ''}`}
            >
              <div className="flex items-start justify-between gap-1">
                <span className="font-semibold text-gray-900 dark:text-gray-100 text-xs leading-snug">{herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}</span>
                <EnergeticEmojis temperature={herb.temperature} moisture={herb.moisture} tone={herb.tone} className="text-xs leading-none shrink-0 mt-0.5" />
              </div>
              <div className="text-xs italic text-gray-500 dark:text-gray-400 leading-snug">{herb.latin_name}</div>
              {strengthCls && (
                <span className={`inline-block mt-1 text-[10px] font-semibold px-1.5 py-0.5 rounded ${strengthCls}`}>
                  {herb.strength!.replace('_', ' ')}
                </span>
              )}
              {herb.actions.length > 0 && (
                <div className="hidden group-hover:block mt-1.5 pt-1.5 border-t border-black/10 dark:border-white/10 text-[10px] text-gray-500 dark:text-gray-400 leading-relaxed">
                  {herb.actions.join(' · ')}
                </div>
              )}
            </Tag>
          );
        })}
      </div>
      {hasMore && (
        <button
          onClick={onToggle}
          className="flex items-center gap-1 mt-2 text-xs text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 transition-colors"
        >
          <svg className={`w-3.5 h-3.5 transition-transform ${isExpanded ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2.5}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
          </svg>
          {isExpanded ? 'Show less' : `Show ${herbs.length - 10} more`}
        </button>
      )}
    </div>
  );
}

function ResultsScreen({
  systemResults,
  dominantComplaints,
  mildComplaints,
  systemHerbs,
  herbsLoading,
  yesAnswers,
  onRetake,
  onHerbSelect,
}: {
  systemResults: SystemResult[];
  dominantComplaints: string[];
  mildComplaints: string[];
  systemHerbs: SystemHerbMap;
  herbsLoading: boolean;
  yesAnswers: YesAnswers;
  onRetake: () => void;
  onHerbSelect?: (herbId: number) => void;
}) {
  const [expandedSystems, setExpandedSystems] = useState<Set<string>>(new Set());
  const toggleExpanded = (sys: string) =>
    setExpandedSystems(prev => { const s = new Set(prev); s.has(sys) ? s.delete(sys) : s.add(sys); return s; });
  const [activeTooltip, setActiveTooltip] = useState<{ system: string; kind: 'excess' | 'deficiency' } | null>(null);

  const hasAnyResults = systemResults.length > 0 || dominantComplaints.length > 0 || mildComplaints.length > 0;

  if (!hasAnyResults) {
    return (
      <div className="flex flex-col gap-6 items-center text-center">
        <p className="text-gray-600 dark:text-gray-300">
          No significant findings — no symptoms were reported.
        </p>
        <button
          onClick={onRetake}
          className="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium"
        >
          Retake Assessment
        </button>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-6">
      {systemResults.length > 0 && (
        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-gray-800 dark:text-gray-100 text-sm uppercase tracking-wide">
            Body System Findings
          </h3>
          <p className="text-xs text-gray-500 dark:text-gray-400">
            Ranked by number of responses. Pattern determined by majority of Yes answers.
          </p>
          {systemResults.map((result) => (
            <div
              key={result.system}
              className={`rounded-xl border-2 p-4 ${
                result.pattern === 'excess'
                  ? 'border-amber-200 dark:border-amber-700 bg-amber-50 dark:bg-amber-900/10'
                  : result.pattern === 'deficiency'
                    ? 'border-blue-200 dark:border-blue-700 bg-blue-50 dark:bg-blue-900/10'
                    : 'border-purple-200 dark:border-purple-700 bg-purple-50 dark:bg-purple-900/10'
              }`}
            >
              <div className="flex items-center justify-between mb-2">
                <div className="flex items-center gap-2">
                  <span className="font-semibold text-gray-800 dark:text-gray-100 text-sm">
                    {result.label}
                  </span>
                  <PatternBadge pattern={result.pattern} />
                </div>
                <span className="text-xs text-gray-400 dark:text-gray-500">
                  {result.total} response{result.total !== 1 ? 's' : ''}
                </span>
              </div>
              <div className="flex gap-3 text-xs mb-2">
                {result.excess > 0 && (
                  <div className="relative">
                    <span
                      className="text-amber-700 dark:text-amber-400 cursor-default underline decoration-dotted"
                      onMouseEnter={() => setActiveTooltip({ system: result.system, kind: 'excess' })}
                      onMouseLeave={() => setActiveTooltip(null)}
                    >
                      {result.excess} excess
                    </span>
                    {activeTooltip?.system === result.system && activeTooltip?.kind === 'excess' && (
                      <div className="absolute left-0 top-full mt-1 z-20 bg-white dark:bg-gray-900 border border-amber-200 dark:border-amber-700 rounded-lg shadow-lg p-3 w-64 pointer-events-none">
                        <div className="text-[10px] font-semibold text-amber-700 dark:text-amber-400 uppercase tracking-wide mb-1.5">Excess responses</div>
                        <ul className="flex flex-col gap-1">
                          {(yesAnswers[result.system]?.excess ?? []).map((q, i) => (
                            <li key={i} className="text-[11px] text-gray-600 dark:text-gray-300 leading-snug">• {q}</li>
                          ))}
                        </ul>
                      </div>
                    )}
                  </div>
                )}
                {result.deficiency > 0 && (
                  <div className="relative">
                    <span
                      className="text-blue-700 dark:text-blue-400 cursor-default underline decoration-dotted"
                      onMouseEnter={() => setActiveTooltip({ system: result.system, kind: 'deficiency' })}
                      onMouseLeave={() => setActiveTooltip(null)}
                    >
                      {result.deficiency} deficiency
                    </span>
                    {activeTooltip?.system === result.system && activeTooltip?.kind === 'deficiency' && (
                      <div className="absolute left-0 top-full mt-1 z-20 bg-white dark:bg-gray-900 border border-blue-200 dark:border-blue-700 rounded-lg shadow-lg p-3 w-64 pointer-events-none">
                        <div className="text-[10px] font-semibold text-blue-700 dark:text-blue-400 uppercase tracking-wide mb-1.5">Deficiency responses</div>
                        <ul className="flex flex-col gap-1">
                          {(yesAnswers[result.system]?.deficiency ?? []).map((q, i) => (
                            <li key={i} className="text-[11px] text-gray-600 dark:text-gray-300 leading-snug">• {q}</li>
                          ))}
                        </ul>
                      </div>
                    )}
                  </div>
                )}
              </div>
              {herbsLoading && !systemHerbs[result.system] && (
                <p className="text-xs text-gray-400 dark:text-gray-500 italic">Loading herbs…</p>
              )}
              {systemHerbs[result.system]?.length ? (
                <HerbCardList
                  herbs={systemHerbs[result.system]!}
                  isExpanded={expandedSystems.has(result.system)}
                  onToggle={() => toggleExpanded(result.system)}
                  onHerbSelect={onHerbSelect}
                />
              ) : null}
            </div>
          ))}
        </div>
      )}

      {dominantComplaints.length > 0 && (
        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-gray-800 dark:text-gray-100 text-sm uppercase tracking-wide">
            Dominant Complaints
          </h3>
          <div className="flex flex-wrap gap-2">
            {dominantComplaints.map((complaint) => (
              <span
                key={complaint}
                className="px-3 py-1.5 bg-rose-100 dark:bg-rose-900/30 text-rose-800 dark:text-rose-300 rounded-lg text-sm font-medium"
              >
                {complaint}
              </span>
            ))}
          </div>
        </div>
      )}

      {mildComplaints.length > 0 && (
        <div className="flex flex-col gap-3">
          <h3 className="font-bold text-gray-800 dark:text-gray-100 text-sm uppercase tracking-wide">
            Mild Complaints
          </h3>
          <div className="flex flex-wrap gap-2">
            {mildComplaints.map((complaint) => (
              <span
                key={complaint}
                className="px-3 py-1.5 bg-amber-100 dark:bg-amber-900/30 text-amber-800 dark:text-amber-300 rounded-lg text-sm"
              >
                {complaint}
              </span>
            ))}
          </div>
        </div>
      )}

      <button
        onClick={onRetake}
        className="self-center px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors"
      >
        Retake Assessment
      </button>
    </div>
  );
}
