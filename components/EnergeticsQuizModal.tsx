'use client';

import { useEffect, useState } from 'react';
import { ArrowRightIcon, FireIcon, XMarkIcon } from '@heroicons/react/24/outline';

type Dimension = 'cold' | 'hot' | 'damp' | 'dry' | 'tense' | 'lax';

interface Question {
  text: string;
  dimensions: Dimension[];
}

const QUESTIONS: Question[] = [
  { text: 'Do you often feel cold — cold hands or feet, or an aversion to cold weather?', dimensions: ['cold'] },
  { text: 'Do you experience fatigue, low energy, or tend to move slowly?', dimensions: ['cold'] },
  { text: 'Do you experience depression or apathy?', dimensions: ['cold'] },
  { text: 'Do you get constipation or chronic bloating?', dimensions: ['cold'] },
  { text: 'Do you have low immunity — getting sick frequently?', dimensions: ['cold'] },
  { text: 'Do you experience achy or dull pain (as opposed to sharp pain)?', dimensions: ['cold'] },
  { text: 'Do you tend toward irritability or anger?', dimensions: ['hot'] },
  { text: 'Do you have red or inflamed skin?', dimensions: ['hot'] },
  { text: 'Do you feel restless, or oversensitive to stimuli?', dimensions: ['hot'] },
  { text: 'Do you experience sharp or stabbing pain?', dimensions: ['hot'] },
  { text: 'Do you have excess thirst or strong body odors?', dimensions: ['hot'] },
  { text: 'Do you have an aversion to heat?', dimensions: ['hot'] },
  { text: 'Do you have chronic congestion, phlegm, or excess mucus?', dimensions: ['damp'] },
  { text: 'Do you tend toward loose stools or nausea?', dimensions: ['damp'] },
  { text: 'Do you experience swelling in your extremities or lymph nodes?', dimensions: ['damp'] },
  { text: 'Do your limbs often feel heavy or sluggish?', dimensions: ['damp'] },
  { text: 'Do you have excess discharge of any kind?', dimensions: ['damp', 'lax'] },
  { text: 'Do you have dry eyes, mouth, or skin?', dimensions: ['dry'] },
  { text: 'Do you have brittle nails or hair?', dimensions: ['dry'] },
  { text: 'Do you have stiff or creaky joints?', dimensions: ['dry'] },
  { text: 'Do you tend toward hard, pebbly stools?', dimensions: ['dry'] },
  { text: 'Do you often feel frazzled, on high alert, or have static mental energy?', dimensions: ['dry'] },
  { text: 'Do you carry chronic muscle tension — tight muscles, neck tension?', dimensions: ['tense'] },
  { text: 'Do you experience muscle spasms or cramps?', dimensions: ['tense'] },
  { text: 'Do you tend toward constipation with a tight, crampy quality (IBS-C)?', dimensions: ['tense'] },
  { text: 'Do you sweat excessively?', dimensions: ['lax'] },
  { text: 'Do you have frequent diarrhea or vomiting?', dimensions: ['lax'] },
  { text: 'Do you have chronic infections, a leaky bladder, or muscle weakness?', dimensions: ['lax'] },
];

const DIMENSION_INFO: Record<Dimension, {
  label: string;
  need: string;
  emoji: string;
  description: string;
  herbs: string[];
}> = {
  cold: {
    label: 'Cold',
    need: 'Warming',
    emoji: '🥶',
    description: 'Your body needs stimulating, warming herbs to increase vitality, circulation, and metabolic fire.',
    herbs: ['Ginger', 'Ashwagandha', 'Rosemary', 'Thyme', 'Cayenne', 'Garlic', 'Turmeric', 'Ginseng', 'Maca', 'Yerba Mansa'],
  },
  hot: {
    label: 'Hot',
    need: 'Cooling',
    emoji: '🔥',
    description: 'Your body needs cooling herbs to soothe inflammation, irritation, and excess heat.',
    herbs: ['Lemon Balm', 'Violet', 'Rosehips', 'Licorice', 'Vervain', 'Peach'],
  },
  damp: {
    label: 'Damp',
    need: 'Drying',
    emoji: '💧',
    description: 'Your body needs drying herbs to remove excess fluid, reduce congestion, and restore healthy flow.',
    herbs: ['Nettles', 'Ginger', 'Rosemary', 'Rhodiola', 'Rose', 'Yerba Santa', 'Chasteberry', 'Scots Pine'],
  },
  dry: {
    label: 'Dry',
    need: 'Moistening',
    emoji: '🏜️',
    description: 'Your body needs moistening herbs to lubricate and soothe dry, brittle tissues.',
    herbs: ['Marshmallow', 'Violet', 'Licorice', 'Mullein', 'Plantain', 'Shatavari', 'Aloe', 'Oat'],
  },
  tense: {
    label: 'Tense',
    need: 'Relaxing',
    emoji: '😬',
    description: 'Your body needs relaxing herbs to release muscle tension, spasm, and constriction.',
    herbs: ['Catnip', 'Kava', 'Silk Tassel'],
  },
  lax: {
    label: 'Lax',
    need: 'Toning',
    emoji: '🫠',
    description: 'Your body needs toning herbs to strengthen lax tissues and reduce excess secretion or discharge.',
    herbs: ['Yarrow', 'Raspberry', 'Rose', 'Plantain', 'Oak', 'Witch Hazel', "Shepherd's Purse", 'Schizandra'],
  },
};

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onHerbSelect?: (herbName: string) => void;
}

type Stage = 'intro' | 'quiz' | 'results';

const STORAGE_KEY = 'energetics-quiz-state';

export function EnergeticsQuizModal({ isOpen, onClose, onHerbSelect }: Props) {
  const [stage, setStage] = useState<Stage>('intro');
  const [questionIndex, setQuestionIndex] = useState(0);
  const [scores, setScores] = useState<Record<Dimension, number>>({
    cold: 0, hot: 0, damp: 0, dry: 0, tense: 0, lax: 0,
  });

  useEffect(() => {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      if (saved) {
        const { stage: s, questionIndex: q, scores: sc } = JSON.parse(saved);
        setStage(s);
        setQuestionIndex(q);
        setScores(sc);
      }
    } catch { /* ignore */ }
  }, []);

  useEffect(() => {
    if (stage === 'intro') return;
    localStorage.setItem(STORAGE_KEY, JSON.stringify({ stage, questionIndex, scores }));
  }, [stage, questionIndex, scores]);

  const reset = () => {
    localStorage.removeItem(STORAGE_KEY);
    setStage('intro');
    setQuestionIndex(0);
    setScores({ cold: 0, hot: 0, damp: 0, dry: 0, tense: 0, lax: 0 });
  };

  const answer = (yes: boolean) => {
    if (yes) {
      const q = QUESTIONS[questionIndex];
      setScores((prev) => {
        const next = { ...prev };
        q.dimensions.forEach((d) => { next[d] += 1; });
        return next;
      });
    }
    if (questionIndex + 1 >= QUESTIONS.length) {
      setStage('results');
    } else {
      setQuestionIndex((i) => i + 1);
    }
  };

  const topDimensions = (): Dimension[] => {
    const pairs = (Object.entries(scores) as [Dimension, number][]).filter(([, v]) => v > 0);
    if (pairs.length === 0) return [];
    const max = Math.max(...pairs.map(([, v]) => v));
    return pairs
      .filter(([, v]) => v >= max - 1)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 3)
      .map(([d]) => d);
  };

  return (
    <div
      className={`fixed top-0 right-0 h-full w-[440px] z-40 bg-white dark:bg-gray-800 shadow-2xl border-l border-gray-200 dark:border-gray-700 flex flex-col transition-transform duration-300 ease-in-out ${isOpen ? 'translate-x-0' : 'translate-x-full'}`}
    >
      <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200 dark:border-gray-700 shrink-0">
        <h2 className="text-lg font-bold text-green-800 dark:text-green-300 flex items-center gap-2"><FireIcon className="w-5 h-5" /> Energetics Quiz</h2>
        <button
          onClick={onClose}
          className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
          aria-label="Close"
        >
          <XMarkIcon className="w-5 h-5" />
        </button>
      </div>

      <div className="flex-1 overflow-y-auto px-6 py-6">
        {stage === 'intro' && <IntroScreen onStart={() => setStage('quiz')} />}
        {stage === 'quiz' && (
          <QuizScreen
            question={QUESTIONS[questionIndex]}
            index={questionIndex}
            total={QUESTIONS.length}
            onAnswer={answer}
          />
        )}
        {stage === 'results' && (
          <ResultsScreen top={topDimensions()} scores={scores} onRetake={reset} onHerbSelect={onHerbSelect} />
        )}
      </div>
    </div>
  );
}

function IntroScreen({ onStart }: { onStart: () => void }) {
  return (
    <div className="flex flex-col gap-5">
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        In western herbalism, <strong>energetics</strong> describes the state of physiological imbalance in the body — and the corresponding properties herbs carry to restore balance.
      </p>
      <p className="text-gray-600 dark:text-gray-300 leading-relaxed">
        Answer yes or no to a series of symptom questions. The quiz will identify your energetic pattern across temperature (cold/hot), moisture (dry/damp), and structure (tense/lax) — then suggest herbs to bring you back into balance.
      </p>
      <button
        onClick={onStart}
        className="self-center px-8 py-3 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors flex items-center gap-2"
      >
        Begin <ArrowRightIcon className="w-4 h-4" />
      </button>
    </div>
  );
}

function QuizScreen({
  question,
  index,
  total,
  onAnswer,
}: {
  question: Question;
  index: number;
  total: number;
  onAnswer: (yes: boolean) => void;
}) {
  return (
    <div className="flex flex-col gap-6">
      <div>
        <div className="flex justify-between text-xs text-gray-400 mb-1">
          <span>Question {index + 1} of {total}</span>
          <span>{Math.round((index / total) * 100)}%</span>
        </div>
        <div className="h-2 bg-gray-100 dark:bg-gray-700 rounded-full overflow-hidden">
          <div
            className="h-full bg-green-500 rounded-full transition-all duration-300"
            style={{ width: `${(index / total) * 100}%` }}
          />
        </div>
      </div>

      <div className="rounded-xl border-2 border-green-200 dark:border-green-700 bg-green-50 dark:bg-green-900/30 p-6 min-h-32 flex items-center justify-center">
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
    </div>
  );
}

function ResultsScreen({
  top,
  scores,
  onRetake,
  onHerbSelect,
}: {
  top: Dimension[];
  scores: Record<Dimension, number>;
  onRetake: () => void;
  onHerbSelect?: (herbName: string) => void;
}) {
  if (top.length === 0) {
    return (
      <div className="flex flex-col gap-6 items-center text-center">
        <p className="text-gray-600 dark:text-gray-300">
          No significant imbalances detected — you appear to be in good balance!
        </p>
        <button
          onClick={onRetake}
          className="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium"
        >
          Retake Quiz
        </button>
      </div>
    );
  }

  const herbCounts = top.reduce((acc, dim) => {
    DIMENSION_INFO[dim].herbs.forEach((herb) => {
      acc[herb] = (acc[herb] || 0) + 1;
    });
    return acc;
  }, {} as Record<string, number>);

  return (
    <div className="flex flex-col gap-4">
      <p className="text-sm text-gray-500 dark:text-gray-400">
        Your dominant energetic pattern{top.length > 1 ? 's' : ''}:
      </p>

      <div className="flex flex-col gap-3">
        {top.map((dim) => {
          const info = DIMENSION_INFO[dim];
          return (
            <div key={dim} className="rounded-xl border-2 border-green-200 dark:border-green-700 bg-green-50 dark:bg-green-900/20 p-4">
              <div className="flex items-center gap-2 mb-1">
                <span className="text-xl">{info.emoji}</span>
                <h3 className="font-bold text-gray-800 dark:text-gray-100">
                  {info.label} — needs {info.need} herbs
                </h3>
                <span className="ml-auto text-xs text-gray-400">{scores[dim]} symptoms</span>
              </div>
              <p className="text-sm text-gray-600 dark:text-gray-300 mb-3">{info.description}</p>
              <div className="flex flex-wrap gap-1.5">
                {info.herbs.map((herb) => {
                  const multi = herbCounts[herb] > 1;
                  const baseClass = multi
                    ? 'bg-green-300 dark:bg-green-600/70 text-green-900 dark:text-green-100'
                    : 'bg-green-100 dark:bg-green-800/40 text-green-800 dark:text-green-300';
                  return onHerbSelect ? (
                    <button
                      key={herb}
                      onClick={() => onHerbSelect(herb)}
                      className={`px-2 py-1 ${baseClass} rounded-md text-xs font-medium hover:brightness-95 transition-colors underline-offset-2 hover:underline`}
                    >
                      {herb}
                    </button>
                  ) : (
                    <span
                      key={herb}
                      className={`px-2 py-1 ${baseClass} rounded-md text-xs font-medium`}
                    >
                      {herb}
                    </span>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>

      <button
        onClick={onRetake}
        className="self-center px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors"
      >
        Retake Quiz
      </button>
    </div>
  );
}
