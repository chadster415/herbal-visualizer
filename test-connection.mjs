import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'http://localhost:54321';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  db: {
    schema: 'herbal'
  }
});

console.log('Testing Supabase connection...\n');

// Test 1: Count herbs
const { data: herbs, error: herbError } = await supabase
  .from('herbs')
  .select('*', { count: 'exact', head: true });

if (herbError) {
  console.error('❌ Error counting herbs:', herbError);
} else {
  console.log('✅ Herbs count:', herbs);
}

// Test 2: Get sample herb with relationships
const { data: garlicData, error: garlicError } = await supabase
  .from('herbs')
  .select(`
    *,
    herb_primary_actions (
      primary_actions (*),
      body_systems (*),
      relative_strength
    )
  `)
  .eq('latin_name', 'Allium sativum')
  .single();

if (garlicError) {
  console.error('❌ Error fetching garlic:', garlicError);
} else {
  console.log('\n✅ Garlic data:', JSON.stringify(garlicData, null, 2));
  console.log(`\n✅ Garlic has ${garlicData.herb_primary_actions.length} primary action relationships`);
}

// Test 3: List all herbs
const { data: allHerbs, error: allError } = await supabase
  .from('herbs')
  .select('common_name')
  .limit(10);

if (allError) {
  console.error('❌ Error listing herbs:', allError);
} else {
  console.log('\n✅ First 10 herbs:', allHerbs.map(h => h.common_name).join(', '));
}

console.log('\n✨ Connection test complete!');
