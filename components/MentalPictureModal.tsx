'use client';

import { useState, useEffect, useRef, useMemo } from 'react';
import { MagnifyingGlassIcon, XMarkIcon, ChevronDownIcon } from '@heroicons/react/24/outline';
import { supabase } from '@/lib/supabase';
import { EnergeticEmojis } from './EnergeticEmojis';

interface HerbResult {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
  temperature: string | null;
  moisture: string | null;
  tone: string | null;
  temperature_inferred: boolean;
  moisture_inferred: boolean;
  tone_inferred: boolean;
  mental_picture: string;
}

interface Props {
  isOpen: boolean;
  onClose: () => void;
  onHerbSelect: (herbId: number) => void;
  initialQuery?: string;
}

function cardBg(temperature?: string | null) {
  if (temperature === 'warming') return 'bg-orange-50 border-orange-200 hover:border-orange-400';
  if (temperature === 'cooling') return 'bg-blue-50 border-blue-200 hover:border-blue-400';
  return 'bg-white border-gray-200 hover:border-green-400';
}

export function MentalPictureModal({ isOpen, onClose, onHerbSelect, initialQuery }: Props) {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<HerbResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [allKeywords, setAllKeywords] = useState<string[]>([]);
  const [keywordBrowserOpen, setKeywordBrowserOpen] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    supabase
      .from('herb_mental_pictures')
      .select('keywords')
      .then(({ data }) => {
        if (!data) return;
        const seen = new Set<string>();
        for (const row of data as any[]) {
          for (const kw of (row.keywords as string[])) seen.add(kw);
        }
        setAllKeywords([...seen].sort((a, b) => a.localeCompare(b)));
      });
  }, []);

  useEffect(() => {
    if (isOpen) {
      setQuery(initialQuery ?? '');
      setTimeout(() => inputRef.current?.focus(), 100);
    } else {
      setQuery('');
      setResults([]);
      setKeywordBrowserOpen(false);
    }
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isOpen, initialQuery]);

  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current);
    if (!query.trim()) { setResults([]); return; }
    debounceRef.current = setTimeout(() => runSearch(query.trim()), 300);
    return () => { if (debounceRef.current) clearTimeout(debounceRef.current); };
  }, [query]);

  const keywordGroups = useMemo(() => {
    const groups: Record<string, string[]> = {};
    for (const kw of allKeywords) {
      const letter = kw[0]?.toUpperCase() ?? '#';
      if (!groups[letter]) groups[letter] = [];
      groups[letter].push(kw);
    }
    return Object.entries(groups).sort(([a], [b]) => a.localeCompare(b));
  }, [allKeywords]);

  async function runSearch(q: string) {
    setLoading(true);
    const { data } = await supabase
      .from('herb_mental_pictures')
      .select(`
        mental_picture,
        herbs (
          id, common_name, latin_name, plant_part,
          temperature, moisture, tone,
          temperature_inferred, moisture_inferred, tone_inferred
        )
      `)
      .textSearch('search_vector', q, { type: 'plain', config: 'english' });
    setLoading(false);
    if (!data) return;
    const mapped: HerbResult[] = (data as any[])
      .filter((row) => row.herbs)
      .map((row) => ({ ...row.herbs, mental_picture: row.mental_picture }));
    setResults(mapped);
  }

  return (
    <div
      className={`fixed top-0 right-0 h-full w-full sm:w-[480px] z-40 bg-white dark:bg-gray-800 shadow-2xl border-l border-gray-200 dark:border-gray-700 flex flex-col transition-transform duration-300 ease-in-out ${isOpen ? 'translate-x-0' : 'translate-x-full'}`}
    >
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200 dark:border-gray-700 shrink-0">
        <h2 className="text-lg font-bold text-green-800 dark:text-green-300 flex items-center gap-2">
          <MagnifyingGlassIcon className="w-5 h-5" /> Symptom Picture Search
        </h2>
        <button onClick={onClose} className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200" aria-label="Close">
          <XMarkIcon className="w-5 h-5" />
        </button>
      </div>

      {/* Search input */}
      <div className="px-6 pt-5 pb-3 shrink-0">
        <p className="text-sm text-gray-500 dark:text-gray-400 mb-3">
          Describe a symptom picture to find matching herbs from Tilgner's Heart of the Earth.
        </p>
        <div className="relative">
          <MagnifyingGlassIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
          <input
            ref={inputRef}
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="e.g. bruising trauma, night sweats exhaustion..."
            className="w-full pl-9 pr-4 py-2.5 border border-gray-200 dark:border-gray-600 rounded-lg text-sm bg-white dark:bg-gray-700 text-gray-900 dark:text-gray-100 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-transparent"
          />
        </div>
      </div>

      {/* Keyword browser */}
      <div className="shrink-0 border-b border-gray-100 dark:border-gray-700">
        <button
          onClick={() => setKeywordBrowserOpen((v) => !v)}
          className="flex items-center gap-1.5 px-6 py-2 text-xs text-gray-400 hover:text-green-700 w-full transition-colors"
        >
          <ChevronDownIcon className={`w-3.5 h-3.5 transition-transform ${keywordBrowserOpen ? '' : '-rotate-90'}`} />
          Browse all keywords
        </button>
        {keywordBrowserOpen && (
          <div className="max-h-72 overflow-y-auto px-6 pb-4">
            {keywordGroups.map(([letter, kws]) => (
              <div key={letter} className="mb-3">
                <div className="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-1.5">{letter}</div>
                <div className="flex flex-wrap gap-1.5">
                  {kws.map((kw) => (
                    <button
                      key={kw}
                      onClick={() => { setQuery(kw); setKeywordBrowserOpen(false); }}
                      className="px-2.5 py-1 text-xs bg-violet-50 text-violet-700 border border-violet-200 rounded-full hover:bg-violet-100 hover:border-violet-400 transition-colors"
                    >
                      {kw}
                    </button>
                  ))}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Results */}
      <div className="flex-1 overflow-y-auto px-6 py-4">
        {loading && (
          <p className="text-sm text-gray-400 py-6 text-center">Searching...</p>
        )}
        {!loading && query && results.length === 0 && (
          <p className="text-sm text-gray-400 py-6 text-center">No herbs matched that picture.</p>
        )}
        {!loading && !query && (
          <p className="text-sm text-gray-400 py-10 text-center leading-relaxed">
            Search keywords, symptom modalities, tongue signs, organ affinities, or emotional states.
          </p>
        )}
        {results.length > 0 && (
          <div className="space-y-3">
            <p className="text-xs text-gray-400 mb-2">{results.length} herb{results.length !== 1 ? 's' : ''} matched</p>
            {results.map((herb) => (
              <button
                key={herb.id}
                onClick={() => { onHerbSelect(herb.id); if (typeof window !== 'undefined' && window.innerWidth < 640) onClose(); }}
                className={`w-full text-left border rounded-lg px-4 py-3 transition-all ${cardBg(herb.temperature)}`}
              >
                <div className="flex items-center justify-between gap-2 mb-1">
                  <span className="font-medium text-sm text-gray-900 dark:text-gray-100">
                    {herb.common_name}{herb.plant_part ? ` (${herb.plant_part})` : ''}
                  </span>
                  <EnergeticEmojis
                    temperature={herb.temperature}
                    moisture={herb.moisture}
                    tone={herb.tone}
                    temperatureInferred={herb.temperature_inferred}
                    moistureInferred={herb.moisture_inferred}
                    toneInferred={herb.tone_inferred}
                  />
                </div>
                <div className="text-xs italic text-gray-500 dark:text-gray-400 mb-2">{herb.latin_name}</div>
                <p className="text-xs text-gray-600 dark:text-gray-300 leading-relaxed line-clamp-3">{herb.mental_picture}</p>
              </button>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
