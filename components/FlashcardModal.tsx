'use client';

import { useEffect, useState, useCallback } from 'react';
import { supabase } from '@/lib/supabase';
import { ArrowRightIcon } from '@heroicons/react/24/outline';

interface Herb {
  id: number;
  latin_name: string;
  common_name: string;
}

interface Card {
  herb: Herb;
  showLatinFirst: boolean;
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
}

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

function buildDeck(herbs: Herb[]): Card[] {
  return shuffle(herbs).map((herb) => ({
    herb,
    showLatinFirst: Math.random() < 0.5,
  }));
}

export function FlashcardModal({ isOpen, onClose }: Props) {
  const [herbs, setHerbs] = useState<Herb[]>([]);
  const [deck, setDeck] = useState<Card[]>([]);
  const [index, setIndex] = useState(0);
  const [revealed, setRevealed] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    document.body.style.overflow = isOpen ? 'hidden' : '';
    return () => { document.body.style.overflow = ''; };
  }, [isOpen]);

  useEffect(() => {
    if (!isOpen) return;
    supabase
      .from('herbs')
      .select('id, latin_name, common_name')
      .eq('is_tcm', false)
      .order('latin_name')
      .then(({ data }) => {
        const h = data ?? [];
        setHerbs(h);
        setDeck(buildDeck(h));
        setIndex(0);
        setRevealed(false);
        setLoading(false);
      });
  }, [isOpen]);

  const next = useCallback(() => {
    if (index + 1 >= deck.length) {
      // reshuffle when deck is exhausted
      setDeck(buildDeck(herbs));
      setIndex(0);
    } else {
      setIndex((i) => i + 1);
    }
    setRevealed(false);
  }, [index, deck.length, herbs]);

  useEffect(() => {
    if (!isOpen) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
      if (e.key === ' ' || e.key === 'Enter') {
        if (!revealed) setRevealed(true);
        else next();
      }
      if (e.key === 'ArrowRight' && revealed) next();
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [isOpen, revealed, next, onClose]);

  if (!isOpen) return null;

  const card = deck[index];
  const progress = deck.length > 0 ? `${index + 1} / ${deck.length}` : '';

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm"
      onClick={onClose}
    >
      <div
        className="relative bg-white dark:bg-gray-800 rounded-2xl shadow-2xl w-full max-w-md mx-4 p-8 flex flex-col gap-6"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-center justify-between">
          <span className="text-sm font-medium text-gray-400">{progress}</span>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200 text-xl leading-none"
            aria-label="Close"
          >
            ✕
          </button>
        </div>

        {loading || !card ? (
          <div className="text-center text-gray-500 py-8">Loading herbs…</div>
        ) : (
          <>
            {/* Card */}
            <div
              className="cursor-pointer select-none rounded-xl border-2 border-green-200 dark:border-green-700 bg-green-50 dark:bg-green-900/30 p-8 flex flex-col items-center gap-4 min-h-48 justify-center transition-all hover:border-green-400"
              onClick={() => !revealed && setRevealed(true)}
            >
              <p className="text-xs uppercase tracking-widest text-green-600 dark:text-green-400 font-semibold">
                {card.showLatinFirst ? 'Latin name' : 'Common name'}
              </p>
              <p className="text-2xl font-bold text-center text-gray-800 dark:text-gray-100">
                {card.showLatinFirst ? card.herb.latin_name : card.herb.common_name}
              </p>

              {revealed ? (
                <div className="mt-2 text-center border-t border-green-200 dark:border-green-700 pt-4 w-full">
                  <p className="text-xs uppercase tracking-widest text-gray-400 font-semibold mb-1">
                    {card.showLatinFirst ? 'Common name' : 'Latin name'}
                  </p>
                  <p className="text-xl font-semibold text-green-700 dark:text-green-300">
                    {card.showLatinFirst ? card.herb.common_name : card.herb.latin_name}
                  </p>
                </div>
              ) : (
                <p className="text-sm text-gray-400 mt-2">click to reveal</p>
              )}
            </div>

            {/* Footer */}
            <div className="flex justify-between items-center">
              <p className="text-xs text-gray-400">space / enter to advance</p>
              <button
                onClick={revealed ? next : () => setRevealed(true)}
                className="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg font-medium transition-colors flex items-center gap-2"
              >
                {revealed ? <><span>Next</span><ArrowRightIcon className="w-4 h-4" /></> : 'Reveal'}
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
