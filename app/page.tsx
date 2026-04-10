'use client';

import { useState } from 'react';
import { HerbView } from '@/components/HerbView';
import { ActionView } from '@/components/ActionView';
import { SystemView } from '@/components/SystemView';
import type { Herb } from '@/types/database';

type ViewMode = 'herb' | 'action' | 'system';

export default function Home() {
  const [viewMode, setViewMode] = useState<ViewMode>('herb');
  const [selectedHerbId, setSelectedHerbId] = useState<number | null>(null);
  const [selectedActionId, setSelectedActionId] = useState<number | null>(null);

  const handleHerbClick = (herbId: number) => {
    setSelectedHerbId(herbId);
    setViewMode('herb');
  };

  const handleActionClick = (actionId: number) => {
    setSelectedActionId(actionId);
    setViewMode('action');
  };

  return (
    <div className="min-h-screen p-8 bg-gradient-to-br from-green-50 to-emerald-100 dark:from-gray-900 dark:to-gray-800">
      <header className="mb-8">
        <h1 className="text-4xl font-bold text-green-800 dark:text-green-300 mb-4">
          Herbal Medicine Visualizer
        </h1>

        <div className="flex gap-4 mb-6">
          <button
            onClick={() => setViewMode('herb')}
            className={`px-6 py-3 rounded-lg font-medium transition-all ${
              viewMode === 'herb'
                ? 'bg-green-600 text-white shadow-lg scale-105'
                : 'bg-white text-green-800 hover:bg-green-50'
            }`}
          >
            By Herb
          </button>
          <button
            onClick={() => setViewMode('action')}
            className={`px-6 py-3 rounded-lg font-medium transition-all ${
              viewMode === 'action'
                ? 'bg-green-600 text-white shadow-lg scale-105'
                : 'bg-white text-green-800 hover:bg-green-50'
            }`}
          >
            By Action
          </button>
          <button
            onClick={() => setViewMode('system')}
            className={`px-6 py-3 rounded-lg font-medium transition-all ${
              viewMode === 'system'
                ? 'bg-green-600 text-white shadow-lg scale-105'
                : 'bg-white text-green-800 hover:bg-green-50'
            }`}
          >
            By Body System
          </button>
        </div>
      </header>

      <main>
        {viewMode === 'herb' && <HerbView selectedHerbId={selectedHerbId} onHerbIdChange={setSelectedHerbId} onActionClick={handleActionClick} />}
        {viewMode === 'action' && <ActionView selectedActionId={selectedActionId} onActionIdChange={setSelectedActionId} onHerbClick={handleHerbClick} />}
        {viewMode === 'system' && <SystemView onHerbClick={handleHerbClick} onActionClick={handleActionClick} />}
      </main>
    </div>
  );
}
