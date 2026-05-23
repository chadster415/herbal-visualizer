'use client';

import { useState } from 'react';
import { HerbView } from '@/components/HerbView';
import { ActionView } from '@/components/ActionView';
import { SystemView } from '@/components/SystemView';
import { FlashcardModal } from '@/components/FlashcardModal';
import { EnergeticsQuizModal } from '@/components/EnergeticsQuizModal';
import { HerbFilterPanel } from '@/components/HerbFilterPanel';

type ViewMode = 'herb' | 'action' | 'system';

interface NavEntry {
  viewMode: ViewMode;
  selectedHerbId: number | null;
  selectedActionId: number | null;
  selectedSystemId: number | null;
  selectedDisorderId: number | null;
}

export default function Home() {
  const [viewMode, setViewMode] = useState<ViewMode>('herb');
  const [selectedHerbId, setSelectedHerbId] = useState<number | null>(null);
  const [selectedActionId, setSelectedActionId] = useState<number | null>(null);
  const [selectedSystemId, setSelectedSystemId] = useState<number | null>(null);
  const [selectedDisorderId, setSelectedDisorderId] = useState<number | null>(null);
  const [history, setHistory] = useState<NavEntry[]>([]);
  const [flashcardsOpen, setFlashcardsOpen] = useState(false);
  const [energeticsQuizOpen, setEnergeticsQuizOpen] = useState(false);
  const [herbFilterOpen, setHerbFilterOpen] = useState(false);

  const pushAndNavigate = (next: NavEntry) => {
    setHistory((prev) => [...prev, { viewMode, selectedHerbId, selectedActionId, selectedSystemId, selectedDisorderId }]);
    setViewMode(next.viewMode);
    setSelectedHerbId(next.selectedHerbId);
    setSelectedActionId(next.selectedActionId);
    setSelectedSystemId(next.selectedSystemId);
    setSelectedDisorderId(next.selectedDisorderId);
  };

  const goBack = () => {
    setHistory((prev) => {
      if (prev.length === 0) return prev;
      const next = [...prev];
      const entry = next.pop()!;
      setViewMode(entry.viewMode);
      setSelectedHerbId(entry.selectedHerbId);
      setSelectedActionId(entry.selectedActionId);
      setSelectedSystemId(entry.selectedSystemId);
      setSelectedDisorderId(entry.selectedDisorderId);
      return next;
    });
  };

  const switchTab = (mode: ViewMode) => {
    setHistory([]);
    setViewMode(mode);
    setSelectedSystemId(null);
    setSelectedDisorderId(null);
  };

  const handleHerbClick = (herbId: number) => {
    pushAndNavigate({ viewMode: 'herb', selectedHerbId: herbId, selectedActionId, selectedSystemId: null, selectedDisorderId: null });
  };

  const handleActionClick = (actionId: number) => {
    pushAndNavigate({ viewMode: 'action', selectedHerbId, selectedActionId: actionId, selectedSystemId: null, selectedDisorderId: null });
  };

  const handleActionNameClick = async (name: string) => {
    const { data } = await import('@/lib/supabase').then(({ supabase }) =>
      supabase.from('primary_actions').select('id').eq('name', name).single()
    );
    if (data) {
      pushAndNavigate({ viewMode: 'action', selectedHerbId, selectedActionId: data.id, selectedSystemId: null, selectedDisorderId: null });
    }
  };

  const handleQuizHerbSelect = async (herbName: string) => {
    const { supabase } = await import('@/lib/supabase');
    const { data } = await supabase
      .from('herbs')
      .select('id')
      .ilike('common_name', herbName)
      .limit(1);
    const herb = data?.[0];
    if (herb) {
      pushAndNavigate({ viewMode: 'herb', selectedHerbId: herb.id, selectedActionId, selectedSystemId: null, selectedDisorderId: null });
    }
  };

  return (
    <div className="min-h-screen p-8 bg-gradient-to-br from-green-50 to-emerald-100 dark:from-gray-900 dark:to-gray-800">
      <header className="mb-8">
        <h1 className="text-4xl font-bold text-green-800 dark:text-green-300 mb-4">
          Herbal Medicine Visualizer
        </h1>

        <div className="flex gap-4 mb-6 flex-wrap items-center">
          {history.length > 0 && (
            <button
              onClick={goBack}
              className="px-4 py-3 rounded-lg font-medium transition-all bg-blue-500 hover:bg-blue-600 text-white shadow-md flex items-center gap-1"
            >
              ← Back
            </button>
          )}
          <button
            onClick={() => switchTab('herb')}
            className={`px-6 py-3 rounded-lg font-medium transition-all ${
              viewMode === 'herb'
                ? 'bg-green-600 text-white shadow-lg scale-105'
                : 'bg-white text-green-800 hover:bg-green-50'
            }`}
          >
            By Herb
          </button>
          <button
            onClick={() => switchTab('action')}
            className={`px-6 py-3 rounded-lg font-medium transition-all ${
              viewMode === 'action'
                ? 'bg-green-600 text-white shadow-lg scale-105'
                : 'bg-white text-green-800 hover:bg-green-50'
            }`}
          >
            By Action
          </button>
          <button
            onClick={() => switchTab('system')}
            className={`px-6 py-3 rounded-lg font-medium transition-all ${
              viewMode === 'system'
                ? 'bg-green-600 text-white shadow-lg scale-105'
                : 'bg-white text-green-800 hover:bg-green-50'
            }`}
          >
            By Body System
          </button>
          <button
            onClick={() => setFlashcardsOpen(true)}
            className="px-6 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-50 border border-green-300"
          >
            🌿 Flashcards
          </button>
          <button
            onClick={() => setEnergeticsQuizOpen(true)}
            className="px-6 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-50 border border-green-300"
          >
            🌡️ Energetics Quiz
          </button>
          <button
            onClick={() => setHerbFilterOpen(true)}
            className="px-6 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-50 border border-green-300"
          >
            🔍 Filter Herbs
          </button>
        </div>
      </header>

      <main>
        {viewMode === 'herb' && <HerbView selectedHerbId={selectedHerbId} onHerbIdChange={setSelectedHerbId} onActionClick={handleActionClick} onActionNameClick={handleActionNameClick} />}
        {viewMode === 'action' && <ActionView selectedActionId={selectedActionId} onActionIdChange={setSelectedActionId} onHerbClick={handleHerbClick} />}
        {viewMode === 'system' && (
          <SystemView
            onHerbClick={handleHerbClick}
            onActionClick={handleActionClick}
            selectedSystemId={selectedSystemId}
            onSystemChange={setSelectedSystemId}
            selectedDisorderId={selectedDisorderId}
            onDisorderChange={setSelectedDisorderId}
          />
        )}
      </main>

      <FlashcardModal isOpen={flashcardsOpen} onClose={() => setFlashcardsOpen(false)} />
      <EnergeticsQuizModal isOpen={energeticsQuizOpen} onClose={() => setEnergeticsQuizOpen(false)} onHerbSelect={handleQuizHerbSelect} />
      <HerbFilterPanel isOpen={herbFilterOpen} onClose={() => setHerbFilterOpen(false)} onHerbSelect={handleHerbClick} />
    </div>
  );
}
