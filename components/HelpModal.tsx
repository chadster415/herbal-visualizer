'use client';

import { useEffect } from 'react';
import {
  XMarkIcon,
  BeakerIcon,
  BookOpenIcon,
  CalculatorIcon,
  ClipboardDocumentListIcon,
  FireIcon,
  MagnifyingGlassIcon,
  RectangleStackIcon,
  TagIcon,
  UserIcon,
} from '@heroicons/react/24/outline';

interface HelpModalProps {
  isOpen: boolean;
  onClose: () => void;
}

interface Feature {
  icon: React.ReactNode;
  title: string;
  description: string;
  sub?: { label: string; detail: string }[];
}

const features: Feature[] = [
  {
    icon: <BookOpenIcon className="w-5 h-5 text-green-700" />,
    title: 'Browse by Herb',
    description:
      'Explore the full herb database. Each herb card shows energetics (temperature, moisture, tone), therapeutic actions grouped by body system, chemical constituents, menstruum recommendations, and drug-herb contraindications where available.',
  },
  {
    icon: <TagIcon className="w-5 h-5 text-green-700" />,
    title: 'Browse by Action',
    description:
      'Start from a therapeutic action (e.g. Expectorant, Nervine) and see every herb that performs it, grouped by body system. Useful for finding alternatives or understanding the full therapeutic landscape of an action.',
  },
  {
    icon: <UserIcon className="w-5 h-5 text-green-700" />,
    title: 'Browse by Body System',
    description:
      'Explore disorders organized by body system — GI, Respiratory, Nervous, Cardiovascular, and more. Each disorder lists clinical notes, indicated actions, specific remedies, and herbal prescriptions from class materials.',
    sub: [
      {
        label: 'Body Diagram',
        detail:
          'Click the person icon next to "By Body System" to open an interactive body diagram and navigate directly to a system or disorder by clicking on the illustration.',
      },
    ],
  },
  {
    icon: <RectangleStackIcon className="w-5 h-5 text-green-700" />,
    title: 'Flashcards',
    description:
      'Study herb names, therapeutic actions, and properties through flip cards. Great for memorizing the materia medica before exams.',
  },
  {
    icon: <BeakerIcon className="w-5 h-5 text-green-700" />,
    title: 'Formula Builder',
    description:
      "Build herbal formulas by searching and adding herbs with part ratios. The builder shows each herb's actions and lets you assign the role each herb plays in the formula.",
  },
  {
    icon: <CalculatorIcon className="w-5 h-5 text-green-700" />,
    title: 'Dosing Calculator',
    description:
      'Calculate tincture doses and batch sizes for multi-herb formulas. Enter the total volume and part ratios to get per-herb volumes in mL.',
  },
  {
    icon: <FireIcon className="w-5 h-5 text-green-700" />,
    title: 'Energetics Quiz',
    description:
      'Test your knowledge of herb energetics — temperature (warming/cooling/neutral), moisture (moistening/drying/neutral), and tone (toning/relaxing/neutral). Herbs are presented one at a time for self-assessment.',
  },
  {
    icon: <ClipboardDocumentListIcon className="w-5 h-5 text-green-700" />,
    title: 'Intake Assessment',
    description:
      "A physiomedicalist-style intake form based on deficiency and excess patterns. Answer questions about a patient's presentation and the tool suggests herbs whose energetics match the indicated pattern.",
  },
  {
    icon: <MagnifyingGlassIcon className="w-5 h-5 text-green-700" />,
    title: 'Filter Herbs',
    description:
      "Search and filter the full herb database by name, body system, therapeutic action, energetics, TCM herbs, and more. Select a result to jump directly to that herb's detail page.",
  },
];

export function HelpModal({ isOpen, onClose }: HelpModalProps) {
  useEffect(() => {
    if (!isOpen) return;
    const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onClose(); };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
      onClick={onClose}
    >
      <div
        className="relative bg-white rounded-2xl shadow-2xl w-full max-w-2xl flex flex-col overflow-hidden"
        style={{ maxHeight: 'calc(100vh - 2rem)' }}
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header — light green */}
        <div className="flex-shrink-0 px-6 pt-5 pb-4 bg-green-50 border-b border-green-200 flex items-start justify-between gap-4 rounded-t-2xl">
          <div>
            <h2 className="text-xl font-semibold text-green-900">Herbal Visualizer — App Guide</h2>
            <p className="text-sm text-green-700/70 mt-0.5">BHC Apprenticeship study tool</p>
          </div>
          <button
            onClick={onClose}
            className="text-green-600 hover:text-green-800 transition-colors mt-0.5"
            aria-label="Close"
          >
            <XMarkIcon className="w-5 h-5" />
          </button>
        </div>

        {/* Feature list */}
        <div className="overflow-y-auto px-6 py-4 space-y-5">
          {features.map((f) => (
            <div key={f.title} className="flex gap-3">
              <div className="mt-0.5 shrink-0 w-5 flex justify-center">{f.icon}</div>
              <div>
                <p className="font-semibold text-gray-800 leading-snug">{f.title}</p>
                <p className="text-sm text-gray-600 mt-0.5 leading-relaxed">{f.description}</p>
                {f.sub && (
                  <ul className="mt-2 space-y-1">
                    {f.sub.map((s) => (
                      <li key={s.label} className="text-sm text-gray-600 pl-3 border-l-2 border-green-200">
                        <span className="font-medium text-green-800">{s.label}:</span> {s.detail}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            </div>
          ))}
        </div>

        {/* Footer */}
        <div className="flex-shrink-0 px-6 py-4 border-t border-gray-100">
          <p className="text-xs text-gray-400 text-center">
            Data sourced from BHC Apprenticeship class materials · Press <kbd className="px-1 py-0.5 bg-gray-100 rounded text-gray-500 font-mono">Esc</kbd> to close
          </p>
        </div>
      </div>
    </div>
  );
}
