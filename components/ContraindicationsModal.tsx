'use client';

import { useEffect, useState, useCallback, useRef } from 'react';

interface Props {
  isOpen: boolean;
  onClose: () => void;
  herbId: number;
  pageCount: number;
  herbName: string;
}

export function ContraindicationsModal({ isOpen, onClose, herbId, pageCount, herbName }: Props) {
  const [page, setPage] = useState(1);
  const [lockedHeight, setLockedHeight] = useState<number | null>(null);
  const imgRef = useRef<HTMLImageElement>(null);

  const prev = useCallback(() => setPage((p) => Math.max(1, p - 1)), []);
  const next = useCallback(() => setPage((p) => Math.min(pageCount, p + 1)), [pageCount]);

  useEffect(() => {
    if (!isOpen) { setPage(1); setLockedHeight(null); return; }
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'ArrowLeft') prev();
      else if (e.key === 'ArrowRight') next();
      else if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [isOpen, prev, next, onClose]);

  if (!isOpen) return null;

  const src = `/contraindications/${herbId}/page_${String(page).padStart(2, '0')}.jpg`;

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center bg-black/70"
      onClick={(e) => { if (e.target === e.currentTarget) onClose(); }}
    >
      <div className="relative flex flex-col bg-white rounded-xl shadow-2xl max-w-3xl w-full mx-4 max-h-[92vh]">
        {/* Header */}
        <div className="flex items-center justify-between px-5 py-3 border-b border-gray-200 shrink-0">
          <div>
            <p className="text-xs font-semibold uppercase tracking-widest text-red-700">Drug Interactions</p>
            <h2 className="text-lg font-bold text-gray-800">{herbName}</h2>
            <p className="text-xs text-gray-400 italic">Stockley&rsquo;s Herbal Medicines Interactions</p>
          </div>
          <button
            onClick={onClose}
            className="ml-4 shrink-0 text-gray-400 hover:text-gray-700 transition-colors"
            aria-label="Close"
          >
            <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        {/* Image */}
        <div
          className="overflow-y-auto flex items-start justify-center bg-gray-100 p-4"
          style={{ height: lockedHeight ?? 'auto', flexShrink: 0 }}
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            ref={imgRef}
            src={src}
            alt={`${herbName} contraindications page ${page}`}
            className="max-w-full shadow-md rounded"
            onLoad={() => {
              if (lockedHeight === null && imgRef.current) {
                setLockedHeight(imgRef.current.offsetHeight + 32);
              }
            }}
          />
        </div>

        {/* Footer nav */}
        <div className="flex items-center justify-between px-5 py-3 border-t border-gray-200 shrink-0">
          <button
            onClick={prev}
            disabled={page === 1}
            className="flex items-center gap-1.5 px-4 py-1.5 rounded-lg border border-gray-300 text-sm text-gray-600 hover:border-gray-400 hover:text-gray-800 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
            </svg>
            Prev
          </button>

          <span className="text-sm text-gray-500">
            {page} / {pageCount}
          </span>

          <button
            onClick={next}
            disabled={page === pageCount}
            className="flex items-center gap-1.5 px-4 py-1.5 rounded-lg border border-gray-300 text-sm text-gray-600 hover:border-gray-400 hover:text-gray-800 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
          >
            Next
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
      </div>
    </div>
  );
}
