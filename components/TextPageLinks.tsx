'use client';

import { useEffect, useRef, useState } from 'react';

interface Props {
  disorderName: string;
  pageCount: number;
}

export function TextPageLinks({ disorderName, pageCount }: Props) {
  const [hoveredPage, setHoveredPage] = useState<number | null>(null);
  const [pinnedPage, setPinnedPage] = useState<number | null>(null);
  const [rect, setRect] = useState<DOMRect | null>(null);
  const hideTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    if (pinnedPage === null || pageCount <= 1) return;
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'ArrowLeft') setPinnedPage((p) => Math.max(1, (p ?? 1) - 1));
      if (e.key === 'ArrowRight') setPinnedPage((p) => Math.min(pageCount, (p ?? 1) + 1));
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [pinnedPage, pageCount]);

  if (pageCount === 0) return null;

  const imageUrl = (page: number) =>
    `/disorder_images/${encodeURIComponent(disorderName)}%20${page}.jpeg`;

  const clearHide = () => {
    if (hideTimer.current) clearTimeout(hideTimer.current);
  };

  const scheduleHide = () => {
    hideTimer.current = setTimeout(() => setHoveredPage(null), 120);
  };

  const handleLinkEnter = (page: number, e: React.MouseEvent) => {
    clearHide();
    setRect((e.currentTarget as HTMLElement).getBoundingClientRect());
    setHoveredPage(page);
  };

  const handleLinkClick = (page: number) => {
    setPinnedPage(page);
    setHoveredPage(null);
  };

  // Position the hover preview below and aligned to the link
  const previewStyle = rect
    ? {
        top: Math.min(rect.bottom + 6, window.innerHeight - 520),
        left: Math.min(rect.left, window.innerWidth - 440),
      }
    : {};

  return (
    <>
      <div className="flex flex-wrap gap-3 mb-4">
        {Array.from({ length: pageCount }, (_, i) => i + 1).map((page) => (
          <span
            key={page}
            onMouseEnter={(e) => handleLinkEnter(page, e)}
            onMouseLeave={scheduleHide}
            onClick={() => handleLinkClick(page)}
            className="text-xs text-blue-500 hover:text-blue-700 underline cursor-pointer select-none"
          >
            Text Page {page}
          </span>
        ))}
      </div>

      {/* Hover preview — floats near the link, no backdrop */}
      {hoveredPage !== null && !pinnedPage && rect && (
        <div
          style={{ position: 'fixed', zIndex: 9998, ...previewStyle }}
          onMouseEnter={clearHide}
          onMouseLeave={scheduleHide}
          className="rounded-xl shadow-2xl overflow-hidden border border-gray-200 bg-white pointer-events-auto"
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={imageUrl(hoveredPage)}
            alt={`${disorderName} page ${hoveredPage}`}
            className="block"
            style={{ maxWidth: 420, maxHeight: 520, objectFit: 'contain' }}
          />
        </div>
      )}

      {/* Pinned modal — centered with backdrop, stays until closed */}
      {pinnedPage !== null && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm"
          onClick={() => setPinnedPage(null)}
        >
          <div
            className="relative bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col"
            style={{ maxWidth: '90vw', maxHeight: '92vh' }}
            onClick={(e) => e.stopPropagation()}
          >
            {/* Close button */}
            <button
              onClick={() => setPinnedPage(null)}
              className="absolute top-3 right-3 z-10 bg-white/90 hover:bg-white rounded-full w-8 h-8 flex items-center justify-center text-gray-600 hover:text-gray-900 shadow-md transition-colors"
              aria-label="Close"
            >
              ✕
            </button>

            {/* Image */}
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img
              src={imageUrl(pinnedPage)}
              alt={`${disorderName} page ${pinnedPage}`}
              className="block"
              style={{ maxWidth: '90vw', maxHeight: '85vh', objectFit: 'contain' }}
            />

            {/* Page switcher — only shown when there are multiple pages */}
            {pageCount > 1 && (
              <div className="flex items-center justify-center gap-3 py-3 bg-white border-t border-gray-100">
                <button
                  onClick={() => setPinnedPage((p) => Math.max(1, (p ?? 1) - 1))}
                  disabled={pinnedPage === 1}
                  className="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100 text-gray-700 hover:bg-gray-200 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                  aria-label="Previous page"
                >
                  ‹
                </button>
                {Array.from({ length: pageCount }, (_, i) => i + 1).map((page) => (
                  <button
                    key={page}
                    onClick={() => setPinnedPage(page)}
                    className={`px-4 py-1.5 rounded-full text-xs font-medium transition-colors ${
                      page === pinnedPage
                        ? 'bg-green-600 text-white'
                        : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                    }`}
                  >
                    Page {page}
                  </button>
                ))}
                <button
                  onClick={() => setPinnedPage((p) => Math.min(pageCount, (p ?? 1) + 1))}
                  disabled={pinnedPage === pageCount}
                  className="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100 text-gray-700 hover:bg-gray-200 disabled:opacity-30 disabled:cursor-not-allowed transition-colors"
                  aria-label="Next page"
                >
                  ›
                </button>
              </div>
            )}
          </div>
        </div>
      )}
    </>
  );
}
