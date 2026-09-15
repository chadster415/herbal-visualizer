-- Dedupe Nettle leaf (herb_id=43) constituent_profiles after a double import merge.
-- Keeping the most complete row for each duplicated constituent:
--   Rutin:            keep 742 (status=Marker, higher rank) / delete 2182 (status=Major)
--   Chlorogenic acid: keep 2183 (importance=High, better notes) / delete 744 (importance=Moderate)
--   Quercetin:        keep 743 (importance=High) / delete 2184 (importance=Moderate)
--   Kaempferol (2185) is unique to the second import — retained.

DELETE FROM herbal.constituent_profiles WHERE id IN (2182, 744, 2184);
