import { NextResponse } from 'next/server';
import { createServerClient } from '@/lib/supabase-server';

const SPOONACULAR_KEY = process.env.SPOONACULAR_API_KEY!;

class SpoonacularQuotaError extends Error {}
class SpoonacularError extends Error {}

async function fetchSpoonacularInfo(foodName: string): Promise<Record<string, unknown> | null> {
  const searchRes = await fetch(
    `https://api.spoonacular.com/food/ingredients/search?query=${encodeURIComponent(foodName)}&number=1&apiKey=${SPOONACULAR_KEY}`
  );
  if (searchRes.status === 402 || searchRes.status === 429) throw new SpoonacularQuotaError('Daily quota exceeded');
  if (!searchRes.ok) throw new SpoonacularError(`Search failed: ${searchRes.status}`);
  const { results } = await searchRes.json();
  if (!results?.length) return null;

  const id: number = results[0].id;

  const infoRes = await fetch(
    `https://api.spoonacular.com/food/ingredients/${id}/information?amount=1&apiKey=${SPOONACULAR_KEY}`
  );
  if (infoRes.status === 402 || infoRes.status === 429) throw new SpoonacularQuotaError('Daily quota exceeded');
  if (!infoRes.ok) throw new SpoonacularError(`Info fetch failed: ${infoRes.status}`);
  return await infoRes.json();
}

export async function POST(request: Request) {
  const { foods } = (await request.json()) as { foods: string[] };
  if (!Array.isArray(foods) || foods.length === 0) {
    return NextResponse.json({ error: 'No foods provided' }, { status: 400 });
  }

  const supabase = createServerClient();
  const result: Record<string, { aisle: string | null; spoonacular_id: number | null }> = {};

  // Check which foods are already cached
  const { data: cached } = await supabase
    .from('food_items')
    .select('name, aisle, spoonacular_id')
    .in('name', foods.map((f) => f.toLowerCase()));

  const cachedMap = new Map((cached ?? []).map((r: any) => [r.name, r]));

  const uncached = foods.filter((f) => !cachedMap.has(f.toLowerCase()));

  // Return cached results immediately
  for (const row of cachedMap.values() as any) {
    console.log('[spoonacular] cache hit:', row.name);
    result[row.name] = { aisle: row.aisle, spoonacular_id: row.spoonacular_id };
  }

  // Fetch uncached foods from Spoonacular (sequentially to respect rate limits)
  try {
    for (const food of uncached) {
      const key = food.toLowerCase();
      console.log('[spoonacular] api hit:', key);
      const info = await fetchSpoonacularInfo(food);

      if (info) {
        const row = {
          name: key,
          spoonacular_id: info.id as number,
          spoonacular_name: info.name as string,
          aisle: info.aisle as string ?? null,
          image: info.image as string ?? null,
          consistency: info.consistency as string ?? null,
          estimated_cost_cents: (info.estimatedCost as any)?.value
            ? Math.round((info.estimatedCost as any).value)
            : null,
          possible_units: info.possibleUnits ?? null,
          nutrients: (info.nutrition as any)?.nutrients ?? null,
          properties: (info.nutrition as any)?.properties ?? null,
          flavonoids: (info.nutrition as any)?.flavonoids ?? null,
          caloric_breakdown: (info.nutrition as any)?.caloricBreakdown ?? null,
          weight_per_serving: (info.nutrition as any)?.weightPerServing ?? null,
          category_path: info.categoryPath ?? null,
          raw_response: info,
        };

        const { error: upsertError } = await supabase.from('food_items').upsert(row, { onConflict: 'name' });
        if (upsertError) console.error('[food_items upsert failed]', upsertError.message, 'food:', row.name);
        result[key] = { aisle: row.aisle, spoonacular_id: row.spoonacular_id };
      } else {
        console.log('[spoonacular] no result found for:', food);
        result[key] = { aisle: null, spoonacular_id: null };
      }
    }
  } catch (err) {
    if (err instanceof SpoonacularQuotaError) {
      return NextResponse.json(
        { error: 'quota_exceeded', message: 'Daily Spoonacular quota exceeded — try again tomorrow.' },
        { status: 402 }
      );
    }
    return NextResponse.json(
      { error: 'spoonacular_unavailable', message: 'Spoonacular is currently unavailable.' },
      { status: 502 }
    );
  }

  return NextResponse.json(result);
}
