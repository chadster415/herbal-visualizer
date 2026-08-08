'use client';

import { useState, useEffect, useRef } from 'react';
import { HerbView } from '@/components/HerbView';
import { ActionView } from '@/components/ActionView';
import { SystemView } from '@/components/SystemView';
import { FlashcardModal } from '@/components/FlashcardModal';
import { EnergeticsQuizModal } from '@/components/EnergeticsQuizModal';
import { HerbFilterPanel } from '@/components/HerbFilterPanel';
import { FormulaBuilderModal } from '@/components/FormulaBuilderModal';
import { IntakeFormModal } from '@/components/IntakeFormModal';
import { BodyDiagramModal } from '@/components/BodyDiagramModal';
import {
  ArrowLeftIcon,
  BeakerIcon,
  ChevronDownIcon,
  ClipboardDocumentListIcon,
  FireIcon,
  MagnifyingGlassIcon,
  RectangleStackIcon,
  UserIcon,
} from '@heroicons/react/24/outline';

type ViewMode = 'herb' | 'action' | 'system';

interface NavEntry {
  viewMode: ViewMode;
  selectedHerbId: number | null;
  selectedActionId: number | null;
  selectedSystemId: number | null;
  selectedDisorderId: number | null;
  selectedSupplementId?: number | null;
}

export default function Home() {
  const [scrollTrigger, setScrollTrigger] = useState(0);
  const isFirstRender = useRef(true);

  useEffect(() => {
    if (isFirstRender.current) { isFirstRender.current = false; return; }
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, [scrollTrigger]);

  const [viewMode, setViewMode] = useState<ViewMode>('herb');
  const [selectedHerbId, setSelectedHerbId] = useState<number | null>(null);
  const [selectedActionId, setSelectedActionId] = useState<number | null>(null);
  const [selectedSystemId, setSelectedSystemId] = useState<number | null>(null);
  const [selectedDisorderId, setSelectedDisorderId] = useState<number | null>(null);
  const [selectedSupplementId, setSelectedSupplementId] = useState<number | null>(null);
  const [history, setHistory] = useState<NavEntry[]>([]);
  const [flashcardsOpen, setFlashcardsOpen] = useState(false);
  const [energeticsQuizOpen, setEnergeticsQuizOpen] = useState(false);
  const [herbFilterOpen, setHerbFilterOpen] = useState(false);
  const [formulaBuilderOpen, setFormulaBuilderOpen] = useState(false);
  const [intakeFormOpen, setIntakeFormOpen] = useState(false);
  const [bodyDiagramOpen, setBodyDiagramOpen] = useState(false);
  const [openDropdown, setOpenDropdown] = useState<'browse' | 'practice' | null>(null);

  const pushAndNavigate = (next: NavEntry) => {
    setHistory((prev) => [...prev, { viewMode, selectedHerbId, selectedActionId, selectedSystemId, selectedDisorderId, selectedSupplementId }]);
    setViewMode(next.viewMode);
    setSelectedHerbId(next.selectedHerbId);
    setSelectedActionId(next.selectedActionId);
    setSelectedSystemId(next.selectedSystemId);
    setSelectedDisorderId(next.selectedDisorderId);
    setSelectedSupplementId(next.selectedSupplementId ?? null);
    setScrollTrigger((k) => k + 1);
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
      setSelectedSupplementId(entry.selectedSupplementId ?? null);
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
    pushAndNavigate({ viewMode: 'herb', selectedHerbId: herbId, selectedActionId, selectedSystemId: null, selectedDisorderId: null, selectedSupplementId: null });
  };

  const handleSupplementClick = (supplementId: number) => {
    pushAndNavigate({ viewMode: 'herb', selectedHerbId: null, selectedActionId, selectedSystemId: null, selectedDisorderId: null, selectedSupplementId: supplementId });
  };

  const handleActionClick = (actionId: number) => {
    pushAndNavigate({ viewMode: 'action', selectedHerbId, selectedActionId: actionId, selectedSystemId: null, selectedDisorderId: null });
  };

  const handleDisorderClick = (disorderId: number, systemId: number) => {
    pushAndNavigate({ viewMode: 'system', selectedHerbId: null, selectedActionId: null, selectedSystemId: systemId, selectedDisorderId: disorderId });
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

  const viewModeLabel = viewMode === 'herb' ? 'By Herb' : viewMode === 'action' ? 'By Action' : 'By Body System';

  return (
    <div className="min-h-screen p-8 bg-gradient-to-br from-green-50 to-emerald-100 dark:from-gray-900 dark:to-gray-800">
      <header className="mb-8">
        <h1 className="text-4xl font-bold text-green-800 dark:text-green-300 mb-4">
          Herbal Medicine Visualizer
        </h1>

        {openDropdown && (
          <div className="fixed inset-0 z-0" onClick={() => setOpenDropdown(null)} />
        )}

        <div className="flex justify-between items-start mb-6 gap-4">
          <div className="flex gap-3 items-center flex-wrap">
            {history.length > 0 && (
              <button
                onClick={goBack}
                className="px-4 py-3 rounded-lg font-medium transition-all bg-blue-500 hover:bg-blue-600 text-white shadow-md flex items-center gap-1"
              >
                <ArrowLeftIcon className="w-4 h-4" /> Back
              </button>
            )}

            {/* Browse dropdown */}
            <div className="relative z-10">
              <button
                onClick={() => setOpenDropdown(openDropdown === 'browse' ? null : 'browse')}
                className="px-6 py-3 rounded-lg font-medium transition-all bg-green-600 text-white shadow-lg border border-green-500 flex items-center gap-2"
              >
                {viewModeLabel} <ChevronDownIcon className="w-4 h-4 opacity-80" />
              </button>
              {openDropdown === 'browse' && (
                <div className="absolute top-full mt-1 left-0 bg-white border border-green-200 rounded-lg shadow-lg min-w-[190px] overflow-hidden z-10">
                  {(['herb', 'action', 'system'] as const).map((mode) => (
                    <div key={mode} className={`flex items-center ${viewMode === mode ? 'bg-green-100' : ''}`}>
                      <button
                        onClick={() => { switchTab(mode); setOpenDropdown(null); }}
                        className={`flex-1 text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all ${viewMode === mode ? 'font-semibold' : ''}`}
                      >
                        {mode === 'herb' ? 'By Herb' : mode === 'action' ? 'By Action' : 'By Body System'}
                      </button>
                      {mode === 'system' && (
                        <button
                          onClick={(e) => { e.stopPropagation(); setBodyDiagramOpen(true); setOpenDropdown(null); }}
                          title="Browse body diagram"
                          className="pr-3 pl-1 py-2.5 text-green-600 hover:text-green-800 transition-all"
                        >
                          <UserIcon className="w-4 h-4" />
                        </button>
                      )}
                    </div>
                  ))}
                  {/* Mobile-only: tools collapsed into browse dropdown */}
                  <div className="md:hidden border-t border-green-100">
                    <button
                      onClick={() => { setFlashcardsOpen(true); setOpenDropdown(null); }}
                      className="w-full text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all flex items-center gap-2"
                    >
                      <RectangleStackIcon className="w-4 h-4 shrink-0" /> Flashcards
                    </button>
                    <button
                      onClick={() => { setFormulaBuilderOpen(true); setOpenDropdown(null); }}
                      className="w-full text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all flex items-center gap-2"
                    >
                      <BeakerIcon className="w-4 h-4 shrink-0" /> Formula Builder
                    </button>
                    <button
                      onClick={() => { setEnergeticsQuizOpen(true); setOpenDropdown(null); }}
                      className="w-full text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all flex items-center gap-2"
                    >
                      <FireIcon className="w-4 h-4 shrink-0" /> Energetics Quiz
                    </button>
                    <button
                      onClick={() => { setIntakeFormOpen(true); setOpenDropdown(null); }}
                      className="w-full text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all flex items-center gap-2"
                    >
                      <ClipboardDocumentListIcon className="w-4 h-4 shrink-0" /> Intake Assessment
                    </button>
                  </div>
                </div>
              )}
            </div>

            <button
              onClick={() => setFlashcardsOpen(true)}
              className="hidden md:flex px-6 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-100 border border-green-300 items-center gap-2"
            >
              <RectangleStackIcon className="w-5 h-5 shrink-0" /> Flashcards
            </button>

            <button
              onClick={() => setFormulaBuilderOpen(true)}
              className="hidden md:flex px-6 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-100 border border-green-300 items-center gap-2"
            >
              <BeakerIcon className="w-5 h-5 shrink-0" /> Formula Builder
            </button>

            {/* Practice dropdown */}
            <div className="hidden md:block relative z-10">
              <button
                onClick={() => setOpenDropdown(openDropdown === 'practice' ? null : 'practice')}
                className="px-6 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-100 border border-green-300 flex items-center gap-2"
              >
                Quizzes <ChevronDownIcon className="w-4 h-4 opacity-60" />
              </button>
              {openDropdown === 'practice' && (
                <div className="absolute top-full mt-1 left-0 bg-white border border-green-200 rounded-lg shadow-lg overflow-hidden z-10">
                  <button
                    onClick={() => { setEnergeticsQuizOpen(true); setOpenDropdown(null); }}
                    className="w-full text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all whitespace-nowrap flex items-center gap-2"
                  >
                    <FireIcon className="w-5 h-5 shrink-0" /> Energetics Quiz
                  </button>
                  <button
                    onClick={() => { setIntakeFormOpen(true); setOpenDropdown(null); }}
                    className="w-full text-left px-4 py-2.5 text-green-800 hover:bg-green-50 transition-all whitespace-nowrap flex items-center gap-2"
                  >
                    <ClipboardDocumentListIcon className="w-5 h-5 shrink-0" /> Intake Assessment
                  </button>
                </div>
              )}
            </div>
          </div>

          {/* Filter Herbs — prominent search button */}
          <button
            onClick={() => setHerbFilterOpen(true)}
            className="px-5 py-3 rounded-lg font-medium transition-all bg-white text-green-800 hover:bg-green-100 border-2 border-green-400 shadow-md flex items-center gap-2 whitespace-nowrap"
          >
            <MagnifyingGlassIcon className="w-5 h-5" /> <span className="hidden sm:inline">Filter Herbs</span>
          </button>
        </div>
      </header>

      <main>
        <div className={viewMode !== 'herb' ? 'hidden' : ''}><HerbView selectedHerbId={selectedHerbId} onHerbIdChange={setSelectedHerbId} onHerbClick={handleHerbClick} onActionClick={handleActionClick} onActionNameClick={handleActionNameClick} onDisorderClick={handleDisorderClick} selectedSupplementId={selectedSupplementId} onSupplementClick={handleSupplementClick} /></div>
        <div className={viewMode !== 'action' ? 'hidden' : ''}><ActionView selectedActionId={selectedActionId} onActionIdChange={setSelectedActionId} onHerbClick={handleHerbClick} /></div>
        {viewMode === 'system' && (
          <SystemView
            onHerbClick={handleHerbClick}
            onActionClick={handleActionClick}
            onSupplementClick={handleSupplementClick}
            selectedSystemId={selectedSystemId}
            onSystemChange={setSelectedSystemId}
            selectedDisorderId={selectedDisorderId}
            onDisorderChange={setSelectedDisorderId}
          />
        )}
      </main>

      <FlashcardModal isOpen={flashcardsOpen} onClose={() => setFlashcardsOpen(false)} />
      <FormulaBuilderModal
        isOpen={formulaBuilderOpen}
        onClose={() => setFormulaBuilderOpen(false)}
        onHerbClick={handleHerbClick}
      />
      <EnergeticsQuizModal isOpen={energeticsQuizOpen} onClose={() => setEnergeticsQuizOpen(false)} onHerbSelect={(herbName) => { handleQuizHerbSelect(herbName); if (typeof window !== 'undefined' && window.innerWidth < 640) setEnergeticsQuizOpen(false); }} />
      <IntakeFormModal isOpen={intakeFormOpen} onClose={() => setIntakeFormOpen(false)} onHerbSelect={(herbId) => { handleHerbClick(herbId); if (typeof window !== 'undefined' && window.innerWidth < 640) setIntakeFormOpen(false); }} />
      <BodyDiagramModal
        open={bodyDiagramOpen}
        onClose={() => setBodyDiagramOpen(false)}
        onSystemSelect={(systemId) => {
          setHistory([]);
          setViewMode('system');
          setSelectedSystemId(systemId);
          setSelectedDisorderId(null);
          setSelectedHerbId(null);
          setSelectedActionId(null);
        }}
        onDisorderSelect={(systemId, disorderId) => {
          setHistory([]);
          setViewMode('system');
          setSelectedSystemId(systemId);
          setSelectedDisorderId(disorderId);
          setSelectedHerbId(null);
          setSelectedActionId(null);
        }}
      />
      <HerbFilterPanel
        isOpen={herbFilterOpen}
        onClose={() => setHerbFilterOpen(false)}
        onHerbSelect={(herbId) => { handleHerbClick(herbId); if (typeof window !== 'undefined' && window.innerWidth < 640) setHerbFilterOpen(false); }}
        onSystemSelect={(systemId) => {
          setHerbFilterOpen(false);
          pushAndNavigate({ viewMode: 'system', selectedHerbId: null, selectedActionId: null, selectedSystemId: systemId, selectedDisorderId: null });
        }}
      />
    </div>
  );
}
