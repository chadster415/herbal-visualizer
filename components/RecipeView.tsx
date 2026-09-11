'use client';

import { useState, useEffect, useRef } from 'react';
import { supabase } from '@/lib/supabase';
import { RecipeImageUpload } from './RecipeImageUpload';
import type { RecipeWithDetails } from '@/types/database';

interface Props {
  bodySystemId: number;
  selectedRecipeId?: number | null;
  onRecipeChange?: (id: number | null) => void;
  onHerbClick?: (herbId: number) => void;
  onSystemClick?: (systemId: number) => void;
  onActionNameClick?: (name: string) => void;
  isLoggedIn?: boolean;
}

export function RecipeView({ bodySystemId, selectedRecipeId, onRecipeChange, onHerbClick, onSystemClick, onActionNameClick, isLoggedIn }: Props) {
  const [recipes, setRecipes] = useState<RecipeWithDetails[]>([]);
  const [loading, setLoading] = useState(true);
  const [mobileListOpen, setMobileListOpen] = useState(false);
  const detailRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    fetchRecipes();
  }, [bodySystemId]);

  // Auto-select first recipe if none selected
  useEffect(() => {
    if (!loading && recipes.length > 0 && !selectedRecipeId) {
      onRecipeChange?.(recipes[0].id);
    }
  }, [loading, recipes, selectedRecipeId]);

  // Sync external selectedRecipeId
  useEffect(() => {
    if (selectedRecipeId != null && recipes.length > 0) {
      const exists = recipes.find((r) => r.id === selectedRecipeId);
      if (!exists) onRecipeChange?.(recipes[0]?.id ?? null);
    }
  }, [selectedRecipeId, recipes]);

  async function fetchRecipes() {
    setLoading(true);
    try {
      const { data } = await supabase
        .from('recipe_body_systems')
        .select(`
          recipe_id,
          recipes (
            id, name, description, preparation_label, instructions, taste, herbal_actions, sort_order, source,
            recipe_herbs (
              id, herb_id, herb_name_override, quantity, sort_order,
              herbs ( id, common_name, latin_name, plant_part )
            ),
            recipe_body_systems (
              body_system_id,
              body_systems ( id, name )
            )
          )
        `)
        .eq('body_system_id', bodySystemId)
        .order('sort_order', { referencedTable: 'recipes', ascending: true });

      const list: RecipeWithDetails[] = (data ?? [])
        .map((row: any) => row.recipes)
        .filter(Boolean)
        .map((r: any) => ({
          ...r,
          instructions: Array.isArray(r.instructions) ? r.instructions : [],
          recipe_herbs: [...(r.recipe_herbs ?? [])].sort((a: any, b: any) => a.sort_order - b.sort_order),
        }));

      setRecipes(list);
    } finally {
      setLoading(false);
    }
  }

  const selectedRecipe = recipes.find((r) => r.id === selectedRecipeId) ?? recipes[0] ?? null;

  const selectRecipe = (id: number) => {
    onRecipeChange?.(id);
    if (typeof window !== 'undefined' && window.innerWidth < 1024) {
      setMobileListOpen(false);
      setTimeout(() => detailRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 50);
    }
  };

  if (loading) return <div className="text-center py-8 text-gray-400">Loading recipes…</div>;
  if (recipes.length === 0) return <p className="text-gray-400 italic">No recipes recorded for this body system.</p>;

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
      {/* Recipe list */}
      <div className="lg:col-span-1">
        {/* Mobile toggle */}
        <button
          className="lg:hidden w-full flex items-center justify-between p-3 bg-gray-50 rounded-lg border border-gray-200 mb-2 text-sm font-medium text-gray-700"
          onClick={() => setMobileListOpen((p) => !p)}
        >
          {selectedRecipe?.name ?? 'Select a recipe'}
          <svg className={`w-4 h-4 transition-transform ${mobileListOpen ? 'rotate-180' : ''}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </button>

        <div className={`${mobileListOpen ? '' : 'hidden'} lg:block space-y-1`}>
          {recipes.map((recipe) => (
            <button
              key={recipe.id}
              onClick={() => selectRecipe(recipe.id)}
              className={`w-full text-left px-3 py-2.5 rounded-lg text-sm font-medium transition-all ${
                selectedRecipe?.id === recipe.id
                  ? 'bg-green-100 text-green-900 border border-green-300'
                  : 'text-gray-700 hover:bg-gray-50 hover:text-green-800'
              }`}
            >
              {recipe.name}
            </button>
          ))}
        </div>
      </div>

      {/* Recipe detail */}
      <div ref={detailRef} className="lg:col-span-2">
        {selectedRecipe ? (
          <RecipeDetail recipe={selectedRecipe} onHerbClick={onHerbClick} onSystemClick={onSystemClick} onActionNameClick={onActionNameClick} isLoggedIn={isLoggedIn} />
        ) : (
          <p className="text-gray-400 italic text-sm">Select a recipe to view details.</p>
        )}
      </div>
    </div>
  );
}

function RecipeDetail({
  recipe,
  onHerbClick,
  onSystemClick,
  onActionNameClick,
  isLoggedIn,
}: {
  recipe: RecipeWithDetails;
  onHerbClick?: (herbId: number) => void;
  onSystemClick?: (systemId: number) => void;
  onActionNameClick?: (name: string) => void;
  isLoggedIn?: boolean;
}) {
  const bodySystems = recipe.recipe_body_systems ?? [];

  return (
    <div>
      <RecipeImageUpload recipeId={recipe.id} isLoggedIn={isLoggedIn} />

      <h3 className="text-2xl font-bold text-green-800 tracking-wide uppercase mb-3">{recipe.name}</h3>

      {recipe.description && (
        <div className="mb-6">
          {recipe.description.split('\n\n').map((para, i) => (
            <p key={i} className="text-gray-700 leading-relaxed mb-2">{para}</p>
          ))}
        </div>
      )}

      {/* Preparation + Ingredients */}
      {(recipe.instructions.length > 0 || recipe.recipe_herbs.length > 0) && (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-6 bg-gray-50 rounded-xl p-5 border border-gray-100">
          {/* Instructions */}
          {recipe.instructions.length > 0 && (
            <div>
              {recipe.preparation_label && (
                <p className="text-[10px] font-bold tracking-widest text-gray-400 uppercase mb-3">
                  {recipe.preparation_label}
                </p>
              )}
              <div className="space-y-3">
                {recipe.instructions.map((step, i) => (
                  <div key={i}>
                    <span className="text-xs font-bold text-gray-700 uppercase tracking-wider">{step.label}: </span>
                    <span className="text-sm text-gray-600">{step.text}</span>
                  </div>
                ))}
              </div>
            </div>
          )}

          {/* Ingredients */}
          {recipe.recipe_herbs.length > 0 && (
            <div>
              <p className="text-[10px] font-bold tracking-widest text-gray-400 uppercase mb-3">Ingredients</p>
              <ul className="space-y-2">
                {recipe.recipe_herbs.map((rh) => {
                  const herb = rh.herbs;
                  const displayName = herb?.common_name ?? rh.herb_name_override ?? 'Unknown';
                  const isLinked = !!herb?.id;
                  return (
                    <li key={rh.id} className="flex items-baseline gap-2">
                      <span className="text-xs text-gray-400 w-16 shrink-0 text-right">{rh.quantity}</span>
                      {isLinked ? (
                        <button
                          onClick={() => onHerbClick?.(herb!.id)}
                          className="px-2.5 py-0.5 rounded-full bg-green-100 text-green-800 text-sm font-medium border border-green-200 hover:bg-green-200 hover:border-green-400 transition-colors"
                        >
                          {displayName}
                        </button>
                      ) : (
                        <span className="px-2.5 py-0.5 rounded-full bg-gray-100 text-gray-600 text-sm border border-gray-200">
                          {displayName}
                        </span>
                      )}
                    </li>
                  );
                })}
              </ul>
            </div>
          )}
        </div>
      )}

      {/* Footer: taste, actions, systems, source */}
      <div className="space-y-2 text-sm border-t border-gray-100 pt-4">
        {recipe.taste && (
          <div>
            <span className="font-semibold text-gray-500 uppercase text-[10px] tracking-widest">Taste: </span>
            <span className="text-gray-700">{recipe.taste}</span>
          </div>
        )}
        {(recipe.herbal_actions?.length ?? 0) > 0 && (
          <div className="flex items-baseline gap-2 flex-wrap">
            <span className="font-semibold text-gray-500 uppercase text-[10px] tracking-widest">Herbal Actions: </span>
            {recipe.herbal_actions!.map((action) => (
              onActionNameClick ? (
                <button key={action} onClick={() => onActionNameClick(action)} className="px-2 py-0.5 rounded-full bg-green-50 text-green-700 text-xs border border-green-100 hover:bg-green-100 hover:border-green-300 transition-colors">
                  {action}
                </button>
              ) : (
                <span key={action} className="px-2 py-0.5 rounded-full bg-green-50 text-green-700 text-xs border border-green-100">{action}</span>
              )
            ))}
          </div>
        )}
        {bodySystems.length > 0 && (
          <div className="flex items-baseline gap-2 flex-wrap">
            <span className="font-semibold text-gray-500 uppercase text-[10px] tracking-widest">Systems: </span>
            {bodySystems.map((bs: any) => (
              onSystemClick ? (
                <button key={bs.body_system_id} onClick={() => onSystemClick(bs.body_system_id)} className="px-2 py-0.5 rounded-full bg-blue-50 text-blue-700 text-xs border border-blue-100 hover:bg-blue-100 hover:border-blue-300 transition-colors">
                  {bs.body_systems?.name ?? ''}
                </button>
              ) : (
                <span key={bs.body_system_id} className="px-2 py-0.5 rounded-full bg-blue-50 text-blue-700 text-xs border border-blue-100">{bs.body_systems?.name ?? ''}</span>
              )
            ))}
          </div>
        )}
        {recipe.source && (
          <div className="pt-1 border-t border-gray-50">
            <span className="text-gray-400 text-xs italic">Source: {recipe.source}</span>
          </div>
        )}
      </div>
    </div>
  );
}
