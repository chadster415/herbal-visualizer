-- Grant sequence usage so anon/authenticated can insert into recipe tables with SERIAL PKs
GRANT USAGE ON SEQUENCE herbal.recipes_id_seq TO anon, authenticated;
GRANT USAGE ON SEQUENCE herbal.recipe_herbs_id_seq TO anon, authenticated;
GRANT USAGE ON SEQUENCE herbal.recipe_images_id_seq TO anon, authenticated;

-- One image per recipe — enforce at DB level and enables ON CONFLICT in sync script
ALTER TABLE herbal.recipe_images ADD CONSTRAINT recipe_images_recipe_id_key UNIQUE (recipe_id);
