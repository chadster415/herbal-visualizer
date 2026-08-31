'use client';

import { useEffect, useState } from 'react';
import {
  AcademicCapIcon,
  CheckCircleIcon,
  ChevronLeftIcon,
  XCircleIcon,
  XMarkIcon,
} from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';

interface QuizQuestion {
  id: number;
  class_name: string;
  question_text: string;
  option_a: string;
  option_b: string;
  option_c: string;
  option_d: string;
  correct_option: 'a' | 'b' | 'c' | 'd';
  explanation: string;
  snippet_text: string;
  section_header: string | null;
  sort_order: number;
}

type Stage = 'select' | 'quiz' | 'revealed' | 'results';

interface Props {
  isOpen: boolean;
  onClose: () => void;
}

export function ClassQuizModal({ isOpen, onClose }: Props) {
  const [stage, setStage] = useState<Stage>('select');
  const [availableClasses, setAvailableClasses] = useState<string[]>([]);
  const [loadingClasses, setLoadingClasses] = useState(false);
  const [selectedClass, setSelectedClass] = useState<string | null>(null);
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [loadingQuestions, setLoadingQuestions] = useState(false);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState<string | null>(null);
  const [score, setScore] = useState(0);

  // Fetch available classes when modal opens
  useEffect(() => {
    if (!isOpen) return;
    setLoadingClasses(true);
    supabase
      .from('class_quiz_questions')
      .select('class_name')
      .order('class_name')
      .then(({ data }) => {
        if (data) {
          const unique = Array.from(
            new Set(data.map((r: { class_name: string }) => r.class_name))
          ) as string[];
          setAvailableClasses(unique);
        }
        setLoadingClasses(false);
      });
  }, [isOpen]);

  const handleSelectClass = async (className: string) => {
    setSelectedClass(className);
    setLoadingQuestions(true);
    const { data } = await supabase
      .from('class_quiz_questions')
      .select('*')
      .eq('class_name', className)
      .order('sort_order');
    if (data) {
      setQuestions(data as QuizQuestion[]);
    }
    setCurrentIndex(0);
    setSelectedOption(null);
    setScore(0);
    setLoadingQuestions(false);
    setStage('quiz');
  };

  const handleOptionSelect = (option: string) => {
    if (stage !== 'quiz') return;
    setSelectedOption(option);
    if (option === questions[currentIndex].correct_option) {
      setScore((s) => s + 1);
    }
    setStage('revealed');
  };

  const handleNext = () => {
    if (currentIndex + 1 >= questions.length) {
      setStage('results');
    } else {
      setCurrentIndex((i) => i + 1);
      setSelectedOption(null);
      setStage('quiz');
    }
  };

  const handleTryAgain = () => {
    setCurrentIndex(0);
    setSelectedOption(null);
    setScore(0);
    setStage('quiz');
  };

  const handleChooseAnother = () => {
    setSelectedClass(null);
    setQuestions([]);
    setCurrentIndex(0);
    setSelectedOption(null);
    setScore(0);
    setStage('select');
  };

  const handleClose = () => {
    setStage('select');
    setSelectedClass(null);
    setQuestions([]);
    setCurrentIndex(0);
    setSelectedOption(null);
    setScore(0);
    onClose();
  };

  const currentQuestion = questions[currentIndex] ?? null;

  const getPerformanceMessage = () => {
    const pct = questions.length > 0 ? score / questions.length : 0;
    if (pct >= 0.9) return 'Excellent work!';
    if (pct >= 0.7) return 'Good job!';
    if (pct >= 0.5) return 'Keep studying!';
    return 'Review the notes and try again.';
  };

  return (
    <div
      className={`fixed top-0 right-0 h-full w-full sm:w-[440px] z-40 bg-white shadow-2xl border-l border-green-200 flex flex-col transition-transform duration-300 ease-in-out ${isOpen ? 'translate-x-0' : 'translate-x-full'}`}
    >
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-green-100 bg-green-50 shrink-0">
        {stage === 'quiz' || stage === 'revealed' ? (
          <button
            onClick={handleChooseAnother}
            className="text-green-700 hover:text-green-900 flex items-center gap-1 text-sm font-medium transition-colors"
            aria-label="Back to class select"
          >
            <ChevronLeftIcon className="w-4 h-4" />
            <span className="truncate max-w-[240px]">
              {selectedClass ? selectedClass.replace(/^BHC - /, '') : 'Classes'}
            </span>
          </button>
        ) : (
          <h2 className="text-lg font-bold text-green-800 flex items-center gap-2">
            <AcademicCapIcon className="w-5 h-5" /> Class Quizzes
          </h2>
        )}
        <button
          onClick={handleClose}
          className="text-gray-400 hover:text-gray-600 transition-colors ml-2 shrink-0"
          aria-label="Close"
        >
          <XMarkIcon className="w-5 h-5" />
        </button>
      </div>

      {/* Body */}
      <div className="flex-1 overflow-y-auto px-6 py-4 space-y-4">

        {/* SELECT STAGE */}
        {stage === 'select' && (
          <div className="flex flex-col gap-4">
            <p className="text-sm text-green-700">Choose a class to test your knowledge</p>
            {loadingClasses && (
              <p className="text-sm text-gray-400">Loading classes…</p>
            )}
            {!loadingClasses && availableClasses.length === 0 && (
              <p className="text-sm text-gray-500 italic">No quiz classes available yet.</p>
            )}
            {!loadingClasses && availableClasses.map((className) => (
              <button
                key={className}
                onClick={() => handleSelectClass(className)}
                className="w-full text-left px-4 py-3 rounded-lg border border-green-200 bg-white hover:bg-green-50 hover:border-green-400 transition-all text-green-900 font-medium"
              >
                {className.replace(/^BHC - /, '')}
              </button>
            ))}
          </div>
        )}

        {/* QUIZ / REVEALED STAGE */}
        {(stage === 'quiz' || stage === 'revealed') && currentQuestion && (
          <div className="flex flex-col gap-4">
            {/* Progress bar */}
            <div>
              <div className="flex justify-between text-xs text-gray-400 mb-1">
                <span>Question {currentIndex + 1} of {questions.length}</span>
              </div>
              <div className="h-1.5 bg-gray-100 rounded-full overflow-hidden">
                <div
                  className="h-full bg-green-500 rounded-full transition-all duration-300"
                  style={{ width: `${(currentIndex / questions.length) * 100}%` }}
                />
              </div>
            </div>

            {/* Question text */}
            <p className="text-base font-semibold text-gray-800 leading-snug">
              {currentQuestion.question_text}
            </p>

            {/* Option buttons */}
            {(['a', 'b', 'c', 'd'] as const).map((opt) => {
              const label = opt.toUpperCase();
              const text = currentQuestion[`option_${opt}` as 'option_a' | 'option_b' | 'option_c' | 'option_d'];
              const isCorrect = opt === currentQuestion.correct_option;
              const isSelected = opt === selectedOption;

              let buttonClass = 'w-full text-left px-4 py-3 rounded-lg border transition-all flex items-start gap-3 ';
              if (stage === 'quiz') {
                buttonClass += 'border-green-200 bg-white hover:bg-green-50 hover:border-green-400 text-gray-800 cursor-pointer';
              } else {
                if (isCorrect) {
                  buttonClass += 'bg-green-100 border-green-500 text-green-800 cursor-default';
                } else if (isSelected && !isCorrect) {
                  buttonClass += 'bg-red-50 border-red-400 text-red-800 cursor-default';
                } else {
                  buttonClass += 'bg-gray-50 border-gray-200 text-gray-400 cursor-default';
                }
              }

              return (
                <button
                  key={opt}
                  onClick={stage === 'quiz' ? () => handleOptionSelect(opt) : undefined}
                  disabled={stage === 'revealed'}
                  className={buttonClass}
                >
                  <span className="font-bold shrink-0 w-5">{label}.</span>
                  <span className="flex-1">{text}</span>
                  {stage === 'revealed' && isCorrect && (
                    <CheckCircleIcon className="w-5 h-5 shrink-0 text-green-600" />
                  )}
                  {stage === 'revealed' && isSelected && !isCorrect && (
                    <XCircleIcon className="w-5 h-5 shrink-0 text-red-500" />
                  )}
                </button>
              );
            })}

            {/* Revealed: explanation + snippet */}
            {stage === 'revealed' && (
              <>
                <div className="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3">
                  <p className="text-xs font-semibold text-blue-700 uppercase tracking-wide mb-1">Explanation</p>
                  <p className="text-sm text-blue-900">{currentQuestion.explanation}</p>
                </div>
                <div className="bg-amber-50 border border-amber-200 rounded-lg px-4 py-3">
                  <p className="text-xs font-semibold text-amber-700 uppercase tracking-wide mb-1">
                    {currentQuestion.section_header ?? 'From the Notes'}
                  </p>
                  <p className="text-sm text-amber-900 italic">{currentQuestion.snippet_text}</p>
                </div>
              </>
            )}

            {/* Loading questions state */}
            {loadingQuestions && (
              <p className="text-sm text-gray-400">Loading questions…</p>
            )}
          </div>
        )}

        {/* RESULTS STAGE */}
        {stage === 'results' && (
          <div className="flex flex-col items-center gap-5 pt-4">
            <div className="text-center">
              <p className="text-5xl font-bold text-green-800">
                {score}<span className="text-2xl text-green-500">/{questions.length}</span>
              </p>
              <p className="text-lg font-semibold text-gray-700 mt-2">{getPerformanceMessage()}</p>
              {selectedClass && (
                <p className="text-sm text-gray-500 mt-1">{selectedClass.replace(/^BHC - /, '')}</p>
              )}
            </div>
          </div>
        )}
      </div>

      {/* Footer */}
      {(stage === 'revealed' || stage === 'results') && (
        <div className="px-6 py-4 border-t border-green-100 shrink-0 flex gap-3">
          {stage === 'revealed' && (
            <button
              onClick={handleNext}
              className="flex-1 px-4 py-3 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors"
            >
              {currentIndex + 1 >= questions.length ? 'See Results' : 'Next Question →'}
            </button>
          )}
          {stage === 'results' && (
            <>
              <button
                onClick={handleTryAgain}
                className="flex-1 px-4 py-3 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors"
              >
                Try Again
              </button>
              <button
                onClick={handleChooseAnother}
                className="flex-1 px-4 py-3 bg-white hover:bg-green-50 text-green-800 rounded-lg font-medium border border-green-300 transition-colors"
              >
                Choose Another Class
              </button>
            </>
          )}
        </div>
      )}
    </div>
  );
}
