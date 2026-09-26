GRANT SELECT, INSERT, UPDATE, DELETE ON herbal.food_items TO anon, authenticated, service_role;
GRANT USAGE, SELECT ON SEQUENCE herbal.food_items_id_seq TO anon, authenticated, service_role;
