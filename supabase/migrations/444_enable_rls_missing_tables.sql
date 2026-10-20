-- Enable RLS on tables flagged by Supabase Security Advisor

ALTER TABLE herbal.constituent_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.food_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.herb_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.herb_monograph_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.recipe_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE herbal.action_pattern ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_read" ON herbal.constituent_profiles FOR SELECT USING (true);
CREATE POLICY "public_read" ON herbal.food_items FOR SELECT USING (true);
CREATE POLICY "public_read" ON herbal.herb_images FOR SELECT USING (true);
CREATE POLICY "public_read" ON herbal.herb_monograph_links FOR SELECT USING (true);
CREATE POLICY "public_read" ON herbal.recipe_images FOR SELECT USING (true);
CREATE POLICY "public_read" ON herbal.action_pattern FOR SELECT USING (true);
