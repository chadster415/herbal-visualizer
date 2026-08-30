-- Migration 223: Merge duplicate ailment keywords in herb_keywords + ailment_search_terms
-- Canonical terms kept: urinary tract infection, hormonal support, uterine tonic,
--                       digestive tonic, heavy bleeding
-- Duplicates removed:   UTI, hormonal imbalance, hormone balance,
--                       uterine support, uterine health, digestive support, uterine bleeding

SET search_path TO herbal, public;

-- ─────────────────────────────────────────────────────────────────────────────
-- Helper: for each merge, delete the duplicate row from herbs that already have
-- the canonical keyword (avoids UNIQUE constraint violation on UPDATE), then
-- remap the remaining rows.
-- ─────────────────────────────────────────────────────────────────────────────

-- 1. UTI → urinary tract infection
--    (urinary tract infection already has UTI as a synonym — no synonym update needed)
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'UTI' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'urinary tract infection');
UPDATE herbal.herb_keywords SET keyword = 'urinary tract infection'
  WHERE keyword = 'UTI' AND category = 'ailment';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'UTI';

-- 2. hormonal imbalance → hormonal support
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'hormonal imbalance' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'hormonal support');
UPDATE herbal.herb_keywords SET keyword = 'hormonal support'
  WHERE keyword = 'hormonal imbalance' AND category = 'ailment';
-- Merge unique synonyms into hormonal support
UPDATE herbal.ailment_search_terms
  SET synonyms = (
    SELECT ARRAY(
      SELECT DISTINCT unnest(synonyms || ARRAY[
        'hormonal imbalance','hormone imbalance','hormonal disruption','endocrine imbalance',
        'hormonal balance','hormone regulation','endocrine balance'
      ])
      ORDER BY 1
    )
  )
  WHERE ailment_keyword = 'hormonal support';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'hormonal imbalance';

-- 3. hormone balance → hormonal support
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'hormone balance' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'hormonal support');
UPDATE herbal.herb_keywords SET keyword = 'hormonal support'
  WHERE keyword = 'hormone balance' AND category = 'ailment';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'hormone balance';

-- 4. uterine support → uterine tonic
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'uterine support' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'uterine tonic');
UPDATE herbal.herb_keywords SET keyword = 'uterine tonic'
  WHERE keyword = 'uterine support' AND category = 'ailment';
-- Merge unique synonyms into uterine tonic
UPDATE herbal.ailment_search_terms
  SET synonyms = (
    SELECT ARRAY(
      SELECT DISTINCT unnest(synonyms || ARRAY[
        'uterine support','uterus support','uterine function','womb support',
        'uterus health','womb health'
      ])
      ORDER BY 1
    )
  )
  WHERE ailment_keyword = 'uterine tonic';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'uterine support';

-- 5. uterine health → uterine tonic
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'uterine health' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'uterine tonic');
UPDATE herbal.herb_keywords SET keyword = 'uterine tonic'
  WHERE keyword = 'uterine health' AND category = 'ailment';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'uterine health';

-- 6. digestive support → digestive tonic
--    (digestive tonic synonyms already include 'digestive support')
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'digestive support' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'digestive tonic');
UPDATE herbal.herb_keywords SET keyword = 'digestive tonic'
  WHERE keyword = 'digestive support' AND category = 'ailment';
UPDATE herbal.ailment_search_terms
  SET synonyms = (
    SELECT ARRAY(
      SELECT DISTINCT unnest(synonyms || ARRAY[
        'digestion','digestive health','GI support','gastrointestinal support','digestive support'
      ])
      ORDER BY 1
    )
  )
  WHERE ailment_keyword = 'digestive tonic';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'digestive support';

-- 7. uterine bleeding → heavy bleeding
DELETE FROM herbal.herb_keywords
  WHERE keyword = 'uterine bleeding' AND category = 'ailment'
    AND herb_id IN (SELECT herb_id FROM herbal.herb_keywords WHERE keyword = 'heavy bleeding');
UPDATE herbal.herb_keywords SET keyword = 'heavy bleeding'
  WHERE keyword = 'uterine bleeding' AND category = 'ailment';
UPDATE herbal.ailment_search_terms
  SET synonyms = (
    SELECT ARRAY(
      SELECT DISTINCT unnest(synonyms || ARRAY[
        'uterine bleeding','uterine hemorrhage','abnormal uterine bleeding','AUB'
      ])
      ORDER BY 1
    )
  )
  WHERE ailment_keyword = 'heavy bleeding';
DELETE FROM herbal.ailment_search_terms WHERE ailment_keyword = 'uterine bleeding';
