'use client';

import { useState, useEffect, useCallback } from 'react';
import { supabase } from '@/lib/supabase';

interface HerbRow {
  id: number;
  common_name: string;
  latin_name: string;
  plant_part: string | null;
}

interface InventoryEntry {
  in_stock: boolean;
  notes: string;
}

type InventoryMap = Map<number, InventoryEntry>;

interface InventoryViewProps {
  onInventoryChange?: (inventory: InventoryMap) => void;
}

export function InventoryView({ onInventoryChange }: InventoryViewProps) {
  const [herbs, setHerbs] = useState<HerbRow[]>([]);
  const [inventory, setInventory] = useState<InventoryMap>(new Map());
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState<Set<number>>(new Set());
  const [saved, setSaved] = useState<Set<number>>(new Set());
  const [searchTerm, setSearchTerm] = useState('');
  const [userId, setUserId] = useState<string | null>(null);

  useEffect(() => {
    async function load() {
      const [{ data: { session } }, { data: herbData }, { data: invData }] = await Promise.all([
        supabase.auth.getSession(),
        supabase
          .from('herbs')
          .select('id, common_name, latin_name, plant_part')
          .order('common_name'),
        supabase
          .from('user_inventory')
          .select('herb_id, in_stock, notes'),
      ]);

      setUserId(session?.user.id ?? null);
      if (herbData) setHerbs(herbData);

      const map: InventoryMap = new Map();
      if (invData) {
        for (const row of invData) {
          map.set(row.herb_id, {
            in_stock: row.in_stock,
            notes: row.notes ?? '',
          });
        }
      }
      setInventory(map);
      setLoading(false);
    }
    load();
  }, []);

  const upsert = useCallback(async (herbId: number, patch: Partial<InventoryEntry>) => {
    if (!userId) return;
    const current = inventory.get(herbId) ?? { in_stock: false, notes: '' };
    const next = { ...current, ...patch };
    const newMap = new Map(inventory);
    newMap.set(herbId, next);

    setInventory(newMap);
    onInventoryChange?.(newMap);

    setSaving((prev) => new Set(prev).add(herbId));
    await supabase.from('user_inventory').upsert(
      { user_id: userId, herb_id: herbId, in_stock: next.in_stock, notes: next.notes },
      { onConflict: 'user_id,herb_id' }
    );
    setSaving((prev) => { const s = new Set(prev); s.delete(herbId); return s; });
    setSaved((prev) => new Set(prev).add(herbId));
    setTimeout(() => {
      setSaved((prev) => { const s = new Set(prev); s.delete(herbId); return s; });
    }, 1500);
  }, [userId, inventory, onInventoryChange]);

  const handleCheckbox = (herbId: number, checked: boolean) => {
    upsert(herbId, { in_stock: checked });
  };

  const handleNotesBlur = (herbId: number, value: string) => {
    const current = inventory.get(herbId);
    if (current?.notes !== value) {
      upsert(herbId, { notes: value });
    }
  };

  const filtered = searchTerm.trim()
    ? herbs.filter((h) =>
        h.common_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        h.latin_name.toLowerCase().includes(searchTerm.toLowerCase())
      )
    : herbs;

  const checkedCount = [...inventory.values()].filter((v) => v.in_stock).length;

  if (loading) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-green-100 p-6 pb-12 max-w-7xl mx-auto flex flex-col items-center justify-center py-24 gap-4">
        <style>{`@keyframes inv-spin { to { transform: rotate(360deg); } }`}</style>
        <div style={{ width: 36, height: 36, borderRadius: '50%', border: '4px solid #d1fae5', borderTopColor: '#10b981', animation: 'inv-spin 0.8s linear infinite' }} />
        <span className="text-gray-400 text-sm">Loading herbs…</span>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-green-100 p-6 pb-12 max-w-7xl mx-auto">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-6 pt-2">
        <div>
          <h2 className="text-2xl font-bold text-green-800">My Herb Inventory</h2>
          <p className="text-sm text-gray-500 mt-0.5">
            {checkedCount} of {herbs.length} herbs in stock
          </p>
        </div>
        <p className="text-xs text-gray-400 italic">
          ✓ Changes save automatically
        </p>
      </div>

      {/* Search */}
      <div className="mb-5">
        <input
          type="text"
          placeholder="Search herbs…"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full sm:w-72 px-3 py-2 rounded-lg border border-gray-300 text-sm focus:outline-none focus:ring-2 focus:ring-green-400"
        />
      </div>

      {/* Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-3">
        {filtered.map((herb) => {
          const entry = inventory.get(herb.id);
          const inStock = entry?.in_stock ?? false;
          const notes = entry?.notes ?? '';
          const isSaving = saving.has(herb.id);
          const isSaved = !isSaving && saved.has(herb.id);

          return (
            <div
              key={herb.id}
              className={`rounded-lg border p-3 transition-all ${
                inStock
                  ? 'bg-green-50 border-green-300'
                  : 'bg-gray-50 border-gray-200'
              }`}
            >
              {/* Row 1: checkbox + name (+ plant_part if set) */}
              <div className="flex items-start gap-2">
                <input
                  type="checkbox"
                  checked={inStock}
                  onChange={(e) => handleCheckbox(herb.id, e.target.checked)}
                  className="mt-1 h-4 w-4 rounded border-gray-300 text-green-600 focus:ring-green-500 cursor-pointer shrink-0"
                />
                <div className="flex-1 min-w-0">
                  <div className="flex items-start justify-between gap-2">
                    <div className="min-w-0">
                      <span className="font-semibold text-gray-900 text-sm">
                        {herb.common_name}
                        {herb.plant_part && <span className="font-normal text-gray-500"> ({herb.plant_part})</span>}
                      </span>
                      <span className="block text-xs italic text-gray-500 truncate">{herb.latin_name}</span>
                    </div>
                    {isSaving && (
                      <span className="text-[10px] text-gray-400 italic shrink-0 mt-0.5">saving…</span>
                    )}
                    {isSaved && (
                      <span className="text-[10px] text-green-600 shrink-0 mt-0.5">saved ✓</span>
                    )}
                  </div>
                </div>
              </div>

              {/* Row 2: notes textarea */}
              <div className="mt-2 ml-6">
                <textarea
                  defaultValue={notes}
                  placeholder="Notes…"
                  rows={2}
                  onBlur={(e) => handleNotesBlur(herb.id, e.target.value)}
                  className="w-full px-2 py-1 text-xs rounded border border-gray-200 focus:outline-none focus:ring-1 focus:ring-green-400 bg-white resize-y min-h-[40px] placeholder:text-gray-300"
                />
              </div>
            </div>
          );
        })}
      </div>

      {filtered.length === 0 && (
        <p className="text-center text-gray-400 text-sm py-12">No herbs match your search.</p>
      )}
    </div>
  );
}
