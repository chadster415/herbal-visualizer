SET search_path TO herbal, public;

-- Rename Rosehips entry to match Rosa spp. convention.
-- ID 849: Rosa canina, common_name='Rosehips' → Rosa spp., common_name='Rose', plant_part='hips'
-- MM Materia Medica entry removed from manifest (was flower content, not hips).

DO $$
BEGIN
  UPDATE herbal.herbs
  SET latin_name  = 'Rosa spp.',
      common_name = 'Rose',
      plant_part  = 'hips'
  WHERE id = 849;

  UPDATE herbal.constituent_profiles
  SET latin_name = 'Rosa spp.'
  WHERE herb_id = 849;

  RAISE NOTICE 'Renamed Rosehips (id 849) → Rose / Rosa spp. / hips';
END $$;
