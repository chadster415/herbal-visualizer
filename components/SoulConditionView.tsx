'use client';

import { useState, useEffect, useRef, useMemo } from 'react';
import Fuse from 'fuse.js';
import { supabase } from '@/lib/supabase';
import type {
  FlowerEssenceCategory,
  FlowerEssenceConditionEntry,
  FlowerEssenceSeeAlso,
} from '@/types/database';
import { MagnifyingGlassIcon, XMarkIcon } from '@heroicons/react/24/outline';

interface CategoryDetail extends FlowerEssenceCategory {
  entries: FlowerEssenceConditionEntry[];
  see_also: string[];
}

interface SoulConditionViewProps {
  onEssenceClick?: (essenceName: string) => void;
  selectedCategory?: string | null;
  onCategoryChange?: (category: string | null) => void;
}

export function SoulConditionView({ onEssenceClick, selectedCategory, onCategoryChange }: SoulConditionViewProps) {
  const [categories, setCategories] = useState<FlowerEssenceCategory[]>([]);
  const [entries, setEntries] = useState<FlowerEssenceConditionEntry[]>([]);
  const [seeAlso, setSeeAlso] = useState<FlowerEssenceSeeAlso[]>([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState<CategoryDetail | null>(null);
  const [search, setSearch] = useState('');
  const [dropdownIndex, setDropdownIndex] = useState(-1);
  // Start collapsed on mobile when restoring a previous selection; open otherwise
  const [mobileListOpen, setMobileListOpen] = useState(!selectedCategory);
  const searchInputRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLUListElement>(null);
  const detailRef = useRef<HTMLDivElement>(null);
  const categoryRefs = useRef<Map<string, HTMLButtonElement>>(new Map());

  useEffect(() => {
    async function load() {
      const [catRes, entRes, saRes] = await Promise.all([
        supabase.from('flower_essence_categories').select('category, search_keywords').order('category'),
        supabase.from('flower_essence_condition_entries').select('id, category, plant_name, plant_id, description').order('plant_name'),
        supabase.from('flower_essence_category_see_also').select('from_category, to_category'),
      ]);
      const cats = (catRes.data ?? []) as FlowerEssenceCategory[];
      const ents = (entRes.data ?? []) as FlowerEssenceConditionEntry[];
      const sas  = (saRes.data  ?? []) as FlowerEssenceSeeAlso[];
      setCategories(cats);
      setEntries(ents);
      setSeeAlso(sas);
      setLoading(false);

      // Restore previously selected category (e.g. after Back navigation)
      if (selectedCategory) {
        const cat = cats.find((c) => c.category === selectedCategory);
        if (cat) {
          const catEntries = ents.filter((e) => e.category === cat.category);
          const seenFrom = sas.filter((sa) => sa.from_category === cat.category).map((sa) => sa.to_category);
          const seenTo   = sas.filter((sa) => sa.to_category   === cat.category).map((sa) => sa.from_category);
          const allSeeAlso = [...new Set([...seenFrom, ...seenTo])].sort();
          setSelected({ ...cat, entries: catEntries, see_also: allSeeAlso });
          // On mobile keep list collapsed; on desktop scroll to it
          setTimeout(() => {
            if (typeof window !== 'undefined' && window.innerWidth >= 1024) {
              scrollCategoryInSidebar(cat.category);
            }
          }, 100);
        }
      }
    }
    load();
  }, []);

  const fuse = useMemo(() => new Fuse(categories, {
    keys: [
      { name: 'category', weight: 3 },
      { name: 'search_keywords', weight: 1 },
    ],
    threshold: 0.35,
    ignoreLocation: true,
    minMatchCharLength: 2,
  }), [categories]);

  const searchResults = useMemo(() => {
    if (!search.trim()) return [];
    return fuse.search(search.trim()).slice(0, 12).map((r) => r.item);
  }, [search, fuse]);

  function buildDetail(cat: FlowerEssenceCategory): CategoryDetail {
    const catEntries = entries.filter((e) => e.category === cat.category);
    const seenFrom = seeAlso.filter((sa) => sa.from_category === cat.category).map((sa) => sa.to_category);
    const seenTo = seeAlso.filter((sa) => sa.to_category === cat.category).map((sa) => sa.from_category);
    const allSeeAlso = [...new Set([...seenFrom, ...seenTo])].sort();
    return { ...cat, entries: catEntries, see_also: allSeeAlso };
  }

  function scrollCategoryInSidebar(category: string) {
    const el = categoryRefs.current.get(category);
    if (!el) return;
    let container: HTMLElement | null = el.parentElement;
    while (container) {
      const { overflowY } = getComputedStyle(container);
      if (overflowY === 'auto' || overflowY === 'scroll') break;
      container = container.parentElement;
    }
    if (!container) return;
    const cRect = container.getBoundingClientRect();
    const eRect = el.getBoundingClientRect();
    container.scrollTo({ top: eRect.top - cRect.top + container.scrollTop - 20, behavior: 'smooth' });
  }

  function selectCategory(cat: FlowerEssenceCategory) {
    setSelected(buildDetail(cat));
    onCategoryChange?.(cat.category);
    setSearch('');
    setDropdownIndex(-1);
    // Collapse list on mobile so the detail panel is immediately visible
    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
      setMobileListOpen(false);
      setTimeout(() => detailRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
    } else {
      setTimeout(() => scrollCategoryInSidebar(cat.category), 50);
    }
  }

  function handleKeyDown(e: React.KeyboardEvent) {
    if (!searchResults.length) return;
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      setDropdownIndex((i) => Math.min(i + 1, searchResults.length - 1));
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      setDropdownIndex((i) => Math.max(i - 1, 0));
    } else if (e.key === 'Enter' && dropdownIndex >= 0) {
      e.preventDefault();
      selectCategory(searchResults[dropdownIndex]);
    } else if (e.key === 'Escape') {
      setSearch('');
      setDropdownIndex(-1);
    }
  }

  useEffect(() => {
    if (dropdownIndex < 0 || !dropdownRef.current) return;
    const items = dropdownRef.current.querySelectorAll('li');
    items[dropdownIndex]?.scrollIntoView({ block: 'nearest' });
  }, [dropdownIndex]);

  if (loading) return <div className="text-center py-8 text-purple-600">Loading soul conditions…</div>;

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">
      {/* Left: condition list */}
      <div className="lg:col-span-1 bg-white rounded-lg shadow-lg p-6">

        {/* Header row: title + mobile toggle */}
        <div className={`flex items-center gap-2 ${mobileListOpen ? 'mb-4' : ''}`}>
          <h2 className="text-lg font-bold text-purple-800 flex-1">Soul Conditions</h2>
          <button
            className="lg:hidden flex-shrink-0 p-2 rounded-lg text-gray-500 hover:text-gray-700 hover:bg-gray-100 transition-all"
            onClick={() => setMobileListOpen((prev) => !prev)}
            aria-label="Toggle condition list"
          >
            <svg
              className={`w-5 h-5 transition-transform duration-200 ${mobileListOpen ? 'rotate-180' : ''}`}
              fill="none" stroke="currentColor" viewBox="0 0 24 24"
            >
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>

        {/* Collapsible body */}
        <div className={`${mobileListOpen ? '' : 'hidden'} lg:block`}>
          {/* Search */}
          <div className="relative mb-4">
            <div className="relative">
              <MagnifyingGlassIcon className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none" />
              <input
                ref={searchInputRef}
                type="text"
                placeholder="Search conditions…"
                value={search}
                onChange={(e) => { setSearch(e.target.value); setDropdownIndex(-1); if (e.target.value) setMobileListOpen(true); }}
                onFocus={() => setMobileListOpen(true)}
                onKeyDown={handleKeyDown}
                className="w-full pl-9 pr-8 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-purple-300"
              />
              {search && (
                <button
                  onClick={() => { setSearch(''); setDropdownIndex(-1); searchInputRef.current?.focus(); }}
                  className="absolute right-2 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                >
                  <XMarkIcon className="w-4 h-4" />
                </button>
              )}
            </div>

            {/* Search dropdown */}
            {searchResults.length > 0 && (
              <ul
                ref={dropdownRef}
                className="absolute z-20 top-full mt-1 left-0 right-0 bg-white border border-purple-200 rounded-lg shadow-lg max-h-64 overflow-y-auto"
              >
                {searchResults.map((cat, idx) => (
                  <li key={cat.category}>
                    <button
                      onMouseDown={() => selectCategory(cat)}
                      className={`w-full text-left px-3 py-2 text-sm hover:bg-purple-50 transition-colors ${idx === dropdownIndex ? 'bg-purple-50 font-medium' : ''}`}
                    >
                      {cat.category}
                    </button>
                  </li>
                ))}
              </ul>
            )}
          </div>

          {/* Scrollable alphabetical list */}
          <div className="space-y-1 max-h-[70vh] overflow-y-auto px-1 py-1">
            {categories.map((cat) => {
              const count = entries.filter((e) => e.category === cat.category).length;
              return (
                <button
                  key={cat.category}
                  ref={(el) => {
                    if (el) categoryRefs.current.set(cat.category, el);
                    else categoryRefs.current.delete(cat.category);
                  }}
                  onClick={() => selectCategory(cat)}
                  className={`w-full text-left px-3 py-2 rounded-lg border transition-all text-sm ${
                    selected?.category === cat.category
                      ? 'bg-purple-100 border-purple-300 ring-2 ring-purple-400 ring-offset-1 font-semibold text-purple-900'
                      : 'bg-gray-50 border-gray-200 hover:bg-purple-50 hover:border-purple-200 text-gray-800'
                  }`}
                >
                  <div className="flex items-center justify-between gap-2">
                    <span className="truncate">{cat.category}</span>
                    <span className="text-xs text-purple-400 shrink-0">{count}</span>
                  </div>
                </button>
              );
            })}
          </div>
        </div>
      </div>

      {/* Right: condition detail */}
      <div ref={detailRef} className="lg:col-span-2 bg-white rounded-lg shadow-lg p-6">
        {!selected ? (
          <div className="text-center py-16 text-gray-400">
            <p className="text-lg">Select a soul condition to view details</p>
            <p className="text-sm mt-1">or search above to find one</p>
          </div>
        ) : (
          <div>
            <h2 className="text-3xl font-bold text-purple-800 mb-2">{selected.category}</h2>

            {/* See Also */}
            {selected.see_also.length > 0 && (
              <div className="mb-5">
                <p className="text-xs font-semibold text-purple-400 uppercase tracking-widest mb-2">See Also</p>
                <div className="flex flex-wrap gap-2">
                  {selected.see_also.map((ref) => (
                    <button
                      key={ref}
                      onClick={() => {
                        const cat = categories.find((c) => c.category === ref);
                        if (cat) selectCategory(cat);
                      }}
                      className="px-3 py-1 rounded-full text-sm bg-purple-50 text-purple-700 border border-purple-200 hover:bg-purple-100 hover:border-purple-300 transition-colors"
                    >
                      {ref}
                    </button>
                  ))}
                </div>
              </div>
            )}

            <div className="border-t border-purple-100 pt-4">
              <p className="text-xs font-semibold text-purple-400 uppercase tracking-widest mb-3">
                Flower Essences for this Condition ({selected.entries.length})
              </p>
              <div className="space-y-4">
                {selected.entries.map((entry) => (
                  <div key={entry.id} className="border border-purple-100 rounded-lg p-4 bg-purple-50/30">
                    <button
                      onClick={() => onEssenceClick?.(entry.plant_name)}
                      className="font-semibold text-purple-800 hover:text-purple-600 hover:underline transition-colors text-left"
                    >
                      {entry.plant_name}
                    </button>
                    {entry.description && (
                      <p className="text-sm text-gray-700 mt-1 leading-relaxed">{entry.description}</p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
