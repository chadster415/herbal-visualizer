--
-- PostgreSQL database dump
--

\restrict 7HmbIYDe1K0JLEdE0HV2MfjfekmaNcv0eQGwOjJvdNZt3qoRb5zQFo3sFyDH9Bs

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

ALTER TABLE IF EXISTS ONLY herbal.prescription_herbs DROP CONSTRAINT IF EXISTS prescription_herbs_prescription_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herbs DROP CONSTRAINT IF EXISTS prescription_herbs_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herb_actions DROP CONSTRAINT IF EXISTS prescription_herb_actions_primary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.prescription_herb_actions DROP CONSTRAINT IF EXISTS prescription_herb_actions_prescription_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_secondary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_primary_action_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_fkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_body_system_id_fkey;
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
ALTER TABLE IF EXISTS ONLY herbal.action_descriptions DROP CONSTRAINT IF EXISTS action_descriptions_primary_action_id_fkey;
DROP INDEX IF EXISTS herbal.idx_prescription_herbs_prescription;
DROP INDEX IF EXISTS herbal.idx_prescription_herbs_herb;
DROP INDEX IF EXISTS herbal.idx_prescription_herb_actions_prescription_herb;
DROP INDEX IF EXISTS herbal.idx_prescription_herb_actions_action;
DROP INDEX IF EXISTS herbal.idx_herbs_latin_name;
DROP INDEX IF EXISTS herbal.idx_herbs_common_name;
DROP INDEX IF EXISTS herbal.idx_herb_secondary_actions_herb;
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
DROP INDEX IF EXISTS herbal.idx_action_descriptions_action;
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
ALTER TABLE IF EXISTS ONLY herbal.herb_secondary_actions DROP CONSTRAINT IF EXISTS herb_secondary_actions_herb_id_secondary_action_id_key;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_pkey;
ALTER TABLE IF EXISTS ONLY herbal.herb_primary_actions DROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_primary_action_id_body_system__key;
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
ALTER TABLE IF EXISTS ONLY herbal.body_systems DROP CONSTRAINT IF EXISTS body_systems_pkey;
ALTER TABLE IF EXISTS ONLY herbal.body_systems DROP CONSTRAINT IF EXISTS body_systems_name_key;
ALTER TABLE IF EXISTS ONLY herbal.action_descriptions DROP CONSTRAINT IF EXISTS action_descriptions_pkey;
ALTER TABLE IF EXISTS herbal.secondary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.primary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.prescription_herbs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.prescription_herb_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herbs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herb_secondary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.herb_primary_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorders ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_specific_remedies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_prescriptions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_notes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_actions_indicated ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.disorder_action_herbs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS herbal.body_systems ALTER COLUMN id DROP DEFAULT;
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
DROP SEQUENCE IF EXISTS herbal.body_systems_id_seq;
DROP TABLE IF EXISTS herbal.body_systems;
DROP SEQUENCE IF EXISTS herbal.action_descriptions_id_seq;
DROP TABLE IF EXISTS herbal.action_descriptions;
DROP TYPE IF EXISTS herbal.strength_level;
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
-- Name: strength_level; Type: TYPE; Schema: herbal; Owner: -
--

CREATE TYPE herbal.strength_level AS ENUM (
    'mild',
    'strong',
    'very_strong'
);


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
    created_at timestamp with time zone DEFAULT now()
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
    created_at timestamp with time zone DEFAULT now()
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
-- Name: body_systems id; Type: DEFAULT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.body_systems ALTER COLUMN id SET DEFAULT nextval('herbal.body_systems_id_seq'::regclass);


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
101	35	168	inhalant	5	2026-04-12 15:59:34.804125+00
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
463	168	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.650467+00
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
487	169	11	11	As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.	\N	2026-03-22 21:15:29.696243+00
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
770	209	21	\N	\N	\N	2026-03-22 21:15:30.091531+00
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
817	214	23	\N	\N	\N	2026-03-22 21:15:30.15602+00
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
979	268	5	10	\N	\N	2026-04-10 20:55:21.608297+00
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
\.


--
-- Data for Name: herb_secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herb_secondary_actions (id, herb_id, secondary_action_id, created_at) FROM stdin;
12	21	35	2026-03-22 21:15:30.237944+00
13	23	35	2026-03-22 21:15:30.239783+00
14	26	35	2026-03-22 21:15:30.241087+00
15	30	35	2026-03-22 21:15:30.242335+00
16	35	35	2026-03-22 21:15:30.243679+00
17	43	35	2026-03-22 21:15:30.245109+00
18	28	36	2026-03-22 21:15:30.246545+00
19	29	36	2026-03-22 21:15:30.247823+00
20	30	36	2026-03-22 21:15:30.249152+00
21	31	36	2026-03-22 21:15:30.250341+00
22	34	36	2026-03-22 21:15:30.251477+00
23	40	36	2026-03-22 21:15:30.252606+00
24	21	37	2026-03-22 21:15:30.253966+00
25	23	37	2026-03-22 21:15:30.255441+00
26	26	37	2026-03-22 21:15:30.256656+00
27	30	37	2026-03-22 21:15:30.257857+00
28	32	37	2026-03-22 21:15:30.259036+00
29	35	37	2026-03-22 21:15:30.260281+00
30	36	37	2026-03-22 21:15:30.261616+00
31	38	37	2026-03-22 21:15:30.262876+00
32	21	38	2026-03-22 21:15:30.264071+00
33	25	38	2026-03-22 21:15:30.265339+00
34	36	38	2026-03-22 21:15:30.266543+00
35	38	38	2026-03-22 21:15:30.267865+00
36	42	38	2026-03-22 21:15:30.268975+00
37	30	39	2026-03-22 21:15:30.270233+00
38	43	39	2026-03-22 21:15:30.271331+00
39	22	40	2026-03-22 21:15:30.272573+00
40	30	40	2026-03-22 21:15:30.273903+00
41	34	40	2026-03-22 21:15:30.275155+00
42	21	41	2026-03-22 21:15:30.276674+00
43	29	41	2026-03-22 21:15:30.277981+00
44	41	41	2026-03-22 21:15:30.279228+00
45	40	41	2026-03-22 21:15:30.280505+00
46	22	42	2026-03-22 21:15:30.281979+00
47	28	42	2026-03-22 21:15:30.283447+00
48	29	42	2026-03-22 21:15:30.284864+00
49	31	42	2026-03-22 21:15:30.286261+00
50	34	42	2026-03-22 21:15:30.287426+00
51	40	42	2026-03-22 21:15:30.288578+00
52	43	42	2026-03-22 21:15:30.289814+00
53	25	43	2026-03-22 21:15:30.291071+00
54	38	44	2026-03-22 21:15:30.292474+00
55	42	44	2026-03-22 21:15:30.293746+00
56	21	45	2026-03-22 21:15:30.29487+00
57	22	45	2026-03-22 21:15:30.296069+00
58	24	45	2026-03-22 21:15:30.297507+00
59	30	45	2026-03-22 21:15:30.298693+00
60	31	45	2026-03-22 21:15:30.299885+00
61	33	45	2026-03-22 21:15:30.301094+00
62	34	45	2026-03-22 21:15:30.302268+00
63	35	45	2026-03-22 21:15:30.303601+00
64	37	45	2026-03-22 21:15:30.304977+00
65	21	46	2026-03-22 21:15:30.306271+00
66	25	46	2026-03-22 21:15:30.307596+00
67	43	46	2026-03-22 21:15:30.308841+00
68	25	47	2026-03-22 21:15:30.309991+00
69	36	47	2026-03-22 21:15:30.31114+00
70	42	47	2026-03-22 21:15:30.312387+00
71	28	48	2026-03-22 21:15:30.313665+00
72	30	48	2026-03-22 21:15:30.314881+00
73	21	49	2026-03-22 21:15:30.316148+00
74	23	49	2026-03-22 21:15:30.317438+00
75	26	49	2026-03-22 21:15:30.318736+00
76	30	49	2026-03-22 21:15:30.32006+00
77	61	49	2026-03-22 21:15:30.321249+00
78	51	36	2026-03-22 21:15:30.322477+00
79	52	36	2026-03-22 21:15:30.323628+00
81	58	36	2026-03-22 21:15:30.326085+00
82	44	37	2026-03-22 21:15:30.327256+00
84	46	37	2026-03-22 21:15:30.329647+00
86	47	37	2026-03-22 21:15:30.336261+00
88	54	37	2026-03-22 21:15:30.338998+00
89	55	37	2026-03-22 21:15:30.340425+00
90	56	37	2026-03-22 21:15:30.341903+00
91	58	37	2026-03-22 21:15:30.34327+00
92	59	37	2026-03-22 21:15:30.344646+00
94	50	38	2026-03-22 21:15:30.347583+00
95	53	38	2026-03-22 21:15:30.349038+00
96	55	38	2026-03-22 21:15:30.350367+00
97	56	38	2026-03-22 21:15:30.351595+00
98	59	38	2026-03-22 21:15:30.352755+00
99	44	39	2026-03-22 21:15:30.353867+00
100	46	39	2026-03-22 21:15:30.355062+00
101	51	39	2026-03-22 21:15:30.356186+00
102	52	39	2026-03-22 21:15:30.357365+00
104	56	39	2026-03-22 21:15:30.359693+00
105	59	39	2026-03-22 21:15:30.360898+00
106	44	40	2026-03-22 21:15:30.362202+00
107	50	40	2026-03-22 21:15:30.363407+00
109	47	50	2026-03-22 21:15:30.365869+00
110	53	50	2026-03-22 21:15:30.367054+00
111	55	50	2026-03-22 21:15:30.368351+00
112	56	50	2026-03-22 21:15:30.369606+00
113	58	50	2026-03-22 21:15:30.370649+00
114	59	50	2026-03-22 21:15:30.371708+00
115	45	51	2026-03-22 21:15:30.372864+00
116	46	51	2026-03-22 21:15:30.37401+00
117	48	51	2026-03-22 21:15:30.375243+00
118	49	51	2026-03-22 21:15:30.376478+00
119	60	51	2026-03-22 21:15:30.377825+00
120	61	51	2026-03-22 21:15:30.379042+00
121	44	41	2026-03-22 21:15:30.38025+00
123	50	41	2026-03-22 21:15:30.382751+00
124	53	41	2026-03-22 21:15:30.384028+00
125	54	41	2026-03-22 21:15:30.385221+00
126	55	41	2026-03-22 21:15:30.386333+00
127	57	41	2026-03-22 21:15:30.387578+00
128	58	41	2026-03-22 21:15:30.389274+00
129	44	42	2026-03-22 21:15:30.390477+00
130	45	42	2026-03-22 21:15:30.392691+00
131	46	42	2026-03-22 21:15:30.393847+00
132	57	42	2026-03-22 21:15:30.395043+00
133	58	42	2026-03-22 21:15:30.396527+00
134	60	42	2026-03-22 21:15:30.397759+00
135	61	42	2026-03-22 21:15:30.398968+00
136	44	43	2026-03-22 21:15:30.400194+00
137	50	43	2026-03-22 21:15:30.401305+00
138	56	43	2026-03-22 21:15:30.402581+00
139	59	43	2026-03-22 21:15:30.403801+00
140	45	44	2026-03-22 21:15:30.405023+00
141	48	44	2026-03-22 21:15:30.406196+00
142	49	44	2026-03-22 21:15:30.407374+00
143	53	44	2026-03-22 21:15:30.408586+00
144	57	44	2026-03-22 21:15:30.410006+00
145	59	44	2026-03-22 21:15:30.41106+00
146	60	44	2026-03-22 21:15:30.412247+00
147	61	44	2026-03-22 21:15:30.413401+00
149	50	45	2026-03-22 21:15:30.41607+00
151	44	46	2026-03-22 21:15:30.418542+00
153	50	52	2026-03-22 21:15:30.420916+00
154	30	52	2026-03-22 21:15:30.422236+00
155	57	52	2026-03-22 21:15:30.42353+00
156	53	47	2026-03-22 21:15:30.42469+00
157	44	53	2026-03-22 21:15:30.425897+00
158	47	53	2026-03-22 21:15:30.427072+00
159	26	53	2026-03-22 21:15:30.428213+00
160	50	53	2026-03-22 21:15:30.429424+00
161	30	53	2026-03-22 21:15:30.43051+00
162	45	48	2026-03-22 21:15:30.431649+00
163	52	48	2026-03-22 21:15:30.433289+00
164	57	48	2026-03-22 21:15:30.434667+00
165	61	48	2026-03-22 21:15:30.435897+00
166	44	35	2026-03-22 21:15:30.437163+00
167	45	35	2026-03-22 21:15:30.4385+00
168	48	35	2026-03-22 21:15:30.439871+00
169	49	35	2026-03-22 21:15:30.441725+00
170	52	35	2026-03-22 21:15:30.443197+00
172	53	35	2026-03-22 21:15:30.445851+00
173	55	35	2026-03-22 21:15:30.447607+00
174	56	35	2026-03-22 21:15:30.449194+00
175	57	35	2026-03-22 21:15:30.450553+00
176	58	35	2026-03-22 21:15:30.453817+00
177	60	35	2026-03-22 21:15:30.455799+00
178	61	35	2026-03-22 21:15:30.459814+00
180	70	37	2026-03-22 21:15:30.463779+00
182	81	37	2026-03-22 21:15:30.467779+00
183	84	37	2026-03-22 21:15:30.469051+00
185	86	37	2026-03-22 21:15:30.472945+00
188	64	38	2026-03-22 21:15:30.480205+00
189	65	38	2026-03-22 21:15:30.483209+00
190	66	38	2026-03-22 21:15:30.48601+00
191	67	38	2026-03-22 21:15:30.488111+00
193	74	38	2026-03-22 21:15:30.493284+00
194	76	38	2026-03-22 21:15:30.495899+00
195	78	38	2026-03-22 21:15:30.498448+00
196	81	38	2026-03-22 21:15:30.501339+00
198	82	38	2026-03-22 21:15:30.507946+00
199	84	38	2026-03-22 21:15:30.510536+00
201	86	38	2026-03-22 21:15:30.515522+00
203	57	38	2026-03-22 21:15:30.519484+00
204	90	38	2026-03-22 21:15:30.523454+00
205	91	38	2026-03-22 21:15:30.526704+00
206	61	38	2026-03-22 21:15:30.529668+00
207	93	38	2026-03-22 21:15:30.532339+00
208	94	38	2026-03-22 21:15:30.535068+00
210	62	39	2026-03-22 21:15:30.53924+00
211	63	39	2026-03-22 21:15:30.543064+00
212	70	39	2026-03-22 21:15:30.546599+00
213	71	39	2026-03-22 21:15:30.549406+00
214	75	39	2026-03-22 21:15:30.551811+00
216	79	39	2026-03-22 21:15:30.557233+00
218	85	39	2026-03-22 21:15:30.561719+00
219	86	39	2026-03-22 21:15:30.563714+00
221	58	39	2026-03-22 21:15:30.569054+00
222	89	39	2026-03-22 21:15:30.571996+00
223	90	39	2026-03-22 21:15:30.574221+00
224	61	39	2026-03-22 21:15:30.576359+00
227	84	40	2026-03-22 21:15:30.582073+00
228	44	50	2026-03-22 21:15:30.585308+00
229	64	50	2026-03-22 21:15:30.588283+00
230	65	50	2026-03-22 21:15:30.591277+00
231	66	50	2026-03-22 21:15:30.594573+00
232	75	50	2026-03-22 21:15:30.59828+00
233	76	50	2026-03-22 21:15:30.600942+00
234	78	50	2026-03-22 21:15:30.604285+00
236	82	50	2026-03-22 21:15:30.607245+00
237	84	50	2026-03-22 21:15:30.608863+00
241	90	50	2026-03-22 21:15:30.613455+00
242	91	50	2026-03-22 21:15:30.615929+00
243	70	54	2026-03-22 21:15:30.617811+00
244	74	54	2026-03-22 21:15:30.623887+00
245	30	54	2026-03-22 21:15:30.625723+00
246	34	54	2026-03-22 21:15:30.627563+00
250	78	51	2026-03-22 21:15:30.633807+00
251	83	51	2026-03-22 21:15:30.635412+00
252	88	51	2026-03-22 21:15:30.636762+00
253	89	51	2026-03-22 21:15:30.638188+00
254	91	51	2026-03-22 21:15:30.639521+00
255	92	51	2026-03-22 21:15:30.64092+00
257	95	51	2026-03-22 21:15:30.643788+00
259	65	41	2026-03-22 21:15:30.646412+00
260	67	41	2026-03-22 21:15:30.64784+00
266	90	41	2026-03-22 21:15:30.655096+00
268	63	42	2026-03-22 21:15:30.657314+00
269	66	42	2026-03-22 21:15:30.658758+00
270	73	42	2026-03-22 21:15:30.660058+00
273	85	42	2026-03-22 21:15:30.663729+00
276	90	42	2026-03-22 21:15:30.667337+00
277	95	42	2026-03-22 21:15:30.668615+00
279	63	43	2026-03-22 21:15:30.671173+00
280	70	43	2026-03-22 21:15:30.67252+00
281	72	43	2026-03-22 21:15:30.674367+00
283	30	43	2026-03-22 21:15:30.677548+00
284	53	43	2026-03-22 21:15:30.679779+00
285	82	43	2026-03-22 21:15:30.683888+00
287	90	43	2026-03-22 21:15:30.687145+00
288	93	43	2026-03-22 21:15:30.688708+00
289	94	43	2026-03-22 21:15:30.690127+00
291	67	44	2026-03-22 21:15:30.692886+00
294	78	44	2026-03-22 21:15:30.696919+00
295	30	44	2026-03-22 21:15:30.698441+00
297	83	44	2026-03-22 21:15:30.700884+00
298	85	44	2026-03-22 21:15:30.702103+00
302	44	45	2026-03-22 21:15:30.706738+00
303	70	45	2026-03-22 21:15:30.707938+00
304	74	45	2026-03-22 21:15:30.709169+00
305	76	45	2026-03-22 21:15:30.710436+00
306	78	45	2026-03-22 21:15:30.711624+00
308	53	45	2026-03-22 21:15:30.713957+00
310	91	45	2026-03-22 21:15:30.716727+00
312	78	52	2026-03-22 21:15:30.719139+00
313	66	47	2026-03-22 21:15:30.720415+00
314	69	47	2026-03-22 21:15:30.721604+00
316	81	47	2026-03-22 21:15:30.723781+00
318	82	47	2026-03-22 21:15:30.726202+00
319	84	47	2026-03-22 21:15:30.72749+00
320	55	47	2026-03-22 21:15:30.72871+00
321	90	47	2026-03-22 21:15:30.729928+00
322	94	47	2026-03-22 21:15:30.731009+00
324	25	53	2026-03-22 21:15:30.73317+00
325	73	53	2026-03-22 21:15:30.734457+00
326	75	53	2026-03-22 21:15:30.735696+00
328	81	53	2026-03-22 21:15:30.738142+00
329	61	53	2026-03-22 21:15:30.739427+00
330	44	48	2026-03-22 21:15:30.740551+00
331	63	48	2026-03-22 21:15:30.741724+00
333	70	48	2026-03-22 21:15:30.744524+00
334	75	48	2026-03-22 21:15:30.745808+00
335	79	48	2026-03-22 21:15:30.747427+00
336	81	48	2026-03-22 21:15:30.748811+00
337	53	48	2026-03-22 21:15:30.750073+00
338	83	48	2026-03-22 21:15:30.75115+00
339	84	48	2026-03-22 21:15:30.752305+00
340	85	48	2026-03-22 21:15:30.753473+00
341	88	48	2026-03-22 21:15:30.754622+00
342	89	48	2026-03-22 21:15:30.75593+00
347	54	49	2026-03-22 21:15:30.797326+00
349	46	35	2026-03-22 21:15:30.804001+00
351	47	35	2026-03-22 21:15:30.807008+00
353	101	35	2026-03-22 21:15:30.809682+00
355	54	35	2026-03-22 21:15:30.81234+00
357	105	35	2026-03-22 21:15:30.816606+00
359	59	35	2026-03-22 21:15:30.820482+00
360	97	36	2026-03-22 21:15:30.821953+00
361	70	36	2026-03-22 21:15:30.823367+00
362	81	36	2026-03-22 21:15:30.824592+00
363	55	36	2026-03-22 21:15:30.825843+00
364	85	36	2026-03-22 21:15:30.827119+00
366	98	38	2026-03-22 21:15:30.868063+00
369	108	38	2026-03-22 21:15:30.871739+00
370	109	38	2026-03-22 21:15:30.872948+00
371	110	38	2026-03-22 21:15:30.874124+00
376	98	39	2026-03-22 21:15:30.879492+00
377	99	39	2026-03-22 21:15:30.880661+00
379	109	39	2026-03-22 21:15:30.883573+00
383	96	40	2026-03-22 21:15:30.887899+00
384	97	40	2026-03-22 21:15:30.889128+00
385	102	40	2026-03-22 21:15:30.890265+00
387	110	40	2026-03-22 21:15:30.892562+00
388	97	50	2026-03-22 21:15:30.893812+00
390	98	50	2026-03-22 21:15:30.895965+00
391	99	50	2026-03-22 21:15:30.897054+00
392	100	50	2026-03-22 21:15:30.898208+00
393	103	50	2026-03-22 21:15:30.899303+00
395	108	50	2026-03-22 21:15:30.901531+00
396	109	50	2026-03-22 21:15:30.902773+00
398	111	50	2026-03-22 21:15:30.904768+00
401	85	51	2026-03-22 21:15:30.907825+00
404	23	41	2026-03-22 21:15:30.911045+00
405	47	41	2026-03-22 21:15:30.912277+00
408	107	41	2026-03-22 21:15:30.915843+00
411	101	42	2026-03-22 21:15:30.920073+00
412	103	42	2026-03-22 21:15:30.921193+00
415	96	43	2026-03-22 21:15:30.924876+00
416	97	43	2026-03-22 21:15:30.925983+00
418	98	43	2026-03-22 21:15:30.928222+00
419	102	43	2026-03-22 21:15:30.929333+00
421	107	43	2026-03-22 21:15:30.93142+00
422	109	43	2026-03-22 21:15:30.932547+00
423	110	43	2026-03-22 21:15:30.933599+00
425	98	44	2026-03-22 21:15:30.935611+00
426	99	44	2026-03-22 21:15:30.936672+00
427	101	44	2026-03-22 21:15:30.937858+00
428	54	44	2026-03-22 21:15:30.93887+00
429	104	44	2026-03-22 21:15:30.939995+00
430	105	44	2026-03-22 21:15:30.941213+00
431	107	44	2026-03-22 21:15:30.942429+00
432	108	44	2026-03-22 21:15:30.943483+00
434	110	44	2026-03-22 21:15:30.945902+00
437	96	45	2026-03-22 21:15:30.949262+00
439	102	45	2026-03-22 21:15:30.952129+00
441	54	45	2026-03-22 21:15:30.954497+00
442	110	45	2026-03-22 21:15:30.956151+00
445	106	46	2026-03-22 21:15:30.961987+00
446	44	52	2026-03-22 21:15:30.963666+00
447	96	52	2026-03-22 21:15:30.964961+00
448	97	52	2026-03-22 21:15:30.966263+00
449	102	52	2026-03-22 21:15:30.968635+00
451	110	52	2026-03-22 21:15:30.974037+00
454	109	47	2026-03-22 21:15:30.980245+00
456	21	53	2026-03-22 21:15:30.983629+00
457	97	53	2026-03-22 21:15:30.985263+00
458	70	53	2026-03-22 21:15:30.986806+00
461	102	53	2026-03-22 21:15:30.992783+00
464	54	53	2026-03-22 21:15:30.999164+00
465	110	53	2026-03-22 21:15:31.001097+00
468	99	48	2026-03-22 21:15:31.008312+00
472	65	36	2026-03-22 21:15:31.016509+00
473	66	36	2026-03-22 21:15:31.01865+00
474	68	36	2026-03-22 21:15:31.021582+00
475	74	36	2026-03-22 21:15:31.025442+00
476	75	36	2026-03-22 21:15:31.028164+00
477	77	36	2026-03-22 21:15:31.03+00
479	80	36	2026-03-22 21:15:31.033043+00
481	86	36	2026-03-22 21:15:31.036149+00
482	121	36	2026-03-22 21:15:31.037646+00
483	22	49	2026-03-22 21:15:31.039142+00
484	33	49	2026-03-22 21:15:31.045656+00
485	118	49	2026-03-22 21:15:31.047665+00
486	29	49	2026-03-22 21:15:31.049422+00
487	80	49	2026-03-22 21:15:31.050783+00
488	31	49	2026-03-22 21:15:31.052126+00
489	34	49	2026-03-22 21:15:31.053438+00
490	35	49	2026-03-22 21:15:31.054909+00
491	37	49	2026-03-22 21:15:31.056559+00
492	40	49	2026-03-22 21:15:31.057926+00
493	43	49	2026-03-22 21:15:31.059193+00
497	50	42	2026-03-22 21:15:31.064107+00
498	117	42	2026-03-22 21:15:31.065548+00
500	120	42	2026-03-22 21:15:31.068072+00
501	122	42	2026-03-22 21:15:31.069457+00
502	113	55	2026-03-22 21:15:31.070525+00
503	116	55	2026-03-22 21:15:31.071541+00
504	47	55	2026-03-22 21:15:31.072627+00
505	119	55	2026-03-22 21:15:31.073707+00
506	109	55	2026-03-22 21:15:31.074936+00
507	123	55	2026-03-22 21:15:31.076209+00
508	124	55	2026-03-22 21:15:31.077451+00
511	114	56	2026-03-22 21:15:31.081355+00
512	97	56	2026-03-22 21:15:31.082804+00
513	115	56	2026-03-22 21:15:31.084064+00
514	72	56	2026-03-22 21:15:31.085288+00
515	25	49	2026-03-22 21:15:31.086496+00
516	42	49	2026-03-22 21:15:31.087716+00
517	25	57	2026-03-22 21:15:31.088957+00
518	74	57	2026-03-22 21:15:31.090087+00
519	128	57	2026-03-22 21:15:31.091142+00
520	81	57	2026-03-22 21:15:31.092199+00
521	130	57	2026-03-22 21:15:31.093245+00
522	55	57	2026-03-22 21:15:31.094471+00
523	137	57	2026-03-22 21:15:31.095692+00
524	139	57	2026-03-22 21:15:31.097209+00
525	145	57	2026-03-22 21:15:31.098432+00
527	82	35	2026-03-22 21:15:31.100674+00
528	84	35	2026-03-22 21:15:31.101977+00
530	136	35	2026-03-22 21:15:31.104641+00
533	90	35	2026-03-22 21:15:31.107743+00
534	91	35	2026-03-22 21:15:31.108839+00
537	124	35	2026-03-22 21:15:31.111992+00
541	78	36	2026-03-22 21:15:31.117275+00
543	53	36	2026-03-22 21:15:31.121031+00
544	82	36	2026-03-22 21:15:31.122839+00
545	84	36	2026-03-22 21:15:31.124367+00
546	134	36	2026-03-22 21:15:31.125749+00
548	57	36	2026-03-22 21:15:31.128362+00
549	90	36	2026-03-22 21:15:31.129803+00
550	60	36	2026-03-22 21:15:31.131395+00
551	98	37	2026-03-22 21:15:31.133022+00
552	126	37	2026-03-22 21:15:31.134818+00
553	129	37	2026-03-22 21:15:31.136333+00
555	82	37	2026-03-22 21:15:31.138795+00
558	108	37	2026-03-22 21:15:31.143244+00
559	138	37	2026-03-22 21:15:31.144719+00
560	109	37	2026-03-22 21:15:31.146222+00
562	129	39	2026-03-22 21:15:31.151013+00
563	81	39	2026-03-22 21:15:31.152584+00
564	133	39	2026-03-22 21:15:31.154511+00
565	140	39	2026-03-22 21:15:31.156577+00
568	93	39	2026-03-22 21:15:31.161643+00
569	94	39	2026-03-22 21:15:31.163205+00
570	115	40	2026-03-22 21:15:31.164648+00
571	129	40	2026-03-22 21:15:31.166063+00
575	115	50	2026-03-22 21:15:31.17119+00
577	125	50	2026-03-22 21:15:31.173692+00
578	127	50	2026-03-22 21:15:31.174947+00
580	129	50	2026-03-22 21:15:31.177666+00
583	131	50	2026-03-22 21:15:31.184086+00
585	134	50	2026-03-22 21:15:31.187367+00
587	135	50	2026-03-22 21:15:31.190068+00
588	136	50	2026-03-22 21:15:31.191372+00
589	120	50	2026-03-22 21:15:31.19272+00
591	141	50	2026-03-22 21:15:31.195366+00
595	145	50	2026-03-22 21:15:31.200649+00
596	146	50	2026-03-22 21:15:31.201865+00
597	124	50	2026-03-22 21:15:31.203051+00
598	126	51	2026-03-22 21:15:31.204309+00
604	25	41	2026-03-22 21:15:31.211424+00
607	136	41	2026-03-22 21:15:31.214823+00
608	109	41	2026-03-22 21:15:31.216249+00
610	143	41	2026-03-22 21:15:31.218827+00
612	146	41	2026-03-22 21:15:31.2212+00
613	124	41	2026-03-22 21:15:31.222665+00
614	65	42	2026-03-22 21:15:31.22395+00
615	125	42	2026-03-22 21:15:31.225306+00
616	133	42	2026-03-22 21:15:31.226775+00
617	136	42	2026-03-22 21:15:31.227995+00
619	138	42	2026-03-22 21:15:31.230355+00
622	144	42	2026-03-22 21:15:31.235621+00
624	115	43	2026-03-22 21:15:31.238038+00
627	131	43	2026-03-22 21:15:31.241701+00
628	135	43	2026-03-22 21:15:31.243894+00
629	65	44	2026-03-22 21:15:31.245745+00
631	125	44	2026-03-22 21:15:31.248615+00
632	126	44	2026-03-22 21:15:31.250314+00
633	76	44	2026-03-22 21:15:31.251802+00
635	133	44	2026-03-22 21:15:31.254793+00
636	136	44	2026-03-22 21:15:31.256189+00
637	120	44	2026-03-22 21:15:31.257579+00
639	143	44	2026-03-22 21:15:31.260301+00
641	91	44	2026-03-22 21:15:31.263576+00
644	146	45	2026-03-22 21:15:31.267959+00
645	128	58	2026-03-22 21:15:31.269333+00
646	129	58	2026-03-22 21:15:31.270576+00
647	130	58	2026-03-22 21:15:31.271741+00
648	84	58	2026-03-22 21:15:31.272863+00
649	137	58	2026-03-22 21:15:31.273978+00
650	138	58	2026-03-22 21:15:31.275143+00
651	139	58	2026-03-22 21:15:31.276411+00
652	90	58	2026-03-22 21:15:31.277628+00
653	145	58	2026-03-22 21:15:31.279005+00
654	131	46	2026-03-22 21:15:31.280344+00
655	137	46	2026-03-22 21:15:31.281974+00
656	142	46	2026-03-22 21:15:31.283531+00
657	90	46	2026-03-22 21:15:31.28485+00
658	145	46	2026-03-22 21:15:31.286106+00
659	25	59	2026-03-22 21:15:31.287288+00
660	128	59	2026-03-22 21:15:31.288765+00
661	129	59	2026-03-22 21:15:31.290097+00
662	81	59	2026-03-22 21:15:31.291226+00
663	53	59	2026-03-22 21:15:31.292472+00
664	130	59	2026-03-22 21:15:31.293605+00
665	82	59	2026-03-22 21:15:31.294877+00
666	131	59	2026-03-22 21:15:31.29623+00
667	132	59	2026-03-22 21:15:31.297568+00
668	133	59	2026-03-22 21:15:31.298658+00
669	84	59	2026-03-22 21:15:31.299872+00
670	134	59	2026-03-22 21:15:31.301051+00
671	55	59	2026-03-22 21:15:31.302177+00
672	136	59	2026-03-22 21:15:31.303441+00
673	137	59	2026-03-22 21:15:31.304661+00
674	138	59	2026-03-22 21:15:31.305922+00
675	139	59	2026-03-22 21:15:31.307114+00
676	140	59	2026-03-22 21:15:31.308604+00
677	142	59	2026-03-22 21:15:31.310177+00
678	90	59	2026-03-22 21:15:31.311631+00
679	145	59	2026-03-22 21:15:31.31342+00
680	93	59	2026-03-22 21:15:31.31524+00
681	94	59	2026-03-22 21:15:31.31708+00
682	115	53	2026-03-22 21:15:31.318688+00
684	142	53	2026-03-22 21:15:31.321595+00
685	91	53	2026-03-22 21:15:31.322969+00
686	144	53	2026-03-22 21:15:31.328758+00
687	60	53	2026-03-22 21:15:31.330525+00
688	146	53	2026-03-22 21:15:31.331779+00
689	136	48	2026-03-22 21:15:31.332932+00
693	91	48	2026-03-22 21:15:31.337706+00
697	51	35	2026-03-22 21:15:31.342366+00
700	152	35	2026-03-22 21:15:31.34606+00
707	79	36	2026-03-22 21:15:31.354159+00
709	152	36	2026-03-22 21:15:31.35805+00
710	153	36	2026-03-22 21:15:31.360198+00
714	147	37	2026-03-22 21:15:31.367528+00
716	153	37	2026-03-22 21:15:31.370195+00
720	133	38	2026-03-22 21:15:31.375078+00
721	140	38	2026-03-22 21:15:31.376624+00
725	148	40	2026-03-22 21:15:31.381447+00
726	140	40	2026-03-22 21:15:31.382752+00
733	119	41	2026-03-22 21:15:31.390868+00
736	148	42	2026-03-22 21:15:31.394361+00
738	150	42	2026-03-22 21:15:31.397129+00
744	155	43	2026-03-22 21:15:31.406213+00
747	140	44	2026-03-22 21:15:31.410233+00
748	89	44	2026-03-22 21:15:31.412135+00
750	148	45	2026-03-22 21:15:31.414753+00
752	150	47	2026-03-22 21:15:31.417233+00
753	140	47	2026-03-22 21:15:31.418711+00
756	148	53	2026-03-22 21:15:31.422931+00
757	155	53	2026-03-22 21:15:31.424467+00
760	148	48	2026-03-22 21:15:31.428274+00
764	159	35	2026-03-22 21:15:31.433292+00
765	50	35	2026-03-22 21:15:31.434466+00
767	160	35	2026-03-22 21:15:31.436601+00
768	44	36	2026-03-22 21:15:31.437771+00
774	96	37	2026-03-22 21:15:31.444415+00
775	97	37	2026-03-22 21:15:31.445808+00
776	115	37	2026-03-22 21:15:31.446889+00
779	160	38	2026-03-22 21:15:31.450521+00
784	96	50	2026-03-22 21:15:31.456752+00
786	159	50	2026-03-22 21:15:31.46075+00
788	161	50	2026-03-22 21:15:31.463722+00
789	96	54	2026-03-22 21:15:31.465099+00
790	97	54	2026-03-22 21:15:31.46666+00
791	115	54	2026-03-22 21:15:31.468213+00
792	158	54	2026-03-22 21:15:31.469744+00
793	159	54	2026-03-22 21:15:31.471062+00
794	102	54	2026-03-22 21:15:31.472295+00
796	161	54	2026-03-22 21:15:31.474953+00
804	159	43	2026-03-22 21:15:31.48588+00
808	161	43	2026-03-22 21:15:31.490444+00
809	160	44	2026-03-22 21:15:31.491578+00
812	97	45	2026-03-22 21:15:31.494772+00
813	115	45	2026-03-22 21:15:31.495905+00
814	158	45	2026-03-22 21:15:31.497175+00
815	159	45	2026-03-22 21:15:31.498315+00
819	161	45	2026-03-22 21:15:31.503483+00
820	158	52	2026-03-22 21:15:31.505687+00
821	159	52	2026-03-22 21:15:31.507098+00
825	115	47	2026-03-22 21:15:31.512201+00
826	159	47	2026-03-22 21:15:31.513504+00
831	159	53	2026-03-22 21:15:31.519583+00
833	160	53	2026-03-22 21:15:31.522241+00
837	160	48	2026-03-22 21:15:31.527243+00
854	103	37	2026-03-22 21:15:31.546656+00
862	97	38	2026-03-22 21:15:31.556802+00
864	131	38	2026-03-22 21:15:31.559146+00
866	134	38	2026-03-22 21:15:31.561503+00
870	145	38	2026-03-22 21:15:31.5665+00
872	167	39	2026-03-22 21:15:31.568948+00
873	77	39	2026-03-22 21:15:31.570354+00
881	134	41	2026-03-22 21:15:31.580084+00
883	135	41	2026-03-22 21:15:31.582321+00
887	77	42	2026-03-22 21:15:31.592279+00
891	77	43	2026-03-22 21:15:31.59786+00
894	120	43	2026-03-22 21:15:31.602439+00
899	64	60	2026-03-22 21:15:31.610032+00
900	98	60	2026-03-22 21:15:31.611684+00
901	77	60	2026-03-22 21:15:31.613226+00
903	134	46	2026-03-22 21:15:31.615801+00
906	129	47	2026-03-22 21:15:31.62109+00
907	131	47	2026-03-22 21:15:31.622648+00
909	134	47	2026-03-22 21:15:31.627515+00
911	145	47	2026-03-22 21:15:31.632926+00
912	21	61	2026-03-22 21:15:31.635401+00
913	103	61	2026-03-22 21:15:31.63737+00
914	120	61	2026-03-22 21:15:31.639668+00
917	84	53	2026-03-22 21:15:31.648556+00
920	24	49	2026-03-22 21:15:31.657329+00
928	158	36	2026-03-22 21:15:31.676898+00
930	27	36	2026-03-22 21:15:31.679584+00
933	109	36	2026-03-22 21:15:31.683513+00
935	158	37	2026-03-22 21:15:31.68735+00
936	170	37	2026-03-22 21:15:31.689353+00
938	33	37	2026-03-22 21:15:31.693341+00
942	175	38	2026-03-22 21:15:31.698506+00
947	23	40	2026-03-22 21:15:31.704959+00
948	158	40	2026-03-22 21:15:31.706316+00
949	171	40	2026-03-22 21:15:31.707606+00
950	172	40	2026-03-22 21:15:31.708908+00
951	173	40	2026-03-22 21:15:31.710232+00
953	27	40	2026-03-22 21:15:31.713097+00
956	174	40	2026-03-22 21:15:31.717526+00
957	33	40	2026-03-22 21:15:31.718994+00
958	176	40	2026-03-22 21:15:31.720478+00
959	177	40	2026-03-22 21:15:31.72324+00
960	158	41	2026-03-22 21:15:31.724915+00
961	74	41	2026-03-22 21:15:31.726551+00
964	24	42	2026-03-22 21:15:31.730679+00
965	173	42	2026-03-22 21:15:31.732144+00
967	27	42	2026-03-22 21:15:31.735483+00
969	176	42	2026-03-22 21:15:31.738394+00
970	23	43	2026-03-22 21:15:31.739872+00
971	158	43	2026-03-22 21:15:31.741284+00
972	171	43	2026-03-22 21:15:31.742651+00
973	172	43	2026-03-22 21:15:31.743922+00
974	173	43	2026-03-22 21:15:31.745328+00
976	27	43	2026-03-22 21:15:31.747831+00
979	174	43	2026-03-22 21:15:31.751777+00
980	33	43	2026-03-22 21:15:31.754097+00
981	176	43	2026-03-22 21:15:31.755824+00
983	177	43	2026-03-22 21:15:31.758509+00
984	174	52	2026-03-22 21:15:31.759872+00
985	177	52	2026-03-22 21:15:31.76211+00
986	37	52	2026-03-22 21:15:31.763693+00
988	171	53	2026-03-22 21:15:31.766224+00
989	24	53	2026-03-22 21:15:31.767476+00
993	31	53	2026-03-22 21:15:31.772211+00
994	176	53	2026-03-22 21:15:31.77343+00
995	37	53	2026-03-22 21:15:31.774594+00
996	177	53	2026-03-22 21:15:31.775675+00
1000	45	36	2026-03-22 21:15:31.779868+00
1002	83	36	2026-03-22 21:15:31.782425+00
1003	89	36	2026-03-22 21:15:31.786103+00
1005	92	36	2026-03-22 21:15:31.789297+00
1006	61	36	2026-03-22 21:15:31.791036+00
1007	179	37	2026-03-22 21:15:31.793015+00
1008	60	38	2026-03-22 21:15:31.795644+00
1010	83	38	2026-03-22 21:15:31.798684+00
1012	45	39	2026-03-22 21:15:31.80384+00
1013	83	39	2026-03-22 21:15:31.805745+00
1015	60	39	2026-03-22 21:15:31.808708+00
1016	92	39	2026-03-22 21:15:31.810292+00
1017	61	41	2026-03-22 21:15:31.811623+00
1019	179	42	2026-03-22 21:15:31.814199+00
1030	180	52	2026-03-22 21:15:31.828823+00
1031	78	53	2026-03-22 21:15:31.830169+00
1034	95	53	2026-03-22 21:15:31.83435+00
1038	60	48	2026-03-22 21:15:31.839816+00
1041	28	49	2026-03-22 21:15:31.844044+00
1046	117	36	2026-03-22 21:15:31.854822+00
1050	181	37	2026-03-22 21:15:31.860736+00
1053	186	37	2026-03-22 21:15:31.864793+00
1055	148	39	2026-03-22 21:15:31.867672+00
1057	150	39	2026-03-22 21:15:31.870107+00
1058	164	39	2026-03-22 21:15:31.871826+00
1059	28	39	2026-03-22 21:15:31.873439+00
1061	163	62	2026-03-22 21:15:31.876075+00
1062	164	62	2026-03-22 21:15:31.87732+00
1064	182	51	2026-03-22 21:15:31.879538+00
1075	176	45	2026-03-22 21:15:31.894188+00
1077	73	46	2026-03-22 21:15:31.896996+00
1079	31	52	2026-03-22 21:15:31.899295+00
1084	181	53	2026-03-22 21:15:31.904874+00
1087	28	53	2026-03-22 21:15:31.908207+00
1094	109	35	2026-03-22 21:15:31.931117+00
1097	72	36	2026-03-22 21:15:31.937632+00
1102	59	36	2026-03-22 21:15:31.945272+00
1109	161	37	2026-03-22 21:15:31.95589+00
1111	189	37	2026-03-22 21:15:31.959685+00
1112	70	38	2026-03-22 21:15:31.961158+00
1113	72	38	2026-03-22 21:15:31.964529+00
1124	146	38	2026-03-22 21:15:31.978881+00
1128	97	39	2026-03-22 21:15:31.983705+00
1130	188	39	2026-03-22 21:15:31.98594+00
1131	155	39	2026-03-22 21:15:31.987203+00
1139	102	50	2026-03-22 21:15:31.995952+00
1146	110	50	2026-03-22 21:15:32.004044+00
1148	121	50	2026-03-22 21:15:32.006424+00
1151	189	50	2026-03-22 21:15:32.009801+00
1159	160	40	2026-03-22 21:15:32.020139+00
1162	121	40	2026-03-22 21:15:32.023806+00
1163	161	40	2026-03-22 21:15:32.025308+00
1164	189	40	2026-03-22 21:15:32.026544+00
1173	188	42	2026-03-22 21:15:32.037493+00
1189	82	46	2026-03-22 21:15:32.068664+00
1202	146	47	2026-03-22 21:15:32.086918+00
1206	72	53	2026-03-22 21:15:32.092414+00
1209	131	53	2026-03-22 21:15:32.0957+00
1212	189	53	2026-03-22 21:15:32.099289+00
1214	190	53	2026-03-22 21:15:32.101925+00
1216	97	48	2026-03-22 21:15:32.104261+00
1220	38	49	2026-03-22 21:15:32.109025+00
1222	194	37	2026-03-22 21:15:32.111462+00
1223	196	37	2026-03-22 21:15:32.112642+00
1226	54	39	2026-03-22 21:15:32.116154+00
1229	195	41	2026-03-22 21:15:32.119772+00
1230	160	43	2026-03-22 21:15:32.121435+00
1232	196	48	2026-03-22 21:15:32.124011+00
1233	201	49	2026-03-22 21:15:32.125354+00
1241	67	36	2026-03-22 21:15:32.137925+00
1242	48	36	2026-03-22 21:15:32.139513+00
1243	49	36	2026-03-22 21:15:32.140736+00
1251	126	38	2026-03-22 21:15:32.150916+00
1253	199	38	2026-03-22 21:15:32.153655+00
1255	132	38	2026-03-22 21:15:32.156366+00
1258	143	38	2026-03-22 21:15:32.160521+00
1264	201	39	2026-03-22 21:15:32.16785+00
1268	67	50	2026-03-22 21:15:32.172497+00
1283	132	47	2026-03-22 21:15:32.190131+00
1298	148	49	2026-03-22 21:15:32.216238+00
1300	27	49	2026-03-22 21:15:32.2188+00
1305	177	49	2026-03-22 21:15:32.224978+00
1306	123	49	2026-03-22 21:15:32.226183+00
1309	33	35	2026-03-22 21:15:32.229598+00
1328	158	39	2026-03-22 21:15:32.251025+00
1334	159	40	2026-03-22 21:15:32.260306+00
1339	113	50	2026-03-22 21:15:32.2676+00
1344	123	50	2026-03-22 21:15:32.275097+00
1350	175	41	2026-03-22 21:15:32.28265+00
1352	123	41	2026-03-22 21:15:32.285094+00
1355	113	42	2026-03-22 21:15:32.28864+00
1370	113	52	2026-03-22 21:15:32.30705+00
1371	171	52	2026-03-22 21:15:32.308318+00
1372	24	52	2026-03-22 21:15:32.309571+00
1373	173	52	2026-03-22 21:15:32.310812+00
1376	33	52	2026-03-22 21:15:32.31523+00
1387	33	53	2026-03-22 21:15:32.329582+00
1388	123	53	2026-03-22 21:15:32.331064+00
1391	148	63	2026-03-22 21:15:32.334281+00
1392	113	63	2026-03-22 21:15:32.335706+00
1393	97	63	2026-03-22 21:15:32.337006+00
1394	158	63	2026-03-22 21:15:32.338311+00
1395	159	63	2026-03-22 21:15:32.339654+00
1396	171	63	2026-03-22 21:15:32.340884+00
1397	24	63	2026-03-22 21:15:32.341956+00
1398	172	63	2026-03-22 21:15:32.343191+00
1399	173	63	2026-03-22 21:15:32.344507+00
1400	102	63	2026-03-22 21:15:32.345768+00
1401	30	63	2026-03-22 21:15:32.346969+00
1402	31	63	2026-03-22 21:15:32.348136+00
1403	175	63	2026-03-22 21:15:32.349501+00
1404	33	63	2026-03-22 21:15:32.350791+00
1405	34	63	2026-03-22 21:15:32.352365+00
1406	176	63	2026-03-22 21:15:32.354114+00
1407	205	63	2026-03-22 21:15:32.355551+00
1408	37	63	2026-03-22 21:15:32.356946+00
1409	206	63	2026-03-22 21:15:32.358162+00
1410	9	64	2026-03-22 21:15:32.359517+00
1413	208	35	2026-03-22 21:15:32.364086+00
1416	25	36	2026-03-22 21:15:32.368177+00
1417	145	36	2026-03-22 21:15:32.369399+00
1419	44	38	2026-03-22 21:15:32.371689+00
1420	72	39	2026-03-22 21:15:32.372781+00
1421	25	39	2026-03-22 21:15:32.374051+00
1422	131	39	2026-03-22 21:15:32.375173+00
1423	137	39	2026-03-22 21:15:32.376374+00
1424	142	39	2026-03-22 21:15:32.377629+00
1427	145	39	2026-03-22 21:15:32.381923+00
1428	146	39	2026-03-22 21:15:32.38332+00
1431	73	65	2026-03-22 21:15:32.386622+00
1432	131	65	2026-03-22 21:15:32.388029+00
1435	146	54	2026-03-22 21:15:32.391839+00
1438	208	41	2026-03-22 21:15:32.395658+00
1449	208	44	2026-03-22 21:15:32.407974+00
1452	91	60	2026-03-22 21:15:32.411412+00
1453	208	45	2026-03-22 21:15:32.412608+00
1455	146	52	2026-03-22 21:15:32.414939+00
1458	137	47	2026-03-22 21:15:32.418769+00
1459	142	47	2026-03-22 21:15:32.420115+00
1463	93	47	2026-03-22 21:15:32.42586+00
1465	211	47	2026-03-22 21:15:32.428367+00
1466	208	48	2026-03-22 21:15:32.429789+00
1472	84	57	2026-03-22 21:15:32.437244+00
1484	129	38	2026-03-22 21:15:32.451534+00
1492	137	38	2026-03-22 21:15:32.460257+00
1493	138	38	2026-03-22 21:15:32.461949+00
1494	142	38	2026-03-22 21:15:32.467519+00
1499	212	39	2026-03-22 21:15:32.473766+00
1522	212	43	2026-03-22 21:15:32.500587+00
1526	132	44	2026-03-22 21:15:32.506106+00
1539	69	48	2026-03-22 21:15:32.522394+00
\.


--
-- Data for Name: herbs; Type: TABLE DATA; Schema: herbal; Owner: -
--

COPY herbal.herbs (id, latin_name, common_name, created_at) FROM stdin;
219	Alchemilla spp.	Lady's Mantle	2026-04-06 21:33:58.34407+00
220	Krameria triandra	Rhatany	2026-04-06 21:33:58.34407+00
296	Hydrangea arborescens	hydrangea	2026-04-10 20:58:36.064973+00
302	Melaleuca spp.	Tea tree	2026-04-10 20:58:36.064973+00
268	Populus balsamifera var. balsamifera	Balm of Gilead	2026-04-10 20:55:21.608297+00
309	Anemopsis californica	yerba mansa	2026-04-12 15:59:34.804125+00
313	Sassafras albidum	sassafras	2026-04-12 15:59:34.804125+00
320	Prunus persica	peach	2026-04-12 15:59:34.804125+00
221	Echinacea angustifolia	Narrow-leaf Echinacea	2026-04-06 21:56:27.332838+00
222	Phyllanthus amarus	Stonebreaker	2026-04-06 21:56:27.332838+00
223	Rehmannia glutinosa	Rehmannia	2026-04-06 21:56:27.332838+00
224	Bupleurum falcatum	Bupleurum	2026-04-06 21:56:27.332838+00
225	Astragalus membranaceus	Astragalus	2026-04-06 21:56:27.332838+00
226	Lentinus edodes	Shiitake	2026-04-06 21:56:27.332838+00
227	Picrorrhiza kurroa	Kutki	2026-04-06 21:56:27.332838+00
228	Ranunculus ficaria	Pilewort	2026-04-06 21:56:27.332838+00
274	Ligustrum lucidum	Privet	2026-04-10 20:55:36.403551+00
271	Codonopsis tangshen	Codonopsis	2026-04-10 20:55:36.403551+00
1	Acanthopanax sessiliflorum	Wu Jia Pi	2026-03-22 21:15:28.845147+00
2	Albizzia julibrissin	Silk Tree	2026-03-22 21:15:28.845147+00
3	Aralia elata	Japanese Angelica Tree	2026-03-22 21:15:28.845147+00
4	Aralia manshurica	Manchurian Aralia	2026-03-22 21:15:28.845147+00
5	Aralia schmidtii	Sakhalin Spikenard	2026-03-22 21:15:28.845147+00
6	Cicer arietinum	Chickpea	2026-03-22 21:15:28.845147+00
7	Codonoposis pilosula	Dang Shen	2026-03-22 21:15:28.845147+00
8	Echinopanax elatus	Asian Devil’s Club	2026-03-22 21:15:28.845147+00
9	Eleutherococcus senticosus	Siberian Ginseng	2026-03-22 21:15:28.845147+00
10	Eucommia ulmoides	Hardy Rubber Tree	2026-03-22 21:15:28.845147+00
11	Ganoderma lucidum	Reishi Mushroom	2026-03-22 21:15:28.845147+00
12	Hoppea dichotoma Leuzea carthamoides	Maral Root	2026-03-22 21:15:28.845147+00
13	Ocimum sanctum	Holy Basil	2026-03-22 21:15:28.845147+00
14	Panax ginseng	Korean Ginseng	2026-03-22 21:15:28.845147+00
15	Panax quinquefolius	American Ginseng	2026-03-22 21:15:28.845147+00
16	Rhodiola rosea	Roseroot Stonecrop	2026-03-22 21:15:28.845147+00
17	Schisandra chinensis	Schizandra	2026-03-22 21:15:28.845147+00
18	Tinospora cordifolia	Guduchi	2026-03-22 21:15:28.845147+00
19	Trichopus zeylanicus	Arogyappacha	2026-03-22 21:15:28.845147+00
20	Withania somnifera	Ashwaganda	2026-03-22 21:15:28.845147+00
21	Allium sativum	Garlic	2026-03-22 21:15:28.845147+00
22	Arctium lappa	Burdock	2026-03-22 21:15:28.845147+00
23	Baptisia tinctoria	Wild Indigo	2026-03-22 21:15:28.845147+00
24	Chionanthus virginicus	Fringetree	2026-03-22 21:15:28.845147+00
25	Cimicifuga racemosa	Black Cohosh	2026-03-22 21:15:28.845147+00
26	Echinacea spp.	Echinacea	2026-03-22 21:15:28.845147+00
27	Fumaria officinalis	Fumitory	2026-03-22 21:15:28.845147+00
28	Galium aparine	Cleavers	2026-03-22 21:15:28.845147+00
29	Guaiacum officinale	Guaiacum	2026-03-22 21:15:28.845147+00
30	Hydrastis canadensis	Goldenseal	2026-03-22 21:15:28.845147+00
31	Iris versicolor	Blue Flag	2026-03-22 21:15:28.845147+00
32	Larrea tridentata	Chaparral	2026-03-22 21:15:28.845147+00
33	Mahonia aquifolium	Oregon Grape	2026-03-22 21:15:28.845147+00
34	Menyanthes trifoliata	Bogbean	2026-03-22 21:15:28.845147+00
35	Phytolacca americana	Poke	2026-03-22 21:15:28.845147+00
36	Pulsatilla vulgaris	Pasqueflower	2026-03-22 21:15:28.845147+00
37	Rumex crispus	Yellow Dock	2026-03-22 21:15:28.845147+00
38	Sanguinaria canadensis	Bloodroot	2026-03-22 21:15:28.845147+00
39	Scrophularia nodosa	Figwort	2026-03-22 21:15:28.845147+00
40	Smilax spp.	Sarsaparilla	2026-03-22 21:15:28.845147+00
41	Stillingia sylvatica	Queen’s Delight	2026-03-22 21:15:28.845147+00
42	Trifolium pratense	Red Clover	2026-03-22 21:15:28.845147+00
43	Urtica dioica	Nettles	2026-03-22 21:15:28.845147+00
44	Achillea millefolium	Yarrow	2026-03-22 21:15:28.845147+00
45	Althaea officinalis	Marshmallow	2026-03-22 21:15:28.845147+00
46	Arctostaphylos uva-ursi	Bearberry	2026-03-22 21:15:28.845147+00
47	Capsicum annuum	Cayenne	2026-03-22 21:15:28.845147+00
48	Cetraria islandica	Iceland Moss	2026-03-22 21:15:28.845147+00
49	Chondrus crispus	Irish Moss	2026-03-22 21:15:28.845147+00
50	Eupatorium perfoliatum	Boneset	2026-03-22 21:15:28.845147+00
51	Euphrasia spp.	Eyebright	2026-03-22 21:15:28.845147+00
52	Geranium maculatum	Cranesbill	2026-03-22 21:15:28.845147+00
53	Hyssopus officinalis	Hyssop	2026-03-22 21:15:28.845147+00
54	Inula helenium	Elecampane	2026-03-22 21:15:28.845147+00
55	Mentha piperita	Peppermint	2026-03-22 21:15:28.845147+00
56	Salvia officinalis	Sage	2026-03-22 21:15:28.845147+00
57	Sambucus nigra	Elder	2026-03-22 21:15:28.845147+00
58	Solidago virgaurea	Goldenrod	2026-03-22 21:15:28.845147+00
59	Thymus vulgaris	Thyme	2026-03-22 21:15:28.845147+00
60	Tussilago farfara	Coltsfoot	2026-03-22 21:15:28.845147+00
61	Verbascum thapsus	Mullein	2026-03-22 21:15:28.845147+00
62	Aesculus hippocastanum	Horse Chestnut	2026-03-22 21:15:28.845147+00
63	Alchemilla arvensis	Lady’s Mantle	2026-03-22 21:15:28.845147+00
64	Anethum graveolens	Dill	2026-03-22 21:15:28.845147+00
65	Angelica archangelica	Angelica	2026-03-22 21:15:28.845147+00
66	Apium graveolens	Celery Seed	2026-03-22 21:15:28.845147+00
67	Asclepias tuberosa	Pleurisy Root	2026-03-22 21:15:28.845147+00
68	Betula spp.	Birch	2026-03-22 21:15:28.845147+00
69	Borago officinalis	Borage	2026-03-22 21:15:28.845147+00
70	Calendula officinalis	Calendula	2026-03-22 21:15:28.845147+00
71	Capsella bursa-pastoris	Shepherd’s Purse	2026-03-22 21:15:28.845147+00
72	Caulophyllum thalictroides	Blue Cohosh	2026-03-22 21:15:28.845147+00
73	Crataegus spp.	Hawthorn	2026-03-22 21:15:28.845147+00
74	Dioscorea villosa	Wild Yam	2026-03-22 21:15:28.845147+00
75	Filipendula ulmaria	Meadowsweet	2026-03-22 21:15:28.845147+00
76	Foeniculum vulgare	Fennel	2026-03-22 21:15:28.845147+00
77	Gaultheria procumbens	Wintergreen	2026-03-22 21:15:28.845147+00
78	Glycyrrhiza glabra	Licorice	2026-03-22 21:15:28.845147+00
79	Hamamelis virginiana	Witch Hazel	2026-03-22 21:15:28.845147+00
80	Harpagophytum procumbens	Devil’s Claw	2026-03-22 21:15:28.845147+00
81	Hypericum perforatum	St. John’s Wort	2026-03-22 21:15:28.845147+00
82	Lavandula spp.	Lavender	2026-03-22 21:15:28.845147+00
83	Malva sylvestris	Mallow	2026-03-22 21:15:28.845147+00
84	Matricaria recutita	Chamomile	2026-03-22 21:15:28.845147+00
85	Plantago major	Plantain	2026-03-22 21:15:28.845147+00
86	Populus tremuloides	Aspen	2026-03-22 21:15:28.845147+00
87	Salix spp.	Willow	2026-03-22 21:15:28.845147+00
88	Stellaria media	Chickweed	2026-03-22 21:15:28.845147+00
89	Symphytum officinale	Comfrey	2026-03-22 21:15:28.845147+00
90	Tilia platyphyllos	Linden	2026-03-22 21:15:28.845147+00
91	Trigonella foenum-graecum	Fenugreek	2026-03-22 21:15:28.845147+00
92	Ulmus rubra	Slippery Elm	2026-03-22 21:15:28.845147+00
93	Viburnum opulus	Cramp Bark	2026-03-22 21:15:28.845147+00
94	Viburnum prunifolium	Black Haw	2026-03-22 21:15:28.845147+00
95	Zea mays	Corn Silk	2026-03-22 21:15:28.845147+00
96	Artemisia abrotanum	Southernwood	2026-03-22 21:15:28.845147+00
97	Artemisia absinthium	Wormwood	2026-03-22 21:15:28.845147+00
98	Carum carvi	Caraway	2026-03-22 21:15:28.845147+00
99	Commiphora molmol	Myrrh	2026-03-22 21:15:28.845147+00
100	Coriandrum sativum	Coriander	2026-03-22 21:15:28.845147+00
101	Eucalyptus spp.	Eucalyptus	2026-03-22 21:15:28.845147+00
102	Gentiana lutea	Gentian	2026-03-22 21:15:28.845147+00
103	Juniperus communis	Juniper	2026-03-22 21:15:28.845147+00
104	Ligusticum porteri	Osha	2026-03-22 21:15:28.845147+00
105	Myroxylon balsamum var. pereirae	Balsam Of Peru	2026-03-22 21:15:28.845147+00
106	Olea europaea	Olive	2026-03-22 21:15:28.845147+00
107	Origanum majorana	Marjoram	2026-03-22 21:15:28.845147+00
108	Pimpinella anisum	Aniseed	2026-03-22 21:15:28.845147+00
109	Rosmarinus officinalis	Rosemary	2026-03-22 21:15:28.845147+00
110	Ruta graveolens	Rue	2026-03-22 21:15:28.845147+00
111	Syzygium aromaticum	Clove	2026-03-22 21:15:28.845147+00
112	Usnea spp.	Usnea	2026-03-22 21:15:28.845147+00
113	Armoracia rusticana	Horseradish	2026-03-22 21:15:28.845147+00
114	Arnica montana	Arnica	2026-03-22 21:15:28.845147+00
115	Artemisia vulgaris	Mugwort	2026-03-22 21:15:28.845147+00
116	Brassica spp.	Mustard	2026-03-22 21:15:28.845147+00
117	Eupatorium purpureum	Gravel Root	2026-03-22 21:15:28.845147+00
118	Fucus vesiculosus	Kelp	2026-03-22 21:15:28.845147+00
119	Myrica cerifera	Bayberry	2026-03-22 21:15:28.845147+00
120	Petroselinum crispum	Parsley	2026-03-22 21:15:28.845147+00
121	Tanacetum parthenium	Feverfew	2026-03-22 21:15:28.845147+00
122	Taraxacum officinale	Dandelion	2026-03-22 21:15:28.845147+00
123	Zanthoxylum americanum	Prickly Ash	2026-03-22 21:15:28.845147+00
124	Zingiber officinale	Ginger	2026-03-22 21:15:28.845147+00
125	Daucus carota	Wild Carrot	2026-03-22 21:15:28.845147+00
126	Drosera rotundifolia	Sundew	2026-03-22 21:15:28.845147+00
127	Elettaria cardamomum	Cardamom	2026-03-22 21:15:28.845147+00
128	Eschscholzia californica	California Poppy	2026-03-22 21:15:28.845147+00
129	Humulus lupulus	Hops	2026-03-22 21:15:28.845147+00
130	Lactuca virosa	Wild Lettuce	2026-03-22 21:15:28.845147+00
131	Leonurus cardiaca	Motherwort	2026-03-22 21:15:28.845147+00
132	Lobelia inflata	Lobelia	2026-03-22 21:15:28.845147+00
133	Lycopus spp.	Bugleweed	2026-03-22 21:15:28.845147+00
134	Melissa officinalis	Lemon Balm	2026-03-22 21:15:28.845147+00
135	Mentha pulegium	Pennyroyal	2026-03-22 21:15:28.845147+00
136	Nepeta cataria	Catnip	2026-03-22 21:15:28.845147+00
137	Passiflora incarnata	Passionflower	2026-03-22 21:15:28.845147+00
138	Piper methysticum	Kava	2026-03-22 21:15:28.845147+00
139	Piscidia erythrina	Jamaica Dogwood	2026-03-22 21:15:28.845147+00
140	Prunus serotina	Wild Cherry Bark	2026-03-22 21:15:28.845147+00
141	Salvia officinalis var. rubia	Red Sage	2026-03-22 21:15:28.845147+00
142	Scutellaria lateriflora	Skullcap	2026-03-22 21:15:28.845147+00
143	Symplocarpus foetidus	Skunk Cabbage	2026-03-22 21:15:28.845147+00
144	Turnera diffusa	Damiana	2026-03-22 21:15:28.845147+00
145	Valeriana officinalis	Valerian	2026-03-22 21:15:28.845147+00
146	Verbena officinalis	Vervain	2026-03-22 21:15:28.845147+00
147	Acacia catechu	Black Catechu	2026-03-22 21:15:28.845147+00
148	Agrimonia eupatoria	Agrimony	2026-03-22 21:15:28.845147+00
149	Camellia sinensis	Tea	2026-03-22 21:15:28.845147+00
150	Cola acuminata	Kola	2026-03-22 21:15:28.845147+00
151	Equisetum arvense	Horsetail	2026-03-22 21:15:28.845147+00
152	Polygonum bistorta	Bistort	2026-03-22 21:15:28.845147+00
153	Quercus spp.	Oak	2026-03-22 21:15:28.845147+00
154	Rheum palmatum	Rhubarb	2026-03-22 21:15:28.845147+00
155	Rubus idaeus	Raspberry	2026-03-22 21:15:28.845147+00
156	Rubus villosus	Blackberry	2026-03-22 21:15:28.845147+00
157	Vinca major	Periwinkle	2026-03-22 21:15:28.845147+00
158	Berberis vulgaris	Barberry	2026-03-22 21:15:28.845147+00
159	Centaurium erythraea	Centaury	2026-03-22 21:15:28.845147+00
160	Marrubium vulgare	Horehound	2026-03-22 21:15:28.845147+00
161	Tanacetum vulgare	Tansy	2026-03-22 21:15:28.845147+00
162	Coleus forskohlii	Coleus	2026-03-22 21:15:28.845147+00
163	Convallaria majalis	Lily Of The Valley	2026-03-22 21:15:28.845147+00
164	Cytisus scoparius	Scotch Broom	2026-03-22 21:15:28.845147+00
165	Ginkgo biloba	Ginkgo	2026-03-22 21:15:28.845147+00
166	Urginea maritima	Squill	2026-03-22 21:15:28.845147+00
167	Cinnamomum spp.	Cinnamon	2026-03-22 21:15:28.845147+00
168	Eucalyptus globulus	Eucalyptus	2026-03-22 21:15:28.845147+00
169	Thymus spp.	Thyme	2026-03-22 21:15:28.845147+00
170	Chelidonium majus	Celandine	2026-03-22 21:15:28.845147+00
171	Chelone glabra	Balmony	2026-03-22 21:15:28.845147+00
172	Cynara scolymus	Artichoke	2026-03-22 21:15:28.845147+00
173	Euonymus atropurpureus	Wahoo	2026-03-22 21:15:28.845147+00
174	Juglans cinerea	Butternut	2026-03-22 21:15:28.845147+00
175	Leptandra virginica	Black Root	2026-03-22 21:15:28.845147+00
176	Peumus boldus	Boldo	2026-03-22 21:15:28.845147+00
177	Taraxacum officinale root	Dandelion	2026-03-22 21:15:28.845147+00
178	Avena sativa	Oat	2026-03-22 21:15:28.845147+00
179	Elymus repens	Couch Grass	2026-03-22 21:15:28.845147+00
180	Linum usitatissimum	Flax	2026-03-22 21:15:28.845147+00
181	Agathosma betulina	Buchu	2026-03-22 21:15:28.845147+00
182	Collinsonia canadensis	Stoneroot	2026-03-22 21:15:28.845147+00
183	Cucurbita pepo	Pumpkin	2026-03-22 21:15:28.845147+00
184	Eryngium maritimum	Sea Holly	2026-03-22 21:15:28.845147+00
185	Parietaria judaica	Pellitory Of The Wall	2026-03-22 21:15:28.845147+00
186	Serenoa repens	Saw Palmetto	2026-03-22 21:15:28.845147+00
187	Marsdenia condurango	Condurango	2026-03-22 21:15:28.845147+00
188	Mitchella repens	Partridgeberry	2026-03-22 21:15:28.845147+00
189	Tropaeolum majus	Nasturtium	2026-03-22 21:15:28.845147+00
190	Vitex agnus-castus	Chasteberry	2026-03-22 21:15:28.845147+00
191	Bellis perennis	English Daisy	2026-03-22 21:15:28.845147+00
192	Cephaelis ipecacuanha	Ipecac	2026-03-22 21:15:28.845147+00
193	Hieracium pilosella	Mouse Ear	2026-03-22 21:15:28.845147+00
194	Myroxylon balsamum var. balsamum	Tolu Balsam	2026-03-22 21:15:28.845147+00
195	Polygala senega	Seneca Snakeroot	2026-03-22 21:15:28.845147+00
196	Populus candicans	Balm Of Gilead	2026-03-22 21:15:28.845147+00
197	Primula veris	Cowslip	2026-03-22 21:15:28.845147+00
198	Viola odorata	Sweet Violet	2026-03-22 21:15:28.845147+00
199	Grindelia camporum	Gumweed	2026-03-22 21:15:28.845147+00
200	Pulmonaria officinalis	Lungwort	2026-03-22 21:15:28.845147+00
201	Thuja occidentalis	Thuja	2026-03-22 21:15:28.845147+00
202	Aloe vera	Aloe	2026-03-22 21:15:28.845147+00
203	Curcuma longa	Turmeric	2026-03-22 21:15:28.845147+00
204	Rhamnus cathartica	Buckthorn	2026-03-22 21:15:28.845147+00
205	Rhamnus purshiana	Cascara Sagrada	2026-03-22 21:15:28.845147+00
206	Silybum marianum	Milk Thistle	2026-03-22 21:15:28.845147+00
207	Stachys officinalis	Wood Betony	2026-03-22 21:15:28.845147+00
208	Allium cepa	Onion	2026-03-22 21:15:28.845147+00
209	A.sativum	Garlic	2026-03-22 21:15:28.845147+00
210	Fagopyrum esculentum	Buckwheat	2026-03-22 21:15:28.845147+00
211	Viscum album	Mistletoe	2026-03-22 21:15:28.845147+00
212	Ballota nigra	Black Horehound	2026-03-22 21:15:28.845147+00
213	Chamaemelum nobile	Roman Chamomile	2026-03-22 21:15:28.845147+00
214	Stachys betonica	Wood Betony	2026-03-22 21:15:28.845147+00
215	Panax spp.	Ginseng	2026-03-22 21:15:28.845147+00
216	Senna alexandrina	Senna	2026-03-22 21:15:28.845147+00
217	Coffea arabica	Coffee	2026-03-22 21:15:28.845147+00
218	Paullinia cupana	Guarana	2026-03-22 21:15:28.845147+00
288	Juglans nigra	black walnut	2026-04-10 20:56:04.197894+00
291	Tabebuia impetiginosa	Pau d'arco	2026-04-10 20:56:04.197894+00
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
63	Moderate	2026-03-22 21:15:28.855694+00
64	Adaptogen	2026-03-22 21:15:28.855694+00
65	Cardiotonic	2026-03-22 21:15:28.855694+00
\.


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.action_descriptions_id_seq', 301, true);


--
-- Name: body_systems_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.body_systems_id_seq', 17, true);


--
-- Name: disorder_action_herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_action_herbs_id_seq', 241, true);


--
-- Name: disorder_actions_indicated_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_actions_indicated_id_seq', 125, true);


--
-- Name: disorder_notes_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_notes_id_seq', 58, true);


--
-- Name: disorder_prescriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_prescriptions_id_seq', 28, true);


--
-- Name: disorder_specific_remedies_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorder_specific_remedies_id_seq', 161, true);


--
-- Name: disorders_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.disorders_id_seq', 51, true);


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herb_primary_actions_id_seq', 1039, true);


--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herb_secondary_actions_id_seq', 1541, true);


--
-- Name: herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.herbs_id_seq', 323, true);


--
-- Name: prescription_herb_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.prescription_herb_actions_id_seq', 149, true);


--
-- Name: prescription_herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.prescription_herbs_id_seq', 107, true);


--
-- Name: primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.primary_actions_id_seq', 89, true);


--
-- Name: secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: -
--

SELECT pg_catalog.setval('herbal.secondary_actions_id_seq', 65, true);


--
-- Name: action_descriptions action_descriptions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.action_descriptions
    ADD CONSTRAINT action_descriptions_pkey PRIMARY KEY (id);


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
-- Name: herb_secondary_actions herb_secondary_actions_herb_id_secondary_action_id_key; Type: CONSTRAINT; Schema: herbal; Owner: -
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_herb_id_secondary_action_id_key UNIQUE (herb_id, secondary_action_id);


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
-- Name: idx_action_descriptions_action; Type: INDEX; Schema: herbal; Owner: -
--

CREATE INDEX idx_action_descriptions_action ON herbal.action_descriptions USING btree (primary_action_id);


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
-- PostgreSQL database dump complete
--

\unrestrict 7HmbIYDe1K0JLEdE0HV2MfjfekmaNcv0eQGwOjJvdNZt3qoRb5zQFo3sFyDH9Bs

