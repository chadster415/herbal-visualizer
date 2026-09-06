-- Allow multiple sources for the same herb+disorder in disorder_specific_remedies.
-- Previously UNIQUE(disorder_id, herb_id) prevented a PP entry from coexisting
-- with an existing Medical Herbalism entry for the same herb+disorder pair.
-- New constraint: UNIQUE(herb_id, disorder_id, source_id) so each source gets its own row.
-- NULL source_id rows (legacy Medical Herbalism data) are treated as one group per the
-- UNIQUE constraint's standard NULL-inequality behaviour — existing rows won't conflict
-- with each other or with sourced PP rows.

SET search_path TO herbal, public;

ALTER TABLE herbal.disorder_specific_remedies
  DROP CONSTRAINT disorder_specific_remedies_disorder_id_herb_id_key;

ALTER TABLE herbal.disorder_specific_remedies
  ADD CONSTRAINT disorder_specific_remedies_herb_disorder_source_key
  UNIQUE (herb_id, disorder_id, source_id);
