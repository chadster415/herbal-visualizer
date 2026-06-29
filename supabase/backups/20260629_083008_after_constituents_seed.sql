--
-- PostgreSQL database dump
--

\restrict dYdafw48ZCGnFUOHZQVd5nXVGYdH7mWlWfoTPZThBPQxrCsH2yJ2XzwhMm4IMQh

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP POLICY IF EXISTS public_read ON herbal.secondary_actions;
DROP POLICY IF EXISTS public_read ON herbal.primary_actions;
DROP POLICY IF EXISTS public_read ON herbal.prescription_herbs;
DROP POLICY IF EXISTS public_read ON herbal.prescription_herb_actions;
DROP POLICY IF EXISTS public_read ON herbal.herbs;
DROP POLICY IF EXISTS public_read ON herbal.herb_secondary_actions;
DROP POLICY IF EXISTS public_read ON herbal.herb_primary_actions;
DROP POLICY IF EXISTS public_read ON herbal.herb_menstruum;
DROP POLICY IF EXISTS public_read ON herbal.herb_constituents;
DROP POLICY IF EXISTS public_read ON herbal.disorders;
DROP POLICY IF EXISTS public_read ON herbal.disorder_specific_remedies;
DROP POLICY IF EXISTS public_read ON herbal.disorder_prescriptions;
DROP POLICY IF EXISTS public_read ON herbal.disorder_notes;
DROP POLICY IF EXISTS public_read ON herbal.disorder_actions_indicated;
DROP POLICY IF EXISTS public_read ON herbal.disorder_action_herbs;
DROP POLICY IF EXISTS public_read ON herbal.constituents;
DROP POLICY IF EXISTS public_read ON herbal.body_systems;
DROP POLICY IF EXISTS public_read ON herbal.body_system_notes;
DROP POLICY IF EXISTS public_read ON herbal.aging_herbs;
DROP POLICY IF EXISTS public_read ON herbal.action_descriptions;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herbs DROP CONSTRAINT IF EXISTS prescription_herbs_prescription_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herbs DROP CONSTRAINT IF EXISTS prescription_herbs_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herb_actions DROP CONSTRAINT IF EXISTS prescription_herb_actions_primary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herb_actions DROP CONSTRAINT IF EXISTS prescription_herb_actions_prescription_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_secondary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_body_system_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_primary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_body_system_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_menstruum DROP CONSTRAINT IF EXISTS herb_menstruum_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_constituents DROP CONSTRAINT IF EXISTS herb_constituents_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_constituents DROP CONSTRAINT IF EXISTS herb_constituents_constituent_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorders DROP CONSTRAINT IF EXISTS disorders_body_system_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_specific_remedies DROP CONSTRAINT IF EXISTS disorder_specific_remedies_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_specific_remedies DROP CONSTRAINT IF EXISTS disorder_specific_remedies_disorder_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_prescriptions DROP CONSTRAINT IF EXISTS disorder_prescriptions_disorder_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_notes DROP CONSTRAINT IF EXISTS disorder_notes_disorder_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_actions_indicated DROP CONSTRAINT IF EXISTS disorder_actions_indicated_primary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_actions_indicated DROP CONSTRAINT IF EXISTS disorder_actions_indicated_disorder_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_action_herbs DROP CONSTRAINT IF EXISTS disorder_action_herbs_primary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_action_herbs DROP CONSTRAINT IF EXISTS disorder_action_herbs_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_action_herbs DROP CONSTRAINT IF EXISTS disorder_action_herbs_disorder_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.body_system_notes DROP CONSTRAINT IF EXISTS body_system_notes_body_system_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.aging_herbs DROP CONSTRAINT IF EXISTS aging_herbs_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.action_descriptions DROP CONSTRAINT IF EXISTS action_descriptions_primary_action_id_fkey;
DROP INDEX IF EXISTS herbal.idx_prescription_herbs_prescription;
DROP INDEX IF EXISTS herbal.idx_prescription_herbs_herb;
DROP INDEX IF EXISTS herbal.idx_prescription_herb_actions_prescription_herb;
DROP INDEX IF EXISTS herbal.idx_prescription_herb_actions_action;
DROP INDEX IF EXISTS herbal.idx_herbs_latin_name;
DROP INDEX IF EXISTS herbal.idx_herbs_common_name;
DROP INDEX IF EXISTS herbal.idx_herb_secondary_actions_herb;
DROP INDEX IF EXISTS herbal.idx_herb_secondary_actions_body_system;
DROP INDEX IF EXISTS herbal.idx_herb_secondary_actions_action;
DROP INDEX IF EXISTS herbal.idx_herb_primary_actions_system;
DROP INDEX IF EXISTS herbal.idx_herb_primary_actions_herb;
DROP INDEX IF EXISTS herbal.idx_herb_primary_actions_action;
DROP INDEX IF EXISTS herbal.idx_disorders_name;
DROP INDEX IF EXISTS herbal.idx_disorders_body_system;
DROP INDEX IF EXISTS herbal.idx_disorder_specific_remedies_herb;
DROP INDEX IF EXISTS herbal.idx_disorder_specific_remedies_disorder;
DROP INDEX IF EXISTS herbal.idx_disorder_prescriptions_disorder;
DROP INDEX IF EXISTS herbal.idx_disorder_notes_disorder;
DROP INDEX IF EXISTS herbal.idx_disorder_actions_indicated_disorder;
DROP INDEX IF EXISTS herbal.idx_disorder_actions_indicated_action;
DROP INDEX IF EXISTS herbal.idx_disorder_action_herbs_herb;
DROP INDEX IF EXISTS herbal.idx_disorder_action_herbs_disorder;
DROP INDEX IF EXISTS herbal.idx_disorder_action_herbs_action;
DROP INDEX IF EXISTS herbal.idx_body_system_notes_system;
DROP INDEX IF EXISTS herbal.idx_action_descriptions_action;
DROP INDEX IF EXISTS herbal.herb_constituents_level_idx;
DROP INDEX IF EXISTS herbal.herb_constituents_herb_id_idx;
DROP INDEX IF EXISTS herbal.herb_constituents_constituent_id_idx;
ALTER TABLE IF EXISTS ONLY herbal.secondary_actions DROP CONSTRAINT IF EXISTS secondary_actions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.secondary_actions DROP CONSTRAINT IF EXISTS secondary_actions_name_key;
ALTER TABLE IF EXISTS ONLY herbal.primary_actions DROP CONSTRAINT IF EXISTS primary_actions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.primary_actions DROP CONSTRAINT IF EXISTS primary_actions_name_key;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herbs DROP CONSTRAINT IF EXISTS prescription_herbs_pkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herb_actions DROP CONSTRAINT IF EXISTS prescription_herb_actions_prescription_herb_id_primary_acti_key;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herb_actions DROP CONSTRAINT IF EXISTS prescription_herb_actions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herbs DROP CONSTRAINT IF EXISTS herbs_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herbs DROP CONSTRAINT IF EXISTS herbs_latin_name_key;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_herb_id_secondary_action_id_body_system_;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_primary_action_id_body_system__key;
ALTER TABLE IF EXISTS ONLY herbal.herb_menstruum DROP CONSTRAINT IF EXISTS herb_menstruum_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_constituents DROP CONSTRAINT IF EXISTS herb_constituents_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_constituents DROP CONSTRAINT IF EXISTS herb_constituents_herb_id_constituent_id_key;
ALTER TABLE IF EXISTS ONLY herbal.disorders DROP CONSTRAINT IF EXISTS disorders_pkey;
ALTER TABLE IF EXISTS ONLY herbal.disorders DROP CONSTRAINT IF EXISTS disorders_name_body_system_id_key;
ALTER TABLE IF EXISTS ONLY herbal.disorder_specific_remedies DROP CONSTRAINT IF EXISTS disorder_specific_remedies_pkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_specific_remedies DROP CONSTRAINT IF EXISTS disorder_specific_remedies_disorder_id_herb_id_key;
ALTER TABLE IF EXISTS ONLY herbal.disorder_prescriptions DROP CONSTRAINT IF EXISTS disorder_prescriptions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_notes DROP CONSTRAINT IF EXISTS disorder_notes_pkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_actions_indicated DROP CONSTRAINT IF EXISTS disorder_actions_indicated_pkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_actions_indicated DROP CONSTRAINT IF EXISTS disorder_actions_indicated_disorder_id_primary_action_id_key;
ALTER TABLE IF EXISTS ONLY herbal.disorder_action_herbs DROP CONSTRAINT IF EXISTS disorder_action_herbs_pkey;
ALTER TABLE IF EXISTS ONLY herbal.disorder_action_herbs DROP CONSTRAINT IF EXISTS disorder_action_herbs_disorder_id_herb_id_primary_action_id_key;
ALTER TABLE IF EXISTS ONLY herbal.constituents DROP CONSTRAINT IF EXISTS constituents_pkey;
ALTER TABLE IF EXISTS ONLY herbal.constituents DROP CONSTRAINT IF EXISTS constituents_name_key;
ALTER TABLE IF EXISTS ONLY herbal.body_systems DROP CONSTRAINT IF EXISTS body_systems_pkey;
ALTER TABLE IF EXISTS ONLY herbal.body_systems DROP CONSTRAINT IF EXISTS body_systems_name_key;
ALTER TABLE IF EXISTS ONLY herbal.body_system_notes DROP CONSTRAINT IF EXISTS body_system_notes_pkey;
ALTER TABLE IF EXISTS ONLY herbal.body_system_notes DROP CONSTRAINT IF EXISTS body_system_notes_body_system_id_sort_order_key;
ALTER TABLE IF EXISTS ONLY herbal.aging_herbs DROP CONSTRAINT IF EXISTS aging_herbs_pkey;
ALTER TABLE IF EXISTS ONLY herbal.action_descriptions DROP CONSTRAINT IF EXISTS action_descriptions_pkey;
ALTER TABLE IF EXISTS herbal.secondary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.primary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.prescription_herbs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.prescription_herb_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herbs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herb_secondary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herb_primary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herb_constituents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_specific_remedies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_prescriptions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_notes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_actions_indicated ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_action_herbs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.constituents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.body_systems ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.body_system_notes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.action_descriptions ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS herbal.secondary_actions_id_seq;
DROP TABLE IF EXISTS herbal.secondary_actions;
DROP SEQUENCE IF EXISTS herbal.primary_actions_id_seq;
DROP TABLE IF EXISTS herbal.primary_actions;
DROP SEQUENCE IF EXISTS herbal.prescription_herbs_id_seq;
DROP TABLE IF EXISTS herbal.prescription_herbs;
DROP SEQUENCE IF EXISTS herbal.prescription_herb_actions_id_seq;
DROP TABLE IF EXISTS herbal.prescription_herb_actions;
DROP SEQUENCE IF EXISTS herbal.herbs_id_seq;
DROP TABLE IF EXISTS herbal.herbs;
DROP SEQUENCE IF EXISTS herbal.herb_secondary_actions_id_seq;
DROP TABLE IF EXISTS herbal.herb_secondary_actions;
DROP SEQUENCE IF EXISTS herbal.herb_primary_actions_id_seq;
DROP TABLE IF EXISTS herbal.herb_primary_actions;
DROP TABLE IF EXISTS herbal.herb_menstruum;
DROP SEQUENCE IF EXISTS herbal.herb_constituents_id_seq;
DROP TABLE IF EXISTS herbal.herb_constituents;
DROP SEQUENCE IF EXISTS herbal.disorders_id_seq;
DROP TABLE IF EXISTS herbal.disorders;
DROP SEQUENCE IF EXISTS herbal.disorder_specific_remedies_id_seq;
DROP TABLE IF EXISTS herbal.disorder_specific_remedies;
DROP SEQUENCE IF EXISTS herbal.disorder_prescriptions_id_seq;
DROP TABLE IF EXISTS herbal.disorder_prescriptions;
DROP SEQUENCE IF EXISTS herbal.disorder_notes_id_seq;
DROP TABLE IF EXISTS herbal.disorder_notes;
DROP SEQUENCE IF EXISTS herbal.disorder_actions_indicated_id_seq;
DROP TABLE IF EXISTS herbal.disorder_actions_indicated;
DROP SEQUENCE IF EXISTS herbal.disorder_action_herbs_id_seq;
DROP TABLE IF EXISTS herbal.disorder_action_herbs;
DROP SEQUENCE IF EXISTS herbal.constituents_id_seq;
DROP TABLE IF EXISTS herbal.constituents;
DROP SEQUENCE IF EXISTS herbal.body_systems_id_seq;
DROP TABLE IF EXISTS herbal.body_systems;
DROP SEQUENCE IF EXISTS herbal.body_system_notes_id_seq;
DROP TABLE IF EXISTS herbal.body_system_notes;
DROP TABLE IF EXISTS herbal.aging_herbs;
DROP SEQUENCE IF EXISTS herbal.action_descriptions_id_seq;
DROP TABLE IF EXISTS herbal.action_descriptions;
DROP FUNCTION IF EXISTS herbal.set_menstruum(p_latin_name text, p_alcohol_min integer, p_alcohol_max integer, p_glycerin_pct integer, p_vinegar_pct integer, p_water_effective boolean, p_primary_label text, p_notes text, p_needs_review boolean);
DROP FUNCTION IF EXISTS herbal.link_constituent(p_latin_name text, p_constituent_name text, p_level herbal.concentration_level, p_sort_order integer, p_notes text, p_needs_review boolean);
DROP FUNCTION IF EXISTS herbal.ensure_herb(p_latin_name text, p_common_name text);
DROP FUNCTION IF EXISTS herbal.ensure_constituent(p_name text, p_category text, p_desc text);
DROP FUNCTION IF EXISTS herbal.ensure_action(p_action_name text);
DROP TYPE IF EXISTS herbal.tone_energetic;
DROP TYPE IF EXISTS herbal.temperature_energetic;
DROP TYPE IF EXISTS herbal.strength_level;
DROP TYPE IF EXISTS herbal.moisture_energetic;
DROP TYPE IF EXISTS herbal.concentration_level;
DROP SCHEMA IF EXISTS herbal;
--
-- Name: herbal; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA herbal;


--
-- Name: SCHEMA herbal; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA herbal IS 'Schema for herbal medicine visualization data';


--
-- Name: concentration_level; Type: TYPE; Schema: herbal; Owner: -
--

CREATE TYPE herbal.concentration_level AS ENUM (
    'trace',
    'minor',
    'moderate',
    'major',
    'primary'
);


--
-- Name: moisture_energetic; Type: TYPE; Schema: herbal; Owner: -
--

CREATE TYPE herbal.moisture_energetic AS ENUM (
    'moistening',
    'drying',
    'neutral'
);


--
-- Name: strength_level; Type: TYPE; Schema: herbal; Owner: -
--

CREATE TYPE herbal.strength_level AS ENUM (
    'mild',
    'strong',
    'very_strong',
    'moderate'
);


--
-- Name: temperature_energetic; Type: TYPE; Schema: herbal; Owner: -
--

CREATE TYPE herbal.temperature_energetic AS ENUM (
    'warming',
    'cooling',
    'neutral'
);


--
-- Name: tone_energetic; Type: TYPE; Schema: herbal; Owner: -
--

CREATE TYPE herbal.tone_energetic AS ENUM (
    'toning',
    'relaxing',
    'neutral'
);


--
-- Name: ensure_action(text); Type: FUNCTION; Schema: herbal; Owner: -
--

CREATE FUNCTION herbal.ensure_action(p_action_name text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  v_action_id INTEGER;
BEGIN
  INSERT INTO herbal.primary_actions (name)
  VALUES (p_action_name)
  ON CONFLICT (name) DO NOTHING
  RETURNING id INTO v_action_id;

  IF v_action_id IS NULL THEN
    SELECT id INTO v_action_id FROM herbal.primary_actions WHERE name = p_action_name;
  END IF;

  RETURN v_action_id;
END;
$$;


--
-- Name: ensure_constituent(text, text, text); Type: FUNCTION; Schema: herbal; Owner: -
--

CREATE FUNCTION herbal.ensure_constituent(p_name text, p_category text, p_desc text DEFAULT NULL::text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INTEGER;
BEGIN
  INSERT INTO herbal.constituents (name, category, description)
  VALUES (p_name, p_category, p_desc)
  ON CONFLICT (name) DO UPDATE SET
    category    = EXCLUDED.category,
    description = COALESCE(EXCLUDED.description, herbal.constituents.description)
  RETURNING id INTO v_id;
  RETURN v_id;
END;
$$;


--
-- Name: ensure_herb(text, text); Type: FUNCTION; Schema: herbal; Owner: -
--

CREATE FUNCTION herbal.ensure_herb(p_latin_name text, p_common_name text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  v_herb_id INTEGER;
BEGIN
  INSERT INTO herbal.herbs (latin_name, common_name)
  VALUES (p_latin_name, initcap(p_common_name))
  ON CONFLICT (latin_name) DO NOTHING
  RETURNING id INTO v_herb_id;

  IF v_herb_id IS NULL THEN
    SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  END IF;

  RETURN v_herb_id;
END;
$$;


--
-- Name: link_constituent(text, text, herbal.concentration_level, integer, text, boolean); Type: FUNCTION; Schema: herbal; Owner: -
--

CREATE FUNCTION herbal.link_constituent(p_latin_name text, p_constituent_name text, p_level herbal.concentration_level DEFAULT 'moderate'::herbal.concentration_level, p_sort_order integer DEFAULT 0, p_notes text DEFAULT NULL::text, p_needs_review boolean DEFAULT false) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  v_herb_id INTEGER;
  v_con_id  INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'link_constituent: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  SELECT id INTO v_con_id FROM herbal.constituents WHERE name = p_constituent_name;
  IF v_con_id IS NULL THEN
    RAISE NOTICE 'link_constituent: constituent not found: %', p_constituent_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_constituents
    (herb_id, constituent_id, concentration_level, sort_order, notes, needs_review)
  VALUES
    (v_herb_id, v_con_id, p_level, p_sort_order, p_notes, p_needs_review)
  ON CONFLICT (herb_id, constituent_id) DO NOTHING;
END;
$$;


--
-- Name: set_menstruum(text, integer, integer, integer, integer, boolean, text, text, boolean); Type: FUNCTION; Schema: herbal; Owner: -
--

CREATE FUNCTION herbal.set_menstruum(p_latin_name text, p_alcohol_min integer DEFAULT NULL::integer, p_alcohol_max integer DEFAULT NULL::integer, p_glycerin_pct integer DEFAULT NULL::integer, p_vinegar_pct integer DEFAULT NULL::integer, p_water_effective boolean DEFAULT false, p_primary_label text DEFAULT NULL::text, p_notes text DEFAULT NULL::text, p_needs_review boolean DEFAULT false) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE v_herb_id INTEGER;
BEGIN
  SELECT id INTO v_herb_id FROM herbal.herbs WHERE latin_name = p_latin_name;
  IF v_herb_id IS NULL THEN
    RAISE NOTICE 'set_menstruum: herb not found: %', p_latin_name;
    RETURN;
  END IF;
  INSERT INTO herbal.herb_menstruum
    (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct,
     water_effective, primary_label, notes, needs_review)
  VALUES
    (v_herb_id, p_alcohol_min, p_alcohol_max, p_glycerin_pct, p_vinegar_pct,
     p_water_effective, COALESCE(p_primary_label, 'review needed'), p_notes, p_needs_review)
  ON CONFLICT (herb_id) DO UPDATE SET
    alcohol_pct_min = EXCLUDED.alcohol_pct_min,
    alcohol_pct_max = EXCLUDED.alcohol_pct_max,
    glycerin_pct    = EXCLUDED.glycerin_pct,
    vinegar_pct     = EXCLUDED.vinegar_pct,
    water_effective = EXCLUDED.water_effective,
    primary_label   = EXCLUDED.primary_label,
    notes           = EXCLUDED.notes,
    needs_review    = EXCLUDED.needs_review;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_descriptions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.action_descriptions (
    id integer NOT NULL,
    primary_action_id integer,
    description text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE action_descriptions; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.action_descriptions IS 'Descriptive bullet points for primary actions';


--
-- Name: COLUMN action_descriptions.sort_order; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.action_descriptions.sort_order IS 'Order in which descriptions should be displayed';


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.action_descriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.action_descriptions_id_seq OWNED BY herbal.action_descriptions.id;


--
-- Name: aging_herbs; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.aging_herbs (
    herb_id integer NOT NULL
);


--
-- Name: TABLE aging_herbs; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.aging_herbs IS 'Herbs recommended for elders/aging. Used by frontend to show 🧓 on Tonic herb cards.';


--
-- Name: body_system_notes; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.body_system_notes (
    id integer NOT NULL,
    body_system_id integer NOT NULL,
    note_text text NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


--
-- Name: TABLE body_system_notes; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.body_system_notes IS 'System-level introductory notes from BHC source files (the # Notes section above any specific disorder).';


--
-- Name: body_system_notes_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.body_system_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: body_system_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.body_system_notes_id_seq OWNED BY herbal.body_system_notes.id;


--
-- Name: body_systems; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.body_systems (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE body_systems; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.body_systems IS 'Body systems affected by herbs';


--
-- Name: body_systems_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.body_systems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: body_systems_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.body_systems_id_seq OWNED BY herbal.body_systems.id;


--
-- Name: constituents; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.constituents (
    id integer NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: constituents_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.constituents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: constituents_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.constituents_id_seq OWNED BY herbal.constituents.id;


--
-- Name: disorder_action_herbs; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.disorder_action_herbs (
    id integer NOT NULL,
    disorder_id integer,
    herb_id integer,
    primary_action_id integer,
    note text,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE disorder_action_herbs; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.disorder_action_herbs IS 'Herbs organized by their therapeutic action for specific disorders';


--
-- Name: disorder_action_herbs_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.disorder_action_herbs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disorder_action_herbs_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.disorder_action_herbs_id_seq OWNED BY herbal.disorder_action_herbs.id;


--
-- Name: disorder_actions_indicated; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.disorder_actions_indicated (
    id integer NOT NULL,
    disorder_id integer,
    primary_action_id integer,
    description text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE disorder_actions_indicated; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.disorder_actions_indicated IS 'Therapeutic rationale for why specific actions are indicated for each disorder';


--
-- Name: disorder_actions_indicated_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.disorder_actions_indicated_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disorder_actions_indicated_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.disorder_actions_indicated_id_seq OWNED BY herbal.disorder_actions_indicated.id;


--
-- Name: disorder_notes; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.disorder_notes (
    id integer NOT NULL,
    disorder_id integer,
    note_text text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE disorder_notes; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.disorder_notes IS 'Clinical notes and context for disorders';


--
-- Name: disorder_notes_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.disorder_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disorder_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.disorder_notes_id_seq OWNED BY herbal.disorder_notes.id;


--
-- Name: disorder_prescriptions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.disorder_prescriptions (
    id integer NOT NULL,
    disorder_id integer,
    title text,
    instructions text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE disorder_prescriptions; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.disorder_prescriptions IS 'Herbal formulas/prescriptions for treating disorders';


--
-- Name: COLUMN disorder_prescriptions.title; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.disorder_prescriptions.title IS 'Optional title like "Internal use", "Mouthwash", "Topical application"';


--
-- Name: disorder_prescriptions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.disorder_prescriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disorder_prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.disorder_prescriptions_id_seq OWNED BY herbal.disorder_prescriptions.id;


--
-- Name: disorder_specific_remedies; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.disorder_specific_remedies (
    id integer NOT NULL,
    disorder_id integer,
    herb_id integer,
    description text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE disorder_specific_remedies; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.disorder_specific_remedies IS 'Particularly effective herbs (specific remedies) for each disorder';


--
-- Name: disorder_specific_remedies_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.disorder_specific_remedies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disorder_specific_remedies_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.disorder_specific_remedies_id_seq OWNED BY herbal.disorder_specific_remedies.id;


--
-- Name: disorders; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.disorders (
    id integer NOT NULL,
    name text NOT NULL,
    body_system_id integer,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE disorders; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.disorders IS 'Clinical disorders/conditions organized by body system';


--
-- Name: COLUMN disorders.sort_order; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.disorders.sort_order IS 'Display order within body system';


--
-- Name: disorders_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.disorders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disorders_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.disorders_id_seq OWNED BY herbal.disorders.id;


--
-- Name: herb_constituents; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.herb_constituents (
    id integer NOT NULL,
    herb_id integer NOT NULL,
    constituent_id integer NOT NULL,
    concentration_level herbal.concentration_level DEFAULT 'moderate'::herbal.concentration_level NOT NULL,
    notes text,
    needs_review boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: herb_constituents_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.herb_constituents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: herb_constituents_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.herb_constituents_id_seq OWNED BY herbal.herb_constituents.id;


--
-- Name: herb_menstruum; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.herb_menstruum (
    herb_id integer NOT NULL,
    alcohol_pct_min integer,
    alcohol_pct_max integer,
    glycerin_pct integer,
    vinegar_pct integer,
    water_effective boolean DEFAULT false NOT NULL,
    primary_label text NOT NULL,
    notes text,
    needs_review boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT herb_menstruum_alcohol_pct_max_check CHECK (((alcohol_pct_max >= 0) AND (alcohol_pct_max <= 100))),
    CONSTRAINT herb_menstruum_alcohol_pct_min_check CHECK (((alcohol_pct_min >= 0) AND (alcohol_pct_min <= 100))),
    CONSTRAINT herb_menstruum_glycerin_pct_check CHECK (((glycerin_pct >= 0) AND (glycerin_pct <= 100))),
    CONSTRAINT herb_menstruum_vinegar_pct_check CHECK (((vinegar_pct >= 0) AND (vinegar_pct <= 100)))
);


--
-- Name: herb_primary_actions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.herb_primary_actions (
    id integer NOT NULL,
    herb_id integer,
    primary_action_id integer,
    body_system_id integer,
    body_system_note text,
    relative_strength herbal.strength_level,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: COLUMN herb_primary_actions.body_system_id; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.herb_primary_actions.body_system_id IS 'Body system affected (NULL if no specific body system affinity)';


--
-- Name: COLUMN herb_primary_actions.relative_strength; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.herb_primary_actions.relative_strength IS 'Strength rating: mild, strong, or very_strong';


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.herb_primary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.herb_primary_actions_id_seq OWNED BY herbal.herb_primary_actions.id;


--
-- Name: herb_secondary_actions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.herb_secondary_actions (
    id integer NOT NULL,
    herb_id integer,
    secondary_action_id integer,
    created_at timestamp with time zone DEFAULT now(),
    body_system_id integer NOT NULL
);


--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.herb_secondary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.herb_secondary_actions_id_seq OWNED BY herbal.herb_secondary_actions.id;


--
-- Name: herbs; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.herbs (
    id integer NOT NULL,
    latin_name text NOT NULL,
    common_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    temperature herbal.temperature_energetic DEFAULT 'neutral'::herbal.temperature_energetic NOT NULL,
    moisture herbal.moisture_energetic DEFAULT 'neutral'::herbal.moisture_energetic NOT NULL,
    tone herbal.tone_energetic DEFAULT 'neutral'::herbal.tone_energetic NOT NULL,
    monograph_url text
);


--
-- Name: TABLE herbs; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.herbs IS 'Medicinal herbs with Latin and common names';


--
-- Name: herbs_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.herbs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: herbs_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.herbs_id_seq OWNED BY herbal.herbs.id;


--
-- Name: prescription_herb_actions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.prescription_herb_actions (
    id integer NOT NULL,
    prescription_herb_id integer,
    primary_action_id integer,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE prescription_herb_actions; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.prescription_herb_actions IS 'Links herbs in formulas to their therapeutic actions/roles';


--
-- Name: prescription_herb_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.prescription_herb_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prescription_herb_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.prescription_herb_actions_id_seq OWNED BY herbal.prescription_herb_actions.id;


--
-- Name: prescription_herbs; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.prescription_herbs (
    id integer NOT NULL,
    prescription_id integer,
    herb_id integer,
    parts text NOT NULL,
    note text,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE prescription_herbs; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.prescription_herbs IS 'Individual herbs in prescriptions with their proportions';


--
-- Name: COLUMN prescription_herbs.parts; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.prescription_herbs.parts IS 'Proportion like "1 part", "2 parts", "35 ml"';


--
-- Name: COLUMN prescription_herbs.note; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON COLUMN herbal.prescription_herbs.note IS 'Specific plant part or other notes like "root", "leaf"';


--
-- Name: prescription_herbs_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.prescription_herbs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prescription_herbs_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.prescription_herbs_id_seq OWNED BY herbal.prescription_herbs.id;


--
-- Name: primary_actions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.primary_actions (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: TABLE primary_actions; Type: COMMENT; Schema: herbal; Owner: -
--

COMMENT ON TABLE herbal.primary_actions IS 'Primary herbal action categories (Alteratives, Adaptogens, etc.)';


--
-- Name: primary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.primary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: primary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.primary_actions_id_seq OWNED BY herbal.primary_actions.id;


--
-- Name: secondary_actions; Type: TABLE; Schema: herbal; Owner: -
--

CREATE TABLE herbal.secondary_actions (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: secondary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: -
--

CREATE SEQUENCE herbal.secondary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: secondary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: -
--

ALTER SEQUENCE herbal.secondary_actions_id_seq OWNED BY herbal.secondary_actions.id;


--
-- Name: action_descriptions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.action_descriptions ALTER COLUMN id SET DEFAULT nextval('herbal.action_descriptions_id_seq'::regclass);


--
-- Name: body_system_notes id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_system_notes ALTER COLUMN id SET DEFAULT nextval('herbal.body_system_notes_id_seq'::regclass);


--
-- Name: body_systems id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_systems ALTER COLUMN id SET DEFAULT nextval('herbal.body_systems_id_seq'::regclass);


--
-- Name: constituents id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.constituents ALTER COLUMN id SET DEFAULT nextval('herbal.constituents_id_seq'::regclass);


--
-- Name: disorder_action_herbs id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_action_herbs ALTER COLUMN id SET DEFAULT nextval('herbal.disorder_action_herbs_id_seq'::regclass);


--
-- Name: disorder_actions_indicated id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_actions_indicated ALTER COLUMN id SET DEFAULT nextval('herbal.disorder_actions_indicated_id_seq'::regclass);


--
-- Name: disorder_notes id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_notes ALTER COLUMN id SET DEFAULT nextval('herbal.disorder_notes_id_seq'::regclass);


--
-- Name: disorder_prescriptions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_prescriptions ALTER COLUMN id SET DEFAULT nextval('herbal.disorder_prescriptions_id_seq'::regclass);


--
-- Name: disorder_specific_remedies id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_specific_remedies ALTER COLUMN id SET DEFAULT nextval('herbal.disorder_specific_remedies_id_seq'::regclass);


--
-- Name: disorders id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorders ALTER COLUMN id SET DEFAULT nextval('herbal.disorders_id_seq'::regclass);


--
-- Name: herb_constituents id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_constituents ALTER COLUMN id SET DEFAULT nextval('herbal.herb_constituents_id_seq'::regclass);


--
-- Name: herb_primary_actions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_primary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.herb_primary_actions_id_seq'::regclass);


--
-- Name: herb_secondary_actions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.herb_secondary_actions_id_seq'::regclass);


--
-- Name: herbs id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herbs ALTER COLUMN id SET DEFAULT nextval('herbal.herbs_id_seq'::regclass);


--
-- Name: prescription_herb_actions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herb_actions ALTER COLUMN id SET DEFAULT nextval('herbal.prescription_herb_actions_id_seq'::regclass);


--
-- Name: prescription_herbs id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herbs ALTER COLUMN id SET DEFAULT nextval('herbal.prescription_herbs_id_seq'::regclass);


--
-- Name: primary_actions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.primary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.primary_actions_id_seq'::regclass);


--
-- Name: secondary_actions id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.secondary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.secondary_actions_id_seq'::regclass);


--
-- Data for Name: action_descriptions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.action_descriptions (id, primary_action_id, description, sort_order, created_at) FROM stdin;
226	5	a sage-y smell usually indicates this action	3	2026-03-22 21:31:43.736795+00
199	1	Helps the body adapt to stress	1	2026-03-22 21:31:43.736795+00
200	1	virtually non-toxic at high doses	2	2026-03-22 21:31:43.736795+00
201	1	non-specific action throughout the body	3	2026-03-22 21:31:43.736795+00
202	1	H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response	4	2026-03-22 21:31:43.736795+00
203	1	adaptogens help regulate this hormonal cascade	5	2026-03-22 21:31:43.736795+00
204	1	non-specific state of resistance to stress: environmental, psych or physio	6	2026-03-22 21:31:43.736795+00
205	1	helping the body adapt to and defend against the effects of environmental stress.	7	2026-03-22 21:31:43.736795+00
206	1	The general aims of treatment with this action are to reduce stress reactions during the alarm phase of the stress response and to prevent or at least delay the state of exhaustion,	8	2026-03-22 21:31:43.736795+00
207	1	smooth out the associated highs and lows. This conserves energy in the alarm phase for use in the resistance phase.	9	2026-03-22 21:31:43.736795+00
208	2	alter the body from unhealthy to healthy via the body channels of elimination	1	2026-03-22 21:31:43.736795+00
209	2	bowel, kidney, skin, liver	2	2026-03-22 21:31:43.736795+00
210	2	aid in detoxification	3	2026-03-22 21:31:43.736795+00
211	2	used to be called "blood cleanser"	4	2026-03-22 21:31:43.736795+00
212	2	gradually restore proper function to the body and increase overall health and vitality.	5	2026-03-22 21:31:43.736795+00
213	2	seem to alter the body's metabolic processes to improve tissues' ability to deal with a range of body functions, from nutrition to elimination.	6	2026-03-22 21:31:43.736795+00
214	2	should be considered first for cases of chronic inflammatory and degenerative diseases	7	2026-03-22 21:31:43.736795+00
215	2	Skin is the body system for which these are often used	8	2026-03-22 21:31:43.736795+00
216	4	reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions	1	2026-03-22 21:31:43.736795+00
217	4	promote healthy inflammation, regulate it to turn on and turn off	2	2026-03-22 21:31:43.736795+00
218	4	work well with musculoskeletal discomfort	3	2026-03-22 21:31:43.736795+00
219	4	help the body combat inflammation	4	2026-03-22 21:31:43.736795+00
220	3	thin the mucus secretions and reduce congestion	1	2026-03-22 21:31:43.736795+00
221	3	can be used for lungs, although aren't as effective in loosening deep-seated mucus as the more stimulating expectorant	2	2026-03-22 21:31:43.736795+00
222	3	help the body remove excess mucus, whether in the sinuses or in other parts of the body. They are used mainly for ear, nose, and throat infections,	3	2026-03-22 21:31:43.736795+00
223	3	Some of this action remedies work by producing a less viscous mucus secretion that is easier for the body to remove. Others reduce mucus secretion directly.	4	2026-03-22 21:31:43.736795+00
224	5	disinfectants, used both internally and externally to prevent or cure infections	1	2026-03-22 21:31:43.736795+00
225	5	a lot of cooking herbs - sage, oregano	2	2026-03-22 21:31:43.736795+00
227	5	usually can be used both topically and internally	4	2026-03-22 21:31:43.736795+00
228	5	help the body destroy or resist pathogenic microorganisms in some way	5	2026-03-22 21:31:43.736795+00
229	5	we are talking about plants that support the immune process, augmenting the integrity of the individual's own defense system	6	2026-03-22 21:31:43.736795+00
230	7	special kind of muscle relaxants	1	2026-03-22 21:31:43.736795+00
231	7	help ease spasms and cramps and also very helpful in gently relaxing body extremities	2	2026-03-22 21:31:43.736795+00
232	7	useful for variety of conditions: anxiety, nervousness, to hypertension, cold hands and feet	3	2026-03-22 21:31:43.736795+00
233	7	prevent or ease spasms or cramps in the muscles. They thus reduce muscular tension in the body,	4	2026-03-22 21:31:43.736795+00
234	7	facilitate physical relaxation of muscles without necessarily causing a sedative effect.	5	2026-03-22 21:31:43.736795+00
235	7	the action that affects the peripheral nerves and the muscle tissue - may have an indirect relaxing action on the whole system.	6	2026-03-22 21:31:43.736795+00
236	8	tone and tighten tissues	1	2026-03-22 21:31:43.736795+00
237	8	tannin rich herbs	2	2026-03-22 21:31:43.736795+00
238	8	pulling or drawing effect	3	2026-03-22 21:31:43.736795+00
239	8	drying	4	2026-03-22 21:31:43.736795+00
240	8	most barks have this property	5	2026-03-22 21:31:43.736795+00
241	8	tightening of the tissue	6	2026-03-22 21:31:43.736795+00
242	8	sometimes called styptics when applied externally to stop bleeding, or anti-hemorrhagics when used for internal bleeding.	7	2026-03-22 21:31:43.736795+00
243	8	produce a kind of temporary leather coat on the surface of tissue.	8	2026-03-22 21:31:43.736795+00
244	8	Reduce irritation on the surface of tissues through a sort of numbing action	9	2026-03-22 21:31:43.736795+00
245	8	Reduce surface inflammation	10	2026-03-22 21:31:43.736795+00
246	8	Create a barrier against infection, great help with wounds and burns	11	2026-03-22 21:31:43.736795+00
247	8	of great importance in round healing and conditions affecting the digestive system.	12	2026-03-22 21:31:43.736795+00
248	9	Stimulate appetite.	1	2026-03-22 21:31:43.736795+00
249	9	Stimulate release of digestive juices from the pancreas, duodenum, and and liver	2	2026-03-22 21:31:43.736795+00
250	9	Aid the liver in detoxification work and increase the flow of bile	3	2026-03-22 21:31:43.736795+00
251	9	Help regulate secretion of pancreatic hormones that regulate blood sugar, insulin, and glucagon	4	2026-03-22 21:31:43.736795+00
252	9	Help the gut wall repair damage by stimulating self-repair mechanisms.	5	2026-03-22 21:31:43.736795+00
253	10	special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart	1	2026-03-22 21:31:43.736795+00
254	10	general category for herbal remedies that have some kind of action on the heart.	2	2026-03-22 21:31:43.736795+00
255	11	clear "wind" and gas/bloating in the body	1	2026-03-22 21:31:43.736795+00
256	11	move energy in the body downward if scattered thoughts as well!	2	2026-03-22 21:31:43.736795+00
257	11	rich in volatile oils	3	2026-03-22 21:31:43.736795+00
258	11	ease discomfort caused by flatulence.	4	2026-03-22 21:31:43.736795+00
259	12	greek meaning bile, and as such has a cleaning and stimulating effect on the liver and gallbladder, allowing from the release of more bile	1	2026-03-22 21:31:43.736795+00
260	12	helpful in aiding digestion, esp in the lower intestinal tract	2	2026-03-22 21:31:43.736795+00
261	12	have the specific effect of stimulating the flow of bile from the liver.	3	2026-03-22 21:31:43.736795+00
262	12	quite specific in that they act on the liver.	4	2026-03-22 21:31:43.736795+00
263	12	indicated for disorders caused by insufficient or congested bile, such as intractable biliary constipation, jaundice, and mild hepatitis.	5	2026-03-22 21:31:43.736795+00
264	12	contraindicated for painful gallstones, Increased contractile activity could further constrict the bile duct, leading to incredibly intense	6	2026-03-22 21:31:43.736795+00
265	12	Because they help with assimilation, these have an enlivening "side effect" in the nervous system. These remedies may actively ease debility and	7	2026-03-22 21:31:43.736795+00
266	13	soothing herbs rich in mucilage	1	2026-03-22 21:31:43.736795+00
267	13	helps to heal mucosal barrier	2	2026-03-22 21:31:43.736795+00
268	13	indication for gastric irritation, ulcers	3	2026-03-22 21:31:43.736795+00
269	13	if someone is already damp, contraindication for this	4	2026-03-22 21:31:43.736795+00
270	13	herbs with this action often have an apparently anti-inflammatory effect, but this is related to their ability to soothe inflamed surfaces, not to reductions in the cellular inflammatory response.	5	2026-03-22 21:31:43.736795+00
271	13	rich in mucilage and can soothe and protect irritated or inflamed internal tissue. When used topically on the skin, these are called emollients.	6	2026-03-22 21:31:43.736795+00
272	13	become slimy and gummy when they come in contact with water:	7	2026-03-22 21:31:43.736795+00
273	13	Reduce irritation down the whole length of the bowel.	8	2026-03-22 21:31:43.736795+00
274	13	Lessen the sensitivity of the digestive system to gastric acids and to digestive bitters	9	2026-03-22 21:31:43.736795+00
275	14	gently promote elimination of water through the kidneys, as urine	1	2026-03-22 21:31:43.736795+00
276	14	help the body rid itself of exces fluids by increasing the kidneys' rate of urine production.	2	2026-03-22 21:31:43.736795+00
277	14	Causes more blood to pass through the kidneys, which produces more urine	3	2026-03-22 21:31:43.736795+00
278	14	Because of their cleansing actions, many of these help with problems of muscles and bones	4	2026-03-22 21:31:43.736795+00
279	15	promote menstruation usually by slightly irritating the uterine lining	1	2026-03-22 21:31:43.736795+00
280	15	severely contraindicated during pregnancy	2	2026-03-22 21:31:43.736795+00
281	15	remedies that stimulate menstrual flow and activity	3	2026-03-22 21:31:43.736795+00
282	19	herbal remedies that aid the work of the liver in a range of ways.	1	2026-03-22 21:31:43.736795+00
283	19	Bitters and cholagogues all act as this action, but so do a whole array of other remedies that do not have those specific actions.	2	2026-03-22 21:31:43.736795+00
284	20	trance-inducing, a little more than simple sedatives	1	2026-03-22 21:31:43.736795+00
285	20	can be very relaxing , useful in sleep conditions, headaches, tension, and for addiction recovery	2	2026-03-22 21:31:43.736795+00
286	20	don't used with sedative medication already	3	2026-03-22 21:31:43.736795+00
287	20	most are also hypotensives - lower blood pressure	4	2026-03-22 21:31:43.736795+00
288	20	nervine remedies that help induce a deep and healing state of sleep.	5	2026-03-22 21:31:43.736795+00
289	20	should always be used within the context of a holistic approach to sleep problems	6	2026-03-22 21:31:43.736795+00
290	21	lower blood pressure by acting either on the heart, arteries, capillaries, or the water balance in the body	1	2026-03-22 21:31:43.736795+00
291	21	use semi-preventatively, when the blood pressure starts to creep up, not in acute conditions	2	2026-03-22 21:31:43.736795+00
292	21	reduce elevated blood pressure, tending to normalize both systolic and diastolic pressure.	3	2026-03-22 21:31:43.736795+00
293	23	most important in times of stress and confusion, as they can alleviate many of the accompanying symptoms.	1	2026-03-22 21:31:43.736795+00
294	23	the best remedies for the "inflamed state of mind"	2	2026-03-22 21:31:43.736795+00
295	24	an action that quickens and enlivens the physiological activity of the body.	1	2026-03-22 21:31:43.736795+00
296	17	seem also to act by reflex, but here the reflex action works to soothe bronchial spasm and loosen mucus secretions.	1	2026-03-22 21:31:43.736795+00
297	17	help to produce a thinner mucus that is easier to expel, allowing the more viscous mucus to move and thus be eliminated.	2	2026-03-22 21:31:43.736795+00
298	17	useful for dry, irritating coughs.	3	2026-03-22 21:31:43.736795+00
299	17	This action is similar in some respects to that of demulcents, and both actions owe much to their content of mucilage and, occasionally, volatile oils.	4	2026-03-22 21:31:43.736795+00
300	16	Irritate the bronchioles to stimulate expulsion of any material present	1	2026-03-22 21:31:43.736795+00
301	16	Liquefy viscid sputum so that it can be cleared by coughing.	2	2026-03-22 21:31:43.736795+00
\.


--
-- Data for Name: aging_herbs; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.aging_herbs (herb_id) FROM stdin;
44
62
21
73
165
131
122
1159
1160
93
67
49
53
54
160
140
59
61
199
132
38
178
81
142
25
82
84
134
128
137
145
115
146
148
45
75
76
102
55
37
206
89
92
46
179
28
57
1212
72
188
186
94
190
66
65
68
74
34
87
43
29
80
123
70
85
88
42
1240
\.


--
-- Data for Name: body_system_notes; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.body_system_notes (id, body_system_id, note_text, sort_order) FROM stdin;
1	26	Theories have been proposed that suggest that aging is related to problems with stability of DNA over time, and with the transcription of information from the chromosomal DNA to RNA. In fact, there is a different theory for each phase of the process. For those who are interested, the most relevant ideas are known as the error theory, the redundant message theory, the transcription theory, and the programmed theory.	10
2	26	Free radicals are a normal but short-lived aspect of metabolism. The core problem is peroxidation of fats, which damages membranes in the body.	20
3	26	The question is whether free radical production is the fundamental cause of aging or simply an ancillary phenomenon that exacerbates age-related changes due to some other cause.	30
4	26	Age is not a disease. Death is not an evil to be avoided at all costs. Our culture has developed some distorted perceptions about old age, seeing it as the undesirable mirror image of youth. This blinkered perception ignores the incredible value of wisdom and experience. It denies our elders a voice and disregards the valuable contributions they have to offer.	40
5	26	Issues such as isolation and poverty that manifest in cardiovascular disease will not be helped by hawthorn.	50
6	26	Perhaps the most outstanding contribution that herbs can make to the health of elders is through system tonics, for the maintenance of wellness and the prevention of many problems associated with aging.	60
7	26	With very elderly people, it is not unusual for a medicine to have an effect that is opposite of what is expected.	70
8	26	Elders have special needs, and plants can address these needs. Whenever possible, the focus should be on tonics and normalizers.	80
9	26	A general rule of thumb is to use a lower dosage for elders than for younger adults. Such concerns do not arise if prescriptions emphasize tonics.	90
10	9	Plants containing cardiac glycosides are used throughout the world to treat heart failure and certain cases of cardiac arrhythmia.	10
11	9	The real value of these herbs lies in their ability to increase the efficiency of the heart without increasing the heart muscle's need for oxygen.	20
12	9	Half of the annual mortality in America results from heart and blood vessel diseases.	30
13	9	Herbal tonics can contribute by offering real possibilities for the practice of preventive medicine.	40
14	9	An increasing amount of research is investigating the cardiovascular effects of plant constituents. As fascinating as this is, the benefits of such research accrue to the pharmaceutical industry, as the information is rarely about the plant from which the constituent has been extracted. It would prove almost impossible to develop herbal approaches to treatment if natural product research was the sole source of information.	50
15	9	Cardioactive herbs owe their effects on the heart to highly active substances, such as cardiac glycosides, and thus have both the strengths and the drawbacks of these powerful constituents. Cardiotonics have a beneficial action on the heart and blood vessels, but do not contain cardiac glycosides.	60
16	9	Blood vessel or vascular tonics are often rich in constituents called flavonoids. These remarkable herbs include Crataegus spp., Allium sativum, Tilia platyphyllos, and Ginkgo biloba.	70
17	9	In addition to the heart tonics, a number of other herbal actions can be helpful. Especially important are the relaxing herbs, such as Leonurus cardiaca (motherwort), Scutellaria lateriflora (skullcap), and Valeriana officinalis (valerian). Circulatory stimulants, such as Capsicum annuum (cayenne), Zingiber officinale (ginger), and Zanthoxylum americanum (prickly ash), increase blood flow, supporting oxygenation of tissue and the elimination of waste. This makes them important in circulatory problems.	80
18	9	The major risk factors for cardiovascular disease that can be altered are cigarette smoking, high blood pressure, high cholesterol, obesity, and physical inactivity.	90
19	9	The more risk factors a person has, the more likely he or she is to develop cardiovascular disease.	100
20	9	The development of heart disease is definitely linked with excess dietary fat, elevated blood cholesterol levels, high blood pressure, smoking, obesity, short stature, and physical inactivity.	110
21	9	High blood cholesterol is another very important risk factor for coronary heart disease that may be amenable to change. Some cholesterol is obtained from the diet (about 2%) and the rest is manufactured by the liver.	120
22	9	The basic dietary rules for lowering cholesterol and maintaining heart health are simple: Avoid saturated fats and dietary cholesterol. Experts recommend a diet that derives not more than 30% of daily calories from fat, some say 20%.	130
23	9	The severity of heart disease correlates with the severity of CoQ10 deficiency.	140
24	9	High blood levels of homocysteine may increase the chances of developing heart disease, stroke, and circulation problems. Elevated levels are believed to damage arteries, predispose the blood to easy clotting, and reduce the flexibility of blood vessels.	150
25	15	The complexities of the mind-body interface, so challenging to doctors concerned with psychosomatic medicine, become an aid to remedy selection for the herbalist.	10
26	15	All of the many herbal nervines have an impact on both somatic symptoms and the mind.	20
27	15	Therefore, if there is disease on the psychological level, it will be reflected on the physiological level, and vice versa.	30
28	15	THE NERVOUS SYSTEM AND HERBAL REMEDIES: Herbs can benefit the nervous system in a number of ways, in addition to the rather simplistic effects of stimulation and relaxation.	40
29	15	Today, Western herbalism commonly recognizes three major categories of herbs that act on the nervous system, collectively called nervines. These are nervine tonics, nervine relaxants, and nervine stimulants. Other important categories of nervines include hypnotics, analgesics, antispasmodics, antidepressants, and adaptogens.	50
30	15	ANXIETY AS A RESPONSE TO STRESS: For some people, anxiety takes the form of recurrent attacks, which begin with a sudden, intense apprehension, often combined with a feeling of impending doom and sometimes with feelings of unreality. An anticipatory fear of loss of control often develops, so that the person may become afraid, for example, of being left alone in public places.	60
31	15	When people are seen as whole beings, not simply as "bodies with minds on top," it should come as no surprise to find a deep association between psychology and physiology.	70
32	15	In reality, a human is a single whole being that cannot be separated into parts like mind and body.	80
33	15	Relaxation is a skill that must be relearned and practiced.	90
74	18	Smoking has a direct effect on the growth of the fetus.	190
34	15	Physiological findings indicated that nature settings produced significant recovery from stress in only four to six minutes.	100
35	15	THE ROLE OF ADAPTOGENS: Even if we have found a remedy that seems to offer an increased resistance to toxic drugs, it is always preferable to remove the toxic chemical.	110
36	15	Adaptogens reinforce the nonspecific power of the body's resistance against stressors, increase its general capacity to withstand stressful situations, and hence guard against disease caused by overstressing the organism.	120
37	15	If periods of stress in a person's life can be predicted, nervine relaxants can be used regularly as gentle, soothing remedies.	130
38	18	The lungs sit within the thoracic cage, where they stretch from the trachea (commonly called the windpipe) to below the heart.	10
39	19	The lungs sit within the thoracic cage, where they stretch from the trachea (commonly called the windpipe) to below the heart.	10
40	18	About 10% of the lung is solid tissue and the rest is filled with air and blood.	20
41	19	About 10% of the lung is solid tissue and the rest is filled with air and blood.	20
42	18	The lungs' main function is to rapidly exchange oxygen from inhaled air with carbon dioxide from the blood	30
43	19	The lungs' main function is to rapidly exchange oxygen from inhaled air with carbon dioxide from the blood	30
44	18	The two main bronchi extend from the trachea into each lung, where they divide into smaller bronchi, and then a great number of smaller bronchioles. The bronchioles divide into a network of about 3 million alveolar ducts containing alveoli, commonly called air sacs.	40
45	19	The two main bronchi extend from the trachea into each lung, where they divide into smaller bronchi, and then a great number of smaller bronchioles. The bronchioles divide into a network of about 3 million alveolar ducts containing alveoli, commonly called air sacs.	40
46	18	Specific nerve sites located in the brain and the neck, called respi vatory centers, coordinate the performance of the ventila-tory apparatus. The respiratory centers respond to changes in oxygen, carbon dioxide, and acid levels in the blood.	50
47	19	Specific nerve sites located in the brain and the neck, called respi vatory centers, coordinate the performance of the ventila-tory apparatus. The respiratory centers respond to changes in oxygen, carbon dioxide, and acid levels in the blood.	50
48	18	Gas exchange between inhaled air and blood takes place in the alveoli. A very thin membrane separates the blood from the air in the alveoli and allows oxygen and nitrogen to diffuse into the blood. This barrier is 50 times thinner than a sheet of tissue paper, but a large surface area (80 square meters, or about as large as a tennis court) is available for gas exchange. In the resting state, it takes just about a minute for the total blood volume of the body to pass through the lungs. It takes a red cell a fraction of a second to pass through the capillary network. Gas exchange occurs almost instantaneously during this short time period	60
49	19	Gas exchange between inhaled air and blood takes place in the alveoli. A very thin membrane separates the blood from the air in the alveoli and allows oxygen and nitrogen to diffuse into the blood. This barrier is 50 times thinner than a sheet of tissue paper, but a large surface area (80 square meters, or about as large as a tennis court) is available for gas exchange. In the resting state, it takes just about a minute for the total blood volume of the body to pass through the lungs. It takes a red cell a fraction of a second to pass through the capillary network. Gas exchange occurs almost instantaneously during this short time period	60
50	18	We are not only what we eat, but also what we breathe.	70
51	19	We are not only what we eat, but also what we breathe.	70
52	18	Many pathological tissue changes can be prevented if the environmental milieu of the cells is constantly rich in oxygen.	80
53	19	Many pathological tissue changes can be prevented if the environmental milieu of the cells is constantly rich in oxygen.	80
54	18	Air pollution in the country may be caused by dust from tractors plowing fields, trucks and cars driving on dirt or gravel roads, and rock quarries, as well as by smoke from wood and crop fires.	90
55	19	Air pollution in the country may be caused by dust from tractors plowing fields, trucks and cars driving on dirt or gravel roads, and rock quarries, as well as by smoke from wood and crop fires.	90
56	18	Ground-level ozone is created when engine and fuel gases that have already been released into the air interact in the presence of sunlight.	100
57	19	Ground-level ozone is created when engine and fuel gases that have already been released into the air interact in the presence of sunlight.	100
58	18	Ozone irritates the respiratory tract and eyes, and exposure to high levels results in chest tightness, coughing, and wheezing.	110
59	19	Ozone irritates the respiratory tract and eyes, and exposure to high levels results in chest tightness, coughing, and wheezing.	110
60	18	For every eight smokers, one nonsmoker dies from the effects of secondhand smoke.	120
61	19	For every eight smokers, one nonsmoker dies from the effects of secondhand smoke.	120
62	18	Smoking is responsible for 32% of deaths due to cancer.	130
63	19	Smoking is responsible for 32% of deaths due to cancer.	130
64	18	Smoking causes nearly 90% of all lung and throat cancers.	140
65	19	Smoking causes nearly 90% of all lung and throat cancers.	140
66	18	Alcohol is also a risk factor for some cancers, and the combination of alcohol and smoking greatly increases cancer risk.	150
67	19	Alcohol is also a risk factor for some cancers, and the combination of alcohol and smoking greatly increases cancer risk.	150
68	18	Smoking decreases the strength of the sphincter muscle between the throat and stomach, which allows stomach contents to reflux, or flow backward, into the esophagus.	160
69	19	Smoking decreases the strength of the sphincter muscle between the throat and stomach, which allows stomach contents to reflux, or flow backward, into the esophagus.	160
70	18	Smoking seems to affect the liver, too, by changing the way it handles drugs and alcohol.	170
71	19	Smoking seems to affect the liver, too, by changing the way it handles drugs and alcohol.	170
72	18	Peptic ulcer disease is more likely to occur in smokers than in nonsmokers, and ulcers heal less readily and are more likely to recur in smokers.	180
73	19	Peptic ulcer disease is more likely to occur in smokers than in nonsmokers, and ulcers heal less readily and are more likely to recur in smokers.	180
75	19	Smoking has a direct effect on the growth of the fetus.	190
76	18	Natural menopause occurs earlier in smokers than in nonsmokers by one to two years.	200
77	19	Natural menopause occurs earlier in smokers than in nonsmokers by one to two years.	200
78	18	Cigarettes and oral contraceptives are a dangerous combination that increases the risk of heart attacks, strokes, and other vascular complications.	210
79	19	Cigarettes and oral contraceptives are a dangerous combination that increases the risk of heart attacks, strokes, and other vascular complications.	210
80	18	A decrease of blood flow in the small vessels of the skin that may damage skin components, leading to skin wrinkling and an appearance of premature aging.	220
81	19	A decrease of blood flow in the small vessels of the skin that may damage skin components, leading to skin wrinkling and an appearance of premature aging.	220
82	18	The respiratory zone, the actual site of gas exchange, is composed of the respiratory bronchioles, alveolar ducts, and alveoli. The conducting zone, sometimes called the dead air space, includes all other respiratory passageways, which serve as fairly rigid conduits to allow air to reach the gas exchange sites. The conducting zone organs also purify, humidify, and warm the incoming air.	230
83	19	The respiratory zone, the actual site of gas exchange, is composed of the respiratory bronchioles, alveolar ducts, and alveoli. The conducting zone, sometimes called the dead air space, includes all other respiratory passageways, which serve as fairly rigid conduits to allow air to reach the gas exchange sites. The conducting zone organs also purify, humidify, and warm the incoming air.	230
84	18	The lower respiratory system consists of the respiratory zone, the alveoli, and respiratory bronchioles. The air-conducting bronchi and trachea are anatomically part of this system. The upper respiratory system consists of the conducting zone, made up of the nose, sinuses, pharynx, and larynx.	240
85	19	The lower respiratory system consists of the respiratory zone, the alveoli, and respiratory bronchioles. The air-conducting bronchi and trachea are anatomically part of this system. The upper respiratory system consists of the conducting zone, made up of the nose, sinuses, pharynx, and larynx.	240
86	18	Expectorants are herbs that facilitate or accelerate the removal of bronchial secretions from the bronchi and trachea.	250
87	19	Expectorants are herbs that facilitate or accelerate the removal of bronchial secretions from the bronchi and trachea.	250
88	18	Stimulating Expectorants: For any given stimulating expectorant, either or both of the following mechanisms may be at play. Irritation of the bronchioles stimulates the expulsion of any material present. Liquefaction of viscid sputum encourages clearing by coughing.	260
89	19	Stimulating Expectorants: For any given stimulating expectorant, either or both of the following mechanisms may be at play. Irritation of the bronchioles stimulates the expulsion of any material present. Liquefaction of viscid sputum encourages clearing by coughing.	260
90	18	The particular form of stimulation offered by this group of expectorants makes them relevant for productive coughs, in which sputum should be removed from the airways.	270
91	19	The particular form of stimulation offered by this group of expectorants makes them relevant for productive coughs, in which sputum should be removed from the airways.	270
92	18	Relaxing expectorants may also act by reflex, but here the herbs work to soothe bronchial spasm and loosen mucous secretions.	280
93	19	Relaxing expectorants may also act by reflex, but here the herbs work to soothe bronchial spasm and loosen mucous secretions.	280
94	18	They facilitate the production of a less viscous mucous secretion, which helps lift up stickier material from below. This makes relaxing expectorants useful for dry, irritating coughs. You will notice that this action is similar in some respects to that of demulcents, and both actions owe a lot to their content of mucilage and occasionally volatile oils.	290
95	19	They facilitate the production of a less viscous mucous secretion, which helps lift up stickier material from below. This makes relaxing expectorants useful for dry, irritating coughs. You will notice that this action is similar in some respects to that of demulcents, and both actions owe a lot to their content of mucilage and occasionally volatile oils.	290
96	18	Herbs known as pulmonaries, or amphoteric expectorants, have a beneficial effect upon both lung tissue and function.	300
97	19	Herbs known as pulmonaries, or amphoteric expectorants, have a beneficial effect upon both lung tissue and function.	300
98	18	We can generalize here that Inula has stimulant expectorant effects and Verbascum is more of a relaxing expectorant. Tussilago is the best of the three for children.	310
99	19	We can generalize here that Inula has stimulant expectorant effects and Verbascum is more of a relaxing expectorant. Tussilago is the best of the three for children.	310
100	18	To avoid any potential toxicity problems, leaf and flower formulations of Tussilago should not be taken for more than one consecutive month, and root products should not be used internally.	320
101	19	To avoid any potential toxicity problems, leaf and flower formulations of Tussilago should not be taken for more than one consecutive month, and root products should not be used internally.	320
102	18	Dyspnea, defined as an unpleasant sensation of difficulty in breathing.	330
103	19	Dyspnea, defined as an unpleasant sensation of difficulty in breathing.	330
104	24	Remember that all bitters will have an emmenagogue effect in the strict sense of the word - that is, they will help improve menstrual function and flow.	10
105	24	Uterine Tonics - These plants have a toning, strengthening, nourishing effect on both the tissue and the function of the female reproductive system.	20
106	24	Of the emmenagogues listed previously, some work through bitter stimulation and others through localized irritation. Herbs that also nourish the system to some degree include Achillea millefolium (yarrow), Artemisia vulgaris (mugwort), and Mitchella repens (partridgeberry).	30
107	24	Hormonal Normalizers - A number of plants have a direct impact upon levels of hormones in the body. The herbalist tends to refer to them in terms of hormonal modulators or normalizers.	40
108	24	Uterine Astringents - An abundance of herbs reduce blood loss from the uterus, whether due to excessively heavy periods (menorrhagia), bleeding between periods (metrorrhagia), or organic disease, such as fibroids.	50
109	24	Uterine Demulcents - There is no way that mucopolysaccharides find their way to the uterus from the digestive process; nonetheless, there is no question that these remedies soothe inflamed tissue.	60
110	24	Nervines and Antispasmodics - By using the appropriate nervine or antispasmodic, much can be achieved in terms of correcting functional tone.	70
128	12	The maintenance of homeostasis is pivotal to any experience of wellness. With the variety of diuretics in our materia medica, the phytotherapist is uniquely endowed by nature with the means to support the complex physiology that maintains healthy kidneys and water balance in the body.	10
129	12	Because of their excretory function, the kidneys are also largely responsible for maintaining the water balance of the body and the pH of the blood.	20
130	12	The kidneys release the protein erythropoietin, which stimulates the bone marrow to increase the formation of red blood cells.	30
131	12	They also help to control blood pressure.	40
132	12	The production of urine is a complex and quite wonderful process. It is far from a simple removal of water from the body. Rather, it is a process of selective filtration that moves waste and potential toxins from the blood while retaining essential molecules.	50
133	12	Arterial blood pressure drives a filtrate of plasma across the porous capillary walls.	60
134	12	The filtered plasma, now called glomerular filtrate, is mainly water, but also contains salts, glucose, amino acids, nitrogenous wastes such as urea, and a small amount of ammonia.	70
135	12	In normal kidneys, 100 to 140 ml of filtrate is formed each minute, a total of about 170 liters per day. Only about 1% of the volume of the original filtrate is finally excreted as urine. The kidneys excrete 400 to 2,000 ml of urine or more per day.	80
136	12	This reabsorption process is highly selective. Water, sodium, and chloride ions, most of the bicarbonate, and all of the glucose are reabsorbed into the blood-stream, while other products, such as urea and ammonia, remain in the tubule.	90
137	12	The cells lining the tubules are under the influence of regulating factors, such as the hormone aldosterone (from the adrenal gland), antidiuretic hormone, parathyroid hormone, and atrial natriuretic factor (from the heart).	100
138	12	The distal tubule regulates the overall acidity of the urine, and ultimately of the blood, by excretion of hydrogen ions.	110
139	12	Much of the sodium ion in kidney filtrate is transported back to the blood, but 3 to 5 grams pass into the urine each day. As a result, most animals have strict salt requirements and must consume several grams of sodium chloride daily in order to live.	120
140	12	The retention of sodium is enhanced by the presence of aldosterone. This hormone is secreted into the bloodstream when the body's supply of sodium falls below normal. When there is an excess of sodium, aldosterone secretion is reduced and more sodium is excreted.	130
141	12	When excessive amounts of fluid are lost from the body, or the blood pressure falls below normal, the kidneys release the enzyme renin into the blood, where it promotes the formation of angiotensin. Within minutes, angiotensin causes vasoconstriction, which increases blood pressure and stimulates the secretion of aldosterone.	140
142	12	In the urinary system, the emphasis is on nourishing the tissue and helping to support the normal functioning of the various organs and tissues involved. Thus, stronger diuretics are not emphasized.	150
143	12	Avoid too much protein in the diet, as it will tend to overload the kidneys.	160
144	12	Avoid dietary irritants, especially foods containing oxalic acid.	170
145	16	The five sensations that arise from stimulation of skin nerves are touch, pain, heat, cold, and pressure.	10
146	16	In hairy skin, the nerve endings are simple, threadlike, naked terminals. In skin that is not hairy, there are several types of specialized nerve endings. Although they look the same, each nerve ending is capable of responding to only one of the five basic types of sensation.	20
147	16	Effective phytotherapeutic treatment of skin disease must be mediated through internal medication, not topical application.	30
148	16	Internal treatment of skin problems will often be relevant, but it may be appropriate to also apply herb externally for local effects.	40
149	16	Stellaria media (chickweed) is an extremely effective topical remedy for the relief of itching.	50
150	16	Baths, also known as balneotherapy, represent one of the most pleasant ways to apply medications to the skin.	60
151	16	Fomentations and Compresses — These methods facilitate the local application of liquid formulations. Infusions, decoctions, tinctures, and oils can all be applied in this way.	70
152	16	Poultices are similar to fomentations and compresses but instead incorporate the herb in some solid form.	80
153	16	Lotions are liquid formulations for carrying the herbs. They will usually have a cooling effect due to evaporation. They rarely need to be washed off, as part will be absorbed and the rest will evaporate.	90
154	16	Creams are suspensions of oil in water, and can be formulated to be either greasy or nongreasy. They are primarily emollient and protective. An advantage of creams is that they do not insulate the skin too much and thus will not cause a localized increase in skin temperature. Overheating can aggravate itching in many skin problems.	100
155	16	An ointment is a semisolid, lipid-based application. Like creams, ointments and salves are emollient and protective, but they remain on the skin longer. This tenacity will confer a local warming effect.	110
156	16	A paste is a mixture of powder in an ointment base. Pastes are indicated when the goal is to keep the effects of the herbs on the surface for extended periods of time. Their contents are not absorbed well, but do impact the skin surface. They are useful in conditions such as psoriasis, in which they facilitate the removal of scales.	120
157	16	Powders are dry, finely powdered herbs or minerals. Their primary benefit is that they take up moisture — for example, perspiration or exudates of eczema. They can also be antipruritic and antimicrobial. Examples include colloidal oatmeal, Lycopodium powder, and cornstarch.	130
\.


--
-- Data for Name: body_systems; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.body_systems (id, name, created_at) FROM stdin;
9	Cardiovascular	2026-03-22 21:15:28.830018+00
10	Respiratory	2026-03-22 21:15:28.830018+00
11	Digestive	2026-03-22 21:15:28.830018+00
12	Urinary	2026-03-22 21:15:28.830018+00
13	Reproductive	2026-03-22 21:15:28.830018+00
14	Musculoskeletal	2026-03-22 21:15:28.830018+00
15	Nervous	2026-03-22 21:15:28.830018+00
16	Skin	2026-03-22 21:15:28.830018+00
17	Immune	2026-04-10 20:52:17.467597+00
18	Lower Respiratory	2026-04-23 16:05:55.110389+00
19	Upper Respiratory	2026-04-23 16:05:55.110389+00
21	All	2026-04-30 16:29:23.722325+00
24	Reproductive - Female	2026-06-07 19:28:17.415064+00
25	Reproductive - Male	2026-06-07 19:28:17.415064+00
26	Aging	2026-06-08 14:41:59.876695+00
\.


--
-- Data for Name: constituents; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.constituents (id, name, category, description, created_at) FROM stdin;
699	achilline	pyrrolidine alkaloid	\N	2026-06-29 15:09:48.1073+00
700	betonicine	pyrrolidine alkaloid	\N	2026-06-29 15:09:48.1073+00
701	berberine	isoquinoline alkaloid	Antimicrobial, anti-inflammatory; inhibits NF-κB	2026-06-29 15:09:48.1073+00
702	berbamine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
703	canadine	isoquinoline alkaloid	Also called l-tetrahydroberberine; sedative	2026-06-29 15:09:48.1073+00
704	columbamine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
705	coptisine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
706	jatrorrhizine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
707	palmatine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
708	stachydrine	pyrrolidine alkaloid	Uterotonic; found in motherwort and others	2026-06-29 15:09:48.1073+00
709	trigonelline	pyridine alkaloid	\N	2026-06-29 15:09:48.1073+00
710	caffeine	purine alkaloid	CNS stimulant; inhibits adenosine receptors	2026-06-29 15:09:48.1073+00
711	theobromine	purine alkaloid	\N	2026-06-29 15:09:48.1073+00
712	theophylline	purine alkaloid	Bronchodilator	2026-06-29 15:09:48.1073+00
713	ephedrine	phenethylamine alkaloid	Sympathomimetic; bronchodilator	2026-06-29 15:09:48.1073+00
714	pseudoephedrine	phenethylamine alkaloid	\N	2026-06-29 15:09:48.1073+00
715	lobeline	piperidine alkaloid	Nicotinic receptor partial agonist; respiratory stimulant	2026-06-29 15:09:48.1073+00
716	lobelanine	piperidine alkaloid	\N	2026-06-29 15:09:48.1073+00
717	lobelanidine	piperidine alkaloid	\N	2026-06-29 15:09:48.1073+00
718	colchicine	tropolone alkaloid	\N	2026-06-29 15:09:48.1073+00
719	chelidonine	benzophenanthridine alkaloid	\N	2026-06-29 15:09:48.1073+00
720	sanguinarine	benzophenanthridine alkaloid	Antimicrobial; found in bloodroot	2026-06-29 15:09:48.1073+00
721	chelerythrine	benzophenanthridine alkaloid	\N	2026-06-29 15:09:48.1073+00
722	allocryptopine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
724	eschscholtzine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
725	californidine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
726	caryachine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
727	gelsemicine	indole alkaloid	Toxic; found in yellow jasmine	2026-06-29 15:09:48.1073+00
728	gelsemine	indole alkaloid	\N	2026-06-29 15:09:48.1073+00
729	coniine	piperidine alkaloid	\N	2026-06-29 15:09:48.1073+00
730	cytisine	quinolizidine alkaloid	Nicotinic receptor agonist; found in scotch broom	2026-06-29 15:09:48.1073+00
731	sparteine	quinolizidine alkaloid	Antiarrhythmic; oxytocic	2026-06-29 15:09:48.1073+00
732	lupanine	quinolizidine alkaloid	\N	2026-06-29 15:09:48.1073+00
733	anagyrine	quinolizidine alkaloid	\N	2026-06-29 15:09:48.1073+00
735	swainsonine	indolizidine alkaloid	\N	2026-06-29 15:09:48.1073+00
736	leonurine	guanidine alkaloid	Uterotonic; found in motherwort	2026-06-29 15:09:48.1073+00
737	apigenin	flavone	Anxiolytic, anti-inflammatory	2026-06-29 15:09:48.1073+00
738	apigenin-7-glucoside	flavone glycoside	\N	2026-06-29 15:09:48.1073+00
739	luteolin	flavone	Anti-inflammatory; inhibits COX-2	2026-06-29 15:09:48.1073+00
740	luteolin-7-glucoside	flavone glycoside	\N	2026-06-29 15:09:48.1073+00
741	quercetin	flavonol	Antioxidant, anti-inflammatory, antihistamine	2026-06-29 15:09:48.1073+00
742	rutin	flavonol glycoside	Vascular tonic; stabilizes capillaries	2026-06-29 15:09:48.1073+00
743	hyperoside	flavonol glycoside	\N	2026-06-29 15:09:48.1073+00
744	isoquercitrin	flavonol glycoside	\N	2026-06-29 15:09:48.1073+00
745	isorhamnetin	flavonol	\N	2026-06-29 15:09:48.1073+00
746	kaempferol	flavonol	Antioxidant; anti-inflammatory	2026-06-29 15:09:48.1073+00
747	myricetin	flavonol	\N	2026-06-29 15:09:48.1073+00
748	naringenin	flavanone	\N	2026-06-29 15:09:48.1073+00
749	naringin	flavanone glycoside	\N	2026-06-29 15:09:48.1073+00
750	hesperidin	flavanone glycoside	Vascular protective; reduces capillary permeability	2026-06-29 15:09:48.1073+00
751	hesperetin	flavanone	\N	2026-06-29 15:09:48.1073+00
752	eriodictyol	flavanone	\N	2026-06-29 15:09:48.1073+00
753	catechin	flavan-3-ol	Antioxidant; astringent	2026-06-29 15:09:48.1073+00
754	epicatechin	flavan-3-ol	\N	2026-06-29 15:09:48.1073+00
755	epigallocatechin gallate	flavan-3-ol	Potent antioxidant	2026-06-29 15:09:48.1073+00
756	vitexin	flavone C-glycoside	Antispasmodic; found in hawthorn and passionflower	2026-06-29 15:09:48.1073+00
757	isovitexin	flavone C-glycoside	\N	2026-06-29 15:09:48.1073+00
758	vitexin-2'-rhamnoside	flavone C-glycoside	\N	2026-06-29 15:09:48.1073+00
759	orientin	flavone C-glycoside	\N	2026-06-29 15:09:48.1073+00
760	isoorientin	flavone C-glycoside	\N	2026-06-29 15:09:48.1073+00
761	chrysin	flavone	Anxiolytic; aromatase inhibitor	2026-06-29 15:09:48.1073+00
762	amentoflavone	biflavonoid	Found in St. John's Wort; antidepressant activity	2026-06-29 15:09:48.1073+00
763	casticin	polymethoxyflavone	Found in chasteberry	2026-06-29 15:09:48.1073+00
764	diosmin	flavone glycoside	Vascular protective	2026-06-29 15:09:48.1073+00
765	linarin	flavone glycoside	Sedative; found in valerian and passionflower	2026-06-29 15:09:48.1073+00
766	acacetin	flavone	\N	2026-06-29 15:09:48.1073+00
767	formononetin	isoflavone	Phytoestrogenic	2026-06-29 15:09:48.1073+00
768	biochanin A	isoflavone	Phytoestrogenic; precursor to genistein	2026-06-29 15:09:48.1073+00
769	daidzein	isoflavone	Phytoestrogenic	2026-06-29 15:09:48.1073+00
770	genistein	isoflavone	Phytoestrogenic; inhibits tyrosine kinase	2026-06-29 15:09:48.1073+00
771	calycosin	isoflavone	\N	2026-06-29 15:09:48.1073+00
772	glabridin	isoflavan	Potent anti-inflammatory from licorice	2026-06-29 15:09:48.1073+00
773	isoliquiritigenin	chalcone	Antispasmodic; estrogenic	2026-06-29 15:09:48.1073+00
774	liquiritigenin	flavanone	Estrogenic from licorice	2026-06-29 15:09:48.1073+00
775	8-prenylnaringenin	prenylated flavanone	Most potent phytoestrogen known; found in hops	2026-06-29 15:09:48.1073+00
776	isoxanthohumol	prenylated flavanone	Found in hops	2026-06-29 15:09:48.1073+00
777	xanthohumol	prenylated chalcone	Anticancer; found in hops	2026-06-29 15:09:48.1073+00
778	proanthocyanidins	condensed tannin	Vascular tonic; antioxidant	2026-06-29 15:09:48.1073+00
779	anthocyanins	anthocyanin	Antioxidant; vascular protective	2026-06-29 15:09:48.1073+00
780	cyanidin-3-glucoside	anthocyanin glycoside	\N	2026-06-29 15:09:48.1073+00
781	cyanidin-3-sambubioside	anthocyanin glycoside	\N	2026-06-29 15:09:48.1073+00
782	delphinidin glycosides	anthocyanin glycoside	\N	2026-06-29 15:09:48.1073+00
783	rosmarinic acid	hydroxycinnamic acid	Antioxidant, anti-inflammatory; inhibits complement	2026-06-29 15:09:48.1073+00
784	caffeic acid	hydroxycinnamic acid	Antioxidant; antimicrobial	2026-06-29 15:09:48.1073+00
786	ferulic acid	hydroxycinnamic acid	Antioxidant; anti-inflammatory	2026-06-29 15:09:48.1073+00
787	cichoric acid	dicaffeoylquinic acid	Immunomodulatory; found in echinacea	2026-06-29 15:09:48.1073+00
734	baptifoline	quinolizidine alkaloid	\N	2026-06-29 15:09:48.1073+00
788	echinacoside	caffeic acid glycoside	Antimicrobial; immunostimulant	2026-06-29 15:09:48.1073+00
789	gallic acid	hydroxybenzoic acid	Astringent; antimicrobial	2026-06-29 15:09:48.1073+00
790	ellagic acid	hydroxybenzoic acid	Antioxidant; anticancer	2026-06-29 15:09:48.1073+00
792	salicylic acid	hydroxybenzoic acid	Anti-inflammatory; analgesic	2026-06-29 15:09:48.1073+00
793	populin	phenolic glycoside	\N	2026-06-29 15:09:48.1073+00
794	p-coumaric acid	hydroxycinnamic acid	\N	2026-06-29 15:09:48.1073+00
795	tannins	polyphenol	Astringent; protein-precipitating	2026-06-29 15:09:48.1073+00
796	gallotannins	hydrolyzable tannin	\N	2026-06-29 15:09:48.1073+00
797	ellagitannins	hydrolyzable tannin	\N	2026-06-29 15:09:48.1073+00
798	geraniin	ellagitannin	\N	2026-06-29 15:09:48.1073+00
799	linalool	monoterpene alcohol	Anxiolytic, sedative, antimicrobial	2026-06-29 15:09:48.1073+00
800	linalyl acetate	monoterpene ester	Antispasmodic; found in lavender	2026-06-29 15:09:48.1073+00
801	menthol	monoterpene alcohol	Cooling; analgesic; decongestant	2026-06-29 15:09:48.1073+00
802	menthone	monoterpene ketone	\N	2026-06-29 15:09:48.1073+00
803	menthyl acetate	monoterpene ester	\N	2026-06-29 15:09:48.1073+00
804	menthofuran	monoterpene furan	\N	2026-06-29 15:09:48.1073+00
806	camphor	bicyclic monoterpene ketone	Stimulant; counterirritant; toxic in excess	2026-06-29 15:09:48.1073+00
807	borneol	bicyclic monoterpene alcohol	\N	2026-06-29 15:09:48.1073+00
808	bornyl acetate	bicyclic monoterpene ester	\N	2026-06-29 15:09:48.1073+00
809	1,8-cineole	monoterpene oxide	Expectorant; antimicrobial; also called eucalyptol	2026-06-29 15:09:48.1073+00
810	alpha-pinene	bicyclic monoterpene	Expectorant; antimicrobial	2026-06-29 15:09:48.1073+00
811	beta-pinene	bicyclic monoterpene	\N	2026-06-29 15:09:48.1073+00
812	thymol	monoterpene phenol	Potent antimicrobial; antifungal	2026-06-29 15:09:48.1073+00
813	carvacrol	monoterpene phenol	Antimicrobial; antifungal	2026-06-29 15:09:48.1073+00
814	p-cymene	monoterpene	\N	2026-06-29 15:09:48.1073+00
815	terpinen-4-ol	monoterpene alcohol	Antimicrobial; found in lavender and tea tree	2026-06-29 15:09:48.1073+00
816	gamma-terpinene	monoterpene	\N	2026-06-29 15:09:48.1073+00
817	limonene	monoterpene	Carminative; anticancer	2026-06-29 15:09:48.1073+00
818	alpha-terpineol	monoterpene alcohol	\N	2026-06-29 15:09:48.1073+00
819	geraniol	monoterpene alcohol	Antimicrobial; insect repellent	2026-06-29 15:09:48.1073+00
820	citral	monoterpene aldehyde	Antiviral; found in lemon balm	2026-06-29 15:09:48.1073+00
821	citronellal	monoterpene aldehyde	\N	2026-06-29 15:09:48.1073+00
822	thujone	bicyclic monoterpene ketone	Convulsant in large doses; found in sage and wormwood	2026-06-29 15:09:48.1073+00
823	sabinene	bicyclic monoterpene	\N	2026-06-29 15:09:48.1073+00
824	myrcene	monoterpene	Sedative; analgesic	2026-06-29 15:09:48.1073+00
825	ocimene	monoterpene	\N	2026-06-29 15:09:48.1073+00
826	chamazulene	sesquiterpene	Potent anti-inflammatory; formed during steam distillation	2026-06-29 15:09:48.1073+00
827	alpha-bisabolol	sesquiterpene alcohol	Anti-inflammatory; found in chamomile	2026-06-29 15:09:48.1073+00
828	bisabolol oxide A	sesquiterpene oxide	\N	2026-06-29 15:09:48.1073+00
829	bisabolol oxide B	sesquiterpene oxide	\N	2026-06-29 15:09:48.1073+00
830	beta-caryophyllene	sesquiterpene	CB2 agonist; anti-inflammatory	2026-06-29 15:09:48.1073+00
831	humulene	sesquiterpene	Anti-inflammatory; appetite suppressant	2026-06-29 15:09:48.1073+00
832	zingiberene	sesquiterpene	Primary volatile in ginger	2026-06-29 15:09:48.1073+00
833	ar-turmerone	sesquiterpene ketone	Found in turmeric; neuroprotective	2026-06-29 15:09:48.1073+00
834	bisabolene	sesquiterpene	\N	2026-06-29 15:09:48.1073+00
835	azulene	sesquiterpene	Anti-inflammatory; blue color in chamomile oil	2026-06-29 15:09:48.1073+00
836	pinocamphone	bicyclic monoterpene ketone	Found in hyssop	2026-06-29 15:09:48.1073+00
837	isopinocamphone	bicyclic monoterpene ketone	\N	2026-06-29 15:09:48.1073+00
838	valeranol	sesquiterpene alcohol	Found in valerian	2026-06-29 15:09:48.1073+00
839	artabsin	sesquiterpene lactone	Bitter; found in wormwood	2026-06-29 15:09:48.1073+00
840	absinthin	sesquiterpene lactone	Intensely bitter dimeric guaianolide	2026-06-29 15:09:48.1073+00
841	artemisinin	sesquiterpene lactone endoperoxide	Antimalarial	2026-06-29 15:09:48.1073+00
842	parthenolide	sesquiterpene lactone	Anti-inflammatory; inhibits NF-κB; found in feverfew	2026-06-29 15:09:48.1073+00
843	arctiopicrin	sesquiterpene lactone	Bitter; antibacterial; found in burdock	2026-06-29 15:09:48.1073+00
844	lactucin	sesquiterpene lactone	Sedative, analgesic; found in wild lettuce	2026-06-29 15:09:48.1073+00
845	lactucopicrin	sesquiterpene lactone	Bitter sedative; found in wild lettuce	2026-06-29 15:09:48.1073+00
848	taraxacin	sesquiterpene lactone	Bitter; found in dandelion	2026-06-29 15:09:48.1073+00
849	taraxacerin	sesquiterpene lactone	\N	2026-06-29 15:09:48.1073+00
850	marrubiin	labdane diterpene	Expectorant; antiarrhythmic; found in horehound	2026-06-29 15:09:48.1073+00
851	carnosic acid	diterpene phenol	Antioxidant; neuroprotective; found in rosemary/sage	2026-06-29 15:09:48.1073+00
852	carnosol	diterpene phenol	Antioxidant; anticancer	2026-06-29 15:09:48.1073+00
853	rosmanol	diterpene phenol	\N	2026-06-29 15:09:48.1073+00
854	ursolic acid	pentacyclic triterpenoid	Anti-inflammatory; anticancer; hepatoprotective	2026-06-29 15:09:48.1073+00
855	oleanolic acid	pentacyclic triterpenoid	Hepatoprotective; anti-inflammatory	2026-06-29 15:09:48.1073+00
856	taraxasterol	pentacyclic triterpenoid	\N	2026-06-29 15:09:48.1073+00
857	beta-sitosterol	phytosterol	5-alpha-reductase inhibitor; anti-inflammatory	2026-06-29 15:09:48.1073+00
859	glycyrrhizin	oleanane triterpenoid saponin	Anti-inflammatory; 50× sweeter than sucrose; inhibits 11β-HSD	2026-06-29 15:09:48.1073+00
860	glycyrrhetic acid	triterpenoid aglycone	Active metabolite of glycyrrhizin	2026-06-29 15:09:48.1073+00
861	diosgenin	steroidal saponin aglycone	Precursor to progesterone synthesis (in vitro); found in wild yam	2026-06-29 15:09:48.1073+00
862	dioscin	steroidal saponin	\N	2026-06-29 15:09:48.1073+00
863	astragaloside IV	cycloastragenol saponin	Telomere-supporting; immunomodulatory	2026-06-29 15:09:48.1073+00
864	cycloastragenol	triterpenoid	Aglycone of astragalosides; telomerase activator	2026-06-29 15:09:48.1073+00
865	ginsenosides	dammarane triterpenoid saponins	Adaptogenic; found in Panax ginseng	2026-06-29 15:09:48.1073+00
866	eleutherosides	phenylpropanoid & lignan glycosides	Adaptogenic; found in Siberian ginseng	2026-06-29 15:09:48.1073+00
867	withanolides	steroidal lactone	Adaptogenic, anti-inflammatory, anticancer; found in ashwagandha	2026-06-29 15:09:48.1073+00
868	withaferin A	steroidal lactone	Potent anti-inflammatory and anticancer withanolide	2026-06-29 15:09:48.1073+00
846	achillin	sesquiterpene lactone	\N	2026-06-29 15:09:48.1073+00
805	pulegone	monoterpene ketone	Toxic in large doses	2026-06-29 15:09:48.1073+00
858	stigmasterol	phytosterol	\N	2026-06-29 15:09:48.1073+00
869	withanosides	steroidal glycoside	Nootropic; found in ashwagandha	2026-06-29 15:09:48.1073+00
870	schisandrin	lignan	Hepatoprotective; adaptogenic; found in schisandra	2026-06-29 15:09:48.1073+00
871	schisandrin B	lignan	\N	2026-06-29 15:09:48.1073+00
872	gomisin A	lignan	\N	2026-06-29 15:09:48.1073+00
873	aucubin	iridoid glycoside	Anti-inflammatory; hepatoprotective	2026-06-29 15:09:48.1073+00
874	catalpol	iridoid glycoside	\N	2026-06-29 15:09:48.1073+00
875	agnuside	iridoid glycoside	Found in chasteberry	2026-06-29 15:09:48.1073+00
876	asperuloside	iridoid glycoside	Found in cleavers	2026-06-29 15:09:48.1073+00
877	harpagide	iridoid glycoside	Anti-inflammatory; found in devil's claw	2026-06-29 15:09:48.1073+00
878	harpagoside	iridoid glycoside	Anti-inflammatory; found in devil's claw	2026-06-29 15:09:48.1073+00
879	leonuride	iridoid glycoside	Found in motherwort	2026-06-29 15:09:48.1073+00
880	valepotriates	epoxide iridoid	Sedative, antispasmodic; found in valerian root	2026-06-29 15:09:48.1073+00
881	valtrate	epoxide iridoid	\N	2026-06-29 15:09:48.1073+00
882	didrovaltrate	epoxide iridoid	\N	2026-06-29 15:09:48.1073+00
883	loganin	iridoid glycoside	\N	2026-06-29 15:09:48.1073+00
884	hypericin	naphthodianthrone	Antidepressant; photosensitizing; found in St. John's Wort	2026-06-29 15:09:48.1073+00
885	pseudohypericin	naphthodianthrone	\N	2026-06-29 15:09:48.1073+00
886	hyperforin	acylphloroglucinol	Antidepressant; inhibits serotonin/dopamine/norepinephrine reuptake	2026-06-29 15:09:48.1073+00
887	adhyperforin	acylphloroglucinol	\N	2026-06-29 15:09:48.1073+00
888	emodin	anthraquinone	Cathartic; anti-inflammatory	2026-06-29 15:09:48.1073+00
889	chrysophanol	anthraquinone	\N	2026-06-29 15:09:48.1073+00
890	physcion	anthraquinone	\N	2026-06-29 15:09:48.1073+00
891	aloe-emodin	anthraquinone	\N	2026-06-29 15:09:48.1073+00
892	barbaloin	anthraquinone glycoside	Cathartic; found in aloe	2026-06-29 15:09:48.1073+00
893	sennosides	anthraquinone glycoside	Stimulant laxative	2026-06-29 15:09:48.1073+00
894	eugenol	phenylpropanoid	Analgesic; antimicrobial; found in clove	2026-06-29 15:09:48.1073+00
895	methyleugenol	phenylpropanoid	Possible carcinogen	2026-06-29 15:09:48.1073+00
896	anethole	phenylpropanoid	Estrogenic; carminative; found in anise and fennel	2026-06-29 15:09:48.1073+00
897	apiole	phenylpropanoid	Uterotonic; found in parsley	2026-06-29 15:09:48.1073+00
898	myristicin	phenylpropanoid	Psychoactive; found in parsley	2026-06-29 15:09:48.1073+00
899	safrole	phenylpropanoid	Carcinogen; found in sassafras	2026-06-29 15:09:48.1073+00
900	asarone	phenylpropanoid	Carcinogen in high doses	2026-06-29 15:09:48.1073+00
901	trans-cinnamic acid	hydroxycinnamic acid	\N	2026-06-29 15:09:48.1073+00
902	methylchavicol	phenylpropanoid	Found in basil	2026-06-29 15:09:48.1073+00
903	herniarin	coumarin	Found in chamomile	2026-06-29 15:09:48.1073+00
904	umbelliferone	coumarin	\N	2026-06-29 15:09:48.1073+00
905	scopoletin	coumarin	Anti-inflammatory; spasmolytic; found in cramp bark	2026-06-29 15:09:48.1073+00
906	aesculetin	coumarin	\N	2026-06-29 15:09:48.1073+00
907	psoralen	furanocoumarin	Photosensitizing	2026-06-29 15:09:48.1073+00
908	bergapten	furanocoumarin	Photosensitizing	2026-06-29 15:09:48.1073+00
909	osthole	coumarin	Found in dong quai; antispasmodic	2026-06-29 15:09:48.1073+00
910	imperatorin	furanocoumarin	\N	2026-06-29 15:09:48.1073+00
911	peucedanin	furanocoumarin	\N	2026-06-29 15:09:48.1073+00
912	inulin	fructo-oligosaccharide	Prebiotic; found in burdock, dandelion, elecampane	2026-06-29 15:09:48.1073+00
913	mucilaginous polysaccharides	polysaccharide	Demulcent; soothing to mucous membranes	2026-06-29 15:09:48.1073+00
914	arabinogalacturonan	acidic polysaccharide	Primary mucilage of marshmallow	2026-06-29 15:09:48.1073+00
915	pectins	polysaccharide	Demulcent; binds toxins in GI tract	2026-06-29 15:09:48.1073+00
916	beta-glucans	polysaccharide	Immunomodulatory; found in medicinal mushrooms	2026-06-29 15:09:48.1073+00
917	astragalans	polysaccharide	Immunomodulatory; found in astragalus	2026-06-29 15:09:48.1073+00
918	echinacea polysaccharides	polysaccharide	Immunostimulant; found in echinacea	2026-06-29 15:09:48.1073+00
919	aloe polysaccharides	polysaccharide	Immunomodulatory; wound healing	2026-06-29 15:09:48.1073+00
920	alginic acid	polysaccharide	\N	2026-06-29 15:09:48.1073+00
921	ulvan	sulfated polysaccharide	\N	2026-06-29 15:09:48.1073+00
922	alliin	cysteine sulfoxide	Precursor to allicin; found in garlic	2026-06-29 15:09:48.1073+00
923	allicin	organosulfur	Antimicrobial; cardiovascular; formed enzymatically from alliin	2026-06-29 15:09:48.1073+00
924	ajoene	organosulfur	Antiplatelet; found in garlic	2026-06-29 15:09:48.1073+00
925	diallyl disulfide	organosulfur	Antimicrobial; anticancer	2026-06-29 15:09:48.1073+00
926	arbutin	hydroquinone glycoside	Urinary antiseptic; inhibits melanin synthesis	2026-06-29 15:09:48.1073+00
927	amygdalin	cyanogenic glycoside	\N	2026-06-29 15:09:48.1073+00
928	prunasin	cyanogenic glycoside	Found in wild cherry; antitussive	2026-06-29 15:09:48.1073+00
929	sinigrin	glucosinolate	Precursor to allyl isothiocyanate; found in mustard	2026-06-29 15:09:48.1073+00
930	gluconasturtiin	glucosinolate	\N	2026-06-29 15:09:48.1073+00
931	allyl isothiocyanate	isothiocyanate	Rubefacient; antimicrobial; from mustard	2026-06-29 15:09:48.1073+00
932	sambunigrin	cyanogenic glycoside	Toxic raw; destroyed by heat; found in elderberry	2026-06-29 15:09:48.1073+00
933	cardiac glycosides	cardiac glycoside	Positive inotropic; found in lily of the valley, digitalis	2026-06-29 15:09:48.1073+00
934	convallotoxin	cardiac glycoside	Found in lily of the valley	2026-06-29 15:09:48.1073+00
935	convallatoxol	cardiac glycoside	\N	2026-06-29 15:09:48.1073+00
936	digitalinum verum	cardiac glycoside	\N	2026-06-29 15:09:48.1073+00
937	resins	resin	Antimicrobial; expectorant; require high alcohol to extract	2026-06-29 15:09:48.1073+00
938	boswellic acids	pentacyclic triterpenoid acid	Anti-inflammatory; inhibit 5-LOX	2026-06-29 15:09:48.1073+00
939	guaiacol	phenol	Expectorant; found in guaiacum	2026-06-29 15:09:48.1073+00
940	myrrhanols	triterpenoid	Anti-inflammatory; found in myrrh	2026-06-29 15:09:48.1073+00
941	commiphoric acid	terpenoid acid	Found in myrrh	2026-06-29 15:09:48.1073+00
942	allantoin	purine derivative	Cell-proliferant; wound healing; found in comfrey and plantain	2026-06-29 15:09:48.1073+00
943	silymarin	flavonolignan complex	Hepatoprotective; antioxidant; found in milk thistle	2026-06-29 15:09:48.1073+00
944	silybin	flavonolignan	Most active component of silymarin	2026-06-29 15:09:48.1073+00
945	silydianin	flavonolignan	\N	2026-06-29 15:09:48.1073+00
946	silychristin	flavonolignan	\N	2026-06-29 15:09:48.1073+00
947	curcumin	curcuminoid	Potent anti-inflammatory; inhibits NF-κB; hepatoprotective	2026-06-29 15:09:48.1073+00
948	demethoxycurcumin	curcuminoid	\N	2026-06-29 15:09:48.1073+00
949	bisdemethoxycurcumin	curcuminoid	\N	2026-06-29 15:09:48.1073+00
950	gingerols	gingerol	Anti-nausea; anti-inflammatory; found in fresh ginger	2026-06-29 15:09:48.1073+00
951	6-gingerol	gingerol	Primary active gingerol	2026-06-29 15:09:48.1073+00
952	shogaols	dehydrated gingerol	More potent than gingerols; found in dried ginger	2026-06-29 15:09:48.1073+00
953	zingerone	gingerol degradation product	\N	2026-06-29 15:09:48.1073+00
954	kavalactones	alpha-pyrone	Anxiolytic; muscle relaxant; found in kava	2026-06-29 15:09:48.1073+00
955	kavain	alpha-pyrone	Primary kavalactone; anxiolytic	2026-06-29 15:09:48.1073+00
956	dihydrokavain	alpha-pyrone	\N	2026-06-29 15:09:48.1073+00
957	methysticin	alpha-pyrone	\N	2026-06-29 15:09:48.1073+00
958	dihydromethysticin	alpha-pyrone	Sedative kavalactone	2026-06-29 15:09:48.1073+00
959	yangonin	alpha-pyrone	\N	2026-06-29 15:09:48.1073+00
960	ginkgolides	diterpene trilactone	PAF antagonist; found in ginkgo	2026-06-29 15:09:48.1073+00
961	ginkgolide A	diterpene trilactone	\N	2026-06-29 15:09:48.1073+00
962	ginkgolide B	diterpene trilactone	Most potent PAF antagonist	2026-06-29 15:09:48.1073+00
963	bilobalide	sesquiterpene trilactone	Neuroprotective; found in ginkgo	2026-06-29 15:09:48.1073+00
964	flavonol glycosides (ginkgo)	flavonol glycoside	Antioxidant; in ginkgo leaf extract	2026-06-29 15:09:48.1073+00
965	valerenic acid	sesquiterpene acid	Anxiolytic; GABA-A modulator; found in valerian	2026-06-29 15:09:48.1073+00
966	acetoxyvalerenic acid	sesquiterpene acid	\N	2026-06-29 15:09:48.1073+00
967	isovaleric acid	short-chain fatty acid	Characteristic odor; sedative in valerian	2026-06-29 15:09:48.1073+00
968	GABA	amino acid neurotransmitter	Inhibitory neurotransmitter; found in valerian	2026-06-29 15:09:48.1073+00
969	humulone	alpha acid	Bitter; antibacterial; found in hops	2026-06-29 15:09:48.1073+00
970	lupulone	beta acid	Bitter; antibacterial; found in hops	2026-06-29 15:09:48.1073+00
971	2-methyl-3-buten-2-ol	monoterpene alcohol	Major sedative from hops; breakdown product of humulone	2026-06-29 15:09:48.1073+00
972	lignans	lignan	Phytoestrogenic; hepatoprotective; antioxidant	2026-06-29 15:09:48.1073+00
973	Z-ligustilide	phthalide	Antispasmodic; found in dong quai and osha	2026-06-29 15:09:48.1073+00
974	butylidenephthalide	phthalide	Antispasmodic; found in dong quai	2026-06-29 15:09:48.1073+00
975	alkamides	isobutylamide	Immunomodulatory; tingling sensation; found in echinacea	2026-06-29 15:09:48.1073+00
976	urtica dioica agglutinin	lectin	Immunomodulatory; anti-inflammatory; found in nettle root	2026-06-29 15:09:48.1073+00
977	formic acid	organic acid	Stinging compound in nettle hairs	2026-06-29 15:09:48.1073+00
978	histamine	biogenic amine	Stinging compound in nettle hairs	2026-06-29 15:09:48.1073+00
979	serotonin	indoleamine	Stinging compound in nettle hairs	2026-06-29 15:09:48.1073+00
980	pyrrolizidine alkaloids	pyrrolizidine alkaloid	Hepatotoxic in large doses; found in comfrey root	2026-06-29 15:09:48.1073+00
981	symphytine	pyrrolizidine alkaloid	Hepatotoxic; found in comfrey	2026-06-29 15:09:48.1073+00
982	echimidine	pyrrolizidine alkaloid	\N	2026-06-29 15:09:48.1073+00
983	ganoderic acids	triterpenoid	Hepatoprotective; immunomodulatory; found in reishi	2026-06-29 15:09:48.1073+00
984	adenosine	nucleoside	Cardiovascular; found in reishi and astragalus	2026-06-29 15:09:48.1073+00
985	harpagophytum procumbens triterpenoids	triterpenoid	Anti-inflammatory; found in devil's claw	2026-06-29 15:09:48.1073+00
986	actein	cycloartane triterpenoid glycoside	Found in black cohosh	2026-06-29 15:09:48.1073+00
987	23-epi-26-deoxyactein	cycloartane triterpenoid glycoside	Primary active triterpene of black cohosh	2026-06-29 15:09:48.1073+00
988	cimicifugoside	cycloartane triterpenoid glycoside	\N	2026-06-29 15:09:48.1073+00
989	fukinolic acid	caffeic acid ester	Found in black cohosh	2026-06-29 15:09:48.1073+00
990	carotenoids	carotenoid	Antioxidant; pro-vitamin A	2026-06-29 15:09:48.1073+00
991	beta-carotene	carotenoid	\N	2026-06-29 15:09:48.1073+00
992	lutein	xanthophyll carotenoid	\N	2026-06-29 15:09:48.1073+00
993	zeaxanthin	xanthophyll carotenoid	\N	2026-06-29 15:09:48.1073+00
994	mucilage	polysaccharide	General demulcent mucilage	2026-06-29 15:09:48.1073+00
995	oxalates	organic acid	Astringent; found in yellow dock and sorrel	2026-06-29 15:09:48.1073+00
996	silica	mineral	Connective tissue support; found in horsetail	2026-06-29 15:09:48.1073+00
997	potassium	mineral	Diuretic effect via osmosis; found in dandelion leaf	2026-06-29 15:09:48.1073+00
998	iron	mineral	Found in nettle leaf	2026-06-29 15:09:48.1073+00
999	selenium	mineral	\N	2026-06-29 15:09:48.1073+00
1000	baicalin	flavone glucuronide	Anti-inflammatory; anxiolytic; found in skullcap	2026-06-29 15:09:48.1073+00
1001	baicalein	flavone	Active aglycone of baicalin	2026-06-29 15:09:48.1073+00
1002	scutellarein	flavone	Found in skullcap	2026-06-29 15:09:48.1073+00
1003	wogonin	flavone	Anti-inflammatory; anxiolytic; found in skullcap	2026-06-29 15:09:48.1073+00
1004	elecampane camphor	sesquiterpene lactone	\N	2026-06-29 15:09:48.1073+00
1005	alantolactone	sesquiterpene lactone	Antimicrobial; found in elecampane	2026-06-29 15:09:48.1073+00
1006	isoalantolactone	sesquiterpene lactone	\N	2026-06-29 15:09:48.1073+00
1007	thiarubrine A	polyacetylene	Antifungal; found in echinacea root	2026-06-29 15:09:48.1073+00
1008	polyacetylenes	polyacetylene	Antimicrobial; immunostimulant	2026-06-29 15:09:48.1073+00
1009	phthalides	phthalide	Antispasmodic; sedative; in celery seed	2026-06-29 15:09:48.1073+00
1010	3-n-butylphthalide	phthalide	Antispasmodic; antihypertensive; found in celery seed	2026-06-29 15:09:48.1073+00
1011	sedanolide	phthalide	Found in celery seed	2026-06-29 15:09:48.1073+00
1012	steroidal saponins	saponin	Precursors to steroid hormones; expectorant	2026-06-29 15:09:48.1073+00
1013	triterpenoid saponins	saponin	Expectorant; adaptogenic	2026-06-29 15:09:48.1073+00
1014	glycoalkaloids	steroidal alkaloid glycoside	\N	2026-06-29 15:09:48.1073+00
1015	hydrastine	isoquinoline alkaloid	Astringent; haemostatic; found in goldenseal	2026-06-29 15:09:48.1073+00
1016	meconine	isoquinoline alkaloid	\N	2026-06-29 15:09:48.1073+00
1017	fatty acids	fatty acid	Nutritive; anti-inflammatory	2026-06-29 15:09:48.1073+00
1018	gamma-linolenic acid	omega-6 fatty acid	Anti-inflammatory; found in evening primrose	2026-06-29 15:09:48.1073+00
1019	linoleic acid	omega-6 fatty acid	\N	2026-06-29 15:09:48.1073+00
1020	alpha-linolenic acid	omega-3 fatty acid	\N	2026-06-29 15:09:48.1073+00
1021	phytosterols	phytosterol	Cholesterol-lowering; 5-alpha-reductase inhibition	2026-06-29 15:09:48.1073+00
1022	saw palmetto fatty acids	fatty acid	Inhibit 5-alpha-reductase; found in saw palmetto	2026-06-29 15:09:48.1073+00
1023	harmine	beta-carboline alkaloid	MAO-A inhibitor; found in passionflower trace	2026-06-29 15:09:48.1073+00
1024	harmane	beta-carboline alkaloid	\N	2026-06-29 15:09:48.1073+00
1025	gossypol	polyphenol	\N	2026-06-29 15:09:48.1073+00
1026	methylxanthines	purine alkaloid	CNS stimulants; collective term for caffeine/theobromine/theophylline	2026-06-29 15:09:48.1073+00
1027	piperine	piperidine alkaloid	Bioavailability enhancer; found in pepper	2026-06-29 15:09:48.1073+00
1028	aescin	triterpenoid saponin	Reduces capillary permeability; found in horse chestnut	2026-06-29 15:09:48.1073+00
1029	aesculin	coumarin glycoside	Found in horse chestnut	2026-06-29 15:09:48.1073+00
1030	fumaric acid	organic acid	Found in fumitory; inhibits DOPA decarboxylase	2026-06-29 15:09:48.1073+00
1031	fumarine	isoquinoline alkaloid	Found in fumitory	2026-06-29 15:09:48.1073+00
723	protopine	isoquinoline alkaloid	Antispasmodic; found in California poppy	2026-06-29 15:09:48.1073+00
1033	guggulsterones	steroidal ketone	Thyroid stimulating; hypolipidemic; found in guggul	2026-06-29 15:09:48.1073+00
785	chlorogenic acid	hydroxycinnamic acid	Antioxidant; hypoglycemic	2026-06-29 15:09:48.1073+00
847	achillicin	sesquiterpene lactone	\N	2026-06-29 15:09:48.1073+00
1037	bitter glycosides	glycoside	General bitter glycosides	2026-06-29 15:09:48.1073+00
1038	saponins	saponin	General saponin glycosides	2026-06-29 15:09:48.1073+00
1039	methylarbutin	hydroquinone glycoside	Found in uva ursi	2026-06-29 15:09:48.1073+00
1040	ononin	isoflavone glycoside	Found in astragalus	2026-06-29 15:09:48.1073+00
1041	avenanthramides	alkaloid amide	Antioxidant, anti-inflammatory; unique to oats	2026-06-29 15:09:48.1073+00
1042	baptisin	isoflavone glycoside	Found in wild indigo	2026-06-29 15:09:48.1073+00
1044	capsaicin	capsaicinoid	TRPV1 agonist; analgesic via substance P depletion	2026-06-29 15:09:48.1073+00
1045	dihydrocapsaicin	capsaicinoid	\N	2026-06-29 15:09:48.1073+00
1046	vitamin C	ascorbic acid	Antioxidant; immune support	2026-06-29 15:09:48.1073+00
1047	cimifugin	chromone	Antispasmodic; found in black cohosh	2026-06-29 15:09:48.1073+00
1048	cinnamaldehyde	phenylpropanoid	Antimicrobial; hypoglycemic; primary volatile of cinnamon	2026-06-29 15:09:48.1073+00
1049	cinnamyl acetate	phenylpropanoid ester	\N	2026-06-29 15:09:48.1073+00
1050	cnicin	sesquiterpene lactone	Intensely bitter; antibacterial; found in blessed thistle	2026-06-29 15:09:48.1073+00
1051	furanosesquiterpenes	sesquiterpene	Antimicrobial; found in myrrh	2026-06-29 15:09:48.1073+00
1052	isoflavones	isoflavone	General isoflavone class	2026-06-29 15:09:48.1073+00
1053	polysaccharides	polysaccharide	Immunomodulatory polysaccharides	2026-06-29 15:09:48.1073+00
1054	phenolic acids	phenolic acid	General phenolic acids class	2026-06-29 15:09:48.1073+00
791	salicin	phenolic glycoside	Pro-drug of salicylic acid; analgesic	2026-06-29 15:09:48.1073+00
1056	spiraein	phenolic glycoside	Hydrolyzed to salicylaldehyde; found in meadowsweet	2026-06-29 15:09:48.1073+00
1057	gaultherin	phenolic glycoside	Found in meadowsweet flowers	2026-06-29 15:09:48.1073+00
1058	citric acid	organic acid	Found in cleavers; mildly diuretic	2026-06-29 15:09:48.1073+00
1059	ergosterol	phytosterol	Pro-vitamin D; found in fungi	2026-06-29 15:09:48.1073+00
1060	gentiopicroside	secoiridoid glycoside	Intensely bitter; hepatoprotective; found in gentian	2026-06-29 15:09:48.1073+00
1061	swertiamarin	secoiridoid glycoside	Bitter; found in gentian	2026-06-29 15:09:48.1073+00
1062	amarogentin	secoiridoid glycoside	One of the most bitter natural compounds known	2026-06-29 15:09:48.1073+00
1094	hamamelitannin	hydrolyzable tannin	Astringent; anti-inflammatory; found in witch hazel bark	2026-06-29 15:11:46.079494+00
1095	procumbide	iridoid glycoside	Found in devil's claw	2026-06-29 15:11:46.079494+00
1096	alpha-terpinen-4-ol	monoterpene alcohol	Diuretic; antimicrobial; primary urinary active of juniper	2026-06-29 15:11:46.079494+00
1097	lactucic acid	organic acid	Found in wild lettuce	2026-06-29 15:11:46.079494+00
1098	coumarins	coumarin	General coumarin class	2026-06-29 15:11:46.079494+00
1099	flavonoids	flavonoid	General flavonoid class	2026-06-29 15:11:46.079494+00
1100	norlobelanine	piperidine alkaloid	Found in lobelia	2026-06-29 15:11:46.079494+00
1101	chelidonic acid	pyranone dicarboxylic acid	Found in lobelia	2026-06-29 15:11:46.079494+00
1102	oxyacanthine	isoquinoline alkaloid	Bisbenzylisoquinoline alkaloid; antimicrobial	2026-06-29 15:11:46.079494+00
1103	alkaloids	alkaloid	General alkaloid class	2026-06-29 15:11:46.079494+00
1104	nepetalactone	iridoid monoterpene	Insect repellent; found in catnip; behavioral effect in cats	2026-06-29 15:11:46.079494+00
1105	nepetol	monoterpene alcohol	Found in catnip	2026-06-29 15:11:46.079494+00
1106	peptidoglycans	glycoprotein	Immunomodulatory; found in ginseng	2026-06-29 15:11:46.079494+00
1107	desmethoxyyangonin	alpha-pyrone	Found in kava	2026-06-29 15:11:46.079494+00
1108	piscidin	isoflavone	Found in Jamaica dogwood; analgesic	2026-06-29 15:11:46.079494+00
1109	piscidic acid	tartrate ester	Found in Jamaica dogwood	2026-06-29 15:11:46.079494+00
1110	rotenone	isoflavanone	Found in Jamaica dogwood; ichthyotoxic	2026-06-29 15:11:46.079494+00
1111	neochlorogenic acid	hydroxycinnamic acid	Found in plantain	2026-06-29 15:11:46.079494+00
1112	fragarine	alkaloid	Uterine tonic alkaloid; found in raspberry leaf	2026-06-29 15:11:46.079494+00
1113	iridoids	iridoid	General iridoid class	2026-06-29 15:11:46.079494+00
1114	taxifoline	dihydroflavonol	Antioxidant; found in milk thistle	2026-06-29 15:11:46.079494+00
1115	chrysanthemyl acetate	monoterpene ester	Found in feverfew and chrysanthemum	2026-06-29 15:11:46.079494+00
1116	tiliroside	kaempferol glycoside	Anti-inflammatory; found in linden flower	2026-06-29 15:11:46.079494+00
1117	farnesol	sesquiterpene alcohol	Sedative; found in linden flower volatile fraction	2026-06-29 15:11:46.079494+00
1118	zinc	mineral	Wound healing; immune support	2026-06-29 15:11:46.079494+00
1119	verbenalin	iridoid glycoside	Found in vervain; bitter; liver-stimulating	2026-06-29 15:11:46.079494+00
1120	hastatoside	iridoid glycoside	Found in blue vervain	2026-06-29 15:11:46.079494+00
1121	scopoline	coumarin alkaloid	Found in cramp bark	2026-06-29 15:11:46.079494+00
1122	valerianic acid	organic acid	Antispasmodic; found in cramp bark and valerian	2026-06-29 15:11:46.079494+00
1123	diosphenol	monoterpenoid	Primary diuretic volatile of buchu	2026-06-29 15:11:46.079494+00
1125	piperol A	phenylpropanoid	Found in yerba mansa; antimicrobial	2026-06-29 15:11:46.079494+00
1126	araloside A	triterpenoid saponin	Found in Aralia spp.	2026-06-29 15:11:46.079494+00
1127	furanocoumarins (lomatium)	furanocoumarin	Antiviral; found in Lomatium; can cause rash	2026-06-29 15:11:46.079494+00
1128	galbanic acid	furanocoumarin	Antiviral; found in Lomatium	2026-06-29 15:11:46.079494+00
1129	eupatorin	flavone	Found in boneset; anti-inflammatory	2026-06-29 15:11:46.079494+00
1130	leiocarposide	phenolic glycoside	Anti-inflammatory; diuretic; found in goldenrod	2026-06-29 15:11:46.079494+00
1131	verbascosaponin	triterpenoid saponin	Expectorant; found in mullein	2026-06-29 15:11:46.079494+00
1132	maysin	flavone C-glycoside	Found in corn silk; anti-inflammatory	2026-06-29 15:11:46.079494+00
\.


--
-- Data for Name: disorder_action_herbs; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.disorder_action_herbs (id, disorder_id, herb_id, primary_action_id, note, sort_order, created_at) FROM stdin;
1	3	26	5	\N	1	2026-04-06 21:33:58.34407+00
2	3	26	2	\N	1	2026-04-06 21:33:58.34407+00
3	3	28	2	\N	2	2026-04-06 21:33:58.34407+00
4	3	70	2	\N	3	2026-04-06 21:33:58.34407+00
5	3	28	27	\N	1	2026-04-06 21:33:58.34407+00
6	3	70	27	\N	2	2026-04-06 21:33:58.34407+00
7	3	70	28	\N	1	2026-04-06 21:33:58.34407+00
8	4	26	5	\N	1	2026-04-06 21:33:58.34407+00
9	4	26	2	\N	1	2026-04-06 21:33:58.34407+00
10	4	28	2	\N	2	2026-04-06 21:33:58.34407+00
11	4	123	2	\N	3	2026-04-06 21:33:58.34407+00
12	4	26	27	\N	1	2026-04-06 21:33:58.34407+00
13	4	28	27	\N	2	2026-04-06 21:33:58.34407+00
14	4	123	27	\N	3	2026-04-06 21:33:58.34407+00
15	4	123	29	\N	1	2026-04-06 21:33:58.34407+00
16	5	45	13	\N	1	2026-04-06 21:33:58.34407+00
17	5	70	27	\N	1	2026-04-06 21:33:58.34407+00
18	5	70	28	\N	1	2026-04-06 21:33:58.34407+00
19	5	70	8	\N	1	2026-04-06 21:33:58.34407+00
20	5	84	4	\N	1	2026-04-06 21:33:58.34407+00
21	5	70	4	\N	2	2026-04-06 21:33:58.34407+00
22	5	84	11	\N	1	2026-04-06 21:33:58.34407+00
23	6	45	13	\N	1	2026-04-06 21:33:58.34407+00
24	6	75	4	\N	1	2026-04-06 21:33:58.34407+00
25	6	84	4	\N	2	2026-04-06 21:33:58.34407+00
26	6	75	8	\N	1	2026-04-06 21:33:58.34407+00
27	6	84	28	\N	1	2026-04-06 21:33:58.34407+00
28	6	84	26	\N	1	2026-04-06 21:33:58.34407+00
29	7	89	13	\N	1	2026-04-06 21:33:58.34407+00
30	7	45	13	\N	2	2026-04-06 21:33:58.34407+00
31	7	84	4	\N	1	2026-04-06 21:33:58.34407+00
32	7	30	4	\N	2	2026-04-06 21:33:58.34407+00
33	7	89	8	\N	1	2026-04-06 21:33:58.34407+00
34	7	30	8	\N	2	2026-04-06 21:33:58.34407+00
35	7	89	28	\N	1	2026-04-06 21:33:58.34407+00
36	7	30	28	\N	2	2026-04-06 21:33:58.34407+00
37	7	84	28	\N	3	2026-04-06 21:33:58.34407+00
38	7	84	26	\N	1	2026-04-06 21:33:58.34407+00
39	7	84	11	\N	1	2026-04-06 21:33:58.34407+00
40	7	30	9	\N	1	2026-04-06 21:33:58.34407+00
41	8	89	13	\N	1	2026-04-06 21:33:58.34407+00
42	8	45	13	\N	2	2026-04-06 21:33:58.34407+00
43	8	75	4	\N	1	2026-04-06 21:33:58.34407+00
44	8	89	28	\N	1	2026-04-06 21:33:58.34407+00
45	8	89	8	\N	1	2026-04-06 21:33:58.34407+00
46	8	75	8	\N	2	2026-04-06 21:33:58.34407+00
47	8	75	11	\N	1	2026-04-06 21:33:58.34407+00
48	8	145	26	\N	1	2026-04-06 21:33:58.34407+00
49	9	55	11	\N	1	2026-04-06 21:33:58.34407+00
50	9	84	11	\N	2	2026-04-06 21:33:58.34407+00
51	9	134	11	\N	3	2026-04-06 21:33:58.34407+00
52	9	55	4	\N	1	2026-04-06 21:33:58.34407+00
53	9	84	4	\N	2	2026-04-06 21:33:58.34407+00
54	9	134	4	\N	3	2026-04-06 21:33:58.34407+00
55	9	102	9	\N	1	2026-04-06 21:33:58.34407+00
56	9	84	9	\N	2	2026-04-06 21:33:58.34407+00
57	9	145	26	\N	1	2026-04-06 21:33:58.34407+00
58	9	84	26	\N	2	2026-04-06 21:33:58.34407+00
59	10	119	8	\N	1	2026-04-06 21:56:12.487259+00
60	10	115	9	\N	1	2026-04-06 21:56:12.487259+00
61	10	84	9	\N	2	2026-04-06 21:56:12.487259+00
62	10	74	4	\N	1	2026-04-06 21:56:12.487259+00
63	10	84	4	\N	2	2026-04-06 21:56:12.487259+00
64	10	84	11	\N	1	2026-04-06 21:56:12.487259+00
65	10	55	11	\N	2	2026-04-06 21:56:12.487259+00
66	10	74	7	\N	1	2026-04-06 21:56:12.487259+00
67	10	84	7	\N	2	2026-04-06 21:56:12.487259+00
68	10	55	7	\N	3	2026-04-06 21:56:12.487259+00
69	10	84	28	\N	1	2026-04-06 21:56:12.487259+00
70	10	84	26	\N	1	2026-04-06 21:56:12.487259+00
71	10	145	26	\N	2	2026-04-06 21:56:12.487259+00
72	11	119	8	\N	1	2026-04-06 21:56:12.487259+00
73	11	148	8	\N	2	2026-04-06 21:56:12.487259+00
74	11	89	8	\N	3	2026-04-06 21:56:12.487259+00
75	11	89	13	\N	1	2026-04-06 21:56:12.487259+00
76	11	89	28	\N	1	2026-04-06 21:56:12.487259+00
77	11	84	28	\N	2	2026-04-06 21:56:12.487259+00
78	11	74	4	\N	1	2026-04-06 21:56:12.487259+00
79	11	84	4	\N	2	2026-04-06 21:56:12.487259+00
80	11	145	11	\N	1	2026-04-06 21:56:12.487259+00
81	11	84	11	\N	2	2026-04-06 21:56:12.487259+00
82	11	145	7	\N	1	2026-04-06 21:56:12.487259+00
83	11	84	7	\N	2	2026-04-06 21:56:12.487259+00
84	11	145	26	\N	1	2026-04-06 21:56:12.487259+00
85	11	84	26	\N	2	2026-04-06 21:56:12.487259+00
86	12	74	7	\N	1	2026-04-06 21:56:12.487259+00
87	12	93	7	\N	2	2026-04-06 21:56:12.487259+00
88	12	55	7	\N	3	2026-04-06 21:56:12.487259+00
89	12	74	4	\N	1	2026-04-06 21:56:12.487259+00
90	12	55	4	\N	2	2026-04-06 21:56:12.487259+00
91	12	21	5	\N	1	2026-04-06 21:56:12.487259+00
92	12	145	11	\N	1	2026-04-06 21:56:12.487259+00
93	12	55	11	\N	2	2026-04-06 21:56:12.487259+00
94	12	145	26	\N	1	2026-04-06 21:56:12.487259+00
95	12	55	26	\N	2	2026-04-06 21:56:12.487259+00
96	14	122	19	\N	1	2026-04-06 21:56:27.332838+00
97	14	146	19	\N	2	2026-04-06 21:56:27.332838+00
98	14	206	19	\N	3	2026-04-06 21:56:27.332838+00
99	14	24	19	\N	4	2026-04-06 21:56:27.332838+00
100	14	176	19	\N	5	2026-04-06 21:56:27.332838+00
101	14	122	9	\N	1	2026-04-06 21:56:27.332838+00
102	14	176	9	\N	2	2026-04-06 21:56:27.332838+00
103	14	122	2	\N	1	2026-04-06 21:56:27.332838+00
104	14	176	2	\N	2	2026-04-06 21:56:27.332838+00
105	14	122	33	\N	1	2026-04-06 21:56:27.332838+00
106	14	176	33	\N	2	2026-04-06 21:56:27.332838+00
107	14	88	34	\N	1	2026-04-06 21:56:27.332838+00
108	15	122	19	\N	1	2026-04-06 21:56:27.332838+00
109	15	206	19	\N	2	2026-04-06 21:56:27.332838+00
110	15	24	19	\N	3	2026-04-06 21:56:27.332838+00
111	15	176	19	\N	4	2026-04-06 21:56:27.332838+00
112	15	26	5	\N	1	2026-04-06 21:56:27.332838+00
113	15	206	35	\N	1	2026-04-06 21:56:27.332838+00
114	15	115	9	\N	1	2026-04-06 21:56:27.332838+00
115	15	122	9	\N	2	2026-04-06 21:56:27.332838+00
116	15	176	9	\N	3	2026-04-06 21:56:27.332838+00
117	15	122	2	\N	1	2026-04-06 21:56:27.332838+00
118	15	176	2	\N	2	2026-04-06 21:56:27.332838+00
119	15	122	33	\N	1	2026-04-06 21:56:27.332838+00
120	15	176	33	\N	2	2026-04-06 21:56:27.332838+00
121	16	9	1	\N	1	2026-04-06 21:56:27.332838+00
122	16	78	1	\N	2	2026-04-06 21:56:27.332838+00
123	16	14	1	\N	3	2026-04-06 21:56:27.332838+00
124	16	223	1	\N	4	2026-04-06 21:56:27.332838+00
125	16	20	1	\N	5	2026-04-06 21:56:27.332838+00
126	16	178	36	\N	1	2026-04-06 21:56:27.332838+00
127	16	81	36	\N	2	2026-04-06 21:56:27.332838+00
128	16	146	36	\N	3	2026-04-06 21:56:27.332838+00
129	16	224	4	\N	1	2026-04-06 21:56:27.332838+00
130	16	84	4	\N	2	2026-04-06 21:56:27.332838+00
131	16	203	4	\N	3	2026-04-06 21:56:27.332838+00
132	16	21	37	\N	1	2026-04-06 21:56:27.332838+00
133	16	165	37	\N	2	2026-04-06 21:56:27.332838+00
134	16	206	37	\N	3	2026-04-06 21:56:27.332838+00
135	16	225	38	\N	1	2026-04-06 21:56:27.332838+00
136	16	226	38	\N	2	2026-04-06 21:56:27.332838+00
137	16	222	38	\N	3	2026-04-06 21:56:27.332838+00
138	16	227	38	\N	4	2026-04-06 21:56:27.332838+00
139	16	201	38	\N	5	2026-04-06 21:56:27.332838+00
140	16	17	39	\N	1	2026-04-06 21:56:27.332838+00
141	16	122	39	\N	2	2026-04-06 21:56:27.332838+00
142	16	172	35	\N	1	2026-04-06 21:56:27.332838+00
143	16	26	40	\N	1	2026-04-06 21:56:27.332838+00
144	16	11	40	\N	2	2026-04-06 21:56:27.332838+00
145	18	122	19	\N	1	2026-04-06 21:56:27.332838+00
146	18	24	19	\N	2	2026-04-06 21:56:27.332838+00
147	18	175	19	\N	3	2026-04-06 21:56:27.332838+00
148	18	122	4	\N	1	2026-04-06 21:56:27.332838+00
149	18	74	7	\N	1	2026-04-06 21:56:27.332838+00
150	18	145	7	\N	2	2026-04-06 21:56:27.332838+00
151	18	122	2	\N	1	2026-04-06 21:56:27.332838+00
152	18	175	2	\N	2	2026-04-06 21:56:27.332838+00
153	18	122	33	\N	1	2026-04-06 21:56:27.332838+00
154	18	175	33	\N	2	2026-04-06 21:56:27.332838+00
155	19	171	19	\N	1	2026-04-06 21:56:27.332838+00
156	19	24	19	\N	2	2026-04-06 21:56:27.332838+00
157	19	175	19	\N	3	2026-04-06 21:56:27.332838+00
158	19	171	41	\N	1	2026-04-06 21:56:27.332838+00
159	19	24	41	\N	2	2026-04-06 21:56:27.332838+00
160	19	74	7	\N	1	2026-04-06 21:56:27.332838+00
161	19	145	7	\N	2	2026-04-06 21:56:27.332838+00
162	20	165	42	\N	1	2026-04-06 21:56:27.332838+00
163	20	62	42	\N	2	2026-04-06 21:56:27.332838+00
164	20	52	8	\N	1	2026-04-06 21:56:27.332838+00
165	20	122	9	\N	1	2026-04-06 21:56:27.332838+00
166	20	30	9	\N	2	2026-04-06 21:56:27.332838+00
167	20	122	31	\N	1	2026-04-06 21:56:27.332838+00
168	20	30	31	\N	2	2026-04-06 21:56:27.332838+00
169	21	225	47	\N	1	2026-04-10 20:55:36.403551+00
170	21	271	47	\N	2	2026-04-10 20:55:36.403551+00
171	21	11	47	\N	3	2026-04-10 20:55:36.403551+00
172	21	226	47	\N	4	2026-04-10 20:55:36.403551+00
173	21	274	47	\N	5	2026-04-10 20:55:36.403551+00
174	21	17	47	\N	6	2026-04-10 20:55:36.403551+00
175	21	21	5	\N	1	2026-04-10 20:55:36.403551+00
176	21	23	5	\N	2	2026-04-10 20:55:36.403551+00
177	21	70	5	\N	3	2026-04-10 20:55:36.403551+00
178	21	99	5	\N	4	2026-04-10 20:55:36.403551+00
179	21	26	5	\N	5	2026-04-10 20:55:36.403551+00
180	21	201	5	\N	6	2026-04-10 20:55:36.403551+00
181	21	112	5	\N	7	2026-04-10 20:55:36.403551+00
182	23	22	2	\N	1	2026-04-10 20:55:36.403551+00
183	23	28	2	\N	2	2026-04-10 20:55:36.403551+00
184	23	43	2	\N	3	2026-04-10 20:55:36.403551+00
185	23	37	31	\N	1	2026-04-10 20:55:36.403551+00
186	23	122	31	\N	2	2026-04-10 20:55:36.403551+00
187	23	44	51	\N	1	2026-04-10 20:55:36.403551+00
188	23	50	51	\N	2	2026-04-10 20:55:36.403551+00
189	23	57	51	\N	3	2026-04-10 20:55:36.403551+00
190	23	28	14	\N	1	2026-04-10 20:55:36.403551+00
191	23	122	14	\N	2	2026-04-10 20:55:36.403551+00
192	23	160	53	\N	1	2026-04-10 20:55:36.403551+00
193	23	61	53	\N	2	2026-04-10 20:55:36.403551+00
194	23	60	53	\N	3	2026-04-10 20:55:36.403551+00
195	23	122	19	\N	1	2026-04-10 20:55:36.403551+00
196	23	206	19	\N	2	2026-04-10 20:55:36.403551+00
197	23	70	55	\N	1	2026-04-10 20:55:36.403551+00
198	23	28	55	\N	2	2026-04-10 20:55:36.403551+00
199	23	42	55	\N	3	2026-04-10 20:55:36.403551+00
200	24	9	1	help the body adapt around the problem and avoid the possibility of collapse	1	2026-04-10 20:55:49.407997+00
201	24	43	2	avoid strong immunostimulants and instead use a mild alterative	1	2026-04-10 20:55:49.407997+00
202	24	28	2	avoid strong immunostimulants and instead use a mild alterative	2	2026-04-10 20:55:49.407997+00
203	24	206	19	support the liver's detoxification process, facilitating the removal of the metabolites from the body and speeding the return to normal. This is the main herb to consider, as it is best to avoid stronger liver stimulants after an operation	1	2026-04-10 20:55:49.407997+00
204	24	70	28	excellent for limiting the amount of scar tissue that forms without compromising the viability of the wound healing, when blended with Vitamin E oil	1	2026-04-10 20:55:49.407997+00
205	24	81	28	excellent for limiting the amount of scar tissue that forms without compromising the viability of the wound healing, when blended with Vitamin E oil	2	2026-04-10 20:55:49.407997+00
206	25	23	5	The Eclectics recommended this in combination with Echinacea for acute febrile infections.	1	2026-04-10 20:55:49.407997+00
207	25	46	5	appropriate for a bladder infection	2	2026-04-10 20:55:49.407997+00
208	25	99	5	good choice for topical application	3	2026-04-10 20:55:49.407997+00
209	25	136	51	good choice for children	1	2026-04-10 20:55:49.407997+00
210	25	113	51	reserve this diaphoretic for adults	2	2026-04-10 20:55:49.407997+00
211	25	61	33	may be the right choice for a lung infection	1	2026-04-10 20:55:49.407997+00
212	25	28	33	more appropriate for lymphatic tissue infections	2	2026-04-10 20:55:49.407997+00
213	25	73	33	use this as a tonic if there is any concern about cardiovascular health	3	2026-04-10 20:55:49.407997+00
214	25	165	33	use this as a tonic for an elderly patient	4	2026-04-10 20:55:49.407997+00
215	28	44	5	\N	1	2026-04-10 20:56:04.197894+00
216	28	181	5	\N	2	2026-04-10 20:56:04.197894+00
217	28	46	5	\N	3	2026-04-10 20:56:04.197894+00
218	28	179	5	\N	4	2026-04-10 20:56:04.197894+00
219	28	103	5	\N	5	2026-04-10 20:56:04.197894+00
220	28	120	5	\N	6	2026-04-10 20:56:04.197894+00
221	29	46	5	\N	1	2026-04-10 20:58:36.064973+00
222	29	181	5	\N	2	2026-04-10 20:58:36.064973+00
223	29	26	5	\N	3	2026-04-10 20:58:36.064973+00
224	29	44	5	\N	4	2026-04-10 20:58:36.064973+00
225	29	186	73	\N	1	2026-04-10 20:58:36.064973+00
226	29	46	14	\N	1	2026-04-10 20:58:36.064973+00
227	29	181	14	\N	2	2026-04-10 20:58:36.064973+00
228	29	95	14	\N	3	2026-04-10 20:58:36.064973+00
229	29	44	14	\N	4	2026-04-10 20:58:36.064973+00
230	29	95	13	\N	1	2026-04-10 20:58:36.064973+00
231	30	26	2	\N	1	2026-04-10 20:58:36.064973+00
232	30	28	2	\N	2	2026-04-10 20:58:36.064973+00
233	30	37	2	\N	3	2026-04-10 20:58:36.064973+00
234	30	35	2	\N	4	2026-04-10 20:58:36.064973+00
235	30	43	2	\N	5	2026-04-10 20:58:36.064973+00
236	30	26	5	\N	1	2026-04-10 20:58:36.064973+00
237	30	28	55	\N	1	2026-04-10 20:58:36.064973+00
238	30	35	55	\N	2	2026-04-10 20:58:36.064973+00
239	30	28	14	\N	1	2026-04-10 20:58:36.064973+00
240	30	43	14	\N	2	2026-04-10 20:58:36.064973+00
241	30	37	19	\N	1	2026-04-10 20:58:36.064973+00
242	52	54	90	\N	1	2026-04-23 16:05:55.110389+00
243	52	60	90	\N	2	2026-04-23 16:05:55.110389+00
244	52	61	90	\N	3	2026-04-23 16:05:55.110389+00
255	52	126	7	\N	1	2026-04-23 16:05:55.110389+00
256	52	338	7	\N	2	2026-04-23 16:05:55.110389+00
257	52	130	7	\N	3	2026-04-23 16:05:55.110389+00
258	52	340	7	\N	4	2026-04-23 16:05:55.110389+00
259	52	140	7	\N	5	2026-04-23 16:05:55.110389+00
260	52	21	5	\N	1	2026-04-23 16:05:55.110389+00
261	52	101	5	\N	2	2026-04-23 16:05:55.110389+00
262	52	59	5	\N	3	2026-04-23 16:05:55.110389+00
264	52	53	3	\N	1	2026-04-23 16:05:55.110389+00
265	52	60	3	\N	2	2026-04-23 16:05:55.110389+00
266	52	73	10	\N	1	2026-04-23 16:05:55.110389+00
267	52	131	10	\N	2	2026-04-23 16:05:55.110389+00
268	52	90	10	\N	3	2026-04-23 16:05:55.110389+00
269	52	53	26	\N	1	2026-04-23 16:05:55.110389+00
270	52	130	26	\N	2	2026-04-23 16:05:55.110389+00
271	52	131	26	\N	3	2026-04-23 16:05:55.110389+00
272	52	132	26	\N	4	2026-04-23 16:05:55.110389+00
273	61	473	5	\N	1	2026-04-23 16:06:49.507222+00
274	61	101	5	\N	2	2026-04-23 16:06:49.507222+00
275	61	59	5	\N	3	2026-04-23 16:06:49.507222+00
276	61	23	5	\N	4	2026-04-23 16:06:49.507222+00
277	61	99	5	\N	5	2026-04-23 16:06:49.507222+00
278	61	104	5	\N	6	2026-04-23 16:06:49.507222+00
280	61	58	3	\N	1	2026-04-23 16:06:49.507222+00
281	61	57	3	\N	2	2026-04-23 16:06:49.507222+00
282	61	53	3	\N	3	2026-04-23 16:06:49.507222+00
283	61	60	3	\N	4	2026-04-23 16:06:49.507222+00
284	61	30	3	\N	5	2026-04-23 16:06:49.507222+00
285	61	56	8	\N	1	2026-04-23 16:06:49.507222+00
286	61	51	8	\N	2	2026-04-23 16:06:49.507222+00
287	61	50	51	\N	1	2026-04-23 16:06:49.507222+00
288	61	90	51	\N	2	2026-04-23 16:06:49.507222+00
289	64	50	3	\N	1	2026-04-23 16:07:01.735818+00
290	64	30	3	\N	2	2026-04-23 16:07:01.735818+00
291	64	160	3	\N	3	2026-04-23 16:07:01.735818+00
292	64	50	9	\N	1	2026-04-23 16:07:01.735818+00
294	64	30	9	\N	3	2026-04-23 16:07:01.735818+00
295	64	160	9	\N	4	2026-04-23 16:07:01.735818+00
296	64	50	51	\N	1	2026-04-23 16:07:01.735818+00
297	64	30	33	\N	1	2026-04-23 16:07:01.735818+00
298	64	160	53	\N	1	2026-04-23 16:07:01.735818+00
300	73	146	19	\N	20	2026-04-30 16:30:34.395192+00
301	73	115	36	\N	30	2026-04-30 16:30:34.395192+00
302	73	115	9	\N	40	2026-04-30 16:30:34.395192+00
303	73	9	1	\N	50	2026-04-30 16:30:34.395192+00
304	73	81	36	\N	60	2026-04-30 16:30:34.395192+00
305	73	206	35	\N	70	2026-04-30 16:30:34.395192+00
307	64	102	9	\N	2	2026-05-17 16:15:06.755767+00
263	52	26	25	\N	1	2026-04-23 16:05:55.110389+00
279	61	26	40	\N	1	2026-04-23 16:06:49.507222+00
299	73	146	22	\N	10	2026-04-30 16:30:34.395192+00
308	118	44	33	\N	1	2026-06-08 14:41:59.876695+00
309	118	62	33	\N	2	2026-06-08 14:41:59.876695+00
310	118	21	33	\N	3	2026-06-08 14:41:59.876695+00
311	118	73	33	\N	4	2026-06-08 14:41:59.876695+00
312	118	165	33	\N	5	2026-06-08 14:41:59.876695+00
313	118	131	33	\N	6	2026-06-08 14:41:59.876695+00
314	118	122	33	\N	7	2026-06-08 14:41:59.876695+00
315	118	1159	33	\N	8	2026-06-08 14:41:59.876695+00
316	118	1160	33	\N	9	2026-06-08 14:41:59.876695+00
317	118	93	33	\N	10	2026-06-08 14:41:59.876695+00
318	119	21	33	\N	1	2026-06-08 14:41:59.876695+00
319	119	67	33	\N	2	2026-06-08 14:41:59.876695+00
320	119	49	33	\N	3	2026-06-08 14:41:59.876695+00
321	119	53	33	\N	4	2026-06-08 14:41:59.876695+00
322	119	54	33	\N	5	2026-06-08 14:41:59.876695+00
323	119	131	33	\N	6	2026-06-08 14:41:59.876695+00
324	119	160	33	\N	7	2026-06-08 14:41:59.876695+00
325	119	140	33	\N	8	2026-06-08 14:41:59.876695+00
326	119	59	33	\N	9	2026-06-08 14:41:59.876695+00
327	119	61	33	\N	10	2026-06-08 14:41:59.876695+00
328	119	199	16	\N	11	2026-06-08 14:41:59.876695+00
329	119	132	16	\N	12	2026-06-08 14:41:59.876695+00
330	119	38	16	\N	13	2026-06-08 14:41:59.876695+00
331	120	178	22	\N	1	2026-06-08 14:41:59.876695+00
332	120	81	22	\N	2	2026-06-08 14:41:59.876695+00
333	120	142	22	\N	3	2026-06-08 14:41:59.876695+00
334	120	25	23	\N	4	2026-06-08 14:41:59.876695+00
335	120	53	23	\N	5	2026-06-08 14:41:59.876695+00
336	120	82	23	\N	6	2026-06-08 14:41:59.876695+00
337	120	131	23	\N	7	2026-06-08 14:41:59.876695+00
338	120	84	23	\N	8	2026-06-08 14:41:59.876695+00
339	120	134	23	\N	9	2026-06-08 14:41:59.876695+00
340	120	1159	23	\N	10	2026-06-08 14:41:59.876695+00
341	120	128	20	\N	11	2026-06-08 14:41:59.876695+00
342	120	84	20	\N	12	2026-06-08 14:41:59.876695+00
343	120	137	20	\N	13	2026-06-08 14:41:59.876695+00
344	120	145	20	\N	14	2026-06-08 14:41:59.876695+00
345	120	178	36	\N	15	2026-06-08 14:41:59.876695+00
346	120	115	36	\N	16	2026-06-08 14:41:59.876695+00
347	120	81	36	\N	17	2026-06-08 14:41:59.876695+00
348	120	82	36	\N	18	2026-06-08 14:41:59.876695+00
349	120	146	36	\N	19	2026-06-08 14:41:59.876695+00
350	121	148	33	\N	1	2026-06-08 14:41:59.876695+00
351	121	45	33	\N	2	2026-06-08 14:41:59.876695+00
352	121	49	33	\N	3	2026-06-08 14:41:59.876695+00
353	121	75	33	\N	4	2026-06-08 14:41:59.876695+00
354	121	76	33	\N	5	2026-06-08 14:41:59.876695+00
355	121	102	33	\N	6	2026-06-08 14:41:59.876695+00
356	121	84	33	\N	7	2026-06-08 14:41:59.876695+00
357	121	55	33	\N	8	2026-06-08 14:41:59.876695+00
358	121	37	33	\N	9	2026-06-08 14:41:59.876695+00
359	121	206	33	\N	10	2026-06-08 14:41:59.876695+00
360	121	89	33	\N	11	2026-06-08 14:41:59.876695+00
361	121	92	33	\N	12	2026-06-08 14:41:59.876695+00
362	122	44	33	\N	1	2026-06-08 14:41:59.876695+00
363	122	46	33	\N	2	2026-06-08 14:41:59.876695+00
364	122	179	33	\N	3	2026-06-08 14:41:59.876695+00
365	122	28	33	\N	4	2026-06-08 14:41:59.876695+00
366	122	57	33	\N	5	2026-06-08 14:41:59.876695+00
367	122	122	33	\N	6	2026-06-08 14:41:59.876695+00
368	122	1212	33	\N	7	2026-06-08 14:41:59.876695+00
369	123	72	33	\N	1	2026-06-08 14:41:59.876695+00
370	123	25	33	\N	2	2026-06-08 14:41:59.876695+00
371	123	131	33	\N	3	2026-06-08 14:41:59.876695+00
372	123	188	33	\N	4	2026-06-08 14:41:59.876695+00
373	123	186	33	\N	5	2026-06-08 14:41:59.876695+00
374	123	93	33	\N	6	2026-06-08 14:41:59.876695+00
375	123	94	33	\N	7	2026-06-08 14:41:59.876695+00
376	123	190	33	\N	8	2026-06-08 14:41:59.876695+00
377	124	66	33	\N	1	2026-06-08 14:41:59.876695+00
378	124	65	33	\N	2	2026-06-08 14:41:59.876695+00
379	124	68	33	\N	3	2026-06-08 14:41:59.876695+00
380	124	25	33	\N	4	2026-06-08 14:41:59.876695+00
381	124	74	33	\N	5	2026-06-08 14:41:59.876695+00
382	124	75	33	\N	6	2026-06-08 14:41:59.876695+00
383	124	34	33	\N	7	2026-06-08 14:41:59.876695+00
384	124	87	33	\N	8	2026-06-08 14:41:59.876695+00
385	124	43	33	\N	9	2026-06-08 14:41:59.876695+00
386	124	29	6	\N	10	2026-06-08 14:41:59.876695+00
387	124	80	6	\N	11	2026-06-08 14:41:59.876695+00
388	124	123	6	\N	12	2026-06-08 14:41:59.876695+00
389	125	70	2	\N	1	2026-06-08 14:41:59.876695+00
390	125	28	2	\N	2	2026-06-08 14:41:59.876695+00
391	125	81	2	\N	3	2026-06-08 14:41:59.876695+00
392	125	85	2	\N	4	2026-06-08 14:41:59.876695+00
393	125	88	2	\N	5	2026-06-08 14:41:59.876695+00
394	125	42	2	\N	6	2026-06-08 14:41:59.876695+00
395	125	43	2	\N	7	2026-06-08 14:41:59.876695+00
396	125	1240	2	\N	8	2026-06-08 14:41:59.876695+00
397	117	186	73	\N	10	2026-06-08 15:00:58.883045+00
398	117	296	4	\N	10	2026-06-08 15:00:58.883045+00
399	117	40	2	\N	10	2026-06-08 15:00:58.883045+00
400	117	95	13	\N	10	2026-06-08 15:00:58.883045+00
401	117	179	13	\N	20	2026-06-08 15:00:58.883045+00
402	117	46	8	\N	10	2026-06-08 15:00:58.883045+00
403	117	151	8	\N	20	2026-06-08 15:00:58.883045+00
\.


--
-- Data for Name: disorder_actions_indicated; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.disorder_actions_indicated (id, disorder_id, primary_action_id, description, sort_order, created_at) FROM stdin;
1	3	4	Play a core role by reducing the localized mucosal reaction.	1	2026-04-06 21:33:58.34407+00
2	3	5	Inhibit the development of infection or prevent the spread of bacteria to the rest of the body, which can occur due to impaired buccal immune response.	2	2026-04-06 21:33:58.34407+00
3	3	25	Necessary if the ulcers suggest a systemic problem.	3	2026-04-06 21:33:58.34407+00
4	3	2	Will help with any metabolic problems that might be present.	4	2026-04-06 21:33:58.34407+00
5	3	13	Help soothe and relieve symptoms.	5	2026-04-06 21:33:58.34407+00
6	3	26	Assist the individual in coping with stress; counseling may also be indicated	6	2026-04-06 21:33:58.34407+00
7	3	1	Assist the individual in coping with stress; counseling may also be indicated	7	2026-04-06 21:33:58.34407+00
8	4	5	Essential to reduce populations of bacteria that contribute to the decay process.	1	2026-04-06 21:33:58.34407+00
9	4	4	Reduce any localized mucosal reaction.	2	2026-04-06 21:33:58.34407+00
10	4	8	Lessen local bleeding and other exudations.	3	2026-04-06 21:33:58.34407+00
11	4	29	Promote the circulation of blood in the gums, aiding in detoxification.	4	2026-04-06 21:33:58.34407+00
12	4	25	Necessary if gum disease suggests a systemic problem.	5	2026-04-06 21:33:58.34407+00
13	4	2	Help the body deal with any systemic problems related to the disease.	6	2026-04-06 21:33:58.34407+00
14	5	13	soothe and coat the tissue of the esophagus, insulating the mucosal lining against acidic gastric contents.	1	2026-04-06 21:33:58.34407+00
15	5	4	reduce localized mucosal reactions.	2	2026-04-06 21:33:58.34407+00
16	5	28	aid the natural healing of ulcerations and other lesions.	3	2026-04-06 21:33:58.34407+00
17	5	8	lessen local bleeding and other exudatations.	4	2026-04-06 21:33:58.34407+00
18	5	2	help the body deal with any systemic problems related to the disease.	5	2026-04-06 21:33:58.34407+00
19	5	11	may be needed if there is general disruption of digestive process.	6	2026-04-06 21:33:58.34407+00
20	6	13	soothe the lining of the stomach, by either coating the stomach or exerting anti-inflammatory actions.	1	2026-04-06 21:33:58.34407+00
21	6	30	have little more to offer than symptomatic relief.	2	2026-04-06 21:33:58.34407+00
22	6	4	reduce localized mucosal reactions.	3	2026-04-06 21:33:58.34407+00
23	6	8	lessen local bleeding.	4	2026-04-06 21:33:58.34407+00
24	6	28	enhance the stomach's natural wound-healing abilities.	5	2026-04-06 21:33:58.34407+00
25	6	26	help ease background stress involvement.	6	2026-04-06 21:33:58.34407+00
26	6	2	help the body deal with any systemic problems related to the disease	7	2026-04-06 21:33:58.34407+00
27	7	13	soothe the lining of the stomach, either by coating the stomach or exerting anti-inflammatory actions.	1	2026-04-06 21:33:58.34407+00
28	7	4	reduce localized mucosal reactions.	2	2026-04-06 21:33:58.34407+00
29	7	5	are indicated for dealing with H. pylori. However, these herbs must be active in the stomach in order for them to be effective.	3	2026-04-06 21:33:58.34407+00
30	7	8	lessen local bleeding.	4	2026-04-06 21:33:58.34407+00
31	7	28	speed natural wound healing	5	2026-04-06 21:33:58.34407+00
32	7	11	will reduce any flatulence in the gastrointestinal tract.	6	2026-04-06 21:33:58.34407+00
33	7	26	help ease background stress involvement.	7	2026-04-06 21:33:58.34407+00
34	7	9	aid the healing process in the latter stages of treatment.	8	2026-04-06 21:33:58.34407+00
35	7	2	help the body deal with any systemic problems related to the disease.	9	2026-04-06 21:33:58.34407+00
36	8	13	soothe the lining of the stomach, by either coating the mucosa or exerting anti-inflammatory actions.	1	2026-04-06 21:33:58.34407+00
37	8	4	reduce localized mucosal reactions.	2	2026-04-06 21:33:58.34407+00
38	8	28	speed natural wound healing and may help strengthen the diaphragm.	3	2026-04-06 21:33:58.34407+00
39	8	8	lessen local bleeding.	4	2026-04-06 21:33:58.34407+00
40	8	11	will help with any flatulence or colic.	5	2026-04-06 21:33:58.34407+00
41	8	26	help ease background stress involvement	6	2026-04-06 21:33:58.34407+00
42	10	8	reverse the diarrhea and reduce any pathological mucus production.	1	2026-04-06 21:56:12.487259+00
43	10	9	promote appropriate digestive secretions, and often will normalize bowel function on their own.	2	2026-04-06 21:56:12.487259+00
44	10	4	reduce localized mucosal reactions.	3	2026-04-06 21:56:12.487259+00
45	10	11	help with any flatulence or colic.	4	2026-04-06 21:56:12.487259+00
46	10	7	other than carminatives may be indicated if cramping is severe.	5	2026-04-06 21:56:12.487259+00
47	10	28	are indicated if there is any hint of damage to the lining of the colon.	6	2026-04-06 21:56:12.487259+00
48	10	26	help ease background stress.	7	2026-04-06 21:56:12.487259+00
49	10	31	may be indicated temporarily if constipation is present. Do not use strong herbs, however, as there may be a rapid swing back to diarrhea.	8	2026-04-06 21:56:12.487259+00
50	11	8	may help stem blood loss.	1	2026-04-06 21:56:12.487259+00
51	11	13	soothe surface irritation.	2	2026-04-06 21:56:12.487259+00
52	11	28	promote healing of ulcerations in the mucosal lining.	3	2026-04-06 21:56:12.487259+00
53	11	4	aid the body in its attempt to control inappropriate inflammatory reactions.	4	2026-04-06 21:56:12.487259+00
54	11	11	help relieve abdominal discomfort.	5	2026-04-06 21:56:12.487259+00
55	11	7	help ease the muscular cramping in the bowel that causes much of the pain.	6	2026-04-06 21:56:12.487259+00
56	11	25	essential and must cover the whole range of issues involved.	7	2026-04-06 21:56:12.487259+00
57	11	5	help combat any secondary infection that might arise.	8	2026-04-06 21:56:12.487259+00
58	11	32	must be given to the other organs of elimination.	9	2026-04-06 21:56:12.487259+00
59	11	26	will help address the psychological components of the condition.	10	2026-04-06 21:56:12.487259+00
60	12	7	help relieve abdominal pain caused by cramping around diverticula.	1	2026-04-06 21:56:12.487259+00
61	12	4	reduce the generalized inflammatory response within the colon.	2	2026-04-06 21:56:12.487259+00
62	12	5	help the body deal with any infection that might be present.	3	2026-04-06 21:56:12.487259+00
63	12	11	lessen discomfort due to flatulence.	4	2026-04-06 21:56:12.487259+00
64	12	26	ease stress, which may be either causal or a result of the condition.	5	2026-04-06 21:56:12.487259+00
65	15	19	help support and improve liver function and metabolism.	1	2026-04-06 21:56:27.332838+00
66	15	5	will be critical if the hepatitis has an infectious basis, and will help with surface immune support even if no infection is present.	2	2026-04-06 21:56:27.332838+00
67	15	9	help with whole-system toning.	3	2026-04-06 21:56:27.332838+00
68	15	12	have a direct impact on the secretion and release of bile, and thus may be indicated if jaundice is present.	4	2026-04-06 21:56:27.332838+00
133	55	10	herbs offer support if there is any history or suspicion of cardiovascular problems.	8	2026-04-23 16:06:07.589513+00
69	15	32	will help the whole body deal with the buildup of bilirubin and other metabolites, Laxatives, diuretics, and diaphoretics are the primary actions to consider.	5	2026-04-06 21:56:27.332838+00
70	15	2	support the whole body in its healing work.	6	2026-04-06 21:56:27.332838+00
71	15	33	support the whole body in its healing work.	7	2026-04-06 21:56:27.332838+00
72	15	27	promote tissue drainage.	8	2026-04-06 21:56:27.332838+00
73	15	26	may be needed for symptomatic support,	9	2026-04-06 21:56:27.332838+00
74	17	19	support and improve liver function and metabolism.	1	2026-04-06 21:56:27.332838+00
75	17	12	have a direct upon the secretion and release of bile	2	2026-04-06 21:56:27.332838+00
76	17	32	will help the whole body deal with the buildup of bilirubin and other metabolites. Laxatives, diuretics, and diaphoretics are the primary actions to consider.	3	2026-04-06 21:56:27.332838+00
77	17	2	support the whole body in its healing work.	4	2026-04-06 21:56:27.332838+00
78	17	33	support the whole body in its healing work.	4	2026-04-06 21:56:27.332838+00
79	17	9	help with whole-system toning.	5	2026-04-06 21:56:27.332838+00
80	17	27	promote systemic tissue drainage.	6	2026-04-06 21:56:27.332838+00
81	17	26	will support any psychological work needed in alcohol withdrawal.	7	2026-04-06 21:56:27.332838+00
82	17	5	will be helpful for surface immune support, even if no infection is present.	8	2026-04-06 21:56:27.332838+00
83	18	19	support the work of the liver and so will have a positive metabolic effect.	1	2026-04-06 21:56:27.332838+00
84	18	4	may help reduce the severity of swelling.	2	2026-04-06 21:56:27.332838+00
85	18	7	help ease colic in the gallbladder or ducts.	3	2026-04-06 21:56:27.332838+00
86	18	32	must be provided to help the whole body deal with the repercussions of digestive distress and systemic problems.	4	2026-04-06 21:56:27.332838+00
87	18	2	support the whole body in its healing work	5	2026-04-06 21:56:27.332838+00
88	18	33	support the whole body in its healing work	5	2026-04-06 21:56:27.332838+00
89	18	26	help ease the strain from pain and general worry.	6	2026-04-06 21:56:27.332838+00
90	18	5	will provide surface immune support even if no infection is present.	7	2026-04-06 21:56:27.332838+00
91	18	9	Caution: Bitters and strong cholagogues are contraindicated, because they increase the strength of peristaltic muscular contractions.	8	2026-04-06 21:56:27.332838+00
92	19	41	have a long tradition of use in moving or even dissolving gallstones and easing pain.	1	2026-04-06 21:56:27.332838+00
93	19	19	support the work of the liver and have a positive metabolic effect.	2	2026-04-06 21:56:27.332838+00
94	19	7	relieve colic in the gallbladder or ducts.	3	2026-04-06 21:56:27.332838+00
95	19	26	ease the strain from pain and general worry.	4	2026-04-06 21:56:27.332838+00
96	19	32	must be provided to help the whole body deal with the repercussions of digestive distress and systemic problems.	5	2026-04-06 21:56:27.332838+00
97	19	2	support the whole body in its healing work.	6	2026-04-06 21:56:27.332838+00
98	19	33	support the whole body in its healing work.	7	2026-04-06 21:56:27.332838+00
99	19	5	will help with surface immune support, even if no infection is present.	8	2026-04-06 21:56:27.332838+00
100	19	9	Caution: Bitters and strong cholagogues are contraindicated, because they increase the strength of peristaltic muscular contractions.	9	2026-04-06 21:56:27.332838+00
101	20	42	will help with the muscular tone and general state of well-being of the veins involved.	1	2026-04-06 21:56:27.332838+00
102	20	8	will reduce bleeding, if present, and tighten the tissue locally. However, if they are used internally, take care to avoid constipation.	2	2026-04-06 21:56:27.332838+00
103	20	9	assist digestive and eliminative processes and facilitate bowel motions.	3	2026-04-06 21:56:27.332838+00
104	20	31	ensure easier bowel movements.	4	2026-04-06 21:56:27.332838+00
105	20	43	ensure easier bowel movements.	4	2026-04-06 21:56:27.332838+00
106	20	28	speed local healing of inflamed tissues.	5	2026-04-06 21:56:27.332838+00
107	20	44	soothe irritated tissue if applied externally.	6	2026-04-06 21:56:27.332838+00
108	20	4	soothe inflamed tissues.	7	2026-04-06 21:56:27.332838+00
109	26	9	will safely stimulate normal metabolism	1	2026-04-10 20:56:04.197894+00
110	26	14	Gentle diuretics and hepatics will support elimination	2	2026-04-10 20:56:04.197894+00
111	26	19	Gentle diuretics and hepatics will support elimination	3	2026-04-10 20:56:04.197894+00
112	26	33	Specific tonics will support the tissue affected at the site of infection and the primary sites of symptomatic discomfort	4	2026-04-10 20:56:04.197894+00
113	29	5	that work well in the urinary system are fundamental to treatment success.	1	2026-04-10 20:58:36.064973+00
114	29	33	Prostate tonics are indicated, as for benign prostatic hyperplasia.	2	2026-04-10 20:58:36.064973+00
115	29	14	Diuretics will promote voiding of urine. However, they may be contraindicated if there is marked blockage due to prostate swelling.	3	2026-04-10 20:58:36.064973+00
116	29	13	Demulcents that soothe the urinary system (demulcent diuretics) can help alleviate some of the symptoms.	4	2026-04-10 20:58:36.064973+00
117	30	2	offer the most benefit in the treatment of boils, although I am unable to give a satisfactory explanation of how they work or why!	1	2026-04-10 20:58:36.064973+00
118	30	5	help the body rid itself of the infection. In this case, it is difficult to say whether they work through direct bactericidal effects or indirect stimulation of the immune response.	2	2026-04-10 20:58:36.064973+00
119	30	55	promote the general drainage of fluid.	3	2026-04-10 20:58:36.064973+00
120	30	14	are especially important in supporting the eliminative work of the kidneys.	4	2026-04-10 20:58:36.064973+00
121	30	19	are similarly helpful for the liver.	5	2026-04-10 20:58:36.064973+00
122	30	28	herbs may all be helpful topically.	6	2026-04-10 20:58:36.064973+00
123	30	4	herbs may all be helpful topically.	7	2026-04-10 20:58:36.064973+00
124	30	34	herbs may all be helpful topically.	8	2026-04-10 20:58:36.064973+00
125	30	8	herbs may all be helpful topically.	9	2026-04-10 20:58:36.064973+00
126	55	90	are not crucial if the bronchitis is not a recurrent problem. However, they are clearly indicated for immunocompromised people.	1	2026-04-23 16:06:07.589513+00
127	55	53	are indicated; the choice between stimulating and relaxing expectorants will depend on the individual's needs. Demulcents augment the action of relaxing expectorants, if necessary.	2	2026-04-23 16:06:07.589513+00
128	55	7	can help if coughing is very troublesome.	3	2026-04-23 16:06:07.589513+00
129	55	5	are essential to deal with infection and to help the body defend against the development of secondary infection.	4	2026-04-23 16:06:07.589513+00
130	55	4	may be indicated if there is extensive inflammation, and especially if the larynx or pharynx is involved.	5	2026-04-23 16:06:07.589513+00
131	55	3	improve the upper respiratory symptom picture.	6	2026-04-23 16:06:07.589513+00
132	55	51	are indicated if the patient has a fever.	7	2026-04-23 16:06:07.589513+00
134	57	90	Essential for supporting respiratory function and the health and general tone of the lungs.	1	2026-04-23 16:06:22.109926+00
137	57	13	will soothe any associated irritation.	4	2026-04-23 16:06:22.109926+00
138	57	51	Valuable when fever is an issue, but are not as vital here as in acute bronchitis.	5	2026-04-23 16:06:22.109926+00
139	57	7	can help if coughing or breathlessness is severe.	6	2026-04-23 16:06:22.109926+00
140	57	5	help the body rid itself of any accompanying infection.	7	2026-04-23 16:06:22.109926+00
141	57	10	Essential for supporting cardiac function in the elderly, patients with cardiovascular weakness, or those with long-term chronic bronchitis.	8	2026-04-23 16:06:22.109926+00
142	57	26	and even adaptogen support may be useful in some cases.	9	2026-04-23 16:06:22.109926+00
143	59	90	Important for long-term strengthening of the lungs, but offer little short-term relief for acute attacks.	1	2026-04-23 16:06:39.257018+00
144	59	53	help prevent buildup of sputum in the lungs. However, use only relaxing expectorants, as stimulant expectorants can potentially aggravate breathing difficulties.	2	2026-04-23 16:06:39.257018+00
145	59	13	soothe irritation and support the action of relaxing expectorants.	3	2026-04-23 16:06:39.257018+00
146	59	7	ease spasm responses in the muscles that facilitate respiration.	4	2026-04-23 16:06:39.257018+00
147	59	5	help reduce the potential for secondary in-fection, which should be avoided at all costs.	5	2026-04-23 16:06:39.257018+00
148	59	3	aid the body in dealing with overproduction of sputum in lungs or sinuses.	6	2026-04-23 16:06:39.257018+00
149	59	10	support the heart in the face of lung congestion or strain,	7	2026-04-23 16:06:39.257018+00
150	59	26	support is always appropriate, both because stress is a potential trigger and because asthma can cause stress, which in turn can trigger further attacks.	8	2026-04-23 16:06:39.257018+00
151	60	90	Important for long-term strengthening of the lungs but offer little short-term relief for acute attacks.	1	2026-04-23 16:06:39.257018+00
152	60	53	Essential to minimize the buildup of sputum in the lungs. Stimulant expectorants are necessary here because of the lessening of tone that affects the walls of the alveoli.	2	2026-04-23 16:06:39.257018+00
153	60	13	soothe irritation and support the work of expectorants.	3	2026-04-23 16:06:39.257018+00
154	60	7	ease spasm responses in the muscles that facilitate respiration.	4	2026-04-23 16:06:39.257018+00
155	60	5	help reduce the potential for secondary infection, which should be avoided at all costs.	5	2026-04-23 16:06:39.257018+00
156	60	3	aid the body in dealing with overproduction of sputum in lungs or sinuses.	6	2026-04-23 16:06:39.257018+00
157	60	10	support the heart in the face of lung congestion or strain.	7	2026-04-23 16:06:39.257018+00
158	60	26	support is always appropriate, as stress will exacerbate emphysema.	8	2026-04-23 16:06:39.257018+00
159	62	5	help the immune system combat the viral infection and help prevent secondary infection.	1	2026-04-23 16:06:49.507222+00
161	62	3	ease the symptomatic discomfort so characteristic of this problem. However, avoid trying to dry up mucus overproduction with herbal decongestants.	3	2026-04-23 16:06:49.507222+00
162	62	51	help with feverishness and support the body's efforts to cope with elevated body temperature.	4	2026-04-23 16:06:49.507222+00
163	62	53	help combat the development of secondary problems in the lower respiratory system.	5	2026-04-23 16:06:49.507222+00
164	62	27	indicated if the lymph glands are swollen or there is a known history of such problems	6	2026-04-23 16:06:49.507222+00
165	63	5	support the immune system in combating viral infection and help prevent the development of secondary infection.	1	2026-04-23 16:07:01.735818+00
166	63	51	help with symptoms of fever and support the body's efforts to cope with elevated temperature.	2	2026-04-23 16:07:01.735818+00
167	63	3	ease the symptomatic discomfort so characteristic of this problem. However, avoid trying to dry up mucus overproduction with herbal decongestants.	3	2026-04-23 16:07:01.735818+00
168	63	53	help combat the development of secondary problems in the lower respiratory system.	4	2026-04-23 16:07:01.735818+00
169	63	27	are indicated if the lymph glands are swollen or there is a known history of such problems.	5	2026-04-23 16:07:01.735818+00
170	63	9	support the body in dealing with the debility that often follows severe viral infections.	6	2026-04-23 16:07:01.735818+00
171	63	26	assist the body in dealing with high fever and associated distress.	7	2026-04-23 16:07:01.735818+00
172	65	3	ease the symptomatic discomfort often characteristic of this problem. Again, avoid trying to dry up mucus overproduction with herbal deconges-tants, as this can end up being quite painful.	1	2026-04-23 16:07:11.301036+00
173	65	53	will be needed if wheezing or pulmonary congestion develops. Relaxing expectorants will usually be most relevant.	2	2026-04-23 16:07:11.301036+00
174	65	7	essential if there is any marked difficulty with breathing.	3	2026-04-23 16:07:11.301036+00
175	65	9	help tone the whole body in the face of the immune systems response.	4	2026-04-23 16:07:11.301036+00
176	65	4	soothe various symptoms of inflammation as and when they arise.	5	2026-04-23 16:07:11.301036+00
177	65	8	often ease the symptom picture, as many anti-catarrhals are also astringents.	6	2026-04-23 16:07:11.301036+00
178	65	1	and immune support may help long term. This overall system support should cover the liver, kidney, and any other systems that require support.	7	2026-04-23 16:07:11.301036+00
179	66	5	pivotal in the treatment of this often entrenched condition. These herbs will help the body deal with any infection present, but also support the immune system in resisting the development of secondary infection.	1	2026-04-23 16:07:11.301036+00
180	66	3	ease the symptomatic discomfort characteristic of this problem and assist the body in eliminating buildup in the sinus cavities.	2	2026-04-23 16:07:11.301036+00
181	66	8	often also anticatarrhals, reduce overproduction of mucus.	3	2026-04-23 16:07:11.301036+00
182	66	4	indicated, but most of the herbs with actions already listed here are also anti-inflammatory.	4	2026-04-23 16:07:11.301036+00
183	66	51	will be indicated if feverishness is part of the symptom picture.	5	2026-04-23 16:07:11.301036+00
184	66	167	may be necessary for temporary pain relief.	6	2026-04-23 16:07:11.301036+00
185	66	27	aid the drainage and immune function of this vital system.	7	2026-04-23 16:07:11.301036+00
186	66	169	indicated if overproduction of mucus causes stomach discomfort.	8	2026-04-23 16:07:11.301036+00
187	66	1	and immune support may help long term.	9	2026-04-23 16:07:11.301036+00
188	67	13	will soothe the mucous lining and ease discomfort.	1	2026-04-23 16:07:11.301036+00
189	67	4	will reduce the immediate cause of distress.	2	2026-04-23 16:07:11.301036+00
160	62	40	help the immune system combat the viral infection and help prevent secondary infection.	2	2026-04-23 16:06:49.507222+00
190	67	5	indicated if there is a causal microorganism involved. However, they are not indicated if inflammation is due to some other cause.	3	2026-04-23 16:07:11.301036+00
191	67	8	often effective as a local gargle, especially if the problem was precipitated by overuse of the vocal cords.	4	2026-04-23 16:07:11.301036+00
192	67	9	have a toning and stimulating effect on the mucosal lining.	5	2026-04-23 16:07:11.301036+00
193	68	27	are of primary importance, as this is an infection of lymphatic tissue.	1	2026-04-23 16:07:11.301036+00
194	68	5	help the immune system combat the infection, whatever the causal pathogen might be, and help prevent the development of secondary infection	2	2026-04-23 16:07:11.301036+00
196	68	51	help the body cope with any associated fever.	4	2026-04-23 16:07:11.301036+00
197	68	53	indicated if secondary problems develop in the lower respiratory system.	5	2026-04-23 16:07:11.301036+00
200	71	9	Bitters often bring about dramatic changes in patients' perceptions of themselves and of their lives.	30	2026-04-30 16:30:20.373726+00
201	71	7	Will alleviate muscular tension that might manifest as a bodily expression of psychological depression. Care should be taken not to use strong relaxants.	40	2026-04-30 16:30:20.373726+00
202	71	1	Support the adrenals in coping with the stress that the whole body is experiencing.	50	2026-04-30 16:30:20.373726+00
203	71	19	Indicated to support the liver's detoxification work, especially if the patient has been using prescription psychotropic drugs.	60	2026-04-30 16:30:20.373726+00
204	72	20	Herbs with a reputation for easing a person into sleep. They are usually strong nervine relaxants, rather than "plant knockout drops"!	10	2026-04-30 16:30:20.373726+00
206	72	7	Address any somatic muscular tightness that might be involved.	30	2026-04-30 16:30:20.373726+00
208	72	1	Will help in a way similar to nervine tonics, but should be used only in the morning to help deal with stress, as they might be too energizing at night.	50	2026-04-30 16:30:20.373726+00
212	73	7	Alleviate muscular tension that develops in response to withdrawal.	40	2026-04-30 16:30:34.395192+00
213	73	9	Act as safe metabolic stimulants.	50	2026-04-30 16:30:34.395192+00
214	73	1	Will support the adrenals through the stressful process the body will undergo.	60	2026-04-30 16:30:34.395192+00
215	73	19	May be appropriate to support the detoxification process.	70	2026-04-30 16:30:34.395192+00
216	74	9	Indicated because they stimulate both appetite and general metabolism.	10	2026-04-30 16:30:34.395192+00
219	74	19	Will support the detoxification process and generally benefit the body.	40	2026-04-30 16:30:34.395192+00
222	77	4	Reduce the inflammatory response.	30	2026-04-30 16:30:46.287227+00
223	77	7	Help alleviate any muscular tension developed in response to the discomfort.	40	2026-04-30 16:30:46.287227+00
224	77	1	Support the body's efforts to cope with the stress of the pain and any stress-related causes.	50	2026-04-30 16:30:46.287227+00
227	80	4	Will reduce the inflammatory response.	30	2026-04-30 16:30:46.287227+00
228	80	7	Will alleviate muscular tension developed in response to pain.	40	2026-04-30 16:30:46.287227+00
229	80	5	May help deal with the virus infection, but it is very intransigent.	50	2026-04-30 16:30:46.287227+00
230	82	21	A broad range of remedies with the observed effect of lowering elevated blood pressure. They appear to work in a variety of ways.	10	2026-05-17 19:20:07.593885+00
231	82	10	Play a fundamental role in strengthening and toning the whole cardiovascular system under such literal pressure. They facilitate beneficial changes in both the pattern and the volume of cardiac output.	20	2026-05-17 19:20:07.593885+00
232	82	390	Lessen resistance within the peripheral blood vessels, increasing the total volume of the system and lowering pressure within it.	30	2026-05-17 19:20:07.593885+00
233	82	14	Help reduce the buildup of excess fluid in the body and overcome any decreased renal blood flow that might accompany the hypertension.	40	2026-05-17 19:20:07.593885+00
235	82	26	Address the tension and anxiety associated with any stress component in the patient's picture. Hypertension itself causes increased tension that can be eased with appropriate nervines.	60	2026-05-17 19:20:07.593885+00
236	82	7	Help ease peripheral resistance to blood flow by gently relaxing the muscular coat of the vessels and the muscles the vessels pass through.	70	2026-05-17 19:20:07.593885+00
238	83	10	Help support the tissue of the cardiovascular system, possibly maintaining flexibility and tone in affected vessels.	10	2026-05-17 19:20:07.593885+00
241	83	390	Have obvious value, because they have the potential to lessen the impact of vessel blockage.	40	2026-05-17 19:20:07.593885+00
242	83	21	Indicated to help lower elevated blood pressure.	50	2026-05-17 19:20:07.593885+00
243	83	26	Indicated if stress is an issue.	60	2026-05-17 19:20:07.593885+00
195	68	3	indicated if there is associated sinus congestion or middle ear involvement.	3	2026-04-23 16:07:11.301036+00
340	135	13	will help, as they usually also act as anti-inflammatory agents in this system.	40	2026-06-21 16:44:38.744675+00
244	83	7	Help relax the muscular coat of the arteries, as well as the muscles that the peripheral vessels pass through.	70	2026-05-17 19:20:07.593885+00
245	84	388	Drugs are often the core of treatment. Cardiac glycosides must be prescribed by skilled diagnosticians with regular monitoring of blood levels.	10	2026-05-17 19:20:07.593885+00
246	84	10	Will support the action of cardiac glycosides prescribed. As they may potentiate cardioactives, blood monitoring is still needed.	20	2026-05-17 19:20:07.593885+00
247	84	390	May be indicated to help with general blood circulation.	30	2026-05-17 19:20:07.593885+00
248	84	21	Often appropriate because of associated hypertension.	40	2026-05-17 19:20:07.593885+00
249	84	14	Ease water-retention problems. Replacement of flushed-out potassium is essential.	50	2026-05-17 19:20:07.593885+00
250	84	26	Will ease stress, whether causal or a result of the heart disease.	60	2026-05-17 19:20:07.593885+00
251	86	10	The pathology that manifests in the legs suggests that disease processes are almost certainly affecting the whole cardiovascular system.	10	2026-05-17 19:20:07.593885+00
252	86	390	Facilitate blood flow to the extremities.	20	2026-05-17 19:20:07.593885+00
253	86	21	May help, as there is a close connection between hypertension and the development of this condition.	30	2026-05-17 19:20:07.593885+00
254	86	14	May be appropriate if edema is present; however, edema calls for careful examination of the heart.	40	2026-05-17 19:20:07.593885+00
256	86	26	May be indicated depending upon the individual's needs.	60	2026-05-17 19:20:07.593885+00
257	86	7	May help ease the degree of muscular spasm.	70	2026-05-17 19:20:07.593885+00
260	87	8	Can support the work of the vascular tonics. The astringency is best applied externally.	30	2026-05-17 19:20:07.593885+00
261	87	4	Ease localized inflammation and discomfort.	40	2026-05-17 19:20:07.593885+00
262	87	44	Used externally, lessen local discomfort.	50	2026-05-17 19:20:07.593885+00
263	87	13	Used externally, lessen local discomfort.	60	2026-05-17 19:20:07.593885+00
237	82	29	Help increase peripheral circulation.	80	2026-05-17 19:20:07.593885+00
240	83	29	Promote the circulation of blood and oxygen availability in the face of increased vascular resistance characteristic of this condition.	30	2026-05-17 19:20:07.593885+00
259	87	29	Assist in the process of venous return to the trunk of the body.	20	2026-05-17 19:20:07.593885+00
199	71	23	May be indicated in the short term, or if the depression has an agitated or hyperactive aspect. These should not be strong herbs, which could trigger a more entrenched depression.	20	2026-04-30 16:30:20.373726+00
205	72	23	Ease the tensions that often produce sleeplessness.	20	2026-04-30 16:30:20.373726+00
210	73	23	Will fulfill the tranquilizing role of the drug in the short term.	20	2026-04-30 16:30:34.395192+00
218	74	23	Will alleviate associated anxiety.	30	2026-04-30 16:30:34.395192+00
221	77	23	Ease associated pain and anxiety.	20	2026-04-30 16:30:46.287227+00
226	80	23	May help ease the associated pain and will definitely lessen associated anxiety or tension.	20	2026-04-30 16:30:46.287227+00
211	73	24	May be indicated in some cases, due to the long-term slowing of mind and body that results from use of these drugs in some people.	30	2026-04-30 16:30:34.395192+00
198	71	22	Fundamental to any long-term change in the individual's ability to cope and transform what must be changed.	10	2026-04-30 16:30:20.373726+00
207	72	22	Indicated if there is any suspicion that insomnia is related to nervous exhaustion (as it often is).	40	2026-04-30 16:30:20.373726+00
209	73	22	Fundamental to any long-term change in the individual's ability to cope with life and transform what must be changed.	10	2026-04-30 16:30:34.395192+00
217	74	22	Fundamental to any long-term change in the individual's ability to cope with life and transform what must be changed.	20	2026-04-30 16:30:34.395192+00
220	77	22	Important to nourish the traumatized nerve tissue.	10	2026-04-30 16:30:46.287227+00
225	80	22	Will nourish traumatized nerve tissue.	10	2026-04-30 16:30:46.287227+00
234	82	42	Help nourish and tone the tissue of the arteries and veins.	50	2026-05-17 19:20:07.593885+00
239	83	42	Help support the tissue of the cardiovascular system, possibly maintaining flexibility and tone in affected vessels.	20	2026-05-17 19:20:07.593885+00
255	86	42	Essential to tone and strengthen the blood vessels.	50	2026-05-17 19:20:07.593885+00
258	87	42	Help the tissues regain tone and strength. Flavonoid-rich herbs are especially useful here, although they do not work quickly.	10	2026-05-17 19:20:07.593885+00
272	90	15	Are the classic treatment, as they can trigger the menstrual process.	10	2026-06-07 19:28:17.415064+00
273	90	510	Will help the body regulate levels of various hormones.	20	2026-06-07 19:28:17.415064+00
274	90	509	Will contribute their nourishing, toning power.	30	2026-06-07 19:28:17.415064+00
275	91	7	Ease the muscle spasms that are the immediate cause of pain.	10	2026-06-07 19:28:17.415064+00
276	91	26	Will help associated psychological tension or anxiety.	20	2026-06-07 19:28:17.415064+00
277	91	14	Are indicated if dysmenorrhea is of a congestive nature, accompanied by water retention.	30	2026-06-07 19:28:17.415064+00
278	91	509	Provide the basis for any healing work in this body system.	40	2026-06-07 19:28:17.415064+00
279	91	510	Are indicated if the diagnosis suggests that hormonal imbalance is making a pivotal contribution.	50	2026-06-07 19:28:17.415064+00
280	92	26	Usually alleviate symptoms, but rarely clear the recurrent pattern.	10	2026-06-07 19:28:17.415064+00
281	92	7	Ease any accompanying dysmenorrhea.	20	2026-06-07 19:28:17.415064+00
282	92	14	Indicated if water retention is part of the picture.	30	2026-06-07 19:28:17.415064+00
283	92	510	Indicated if the diagnosis suggests that hormonal imbalance is making a pivotal contribution to PMS.	40	2026-06-07 19:28:17.415064+00
284	93	510	Will help the body's endocrine control mechanisms balance activity in the face of the menopausal changes.	10	2026-06-07 19:28:17.415064+00
285	93	509	Help the various organs and tissues involved move through the changes with minimal trauma.	20	2026-06-07 19:28:17.415064+00
286	93	524	Indicated for the anxiety and tension that often accompany menopausal changes. The nervines will ideally also be tonics.	30	2026-06-07 19:28:17.415064+00
287	93	36	Will be needed if the woman experiences depression.	40	2026-06-07 19:28:17.415064+00
288	93	9	Help in a generalized way as stimulants. These may be taken as part of the diet.	50	2026-06-07 19:28:17.415064+00
289	96	590	Important, as they will calm the vomit reflex, no matter what the cause of morning sickness.	10	2026-06-07 19:28:17.415064+00
290	114	509	Support the general health and vitality of the uterus.	10	2026-06-07 19:28:17.415064+00
291	114	511	Reduce blood loss.	20	2026-06-07 19:28:17.415064+00
292	114	2	Often help in health problems associated with benign growths.	30	2026-06-07 19:28:17.415064+00
293	114	7	Will lessen cramping pains.	40	2026-06-07 19:28:17.415064+00
294	114	27	Support the drainage of fluid from the womb.	50	2026-06-07 19:28:17.415064+00
295	114	596	May be appropriate.	60	2026-06-07 19:28:17.415064+00
296	115	510	Such as Vitex, appear to help the body alter underlying hormonal problems.	10	2026-06-07 19:28:17.415064+00
297	115	509	Essential for their tonic actions on endometrial tissue. In theory, this will help wherever such tissue is.	20	2026-06-07 19:28:17.415064+00
298	115	7	Ease the muscular, cramping pain that is so distressing in this condition.	30	2026-06-07 19:28:17.415064+00
299	115	524	Help with stress and pain.	40	2026-06-07 19:28:17.415064+00
300	116	510	Help the body balance hormones and regularize swings, enabling a move toward complete alleviation of the problem.	10	2026-06-07 19:28:17.415064+00
301	116	27	Assist with drainage and the general vitality of the lymphatic tissue in the breast.	20	2026-06-07 19:28:17.415064+00
302	116	7	May help if there are excessive dragging pains.	30	2026-06-07 19:28:17.415064+00
303	116	524	Are indicated if the problem is associated with PMS.	40	2026-06-07 19:28:17.415064+00
304	116	14	Help if there is associated water retention, but should not be used alone.	50	2026-06-07 19:28:17.415064+00
305	117	73	Inhibit 5-alpha reductase to reduce conversion of testosterone to DHT, addressing the underlying driver of prostatic enlargement.	10	2026-06-08 15:00:58.883045+00
306	117	4	Reduce inflammation and congestion of the prostate gland.	20	2026-06-08 15:00:58.883045+00
307	117	13	Soothe and protect the inflamed urinary mucosa from irritation caused by obstructed flow.	30	2026-06-08 15:00:58.883045+00
308	117	8	Tone the urinary tract tissues and reduce congestion.	40	2026-06-08 15:00:58.883045+00
309	117	2	Support systemic detoxification and hormonal balance.	50	2026-06-08 15:00:58.883045+00
321	130	5	will help the body rid itself of any pathogens present, thus reducing inflammation and its resulting symptoms.	10	2026-06-21 16:44:38.744675+00
322	130	4	soothe inflamed tissue and thus reduce the irritation of local muscle spasm.	20	2026-06-21 16:44:38.744675+00
323	130	14	will often help, simply because they usually will also have either antimicrobial or anti-inflammatory effects. Diuretics rich in volatile oils, such as Juniperus communis (juniper berry), may be contraindicated in severe cases, as it can be irritating to the nephrons.	30	2026-06-21 16:44:38.744675+00
324	131	4	will usually help ease the pain by reducing inflammation.	10	2026-06-21 16:44:38.744675+00
325	131	7	soothe muscle spasms that often accompany such urinary tract problems.	20	2026-06-21 16:44:38.744675+00
326	131	5	help the body rid itself of any pathogens, further reducing inflammation and associated symptoms.	30	2026-06-21 16:44:38.744675+00
327	132	8	will stanch bleeding. They may not always be powerful enough — for example, in cases of bleeding caused by large kidney stones.	10	2026-06-21 16:44:38.744675+00
328	132	4	will soothe inflamed tissue, thus lessening bleeding.	20	2026-06-21 16:44:38.744675+00
329	132	5	will help the body rid itself of any pathogens present, thus reducing inflammation and resultant bleeding.	30	2026-06-21 16:44:38.744675+00
330	132	14	A number of diuretic plants have an astringent effect.	40	2026-06-21 16:44:38.744675+00
331	133	14	of course, the primary herbs to consider. The broader picture that the patient presents will suggest the appropriate treatment.	10	2026-06-21 16:44:38.744675+00
332	134	5	help the body control and then clear bacterial infection.	10	2026-06-21 16:44:38.744675+00
333	134	4	soothe the pain and discomfort, but avoid overemphasizing them in the prescription. The symptomatic relief they produce must be applied in the context of removing the infection that causes the inflammation.	20	2026-06-21 16:44:38.744675+00
334	134	8	may be indicated if there is any hematuria.	30	2026-06-21 16:44:38.744675+00
335	134	14	help flush the whole of the tract. Of course, it is best to select diuretics that possess antimicrobial and anti-inflammatory actions.	40	2026-06-21 16:44:38.744675+00
336	134	7	may be necessary if there is much pain.	50	2026-06-21 16:44:38.744675+00
337	135	41	remedies are the core of any treatment of renal calculus.	10	2026-06-21 16:44:38.744675+00
338	135	4	indicated to lessen the inflammation caused by the passage of hard material along the delicate tissue of this system. Such remedies will decrease the pain and discomfort to some extent.	20	2026-06-21 16:44:38.744675+00
339	135	7	are essential to help reduce muscular spasms along the urinary tract as peristalsis moves the stone. Unfortunately, legal plant antispasmodics are not strong enough to deal with acute problems of this nature.	30	2026-06-21 16:44:38.744675+00
341	136	2	are the classic remedies for the treatment of eczema. How they work is unclear, but they can often be dramatically effective.	10	2026-06-21 16:54:56.148727+00
342	136	34	remedies that reduce the sensation of itching, are indicated, not simply to make the patient feel better, but also to reduce physical trauma caused by scratching.	20	2026-06-21 16:54:56.148727+00
343	136	4	applied topically and taken internally speed the curative work of the alteratives, but do not replace them.	30	2026-06-21 16:54:56.148727+00
344	136	55	which may be considered a type of alterative, are especially helpful for eczema in children.	40	2026-06-21 16:54:56.148727+00
345	136	524	help with the commonly associated problem of anxiety. They also often ease itching and even inflammation in the skin because of their relaxing effect on the peripheral nerves of the autonomic nervous system.	50	2026-06-21 16:54:56.148727+00
346	136	14	ensure adequate elimination through the kidneys. Diuretic alteratives are most relevant.	60	2026-06-21 16:54:56.148727+00
347	136	19	will contribute support for liver function and the digestive process. Hepatic alteratives are best here.	70	2026-06-21 16:54:56.148727+00
348	136	28	support the healing of skin lesions when applied topically, but do not replace appropriate internal treatment.	80	2026-06-21 16:54:56.148727+00
349	136	8	used topically, reduce any weeping or oozing of fluids.	90	2026-06-21 16:54:56.148727+00
350	136	44	suitable for topical applications where soothing is needed. The demarcation among emollient, anti-inflammatory, and antipruritic herbs is rather meaningless here.	100	2026-06-21 16:54:56.148727+00
351	137	2	are important, as they are for all internally generated skin problems. In practice, the rooty hepatic alteratives often are the best choice.	10	2026-06-21 16:54:56.148727+00
352	137	4	applied topically and taken internally, will speed the curative work of the alteratives, but not replace them. They are most helpful during flare-ups and exacerbations.	20	2026-06-21 16:54:56.148727+00
353	137	55	improve the health of the internal environment.	30	2026-06-21 16:54:56.148727+00
354	137	524	ease the anxiety that often accompanies psoriasis. They will also soothe skin discomfort, including itching and even inflammation, due to their relaxing effects on the peripheral nerves of the autonomic nervous system.	40	2026-06-21 16:54:56.148727+00
355	137	14	ensure adequate elimination via the kidneys.	50	2026-06-21 16:54:56.148727+00
356	137	19	support liver function and the digestive process.	60	2026-06-21 16:54:56.148727+00
357	137	28	support the healing of skin lesions when applied topically, but are not as effective here as one might hope. Remember, there is no wound to heal.	70	2026-06-21 16:54:56.148727+00
358	137	8	used topically, may help in reducing redness, heat, and itching through local vasoconstrictor effects.	80	2026-06-21 16:54:56.148727+00
359	137	44	assist in the process of scale removal.	90	2026-06-21 16:54:56.148727+00
360	137	34	used topically may help, but itching is not a major factor in psoriasis.	100	2026-06-21 16:54:56.148727+00
361	137	51	have been suggested as a means of increasing circulation in the skin, thus promoting elimination and, in theory, general skin health. Diaphoretics may also aggravate psoriasis in some people.	110	2026-06-21 16:54:56.148727+00
362	138	2	are the core of any treatment. Hepatic alteratives are especially helpful.	10	2026-06-21 16:54:56.148727+00
363	138	510	are indicated because of the androgen involvement. However, impacting these hormones in an appropriate way is not always a straightforward matter.	20	2026-06-21 16:54:56.148727+00
364	138	5	help the body deal with secondary infection. They may be used both internally and topically.	30	2026-06-21 16:54:56.148727+00
365	138	55	support lymphatic drainage from the skin and underlying tissues.	40	2026-06-21 16:54:56.148727+00
366	138	19	are vital, partly for the generalized benefit imparted by their liver-toning effects, but also because they have a specific role in detoxification.	50	2026-06-21 16:54:56.148727+00
367	138	14	important in ensuring adequate elimination through the kidneys.	60	2026-06-21 16:54:56.148727+00
368	138	4	can be helpful when used topically within the context of daily hygiene.	70	2026-06-21 16:54:56.148727+00
369	138	8	used topically, help in cleansing and avoiding secondary infection.	80	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: disorder_notes; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.disorder_notes (id, disorder_id, note_text, sort_order, created_at) FROM stdin;
1	9	Functional dyspepsia, often referred to as "indigestion," is a vague and variable problem that is functional in nature but usually not caused by underlying structural issues.	1	2026-04-06 21:33:58.34407+00
2	9	Specific remedies are often bitter carminatives or nervine carminatives.	2	2026-04-06 21:33:58.34407+00
3	9	Often, the traditional simple (tea made from a single fresh remedy) is the best treatment.	3	2026-04-06 21:33:58.34407+00
4	9	Indigestion may be disease-related, but for the most part, it results from eating too much or too quickly, eating high-fat foods, or eating during stressful situations. Smoking, alcohol, medications that irritate the stomach lining, fatigue, and ongoing stress can also aggravate or cause indigestion.	4	2026-04-06 21:33:58.34407+00
5	9	Exercising with a full stomach may also cause indigestion,	5	2026-04-06 21:33:58.34407+00
6	10	Irritable bowel syndrome (IBS) is a common disorder characterized by cramping pain, gassiness, bloating, and changes in bowel habits. Symptoms can include constipation or diarrhea, or may alternate between constipation and diarrhea.	1	2026-04-06 21:56:12.487259+00
7	10	While stress, anxiety, and other psychological issues are often pivotal, they are but components in a multifactorial matrix. Another factor to consider is intolerance to such common foods as wheat, corn, dairy products, coffee, tea, and citrus fruit.	2	2026-04-06 21:56:12.487259+00
8	10	Occasionally, infectious or parasitic organisms are involved	3	2026-04-06 21:56:12.487259+00
9	10	Stress-reduction training or counseling and support can help relieve IBS symptoms.	4	2026-04-06 21:56:12.487259+00
10	10	The intensity is often related to the number of calories and the amount of fat in the meal. Fat, whether animal or vegetable, is a strong stimulus for colonic contractions.	5	2026-04-06 21:56:12.487259+00
11	11	Inflammatory bowel disease (IBD) refers to two chronic intestinal disorders: Crohn's disease and ulcerative colitis	1	2026-04-06 21:56:12.487259+00
12	12	A diverticulum is a small, saclike pouch or hernation of the colonic mucosa that bulges outward through a weak spot in the colon wall; these are collectively known as di-verticula. About half of all Americans aged 60 to 80 and almost everyone over the age of 80 has diverticulosis, or the condition characterized by the presence of diverticula.	1	2026-04-06 21:56:12.487259+00
13	12	When diverticula become inflamed, the disorder is called diverticulitis. This happens in 10% to 25% of people with diverticulosis.	2	2026-04-06 21:56:12.487259+00
14	12	Pain and tenderness associated with constipation that alternates with diarrhea.	3	2026-04-06 21:56:12.487259+00
15	12	Diverticulitis is common in industrialized countries where low-fiber diets are the norm, but rare in countries where people eat high-fiber diets rich in vegetables.	4	2026-04-06 21:56:12.487259+00
16	12	Straining due to constipation increases pressure in the colon, which causes weak spots to bulge out and become diverticula.	5	2026-04-06 21:56:12.487259+00
17	15	The term hepatitis embraces a number of specific syndromes with a range of causes and prognoses. They all share a core pathology of an inflammatory response in liver cells (hepatocytes) that can lead to cellular necrosis.	1	2026-04-06 21:56:27.332838+00
18	15	In chronic hepatitis, the necrosis and inflammation lasts longer than six months to a year.	2	2026-04-06 21:56:27.332838+00
19	17	The condition is characterized by widespread death of liver cells, accompanied by progressive fibrosis and distortion of liver architecture. This can be due to many causes, but in the United States and Europe is most commonly related to alcohol abuse.	1	2026-04-06 21:56:27.332838+00
20	18	Cholecystitis, or gallbladder inflammation, is characterized by severe pain that becomes localized in the upper right quadrant of the abdomen, radiating to the right lower shoulder blade. Nausea and vomiting are common symptoms. Cholecystitis may be associated with gallstones, but the stones constitute a separate condition.	1	2026-04-06 21:56:27.332838+00
21	18	Even though people can tolerate the absence of the gallbladder, a healthy gallbladder helps ensure efficient digestion, which directly decreases the risks of developing arte-riosclerosis, irritable bowel syndrome, hypertension, heart disease, stroke, and other major diseases.	2	2026-04-06 21:56:27.332838+00
22	18	Diet and stress management are critical. Strong chemical pain relief may be indicated for severe cases.	3	2026-04-06 21:56:27.332838+00
23	19	Gallstones appear to be caused by a combination of factors, including inherited body chemistry, body weight, gallbladder movement, and diet.	1	2026-04-06 21:56:27.332838+00
24	19	Diet and stress management are critical. Strong chemical pain relief may be indicated for severe cases.	2	2026-04-06 21:56:27.332838+00
25	20	Hemorrhoids are caused by increased pressure in the veins of the anus.	1	2026-04-06 21:56:27.332838+00
26	20	Avoidance or elimination of constipation is often the key to alleviating hemorrhoids.	2	2026-04-06 21:56:27.332838+00
27	21	Herbal medicine is as limited as orthodox medicine if it is used only to affect T- and B-lymphocyte function, without the benefit of a broader holistic context.	1	2026-04-10 20:55:36.403551+00
28	21	Human immunity is ecology in action. In other words, there is a multifactorial relationship at play between individuals and their environment.	2	2026-04-10 20:55:36.403551+00
29	21	Immunity represents an ecological interface between inner and outer environments.	3	2026-04-10 20:55:36.403551+00
30	21	In human ecology, the immune system is governed by a complex of processes that allow resistance and embrace at the same time. To focus on only one side of this profound interaction is to miss the point and compromise understanding of the whole.	4	2026-04-10 20:55:36.403551+00
31	21	Immunity is an expression of homeostasis. We now know that in the presence of stress, a large and complex array of mechanical, chemical, and immune changes take place, as the body attempts to defend itself or restore homeostasis.	5	2026-04-10 20:55:36.403551+00
32	21	The term psychoneuroimmunology comes from our growing understanding of these mind-body connections. Psycho denotes thinking, emotions, and mood states; neuro implies involvement of the neurological and neuroendocrine systems; and immunology refers to cellular structures and the immune system.	6	2026-04-10 20:55:36.403551+00
33	21	Consider, for example, the commonly held belief in the Western herbal community that Panax ginseng is for men and Angelica sinensis (dong quai) is for women. This is simply not the case. Panax is the strongest yang tonic, while A. sinensis is the most yielding yin tonic. This leads to entirely different therapeutic implications.	7	2026-04-10 20:55:36.403551+00
34	21	It is too easy to discard the insights of traditional approaches in favor of research published in peer-reviewed journals. This is imprudent, because important insights may be gained when one takes into account the herbal wisdom garnered through generations of experience.	8	2026-04-10 20:55:36.403551+00
35	21	Herbal medicine is ecological medicine; it is based on an ecological relationship that has evolved through geological time.	9	2026-04-10 20:55:36.403551+00
69	52	Ozone irritates the respiratory tract and eyes, and exposure to high levels results in chest tightness, coughing, and wheezing.	11	2026-04-23 16:05:55.110389+00
36	21	In both the laboratory and the clinic, a growing number of herbal remedies have been shown to have marked effects upon the immune system. Some stimulate immune system responses, but most can best be described as modulators. That is, these remedies facilitate greater immune system flexibility in the body's natural response to disease.	10	2026-04-10 20:55:36.403551+00
37	21	Nonspecific immunostimulants do not affect immune system memory cells, and because their pharmacological effects fade relatively quickly, they must be administered either at intervals or continuously.	11	2026-04-10 20:55:36.403551+00
38	21	The protective immunity conferred by immunostimulants happens quickly and has been termed paramunity.	12	2026-04-10 20:55:36.403551+00
39	21	Immunomodulation and immunoregulation are terms that have been proposed to denote any effect on immune system responsiveness. For example, herbs may also stimulate T-suppressor cells and thereby reduce immune resistance.	13	2026-04-10 20:55:36.403551+00
40	21	Immunoadjuvants are substances that enhance the production of antibodies without acting as antigens themselves. The effects of adjuvants are often thymus-dependent.	14	2026-04-10 20:55:36.403551+00
41	21	Herbalist Christopher Hobbs identifies three relevant levels of herbal activity: • Deep immune activation • Surface immune activation • Adaptogenic action or hormonal modulation	15	2026-04-10 20:55:36.403551+00
42	21	Autoimmune diseases are conditions in which lymphocytes produce antibodies that attack the body's own cells and tissues as if they were foreign substances, thus causing pathological damage.	16	2026-04-10 20:55:36.403551+00
43	21	Conditions thought to have an autoimmune basis include rheumatoid arthritis, polyarthritis, chronic active hepatitis, multiple sclerosis, and psoriasis.	17	2026-04-10 20:55:36.403551+00
44	21	The real question involves knowing when to use immunostimulant herbs and, even more important, when not to. Stimulating immune system activity may be inappropriate in some conditions and vital in others.	18	2026-04-10 20:55:36.403551+00
45	21	In general, it seems safe to say that immunostimulant plants should be avoided in conditions that involve inappropriate activity of some aspect of the immune complex. In autoimmune conditions, for example, any stimulation might increase the production or pathological impact of antibodies.	19	2026-04-10 20:55:36.403551+00
46	22	Autoimmune diseases are conditions in which lymphocytes produce antibodies that attack the body's own cells and tissues as if they were foreign substances, thus causing pathological damage.	1	2026-04-10 20:55:36.403551+00
47	22	Conditions thought to have an autoimmune basis include rheumatoid arthritis, polyarthritis, chronic active hepatitis, multiple sclerosis, and psoriasis.	2	2026-04-10 20:55:36.403551+00
48	22	The real question involves knowing when to use immunostimulant herbs and, even more important, when not to. Stimulating immune system activity may be inappropriate in some conditions and vital in others.	3	2026-04-10 20:55:36.403551+00
49	22	In general, it seems safe to say that immunostimulant plants should be avoided in conditions that involve inappropriate activity of some aspect of the immune complex. In autoimmune conditions, for example, any stimulation might increase the production or pathological impact of antibodies.	4	2026-04-10 20:55:36.403551+00
50	24	To support the body system that is the focus of the surgical procedure, choose relevant tonic remedies	1	2026-04-10 20:55:49.407997+00
51	24	Consider Urtica for skin and membranes, Crataegus and Ginkgo for blood vessels, and Hypericum for nerves.	2	2026-04-10 20:55:49.407997+00
52	26	Once a course of antibiotics has been completed, herbs may be used to speed convalescence.	1	2026-04-10 20:56:04.197894+00
53	26	The focus here should be on general nutrition, as well as herbal tonics.	2	2026-04-10 20:56:04.197894+00
54	26	Immune Support: This is important, and may entail both deep and surface work. Focus on deep immune support if: • The infection is a chronic or recurrent problem • The patient is very debilitated after the infection • The patient is elderly • The patient is under much stress of any kind, and thus at risk of becoming immunocompromised	3	2026-04-10 20:56:04.197894+00
55	28	A range of antimicrobials are uniquely suited to treating this part of the body. They are usually herbs rich in essential oils.	1	2026-04-10 20:56:04.197894+00
56	30	Also known as furuncles, are infections that manifest as localized abscesses starting in the hair follicles.	1	2026-04-10 20:58:36.064973+00
57	30	When deeper furuncles form and coalesce, the term carbuncle applies. A carbuncle may drain at several openings in the same region. The shoulders, face, scalp, buttocks, and armpits are common sites for carbuncles.	2	2026-04-10 20:58:36.064973+00
58	30	The stronger hepatic alteratives are often considered specifics. Their strength highlights the need to take care with dosage. Important examples of hepatic alteratives are listed here. In addition, Echinacea is strongly indicated.	3	2026-04-10 20:58:36.064973+00
59	52	The lungs sit within the thoracic cage, where they stretch from the trachea (commonly called the windpipe) to below the heart.	1	2026-04-23 16:05:55.110389+00
60	52	About 10% of the lung is solid tissue and the rest is filled with air and blood.	2	2026-04-23 16:05:55.110389+00
61	52	The lungs' main function is to rapidly exchange oxygen from inhaled air with carbon dioxide from the blood	3	2026-04-23 16:05:55.110389+00
62	52	The two main bronchi extend from the trachea into each lung, where they divide into smaller bronchi, and then a great number of smaller bronchioles. The bronchioles divide into a network of about 3 million alveolar ducts containing alveoli, commonly called air sacs.	4	2026-04-23 16:05:55.110389+00
63	52	Specific nerve sites located in the brain and the neck, called respi vatory centers, coordinate the performance of the ventila-tory apparatus. The respiratory centers respond to changes in oxygen, carbon dioxide, and acid levels in the blood.	5	2026-04-23 16:05:55.110389+00
64	52	Gas exchange between inhaled air and blood takes place in the alveoli. A very thin membrane separates the blood from the air in the alveoli and allows oxygen and nitrogen to diffuse into the blood. This barrier is 50 times thinner than a sheet of tissue paper, but a large surface area (80 square meters, or about as large as a tennis court) is available for gas exchange. In the resting state, it takes just about a minute for the total blood volume of the body to pass through the lungs. It takes a red cell a fraction of a second to pass through the capillary network. Gas exchange occurs almost instantaneously during this short time period	6	2026-04-23 16:05:55.110389+00
65	52	We are not only what we eat, but also what we breathe.	7	2026-04-23 16:05:55.110389+00
66	52	Many pathological tissue changes can be prevented if the environmental milieu of the cells is constantly rich in oxygen.	8	2026-04-23 16:05:55.110389+00
67	52	Air pollution in the country may be caused by dust from tractors plowing fields, trucks and cars driving on dirt or gravel roads, and rock quarries, as well as by smoke from wood and crop fires.	9	2026-04-23 16:05:55.110389+00
68	52	Ground-level ozone is created when engine and fuel gases that have already been released into the air interact in the presence of sunlight.	10	2026-04-23 16:05:55.110389+00
70	52	For every eight smokers, one nonsmoker dies from the effects of secondhand smoke.	12	2026-04-23 16:05:55.110389+00
71	52	Smoking is responsible for 32% of deaths due to cancer.	13	2026-04-23 16:05:55.110389+00
72	52	Smoking causes nearly 90% of all lung and throat cancers.	14	2026-04-23 16:05:55.110389+00
73	52	Alcohol is also a risk factor for some cancers, and the combination of alcohol and smoking greatly increases cancer risk.	15	2026-04-23 16:05:55.110389+00
74	52	Smoking decreases the strength of the sphincter muscle between the throat and stomach, which allows stomach contents to reflux, or flow backward, into the esophagus.	16	2026-04-23 16:05:55.110389+00
75	52	Smoking seems to affect the liver, too, by changing the way it handles drugs and alcohol.	17	2026-04-23 16:05:55.110389+00
76	52	Peptic ulcer disease is more likely to occur in smokers than in nonsmokers, and ulcers heal less readily and are more likely to recur in smokers.	18	2026-04-23 16:05:55.110389+00
77	52	Smoking has a direct effect on the growth of the fetus.	19	2026-04-23 16:05:55.110389+00
78	52	Natural menopause occurs earlier in smokers than in nonsmokers by one to two years.	20	2026-04-23 16:05:55.110389+00
79	52	Cigarettes and oral contraceptives are a dangerous combination that increases the risk of heart attacks, strokes, and other vascular complications.	21	2026-04-23 16:05:55.110389+00
80	52	A decrease of blood flow in the small vessels of the skin that may damage skin components, leading to skin wrinkling and an appearance of premature aging.	22	2026-04-23 16:05:55.110389+00
81	52	The respiratory zone, the actual site of gas exchange, is composed of the respiratory bronchioles, alveolar ducts, and alveoli. The conducting zone, sometimes called the dead air space, includes all other respiratory passageways, which serve as fairly rigid conduits to allow air to reach the gas exchange sites. The conducting zone organs also purify, humidify, and warm the incoming air.	23	2026-04-23 16:05:55.110389+00
82	52	The lower respiratory system consists of the respiratory zone, the alveoli, and respiratory bronchioles. The air-conducting bronchi and trachea are anatomically part of this system. The upper respiratory system consists of the conducting zone, made up of the nose, sinuses, pharynx, and larynx.	24	2026-04-23 16:05:55.110389+00
83	52	Expectorants are herbs that facilitate or accelerate the removal of bronchial secretions from the bronchi and trachea.	25	2026-04-23 16:05:55.110389+00
84	52	Stimulating Expectorants: For any given stimulating expectorant, either or both of the following mechanisms may be at play. Irritation of the bronchioles stimulates the expulsion of any material present. Liquefaction of viscid sputum encourages clearing by coughing.	26	2026-04-23 16:05:55.110389+00
85	52	The particular form of stimulation offered by this group of expectorants makes them relevant for productive coughs, in which sputum should be removed from the airways.	27	2026-04-23 16:05:55.110389+00
86	52	Relaxing expectorants may also act by reflex, but here the herbs work to soothe bronchial spasm and loosen mucous secretions.	28	2026-04-23 16:05:55.110389+00
87	52	They facilitate the production of a less viscous mucous secretion, which helps lift up stickier material from below. This makes relaxing expectorants useful for dry, irritating coughs. You will notice that this action is similar in some respects to that of demulcents, and both actions owe a lot to their content of mucilage and occasionally volatile oils.	29	2026-04-23 16:05:55.110389+00
88	52	Herbs known as pulmonaries, or amphoteric expectorants, have a beneficial effect upon both lung tissue and function.	30	2026-04-23 16:05:55.110389+00
89	52	We can generalize here that Inula has stimulant expectorant effects and Verbascum is more of a relaxing expectorant. Tussilago is the best of the three for children.	31	2026-04-23 16:05:55.110389+00
90	52	To avoid any potential toxicity problems, leaf and flower formulations of Tussilago should not be taken for more than one consecutive month, and root products should not be used internally.	32	2026-04-23 16:05:55.110389+00
91	52	Dyspnea, defined as an unpleasant sensation of difficulty in breathing.	33	2026-04-23 16:05:55.110389+00
92	53	For treating coughs, always select the appropriate approach for the individual's unique case. The key to treatment is achieving a correct balance among the various stimulating, demul-cent, antimicrobial, and antitussive herbs available. Treat the person and his or her experience, not just the cough.	1	2026-04-23 16:05:55.110389+00
93	53	Coughing is a reflex response that represents an attempt by the body to clear the airways. Usually, blockages are caused by mucus secreted by membranes lining the respiratory tract. These mucous secretions help to protect the respiratory tract from all kinds of irritants by trapping and flushing out smoke particles, bacteria, and viruses. Any cough that lasts more than a few days, does not respond to treatment, or produces blood should be investigated further, as it may be a sign of serious organic disease.	2	2026-04-23 16:05:55.110389+00
94	53	Cough may be related to gastroesophageal reflux disease (GERD). In this condition, acid reflux from the stomach backs up into the throat, causing either heartburn or cough.	3	2026-04-23 16:05:55.110389+00
95	53	Treatment: Acute inflammatory conditions of the respiratory system are primarily treated with mucilage-rich demulcents, which soothe inflamed tissue. It is difficult to explain the mechanism at play here, as the mucopolysaccharide molecules in demulcent herbs do not enter the bloodstream and thus cannot be directly active in the respiratory tissue.	4	2026-04-23 16:05:55.110389+00
96	53	Stimulant, saponin-containing expectorants are best used for subacute or chronic bronchitis, for which active expectoration is indicated.	5	2026-04-23 16:05:55.110389+00
97	54	Bronchitis is either an acute or a chronic inflammation of the mucous lining of the bronchial tubes, the main airways that carry air from the trachea to the lungs.	1	2026-04-23 16:06:07.589513+00
98	54	When the cells of the bronchial lining tissue are irritated bevond a certain point, cilia that normally trap and eliminate pollutants stop functioning.	2	2026-04-23 16:06:07.589513+00
99	54	Bronchitis makes breathing difficult and sometimes even painful. Pain may be related to the swelling of the mucous membrane in the trachea. Other common sions of bronchitis are persistent coughing, aching associated with fever, and mucus secretions. The patient will feel very fatigued due to the fact that the body is receiving less oxygen than it needs.	3	2026-04-23 16:06:07.589513+00
100	55	Acute bronchitis usually originates with a viral infection of the upper respiratory tract, such as a cold or sore throat, that can become a secondary bacterial infection and spread to the lungs.	1	2026-04-23 16:06:07.589513+00
101	55	It usually lasts about a week and is accompanied by a cough that produces thick green or yellow mucus.	2	2026-04-23 16:06:07.589513+00
102	55	It may be accompanied by fever that lasts a few days, but persistent fever suggests the development of a pneumonia complication.	3	2026-04-23 16:06:07.589513+00
103	55	The cough of acute bronchitis may last for several weeks or even months, a reflection of the amount of time it takes for the bronchial lining to heal.	4	2026-04-23 16:06:07.589513+00
104	55	Acute bronchitis can be confused with asthma.	5	2026-04-23 16:06:07.589513+00
105	55	Acute bronchitis most commonly develops as a complication of a cold in a healthy person.	6	2026-04-23 16:06:07.589513+00
106	55	Congestive mucus should be coughed up, so avoid the use of cough suppressants. The use of soothing, relaxing expectorants in combination with antimicrobials is often the key to successful treatment. Particularly important relaxing expectorants are Tussilago, Verbascum, Plantago, Cetraria, Trigonella, Althaea, and Pulmonaria.	7	2026-04-23 16:06:07.589513+00
107	55	Specific Remedies: Osha (Ligusticum porteri), a plant of the American Southwest, is an excellent specific for cases of tracheobronchitis. The specifics listed here cover a range of expectorant, antimicrobial, and antispasmodic actions. Strictly speaking, none of them is guaranteed to work in all cases, as specifics must be chosen based on the unique needs of an individual with a particular clinical picture.	8	2026-04-23 16:06:07.589513+00
108	56	A bout of acute bronchitis is commonly followed by a period of debility.	1	2026-04-23 16:06:22.109926+00
109	56	Emphasis should be given to respiratory tonics, bitter tonics, and support for any body system or functions indicated for the individual.	2	2026-04-23 16:06:22.109926+00
110	56	Goals of treatment in the latter stages of acute bronchitis include clearing mucus from the lungs and preventing the development of complications, and any of the expectorant essential oils will be indicated.	3	2026-04-23 16:06:22.109926+00
111	56	Specific Remedies: Toning remedies to consider include Verbascum thapsus and Marrubium vulgare. Marrubium is especially useful, for not only is it a useful lung remedy, but it also has valuable bitter properties.	4	2026-04-23 16:06:22.109926+00
112	57	Chronic bronchitis is a long-term condition unaccompanied by fever. It is characterized by a permanent cough with sputum that results from continual overproduction of mucus.	1	2026-04-23 16:06:22.109926+00
113	57	When infection, air pollution, smoking, or other external factors irritate the bronchi, the lungs are provoked to produce abnormally large amounts of mucus, which literally swamp the minute cilia. A deep layer of mucus covers the cilia, so they are no longer able to propel it out of the bronchi.	2	2026-04-23 16:06:22.109926+00
114	57	Chronic bronchitis is preventable, as the primary causal factors are pollutants.	3	2026-04-23 16:06:22.109926+00
115	57	Bronchi become narrowed due to thickening, the lungs lose some of their elasticity, damage also reduces the amount of alveolar tissue. Eventually, the heart may become strained.	4	2026-04-23 16:06:22.109926+00
116	57	Giving up smoking is the first and most important preventive measure. The other is improving nutrition, particularly cutting out or greatly reducing the consumption of foods that encourage the production of mucus. For most people, these are dairy products and refined starches.	5	2026-04-23 16:06:22.109926+00
117	57	Exercise can strengthen the muscles that facilitate breathing. Patients should exercise at least three times a week, starting with short sessions of gentle exercise and gradually building up to longer, more strenuous sessions.	6	2026-04-23 16:06:22.109926+00
118	57	Specific Remedies: Please refer to Specific Remedies provided for acute bronchitis. In addition, the steam inhalation and aromatherapy recommendations given for acute bronchitis are also relevant to chronic bronchitis.	7	2026-04-23 16:06:22.109926+00
119	58	Pertussis, commonly known as whooping cough, is caused by the bacterium Bordetella pertussis. This highly contagious infection is transmitted when the bacteria are coughed or sneezed out by an infected person and breathed in by someone else, especially during the catarrhal and early paroxysmal stages of the disease.	1	2026-04-23 16:06:39.257018+00
120	58	The disease lasts about six weeks and has three well-defined stages. 1. Catarrhal. This stage begins slowly, with sneezing, free-flowing tears, and other signs typical of the common cold. 2. Paroxysmal. Developing after 10 to 14 days, this stage is characterized by paroxysmal coughing. 3. Convalescent. This stage usually begins within four weeks.	2	2026-04-23 16:06:39.257018+00
121	58	Long-term immune system support is essential after such an infection. In addition, support for the respiratory system and potentially even the cardiovascular system may be needed.	3	2026-04-23 16:06:39.257018+00
122	58	Specific Remedies: The European herbal tradition proposes a number of herbs as possible specifics. However, these are not dramatically effective and do not replace appropriate antibiotic treatment. Instead, they support antibiotic therapy.	4	2026-04-23 16:06:39.257018+00
123	59	Asthma is a chronic inflammatory disorder of the airways typified by wheezing, chest tightness, coughing exacerbations, and difficult breathing.	1	2026-04-23 16:06:39.257018+00
124	59	Asthma can develop at any time, but is most common in young children.	2	2026-04-23 16:06:39.257018+00
125	59	Replacement of the term asthma with a more descriptive name, reactive airway disease (RAD). People with RAD have bronchial passages that are more sensitive than normal to irritation.	3	2026-04-23 16:06:39.257018+00
126	59	The inflammation in turn fosters the production of excess mucus and a tightening of the muscles that wind around the bronchial tubes.	4	2026-04-23 16:06:39.257018+00
127	59	A dry cough is sometimes the only sign.	5	2026-04-23 16:06:39.257018+00
128	59	An estimated 75% of childhood asthma is allergy related, so controlling allergies may be pivotal to reducing the frequency of asthma attacks.	6	2026-04-23 16:06:39.257018+00
129	59	As much as 30% of all asthma may be caused by gastro-esophageal reflux, which causes the unpleasant symptom commonly known as heartburn.	7	2026-04-23 16:06:39.257018+00
130	59	Asthma that begins in childhood is closely linked with the presence of eczema, hay fever, urticaria (hives), and migraine in the patient or in close relatives.	8	2026-04-23 16:06:39.257018+00
131	59	Specific Remedies: Ephedra sinica (ma huang) and other Asian ephedra species prove exceptionally useful as bronchodilators. Although synthetic ephedrine is available, the whole herb is better tolerated and causes fewer adverse heart effects. Ephedra stimulates the sympathetic nervous system and thus relieves the bronchospasm that underlies asthma and certain other conditions, including emphysema. Allergic reactions respond well to Ephedra because of its action on the sympathetic nervous system. The ayurvedic herb Coleus forskohlii may be useful in asthma. The constituent forskolin raises cellular levels of CAMP, which results in relaxation of bronchial muscles and relief of asthma symptoms. Forskolin also inhibits the release of histamine and the synthesis of allergic compounds. The others herbs in this list have Antispasmodic and Bronchodilating effects.	9	2026-04-23 16:06:39.257018+00
132	59	Additional Specific Remedies: During an actual asthmatic crisis, inhalation of an antispasmodic oil is the only practical herbal help.	10	2026-04-23 16:06:39.257018+00
133	60	Emphysema, which often develops as a long-term complication of chronic bronchitis, is characterized by damage to the elastic walls of the sac-like alveoli in the lungs. This damage is caused by constant coughing.	1	2026-04-23 16:06:39.257018+00
134	61	Many chronic catarrhal states represent the body's response to a diet too rich in mucus-forming foods.	1	2026-04-23 16:06:49.507222+00
135	61	If the body is using the mucous membranes of the sinuses as a window for removing waste through the vehicle of the catarrh, then it is best to support rather than block this activity.	2	2026-04-23 16:06:49.507222+00
136	61	Blockage of the sinus cavities is very common and relatively easy to treat with herbs.	3	2026-04-23 16:06:49.507222+00
137	61	Specific Remedies: Anticatarrhal herbs do not substitute for the nurturing action of tonics for this part of the body. From the European perspective, here are some appropriate tonics that also possess anti-catarrhal properties.	4	2026-04-23 16:06:49.507222+00
138	62	When the mucous membranes of the nose and throat are inflamed by infection, they are far more vulnerable to attack by bacteria, and this can easily give rise to secondary infections that are more serious than the original cold, such as sinusitis, ear infections, and bronchitis.	1	2026-04-23 16:06:49.507222+00
139	62	For a short-term, acute infection, there is usually no need to focus on system support. However, if the individual has frequent or recurrent colds, the use of tonic remedies will be vital.	2	2026-04-23 16:06:49.507222+00
140	62	If the patient has a history of heart dis-ease, cardiotonics may be used as a precautionary measure. However, Tilia is most appropriate, as it is diaphoretic in addition to being a heart tonic.	3	2026-04-23 16:06:49.507222+00
141	62	Specific Remedies: Aches and pains are common, and our materia medica offers a number of plants that will relieve these unpleasant feelings. Perhaps the best is the diaphoretic Eupatorium perfoliatum (boneset), especially if the patient has a fever. Boneset's bitter taste is one of its therapeutic assets.	4	2026-04-23 16:06:49.507222+00
142	62	Do not inhibit nasal congestion with anticatarrhal drugs, as mucus production is part of the body's normal response to infection. Herbal anticatarrhals work in a different, safer way than anticatarrhal drugs. Matricaria, Mentha piperita, or Eupatorium perfoliatum can help relieve much of the discomfort. Steam inhalations of eucalyptus and thyme oils will also help reduce the formation of catarrh.	5	2026-04-23 16:06:49.507222+00
143	62	To support the immune system, use antimicrobial herbs such as echinacea and goldenseal, as well as ton-ics, such as cleavers and nettles. These may be combined in capsules or as tinctures. Hydrastis canadensis will speed recovery from infection, as will raw garlic or garlic oil capsules.	6	2026-04-23 16:06:49.507222+00
144	63	Influenza, commonly called the flu, is a severe form of viral respiratory tract infection with generalized bodily symptoms.	1	2026-04-23 16:07:01.735818+00
145	63	Typical clinical features of influenza include fever (100°F to 103°F in adults and even higher in children), headache, muscle aches, extreme fatigue, and respiratory symptoms, such as cough, sore throat, and runny or stuffy nose.	2	2026-04-23 16:07:01.735818+00
146	63	Gastrointestinal symptoms are rarely prominent.	3	2026-04-23 16:07:01.735818+00
147	63	Most people recover completely in one to two weeks.	4	2026-04-23 16:07:01.735818+00
148	63	Secondary bacterial infections are the greatest risk of influenza.	5	2026-04-23 16:07:01.735818+00
149	63	Treatment will be most effective if initiated at the very first sign of infection. A moderately hot bath containing a few drops of antiviral essential oil will often induce diaphoresis, followed by a deep, restful sleep.	6	2026-04-23 16:07:01.735818+00
150	63	It is a good idea to repeat this bath treatment for the next two or three days. Tea tree oil is particularly effective for this purpose. However, some people find it to be a mild skin irritant, and may not be able to tolerate more than 3 or 4 drops in a full bath.	7	2026-04-23 16:07:01.735818+00
151	63	Specific Remedies: As with the common cold, there are no miracle cures here. However, certain plants can make life much more bearable during a bout of flu. These are usually diaphoretics, and my favorite is Eupatorium perfolatum (boneset).	8	2026-04-23 16:07:01.735818+00
152	64	Recovery from influenza is often slow, and the convalescing patient may feel very weak and lacking in vitality. Caffeine-containing stimulant herbs should be avoided, as the lift they confer is only temporary and will slow down recovery.	1	2026-04-23 16:07:01.735818+00
153	64	Bitter tonics will speed recovery through their metabolism-stimulating effects.	2	2026-04-23 16:07:01.735818+00
154	65	Hay fever, or allergic rhinitis, is a form of allergy that affects the lining of the nose and, often, the eyes and throat.	1	2026-04-23 16:07:11.301036+00
155	65	Tonic support should be provided for both the upper and lower respiratory systems.	2	2026-04-23 16:07:11.301036+00
156	65	Specific Remedies: There is no particular specific remedy for hay fever. The well-known traditional Chinese remedy Ephedra sinica (ma huang) is a bronchodilator and has much to offer in the treatment of allergic reactions. Ayurveda and unani medicine use Ammi visnaga, a plant with a similar biochemical impact that is now being introduced to the Western world. In addition to these alkaloid-rich plants, certain herbs might be considered specific for various types and sites of symptoms that may arise. For example, Euphrasia spp. ease distress that occurs in the eyes.	3	2026-04-23 16:07:11.301036+00
157	66	The sinuses are four bony cavities positioned behind, above, and at each side of the nose and open into the nasal cavity. They act as a sound box to give resonance to the voice. Sinusitis is an inflammation of these air-containing cavities.	1	2026-04-23 16:07:11.301036+00
158	66	Because the openings from the nose into the sinuses are very narrow, they quickly become blocked when the mucous membranes swell during a cold, hay fever, or catarrh, trapping the infection inside the sinuses.	2	2026-04-23 16:07:11.301036+00
159	66	If the maxillary sinuses above the cheeks are infected, toothache may result.	3	2026-04-23 16:07:11.301036+00
160	67	Laryngitis is an acute inflammation of the larynx, or voice box, usually associated with a common cold or overuse of the voice.	1	2026-04-23 16:07:11.301036+00
161	67	It is usually caused by a bacterial or viral infection.	2	2026-04-23 16:07:11.301036+00
162	67	Specific Remedies: Aromatherapy provides some oils that ease inflammation quite effectively, including cypress and bergamot oils. To use as a gargle, put 3 drops of essential oil in ½/2 cup of warm water. Gargle hourly.	3	2026-04-23 16:07:11.301036+00
163	68	Tonsils are composed of the same type of tissue that makes up the lymph nodes, and they are part of the body's natural defense system. When the tonsils are infected. the lymph glands in the neck often simultaneously become enlarged and tender.	1	2026-04-23 16:07:11.301036+00
164	68	Specific Remedies: Lymphatic alteratives usually have local reputations as specifics for tonsillitis. In the United Kingdom, the most famous is Galium aparine (cleavers).	2	2026-04-23 16:07:11.301036+00
165	71	Depression is either a disorder in its own right or can be a symptom of another disorder, either mental or physical.	10	2026-04-30 16:30:20.373726+00
166	71	Major depression occurs in 10% to 20% of the world's population in the course of a lifetime. Women are more often affected than men are, by a 2:1 ratio, and they seem to be at particular risk just before menstruation or immediately after childbirth.	20	2026-04-30 16:30:20.373726+00
167	71	Depression that is considered a reaction to some loss of or separation from a valued person or object is called reactive or exogenous depression. In contrast, the usually more severe form of depression without apparent cause is called endogenous depression.	30	2026-04-30 16:30:20.373726+00
168	71	TREATMENT OF DEPRESSION: In terms of the herbal component of treatment protocols for depression, attention to the liver and the digestive system in general is usually a good idea.	40	2026-04-30 16:30:20.373726+00
169	72	While sleeping approximately eight hours a night is vital to physical and mental health, dreaming is necessary for psychological health. Eight hours of sleep a night is the usually cited average, although 7 to 7½ hours is more accurate for most people.	10	2026-04-30 16:30:20.373726+00
170	72	Insomnia is especially related to conditions that result in pain, shortness of breath, cough, urination, nausea, diarrhea, or other bothersome symptoms that occur at night.	20	2026-04-30 16:30:20.373726+00
171	72	The key to successful treatment of insomnia is to find the cause and deal with it. Treatment should not depend upon substances, whether herbs or drugs.	30	2026-04-30 16:30:20.373726+00
172	72	Insomnia and Aromatherapy: Aromatherapy, a healing system based on the external application of herbs in the form of essential oils, has much to offer to those in search of restful sleep.	40	2026-04-30 16:30:20.373726+00
173	73	All of the commonly prescribed and abused minor tranquilizers, such as Valium and Xanax, can be safely replaced by herbal remedies when used in a broadly holistic context.	10	2026-04-30 16:30:34.395192+00
174	74	Anorexia nervosa is a problem typified by self-starvation.	10	2026-04-30 16:30:34.395192+00
175	74	In general, the patient will sleep poorly but, despite weight loss, will remain physically active, believing herself to be much fatter than she actually is. These symptoms suggest that anorexia nervosa may be associated with a disorder of the hypothalamus, a region of the brain that regulates menstruation, eating, body temperature, and sleep.	20	2026-04-30 16:30:34.395192+00
176	75	For most headaches, even when the pain is severe, no underlying disease exists. Most headaches are caused by fatigue, emotional disorders, or allergies.	10	2026-04-30 16:30:34.395192+00
177	75	Headache pain results from the stimulation of pain-sensitive structures such as the meninges and the nerves of the cranium and upper neck — produced by inflammation, dilation of blood vessels in the head, or muscle spasms.	20	2026-04-30 16:30:34.395192+00
178	75	Headaches brought on by muscle spasms are classified as tension headaches. Those caused by dilation of blood vessels are called vascular headaches.	30	2026-04-30 16:30:34.395192+00
179	76	Orthodox medicine considers the underlying cause of migraine to be unknown. Common migraine may affect as many as 25% of Americans.	10	2026-04-30 16:30:46.287227+00
180	76	The immediate cause appears to relate to spasms in the muscular walls of the blood vessels of the brain and scalp. In approximately 15% of all cases, migraine attacks are preceded by warning signs known as auras.	20	2026-04-30 16:30:46.287227+00
181	76	Triggers don't actually cause the pain; rather, they activate an already existing chemical mechanism in the brain. The more triggers present at any given time, the more likely that a headache will follow.	30	2026-04-30 16:30:46.287227+00
182	78	One person out of 10 has some type of hearing impairment or ear problem, and 85% of these have some associated tinnitus.	10	2026-04-30 16:30:46.287227+00
183	78	Hypericum perforatum is the main herb to consider here for tinnitus associated with depression. Ginkgo biloba may help improve problems of the inner ear that result from a disturbance in blood supply.	20	2026-04-30 16:30:46.287227+00
184	79	Zingiber officinale (ginger) can usually be relied upon. Research published in The Lancet showed it to be more effective than Dramamine in preventing symptoms of motion sickness. Ginger may be drunk as a fresh infusion, eaten as candied ginger, or taken as capsules of the powder (usual dosage: 2 to 4 capsules as needed).	10	2026-04-30 16:30:46.287227+00
185	79	Ballota nigra (black horehound) will also reduce this kind of nausea. One of the more effective allopathic treatments involves a dermal patch of scopolamine, a constituent of Atropa belladonna.	20	2026-04-30 16:30:46.287227+00
186	81	Cholesterol is found in all cells of the body, primarily as a structural component of cell membranes. Stored in the adrenal glands, testes, and ovaries, it serves as a precursor molecule for hormones.	10	2026-05-17 19:20:07.593885+00
187	81	In the bloodstream, cholesterol binds with protein molecules to form lipoproteins. HDL transports excess cholesterol to the liver for elimination, while LDL tends to remain in the body. VLDLs transport triglycerides.	20	2026-05-17 19:20:07.593885+00
188	81	LDL is often called "bad" cholesterol because excess LDL leads to buildup and blockage in the arteries. HDL is "good" cholesterol because it removes cholesterol from the blood, preventing arterial accumulation.	30	2026-05-17 19:20:07.593885+00
189	81	A desirable total cholesterol level for adults without heart disease is lower than 200 mg/dl. A level of 240 mg/dl or higher is considered high. Even borderline high levels (200–239 mg/dl) increase the risk of heart disease.	40	2026-05-17 19:20:07.593885+00
190	82	Hypertension is common in Western culture but rare in those untouched by the Western lifestyle. Lifestyle plays a major role; dietary, psychological, and social factors must all be addressed.	10	2026-05-17 19:20:07.593885+00
191	82	Hypertension typically causes no symptoms until complications arise, which can include dizziness, flushed face, headache, fatigue, epistaxis (nosebleed), and nervousness.	20	2026-05-17 19:20:07.593885+00
192	82	In general, hypertension is indicated by a blood pressure measurement higher than 140/90 mm Hg. Blood pressure lower than 120/80 mm Hg is considered optimal.	30	2026-05-17 19:20:07.593885+00
193	82	If left untreated, high blood pressure can lead to arteriosclerosis, myocardial infarction, enlarged heart, kidney damage, and stroke.	40	2026-05-17 19:20:07.593885+00
194	82	Weight reduction, dietary changes, tobacco cessation, exercise, massage, relaxation techniques, and meditation are all important treatment components. Blood pressure usually falls when patients cut back on salt and sodium.	50	2026-05-17 19:20:07.593885+00
195	83	The most familiar form of arteriosclerosis is atherosclerosis, characterized by fatty deposits on the inner lining of the arteries. These arterial plaques lead to loss of arterial elasticity and narrowing of the artery.	10	2026-05-17 19:20:07.593885+00
196	83	Atherosclerosis tends to target the aorta as well as the arteries leading to the brain, lower limbs, and kidneys. Overwhelming evidence links it closely to diet and lifestyle, suggesting it can be prevented, slowed, or in some cases reversed.	20	2026-05-17 19:20:07.593885+00
197	83	Hypertension is a critical factor in the atherosclerotic process. People with high LDL cholesterol are at risk, though many with high cholesterol do not develop atherosclerosis and many with atherosclerosis have normal cholesterol levels.	30	2026-05-17 19:20:07.593885+00
198	83	Herbalism aims to prevent the disease by addressing causative factors: hypertension, diabetes mellitus, smoking, diet, and obesity. The cardiovascular system should be the focus of tonic attention.	40	2026-05-17 19:20:07.593885+00
199	84	Congestive heart failure (CHF) is a severe condition in which the heart cannot supply the body with enough blood because it is functioning inadequately as a pump. The condition generally develops slowly as the heart gradually loses its ability to pump efficiently.	10	2026-05-17 19:20:07.593885+00
200	84	Shortness of breath is often the most prominent symptom, resulting from fluid buildup in the lungs. Fatigue, edema (swelling of feet, ankles, legs), and persistent coughing are other common symptoms.	20	2026-05-17 19:20:07.593885+00
201	84	The heart compensates through enlargement, thickening of muscle fibers, and more frequent contractions. Eventually it cannot offset its lost pumping ability, and the signs of heart failure appear.	30	2026-05-17 19:20:07.593885+00
202	84	While herbs containing cardiac glycosides form the basis of important pharmaceutical drugs for CHF, herbal treatment focuses on cardiotonics, peripheral vasodilators, hypotensives, diuretics, and nervines.	40	2026-05-17 19:20:07.593885+00
203	85	Angina pectoris is a recurring pain or discomfort in the chest indicating that the heart is not getting enough oxygen. The main underlying cause is coronary artery disease stemming from atherosclerosis.	10	2026-05-17 19:20:07.593885+00
204	85	Episodes occur when the heart's need for oxygen exceeds its availability from the blood. Physical exertion is the most common trigger.	20	2026-05-17 19:20:07.593885+00
205	85	An angina attack is not a heart attack. While the pain is similar, it usually lasts no more than five minutes and does not mean the heart muscle is suffering irreversible damage.	30	2026-05-17 19:20:07.593885+00
206	86	Peripheral arterial occlusive disease, also known as intermittent claudication, is a peripheral vascular disease caused by narrowing of the arteries in the legs.	10	2026-05-17 19:20:07.593885+00
207	86	Because of the limited blood supply, muscles do not receive the oxygen they need, resulting in the buildup of lactic acid.	20	2026-05-17 19:20:07.593885+00
208	87	The core problem is valve incompetency in the veins of the legs, which leads to dilation of the veins, loss of tissue tone, and some degree of reversal of blood flow.	10	2026-05-17 19:20:07.593885+00
209	87	When vein efficiency declines, blood may stagnate, causing the veins to become swollen and tortuous (twisted), resulting in aching and abnormal fatigue in the legs.	20	2026-05-17 19:20:07.593885+00
218	90	The duration of a menstrual period is 28 ± 3 days for 65% of women, with a range of 18 to 40 days. Once a menstrual pattern has been established, the variation does not normally exceed five days. The average duration of flow is 5 ± 2 days, with a blood loss averaging 30 ml. Flow is generally heaviest on the second day.	10	2026-06-07 19:28:17.415064+00
219	90	The core herbal treatment guidelines for this condition must start with tonic support for the reproductive system.	20	2026-06-07 19:28:17.415064+00
220	90	Other actions will be indicated by the associated symptom picture or case history. For example, if anxiety and stress are an issue, consider appropriate nervines. If severe menstrual cramps occur, use antispasmodics.	30	2026-06-07 19:28:17.415064+00
221	91	Dysmenorrhea, or painful menstruation, is the most common of all gynecologic complaints.	10	2026-06-07 19:28:17.415064+00
222	91	A number of constitutional factors may lower the pain threshold and thus appear to worsen dysmenorrhea. Common factors include anemia, increase in obesity, chronic illness, over-work, stress in general, diabetes, and poor nutrition.	20	2026-06-07 19:28:17.415064+00
223	91	Primary dysmenorrhea is dysmenorrhea unrelated to any definable pelvic lesion. It usually starts with the first ovulatory cycles, beginning in most cases before the age of 20 years. It generally occurs over the midline of the abdomen, and is relieved by the onset of good menstrual flow.	30	2026-06-07 19:28:17.415064+00
224	91	Secondary dysmenorrhea is related to the presence of pelvic lesions associated with organic pelvic disease; often it is lateralized to one side of the body. In general, the onset of secondary dysmenorrhea occurs later in life in women who have not had primary dysmenorrhea.	40	2026-06-07 19:28:17.415064+00
225	91	Psychological issues can be fundamental here. Low tolerance to the sensation of uterine contraction may be learned behavior.	50	2026-06-07 19:28:17.415064+00
226	92	The name premenstrual syndrome (PMS) describes a broad range of symptoms that occur cyclically and are severe enough to disturb a woman's life or cause her to seek help from a health practitioner.	10	2026-06-07 19:28:17.415064+00
227	92	There is, by definition, a period of time for PMS sufferers during which symptoms are absent, usually just after the onset or end of menses. PMS occurs during the proliferative or luteal phase of the menstrual cycle, when levels of estrogen and progesterone are relatively high. Estrogen is a central nervous system (CNS) stimulant and progesterone is a CNS depressant.	20	2026-06-07 19:28:17.415064+00
228	92	Violent crimes by women and suicide are often committed in the premenstrual period.	30	2026-06-07 19:28:17.415064+00
229	93	In our society, far too many women approach menopause with dread, fearing that they will no longer be valued as women. On the other hand, menopause may also be viewed as a great gift in a woman's life, a liberation and an initiation.	10	2026-06-07 19:28:17.415064+00
230	93	Menopause is the cessation of menstruation and the termination of fertility, which are not the same thing and may occur at different times. Climacteric is a transition phase that lasts for 15 to 20 years, during which time ovarian function and hormone production decline and the body readapts. Menopause is simply one event within this process.	20	2026-06-07 19:28:17.415064+00
338	138	Do not squeeze pimples or blackheads, as squeezing the skin makes the acne worse. Keep the hair off the face, and wash the hair daily.	70	2026-06-21 16:54:56.148727+00
231	93	The years of progressive ovarian failure that lead up to menopause are what are referred to as the climacteric, or "change of life." In the United States, the majority of women experience menopause between the ages of 40 and 55, and the average age of menopause is 51 years.	30	2026-06-07 19:28:17.415064+00
232	93	The most common symptom caused by the menopausal decline in estrogen secretion is hot flashes, or flushing. About 85% of women over the age of 50 are affected. Vitex agnus-castus is an effective remedy for this often distressing symptom.	40	2026-06-07 19:28:17.415064+00
233	93	Decreased estrogen secretion has no direct effect on libido. As long as vaginal symptoms are effectively treated, there is no reason why postmenopausal women should not be able to enjoy a satisfying sex life.	50	2026-06-07 19:28:17.415064+00
234	93	With decreased production of natural lubricating substances, the vagina becomes dry and irritated. Itching and dyspareunia (painful sexual intercourse) may result.	60	2026-06-07 19:28:17.415064+00
235	93	Estrogen deficiency plays a role in postmenopausal osteoporosis by diminishing the intestinal absorption of calcium.	70	2026-06-07 19:28:17.415064+00
236	94	Herbs can shorten labor and decrease the likelihood that complications will arise during pregnancy and in childbirth. The most widely used of these in Europe is raspberry leaf (Rubus idaeus).	10	2026-06-07 19:28:17.415064+00
237	94	Because bitters stimulate metabolism in general, and some bitters also act as emmenagogues to stimulate smooth muscle activity, bitters are contraindicated during pregnancy.	20	2026-06-07 19:28:17.415064+00
238	94	Alkaloids are a diverse group of secondary plant constituents with a wide range of pharmacological effects. The stronger representatives should be avoided during pregnancy, including the caffeine-containing social drugs coffee and tea.	30	2026-06-07 19:28:17.415064+00
239	94	Many essential oils can have a devastating impact on the placenta and fetus if taken internally during pregnancy. However, if used in moderation, the whole plant from which the oil was distilled will usually be fine.	40	2026-06-07 19:28:17.415064+00
240	94	The strong herbal laxatives often owe their effects to the presence of anthraquinone constituents that stimulate peristalsis in the bowel. They may have a similar stimulating impact upon the uterus.	50	2026-06-07 19:28:17.415064+00
241	94	Anthelmintic remedies should be avoided because they often stimulate uterine contractions, as well as containing potentially toxic constituents.	60	2026-06-07 19:28:17.415064+00
242	95	Herbs can help as long as the fetus is normal and the mother's general physical, emotional, and mental health is good. No herbal remedy will block appropriate miscarriage — most cases are a natural rejection of a malformed fetus.	10	2026-06-07 19:28:17.415064+00
243	95	To ensure fewer complications, women should take at least 6 to 12 months between pregnancies.	20	2026-06-07 19:28:17.415064+00
244	95	When chronic poor health, inadequate diet, or trauma and stress has depleted a woman's general strength, herbs can provide extra vitality, especially to the womb, and so help avoid unnecessary miscarriage.	30	2026-06-07 19:28:17.415064+00
245	95	The woman should eat plenty of foods containing vitamins E and C. Asparagus and celery are said to be strengthening.	40	2026-06-07 19:28:17.415064+00
246	96	Morning sickness refers to the nausea and vomiting some women experience when they become pregnant. It is caused by the sudden increase in hormone levels during pregnancy.	10	2026-06-07 19:28:17.415064+00
247	96	It is very common early in pregnancy, but tends to go away later, and is almost always gone by the second trimester (the fourth month). Morning sickness is seen in about 50% of pregnancies, and tends to worsen with each successive pregnancy.	20	2026-06-07 19:28:17.415064+00
248	96	During the first 12 to 14 weeks of pregnancy, when most women experience sickness, hormones are primarily produced in the corpus luteum in the ovaries. After this time, hormone production shifts to the placenta, which may help explain why morning sickness stops at around the same time.	30	2026-06-07 19:28:17.415064+00
249	97	High levels of progesterone relax the intestinal muscles, and thus reduce their ability to propel the contents of the bowel toward the rectum and out of the body.	10	2026-06-07 19:28:17.415064+00
250	97	The weight of the baby and placenta increases pressure on the lower bowel, aggravating the tendency to constipation.	20	2026-06-07 19:28:17.415064+00
251	97	Anthraquinone-containing stimulant laxatives are not safe for use during pregnancy.	30	2026-06-07 19:28:17.415064+00
252	97	Increase water intake to 8 glasses per day. Increase exercise — walking half a mile a day is appropriate. Increase intake of fresh fruits and certain dried fruits, such as prunes, raisins, and figs. Increase fiber intake. Use bulk laxatives, such as psyllium seeds: 1 tablespoon three times a day in 1/4 cup of juice.	40	2026-06-07 19:28:17.415064+00
253	98	Anemia commonly occurs during the last two months of pregnancy, when the baby utilizes a high proportion of the mother's iron.	10	2026-06-07 19:28:17.415064+00
254	98	The best approach is to increase dietary intake of iron-containing foods, as iron supplements may aggravate constipation.	20	2026-06-07 19:28:17.415064+00
255	99	Dizziness caused by the ability of progesterone to relax the blood vessel walls is common in pregnancy.	10	2026-06-07 19:28:17.415064+00
256	99	Recommendations: Change positions slowly. Eat small meals throughout the day rather than three large meals. Maintain blood sugar levels.	20	2026-06-07 19:28:17.415064+00
257	100	Heartburn, caused by reflux of gastric contents into the esophagus, is one of the most common complaints of pregnancy.	10	2026-06-07 19:28:17.415064+00
258	100	The relaxing effects of progesterone also reach the cardiac sphincter, the valve that guards the entrance to the stomach at the bottom of the esophagus.	20	2026-06-07 19:28:17.415064+00
259	101	Bleeding gums are frequently seen in pregnancy. Gingival hypertrophy, a temporary softening of the gums, is seen in 40% of pregnancies. This is a response to elevated progesterone levels in the blood.	10	2026-06-07 19:28:17.415064+00
260	101	Suggestions: Brush gums frequently with a soft brush. Vitamin C and bioflavonoids complex: up to 2,000 mg/day.	20	2026-06-07 19:28:17.415064+00
261	102	Headache sometimes occurs in early pregnancy, but is worse between three and five months. A few cases may result from eyestrain, as pregnancy may result in a change in the amount of refractive error in the eyes. Some cases may be caused by sinusitis, and frontal headaches are seen with hypertension.	10	2026-06-07 19:28:17.415064+00
262	103	Hemorrhoids may be exacerbated by or occur for the first time during pregnancy. The condition is caused by increased pressure and impairment of return of venous fluid in the veins by the pressure of the enlarging uterus.	10	2026-06-07 19:28:17.415064+00
263	104	During the second trimester, the woman will usually experience decreased nausea and better sleep patterns, and have more stamina and energy than during the first trimester.	10	2026-06-07 19:28:17.415064+00
264	104	A whole new set of symptoms and sensations commonly arise, including back pain, leg cramps, heartburn, skin changes, and constipation.	20	2026-06-07 19:28:17.415064+00
339	138	Traditionally, there are no definite specifics here, other than hepatic alteratives.	80	2026-06-21 16:54:56.148727+00
265	104	Many of the physical symptoms of late pregnancy arise from the increase in uterine size. These may include shortness of breath, sleeping problems, varicose veins, skin changes, and hemorrhoids.	30	2026-06-07 19:28:17.415064+00
266	105	The tendency to develop stretch marks can be lessened by eating appropriately and using remedies to address collagen problems in the skin.	10	2026-06-07 19:28:17.415064+00
267	105	Massaging wheat germ or vitamin E oil into the breasts, abdomen, and thighs daily will reduce the likelihood that marks will develop. Calendula oil mixed with wheat germ oil is especially helpful.	20	2026-06-07 19:28:17.415064+00
268	106	The relaxation of the ligaments that support the spine combined with the weight of the growing abdomen often cause backache.	10	2026-06-07 19:28:17.415064+00
269	106	Yoga exercises may be helpful. Rest is important in preventing or relieving backache, especially in the last three months of pregnancy. Deep breathing and relaxation exercises can also help. Baths with lavender and rosemary essential oils and massage of the whole spine with a mixture of chamomile and geranium essential oils can be effective.	20	2026-06-07 19:28:17.415064+00
270	107	Gestational hypertension is characterized by a steady rise in blood pressure after the 28th week of gestation. The general rule for the upper limit of gestational hypertension is 140/90 mm Hg.	10	2026-06-07 19:28:17.415064+00
271	107	Herbal treatment can do much to mitigate this form of secondary hypertension, but blood pressure must be monitored closely.	20	2026-06-07 19:28:17.415064+00
272	108	Generally, if a woman does not nurse, she will menstruate six to eight weeks after birth. Nursing women begin to menstruate again at any time from six weeks after birth to two years after birth.	10	2026-06-07 19:28:17.415064+00
273	108	Nursing is not an adequate method of birth control, as most women ovulate before they menstruate, and a woman can become pregnant before her period returns.	20	2026-06-07 19:28:17.415064+00
274	109	If the woman is lactating, she will secrete prolactin, which is stimulated by the sensation caused by the nursing baby. Prolactin is a mild relaxant and depressant. As prolactin levels rise, the elevated levels of estrogen and progesterone maintained throughout the pregnancy drop abruptly. This may lead to postpartum depression.	10	2026-06-07 19:28:17.415064+00
275	109	Greater emphasis can be placed on Artemisia vulgaris and Hypericum perforatum. It is important to encourage the new mother to go out and enjoy the company of other adults.	20	2026-06-07 19:28:17.415064+00
276	110	The perineum (the area of skin between the vagina and the anus) may be surgically cut (an episiotomy) or may tear during birth.	10	2026-06-07 19:28:17.415064+00
277	111	For women who have had more than one child, after pains increase in strength with each successive pregnancy.	10	2026-06-07 19:28:17.415064+00
278	111	If necessary, use antispasmodic herbs and uterine tonics.	20	2026-06-07 19:28:17.415064+00
279	112	Herbal remedies called galactogogues encourage milk production to begin and increase total milk volume.	10	2026-06-07 19:28:17.415064+00
280	113	Mastitis is inflammation of the mammary gland, usually caused by infection. Such breast infections are located in the tissue of the breast; the bacteria usually enter through cracks in the nipples.	10	2026-06-07 19:28:17.415064+00
281	114	Fibroid tumors are benign muscle tumors that cause enlargement and distortion of the uterus in premenopausal women. They may make menstruation painful and heavy, possibly leading to anemia.	10	2026-06-07 19:28:17.415064+00
282	115	Endometriosis is the presence of uterine tissue (endometrium) outside its usual location on the inner lining of the uterus. Pain, abnormal menstrual bleeding, infertility, and prolonged disability may result.	10	2026-06-07 19:28:17.415064+00
283	115	Endometrial tissue may implant itself on the ovaries, fallopian tubes, pelvic ligaments, abdominal organs, old scars, and, in rare cases, the chest, lungs, spinal cord, and extremities. Over time, the implants may enlarge, bleed, cause scarring, and form tough fibrous adhesions between pelvic and abdominal structures.	20	2026-06-07 19:28:17.415064+00
284	115	Implants often regress during pregnancy, and first pregnancy at a young age seems to protect against the development of endometriosis.	30	2026-06-07 19:28:17.415064+00
285	115	Endometriosis is a notoriously difficult condition to diagnose; conclusive diagnosis often necessitates exploratory laparoscopy. In severe cases, surgery may be indicated.	40	2026-06-07 19:28:17.415064+00
286	116	Fibrocystic breast disease, also known as chronic cystic mastitis, is the most common nonmalignant breast disease.	10	2026-06-07 19:28:17.415064+00
287	116	While uncomfortable, the condition is not dangerous, and up to 20% of women develop some degree of fibrocystic breast disease during their lives.	20	2026-06-07 19:28:17.415064+00
288	117	As it achieves adult size, the prostate wraps itself around the urethra, into which its secretions empty. The gland is normally about the size of a chestnut.	10	2026-06-07 19:28:17.415064+00
289	117	Because of its location, if it becomes inflamed or enlarged, it may exert pressure on the urethra or block the outlet to the bladder, thus obstructing the flow of urine. Urine trapped in the bladder may become infected, causing cystitis, and backward pressure can lead to kidney infection.	20	2026-06-07 19:28:17.415064+00
290	117	Congestion and overgrowth of the prostate gland is virtually universal in men older than 60.	30	2026-06-07 19:28:17.415064+00
291	117	DHT is necessary for the normal growth and development of the prostate, but its presence is also necessary for the pathologic enlargement that occurs in BPH. One therapeutic approach is to reduce the formation of DHT by blocking the enzyme 5-alpha reductase. Serenoa repens (saw palmetto) has this effect.	40	2026-06-07 19:28:17.415064+00
292	117	When it becomes impossible to empty the bladder of all its contents, the occasional bacteria present in the urinary tract are able to multiply, and urinary tract infection may occur.	50	2026-06-07 19:28:17.415064+00
293	118	An important exception may be the use of Cytisus scoparius (Scotch broom) in the treatment of hypotension. It may prove too strong for some elderly people, and so should be avoided.	1	2026-06-08 14:41:59.876695+00
294	118	More than with any other age group, it is essential to avoid the inappropriate use of cardiac glycoside-containing herbs in elders.	2	2026-06-08 14:41:59.876695+00
295	120	A caution must be voiced about the use of Valeriana with elders. A very small number of people experience a paradoxical reaction — instead of a relaxing or hypnotic effect, they have a caffeinelike stimulation. If this happens, Valeriana should be avoided. If a paradoxical reaction does occur, Scutellaria will ease the unpleasant symptoms quite effectively.	1	2026-06-08 14:41:59.876695+00
296	120	Note that Humulus lupulus was not included in the list of relevant hypnotics, as it has a tendency to induce depression if used consistently.	2	2026-06-08 14:41:59.876695+00
297	120	Ginkgo biloba: while it has a popular reputation as a "memory" herb, it should be considered a cardiovascular remedy in the treatment of cerebrovascular dysfunction and peripheral vascular disorders. Studies confirm the efficacy of ginkgo extract for treating disturbances of cerebrovascular function.	3	2026-06-08 14:41:59.876695+00
298	121	Herbs have much to offer for general symptomatic relief of digestive upsets. This is especially the case when digestive symptoms are related to side effects of essential allopathic medications.	1	2026-06-08 14:41:59.876695+00
299	124	There is usually no need to resort to intense treatments for musculoskeletal problems in elders, as the milder antirheumatic herbs are often effective, given time.	1	2026-06-08 14:41:59.876695+00
300	124	Make it a priority to address any digestive symptoms present in older patients with rheumatic conditions. Any such symptoms indicate that digestion, assimilation, and elimination are not functioning at optimal levels.	2	2026-06-08 14:41:59.876695+00
301	125	The topical anti-inflammatory activity of Calendula officinalis and Hypericum perforatum are particularly valuable.	1	2026-06-08 14:41:59.876695+00
302	125	The emphasis should be on gentle alteratives and tonics, with extra focus on general liver, digestive, and kidney function.	2	2026-06-08 14:41:59.876695+00
303	125	Many essential oils are also helpful when applied topically.	3	2026-06-08 14:41:59.876695+00
310	130	This common symptom indicates that the bladder cannot hold as much fluid as usual.	10	2026-06-21 16:44:38.744675+00
311	130	Infection, foreign bodies, stones, and tumors can all injure the tissue of the bladder wall and cause inflammation.	20	2026-06-21 16:44:38.744675+00
312	131	Painful urination.	10	2026-06-21 16:44:38.744675+00
313	132	Hematuria can give the urine a red or brown color.	10	2026-06-21 16:44:38.744675+00
314	132	The bleeding may occur at a site of physical trauma, such as where a kidney stone has cut the tissue, or from a focus of infection.	20	2026-06-21 16:44:38.744675+00
315	133	This accumulation may be associated with liver or kidney disturbances, pregnancy, premenstrual syndrome, or heart failure. Never treat water retention without addressing its causal factors.	10	2026-06-21 16:44:38.744675+00
316	134	Cystitis, or inflammation of the wall and lining of the urinary bladder, may be due to bacterial infection or to mechanical abrasion from microcrystals of calcium phosphate in urine.	10	2026-06-21 16:44:38.744675+00
317	134	These infections are usually caused by the rod-shaped bacterium called Escherichia coli, commonly known as E. coli.	20	2026-06-21 16:44:38.744675+00
318	134	Treatment: plants that are specifically active in the urinary tract. Thus, antimicrobials containing terpene essential oils are indicated. The essential oil is excreted from the body via the kidney, directing its action to the site of infection in the bladder.	30	2026-06-21 16:44:38.744675+00
319	135	Low urine pH due to hereditary causes or bowel disease promotes uric acid stones. High pH related to alkali drugs or renal tubular acidosis increases calcium phosphate supersaturation.	10	2026-06-21 16:44:38.744675+00
320	135	For patients with calcium oxalate stones, avoid foods that contain oxalates, such as spinach, rhubarb, beets, parsley, sorrel, and chocolate. These patients should be advised to restrict intake of dairy products, which are rich in calcium. Mineral waters rich in magnesium will increase the solubility of calcium. Both vitamin B6 and folic acid are thought to restrict the amount of calcium formed in the body.	20	2026-06-21 16:44:38.744675+00
321	136	The terms eczema and dermatitis are the cause of much confusion. We use these terms synonymously to indicate superficial inflammation of the skin.	10	2026-06-21 16:54:56.148727+00
322	136	For the phytotherapist, however, the most important distinction is between cases with an internal or endogenous cause and those with a contact or exogenous cause.	20	2026-06-21 16:54:56.148727+00
323	136	A number of factors can aggravate eczema, although the specifics vary from person to person. Dietary factors are particularly important, especially in children. Milk and milk products are the most common triggers. Primary aggravating factors for eczema are: Stress, Mechanical irritation, Heat, Dietary.	30	2026-06-21 16:54:56.148727+00
324	137	Psoriasis usually develops slowly, following a typical course of remission and recurrence. The characteristic psoriatic plaques, or lesions, are sharply demarcated, red and raised, covered with silvery scales, and bleed easily. These plaques do not usually itch, and will heal without leaving scar tissue or affecting hair growth. The nails may become pitted.	10	2026-06-21 16:54:56.148727+00
325	137	Common sites for psoriasis are: bony protuberances (knees, elbows, sacrum), scalp, external parts of ears, nails and eyebrows, back and buttocks, and skin folds such as the umbilicus.	20	2026-06-21 16:54:56.148727+00
326	137	In normal skin, it takes about 28 days for an epidermal cell to go from creation to shedding or scaling. Psoriatic cells complete this process in three or four days, or almost nine times faster than usual.	30	2026-06-21 16:54:56.148727+00
327	137	Much of psoriasis therapy is directed toward removing these plaques in a non-traumatic fashion and to easing any attendant discomfort.	40	2026-06-21 16:54:56.148727+00
328	137	The underlying cause of the rapid epithelial cell turnover characteristic of psoriasis is not known.	50	2026-06-21 16:54:56.148727+00
329	137	Flare-ups commonly accompany infections, especially infections of the upper respiratory tract.	60	2026-06-21 16:54:56.148727+00
330	137	In short, psoriasis represents a classic example of a condition for which a holistic perspective is essential.	70	2026-06-21 16:54:56.148727+00
331	137	There are probably no true specifics. This is to be expected in light of the multifactorial, systemic nature of psoriasis.	80	2026-06-21 16:54:56.148727+00
332	138	Acne involves the sebaceous glands in the skin, which secrete lubrication (sebum) for the hair follicles (pilosebaceous follicles) and surrounding skin. These are located in greatest concentrations on the face, back, shoulders, and chest.	10	2026-06-21 16:54:56.148727+00
333	138	Statistics suggest that the strongest single factor in the development of acne is family history.	20	2026-06-21 16:54:56.148727+00
334	138	Stimulation of the sebaceous glands seems to occur with the production of androgens (the masculinizing hormone found in both sexes) at puberty.	30	2026-06-21 16:54:56.148727+00
335	138	Although it is popularly thought that diet is a major factor in acne, there is no clear scientific evidence to support this.	40	2026-06-21 16:54:56.148727+00
336	138	Treatment: Toning work can be focused through the use of hepatic alteratives.	50	2026-06-21 16:54:56.148727+00
337	138	Personal hygiene is important, but an obsession with washing can aggravate the problem.	60	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: disorder_prescriptions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.disorder_prescriptions (id, disorder_id, title, instructions, sort_order, created_at) FROM stdin;
1	1	\N	Dosage: up to 5 ml of tincture three times a day	1	2026-04-06 21:33:58.34407+00
2	2	\N	Combine dried herbs and prepare as an infusion; drink regularly throughout the day until symptoms subside.	1	2026-04-06 21:33:58.34407+00
3	3	Mouthwash	Combine dried herbs and prepare as an infusion, to be gargled often.	1	2026-04-06 21:33:58.34407+00
4	3	Internal use	Dosage - up to 3 ml of tincture three times a day	2	2026-04-06 21:33:58.34407+00
5	4	Gum application	Combine tinctures and apply to the gums three times a day using a very fine brush. An infusion of buccal anti-inflammatory herbs, such as Salvia and Matricaria, may be used as a mouthwash, Do not swallow.	1	2026-04-06 21:33:58.34407+00
6	4	Internal use	Dosage - up to 5 ml of tincture combination three times a day	2	2026-04-06 21:33:58.34407+00
7	5	\N	Dosage: up to 5 ml of tincture three times a day. In addition, an infusion of the anti-inflammatory herb Matricaria, sipped slowly throughout the day, can be helpful. As an alternative, a cold infusion of Althaea root can be taken whenever needed.	1	2026-04-06 21:33:58.34407+00
8	6	\N	Dosage: Take tincture in divided doses, to 5 ml in total, three times a day. An infusion of Matricaria or Melissa sipped slowly throughout the day will also help.	1	2026-04-06 21:33:58.34407+00
9	7	\N	Focuses on reducing inflammation and beginning the healing process. Dosage: 5 ml of tincture combination three times a day. In addition, a cold infusion of these herbs (fresh or dried) may be drunk often to ease symptoms. Matricaria infusion drunk on an empty stomach will reduce inflammation and help reverse the ulcerative process. Caution: If symptoms have not subsided within a week, seek skilled diagnosis.	1	2026-04-06 21:33:58.34407+00
10	7	\N	Focuses on the second step in the healing process, to tone and complete healing. Dosage: 5 ml of tincture combination three times a day. Caution: If symptoms have not subsided within a week, seek skilled diagnosis.	2	2026-04-06 21:33:58.34407+00
11	8	\N	Dosage: 5 ml of tincture combination three times a day. An infusion of these herbs (fresh or dried) may be drunk often to ease symptoms. Carminative nervines may be added if stress is a major component. (Valeriana officinalis is a good example.)	1	2026-04-06 21:33:58.34407+00
12	9	\N	For indigestion. Dosage: 2.5 ml of tincture combination 10 minutes before eating	1	2026-04-06 21:33:58.34407+00
13	10	\N	Dosage: 5 ml of tincture combination three times a day. In addition, a warm infusion of an appropriate carminative nervine should be drunk frequently.	1	2026-04-06 21:56:12.487259+00
14	11	\N	Dosage: 5 ml of tincture combination three times a day. At least 1 clove of raw garlic should be eaten every day, and a warm infusion of an appropriate carminative nervine should be drunk often.	1	2026-04-06 21:56:12.487259+00
15	12	\N	Dosage: 5 ml of tincture combination three times a day. An infusion of Matricaria or Mentha piperita sipped slowly throughout the day will help. One clove a day of garlic (Allium sativum) should be eaten raw as part of the diet, or an equivalent amount taken in supplement form. The supplement should be a 600 mg oil "perle" containing 6 mg of allicin.	1	2026-04-06 21:56:12.487259+00
16	14	\N	Dosage: up to 2.5 ml of tincture combination three times a day, building up to 5 ml three times a day. An infusion of Stellaria media or distilled witch hazel may be applied topically to relieve itching.	1	2026-04-06 21:56:27.332838+00
17	15	\N	Dosage: up to 2.5 ml of tincture three times a day, building up to 5 ml three times a day. Artemisia vulgaris is included as a bitter nervine, but this herb could be replaced with Verbena officianalis or another appropriate nervine.	1	2026-04-06 21:56:27.332838+00
18	16	\N	Dosage: 5 ml with water four times a day	1	2026-04-06 21:56:27.332838+00
19	17	\N	Dosage: up to 2.5 ml of tincture three times a day, building up to 5 ml three times a day. The alcohol base of tinctures may pose a problem. If these remedies cannot be obtained in an alcohol-free glycerite form, the medicine can be put into a small amount of hot water; the alcohol will evaporate and leave behind the herbal component.	1	2026-04-06 21:56:27.332838+00
20	18	\N	Dosage: up to 5 ml of tincture three times a day. An infusion of a carminative, antispasmodic nervine, such as Matricaria recu-tita, should be taken regularly throughout the day. In addition, the patient should take Silybum marianum tablets or capsules standardized to 80% silymarin. Recommended dosage is 1 capsule containing 140 mg of silymarin three times daily. NOTE: This prescription supplies antispasmodic, hepatic, nervine, and preventive antilithic actions. Many other herbs could have been used. Consider Chelone glabra, Verbena officinalis, and Mahonia aquifolium. The Eclectic physicians would have suggested that small amounts of Hydrastis canadensis and Lobelia inflata be added to such a mixture.	1	2026-04-06 21:56:27.332838+00
21	19	\N	Dosage: up to 5 ml of tincture three times a day. An infusion of a carminative, antispasmodic, nervine herb should be taken regularly throughout the day (for example, Matricaria recutita).	1	2026-04-06 21:56:27.332838+00
22	20	\N	Dosage: 5 ml of tincture three times a day	1	2026-04-06 21:56:27.332838+00
23	20	Topical application	Apply this combination after every bowel movement and as needed. Salves containing any of many possible herbs may also be used. Useful herbs include Calendula officinalis, Hypericum perforatum, Matricaria recutita, Plantago spp., and Achillea millefolium.	2	2026-04-06 21:56:27.332838+00
24	27	Capsule Formula	Mix equal parts of the powders thoroughly and encapsulate in size 00 capsules. Take 2 capsules three times daily for 5 days, then take 2 days off. Continue this cycle for 4 weeks, or until symptoms subside.	1	2026-04-10 20:56:04.197894+00
25	27	Dusting Powder (Yoni Powder)	Combine all the ingredients and mix together using a wire whisk. Spoon some into a jar with a shaker top for easy application. Store the remainder in a glass jar with a tight-fitting lid.	2	2026-04-10 20:56:04.197894+00
26	29	Tincture	Dosage: up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of equal parts of dried Zea mays and Achillea millefolium throughout the day.	1	2026-04-10 20:58:36.064973+00
27	30	Tincture + Infusion	Dosage: up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of Urtica dioica (preferably made from fresh herb) twice a day.	1	2026-04-10 20:58:36.064973+00
28	31	Essential Oil Blend	A combination of equal parts lavender and myrrh essential oils is a long-standing treatment for athlete's foot among aromatherapists in the United Kingdom. Myrrh is fungicidal and lavender is anti-inflammatory and vulnerary. For the first few days of treatment, dissolve the oils in rubbing alcohol and apply to skin until the skin no longer seems moist or weepy. Continue treatment with an ointment or cream containing 3% to 5% essential oil until the skin is completely clear. If the skin is deeply cracked and painful, calendula oil can be valuable as well.	1	2026-04-10 20:58:36.064973+00
29	53	\N	Infuse 1 teaspoon of dried herb mixture in 1 cup of freshly boiled water; drink often until symptoms subside.	1	2026-04-23 16:05:55.110389+00
30	43	A Demulcent Tea for Acute Dry Cough	The infusion presented here, provided by Dr. Rudolf Fritz Weiss in Herbal Medicine, supplies the additional benefit of increased fluid intake. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day	1	2026-04-23 16:06:07.589513+00
31	43	Prescription I to Promote Expectoration	Another approach increases the stimulating expectorant component, making it more appropriate for subacute and chronic bronchitis characterized by excessive sputum production. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day.	2	2026-04-23 16:06:07.589513+00
32	43	Prescription II to Promote Expectoration	An alternative yet equivalent approach for acute dry cough replaces Thymus vulgaris with Pimpinella anisum. This combination also boosts the stimulating expectorant action of the prescription by increasing the proportion of saponin-rich Primula veris. Infuse 2 teaspoons of dry herb combination in 1 cup of boiling water for 20 minutes; drink hot three times a day.	3	2026-04-23 16:06:07.589513+00
33	43	A Prescription to Combat Infection in Acute Bronchitis	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw (one clove a day) or garlic oil taken as a supplement.	4	2026-04-23 16:06:07.589513+00
34	43	Steam Inhalation	Thymus, Eucalyptus, Matricaria, and Origanum are good choices for steam inhalations. Pure plant essential oils may also be used. Volatile oil-rich herbs are effective decongestants and support the internal treatment by addressing some associated symptoms. Add 1 tablespoon of dried herb combination to ½ liter (1 pint) of boiling water. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl. Inhale vapors for 5 to 10 minutes.	5	2026-04-23 16:06:07.589513+00
35	43	Essential Oil Inhalation	In the first stages of acute bronchitis, when the cough is dry and painful, steam inhalation with the oils listed here may provide a great deal of relief. Bergamot and eucalyptus oils are also effective in lowering fever, and all of these oils will help to reinforce the immune response to the infection. Dwarf pine needle oil (Pinus pumilio) has been the main oil used traditionally, but with the growing interest in aromatherapy, many volatile oils are now recognized as valuable remedies for inhalations. Mentha arvensis var. piperascens, the source of "Chinese white flower oil," is especially rich in menthol. Menthol is anti-inflammatory, especially for the mucous membranes of the upper respiratory tract. It stimulates mucous secretions and exerts antimicrobial and mild anaesthetic actions. As with many oils, it is best used at the onset of symptoms. Essential Oil Inhalation: Place 3 to 5 drops of essential oil in a bowl and add boiling water. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl. Inhale for 5 to 10 minutes, keeping the eyes closed to prevent irritation from vapor. Massaging or otherwise applying oils to chest, neck, or back fosters absorption through the skin, technically called percutaneous absorption. Be sure to dilute the oil first in an appropriate carrier oil, such as almond oil. Essential oils absorbed through the skin are often eliminated from the body via the lungs, allowing the constituents to come in contact with the site of lung infection or inflammation. A good technique is to apply the oil and then place a clean dry cloth over the area to ensure that oils are absorbed and do not evaporate.	6	2026-04-23 16:06:07.589513+00
36	56	Essential Oils for Recovery	Applying essential oils in inhalations, baths, and local massage to chest and throat will shorten the time needed for full recovery.	1	2026-04-23 16:06:22.109926+00
37	57	\N	Add 1 teaspoon of dried herb mixture to 1 cup of boiling water and infuse for 20 minutes. Drink hot three times a day. This formulation is designed for a patient who is debilitated and weakened by chronic bronchitis. Thus, it contains a blend of stimulating and relaxing pulmonary tonics. Cetraria has long been used in the United Kingdom (the world capital of chronic bronchitis!) as nutritive support in such cases. To this may be added other herbs appropriate for the individual, such as Crataegus spp., Eleutherococcus senticosus, and Galium aparine.	1	2026-04-23 16:06:22.109926+00
38	57	A Prescription for Chronic Bronchitis with Infection	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw (one clove a day) or garlic oil taken as a supplement.	2	2026-04-23 16:06:22.109926+00
39	57	A Prescription for Chronic Recurrent Bronchitis with Dyspnea	Add 1 part the Dyspnea formula as well. Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw in the diet (one clove a day) or garlic oil taken as a supplement.	3	2026-04-23 16:06:22.109926+00
40	57	A Prescription for Chronic Recurrent Bronchitis with Severe Congestion	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be eaten raw in the diet (one clove a day) or garlic oil taken as a supplement.	4	2026-04-23 16:06:22.109926+00
41	58	A Prescription for Pertussis and Other Paroxysmal Coughs	Infuse 1 teaspoon of dried herb mixture in 1 cup of boiling water for 20 minutes. This should be drunk hot several times a day. Hot infusions are valuable in that they replace lost fluids and promote diaphoresis.	1	2026-04-23 16:06:39.257018+00
42	59	Dyspnea Formula for Asthma	Dosage: 5 ml of mixture three times a day. If Euphorbia pilulifera proves difficult to obtain, double the amount of Grindelia to make up for it.	1	2026-04-23 16:06:39.257018+00
43	59	A Prescription for Childhood Atopic Asthma Associated with Eczema	Add Dyspnea Formula - 2 parts. Dosage: up to 5 ml of tincture three times a day	2	2026-04-23 16:06:39.257018+00
44	60	A Prescription for Emphysema	Add Dyspnea Formula (1 part) Dosage: up to 5 ml of tincture three times a day	1	2026-04-23 16:06:39.257018+00
45	62	A Prescription for the Common Cold	Infuse 1 to 2 teaspoons of dried herb mixture in 1 cup of boiling water, this should be drunk hot often until symptoms pass.	1	2026-04-23 16:06:49.507222+00
46	62	Herbal Footbath for Colds	Footbaths are a traditional treatment for colds. Dissolve 1 tablespoon of mustard powder in 4 pints of hot water. Bathe the feet for 10 minutes, twice a day.	2	2026-04-23 16:06:49.507222+00
47	62	Chamomile Steam Inhalation	Place a handful of Matricaria flowers in a bowl and pour boiling water over them. Create a tent by draping a towel over the head to prevent the escape of vapors; inhale vapors rising from bowl for 5 to 10 minutes.	3	2026-04-23 16:06:49.507222+00
48	62	Steam Inhalation Combination	Add 1 tablespoon of dried herb mixture to ½ liter (1 pint) of boiling water. Follow inhalation instructions given for Chamomile Steam Inhalation.	4	2026-04-23 16:06:49.507222+00
49	62	Essential Oils for Common Cold	It clears congested nasal passages and soothes inflamed mucous membranes. At the same time, the essential oil will kill many bacteria. Some of the oils, especially Eucalyptus and Melaleuca, have an inhibitory effect on the cold virus. Use either of these two oils for inhalations in the earlier part of the day (possibly alternating with Rosmarinus and Mentha piperita), as they are mildly stimulating. At night, use inhalations of Lavandula or add a few drops of oil to a bath. Diffusing oil in the bedroom is helpful, especially if the patient has a cough.	5	2026-04-23 16:06:49.507222+00
50	62	Kitchen Remedy to Ward Off a Cold	Decoct ingredients for 15 minutes in l pint of water; strain. Drink a cupful hot every 2 hours. Sweeten with organic honey to taste.	6	2026-04-23 16:06:49.507222+00
79	77	A Prescription for Neuritis — Internal Use	Dosage: 5 ml of tincture three times a day.	10	2026-04-30 16:30:46.287227+00
51	63	A Prescription for Influenza	Dosage: 2.5 ml of tincture every 2 hours. In addition, the patient should drink a strong hot infusion of Eupatorium perfoliatum every hour. If the symptom picture calls for it, follow recommendations given earlier for the common cold.	1	2026-04-23 16:07:01.735818+00
52	65	A Prescription for Hay Fever	Dosage: 5 ml of tincture three times a day. Ideally, this treatment should be started two months before hay fever season is due to commence. Start with the following dosage regimen. Pre-Hay Fever Season Dosage Regimen: Weeks 1-2: 2.5 ml once a day, Weeks 3-4: 5 ml once a day, Weeks 5-6: 5 ml twice a day, Weeks 7-8: 5 ml three times a day. If this treatment cannot be initiated before the allergy flares up, then start with a full dose immediately, possibly increasing the dose to 5 ml four or five times a day (adults only).	1	2026-04-23 16:07:11.301036+00
53	65	Essential Oils for Hay Fever	Various essential oils can help with symptoms of hay fever, but the specifics vary from person to person. Oils recommended by aromatherapists include all of those listed above for the common cold, with the addition of blue chamomile, lemon balm, and lavender. If steam inhalation makes the patient feel even worse, suggest that the person put some oil on a tissue to sniff whenever needed. A massage with any of these oils can also be helpful.	2	2026-04-23 16:07:11.301036+00
54	66	A Prescription for Sinusitis	Dosage: 5 ml of tincture three times a day	1	2026-04-23 16:07:11.301036+00
55	66	Steam Inhalation for Upper Respiratory Tract	Combine ingredients in a bottle and shake well. Put a teaspoon of the mixture in a bowl and pour on ½ liter (1 pint) boiled water. Cover the head and the bowl with a towel or cloth and inhale. Caution: Keep the eyes closed	2	2026-04-23 16:07:11.301036+00
56	68	A Prescription for Tonsillitis	Dosage: up to 5 ml of tincture three times a day. Diaphoretics should be added if fever is an issue.	1	2026-04-23 16:07:11.301036+00
57	68	Fomentation	Make a strong infusion of dried herb mixture. Dip a cloth in the fomentation and wrap around the neck at night, repeating the procedure each night until the condition clears up.	2	2026-04-23 16:07:11.301036+00
58	70	A Prescription for Acute Stress Reactions	Dosage: up to 5 ml of tincture as needed. The stress response is cyclical, and different times of the day will be more challenging for each person. The dosage may be increased until symptoms are relieved, as this is largely symptomatic medication. The dosage regimen may also be altered as necessary, varying time of day and quantity of dose to suit individual needs.	10	2026-04-30 16:30:20.373726+00
59	70	A Prescription for Acute Stress Reaction with Indigestion and Palpitations	Dosage: up to 5 ml of tincture as needed. Motherwort (Leonurus cardiaca) supports the relaxing action of the other nervines, but also has a specific calming impact upon tachycardia.	20	2026-04-30 16:30:20.373726+00
60	70	A Prescription for Acute Stress Reaction with Associated Muscle Tension	Dosage: up to 5 ml of tincture as needed.	30	2026-04-30 16:30:20.373726+00
61	70	Hot Chamomile Compress for Muscle Tension	Hot chamomile compresses work well to relax painful, tense muscles. Prepare a strong infusion, using a full cup of chamomile flowers and 2 quarts of water. Cover with a lid and allow to steep for about 10 minutes; strain. Dip a towel into the infusion, wring it out, and spread it (as hot as is tolerable) on the back, shoulders, and neck. Repeat the procedure 10 to 20 times, until there is a sense of relaxation and relief of tension.	40	2026-04-30 16:30:20.373726+00
62	71	A Prescription for Moderate Depression	Dosage: up to 5 ml of tincture three times a day for at least 1 month.	10	2026-04-30 16:30:20.373726+00
63	72	A Prescription for Insomnia	Dosage: 5 ml of tincture 30 minutes before bedtime.	10	2026-04-30 16:30:20.373726+00
64	72	A Prescription for Insomnia Associated with Menopausal Problems	Dosage: 5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments.	20	2026-04-30 16:30:20.373726+00
65	72	A Prescription for Insomnia Associated with Indigestion	Dosage: 7.5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments. An infusion of Matricaria, Tilia, or Melissa at night may also be helpful.	30	2026-04-30 16:30:20.373726+00
66	72	A Prescription for Insomnia Associated with Depression	Dosage: 7.5 ml of tincture 30 minutes before bedtime, in addition to appropriate daytime treatments. Note: Avoid the use of Humulus lupulus (hops) in depression.	40	2026-04-30 16:30:20.373726+00
67	72	Relaxing Antidepressant Essential Oil Formula	This can be used as either a massage or a bath oil. Lavender is the primary essential oil used to induce sleep. Always dilute oils before applying to skin: 10 to 12 drops per ounce of carrier oil (2% dilution). For baths, add up to 5 drops to warm water.	50	2026-04-30 16:30:20.373726+00
68	72	Fragrant Insomnia Blend (for diffuser)	Use in a diffuser to promote sleep.	60	2026-04-30 16:30:20.373726+00
69	73	A Prescription to Help with Benzodiazepine Withdrawal	Dosage: 2.5 ml to 5 ml of tincture three times a day.	10	2026-04-30 16:30:34.395192+00
70	74	A Prescription for Anorexia Nervosa	Dosage: 5 ml of tincture 10 to 15 minutes before eating, three times a day.	10	2026-04-30 16:30:34.395192+00
71	75	Essential Oils for Headache	Many essential oils can be used to relieve headache. Particularly effective oils include Lavandula spp., Rosmarinus officinalis, and Mentha piperita, which can be used separately or in combination. Lavandula may be rubbed on the temples or made into a cold compress. Equal parts of Lavandula and Mentha piperita may be even more effective. If headache is caused by catarrh or sinus infection, inhalations will be very effective.	10	2026-04-30 16:30:34.395192+00
72	75	Supportive Nervines for Tension Headaches	A daily supplement of B-complex vitamins and vitamin C is also helpful. Relaxation exercises are invaluable, and the impact of various stressors should be softened.	20	2026-04-30 16:30:34.395192+00
73	75	A Prescription for Tension-Related Headaches	Dosage: 2.5 ml of tincture combination three times a day. If using dried herbs, infuse 2 teaspoons of the mixture in 1 cup of boiling water, drunk three times a day.	30	2026-04-30 16:30:34.395192+00
74	75	A Prescription for Tension Headache with Indigestion and Palpitations	Dosage: 5 ml of tincture mixture three times a day. If using dried herbs, infuse 2 teaspoons of mixture to 1 cup of boiling water, drunk three times a day.	40	2026-04-30 16:30:34.395192+00
75	75	Essential Oil Formula for Headache Relief	Use as a massage or bath oil to relieve headache.	50	2026-04-30 16:30:34.395192+00
76	76	A Prescription for the Prevention of Migraines	Tanacetum parthenium: 125 mg of dried herb taken once daily. Lavandula officinalis: massage essential oil into temples at first sign of an attack.	10	2026-04-30 16:30:46.287227+00
77	76	A Prescription for Migraine Associated with Stress and Hypertension	Dosage: 2.5 ml of tincture three times a day. In addition, the patient should follow instructions given in Prescription for Prevention of Migraine.	20	2026-04-30 16:30:46.287227+00
78	76	A Cooling Compress for Migraine	Pour 1 quart ice-cold water into a 2-quart glass bowl and add the essential oils. Soak a clean cloth in the water and apply it to the head, forehead, or neck at the first sign of a migraine. Do not allow the compress to come into contact with the eyes. An ice pack applied over the compress will help keep it from getting warm.	30	2026-04-30 16:30:46.287227+00
80	77	A Prescription for Neuritis — External Use	Three approaches to minimizing discomfort caused by touch. Gently applying menthol-rich peppermint oil produces a cooling, locally anesthetic effect. Applying infused oil of Hypericum will reduce neurological inflammation. Colloidal oatmeal can act as a dry lubricant between the skin and clothing, minimizing irritation.	20	2026-04-30 16:30:46.287227+00
81	77	Essential Oils for Pain	Combine ingredients and use for massage.	30	2026-04-30 16:30:46.287227+00
82	78	A Prescription for Tinnitus	Dosage: up to 5 ml of tincture three times a day.	10	2026-04-30 16:30:46.287227+00
83	79	A Prescription for Motion Sickness	Dosage: 5 ml of tincture 20 minutes before travel. In addition, the patient should eat a small piece of candied ginger just before travel and as needed.	10	2026-04-30 16:30:46.287227+00
84	80	A Prescription for Shingles	Dosage: up to 5 ml of tincture four times a day. Topical application of Mentha piperita oil may reduce pain through a mild, local numbing effect (do not use if skin is extremely sensitive). Colloidal oatmeal powder may be dusted on affected skin to minimize pain caused by contact with clothes.	10	2026-04-30 16:30:46.287227+00
85	82	A Prescription for Hypertension	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	10	2026-05-17 19:20:07.593885+00
86	82	A Prescription for Hypertension with a Major Stress Component	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	20	2026-05-17 19:20:07.593885+00
87	82	A Prescription for Hypertension with Associated Headache	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	30	2026-05-17 19:20:07.593885+00
88	82	A Prescription for Hypertension with Palpitations	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	40	2026-05-17 19:20:07.593885+00
89	82	A Prescription for Hypertension with Debility	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	50	2026-05-17 19:20:07.593885+00
90	82	A Prescription for Hypertension with Indigestion	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	60	2026-05-17 19:20:07.593885+00
91	82	A Prescription for Hypertension with Bronchitis	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	70	2026-05-17 19:20:07.593885+00
92	82	A Prescription for Hypertension with Premenstrual Syndrome	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	80	2026-05-17 19:20:07.593885+00
93	83	A Prescription for Atherosclerosis	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	10	2026-05-17 19:20:07.593885+00
94	84	A Prescription for Mild Congestive Heart Failure	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	10	2026-05-17 19:20:07.593885+00
95	85	A Prescription for Angina	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day. In addition, the patient can take 5 ml of Crataegus tincture at the first sign of an angina attack. This will not replace the use of prescription medication.	10	2026-05-17 19:20:07.593885+00
96	86	A Prescription for Peripheral Arterial Disease	Dosage: up to 5 ml of tincture three times a day. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	10	2026-05-17 19:20:07.593885+00
97	87	A Prescription for Varicose Veins	Dosage: up to 5 ml of tincture three times a day.	10	2026-05-17 19:20:07.593885+00
98	87	Varicose Veins Lotion for External Use	Apply liberally as needed to ease irritation and discomfort. Rose water or another floral water may be added to make the lotion more cosmetically pleasing.	20	2026-05-17 19:20:07.593885+00
101	90	A Prescription for Amenorrhea Associated with Hormonal Imbalance	Dosage: 2 ml of tincture three times a day until period starts.	10	2026-06-07 19:28:17.415064+00
102	90	A Prescription for Amenorrhea Associated with Stress	Dosage: 2.5 ml of tincture three times a day until period starts.	20	2026-06-07 19:28:17.415064+00
103	91	A Prescription for Dysmenorrhea	Dosage: 5 ml of tincture as needed.	10	2026-06-07 19:28:17.415064+00
104	91	A Prescription for Dysmenorrhea Associated with Pelvic Lesions	Dosage: 5 ml of tincture three times a day. The addition of Dioscorea villosa will provide a more reliable antispasmodic action if a physical problem is present. This prescription will support, but not replace, whatever treatment is necessary for the underlying problem.	20	2026-06-07 19:28:17.415064+00
105	92	A Prescription for Acute PMS Symptoms	Dosage: 5 ml of tincture as needed to alleviate symptoms. The dosage may be increased until the desired relief is experienced. The regimen may be altered as necessary, varying time of day and quantity of dose to suit the individual's needs. Always treat the human being, not the theory about the condition.	10	2026-06-07 19:28:17.415064+00
106	92	A Supportive Prescription to Normalize Hormone Levels	Dosage: 5 ml of tincture once a day throughout cycle. Use in combination with the prescription for symptomatic relief.	20	2026-06-07 19:28:17.415064+00
107	92	A Prescription for PMS Associated with Transitory Skin Problems	Dosage: 5 ml of tincture as needed to alleviate symptoms. Use in combination with the Prescription to Normalize Hormone Levels.	30	2026-06-07 19:28:17.415064+00
108	93	A Prescription for Easing Menopause Symptoms	Dosage: 5 ml of tincture three times a day.	10	2026-06-07 19:28:17.415064+00
109	93	A Prescription for Menopause Symptoms with Anxiety and Tachycardia	Dosage: up to 5 ml of tincture three times a day.	20	2026-06-07 19:28:17.415064+00
110	95	A Prescription to Help Prevent Miscarriage	Dosage: 2.5 ml of tincture three times a day, building up to 5 ml three times a day.	10	2026-06-07 19:28:17.415064+00
111	96	A Prescription for Morning Sickness	Dosage: 2.5 ml of tincture at night and in the morning, building up to 5 ml if needed.	10	2026-06-07 19:28:17.415064+00
112	96	A Supplemental Infusion for Morning Sickness	Dosage: Infuse 1 teaspoon of dried herb mixture in 1 cup of boiling water. Drink often during the day.	20	2026-06-07 19:28:17.415064+00
113	114	A Prescription for Uterine Fibroids	Dosage: 2.5 ml of tincture three times a day. This formula can be made stronger by adding more antispasmodic or astringent remedies.	10	2026-06-07 19:28:17.415064+00
114	115	A Prescription for Endometriosis	Dosage: 5 ml of tincture three times a day.	10	2026-06-07 19:28:17.415064+00
115	116	A Prescription for Fibrocystic Breast Disease	Dosage: 2.5 ml of tincture three times a day. In addition, the patient should take evening primrose oil (Oenothera biennis) at a dosage of five 500 mg capsules a day.	10	2026-06-07 19:28:17.415064+00
116	117	A Prescription for Benign Prostatic Hypertrophy (Internal)	Dosage: up to 5 ml of tincture three times a day.	10	2026-06-07 19:28:17.415064+00
117	117	An Infusion for Benign Prostatic Hypertrophy (Sitz Bath)	Dosage: Infuse 2 oz of the mixture to each 1 pint of boiling water. Add infusion to sitz bath.	20	2026-06-07 19:28:17.415064+00
122	130	A Prescription for Urinary Frequency Associated with Infection	Infuse 2 teaspoons of dry herb mixture in 1 cup of boiling water; drink 1 cup every hour until symptoms subside.	10	2026-06-21 16:44:38.744675+00
123	131	A Prescription for Dysuria	Infuse 2 teaspoons of dried herb mixture in 1 cup of boiling water; drink 1 cup every hour until the symptoms subside.	10	2026-06-21 16:44:38.744675+00
124	132	A Prescription for Hematuria	Infuse 2 teaspoons of dried herb mixture to 1 cup of boiling water; drink 1 cup every 2 hours.	10	2026-06-21 16:44:38.744675+00
125	133	A Prescription for Edema	2.5 ml of tincture three times a day or 5 ml of tincture when needed, but not at night.	10	2026-06-21 16:44:38.744675+00
126	134	A Prescription for Cystitis	5 ml of tincture three times a day. Infusion of Achillea millefolium (preferably fresh) should be drunk often.	10	2026-06-21 16:44:38.744675+00
127	134	A Prescription for Cystitis with Pain and Discomfort	5 ml of tincture three times a day. An infusion of Achillea millefolium (preferably fresh) should be drunk often.	20	2026-06-21 16:44:38.744675+00
128	134	Cystitis Infusion	Hot infusions can ease symptoms dramatically. A combination recommended by British medical herbalist Annie McIntyre. Add 1 teaspoon of this mixture to 1 cup of boiling water and infuse for 10 to 15 minutes. Drink hot four to five times a day.	30	2026-06-21 16:44:38.744675+00
129	135	A Prescription for Kidney Stones	Up to 5 ml of tincture three times a day.	10	2026-06-21 16:44:38.744675+00
130	136	A Prescription for Eczema	Up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day.	10	2026-06-21 16:54:56.148727+00
131	136	A Prescription for Persistent Eczema Unresponsive to Mild Alteratives	2.5 ml of tincture three times a day; build up to 5 ml three times a day. In addition, the patient should drink an infusion of fresh or dried Urtica dioica two or three times a day. Care should be taken initially with Scrophularia nodosa, as it can produce the opposite of the desired result in some patients. If there is a flare-up of the skin eruption, cut down on the Scrophularia and try again. This is not a healing crisis!	20	2026-06-21 16:54:56.148727+00
132	136	A Prescription for Atopic Eczema Associated with Asthma	Add 1 part Dyspnea Formula as well. Up to 5 ml of tincture three times a day. The relative proportion of alterative herbs to Dyspnea Formula will depend upon the patient's specific needs. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day.	30	2026-06-21 16:54:56.148727+00
133	137	A Prescription for Psoriasis	Up to 5 ml of tincture three times a day. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day.	10	2026-06-21 16:54:56.148727+00
134	137	A Prescription for Psoriasis with Anxiety and Tension	Up to 5 ml of tincture three times a day. The patient should also drink an infusion of Matricaria recutita as desired.	20	2026-06-21 16:54:56.148727+00
135	137	A Prescription for Intransigent, Unresponsive Psoriasis	5 ml of tincture three times a day. In addition, the patient should drink an infusion of fresh Urtica dioica or Galium aparine two or three times a day. Care must be taken with this combination, and it is not advisable for children because of the inclusion of Phytolacca americana (poke root).	30	2026-06-21 16:54:56.148727+00
136	137	A Prescription for a Patient with Psoriasis and Hypertension	5 ml of tincture three times a day. The patient should also drink an infusion of Matricaria recutita, Tilia platyphyllos, or Trifolium pratense as desired. Allium sativum should be added to the diet or used as a dietary supplement: 1 clove of fresh garlic or 200 to 300 mg of standardized extract three times a day.	40	2026-06-21 16:54:56.148727+00
137	138	A Prescription for Acne	Up to 5 ml of tincture three times a day. The patient should also drink an infusion of Urtica dioica two or three times a day. In addition, apply Calendula officinalis topically as a wash, in the form of an infusion mixed with distilled Hamamelis virginiana (witch hazel).	10	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: disorder_specific_remedies; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.disorder_specific_remedies (id, disorder_id, herb_id, description, sort_order, created_at) FROM stdin;
1	2	75	May well be the best gentle overall treatment for diarrhea, as it seems to tone the lining of the small intestine	1	2026-04-06 21:33:58.34407+00
2	2	148	Excellent remedy	2	2026-04-06 21:33:58.34407+00
3	2	219	Excellent remedy	3	2026-04-06 21:33:58.34407+00
4	2	52	Excellent remedy	4	2026-04-06 21:33:58.34407+00
5	2	153	Stronger astringent, should be used only as a last resort	5	2026-04-06 21:33:58.34407+00
6	3	56	This is a variety of ordinary sage that contains a stronger volatile oil. While it is rarely used in cooking, it makes a perfect herb to use as a mouthwash for aphthous ulcers and other inflammatory conditions of the mouth.	1	2026-04-06 21:33:58.34407+00
7	4	99	May be considered a specific remedy here, as it has powerful antimicrobial effects against the pathogens that cause gum disease.	1	2026-04-06 21:33:58.34407+00
8	4	220	An astringent herb from Peru, has proved uniquely effective for gum disease. Some proprietary herbal toothpastes can help support treatment	2	2026-04-06 21:33:58.34407+00
9	7	89		1	2026-04-06 21:33:58.34407+00
10	7	45		2	2026-04-06 21:33:58.34407+00
11	7	75		3	2026-04-06 21:33:58.34407+00
12	7	70		4	2026-04-06 21:33:58.34407+00
13	7	84		5	2026-04-06 21:33:58.34407+00
14	8	89	Symphytum has an especially valid role because of its content of allantoin, a constituent that promotes wound healing.	1	2026-04-06 21:33:58.34407+00
15	8	45		2	2026-04-06 21:33:58.34407+00
16	8	75		3	2026-04-06 21:33:58.34407+00
17	8	70		4	2026-04-06 21:33:58.34407+00
18	8	84		5	2026-04-06 21:33:58.34407+00
19	9	102		1	2026-04-06 21:33:58.34407+00
20	9	55		2	2026-04-06 21:33:58.34407+00
21	9	84		3	2026-04-06 21:33:58.34407+00
22	9	134		4	2026-04-06 21:33:58.34407+00
23	9	129		5	2026-04-06 21:33:58.34407+00
24	9	145		6	2026-04-06 21:33:58.34407+00
25	10	84	can have a direct impact on IBS	1	2026-04-06 21:56:12.487259+00
26	10	55	can have a direct impact on IBS	2	2026-04-06 21:56:12.487259+00
27	10	119	astringent	3	2026-04-06 21:56:12.487259+00
28	10	89	wound-healing remedy	4	2026-04-06 21:56:12.487259+00
29	10	85	wound-healing remedy	5	2026-04-06 21:56:12.487259+00
30	10	74	colic-relieving antispasmodic	6	2026-04-06 21:56:12.487259+00
31	12	74	is a very useful specific here. It is a good antispasmodic and anti-inflammatory herb, but also has a specific impact upon this condition.	1	2026-04-06 21:56:12.487259+00
32	13	122		1	2026-04-06 21:56:12.487259+00
33	13	206		2	2026-04-06 21:56:12.487259+00
34	13	171		3	2026-04-06 21:56:12.487259+00
35	13	17		4	2026-04-06 21:56:12.487259+00
36	13	78		5	2026-04-06 21:56:12.487259+00
37	14	122	In Europe, has traditionally been considered specific	1	2026-04-06 21:56:27.332838+00
38	14	146	In Europe, has traditionally been considered specific	2	2026-04-06 21:56:27.332838+00
39	14	206	because can help regenerate liver cells, this herb can help ensure that bile buildup does not cause hepatotoxicity	3	2026-04-06 21:56:27.332838+00
40	14	24		4	2026-04-06 21:56:27.332838+00
41	14	175		5	2026-04-06 21:56:27.332838+00
42	14	171		6	2026-04-06 21:56:27.332838+00
43	15	206	Because of its regenerative potential, comes closest to being a textbook specific	1	2026-04-06 21:56:27.332838+00
44	15	122	The tonic hepatics are all relevant	2	2026-04-06 21:56:27.332838+00
45	15	176	The tonic hepatics are all relevant	3	2026-04-06 21:56:27.332838+00
46	15	24	The tonic hepatics are all relevant	4	2026-04-06 21:56:27.332838+00
47	15	175	The tonic hepatics are all relevant	5	2026-04-06 21:56:27.332838+00
48	15	171	The tonic hepatics are all relevant	6	2026-04-06 21:56:27.332838+00
49	16	81	The use in this kind of viral infection is worth exploring. The compounds hypericin and pseudohypericin are known to disrupt viral replication by damaging the integrity of the lipid envelope.	1	2026-04-06 21:56:27.332838+00
50	17	206	comes closest to being a textbook specific, because of its regenerative potential. This wonderful remedy is essential to any treatment of cirrhosis.	1	2026-04-06 21:56:27.332838+00
51	17	122	the tonic hepatic herbs are all relevant	2	2026-04-06 21:56:27.332838+00
52	17	176	the tonic hepatic herbs are all relevant	3	2026-04-06 21:56:27.332838+00
53	17	24	the tonic hepatic herbs are all relevant	4	2026-04-06 21:56:27.332838+00
54	17	175	the tonic hepatic herbs are all relevant	5	2026-04-06 21:56:27.332838+00
55	17	171	the tonic hepatic herbs are all relevant	6	2026-04-06 21:56:27.332838+00
56	17	30	may be useful	7	2026-04-06 21:56:27.332838+00
57	17	172	may be useful	8	2026-04-06 21:56:27.332838+00
58	20	228	In Europe, nothing matches the action of the aptly named pilewort! Apart from this plant, most astringent or anti-inflammatory herbs will help if applied topically.	1	2026-04-06 21:56:27.332838+00
59	29	46	useful antimicrobial	1	2026-04-10 20:58:36.064973+00
60	29	181	useful antimicrobial	2	2026-04-10 20:58:36.064973+00
61	29	179	useful antimicrobial	3	2026-04-10 20:58:36.064973+00
62	29	186	useful prostatic tonic	4	2026-04-10 20:58:36.064973+00
63	29	296	useful prostatic tonic	5	2026-04-10 20:58:36.064973+00
64	29	144		6	2026-04-10 20:58:36.064973+00
65	29	40		7	2026-04-10 20:58:36.064973+00
66	30	31		1	2026-04-10 20:58:36.064973+00
67	30	32		2	2026-04-10 20:58:36.064973+00
68	30	35		3	2026-04-10 20:58:36.064973+00
69	30	36		4	2026-04-10 20:58:36.064973+00
70	31	21		1	2026-04-10 20:58:36.064973+00
71	31	99	myrrh essential oil	2	2026-04-10 20:58:36.064973+00
72	31	302	tea tree oil	3	2026-04-10 20:58:36.064973+00
73	32	22		1	2026-04-10 20:58:36.064973+00
74	32	70		2	2026-04-10 20:58:36.064973+00
75	32	28		3	2026-04-10 20:58:36.064973+00
76	32	30		4	2026-04-10 20:58:36.064973+00
77	32	31		5	2026-04-10 20:58:36.064973+00
78	32	32		6	2026-04-10 20:58:36.064973+00
79	32	35		7	2026-04-10 20:58:36.064973+00
80	32	37		8	2026-04-10 20:58:36.064973+00
81	32	38		9	2026-04-10 20:58:36.064973+00
82	32	39		10	2026-04-10 20:58:36.064973+00
83	32	41		11	2026-04-10 20:58:36.064973+00
84	32	201		12	2026-04-10 20:58:36.064973+00
85	32	42		13	2026-04-10 20:58:36.064973+00
86	32	43		14	2026-04-10 20:58:36.064973+00
87	32	198		15	2026-04-10 20:58:36.064973+00
88	32	211		16	2026-04-10 20:58:36.064973+00
89	1	78		1	2026-04-12 15:51:43.814357+00
90	2	78		1	2026-04-12 15:51:43.814357+00
91	33	26		1	2026-04-12 15:59:34.804125+00
92	33	309		2	2026-04-12 15:59:34.804125+00
93	33	61	external, flower oil	3	2026-04-12 15:59:34.804125+00
94	34	26		1	2026-04-12 15:59:34.804125+00
95	34	78		2	2026-04-12 15:59:34.804125+00
96	34	21		3	2026-04-12 15:59:34.804125+00
97	34	56	essential oil, gargle	5	2026-04-12 15:59:34.804125+00
98	35	57	flowers	1	2026-04-12 15:59:34.804125+00
99	35	55		2	2026-04-12 15:59:34.804125+00
100	35	309		3	2026-04-12 15:59:34.804125+00
102	35	59	inhalant	6	2026-04-12 15:59:34.804125+00
103	36	28		1	2026-04-12 15:59:34.804125+00
104	36	57	flowers	2	2026-04-12 15:59:34.804125+00
105	36	313		3	2026-04-12 15:59:34.804125+00
106	36	26		4	2026-04-12 15:59:34.804125+00
107	36	35	root	6	2026-04-12 15:59:34.804125+00
108	37	26		1	2026-04-12 15:59:34.804125+00
109	37	28		2	2026-04-12 15:59:34.804125+00
110	37	30		3	2026-04-12 15:59:34.804125+00
111	37	21		4	2026-04-12 15:59:34.804125+00
112	37	99		5	2026-04-12 15:59:34.804125+00
113	38	55		1	2026-04-12 15:59:34.804125+00
114	38	26		2	2026-04-12 15:59:34.804125+00
115	38	57		3	2026-04-12 15:59:34.804125+00
116	38	145		4	2026-04-12 15:59:34.804125+00
117	39	26		1	2026-04-12 15:59:34.804125+00
118	39	28		2	2026-04-12 15:59:34.804125+00
119	39	21		3	2026-04-12 15:59:34.804125+00
120	39	55		4	2026-04-12 15:59:34.804125+00
121	39	44		5	2026-04-12 15:59:34.804125+00
122	40	21		1	2026-04-12 15:59:34.804125+00
123	40	78		2	2026-04-12 15:59:34.804125+00
124	40	28		3	2026-04-12 15:59:34.804125+00
125	40	26		4	2026-04-12 15:59:34.804125+00
126	41	140	bark	1	2026-04-12 15:59:34.804125+00
127	41	78		2	2026-04-12 15:59:34.804125+00
128	41	55		3	2026-04-12 15:59:34.804125+00
129	42	99		1	2026-04-12 15:59:34.804125+00
130	42	47	gargle	2	2026-04-12 15:59:34.804125+00
131	43	26		1	2026-04-12 15:59:34.804125+00
132	43	54		2	2026-04-12 15:59:34.804125+00
133	43	78		3	2026-04-12 15:59:34.804125+00
134	43	57	flower	4	2026-04-12 15:59:34.804125+00
135	43	124	compress	5	2026-04-12 15:59:34.804125+00
136	44	21		1	2026-04-12 15:59:34.804125+00
137	44	54		2	2026-04-12 15:59:34.804125+00
138	44	44		3	2026-04-12 15:59:34.804125+00
139	44	78		4	2026-04-12 15:59:34.804125+00
140	44	145		5	2026-04-12 15:59:34.804125+00
141	44	26		6	2026-04-12 15:59:34.804125+00
142	45	92	as a gruel	1	2026-04-12 15:59:34.804125+00
143	45	124		2	2026-04-12 15:59:34.804125+00
144	45	136		3	2026-04-12 15:59:34.804125+00
147	48	55		1	2026-04-12 15:59:34.804125+00
148	48	124		2	2026-04-12 15:59:34.804125+00
149	48	65		3	2026-04-12 15:59:34.804125+00
150	48	45		4	2026-04-12 15:59:34.804125+00
151	48	320	leaf	6	2026-04-12 15:59:34.804125+00
152	49	57	flowers	1	2026-04-12 15:59:34.804125+00
153	49	55		2	2026-04-12 15:59:34.804125+00
154	49	44		3	2026-04-12 15:59:34.804125+00
155	49	136		4	2026-04-12 15:59:34.804125+00
156	49	26		5	2026-04-12 15:59:34.804125+00
157	50	178		1	2026-04-12 15:59:34.804125+00
158	50	26		2	2026-04-12 15:59:34.804125+00
159	50	88	external, as a wash	3	2026-04-12 15:59:34.804125+00
160	51	136		2	2026-04-12 15:59:34.804125+00
161	51	128		3	2026-04-12 15:59:34.804125+00
162	55	21	Antimicrobial and immune support	1	2026-04-23 16:06:07.589513+00
163	55	45	Demulcent and soothing	2	2026-04-23 16:06:07.589513+00
164	55	67	Relaxing expectorant	3	2026-04-23 16:06:07.589513+00
165	55	192	Stimulating expectorant	4	2026-04-23 16:06:07.589513+00
166	55	48	Demulcent and nutritive	5	2026-04-23 16:06:07.589513+00
167	55	49	Demulcent	6	2026-04-23 16:06:07.589513+00
168	55	126	Antispasmodic	7	2026-04-23 16:06:07.589513+00
169	55	78	Anti-inflammatory and expectorant	8	2026-04-23 16:06:07.589513+00
170	55	30	Antimicrobial and anticatarrhal	9	2026-04-23 16:06:07.589513+00
171	55	53	Anticatarrhal and expectorant	10	2026-04-23 16:06:07.589513+00
172	55	54	Pulmonary tonic and expectorant	11	2026-04-23 16:06:07.589513+00
173	55	104	Excellent specific for tracheobronchitis	12	2026-04-23 16:06:07.589513+00
174	55	132	Antispasmodic and expectorant	13	2026-04-23 16:06:07.589513+00
175	55	160	Expectorant	14	2026-04-23 16:06:07.589513+00
176	55	108	Antimicrobial and antispasmodic	15	2026-04-23 16:06:07.589513+00
178	55	195	Stimulating expectorant	17	2026-04-23 16:06:07.589513+00
180	55	197	Expectorant	19	2026-04-23 16:06:07.589513+00
181	55	200	Pulmonary tonic	20	2026-04-23 16:06:07.589513+00
182	55	38	Stimulating expectorant	21	2026-04-23 16:06:07.589513+00
183	55	89	Demulcent	22	2026-04-23 16:06:07.589513+00
184	55	143	Antispasmodic	23	2026-04-23 16:06:07.589513+00
185	55	59	Antimicrobial	24	2026-04-23 16:06:07.589513+00
186	55	91	Demulcent expectorant	25	2026-04-23 16:06:07.589513+00
187	55	60	Pulmonary tonic and expectorant	26	2026-04-23 16:06:07.589513+00
188	55	61	Pulmonary tonic and expectorant	27	2026-04-23 16:06:07.589513+00
189	55	146	Nervine support	28	2026-04-23 16:06:07.589513+00
190	55	198	Expectorant	29	2026-04-23 16:06:07.589513+00
191	56	61	Toning remedy for lungs	1	2026-04-23 16:06:22.109926+00
192	56	160	Useful lung remedy with valuable bitter properties	2	2026-04-23 16:06:22.109926+00
193	58	126	Traditional specific for pertussis	1	2026-04-23 16:06:39.257018+00
194	58	59	Antimicrobial support	2	2026-04-23 16:06:39.257018+00
195	58	441	Traditional remedy	3	2026-04-23 16:06:39.257018+00
196	58	140	Antispasmodic and cough suppressant	4	2026-04-23 16:06:39.257018+00
198	59	448	Exceptionally useful bronchodilator, better tolerated than synthetic ephedrine	1	2026-04-23 16:06:39.257018+00
199	59	162	Ayurvedic herb useful for bronchial muscle relaxation	2	2026-04-23 16:06:39.257018+00
200	59	450	Antispasmodic and bronchodilator	3	2026-04-23 16:06:39.257018+00
201	59	126	Antispasmodic effects	4	2026-04-23 16:06:39.257018+00
202	59	338	Antispasmodic and bronchodilator	5	2026-04-23 16:06:39.257018+00
203	59	199	Antispasmodic and expectorant	6	2026-04-23 16:06:39.257018+00
204	59	140	Antispasmodic effects	7	2026-04-23 16:06:39.257018+00
205	59	53	Antispasmodic oil for acute crisis inhalation	8	2026-04-23 16:06:39.257018+00
206	59	82	Antispasmodic oil for acute crisis inhalation	9	2026-04-23 16:06:39.257018+00
207	59	108	Antispasmodic oil for acute crisis inhalation	10	2026-04-23 16:06:39.257018+00
208	59	469	Antispasmodic oil for acute crisis inhalation	11	2026-04-23 16:06:39.257018+00
209	59	109	Antispasmodic oil for acute crisis inhalation	12	2026-04-23 16:06:39.257018+00
210	61	51	Tonic with anti-catarrhal properties	1	2026-04-23 16:06:49.507222+00
211	61	30	Tonic with anti-catarrhal properties	2	2026-04-23 16:06:49.507222+00
212	61	53	Tonic with anti-catarrhal properties	3	2026-04-23 16:06:49.507222+00
213	61	57	Tonic with anti-catarrhal properties	4	2026-04-23 16:06:49.507222+00
214	61	58	Tonic with anti-catarrhal properties	5	2026-04-23 16:06:49.507222+00
215	61	43	Tonic with anti-catarrhal properties	6	2026-04-23 16:06:49.507222+00
216	62	44	Diaphoretic and antimicrobial	1	2026-04-23 16:06:49.507222+00
217	62	473	Antimicrobial	2	2026-04-23 16:06:49.507222+00
218	62	113	Stimulating antimicrobial	3	2026-04-23 16:06:49.507222+00
219	62	116	Stimulating and warming	4	2026-04-23 16:06:49.507222+00
221	62	50	Best for aches and pains with fever	6	2026-04-23 16:06:49.507222+00
222	62	84	Anti-inflammatory and calming	7	2026-04-23 16:06:49.507222+00
223	62	55	Relieves discomfort	8	2026-04-23 16:06:49.507222+00
224	62	57	Diaphoretic and anticatarrhal	9	2026-04-23 16:06:49.507222+00
225	62	90	Diaphoretic and cardiotonic	10	2026-04-23 16:06:49.507222+00
226	62	26	Immune support and antimicrobial	11	2026-04-23 16:06:49.507222+00
228	62	30	Speeds recovery from infection	13	2026-04-23 16:06:49.507222+00
229	62	59	Antimicrobial for steam inhalations	14	2026-04-23 16:06:49.507222+00
230	63	50	Favorite diaphoretic for flu, especially effective	1	2026-04-23 16:07:01.735818+00
231	65	448	Bronchodilator, effective for allergic reactions	1	2026-04-23 16:07:11.301036+00
232	65	450	Similar to Ephedra, from Ayurveda and unani medicine	2	2026-04-23 16:07:11.301036+00
233	65	51	Eases eye distress	3	2026-04-23 16:07:11.301036+00
234	67	570	Essential oil for gargle, eases inflammation	1	2026-04-23 16:07:11.301036+00
235	67	407	Essential oil for gargle, eases inflammation	2	2026-04-23 16:07:11.301036+00
236	68	28	Famous specific for tonsillitis in UK	1	2026-04-23 16:07:11.301036+00
237	69	9	Adaptogen	10	2026-04-30 16:30:20.373726+00
238	69	14	Adaptogen	20	2026-04-30 16:30:20.373726+00
239	69	20	Adaptogen	30	2026-04-30 16:30:20.373726+00
240	70	137	Nervine Relaxant	10	2026-04-30 16:30:20.373726+00
241	70	145	Nervine Relaxant	20	2026-04-30 16:30:20.373726+00
242	70	138	Nervine Relaxant	30	2026-04-30 16:30:20.373726+00
243	70	130	Nervine Relaxant	40	2026-04-30 16:30:20.373726+00
244	71	81	Hypericum perforatum (St. John's wort) has a long tradition of use. This herb requires time to work, and so must be taken for at least a month.	10	2026-04-30 16:30:20.373726+00
245	72	131	By choosing herbs that address the specific health issues compounding the sleep difficulties, better results are obtained than if one simply chooses a strong hypnotic. If a patient with insomnia also has heart palpitations, Leonurus cardiaca would be a good choice of nervine.	10	2026-04-30 16:30:20.373726+00
246	73	178	Primary Relaxing and Tonic Nervine for Withdrawal	10	2026-04-30 16:30:34.395192+00
247	73	137	Primary Relaxing and Tonic Nervine for Withdrawal	20	2026-04-30 16:30:34.395192+00
248	73	142	Primary Relaxing and Tonic Nervine for Withdrawal	30	2026-04-30 16:30:34.395192+00
249	73	145	Primary Relaxing and Tonic Nervine for Withdrawal	40	2026-04-30 16:30:34.395192+00
250	74	146	Bitters are considered specifics here, but especially Verbena officinalis (vervain), a relaxing nervine with marked hepatic properties.	10	2026-04-30 16:30:34.395192+00
251	75	97	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	10	2026-04-30 16:30:34.395192+00
252	75	47	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	20	2026-04-30 16:30:34.395192+00
253	75	82	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	30	2026-04-30 16:30:34.395192+00
254	75	84	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	40	2026-04-30 16:30:34.395192+00
255	75	134	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	50	2026-04-30 16:30:34.395192+00
256	75	55	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	60	2026-04-30 16:30:34.395192+00
258	75	139	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	80	2026-04-30 16:30:34.395192+00
259	75	109	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	90	2026-04-30 16:30:34.395192+00
260	75	110	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	100	2026-04-30 16:30:34.395192+00
261	75	57	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	110	2026-04-30 16:30:34.395192+00
262	75	142	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	120	2026-04-30 16:30:34.395192+00
264	75	59	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	140	2026-04-30 16:30:34.395192+00
265	75	145	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	150	2026-04-30 16:30:34.395192+00
266	76	121	The most important herb for migraine prevention. Feverfew is a long-term treatment, not an immediate cure for a migraine attack.	10	2026-04-30 16:30:46.287227+00
267	78	25	Specific remedy for tinnitus, particularly noise-induced tinnitus.	10	2026-04-30 16:30:46.287227+00
268	78	30	Specific remedy for tinnitus.	20	2026-04-30 16:30:46.287227+00
269	78	165	May help improve inner ear problems resulting from disturbance in blood supply.	30	2026-04-30 16:30:46.287227+00
270	79	124	Primary specific for motion sickness — more effective than Dramamine per Lancet research.	10	2026-04-30 16:30:46.287227+00
271	79	212	Also reduces nausea from motion sickness.	20	2026-04-30 16:30:46.287227+00
280	55	196	Expectorant	18	2026-05-17 16:15:06.755767+00
281	62	47	Stimulating circulatory	5	2026-05-17 16:15:06.755767+00
282	35	101	inhalant	5	2026-05-17 16:15:06.755767+00
283	62	101	Antimicrobial for steam inhalations	12	2026-05-17 16:15:06.755767+00
284	75	107	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	70	2026-05-17 16:15:06.755767+00
285	55	85	Soothing expectorant	16	2026-05-17 16:15:06.755767+00
286	58	184	Traditional remedy	5	2026-05-17 16:15:06.755767+00
287	75	207	Anti-inflammatory and antispasmodic herbs that alleviate processes underlying muscle contractions and tension headaches.	130	2026-05-17 16:15:06.755767+00
288	81	877	Guggulipid is gaining a reputation for reducing high blood cholesterol. As antioxidants, guggulsterones keep LDL from oxidizing, protecting against atherosclerosis.	10	2026-05-17 19:20:07.593885+00
289	81	21	Significantly reduces serum cholesterol levels and possesses antiplatelet effects. Its cholesterol-lowering action appears unaffected by cooking.	20	2026-05-17 19:20:07.593885+00
290	81	47	Capsaicin-containing plants may help lower blood cholesterol levels.	30	2026-05-17 19:20:07.593885+00
291	81	91	May help lower blood cholesterol levels.	40	2026-05-17 19:20:07.593885+00
292	81	98	An aromatic spice with demonstrable cholesterol-lowering properties.	50	2026-05-17 19:20:07.593885+00
293	81	882	An Asian herbal remedy proving its value in reducing elevated cholesterol.	60	2026-05-17 19:20:07.593885+00
294	81	274	An Asian herbal remedy proving its value in reducing elevated cholesterol.	70	2026-05-17 19:20:07.593885+00
295	81	208	Has an international reputation for lowering blood pressure and improving cardiovascular health.	80	2026-05-17 19:20:07.593885+00
296	81	885	Reputed to have cholesterol-lowering properties.	90	2026-05-17 19:20:07.593885+00
297	81	203	Reputed to have cholesterol-lowering properties.	100	2026-05-17 19:20:07.593885+00
298	81	14	Reputed to have cholesterol-lowering properties.	110	2026-05-17 19:20:07.593885+00
299	82	73	The most important hypotensive plant remedy in Western medicine.	10	2026-05-17 19:20:07.593885+00
300	82	90	Probably the second most important hypotensive plant remedy in Western medicine. Especially indicated when anxiety and tension are part of the spectrum.	20	2026-05-17 19:20:07.593885+00
301	82	211	A well-known plant that may be considered specific for hypertension.	30	2026-05-17 19:20:07.593885+00
302	82	106	Another well-known plant that may be considered specific for hypertension.	40	2026-05-17 19:20:07.593885+00
303	82	892	If headaches are part of the picture, include this as part of the prescription.	50	2026-05-17 19:20:07.593885+00
304	82	131	If there are associated heart palpitations, add this herb.	60	2026-05-17 19:20:07.593885+00
305	84	73	A primary cardiotonic specific for supporting the heart in congestive heart failure.	10	2026-05-17 19:20:07.593885+00
306	84	90	Supports the cardiovascular system and addresses associated anxiety and tension.	20	2026-05-17 19:20:07.593885+00
307	84	21	Supports overall cardiovascular health and helps address associated hypertension.	30	2026-05-17 19:20:07.593885+00
308	84	162	Coleus forskohlii and its diterpene constituent forskolin can lower blood pressure while improving the contractility of the heart.	40	2026-05-17 19:20:07.593885+00
309	85	73	Studies show Crataegus may inhibit the progression of atherosclerosis, increase coronary perfusion, and confer mild hypotensive effects.	10	2026-05-17 19:20:07.593885+00
310	85	956	Used in traditional Chinese medicine as a circulatory stimulant, sedative, and cooling agent. It has been shown to dilate coronary arteries and has a protective action against myocardial ischemia.	20	2026-05-17 19:20:07.593885+00
311	86	73	Crataegus, Aesculus, and Ginkgo may all be considered specifics for this problem.	10	2026-05-17 19:20:07.593885+00
312	86	62	Has been the subject of numerous clinical studies on the treatment of this condition. A meta-analysis concluded the herb was efficacious and safe.	20	2026-05-17 19:20:07.593885+00
313	86	165	Useful for treating peripheral vascular disease including diabetic retinopathy and intermittent claudication. Flavonoids reduce capillary permeability and fragility; terpene ginkgolides inhibit platelet-activating factor and decrease vascular resistance.	30	2026-05-17 19:20:07.593885+00
314	87	62	Traditionally in Europe considered an effective specific. The seeds have long been used to treat venous disorders, including varicose veins.	10	2026-05-17 19:20:07.593885+00
319	90	135	Can help initiate flow.	10	2026-06-07 19:28:17.415064+00
320	90	44	Can help initiate flow.	20	2026-06-07 19:28:17.415064+00
321	90	115	Can help initiate flow.	30	2026-06-07 19:28:17.415064+00
322	91	25		10	2026-06-07 19:28:17.415064+00
323	91	74		20	2026-06-07 19:28:17.415064+00
324	91	142		30	2026-06-07 19:28:17.415064+00
325	91	93		40	2026-06-07 19:28:17.415064+00
326	91	94		50	2026-06-07 19:28:17.415064+00
327	92	142	Useful in the short term; is as close as possible to a specific for symptomatic relief.	10	2026-06-07 19:28:17.415064+00
328	92	190	A longer-term specific, hormonally focused.	20	2026-06-07 19:28:17.415064+00
329	93	81	May help lessen any depression that might occur.	10	2026-06-07 19:28:17.415064+00
330	93	131	Can help with the distressing tachycardia that often accompanies hot flashes.	20	2026-06-07 19:28:17.415064+00
331	93	25	In North American herbalism, a potential specific for menopausal complaints.	30	2026-06-07 19:28:17.415064+00
332	93	1058	In North American herbalism, a potential specific for menopausal complaints.	40	2026-06-07 19:28:17.415064+00
333	94	155	Has a mildly soothing astringent and tonic action. Helps to quell nausea and is slightly sedative. Has a particular affinity for the uterus, acting to strengthen the uterine and pelvic muscles and prevent miscarriage. The relaxant properties bring about tonic relaxation of the smooth muscle of the uterus, helping to reduce the pain of uterine contractions at labor. Raspberry leaf tones the mucous membranes throughout the body, soothes the kidneys and urinary tract, and helps prevent hemorrhage. Principally used before delivery to encourage safe, easy, and speedy childbirth, and after delivery to improve milk production and speed recovery.	10	2026-06-07 19:28:17.415064+00
334	95	74		10	2026-06-07 19:28:17.415064+00
335	95	93		20	2026-06-07 19:28:17.415064+00
336	95	94		30	2026-06-07 19:28:17.415064+00
337	95	109		40	2026-06-07 19:28:17.415064+00
338	95	155		50	2026-06-07 19:28:17.415064+00
339	95	1072		60	2026-06-07 19:28:17.415064+00
340	95	188		70	2026-06-07 19:28:17.415064+00
341	95	131		80	2026-06-07 19:28:17.415064+00
342	95	21		90	2026-06-07 19:28:17.415064+00
343	95	91		100	2026-06-07 19:28:17.415064+00
344	96	212	Valuable antiemetic safe to use in early pregnancy.	10	2026-06-07 19:28:17.415064+00
345	96	75	Valuable antiemetic safe to use in early pregnancy.	20	2026-06-07 19:28:17.415064+00
346	96	102	Valuable antiemetic safe to use in early pregnancy.	30	2026-06-07 19:28:17.415064+00
347	96	109	Valuable antiemetic safe to use in early pregnancy.	40	2026-06-07 19:28:17.415064+00
348	96	1083	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	50	2026-06-07 19:28:17.415064+00
349	96	74	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	60	2026-06-07 19:28:17.415064+00
350	96	76	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	70	2026-06-07 19:28:17.415064+00
351	96	129	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	80	2026-06-07 19:28:17.415064+00
352	96	82	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	90	2026-06-07 19:28:17.415064+00
353	96	84	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	100	2026-06-07 19:28:17.415064+00
354	96	134	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	110	2026-06-07 19:28:17.415064+00
355	96	55	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	120	2026-06-07 19:28:17.415064+00
356	96	155	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	130	2026-06-07 19:28:17.415064+00
357	96	111	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	140	2026-06-07 19:28:17.415064+00
358	96	124	Carminative, antispasmodic, and relaxing nervine; especially important to aid digestion.	150	2026-06-07 19:28:17.415064+00
359	96	49	Mucilage-rich demulcent that helps soothe the digestive tract. Highly nutritious and easily digested, with many minerals and trace elements.	160	2026-06-07 19:28:17.415064+00
360	96	92	Mucilage-rich demulcent that helps soothe the digestive tract. Highly nutritious and easily digested, with many minerals and trace elements.	170	2026-06-07 19:28:17.415064+00
361	98	73	Leafy herb that can be added to salads, cooked as a vegetable, and added to soups; also contains meaningful levels of iron when used as an infusion or tincture.	10	2026-06-07 19:28:17.415064+00
362	98	1102	Leafy herb that can be added to salads, cooked as a vegetable, and added to soups.	20	2026-06-07 19:28:17.415064+00
363	98	89	Leafy herb that can be added to salads, cooked as a vegetable, and added to soups — use in moderation.	30	2026-06-07 19:28:17.415064+00
364	98	122	Leafy herb that can be added to salads, cooked as a vegetable, and added to soups.	40	2026-06-07 19:28:17.415064+00
365	98	43	Leafy herb that can be added to salads, cooked as a vegetable, and added to soups.	50	2026-06-07 19:28:17.415064+00
366	98	22	Contains meaningful levels of iron when used as an infusion or tincture.	60	2026-06-07 19:28:17.415064+00
367	98	102	Contains meaningful levels of iron when used as an infusion or tincture.	70	2026-06-07 19:28:17.415064+00
368	98	129	Contains meaningful levels of iron when used as an infusion or tincture.	80	2026-06-07 19:28:17.415064+00
369	98	155	Contains meaningful levels of iron when used as an infusion or tincture.	90	2026-06-07 19:28:17.415064+00
370	98	37	Contains meaningful levels of iron when used as an infusion or tincture.	100	2026-06-07 19:28:17.415064+00
371	98	142	Contains meaningful levels of iron when used as an infusion or tincture.	110	2026-06-07 19:28:17.415064+00
372	98	146	Contains meaningful levels of iron when used as an infusion or tincture.	120	2026-06-07 19:28:17.415064+00
373	110	202	Apply gel externally to soothe and heal tissue.	10	2026-06-07 19:28:17.415064+00
374	110	70	Good choice of herb for ointments or sitz baths.	20	2026-06-07 19:28:17.415064+00
375	110	89	Good choice of herb for ointments or sitz baths.	30	2026-06-07 19:28:17.415064+00
376	110	30	Good choice of herb for ointments or sitz baths.	40	2026-06-07 19:28:17.415064+00
377	110	44	Good choice of herb for ointments or sitz baths.	50	2026-06-07 19:28:17.415064+00
378	111	25		10	2026-06-07 19:28:17.415064+00
379	111	74		20	2026-06-07 19:28:17.415064+00
380	111	94		30	2026-06-07 19:28:17.415064+00
381	111	93		40	2026-06-07 19:28:17.415064+00
382	112	1122		10	2026-06-07 19:28:17.415064+00
383	112	76		20	2026-06-07 19:28:17.415064+00
384	112	1124		30	2026-06-07 19:28:17.415064+00
385	113	70	Apply vulnerary and antimicrobial herbs externally, such as Calendula.	10	2026-06-07 19:28:17.415064+00
386	115	74	There are no traditional specifics for endometriosis, but this is almost specific for the pain, although it is not very strong.	10	2026-06-07 19:28:17.415064+00
387	115	190	May be considered the most appropriate remedy for the underlying processes involved.	20	2026-06-07 19:28:17.415064+00
388	116	190	No true specifics are known for this condition, but Vitex is undoubtedly strongly indicated.	10	2026-06-07 19:28:17.415064+00
389	116	1139	Evening primrose oil may also be of great value.	20	2026-06-07 19:28:17.415064+00
390	117	186	Reduces the formation of DHT by blocking the enzyme 5-alpha reductase, addressing the underlying driver of prostatic enlargement.	10	2026-06-07 19:28:17.415064+00
399	130	95	A number of demulcent diuretic remedies work well. It is difficult to say whether they act primarily as anti-inflammatory agents to reduce inflammation or as demulcents that soothe the surface of the cells.	10	2026-06-21 16:44:38.744675+00
400	130	179	A number of demulcent diuretic remedies work well. It is difficult to say whether they act primarily as anti-inflammatory agents to reduce inflammation or as demulcents that soothe the surface of the cells.	20	2026-06-21 16:44:38.744675+00
401	130	45	A number of demulcent diuretic remedies work well. It is difficult to say whether they act primarily as anti-inflammatory agents to reduce inflammation or as demulcents that soothe the surface of the cells.	30	2026-06-21 16:44:38.744675+00
402	132	157	A number of diuretic plants have an astringent effect.	10	2026-06-21 16:44:38.744675+00
403	132	151	A number of diuretic plants have an astringent effect.	20	2026-06-21 16:44:38.744675+00
404	132	1014	A number of diuretic plants have an astringent effect.	30	2026-06-21 16:44:38.744675+00
405	132	71	A number of diuretic plants have an astringent effect.	40	2026-06-21 16:44:38.744675+00
406	133	122	Leaf. The diuretic effect of this herb is comparable to that of the drug furosemide. In dandelion leaf, however, we have one of the best natural sources of potassium. Dandelion leaf simultaneously replaces the potassium that is flushed from the body via its diuretic action.	10	2026-06-21 16:44:38.744675+00
407	134	44	In Wales, preferably harvested from sea cliffs, has a dramatic effect even in intransigent cases of cystitis. Unfortunately, tinctures or infusions made from the same plants after drying do not replicate the results achieved with fresh plant material. This is probably due to changes in the amount or relative composition of the volatile oils present.	10	2026-06-21 16:44:38.744675+00
408	134	46	Plants that contain antimicrobial volatile oils have most to offer.	20	2026-06-21 16:44:38.744675+00
409	134	181	Plants that contain antimicrobial volatile oils have most to offer.	30	2026-06-21 16:44:38.744675+00
410	134	1212	Juice has a strong traditional reputation for soothing symptoms of cystitis. It actually helps prevent the adherence of pathogenic bacteria to the lining of the urinary tract. Cranberry has been shown to inhibit the adherence of fimbriated E. coli to the mucosa. It now appears that a group of flavonoids in cranberry, called proanthocyanidins, are responsible for these anti-adhesion effects. Unsweetened cranberry juice is recommended.	40	2026-06-21 16:44:38.744675+00
411	135	296	a long tradition of use as specific in Europe	10	2026-06-21 16:44:38.744675+00
412	135	1402	a long tradition of use as specific in Europe	20	2026-06-21 16:44:38.744675+00
413	135	1403	a long tradition of use as specific in Europe	30	2026-06-21 16:44:38.744675+00
414	135	179	a long tradition of use as specific in Europe	40	2026-06-21 16:44:38.744675+00
415	135	43	a long tradition of use as specific in Europe	50	2026-06-21 16:44:38.744675+00
416	135	58	a long tradition of use as specific in Europe	60	2026-06-21 16:44:38.744675+00
417	135	117	North American plant	70	2026-06-21 16:44:38.744675+00
418	135	182	North American plant	80	2026-06-21 16:44:38.744675+00
419	135	95	North American plant	90	2026-06-21 16:44:38.744675+00
420	136	27	For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.	10	2026-06-21 16:54:56.148727+00
421	136	28	For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.	20	2026-06-21 16:54:56.148727+00
422	136	39	For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.	30	2026-06-21 16:54:56.148727+00
423	136	42	For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.	40	2026-06-21 16:54:56.148727+00
424	136	43	For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.	50	2026-06-21 16:54:56.148727+00
425	136	1240	For internal treatment, the leafy alteratives are often considered the closest to specifics for this often intransigent condition. These are also often diuretic and lymphatic remedies.	60	2026-06-21 16:54:56.148727+00
426	136	22	The rooty alteratives tend to be hepatic in nature. They can often be too strong for eczema, aggravating the problem instead of healing it. For intransigent cases unresponsive to the herbs already listed, stronger remedies are indicated.	70	2026-06-21 16:54:56.148727+00
427	136	30	The rooty alteratives tend to be hepatic in nature. They can often be too strong for eczema, aggravating the problem instead of healing it. For intransigent cases unresponsive to the herbs already listed, stronger remedies are indicated.	80	2026-06-21 16:54:56.148727+00
428	136	33	The rooty alteratives tend to be hepatic in nature. They can often be too strong for eczema, aggravating the problem instead of healing it. For intransigent cases unresponsive to the herbs already listed, stronger remedies are indicated.	90	2026-06-21 16:54:56.148727+00
429	136	70	Relevant herbs for topical use abound. Always bear in mind that healing must be based upon internal medication, not salves. Select remedies according to the actions most appropriate for the individual's specific symptoms.	100	2026-06-21 16:54:56.148727+00
430	136	1428	Relevant herbs for topical use abound. Select remedies according to the actions most appropriate for the individual's specific symptoms.	110	2026-06-21 16:54:56.148727+00
431	136	88	Relevant herbs for topical use abound. Select remedies according to the actions most appropriate for the individual's specific symptoms.	120	2026-06-21 16:54:56.148727+00
432	137	22	The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.	10	2026-06-21 16:54:56.148727+00
433	137	33	The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.	20	2026-06-21 16:54:56.148727+00
434	137	37	The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.	30	2026-06-21 16:54:56.148727+00
435	137	40	The woody, hepatic alteratives are the herbs that come closest to being specifics for psoriasis.	40	2026-06-21 16:54:56.148727+00
436	137	28	Any of the other alteratives may prove to be specific for a given individual.	50	2026-06-21 16:54:56.148727+00
437	137	32	Any of the other alteratives may prove to be specific for a given individual.	60	2026-06-21 16:54:56.148727+00
438	137	39	Any of the other alteratives may prove to be specific for a given individual.	70	2026-06-21 16:54:56.148727+00
439	137	42	Any of the other alteratives may prove to be specific for a given individual.	80	2026-06-21 16:54:56.148727+00
440	137	43	Any of the other alteratives may prove to be specific for a given individual.	90	2026-06-21 16:54:56.148727+00
441	137	1240	Any of the other alteratives may prove to be specific for a given individual.	100	2026-06-21 16:54:56.148727+00
442	137	70	Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.	110	2026-06-21 16:54:56.148727+00
443	137	1428	Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.	120	2026-06-21 16:54:56.148727+00
444	137	1475	Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.	130	2026-06-21 16:54:56.148727+00
445	137	88	Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.	140	2026-06-21 16:54:56.148727+00
446	137	201	Choice of topical application will be governed to some extent by the personal preferences of the patient, so experimentation may be necessary.	150	2026-06-21 16:54:56.148727+00
447	138	1442	Tea tree oil has specifically relevant properties. It has been shown to possess significant antimicrobial properties. Organisms inhibited include Candida albicans, Escherichia coli, Staphylococcus aureus, Staphylococcus epidermidis, and Propionibacterium acnes. For acne, tea tree oil applied topically in a 5% to 15% dilution three or four times daily is recommended.	10	2026-06-21 16:54:56.148727+00
448	138	190	Keep in mind that there is no specific herb that normalizes levels of androgens. Occasionally, however, Vitex can have a beneficial effect in adolescent girls.	20	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: disorders; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.disorders (id, name, body_system_id, sort_order, created_at) FROM stdin;
1	Constipation	11	1	2026-04-06 21:33:58.34407+00
2	Diarrhea	11	2	2026-04-06 21:33:58.34407+00
3	Aphthous Ulcers	11	3	2026-04-06 21:33:58.34407+00
4	Periodontal Disease	11	4	2026-04-06 21:33:58.34407+00
5	GERD	11	5	2026-04-06 21:33:58.34407+00
6	Gastritis	11	6	2026-04-06 21:33:58.34407+00
7	Peptic Ulcers	11	7	2026-04-06 21:33:58.34407+00
8	Hiatus Hernia	11	8	2026-04-06 21:33:58.34407+00
9	Functional Dyspepsia	11	9	2026-04-06 21:33:58.34407+00
10	Irritable Bowel Syndrome	11	10	2026-04-06 21:56:12.487259+00
11	Ulcerative Colitis	11	11	2026-04-06 21:56:12.487259+00
12	Diverticulitis	11	12	2026-04-06 21:56:12.487259+00
13	Liver Disease	11	13	2026-04-06 21:56:12.487259+00
14	Jaundice	11	14	2026-04-06 21:56:27.332838+00
15	Chronic Hepatitis	11	15	2026-04-06 21:56:27.332838+00
16	Viral Hepatitis	11	16	2026-04-06 21:56:27.332838+00
17	Cirrhosis	11	17	2026-04-06 21:56:27.332838+00
18	Cholecystitis	11	18	2026-04-06 21:56:27.332838+00
19	Cholelithiasis	11	19	2026-04-06 21:56:27.332838+00
20	Hemorrhoids	11	20	2026-04-06 21:56:27.332838+00
21	Overall	17	0	2026-04-10 20:55:36.403551+00
22	Autoimmune Diseases	17	1	2026-04-10 20:55:36.403551+00
23	Elimination and Detox Issues	17	2	2026-04-10 20:55:36.403551+00
24	Postoperative Recovery	17	3	2026-04-10 20:55:49.407997+00
25	Infection	17	4	2026-04-10 20:55:49.407997+00
26	Antibiotic Recovery	17	5	2026-04-10 20:56:04.197894+00
27	Vaginitis	17	6	2026-04-10 20:56:04.197894+00
28	Genitourinary Tract Infections	17	7	2026-04-10 20:56:04.197894+00
29	Prostatitis	17	8	2026-04-10 20:58:36.064973+00
30	Boils	17	9	2026-04-10 20:58:36.064973+00
31	Fungal Skin Infections	17	10	2026-04-10 20:58:36.064973+00
32	Cancer	17	11	2026-04-10 20:58:36.064973+00
33	Ear Infections	17	100	2026-04-12 15:53:48.543859+00
34	Sore Throat	17	101	2026-04-12 15:53:48.543859+00
35	Congestion	17	102	2026-04-12 15:53:48.543859+00
36	Swollen Glands	17	103	2026-04-12 15:53:48.543859+00
37	Mumps	17	104	2026-04-12 15:53:48.543859+00
38	Flu	17	105	2026-04-12 15:53:48.543859+00
39	Colds	17	106	2026-04-12 15:53:48.543859+00
40	Cough (soothe)	17	107	2026-04-12 15:53:48.543859+00
41	Cough (suppress)	17	108	2026-04-12 15:53:48.543859+00
42	Laryngitis	17	109	2026-04-12 15:53:48.543859+00
43	Acute Bronchitis	17	110	2026-04-12 15:53:48.543859+00
44	Pneumonia	17	111	2026-04-12 15:53:48.543859+00
45	Colic/Gastritis	17	112	2026-04-12 15:53:48.543859+00
46	Constipation	17	113	2026-04-12 15:53:48.543859+00
47	Diarrhea	17	114	2026-04-12 15:53:48.543859+00
48	Nausea	17	115	2026-04-12 15:53:48.543859+00
49	Fevers	17	116	2026-04-12 15:53:48.543859+00
50	Chicken Pox	17	117	2026-04-12 15:53:48.543859+00
51	Restlessness	17	118	2026-04-12 15:53:48.543859+00
52	Overall	18	0	2026-04-23 16:05:55.110389+00
53	Cough	18	1	2026-04-23 16:05:55.110389+00
54	Bronchitis	18	2	2026-04-23 16:06:07.589513+00
55	Acute Bronchitis	18	3	2026-04-23 16:06:07.589513+00
56	Post-Bronchitis Recovery	18	4	2026-04-23 16:06:22.109926+00
57	Chronic Bronchitis	18	5	2026-04-23 16:06:22.109926+00
58	Pertussis	18	6	2026-04-23 16:06:39.257018+00
59	Asthma	18	7	2026-04-23 16:06:39.257018+00
60	Emphysema	18	8	2026-04-23 16:06:39.257018+00
61	All	19	0	2026-04-23 16:06:49.507222+00
62	The Common Cold	19	1	2026-04-23 16:06:49.507222+00
63	Influenza	19	2	2026-04-23 16:07:01.735818+00
64	Influenza Convalescence	19	3	2026-04-23 16:07:01.735818+00
65	Hay Fever	19	4	2026-04-23 16:07:11.301036+00
66	Sinusitis	19	5	2026-04-23 16:07:11.301036+00
67	Laryngitis	19	6	2026-04-23 16:07:11.301036+00
68	Tonsillitis	19	7	2026-04-23 16:07:11.301036+00
69	Ongoing Stress	15	10	2026-04-30 16:30:20.373726+00
70	Acute Stress	15	20	2026-04-30 16:30:20.373726+00
71	Depression	15	30	2026-04-30 16:30:20.373726+00
72	Insomnia	15	40	2026-04-30 16:30:20.373726+00
73	Withdrawal from Benzodiazepines	15	50	2026-04-30 16:30:34.395192+00
74	Anorexia Nervosa	15	60	2026-04-30 16:30:34.395192+00
75	Headache	15	70	2026-04-30 16:30:34.395192+00
76	Migraine	15	80	2026-04-30 16:30:46.287227+00
77	Neuritis	15	90	2026-04-30 16:30:46.287227+00
78	Tinnitus	15	100	2026-04-30 16:30:46.287227+00
79	Motion Sickness	15	110	2026-04-30 16:30:46.287227+00
80	Shingles	15	120	2026-04-30 16:30:46.287227+00
81	Elevated Cholesterol	9	10	2026-05-17 19:20:07.593885+00
82	Hypertension	9	20	2026-05-17 19:20:07.593885+00
83	Arteriosclerosis	9	30	2026-05-17 19:20:07.593885+00
84	Congestive Heart Failure	9	40	2026-05-17 19:20:07.593885+00
85	Angina Pectoris	9	50	2026-05-17 19:20:07.593885+00
86	Peripheral Arterial Occlusive Disease	9	60	2026-05-17 19:20:07.593885+00
87	Varicose Veins	9	70	2026-05-17 19:20:07.593885+00
90	Amenorrhea	24	10	2026-06-07 19:28:17.415064+00
91	Dysmenorrhea	24	20	2026-06-07 19:28:17.415064+00
92	Premenstrual Syndrome	24	30	2026-06-07 19:28:17.415064+00
93	Menopausal Complaints	24	40	2026-06-07 19:28:17.415064+00
94	Pregnancy - General Issues	24	50	2026-06-07 19:28:17.415064+00
95	Pregnancy - First Trimester - Threatened Miscarriage	24	60	2026-06-07 19:28:17.415064+00
96	Pregnancy - First Trimester - Morning Sickness	24	70	2026-06-07 19:28:17.415064+00
97	Pregnancy - First Trimester - Constipation	24	80	2026-06-07 19:28:17.415064+00
98	Pregnancy - First Trimester - Anemia	24	90	2026-06-07 19:28:17.415064+00
99	Pregnancy - First Trimester - Dizziness	24	100	2026-06-07 19:28:17.415064+00
100	Pregnancy - First Trimester - Heartburn	24	110	2026-06-07 19:28:17.415064+00
101	Pregnancy - First Trimester - Bleeding Gums	24	120	2026-06-07 19:28:17.415064+00
102	Pregnancy - First Trimester - Headache	24	130	2026-06-07 19:28:17.415064+00
103	Pregnancy - First Trimester - Hemorrhoids	24	140	2026-06-07 19:28:17.415064+00
104	Pregnancy - Second and Third Trimester - General	24	150	2026-06-07 19:28:17.415064+00
105	Pregnancy - Second and Third Trimester - Stretch Marks	24	160	2026-06-07 19:28:17.415064+00
106	Pregnancy - Second and Third Trimester - Backache	24	170	2026-06-07 19:28:17.415064+00
107	Pregnancy - Second and Third Trimester - Hypertension	24	180	2026-06-07 19:28:17.415064+00
108	Pregnancy - Postpartum - General	24	190	2026-06-07 19:28:17.415064+00
109	Pregnancy - Postpartum - Depression	24	200	2026-06-07 19:28:17.415064+00
110	Pregnancy - Postpartum - Perineal Tears or Extensive Episiotomy	24	210	2026-06-07 19:28:17.415064+00
111	Pregnancy - Postpartum - After Pains or Recurrent Uterine Contractions	24	220	2026-06-07 19:28:17.415064+00
112	Pregnancy - Postpartum - Stimulating Lactation	24	230	2026-06-07 19:28:17.415064+00
113	Pregnancy - Postpartum - Mastitis	24	240	2026-06-07 19:28:17.415064+00
114	Uterine Fibroids	24	250	2026-06-07 19:28:17.415064+00
115	Endometriosis	24	260	2026-06-07 19:28:17.415064+00
116	Fibrocystic Breast Disease	24	270	2026-06-07 19:28:17.415064+00
117	Benign Prostatic Hypertrophy	25	10	2026-06-07 19:28:17.415064+00
118	Cardiovascular System Issues	26	1	2026-06-08 14:41:59.876695+00
119	Respiratory System Issues	26	2	2026-06-08 14:41:59.876695+00
120	Nervous System Issues	26	3	2026-06-08 14:41:59.876695+00
121	Digestive System Issues	26	4	2026-06-08 14:41:59.876695+00
122	Urinary System Issues	26	5	2026-06-08 14:41:59.876695+00
123	Reproductive System Issues	26	6	2026-06-08 14:41:59.876695+00
124	Musculoskeletal System Issues	26	7	2026-06-08 14:41:59.876695+00
125	Skin Issues	26	8	2026-06-08 14:41:59.876695+00
130	Frequency	12	10	2026-06-21 16:44:38.744675+00
131	Dysuria	12	20	2026-06-21 16:44:38.744675+00
132	Hematuria	12	30	2026-06-21 16:44:38.744675+00
133	Edema	12	40	2026-06-21 16:44:38.744675+00
134	Cystitis	12	50	2026-06-21 16:44:38.744675+00
135	Urinary Calculus	12	60	2026-06-21 16:44:38.744675+00
136	Eczema	16	10	2026-06-21 16:54:56.148727+00
137	Psoriasis	16	20	2026-06-21 16:54:56.148727+00
138	Acne	16	30	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: herb_constituents; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herb_constituents (id, herb_id, constituent_id, concentration_level, notes, needs_review, sort_order, created_at) FROM stdin;
219	44	826	major	\N	f	10	2026-06-29 15:09:48.1073+00
220	44	827	minor	\N	f	20	2026-06-29 15:09:48.1073+00
221	44	806	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
222	44	807	minor	\N	f	40	2026-06-29 15:09:48.1073+00
223	44	809	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
224	44	822	minor	\N	f	60	2026-06-29 15:09:48.1073+00
225	44	846	major	\N	f	70	2026-06-29 15:09:48.1073+00
226	44	847	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
227	44	737	major	\N	f	90	2026-06-29 15:09:48.1073+00
228	44	739	moderate	\N	f	100	2026-06-29 15:09:48.1073+00
229	44	763	moderate	\N	f	110	2026-06-29 15:09:48.1073+00
230	44	742	moderate	\N	f	120	2026-06-29 15:09:48.1073+00
231	44	741	moderate	\N	f	130	2026-06-29 15:09:48.1073+00
232	44	699	minor	\N	f	140	2026-06-29 15:09:48.1073+00
233	44	700	minor	\N	f	150	2026-06-29 15:09:48.1073+00
234	44	795	moderate	\N	f	160	2026-06-29 15:09:48.1073+00
235	44	792	minor	\N	f	170	2026-06-29 15:09:48.1073+00
236	62	1028	primary	\N	f	10	2026-06-29 15:09:48.1073+00
237	62	1029	major	\N	f	20	2026-06-29 15:09:48.1073+00
238	62	778	major	\N	f	30	2026-06-29 15:09:48.1073+00
239	62	741	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
240	62	746	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
241	62	742	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
242	62	795	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
243	148	795	primary	\N	f	10	2026-06-29 15:09:48.1073+00
244	148	741	major	\N	f	20	2026-06-29 15:09:48.1073+00
245	148	742	major	\N	f	30	2026-06-29 15:09:48.1073+00
246	148	739	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
247	148	737	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
248	148	854	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
249	148	753	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
250	148	797	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
251	148	1037	moderate	\N	f	90	2026-06-29 15:09:48.1073+00
252	21	922	primary	\N	f	10	2026-06-29 15:09:48.1073+00
253	21	923	primary	Formed when raw garlic is crushed; destroyed by heat	f	20	2026-06-29 15:09:48.1073+00
254	21	924	major	\N	f	30	2026-06-29 15:09:48.1073+00
255	21	925	major	\N	f	40	2026-06-29 15:09:48.1073+00
256	21	741	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
257	21	857	minor	\N	f	60	2026-06-29 15:09:48.1073+00
258	21	1038	minor	\N	f	70	2026-06-29 15:09:48.1073+00
259	45	914	primary	Root highest in mucilage	f	10	2026-06-29 15:09:48.1073+00
260	45	913	primary	\N	f	20	2026-06-29 15:09:48.1073+00
261	45	915	major	\N	f	30	2026-06-29 15:09:48.1073+00
262	45	741	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
263	45	746	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
264	45	905	minor	\N	f	60	2026-06-29 15:09:48.1073+00
265	45	795	minor	\N	f	70	2026-06-29 15:09:48.1073+00
266	22	912	primary	Up to 45% in root	f	10	2026-06-29 15:09:48.1073+00
267	22	843	major	\N	f	20	2026-06-29 15:09:48.1073+00
268	22	1008	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
269	22	972	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
270	22	784	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
271	22	785	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
272	22	741	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
273	22	795	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
274	22	994	moderate	\N	f	90	2026-06-29 15:09:48.1073+00
275	46	926	primary	Urinary antiseptic prodrug of hydroquinone	f	10	2026-06-29 15:09:48.1073+00
276	46	795	primary	Up to 40%	f	30	2026-06-29 15:09:48.1073+00
277	46	854	major	\N	f	40	2026-06-29 15:09:48.1073+00
278	46	741	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
279	46	743	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
280	46	744	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
281	46	1039	major	\N	f	20	2026-06-29 15:09:48.1073+00
282	97	840	primary	\N	f	10	2026-06-29 15:09:48.1073+00
283	97	839	primary	\N	f	20	2026-06-29 15:09:48.1073+00
284	97	822	major	Neurotoxic in large doses	f	30	2026-06-29 15:09:48.1073+00
285	97	826	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
286	97	835	minor	\N	f	50	2026-06-29 15:09:48.1073+00
287	97	806	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
288	97	741	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
289	97	742	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
290	97	784	moderate	\N	f	90	2026-06-29 15:09:48.1073+00
291	115	822	moderate	\N	f	10	2026-06-29 15:09:48.1073+00
292	115	806	moderate	\N	f	20	2026-06-29 15:09:48.1073+00
293	115	809	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
294	115	839	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
295	115	741	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
296	115	742	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
297	115	784	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
298	225	917	primary	\N	f	10	2026-06-29 15:09:48.1073+00
299	225	863	primary	\N	f	20	2026-06-29 15:09:48.1073+00
300	225	864	major	\N	f	30	2026-06-29 15:09:48.1073+00
301	225	771	major	\N	f	40	2026-06-29 15:09:48.1073+00
302	225	767	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
303	225	857	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
304	225	984	minor	\N	f	80	2026-06-29 15:09:48.1073+00
305	225	1040	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
306	178	916	primary	Green oat milky stage highest	f	10	2026-06-29 15:09:48.1073+00
307	178	1038	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
308	178	741	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
309	178	742	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
310	178	1017	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
311	178	996	minor	\N	f	70	2026-06-29 15:09:48.1073+00
312	178	1041	major	\N	f	20	2026-06-29 15:09:48.1073+00
313	23	734	primary	\N	f	10	2026-06-29 15:09:48.1073+00
314	23	733	major	\N	f	20	2026-06-29 15:09:48.1073+00
315	23	1042	major	\N	f	30	2026-06-29 15:09:48.1073+00
316	23	767	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
317	23	768	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
318	23	1008	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
319	70	855	primary	\N	f	10	2026-06-29 15:09:48.1073+00
320	70	854	primary	\N	f	20	2026-06-29 15:09:48.1073+00
321	70	741	major	\N	f	30	2026-06-29 15:09:48.1073+00
322	70	745	major	\N	f	40	2026-06-29 15:09:48.1073+00
323	70	743	major	\N	f	50	2026-06-29 15:09:48.1073+00
324	70	991	major	\N	f	60	2026-06-29 15:09:48.1073+00
325	70	992	major	\N	f	70	2026-06-29 15:09:48.1073+00
326	70	993	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
327	70	913	moderate	\N	f	90	2026-06-29 15:09:48.1073+00
328	70	1038	major	\N	f	100	2026-06-29 15:09:48.1073+00
329	70	937	moderate	\N	f	110	2026-06-29 15:09:48.1073+00
330	70	795	moderate	\N	f	120	2026-06-29 15:09:48.1073+00
331	47	1044	primary	\N	f	10	2026-06-29 15:09:48.1073+00
332	47	1045	major	\N	f	20	2026-06-29 15:09:48.1073+00
333	47	741	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
334	47	739	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
335	47	991	major	\N	f	50	2026-06-29 15:09:48.1073+00
336	47	1046	major	\N	f	60	2026-06-29 15:09:48.1073+00
337	25	987	primary	\N	f	10	2026-06-29 15:09:48.1073+00
338	25	986	primary	\N	f	20	2026-06-29 15:09:48.1073+00
339	25	988	major	\N	f	30	2026-06-29 15:09:48.1073+00
340	25	989	major	\N	f	40	2026-06-29 15:09:48.1073+00
341	25	784	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
342	25	792	minor	\N	f	70	2026-06-29 15:09:48.1073+00
343	25	767	trace	Disputed; may not be present in meaningful quantity	f	80	2026-06-29 15:09:48.1073+00
344	25	1047	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
345	1124	1050	primary	\N	f	10	2026-06-29 15:09:48.1073+00
346	1124	739	moderate	\N	f	20	2026-06-29 15:09:48.1073+00
347	1124	737	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
348	1124	795	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
349	1124	994	minor	\N	f	50	2026-06-29 15:09:48.1073+00
350	99	937	primary	~60% of dry weight	f	10	2026-06-29 15:09:48.1073+00
351	99	940	major	\N	f	20	2026-06-29 15:09:48.1073+00
352	99	941	major	\N	f	30	2026-06-29 15:09:48.1073+00
353	99	994	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
354	99	1051	major	\N	f	40	2026-06-29 15:09:48.1073+00
355	73	778	primary	Oligomeric proanthocyanidins; key cardiotonics	f	10	2026-06-29 15:09:48.1073+00
356	73	756	primary	\N	f	20	2026-06-29 15:09:48.1073+00
357	73	758	primary	\N	f	30	2026-06-29 15:09:48.1073+00
358	73	743	major	\N	f	40	2026-06-29 15:09:48.1073+00
359	73	741	major	\N	f	50	2026-06-29 15:09:48.1073+00
360	73	742	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
361	73	754	major	\N	f	70	2026-06-29 15:09:48.1073+00
362	73	785	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
363	73	784	moderate	\N	f	90	2026-06-29 15:09:48.1073+00
364	203	947	primary	~3% of dry rhizome	f	10	2026-06-29 15:09:48.1073+00
365	203	948	major	\N	f	20	2026-06-29 15:09:48.1073+00
366	203	949	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
367	203	833	major	\N	f	40	2026-06-29 15:09:48.1073+00
368	203	832	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
369	203	834	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
370	203	784	minor	\N	f	70	2026-06-29 15:09:48.1073+00
371	164	731	primary	\N	f	10	2026-06-29 15:09:48.1073+00
372	164	730	major	\N	f	20	2026-06-29 15:09:48.1073+00
373	164	732	major	\N	f	30	2026-06-29 15:09:48.1073+00
374	164	733	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
375	164	784	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
376	164	1052	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
377	26	975	primary	Responsible for tingling sensation; immunomodulatory	f	10	2026-06-29 15:09:48.1073+00
378	26	787	primary	Highest in E. purpurea	f	20	2026-06-29 15:09:48.1073+00
379	26	788	primary	Highest in E. angustifolia and E. pallida	f	30	2026-06-29 15:09:48.1073+00
380	26	918	major	\N	f	40	2026-06-29 15:09:48.1073+00
381	26	785	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
382	26	784	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
383	26	1008	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
384	26	1007	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
385	9	866	primary	\N	f	10	2026-06-29 15:09:48.1073+00
386	9	972	major	\N	f	20	2026-06-29 15:09:48.1073+00
387	9	1013	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
388	9	784	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
389	9	1053	major	\N	f	30	2026-06-29 15:09:48.1073+00
390	151	996	primary	5–7% of dry weight as silicic acid	f	10	2026-06-29 15:09:48.1073+00
391	151	1038	major	\N	f	20	2026-06-29 15:09:48.1073+00
392	151	746	major	\N	f	30	2026-06-29 15:09:48.1073+00
393	151	741	major	\N	f	40	2026-06-29 15:09:48.1073+00
394	151	739	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
395	151	784	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
396	151	1054	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
397	128	725	primary	\N	f	10	2026-06-29 15:09:48.1073+00
398	128	724	primary	\N	f	20	2026-06-29 15:09:48.1073+00
399	128	723	major	\N	f	30	2026-06-29 15:09:48.1073+00
400	128	722	major	\N	f	40	2026-06-29 15:09:48.1073+00
401	128	726	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
402	128	737	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
403	128	739	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
404	128	990	major	Responsible for orange color	f	80	2026-06-29 15:09:48.1073+00
405	75	791	primary	\N	f	10	2026-06-29 15:09:48.1073+00
406	75	1056	primary	\N	f	20	2026-06-29 15:09:48.1073+00
407	75	1057	major	\N	f	30	2026-06-29 15:09:48.1073+00
408	75	741	major	\N	f	40	2026-06-29 15:09:48.1073+00
409	75	742	major	\N	f	50	2026-06-29 15:09:48.1073+00
410	75	743	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
411	75	795	major	\N	f	70	2026-06-29 15:09:48.1073+00
412	75	994	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
413	28	876	primary	\N	f	10	2026-06-29 15:09:48.1073+00
414	28	795	major	\N	f	20	2026-06-29 15:09:48.1073+00
415	28	784	moderate	\N	f	30	2026-06-29 15:09:48.1073+00
416	28	789	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
417	28	739	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
418	28	741	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
419	28	1058	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
420	11	916	primary	\N	f	10	2026-06-29 15:09:48.1073+00
421	11	983	primary	\N	f	20	2026-06-29 15:09:48.1073+00
422	11	984	major	\N	f	30	2026-06-29 15:09:48.1073+00
423	11	972	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
424	11	1059	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
425	102	1060	primary	\N	f	10	2026-06-29 15:09:48.1073+00
426	102	1062	primary	\N	f	20	2026-06-29 15:09:48.1073+00
427	102	1061	major	\N	f	30	2026-06-29 15:09:48.1073+00
428	102	741	moderate	\N	f	40	2026-06-29 15:09:48.1073+00
429	102	757	moderate	\N	f	50	2026-06-29 15:09:48.1073+00
430	102	795	minor	\N	f	60	2026-06-29 15:09:48.1073+00
431	78	859	primary	4–20% of dry root	f	10	2026-06-29 15:09:48.1073+00
432	78	860	major	\N	f	20	2026-06-29 15:09:48.1073+00
433	78	772	major	\N	f	30	2026-06-29 15:09:48.1073+00
434	78	774	major	\N	f	40	2026-06-29 15:09:48.1073+00
435	78	773	major	\N	f	50	2026-06-29 15:09:48.1073+00
436	78	767	moderate	\N	f	60	2026-06-29 15:09:48.1073+00
437	78	741	moderate	\N	f	70	2026-06-29 15:09:48.1073+00
438	78	742	moderate	\N	f	80	2026-06-29 15:09:48.1073+00
439	78	913	major	\N	f	90	2026-06-29 15:09:48.1073+00
440	78	1013	major	\N	f	100	2026-06-29 15:09:48.1073+00
833	79	1094	primary	\N	f	10	2026-06-29 15:11:46.079494+00
834	79	796	primary	\N	f	20	2026-06-29 15:11:46.079494+00
835	79	797	major	\N	f	30	2026-06-29 15:11:46.079494+00
836	79	778	major	\N	f	40	2026-06-29 15:11:46.079494+00
837	79	741	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
838	79	746	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
839	79	899	trace	In volatile fraction; avoid in large doses	f	70	2026-06-29 15:11:46.079494+00
840	80	878	primary	\N	f	10	2026-06-29 15:11:46.079494+00
841	80	877	major	\N	f	20	2026-06-29 15:11:46.079494+00
842	80	739	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
843	80	741	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
844	80	746	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
845	80	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
846	80	1095	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
847	129	969	primary	\N	f	10	2026-06-29 15:11:46.079494+00
848	129	970	primary	\N	f	20	2026-06-29 15:11:46.079494+00
849	129	971	major	Major sedative; breakdown product of humulone	f	30	2026-06-29 15:11:46.079494+00
850	129	775	major	\N	f	40	2026-06-29 15:11:46.079494+00
851	129	776	major	\N	f	50	2026-06-29 15:11:46.079494+00
852	129	777	major	\N	f	60	2026-06-29 15:11:46.079494+00
853	129	799	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
854	129	824	major	\N	f	80	2026-06-29 15:11:46.079494+00
855	129	795	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
856	129	765	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
857	30	701	primary	~4% of root	f	10	2026-06-29 15:11:46.079494+00
858	30	1015	primary	~2–4% of root	f	20	2026-06-29 15:11:46.079494+00
859	30	703	major	\N	f	30	2026-06-29 15:11:46.079494+00
860	30	1016	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
861	30	785	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
862	30	784	minor	\N	f	60	2026-06-29 15:11:46.079494+00
863	81	884	primary	\N	f	10	2026-06-29 15:11:46.079494+00
864	81	885	primary	\N	f	20	2026-06-29 15:11:46.079494+00
865	81	886	primary	\N	f	30	2026-06-29 15:11:46.079494+00
866	81	887	major	\N	f	40	2026-06-29 15:11:46.079494+00
867	81	762	major	\N	f	50	2026-06-29 15:11:46.079494+00
868	81	743	major	\N	f	60	2026-06-29 15:11:46.079494+00
869	81	742	major	\N	f	70	2026-06-29 15:11:46.079494+00
870	81	741	major	\N	f	80	2026-06-29 15:11:46.079494+00
871	81	744	major	\N	f	90	2026-06-29 15:11:46.079494+00
872	81	784	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
873	81	785	moderate	\N	f	110	2026-06-29 15:11:46.079494+00
874	53	836	primary	\N	f	10	2026-06-29 15:11:46.079494+00
875	53	837	primary	\N	f	20	2026-06-29 15:11:46.079494+00
876	53	809	major	\N	f	30	2026-06-29 15:11:46.079494+00
877	53	811	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
878	53	764	major	\N	f	50	2026-06-29 15:11:46.079494+00
879	53	750	major	\N	f	60	2026-06-29 15:11:46.079494+00
880	53	737	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
881	53	850	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
882	53	795	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
883	53	783	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
884	54	912	primary	Up to 44% of root by dry weight	f	10	2026-06-29 15:11:46.079494+00
885	54	1005	primary	\N	f	20	2026-06-29 15:11:46.079494+00
886	54	1006	major	\N	f	30	2026-06-29 15:11:46.079494+00
887	54	835	major	\N	f	40	2026-06-29 15:11:46.079494+00
888	54	806	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
889	54	994	major	\N	f	60	2026-06-29 15:11:46.079494+00
890	54	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
891	54	937	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
892	103	1096	primary	\N	f	10	2026-06-29 15:11:46.079494+00
893	103	810	major	\N	f	20	2026-06-29 15:11:46.079494+00
894	103	823	major	\N	f	30	2026-06-29 15:11:46.079494+00
895	103	824	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
896	103	817	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
897	103	815	major	\N	f	60	2026-06-29 15:11:46.079494+00
898	103	753	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
899	103	778	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
900	103	762	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
901	130	844	primary	\N	f	10	2026-06-29 15:11:46.079494+00
902	130	845	primary	\N	f	20	2026-06-29 15:11:46.079494+00
903	130	1097	major	\N	f	30	2026-06-29 15:11:46.079494+00
904	130	1098	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
905	130	1099	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
906	82	799	primary	25–45% of essential oil	f	10	2026-06-29 15:11:46.079494+00
907	82	800	primary	25–45% of essential oil	f	20	2026-06-29 15:11:46.079494+00
908	82	815	major	\N	f	30	2026-06-29 15:11:46.079494+00
909	82	806	moderate	Higher in lavandin	f	40	2026-06-29 15:11:46.079494+00
910	82	809	minor	\N	f	50	2026-06-29 15:11:46.079494+00
911	82	825	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
912	82	783	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
913	82	739	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
914	82	737	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
915	131	736	primary	Uterotonic; cardioactive	f	10	2026-06-29 15:11:46.079494+00
916	131	708	primary	\N	f	20	2026-06-29 15:11:46.079494+00
917	131	879	major	\N	f	30	2026-06-29 15:11:46.079494+00
918	131	700	major	\N	f	40	2026-06-29 15:11:46.079494+00
919	131	742	major	\N	f	50	2026-06-29 15:11:46.079494+00
920	131	741	major	\N	f	60	2026-06-29 15:11:46.079494+00
921	131	743	major	\N	f	70	2026-06-29 15:11:46.079494+00
922	131	744	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
923	131	784	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
924	131	795	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
925	132	715	primary	\N	f	10	2026-06-29 15:11:46.079494+00
926	132	716	major	\N	f	20	2026-06-29 15:11:46.079494+00
927	132	717	major	\N	f	30	2026-06-29 15:11:46.079494+00
928	132	937	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
929	132	1100	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
930	33	701	primary	~3–5% of root bark	f	10	2026-06-29 15:11:46.079494+00
931	33	702	major	\N	f	20	2026-06-29 15:11:46.079494+00
932	33	704	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
933	33	706	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
934	33	707	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
935	33	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
936	33	1102	major	\N	f	30	2026-06-29 15:11:46.079494+00
937	84	826	primary	Formed from matricine during steam distillation	f	10	2026-06-29 15:11:46.079494+00
938	84	827	primary	\N	f	20	2026-06-29 15:11:46.079494+00
939	84	828	major	\N	f	30	2026-06-29 15:11:46.079494+00
940	84	829	major	\N	f	40	2026-06-29 15:11:46.079494+00
941	84	737	primary	\N	f	50	2026-06-29 15:11:46.079494+00
942	84	738	primary	\N	f	60	2026-06-29 15:11:46.079494+00
943	84	739	major	\N	f	70	2026-06-29 15:11:46.079494+00
944	84	741	major	\N	f	80	2026-06-29 15:11:46.079494+00
945	84	903	major	\N	f	90	2026-06-29 15:11:46.079494+00
946	84	904	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
947	84	913	moderate	\N	f	110	2026-06-29 15:11:46.079494+00
948	134	783	primary	Primary antiviral and anti-inflammatory constituent	f	10	2026-06-29 15:11:46.079494+00
949	134	784	major	\N	f	20	2026-06-29 15:11:46.079494+00
950	134	785	major	\N	f	30	2026-06-29 15:11:46.079494+00
951	134	820	major	Also called neral+geranial	f	40	2026-06-29 15:11:46.079494+00
952	134	821	major	\N	f	50	2026-06-29 15:11:46.079494+00
953	134	799	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
954	134	819	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
955	134	739	major	\N	f	80	2026-06-29 15:11:46.079494+00
956	134	737	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
957	134	795	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
958	55	801	primary	30–55% of essential oil	f	10	2026-06-29 15:11:46.079494+00
959	55	802	primary	14–32% of essential oil	f	20	2026-06-29 15:11:46.079494+00
960	55	803	major	\N	f	30	2026-06-29 15:11:46.079494+00
961	55	804	moderate	Hepatotoxic in large amounts	f	40	2026-06-29 15:11:46.079494+00
962	55	805	minor	Toxic in large doses	f	50	2026-06-29 15:11:46.079494+00
963	55	809	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
964	55	783	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
965	55	739	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
966	55	737	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
967	55	750	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
968	188	795	major	\N	f	10	2026-06-29 15:11:46.079494+00
969	188	1038	moderate	\N	f	20	2026-06-29 15:11:46.079494+00
970	188	994	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
971	188	784	minor	\N	f	50	2026-06-29 15:11:46.079494+00
972	188	1103	minor	\N	f	30	2026-06-29 15:11:46.079494+00
973	136	1104	primary	\N	f	10	2026-06-29 15:11:46.079494+00
974	136	1105	major	\N	f	20	2026-06-29 15:11:46.079494+00
975	136	783	major	\N	f	30	2026-06-29 15:11:46.079494+00
976	136	784	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
977	136	739	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
978	136	737	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
979	136	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
980	14	865	primary	Rb1, Rb2, Rc, Rd (Rb group); Rg1, Re, Rf (Rg group)	f	10	2026-06-29 15:11:46.079494+00
981	14	1053	major	\N	f	20	2026-06-29 15:11:46.079494+00
982	14	1008	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
983	14	857	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
984	14	784	minor	\N	f	50	2026-06-29 15:11:46.079494+00
985	14	1106	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
986	137	756	primary	\N	f	10	2026-06-29 15:11:46.079494+00
987	137	757	primary	\N	f	20	2026-06-29 15:11:46.079494+00
988	137	759	major	\N	f	30	2026-06-29 15:11:46.079494+00
989	137	760	major	\N	f	40	2026-06-29 15:11:46.079494+00
990	137	761	major	\N	f	50	2026-06-29 15:11:46.079494+00
991	137	739	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
992	137	737	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
993	137	765	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
994	137	1024	trace	Trace beta-carbolines; activity disputed	f	90	2026-06-29 15:11:46.079494+00
995	137	1023	trace	\N	f	100	2026-06-29 15:11:46.079494+00
996	137	968	moderate	\N	f	110	2026-06-29 15:11:46.079494+00
997	138	955	primary	\N	f	10	2026-06-29 15:11:46.079494+00
998	138	956	primary	\N	f	20	2026-06-29 15:11:46.079494+00
999	138	957	primary	\N	f	30	2026-06-29 15:11:46.079494+00
1000	138	958	major	\N	f	40	2026-06-29 15:11:46.079494+00
1001	138	959	major	\N	f	50	2026-06-29 15:11:46.079494+00
1002	138	954	primary	Collective term for all 6 major kavalactones	f	5	2026-06-29 15:11:46.079494+00
1003	138	1107	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1004	139	1108	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1005	139	1109	major	\N	f	20	2026-06-29 15:11:46.079494+00
1006	139	1110	major	Use in low doses; toxic in excess	f	30	2026-06-29 15:11:46.079494+00
1007	139	767	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1008	139	768	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1009	139	795	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1010	1428	873	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1011	1428	874	major	\N	f	20	2026-06-29 15:11:46.079494+00
1012	1428	913	primary	\N	f	30	2026-06-29 15:11:46.079494+00
1013	1428	942	major	\N	f	40	2026-06-29 15:11:46.079494+00
1014	1428	784	major	\N	f	50	2026-06-29 15:11:46.079494+00
1015	1428	785	major	\N	f	60	2026-06-29 15:11:46.079494+00
1016	1428	739	major	\N	f	80	2026-06-29 15:11:46.079494+00
1017	1428	737	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1018	1428	795	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
1019	1428	1111	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1020	109	783	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1021	109	851	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1022	109	852	major	\N	f	30	2026-06-29 15:11:46.079494+00
1023	109	853	major	\N	f	40	2026-06-29 15:11:46.079494+00
1024	109	809	primary	35–45% of essential oil	f	50	2026-06-29 15:11:46.079494+00
1025	109	806	major	10–20% of essential oil	f	60	2026-06-29 15:11:46.079494+00
1026	109	810	major	\N	f	70	2026-06-29 15:11:46.079494+00
1027	109	807	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1028	109	808	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1029	109	739	major	\N	f	100	2026-06-29 15:11:46.079494+00
1030	109	737	moderate	\N	f	110	2026-06-29 15:11:46.079494+00
1031	155	795	primary	Including ellagitannins	f	10	2026-06-29 15:11:46.079494+00
1032	155	797	major	\N	f	20	2026-06-29 15:11:46.079494+00
1033	155	1112	major	\N	f	30	2026-06-29 15:11:46.079494+00
1034	155	741	major	\N	f	40	2026-06-29 15:11:46.079494+00
1035	155	746	major	\N	f	50	2026-06-29 15:11:46.079494+00
1036	155	742	major	\N	f	60	2026-06-29 15:11:46.079494+00
1037	155	784	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1038	155	1046	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1039	37	888	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1040	37	889	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1041	37	890	major	\N	f	30	2026-06-29 15:11:46.079494+00
1042	37	795	major	\N	f	40	2026-06-29 15:11:46.079494+00
1043	37	995	major	Highest in leaves; lower in root	f	50	2026-06-29 15:11:46.079494+00
1044	37	742	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1045	37	998	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1046	56	822	major	Convulsant in large doses; avoid prolonged high-dose use	f	10	2026-06-29 15:11:46.079494+00
1047	56	806	major	\N	f	20	2026-06-29 15:11:46.079494+00
1048	56	809	major	\N	f	30	2026-06-29 15:11:46.079494+00
1049	56	807	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1050	56	783	primary	\N	f	50	2026-06-29 15:11:46.079494+00
1051	56	851	major	\N	f	60	2026-06-29 15:11:46.079494+00
1052	56	852	major	\N	f	70	2026-06-29 15:11:46.079494+00
1053	56	739	major	\N	f	80	2026-06-29 15:11:46.079494+00
1054	56	737	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1055	56	795	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
1056	57	780	primary	Highest in berries	f	10	2026-06-29 15:11:46.079494+00
1057	57	781	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1058	57	779	primary	\N	f	30	2026-06-29 15:11:46.079494+00
1059	57	741	major	\N	f	40	2026-06-29 15:11:46.079494+00
1060	57	742	major	\N	f	50	2026-06-29 15:11:46.079494+00
1061	57	746	major	\N	f	60	2026-06-29 15:11:46.079494+00
1062	57	785	major	\N	f	70	2026-06-29 15:11:46.079494+00
1063	57	932	moderate	Toxic raw; destroyed by heat or fermentation	f	80	2026-06-29 15:11:46.079494+00
1064	57	994	moderate	Higher in flowers	f	90	2026-06-29 15:11:46.079494+00
1065	57	795	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
1066	142	1000	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1067	142	1001	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1068	142	1002	major	\N	f	30	2026-06-29 15:11:46.079494+00
1069	142	1003	major	\N	f	40	2026-06-29 15:11:46.079494+00
1070	142	739	major	\N	f	50	2026-06-29 15:11:46.079494+00
1071	142	737	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1072	142	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1073	142	1113	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1074	186	1022	primary	Lauric, oleic, myristic, linoleic; inhibit 5-alpha-reductase	f	10	2026-06-29 15:11:46.079494+00
1075	186	1021	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1076	186	857	major	\N	f	30	2026-06-29 15:11:46.079494+00
1077	186	858	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1078	186	1053	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1079	186	795	minor	\N	f	60	2026-06-29 15:11:46.079494+00
1080	206	943	primary	Complex of silybin, silydianin, silychristin	f	10	2026-06-29 15:11:46.079494+00
1081	206	944	primary	Most bioactive component; also called silibinin	f	20	2026-06-29 15:11:46.079494+00
1082	206	945	major	\N	f	30	2026-06-29 15:11:46.079494+00
1083	206	946	major	\N	f	40	2026-06-29 15:11:46.079494+00
1084	206	741	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1085	206	1017	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1086	206	1114	major	\N	f	50	2026-06-29 15:11:46.079494+00
1087	89	942	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1088	89	913	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1089	89	783	major	\N	f	30	2026-06-29 15:11:46.079494+00
1090	89	785	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1091	89	980	major	Highest in root; hepatotoxic—internal use of root restricted	f	50	2026-06-29 15:11:46.079494+00
1092	89	981	major	Primary pyrrolizidine alkaloid	f	60	2026-06-29 15:11:46.079494+00
1093	89	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1094	89	1012	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1095	121	842	primary	0.2–0.9% of dry leaf; primary anti-migraine constituent	f	10	2026-06-29 15:11:46.079494+00
1096	121	806	major	\N	f	20	2026-06-29 15:11:46.079494+00
1097	121	739	major	\N	f	40	2026-06-29 15:11:46.079494+00
1098	121	737	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1099	121	741	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1100	121	795	minor	\N	f	70	2026-06-29 15:11:46.079494+00
1101	121	1115	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1102	122	848	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1103	122	849	major	\N	f	20	2026-06-29 15:11:46.079494+00
1104	122	856	major	\N	f	30	2026-06-29 15:11:46.079494+00
1105	122	912	primary	Up to 40% of root in autumn	f	40	2026-06-29 15:11:46.079494+00
1106	122	857	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1107	122	784	major	\N	f	60	2026-06-29 15:11:46.079494+00
1108	122	785	major	\N	f	70	2026-06-29 15:11:46.079494+00
1109	122	997	primary	Abundant in leaves; contributes to diuretic effect	f	80	2026-06-29 15:11:46.079494+00
1110	122	991	major	Especially in leaves	f	90	2026-06-29 15:11:46.079494+00
1111	122	739	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
1112	122	741	moderate	\N	f	110	2026-06-29 15:11:46.079494+00
1113	59	812	primary	20–55% of essential oil; potent antimicrobial	f	10	2026-06-29 15:11:46.079494+00
1114	59	813	primary	1–10% of essential oil	f	20	2026-06-29 15:11:46.079494+00
1115	59	814	major	\N	f	30	2026-06-29 15:11:46.079494+00
1116	59	799	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1117	59	783	major	\N	f	50	2026-06-29 15:11:46.079494+00
1118	59	739	major	\N	f	60	2026-06-29 15:11:46.079494+00
1119	59	737	major	\N	f	70	2026-06-29 15:11:46.079494+00
1120	59	748	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1121	59	795	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1122	90	1116	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1123	90	741	major	\N	f	20	2026-06-29 15:11:46.079494+00
1124	90	746	major	\N	f	30	2026-06-29 15:11:46.079494+00
1125	90	742	major	\N	f	40	2026-06-29 15:11:46.079494+00
1126	90	994	primary	Abundant in bract; demulcent	f	50	2026-06-29 15:11:46.079494+00
1127	90	1117	major	\N	f	60	2026-06-29 15:11:46.079494+00
1128	90	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1129	90	784	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1130	42	767	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1131	42	768	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1132	42	769	major	\N	f	30	2026-06-29 15:11:46.079494+00
1133	42	770	major	\N	f	40	2026-06-29 15:11:46.079494+00
1134	42	746	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1135	42	741	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1136	42	1098	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1137	42	784	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1138	92	913	primary	Inner bark ~60% mucilage	f	10	2026-06-29 15:11:46.079494+00
1139	92	914	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1140	92	795	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1141	92	857	minor	\N	f	40	2026-06-29 15:11:46.079494+00
1142	92	1118	minor	\N	f	50	2026-06-29 15:11:46.079494+00
1143	43	976	primary	Lectin in root; immunomodulatory; inhibits SHBG binding	f	10	2026-06-29 15:11:46.079494+00
1144	43	741	major	\N	f	20	2026-06-29 15:11:46.079494+00
1145	43	746	major	\N	f	30	2026-06-29 15:11:46.079494+00
1146	43	745	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1147	43	784	major	\N	f	50	2026-06-29 15:11:46.079494+00
1148	43	785	major	\N	f	60	2026-06-29 15:11:46.079494+00
1149	43	857	moderate	Especially in root	f	70	2026-06-29 15:11:46.079494+00
1150	43	972	moderate	Especially in root; anti-androgenic	f	80	2026-06-29 15:11:46.079494+00
1151	43	977	major	In stinging hairs of fresh leaf	f	90	2026-06-29 15:11:46.079494+00
1152	43	978	major	In stinging hairs; destroyed by drying/cooking	f	100	2026-06-29 15:11:46.079494+00
1153	43	979	moderate	In stinging hairs	f	110	2026-06-29 15:11:46.079494+00
1154	43	998	major	High in leaf; nutritive	f	120	2026-06-29 15:11:46.079494+00
1155	43	996	moderate	\N	f	130	2026-06-29 15:11:46.079494+00
1156	43	997	major	Contributes to diuretic effect	f	140	2026-06-29 15:11:46.079494+00
1157	145	965	primary	GABA-A receptor modulator; primary sedative constituent	f	10	2026-06-29 15:11:46.079494+00
1158	145	966	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1159	145	967	major	Characteristic odor; sedative	f	30	2026-06-29 15:11:46.079494+00
1160	145	880	primary	In fresh root only; degrade in dried herb	f	40	2026-06-29 15:11:46.079494+00
1161	145	881	major	\N	f	50	2026-06-29 15:11:46.079494+00
1162	145	882	major	\N	f	60	2026-06-29 15:11:46.079494+00
1163	145	838	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1164	145	808	major	\N	f	80	2026-06-29 15:11:46.079494+00
1165	145	807	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1166	145	968	moderate	\N	f	100	2026-06-29 15:11:46.079494+00
1167	145	765	major	\N	f	110	2026-06-29 15:11:46.079494+00
1168	145	750	moderate	\N	f	120	2026-06-29 15:11:46.079494+00
1169	146	1119	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1170	146	1120	major	\N	f	20	2026-06-29 15:11:46.079494+00
1171	146	873	major	\N	f	30	2026-06-29 15:11:46.079494+00
1172	146	795	major	\N	f	40	2026-06-29 15:11:46.079494+00
1173	146	784	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1174	146	739	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1175	146	741	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1176	93	905	primary	Antispasmodic; serotonin antagonist	f	10	2026-06-29 15:11:46.079494+00
1177	93	906	major	\N	f	30	2026-06-29 15:11:46.079494+00
1178	93	926	major	\N	f	40	2026-06-29 15:11:46.079494+00
1179	93	795	major	\N	f	50	2026-06-29 15:11:46.079494+00
1180	93	791	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1181	93	937	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1182	93	1121	major	\N	f	20	2026-06-29 15:11:46.079494+00
1183	93	1122	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1184	94	905	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1185	94	906	major	\N	f	20	2026-06-29 15:11:46.079494+00
1186	94	791	major	\N	f	30	2026-06-29 15:11:46.079494+00
1187	94	926	major	\N	f	40	2026-06-29 15:11:46.079494+00
1188	94	795	major	\N	f	50	2026-06-29 15:11:46.079494+00
1189	94	1122	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1190	94	937	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1191	94	785	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1192	190	873	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1193	190	875	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1194	190	763	primary	\N	f	30	2026-06-29 15:11:46.079494+00
1195	190	756	major	\N	f	40	2026-06-29 15:11:46.079494+00
1196	190	757	major	\N	f	50	2026-06-29 15:11:46.079494+00
1197	190	739	major	\N	f	60	2026-06-29 15:11:46.079494+00
1198	190	809	major	\N	f	70	2026-06-29 15:11:46.079494+00
1199	190	823	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1200	190	810	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1201	20	867	primary	0.001–0.5% of dry root	f	10	2026-06-29 15:11:46.079494+00
1202	20	868	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1203	20	869	major	\N	f	30	2026-06-29 15:11:46.079494+00
1204	20	1103	major	Somniferine, somnine, somniferinine, withananine	f	40	2026-06-29 15:11:46.079494+00
1205	20	1012	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1206	20	857	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1207	20	998	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1208	124	950	primary	Highest in fresh root; 6-gingerol primary	f	10	2026-06-29 15:11:46.079494+00
1209	124	951	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1210	124	952	primary	Formed from gingerols on drying; more potent anti-inflammatory	f	30	2026-06-29 15:11:46.079494+00
1211	124	953	major	\N	f	40	2026-06-29 15:11:46.079494+00
1212	124	832	primary	\N	f	50	2026-06-29 15:11:46.079494+00
1213	124	834	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1214	124	807	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1215	124	806	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1216	124	784	minor	\N	f	90	2026-06-29 15:11:46.079494+00
1217	181	1123	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1218	181	805	major	\N	f	20	2026-06-29 15:11:46.079494+00
1219	181	741	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1220	181	764	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1221	181	742	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1222	309	895	major	\N	t	10	2026-06-29 15:11:46.079494+00
1223	309	795	major	\N	f	30	2026-06-29 15:11:46.079494+00
1224	309	784	moderate	\N	t	40	2026-06-29 15:11:46.079494+00
1225	309	1125	major	\N	t	20	2026-06-29 15:11:46.079494+00
1226	579	1126	major	\N	t	10	2026-06-29 15:11:46.079494+00
1227	579	1013	major	\N	t	20	2026-06-29 15:11:46.079494+00
1228	579	784	moderate	\N	t	30	2026-06-29 15:11:46.079494+00
1229	579	1008	moderate	\N	t	40	2026-06-29 15:11:46.079494+00
1230	980	1127	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1231	980	937	major	\N	f	30	2026-06-29 15:11:46.079494+00
1232	980	1008	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1233	980	1128	major	\N	t	20	2026-06-29 15:11:46.079494+00
1234	179	913	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1235	179	996	major	\N	f	20	2026-06-29 15:11:46.079494+00
1236	179	997	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1237	179	1038	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1238	50	1129	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1239	50	918	major	\N	f	20	2026-06-29 15:11:46.079494+00
1240	50	784	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1241	50	741	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1242	165	960	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1243	165	962	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1244	165	961	major	\N	f	30	2026-06-29 15:11:46.079494+00
1245	165	963	primary	\N	f	40	2026-06-29 15:11:46.079494+00
1246	165	964	primary	\N	f	50	2026-06-29 15:11:46.079494+00
1247	165	741	major	\N	f	60	2026-06-29 15:11:46.079494+00
1248	165	746	major	\N	f	70	2026-06-29 15:11:46.079494+00
1249	165	745	major	\N	f	80	2026-06-29 15:11:46.079494+00
1250	165	778	moderate	\N	f	90	2026-06-29 15:11:46.079494+00
1251	58	1130	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1252	58	741	major	\N	f	20	2026-06-29 15:11:46.079494+00
1253	58	742	major	\N	f	30	2026-06-29 15:11:46.079494+00
1254	58	746	major	\N	f	40	2026-06-29 15:11:46.079494+00
1255	58	784	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1256	58	785	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1257	58	1038	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1258	58	795	moderate	\N	f	80	2026-06-29 15:11:46.079494+00
1259	88	1038	major	\N	f	10	2026-06-29 15:11:46.079494+00
1260	88	994	major	\N	f	20	2026-06-29 15:11:46.079494+00
1261	88	1098	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1262	88	741	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1263	88	742	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1264	88	1046	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1265	61	1131	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1266	61	913	primary	\N	f	20	2026-06-29 15:11:46.079494+00
1267	61	873	major	\N	f	30	2026-06-29 15:11:46.079494+00
1268	61	784	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1269	61	739	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1270	61	737	moderate	\N	f	60	2026-06-29 15:11:46.079494+00
1271	61	795	moderate	\N	f	70	2026-06-29 15:11:46.079494+00
1272	95	1132	primary	\N	f	10	2026-06-29 15:11:46.079494+00
1273	95	997	major	Contributes to diuretic effect	f	20	2026-06-29 15:11:46.079494+00
1274	95	1038	moderate	\N	f	30	2026-06-29 15:11:46.079494+00
1275	95	795	moderate	\N	f	40	2026-06-29 15:11:46.079494+00
1276	95	784	moderate	\N	f	50	2026-06-29 15:11:46.079494+00
1277	95	858	minor	\N	f	60	2026-06-29 15:11:46.079494+00
\.


--
-- Data for Name: herb_menstruum; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herb_menstruum (herb_id, alcohol_pct_min, alcohol_pct_max, glycerin_pct, vinegar_pct, water_effective, primary_label, notes, needs_review, created_at) FROM stdin;
79	14	15	\N	\N	t	water or 14–15% alcohol (distillate)	Commercial witch hazel is a water distillate (~14% alcohol). Bark tincture at 25–40% for fuller tannin extraction.	f	2026-06-29 15:11:46.079494+00
80	30	60	\N	\N	t	30–60% alcohol or water	Iridoid glycosides are water-soluble; moderate alcohol captures flavonoids too. Decoction traditional.	f	2026-06-29 15:11:46.079494+00
129	60	70	\N	\N	f	60–70% alcohol	Alpha and beta acids and prenylated flavanones require moderate-high alcohol.	f	2026-06-29 15:11:46.079494+00
30	40	60	\N	\N	f	40–60% alcohol	Isoquinoline alkaloids require moderate alcohol; water extraction is partial but less effective for berberine.	f	2026-06-29 15:11:46.079494+00
81	60	75	\N	\N	f	60–75% alcohol (fresh flower)	Hyperforin is highly lipophilic; requires high alcohol. Hypericins need moderate-high alcohol. Fresh flowering tops tincture preferred.	f	2026-06-29 15:11:46.079494+00
53	40	60	\N	\N	t	40–60% alcohol or water	Volatile monoterpenes captured in moderate alcohol; flavonoids and marrubiin also extract in water.	f	2026-06-29 15:11:46.079494+00
54	25	60	\N	\N	t	25–60% alcohol or water decoction	Inulin in water; sesquiterpene lactones in moderate alcohol. Root decoction traditional for respiratory use.	f	2026-06-29 15:11:46.079494+00
103	40	70	\N	\N	f	40–70% alcohol	Volatile terpenes require moderate-high alcohol. Not for use in kidney disease.	f	2026-06-29 15:11:46.079494+00
130	60	70	\N	\N	f	60–70% alcohol	Bitter sesquiterpene lactones require moderate-high alcohol. Fresh plant latex strongest.	f	2026-06-29 15:11:46.079494+00
82	60	80	\N	\N	f	60–80% alcohol	Volatile monoterpenes require high alcohol for flower tincture; aromatic herb.	f	2026-06-29 15:11:46.079494+00
131	25	60	\N	\N	t	25–60% alcohol or water	Alkaloids and flavonoids extract in moderate alcohol; fresh plant tincture at 25–40% preferred.	f	2026-06-29 15:11:46.079494+00
132	40	70	\N	\N	f	40–70% alcohol	Piperidine alkaloids require moderate-high alcohol. Narrow therapeutic window—use with care.	f	2026-06-29 15:11:46.079494+00
33	40	60	\N	\N	f	40–60% alcohol	Isoquinoline alkaloids require moderate alcohol. Root bark tincture.	f	2026-06-29 15:11:46.079494+00
84	40	60	\N	\N	t	40–60% alcohol or water	Apigenin and volatile oils in moderate alcohol; water infusion captures water-soluble flavonoid glycosides and mucilage.	f	2026-06-29 15:11:46.079494+00
134	25	60	\N	\N	t	25–60% alcohol or water	Rosmarinic acid water-soluble; volatile oils need moderate alcohol. Fresh plant preferred.	f	2026-06-29 15:11:46.079494+00
55	40	70	\N	\N	t	40–70% alcohol or water	Menthol and volatile oils in moderate alcohol; water infusion captures menthol partially and is traditional.	f	2026-06-29 15:11:46.079494+00
188	25	50	\N	\N	t	25–50% alcohol or water	\N	t	2026-06-29 15:11:46.079494+00
136	25	60	\N	\N	t	25–60% alcohol or water	Gentle herb; water infusion is traditional and effective. Fresh plant tincture captures nepetalactone better.	f	2026-06-29 15:11:46.079494+00
14	40	70	\N	\N	t	40–70% alcohol or water decoction	Ginsenosides extract in moderate alcohol; polysaccharides in water decoction. Both needed for full activity.	f	2026-06-29 15:11:46.079494+00
137	25	60	\N	\N	t	25–60% alcohol or water	Flavone C-glycosides are water-soluble; moderate alcohol captures chrysin and lipophilic flavones.	f	2026-06-29 15:11:46.079494+00
138	30	60	\N	\N	t	30–60% alcohol or water+fat emulsion	Kavalactones are lipophilic; traditional preparation is water + coconut milk (fat emulsification). Moderate alcohol tincture also effective.	f	2026-06-29 15:11:46.079494+00
139	40	60	\N	\N	f	40–60% alcohol	Isoflavones and organic acids require moderate alcohol. Root bark preparation.	f	2026-06-29 15:11:46.079494+00
1428	\N	\N	60	\N	t	cold water or glycerin	Mucilage and iridoid glycosides extract in cold water or glycerin; heat degrades mucilage. Fresh plant juice also effective.	f	2026-06-29 15:11:46.079494+00
44	25	60	\N	\N	t	25–60% alcohol or water	Fresh plant tincture at 25%; dried herb needs 40–60%. Water extracts volatile oils via steam.	f	2026-06-29 15:09:48.1073+00
62	40	60	\N	\N	f	40–60% alcohol	Saponins and coumarins require moderate alcohol; bark tincture.	f	2026-06-29 15:09:48.1073+00
148	25	45	\N	\N	t	25–45% alcohol or water	Tannins and flavonoids extract well in water or low alcohol.	f	2026-06-29 15:09:48.1073+00
21	25	50	\N	\N	t	water or 25–50% alcohol	Organosulfurs extract in water; alcohol stabilizes. Fresh plant preferred.	f	2026-06-29 15:09:48.1073+00
45	\N	\N	60	\N	t	cold water or glycerin	Mucilages are destroyed by heat and precipitated by alcohol; cold infusion or glycerite best.	f	2026-06-29 15:09:48.1073+00
22	25	60	\N	\N	t	25–60% alcohol or water	Inulin extracts in water; bitter sesquiterpenes need moderate alcohol.	f	2026-06-29 15:09:48.1073+00
46	25	60	\N	\N	t	25–60% alcohol or water	Arbutin is water-soluble; tannins extract in water or low alcohol.	f	2026-06-29 15:09:48.1073+00
97	40	70	\N	\N	f	40–70% alcohol	Bitter sesquiterpenes and volatile oils require moderate-high alcohol.	f	2026-06-29 15:09:48.1073+00
115	40	65	\N	\N	f	40–65% alcohol	Similar profile to wormwood; bitter sesquiterpenes need moderate alcohol.	f	2026-06-29 15:09:48.1073+00
225	25	60	\N	\N	t	25–60% alcohol or water decoction	Polysaccharides extract in hot water; saponins in moderate alcohol. Traditional use is decoction.	f	2026-06-29 15:09:48.1073+00
178	25	60	\N	\N	t	25–60% alcohol (milky oats fresh)	Milky stage oats tincture in 25–60% alcohol; dried herb less active.	f	2026-06-29 15:09:48.1073+00
23	50	70	\N	\N	f	50–70% alcohol	Alkaloids and isoflavones require moderate-high alcohol. Use sparingly—low therapeutic index.	f	2026-06-29 15:09:48.1073+00
70	60	90	\N	\N	f	60–90% alcohol	Resins and carotenoids require high alcohol. Infused oil captures carotenoids topically.	f	2026-06-29 15:09:48.1073+00
47	60	90	\N	\N	f	60–90% alcohol	Capsaicinoids are highly lipophilic; require high-% alcohol or oil.	f	2026-06-29 15:09:48.1073+00
25	40	60	\N	\N	f	40–60% alcohol	Triterpene glycosides require moderate alcohol; root tincture standard preparation.	f	2026-06-29 15:09:48.1073+00
1124	25	60	\N	\N	t	25–60% alcohol or water	Bitter lactone extracts readily in moderate alcohol; water infusion also effective.	f	2026-06-29 15:09:48.1073+00
99	90	95	\N	\N	f	90–95% alcohol	Resins require very high alcohol or are used as oleo-gum-resin. Water will not dissolve resins.	f	2026-06-29 15:09:48.1073+00
73	40	60	\N	\N	t	40–60% alcohol or water	Flavonoids and OPCs extract in moderate alcohol; berry tea also effective.	f	2026-06-29 15:09:48.1073+00
203	60	75	\N	\N	f	60–75% alcohol	Curcuminoids are poorly water-soluble; require moderate-high alcohol or fat/oil. Black pepper (piperine) enhances bioavailability.	f	2026-06-29 15:09:48.1073+00
164	40	60	\N	\N	f	40–60% alcohol	Quinolizidine alkaloids require moderate alcohol. Caution: narrow therapeutic index.	f	2026-06-29 15:09:48.1073+00
26	60	70	\N	\N	f	60–70% alcohol (fresh root)	Alkamides require 60–70% alcohol; caffeic acid derivatives also extract. Polysaccharides lost in high alcohol—use separately as water extract if desired.	f	2026-06-29 15:09:48.1073+00
9	30	60	\N	\N	t	30–60% alcohol or water decoction	Eleutherosides extract in moderate alcohol; polysaccharides in water decoction.	f	2026-06-29 15:09:48.1073+00
151	25	40	\N	\N	t	25–40% alcohol or water	Silicic acid is water-soluble; low alcohol tincture or decoction preferred.	f	2026-06-29 15:09:48.1073+00
128	40	70	\N	\N	f	40–70% alcohol (fresh plant)	Isoquinoline alkaloids require moderate-high alcohol. Fresh plant preferred; whole plant tincture.	f	2026-06-29 15:09:48.1073+00
75	25	45	\N	\N	t	25–45% alcohol or water	Salicylate glycosides and flavonoids extract in water or low alcohol; gentle preparation preserves volatile components.	f	2026-06-29 15:09:48.1073+00
28	\N	\N	\N	\N	t	cold water (fresh plant juice)	Fresh plant juice or cold infusion best; iridoid glycosides degrade with heat and high alcohol.	f	2026-06-29 15:09:48.1073+00
11	25	40	\N	\N	t	dual extraction: water + 25–40% alcohol	Beta-glucans require hot water decoction; triterpenoids require alcohol. Dual extraction recommended for full spectrum.	f	2026-06-29 15:09:48.1073+00
102	25	60	\N	\N	t	25–60% alcohol or water	Bitter secoiridoids are highly water-soluble; low-alcohol tincture or decoction. Bitter threshold: 1:20,000 dilution.	f	2026-06-29 15:09:48.1073+00
78	25	50	\N	\N	t	25–50% alcohol or water	Glycyrrhizin is water-soluble; moderate alcohol captures flavonoids and glycyrrhizin. Decoction traditional.	f	2026-06-29 15:09:48.1073+00
109	60	75	\N	\N	f	60–75% alcohol	Diterpene phenols and volatile oils require moderate-high alcohol. Water captures rosmarinic acid well.	f	2026-06-29 15:11:46.079494+00
155	25	45	\N	\N	t	25–45% alcohol or water	Tannins and flavonoids extract readily in water or low alcohol; traditional as tea.	f	2026-06-29 15:11:46.079494+00
37	25	60	\N	\N	t	25–60% alcohol or water decoction	Anthraquinone glycosides extract in moderate alcohol; root decoction also effective.	f	2026-06-29 15:11:46.079494+00
56	40	70	\N	\N	t	40–70% alcohol or water	Diterpene phenols need moderate alcohol; rosmarinic acid extracts in water. Fresh-dried leaf preferred.	f	2026-06-29 15:11:46.079494+00
57	25	60	\N	\N	t	25–60% alcohol, water, or glycerin	Anthocyanins (berry) and flavonoids extract in water, glycerin, or moderate alcohol. Flower glycerite effective. Always heat berries to destroy sambunigrin.	f	2026-06-29 15:11:46.079494+00
142	50	60	\N	\N	f	50–60% alcohol (fresh plant)	Baicalin is water-soluble but baicalein requires alcohol. Fresh plant tincture at 50–60% captures full spectrum. Adulteration with Teucrium common—verify source.	f	2026-06-29 15:11:46.079494+00
186	80	95	\N	\N	f	80–95% alcohol or lipid extract	Lipophilic fatty acids and sterols require high-% alcohol or oil/lipid extraction. Supercritical CO₂ extract is gold standard.	f	2026-06-29 15:11:46.079494+00
206	70	80	\N	\N	f	70–80% alcohol	Silymarin flavonolignans are poorly water-soluble; require high alcohol. Standardized seed extract common. Phospholipid complex improves bioavailability.	f	2026-06-29 15:11:46.079494+00
89	\N	\N	60	\N	t	cold water or glycerin (leaf only)	Allantoin and mucilage extract in cold water; glycerin also effective. Avoid internal use of root preparations due to pyrrolizidine alkaloids.	f	2026-06-29 15:11:46.079494+00
121	40	70	\N	\N	f	40–70% alcohol (fresh plant)	Parthenolide is lipophilic; requires moderate-high alcohol. Fresh leaf tincture preferred; parthenolide degrades in dried herb.	f	2026-06-29 15:11:46.079494+00
122	25	50	\N	\N	t	25–50% alcohol or water	Bitter sesquiterpenes and polyphenols in moderate alcohol; inulin and minerals in water. Root decoction or leaf infusion both traditional.	f	2026-06-29 15:11:46.079494+00
59	40	70	\N	\N	t	40–70% alcohol or water	Thymol and carvacrol require moderate alcohol; water infusion captures volatile oils via steam and is traditional for respiratory use.	f	2026-06-29 15:11:46.079494+00
90	25	60	\N	\N	t	25–60% alcohol or water	Mucilage and flavonoid glycosides extract in water or low alcohol; gentle warm infusion traditional.	f	2026-06-29 15:11:46.079494+00
42	40	60	\N	\N	t	40–60% alcohol or water	Isoflavones partially water-soluble; moderate alcohol for better extraction of formononetin and biochanin A.	f	2026-06-29 15:11:46.079494+00
92	\N	\N	60	\N	t	cold water or glycerin	Mucilage is destroyed by alcohol and heat; cold-water preparation or glycerite only. Denatured by boiling.	f	2026-06-29 15:11:46.079494+00
43	25	60	\N	\N	t	25–60% alcohol or water	Flavonoids and minerals extract in water; root lectins and lignans in moderate alcohol. Fresh plant juice also effective for leaf.	f	2026-06-29 15:11:46.079494+00
145	40	70	\N	\N	f	40–70% alcohol (fresh root)	Valerenic acids and valepotriates require moderate alcohol; valepotriates degrade in water and dried herb. Fresh root tincture captures full profile.	f	2026-06-29 15:11:46.079494+00
146	25	60	\N	\N	t	25–60% alcohol or water	Iridoid glycosides water-soluble; tannins also extract in water. Moderate alcohol tincture of fresh plant preferred.	f	2026-06-29 15:11:46.079494+00
93	40	60	\N	\N	f	40–60% alcohol	Coumarins and resins require moderate alcohol; bark tincture standard preparation.	f	2026-06-29 15:11:46.079494+00
94	40	60	\N	\N	f	40–60% alcohol	Similar to cramp bark; coumarins and resins require moderate alcohol. Bark or root bark tincture.	f	2026-06-29 15:11:46.079494+00
190	60	70	\N	\N	f	60–70% alcohol	Diterpenes and volatile oils require moderate-high alcohol. Berry tincture; long-term use required for effect (3–6 months).	f	2026-06-29 15:11:46.079494+00
20	40	70	\N	\N	t	40–70% alcohol or milk decoction	Withanolides extract in moderate alcohol; traditional use is milk decoction (fat helps absorption of lipophilic withanolides). Dual extraction ideal.	f	2026-06-29 15:11:46.079494+00
124	40	70	\N	\N	t	40–70% alcohol or water	Gingerols and shogaols in moderate alcohol; ginger tea (water) is highly effective for volatile gingerols and is traditional. Fresh root tincture at 60–70% for maximum potency.	f	2026-06-29 15:11:46.079494+00
181	60	70	\N	\N	f	60–70% alcohol	Volatile diosphenol requires moderate-high alcohol.	f	2026-06-29 15:11:46.079494+00
309	40	70	\N	\N	f	40–70% alcohol	\N	t	2026-06-29 15:11:46.079494+00
579	40	60	\N	\N	f	40–60% alcohol	\N	t	2026-06-29 15:11:46.079494+00
980	60	80	\N	\N	f	60–80% alcohol	Resins and furanocoumarins require moderate-high alcohol. Fresh root.	t	2026-06-29 15:11:46.079494+00
179	\N	\N	\N	\N	t	water decoction	Mucilage and silica extract in water decoction; rhizome.	f	2026-06-29 15:11:46.079494+00
50	25	60	\N	\N	t	25–60% alcohol or water	Bitter flavones and polysaccharides extract in water or moderate alcohol.	f	2026-06-29 15:11:46.079494+00
165	60	70	\N	\N	f	60–70% alcohol	Ginkgolides and bilobalide require moderate-high alcohol. Standardized extract (24% flavone glycosides, 6% terpene lactones) is the research form.	f	2026-06-29 15:11:46.079494+00
58	25	60	\N	\N	t	25–60% alcohol or water	Phenolic glycosides and flavonoids extract in water or moderate alcohol; traditional as tea.	f	2026-06-29 15:11:46.079494+00
88	\N	\N	\N	\N	t	fresh plant juice or cold water	Demulcent saponins and mucilage in fresh plant; primarily a topical or fresh-juice herb.	f	2026-06-29 15:11:46.079494+00
61	\N	\N	60	\N	t	water or glycerin	Mucilage and saponins extract in water or glycerin; avoid high alcohol which precipitates mucilage.	f	2026-06-29 15:11:46.079494+00
95	25	60	\N	\N	t	25–60% alcohol or water	Flavone glycosides and minerals extract in water or low-moderate alcohol; tea is traditional.	f	2026-06-29 15:11:46.079494+00
\.


--
-- Data for Name: herb_primary_actions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herb_primary_actions (id, herb_id, primary_action_id, body_system_id, body_system_note, relative_strength, created_at) FROM stdin;
47	1	1	\N	\N	\N	2026-03-22 21:15:28.860367+00
48	2	1	\N	\N	\N	2026-03-22 21:15:28.864506+00
49	3	1	\N	\N	\N	2026-03-22 21:15:28.8667+00
50	4	1	\N	\N	\N	2026-03-22 21:15:28.869125+00
51	5	1	\N	\N	\N	2026-03-22 21:15:28.870665+00
52	6	1	\N	\N	\N	2026-03-22 21:15:28.872882+00
53	7	1	\N	\N	\N	2026-03-22 21:15:28.874695+00
54	8	1	\N	\N	\N	2026-03-22 21:15:28.876419+00
56	10	1	\N	\N	\N	2026-03-22 21:15:28.879809+00
57	11	1	\N	\N	\N	2026-03-22 21:15:28.881635+00
58	12	1	\N	\N	\N	2026-03-22 21:15:28.900256+00
59	13	1	\N	\N	\N	2026-03-22 21:15:28.903098+00
61	15	1	\N	\N	\N	2026-03-22 21:15:28.906662+00
62	16	1	\N	\N	\N	2026-03-22 21:15:28.908764+00
63	17	1	\N	\N	\N	2026-03-22 21:15:28.910856+00
64	18	1	\N	\N	\N	2026-03-22 21:15:28.913147+00
65	19	1	\N	\N	\N	2026-03-22 21:15:28.915547+00
67	21	2	9	The hypocholesteremic and hypotensive actions are well known	mild	2026-03-22 21:15:28.918937+00
68	21	2	10	The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole	mild	2026-03-22 21:15:28.921029+00
69	21	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	mild	2026-03-22 21:15:28.922858+00
70	22	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	strong	2026-03-22 21:15:28.924826+00
71	22	2	14	Many alteratives are important here	strong	2026-03-22 21:15:28.928079+00
72	22	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.930067+00
73	23	2	10	The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole	mild	2026-03-22 21:15:28.932671+00
74	24	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	mild	2026-03-22 21:15:28.934721+00
75	25	2	13	Here, the general alteratives are always of value	mild	2026-03-22 21:15:28.936598+00
76	25	2	14	Many alteratives are important here	mild	2026-03-22 21:15:28.937801+00
77	26	2	9	In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation	mild	2026-03-22 21:15:28.939082+00
78	26	2	10	The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole	mild	2026-03-22 21:15:28.940283+00
79	26	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	mild	2026-03-22 21:15:28.941691+00
80	27	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.943168+00
81	28	2	9	In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation	strong	2026-03-22 21:15:28.944308+00
82	28	2	12	Some of the herbs described as diuretics could be characterized as urinary system alteratives	strong	2026-03-22 21:15:28.945413+00
83	28	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.946544+00
84	29	2	\N	\N	strong	2026-03-22 21:15:28.947709+00
85	30	2	10	The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole	strong	2026-03-22 21:15:28.949028+00
86	30	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	strong	2026-03-22 21:15:28.950192+00
87	30	2	13	Here, the general alteratives are always of value	strong	2026-03-22 21:15:28.951741+00
88	31	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	very_strong	2026-03-22 21:15:28.95297+00
89	32	2	\N	\N	very_strong	2026-03-22 21:15:28.954093+00
126	49	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.007816+00
257	113	6	\N	\N	\N	2026-03-22 21:15:29.19752+00
55	9	1	11	\N	\N	2026-03-22 21:15:28.877971+00
60	14	1	11	\N	\N	2026-03-22 21:15:28.904748+00
66	20	1	11	\N	\N	2026-03-22 21:15:28.917424+00
90	33	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	mild	2026-03-22 21:15:28.955221+00
91	34	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	mild	2026-03-22 21:15:28.956865+00
92	34	2	14	Many alteratives are important here	mild	2026-03-22 21:15:28.958018+00
93	35	2	9	In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation	very_strong	2026-03-22 21:15:28.959159+00
94	36	2	15	By helping the body to be healthy and whole, all alteratives aid the strained nervous system, but this is especially helpful as an alterative with nervine actions	mild	2026-03-22 21:15:28.960447+00
95	37	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	strong	2026-03-22 21:15:28.961598+00
96	37	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.962943+00
97	38	2	10	The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole	very_strong	2026-03-22 21:15:28.963953+00
98	39	2	9	useful in chronic eczema, also has positive inotropic actions	strong	2026-03-22 21:15:28.965008+00
99	39	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.966074+00
100	40	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	strong	2026-03-22 21:15:28.967073+00
101	40	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.968503+00
102	41	2	\N	\N	very_strong	2026-03-22 21:15:28.969541+00
103	42	2	15	By helping the body to be healthy and whole, all alteratives aid the strained nervous system, but this is especially helpful as an alterative with nervine actions	strong	2026-03-22 21:15:28.970603+00
104	42	2	16	The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies	strong	2026-03-22 21:15:28.972026+00
105	43	2	11	All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine	strong	2026-03-22 21:15:28.973292+00
106	43	2	12	Some of the herbs described as diuretics could be characterized as urinary system alteratives	strong	2026-03-22 21:15:28.974732+00
107	44	3	9	Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination	\N	2026-03-22 21:15:28.976266+00
108	44	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:28.977744+00
109	44	3	13	While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider	\N	2026-03-22 21:15:28.979452+00
110	21	3	9	Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination	\N	2026-03-22 21:15:28.980845+00
111	21	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:28.98224+00
112	21	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:28.983471+00
113	21	3	16	Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes	\N	2026-03-22 21:15:28.985451+00
114	45	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:28.987434+00
115	45	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:28.98896+00
116	46	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:28.990977+00
117	46	3	12	In addition to their anticatarrhal properties	\N	2026-03-22 21:15:28.993363+00
118	46	3	13	While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider	\N	2026-03-22 21:15:28.995361+00
119	23	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:28.997055+00
120	23	3	16	Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes	\N	2026-03-22 21:15:28.998456+00
121	47	3	9	Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination	\N	2026-03-22 21:15:29.000208+00
122	47	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.002531+00
123	47	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.004104+00
124	48	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.005399+00
125	48	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.006687+00
127	49	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.008974+00
128	26	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.010639+00
129	26	3	16	Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes	\N	2026-03-22 21:15:29.015538+00
130	50	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.017363+00
131	50	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.019108+00
132	51	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.02082+00
133	52	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.022388+00
134	52	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.023785+00
135	52	3	13	While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider	\N	2026-03-22 21:15:29.024917+00
136	30	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.026073+00
137	30	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.027758+00
138	30	3	13	While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider	\N	2026-03-22 21:15:29.029486+00
139	30	3	16	Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes	\N	2026-03-22 21:15:29.030747+00
140	53	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.032163+00
141	54	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.033392+00
142	55	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.035013+00
143	55	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.036125+00
144	56	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.0374+00
145	56	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.038828+00
146	57	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.040289+00
147	57	3	16	Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes	\N	2026-03-22 21:15:29.041571+00
148	58	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.045083+00
149	58	3	12	In addition to their anticatarrhal properties	\N	2026-03-22 21:15:29.048165+00
150	59	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.053038+00
151	59	3	11	Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems	\N	2026-03-22 21:15:29.055983+00
152	60	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.057827+00
153	61	3	10	All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems	\N	2026-03-22 21:15:29.059374+00
154	44	4	\N	\N	\N	2026-03-22 21:15:29.060695+00
155	62	4	\N	\N	\N	2026-03-22 21:15:29.062208+00
156	63	4	13	Many tonics and other specific reproductive remedies will often have anti-inflammatory actions	\N	2026-03-22 21:15:29.063465+00
157	45	4	11	Demulcent remedies rich in mucilage, can have the localized effect of reducing inflammation through contact soothing	\N	2026-03-22 21:15:29.064655+00
158	64	4	\N	\N	\N	2026-03-22 21:15:29.065846+00
159	65	4	\N	\N	\N	2026-03-22 21:15:29.066948+00
160	66	4	\N	\N	\N	2026-03-22 21:15:29.068003+00
161	67	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.068991+00
162	68	4	14	For hardworking and abused muscles and bones, salicylate-containing remedies come into their own	\N	2026-03-22 21:15:29.070004+00
163	69	4	\N	\N	\N	2026-03-22 21:15:29.070962+00
164	70	4	16	Numerous remedies reduce inflammation on the skin	\N	2026-03-22 21:15:29.072132+00
165	71	4	\N	\N	\N	2026-03-22 21:15:29.073234+00
166	72	4	13	Many tonics and other specific reproductive remedies will often have anti-inflammatory actions	\N	2026-03-22 21:15:29.074733+00
167	48	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.075725+00
168	49	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.076908+00
169	25	4	14	\N	\N	2026-03-22 21:15:29.077925+00
170	73	4	\N	\N	\N	2026-03-22 21:15:29.079153+00
171	74	4	11	As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids	\N	2026-03-22 21:15:29.080311+00
172	74	4	14	\N	\N	2026-03-22 21:15:29.081934+00
173	75	4	14	For hardworking and abused muscles and bones, salicylate-containing remedies come into their own,	\N	2026-03-22 21:15:29.08319+00
174	76	4	\N	\N	\N	2026-03-22 21:15:29.084372+00
175	28	4	\N	\N	\N	2026-03-22 21:15:29.08544+00
176	77	4	\N	\N	\N	2026-03-22 21:15:29.086435+00
177	52	4	\N	\N	\N	2026-03-22 21:15:29.087363+00
178	78	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.088347+00
179	78	4	11	As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids	\N	2026-03-22 21:15:29.089417+00
180	29	4	\N	\N	\N	2026-03-22 21:15:29.090449+00
181	79	4	\N	\N	\N	2026-03-22 21:15:29.091427+00
182	80	4	14	\N	\N	2026-03-22 21:15:29.092302+00
253	65	6	\N	\N	\N	2026-03-22 21:15:29.189647+00
254	66	6	\N	\N	\N	2026-03-22 21:15:29.192559+00
255	22	6	\N	\N	\N	2026-03-22 21:15:29.194462+00
256	46	6	\N	\N	mild	2026-03-22 21:15:29.196003+00
183	30	4	11	As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids	\N	2026-03-22 21:15:29.09325+00
184	30	4	16	Numerous remedies reduce inflammation on the skin	\N	2026-03-22 21:15:29.094651+00
185	81	4	15	While the nervous system often feels as if it needs anti-inflammatories, the best remedies for the “inflamed state of mind” are the relaxing nervines. The only direct anti-inflammatory for nervous system tissue is this, which helps speed the recovery of damaged nerves.	\N	2026-03-22 21:15:29.096744+00
186	81	4	16	Numerous remedies reduce inflammation on the skin	\N	2026-03-22 21:15:29.098488+00
187	53	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.099495+00
188	82	4	\N	\N	\N	2026-03-22 21:15:29.100599+00
189	83	4	\N	\N	\N	2026-03-22 21:15:29.101593+00
190	84	4	11	As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids	\N	2026-03-22 21:15:29.102659+00
191	55	4	11	As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids	\N	2026-03-22 21:15:29.1039+00
192	34	4	14	\N	\N	2026-03-22 21:15:29.104938+00
193	85	4	16	Numerous remedies reduce inflammation on the skin	\N	2026-03-22 21:15:29.105943+00
194	86	4	14	For hardworking and abused muscles and bones, salicylate-containing remedies come into their own,	\N	2026-03-22 21:15:29.106977+00
195	87	4	14	For hardworking and abused muscles and bones, salicylate-containing remedies come into their own	\N	2026-03-22 21:15:29.10788+00
196	56	4	\N	\N	\N	2026-03-22 21:15:29.108854+00
197	57	4	10	For the upper respiratory system, consider	\N	2026-03-22 21:15:29.109784+00
198	58	4	10	For the upper respiratory system, consider	\N	2026-03-22 21:15:29.110935+00
199	58	4	12	A number of herbs soothe the tissue of the urinary tract directly as their anti-inflammatory constituents pass through the kidneys and bladder. Plants that soothe the tissue and fight infection will also have an anti-inflammatory action	\N	2026-03-22 21:15:29.111797+00
200	88	4	16	Numerous remedies reduce inflammation on the skin	\N	2026-03-22 21:15:29.112856+00
201	89	4	\N	\N	\N	2026-03-22 21:15:29.113949+00
202	90	4	\N	\N	\N	2026-03-22 21:15:29.115089+00
203	91	4	\N	\N	\N	2026-03-22 21:15:29.11612+00
204	60	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.117083+00
205	92	4	\N	\N	\N	2026-03-22 21:15:29.118107+00
206	61	4	10	For the lower respiratory system, consider	\N	2026-03-22 21:15:29.119096+00
207	93	4	\N	\N	\N	2026-03-22 21:15:29.120073+00
208	94	4	\N	\N	\N	2026-03-22 21:15:29.121258+00
209	95	4	12	A number of herbs soothe the tissue of the urinary tract directly as their anti-inflammatory constituents pass through the kidneys and bladder. Plants that soothe the tissue and fight infection will also have an anti-inflammatory action	\N	2026-03-22 21:15:29.122296+00
210	44	5	9	mong antimicrobial herbs, Allium sativum and Achillea millefolium have a reputation as tonics for this system.	\N	2026-03-22 21:15:29.123232+00
211	44	5	12	Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong	\N	2026-03-22 21:15:29.124332+00
212	21	5	9	among antimicrobial herbs, Allium sativum and Achillea millefolium have a reputation as tonics for this system. Allium sativum is especially appropriate because of its broad value for the cardiovascular system in general.	\N	2026-03-22 21:15:29.125387+00
213	21	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines.	\N	2026-03-22 21:15:29.126407+00
214	21	5	13	as well as urinary antimicrobials	\N	2026-03-22 21:15:29.127742+00
215	21	5	16	Many antimicrobial herbs can be used on the skin. A wash of this can be most effective	\N	2026-03-22 21:15:29.129193+00
216	46	5	12	Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong	\N	2026-03-22 21:15:29.130145+00
217	96	5	13	as well as urinary antimicrobials	\N	2026-03-22 21:15:29.131126+00
218	97	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines	\N	2026-03-22 21:15:29.132317+00
219	23	5	10	\N	\N	2026-03-22 21:15:29.133502+00
220	23	5	14	provides a good basis for treatment	\N	2026-03-22 21:15:29.134542+00
221	70	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines	mild	2026-03-22 21:15:29.135511+00
222	47	5	\N	\N	\N	2026-03-22 21:15:29.136459+00
223	98	5	\N	\N	mild	2026-03-22 21:15:29.137431+00
224	99	5	10	\N	\N	2026-03-22 21:15:29.13846+00
225	99	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines	\N	2026-03-22 21:15:29.139457+00
226	99	5	16	is one of the strongest external remedies	\N	2026-03-22 21:15:29.140455+00
227	100	5	\N	\N	mild	2026-03-22 21:15:29.141573+00
228	26	5	10	\N	\N	2026-03-22 21:15:29.142572+00
229	26	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines.	\N	2026-03-22 21:15:29.143566+00
230	26	5	13	as well as urinary antimicrobials	\N	2026-03-22 21:15:29.144535+00
231	26	5	14	provides a good basis for treatment	\N	2026-03-22 21:15:29.145518+00
232	101	5	12	Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong	\N	2026-03-22 21:15:29.146496+00
233	102	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines	mild	2026-03-22 21:15:29.147832+00
234	30	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines	\N	2026-03-22 21:15:29.148825+00
235	81	5	15	in combination with nervines and other antimicrobial herbs, will help with the intransigent infections that can affect the nervous system	\N	2026-03-22 21:15:29.149833+00
236	54	5	10	\N	\N	2026-03-22 21:15:29.153633+00
237	103	5	12	Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong	\N	2026-03-22 21:15:29.156327+00
238	104	5	10	\N	\N	2026-03-22 21:15:29.15918+00
239	55	5	\N	\N	\N	2026-03-22 21:15:29.16144+00
240	105	5	10	\N	\N	2026-03-22 21:15:29.16387+00
241	106	5	\N	\N	mild	2026-03-22 21:15:29.165719+00
242	107	5	16	Many antimicrobial herbs can be used on the skin. A wash of this can be most effective	mild	2026-03-22 21:15:29.167329+00
243	108	5	10	\N	mild	2026-03-22 21:15:29.169085+00
244	85	5	\N	\N	mild	2026-03-22 21:15:29.170565+00
245	109	5	16	Many antimicrobial herbs can be used on the skin. A wash of this can be most effective	\N	2026-03-22 21:15:29.174061+00
246	110	5	\N	\N	\N	2026-03-22 21:15:29.175914+00
247	56	5	11	Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines	\N	2026-03-22 21:15:29.1778+00
248	111	5	10	\N	mild	2026-03-22 21:15:29.179748+00
249	59	5	10	\N	\N	2026-03-22 21:15:29.181912+00
250	59	5	16	Many antimicrobial herbs can be used on the skin. A wash of this can be most effective	\N	2026-03-22 21:15:29.184202+00
251	112	5	\N	\N	\N	2026-03-22 21:15:29.185996+00
252	44	6	\N	\N	mild	2026-03-22 21:15:29.187818+00
258	114	6	\N	\N	mild	2026-03-22 21:15:29.199057+00
259	97	6	\N	\N	mild	2026-03-22 21:15:29.202174+00
260	115	6	\N	\N	mild	2026-03-22 21:15:29.205828+00
261	68	6	\N	\N	\N	2026-03-22 21:15:29.20961+00
262	116	6	\N	\N	\N	2026-03-22 21:15:29.211365+00
263	47	6	\N	\N	\N	2026-03-22 21:15:29.213296+00
264	72	6	\N	\N	mild	2026-03-22 21:15:29.215109+00
265	25	6	\N	\N	\N	2026-03-22 21:15:29.218953+00
266	74	6	\N	\N	\N	2026-03-22 21:15:29.221434+00
267	50	6	\N	\N	mild	2026-03-22 21:15:29.223684+00
268	117	6	\N	\N	mild	2026-03-22 21:15:29.225511+00
269	75	6	\N	\N	\N	2026-03-22 21:15:29.227412+00
270	118	6	\N	\N	mild	2026-03-22 21:15:29.229265+00
271	77	6	\N	\N	\N	2026-03-22 21:15:29.231514+00
272	29	6	\N	\N	strong	2026-03-22 21:15:29.235441+00
273	80	6	\N	\N	\N	2026-03-22 21:15:29.237676+00
274	31	6	\N	\N	strong	2026-03-22 21:15:29.239716+00
275	103	6	\N	\N	strong	2026-03-22 21:15:29.242314+00
276	33	6	\N	\N	mild	2026-03-22 21:15:29.248401+00
277	34	6	\N	\N	\N	2026-03-22 21:15:29.250894+00
278	119	6	\N	\N	\N	2026-03-22 21:15:29.252726+00
279	120	6	\N	\N	\N	2026-03-22 21:15:29.254443+00
280	35	6	\N	\N	strong	2026-03-22 21:15:29.256168+00
281	86	6	\N	\N	\N	2026-03-22 21:15:29.257898+00
282	109	6	\N	\N	mild	2026-03-22 21:15:29.259745+00
283	37	6	\N	\N	mild	2026-03-22 21:15:29.261824+00
284	87	6	\N	\N	\N	2026-03-22 21:15:29.263768+00
285	40	6	\N	\N	\N	2026-03-22 21:15:29.26858+00
286	121	6	\N	\N	strong	2026-03-22 21:15:29.272113+00
287	122	6	\N	\N	mild	2026-03-22 21:15:29.274829+00
288	43	6	\N	\N	\N	2026-03-22 21:15:29.278215+00
289	93	6	\N	\N	\N	2026-03-22 21:15:29.281557+00
290	123	6	\N	\N	\N	2026-03-22 21:15:29.28526+00
291	124	6	\N	\N	\N	2026-03-22 21:15:29.287698+00
292	64	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	mild	2026-03-22 21:15:29.289876+00
293	65	7	\N	\N	mild	2026-03-22 21:15:29.292819+00
294	66	7	\N	\N	\N	2026-03-22 21:15:29.295503+00
295	115	7	\N	\N	\N	2026-03-22 21:15:29.297537+00
296	98	7	\N	\N	mild	2026-03-22 21:15:29.299662+00
297	25	7	9	\N	strong	2026-03-22 21:15:29.301974+00
298	125	7	12	\N	mild	2026-03-22 21:15:29.303866+00
299	74	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	strong	2026-03-22 21:15:29.305858+00
300	126	7	\N	\N	strong	2026-03-22 21:15:29.307974+00
301	127	7	\N	\N	mild	2026-03-22 21:15:29.309614+00
302	128	7	\N	\N	strong	2026-03-22 21:15:29.311325+00
303	76	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	mild	2026-03-22 21:15:29.313774+00
304	78	7	\N	\N	mild	2026-03-22 21:15:29.316223+00
305	129	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	strong	2026-03-22 21:15:29.317859+00
306	81	7	\N	\N	\N	2026-03-22 21:15:29.319257+00
307	53	7	\N	\N	\N	2026-03-22 21:15:29.321021+00
308	130	7	10	A range of antispasmodics are useful in the respiratory system	strong	2026-03-22 21:15:29.322839+00
309	82	7	9	\N	\N	2026-03-22 21:15:29.324273+00
310	131	7	9	\N	strong	2026-03-22 21:15:29.325675+00
311	132	7	10	A range of antispasmodics are useful in the respiratory system	strong	2026-03-22 21:15:29.326946+00
312	132	7	14	Externally, Lobelia inflata can be helpful.	strong	2026-03-22 21:15:29.328248+00
313	133	7	\N	\N	\N	2026-03-22 21:15:29.329568+00
314	84	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	\N	2026-03-22 21:15:29.330695+00
315	134	7	9	\N	\N	2026-03-22 21:15:29.331895+00
316	55	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	mild	2026-03-22 21:15:29.333944+00
317	135	7	\N	\N	mild	2026-03-22 21:15:29.33557+00
318	136	7	\N	\N	\N	2026-03-22 21:15:29.337154+00
319	137	7	\N	\N	\N	2026-03-22 21:15:29.338604+00
320	120	7	\N	\N	mild	2026-03-22 21:15:29.340183+00
321	108	7	10	A range of antispasmodics are useful in the respiratory system	mild	2026-03-22 21:15:29.34157+00
322	138	7	14	Primary muscle relaxant remedies	strong	2026-03-22 21:15:29.342972+00
323	139	7	\N	\N	strong	2026-03-22 21:15:29.34463+00
324	140	7	10	A range of antispasmodics are useful in the respiratory system	strong	2026-03-22 21:15:29.348706+00
325	109	7	\N	\N	mild	2026-03-22 21:15:29.350667+00
326	141	7	\N	\N	\N	2026-03-22 21:15:29.352646+00
327	57	7	\N	\N	mild	2026-03-22 21:15:29.354528+00
328	142	7	13	The nervine antispasmodics, such as Valeriana officinalis and Scutellaria lateriflora, are also helpful.	strong	2026-03-22 21:15:29.358041+00
329	142	7	14	Primary muscle relaxant remedies	strong	2026-03-22 21:15:29.360972+00
330	143	7	\N	\N	strong	2026-03-22 21:15:29.363151+00
331	121	7	\N	\N	\N	2026-03-22 21:15:29.365012+00
332	59	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	strong	2026-03-22 21:15:29.366665+00
333	90	7	\N	\N	\N	2026-03-22 21:15:29.368414+00
334	42	7	\N	\N	\N	2026-03-22 21:15:29.37005+00
335	91	7	\N	\N	mild	2026-03-22 21:15:29.372129+00
336	144	7	\N	\N	\N	2026-03-22 21:15:29.37418+00
337	60	7	\N	\N	\N	2026-03-22 21:15:29.375759+00
338	145	7	9	\N	strong	2026-03-22 21:15:29.377305+00
339	145	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	strong	2026-03-22 21:15:29.379061+00
340	145	7	13	The nervine antispasmodics, such as Valeriana officinalis and Scutellaria lateriflora, are also helpful.	strong	2026-03-22 21:15:29.380855+00
341	145	7	14	Primary muscle relaxant remedies	strong	2026-03-22 21:15:29.382702+00
342	61	7	\N	\N	mild	2026-03-22 21:15:29.384575+00
343	146	7	\N	\N	strong	2026-03-22 21:15:29.386039+00
344	93	7	9	\N	strong	2026-03-22 21:15:29.387672+00
345	93	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	strong	2026-03-22 21:15:29.389166+00
346	93	7	12	\N	strong	2026-03-22 21:15:29.391002+00
347	93	7	13	Here, Viburnum opulus and Viburnum prunifolium come into their own	strong	2026-03-22 21:15:29.394457+00
348	93	7	14	Primary muscle relaxant remedies	strong	2026-03-22 21:15:29.396112+00
349	94	7	11	All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.	strong	2026-03-22 21:15:29.397864+00
350	94	7	12	\N	strong	2026-03-22 21:15:29.399254+00
351	94	7	13	Here, Viburnum opulus and Viburnum prunifolium come into their own	strong	2026-03-22 21:15:29.401108+00
352	94	7	14	Primary muscle relaxant remedies	strong	2026-03-22 21:15:29.403779+00
353	124	7	\N	\N	\N	2026-03-22 21:15:29.405706+00
354	147	8	11	\N	strong	2026-03-22 21:15:29.407388+00
355	44	8	9	Astringents are rarely needed internally for this system, although they are used externally for bruises that can be seen under the skin. However, certain cardiovascular remedies are also astringents, including this	\N	2026-03-22 21:15:29.409072+00
356	44	8	10	The anticatarrhal remedies often also have astringent properties.	\N	2026-03-22 21:15:29.411793+00
357	44	8	12	\N	\N	2026-03-22 21:15:29.413511+00
358	44	8	16	Of the many external astringents, or styptics, an example is this	\N	2026-03-22 21:15:29.415664+00
425	162	10	9	The primary cardiotonic herbs to consider, possibly this.	\N	2026-03-22 21:15:29.510833+00
359	62	8	9	Astringents are rarely needed internally for this system, although they are used externally for bruises that can be seen under the skin. However, certain cardiovascular remedies are also astringents, including this	\N	2026-03-22 21:15:29.417141+00
360	148	8	11	\N	strong	2026-03-22 21:15:29.418826+00
361	46	8	\N	\N	mild	2026-03-22 21:15:29.420405+00
362	149	8	\N	\N	\N	2026-03-22 21:15:29.421848+00
363	71	8	10	The anticatarrhal remedies often also have astringent properties.	\N	2026-03-22 21:15:29.427068+00
364	71	8	11	\N	\N	2026-03-22 21:15:29.429277+00
365	71	8	16	Of the many external astringents, or styptics, an example is this	\N	2026-03-22 21:15:29.430709+00
366	150	8	\N	\N	strong	2026-03-22 21:15:29.432417+00
367	151	8	12	\N	\N	2026-03-22 21:15:29.434196+00
368	151	8	16	Of the many external astringents, or styptics, an example is this	\N	2026-03-22 21:15:29.435895+00
369	51	8	10	The anticatarrhal remedies often also have astringent properties.	\N	2026-03-22 21:15:29.43726+00
370	75	8	11	\N	\N	2026-03-22 21:15:29.438577+00
371	52	8	11	\N	\N	2026-03-22 21:15:29.439854+00
372	52	8	13	\N	\N	2026-03-22 21:15:29.441496+00
373	79	8	11	\N	strong	2026-03-22 21:15:29.442937+00
374	79	8	16	Of the many external astringents, or styptics, an example is this	strong	2026-03-22 21:15:29.44424+00
375	54	8	\N	\N	\N	2026-03-22 21:15:29.445677+00
376	133	8	\N	\N	mild	2026-03-22 21:15:29.447031+00
378	85	8	10	The anticatarrhal remedies often also have astringent properties.	mild	2026-03-22 21:15:29.449539+00
379	85	8	16	Of the many external astringents, or styptics, an example is this	mild	2026-03-22 21:15:29.450744+00
380	152	8	11	\N	strong	2026-03-22 21:15:29.451954+00
381	140	8	\N	\N	\N	2026-03-22 21:15:29.453132+00
382	153	8	11	\N	strong	2026-03-22 21:15:29.454341+00
383	153	8	16	Of the many external astringents, or styptics, an example is this	strong	2026-03-22 21:15:29.455595+00
384	154	8	\N	\N	\N	2026-03-22 21:15:29.456904+00
385	109	8	\N	\N	mild	2026-03-22 21:15:29.458151+00
386	155	8	\N	\N	\N	2026-03-22 21:15:29.459441+00
387	156	8	\N	\N	strong	2026-03-22 21:15:29.460679+00
388	56	8	11	\N	mild	2026-03-22 21:15:29.462034+00
389	58	8	\N	\N	mild	2026-03-22 21:15:29.463579+00
390	89	8	11	\N	mild	2026-03-22 21:15:29.46482+00
391	61	8	\N	\N	mild	2026-03-22 21:15:29.466167+00
392	157	8	13	\N	strong	2026-03-22 21:15:29.467506+00
393	44	9	13	Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy. To a lesser degree, this, because of its mildness	mild	2026-03-22 21:15:29.468829+00
394	96	9	13	Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy	mild	2026-03-22 21:15:29.470053+00
395	97	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.471231+00
396	97	9	13	Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy	strong	2026-03-22 21:15:29.472415+00
397	97	9	15	By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium	strong	2026-03-22 21:15:29.473521+00
398	115	9	11	takes into account the liver and pancreas as organs of the digestive system	mild	2026-03-22 21:15:29.474773+00
399	115	9	13	Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy	mild	2026-03-22 21:15:29.476072+00
400	115	9	15	By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium	mild	2026-03-22 21:15:29.477372+00
401	158	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.478603+00
402	159	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.479879+00
403	50	9	\N	\N	strong	2026-03-22 21:15:29.481093+00
404	102	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.482419+00
405	102	9	15	By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium	strong	2026-03-22 21:15:29.483818+00
406	30	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.485351+00
407	160	9	10	Certain bitters have expectorant actions, and in the case of Marrubium vulgare, we have an excellent remedy for all chest problems combined with the value of a potent bitter	strong	2026-03-22 21:15:29.486919+00
409	34	9	14	Anything that helps with digestion and assimilation of food will benefit the musculoskeletal system. A bitter that is particularly valuable for this system is Menyanthes trifoliata	\N	2026-03-22 21:15:29.489522+00
410	110	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.490692+00
411	110	9	13	Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy	strong	2026-03-22 21:15:29.492108+00
412	161	9	\N	\N	strong	2026-03-22 21:15:29.493362+00
414	44	10	9	Remedies that specifically benefit blood vessels	\N	2026-03-22 21:15:29.496021+00
415	44	10	11	\N	\N	2026-03-22 21:15:29.497389+00
416	44	10	12	Most of the herbs that have a direct impact on the heart’s action also increase the amount of blood that passes through the kidneys, and so act as diuretics. Achillea millefolium is used in urinary problems, as is Cytisus scoparius. Any cardioactive properties must be taken into account, especially with Cytisus scoparius.	\N	2026-03-22 21:15:29.498664+00
417	44	10	13	The cardiac tonics are not directly involved in the function of this system. Achillea millefolium may play a role as a gentle emmenagogue.	\N	2026-03-22 21:15:29.499993+00
418	44	10	16	when a skin problem is related to varicosity in veins, cardiac tonics are very important	\N	2026-03-22 21:15:29.50151+00
419	62	10	9	Remedies that specifically benefit blood vessels	\N	2026-03-22 21:15:29.502963+00
420	62	10	16	when a skin problem is related to varicosity in veins, cardiac tonics are very important	\N	2026-03-22 21:15:29.504324+00
421	21	10	9	Remedies that specifically benefit blood vessels	\N	2026-03-22 21:15:29.505629+00
422	21	10	10	Any problem with the activity of the heart might have an effect on lung congestion due to a backup of blood waiting to be pumped. Thus, cardiac tonics may benefit the lungs by helping the heart. This is renowned for its antimicrobial and generally beneficial action on the lungs.	\N	2026-03-22 21:15:29.506971+00
423	21	10	11	\N	\N	2026-03-22 21:15:29.50825+00
424	47	10	14	Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness	\N	2026-03-22 21:15:29.509585+00
570	125	14	12	\N	strong	2026-03-22 21:15:29.820719+00
426	163	10	9	Primarily cardioactive remedies include Convallaria majalis and Digitalis lanata. Must be used with caution in order to avoid toxicity problems in heart patients.	\N	2026-03-22 21:15:29.512078+00
427	73	10	9	The primary cardiotonic herbs to consider	\N	2026-03-22 21:15:29.513366+00
429	73	10	16	when a skin problem is related to varicosity in veins, cardiac tonics are very important	\N	2026-03-22 21:15:29.518104+00
430	164	10	9	Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.	\N	2026-03-22 21:15:29.519549+00
431	164	10	12	Most of the herbs that have a direct impact on the heart’s action also increase the amount of blood that passes through the kidneys, and so act as diuretics. Achillea millefolium is used in urinary problems, as is Cytisus scoparius. Any cardioactive properties must be taken into account, especially with Cytisus scoparius.	\N	2026-03-22 21:15:29.521201+00
432	165	10	9	Remedies that specifically benefit blood vessels	\N	2026-03-22 21:15:29.522859+00
433	131	10	11	\N	\N	2026-03-22 21:15:29.524138+00
434	131	10	15	Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole	\N	2026-03-22 21:15:29.525613+00
435	133	10	9	Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.	\N	2026-03-22 21:15:29.527153+00
436	134	10	11	\N	\N	2026-03-22 21:15:29.528604+00
437	134	10	15	Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole	\N	2026-03-22 21:15:29.529969+00
438	109	10	11	\N	\N	2026-03-22 21:15:29.531134+00
439	109	10	15	Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole	\N	2026-03-22 21:15:29.532418+00
440	39	10	9	Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.	\N	2026-03-22 21:15:29.533992+00
441	39	10	16	The only directly applicable remedy here	\N	2026-03-22 21:15:29.535597+00
442	90	10	9	The primary cardiotonic herbs to consider	\N	2026-03-22 21:15:29.605311+00
444	90	10	11	\N	\N	2026-03-22 21:15:29.609257+00
445	90	10	15	Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole	\N	2026-03-22 21:15:29.611231+00
446	90	10	16	when a skin problem is related to varicosity in veins, cardiac tonics are very important	\N	2026-03-22 21:15:29.612793+00
447	166	10	9	Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.	\N	2026-03-22 21:15:29.614238+00
448	123	10	14	Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness	\N	2026-03-22 21:15:29.615763+00
449	124	10	14	Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness	\N	2026-03-22 21:15:29.618071+00
450	21	11	9	Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects	\N	2026-03-22 21:15:29.621595+00
451	21	11	10	Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions	\N	2026-03-22 21:15:29.626015+00
452	21	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.627914+00
453	64	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.629565+00
454	65	11	10	Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions	\N	2026-03-22 21:15:29.631889+00
455	65	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.634011+00
456	65	11	14	a carminative that is also a specific anti-inflammatory for this system	\N	2026-03-22 21:15:29.636329+00
457	66	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.638189+00
458	66	11	14	a carminative that is also a specific anti-inflammatory for this system	\N	2026-03-22 21:15:29.640253+00
459	97	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.642313+00
460	98	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.644194+00
461	167	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.646449+00
462	127	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.648388+00
464	76	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.652017+00
465	77	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.653979+00
466	77	11	14	a carminative that is also a specific anti-inflammatory for this system	\N	2026-03-22 21:15:29.655526+00
467	129	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.657154+00
468	129	11	15	Many volatile oil–containing remedies will soothe the nervous system	\N	2026-03-22 21:15:29.659518+00
469	103	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.662077+00
571	151	14	12	\N	\N	2026-03-22 21:15:29.82212+00
572	184	14	12	\N	strong	2026-03-22 21:15:29.823527+00
470	103	11	12	Because of their volatile oil content, some carminatives act as diuretics and may even irritate the kidneys	\N	2026-03-22 21:15:29.664054+00
900	84	28	11	\N	\N	2026-04-06 22:03:41.338726+00
471	131	11	9	Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects	\N	2026-03-22 21:15:29.667802+00
472	131	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.672672+00
473	84	11	9	Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects	\N	2026-03-22 21:15:29.674035+00
474	84	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.675484+00
475	84	11	15	Many volatile oil–containing remedies will soothe the nervous system	\N	2026-03-22 21:15:29.68008+00
476	134	11	9	Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects	\N	2026-03-22 21:15:29.681589+00
477	134	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.682981+00
478	134	11	15	Many volatile oil–containing remedies will soothe the nervous system	\N	2026-03-22 21:15:29.684305+00
479	55	11	10	Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions	\N	2026-03-22 21:15:29.685758+00
480	55	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.687041+00
481	135	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.688568+00
482	120	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.689895+00
483	108	11	10	Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions	\N	2026-03-22 21:15:29.691064+00
484	108	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.692177+00
485	56	11	10	Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions	\N	2026-03-22 21:15:29.693364+00
486	56	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.694827+00
488	145	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.69758+00
489	145	11	15	Many volatile oil–containing remedies will soothe the nervous system	\N	2026-03-22 21:15:29.698936+00
490	124	11	9	Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects	\N	2026-03-22 21:15:29.700231+00
491	124	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.701869+00
492	23	12	10	Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this	strong	2026-03-22 21:15:29.70329+00
493	158	12	11	\N	strong	2026-03-22 21:15:29.704665+00
494	158	12	13	Cholagogue remedies such as Hydrastis canadensis and Berberis vulgaris have a marked action on the muscles of the uterus, as they are strong bitters	strong	2026-03-22 21:15:29.705989+00
495	170	12	11	\N	strong	2026-03-22 21:15:29.707282+00
496	171	12	\N	\N	mild	2026-03-22 21:15:29.708967+00
497	24	12	11	the bark	mild	2026-03-22 21:15:29.710327+00
498	172	12	11	\N	mild	2026-03-22 21:15:29.711626+00
499	74	12	11	\N	mild	2026-03-22 21:15:29.712825+00
500	173	12	11	\N	mild	2026-03-22 21:15:29.713979+00
501	50	12	10	Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this	mild	2026-03-22 21:15:29.71524+00
502	50	12	12	can be an effective diuretic in feverish conditions	mild	2026-03-22 21:15:29.71655+00
503	27	12	16	Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.	mild	2026-03-22 21:15:29.717783+00
504	102	12	11	\N	strong	2026-03-22 21:15:29.719032+00
505	30	12	10	Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this	strong	2026-03-22 21:15:29.720201+00
506	30	12	13	Cholagogue remedies such as Hydrastis canadensis and Berberis vulgaris have a marked action on the muscles of the uterus, as they are strong bitters	strong	2026-03-22 21:15:29.721549+00
507	30	12	16	may also be of use externally	strong	2026-03-22 21:15:29.722972+00
514	31	12	11	\N	strong	2026-03-22 21:15:29.732152+00
515	31	12	16	Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.	strong	2026-03-22 21:15:29.733676+00
516	174	12	11	\N	strong	2026-03-22 21:15:29.735177+00
517	175	12	11	\N	mild	2026-03-22 21:15:29.736462+00
518	33	12	16	Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.	strong	2026-03-22 21:15:29.737913+00
519	134	12	11	\N	\N	2026-03-22 21:15:29.739894+00
520	176	12	11	\N	mild	2026-03-22 21:15:29.741402+00
521	109	12	10	Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this	mild	2026-03-22 21:15:29.742845+00
522	109	12	13	has a tonic and emmenagogue action, while most bitters stimulate the womb or menstrual activity	mild	2026-03-22 21:15:29.744433+00
580	28	14	16	All of the diuretics can potentially help the skin through inner cleansing actions. Especially important are these	strong	2026-03-22 21:15:29.833416+00
523	109	12	15	Because they help with assimilation, cholagogues have an enlivening “side effect” in the nervous system. These remedies may actively ease debility and depression. Rosmarinus officinalis is a	mild	2026-03-22 21:15:29.745831+00
524	37	12	16	Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.	mild	2026-03-22 21:15:29.747349+00
525	56	12	10	Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this	mild	2026-03-22 21:15:29.748686+00
526	177	12	11	\N	mild	2026-03-22 21:15:29.749931+00
527	177	12	12	Cholagogues confer only indirect benefits to this system. However, Taraxacum officinale root is partially diuretic in action, although weaker than the leaves	mild	2026-03-22 21:15:29.751165+00
528	177	12	16	Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.	mild	2026-03-22 21:15:29.752329+00
529	45	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.753414+00
530	45	13	16	The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum	\N	2026-03-22 21:15:29.754616+00
531	178	13	15	Demulcents are of direct value in this system only when applied to the skin, as in shingles. However, skin tonics may be thought of as “surrogate” demulcents, especially Avena sativa.	\N	2026-03-22 21:15:29.756145+00
532	48	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.75751+00
533	49	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.758802+00
534	179	13	12	Excellent kidney and bladder demulcents	\N	2026-03-22 21:15:29.760109+00
535	78	13	10	soothe inflammation in the chest, throat and sinuses	\N	2026-03-22 21:15:29.761521+00
536	78	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.762904+00
537	180	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.764571+00
538	180	13	16	The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum	\N	2026-03-22 21:15:29.76583+00
539	83	13	\N	\N	\N	2026-03-22 21:15:29.767281+00
540	89	13	10	soothe inflammation in the chest, throat and sinuses	\N	2026-03-22 21:15:29.768639+00
541	89	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.769901+00
542	89	13	14	Vulneraries and anti-inflammatories have a more direct value in this system than demulcents as such. The undeniable value of Symphytum officinale here is related to its vulnerary properties	\N	2026-03-22 21:15:29.77108+00
543	89	13	16	The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum	\N	2026-03-22 21:15:29.772341+00
544	60	13	10	soothe inflammation in the chest, throat and sinuses	\N	2026-03-22 21:15:29.773728+00
545	92	13	11	These remedies can be applied freely whenever a soothing demulcent is indicated	\N	2026-03-22 21:15:29.774913+00
546	92	13	16	The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum	\N	2026-03-22 21:15:29.776263+00
547	61	13	10	soothe inflammation in the chest, throat and sinuses	\N	2026-03-22 21:15:29.777743+00
548	95	13	\N	\N	\N	2026-03-22 21:15:29.781489+00
549	44	14	9	As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.	strong	2026-03-22 21:15:29.783231+00
550	44	14	10	If chest congestion is related to heart problems, most of the diuretics will be of value.	strong	2026-03-22 21:15:29.784589+00
551	44	14	12	\N	strong	2026-03-22 21:15:29.786031+00
552	44	14	14	Because of their cleansing actions, many diuretics help with problems of muscles and bones	strong	2026-03-22 21:15:29.787485+00
553	181	14	12	\N	strong	2026-03-22 21:15:29.788888+00
554	148	14	11	Some laxative herbs also act as diuretics	\N	2026-03-22 21:15:29.790537+00
555	148	14	12	\N	\N	2026-03-22 21:15:29.792019+00
556	66	14	11	Some laxative herbs also act as diuretics	strong	2026-03-22 21:15:29.793408+00
557	66	14	12	\N	strong	2026-03-22 21:15:29.794645+00
558	66	14	14	Because of their cleansing actions, many diuretics help with problems of muscles and bones	strong	2026-03-22 21:15:29.800232+00
559	22	14	12	\N	mild	2026-03-22 21:15:29.802846+00
560	46	14	12	\N	strong	2026-03-22 21:15:29.804651+00
561	46	14	13	Antiseptic diuretics often have similar effects in the reproductive system.	strong	2026-03-22 21:15:29.80637+00
562	150	14	12	\N	\N	2026-03-22 21:15:29.807791+00
563	182	14	12	\N	\N	2026-03-22 21:15:29.809241+00
564	163	14	9	As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.	\N	2026-03-22 21:15:29.810884+00
565	163	14	12	\N	\N	2026-03-22 21:15:29.812739+00
566	73	14	12	\N	mild	2026-03-22 21:15:29.815042+00
567	183	14	12	\N	\N	2026-03-22 21:15:29.816578+00
568	164	14	9	As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.	strong	2026-03-22 21:15:29.817901+00
569	164	14	12	\N	strong	2026-03-22 21:15:29.819263+00
573	50	14	10	If chest congestion is related to heart problems, most of the diuretics will be of value.	strong	2026-03-22 21:15:29.824756+00
574	50	14	12	\N	strong	2026-03-22 21:15:29.826081+00
575	50	14	14	Because of their cleansing actions, many diuretics help with problems of muscles and bones	strong	2026-03-22 21:15:29.82742+00
576	117	14	12	\N	strong	2026-03-22 21:15:29.828625+00
577	117	14	14	Because of their cleansing actions, many diuretics help with problems of muscles and bones	strong	2026-03-22 21:15:29.829869+00
578	28	14	10	If chest congestion is related to heart problems, most of the diuretics will be of value.	strong	2026-03-22 21:15:29.830997+00
579	28	14	12	\N	strong	2026-03-22 21:15:29.832126+00
581	31	14	11	Some laxative herbs also act as diuretics	mild	2026-03-22 21:15:29.83509+00
582	31	14	12	\N	mild	2026-03-22 21:15:29.836506+00
583	103	14	12	\N	strong	2026-03-22 21:15:29.837776+00
584	185	14	12	\N	\N	2026-03-22 21:15:29.839227+00
585	120	14	11	Some laxative herbs also act as diuretics	strong	2026-03-22 21:15:29.840713+00
586	120	14	12	\N	strong	2026-03-22 21:15:29.842068+00
587	176	14	11	Some laxative herbs also act as diuretics	mild	2026-03-22 21:15:29.843233+00
588	176	14	12	\N	mild	2026-03-22 21:15:29.844662+00
589	57	14	10	If chest congestion is related to heart problems, most of the diuretics will be of value.	\N	2026-03-22 21:15:29.846264+00
590	57	14	12	\N	\N	2026-03-22 21:15:29.848136+00
591	186	14	12	\N	mild	2026-03-22 21:15:29.849884+00
592	186	14	13	a mild diuretic.	mild	2026-03-22 21:15:29.85183+00
593	122	14	9	As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.	strong	2026-03-22 21:15:29.853687+00
594	122	14	11	Some laxative herbs also act as diuretics	strong	2026-03-22 21:15:29.855162+00
595	122	14	12	\N	strong	2026-03-22 21:15:29.856699+00
596	122	14	16	All of the diuretics can potentially help the skin through inner cleansing actions. Especially important are these	strong	2026-03-22 21:15:29.858345+00
597	90	14	12	\N	mild	2026-03-22 21:15:29.859696+00
598	95	14	12	\N	\N	2026-03-22 21:15:29.861134+00
599	44	15	\N	\N	mild	2026-03-22 21:15:29.862831+00
600	96	15	\N	\N	strong	2026-03-22 21:15:29.864286+00
601	97	15	\N	\N	strong	2026-03-22 21:15:29.865679+00
602	115	15	\N	\N	strong	2026-03-22 21:15:29.867053+00
603	70	15	\N	\N	mild	2026-03-22 21:15:29.868419+00
604	72	15	\N	\N	\N	2026-03-22 21:15:29.869678+00
605	25	15	\N	\N	\N	2026-03-22 21:15:29.870858+00
606	102	15	\N	\N	strong	2026-03-22 21:15:29.872121+00
607	30	15	\N	\N	strong	2026-03-22 21:15:29.873327+00
608	53	15	\N	\N	mild	2026-03-22 21:15:29.874524+00
609	82	15	\N	\N	mild	2026-03-22 21:15:29.875613+00
610	131	15	\N	\N	mild	2026-03-22 21:15:29.876708+00
611	160	15	\N	\N	strong	2026-03-22 21:15:29.87779+00
612	187	15	\N	\N	strong	2026-03-22 21:15:29.878844+00
613	84	15	\N	\N	mild	2026-03-22 21:15:29.879997+00
614	55	15	\N	\N	mild	2026-03-22 21:15:29.881386+00
615	135	15	\N	\N	\N	2026-03-22 21:15:29.882609+00
616	188	15	\N	\N	\N	2026-03-22 21:15:29.883993+00
617	120	15	\N	\N	mild	2026-03-22 21:15:29.885117+00
618	35	15	\N	\N	\N	2026-03-22 21:15:29.886224+00
619	36	15	\N	\N	mild	2026-03-22 21:15:29.887276+00
620	109	15	\N	\N	mild	2026-03-22 21:15:29.888388+00
621	155	15	\N	\N	\N	2026-03-22 21:15:29.889456+00
622	110	15	\N	\N	strong	2026-03-22 21:15:29.890571+00
623	56	15	\N	\N	mild	2026-03-22 21:15:29.89176+00
624	121	15	\N	\N	strong	2026-03-22 21:15:29.892881+00
625	161	15	\N	\N	strong	2026-03-22 21:15:29.893971+00
626	59	15	\N	\N	mild	2026-03-22 21:15:29.895034+00
627	90	15	\N	\N	mild	2026-03-22 21:15:29.896093+00
628	91	15	\N	\N	mild	2026-03-22 21:15:29.897127+00
629	189	15	\N	\N	strong	2026-03-22 21:15:29.898142+00
630	145	15	\N	\N	mild	2026-03-22 21:15:29.89925+00
631	146	15	\N	\N	mild	2026-03-22 21:15:29.900603+00
632	93	15	\N	\N	mild	2026-03-22 21:15:29.901834+00
633	94	15	\N	\N	mild	2026-03-22 21:15:29.903085+00
634	190	15	\N	\N	\N	2026-03-22 21:15:29.904241+00
635	124	15	\N	\N	strong	2026-03-22 21:15:29.905466+00
636	191	16	10	\N	\N	2026-03-22 21:15:29.906503+00
637	192	16	10	\N	\N	2026-03-22 21:15:29.907738+00
638	192	16	11	All of the stimulating expectorants may act as emetics if taken in too high a dose (for example, Cephaelis ipecacuanha)	\N	2026-03-22 21:15:29.908844+00
639	193	16	10	\N	\N	2026-03-22 21:15:29.909957+00
640	54	16	10	\N	\N	2026-03-22 21:15:29.911074+00
641	54	16	16	By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this	\N	2026-03-22 21:15:29.912209+00
642	160	16	10	\N	\N	2026-03-22 21:15:29.913456+00
643	194	16	10	\N	\N	2026-03-22 21:15:29.914726+00
644	195	16	10	\N	\N	2026-03-22 21:15:29.91577+00
645	196	16	10	\N	\N	2026-03-22 21:15:29.916986+00
646	196	16	16	By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this	\N	2026-03-22 21:15:29.918333+00
647	197	16	10	\N	\N	2026-03-22 21:15:29.919626+00
648	197	16	15	can have relaxing nervine action.	\N	2026-03-22 21:15:29.920775+00
649	38	16	10	\N	\N	2026-03-22 21:15:29.923083+00
650	166	16	10	\N	\N	2026-03-22 21:15:29.92464+00
651	198	16	10	\N	\N	2026-03-22 21:15:29.925912+00
652	45	17	10	\N	\N	2026-03-22 21:15:29.927551+00
653	67	17	10	\N	\N	2026-03-22 21:15:29.928912+00
654	48	17	10	\N	\N	2026-03-22 21:15:29.930195+00
655	49	17	10	\N	\N	2026-03-22 21:15:29.931295+00
656	126	17	10	\N	\N	2026-03-22 21:15:29.932455+00
657	78	17	10	\N	\N	2026-03-22 21:15:29.933712+00
658	199	17	10	\N	\N	2026-03-22 21:15:29.934942+00
659	30	17	10	\N	\N	2026-03-22 21:15:29.936268+00
660	30	17	13	can work as an expectorant while toning the mucous membranes of the respiratory system, may also be of value in the reproductive tract.	\N	2026-03-22 21:15:29.937458+00
661	30	17	16	By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this	\N	2026-03-22 21:15:29.938778+00
662	53	17	10	\N	\N	2026-03-22 21:15:29.940014+00
663	53	17	15	can have relaxing nervine actions	\N	2026-03-22 21:15:29.94184+00
664	132	17	10	\N	\N	2026-03-22 21:15:29.943298+00
665	132	17	14	a good muscle relaxant	\N	2026-03-22 21:15:29.9446+00
666	108	17	10	\N	\N	2026-03-22 21:15:29.945874+00
667	108	17	11	The relaxing expectorants may be either demulcents (Symphytum officinale) or carminatives (Pimpinella anisum).	\N	2026-03-22 21:15:29.947182+00
668	140	17	10	\N	\N	2026-03-22 21:15:29.94868+00
669	200	17	10	\N	\N	2026-03-22 21:15:29.949795+00
670	89	17	10	\N	\N	2026-03-22 21:15:29.95085+00
671	89	17	11	The relaxing expectorants may be either demulcents (Symphytum officinale) or carminatives (Pimpinella anisum).	\N	2026-03-22 21:15:29.951928+00
672	89	17	16	By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this	\N	2026-03-22 21:15:29.953254+00
673	143	17	10	\N	\N	2026-03-22 21:15:29.954802+00
674	201	17	10	\N	\N	2026-03-22 21:15:29.956084+00
675	59	17	10	\N	\N	2026-03-22 21:15:29.957407+00
676	59	17	15	can have relaxing nervine actions	\N	2026-03-22 21:15:29.958655+00
677	60	17	10	\N	\N	2026-03-22 21:15:29.959912+00
678	146	17	10	\N	\N	2026-03-22 21:15:29.961173+00
679	146	17	15	can have relaxing nervine actions	\N	2026-03-22 21:15:29.96275+00
680	21	18	10	\N	\N	2026-03-22 21:15:29.964255+00
681	21	18	16	By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this	\N	2026-03-22 21:15:29.965647+00
682	57	18	10	\N	\N	2026-03-22 21:15:29.966949+00
896	75	11	11	\N	\N	2026-04-06 22:03:41.338726+00
897	78	1	11	\N	\N	2026-04-06 22:03:41.338726+00
683	57	18	16	By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this	\N	2026-03-22 21:15:29.968197+00
684	61	18	10	\N	\N	2026-03-22 21:15:29.969338+00
685	44	19	\N	\N	\N	2026-03-22 21:15:29.970522+00
686	148	19	11	\N	\N	2026-03-22 21:15:29.971752+00
687	202	19	\N	\N	\N	2026-03-22 21:15:29.972986+00
688	66	19	\N	\N	\N	2026-03-22 21:15:29.97425+00
689	113	19	\N	\N	\N	2026-03-22 21:15:29.975355+00
690	97	19	\N	\N	\N	2026-03-22 21:15:29.976506+00
691	23	19	10	Certain hepatics are also antimicrobial and anticatarrhal, which will benefit the respiratory system. Also, mucous membrane tonics help here, including herbs such as this	\N	2026-03-22 21:15:29.977632+00
692	158	19	11	\N	\N	2026-03-22 21:15:29.979032+00
693	158	19	13	Hepatic plants such as Hydrastis canadensis and Berberis vulgaris have a pronounced action on the muscles of the uterus	\N	2026-03-22 21:15:29.980132+00
694	159	19	\N	\N	\N	2026-03-22 21:15:29.981341+00
695	171	19	11	\N	\N	2026-03-22 21:15:29.982539+00
697	203	19	\N	\N	\N	2026-03-22 21:15:29.984789+00
698	172	19	\N	\N	\N	2026-03-22 21:15:29.98591+00
699	74	19	11	\N	\N	2026-03-22 21:15:29.987084+00
700	173	19	11	\N	\N	2026-03-22 21:15:29.988444+00
701	76	19	\N	\N	\N	2026-03-22 21:15:29.989787+00
702	27	19	16	Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.	\N	2026-03-22 21:15:29.991019+00
703	28	19	\N	\N	\N	2026-03-22 21:15:29.992217+00
704	102	19	11	\N	\N	2026-03-22 21:15:29.993514+00
705	30	19	10	Certain hepatics are also antimicrobial and anticatarrhal, which will benefit the respiratory system. Also, mucous membrane tonics help here, including herbs such as this	\N	2026-03-22 21:15:29.994839+00
706	30	19	13	Hepatic plants such as Hydrastis canadensis and Berberis vulgaris have a pronounced action on the muscles of the uterus	\N	2026-03-22 21:15:29.996054+00
707	30	19	16	Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.	\N	2026-03-22 21:15:29.997265+00
709	53	19	\N	\N	\N	2026-03-22 21:15:29.99964+00
710	54	19	\N	\N	\N	2026-03-22 21:15:30.000842+00
711	31	19	11	\N	\N	2026-03-22 21:15:30.002649+00
712	31	19	16	Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.	\N	2026-03-22 21:15:30.004355+00
713	131	19	\N	\N	\N	2026-03-22 21:15:30.005781+00
714	175	19	11	\N	\N	2026-03-22 21:15:30.006994+00
715	33	19	16	Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.	\N	2026-03-22 21:15:30.008192+00
716	134	19	\N	\N	\N	2026-03-22 21:15:30.009694+00
717	34	19	\N	\N	\N	2026-03-22 21:15:30.010739+00
718	176	19	11	\N	\N	2026-03-22 21:15:30.011863+00
719	204	19	\N	\N	\N	2026-03-22 21:15:30.013154+00
720	205	19	\N	\N	\N	2026-03-22 21:15:30.014365+00
721	37	19	16	Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.	\N	2026-03-22 21:15:30.015635+00
723	177	19	11	\N	\N	2026-03-22 21:15:30.018239+00
724	177	19	12	Hepatics confer only an indirect benefit to this system. However, Taraxacum officinale root is partially diuretic in action, although weaker than the leaves	\N	2026-03-22 21:15:30.019678+00
725	177	19	16	Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.	\N	2026-03-22 21:15:30.020885+00
726	123	19	\N	\N	\N	2026-03-22 21:15:30.022222+00
727	115	20	12	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.023632+00
728	115	20	13	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.024861+00
729	128	20	12	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.026145+00
730	128	20	13	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.027338+00
731	129	20	11	The relaxing nervines and carminatives are important	strong	2026-03-22 21:15:30.028709+00
733	129	20	12	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.03112+00
734	129	20	13	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.032262+00
735	130	20	10	eases irritable coughs	strong	2026-03-22 21:15:30.0334+00
736	130	20	12	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.034661+00
737	130	20	13	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.036212+00
738	131	20	9	Notice that this herb are all in the “milder” category	mild	2026-03-22 21:15:30.037816+00
739	131	20	12	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.039182+00
740	131	20	13	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.040592+00
741	84	20	11	The relaxing nervines and carminatives are important	mild	2026-03-22 21:15:30.042968+00
742	84	20	12	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.045066+00
743	84	20	13	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.046872+00
744	137	20	11	will help with intestinal colic—for example	strong	2026-03-22 21:15:30.048683+00
745	137	20	12	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.050671+00
746	137	20	13	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.052866+00
747	35	20	12	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.05479+00
748	35	20	13	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.056713+00
749	139	20	11	will help with intestinal colic—for example	strong	2026-03-22 21:15:30.058546+00
750	139	20	12	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.059905+00
751	139	20	13	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.061367+00
752	139	20	14	All hypnotics help reduce muscle tension and even the pain associated with problems in this system. They may be used	strong	2026-03-22 21:15:30.062674+00
753	142	20	12	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.063845+00
754	142	20	13	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.064976+00
755	207	20	12	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.070166+00
756	207	20	13	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.072364+00
757	90	20	9	Notice that this herb are all in the “milder” category	mild	2026-03-22 21:15:30.073938+00
758	90	20	12	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.075146+00
759	90	20	13	Hypnotics are important here when used as muscle relaxants.	mild	2026-03-22 21:15:30.07631+00
760	145	20	11	The relaxing nervines and carminatives are important	strong	2026-03-22 21:15:30.077669+00
762	145	20	12	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.080474+00
763	145	20	13	Hypnotics are important here when used as muscle relaxants.	strong	2026-03-22 21:15:30.082035+00
764	145	20	14	All hypnotics help reduce muscle tension and even the pain associated with problems in this system. They may be used	strong	2026-03-22 21:15:30.083352+00
765	146	20	11	The relaxing nervines and carminatives are important	\N	2026-03-22 21:15:30.08493+00
696	24	19	11	\N	\N	2026-03-22 21:15:29.983716+00
766	146	20	12	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.086162+00
767	146	20	13	Hypnotics are important here when used as muscle relaxants.	\N	2026-03-22 21:15:30.087521+00
768	44	21	\N	\N	\N	2026-03-22 21:15:30.08892+00
769	208	21	\N	\N	mild	2026-03-22 21:15:30.090184+00
771	72	21	\N	\N	mild	2026-03-22 21:15:30.092829+00
772	25	21	\N	\N	mild	2026-03-22 21:15:30.094093+00
773	73	21	\N	\N	strong	2026-03-22 21:15:30.095205+00
774	9	21	\N	\N	\N	2026-03-22 21:15:30.096217+00
775	210	21	\N	\N	\N	2026-03-22 21:15:30.097517+00
776	131	21	\N	\N	\N	2026-03-22 21:15:30.098762+00
777	137	21	\N	\N	\N	2026-03-22 21:15:30.099968+00
778	120	21	\N	\N	\N	2026-03-22 21:15:30.101153+00
779	142	21	\N	\N	\N	2026-03-22 21:15:30.102739+00
780	90	21	\N	\N	strong	2026-03-22 21:15:30.104272+00
781	91	21	\N	\N	strong	2026-03-22 21:15:30.105603+00
782	43	21	\N	\N	mild	2026-03-22 21:15:30.106993+00
783	145	21	\N	\N	\N	2026-03-22 21:15:30.108243+00
784	146	21	\N	\N	mild	2026-03-22 21:15:30.109533+00
785	93	21	\N	\N	strong	2026-03-22 21:15:30.110739+00
786	94	21	\N	\N	\N	2026-03-22 21:15:30.112034+00
787	211	21	\N	\N	strong	2026-03-22 21:15:30.113446+00
788	142	22	\N	\N	\N	2026-03-22 21:15:30.114627+00
789	81	22	\N	\N	\N	2026-03-22 21:15:30.115665+00
790	115	23	\N	\N	\N	2026-03-22 21:15:30.116959+00
791	212	23	\N	\N	mild	2026-03-22 21:15:30.118179+00
792	69	23	\N	\N	mild	2026-03-22 21:15:30.119857+00
793	213	23	\N	\N	mild	2026-03-22 21:15:30.121129+00
794	25	23	10	Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this	\N	2026-03-22 21:15:30.122522+00
795	25	23	13	\N	\N	2026-03-22 21:15:30.123708+00
796	25	23	14	All sedative remedies will help ease muscular tension and pain in this complex system	\N	2026-03-22 21:15:30.124828+00
797	25	23	16	All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions	\N	2026-03-22 21:15:30.125939+00
798	128	23	\N	\N	strong	2026-03-22 21:15:30.127248+00
799	129	23	11	All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include stronger herbs such as this	strong	2026-03-22 21:15:30.128455+00
800	81	23	16	All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions	\N	2026-03-22 21:15:30.12952+00
801	53	23	\N	\N	mild	2026-03-22 21:15:30.130638+00
802	130	23	10	Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this	strong	2026-03-22 21:15:30.131851+00
803	130	23	13	\N	strong	2026-03-22 21:15:30.13298+00
804	82	23	11	All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this	mild	2026-03-22 21:15:30.134267+00
805	131	23	9	a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.	\N	2026-03-22 21:15:30.136175+00
806	131	23	10	Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this	\N	2026-03-22 21:15:30.137908+00
807	131	23	13	\N	\N	2026-03-22 21:15:30.139207+00
808	132	23	10	Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this	\N	2026-03-22 21:15:30.140346+00
809	84	23	11	All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this	\N	2026-03-22 21:15:30.142443+00
810	134	23	9	a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.	mild	2026-03-22 21:15:30.145965+00
811	134	23	11	All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this	mild	2026-03-22 21:15:30.148135+00
812	137	23	\N	\N	strong	2026-03-22 21:15:30.149578+00
813	138	23	\N	\N	\N	2026-03-22 21:15:30.151004+00
814	139	23	\N	\N	strong	2026-03-22 21:15:30.152235+00
815	36	23	\N	\N	\N	2026-03-22 21:15:30.153452+00
816	142	23	\N	\N	\N	2026-03-22 21:15:30.154693+00
818	90	23	9	a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.	\N	2026-03-22 21:15:30.157444+00
819	42	23	16	All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions	mild	2026-03-22 21:15:30.159097+00
820	144	23	\N	\N	\N	2026-03-22 21:15:30.160437+00
821	145	23	\N	\N	strong	2026-03-22 21:15:30.161989+00
822	146	23	\N	\N	\N	2026-03-22 21:15:30.163356+00
823	93	23	\N	\N	mild	2026-03-22 21:15:30.164643+00
824	94	23	14	All sedative remedies will help ease muscular tension and pain in this complex system	mild	2026-03-22 21:15:30.165906+00
825	44	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.167254+00
826	44	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.168808+00
827	44	24	12	Relevant stimulants with diuretic properties include this	\N	2026-03-22 21:15:30.170051+00
828	21	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.171174+00
829	21	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.172381+00
830	65	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.173526+00
831	113	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.174597+00
832	113	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.175848+00
833	113	24	14	a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.	\N	2026-03-22 21:15:30.177037+00
834	96	24	13	Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.	\N	2026-03-22 21:15:30.178228+00
835	97	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.179483+00
836	97	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.180697+00
837	97	24	13	Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.	\N	2026-03-22 21:15:30.182479+00
838	115	24	\N	\N	\N	2026-03-22 21:15:30.183776+00
839	116	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.18502+00
840	116	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.186239+00
841	116	24	14	a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.	\N	2026-03-22 21:15:30.187441+00
898	81	36	11	\N	\N	2026-04-06 22:03:41.338726+00
899	84	26	11	\N	\N	2026-04-06 22:03:41.338726+00
842	47	24	14	a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.	\N	2026-03-22 21:15:30.188666+00
843	98	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.189869+00
844	192	24	\N	\N	\N	2026-03-22 21:15:30.190985+00
845	170	24	\N	\N	\N	2026-03-22 21:15:30.192159+00
846	150	24	15	\N	\N	2026-03-22 21:15:30.193349+00
847	127	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.194469+00
848	50	24	\N	\N	\N	2026-03-22 21:15:30.195778+00
849	117	24	12	Relevant stimulants with diuretic properties include this	\N	2026-03-22 21:15:30.197116+00
850	76	24	\N	\N	\N	2026-03-22 21:15:30.19833+00
851	118	24	\N	\N	\N	2026-03-22 21:15:30.199892+00
852	102	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.201324+00
853	54	24	\N	\N	\N	2026-03-22 21:15:30.202743+00
854	103	24	12	Relevant stimulants with diuretic properties include this	\N	2026-03-22 21:15:30.204121+00
855	160	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.205461+00
856	187	24	\N	\N	\N	2026-03-22 21:15:30.206678+00
857	55	24	10	The diaphoretic chest remedies can be considered stimulant in action	\N	2026-03-22 21:15:30.207896+00
858	55	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.209142+00
859	119	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.210241+00
860	119	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.211332+00
861	215	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.212641+00
862	195	24	\N	\N	\N	2026-03-22 21:15:30.213898+00
863	204	24	\N	\N	\N	2026-03-22 21:15:30.215146+00
864	205	24	\N	\N	\N	2026-03-22 21:15:30.216373+00
865	109	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.217618+00
866	109	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.218857+00
867	109	24	13	Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.	\N	2026-03-22 21:15:30.220065+00
868	110	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.221555+00
869	110	24	11	As already discussed, bitters may be considered stimulants	\N	2026-03-22 21:15:30.222881+00
870	110	24	13	Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.	\N	2026-03-22 21:15:30.224683+00
871	38	24	\N	\N	\N	2026-03-22 21:15:30.225975+00
872	216	24	\N	\N	\N	2026-03-22 21:15:30.2274+00
873	161	24	13	Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.	\N	2026-03-22 21:15:30.228678+00
874	123	24	9	Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart	\N	2026-03-22 21:15:30.230056+00
875	124	24	14	a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.	\N	2026-03-22 21:15:30.23125+00
876	217	24	15	\N	\N	2026-03-22 21:15:30.232484+00
877	149	24	15	\N	\N	2026-03-22 21:15:30.233726+00
879	218	24	15	\N	\N	2026-03-22 21:15:30.236356+00
377	119	8	11	\N	strong	2026-03-22 21:15:29.448248+00
408	84	9	11	\N	mild	2026-03-22 21:15:29.488182+00
413	122	9	11	\N	mild	2026-03-22 21:15:29.494772+00
722	206	19	11	\N	\N	2026-03-22 21:15:30.016901+00
880	11	40	11	\N	\N	2026-04-06 22:03:41.338726+00
881	17	39	11	\N	\N	2026-04-06 22:03:41.338726+00
882	21	37	11	\N	\N	2026-04-06 22:03:41.338726+00
883	24	41	11	\N	\N	2026-04-06 22:03:41.338726+00
884	26	27	11	\N	\N	2026-04-06 22:03:41.338726+00
885	26	40	11	\N	\N	2026-04-06 22:03:41.338726+00
886	28	27	11	\N	\N	2026-04-06 22:03:41.338726+00
887	30	8	11	\N	\N	2026-04-06 22:03:41.338726+00
888	30	28	11	\N	\N	2026-04-06 22:03:41.338726+00
889	30	31	11	\N	\N	2026-04-06 22:03:41.338726+00
890	55	26	11	\N	\N	2026-04-06 22:03:41.338726+00
891	62	42	11	\N	\N	2026-04-06 22:03:41.338726+00
892	70	2	11	\N	\N	2026-04-06 22:03:41.338726+00
893	70	8	11	\N	\N	2026-04-06 22:03:41.338726+00
894	70	27	11	\N	\N	2026-04-06 22:03:41.338726+00
895	70	28	11	\N	\N	2026-04-06 22:03:41.338726+00
901	88	34	11	\N	\N	2026-04-06 22:03:41.338726+00
902	89	28	11	\N	\N	2026-04-06 22:03:41.338726+00
903	122	2	11	\N	\N	2026-04-06 22:03:41.338726+00
904	122	4	11	\N	\N	2026-04-06 22:03:41.338726+00
905	122	19	11	\N	\N	2026-04-06 22:03:41.338726+00
906	122	31	11	\N	\N	2026-04-06 22:03:41.338726+00
908	122	39	11	\N	\N	2026-04-06 22:03:41.338726+00
909	123	2	11	\N	\N	2026-04-06 22:03:41.338726+00
910	123	27	11	\N	\N	2026-04-06 22:03:41.338726+00
911	123	29	11	\N	\N	2026-04-06 22:03:41.338726+00
912	134	4	11	\N	\N	2026-04-06 22:03:41.338726+00
913	145	26	11	\N	\N	2026-04-06 22:03:41.338726+00
914	146	19	11	\N	\N	2026-04-06 22:03:41.338726+00
915	146	36	11	\N	\N	2026-04-06 22:03:41.338726+00
916	165	37	11	\N	\N	2026-04-06 22:03:41.338726+00
917	165	42	11	\N	\N	2026-04-06 22:03:41.338726+00
918	171	41	11	\N	\N	2026-04-06 22:03:41.338726+00
919	172	35	11	\N	\N	2026-04-06 22:03:41.338726+00
920	175	2	11	\N	\N	2026-04-06 22:03:41.338726+00
921	175	33	11	\N	\N	2026-04-06 22:03:41.338726+00
922	176	2	11	\N	\N	2026-04-06 22:03:41.338726+00
923	176	9	11	\N	\N	2026-04-06 22:03:41.338726+00
924	176	33	11	\N	\N	2026-04-06 22:03:41.338726+00
925	178	36	11	\N	\N	2026-04-06 22:03:41.338726+00
926	201	38	11	\N	\N	2026-04-06 22:03:41.338726+00
927	203	4	11	\N	\N	2026-04-06 22:03:41.338726+00
928	206	35	11	\N	\N	2026-04-06 22:03:41.338726+00
929	206	37	11	\N	\N	2026-04-06 22:03:41.338726+00
930	222	38	11	\N	\N	2026-04-06 22:03:41.338726+00
931	223	1	11	\N	\N	2026-04-06 22:03:41.338726+00
932	224	4	11	\N	\N	2026-04-06 22:03:41.338726+00
933	225	38	11	\N	\N	2026-04-06 22:03:41.338726+00
934	226	38	11	\N	\N	2026-04-06 22:03:41.338726+00
935	227	38	11	\N	\N	2026-04-06 22:03:41.338726+00
936	73	33	9	\N	\N	2026-04-10 20:52:32.050671+00
937	21	33	9	\N	\N	2026-04-10 20:52:32.050671+00
938	165	33	9	\N	\N	2026-04-10 20:52:32.050671+00
939	61	33	10	\N	\N	2026-04-10 20:52:32.050671+00
940	54	33	10	\N	\N	2026-04-10 20:52:32.050671+00
941	75	33	11	\N	\N	2026-04-10 20:52:32.050671+00
942	102	33	11	beneficial for the liver	\N	2026-04-10 20:52:32.050671+00
943	84	33	11	\N	\N	2026-04-10 20:52:32.050671+00
944	206	33	11	beneficial for the liver	\N	2026-04-10 20:52:32.050671+00
907	122	33	11	root is beneficial for the liver	\N	2026-04-06 22:03:41.338726+00
946	46	33	12	\N	\N	2026-04-10 20:52:32.050671+00
947	95	33	12	\N	\N	2026-04-10 20:52:32.050671+00
948	188	33	13	for women	\N	2026-04-10 20:52:32.050671+00
949	155	33	13	for women	\N	2026-04-10 20:52:32.050671+00
950	186	33	13	for men	\N	2026-04-10 20:52:32.050671+00
951	178	33	15	\N	\N	2026-04-10 20:52:32.050671+00
952	142	33	15	\N	\N	2026-04-10 20:52:32.050671+00
953	81	33	15	\N	\N	2026-04-10 20:52:32.050671+00
954	66	33	14	\N	\N	2026-04-10 20:52:32.050671+00
955	43	33	14	\N	\N	2026-04-10 20:52:32.050671+00
956	28	33	16	\N	\N	2026-04-10 20:52:32.050671+00
957	43	33	16	\N	\N	2026-04-10 20:52:32.050671+00
958	42	33	16	\N	\N	2026-04-10 20:52:32.050671+00
961	47	5	11	\N	\N	2026-04-10 20:55:21.608297+00
962	98	5	11	\N	\N	2026-04-10 20:55:21.608297+00
963	100	5	11	\N	\N	2026-04-10 20:55:21.608297+00
966	109	5	11	\N	\N	2026-04-10 20:55:21.608297+00
967	111	5	11	\N	\N	2026-04-10 20:55:21.608297+00
968	59	5	11	\N	\N	2026-04-10 20:55:21.608297+00
969	21	5	10	\N	\N	2026-04-10 20:55:21.608297+00
973	101	5	10	\N	\N	2026-04-10 20:55:21.608297+00
974	30	5	10	\N	\N	2026-04-10 20:55:21.608297+00
981	112	5	10	\N	\N	2026-04-10 20:55:21.608297+00
982	9	1	17	\N	\N	2026-04-10 21:00:46.921659+00
983	11	47	17	\N	\N	2026-04-10 21:00:46.921659+00
984	17	47	17	\N	\N	2026-04-10 21:00:46.921659+00
985	21	5	17	\N	\N	2026-04-10 21:00:46.921659+00
986	22	2	17	\N	\N	2026-04-10 21:00:46.921659+00
987	23	5	17	\N	\N	2026-04-10 21:00:46.921659+00
988	26	2	17	\N	\N	2026-04-10 21:00:46.921659+00
989	26	5	17	\N	\N	2026-04-10 21:00:46.921659+00
990	28	2	17	\N	\N	2026-04-10 21:00:46.921659+00
991	28	14	17	\N	\N	2026-04-10 21:00:46.921659+00
992	28	33	17	\N	\N	2026-04-10 21:00:46.921659+00
993	28	55	17	\N	\N	2026-04-10 21:00:46.921659+00
994	35	2	17	\N	\N	2026-04-10 21:00:46.921659+00
995	35	55	17	\N	\N	2026-04-10 21:00:46.921659+00
996	37	2	17	\N	\N	2026-04-10 21:00:46.921659+00
997	37	19	17	\N	\N	2026-04-10 21:00:46.921659+00
998	37	31	17	\N	\N	2026-04-10 21:00:46.921659+00
999	42	55	17	\N	\N	2026-04-10 21:00:46.921659+00
1000	43	2	17	\N	\N	2026-04-10 21:00:46.921659+00
1001	43	14	17	\N	\N	2026-04-10 21:00:46.921659+00
1002	44	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1003	44	14	17	\N	\N	2026-04-10 21:00:46.921659+00
1004	44	51	17	\N	\N	2026-04-10 21:00:46.921659+00
1005	46	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1006	46	14	17	\N	\N	2026-04-10 21:00:46.921659+00
1007	50	51	17	\N	\N	2026-04-10 21:00:46.921659+00
1008	57	51	17	\N	\N	2026-04-10 21:00:46.921659+00
1009	60	53	17	\N	\N	2026-04-10 21:00:46.921659+00
1010	61	33	17	\N	\N	2026-04-10 21:00:46.921659+00
1011	61	53	17	\N	\N	2026-04-10 21:00:46.921659+00
1012	70	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1013	70	28	17	\N	\N	2026-04-10 21:00:46.921659+00
1014	70	55	17	\N	\N	2026-04-10 21:00:46.921659+00
1015	73	33	17	\N	\N	2026-04-10 21:00:46.921659+00
1016	81	28	17	\N	\N	2026-04-10 21:00:46.921659+00
1017	95	13	17	\N	\N	2026-04-10 21:00:46.921659+00
1018	95	14	17	\N	\N	2026-04-10 21:00:46.921659+00
1019	99	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1020	103	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1021	112	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1022	113	51	17	\N	\N	2026-04-10 21:00:46.921659+00
1023	120	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1024	122	14	17	\N	\N	2026-04-10 21:00:46.921659+00
1025	122	19	17	\N	\N	2026-04-10 21:00:46.921659+00
1026	122	31	17	\N	\N	2026-04-10 21:00:46.921659+00
1027	136	51	17	\N	\N	2026-04-10 21:00:46.921659+00
1028	160	53	17	\N	\N	2026-04-10 21:00:46.921659+00
1029	165	33	17	\N	\N	2026-04-10 21:00:46.921659+00
1030	179	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1031	181	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1032	181	14	17	\N	\N	2026-04-10 21:00:46.921659+00
1033	186	73	17	\N	\N	2026-04-10 21:00:46.921659+00
1034	201	5	17	\N	\N	2026-04-10 21:00:46.921659+00
1035	206	19	17	\N	\N	2026-04-10 21:00:46.921659+00
1036	225	47	17	\N	\N	2026-04-10 21:00:46.921659+00
1037	226	47	17	\N	\N	2026-04-10 21:00:46.921659+00
1038	271	47	17	\N	\N	2026-04-10 21:00:46.921659+00
1039	274	47	17	\N	\N	2026-04-10 21:00:46.921659+00
1040	21	5	18	\N	\N	2026-04-23 16:14:35.59562+00
1044	53	3	18	\N	\N	2026-04-23 16:14:35.59562+00
1045	53	26	18	\N	\N	2026-04-23 16:14:35.59562+00
1046	54	90	18	\N	\N	2026-04-23 16:14:35.59562+00
1048	59	5	18	\N	\N	2026-04-23 16:14:35.59562+00
1049	60	3	18	\N	\N	2026-04-23 16:14:35.59562+00
1050	60	90	18	\N	\N	2026-04-23 16:14:35.59562+00
1052	61	90	18	\N	\N	2026-04-23 16:14:35.59562+00
1054	73	10	18	\N	\N	2026-04-23 16:14:35.59562+00
1055	90	10	18	\N	\N	2026-04-23 16:14:35.59562+00
1056	101	5	18	\N	\N	2026-04-23 16:14:35.59562+00
1057	126	7	18	\N	\N	2026-04-23 16:14:35.59562+00
1058	130	7	18	\N	\N	2026-04-23 16:14:35.59562+00
1059	130	26	18	\N	\N	2026-04-23 16:14:35.59562+00
1060	131	10	18	\N	\N	2026-04-23 16:14:35.59562+00
1061	131	26	18	\N	\N	2026-04-23 16:14:35.59562+00
1062	132	26	18	\N	\N	2026-04-23 16:14:35.59562+00
1064	140	7	18	\N	\N	2026-04-23 16:14:35.59562+00
1042	38	16	18	\N	\N	2026-04-23 16:14:35.59562+00
1066	192	16	18	\N	\N	2026-04-23 16:14:35.59562+00
1065	160	16	18	\N	\N	2026-04-23 16:14:35.59562+00
1047	54	16	18	\N	\N	2026-04-23 16:14:35.59562+00
1063	132	17	18	\N	\N	2026-04-23 16:14:35.59562+00
1051	60	17	18	\N	\N	2026-04-23 16:14:35.59562+00
1043	48	17	18	\N	\N	2026-04-23 16:14:35.59562+00
1041	26	25	18	\N	\N	2026-04-23 16:14:35.59562+00
1069	338	7	18	\N	\N	2026-04-23 16:14:35.59562+00
1070	340	7	18	\N	\N	2026-04-23 16:14:35.59562+00
1071	23	5	19	\N	\N	2026-04-23 16:14:35.59562+00
1073	30	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1074	30	9	19	\N	\N	2026-04-23 16:14:35.59562+00
1075	30	33	19	\N	\N	2026-04-23 16:14:35.59562+00
1076	50	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1077	50	9	19	\N	\N	2026-04-23 16:14:35.59562+00
1078	50	51	19	\N	\N	2026-04-23 16:14:35.59562+00
1079	51	8	19	\N	\N	2026-04-23 16:14:35.59562+00
1080	53	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1081	56	8	19	\N	\N	2026-04-23 16:14:35.59562+00
1082	57	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1083	58	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1084	59	5	19	\N	\N	2026-04-23 16:14:35.59562+00
1085	60	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1086	90	51	19	\N	\N	2026-04-23 16:14:35.59562+00
1087	99	5	19	\N	\N	2026-04-23 16:14:35.59562+00
1088	101	5	19	\N	\N	2026-04-23 16:14:35.59562+00
1089	104	5	19	\N	\N	2026-04-23 16:14:35.59562+00
1090	160	3	19	\N	\N	2026-04-23 16:14:35.59562+00
1091	160	9	19	\N	\N	2026-04-23 16:14:35.59562+00
1092	160	53	19	\N	\N	2026-04-23 16:14:35.59562+00
1093	473	5	19	\N	\N	2026-04-23 16:14:35.59562+00
1053	67	17	18	\N	\N	2026-04-23 16:14:35.59562+00
1067	199	17	18	\N	\N	2026-04-23 16:14:35.59562+00
1095	579	181	19	\N	\N	2026-04-25 23:10:59.300366+00
1096	579	181	18	\N	\N	2026-04-25 23:10:59.300366+00
1097	579	53	19	\N	\N	2026-04-25 23:10:59.300366+00
1098	579	53	18	\N	\N	2026-04-25 23:10:59.300366+00
1099	579	33	19	\N	\N	2026-04-25 23:10:59.300366+00
1100	579	33	18	\N	\N	2026-04-25 23:10:59.300366+00
1101	579	5	19	\N	\N	2026-04-25 23:10:59.300366+00
1102	579	5	18	\N	\N	2026-04-25 23:10:59.300366+00
1103	579	4	19	\N	\N	2026-04-25 23:10:59.300366+00
1104	579	4	18	\N	\N	2026-04-25 23:10:59.300366+00
1105	579	1	19	\N	\N	2026-04-25 23:10:59.300366+00
1106	579	1	18	\N	\N	2026-04-25 23:10:59.300366+00
1107	136	11	19	\N	\N	2026-04-25 23:10:59.300366+00
1108	136	11	18	\N	\N	2026-04-25 23:10:59.300366+00
1109	136	7	19	\N	\N	2026-04-25 23:10:59.300366+00
1110	136	7	18	\N	\N	2026-04-25 23:10:59.300366+00
1111	136	23	19	\N	\N	2026-04-25 23:10:59.300366+00
1112	136	23	18	\N	\N	2026-04-25 23:10:59.300366+00
1113	136	51	19	\N	\N	2026-04-25 23:10:59.300366+00
1114	136	51	18	\N	\N	2026-04-25 23:10:59.300366+00
1115	136	3	19	\N	\N	2026-04-25 23:10:59.300366+00
1116	136	3	18	\N	\N	2026-04-25 23:10:59.300366+00
1117	136	8	19	\N	\N	2026-04-25 23:10:59.300366+00
1118	136	8	18	\N	\N	2026-04-25 23:10:59.300366+00
1125	165	4	19	\N	\N	2026-04-25 23:10:59.300366+00
1126	165	4	18	\N	\N	2026-04-25 23:10:59.300366+00
1127	165	197	19	\N	\N	2026-04-25 23:10:59.300366+00
1128	165	197	18	\N	\N	2026-04-25 23:10:59.300366+00
1129	583	3	19	\N	\N	2026-04-25 23:10:59.300366+00
1130	583	3	18	\N	\N	2026-04-25 23:10:59.300366+00
1131	583	51	19	\N	\N	2026-04-25 23:10:59.300366+00
1132	583	51	18	\N	\N	2026-04-25 23:10:59.300366+00
1133	583	14	19	\N	\N	2026-04-25 23:10:59.300366+00
1134	583	14	18	\N	\N	2026-04-25 23:10:59.300366+00
1135	140	201	19	\N	\N	2026-04-25 23:10:59.300366+00
1136	140	201	18	\N	\N	2026-04-25 23:10:59.300366+00
1137	140	53	19	\N	\N	2026-04-25 23:10:59.300366+00
1138	140	53	18	\N	\N	2026-04-25 23:10:59.300366+00
1139	140	8	19	\N	\N	2026-04-25 23:10:59.300366+00
1140	140	8	18	\N	\N	2026-04-25 23:10:59.300366+00
1141	140	23	19	\N	\N	2026-04-25 23:10:59.300366+00
1142	140	23	18	\N	\N	2026-04-25 23:10:59.300366+00
1143	140	9	19	\N	\N	2026-04-25 23:10:59.300366+00
1144	140	9	18	\N	\N	2026-04-25 23:10:59.300366+00
1145	60	17	19	\N	\N	2026-04-25 23:10:59.300366+00
1147	60	201	19	\N	\N	2026-04-25 23:10:59.300366+00
1148	60	201	18	\N	\N	2026-04-25 23:10:59.300366+00
1149	60	13	19	\N	\N	2026-04-25 23:10:59.300366+00
1150	60	13	18	\N	\N	2026-04-25 23:10:59.300366+00
1153	60	14	19	\N	\N	2026-04-25 23:10:59.300366+00
1154	60	14	18	\N	\N	2026-04-25 23:10:59.300366+00
1155	586	17	19	\N	\N	2026-04-25 23:10:59.300366+00
1156	586	17	18	\N	\N	2026-04-25 23:10:59.300366+00
1157	586	7	19	\N	\N	2026-04-25 23:10:59.300366+00
1158	586	7	18	\N	\N	2026-04-25 23:10:59.300366+00
1159	586	23	19	\N	\N	2026-04-25 23:10:59.300366+00
1160	586	23	18	\N	\N	2026-04-25 23:10:59.300366+00
1161	199	16	19	\N	\N	2026-04-25 23:10:59.300366+00
1162	199	16	18	\N	\N	2026-04-25 23:10:59.300366+00
1163	199	7	19	\N	\N	2026-04-25 23:10:59.300366+00
1164	199	7	18	\N	\N	2026-04-25 23:10:59.300366+00
1165	199	4	19	\N	\N	2026-04-25 23:10:59.300366+00
1166	199	4	18	\N	\N	2026-04-25 23:10:59.300366+00
1167	199	14	19	\N	\N	2026-04-25 23:10:59.300366+00
1168	199	14	18	\N	\N	2026-04-25 23:10:59.300366+00
1169	199	21	19	\N	\N	2026-04-25 23:10:59.300366+00
1170	199	21	18	\N	\N	2026-04-25 23:10:59.300366+00
1171	67	9	19	\N	\N	2026-04-25 23:10:59.300366+00
1172	67	9	18	\N	\N	2026-04-25 23:10:59.300366+00
1173	67	51	19	\N	\N	2026-04-25 23:10:59.300366+00
1174	67	51	18	\N	\N	2026-04-25 23:10:59.300366+00
1175	67	53	19	\N	\N	2026-04-25 23:10:59.300366+00
1176	67	53	18	\N	\N	2026-04-25 23:10:59.300366+00
1177	67	222	19	\N	\N	2026-04-25 23:10:59.300366+00
1178	67	222	18	\N	\N	2026-04-25 23:10:59.300366+00
1179	160	16	19	\N	\N	2026-04-25 23:10:59.300366+00
1181	160	4	19	\N	\N	2026-04-25 23:10:59.300366+00
1182	160	4	18	\N	\N	2026-04-25 23:10:59.300366+00
1183	590	3	19	\N	\N	2026-04-25 23:10:59.300366+00
1184	590	3	18	\N	\N	2026-04-25 23:10:59.300366+00
1185	590	4	19	\N	\N	2026-04-25 23:10:59.300366+00
1186	590	4	18	\N	\N	2026-04-25 23:10:59.300366+00
1187	591	16	19	\N	\N	2026-04-25 23:10:59.300366+00
1188	591	16	18	\N	\N	2026-04-25 23:10:59.300366+00
1189	59	11	19	\N	\N	2026-04-25 23:10:59.300366+00
1190	59	11	18	\N	\N	2026-04-25 23:10:59.300366+00
1191	59	53	19	\N	\N	2026-04-25 23:10:59.300366+00
1192	59	53	18	\N	\N	2026-04-25 23:10:59.300366+00
1195	593	17	19	\N	\N	2026-04-25 23:10:59.300366+00
1196	593	17	18	\N	\N	2026-04-25 23:10:59.300366+00
1197	593	4	19	\N	\N	2026-04-25 23:10:59.300366+00
1198	593	4	18	\N	\N	2026-04-25 23:10:59.300366+00
1199	178	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1200	81	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1201	142	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1202	25	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1203	128	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1204	129	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1206	53	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1207	82	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1208	131	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1209	84	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1210	134	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1211	136	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1212	137	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1213	138	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1214	139	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1215	36	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1217	90	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1218	145	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1219	211	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1220	615	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1221	217	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1222	617	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1223	218	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1224	109	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1227	130	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1235	93	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1236	94	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1237	9	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1238	226	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1072	26	40	19	\N	\N	2026-04-23 16:14:35.59562+00
1239	14	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1240	15	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1241	17	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1242	20	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1243	115	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1247	144	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1248	74	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1250	645	26	15	\N	\N	2026-04-30 16:29:43.150631+00
1262	657	7	10	\N	\N	2026-04-30 16:29:55.415237+00
1281	134	20	9	\N	\N	2026-04-30 16:29:55.415237+00
1285	134	20	11	\N	\N	2026-04-30 16:29:55.415237+00
1290	36	20	13	\N	\N	2026-04-30 16:29:55.415237+00
1294	84	20	16	\N	\N	2026-04-30 16:29:55.415237+00
1295	197	20	16	\N	\N	2026-04-30 16:29:55.415237+00
1296	84	20	15	\N	mild	2026-04-30 16:30:08.374758+00
1297	134	20	15	\N	mild	2026-04-30 16:30:08.374758+00
1298	136	20	15	\N	mild	2026-04-30 16:30:08.374758+00
1299	90	20	15	\N	mild	2026-04-30 16:30:08.374758+00
1300	42	20	15	\N	mild	2026-04-30 16:30:08.374758+00
1301	131	20	15	\N	moderate	2026-04-30 16:30:08.374758+00
1302	36	20	15	\N	moderate	2026-04-30 16:30:08.374758+00
1303	142	20	15	\N	moderate	2026-04-30 16:30:08.374758+00
1304	146	20	15	\N	moderate	2026-04-30 16:30:08.374758+00
1305	128	20	15	\N	strong	2026-04-30 16:30:08.374758+00
1306	129	20	15	\N	strong	2026-04-30 16:30:08.374758+00
1307	130	20	15	\N	strong	2026-04-30 16:30:08.374758+00
1308	137	20	15	\N	strong	2026-04-30 16:30:08.374758+00
1309	138	20	15	\N	strong	2026-04-30 16:30:08.374758+00
1310	145	20	15	\N	strong	2026-04-30 16:30:08.374758+00
1311	9	1	15	\N	\N	2026-04-30 16:30:58.719955+00
1312	81	36	15	\N	\N	2026-04-30 16:30:58.719955+00
1314	115	36	15	\N	\N	2026-04-30 16:30:58.719955+00
1315	146	19	15	\N	\N	2026-04-30 16:30:58.719955+00
1317	206	35	15	\N	\N	2026-04-30 16:30:58.719955+00
1322	81	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1326	84	4	15	\N	\N	2026-04-30 16:30:58.719955+00
1327	84	9	15	\N	\N	2026-04-30 16:30:58.719955+00
1330	102	19	15	\N	\N	2026-04-30 16:30:58.719955+00
1331	115	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1333	115	11	15	\N	\N	2026-04-30 16:30:58.719955+00
1336	131	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1337	131	15	15	\N	\N	2026-04-30 16:30:58.719955+00
1339	134	4	15	\N	\N	2026-04-30 16:30:58.719955+00
1340	134	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1343	137	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1346	138	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1348	142	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1351	145	4	15	\N	\N	2026-04-30 16:30:58.719955+00
1352	145	7	15	\N	\N	2026-04-30 16:30:58.719955+00
1376	196	5	10	\N	\N	2026-05-17 16:15:06.755767+00
1377	101	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-05-17 16:15:06.755767+00
1378	51	3	18	\N	\N	2026-05-17 16:15:06.755767+00
1379	51	3	19	\N	\N	2026-05-17 16:15:06.755767+00
1380	51	4	18	\N	\N	2026-05-17 16:15:06.755767+00
1381	51	4	19	\N	\N	2026-05-17 16:15:06.755767+00
1382	51	8	18	\N	\N	2026-05-17 16:15:06.755767+00
1384	21	21	\N	\N	\N	2026-05-17 16:15:06.755767+00
1385	102	9	19	\N	\N	2026-05-17 16:15:06.755767+00
1386	85	17	18	\N	\N	2026-05-17 16:15:06.755767+00
1387	59	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-05-17 16:15:06.755767+00
1388	207	23	\N	\N	\N	2026-05-17 16:15:06.755767+00
1389	207	26	15	\N	\N	2026-05-17 16:15:06.755767+00
1392	163	388	9	\N	\N	2026-05-17 19:20:07.593885+00
1393	164	388	9	\N	\N	2026-05-17 19:20:07.593885+00
1394	858	388	9	\N	\N	2026-05-17 19:20:07.593885+00
1395	39	388	9	\N	\N	2026-05-17 19:20:07.593885+00
1397	123	390	9	\N	\N	2026-05-17 19:20:07.593885+00
1398	165	390	9	\N	\N	2026-05-17 19:20:07.593885+00
1399	90	21	9	\N	\N	2026-05-17 19:20:07.593885+00
1400	211	21	9	\N	\N	2026-05-17 19:20:07.593885+00
1401	21	21	9	\N	\N	2026-05-17 19:20:07.593885+00
1402	164	392	9	\N	\N	2026-05-17 19:20:07.593885+00
1408	131	26	9	\N	\N	2026-05-17 19:20:07.593885+00
1409	90	26	9	\N	\N	2026-05-17 19:20:07.593885+00
1410	145	26	9	\N	\N	2026-05-17 19:20:07.593885+00
1396	47	29	9	\N	\N	2026-05-17 19:20:07.593885+00
1319	26	25	15	\N	\N	2026-04-30 16:30:58.719955+00
1255	25	23	9	\N	\N	2026-04-30 16:29:55.415237+00
1256	211	23	9	\N	\N	2026-04-30 16:29:55.415237+00
1257	82	23	9	\N	\N	2026-04-30 16:29:55.415237+00
1260	145	23	9	\N	\N	2026-04-30 16:29:55.415237+00
1269	145	23	11	\N	\N	2026-04-30 16:29:55.415237+00
1274	36	23	13	\N	\N	2026-04-30 16:29:55.415237+00
1275	142	23	13	\N	\N	2026-04-30 16:29:55.415237+00
1276	145	23	13	\N	\N	2026-04-30 16:29:55.415237+00
1324	81	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1335	115	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1338	131	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1342	134	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1345	137	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1347	138	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1349	142	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1355	145	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1357	146	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1359	178	23	15	\N	\N	2026-04-30 16:30:58.719955+00
1316	146	22	15	\N	\N	2026-04-30 16:30:58.719955+00
1325	81	22	15	\N	\N	2026-04-30 16:30:58.719955+00
1350	142	22	15	\N	\N	2026-04-30 16:30:58.719955+00
1360	178	22	15	\N	\N	2026-04-30 16:30:58.719955+00
1405	62	42	9	\N	\N	2026-05-17 19:20:07.593885+00
1406	210	42	9	\N	\N	2026-05-17 19:20:07.593885+00
1407	165	42	9	\N	\N	2026-05-17 19:20:07.593885+00
1428	1009	509	24	\N	\N	2026-06-07 19:28:17.415064+00
1429	72	509	24	\N	\N	2026-06-07 19:28:17.415064+00
1430	25	509	24	\N	\N	2026-06-07 19:28:17.415064+00
1431	188	509	24	\N	\N	2026-06-07 19:28:17.415064+00
1432	190	510	24	\N	\N	2026-06-07 19:28:17.415064+00
1433	1014	511	24	\N	\N	2026-06-07 19:28:17.415064+00
1434	71	511	24	\N	\N	2026-06-07 19:28:17.415064+00
1435	52	511	24	\N	\N	2026-06-07 19:28:17.415064+00
1436	157	511	24	\N	\N	2026-06-07 19:28:17.415064+00
1437	72	512	24	\N	\N	2026-06-07 19:28:17.415064+00
1438	93	7	24	\N	\N	2026-06-07 19:28:17.415064+00
1439	94	7	24	\N	\N	2026-06-07 19:28:17.415064+00
1440	25	7	24	\N	\N	2026-06-07 19:28:17.415064+00
1441	131	7	24	\N	\N	2026-06-07 19:28:17.415064+00
1442	36	7	24	\N	\N	2026-06-07 19:28:17.415064+00
1443	44	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1444	62	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1448	131	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1449	122	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1450	1159	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1451	1160	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1452	93	33	9	\N	\N	2026-06-08 14:41:59.876695+00
1453	21	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1454	67	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1455	49	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1456	53	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1458	131	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1459	160	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1460	140	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1461	59	33	10	\N	\N	2026-06-08 14:41:59.876695+00
1463	199	33	10	\N	strong	2026-06-08 14:41:59.876695+00
1464	132	33	10	\N	strong	2026-06-08 14:41:59.876695+00
1465	38	33	10	\N	strong	2026-06-08 14:41:59.876695+00
1469	25	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1470	53	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1471	82	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1472	131	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1473	84	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1474	134	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1475	1159	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1476	128	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1477	137	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1478	145	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1479	115	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1480	146	33	15	\N	\N	2026-06-08 14:41:59.876695+00
1481	148	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1482	45	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1483	49	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1485	76	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1488	55	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1489	37	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1491	89	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1492	92	33	11	\N	\N	2026-06-08 14:41:59.876695+00
1493	44	33	12	\N	\N	2026-06-08 14:41:59.876695+00
1495	179	33	12	\N	\N	2026-06-08 14:41:59.876695+00
1496	28	33	12	\N	\N	2026-06-08 14:41:59.876695+00
1497	57	33	12	\N	\N	2026-06-08 14:41:59.876695+00
1498	122	33	12	\N	\N	2026-06-08 14:41:59.876695+00
1499	1212	33	12	\N	\N	2026-06-08 14:41:59.876695+00
1500	72	33	13	\N	\N	2026-06-08 14:41:59.876695+00
1501	25	33	13	\N	\N	2026-06-08 14:41:59.876695+00
1502	131	33	13	\N	\N	2026-06-08 14:41:59.876695+00
1505	93	33	13	\N	\N	2026-06-08 14:41:59.876695+00
1506	94	33	13	\N	\N	2026-06-08 14:41:59.876695+00
1507	190	33	13	\N	\N	2026-06-08 14:41:59.876695+00
1509	65	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1510	68	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1511	25	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1512	74	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1513	75	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1514	34	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1515	87	33	14	\N	\N	2026-06-08 14:41:59.876695+00
1517	29	33	14	\N	strong	2026-06-08 14:41:59.876695+00
1518	80	33	14	\N	strong	2026-06-08 14:41:59.876695+00
1519	123	33	14	\N	strong	2026-06-08 14:41:59.876695+00
1520	70	33	16	\N	\N	2026-06-08 14:41:59.876695+00
1522	81	33	16	\N	\N	2026-06-08 14:41:59.876695+00
1523	85	33	16	\N	\N	2026-06-08 14:41:59.876695+00
1524	88	33	16	\N	\N	2026-06-08 14:41:59.876695+00
1527	1240	33	16	\N	\N	2026-06-08 14:41:59.876695+00
1528	21	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1529	25	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1530	25	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1531	28	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1532	28	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1533	29	6	26	\N	\N	2026-06-08 14:51:57.361085+00
1534	34	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1535	37	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1536	38	16	26	\N	\N	2026-06-08 14:51:57.361085+00
1537	42	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1538	43	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1539	43	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1540	44	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1541	45	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1542	46	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1543	49	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1544	53	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1545	53	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1546	54	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1547	55	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1548	57	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1549	59	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1550	61	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1551	62	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1552	65	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1553	66	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1554	67	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1555	68	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1556	70	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1557	72	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1558	73	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1559	74	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1560	75	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1561	76	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1562	80	6	26	\N	\N	2026-06-08 14:51:57.361085+00
1563	81	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1564	81	22	26	\N	\N	2026-06-08 14:51:57.361085+00
1565	81	36	26	\N	\N	2026-06-08 14:51:57.361085+00
1566	82	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1567	82	36	26	\N	\N	2026-06-08 14:51:57.361085+00
1568	84	20	26	\N	\N	2026-06-08 14:51:57.361085+00
1569	84	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1570	84	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1571	85	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1572	87	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1573	88	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1574	89	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1575	92	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1576	93	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1577	94	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1578	102	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1579	115	36	26	\N	\N	2026-06-08 14:51:57.361085+00
1580	122	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1581	123	6	26	\N	\N	2026-06-08 14:51:57.361085+00
1582	128	20	26	\N	\N	2026-06-08 14:51:57.361085+00
1583	131	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1584	131	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1585	132	16	26	\N	\N	2026-06-08 14:51:57.361085+00
1586	134	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1587	137	20	26	\N	\N	2026-06-08 14:51:57.361085+00
1588	140	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1589	142	22	26	\N	\N	2026-06-08 14:51:57.361085+00
1590	145	20	26	\N	\N	2026-06-08 14:51:57.361085+00
1591	146	36	26	\N	\N	2026-06-08 14:51:57.361085+00
1592	148	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1593	160	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1594	165	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1595	178	22	26	\N	\N	2026-06-08 14:51:57.361085+00
1596	178	36	26	\N	\N	2026-06-08 14:51:57.361085+00
1597	179	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1598	186	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1599	188	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1600	190	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1601	199	16	26	\N	\N	2026-06-08 14:51:57.361085+00
1602	206	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1603	1159	23	26	\N	\N	2026-06-08 14:51:57.361085+00
1604	1159	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1605	1160	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1606	1212	33	26	\N	\N	2026-06-08 14:51:57.361085+00
1607	1240	2	26	\N	\N	2026-06-08 14:51:57.361085+00
1608	40	2	25	\N	\N	2026-06-08 15:00:58.883045+00
1609	46	8	25	\N	\N	2026-06-08 15:00:58.883045+00
1610	95	13	25	\N	\N	2026-06-08 15:00:58.883045+00
1611	151	8	25	\N	\N	2026-06-08 15:00:58.883045+00
1612	179	13	25	\N	\N	2026-06-08 15:00:58.883045+00
1613	186	73	25	\N	\N	2026-06-08 15:00:58.883045+00
1614	296	4	25	\N	\N	2026-06-08 15:00:58.883045+00
1670	179	14	12	\N	\N	2026-06-21 16:44:38.744675+00
1679	44	4	12	\N	\N	2026-06-21 16:44:38.744675+00
1680	66	4	12	\N	\N	2026-06-21 16:44:38.744675+00
1681	46	4	12	\N	\N	2026-06-21 16:44:38.744675+00
1682	117	4	12	\N	\N	2026-06-21 16:44:38.744675+00
1683	28	4	12	\N	\N	2026-06-21 16:44:38.744675+00
1685	182	41	12	\N	\N	2026-06-21 16:44:38.744675+00
1686	117	41	12	\N	\N	2026-06-21 16:44:38.744675+00
1688	181	5	12	\N	\N	2026-06-21 16:44:38.744675+00
1690	179	5	12	\N	\N	2026-06-21 16:44:38.744675+00
1692	84	7	12	\N	\N	2026-06-21 16:44:38.744675+00
1693	145	7	12	\N	\N	2026-06-21 16:44:38.744675+00
1695	74	7	12	\N	\N	2026-06-21 16:44:38.744675+00
1697	148	8	12	\N	\N	2026-06-21 16:44:38.744675+00
1698	46	8	12	\N	\N	2026-06-21 16:44:38.744675+00
1700	615	8	12	\N	\N	2026-06-21 16:44:38.744675+00
1701	164	8	12	\N	\N	2026-06-21 16:44:38.744675+00
1702	163	388	12	\N	\N	2026-06-21 16:44:38.744675+00
1703	164	388	12	\N	\N	2026-06-21 16:44:38.744675+00
1704	133	388	12	\N	\N	2026-06-21 16:44:38.744675+00
1705	46	13	12	\N	\N	2026-06-21 16:44:38.744675+00
1706	182	13	12	\N	\N	2026-06-21 16:44:38.744675+00
1708	95	13	12	\N	\N	2026-06-21 16:44:38.744675+00
1709	44	51	12	\N	\N	2026-06-21 16:44:38.744675+00
1710	50	51	12	\N	\N	2026-06-21 16:44:38.744675+00
1711	57	51	12	\N	\N	2026-06-21 16:44:38.744675+00
1712	90	51	12	\N	\N	2026-06-21 16:44:38.744675+00
1713	44	21	12	\N	\N	2026-06-21 16:44:38.744675+00
1714	73	21	12	\N	\N	2026-06-21 16:44:38.744675+00
1715	90	21	12	\N	\N	2026-06-21 16:44:38.744675+00
1723	71	8	12	\N	\N	2026-06-21 16:44:38.744675+00
1727	95	7	12	\N	\N	2026-06-21 16:44:38.744675+00
1734	157	8	12	\N	\N	2026-06-21 16:44:38.744675+00
1742	43	2	16	\N	\N	2026-06-21 16:54:56.148727+00
1746	70	34	16	\N	\N	2026-06-21 16:54:56.148727+00
1747	79	34	16	\N	\N	2026-06-21 16:54:56.148727+00
1748	81	34	16	\N	\N	2026-06-21 16:54:56.148727+00
1749	88	34	16	\N	\N	2026-06-21 16:54:56.148727+00
1752	84	4	16	\N	\N	2026-06-21 16:54:56.148727+00
1753	1428	4	16	\N	\N	2026-06-21 16:54:56.148727+00
1754	45	44	16	\N	\N	2026-06-21 16:54:56.148727+00
1755	83	44	16	\N	\N	2026-06-21 16:54:56.148727+00
1756	89	44	16	\N	\N	2026-06-21 16:54:56.148727+00
1757	92	44	16	\N	\N	2026-06-21 16:54:56.148727+00
1759	52	8	16	\N	\N	2026-06-21 16:54:56.148727+00
1761	89	28	16	\N	\N	2026-06-21 16:54:56.148727+00
1764	30	5	16	\N	\N	2026-06-21 16:54:56.148727+00
1766	1441	5	16	\N	\N	2026-06-21 16:54:56.148727+00
1767	1442	5	16	\N	\N	2026-06-21 16:54:56.148727+00
1769	22	14	16	\N	\N	2026-06-21 16:54:56.148727+00
1770	22	19	16	\N	\N	2026-06-21 16:54:56.148727+00
1771	26	5	16	\N	\N	2026-06-21 16:54:56.148727+00
1772	26	55	16	\N	\N	2026-06-21 16:54:56.148727+00
1774	28	4	16	\N	\N	2026-06-21 16:54:56.148727+00
1776	28	19	16	\N	\N	2026-06-21 16:54:56.148727+00
1777	28	55	16	\N	\N	2026-06-21 16:54:56.148727+00
1778	31	2	16	\N	\N	2026-06-21 16:54:56.148727+00
1780	31	55	16	\N	\N	2026-06-21 16:54:56.148727+00
1781	35	2	16	\N	\N	2026-06-21 16:54:56.148727+00
1782	35	55	16	\N	\N	2026-06-21 16:54:56.148727+00
1787	40	19	16	\N	\N	2026-06-21 16:54:56.148727+00
1789	42	19	16	\N	\N	2026-06-21 16:54:56.148727+00
1790	42	524	16	\N	\N	2026-06-21 16:54:56.148727+00
1792	43	14	16	\N	\N	2026-06-21 16:54:56.148727+00
1793	43	55	16	\N	\N	2026-06-21 16:54:56.148727+00
1794	44	14	16	\N	\N	2026-06-21 16:54:56.148727+00
1795	44	21	16	\N	\N	2026-06-21 16:54:56.148727+00
1796	73	14	16	\N	\N	2026-06-21 16:54:56.148727+00
1797	73	21	16	\N	\N	2026-06-21 16:54:56.148727+00
1798	90	14	16	\N	\N	2026-06-21 16:54:56.148727+00
1799	90	21	16	\N	\N	2026-06-21 16:54:56.148727+00
1800	90	524	16	\N	\N	2026-06-21 16:54:56.148727+00
1801	142	524	16	\N	\N	2026-06-21 16:54:56.148727+00
1802	145	524	16	\N	\N	2026-06-21 16:54:56.148727+00
1803	146	19	16	\N	\N	2026-06-21 16:54:56.148727+00
1804	146	524	16	\N	\N	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: herb_secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herb_secondary_actions (id, herb_id, secondary_action_id, created_at, body_system_id) FROM stdin;
12	21	35	2026-03-22 21:15:30.237944+00	21
13	23	35	2026-03-22 21:15:30.239783+00	21
14	26	35	2026-03-22 21:15:30.241087+00	21
15	30	35	2026-03-22 21:15:30.242335+00	21
16	35	35	2026-03-22 21:15:30.243679+00	21
17	43	35	2026-03-22 21:15:30.245109+00	21
18	28	36	2026-03-22 21:15:30.246545+00	21
19	29	36	2026-03-22 21:15:30.247823+00	21
20	30	36	2026-03-22 21:15:30.249152+00	21
1542	178	53	2026-04-30 16:29:43.150631+00	15
1543	81	53	2026-04-30 16:29:43.150631+00	15
1544	142	53	2026-04-30 16:29:43.150631+00	15
1545	25	67	2026-04-30 16:29:43.150631+00	15
1546	128	67	2026-04-30 16:29:43.150631+00	15
1547	129	67	2026-04-30 16:29:43.150631+00	15
1548	81	67	2026-04-30 16:29:43.150631+00	15
1549	53	67	2026-04-30 16:29:43.150631+00	15
1550	82	67	2026-04-30 16:29:43.150631+00	15
1551	131	67	2026-04-30 16:29:43.150631+00	15
1552	84	67	2026-04-30 16:29:43.150631+00	15
1553	134	67	2026-04-30 16:29:43.150631+00	15
1554	136	67	2026-04-30 16:29:43.150631+00	15
1555	137	67	2026-04-30 16:29:43.150631+00	15
1556	138	67	2026-04-30 16:29:43.150631+00	15
1557	139	67	2026-04-30 16:29:43.150631+00	15
1558	36	67	2026-04-30 16:29:43.150631+00	15
1559	142	67	2026-04-30 16:29:43.150631+00	15
1560	90	67	2026-04-30 16:29:43.150631+00	15
1561	145	67	2026-04-30 16:29:43.150631+00	15
1562	211	67	2026-04-30 16:29:43.150631+00	15
1563	615	68	2026-04-30 16:29:43.150631+00	15
1564	217	68	2026-04-30 16:29:43.150631+00	15
1565	617	68	2026-04-30 16:29:43.150631+00	15
1566	218	68	2026-04-30 16:29:43.150631+00	15
1567	109	68	2026-04-30 16:29:43.150631+00	15
1568	128	58	2026-04-30 16:29:43.150631+00	15
1569	129	58	2026-04-30 16:29:43.150631+00	15
1570	130	58	2026-04-30 16:29:43.150631+00	15
1571	137	58	2026-04-30 16:29:43.150631+00	15
1572	138	58	2026-04-30 16:29:43.150631+00	15
1573	139	58	2026-04-30 16:29:43.150631+00	15
1574	145	58	2026-04-30 16:29:43.150631+00	15
1575	138	38	2026-04-30 16:29:43.150631+00	15
1576	142	38	2026-04-30 16:29:43.150631+00	15
1577	145	38	2026-04-30 16:29:43.150631+00	15
1578	93	38	2026-04-30 16:29:43.150631+00	15
1579	94	38	2026-04-30 16:29:43.150631+00	15
1580	9	64	2026-04-30 16:29:43.150631+00	15
1581	226	64	2026-04-30 16:29:43.150631+00	15
1582	14	64	2026-04-30 16:29:43.150631+00	15
1583	15	64	2026-04-30 16:29:43.150631+00	15
1584	17	64	2026-04-30 16:29:43.150631+00	15
1585	20	64	2026-04-30 16:29:43.150631+00	15
1586	115	72	2026-04-30 16:29:43.150631+00	15
1587	178	72	2026-04-30 16:29:43.150631+00	15
1588	81	72	2026-04-30 16:29:43.150631+00	15
1589	82	72	2026-04-30 16:29:43.150631+00	15
1590	144	72	2026-04-30 16:29:43.150631+00	15
1591	74	57	2026-04-30 16:29:43.150631+00	15
1592	128	57	2026-04-30 16:29:43.150631+00	15
1593	645	57	2026-04-30 16:29:43.150631+00	15
1594	139	57	2026-04-30 16:29:43.150631+00	15
1596	145	57	2026-04-30 16:29:43.150631+00	15
1598	207	57	2026-05-17 16:15:06.755767+00	15
21	31	36	2026-03-22 21:15:30.250341+00	21
22	34	36	2026-03-22 21:15:30.251477+00	21
23	40	36	2026-03-22 21:15:30.252606+00	21
24	21	37	2026-03-22 21:15:30.253966+00	21
25	23	37	2026-03-22 21:15:30.255441+00	21
26	26	37	2026-03-22 21:15:30.256656+00	21
27	30	37	2026-03-22 21:15:30.257857+00	21
28	32	37	2026-03-22 21:15:30.259036+00	21
29	35	37	2026-03-22 21:15:30.260281+00	21
30	36	37	2026-03-22 21:15:30.261616+00	21
31	38	37	2026-03-22 21:15:30.262876+00	21
32	21	38	2026-03-22 21:15:30.264071+00	21
33	25	38	2026-03-22 21:15:30.265339+00	21
34	36	38	2026-03-22 21:15:30.266543+00	21
35	38	38	2026-03-22 21:15:30.267865+00	21
36	42	38	2026-03-22 21:15:30.268975+00	21
37	30	39	2026-03-22 21:15:30.270233+00	21
38	43	39	2026-03-22 21:15:30.271331+00	21
39	22	40	2026-03-22 21:15:30.272573+00	21
40	30	40	2026-03-22 21:15:30.273903+00	21
41	34	40	2026-03-22 21:15:30.275155+00	21
42	21	41	2026-03-22 21:15:30.276674+00	21
43	29	41	2026-03-22 21:15:30.277981+00	21
44	41	41	2026-03-22 21:15:30.279228+00	21
45	40	41	2026-03-22 21:15:30.280505+00	21
46	22	42	2026-03-22 21:15:30.281979+00	21
47	28	42	2026-03-22 21:15:30.283447+00	21
48	29	42	2026-03-22 21:15:30.284864+00	21
49	31	42	2026-03-22 21:15:30.286261+00	21
50	34	42	2026-03-22 21:15:30.287426+00	21
51	40	42	2026-03-22 21:15:30.288578+00	21
52	43	42	2026-03-22 21:15:30.289814+00	21
53	25	43	2026-03-22 21:15:30.291071+00	21
54	38	44	2026-03-22 21:15:30.292474+00	21
55	42	44	2026-03-22 21:15:30.293746+00	21
56	21	45	2026-03-22 21:15:30.29487+00	21
57	22	45	2026-03-22 21:15:30.296069+00	21
58	24	45	2026-03-22 21:15:30.297507+00	21
59	30	45	2026-03-22 21:15:30.298693+00	21
60	31	45	2026-03-22 21:15:30.299885+00	21
61	33	45	2026-03-22 21:15:30.301094+00	21
62	34	45	2026-03-22 21:15:30.302268+00	21
63	35	45	2026-03-22 21:15:30.303601+00	21
64	37	45	2026-03-22 21:15:30.304977+00	21
65	21	46	2026-03-22 21:15:30.306271+00	21
66	25	46	2026-03-22 21:15:30.307596+00	21
67	43	46	2026-03-22 21:15:30.308841+00	21
68	25	47	2026-03-22 21:15:30.309991+00	21
69	36	47	2026-03-22 21:15:30.31114+00	21
70	42	47	2026-03-22 21:15:30.312387+00	21
71	28	48	2026-03-22 21:15:30.313665+00	21
72	30	48	2026-03-22 21:15:30.314881+00	21
73	21	49	2026-03-22 21:15:30.316148+00	21
74	23	49	2026-03-22 21:15:30.317438+00	21
75	26	49	2026-03-22 21:15:30.318736+00	21
76	30	49	2026-03-22 21:15:30.32006+00	21
77	61	49	2026-03-22 21:15:30.321249+00	21
78	51	36	2026-03-22 21:15:30.322477+00	21
79	52	36	2026-03-22 21:15:30.323628+00	21
81	58	36	2026-03-22 21:15:30.326085+00	21
82	44	37	2026-03-22 21:15:30.327256+00	21
84	46	37	2026-03-22 21:15:30.329647+00	21
86	47	37	2026-03-22 21:15:30.336261+00	21
88	54	37	2026-03-22 21:15:30.338998+00	21
89	55	37	2026-03-22 21:15:30.340425+00	21
90	56	37	2026-03-22 21:15:30.341903+00	21
91	58	37	2026-03-22 21:15:30.34327+00	21
92	59	37	2026-03-22 21:15:30.344646+00	21
94	50	38	2026-03-22 21:15:30.347583+00	21
95	53	38	2026-03-22 21:15:30.349038+00	21
96	55	38	2026-03-22 21:15:30.350367+00	21
97	56	38	2026-03-22 21:15:30.351595+00	21
98	59	38	2026-03-22 21:15:30.352755+00	21
99	44	39	2026-03-22 21:15:30.353867+00	21
100	46	39	2026-03-22 21:15:30.355062+00	21
101	51	39	2026-03-22 21:15:30.356186+00	21
102	52	39	2026-03-22 21:15:30.357365+00	21
104	56	39	2026-03-22 21:15:30.359693+00	21
105	59	39	2026-03-22 21:15:30.360898+00	21
106	44	40	2026-03-22 21:15:30.362202+00	21
107	50	40	2026-03-22 21:15:30.363407+00	21
109	47	50	2026-03-22 21:15:30.365869+00	21
110	53	50	2026-03-22 21:15:30.367054+00	21
111	55	50	2026-03-22 21:15:30.368351+00	21
112	56	50	2026-03-22 21:15:30.369606+00	21
113	58	50	2026-03-22 21:15:30.370649+00	21
114	59	50	2026-03-22 21:15:30.371708+00	21
115	45	51	2026-03-22 21:15:30.372864+00	21
116	46	51	2026-03-22 21:15:30.37401+00	21
117	48	51	2026-03-22 21:15:30.375243+00	21
118	49	51	2026-03-22 21:15:30.376478+00	21
119	60	51	2026-03-22 21:15:30.377825+00	21
120	61	51	2026-03-22 21:15:30.379042+00	21
121	44	41	2026-03-22 21:15:30.38025+00	21
123	50	41	2026-03-22 21:15:30.382751+00	21
124	53	41	2026-03-22 21:15:30.384028+00	21
125	54	41	2026-03-22 21:15:30.385221+00	21
126	55	41	2026-03-22 21:15:30.386333+00	21
127	57	41	2026-03-22 21:15:30.387578+00	21
128	58	41	2026-03-22 21:15:30.389274+00	21
129	44	42	2026-03-22 21:15:30.390477+00	21
130	45	42	2026-03-22 21:15:30.392691+00	21
131	46	42	2026-03-22 21:15:30.393847+00	21
132	57	42	2026-03-22 21:15:30.395043+00	21
133	58	42	2026-03-22 21:15:30.396527+00	21
134	60	42	2026-03-22 21:15:30.397759+00	21
135	61	42	2026-03-22 21:15:30.398968+00	21
136	44	43	2026-03-22 21:15:30.400194+00	21
137	50	43	2026-03-22 21:15:30.401305+00	21
138	56	43	2026-03-22 21:15:30.402581+00	21
139	59	43	2026-03-22 21:15:30.403801+00	21
140	45	44	2026-03-22 21:15:30.405023+00	21
141	48	44	2026-03-22 21:15:30.406196+00	21
142	49	44	2026-03-22 21:15:30.407374+00	21
143	53	44	2026-03-22 21:15:30.408586+00	21
144	57	44	2026-03-22 21:15:30.410006+00	21
145	59	44	2026-03-22 21:15:30.41106+00	21
146	60	44	2026-03-22 21:15:30.412247+00	21
147	61	44	2026-03-22 21:15:30.413401+00	21
149	50	45	2026-03-22 21:15:30.41607+00	21
151	44	46	2026-03-22 21:15:30.418542+00	21
153	50	52	2026-03-22 21:15:30.420916+00	21
154	30	52	2026-03-22 21:15:30.422236+00	21
155	57	52	2026-03-22 21:15:30.42353+00	21
156	53	47	2026-03-22 21:15:30.42469+00	21
157	44	53	2026-03-22 21:15:30.425897+00	21
158	47	53	2026-03-22 21:15:30.427072+00	21
159	26	53	2026-03-22 21:15:30.428213+00	21
160	50	53	2026-03-22 21:15:30.429424+00	21
161	30	53	2026-03-22 21:15:30.43051+00	21
162	45	48	2026-03-22 21:15:30.431649+00	21
163	52	48	2026-03-22 21:15:30.433289+00	21
164	57	48	2026-03-22 21:15:30.434667+00	21
165	61	48	2026-03-22 21:15:30.435897+00	21
166	44	35	2026-03-22 21:15:30.437163+00	21
167	45	35	2026-03-22 21:15:30.4385+00	21
168	48	35	2026-03-22 21:15:30.439871+00	21
169	49	35	2026-03-22 21:15:30.441725+00	21
170	52	35	2026-03-22 21:15:30.443197+00	21
172	53	35	2026-03-22 21:15:30.445851+00	21
173	55	35	2026-03-22 21:15:30.447607+00	21
174	56	35	2026-03-22 21:15:30.449194+00	21
175	57	35	2026-03-22 21:15:30.450553+00	21
176	58	35	2026-03-22 21:15:30.453817+00	21
177	60	35	2026-03-22 21:15:30.455799+00	21
178	61	35	2026-03-22 21:15:30.459814+00	21
180	70	37	2026-03-22 21:15:30.463779+00	21
182	81	37	2026-03-22 21:15:30.467779+00	21
183	84	37	2026-03-22 21:15:30.469051+00	21
185	86	37	2026-03-22 21:15:30.472945+00	21
188	64	38	2026-03-22 21:15:30.480205+00	21
189	65	38	2026-03-22 21:15:30.483209+00	21
190	66	38	2026-03-22 21:15:30.48601+00	21
191	67	38	2026-03-22 21:15:30.488111+00	21
193	74	38	2026-03-22 21:15:30.493284+00	21
194	76	38	2026-03-22 21:15:30.495899+00	21
195	78	38	2026-03-22 21:15:30.498448+00	21
196	81	38	2026-03-22 21:15:30.501339+00	21
198	82	38	2026-03-22 21:15:30.507946+00	21
199	84	38	2026-03-22 21:15:30.510536+00	21
201	86	38	2026-03-22 21:15:30.515522+00	21
203	57	38	2026-03-22 21:15:30.519484+00	21
204	90	38	2026-03-22 21:15:30.523454+00	21
205	91	38	2026-03-22 21:15:30.526704+00	21
206	61	38	2026-03-22 21:15:30.529668+00	21
207	93	38	2026-03-22 21:15:30.532339+00	21
208	94	38	2026-03-22 21:15:30.535068+00	21
210	62	39	2026-03-22 21:15:30.53924+00	21
211	63	39	2026-03-22 21:15:30.543064+00	21
212	70	39	2026-03-22 21:15:30.546599+00	21
213	71	39	2026-03-22 21:15:30.549406+00	21
214	75	39	2026-03-22 21:15:30.551811+00	21
216	79	39	2026-03-22 21:15:30.557233+00	21
218	85	39	2026-03-22 21:15:30.561719+00	21
219	86	39	2026-03-22 21:15:30.563714+00	21
221	58	39	2026-03-22 21:15:30.569054+00	21
222	89	39	2026-03-22 21:15:30.571996+00	21
223	90	39	2026-03-22 21:15:30.574221+00	21
224	61	39	2026-03-22 21:15:30.576359+00	21
227	84	40	2026-03-22 21:15:30.582073+00	21
228	44	50	2026-03-22 21:15:30.585308+00	21
229	64	50	2026-03-22 21:15:30.588283+00	21
230	65	50	2026-03-22 21:15:30.591277+00	21
231	66	50	2026-03-22 21:15:30.594573+00	21
232	75	50	2026-03-22 21:15:30.59828+00	21
233	76	50	2026-03-22 21:15:30.600942+00	21
234	78	50	2026-03-22 21:15:30.604285+00	21
236	82	50	2026-03-22 21:15:30.607245+00	21
237	84	50	2026-03-22 21:15:30.608863+00	21
241	90	50	2026-03-22 21:15:30.613455+00	21
242	91	50	2026-03-22 21:15:30.615929+00	21
243	70	54	2026-03-22 21:15:30.617811+00	21
244	74	54	2026-03-22 21:15:30.623887+00	21
245	30	54	2026-03-22 21:15:30.625723+00	21
246	34	54	2026-03-22 21:15:30.627563+00	21
250	78	51	2026-03-22 21:15:30.633807+00	21
251	83	51	2026-03-22 21:15:30.635412+00	21
252	88	51	2026-03-22 21:15:30.636762+00	21
253	89	51	2026-03-22 21:15:30.638188+00	21
254	91	51	2026-03-22 21:15:30.639521+00	21
255	92	51	2026-03-22 21:15:30.64092+00	21
257	95	51	2026-03-22 21:15:30.643788+00	21
259	65	41	2026-03-22 21:15:30.646412+00	21
260	67	41	2026-03-22 21:15:30.64784+00	21
266	90	41	2026-03-22 21:15:30.655096+00	21
268	63	42	2026-03-22 21:15:30.657314+00	21
269	66	42	2026-03-22 21:15:30.658758+00	21
270	73	42	2026-03-22 21:15:30.660058+00	21
273	85	42	2026-03-22 21:15:30.663729+00	21
276	90	42	2026-03-22 21:15:30.667337+00	21
277	95	42	2026-03-22 21:15:30.668615+00	21
279	63	43	2026-03-22 21:15:30.671173+00	21
280	70	43	2026-03-22 21:15:30.67252+00	21
281	72	43	2026-03-22 21:15:30.674367+00	21
283	30	43	2026-03-22 21:15:30.677548+00	21
284	53	43	2026-03-22 21:15:30.679779+00	21
285	82	43	2026-03-22 21:15:30.683888+00	21
287	90	43	2026-03-22 21:15:30.687145+00	21
288	93	43	2026-03-22 21:15:30.688708+00	21
289	94	43	2026-03-22 21:15:30.690127+00	21
291	67	44	2026-03-22 21:15:30.692886+00	21
294	78	44	2026-03-22 21:15:30.696919+00	21
295	30	44	2026-03-22 21:15:30.698441+00	21
297	83	44	2026-03-22 21:15:30.700884+00	21
298	85	44	2026-03-22 21:15:30.702103+00	21
302	44	45	2026-03-22 21:15:30.706738+00	21
303	70	45	2026-03-22 21:15:30.707938+00	21
304	74	45	2026-03-22 21:15:30.709169+00	21
305	76	45	2026-03-22 21:15:30.710436+00	21
306	78	45	2026-03-22 21:15:30.711624+00	21
308	53	45	2026-03-22 21:15:30.713957+00	21
310	91	45	2026-03-22 21:15:30.716727+00	21
312	78	52	2026-03-22 21:15:30.719139+00	21
313	66	47	2026-03-22 21:15:30.720415+00	21
314	69	47	2026-03-22 21:15:30.721604+00	21
316	81	47	2026-03-22 21:15:30.723781+00	21
318	82	47	2026-03-22 21:15:30.726202+00	21
319	84	47	2026-03-22 21:15:30.72749+00	21
320	55	47	2026-03-22 21:15:30.72871+00	21
321	90	47	2026-03-22 21:15:30.729928+00	21
322	94	47	2026-03-22 21:15:30.731009+00	21
324	25	53	2026-03-22 21:15:30.73317+00	21
325	73	53	2026-03-22 21:15:30.734457+00	21
326	75	53	2026-03-22 21:15:30.735696+00	21
328	81	53	2026-03-22 21:15:30.738142+00	21
329	61	53	2026-03-22 21:15:30.739427+00	21
330	44	48	2026-03-22 21:15:30.740551+00	21
331	63	48	2026-03-22 21:15:30.741724+00	21
333	70	48	2026-03-22 21:15:30.744524+00	21
334	75	48	2026-03-22 21:15:30.745808+00	21
335	79	48	2026-03-22 21:15:30.747427+00	21
336	81	48	2026-03-22 21:15:30.748811+00	21
337	53	48	2026-03-22 21:15:30.750073+00	21
338	83	48	2026-03-22 21:15:30.75115+00	21
339	84	48	2026-03-22 21:15:30.752305+00	21
340	85	48	2026-03-22 21:15:30.753473+00	21
341	88	48	2026-03-22 21:15:30.754622+00	21
342	89	48	2026-03-22 21:15:30.75593+00	21
347	54	49	2026-03-22 21:15:30.797326+00	21
349	46	35	2026-03-22 21:15:30.804001+00	21
351	47	35	2026-03-22 21:15:30.807008+00	21
353	101	35	2026-03-22 21:15:30.809682+00	21
355	54	35	2026-03-22 21:15:30.81234+00	21
357	105	35	2026-03-22 21:15:30.816606+00	21
359	59	35	2026-03-22 21:15:30.820482+00	21
360	97	36	2026-03-22 21:15:30.821953+00	21
361	70	36	2026-03-22 21:15:30.823367+00	21
362	81	36	2026-03-22 21:15:30.824592+00	21
363	55	36	2026-03-22 21:15:30.825843+00	21
364	85	36	2026-03-22 21:15:30.827119+00	21
366	98	38	2026-03-22 21:15:30.868063+00	21
369	108	38	2026-03-22 21:15:30.871739+00	21
370	109	38	2026-03-22 21:15:30.872948+00	21
371	110	38	2026-03-22 21:15:30.874124+00	21
376	98	39	2026-03-22 21:15:30.879492+00	21
377	99	39	2026-03-22 21:15:30.880661+00	21
379	109	39	2026-03-22 21:15:30.883573+00	21
383	96	40	2026-03-22 21:15:30.887899+00	21
384	97	40	2026-03-22 21:15:30.889128+00	21
385	102	40	2026-03-22 21:15:30.890265+00	21
387	110	40	2026-03-22 21:15:30.892562+00	21
388	97	50	2026-03-22 21:15:30.893812+00	21
390	98	50	2026-03-22 21:15:30.895965+00	21
391	99	50	2026-03-22 21:15:30.897054+00	21
392	100	50	2026-03-22 21:15:30.898208+00	21
393	103	50	2026-03-22 21:15:30.899303+00	21
395	108	50	2026-03-22 21:15:30.901531+00	21
396	109	50	2026-03-22 21:15:30.902773+00	21
398	111	50	2026-03-22 21:15:30.904768+00	21
401	85	51	2026-03-22 21:15:30.907825+00	21
404	23	41	2026-03-22 21:15:30.911045+00	21
405	47	41	2026-03-22 21:15:30.912277+00	21
408	107	41	2026-03-22 21:15:30.915843+00	21
411	101	42	2026-03-22 21:15:30.920073+00	21
412	103	42	2026-03-22 21:15:30.921193+00	21
415	96	43	2026-03-22 21:15:30.924876+00	21
416	97	43	2026-03-22 21:15:30.925983+00	21
418	98	43	2026-03-22 21:15:30.928222+00	21
419	102	43	2026-03-22 21:15:30.929333+00	21
421	107	43	2026-03-22 21:15:30.93142+00	21
422	109	43	2026-03-22 21:15:30.932547+00	21
423	110	43	2026-03-22 21:15:30.933599+00	21
425	98	44	2026-03-22 21:15:30.935611+00	21
426	99	44	2026-03-22 21:15:30.936672+00	21
427	101	44	2026-03-22 21:15:30.937858+00	21
428	54	44	2026-03-22 21:15:30.93887+00	21
429	104	44	2026-03-22 21:15:30.939995+00	21
430	105	44	2026-03-22 21:15:30.941213+00	21
431	107	44	2026-03-22 21:15:30.942429+00	21
432	108	44	2026-03-22 21:15:30.943483+00	21
434	110	44	2026-03-22 21:15:30.945902+00	21
437	96	45	2026-03-22 21:15:30.949262+00	21
439	102	45	2026-03-22 21:15:30.952129+00	21
441	54	45	2026-03-22 21:15:30.954497+00	21
442	110	45	2026-03-22 21:15:30.956151+00	21
445	106	46	2026-03-22 21:15:30.961987+00	21
446	44	52	2026-03-22 21:15:30.963666+00	21
447	96	52	2026-03-22 21:15:30.964961+00	21
448	97	52	2026-03-22 21:15:30.966263+00	21
449	102	52	2026-03-22 21:15:30.968635+00	21
451	110	52	2026-03-22 21:15:30.974037+00	21
454	109	47	2026-03-22 21:15:30.980245+00	21
456	21	53	2026-03-22 21:15:30.983629+00	21
457	97	53	2026-03-22 21:15:30.985263+00	21
458	70	53	2026-03-22 21:15:30.986806+00	21
461	102	53	2026-03-22 21:15:30.992783+00	21
464	54	53	2026-03-22 21:15:30.999164+00	21
465	110	53	2026-03-22 21:15:31.001097+00	21
468	99	48	2026-03-22 21:15:31.008312+00	21
472	65	36	2026-03-22 21:15:31.016509+00	21
473	66	36	2026-03-22 21:15:31.01865+00	21
474	68	36	2026-03-22 21:15:31.021582+00	21
475	74	36	2026-03-22 21:15:31.025442+00	21
476	75	36	2026-03-22 21:15:31.028164+00	21
477	77	36	2026-03-22 21:15:31.03+00	21
479	80	36	2026-03-22 21:15:31.033043+00	21
481	86	36	2026-03-22 21:15:31.036149+00	21
482	121	36	2026-03-22 21:15:31.037646+00	21
483	22	49	2026-03-22 21:15:31.039142+00	21
484	33	49	2026-03-22 21:15:31.045656+00	21
485	118	49	2026-03-22 21:15:31.047665+00	21
486	29	49	2026-03-22 21:15:31.049422+00	21
487	80	49	2026-03-22 21:15:31.050783+00	21
488	31	49	2026-03-22 21:15:31.052126+00	21
489	34	49	2026-03-22 21:15:31.053438+00	21
490	35	49	2026-03-22 21:15:31.054909+00	21
491	37	49	2026-03-22 21:15:31.056559+00	21
492	40	49	2026-03-22 21:15:31.057926+00	21
493	43	49	2026-03-22 21:15:31.059193+00	21
497	50	42	2026-03-22 21:15:31.064107+00	21
498	117	42	2026-03-22 21:15:31.065548+00	21
500	120	42	2026-03-22 21:15:31.068072+00	21
501	122	42	2026-03-22 21:15:31.069457+00	21
502	113	55	2026-03-22 21:15:31.070525+00	21
503	116	55	2026-03-22 21:15:31.071541+00	21
504	47	55	2026-03-22 21:15:31.072627+00	21
505	119	55	2026-03-22 21:15:31.073707+00	21
506	109	55	2026-03-22 21:15:31.074936+00	21
507	123	55	2026-03-22 21:15:31.076209+00	21
508	124	55	2026-03-22 21:15:31.077451+00	21
511	114	56	2026-03-22 21:15:31.081355+00	21
512	97	56	2026-03-22 21:15:31.082804+00	21
513	115	56	2026-03-22 21:15:31.084064+00	21
514	72	56	2026-03-22 21:15:31.085288+00	21
515	25	49	2026-03-22 21:15:31.086496+00	21
516	42	49	2026-03-22 21:15:31.087716+00	21
517	25	57	2026-03-22 21:15:31.088957+00	21
518	74	57	2026-03-22 21:15:31.090087+00	21
519	128	57	2026-03-22 21:15:31.091142+00	21
520	81	57	2026-03-22 21:15:31.092199+00	21
521	130	57	2026-03-22 21:15:31.093245+00	21
522	55	57	2026-03-22 21:15:31.094471+00	21
523	137	57	2026-03-22 21:15:31.095692+00	21
524	139	57	2026-03-22 21:15:31.097209+00	21
525	145	57	2026-03-22 21:15:31.098432+00	21
527	82	35	2026-03-22 21:15:31.100674+00	21
528	84	35	2026-03-22 21:15:31.101977+00	21
530	136	35	2026-03-22 21:15:31.104641+00	21
533	90	35	2026-03-22 21:15:31.107743+00	21
534	91	35	2026-03-22 21:15:31.108839+00	21
537	124	35	2026-03-22 21:15:31.111992+00	21
541	78	36	2026-03-22 21:15:31.117275+00	21
543	53	36	2026-03-22 21:15:31.121031+00	21
544	82	36	2026-03-22 21:15:31.122839+00	21
545	84	36	2026-03-22 21:15:31.124367+00	21
546	134	36	2026-03-22 21:15:31.125749+00	21
548	57	36	2026-03-22 21:15:31.128362+00	21
549	90	36	2026-03-22 21:15:31.129803+00	21
550	60	36	2026-03-22 21:15:31.131395+00	21
551	98	37	2026-03-22 21:15:31.133022+00	21
552	126	37	2026-03-22 21:15:31.134818+00	21
553	129	37	2026-03-22 21:15:31.136333+00	21
555	82	37	2026-03-22 21:15:31.138795+00	21
558	108	37	2026-03-22 21:15:31.143244+00	21
559	138	37	2026-03-22 21:15:31.144719+00	21
560	109	37	2026-03-22 21:15:31.146222+00	21
562	129	39	2026-03-22 21:15:31.151013+00	21
563	81	39	2026-03-22 21:15:31.152584+00	21
564	133	39	2026-03-22 21:15:31.154511+00	21
565	140	39	2026-03-22 21:15:31.156577+00	21
568	93	39	2026-03-22 21:15:31.161643+00	21
569	94	39	2026-03-22 21:15:31.163205+00	21
570	115	40	2026-03-22 21:15:31.164648+00	21
571	129	40	2026-03-22 21:15:31.166063+00	21
575	115	50	2026-03-22 21:15:31.17119+00	21
577	125	50	2026-03-22 21:15:31.173692+00	21
578	127	50	2026-03-22 21:15:31.174947+00	21
580	129	50	2026-03-22 21:15:31.177666+00	21
583	131	50	2026-03-22 21:15:31.184086+00	21
585	134	50	2026-03-22 21:15:31.187367+00	21
587	135	50	2026-03-22 21:15:31.190068+00	21
588	136	50	2026-03-22 21:15:31.191372+00	21
589	120	50	2026-03-22 21:15:31.19272+00	21
591	141	50	2026-03-22 21:15:31.195366+00	21
595	145	50	2026-03-22 21:15:31.200649+00	21
596	146	50	2026-03-22 21:15:31.201865+00	21
597	124	50	2026-03-22 21:15:31.203051+00	21
598	126	51	2026-03-22 21:15:31.204309+00	21
604	25	41	2026-03-22 21:15:31.211424+00	21
607	136	41	2026-03-22 21:15:31.214823+00	21
608	109	41	2026-03-22 21:15:31.216249+00	21
610	143	41	2026-03-22 21:15:31.218827+00	21
612	146	41	2026-03-22 21:15:31.2212+00	21
613	124	41	2026-03-22 21:15:31.222665+00	21
614	65	42	2026-03-22 21:15:31.22395+00	21
615	125	42	2026-03-22 21:15:31.225306+00	21
616	133	42	2026-03-22 21:15:31.226775+00	21
617	136	42	2026-03-22 21:15:31.227995+00	21
619	138	42	2026-03-22 21:15:31.230355+00	21
622	144	42	2026-03-22 21:15:31.235621+00	21
624	115	43	2026-03-22 21:15:31.238038+00	21
627	131	43	2026-03-22 21:15:31.241701+00	21
628	135	43	2026-03-22 21:15:31.243894+00	21
629	65	44	2026-03-22 21:15:31.245745+00	21
631	125	44	2026-03-22 21:15:31.248615+00	21
632	126	44	2026-03-22 21:15:31.250314+00	21
633	76	44	2026-03-22 21:15:31.251802+00	21
635	133	44	2026-03-22 21:15:31.254793+00	21
636	136	44	2026-03-22 21:15:31.256189+00	21
637	120	44	2026-03-22 21:15:31.257579+00	21
639	143	44	2026-03-22 21:15:31.260301+00	21
641	91	44	2026-03-22 21:15:31.263576+00	21
644	146	45	2026-03-22 21:15:31.267959+00	21
645	128	58	2026-03-22 21:15:31.269333+00	21
646	129	58	2026-03-22 21:15:31.270576+00	21
647	130	58	2026-03-22 21:15:31.271741+00	21
648	84	58	2026-03-22 21:15:31.272863+00	21
649	137	58	2026-03-22 21:15:31.273978+00	21
650	138	58	2026-03-22 21:15:31.275143+00	21
651	139	58	2026-03-22 21:15:31.276411+00	21
652	90	58	2026-03-22 21:15:31.277628+00	21
653	145	58	2026-03-22 21:15:31.279005+00	21
654	131	46	2026-03-22 21:15:31.280344+00	21
655	137	46	2026-03-22 21:15:31.281974+00	21
656	142	46	2026-03-22 21:15:31.283531+00	21
657	90	46	2026-03-22 21:15:31.28485+00	21
658	145	46	2026-03-22 21:15:31.286106+00	21
659	25	59	2026-03-22 21:15:31.287288+00	21
660	128	59	2026-03-22 21:15:31.288765+00	21
661	129	59	2026-03-22 21:15:31.290097+00	21
662	81	59	2026-03-22 21:15:31.291226+00	21
663	53	59	2026-03-22 21:15:31.292472+00	21
664	130	59	2026-03-22 21:15:31.293605+00	21
665	82	59	2026-03-22 21:15:31.294877+00	21
666	131	59	2026-03-22 21:15:31.29623+00	21
667	132	59	2026-03-22 21:15:31.297568+00	21
668	133	59	2026-03-22 21:15:31.298658+00	21
669	84	59	2026-03-22 21:15:31.299872+00	21
670	134	59	2026-03-22 21:15:31.301051+00	21
671	55	59	2026-03-22 21:15:31.302177+00	21
672	136	59	2026-03-22 21:15:31.303441+00	21
673	137	59	2026-03-22 21:15:31.304661+00	21
674	138	59	2026-03-22 21:15:31.305922+00	21
675	139	59	2026-03-22 21:15:31.307114+00	21
676	140	59	2026-03-22 21:15:31.308604+00	21
677	142	59	2026-03-22 21:15:31.310177+00	21
678	90	59	2026-03-22 21:15:31.311631+00	21
679	145	59	2026-03-22 21:15:31.31342+00	21
680	93	59	2026-03-22 21:15:31.31524+00	21
681	94	59	2026-03-22 21:15:31.31708+00	21
682	115	53	2026-03-22 21:15:31.318688+00	21
684	142	53	2026-03-22 21:15:31.321595+00	21
685	91	53	2026-03-22 21:15:31.322969+00	21
686	144	53	2026-03-22 21:15:31.328758+00	21
687	60	53	2026-03-22 21:15:31.330525+00	21
688	146	53	2026-03-22 21:15:31.331779+00	21
689	136	48	2026-03-22 21:15:31.332932+00	21
693	91	48	2026-03-22 21:15:31.337706+00	21
697	51	35	2026-03-22 21:15:31.342366+00	21
700	152	35	2026-03-22 21:15:31.34606+00	21
707	79	36	2026-03-22 21:15:31.354159+00	21
709	152	36	2026-03-22 21:15:31.35805+00	21
710	153	36	2026-03-22 21:15:31.360198+00	21
714	147	37	2026-03-22 21:15:31.367528+00	21
716	153	37	2026-03-22 21:15:31.370195+00	21
720	133	38	2026-03-22 21:15:31.375078+00	21
721	140	38	2026-03-22 21:15:31.376624+00	21
725	148	40	2026-03-22 21:15:31.381447+00	21
726	140	40	2026-03-22 21:15:31.382752+00	21
733	119	41	2026-03-22 21:15:31.390868+00	21
736	148	42	2026-03-22 21:15:31.394361+00	21
738	150	42	2026-03-22 21:15:31.397129+00	21
744	155	43	2026-03-22 21:15:31.406213+00	21
747	140	44	2026-03-22 21:15:31.410233+00	21
748	89	44	2026-03-22 21:15:31.412135+00	21
750	148	45	2026-03-22 21:15:31.414753+00	21
752	150	47	2026-03-22 21:15:31.417233+00	21
753	140	47	2026-03-22 21:15:31.418711+00	21
756	148	53	2026-03-22 21:15:31.422931+00	21
757	155	53	2026-03-22 21:15:31.424467+00	21
760	148	48	2026-03-22 21:15:31.428274+00	21
764	159	35	2026-03-22 21:15:31.433292+00	21
765	50	35	2026-03-22 21:15:31.434466+00	21
767	160	35	2026-03-22 21:15:31.436601+00	21
768	44	36	2026-03-22 21:15:31.437771+00	21
774	96	37	2026-03-22 21:15:31.444415+00	21
775	97	37	2026-03-22 21:15:31.445808+00	21
776	115	37	2026-03-22 21:15:31.446889+00	21
779	160	38	2026-03-22 21:15:31.450521+00	21
784	96	50	2026-03-22 21:15:31.456752+00	21
786	159	50	2026-03-22 21:15:31.46075+00	21
788	161	50	2026-03-22 21:15:31.463722+00	21
789	96	54	2026-03-22 21:15:31.465099+00	21
790	97	54	2026-03-22 21:15:31.46666+00	21
791	115	54	2026-03-22 21:15:31.468213+00	21
792	158	54	2026-03-22 21:15:31.469744+00	21
793	159	54	2026-03-22 21:15:31.471062+00	21
794	102	54	2026-03-22 21:15:31.472295+00	21
796	161	54	2026-03-22 21:15:31.474953+00	21
804	159	43	2026-03-22 21:15:31.48588+00	21
808	161	43	2026-03-22 21:15:31.490444+00	21
809	160	44	2026-03-22 21:15:31.491578+00	21
812	97	45	2026-03-22 21:15:31.494772+00	21
813	115	45	2026-03-22 21:15:31.495905+00	21
814	158	45	2026-03-22 21:15:31.497175+00	21
815	159	45	2026-03-22 21:15:31.498315+00	21
819	161	45	2026-03-22 21:15:31.503483+00	21
820	158	52	2026-03-22 21:15:31.505687+00	21
821	159	52	2026-03-22 21:15:31.507098+00	21
825	115	47	2026-03-22 21:15:31.512201+00	21
826	159	47	2026-03-22 21:15:31.513504+00	21
831	159	53	2026-03-22 21:15:31.519583+00	21
833	160	53	2026-03-22 21:15:31.522241+00	21
837	160	48	2026-03-22 21:15:31.527243+00	21
854	103	37	2026-03-22 21:15:31.546656+00	21
862	97	38	2026-03-22 21:15:31.556802+00	21
864	131	38	2026-03-22 21:15:31.559146+00	21
866	134	38	2026-03-22 21:15:31.561503+00	21
870	145	38	2026-03-22 21:15:31.5665+00	21
872	167	39	2026-03-22 21:15:31.568948+00	21
873	77	39	2026-03-22 21:15:31.570354+00	21
881	134	41	2026-03-22 21:15:31.580084+00	21
883	135	41	2026-03-22 21:15:31.582321+00	21
887	77	42	2026-03-22 21:15:31.592279+00	21
891	77	43	2026-03-22 21:15:31.59786+00	21
894	120	43	2026-03-22 21:15:31.602439+00	21
899	64	60	2026-03-22 21:15:31.610032+00	21
900	98	60	2026-03-22 21:15:31.611684+00	21
901	77	60	2026-03-22 21:15:31.613226+00	21
903	134	46	2026-03-22 21:15:31.615801+00	21
906	129	47	2026-03-22 21:15:31.62109+00	21
907	131	47	2026-03-22 21:15:31.622648+00	21
909	134	47	2026-03-22 21:15:31.627515+00	21
911	145	47	2026-03-22 21:15:31.632926+00	21
912	21	61	2026-03-22 21:15:31.635401+00	21
913	103	61	2026-03-22 21:15:31.63737+00	21
914	120	61	2026-03-22 21:15:31.639668+00	21
917	84	53	2026-03-22 21:15:31.648556+00	21
920	24	49	2026-03-22 21:15:31.657329+00	21
928	158	36	2026-03-22 21:15:31.676898+00	21
930	27	36	2026-03-22 21:15:31.679584+00	21
933	109	36	2026-03-22 21:15:31.683513+00	21
935	158	37	2026-03-22 21:15:31.68735+00	21
936	170	37	2026-03-22 21:15:31.689353+00	21
938	33	37	2026-03-22 21:15:31.693341+00	21
942	175	38	2026-03-22 21:15:31.698506+00	21
947	23	40	2026-03-22 21:15:31.704959+00	21
948	158	40	2026-03-22 21:15:31.706316+00	21
949	171	40	2026-03-22 21:15:31.707606+00	21
950	172	40	2026-03-22 21:15:31.708908+00	21
951	173	40	2026-03-22 21:15:31.710232+00	21
953	27	40	2026-03-22 21:15:31.713097+00	21
956	174	40	2026-03-22 21:15:31.717526+00	21
957	33	40	2026-03-22 21:15:31.718994+00	21
958	176	40	2026-03-22 21:15:31.720478+00	21
959	177	40	2026-03-22 21:15:31.72324+00	21
960	158	41	2026-03-22 21:15:31.724915+00	21
961	74	41	2026-03-22 21:15:31.726551+00	21
964	24	42	2026-03-22 21:15:31.730679+00	21
965	173	42	2026-03-22 21:15:31.732144+00	21
967	27	42	2026-03-22 21:15:31.735483+00	21
969	176	42	2026-03-22 21:15:31.738394+00	21
970	23	43	2026-03-22 21:15:31.739872+00	21
971	158	43	2026-03-22 21:15:31.741284+00	21
972	171	43	2026-03-22 21:15:31.742651+00	21
973	172	43	2026-03-22 21:15:31.743922+00	21
974	173	43	2026-03-22 21:15:31.745328+00	21
976	27	43	2026-03-22 21:15:31.747831+00	21
979	174	43	2026-03-22 21:15:31.751777+00	21
980	33	43	2026-03-22 21:15:31.754097+00	21
981	176	43	2026-03-22 21:15:31.755824+00	21
983	177	43	2026-03-22 21:15:31.758509+00	21
984	174	52	2026-03-22 21:15:31.759872+00	21
985	177	52	2026-03-22 21:15:31.76211+00	21
986	37	52	2026-03-22 21:15:31.763693+00	21
988	171	53	2026-03-22 21:15:31.766224+00	21
989	24	53	2026-03-22 21:15:31.767476+00	21
993	31	53	2026-03-22 21:15:31.772211+00	21
994	176	53	2026-03-22 21:15:31.77343+00	21
995	37	53	2026-03-22 21:15:31.774594+00	21
996	177	53	2026-03-22 21:15:31.775675+00	21
1000	45	36	2026-03-22 21:15:31.779868+00	21
1002	83	36	2026-03-22 21:15:31.782425+00	21
1003	89	36	2026-03-22 21:15:31.786103+00	21
1005	92	36	2026-03-22 21:15:31.789297+00	21
1006	61	36	2026-03-22 21:15:31.791036+00	21
1007	179	37	2026-03-22 21:15:31.793015+00	21
1008	60	38	2026-03-22 21:15:31.795644+00	21
1010	83	38	2026-03-22 21:15:31.798684+00	21
1012	45	39	2026-03-22 21:15:31.80384+00	21
1013	83	39	2026-03-22 21:15:31.805745+00	21
1015	60	39	2026-03-22 21:15:31.808708+00	21
1016	92	39	2026-03-22 21:15:31.810292+00	21
1017	61	41	2026-03-22 21:15:31.811623+00	21
1019	179	42	2026-03-22 21:15:31.814199+00	21
1030	180	52	2026-03-22 21:15:31.828823+00	21
1031	78	53	2026-03-22 21:15:31.830169+00	21
1034	95	53	2026-03-22 21:15:31.83435+00	21
1038	60	48	2026-03-22 21:15:31.839816+00	21
1041	28	49	2026-03-22 21:15:31.844044+00	21
1046	117	36	2026-03-22 21:15:31.854822+00	21
1050	181	37	2026-03-22 21:15:31.860736+00	21
1053	186	37	2026-03-22 21:15:31.864793+00	21
1055	148	39	2026-03-22 21:15:31.867672+00	21
1057	150	39	2026-03-22 21:15:31.870107+00	21
1058	164	39	2026-03-22 21:15:31.871826+00	21
1059	28	39	2026-03-22 21:15:31.873439+00	21
1061	163	62	2026-03-22 21:15:31.876075+00	21
1062	164	62	2026-03-22 21:15:31.87732+00	21
1064	182	51	2026-03-22 21:15:31.879538+00	21
1075	176	45	2026-03-22 21:15:31.894188+00	21
1077	73	46	2026-03-22 21:15:31.896996+00	21
1079	31	52	2026-03-22 21:15:31.899295+00	21
1084	181	53	2026-03-22 21:15:31.904874+00	21
1087	28	53	2026-03-22 21:15:31.908207+00	21
1094	109	35	2026-03-22 21:15:31.931117+00	21
1097	72	36	2026-03-22 21:15:31.937632+00	21
1102	59	36	2026-03-22 21:15:31.945272+00	21
1109	161	37	2026-03-22 21:15:31.95589+00	21
1111	189	37	2026-03-22 21:15:31.959685+00	21
1112	70	38	2026-03-22 21:15:31.961158+00	21
1113	72	38	2026-03-22 21:15:31.964529+00	21
1124	146	38	2026-03-22 21:15:31.978881+00	21
1128	97	39	2026-03-22 21:15:31.983705+00	21
1130	188	39	2026-03-22 21:15:31.98594+00	21
1131	155	39	2026-03-22 21:15:31.987203+00	21
1139	102	50	2026-03-22 21:15:31.995952+00	21
1146	110	50	2026-03-22 21:15:32.004044+00	21
1148	121	50	2026-03-22 21:15:32.006424+00	21
1151	189	50	2026-03-22 21:15:32.009801+00	21
1159	160	40	2026-03-22 21:15:32.020139+00	21
1162	121	40	2026-03-22 21:15:32.023806+00	21
1163	161	40	2026-03-22 21:15:32.025308+00	21
1164	189	40	2026-03-22 21:15:32.026544+00	21
1173	188	42	2026-03-22 21:15:32.037493+00	21
1189	82	46	2026-03-22 21:15:32.068664+00	21
1202	146	47	2026-03-22 21:15:32.086918+00	21
1206	72	53	2026-03-22 21:15:32.092414+00	21
1209	131	53	2026-03-22 21:15:32.0957+00	21
1212	189	53	2026-03-22 21:15:32.099289+00	21
1214	190	53	2026-03-22 21:15:32.101925+00	21
1216	97	48	2026-03-22 21:15:32.104261+00	21
1220	38	49	2026-03-22 21:15:32.109025+00	21
1222	194	37	2026-03-22 21:15:32.111462+00	21
1223	196	37	2026-03-22 21:15:32.112642+00	21
1226	54	39	2026-03-22 21:15:32.116154+00	21
1229	195	41	2026-03-22 21:15:32.119772+00	21
1230	160	43	2026-03-22 21:15:32.121435+00	21
1232	196	48	2026-03-22 21:15:32.124011+00	21
1233	201	49	2026-03-22 21:15:32.125354+00	21
1241	67	36	2026-03-22 21:15:32.137925+00	21
1242	48	36	2026-03-22 21:15:32.139513+00	21
1243	49	36	2026-03-22 21:15:32.140736+00	21
1251	126	38	2026-03-22 21:15:32.150916+00	21
1253	199	38	2026-03-22 21:15:32.153655+00	21
1255	132	38	2026-03-22 21:15:32.156366+00	21
1258	143	38	2026-03-22 21:15:32.160521+00	21
1264	201	39	2026-03-22 21:15:32.16785+00	21
1268	67	50	2026-03-22 21:15:32.172497+00	21
1283	132	47	2026-03-22 21:15:32.190131+00	21
1298	148	49	2026-03-22 21:15:32.216238+00	21
1300	27	49	2026-03-22 21:15:32.2188+00	21
1305	177	49	2026-03-22 21:15:32.224978+00	21
1306	123	49	2026-03-22 21:15:32.226183+00	21
1309	33	35	2026-03-22 21:15:32.229598+00	21
1328	158	39	2026-03-22 21:15:32.251025+00	21
1334	159	40	2026-03-22 21:15:32.260306+00	21
1339	113	50	2026-03-22 21:15:32.2676+00	21
1344	123	50	2026-03-22 21:15:32.275097+00	21
1350	175	41	2026-03-22 21:15:32.28265+00	21
1352	123	41	2026-03-22 21:15:32.285094+00	21
1355	113	42	2026-03-22 21:15:32.28864+00	21
1370	113	52	2026-03-22 21:15:32.30705+00	21
1371	171	52	2026-03-22 21:15:32.308318+00	21
1372	24	52	2026-03-22 21:15:32.309571+00	21
1373	173	52	2026-03-22 21:15:32.310812+00	21
1376	33	52	2026-03-22 21:15:32.31523+00	21
1387	33	53	2026-03-22 21:15:32.329582+00	21
1388	123	53	2026-03-22 21:15:32.331064+00	21
1410	9	64	2026-03-22 21:15:32.359517+00	21
1413	208	35	2026-03-22 21:15:32.364086+00	21
1416	25	36	2026-03-22 21:15:32.368177+00	21
1417	145	36	2026-03-22 21:15:32.369399+00	21
1419	44	38	2026-03-22 21:15:32.371689+00	21
1420	72	39	2026-03-22 21:15:32.372781+00	21
1421	25	39	2026-03-22 21:15:32.374051+00	21
1422	131	39	2026-03-22 21:15:32.375173+00	21
1423	137	39	2026-03-22 21:15:32.376374+00	21
1424	142	39	2026-03-22 21:15:32.377629+00	21
1427	145	39	2026-03-22 21:15:32.381923+00	21
1428	146	39	2026-03-22 21:15:32.38332+00	21
1431	73	65	2026-03-22 21:15:32.386622+00	21
1432	131	65	2026-03-22 21:15:32.388029+00	21
1435	146	54	2026-03-22 21:15:32.391839+00	21
1438	208	41	2026-03-22 21:15:32.395658+00	21
1449	208	44	2026-03-22 21:15:32.407974+00	21
1452	91	60	2026-03-22 21:15:32.411412+00	21
1453	208	45	2026-03-22 21:15:32.412608+00	21
1455	146	52	2026-03-22 21:15:32.414939+00	21
1458	137	47	2026-03-22 21:15:32.418769+00	21
1459	142	47	2026-03-22 21:15:32.420115+00	21
1463	93	47	2026-03-22 21:15:32.42586+00	21
1465	211	47	2026-03-22 21:15:32.428367+00	21
1466	208	48	2026-03-22 21:15:32.429789+00	21
1472	84	57	2026-03-22 21:15:32.437244+00	21
1484	129	38	2026-03-22 21:15:32.451534+00	21
1492	137	38	2026-03-22 21:15:32.460257+00	21
1493	138	38	2026-03-22 21:15:32.461949+00	21
1494	142	38	2026-03-22 21:15:32.467519+00	21
1499	212	39	2026-03-22 21:15:32.473766+00	21
1522	212	43	2026-03-22 21:15:32.500587+00	21
1526	132	44	2026-03-22 21:15:32.506106+00	21
1539	69	48	2026-03-22 21:15:32.522394+00	21
\.


--
-- Data for Name: herbs; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herbs (id, latin_name, common_name, created_at, temperature, moisture, tone, monograph_url) FROM stdin;
220	Krameria triandra	Rhatany	2026-04-06 21:33:58.34407+00	cooling	drying	toning	\N
448	Ephedra sinica	Ma Huang	2026-04-23 16:06:39.257018+00	warming	drying	neutral	\N
33	Mahonia aquifolium	Oregon Grape	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	https://docs.google.com/document/d/11NLmT9cdT62wQOLuBr_831C9JnbtCfCKfhmNQyUsvso/edit?usp=classroom_web&authuser=0
450	Ammi visnaga	Khella	2026-04-23 16:06:39.257018+00	warming	neutral	relaxing	\N
11	Ganoderma lucidum	Reishi Mushroom	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	https://docs.google.com/document/d/16eOvbiMzzkvj6mpUTSS5D-CfvBF3E-szvs6pBm8y6C8/edit?usp=classroom_web&authuser=0
10	Eucommia ulmoides	Hardy Rubber Tree	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	\N
12	Hoppea dichotoma Leuzea carthamoides	Maral Root	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
14	Panax ginseng	Korean Ginseng	2026-03-22 21:15:28.845147+00	warming	moistening	toning	\N
15	Panax quinquefolius	American Ginseng	2026-03-22 21:15:28.845147+00	neutral	moistening	toning	\N
16	Rhodiola rosea	Rhodiola	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
17	Schisandra chinensis	Schizandra	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
18	Tinospora cordifolia	Guduchi	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	\N
19	Trichopus zeylanicus	Arogyappacha	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	\N
13	Ocimum sanctum	Holy Basil	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	https://docs.google.com/document/d/1qCWjDgPuXsIpXDrL72I81M4pfkVH-kbOy0A_U7PGSB8/edit?usp=classroom_web&authuser=0
858	Lycopus europaeus	Bugleweed	2026-05-17 19:20:07.593885+00	cooling	drying	neutral	\N
22	Arctium lappa	Burdock	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
23	Baptisia tinctoria	Wild Indigo	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
570	Cupressus sempervirens	Cypress	2026-04-23 16:07:11.301036+00	cooling	drying	toning	\N
591	Oplopanax horridus	Devil's Club	2026-04-25 23:10:59.300366+00	warming	drying	toning	\N
579	Aralia californica	California Spikenard	2026-04-25 23:10:59.300366+00	warming	neutral	neutral	\N
24	Chionanthus virginicus	Fringetree	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
25	Cimicifuga racemosa	Black Cohosh	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	\N
882	Phyllanthus emblica	Indian Gooseberry	2026-05-17 19:20:07.593885+00	cooling	moistening	toning	\N
45	Althaea officinalis	Marshmallow	2026-03-22 21:15:28.845147+00	cooling	moistening	relaxing	https://docs.google.com/document/d/1yczahfNno3lPQ9eQoVxYiy-vcEsmrxkBVyErG5B76yo/edit?usp=classroom_web&authuser=0
26	Echinacea spp.	Echinacea	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	https://docs.google.com/document/d/1DCKGxL0nRxE0oHKNxyBWoK3qmLghDbg20Z__r--KHfo/edit?usp=classroom_web&authuser=0
21	Allium sativum	Garlic	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1Xc_wtWpqXM9WW0ToTVmpYhbbCMqn9nytz6bvJTnhbLs/edit?usp=classroom_web&authuser=0
309	Anemopsis californica	Yerba Mansa	2026-04-12 15:59:34.804125+00	warming	drying	toning	https://docs.google.com/document/d/1E5TjtDMVnfHS8KHwcuOrtsnDoVsflG40nzFynMGMD5A/edit?usp=classroom_web&authuser=0
892	Stachys betonica	Wood Betony	2026-05-17 19:20:07.593885+00	warming	drying	relaxing	\N
27	Fumaria officinalis	Fumitory	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
29	Guaiacum officinale	Guaiacum	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
30	Hydrastis canadensis	Goldenseal	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
31	Iris versicolor	Blue Flag	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
956	Salvia miltiorrhiza	Dan Shen	2026-05-17 19:20:07.593885+00	cooling	drying	neutral	\N
34	Menyanthes trifoliata	Bogbean	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
35	Phytolacca americana	Poke	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
36	Pulsatilla vulgaris	Pasqueflower	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	\N
37	Rumex crispus	Yellow Dock	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
38	Sanguinaria canadensis	Bloodroot	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
39	Scrophularia nodosa	Figwort	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
40	Smilax spp.	Sarsaparilla	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
41	Stillingia sylvatica	Queen’s Delight	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
42	Trifolium pratense	Red Clover	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
1159	Tilia spp.	Linden	2026-06-08 14:41:59.876695+00	neutral	neutral	neutral	\N
1160	Vaccinium myrtillus	Bilberry	2026-06-08 14:41:59.876695+00	neutral	neutral	neutral	\N
48	Cetraria islandica	Iceland Moss	2026-03-22 21:15:28.845147+00	neutral	moistening	toning	\N
49	Chondrus crispus	Irish Moss	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
111	Syzygium aromaticum	Clove	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
219	Alchemilla spp.	Lady's Mantle	2026-04-06 21:33:58.34407+00	cooling	drying	toning	\N
296	Hydrangea arborescens	Hydrangea	2026-04-10 20:58:36.064973+00	cooling	moistening	neutral	\N
302	Melaleuca spp.	Tea Tree	2026-04-10 20:58:36.064973+00	cooling	drying	neutral	\N
1240	Viola tricolor	Heartsease	2026-06-08 14:41:59.876695+00	neutral	neutral	neutral	\N
313	Sassafras albidum	Sassafras	2026-04-12 15:59:34.804125+00	warming	drying	neutral	\N
320	Prunus persica	Peach	2026-04-12 15:59:34.804125+00	cooling	moistening	relaxing	\N
338	Euphorbia pilulifera	Pill-Bearing Spurge	2026-04-23 16:05:55.110389+00	neutral	drying	relaxing	\N
340	Papaver spp.	Poppy	2026-04-23 16:05:55.110389+00	cooling	moistening	relaxing	\N
441	Pinguicula vulgaris	Butterwort	2026-04-23 16:06:39.257018+00	neutral	moistening	neutral	\N
583	Sambucus spp.	Elderflower	2026-04-25 23:10:59.300366+00	cooling	neutral	neutral	\N
586	Petasites palmatus	Western Coltsfoot	2026-04-25 23:10:59.300366+00	warming	moistening	neutral	\N
593	Smilacina racemosa	False Solomon's Seal	2026-04-25 23:10:59.300366+00	neutral	moistening	relaxing	\N
615	Cola vera	Kola Nut	2026-04-30 16:29:43.150631+00	warming	drying	neutral	\N
617	Ilex paraguayensis	Yerba Mate	2026-04-30 16:29:43.150631+00	warming	drying	neutral	\N
645	Gelsemium sempervirens	Yellow Jasmine	2026-04-30 16:29:43.150631+00	cooling	drying	relaxing	\N
831	Helichrysum italicum	Helichrysum	2026-04-30 16:30:46.287227+00	cooling	neutral	neutral	\N
849	Rosa canina	Rosehips	2026-05-17 16:00:54.051539+00	cooling	moistening	neutral	\N
850	Rosa gallica	Rose	2026-05-17 16:00:54.051539+00	cooling	drying	toning	\N
851	Lepidium meyenii	Maca	2026-05-17 16:00:54.051539+00	warming	moistening	toning	\N
853	Garrya fremontii	Silk Tassel	2026-05-17 16:00:54.051539+00	cooling	drying	relaxing	\N
877	Commiphora mukul	Guggul	2026-05-17 19:20:07.593885+00	warming	drying	neutral	\N
1248	Fouquieria splendens	Ocotillo	2026-06-17 17:14:13.776779+00	neutral	neutral	neutral	https://docs.google.com/document/d/18R8y5TBb4_alh4oq8-dEWRC_GM5cL8dubeX7OZq8nHc/edit?tab=t.0
885	Medicago sativa	Alfalfa	2026-05-17 19:20:07.593885+00	neutral	moistening	neutral	\N
1	Acanthopanax sessiliflorum	Wu Jia Pi	2026-03-22 21:15:28.845147+00	neutral	drying	toning	\N
223	Rehmannia glutinosa	Rehmannia	2026-04-06 21:56:27.332838+00	cooling	moistening	neutral	\N
224	Bupleurum falcatum	Bupleurum	2026-04-06 21:56:27.332838+00	cooling	drying	neutral	\N
140	Prunus serotina	Wild Cherry Bark	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1xFESEIZvFY90Mw85Mv16C80J9q58LmAV9Rw7PZMfNH4/edit?usp=classroom_web&authuser=0
155	Rubus idaeus	Raspberry	2026-03-22 21:15:28.845147+00	cooling	drying	toning	https://docs.google.com/document/d/1FohWPAJg-4QkK_uVD6eGG39RDQei_SIngAP3x2t7cIo/edit?tab=t.0
226	Lentinus edodes	Shiitake	2026-04-06 21:56:27.332838+00	neutral	neutral	toning	\N
227	Picrorrhiza kurroa	Kutki	2026-04-06 21:56:27.332838+00	cooling	drying	neutral	\N
228	Ranunculus ficaria	Pilewort	2026-04-06 21:56:27.332838+00	cooling	drying	toning	\N
271	Codonopsis tangshen	Codonopsis	2026-04-10 20:55:36.403551+00	neutral	moistening	toning	\N
407	Citrus aurantium ssp. bergamia	Bergamot	2026-04-23 16:06:07.589513+00	cooling	drying	relaxing	\N
274	Ligustrum lucidum	Privet	2026-04-10 20:55:36.403551+00	cooling	moistening	toning	\N
3	Aralia elata	Japanese Angelica Tree	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
4	Aralia manshurica	Manchurian Aralia	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
5	Aralia schmidtii	Sakhalin Spikenard	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
6	Cicer arietinum	Chickpea	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
7	Codonoposis pilosula	Dang Shen	2026-03-22 21:15:28.845147+00	neutral	moistening	toning	\N
8	Echinopanax elatus	Asian Devil’s Club	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
473	Allium spp.	Onion And Garlic	2026-04-23 16:06:49.507222+00	warming	drying	neutral	\N
410	Mentha arvensis var. piperascens	Asian Mint	2026-04-23 16:06:07.589513+00	cooling	drying	relaxing	\N
50	Eupatorium perfoliatum	Boneset	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
51	Euphrasia spp.	Eyebright	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
535	Citrus limon	Lemon	2026-04-23 16:06:49.507222+00	cooling	drying	neutral	\N
412	Pinus pumilio	Dwarf Pine	2026-04-23 16:06:07.589513+00	warming	drying	neutral	\N
2	Albizzia julibrissin	Silk Tree	2026-03-22 21:15:28.845147+00	cooling	neutral	relaxing	https://docs.google.com/document/d/1WEoMOIX3mD4Y3Kn0xd9uVYZ9LjFjw4YrB5KlZRD7rtY/edit?usp=classroom_web&authuser=0
93	Viburnum opulus	Cramp Bark	2026-03-22 21:15:28.845147+00	neutral	neutral	relaxing	https://docs.google.com/document/d/1AAcEtBF7qNH-NorywkqhL3lJ9_Dr_uNuXl32izZokfY/edit?tab=t.0
60	Tussilago farfara	Coltsfoot	2026-03-22 21:15:28.845147+00	warming	moistening	neutral	\N
56	Salvia officinalis	Sage	2026-03-22 21:15:28.845147+00	warming	drying	toning	https://docs.google.com/document/d/1l_0y6A-XGGWWziKdjalnzpOJ0N-Y8jIB4E3xhl6auYM/edit?tab=t.0
74	Dioscorea villosa	Wild Yam	2026-03-22 21:15:28.845147+00	warming	neutral	relaxing	https://docs.google.com/document/d/1SBKbF6kzlE10QobJyGV2uY2ZD-fpg9zjtMYkJCoCPMI/edit?tab=t.0
63	Alchemilla arvensis	Lady’s Mantle	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
64	Anethum graveolens	Dill	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
65	Angelica archangelica	Angelica	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
52	Geranium maculatum	Cranesbill	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
53	Hyssopus officinalis	Hyssop	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
70	Calendula officinalis	Calendula	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1GRAldCdeuPAARgaU9hCP-Who3BO3Lqe2xu6LOKwhNss/edit?tab=t.0
89	Symphytum officinale	Comfrey	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	https://docs.google.com/document/d/1YpgcAP6j8Djc8lLuGPuGWV__CjyEdyqAdTJSBqElkpk/edit?tab=t.0
66	Apium graveolens	Celery Seed	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
67	Asclepias tuberosa	Pleurisy Root	2026-03-22 21:15:28.845147+00	warming	neutral	relaxing	\N
68	Betula spp.	Birch	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
69	Borago officinalis	Borage	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
71	Capsella bursa-pastoris	Shepherd’s Purse	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
72	Caulophyllum thalictroides	Blue Cohosh	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
75	Filipendula ulmaria	Meadowsweet	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
76	Foeniculum vulgare	Fennel	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
77	Gaultheria procumbens	Wintergreen	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
78	Glycyrrhiza glabra	Licorice	2026-03-22 21:15:28.845147+00	neutral	moistening	relaxing	\N
79	Hamamelis virginiana	Witch Hazel	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
80	Harpagophytum procumbens	Devil’s Claw	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
81	Hypericum perforatum	St. John’s Wort	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
82	Lavandula spp.	Lavender	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	\N
83	Malva sylvestris	Mallow	2026-03-22 21:15:28.845147+00	cooling	moistening	relaxing	\N
86	Populus tremuloides	Aspen	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
87	Salix spp.	Willow	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
88	Stellaria media	Chickweed	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
91	Trigonella foenum-graecum	Fenugreek	2026-03-22 21:15:28.845147+00	warming	moistening	neutral	\N
92	Ulmus rubra	Slippery Elm	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
94	Viburnum prunifolium	Black Haw	2026-03-22 21:15:28.845147+00	neutral	neutral	relaxing	\N
96	Artemisia abrotanum	Southernwood	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
97	Artemisia absinthium	Wormwood	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
98	Carum carvi	Caraway	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
100	Coriandrum sativum	Coriander	2026-03-22 21:15:28.845147+00	neutral	drying	relaxing	\N
101	Eucalyptus spp.	Eucalyptus	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
102	Gentiana lutea	Gentian	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
120	Petroselinum crispum	Parsley	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
143	Symplocarpus foetidus	Skunk Cabbage	2026-03-22 21:15:28.845147+00	warming	neutral	relaxing	\N
152	Polygonum bistorta	Bistort	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
153	Quercus spp.	Oak	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
154	Rheum palmatum	Rhubarb	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
221	Echinacea angustifolia	Narrow-Leaf Echinacea	2026-04-06 21:56:27.332838+00	cooling	drying	neutral	\N
222	Phyllanthus amarus	Stonebreaker	2026-04-06 21:56:27.332838+00	cooling	drying	neutral	\N
413	Santalum album	Sandalwood	2026-04-23 16:06:07.589513+00	cooling	moistening	neutral	\N
657	Grindelia spp.	Grindelia	2026-04-30 16:29:55.415237+00	warming	drying	neutral	\N
156	Rubus villosus	Blackberry	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
161	Tanacetum vulgare	Tansy	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
162	Coleus forskohlii	Coleus	2026-03-22 21:15:28.845147+00	neutral	neutral	neutral	\N
163	Convallaria majalis	Lily Of The Valley	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
164	Cytisus scoparius	Scotch Broom	2026-03-22 21:15:28.845147+00	neutral	drying	neutral	\N
166	Urginea maritima	Squill	2026-03-22 21:15:28.845147+00	neutral	drying	neutral	\N
167	Cinnamomum spp.	Cinnamon	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
179	Elymus repens	Couch Grass	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
180	Linum usitatissimum	Flax	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
181	Agathosma betulina	Buchu	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
182	Collinsonia canadensis	Stoneroot	2026-03-22 21:15:28.845147+00	neutral	drying	toning	\N
406	Origanum vulgare	Oregano	2026-04-23 16:06:07.589513+00	warming	drying	neutral	\N
414	Styrax benzoin	Benzoin	2026-04-23 16:06:07.589513+00	warming	drying	neutral	\N
165	Ginkgo biloba	Ginkgo	2026-03-22 21:15:28.845147+00	neutral	drying	neutral	https://docs.google.com/document/d/19Zo6nksBBS-gy0jYJlz5b4zLS-ItY7MCh6G_mR7kbSI/edit?usp=classroom_web&authuser=0
178	Avena sativa	Oat	2026-03-22 21:15:28.845147+00	neutral	moistening	relaxing	https://docs.google.com/document/d/1WR8Om_2UmtiiujOY5voJBiq9c-5_QGBMUMwORMtom7E/edit?usp=classroom_web&authuser=0
1014	Alchemilla vulgaris	Lady's Mantle	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1058	Senecio aureus	Life Root	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1072	Crataegus laevigata	Hawthorn	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1083	Cinnamomum aromaticum	Cinnamon Bark	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1102	Rumex acetosa	Sorrel	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1122	Galega officinalis	Goat's Rue	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1124	Cnicus benedictus	Blessed Thistle	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1139	Oenothera biennis	Evening Primrose	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	\N
1009	Angelica sinensis	Dong Quai	2026-06-07 19:28:17.415064+00	neutral	neutral	neutral	https://docs.google.com/document/d/1NXoivzHpA80OwgGcdaiz8TLdvC6zuqy0wNZzh0rMwUE/edit?tab=t.0
469	Pinus sylvestris	Scots Pine	2026-04-23 16:06:39.257018+00	warming	drying	neutral	https://docs.google.com/document/d/1GzMTyXXp3LSfYplmSibNBBZtYtUHlYd1iFpSkrZvBE0/edit?tab=t.0
852	Asparagus racemosus	Shatavari	2026-05-17 16:00:54.051539+00	cooling	moistening	relaxing	https://docs.google.com/document/d/11Yugo0XIoOr032L5gK9qXlTHEzx3zcEF8ytTyRa07Gc/edit?tab=t.0
114	Arnica montana	Arnica	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1OnUJ3TWmhAD5hxAUtXYhvAtztWrrL9_Tp_YNlxOw-18/edit?tab=t.0
32	Larrea tridentata	Chaparral	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	https://docs.google.com/document/d/1ucGtHC4pDuldnvht2D_inPPs6MdxIdqOsWo84YE6WNA/edit?tab=t.0
1252	Polygonatum biflorum	Solomon's Seal	2026-06-17 17:14:13.776779+00	neutral	neutral	neutral	https://docs.google.com/document/d/1ysXLUPIpN04ef-orudMU9llllca7bYNVyw1Ue1wBRgk/edit?tab=t.0
148	Agrimonia eupatoria	Agrimony	2026-03-22 21:15:28.845147+00	neutral	drying	toning	https://docs.google.com/document/d/1cSFJ36XpTuaXqgluAQBde9rvo4XbLM_11AyZVvDh__A/edit?tab=t.0
28	Galium aparine	Cleavers	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	https://docs.google.com/document/d/1EX3J5MjiHrDSAvenmIfOmklE4O9DK-BNkjAk8HXYnnk/edit?tab=t.0
95	Zea mays	Corn Silk	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	https://docs.google.com/document/d/1v7upDA9aSShyMBbHP9w0sRg0wdUFgDEEsMCHAfopyN8/edit?tab=t.0
1212	Vaccinium macrocarpon	Cranberry	2026-06-08 14:41:59.876695+00	neutral	neutral	neutral	https://docs.google.com/document/d/1I2kd_372kZKUIo3QWgqrWPrwjdz0Svlyv9pu512gVXY/edit?tab=t.0
151	Equisetum arvense	Horsetail	2026-03-22 21:15:28.845147+00	cooling	drying	toning	https://docs.google.com/document/d/1TMVYtXeBP03otOI7d0--NmAFCyHvkDggiZ5aEbLCFlw/edit?tab=t.0
103	Juniperus communis	Juniper	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1bB3-uDAdgIAP4hTBmCQ6CBO16VtZ7nksdNDmOW6Vapc/edit?tab=t.0
1253	Arctostaphylos manzanita	Manzanita	2026-06-17 17:14:13.776779+00	neutral	neutral	neutral	https://docs.google.com/document/d/1Axj3gCJPlwQBA9qnYnxHe9k9Q10qWIirbZfbbz8BoVg/edit?tab=t.0
43	Urtica dioica	Nettles	2026-03-22 21:15:28.845147+00	neutral	drying	toning	https://docs.google.com/document/d/1kK2jup24D7dRb4J86Qn9igpoZMKYXKIjynvXZj1yqAc/edit?tab=t.0
46	Arctostaphylos uva-ursi	Bearberry	2026-03-22 21:15:28.845147+00	cooling	drying	toning	https://docs.google.com/document/d/1Pi14avxpxQL0ghD0deMazGMRH0Nxg6YEqJuQFDAIW7w/edit?tab=t.0
104	Ligusticum porteri	Osha	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
105	Myroxylon balsamum var. pereirae	Balsam Of Peru	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
106	Olea europaea	Olive	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
107	Origanum majorana	Marjoram	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
108	Pimpinella anisum	Aniseed	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
109	Rosmarinus officinalis	Rosemary	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
110	Ruta graveolens	Rue	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
150	Cola acuminata	Kola	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
136	Nepeta cataria	Catnip	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1qw1IOjyRw7i6Ixrd4EYqzF42TnMSaOp9aw07rlkRv-w/edit?usp=classroom_web&authuser=0
84	Matricaria recutita	Chamomile	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	https://docs.google.com/document/d/1cMLuyw7Y_7BypYIz7TZx9ZQaMzl0T-wQaeGXK77Hvos/edit?tab=t.0
124	Zingiber officinale	Ginger	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	https://docs.google.com/document/d/18EcFGSqs2E-WtEKw3OXbGoGwMMNDa9Msb1mioHD4Fro/edit?usp=classroom_web&authuser=0
115	Artemisia vulgaris	Mugwort	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	https://docs.google.com/document/d/1sKdd3iq8e0xg2QzCfwM2ysaMjQ2eIGyt4qJrz3RC3EA/edit?usp=classroom_web&authuser=0
55	Mentha piperita	Peppermint	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1tDDREbCbNjc082ZBu7COIqB8BmPVxrijoEpvjgAl0ls/edit?usp=classroom_web&authuser=0
85	Plantago major	Plantain	2026-03-22 21:15:28.845147+00	cooling	moistening	toning	https://docs.google.com/document/d/1V0L0JSs9wSwFXkNH-4sMePG2zYjM7tRkCDT1Mj50QaM/edit?usp=classroom_web&authuser=0
145	Valeriana officinalis	Valerian	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	https://docs.google.com/document/d/1PuH9Brq8Ry7WVtlCvyU2mX0qVBZnLcd4cBKYMNedXFY/edit?usp=classroom_web&authuser=0
225	Astragalus membranaceus	Astragalus	2026-04-06 21:56:27.332838+00	warming	moistening	toning	https://docs.google.com/document/d/1gQGRItw-oXvEcE6pt-qB1CAWLnCrd4UyDIRan6kCS5o/edit?usp=classroom_web&authuser=0
57	Sambucus nigra	Elder	2026-03-22 21:15:28.845147+00	cooling	neutral	neutral	https://docs.google.com/document/d/1YH0l-iELK7LzCmQhoG1j_faaK2EXtg3dsyOzEQ_NyZg/edit?usp=classroom_web&authuser=0
99	Commiphora molmol	Myrrh	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1drrQ74t5Zt3zoOcM26YnS62zCRatW6M0cHo1Ixef5bE/edit?usp=classroom_web&authuser=0
54	Inula helenium	Elecampane	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1LUsICOSmtMNYRRJ0KHLSk0h6FcULoFWo857kNPFlOxU/edit?usp=classroom_web&authuser=0
58	Solidago virgaurea	Goldenrod	2026-03-22 21:15:28.845147+00	warming	drying	toning	https://docs.google.com/document/d/1Zn7zRdZLuKfab0WMiI2XssPeBXnsEPXgF8a-rfBtJiI/edit?usp=classroom_web&authuser=0
199	Grindelia camporum	Gumweed	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/11zqbgFOB-AfdEj2kIH3R7MgTy6uOD4vliIOexpudstU/edit?usp=classroom_web&authuser=0
160	Marrubium vulgare	Horehound	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	https://docs.google.com/document/d/16Sk768zfhEdmaz0BcRjMIHPVfHSD1DyG1doCkto5UQ8/edit?usp=classroom_web&authuser=0
61	Verbascum thapsus	Mullein	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	https://docs.google.com/document/d/1xcMA1MfCGpGo3kZ-6QF-tQ_afFAJlhUkEsgA_wgPNUs/edit?usp=classroom_web&authuser=0
59	Thymus vulgaris	Thyme	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1Ti3LDr6rZAdaF1K_V4tETeljT1nSe3o3p1M-QGI7YIk/edit?usp=classroom_web&authuser=0
590	Eriodictyon californicum	Yerba Santa	2026-04-25 23:10:59.300366+00	warming	drying	neutral	https://docs.google.com/document/d/1CjpHxJ37Bv4FqNhgll0T5L8Ln5uC03zKXYWh32_C5iQ/edit?usp=classroom_web&authuser=0
20	Withania somnifera	Ashwagandha	2026-03-22 21:15:28.845147+00	warming	moistening	toning	https://docs.google.com/document/d/1LSq7VVrWUnuiwSZO0Uxm0Rtf6aXIQCrf4mKzU9m8RKs/edit?usp=classroom_web&authuser=0
128	Eschscholzia californica	California Poppy	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1nXMTe9mQzks1bxx7ahxqTRmqExx-GIBqV6HgdafTcdk/edit?usp=classroom_web&authuser=0
144	Turnera diffusa	Damiana	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	https://docs.google.com/document/d/1SN9bIg1ndHFr7bmj6e-30aV16Csi5meQouzYydwNlUk/edit?usp=classroom_web&authuser=0
134	Melissa officinalis	Lemon Balm	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1nu1boh4TBKm3H6qTsgMY4nuYTD2RunbYNBNIq-YwGPg/edit?usp=classroom_web&authuser=0
142	Scutellaria lateriflora	Skullcap	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1Tb3dZuK8jTjSYSGZPK4EsaaXzLE_2FzE_nWIyn4watQ/edit?usp=classroom_web&authuser=0
47	Capsicum annuum	Cayenne	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/15J5JL7ZQVs9qnJV24zawpbWPZ1X1ojob5yRRtANRFrE/edit?usp=classroom_web&authuser=0
73	Crataegus spp.	Hawthorn	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	https://docs.google.com/document/d/1w0J53oNgFQyOHdvkHCcJB3w3aMXqYSY5PXsQHX93qdQ/edit?usp=classroom_web&authuser=0
62	Aesculus hippocastanum	Horse Chestnut	2026-03-22 21:15:28.845147+00	cooling	drying	toning	https://docs.google.com/document/d/1_Xe6x8u7RsrwFNrCwVwrtrJmJKCzKsW61SYD55gmAi8/edit?usp=classroom_web&authuser=0
90	Tilia platyphyllos	Linden	2026-03-22 21:15:28.845147+00	cooling	moistening	relaxing	https://docs.google.com/document/d/1aNTMRjc7vJcwBLe27ukF8hgxAaECZmEK-YqWA9zRCM0/edit?usp=classroom_web&authuser=0
131	Leonurus cardiaca	Motherwort	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1EJ3zv2EBaooqh-IB2e5cA8ESDsgNraKZJ1zrYDbrTwo/edit?usp=classroom_web&authuser=0
137	Passiflora incarnata	Passionflower	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/1ozu3SYgon0QJ-fnUKtvx8WguBu8oye2cbDSEoMdKFGg/edit?usp=classroom_web&authuser=0
123	Zanthoxylum americanum	Prickly Ash	2026-03-22 21:15:28.845147+00	warming	drying	neutral	https://docs.google.com/document/d/1ftAZgmgNpeYwLZMFi9UW9jBZMwtTQ6A0ubRfXk9y1PM/edit?usp=classroom_web&authuser=0
9	Eleutherococcus senticosus	Siberian Ginseng	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	https://docs.google.com/document/d/1knzVQXKJXlyEG-gHJ8k5c6JCCkF4L3Sd5sp4U0m2V1M/edit?usp=classroom_web&authuser=0
44	Achillea millefolium	Yarrow	2026-03-22 21:15:28.845147+00	warming	drying	toning	https://docs.google.com/document/d/13K1S8ZlP79YPqJrdB8gaBRPFMWcWIpZ6ZeFqMiRExcM/edit?usp=classroom_web&authuser=0
122	Taraxacum officinale	Dandelion	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	https://docs.google.com/document/d/1kuHDaicHrEx3WE5JsVgm0Nmrb5ld8DX2pnEFHbrZnRI/edit?tab=t.0
1402	Aphanes arvensis	Parsley Piert	2026-06-21 16:44:38.744675+00	neutral	neutral	neutral	\N
1403	Parietaria diffusa	Pellitory-Of-The-Wall	2026-06-21 16:44:38.744675+00	neutral	neutral	neutral	\N
138	Piper methysticum	Kava	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	https://docs.google.com/document/d/11MG8007dKtoeAsfF0xoLHSShBT_ILK_VvPbg-s87Oiw/edit?usp=classroom_web&authuser=0
113	Armoracia rusticana	Horseradish	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
116	Brassica spp.	Mustard	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
117	Eupatorium purpureum	Gravel Root	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
118	Fucus vesiculosus	Kelp	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
119	Myrica cerifera	Bayberry	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
121	Tanacetum parthenium	Feverfew	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
980	Lomatium dissectum	Lomatium	2026-05-24 18:16:03.856759+00	neutral	neutral	neutral	https://docs.google.com/document/d/1pA3hnhhOUywprp7evXU7RXPK3C7ajELflVib6mBPAjg/edit?usp=classroom_web&authuser=0
981	Ceanothus americanus	Red Root	2026-05-24 18:16:03.856759+00	neutral	neutral	neutral	https://docs.google.com/document/d/1J6XY7bGox2zH3xY1TBNAiF1hiiqxvPUYyfjBpxB36vU/edit?usp=classroom_web&authuser=0
125	Daucus carota	Wild Carrot	2026-03-22 21:15:28.845147+00	neutral	drying	neutral	\N
126	Drosera rotundifolia	Sundew	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
127	Elettaria cardamomum	Cardamom	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
129	Humulus lupulus	Hops	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	\N
130	Lactuca virosa	Wild Lettuce	2026-03-22 21:15:28.845147+00	cooling	moistening	relaxing	\N
982	Pseudostellaria heterophylla	Prince Seng	2026-05-24 18:16:03.856759+00	neutral	neutral	neutral	https://docs.google.com/document/d/1wp7J0Ad9bB7NextaixjiQgvE7t64-NS_AtHMYC73Jfo/edit?usp=classroom_web&authuser=0
132	Lobelia inflata	Lobelia	2026-03-22 21:15:28.845147+00	neutral	drying	relaxing	\N
133	Lycopus spp.	Bugleweed	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
135	Mentha pulegium	Pennyroyal	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
188	Mitchella repens	Partridgeberry	2026-03-22 21:15:28.845147+00	neutral	drying	toning	https://docs.google.com/document/d/1dFgfoficerlmhv9JGjIMYoC7uIy8vmKuoRxW69JAtZ8/edit?tab=t.0
186	Serenoa repens	Saw Palmetto	2026-03-22 21:15:28.845147+00	warming	moistening	toning	https://docs.google.com/document/d/1ugIPiF61HdjDirzF94V9lJRNqUxUGbDocpQO0ovyshA/edit?tab=t.0
139	Piscidia erythrina	Jamaica Dogwood	2026-03-22 21:15:28.845147+00	neutral	drying	relaxing	\N
141	Salvia officinalis var. rubia	Red Sage	2026-03-22 21:15:28.845147+00	warming	drying	toning	\N
146	Verbena officinalis	Vervain	2026-03-22 21:15:28.845147+00	cooling	drying	relaxing	\N
147	Acacia catechu	Black Catechu	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
149	Camellia sinensis	Tea	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
157	Vinca major	Periwinkle	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
158	Berberis vulgaris	Barberry	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
159	Centaurium erythraea	Centaury	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
170	Chelidonium majus	Celandine	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
171	Chelone glabra	Balmony	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
172	Cynara scolymus	Artichoke	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
173	Euonymus atropurpureus	Wahoo	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
174	Juglans cinerea	Butternut	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
175	Leptandra virginica	Black Root	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
176	Peumus boldus	Boldo	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
177	Taraxacum officinale root	Dandelion Root	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
183	Cucurbita pepo	Pumpkin	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
184	Eryngium maritimum	Sea Holly	2026-03-22 21:15:28.845147+00	neutral	drying	neutral	\N
185	Parietaria judaica	Pellitory Of The Wall	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
187	Marsdenia condurango	Condurango	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
189	Tropaeolum majus	Nasturtium	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
190	Vitex agnus-castus	Chasteberry	2026-03-22 21:15:28.845147+00	neutral	neutral	toning	\N
191	Bellis perennis	English Daisy	2026-03-22 21:15:28.845147+00	neutral	drying	neutral	\N
192	Cephaelis ipecacuanha	Ipecac	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
193	Hieracium pilosella	Mouse Ear	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
194	Myroxylon balsamum var. balsamum	Tolu Balsam	2026-03-22 21:15:28.845147+00	warming	moistening	neutral	\N
195	Polygala senega	Seneca Snakeroot	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
196	Populus candicans	Balm Of Gilead	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
197	Primula veris	Cowslip	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
198	Viola odorata	Violet	2026-03-22 21:15:28.845147+00	cooling	moistening	relaxing	\N
200	Pulmonaria officinalis	Lungwort	2026-03-22 21:15:28.845147+00	neutral	moistening	neutral	\N
201	Thuja occidentalis	Thuja	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
202	Aloe vera	Aloe	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
203	Curcuma longa	Turmeric	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
204	Rhamnus cathartica	Buckthorn	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
205	Rhamnus purshiana	Cascara Sagrada	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
206	Silybum marianum	Milk Thistle	2026-03-22 21:15:28.845147+00	cooling	moistening	neutral	\N
207	Stachys officinalis	Wood Betony	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
208	Allium cepa	Onion	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
210	Fagopyrum esculentum	Buckwheat	2026-03-22 21:15:28.845147+00	cooling	drying	toning	\N
211	Viscum album	Mistletoe	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
212	Ballota nigra	Black Horehound	2026-03-22 21:15:28.845147+00	neutral	drying	relaxing	\N
213	Chamaemelum nobile	Roman Chamomile	2026-03-22 21:15:28.845147+00	warming	drying	relaxing	\N
215	Panax spp.	Ginseng	2026-03-22 21:15:28.845147+00	warming	moistening	toning	\N
216	Senna alexandrina	Senna	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	\N
217	Coffea arabica	Coffee	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
218	Paullinia cupana	Guarana	2026-03-22 21:15:28.845147+00	warming	drying	neutral	\N
288	Juglans nigra	Black Walnut	2026-04-10 20:56:04.197894+00	cooling	drying	neutral	\N
291	Tabebuia impetiginosa	Pau D'arco	2026-04-10 20:56:04.197894+00	warming	drying	neutral	\N
420	Ocimum basilicum	Basil	2026-04-23 16:06:22.109926+00	warming	drying	relaxing	\N
742	Neroli	Neroli	2026-04-30 16:30:20.373726+00	cooling	drying	relaxing	\N
743	Salvia sclarea	Clary Sage	2026-04-30 16:30:20.373726+00	warming	drying	relaxing	\N
745	Cananga odorata	Ylang Ylang	2026-04-30 16:30:20.373726+00	neutral	neutral	relaxing	\N
112	Usnea spp.	Usnea	2026-03-22 21:15:28.845147+00	cooling	drying	neutral	https://docs.google.com/document/d/1n-ssGWbF1nOLvSUpbZeUZNZqvmLu8jmeoF4Ft8JjIkU/edit?usp=classroom_web&authuser=0
748	Citrus sinensis	Sweet Orange	2026-04-30 16:30:20.373726+00	warming	drying	relaxing	\N
983	Verbena hastata	Blue Vervain	2026-05-24 18:16:03.856759+00	neutral	neutral	neutral	https://docs.google.com/document/d/1xPsYvGrH33JXLLSZlC0NuoKGi__JXR_EjUqFEymtBUw/edit?usp=classroom_web&authuser=0
1428	Plantago spp.	Plantain	2026-06-21 16:54:56.148727+00	neutral	neutral	neutral	\N
1441	Eucalyptus globulus	Eucalyptus	2026-06-21 16:54:56.148727+00	neutral	neutral	neutral	\N
1442	Melaleuca alternifolia	Tea Tree	2026-06-21 16:54:56.148727+00	neutral	neutral	neutral	\N
1475	Populus balsamifera var. balsamifera	Balm Of Gilead	2026-06-21 16:54:56.148727+00	neutral	neutral	neutral	\N
\.


--
-- Data for Name: prescription_herb_actions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.prescription_herb_actions (id, prescription_herb_id, primary_action_id, created_at) FROM stdin;
1	9	2	2026-04-06 21:56:43.554385+00
2	9	5	2026-04-06 21:56:43.554385+00
3	10	2	2026-04-06 21:56:43.554385+00
4	10	27	2026-04-06 21:56:43.554385+00
5	11	2	2026-04-06 21:56:43.554385+00
6	11	27	2026-04-06 21:56:43.554385+00
7	11	28	2026-04-06 21:56:43.554385+00
8	13	2	2026-04-06 21:56:43.554385+00
9	13	5	2026-04-06 21:56:43.554385+00
10	13	27	2026-04-06 21:56:43.554385+00
11	15	2	2026-04-06 21:56:43.554385+00
12	15	5	2026-04-06 21:56:43.554385+00
13	15	27	2026-04-06 21:56:43.554385+00
14	16	2	2026-04-06 21:56:43.554385+00
15	16	27	2026-04-06 21:56:43.554385+00
16	17	2	2026-04-06 21:56:43.554385+00
17	17	27	2026-04-06 21:56:43.554385+00
18	17	29	2026-04-06 21:56:43.554385+00
19	18	13	2026-04-06 21:56:43.554385+00
20	19	4	2026-04-06 21:56:43.554385+00
21	19	8	2026-04-06 21:56:43.554385+00
22	19	27	2026-04-06 21:56:43.554385+00
23	19	28	2026-04-06 21:56:43.554385+00
24	20	4	2026-04-06 21:56:43.554385+00
25	20	11	2026-04-06 21:56:43.554385+00
26	21	13	2026-04-06 21:56:43.554385+00
27	22	4	2026-04-06 21:56:43.554385+00
28	22	8	2026-04-06 21:56:43.554385+00
29	23	4	2026-04-06 21:56:43.554385+00
30	23	26	2026-04-06 21:56:43.554385+00
31	23	28	2026-04-06 21:56:43.554385+00
32	24	8	2026-04-06 21:56:43.554385+00
33	24	13	2026-04-06 21:56:43.554385+00
34	24	28	2026-04-06 21:56:43.554385+00
35	25	13	2026-04-06 21:56:43.554385+00
36	26	4	2026-04-06 21:56:43.554385+00
37	26	11	2026-04-06 21:56:43.554385+00
38	26	26	2026-04-06 21:56:43.554385+00
39	26	28	2026-04-06 21:56:43.554385+00
40	27	4	2026-04-06 21:56:43.554385+00
41	27	8	2026-04-06 21:56:43.554385+00
42	27	9	2026-04-06 21:56:43.554385+00
43	27	28	2026-04-06 21:56:43.554385+00
44	28	8	2026-04-06 21:56:43.554385+00
45	28	13	2026-04-06 21:56:43.554385+00
46	28	28	2026-04-06 21:56:43.554385+00
47	29	4	2026-04-06 21:56:43.554385+00
48	29	11	2026-04-06 21:56:43.554385+00
49	29	26	2026-04-06 21:56:43.554385+00
50	29	28	2026-04-06 21:56:43.554385+00
51	30	8	2026-04-06 21:56:43.554385+00
52	30	13	2026-04-06 21:56:43.554385+00
53	30	28	2026-04-06 21:56:43.554385+00
54	31	13	2026-04-06 21:56:43.554385+00
55	32	4	2026-04-06 21:56:43.554385+00
56	32	8	2026-04-06 21:56:43.554385+00
57	32	11	2026-04-06 21:56:43.554385+00
58	33	4	2026-04-06 21:56:43.554385+00
59	33	9	2026-04-06 21:56:43.554385+00
60	33	11	2026-04-06 21:56:43.554385+00
61	33	26	2026-04-06 21:56:43.554385+00
62	34	4	2026-04-06 21:56:43.554385+00
63	34	11	2026-04-06 21:56:43.554385+00
64	35	9	2026-04-06 21:56:43.554385+00
65	36	26	2026-04-06 21:56:43.554385+00
66	37	8	2026-04-06 21:56:43.554385+00
67	38	9	2026-04-06 21:56:43.554385+00
68	39	4	2026-04-06 21:56:43.554385+00
69	39	7	2026-04-06 21:56:43.554385+00
70	39	9	2026-04-06 21:56:43.554385+00
71	39	11	2026-04-06 21:56:43.554385+00
72	39	26	2026-04-06 21:56:43.554385+00
73	39	28	2026-04-06 21:56:43.554385+00
74	40	7	2026-04-06 21:56:43.554385+00
75	40	11	2026-04-06 21:56:43.554385+00
76	41	4	2026-04-06 21:56:43.554385+00
77	41	7	2026-04-06 21:56:43.554385+00
78	42	26	2026-04-06 21:56:43.554385+00
79	43	8	2026-04-06 21:56:43.554385+00
80	44	4	2026-04-06 21:56:43.554385+00
81	45	8	2026-04-06 21:56:43.554385+00
82	45	13	2026-04-06 21:56:43.554385+00
83	45	28	2026-04-06 21:56:43.554385+00
84	46	7	2026-04-06 21:56:43.554385+00
85	46	11	2026-04-06 21:56:43.554385+00
86	46	26	2026-04-06 21:56:43.554385+00
87	47	8	2026-04-06 21:56:43.554385+00
88	48	4	2026-04-06 21:56:43.554385+00
89	48	7	2026-04-06 21:56:43.554385+00
90	48	11	2026-04-06 21:56:43.554385+00
91	48	26	2026-04-06 21:56:43.554385+00
92	48	28	2026-04-06 21:56:43.554385+00
93	49	4	2026-04-06 21:56:43.554385+00
94	49	7	2026-04-06 21:56:43.554385+00
95	50	11	2026-04-06 21:56:43.554385+00
96	50	26	2026-04-06 21:56:43.554385+00
97	51	7	2026-04-06 21:56:43.554385+00
98	52	4	2026-04-06 21:56:43.554385+00
99	52	7	2026-04-06 21:56:43.554385+00
100	52	11	2026-04-06 21:56:43.554385+00
101	52	26	2026-04-06 21:56:43.554385+00
102	53	2	2026-04-06 21:56:43.554385+00
103	53	9	2026-04-06 21:56:43.554385+00
104	53	19	2026-04-06 21:56:43.554385+00
105	53	33	2026-04-06 21:56:43.554385+00
106	54	19	2026-04-06 21:56:43.554385+00
107	55	19	2026-04-06 21:56:43.554385+00
108	56	19	2026-04-06 21:56:43.554385+00
109	57	2	2026-04-06 21:56:43.554385+00
110	57	9	2026-04-06 21:56:43.554385+00
111	57	19	2026-04-06 21:56:43.554385+00
112	57	33	2026-04-06 21:56:43.554385+00
113	58	2	2026-04-06 21:56:43.554385+00
114	58	9	2026-04-06 21:56:43.554385+00
115	58	19	2026-04-06 21:56:43.554385+00
116	58	33	2026-04-06 21:56:43.554385+00
117	59	19	2026-04-06 21:56:43.554385+00
118	59	35	2026-04-06 21:56:43.554385+00
119	60	5	2026-04-06 21:56:43.554385+00
120	61	9	2026-04-06 21:56:43.554385+00
121	62	19	2026-04-06 21:56:43.554385+00
122	64	36	2026-04-06 21:56:43.554385+00
123	65	37	2026-04-06 21:56:43.554385+00
124	66	38	2026-04-06 21:56:43.554385+00
125	71	7	2026-04-06 21:56:43.554385+00
126	72	19	2026-04-06 21:56:43.554385+00
127	73	7	2026-04-06 21:56:43.554385+00
128	74	2	2026-04-06 21:56:43.554385+00
129	74	4	2026-04-06 21:56:43.554385+00
130	74	19	2026-04-06 21:56:43.554385+00
131	74	33	2026-04-06 21:56:43.554385+00
132	75	2	2026-04-06 21:56:43.554385+00
133	75	19	2026-04-06 21:56:43.554385+00
134	75	33	2026-04-06 21:56:43.554385+00
135	76	7	2026-04-06 21:56:43.554385+00
136	77	7	2026-04-06 21:56:43.554385+00
137	78	19	2026-04-06 21:56:43.554385+00
138	78	41	2026-04-06 21:56:43.554385+00
139	79	19	2026-04-06 21:56:43.554385+00
140	80	19	2026-04-06 21:56:43.554385+00
141	80	41	2026-04-06 21:56:43.554385+00
142	81	42	2026-04-06 21:56:43.554385+00
143	82	42	2026-04-06 21:56:43.554385+00
144	83	9	2026-04-06 21:56:43.554385+00
145	83	31	2026-04-06 21:56:43.554385+00
146	84	9	2026-04-06 21:56:43.554385+00
147	84	31	2026-04-06 21:56:43.554385+00
148	85	8	2026-04-06 21:56:43.554385+00
149	86	42	2026-04-06 21:56:43.554385+00
152	231	7	2026-04-30 16:30:20.373726+00
154	232	11	2026-04-30 16:30:20.373726+00
155	232	7	2026-04-30 16:30:20.373726+00
158	233	7	2026-04-30 16:30:20.373726+00
160	234	7	2026-04-30 16:30:20.373726+00
161	234	4	2026-04-30 16:30:20.373726+00
162	234	11	2026-04-30 16:30:20.373726+00
164	236	9	2026-04-30 16:30:20.373726+00
165	236	4	2026-04-30 16:30:20.373726+00
166	236	11	2026-04-30 16:30:20.373726+00
167	237	9	2026-04-30 16:30:20.373726+00
168	237	11	2026-04-30 16:30:20.373726+00
171	238	7	2026-04-30 16:30:20.373726+00
173	239	7	2026-04-30 16:30:20.373726+00
179	243	9	2026-04-30 16:30:20.373726+00
180	244	20	2026-04-30 16:30:20.373726+00
182	244	7	2026-04-30 16:30:20.373726+00
183	245	20	2026-04-30 16:30:20.373726+00
185	245	7	2026-04-30 16:30:20.373726+00
186	245	11	2026-04-30 16:30:20.373726+00
187	246	20	2026-04-30 16:30:20.373726+00
189	246	7	2026-04-30 16:30:20.373726+00
190	247	20	2026-04-30 16:30:20.373726+00
192	247	7	2026-04-30 16:30:20.373726+00
193	247	11	2026-04-30 16:30:20.373726+00
195	248	7	2026-04-30 16:30:20.373726+00
196	248	15	2026-04-30 16:30:20.373726+00
197	249	20	2026-04-30 16:30:20.373726+00
199	249	7	2026-04-30 16:30:20.373726+00
200	250	20	2026-04-30 16:30:20.373726+00
202	250	7	2026-04-30 16:30:20.373726+00
203	250	11	2026-04-30 16:30:20.373726+00
204	250	4	2026-04-30 16:30:20.373726+00
206	251	7	2026-04-30 16:30:20.373726+00
207	251	11	2026-04-30 16:30:20.373726+00
208	251	9	2026-04-30 16:30:20.373726+00
210	252	7	2026-04-30 16:30:20.373726+00
211	252	11	2026-04-30 16:30:20.373726+00
212	252	4	2026-04-30 16:30:20.373726+00
213	253	20	2026-04-30 16:30:20.373726+00
215	253	7	2026-04-30 16:30:20.373726+00
216	254	20	2026-04-30 16:30:20.373726+00
218	254	7	2026-04-30 16:30:20.373726+00
220	255	7	2026-04-30 16:30:20.373726+00
221	255	36	2026-04-30 16:30:20.373726+00
223	256	7	2026-04-30 16:30:20.373726+00
224	256	36	2026-04-30 16:30:20.373726+00
225	256	9	2026-04-30 16:30:20.373726+00
231	270	7	2026-04-30 16:30:34.395192+00
233	272	1	2026-04-30 16:30:34.395192+00
234	273	9	2026-04-30 16:30:34.395192+00
235	273	19	2026-04-30 16:30:34.395192+00
241	276	19	2026-04-30 16:30:34.395192+00
244	312	4	2026-04-30 16:30:46.287227+00
245	312	7	2026-04-30 16:30:46.287227+00
248	313	7	2026-04-30 16:30:46.287227+00
250	315	1	2026-04-30 16:30:46.287227+00
254	329	4	2026-04-30 16:30:46.287227+00
255	329	7	2026-04-30 16:30:46.287227+00
256	329	5	2026-04-30 16:30:46.287227+00
259	331	7	2026-04-30 16:30:46.287227+00
260	332	21	2026-05-17 19:20:07.593885+00
261	332	10	2026-05-17 19:20:07.593885+00
262	332	14	2026-05-17 19:20:07.593885+00
264	333	21	2026-05-17 19:20:07.593885+00
265	333	10	2026-05-17 19:20:07.593885+00
266	333	14	2026-05-17 19:20:07.593885+00
267	333	7	2026-05-17 19:20:07.593885+00
270	334	21	2026-05-17 19:20:07.593885+00
271	334	14	2026-05-17 19:20:07.593885+00
273	335	21	2026-05-17 19:20:07.593885+00
274	335	7	2026-05-17 19:20:07.593885+00
276	336	21	2026-05-17 19:20:07.593885+00
277	336	7	2026-05-17 19:20:07.593885+00
279	378	10	2026-05-17 19:20:07.593885+00
281	378	21	2026-05-17 19:20:07.593885+00
282	378	7	2026-05-17 19:20:07.593885+00
283	379	10	2026-05-17 19:20:07.593885+00
285	379	21	2026-05-17 19:20:07.593885+00
286	379	26	2026-05-17 19:20:07.593885+00
287	379	7	2026-05-17 19:20:07.593885+00
288	380	10	2026-05-17 19:20:07.593885+00
290	380	390	2026-05-17 19:20:07.593885+00
291	380	21	2026-05-17 19:20:07.593885+00
292	381	10	2026-05-17 19:20:07.593885+00
294	381	21	2026-05-17 19:20:07.593885+00
295	381	26	2026-05-17 19:20:07.593885+00
296	381	7	2026-05-17 19:20:07.593885+00
297	382	10	2026-05-17 19:20:07.593885+00
299	382	390	2026-05-17 19:20:07.593885+00
300	382	7	2026-05-17 19:20:07.593885+00
305	403	8	2026-05-17 19:20:07.593885+00
307	404	4	2026-05-17 19:20:07.593885+00
308	405	8	2026-05-17 19:20:07.593885+00
309	406	4	2026-05-17 19:20:07.593885+00
310	407	44	2026-05-17 19:20:07.593885+00
311	407	13	2026-05-17 19:20:07.593885+00
312	407	28	2026-05-17 19:20:07.593885+00
302	401	29	2026-05-17 19:20:07.593885+00
303	402	29	2026-05-17 19:20:07.593885+00
257	330	25	2026-04-30 16:30:46.287227+00
151	231	23	2026-04-30 16:30:20.373726+00
153	232	23	2026-04-30 16:30:20.373726+00
157	233	23	2026-04-30 16:30:20.373726+00
159	234	23	2026-04-30 16:30:20.373726+00
163	235	23	2026-04-30 16:30:20.373726+00
170	238	23	2026-04-30 16:30:20.373726+00
172	239	23	2026-04-30 16:30:20.373726+00
175	241	23	2026-04-30 16:30:20.373726+00
177	242	23	2026-04-30 16:30:20.373726+00
178	243	23	2026-04-30 16:30:20.373726+00
181	244	23	2026-04-30 16:30:20.373726+00
184	245	23	2026-04-30 16:30:20.373726+00
188	246	23	2026-04-30 16:30:20.373726+00
191	247	23	2026-04-30 16:30:20.373726+00
194	248	23	2026-04-30 16:30:20.373726+00
198	249	23	2026-04-30 16:30:20.373726+00
201	250	23	2026-04-30 16:30:20.373726+00
205	251	23	2026-04-30 16:30:20.373726+00
209	252	23	2026-04-30 16:30:20.373726+00
214	253	23	2026-04-30 16:30:20.373726+00
217	254	23	2026-04-30 16:30:20.373726+00
219	255	23	2026-04-30 16:30:20.373726+00
222	256	23	2026-04-30 16:30:20.373726+00
227	268	23	2026-04-30 16:30:34.395192+00
229	269	23	2026-04-30 16:30:34.395192+00
230	270	23	2026-04-30 16:30:34.395192+00
232	271	23	2026-04-30 16:30:34.395192+00
238	275	23	2026-04-30 16:30:34.395192+00
240	276	23	2026-04-30 16:30:34.395192+00
243	312	23	2026-04-30 16:30:46.287227+00
247	313	23	2026-04-30 16:30:46.287227+00
253	329	23	2026-04-30 16:30:46.287227+00
258	331	23	2026-04-30 16:30:46.287227+00
269	333	23	2026-05-17 19:20:07.593885+00
275	335	23	2026-05-17 19:20:07.593885+00
278	336	23	2026-05-17 19:20:07.593885+00
150	231	22	2026-04-30 16:30:20.373726+00
156	233	22	2026-04-30 16:30:20.373726+00
169	238	22	2026-04-30 16:30:20.373726+00
174	241	22	2026-04-30 16:30:20.373726+00
176	242	22	2026-04-30 16:30:20.373726+00
226	268	22	2026-04-30 16:30:34.395192+00
228	269	22	2026-04-30 16:30:34.395192+00
236	274	22	2026-04-30 16:30:34.395192+00
237	275	22	2026-04-30 16:30:34.395192+00
239	276	22	2026-04-30 16:30:34.395192+00
242	312	22	2026-04-30 16:30:46.287227+00
246	313	22	2026-04-30 16:30:46.287227+00
249	314	22	2026-04-30 16:30:46.287227+00
251	328	22	2026-04-30 16:30:46.287227+00
252	329	22	2026-04-30 16:30:46.287227+00
263	332	42	2026-05-17 19:20:07.593885+00
268	333	42	2026-05-17 19:20:07.593885+00
272	334	42	2026-05-17 19:20:07.593885+00
280	378	42	2026-05-17 19:20:07.593885+00
284	379	42	2026-05-17 19:20:07.593885+00
289	380	42	2026-05-17 19:20:07.593885+00
293	381	42	2026-05-17 19:20:07.593885+00
298	382	42	2026-05-17 19:20:07.593885+00
301	400	42	2026-05-17 19:20:07.593885+00
304	403	42	2026-05-17 19:20:07.593885+00
306	404	42	2026-05-17 19:20:07.593885+00
325	414	15	2026-06-07 19:28:17.415064+00
326	414	509	2026-06-07 19:28:17.415064+00
327	415	15	2026-06-07 19:28:17.415064+00
328	416	15	2026-06-07 19:28:17.415064+00
329	416	510	2026-06-07 19:28:17.415064+00
330	417	15	2026-06-07 19:28:17.415064+00
331	417	509	2026-06-07 19:28:17.415064+00
332	417	524	2026-06-07 19:28:17.415064+00
333	418	15	2026-06-07 19:28:17.415064+00
334	418	524	2026-06-07 19:28:17.415064+00
335	419	15	2026-06-07 19:28:17.415064+00
336	419	510	2026-06-07 19:28:17.415064+00
337	420	7	2026-06-07 19:28:17.415064+00
338	420	26	2026-06-07 19:28:17.415064+00
339	421	7	2026-06-07 19:28:17.415064+00
340	421	26	2026-06-07 19:28:17.415064+00
341	422	7	2026-06-07 19:28:17.415064+00
342	422	26	2026-06-07 19:28:17.415064+00
343	422	509	2026-06-07 19:28:17.415064+00
344	423	7	2026-06-07 19:28:17.415064+00
345	423	26	2026-06-07 19:28:17.415064+00
346	424	7	2026-06-07 19:28:17.415064+00
347	425	7	2026-06-07 19:28:17.415064+00
348	425	26	2026-06-07 19:28:17.415064+00
349	425	509	2026-06-07 19:28:17.415064+00
350	426	26	2026-06-07 19:28:17.415064+00
351	426	7	2026-06-07 19:28:17.415064+00
352	427	26	2026-06-07 19:28:17.415064+00
353	427	7	2026-06-07 19:28:17.415064+00
354	428	14	2026-06-07 19:28:17.415064+00
355	429	510	2026-06-07 19:28:17.415064+00
356	429	509	2026-06-07 19:28:17.415064+00
357	430	26	2026-06-07 19:28:17.415064+00
358	430	7	2026-06-07 19:28:17.415064+00
359	430	509	2026-06-07 19:28:17.415064+00
360	431	26	2026-06-07 19:28:17.415064+00
361	431	7	2026-06-07 19:28:17.415064+00
362	432	26	2026-06-07 19:28:17.415064+00
363	432	7	2026-06-07 19:28:17.415064+00
364	432	2	2026-06-07 19:28:17.415064+00
365	433	14	2026-06-07 19:28:17.415064+00
366	433	2	2026-06-07 19:28:17.415064+00
367	434	14	2026-06-07 19:28:17.415064+00
368	435	510	2026-06-07 19:28:17.415064+00
369	436	524	2026-06-07 19:28:17.415064+00
370	436	576	2026-06-07 19:28:17.415064+00
371	436	36	2026-06-07 19:28:17.415064+00
372	437	509	2026-06-07 19:28:17.415064+00
373	438	510	2026-06-07 19:28:17.415064+00
374	439	524	2026-06-07 19:28:17.415064+00
375	440	524	2026-06-07 19:28:17.415064+00
376	440	36	2026-06-07 19:28:17.415064+00
377	441	509	2026-06-07 19:28:17.415064+00
378	442	509	2026-06-07 19:28:17.415064+00
379	442	524	2026-06-07 19:28:17.415064+00
380	442	7	2026-06-07 19:28:17.415064+00
381	443	509	2026-06-07 19:28:17.415064+00
382	443	524	2026-06-07 19:28:17.415064+00
383	443	7	2026-06-07 19:28:17.415064+00
384	449	509	2026-06-07 19:28:17.415064+00
385	449	2	2026-06-07 19:28:17.415064+00
386	450	511	2026-06-07 19:28:17.415064+00
387	451	510	2026-06-07 19:28:17.415064+00
388	452	509	2026-06-07 19:28:17.415064+00
389	452	2	2026-06-07 19:28:17.415064+00
390	452	7	2026-06-07 19:28:17.415064+00
391	453	7	2026-06-07 19:28:17.415064+00
392	454	2	2026-06-07 19:28:17.415064+00
393	454	27	2026-06-07 19:28:17.415064+00
394	455	510	2026-06-07 19:28:17.415064+00
395	456	509	2026-06-07 19:28:17.415064+00
396	456	7	2026-06-07 19:28:17.415064+00
397	456	524	2026-06-07 19:28:17.415064+00
398	457	7	2026-06-07 19:28:17.415064+00
399	457	524	2026-06-07 19:28:17.415064+00
400	458	7	2026-06-07 19:28:17.415064+00
401	458	524	2026-06-07 19:28:17.415064+00
402	459	510	2026-06-07 19:28:17.415064+00
403	460	27	2026-06-07 19:28:17.415064+00
404	460	14	2026-06-07 19:28:17.415064+00
405	461	524	2026-06-07 19:28:17.415064+00
406	461	7	2026-06-07 19:28:17.415064+00
407	462	73	2026-06-08 15:00:58.883045+00
408	463	4	2026-06-08 15:00:58.883045+00
409	464	2	2026-06-08 15:00:58.883045+00
410	465	13	2026-06-08 15:00:58.883045+00
411	466	8	2026-06-08 15:00:58.883045+00
412	467	8	2026-06-08 15:00:58.883045+00
413	468	13	2026-06-08 15:00:58.883045+00
414	469	8	2026-06-08 15:00:58.883045+00
435	480	13	2026-06-21 16:44:38.744675+00
436	480	14	2026-06-21 16:44:38.744675+00
437	480	4	2026-06-21 16:44:38.744675+00
438	481	5	2026-06-21 16:44:38.744675+00
439	481	4	2026-06-21 16:44:38.744675+00
440	481	13	2026-06-21 16:44:38.744675+00
441	482	7	2026-06-21 16:44:38.744675+00
442	483	13	2026-06-21 16:44:38.744675+00
443	483	4	2026-06-21 16:44:38.744675+00
444	483	14	2026-06-21 16:44:38.744675+00
445	484	5	2026-06-21 16:44:38.744675+00
446	484	4	2026-06-21 16:44:38.744675+00
447	484	13	2026-06-21 16:44:38.744675+00
448	485	8	2026-06-21 16:44:38.744675+00
449	486	8	2026-06-21 16:44:38.744675+00
450	487	14	2026-06-21 16:44:38.744675+00
451	487	13	2026-06-21 16:44:38.744675+00
452	488	5	2026-06-21 16:44:38.744675+00
453	488	8	2026-06-21 16:44:38.744675+00
454	488	14	2026-06-21 16:44:38.744675+00
455	489	14	2026-06-21 16:44:38.744675+00
456	490	14	2026-06-21 16:44:38.744675+00
457	490	13	2026-06-21 16:44:38.744675+00
458	491	14	2026-06-21 16:44:38.744675+00
459	491	5	2026-06-21 16:44:38.744675+00
460	492	14	2026-06-21 16:44:38.744675+00
461	492	5	2026-06-21 16:44:38.744675+00
462	493	14	2026-06-21 16:44:38.744675+00
463	493	13	2026-06-21 16:44:38.744675+00
464	494	14	2026-06-21 16:44:38.744675+00
465	494	5	2026-06-21 16:44:38.744675+00
466	495	7	2026-06-21 16:44:38.744675+00
467	496	7	2026-06-21 16:44:38.744675+00
468	503	14	2026-06-21 16:44:38.744675+00
469	503	41	2026-06-21 16:44:38.744675+00
470	503	13	2026-06-21 16:44:38.744675+00
471	504	14	2026-06-21 16:44:38.744675+00
472	504	41	2026-06-21 16:44:38.744675+00
473	505	14	2026-06-21 16:44:38.744675+00
474	505	13	2026-06-21 16:44:38.744675+00
475	505	7	2026-06-21 16:44:38.744675+00
476	506	7	2026-06-21 16:44:38.744675+00
477	507	7	2026-06-21 16:44:38.744675+00
478	508	2	2026-06-21 16:54:56.148727+00
479	508	55	2026-06-21 16:54:56.148727+00
480	508	4	2026-06-21 16:54:56.148727+00
481	508	14	2026-06-21 16:54:56.148727+00
482	508	19	2026-06-21 16:54:56.148727+00
483	509	2	2026-06-21 16:54:56.148727+00
484	509	55	2026-06-21 16:54:56.148727+00
485	509	14	2026-06-21 16:54:56.148727+00
486	510	2	2026-06-21 16:54:56.148727+00
487	510	524	2026-06-21 16:54:56.148727+00
488	510	19	2026-06-21 16:54:56.148727+00
489	511	2	2026-06-21 16:54:56.148727+00
490	511	55	2026-06-21 16:54:56.148727+00
491	511	4	2026-06-21 16:54:56.148727+00
492	511	14	2026-06-21 16:54:56.148727+00
493	511	19	2026-06-21 16:54:56.148727+00
494	512	2	2026-06-21 16:54:56.148727+00
495	512	14	2026-06-21 16:54:56.148727+00
496	512	19	2026-06-21 16:54:56.148727+00
497	513	2	2026-06-21 16:54:56.148727+00
498	516	2	2026-06-21 16:54:56.148727+00
499	516	14	2026-06-21 16:54:56.148727+00
500	516	19	2026-06-21 16:54:56.148727+00
501	517	2	2026-06-21 16:54:56.148727+00
502	517	19	2026-06-21 16:54:56.148727+00
503	518	2	2026-06-21 16:54:56.148727+00
504	518	55	2026-06-21 16:54:56.148727+00
505	518	4	2026-06-21 16:54:56.148727+00
506	518	14	2026-06-21 16:54:56.148727+00
507	518	19	2026-06-21 16:54:56.148727+00
508	519	524	2026-06-21 16:54:56.148727+00
509	520	2	2026-06-21 16:54:56.148727+00
510	520	14	2026-06-21 16:54:56.148727+00
511	520	19	2026-06-21 16:54:56.148727+00
512	521	2	2026-06-21 16:54:56.148727+00
513	521	19	2026-06-21 16:54:56.148727+00
514	522	2	2026-06-21 16:54:56.148727+00
515	522	55	2026-06-21 16:54:56.148727+00
516	522	4	2026-06-21 16:54:56.148727+00
517	522	14	2026-06-21 16:54:56.148727+00
518	522	19	2026-06-21 16:54:56.148727+00
519	523	524	2026-06-21 16:54:56.148727+00
520	524	524	2026-06-21 16:54:56.148727+00
521	524	19	2026-06-21 16:54:56.148727+00
522	525	2	2026-06-21 16:54:56.148727+00
523	525	14	2026-06-21 16:54:56.148727+00
524	525	19	2026-06-21 16:54:56.148727+00
525	526	2	2026-06-21 16:54:56.148727+00
526	526	19	2026-06-21 16:54:56.148727+00
527	527	2	2026-06-21 16:54:56.148727+00
528	527	19	2026-06-21 16:54:56.148727+00
529	528	2	2026-06-21 16:54:56.148727+00
530	528	55	2026-06-21 16:54:56.148727+00
531	529	524	2026-06-21 16:54:56.148727+00
532	530	2	2026-06-21 16:54:56.148727+00
533	530	14	2026-06-21 16:54:56.148727+00
534	530	19	2026-06-21 16:54:56.148727+00
535	531	2	2026-06-21 16:54:56.148727+00
536	531	19	2026-06-21 16:54:56.148727+00
537	532	2	2026-06-21 16:54:56.148727+00
538	532	55	2026-06-21 16:54:56.148727+00
539	532	4	2026-06-21 16:54:56.148727+00
540	532	14	2026-06-21 16:54:56.148727+00
541	532	19	2026-06-21 16:54:56.148727+00
542	533	524	2026-06-21 16:54:56.148727+00
543	534	21	2026-06-21 16:54:56.148727+00
544	534	14	2026-06-21 16:54:56.148727+00
545	535	524	2026-06-21 16:54:56.148727+00
546	535	21	2026-06-21 16:54:56.148727+00
547	535	14	2026-06-21 16:54:56.148727+00
548	536	21	2026-06-21 16:54:56.148727+00
549	536	14	2026-06-21 16:54:56.148727+00
550	537	2	2026-06-21 16:54:56.148727+00
551	537	19	2026-06-21 16:54:56.148727+00
552	537	55	2026-06-21 16:54:56.148727+00
553	538	2	2026-06-21 16:54:56.148727+00
554	538	19	2026-06-21 16:54:56.148727+00
555	538	14	2026-06-21 16:54:56.148727+00
556	539	5	2026-06-21 16:54:56.148727+00
557	539	55	2026-06-21 16:54:56.148727+00
558	540	2	2026-06-21 16:54:56.148727+00
559	540	55	2026-06-21 16:54:56.148727+00
560	540	14	2026-06-21 16:54:56.148727+00
561	540	4	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: prescription_herbs; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.prescription_herbs (id, prescription_id, herb_id, parts, note, sort_order, created_at) FROM stdin;
1	1	37	2 parts	\N	1	2026-04-06 21:33:58.34407+00
2	1	122	2 parts	root	2	2026-04-06 21:33:58.34407+00
3	1	108	1 part	\N	3	2026-04-06 21:33:58.34407+00
4	2	148	1 part	\N	1	2026-04-06 21:33:58.34407+00
5	2	52	1 part	\N	2	2026-04-06 21:33:58.34407+00
6	2	84	1 part	\N	3	2026-04-06 21:33:58.34407+00
7	3	56	1 part	var. rubia	1	2026-04-06 21:33:58.34407+00
8	3	84	1 part	\N	2	2026-04-06 21:33:58.34407+00
9	4	26	1 part	\N	1	2026-04-06 21:33:58.34407+00
10	4	28	1 part	\N	2	2026-04-06 21:33:58.34407+00
11	4	70	1 part	\N	3	2026-04-06 21:33:58.34407+00
12	5	99	1 part	\N	1	2026-04-06 21:33:58.34407+00
13	5	26	1 part	\N	2	2026-04-06 21:33:58.34407+00
14	5	220	1 part	\N	3	2026-04-06 21:33:58.34407+00
15	6	26	1 part	\N	1	2026-04-06 21:33:58.34407+00
16	6	28	1 part	\N	2	2026-04-06 21:33:58.34407+00
17	6	123	1 part	\N	3	2026-04-06 21:33:58.34407+00
18	7	45	2 parts	\N	1	2026-04-06 21:33:58.34407+00
19	7	70	1 part	\N	2	2026-04-06 21:33:58.34407+00
20	7	84	1 part	\N	3	2026-04-06 21:33:58.34407+00
21	8	45	3 parts	\N	1	2026-04-06 21:33:58.34407+00
22	8	75	1 part	\N	2	2026-04-06 21:33:58.34407+00
23	8	84	1 part	\N	3	2026-04-06 21:33:58.34407+00
24	9	89	1 part	root	1	2026-04-06 21:33:58.34407+00
25	9	45	1 part	root	2	2026-04-06 21:33:58.34407+00
26	9	84	1 part	\N	3	2026-04-06 21:33:58.34407+00
27	10	30	1 part	\N	1	2026-04-06 21:33:58.34407+00
28	10	89	2 parts	\N	2	2026-04-06 21:33:58.34407+00
29	10	84	2 parts	\N	3	2026-04-06 21:33:58.34407+00
30	11	89	1 part	root	1	2026-04-06 21:33:58.34407+00
31	11	45	1 part	root	2	2026-04-06 21:33:58.34407+00
32	11	75	1 part	\N	3	2026-04-06 21:33:58.34407+00
33	12	84	1 part	\N	1	2026-04-06 21:33:58.34407+00
34	12	55	1 part	\N	2	2026-04-06 21:33:58.34407+00
35	12	102	1 part	\N	3	2026-04-06 21:33:58.34407+00
36	12	145	1 part	\N	4	2026-04-06 21:33:58.34407+00
37	13	119	2 parts	\N	1	2026-04-06 21:56:12.487259+00
38	13	115	1 part	\N	2	2026-04-06 21:56:12.487259+00
39	13	84	1 part	\N	3	2026-04-06 21:56:12.487259+00
40	13	55	1 part	\N	4	2026-04-06 21:56:12.487259+00
41	13	74	1 part	\N	5	2026-04-06 21:56:12.487259+00
42	13	145	1 part	\N	6	2026-04-06 21:56:12.487259+00
43	14	119	2 parts	\N	1	2026-04-06 21:56:12.487259+00
44	14	74	2 parts	\N	2	2026-04-06 21:56:12.487259+00
45	14	89	2 parts	\N	3	2026-04-06 21:56:12.487259+00
46	14	145	1 part	\N	4	2026-04-06 21:56:12.487259+00
47	14	148	1 part	\N	5	2026-04-06 21:56:12.487259+00
48	14	84	1 part	\N	6	2026-04-06 21:56:12.487259+00
49	15	74	2 parts	\N	1	2026-04-06 21:56:12.487259+00
50	15	145	1 part	\N	2	2026-04-06 21:56:12.487259+00
51	15	93	1 part	\N	3	2026-04-06 21:56:12.487259+00
52	15	55	1 part	\N	4	2026-04-06 21:56:12.487259+00
53	16	122	2 parts	root	1	2026-04-06 21:56:27.332838+00
54	16	146	1 part	\N	2	2026-04-06 21:56:27.332838+00
55	16	206	1 part	\N	3	2026-04-06 21:56:27.332838+00
56	16	24	1 part	\N	4	2026-04-06 21:56:27.332838+00
57	16	176	1 part	\N	5	2026-04-06 21:56:27.332838+00
58	17	122	2 parts	root	1	2026-04-06 21:56:27.332838+00
59	17	206	2 parts	\N	2	2026-04-06 21:56:27.332838+00
60	17	26	1 part	\N	3	2026-04-06 21:56:27.332838+00
61	17	115	1 part	\N	4	2026-04-06 21:56:27.332838+00
62	17	24	1 part	\N	5	2026-04-06 21:56:27.332838+00
63	18	221	35 ml	\N	1	2026-04-06 21:56:27.332838+00
64	18	81	25 ml	\N	2	2026-04-06 21:56:27.332838+00
65	18	206	20 ml	\N	3	2026-04-06 21:56:27.332838+00
66	18	222	20 ml	\N	4	2026-04-06 21:56:27.332838+00
67	19	206	2 parts	\N	1	2026-04-06 21:56:27.332838+00
68	19	146	1 part	\N	2	2026-04-06 21:56:27.332838+00
69	19	171	1 part	\N	3	2026-04-06 21:56:27.332838+00
70	19	24	1 part	\N	4	2026-04-06 21:56:27.332838+00
71	20	74	2 parts	\N	1	2026-04-06 21:56:27.332838+00
72	20	24	2 parts	\N	2	2026-04-06 21:56:27.332838+00
73	20	145	2 parts	\N	3	2026-04-06 21:56:27.332838+00
74	20	122	1 part	root	4	2026-04-06 21:56:27.332838+00
75	20	175	1 part	\N	5	2026-04-06 21:56:27.332838+00
76	21	74	2 parts	\N	1	2026-04-06 21:56:27.332838+00
77	21	145	2 parts	\N	2	2026-04-06 21:56:27.332838+00
78	21	171	1 part	\N	3	2026-04-06 21:56:27.332838+00
79	21	175	1 part	\N	4	2026-04-06 21:56:27.332838+00
80	21	24	1 part	\N	5	2026-04-06 21:56:27.332838+00
81	22	165	1 part	\N	1	2026-04-06 21:56:27.332838+00
82	22	62	1 part	\N	2	2026-04-06 21:56:27.332838+00
83	22	122	1 part	\N	3	2026-04-06 21:56:27.332838+00
84	22	30	1 part	\N	4	2026-04-06 21:56:27.332838+00
85	22	52	1 part	\N	5	2026-04-06 21:56:27.332838+00
86	23	62	10 ml	\N	1	2026-04-06 21:56:27.332838+00
87	23	79	80 ml	distilled	2	2026-04-06 21:56:27.332838+00
88	24	288	equal parts	hull powder	1	2026-04-10 20:56:04.197894+00
89	24	32	equal parts	powder	2	2026-04-10 20:56:04.197894+00
90	24	26	equal parts	root powder	3	2026-04-10 20:56:04.197894+00
91	24	30	equal parts	root powder	4	2026-04-10 20:56:04.197894+00
92	24	45	equal parts	root powder	5	2026-04-10 20:56:04.197894+00
93	24	291	equal parts	powder	6	2026-04-10 20:56:04.197894+00
94	25	288	2 tablespoons	hull powder	1	2026-04-10 20:56:04.197894+00
95	25	99	2 tablespoons	powder	2	2026-04-10 20:56:04.197894+00
96	25	30	1 tablespoon	root powder (organically cultivated)	3	2026-04-10 20:56:04.197894+00
97	26	46	1 part	\N	1	2026-04-10 20:58:36.064973+00
98	26	181	1 part	\N	2	2026-04-10 20:58:36.064973+00
99	26	26	1 part	\N	3	2026-04-10 20:58:36.064973+00
100	26	186	1 part	\N	4	2026-04-10 20:58:36.064973+00
101	26	95	1 part	\N	5	2026-04-10 20:58:36.064973+00
102	27	26	3 parts	\N	1	2026-04-10 20:58:36.064973+00
103	27	28	2 parts	\N	2	2026-04-10 20:58:36.064973+00
104	27	37	1 part	\N	3	2026-04-10 20:58:36.064973+00
105	27	35	1 part	\N	4	2026-04-10 20:58:36.064973+00
106	28	82	1 part	essential oil	1	2026-04-10 20:58:36.064973+00
107	28	99	1 part	essential oil	2	2026-04-10 20:58:36.064973+00
108	29	60	2 parts	\N	1	2026-04-23 16:05:55.110389+00
109	29	45	2 parts	\N	2	2026-04-23 16:05:55.110389+00
110	29	53	2 parts	\N	3	2026-04-23 16:05:55.110389+00
111	29	78	1 part	\N	4	2026-04-23 16:05:55.110389+00
112	29	108	1 part	\N	5	2026-04-23 16:05:55.110389+00
113	30	61	1 part	\N	1	2026-04-23 16:06:07.589513+00
114	30	60	1 part	\N	2	2026-04-23 16:06:07.589513+00
115	30	45	1 part	\N	3	2026-04-23 16:06:07.589513+00
116	30	108	1 part	\N	4	2026-04-23 16:06:07.589513+00
117	31	197	1 part	\N	1	2026-04-23 16:06:07.589513+00
118	31	59	1 part	\N	2	2026-04-23 16:06:07.589513+00
119	31	60	1 part	\N	3	2026-04-23 16:06:07.589513+00
120	32	197	2 parts	\N	1	2026-04-23 16:06:07.589513+00
121	32	108	1 part	\N	2	2026-04-23 16:06:07.589513+00
122	32	60	1 part	\N	3	2026-04-23 16:06:07.589513+00
123	33	54	1 part	\N	1	2026-04-23 16:06:07.589513+00
124	33	160	1 part	\N	2	2026-04-23 16:06:07.589513+00
125	33	60	1 part	\N	3	2026-04-23 16:06:07.589513+00
126	33	30	1 part	\N	4	2026-04-23 16:06:07.589513+00
127	33	26	1 part	\N	5	2026-04-23 16:06:07.589513+00
128	34	84	1 part	flowers	1	2026-04-23 16:06:07.589513+00
129	34	59	1 part	herb	2	2026-04-23 16:06:07.589513+00
130	34	406	1 part	herb	3	2026-04-23 16:06:07.589513+00
131	35	407	essential oil	\N	1	2026-04-23 16:06:07.589513+00
133	35	82	essential oil	\N	3	2026-04-23 16:06:07.589513+00
134	35	410	essential oil	\N	4	2026-04-23 16:06:07.589513+00
135	35	55	essential oil	\N	5	2026-04-23 16:06:07.589513+00
136	35	412	essential oil	\N	6	2026-04-23 16:06:07.589513+00
137	35	413	essential oil	\N	7	2026-04-23 16:06:07.589513+00
138	35	414	essential oil	\N	8	2026-04-23 16:06:07.589513+00
139	35	59	essential oil	\N	9	2026-04-23 16:06:07.589513+00
140	36	407	essential oil	\N	1	2026-04-23 16:06:22.109926+00
141	36	99	essential oil	\N	2	2026-04-23 16:06:22.109926+00
142	36	420	essential oil	\N	3	2026-04-23 16:06:22.109926+00
143	36	107	essential oil	\N	4	2026-04-23 16:06:22.109926+00
144	36	413	essential oil	\N	5	2026-04-23 16:06:22.109926+00
145	36	59	essential oil	\N	6	2026-04-23 16:06:22.109926+00
146	37	54	1 part	\N	1	2026-04-23 16:06:22.109926+00
147	37	48	1 part	\N	2	2026-04-23 16:06:22.109926+00
148	37	60	1 part	\N	3	2026-04-23 16:06:22.109926+00
149	37	61	1 part	\N	4	2026-04-23 16:06:22.109926+00
150	38	54	1 part	\N	1	2026-04-23 16:06:22.109926+00
151	38	26	1 part	\N	2	2026-04-23 16:06:22.109926+00
152	38	160	1 part	\N	3	2026-04-23 16:06:22.109926+00
153	38	61	1 part	\N	4	2026-04-23 16:06:22.109926+00
154	39	54	1 part	\N	1	2026-04-23 16:06:22.109926+00
155	39	160	1 part	\N	2	2026-04-23 16:06:22.109926+00
156	39	61	1 part	\N	3	2026-04-23 16:06:22.109926+00
157	40	54	1 part	\N	1	2026-04-23 16:06:22.109926+00
158	40	38	1 part	\N	2	2026-04-23 16:06:22.109926+00
159	40	160	1 part	\N	3	2026-04-23 16:06:22.109926+00
160	40	61	1 part	\N	4	2026-04-23 16:06:22.109926+00
161	41	59	1 part	\N	1	2026-04-23 16:06:39.257018+00
162	41	126	1 part	\N	2	2026-04-23 16:06:39.257018+00
163	41	140	1 part	\N	3	2026-04-23 16:06:39.257018+00
164	41	108	1 part	\N	4	2026-04-23 16:06:39.257018+00
165	42	199	24 parts	tincture	1	2026-04-23 16:06:39.257018+00
166	42	338	24 parts	tincture	2	2026-04-23 16:06:39.257018+00
167	42	132	12 parts	tincture	3	2026-04-23 16:06:39.257018+00
168	42	140	12 parts	tincture	4	2026-04-23 16:06:39.257018+00
169	42	78	12 parts	tincture	5	2026-04-23 16:06:39.257018+00
170	42	131	12 parts	tincture	6	2026-04-23 16:06:39.257018+00
171	42	448	10 parts	tincture	7	2026-04-23 16:06:39.257018+00
172	42	108	1 part	essential oil	8	2026-04-23 16:06:39.257018+00
173	43	28	1 part	\N	1	2026-04-23 16:06:39.257018+00
174	43	42	1 part	\N	2	2026-04-23 16:06:39.257018+00
175	43	43	1 part	\N	3	2026-04-23 16:06:39.257018+00
176	44	38	1 part	\N	1	2026-04-23 16:06:39.257018+00
177	44	54	1 part	\N	2	2026-04-23 16:06:39.257018+00
178	45	57	1 part	\N	1	2026-04-23 16:06:49.507222+00
179	45	55	1 part	\N	2	2026-04-23 16:06:49.507222+00
180	45	44	1 part	\N	3	2026-04-23 16:06:49.507222+00
181	46	116	1 tablespoon powder	\N	1	2026-04-23 16:06:49.507222+00
182	47	84	handful	flowers	1	2026-04-23 16:06:49.507222+00
183	48	84	1 part	flowers	1	2026-04-23 16:06:49.507222+00
184	48	59	1 part	herb	2	2026-04-23 16:06:49.507222+00
185	48	406	1 part	herb	3	2026-04-23 16:06:49.507222+00
186	49	407	essential oil	\N	1	2026-04-23 16:06:49.507222+00
187	49	99	essential oil	\N	2	2026-04-23 16:06:49.507222+00
189	49	82	essential oil	\N	4	2026-04-23 16:06:49.507222+00
190	49	302	essential oil	\N	5	2026-04-23 16:06:49.507222+00
191	49	410	essential oil	\N	6	2026-04-23 16:06:49.507222+00
192	49	55	essential oil	\N	7	2026-04-23 16:06:49.507222+00
193	49	420	essential oil	\N	8	2026-04-23 16:06:49.507222+00
194	49	107	essential oil	\N	9	2026-04-23 16:06:49.507222+00
195	49	412	essential oil	\N	10	2026-04-23 16:06:49.507222+00
196	49	109	essential oil	\N	11	2026-04-23 16:06:49.507222+00
197	49	413	essential oil	\N	12	2026-04-23 16:06:49.507222+00
198	49	414	essential oil	\N	13	2026-04-23 16:06:49.507222+00
199	49	59	essential oil	\N	14	2026-04-23 16:06:49.507222+00
200	50	124	1 ounce	fresh, sliced	1	2026-04-23 16:06:49.507222+00
202	50	100	1 teaspoon	seeds	3	2026-04-23 16:06:49.507222+00
203	50	111	3	\N	4	2026-04-23 16:06:49.507222+00
204	50	535	1 slice		5	2026-04-23 16:06:49.507222+00
205	51	30	1 part	\N	1	2026-04-23 16:07:01.735818+00
206	51	26	1 part	\N	2	2026-04-23 16:07:01.735818+00
207	51	50	infusion		3	2026-04-23 16:07:01.735818+00
208	52	448	1 part	\N	1	2026-04-23 16:07:11.301036+00
209	52	30	1 part	\N	2	2026-04-23 16:07:11.301036+00
210	52	51	1 part	\N	3	2026-04-23 16:07:11.301036+00
211	52	43	2 parts	\N	4	2026-04-23 16:07:11.301036+00
212	52	58	2 parts	\N	5	2026-04-23 16:07:11.301036+00
213	53	84	essential oil	\N	1	2026-04-23 16:07:11.301036+00
214	53	134	essential oil	\N	2	2026-04-23 16:07:11.301036+00
215	53	82	essential oil	\N	3	2026-04-23 16:07:11.301036+00
216	54	58	1 part	\N	1	2026-04-23 16:07:11.301036+00
217	54	57	1 part	\N	2	2026-04-23 16:07:11.301036+00
218	54	26	1 part	\N	3	2026-04-23 16:07:11.301036+00
219	54	23	1 part	\N	4	2026-04-23 16:07:11.301036+00
220	55	414	30 ml	Compound tincture	1	2026-04-23 16:07:11.301036+00
222	55	55	6 drops	essential oil	3	2026-04-23 16:07:11.301036+00
223	55	82	5 drops	essential oil	4	2026-04-23 16:07:11.301036+00
224	55	469	5 drops	essential oil	5	2026-04-23 16:07:11.301036+00
225	56	28	2 parts	\N	1	2026-04-23 16:07:11.301036+00
226	56	26	2 parts	\N	2	2026-04-23 16:07:11.301036+00
227	56	23	1 part	\N	3	2026-04-23 16:07:11.301036+00
228	56	70	1 part	\N	4	2026-04-23 16:07:11.301036+00
229	57	61	3 parts	\N	1	2026-04-23 16:07:11.301036+00
230	57	132	1 part	\N	2	2026-04-23 16:07:11.301036+00
231	58	142	1 part	\N	10	2026-04-30 16:30:20.373726+00
232	58	145	1 part	\N	20	2026-04-30 16:30:20.373726+00
233	59	142	2 parts	\N	10	2026-04-30 16:30:20.373726+00
234	59	145	2 parts	\N	20	2026-04-30 16:30:20.373726+00
235	59	131	1 part	\N	30	2026-04-30 16:30:20.373726+00
236	59	84	1 part	\N	40	2026-04-30 16:30:20.373726+00
237	59	115	1 part	\N	50	2026-04-30 16:30:20.373726+00
238	60	142	1 part	\N	10	2026-04-30 16:30:20.373726+00
239	60	138	1 part	\N	20	2026-04-30 16:30:20.373726+00
240	61	84	strong infusion	topical compress	10	2026-04-30 16:30:20.373726+00
241	62	81	2 parts	\N	10	2026-04-30 16:30:20.373726+00
242	62	178	1 part	\N	20	2026-04-30 16:30:20.373726+00
243	62	115	1 part	\N	30	2026-04-30 16:30:20.373726+00
244	63	137	1 part	\N	10	2026-04-30 16:30:20.373726+00
245	63	145	1 part	\N	20	2026-04-30 16:30:20.373726+00
246	64	137	1 part	\N	10	2026-04-30 16:30:20.373726+00
247	64	145	1 part	\N	20	2026-04-30 16:30:20.373726+00
248	64	131	1 part	\N	30	2026-04-30 16:30:20.373726+00
249	65	137	1 part	\N	10	2026-04-30 16:30:20.373726+00
250	65	145	1 part	\N	20	2026-04-30 16:30:20.373726+00
251	65	115	1 part	\N	30	2026-04-30 16:30:20.373726+00
252	65	134	1 part	\N	40	2026-04-30 16:30:20.373726+00
253	66	137	1 part	\N	10	2026-04-30 16:30:20.373726+00
254	66	145	1 part	\N	20	2026-04-30 16:30:20.373726+00
255	66	81	1 part	\N	30	2026-04-30 16:30:20.373726+00
256	66	115	1 part	\N	40	2026-04-30 16:30:20.373726+00
257	67	82	3 drops oil	\N	10	2026-04-30 16:30:20.373726+00
258	67	742	3 drops oil	\N	20	2026-04-30 16:30:20.373726+00
259	67	743	2 drops oil	\N	30	2026-04-30 16:30:20.373726+00
261	67	745	2 drops oil	\N	50	2026-04-30 16:30:20.373726+00
262	67	84	1 drop oil	\N	60	2026-04-30 16:30:20.373726+00
263	68	82	25 drops oil	\N	10	2026-04-30 16:30:20.373726+00
264	68	748	10 drops oil	\N	20	2026-04-30 16:30:20.373726+00
265	68	84	8 drops oil	\N	30	2026-04-30 16:30:20.373726+00
267	68	745	6 drops oil	\N	50	2026-04-30 16:30:20.373726+00
268	69	178	2 parts	\N	10	2026-04-30 16:30:34.395192+00
269	69	142	2 parts	\N	20	2026-04-30 16:30:34.395192+00
270	69	145	2 parts	\N	30	2026-04-30 16:30:34.395192+00
271	69	131	1 part	\N	40	2026-04-30 16:30:34.395192+00
272	69	9	1 part	\N	50	2026-04-30 16:30:34.395192+00
273	70	102	1 part	\N	10	2026-04-30 16:30:34.395192+00
274	70	178	1 part	\N	20	2026-04-30 16:30:34.395192+00
275	70	81	1 part	\N	30	2026-04-30 16:30:34.395192+00
276	70	146	1 part	\N	40	2026-04-30 16:30:34.395192+00
277	71	82	essential oil	\N	10	2026-04-30 16:30:34.395192+00
278	71	109	essential oil	\N	20	2026-04-30 16:30:34.395192+00
279	71	55	essential oil	\N	30	2026-04-30 16:30:34.395192+00
280	72	115	as needed	\N	10	2026-04-30 16:30:34.395192+00
281	72	178	as needed	\N	20	2026-04-30 16:30:34.395192+00
282	72	84	as needed	\N	30	2026-04-30 16:30:34.395192+00
283	72	134	as needed	\N	40	2026-04-30 16:30:34.395192+00
284	72	138	as needed	\N	50	2026-04-30 16:30:34.395192+00
285	72	142	as needed	\N	60	2026-04-30 16:30:34.395192+00
286	72	90	as needed	\N	70	2026-04-30 16:30:34.395192+00
287	72	146	as needed	\N	80	2026-04-30 16:30:34.395192+00
288	73	142	2 parts	\N	10	2026-04-30 16:30:34.395192+00
289	73	145	2 parts	\N	20	2026-04-30 16:30:34.395192+00
290	73	178	1 part	\N	30	2026-04-30 16:30:34.395192+00
291	74	142	2 parts	\N	10	2026-04-30 16:30:34.395192+00
292	74	145	2 parts	\N	20	2026-04-30 16:30:34.395192+00
293	74	131	1 part	\N	30	2026-04-30 16:30:34.395192+00
294	74	84	1 part	\N	40	2026-04-30 16:30:34.395192+00
295	74	115	1 part	\N	50	2026-04-30 16:30:34.395192+00
296	75	82	3 drops oil	\N	10	2026-04-30 16:30:34.395192+00
297	75	742	3 drops oil	\N	20	2026-04-30 16:30:34.395192+00
299	75	745	2 drops oil	\N	40	2026-04-30 16:30:34.395192+00
300	75	84	1 drop oil	\N	50	2026-04-30 16:30:34.395192+00
301	75	743	1 drop oil	\N	60	2026-04-30 16:30:34.395192+00
302	76	121	125 mg dried herb daily	\N	10	2026-04-30 16:30:46.287227+00
304	77	73	1 part	\N	10	2026-04-30 16:30:46.287227+00
305	77	90	1 part	\N	20	2026-04-30 16:30:46.287227+00
307	77	142	1 part	\N	40	2026-04-30 16:30:46.287227+00
308	77	93	1 part	\N	50	2026-04-30 16:30:46.287227+00
309	78	55	2 drops essential oil	\N	10	2026-04-30 16:30:46.287227+00
310	78	124	1 drop essential oil	\N	20	2026-04-30 16:30:46.287227+00
312	79	81	1 part	\N	10	2026-04-30 16:30:46.287227+00
313	79	142	1 part	\N	20	2026-04-30 16:30:46.287227+00
314	79	178	1 part	\N	30	2026-04-30 16:30:46.287227+00
315	79	9	1 part	\N	40	2026-04-30 16:30:46.287227+00
316	80	55	essential oil	or any menthol-rich mint oil	10	2026-04-30 16:30:46.287227+00
317	80	81	infused oil	topical application	20	2026-04-30 16:30:46.287227+00
318	80	178	colloidal oatmeal	dry lubricant on skin	30	2026-04-30 16:30:46.287227+00
319	81	831	5 drops	\N	10	2026-04-30 16:30:46.287227+00
320	81	84	3 drops	\N	20	2026-04-30 16:30:46.287227+00
322	81	82	2 drops	\N	40	2026-04-30 16:30:46.287227+00
323	82	25	1 part	\N	10	2026-04-30 16:30:46.287227+00
324	82	30	1 part	\N	20	2026-04-30 16:30:46.287227+00
325	82	165	1 part	\N	30	2026-04-30 16:30:46.287227+00
326	83	212	1 part	\N	10	2026-04-30 16:30:46.287227+00
327	83	55	1 part	\N	20	2026-04-30 16:30:46.287227+00
328	84	178	1 part	\N	10	2026-04-30 16:30:46.287227+00
329	84	81	1 part	\N	20	2026-04-30 16:30:46.287227+00
330	84	26	1 part	\N	30	2026-04-30 16:30:46.287227+00
331	84	142	1 part	\N	40	2026-04-30 16:30:46.287227+00
201	50	167	1 stick	broken	2	2026-04-23 16:06:49.507222+00
132	35	101	essential oil	\N	2	2026-04-23 16:06:07.589513+00
188	49	101	essential oil	\N	3	2026-04-23 16:06:49.507222+00
221	55	101	2.5 ml	essential oil	2	2026-04-23 16:07:11.301036+00
303	76	82	massage essential oil	\N	20	2026-04-30 16:30:46.287227+00
260	67	107	2 drops oil	\N	40	2026-04-30 16:30:20.373726+00
266	68	107	8 drops oil	\N	40	2026-04-30 16:30:20.373726+00
298	75	107	2 drops oil	\N	30	2026-04-30 16:30:34.395192+00
311	78	107	1 drop essential oil	\N	30	2026-04-30 16:30:46.287227+00
321	81	107	2 drops	\N	30	2026-04-30 16:30:46.287227+00
306	77	207	1 part	\N	30	2026-04-30 16:30:46.287227+00
332	85	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
333	85	90	1 part	\N	20	2026-05-17 19:20:07.593885+00
334	85	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
335	85	93	1 part	\N	40	2026-05-17 19:20:07.593885+00
336	85	145	1 part	\N	50	2026-05-17 19:20:07.593885+00
337	86	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
338	86	90	1 part	\N	20	2026-05-17 19:20:07.593885+00
339	86	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
340	86	9	1 part	\N	40	2026-05-17 19:20:07.593885+00
341	86	142	1 part	\N	50	2026-05-17 19:20:07.593885+00
342	86	93	1 part	\N	60	2026-05-17 19:20:07.593885+00
343	86	145	1 part	\N	70	2026-05-17 19:20:07.593885+00
344	87	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
345	87	892	2 parts	\N	20	2026-05-17 19:20:07.593885+00
346	87	90	1 part	\N	30	2026-05-17 19:20:07.593885+00
347	87	44	1 part	\N	40	2026-05-17 19:20:07.593885+00
348	87	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
349	88	131	2 parts	\N	10	2026-05-17 19:20:07.593885+00
350	88	73	2 parts	\N	20	2026-05-17 19:20:07.593885+00
351	88	90	1 part	\N	30	2026-05-17 19:20:07.593885+00
352	88	44	1 part	\N	40	2026-05-17 19:20:07.593885+00
353	88	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
354	89	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
355	89	90	1 part	\N	20	2026-05-17 19:20:07.593885+00
356	89	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
357	89	93	1 part	\N	40	2026-05-17 19:20:07.593885+00
358	89	115	1 part	\N	50	2026-05-17 19:20:07.593885+00
359	90	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
360	90	84	2 parts	\N	20	2026-05-17 19:20:07.593885+00
361	90	90	1 part	\N	30	2026-05-17 19:20:07.593885+00
362	90	44	1 part	\N	40	2026-05-17 19:20:07.593885+00
363	90	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
364	90	145	1 part	\N	60	2026-05-17 19:20:07.593885+00
365	91	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
366	91	90	1 part	\N	20	2026-05-17 19:20:07.593885+00
367	91	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
368	91	160	1 part	\N	40	2026-05-17 19:20:07.593885+00
369	91	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
370	91	61	1 part	\N	60	2026-05-17 19:20:07.593885+00
371	92	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
372	92	90	1 part	\N	20	2026-05-17 19:20:07.593885+00
373	92	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
374	92	142	1 part	\N	40	2026-05-17 19:20:07.593885+00
375	92	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
376	92	145	1 part	\N	60	2026-05-17 19:20:07.593885+00
377	92	190	1 part	\N	70	2026-05-17 19:20:07.593885+00
378	93	73	2 parts	\N	10	2026-05-17 19:20:07.593885+00
379	93	90	1 part	\N	20	2026-05-17 19:20:07.593885+00
380	93	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
381	93	93	1 part	\N	40	2026-05-17 19:20:07.593885+00
382	93	165	1 part	\N	50	2026-05-17 19:20:07.593885+00
383	94	73	3 parts	\N	10	2026-05-17 19:20:07.593885+00
384	94	165	1 part	\N	20	2026-05-17 19:20:07.593885+00
385	94	90	1 part	\N	30	2026-05-17 19:20:07.593885+00
386	94	122	1 part	\N	40	2026-05-17 19:20:07.593885+00
387	94	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
388	94	145	1 part	\N	60	2026-05-17 19:20:07.593885+00
389	95	73	3 parts	\N	10	2026-05-17 19:20:07.593885+00
390	95	131	2 parts	\N	20	2026-05-17 19:20:07.593885+00
391	95	44	1 part	\N	30	2026-05-17 19:20:07.593885+00
392	95	90	1 part	\N	40	2026-05-17 19:20:07.593885+00
393	95	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
394	95	165	1 part	\N	60	2026-05-17 19:20:07.593885+00
395	96	73	1 part	\N	10	2026-05-17 19:20:07.593885+00
396	96	62	1 part	\N	20	2026-05-17 19:20:07.593885+00
397	96	165	1 part	\N	30	2026-05-17 19:20:07.593885+00
398	96	123	1 part	\N	40	2026-05-17 19:20:07.593885+00
399	96	93	1 part	\N	50	2026-05-17 19:20:07.593885+00
400	97	73	1 part	\N	10	2026-05-17 19:20:07.593885+00
401	97	123	1 part	\N	20	2026-05-17 19:20:07.593885+00
402	97	165	1 part	\N	30	2026-05-17 19:20:07.593885+00
403	97	44	1 part	\N	40	2026-05-17 19:20:07.593885+00
404	97	62	1 part	\N	50	2026-05-17 19:20:07.593885+00
405	98	79	distilled, 80 ml	\N	10	2026-05-17 19:20:07.593885+00
406	98	62	tincture, 10 ml	\N	20	2026-05-17 19:20:07.593885+00
407	98	89	tincture, 10 ml	\N	30	2026-05-17 19:20:07.593885+00
414	101	72	2 parts	\N	10	2026-06-07 19:28:17.415064+00
415	101	115	2 parts	\N	20	2026-06-07 19:28:17.415064+00
416	101	190	1 part	\N	30	2026-06-07 19:28:17.415064+00
417	102	25	2 parts	\N	10	2026-06-07 19:28:17.415064+00
418	102	146	2 parts	\N	20	2026-06-07 19:28:17.415064+00
419	102	190	1 part	\N	30	2026-06-07 19:28:17.415064+00
420	103	94	1 part	\N	10	2026-06-07 19:28:17.415064+00
421	103	142	1 part	\N	20	2026-06-07 19:28:17.415064+00
422	103	25	1 part	\N	30	2026-06-07 19:28:17.415064+00
423	104	94	1 part	\N	10	2026-06-07 19:28:17.415064+00
424	104	74	1 part	\N	20	2026-06-07 19:28:17.415064+00
425	104	25	1 part	\N	30	2026-06-07 19:28:17.415064+00
426	105	142	2 parts	\N	10	2026-06-07 19:28:17.415064+00
427	105	145	1 part	\N	20	2026-06-07 19:28:17.415064+00
428	105	122	leaf, 1 part	\N	30	2026-06-07 19:28:17.415064+00
429	106	190	2 parts	\N	10	2026-06-07 19:28:17.415064+00
430	106	25	1 part	\N	20	2026-06-07 19:28:17.415064+00
431	107	142	2 parts	\N	10	2026-06-07 19:28:17.415064+00
432	107	36	1 part	\N	20	2026-06-07 19:28:17.415064+00
433	107	28	1 part	\N	30	2026-06-07 19:28:17.415064+00
434	107	122	leaf, 1 part	\N	40	2026-06-07 19:28:17.415064+00
435	108	190	2 parts	\N	10	2026-06-07 19:28:17.415064+00
436	108	81	1 part	\N	20	2026-06-07 19:28:17.415064+00
437	108	25	1 part	\N	30	2026-06-07 19:28:17.415064+00
438	109	190	2 parts	\N	10	2026-06-07 19:28:17.415064+00
439	109	131	2 parts	\N	20	2026-06-07 19:28:17.415064+00
440	109	81	1 part	\N	30	2026-06-07 19:28:17.415064+00
441	109	25	1 part	\N	40	2026-06-07 19:28:17.415064+00
442	110	94	1 part	\N	10	2026-06-07 19:28:17.415064+00
443	110	25	1 part	\N	20	2026-06-07 19:28:17.415064+00
444	111	124	1 part	\N	10	2026-06-07 19:28:17.415064+00
445	111	74	1 part	\N	20	2026-06-07 19:28:17.415064+00
446	111	212	1 part	\N	30	2026-06-07 19:28:17.415064+00
447	112	55	1 part	\N	10	2026-06-07 19:28:17.415064+00
448	112	84	1 part	\N	20	2026-06-07 19:28:17.415064+00
449	113	72	2 parts	\N	10	2026-06-07 19:28:17.415064+00
450	113	157	2 parts	\N	20	2026-06-07 19:28:17.415064+00
451	113	190	1 part	\N	30	2026-06-07 19:28:17.415064+00
452	113	25	1 part	\N	40	2026-06-07 19:28:17.415064+00
453	113	74	1 part	\N	50	2026-06-07 19:28:17.415064+00
454	113	28	1 part	\N	60	2026-06-07 19:28:17.415064+00
455	114	190	2 parts	\N	10	2026-06-07 19:28:17.415064+00
456	114	25	1 part	\N	20	2026-06-07 19:28:17.415064+00
457	114	74	1 part	\N	30	2026-06-07 19:28:17.415064+00
458	114	142	1 part	\N	40	2026-06-07 19:28:17.415064+00
459	115	190	2 parts	\N	10	2026-06-07 19:28:17.415064+00
460	115	28	1 part	\N	20	2026-06-07 19:28:17.415064+00
461	115	142	1 part	\N	30	2026-06-07 19:28:17.415064+00
462	116	186	2 parts	\N	10	2026-06-07 19:28:17.415064+00
463	116	296	2 parts	\N	20	2026-06-07 19:28:17.415064+00
464	116	40	1 part	\N	30	2026-06-07 19:28:17.415064+00
465	116	95	1 part	\N	40	2026-06-07 19:28:17.415064+00
466	116	46	1 part	\N	50	2026-06-07 19:28:17.415064+00
467	117	151	1 part	\N	10	2026-06-07 19:28:17.415064+00
468	117	179	1 part	\N	20	2026-06-07 19:28:17.415064+00
469	117	46	1 part	\N	30	2026-06-07 19:28:17.415064+00
480	122	95	2 parts	\N	10	2026-06-21 16:44:38.744675+00
481	122	46	1 part	\N	20	2026-06-21 16:44:38.744675+00
482	123	94	1 part	\N	10	2026-06-21 16:44:38.744675+00
483	123	95	1 part	\N	20	2026-06-21 16:44:38.744675+00
484	123	46	1 part	\N	30	2026-06-21 16:44:38.744675+00
485	124	157	1 part	\N	10	2026-06-21 16:44:38.744675+00
486	124	71	1 part	\N	20	2026-06-21 16:44:38.744675+00
487	124	95	1 part	\N	30	2026-06-21 16:44:38.744675+00
488	124	44	1 part	\N	40	2026-06-21 16:44:38.744675+00
489	125	122		leaf	10	2026-06-21 16:44:38.744675+00
490	126	95	2 parts	\N	10	2026-06-21 16:44:38.744675+00
491	126	46	2 parts	\N	20	2026-06-21 16:44:38.744675+00
492	126	181	1 part	\N	30	2026-06-21 16:44:38.744675+00
493	127	95	2 parts	\N	10	2026-06-21 16:44:38.744675+00
494	127	46	2 parts	\N	20	2026-06-21 16:44:38.744675+00
495	127	94	1 part	\N	30	2026-06-21 16:44:38.744675+00
496	127	145	1 part	\N	40	2026-06-21 16:44:38.744675+00
497	128	45	2 parts	root	10	2026-06-21 16:44:38.744675+00
498	128	95	2 parts	\N	20	2026-06-21 16:44:38.744675+00
499	128	179	2 parts	\N	30	2026-06-21 16:44:38.744675+00
500	128	151	2 parts	\N	40	2026-06-21 16:44:38.744675+00
501	128	46	2 parts	\N	50	2026-06-21 16:44:38.744675+00
502	128	181	1 part	\N	60	2026-06-21 16:44:38.744675+00
503	129	182	1 part	\N	10	2026-06-21 16:44:38.744675+00
504	129	117	1 part	\N	20	2026-06-21 16:44:38.744675+00
505	129	95	1 part	\N	30	2026-06-21 16:44:38.744675+00
506	129	74	1 part	\N	40	2026-06-21 16:44:38.744675+00
507	129	94	1 part	\N	50	2026-06-21 16:44:38.744675+00
508	130	28	1 part	\N	10	2026-06-21 16:54:56.148727+00
509	130	43	1 part	\N	20	2026-06-21 16:54:56.148727+00
510	130	42	1 part	\N	30	2026-06-21 16:54:56.148727+00
511	131	28	1 part	\N	10	2026-06-21 16:54:56.148727+00
512	131	22	1 part	\N	20	2026-06-21 16:54:56.148727+00
513	131	39	1 part	\N	30	2026-06-21 16:54:56.148727+00
514	132	43	2 parts	\N	10	2026-06-21 16:54:56.148727+00
515	132	42	2 parts	\N	20	2026-06-21 16:54:56.148727+00
516	133	22	1 part	\N	10	2026-06-21 16:54:56.148727+00
517	133	37	1 part	\N	20	2026-06-21 16:54:56.148727+00
518	133	28	1 part	\N	30	2026-06-21 16:54:56.148727+00
519	133	142	1 part	\N	40	2026-06-21 16:54:56.148727+00
520	134	22	1 part	\N	10	2026-06-21 16:54:56.148727+00
521	134	37	1 part	\N	20	2026-06-21 16:54:56.148727+00
522	134	28	1 part	\N	30	2026-06-21 16:54:56.148727+00
523	134	145	1 part	\N	40	2026-06-21 16:54:56.148727+00
524	134	146	1 part	\N	50	2026-06-21 16:54:56.148727+00
525	135	22	2 parts	\N	10	2026-06-21 16:54:56.148727+00
526	135	37	2 parts	\N	20	2026-06-21 16:54:56.148727+00
527	135	40	2 parts	\N	30	2026-06-21 16:54:56.148727+00
528	135	35	1 part	\N	40	2026-06-21 16:54:56.148727+00
529	135	145	1 part	\N	50	2026-06-21 16:54:56.148727+00
530	136	22	2 parts	\N	10	2026-06-21 16:54:56.148727+00
531	136	37	2 parts	\N	20	2026-06-21 16:54:56.148727+00
532	136	28	2 parts	\N	30	2026-06-21 16:54:56.148727+00
533	136	145	1 part	\N	40	2026-06-21 16:54:56.148727+00
534	136	73	1 part	\N	50	2026-06-21 16:54:56.148727+00
535	136	90	1 part	\N	60	2026-06-21 16:54:56.148727+00
536	136	44	1 part	\N	70	2026-06-21 16:54:56.148727+00
537	137	31	1 part	\N	10	2026-06-21 16:54:56.148727+00
538	137	22	1 part	\N	20	2026-06-21 16:54:56.148727+00
539	137	26	1 part	\N	30	2026-06-21 16:54:56.148727+00
540	137	28	1 part	\N	40	2026-06-21 16:54:56.148727+00
\.


--
-- Data for Name: primary_actions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.primary_actions (id, name, description, created_at) FROM stdin;
3	Anticatarrhal	\N	2026-03-22 21:15:28.838092+00
4	Anti-inflammatory	\N	2026-03-22 21:15:28.838092+00
5	Antimicrobial	\N	2026-03-22 21:15:28.838092+00
6	Antirheumatic	\N	2026-03-22 21:15:28.838092+00
7	Antispasmodic	\N	2026-03-22 21:15:28.838092+00
8	Astringent	\N	2026-03-22 21:15:28.838092+00
9	Bitter	\N	2026-03-22 21:15:28.838092+00
10	Cardiotonic	\N	2026-03-22 21:15:28.838092+00
11	Carminative	\N	2026-03-22 21:15:28.838092+00
12	Cholagogue	\N	2026-03-22 21:15:28.838092+00
13	Demulcent	\N	2026-03-22 21:15:28.838092+00
14	Diuretic	\N	2026-03-22 21:15:28.838092+00
15	Emmenagogue	\N	2026-03-22 21:15:28.838092+00
16	Stimulating Expectorant	\N	2026-03-22 21:15:28.838092+00
17	Relaxing Expectorant	\N	2026-03-22 21:15:28.838092+00
18	Amphoteric Expectorant	\N	2026-03-22 21:15:28.838092+00
19	Hepatic	\N	2026-03-22 21:15:28.838092+00
20	Hypnotic	\N	2026-03-22 21:15:28.838092+00
21	Hypotensive	\N	2026-03-22 21:15:28.838092+00
24	Nervine Stimulant	\N	2026-03-22 21:15:28.838092+00
1	Adaptogen	\N	2026-03-22 21:15:28.838092+00
2	Alterative	\N	2026-03-22 21:15:28.838092+00
22	Nervine Tonic	\N	2026-03-22 21:15:28.838092+00
23	Nervine Relaxant	\N	2026-03-22 21:15:28.838092+00
25	Immune Support	\N	2026-04-06 21:33:58.34407+00
26	Nervine	\N	2026-04-06 21:33:58.34407+00
27	Lymphatic	\N	2026-04-06 21:33:58.34407+00
28	Vulnerary	\N	2026-04-06 21:33:58.34407+00
29	Circulatory Stimulant	\N	2026-04-06 21:33:58.34407+00
30	Antacid	\N	2026-04-06 21:33:58.34407+00
31	Aperient	\N	2026-04-06 21:56:12.487259+00
32	Eliminative Support	\N	2026-04-06 21:56:12.487259+00
33	Tonic	\N	2026-04-06 21:56:27.332838+00
34	Antipruritic	\N	2026-04-06 21:56:27.332838+00
35	Antihepatotoxic	\N	2026-04-06 21:56:27.332838+00
36	Antidepressant	\N	2026-04-06 21:56:27.332838+00
37	Antioxidant	\N	2026-04-06 21:56:27.332838+00
38	Antiviral	\N	2026-04-06 21:56:27.332838+00
39	Detoxifying	\N	2026-04-06 21:56:27.332838+00
40	Immunostimulant	\N	2026-04-06 21:56:27.332838+00
41	Antilithic	\N	2026-04-06 21:56:27.332838+00
42	Vascular Tonic	\N	2026-04-06 21:56:27.332838+00
43	Laxative	\N	2026-04-06 21:56:27.332838+00
44	Emollient	\N	2026-04-06 21:56:27.332838+00
47	Immunomodulator	\N	2026-04-10 20:55:36.403551+00
51	Diaphoretic	\N	2026-04-10 20:55:36.403551+00
53	Expectorant	\N	2026-04-10 20:55:36.403551+00
55	Lymphatic tonic	\N	2026-04-10 20:55:36.403551+00
73	Prostate tonic	\N	2026-04-10 20:58:36.064973+00
90	Pulmonary tonic	\N	2026-04-23 16:05:55.110389+00
167	Analgesic	\N	2026-04-23 16:07:11.301036+00
169	Digestive support	\N	2026-04-23 16:07:11.301036+00
181	Soothing	\N	2026-04-25 23:10:59.300366+00
197	Circulatory Tonic	\N	2026-04-25 23:10:59.300366+00
201	Antitussive	\N	2026-04-25 23:10:59.300366+00
222	Pectoral Relaxant	\N	2026-04-25 23:10:59.300366+00
388	Cardioactive	\N	2026-05-17 19:20:07.593885+00
390	Peripheral vasodilator	\N	2026-05-17 19:20:07.593885+00
392	Hypertensive	\N	2026-05-17 19:20:07.593885+00
509	Uterine tonic	\N	2026-06-07 19:28:17.415064+00
510	Hormonal normalizer	\N	2026-06-07 19:28:17.415064+00
511	Uterine astringent	\N	2026-06-07 19:28:17.415064+00
512	Uterine demulcent	\N	2026-06-07 19:28:17.415064+00
524	Nervine relaxant	\N	2026-06-07 19:28:17.415064+00
576	Nervine tonic	\N	2026-06-07 19:28:17.415064+00
590	Antiemetic	\N	2026-06-07 19:28:17.415064+00
596	Immune support	\N	2026-06-07 19:28:17.415064+00
\.


--
-- Data for Name: secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.secondary_actions (id, name, created_at) FROM stdin;
35	Anticatarrhal	2026-03-22 21:15:28.855694+00
36	Anti-inflammatory	2026-03-22 21:15:28.855694+00
37	Antimicrobial	2026-03-22 21:15:28.855694+00
38	Antispasmodic	2026-03-22 21:15:28.855694+00
39	Astringent	2026-03-22 21:15:28.855694+00
40	Bitter	2026-03-22 21:15:28.855694+00
41	Diaphoretic	2026-03-22 21:15:28.855694+00
42	Diuretic	2026-03-22 21:15:28.855694+00
43	Emmenagogue	2026-03-22 21:15:28.855694+00
44	Expectorant	2026-03-22 21:15:28.855694+00
45	Hepatic	2026-03-22 21:15:28.855694+00
46	Hypotensive	2026-03-22 21:15:28.855694+00
47	Nervine	2026-03-22 21:15:28.855694+00
48	Vulnerary	2026-03-22 21:15:28.855694+00
49	Alterative	2026-03-22 21:15:28.855694+00
50	Carminative	2026-03-22 21:15:28.855694+00
51	Demulcent	2026-03-22 21:15:28.855694+00
52	Laxative	2026-03-22 21:15:28.855694+00
53	Tonic	2026-03-22 21:15:28.855694+00
54	Cholagogue	2026-03-22 21:15:28.855694+00
55	Circulatory stimulant	2026-03-22 21:15:28.855694+00
56	Other action (or basis unclear)	2026-03-22 21:15:28.855694+00
57	Analgesic	2026-03-22 21:15:28.855694+00
58	Hypnotic	2026-03-22 21:15:28.855694+00
59	Nervine relaxant	2026-03-22 21:15:28.855694+00
60	Galactagogue	2026-03-22 21:15:28.855694+00
61	Rubefacient	2026-03-22 21:15:28.855694+00
62	Cardioactive	2026-03-22 21:15:28.855694+00
64	Adaptogen	2026-03-22 21:15:28.855694+00
65	Cardiotonic	2026-03-22 21:15:28.855694+00
67	Relaxant	2026-04-30 16:29:43.150631+00
68	Stimulant	2026-04-30 16:29:43.150631+00
72	Antidepressant	2026-04-30 16:29:43.150631+00
\.


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.action_descriptions_id_seq', 301, true);


--
-- Name: body_system_notes_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.body_system_notes_id_seq', 157, true);


--
-- Name: body_systems_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.body_systems_id_seq', 29, true);


--
-- Name: constituents_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.constituents_id_seq', 1133, true);


--
-- Name: disorder_action_herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_action_herbs_id_seq', 403, true);


--
-- Name: disorder_actions_indicated_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_actions_indicated_id_seq', 369, true);


--
-- Name: disorder_notes_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_notes_id_seq', 339, true);


--
-- Name: disorder_prescriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_prescriptions_id_seq', 137, true);


--
-- Name: disorder_specific_remedies_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_specific_remedies_id_seq', 448, true);


--
-- Name: disorders_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorders_id_seq', 138, true);


--
-- Name: herb_constituents_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herb_constituents_id_seq', 1277, true);


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herb_primary_actions_id_seq', 1804, true);


--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herb_secondary_actions_id_seq', 1598, true);


--
-- Name: herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herbs_id_seq', 1504, true);


--
-- Name: prescription_herb_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.prescription_herb_actions_id_seq', 561, true);


--
-- Name: prescription_herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.prescription_herbs_id_seq', 540, true);


--
-- Name: primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.primary_actions_id_seq', 897, true);


--
-- Name: secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.secondary_actions_id_seq', 73, true);


--
-- Name: action_descriptions action_descriptions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.action_descriptions
    ADD CONSTRAINT action_descriptions_pkey PRIMARY KEY (id);


--
-- Name: aging_herbs aging_herbs_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.aging_herbs
    ADD CONSTRAINT aging_herbs_pkey PRIMARY KEY (herb_id);


--
-- Name: body_system_notes body_system_notes_body_system_id_sort_order_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_system_notes
    ADD CONSTRAINT body_system_notes_body_system_id_sort_order_key UNIQUE (body_system_id, sort_order);


--
-- Name: body_system_notes body_system_notes_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_system_notes
    ADD CONSTRAINT body_system_notes_pkey PRIMARY KEY (id);


--
-- Name: body_systems body_systems_name_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_systems
    ADD CONSTRAINT body_systems_name_key UNIQUE (name);


--
-- Name: body_systems body_systems_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_systems
    ADD CONSTRAINT body_systems_pkey PRIMARY KEY (id);


--
-- Name: constituents constituents_name_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.constituents
    ADD CONSTRAINT constituents_name_key UNIQUE (name);


--
-- Name: constituents constituents_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.constituents
    ADD CONSTRAINT constituents_pkey PRIMARY KEY (id);


--
-- Name: disorder_action_herbs disorder_action_herbs_disorder_id_herb_id_primary_action_id_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_action_herbs
    ADD CONSTRAINT disorder_action_herbs_disorder_id_herb_id_primary_action_id_key UNIQUE (disorder_id, herb_id, primary_action_id);


--
-- Name: disorder_action_herbs disorder_action_herbs_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_action_herbs
    ADD CONSTRAINT disorder_action_herbs_pkey PRIMARY KEY (id);


--
-- Name: disorder_actions_indicated disorder_actions_indicated_disorder_id_primary_action_id_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_actions_indicated
    ADD CONSTRAINT disorder_actions_indicated_disorder_id_primary_action_id_key UNIQUE (disorder_id, primary_action_id);


--
-- Name: disorder_actions_indicated disorder_actions_indicated_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_actions_indicated
    ADD CONSTRAINT disorder_actions_indicated_pkey PRIMARY KEY (id);


--
-- Name: disorder_notes disorder_notes_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_notes
    ADD CONSTRAINT disorder_notes_pkey PRIMARY KEY (id);


--
-- Name: disorder_prescriptions disorder_prescriptions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_prescriptions
    ADD CONSTRAINT disorder_prescriptions_pkey PRIMARY KEY (id);


--
-- Name: disorder_specific_remedies disorder_specific_remedies_disorder_id_herb_id_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_specific_remedies
    ADD CONSTRAINT disorder_specific_remedies_disorder_id_herb_id_key UNIQUE (disorder_id, herb_id);


--
-- Name: disorder_specific_remedies disorder_specific_remedies_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_specific_remedies
    ADD CONSTRAINT disorder_specific_remedies_pkey PRIMARY KEY (id);


--
-- Name: disorders disorders_name_body_system_id_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorders
    ADD CONSTRAINT disorders_name_body_system_id_key UNIQUE (name, body_system_id);


--
-- Name: disorders disorders_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorders
    ADD CONSTRAINT disorders_pkey PRIMARY KEY (id);


--
-- Name: herb_constituents herb_constituents_herb_id_constituent_id_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_constituents
    ADD CONSTRAINT herb_constituents_herb_id_constituent_id_key UNIQUE (herb_id, constituent_id);


--
-- Name: herb_constituents herb_constituents_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_constituents
    ADD CONSTRAINT herb_constituents_pkey PRIMARY KEY (id);


--
-- Name: herb_menstruum herb_menstruum_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_menstruum
    ADD CONSTRAINT herb_menstruum_pkey PRIMARY KEY (herb_id);


--
-- Name: herb_primary_actions herb_primary_actions_herb_id_primary_action_id_body_system__key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_herb_id_primary_action_id_body_system__key UNIQUE (herb_id, primary_action_id, body_system_id);


--
-- Name: herb_primary_actions herb_primary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_pkey PRIMARY KEY (id);


--
-- Name: herb_secondary_actions herb_secondary_actions_herb_id_secondary_action_id_body_system_; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_herb_id_secondary_action_id_body_system_ UNIQUE (herb_id, secondary_action_id, body_system_id);


--
-- Name: herb_secondary_actions herb_secondary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_pkey PRIMARY KEY (id);


--
-- Name: herbs herbs_latin_name_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herbs
    ADD CONSTRAINT herbs_latin_name_key UNIQUE (latin_name);


--
-- Name: herbs herbs_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herbs
    ADD CONSTRAINT herbs_pkey PRIMARY KEY (id);


--
-- Name: prescription_herb_actions prescription_herb_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herb_actions
    ADD CONSTRAINT prescription_herb_actions_pkey PRIMARY KEY (id);


--
-- Name: prescription_herb_actions prescription_herb_actions_prescription_herb_id_primary_acti_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herb_actions
    ADD CONSTRAINT prescription_herb_actions_prescription_herb_id_primary_acti_key UNIQUE (prescription_herb_id, primary_action_id);


--
-- Name: prescription_herbs prescription_herbs_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herbs
    ADD CONSTRAINT prescription_herbs_pkey PRIMARY KEY (id);


--
-- Name: primary_actions primary_actions_name_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.primary_actions
    ADD CONSTRAINT primary_actions_name_key UNIQUE (name);


--
-- Name: primary_actions primary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.primary_actions
    ADD CONSTRAINT primary_actions_pkey PRIMARY KEY (id);


--
-- Name: secondary_actions secondary_actions_name_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.secondary_actions
    ADD CONSTRAINT secondary_actions_name_key UNIQUE (name);


--
-- Name: secondary_actions secondary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.secondary_actions
    ADD CONSTRAINT secondary_actions_pkey PRIMARY KEY (id);


--
-- Name: herb_constituents_constituent_id_idx; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX herb_constituents_constituent_id_idx ON herbal.herb_constituents USING btree (constituent_id);


--
-- Name: herb_constituents_herb_id_idx; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX herb_constituents_herb_id_idx ON herbal.herb_constituents USING btree (herb_id);


--
-- Name: herb_constituents_level_idx; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX herb_constituents_level_idx ON herbal.herb_constituents USING btree (concentration_level);


--
-- Name: idx_action_descriptions_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_action_descriptions_action ON herbal.action_descriptions USING btree (primary_action_id);


--
-- Name: idx_body_system_notes_system; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_body_system_notes_system ON herbal.body_system_notes USING btree (body_system_id);


--
-- Name: idx_disorder_action_herbs_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_action_herbs_action ON herbal.disorder_action_herbs USING btree (primary_action_id);


--
-- Name: idx_disorder_action_herbs_disorder; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_action_herbs_disorder ON herbal.disorder_action_herbs USING btree (disorder_id);


--
-- Name: idx_disorder_action_herbs_herb; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_action_herbs_herb ON herbal.disorder_action_herbs USING btree (herb_id);


--
-- Name: idx_disorder_actions_indicated_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_actions_indicated_action ON herbal.disorder_actions_indicated USING btree (primary_action_id);


--
-- Name: idx_disorder_actions_indicated_disorder; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_actions_indicated_disorder ON herbal.disorder_actions_indicated USING btree (disorder_id);


--
-- Name: idx_disorder_notes_disorder; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_notes_disorder ON herbal.disorder_notes USING btree (disorder_id);


--
-- Name: idx_disorder_prescriptions_disorder; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_prescriptions_disorder ON herbal.disorder_prescriptions USING btree (disorder_id);


--
-- Name: idx_disorder_specific_remedies_disorder; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_specific_remedies_disorder ON herbal.disorder_specific_remedies USING btree (disorder_id);


--
-- Name: idx_disorder_specific_remedies_herb; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorder_specific_remedies_herb ON herbal.disorder_specific_remedies USING btree (herb_id);


--
-- Name: idx_disorders_body_system; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorders_body_system ON herbal.disorders USING btree (body_system_id);


--
-- Name: idx_disorders_name; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_disorders_name ON herbal.disorders USING btree (name);


--
-- Name: idx_herb_primary_actions_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herb_primary_actions_action ON herbal.herb_primary_actions USING btree (primary_action_id);


--
-- Name: idx_herb_primary_actions_herb; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herb_primary_actions_herb ON herbal.herb_primary_actions USING btree (herb_id);


--
-- Name: idx_herb_primary_actions_system; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herb_primary_actions_system ON herbal.herb_primary_actions USING btree (body_system_id);


--
-- Name: idx_herb_secondary_actions_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herb_secondary_actions_action ON herbal.herb_secondary_actions USING btree (secondary_action_id);


--
-- Name: idx_herb_secondary_actions_body_system; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herb_secondary_actions_body_system ON herbal.herb_secondary_actions USING btree (body_system_id);


--
-- Name: idx_herb_secondary_actions_herb; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herb_secondary_actions_herb ON herbal.herb_secondary_actions USING btree (herb_id);


--
-- Name: idx_herbs_common_name; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herbs_common_name ON herbal.herbs USING btree (common_name);


--
-- Name: idx_herbs_latin_name; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_herbs_latin_name ON herbal.herbs USING btree (latin_name);


--
-- Name: idx_prescription_herb_actions_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_prescription_herb_actions_action ON herbal.prescription_herb_actions USING btree (primary_action_id);


--
-- Name: idx_prescription_herb_actions_prescription_herb; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_prescription_herb_actions_prescription_herb ON herbal.prescription_herb_actions USING btree (prescription_herb_id);


--
-- Name: idx_prescription_herbs_herb; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_prescription_herbs_herb ON herbal.prescription_herbs USING btree (herb_id);


--
-- Name: idx_prescription_herbs_prescription; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_prescription_herbs_prescription ON herbal.prescription_herbs USING btree (prescription_id);


--
-- Name: action_descriptions action_descriptions_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.action_descriptions
    ADD CONSTRAINT action_descriptions_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: aging_herbs aging_herbs_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.aging_herbs
    ADD CONSTRAINT aging_herbs_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: body_system_notes body_system_notes_body_system_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_system_notes
    ADD CONSTRAINT body_system_notes_body_system_id_fkey FOREIGN KEY (body_system_id) REFERENCES herbal.body_systems(id) ON DELETE CASCADE;


--
-- Name: disorder_action_herbs disorder_action_herbs_disorder_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_action_herbs
    ADD CONSTRAINT disorder_action_herbs_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES herbal.disorders(id) ON DELETE CASCADE;


--
-- Name: disorder_action_herbs disorder_action_herbs_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_action_herbs
    ADD CONSTRAINT disorder_action_herbs_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: disorder_action_herbs disorder_action_herbs_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_action_herbs
    ADD CONSTRAINT disorder_action_herbs_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: disorder_actions_indicated disorder_actions_indicated_disorder_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_actions_indicated
    ADD CONSTRAINT disorder_actions_indicated_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES herbal.disorders(id) ON DELETE CASCADE;


--
-- Name: disorder_actions_indicated disorder_actions_indicated_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_actions_indicated
    ADD CONSTRAINT disorder_actions_indicated_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: disorder_notes disorder_notes_disorder_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_notes
    ADD CONSTRAINT disorder_notes_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES herbal.disorders(id) ON DELETE CASCADE;


--
-- Name: disorder_prescriptions disorder_prescriptions_disorder_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_prescriptions
    ADD CONSTRAINT disorder_prescriptions_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES herbal.disorders(id) ON DELETE CASCADE;


--
-- Name: disorder_specific_remedies disorder_specific_remedies_disorder_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_specific_remedies
    ADD CONSTRAINT disorder_specific_remedies_disorder_id_fkey FOREIGN KEY (disorder_id) REFERENCES herbal.disorders(id) ON DELETE CASCADE;


--
-- Name: disorder_specific_remedies disorder_specific_remedies_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorder_specific_remedies
    ADD CONSTRAINT disorder_specific_remedies_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: disorders disorders_body_system_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.disorders
    ADD CONSTRAINT disorders_body_system_id_fkey FOREIGN KEY (body_system_id) REFERENCES herbal.body_systems(id) ON DELETE CASCADE;


--
-- Name: herb_constituents herb_constituents_constituent_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_constituents
    ADD CONSTRAINT herb_constituents_constituent_id_fkey FOREIGN KEY (constituent_id) REFERENCES herbal.constituents(id) ON DELETE CASCADE;


--
-- Name: herb_constituents herb_constituents_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_constituents
    ADD CONSTRAINT herb_constituents_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: herb_menstruum herb_menstruum_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_menstruum
    ADD CONSTRAINT herb_menstruum_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: herb_primary_actions herb_primary_actions_body_system_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_body_system_id_fkey FOREIGN KEY (body_system_id) REFERENCES herbal.body_systems(id) ON DELETE CASCADE;


--
-- Name: herb_primary_actions herb_primary_actions_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: herb_primary_actions herb_primary_actions_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: herb_secondary_actions herb_secondary_actions_body_system_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_body_system_id_fkey FOREIGN KEY (body_system_id) REFERENCES herbal.body_systems(id);


--
-- Name: herb_secondary_actions herb_secondary_actions_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: herb_secondary_actions herb_secondary_actions_secondary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_secondary_action_id_fkey FOREIGN KEY (secondary_action_id) REFERENCES herbal.secondary_actions(id) ON DELETE CASCADE;


--
-- Name: prescription_herb_actions prescription_herb_actions_prescription_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herb_actions
    ADD CONSTRAINT prescription_herb_actions_prescription_herb_id_fkey FOREIGN KEY (prescription_herb_id) REFERENCES herbal.prescription_herbs(id) ON DELETE CASCADE;


--
-- Name: prescription_herb_actions prescription_herb_actions_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herb_actions
    ADD CONSTRAINT prescription_herb_actions_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: prescription_herbs prescription_herbs_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herbs
    ADD CONSTRAINT prescription_herbs_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: prescription_herbs prescription_herbs_prescription_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.prescription_herbs
    ADD CONSTRAINT prescription_herbs_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES herbal.disorder_prescriptions(id) ON DELETE CASCADE;


--
-- Name: action_descriptions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.action_descriptions ENABLE ROW LEVEL SECURITY;

--
-- Name: aging_herbs; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.aging_herbs ENABLE ROW LEVEL SECURITY;

--
-- Name: body_system_notes; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.body_system_notes ENABLE ROW LEVEL SECURITY;

--
-- Name: body_systems; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.body_systems ENABLE ROW LEVEL SECURITY;

--
-- Name: constituents; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.constituents ENABLE ROW LEVEL SECURITY;

--
-- Name: disorder_action_herbs; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.disorder_action_herbs ENABLE ROW LEVEL SECURITY;

--
-- Name: disorder_actions_indicated; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.disorder_actions_indicated ENABLE ROW LEVEL SECURITY;

--
-- Name: disorder_notes; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.disorder_notes ENABLE ROW LEVEL SECURITY;

--
-- Name: disorder_prescriptions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.disorder_prescriptions ENABLE ROW LEVEL SECURITY;

--
-- Name: disorder_specific_remedies; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.disorder_specific_remedies ENABLE ROW LEVEL SECURITY;

--
-- Name: disorders; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.disorders ENABLE ROW LEVEL SECURITY;

--
-- Name: herb_constituents; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.herb_constituents ENABLE ROW LEVEL SECURITY;

--
-- Name: herb_menstruum; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.herb_menstruum ENABLE ROW LEVEL SECURITY;

--
-- Name: herb_primary_actions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.herb_primary_actions ENABLE ROW LEVEL SECURITY;

--
-- Name: herb_secondary_actions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.herb_secondary_actions ENABLE ROW LEVEL SECURITY;

--
-- Name: herbs; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.herbs ENABLE ROW LEVEL SECURITY;

--
-- Name: prescription_herb_actions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.prescription_herb_actions ENABLE ROW LEVEL SECURITY;

--
-- Name: prescription_herbs; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.prescription_herbs ENABLE ROW LEVEL SECURITY;

--
-- Name: primary_actions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.primary_actions ENABLE ROW LEVEL SECURITY;

--
-- Name: action_descriptions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.action_descriptions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: aging_herbs public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.aging_herbs FOR SELECT TO authenticated, anon USING (true);


--
-- Name: body_system_notes public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.body_system_notes FOR SELECT TO authenticated, anon USING (true);


--
-- Name: body_systems public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.body_systems FOR SELECT TO authenticated, anon USING (true);


--
-- Name: constituents public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.constituents FOR SELECT TO authenticated, anon USING (true);


--
-- Name: disorder_action_herbs public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.disorder_action_herbs FOR SELECT TO authenticated, anon USING (true);


--
-- Name: disorder_actions_indicated public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.disorder_actions_indicated FOR SELECT TO authenticated, anon USING (true);


--
-- Name: disorder_notes public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.disorder_notes FOR SELECT TO authenticated, anon USING (true);


--
-- Name: disorder_prescriptions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.disorder_prescriptions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: disorder_specific_remedies public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.disorder_specific_remedies FOR SELECT TO authenticated, anon USING (true);


--
-- Name: disorders public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.disorders FOR SELECT TO authenticated, anon USING (true);


--
-- Name: herb_constituents public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.herb_constituents FOR SELECT TO authenticated, anon USING (true);


--
-- Name: herb_menstruum public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.herb_menstruum FOR SELECT TO authenticated, anon USING (true);


--
-- Name: herb_primary_actions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.herb_primary_actions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: herb_secondary_actions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.herb_secondary_actions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: herbs public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.herbs FOR SELECT TO authenticated, anon USING (true);


--
-- Name: prescription_herb_actions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.prescription_herb_actions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: prescription_herbs public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.prescription_herbs FOR SELECT TO authenticated, anon USING (true);


--
-- Name: primary_actions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.primary_actions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: secondary_actions public_read; Type: POLICY; Schema: herbal; Owner: -
--

CREATE POLICY public_read ON herbal.secondary_actions FOR SELECT TO authenticated, anon USING (true);


--
-- Name: secondary_actions; Type: ROW SECURITY; Schema: herbal; Owner: -
--

ALTER TABLE herbal.secondary_actions ENABLE ROW LEVEL SECURITY;

--
-- PostgreSQL database dump complete
--

\unrestrict dYdafw48ZCGnFUOHZQVd5nXVGYdH7mWlWfoTPZThBPQxrCsH2yJ2XzwhMm4IMQh

