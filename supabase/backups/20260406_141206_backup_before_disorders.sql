--
-- PostgreSQL database dump
--

\restrict CvkWgYkkvicseNUe4FiR86ToYanydrglk87Ky7fK4lAiEo68eXHogPU6PPP3Gjz

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO postgres;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: herbal; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA herbal;


ALTER SCHEMA herbal OWNER TO postgres;

--
-- Name: SCHEMA herbal; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA herbal IS 'Schema for herbal medicine visualization data';


--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: strength_level; Type: TYPE; Schema: herbal; Owner: postgres
--

CREATE TYPE herbal.strength_level AS ENUM (
    'mild',
    'strong',
    'very_strong'
);


ALTER TYPE herbal.strength_level OWNER TO postgres;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _realtime.extensions OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
    max_presence_events_per_second integer DEFAULT 1000,
    max_payload_size_in_kb integer DEFAULT 3000,
    max_client_presence_events_per_window integer,
    client_presence_window_ms integer,
    presence_enabled boolean DEFAULT false NOT NULL,
    CONSTRAINT jwt_secret_or_jwt_jwks_required CHECK (((jwt_secret IS NOT NULL) OR (jwt_jwks IS NOT NULL)))
);


ALTER TABLE _realtime.tenants OWNER TO supabase_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: action_descriptions; Type: TABLE; Schema: herbal; Owner: postgres
--

CREATE TABLE herbal.action_descriptions (
    id integer NOT NULL,
    primary_action_id integer,
    description text NOT NULL,
    sort_order integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE herbal.action_descriptions OWNER TO postgres;

--
-- Name: TABLE action_descriptions; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON TABLE herbal.action_descriptions IS 'Descriptive bullet points for primary actions';


--
-- Name: COLUMN action_descriptions.sort_order; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON COLUMN herbal.action_descriptions.sort_order IS 'Order in which descriptions should be displayed';


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.action_descriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.action_descriptions_id_seq OWNER TO postgres;

--
-- Name: action_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.action_descriptions_id_seq OWNED BY herbal.action_descriptions.id;


--
-- Name: body_systems; Type: TABLE; Schema: herbal; Owner: postgres
--

CREATE TABLE herbal.body_systems (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE herbal.body_systems OWNER TO postgres;

--
-- Name: TABLE body_systems; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON TABLE herbal.body_systems IS 'Body systems affected by herbs';


--
-- Name: body_systems_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.body_systems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.body_systems_id_seq OWNER TO postgres;

--
-- Name: body_systems_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.body_systems_id_seq OWNED BY herbal.body_systems.id;


--
-- Name: herb_primary_actions; Type: TABLE; Schema: herbal; Owner: postgres
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


ALTER TABLE herbal.herb_primary_actions OWNER TO postgres;

--
-- Name: COLUMN herb_primary_actions.body_system_id; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON COLUMN herbal.herb_primary_actions.body_system_id IS 'Body system affected (NULL if no specific body system affinity)';


--
-- Name: COLUMN herb_primary_actions.relative_strength; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON COLUMN herbal.herb_primary_actions.relative_strength IS 'Strength rating: mild, strong, or very_strong';


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.herb_primary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.herb_primary_actions_id_seq OWNER TO postgres;

--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.herb_primary_actions_id_seq OWNED BY herbal.herb_primary_actions.id;


--
-- Name: herb_secondary_actions; Type: TABLE; Schema: herbal; Owner: postgres
--

CREATE TABLE herbal.herb_secondary_actions (
    id integer NOT NULL,
    herb_id integer,
    secondary_action_id integer,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE herbal.herb_secondary_actions OWNER TO postgres;

--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.herb_secondary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.herb_secondary_actions_id_seq OWNER TO postgres;

--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.herb_secondary_actions_id_seq OWNED BY herbal.herb_secondary_actions.id;


--
-- Name: herbs; Type: TABLE; Schema: herbal; Owner: postgres
--

CREATE TABLE herbal.herbs (
    id integer NOT NULL,
    latin_name text NOT NULL,
    common_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE herbal.herbs OWNER TO postgres;

--
-- Name: TABLE herbs; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON TABLE herbal.herbs IS 'Medicinal herbs with Latin and common names';


--
-- Name: herbs_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.herbs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.herbs_id_seq OWNER TO postgres;

--
-- Name: herbs_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.herbs_id_seq OWNED BY herbal.herbs.id;


--
-- Name: primary_actions; Type: TABLE; Schema: herbal; Owner: postgres
--

CREATE TABLE herbal.primary_actions (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE herbal.primary_actions OWNER TO postgres;

--
-- Name: TABLE primary_actions; Type: COMMENT; Schema: herbal; Owner: postgres
--

COMMENT ON TABLE herbal.primary_actions IS 'Primary herbal action categories (Alteratives, Adaptogens, etc.)';


--
-- Name: primary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.primary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.primary_actions_id_seq OWNER TO postgres;

--
-- Name: primary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.primary_actions_id_seq OWNED BY herbal.primary_actions.id;


--
-- Name: secondary_actions; Type: TABLE; Schema: herbal; Owner: postgres
--

CREATE TABLE herbal.secondary_actions (
    id integer NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE herbal.secondary_actions OWNER TO postgres;

--
-- Name: secondary_actions_id_seq; Type: SEQUENCE; Schema: herbal; Owner: postgres
--

CREATE SEQUENCE herbal.secondary_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE herbal.secondary_actions_id_seq OWNER TO postgres;

--
-- Name: secondary_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: herbal; Owner: postgres
--

ALTER SEQUENCE herbal.secondary_actions_id_seq OWNED BY herbal.secondary_actions.id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_04_05; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_05 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_06; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_06 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_06 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_07; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_07 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_07 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_08; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_08 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_08 OWNER TO supabase_admin;

--
-- Name: messages_2026_04_09; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_04_09 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_04_09 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    catalog_id uuid NOT NULL
);


ALTER TABLE storage.iceberg_namespaces OWNER TO supabase_storage_admin;

--
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    remote_table_id text,
    shard_key text,
    shard_id text,
    catalog_id uuid NOT NULL
);


ALTER TABLE storage.iceberg_tables OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: messages_2026_04_05; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_05 FOR VALUES FROM ('2026-04-05 00:00:00') TO ('2026-04-06 00:00:00');


--
-- Name: messages_2026_04_06; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00') TO ('2026-04-07 00:00:00');


--
-- Name: messages_2026_04_07; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_07 FOR VALUES FROM ('2026-04-07 00:00:00') TO ('2026-04-08 00:00:00');


--
-- Name: messages_2026_04_08; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_08 FOR VALUES FROM ('2026-04-08 00:00:00') TO ('2026-04-09 00:00:00');


--
-- Name: messages_2026_04_09; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_09 FOR VALUES FROM ('2026-04-09 00:00:00') TO ('2026-04-10 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: action_descriptions id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.action_descriptions ALTER COLUMN id SET DEFAULT nextval('herbal.action_descriptions_id_seq'::regclass);


--
-- Name: body_systems id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.body_systems ALTER COLUMN id SET DEFAULT nextval('herbal.body_systems_id_seq'::regclass);


--
-- Name: herb_primary_actions id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_primary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.herb_primary_actions_id_seq'::regclass);


--
-- Name: herb_secondary_actions id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_secondary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.herb_secondary_actions_id_seq'::regclass);


--
-- Name: herbs id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herbs ALTER COLUMN id SET DEFAULT nextval('herbal.herbs_id_seq'::regclass);


--
-- Name: primary_actions id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.primary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.primary_actions_id_seq'::regclass);


--
-- Name: secondary_actions id; Type: DEFAULT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.secondary_actions ALTER COLUMN id SET DEFAULT nextval('herbal.secondary_actions_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
44e624dc-c2a9-47e0-9b59-7c965f7eb02b	postgres_cdc_rls	{"region": "us-east-1", "db_host": "uOg1r8r2qolaGRFsENOOb4bGQ7K2er8QzShIhZ7INd4=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2026-04-06 20:34:56	2026-04-06 20:34:56
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2026-03-22 21:39:49
20220329161857	2026-03-22 21:39:49
20220410212326	2026-03-22 21:39:49
20220506102948	2026-03-22 21:39:49
20220527210857	2026-03-22 21:39:49
20220815211129	2026-03-22 21:39:49
20220815215024	2026-03-22 21:39:49
20220818141501	2026-03-22 21:39:49
20221018173709	2026-03-22 21:39:49
20221102172703	2026-03-22 21:39:49
20221223010058	2026-03-22 21:39:49
20230110180046	2026-03-22 21:39:49
20230810220907	2026-03-22 21:39:49
20230810220924	2026-03-22 21:39:49
20231024094642	2026-03-22 21:39:49
20240306114423	2026-03-22 21:39:49
20240418082835	2026-03-22 21:39:49
20240625211759	2026-03-22 21:39:49
20240704172020	2026-03-22 21:39:49
20240902173232	2026-03-22 21:39:49
20241106103258	2026-03-22 21:39:49
20250424203323	2026-03-22 21:39:49
20250613072131	2026-03-22 21:39:49
20250711044927	2026-03-22 21:39:49
20250811121559	2026-03-22 21:39:49
20250926223044	2026-03-22 21:39:49
20251204170944	2026-03-22 21:39:49
20251218000543	2026-03-22 21:39:49
20260209232800	2026-03-22 21:39:49
20260304000000	2026-03-22 21:39:49
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter, max_presence_events_per_second, max_payload_size_in_kb, max_client_presence_events_per_window, client_presence_window_ms, presence_enabled) FROM stdin;
9dc7f3f9-bbec-4956-9e79-0f8ad3d250a4	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2026-04-06 20:34:56	2026-04-06 20:34:56	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"x": "M5Sjqn5zwC9Kl1zVfUUGvv9boQjCGd45G8sdopBExB4", "y": "P6IXMvA2WYXSHSOMTBH2jsw_9rrzGy89FjPf6oOsIxQ", "alg": "ES256", "crv": "P-256", "ext": true, "kid": "b81269f1-21d8-4f2e-b719-c2240a840d90", "kty": "EC", "use": "sig", "key_ops": ["verify"]}, {"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	68	gen_rpc	1000	3000	\N	\N	f
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: action_descriptions; Type: TABLE DATA; Schema: herbal; Owner: postgres
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
-- Data for Name: body_systems; Type: TABLE DATA; Schema: herbal; Owner: postgres
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
\.


--
-- Data for Name: herb_primary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
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
55	9	1	\N	\N	\N	2026-03-22 21:15:28.877971+00
56	10	1	\N	\N	\N	2026-03-22 21:15:28.879809+00
57	11	1	\N	\N	\N	2026-03-22 21:15:28.881635+00
58	12	1	\N	\N	\N	2026-03-22 21:15:28.900256+00
59	13	1	\N	\N	\N	2026-03-22 21:15:28.903098+00
60	14	1	\N	\N	\N	2026-03-22 21:15:28.904748+00
61	15	1	\N	\N	\N	2026-03-22 21:15:28.906662+00
62	16	1	\N	\N	\N	2026-03-22 21:15:28.908764+00
63	17	1	\N	\N	\N	2026-03-22 21:15:28.910856+00
64	18	1	\N	\N	\N	2026-03-22 21:15:28.913147+00
65	19	1	\N	\N	\N	2026-03-22 21:15:28.915547+00
66	20	1	\N	\N	\N	2026-03-22 21:15:28.917424+00
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
377	119	8	\N	\N	strong	2026-03-22 21:15:29.448248+00
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
408	84	9	\N	\N	mild	2026-03-22 21:15:29.488182+00
409	34	9	14	Anything that helps with digestion and assimilation of food will benefit the musculoskeletal system. A bitter that is particularly valuable for this system is Menyanthes trifoliata	\N	2026-03-22 21:15:29.489522+00
410	110	9	11	takes into account the liver and pancreas as organs of the digestive system	strong	2026-03-22 21:15:29.490692+00
411	110	9	13	Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy	strong	2026-03-22 21:15:29.492108+00
412	161	9	\N	\N	strong	2026-03-22 21:15:29.493362+00
413	122	9	\N	\N	mild	2026-03-22 21:15:29.494772+00
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
696	24	19	\N	\N	\N	2026-03-22 21:15:29.983716+00
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
722	206	19	\N	\N	\N	2026-03-22 21:15:30.016901+00
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
\.


--
-- Data for Name: herb_secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
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
-- Data for Name: herbs; Type: TABLE DATA; Schema: herbal; Owner: postgres
--

COPY herbal.herbs (id, latin_name, common_name, created_at) FROM stdin;
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
\.


--
-- Data for Name: primary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
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
\.


--
-- Data for Name: secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres
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
-- Data for Name: messages_2026_04_05; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_05 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_06; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_06 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_07; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_07 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_08; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_08 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_09; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_04_09 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-03-22 21:39:49
20211116045059	2026-03-22 21:39:49
20211116050929	2026-03-22 21:39:49
20211116051442	2026-03-22 21:39:49
20211116212300	2026-03-22 21:39:49
20211116213355	2026-03-22 21:39:49
20211116213934	2026-03-22 21:39:49
20211116214523	2026-03-22 21:39:49
20211122062447	2026-03-22 21:39:49
20211124070109	2026-03-22 21:39:49
20211202204204	2026-03-22 21:39:49
20211202204605	2026-03-22 21:39:49
20211210212804	2026-03-22 21:39:49
20211228014915	2026-03-22 21:39:49
20220107221237	2026-03-22 21:39:49
20220228202821	2026-03-22 21:39:49
20220312004840	2026-03-22 21:39:49
20220603231003	2026-03-22 21:39:49
20220603232444	2026-03-22 21:39:49
20220615214548	2026-03-22 21:39:49
20220712093339	2026-03-22 21:39:49
20220908172859	2026-03-22 21:39:49
20220916233421	2026-03-22 21:39:49
20230119133233	2026-03-22 21:39:49
20230128025114	2026-03-22 21:39:49
20230128025212	2026-03-22 21:39:49
20230227211149	2026-03-22 21:39:49
20230228184745	2026-03-22 21:39:49
20230308225145	2026-03-22 21:39:49
20230328144023	2026-03-22 21:39:49
20231018144023	2026-03-22 21:39:49
20231204144023	2026-03-22 21:39:49
20231204144024	2026-03-22 21:39:49
20231204144025	2026-03-22 21:39:49
20240108234812	2026-03-22 21:39:49
20240109165339	2026-03-22 21:39:49
20240227174441	2026-03-22 21:39:49
20240311171622	2026-03-22 21:39:49
20240321100241	2026-03-22 21:39:49
20240401105812	2026-03-22 21:39:49
20240418121054	2026-03-22 21:39:49
20240523004032	2026-03-22 21:39:49
20240618124746	2026-03-22 21:39:49
20240801235015	2026-03-22 21:39:49
20240805133720	2026-03-22 21:39:49
20240827160934	2026-03-22 21:39:49
20240919163303	2026-03-22 21:39:49
20240919163305	2026-03-22 21:39:49
20241019105805	2026-03-22 21:39:49
20241030150047	2026-03-22 21:39:49
20241108114728	2026-03-22 21:39:49
20241121104152	2026-03-22 21:39:49
20241130184212	2026-03-22 21:39:49
20241220035512	2026-03-22 21:39:49
20241220123912	2026-03-22 21:39:49
20241224161212	2026-03-22 21:39:49
20250107150512	2026-03-22 21:39:49
20250110162412	2026-03-22 21:39:49
20250123174212	2026-03-22 21:39:50
20250128220012	2026-03-22 21:39:50
20250506224012	2026-03-22 21:39:50
20250523164012	2026-03-22 21:39:50
20250714121412	2026-03-22 21:39:50
20250905041441	2026-03-22 21:39:50
20251103001201	2026-03-22 21:39:50
20251120212548	2026-03-22 21:39:50
20251120215549	2026-03-22 21:39:50
20260218120000	2026-03-22 21:39:50
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_namespaces (id, bucket_name, name, created_at, updated_at, metadata, catalog_id) FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_tables (id, namespace_id, bucket_name, name, location, created_at, updated_at, remote_table_id, shard_key, shard_id, catalog_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-03-22 21:40:00.009629
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-03-22 21:40:00.015653
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-03-22 21:40:00.017147
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-03-22 21:40:00.028937
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-03-22 21:40:00.034298
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-03-22 21:40:00.036352
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-03-22 21:40:00.038333
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-03-22 21:40:00.039801
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-03-22 21:40:00.040648
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-03-22 21:40:00.041392
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-03-22 21:40:00.042582
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-03-22 21:40:00.043748
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-03-22 21:40:00.045203
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-03-22 21:40:00.046101
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-03-22 21:40:00.047496
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-03-22 21:40:00.058027
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-03-22 21:40:00.060073
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-03-22 21:40:00.061697
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-03-22 21:40:00.06276
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-03-22 21:40:00.064165
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-03-22 21:40:00.065158
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-03-22 21:40:00.072084
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-03-22 21:40:00.085772
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-03-22 21:40:00.089035
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-03-22 21:40:00.090427
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-03-22 21:40:00.092491
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-03-22 21:40:00.093476
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-03-22 21:40:00.094795
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-03-22 21:40:00.095414
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-03-22 21:40:00.095905
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-03-22 21:40:00.096566
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-03-22 21:40:00.097293
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-03-22 21:40:00.097697
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-03-22 21:40:00.098078
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-03-22 21:40:00.098547
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-03-22 21:40:00.09892
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-03-22 21:40:00.099244
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-03-22 21:40:00.099557
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-03-22 21:40:00.100812
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-03-22 21:40:00.108516
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-03-22 21:40:00.109281
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-03-22 21:40:00.109706
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-03-22 21:40:00.110086
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-03-22 21:40:00.110487
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-03-22 21:40:00.11093
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-03-22 21:40:00.111863
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-03-22 21:40:00.117223
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-03-22 21:40:00.118886
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-03-22 21:40:00.120168
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-03-22 21:40:00.130269
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-03-22 21:40:00.131057
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-03-22 21:40:00.135848
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-03-22 21:40:00.136021
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-03-22 21:40:00.138048
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-03-22 21:40:00.139347
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-03-22 21:40:00.139643
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-03-22 21:40:00.140759
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2026-03-22 21:39:48.069607+00
20210809183423_update_grants	2026-03-22 21:39:48.069607+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
001	{"-- Create a dedicated schema for herbal medicine data\nCREATE SCHEMA IF NOT EXISTS herbal","-- Set search path to use the herbal schema\nSET search_path TO herbal, public","-- Create herbs table\nCREATE TABLE herbal.herbs (\n  id SERIAL PRIMARY KEY,\n  latin_name TEXT NOT NULL UNIQUE,\n  common_name TEXT NOT NULL,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n)","-- Create primary actions table\nCREATE TABLE herbal.primary_actions (\n  id SERIAL PRIMARY KEY,\n  name TEXT NOT NULL UNIQUE,\n  description TEXT,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n)","-- Create secondary actions table\nCREATE TABLE herbal.secondary_actions (\n  id SERIAL PRIMARY KEY,\n  name TEXT NOT NULL UNIQUE,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n)","-- Create body systems table\nCREATE TABLE herbal.body_systems (\n  id SERIAL PRIMARY KEY,\n  name TEXT NOT NULL UNIQUE,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n)","-- Create relative strength enum in the herbal schema\nCREATE TYPE herbal.strength_level AS ENUM ('mild', 'strong', 'very_strong')","-- Junction table: herbs to primary actions with body system and strength\nCREATE TABLE herbal.herb_primary_actions (\n  id SERIAL PRIMARY KEY,\n  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,\n  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,\n  body_system_id INTEGER REFERENCES herbal.body_systems(id) ON DELETE CASCADE,\n  body_system_note TEXT,\n  relative_strength herbal.strength_level,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  UNIQUE(herb_id, primary_action_id, body_system_id)\n)","-- Junction table: herbs to secondary actions\nCREATE TABLE herbal.herb_secondary_actions (\n  id SERIAL PRIMARY KEY,\n  herb_id INTEGER REFERENCES herbal.herbs(id) ON DELETE CASCADE,\n  secondary_action_id INTEGER REFERENCES herbal.secondary_actions(id) ON DELETE CASCADE,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  UNIQUE(herb_id, secondary_action_id)\n)","-- Create indexes for better query performance\nCREATE INDEX idx_herb_primary_actions_herb ON herbal.herb_primary_actions(herb_id)","CREATE INDEX idx_herb_primary_actions_action ON herbal.herb_primary_actions(primary_action_id)","CREATE INDEX idx_herb_primary_actions_system ON herbal.herb_primary_actions(body_system_id)","CREATE INDEX idx_herb_secondary_actions_herb ON herbal.herb_secondary_actions(herb_id)","CREATE INDEX idx_herb_secondary_actions_action ON herbal.herb_secondary_actions(secondary_action_id)","CREATE INDEX idx_herbs_latin_name ON herbal.herbs(latin_name)","CREATE INDEX idx_herbs_common_name ON herbal.herbs(common_name)","-- Grant permissions (adjust if you have specific roles)\nGRANT USAGE ON SCHEMA herbal TO postgres, anon, authenticated, service_role","GRANT ALL ON ALL TABLES IN SCHEMA herbal TO postgres, anon, authenticated, service_role","GRANT ALL ON ALL SEQUENCES IN SCHEMA herbal TO postgres, anon, authenticated, service_role","-- Insert body systems\nINSERT INTO herbal.body_systems (name) VALUES \n  ('Cardiovascular'),\n  ('Respiratory'),\n  ('Digestive'),\n  ('Urinary'),\n  ('Reproductive'),\n  ('Musculoskeletal'),\n  ('Nervous'),\n  ('Skin')","COMMENT ON SCHEMA herbal IS 'Schema for herbal medicine visualization data'","COMMENT ON TABLE herbal.herbs IS 'Medicinal herbs with Latin and common names'","COMMENT ON TABLE herbal.primary_actions IS 'Primary herbal action categories (Alteratives, Adaptogens, etc.)'","COMMENT ON TABLE herbal.body_systems IS 'Body systems affected by herbs'","COMMENT ON COLUMN herbal.herb_primary_actions.relative_strength IS 'Strength rating: mild, strong, or very_strong'"}	herbal_schema
002	{"-- Set schema\nSET search_path TO herbal, public","-- Insert herbs into herbal schema\nINSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (1, 'Acanthopanax sessiliflorum', 'wu jia pi') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (2, 'Albizzia julibrissin', 'silk tree') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (3, 'Aralia elata', 'Japanese angelica tree') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (4, 'A. manshurica', 'Manchurian aralia') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (5, 'Aralia schmidtii', 'Sakhalin spikenard') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (6, 'Cicer arietinum', 'chickpea') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (7, 'Codonoposis pilosula', 'dang shen') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (8, 'Echinopanax elatus', 'Asian devil’s club') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (9, 'Eleutherococcus senticosus', 'Siberian ginseng') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (10, 'Eucommia ulmoides', 'hardy rubber tree') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (11, 'Ganoderma lucidum', 'reishi mushroom') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (12, 'Hoppea dichotoma Leuzea carthamoides', 'maral root') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (13, 'Ocimum sanctum', 'holy basil') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (14, 'Panax ginseng', 'Korean ginseng') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (15, 'Panax quinquefolius', 'American ginseng') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (16, 'Rhodiola rosea', 'roseroot stonecrop') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (17, 'Schisandra chinensis', 'schizandra') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (18, 'Tinospora cordifolia', 'guduchi') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (19, 'Trichopus zeylanicus', 'arogyappacha') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (20, 'Withania somnifera', 'ashwaganda') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (21, 'Allium sativum', 'garlic') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (22, 'Arctium lappa', 'burdock') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (23, 'Baptisia tinctoria', 'wild indigo') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (24, 'Chionanthus virginicus', 'fringetree') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (25, 'Cimicifuga racemosa', 'black cohosh') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (26, 'Echinacea spp.', 'echinacea') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (27, 'Fumaria officinalis', 'fumitory') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (28, 'Galium aparine', 'cleavers') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (29, 'Guaiacum officinale', 'guaiacum') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (30, 'Hydrastis canadensis', 'goldenseal') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (31, 'Iris versicolor', 'blue flag') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (32, 'Larrea tridentata', 'chaparral') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (33, 'Mahonia aquifolium', 'Oregon grape') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (34, 'Menyanthes trifoliata', 'bogbean') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (35, 'Phytolacca americana', 'poke') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (36, 'Pulsatilla vulgaris', 'pasqueflower') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (37, 'Rumex crispus', 'yellow dock') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (38, 'Sanguinaria canadensis', 'bloodroot') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (39, 'Scrophularia nodosa', 'figwort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (40, 'Smilax spp.', 'sarsaparilla') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (41, 'Stillingia sylvatica', 'queen’s delight') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (42, 'Trifolium pratense', 'red clover') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (43, 'Urtica dioica', 'nettles') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (44, 'Achillea millefolium', 'yarrow') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (45, 'Althaea officinalis', 'marshmallow') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (46, 'Arctostaphylos uva-ursi', 'bearberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (47, 'Capsicum annuum', 'cayenne') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (48, 'Cetraria islandica', 'Iceland moss') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (49, 'Chondrus crispus', 'Irish moss') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (50, 'Eupatorium perfoliatum', 'boneset') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (51, 'Euphrasia spp.', 'eyebright') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (52, 'Geranium maculatum', 'cranesbill') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (53, 'Hyssopus officinalis', 'hyssop') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (54, 'Inula helenium', 'elecampane') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (55, 'Mentha piperita', 'peppermint') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (56, 'Salvia officinalis', 'sage') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (57, 'Sambucus nigra', 'elder') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (58, 'Solidago virgaurea', 'goldenrod') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (59, 'Thymus vulgaris', 'thyme') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (60, 'Tussilago farfara', 'coltsfoot') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (61, 'Verbascum thapsus', 'mullein') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (62, 'Aesculus hippocastanum', 'horse chestnut') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (63, 'Alchemilla arvensis', 'lady’s mantle') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (64, 'Anethum graveolens', 'dill') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (65, 'Angelica archangelica', 'angelica') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (66, 'Apium graveolens', 'celery seed') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (67, 'Asclepias tuberosa', 'pleurisy root') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (68, 'Betula spp.', 'birch') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (69, 'Borago officinalis', 'borage') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (70, 'Calendula officinalis', 'calendula') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (71, 'Capsella bursa-pastoris', 'shepherd’s purse') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (72, 'Caulophyllum thalictroides', 'blue cohosh') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (73, 'Crataegus spp.', 'hawthorn') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (74, 'Dioscorea villosa', 'wild yam') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (75, 'Filipendula ulmaria', 'meadowsweet') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (76, 'Foeniculum vulgare', 'fennel') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (77, 'Gaultheria procumbens', 'wintergreen') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (78, 'Glycyrrhiza glabra', 'licorice') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (79, 'Hamamelis virginiana', 'witch hazel') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (80, 'Harpagophytum procumbens', 'devil’s claw') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (81, 'Hypericum perforatum', 'St. John’s wort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (82, 'Lavandula spp.', 'lavender') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (83, 'Malva sylvestris', 'mallow') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (84, 'Matricaria recutita', 'chamomile') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (85, 'Plantago major', 'plantain') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (86, 'Populus tremuloides', 'aspen') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (87, 'Salix spp.', 'willow') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (88, 'Stellaria media', 'chickweed') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (89, 'Symphytum officinale', 'comfrey') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (90, 'Tilia platyphyllos', 'linden') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (91, 'Trigonella foenum-graecum', 'fenugreek') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (92, 'Ulmus rubra', 'slippery elm') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (93, 'Viburnum opulus', 'cramp bark') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (94, 'Viburnum prunifolium', 'black haw') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (95, 'Zea mays', 'corn silk') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (96, 'Artemisia abrotanum', 'southernwood') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (97, 'A. absinthium', 'wormwood') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (98, 'Carum carvi', 'caraway') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (99, 'Commiphora molmol', 'myrrh') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (100, 'Coriandrum sativum', 'coriander') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (101, 'Eucalyptus spp.', 'eucalyptus') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (102, 'Gentiana lutea', 'gentian') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (103, 'Juniperus communis', 'juniper') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (104, 'Ligusticum porteri', 'osha') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (105, 'Myroxylon balsamum var. pereirae', 'balsam of Peru') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (106, 'Olea europaea', 'olive') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (107, 'Origanum majorana', 'marjoram') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (108, 'Pimpinella anisum', 'aniseed') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (109, 'Rosmarinus officinalis', 'rosemary') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (110, 'Ruta graveolens', 'rue') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (111, 'Syzygium aromaticum', 'clove') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (112, 'Usnea spp.', 'usnea') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (113, 'Armoracia rusticana', 'horseradish') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (114, 'Arnica montana', 'arnica') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (115, 'Artemisia absinthium', 'wormwood') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (116, 'Artemisia vulgaris', 'mugwort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (117, 'Brassica spp.', 'mustard') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (118, 'E. purpureum', 'gravel root') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (119, 'Fucus vesiculosus', 'kelp') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (120, 'Myrica cerifera', 'bayberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (121, 'Petroselinum crispum', 'parsley') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (122, 'Tanacetum parthenium', 'feverfew') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (123, 'Taraxacum officinale', 'dandelion') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (124, 'Zanthoxylum americanum', 'prickly ash') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (125, 'Zingiber officinale', 'ginger') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (126, 'Daucus carota', 'wild carrot') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (127, 'Drosera rotundifolia', 'sundew') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (128, 'Elettaria cardamomum', 'cardamom') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (129, 'Eschscholzia californica', 'California poppy') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (130, 'Humulus lupulus', 'hops') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (131, 'Lactuca virosa', 'wild lettuce') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (132, 'Leonurus cardiaca', 'motherwort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (133, 'Lobelia inflata', 'lobelia') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (134, 'Lycopus spp.', 'bugleweed') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (135, 'Melissa officinalis', 'lemon balm') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (136, 'M. pulegium', 'pennyroyal') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (137, 'Nepeta cataria', 'catnip') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (138, 'Passiflora incarnata', 'passionflower') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (139, 'Piper methysticum', 'kava kava') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (140, 'Piscidia erythrina', 'Jamaica dogwood') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (141, 'Prunus serotina', 'wild cherry bark') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (142, 'Salvia officinalis var. rubia', 'red sage') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (143, 'Scutellaria lateriflora', 'skullcap') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (144, 'Symplocarpus foetidus', 'skunk cabbage') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (145, 'Turnera diffusa', 'damiana') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (146, 'Valeriana officinalis', 'valerian') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (147, 'Verbena officinalis', 'vervain') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (148, 'V . prunifolium', 'black haw') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (149, 'Acacia catechu', 'black catechu') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (150, 'Agrimonia eupatoria', 'agrimony') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (151, 'Camellia sinensis', 'tea') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (152, 'Cola acuminata', 'kola') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (153, 'Equisetum arvense', 'horsetail') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (154, 'Polygonum bistorta', 'bistort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (155, 'Quercus spp.', 'oak') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (156, 'Rheum palmatum', 'rhubarb') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (157, 'Rubus idaeus', 'raspberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (158, 'R. villosus', 'blackberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (159, 'Vinca major', 'periwinkle') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (160, 'A. vulgaris', 'mugwort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (161, 'Berberis vulgaris', 'barberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (162, 'Centaurium erythraea', 'centaury') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (163, 'Marrubium vulgare', 'horehound') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (164, 'Tanacetum vulgare', 'tansy') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (165, 'Coleus forskohlii', 'coleus') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (166, 'Convallaria majalis', 'lily of the valley') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (167, 'Cytisus scoparius', 'Scotch broom') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (168, 'Ginkgo biloba', 'ginkgo') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (169, 'Urginea maritima', 'squill') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (170, 'Cinnamomum spp.', 'cinnamon') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (171, 'Eucalyptus globulus', 'eucalyptus') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (172, 'Thymus spp.', 'thyme') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (173, 'Chelidonium majus', 'celandine') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (174, 'Chelone glabra', 'balmony') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (175, 'Cynara scolymus', 'artichoke') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (176, 'Euonymus atropurpureus', 'wahoo') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (177, 'Juglans cinerea', 'butternut') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (178, 'Leptandra virginica', 'black root') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (179, 'Peumus boldus', 'boldo') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (180, 'Taraxacum officinale root', 'dandelion') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (181, 'Avena sativa', 'oat') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (182, 'Elymus repens', 'couch grass') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (183, 'Linum usitatissimum', 'flax') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (184, 'Agathosma betulina', 'buchu') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (185, 'Collinsonia canadensis', 'stoneroot') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (186, 'Cucurbita pepo', 'pumpkin') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (187, 'Eryngium maritimum', 'sea holly') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (188, 'E.purpureum', 'gravel root') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (189, 'Parietaria judaica', 'pellitory of the wall') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (190, 'Serenoa repens', 'saw palmetto') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (191, 'Marsdenia condurango', 'condurango') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (192, 'Mitchella repens', 'partridgeberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (193, 'T. vulgare', 'tansy') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (194, 'Tropaeolum majus', 'nasturtium') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (195, 'Vitex agnus-castus', 'chasteberry') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (196, 'Bellis perennis', 'English daisy') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (197, 'Cephaelis ipecacuanha', 'ipecac') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (198, 'Hieracium pilosella', 'mouse ear') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (199, 'Myroxylon balsamum var. balsamum', 'Tolu balsam') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (200, 'Polygala senega', 'Seneca snakeroot') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (201, 'Populus candicans', 'balm of Gilead') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (202, 'Primula veris', 'cowslip') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (203, 'Viola odorata', 'sweet violet') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (204, 'Grindelia camporum', 'gumweed') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (205, 'Pulmonaria officinalis', 'lungwort') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (206, 'Thuja occidentalis', 'thuja') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (207, 'Aloe vera', 'aloe') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (208, 'Curcuma longa', 'turmeric') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (209, 'Rhamnus cathartica', 'buckthorn') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (210, 'R. purshiana', 'cascara sagrada') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (211, 'Silybum marianum', 'milk thistle') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (212, 'Stachys officinalis', 'wood betony') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (213, 'Allium cepa', 'onion') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (214, 'A.sativum', 'garlic') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (215, 'Fagopyrum esculentum', 'buckwheat') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (216, 'Viscum album', 'mistletoe') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (217, 'Panax spp.', 'ginseng') ON CONFLICT (latin_name) DO NOTHING","INSERT INTO herbal.herbs (id, latin_name, common_name) VALUES (218, 'Senna alexandrina', 'senna') ON CONFLICT (latin_name) DO NOTHING","-- Insert primary actions\nINSERT INTO herbal.primary_actions (id, name) VALUES (1, 'Adaptogens') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (2, 'Alteratives') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (3, 'Anticatarrhal') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (4, 'Anti-inflammatory') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (5, 'Antimicrobial') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (6, 'Antirheumatic') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (7, 'Antispasmodic') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (8, 'Astringent') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (9, 'Bitter') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (10, 'Cardiac Remedies') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (11, 'Carminative') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (12, 'Cholagogue') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (13, 'Demulcent') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (14, 'Diuretic') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (15, 'Emmenagogue') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (16, 'Expectorant') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (17, 'Hepatic') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (18, 'Hypnotic') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (19, 'Hypotensive') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (20, 'Nervine') ON CONFLICT (name) DO NOTHING","INSERT INTO herbal.primary_actions (id, name) VALUES (21, 'Stimulant') ON CONFLICT (name) DO NOTHING","-- Body systems are already inserted in the schema migration\n-- If you need to re-insert them:\n-- DELETE FROM herbal.body_systems;\n-- INSERT INTO herbal.body_systems (id, name) VALUES (1, 'Cardiovascular');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (2, 'Respiratory');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (3, 'Digestive');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (4, 'Urinary');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (5, 'Reproductive');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (6, 'Musculoskeletal');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (7, 'Nervous');\n-- INSERT INTO herbal.body_systems (id, name) VALUES (8, 'Skin');"}	seed_data
003	{"-- Set schema\nSET search_path TO herbal, public","-- ============================================\n-- ALTERATIVES - Herb to Action to Body System Relationships\n-- ============================================\n\n-- Cardiovascular System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Cardiovascular'\nAND h.latin_name IN ('Galium aparine', 'Phytolacca americana', 'Echinacea spp.', 'Scrophularia nodosa', 'Allium sativum')","-- Respiratory System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Respiratory'\nAND h.latin_name IN ('Allium sativum', 'Hydrastis canadensis', 'Sanguinaria canadensis', 'Baptisia tinctoria', 'Echinacea spp.')","-- Digestive System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, \n  CASE \n    WHEN h.latin_name IN ('Arctium lappa', 'Hydrastis canadensis', 'Rumex crispus', 'Smilax spp.', 'Urtica dioica') THEN 'strong'::herbal.strength_level\n    WHEN h.latin_name IN ('Iris versicolor') THEN 'very_strong'::herbal.strength_level\n    ELSE 'mild'::herbal.strength_level\n  END\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Digestive'\nAND h.latin_name IN ('Allium sativum', 'Arctium lappa', 'Chionanthus virginicus', 'Hydrastis canadensis', 'Iris versicolor', 'Menyanthes trifoliata', 'Rumex crispus', 'Smilax spp.', 'Urtica dioica')","-- Urinary System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, 'strong'::herbal.strength_level\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Urinary'\nAND h.latin_name IN ('Galium aparine', 'Urtica dioica')","-- Reproductive System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Reproductive'\nAND h.latin_name IN ('Cimicifuga racemosa', 'Hydrastis canadensis')","-- Musculoskeletal System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, 'strong'::herbal.strength_level\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Musculoskeletal'\nAND h.latin_name IN ('Cimicifuga racemosa', 'Menyanthes trifoliata', 'Arctium lappa')","-- Nervous System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id, 'mild'::herbal.strength_level\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Nervous'\nAND h.latin_name IN ('Pulsatilla vulgaris', 'Trifolium pratense')","-- Skin System Alteratives\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT h.id, pa.id, bs.id,\n  CASE \n    WHEN h.latin_name IN ('Arctium lappa', 'Fumaria officinalis', 'Galium aparine', 'Hydrastis canadensis', 'Rumex crispus', 'Scrophularia nodosa', 'Smilax spp.', 'Trifolium pratense', 'Urtica dioica') THEN 'strong'::herbal.strength_level\n    ELSE 'mild'::herbal.strength_level\n  END\nFROM herbal.herbs h\nCROSS JOIN herbal.primary_actions pa\nCROSS JOIN herbal.body_systems bs\nWHERE pa.name = 'Alteratives' AND bs.name = 'Skin'\nAND h.latin_name IN ('Arctium lappa', 'Mahonia aquifolium', 'Fumaria officinalis', 'Galium aparine', 'Echinacea spp.', 'Scrophularia nodosa', 'Smilax spp.', 'Rumex crispus', 'Trifolium pratense')","-- ============================================\n-- SECONDARY ACTIONS for Alteratives\n-- ============================================\n\n-- Anticatarrhal\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Anticatarrhal'\nAND h.latin_name IN ('Allium sativum', 'Baptisia tinctoria', 'Echinacea spp.', 'Hydrastis canadensis', 'Phytolacca americana', 'Urtica dioica')\nON CONFLICT DO NOTHING","-- Anti-inflammatory\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Anti-inflammatory'\nAND h.latin_name IN ('Galium aparine', 'Guaiacum officinale', 'Hydrastis canadensis', 'Iris versicolor', 'Menyanthes trifoliata', 'Smilax spp.')\nON CONFLICT DO NOTHING","-- Antimicrobial\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Antimicrobial'\nAND h.latin_name IN ('Allium sativum', 'Baptisia tinctoria', 'Echinacea spp.', 'Hydrastis canadensis', 'Larrea tridentata', 'Phytolacca americana', 'Pulsatilla vulgaris', 'Sanguinaria canadensis')\nON CONFLICT DO NOTHING","-- Antispasmodic\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Antispasmodic'\nAND h.latin_name IN ('Allium sativum', 'Cimicifuga racemosa', 'Pulsatilla vulgaris', 'Sanguinaria canadensis', 'Trifolium pratense')\nON CONFLICT DO NOTHING","-- Astringent\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Astringent'\nAND h.latin_name IN ('Hydrastis canadensis', 'Urtica dioica')\nON CONFLICT DO NOTHING","-- Bitter\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Bitter'\nAND h.latin_name IN ('Arctium lappa', 'Hydrastis canadensis', 'Menyanthes trifoliata')\nON CONFLICT DO NOTHING","-- Diaphoretic\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Diaphoretic'\nAND h.latin_name IN ('Allium sativum', 'Guaiacum officinale', 'Stillingia sylvatica', 'Smilax spp.')\nON CONFLICT DO NOTHING","-- Diuretic\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Diuretic'\nAND h.latin_name IN ('Arctium lappa', 'Galium aparine', 'Guaiacum officinale', 'Iris versicolor', 'Menyanthes trifoliata', 'Smilax spp.', 'Urtica dioica')\nON CONFLICT DO NOTHING","-- Emmenagogue\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Emmenagogue'\nAND h.latin_name IN ('Cimicifuga racemosa')\nON CONFLICT DO NOTHING","-- Expectorant\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Expectorant'\nAND h.latin_name IN ('Sanguinaria canadensis', 'Trifolium pratense', 'Verbascum thapsus')\nON CONFLICT DO NOTHING","-- Hepatic\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Hepatic'\nAND h.latin_name IN ('Allium sativum', 'Arctium lappa', 'Chionanthus virginicus', 'Hydrastis canadensis', 'Iris versicolor', 'Mahonia aquifolium', 'Menyanthes trifoliata', 'Phytolacca americana', 'Rumex crispus')\nON CONFLICT DO NOTHING","-- Hypotensive\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Hypotensive'\nAND h.latin_name IN ('Allium sativum', 'Cimicifuga racemosa', 'Urtica dioica')\nON CONFLICT DO NOTHING","-- Nervine\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Nervine'\nAND h.latin_name IN ('Cimicifuga racemosa', 'Pulsatilla vulgaris', 'Trifolium pratense')\nON CONFLICT DO NOTHING","-- Vulnerary\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT h.id, sa.id\nFROM herbal.herbs h\nCROSS JOIN herbal.secondary_actions sa\nWHERE sa.name = 'Vulnerary'\nAND h.latin_name IN ('Galium aparine', 'Hydrastis canadensis')\nON CONFLICT DO NOTHING","-- Insert all secondary actions first\nINSERT INTO herbal.secondary_actions (name) VALUES\n  ('Anticatarrhal'),\n  ('Anti-inflammatory'),\n  ('Antimicrobial'),\n  ('Antispasmodic'),\n  ('Astringent'),\n  ('Bitter'),\n  ('Carminative'),\n  ('Demulcent'),\n  ('Diaphoretic'),\n  ('Diuretic'),\n  ('Emmenagogue'),\n  ('Expectorant'),\n  ('Hepatic'),\n  ('Hypotensive'),\n  ('Nervine'),\n  ('Vulnerary')\nON CONFLICT (name) DO NOTHING"}	relationships_data
004	{"-- Set schema\nSET search_path TO herbal, public","-- ============================================\n-- INSERT SECONDARY ACTIONS FIRST\n-- ============================================\nINSERT INTO herbal.secondary_actions (name) VALUES\n  ('Anticatarrhal'),\n  ('Anti-inflammatory'),\n  ('Antimicrobial'),\n  ('Antispasmodic'),\n  ('Astringent'),\n  ('Bitter'),\n  ('Carminative'),\n  ('Demulcent'),\n  ('Diaphoretic'),\n  ('Diuretic'),\n  ('Emmenagogue'),\n  ('Expectorant'),\n  ('Hepatic'),\n  ('Hypotensive'),\n  ('Nervine'),\n  ('Stimulant'),\n  ('Tonic'),\n  ('Vulnerary')\nON CONFLICT (name) DO NOTHING","-- ============================================\n-- EXAMPLE RELATIONSHIPS - Alteratives\n-- Based on your text file\n-- ============================================\n\n-- Garlic (Allium sativum) - Alterative for Multiple Systems\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength, body_system_note)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular'),\n  'mild'::herbal.strength_level,\n  'The hypocholesteremic and hypotensive actions are well known'\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),\n  'mild'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),\n  'mild'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","-- Burdock (Arctium lappa) - Strong Alterative\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Digestive'),\n  'strong'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Musculoskeletal'),\n  'strong'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Skin'),\n  'strong'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')\nON CONFLICT DO NOTHING","-- Echinacea - Mild Alterative\nINSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Cardiovascular'),\n  'mild'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Respiratory'),\n  'mild'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_primary_actions (herb_id, primary_action_id, body_system_id, relative_strength)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),\n  (SELECT id FROM herbal.primary_actions WHERE name = 'Alteratives'),\n  (SELECT id FROM herbal.body_systems WHERE name = 'Skin'),\n  'mild'::herbal.strength_level\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')\nON CONFLICT DO NOTHING","-- ============================================\n-- SECONDARY ACTIONS FOR SAMPLE HERBS\n-- ============================================\n\n-- Garlic secondary actions\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Anticatarrhal')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antispasmodic')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Diaphoretic')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hepatic')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Allium sativum'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hypotensive')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Allium sativum')\nON CONFLICT DO NOTHING","-- Burdock secondary actions\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Bitter')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Diuretic')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Arctium lappa'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Hepatic')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Arctium lappa')\nON CONFLICT DO NOTHING","-- Echinacea secondary actions\nINSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Anticatarrhal')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')\nON CONFLICT DO NOTHING","INSERT INTO herbal.herb_secondary_actions (herb_id, secondary_action_id)\nSELECT \n  (SELECT id FROM herbal.herbs WHERE latin_name = 'Echinacea spp.'),\n  (SELECT id FROM herbal.secondary_actions WHERE name = 'Antimicrobial')\nWHERE EXISTS (SELECT 1 FROM herbal.herbs WHERE latin_name = 'Echinacea spp.')\nON CONFLICT DO NOTHING"}	sample_relationships
005	{"-- Make body_system_id nullable to allow herbs without specific body system affinities\nALTER TABLE herbal.herb_primary_actions\nALTER COLUMN body_system_id DROP NOT NULL","-- Update the unique constraint to handle NULL values properly\n-- Drop the existing constraint\nALTER TABLE herbal.herb_primary_actions\nDROP CONSTRAINT IF EXISTS herb_primary_actions_herb_id_primary_action_id_body_system__key","-- Add it back (PostgreSQL handles NULL values in unique constraints properly)\nALTER TABLE herbal.herb_primary_actions\nADD CONSTRAINT herb_primary_actions_herb_id_primary_action_id_body_system__key\nUNIQUE (herb_id, primary_action_id, body_system_id)","COMMENT ON COLUMN herbal.herb_primary_actions.body_system_id IS 'Body system affected (NULL if no specific body system affinity)'"}	make_body_system_nullable
006	{"-- Create action descriptions table to store bullet points for each primary action\nCREATE TABLE herbal.action_descriptions (\n  id SERIAL PRIMARY KEY,\n  primary_action_id INTEGER REFERENCES herbal.primary_actions(id) ON DELETE CASCADE,\n  description TEXT NOT NULL,\n  sort_order INTEGER DEFAULT 0,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n)","-- Create index for better query performance\nCREATE INDEX idx_action_descriptions_action ON herbal.action_descriptions(primary_action_id)","-- Grant permissions\nGRANT ALL ON herbal.action_descriptions TO postgres, anon, authenticated, service_role","GRANT ALL ON SEQUENCE herbal.action_descriptions_id_seq TO postgres, anon, authenticated, service_role","COMMENT ON TABLE herbal.action_descriptions IS 'Descriptive bullet points for primary actions'","COMMENT ON COLUMN herbal.action_descriptions.sort_order IS 'Order in which descriptions should be displayed'"}	action_descriptions
007	{"-- This migration has been superseded by migration 008 (full data snapshot)\n-- Migration 008 contains all action descriptions along with all other data\n-- This file is kept for migration history but does nothing\n\nSELECT 1","-- No-op statement to keep migration valid"}	populate_action_descriptions
008	{"-- Data Snapshot: Complete database state\n-- This migration contains a full dump of all data including:\n-- - All herbs, primary actions, secondary actions, body systems\n-- - All herb-primary action relationships with body systems and strengths\n-- - All herb-secondary action relationships\n-- - All action descriptions (bullet points for each primary action)\n--\n-- Running 'supabase db reset' will restore the database to this exact state.\n-- This snapshot was created after running the ingestion script and adding action descriptions.\n\n-- Clear all existing data in the correct order (respecting foreign key constraints)\nSET search_path TO herbal, public","DELETE FROM herbal.action_descriptions","DELETE FROM herbal.herb_secondary_actions","DELETE FROM herbal.herb_primary_actions","DELETE FROM herbal.secondary_actions","DELETE FROM herbal.herbs","DELETE FROM herbal.primary_actions","DELETE FROM herbal.body_systems","SET session_replication_role = replica","--\n-- PostgreSQL database dump\n--\n\n-- \\\\restrict HpaiwY8Yszu6KUg42qKJGrWw1I58Lut0jmsVHHyCtzyDi9LO5YfoY4HteSXq58L\n\n-- Dumped from database version 17.6\n-- Dumped by pg_dump version 17.6\n\nSET statement_timeout = 0","SET lock_timeout = 0","SET idle_in_transaction_session_timeout = 0","SET transaction_timeout = 0","SET client_encoding = 'UTF8'","SET standard_conforming_strings = on","SELECT pg_catalog.set_config('search_path', '', false)","SET check_function_bodies = false","SET xmloption = content","SET client_min_messages = warning","SET row_security = off","--\n-- Data for Name: primary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"primary_actions\\" (\\"id\\", \\"name\\", \\"description\\", \\"created_at\\") VALUES\n\t(1, 'Adaptogens', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(2, 'Alteratives', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(3, 'Anticatarrhal', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(4, 'Anti-inflammatory', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(5, 'Antimicrobial', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(6, 'Antirheumatic', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(7, 'Antispasmodic', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(8, 'Astringent', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(9, 'Bitter', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(10, 'Cardiotonic', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(11, 'Carminative', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(12, 'Cholagogue', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(13, 'Demulcent', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(14, 'Diuretic', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(15, 'Emmenagogue', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(16, 'Stimulating Expectorant', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(17, 'Relaxing Expectorant', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(18, 'Amphoteric Expectorant', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(19, 'Hepatic', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(20, 'Hypnotic', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(21, 'Hypotensive', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(22, 'Nervine Tonics', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(23, 'Nervine Relaxants', NULL, '2026-03-22 21:15:28.838092+00'),\n\t(24, 'Nervine Stimulant', NULL, '2026-03-22 21:15:28.838092+00')","--\n-- Data for Name: action_descriptions; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"action_descriptions\\" (\\"id\\", \\"primary_action_id\\", \\"description\\", \\"sort_order\\", \\"created_at\\") VALUES\n\t(226, 5, 'a sage-y smell usually indicates this action', 3, '2026-03-22 21:31:43.736795+00'),\n\t(199, 1, 'Helps the body adapt to stress', 1, '2026-03-22 21:31:43.736795+00'),\n\t(200, 1, 'virtually non-toxic at high doses', 2, '2026-03-22 21:31:43.736795+00'),\n\t(201, 1, 'non-specific action throughout the body', 3, '2026-03-22 21:31:43.736795+00'),\n\t(202, 1, 'H-P-A axis = Hypothalamic Pituitary Adrenal - communication system involved in the stress response', 4, '2026-03-22 21:31:43.736795+00'),\n\t(203, 1, 'adaptogens help regulate this hormonal cascade', 5, '2026-03-22 21:31:43.736795+00'),\n\t(204, 1, 'non-specific state of resistance to stress: environmental, psych or physio', 6, '2026-03-22 21:31:43.736795+00'),\n\t(205, 1, 'helping the body adapt to and defend against the effects of environmental stress.', 7, '2026-03-22 21:31:43.736795+00'),\n\t(206, 1, 'The general aims of treatment with this action are to reduce stress reactions during the alarm phase of the stress response and to prevent or at least delay the state of exhaustion,', 8, '2026-03-22 21:31:43.736795+00'),\n\t(207, 1, 'smooth out the associated highs and lows. This conserves energy in the alarm phase for use in the resistance phase.', 9, '2026-03-22 21:31:43.736795+00'),\n\t(208, 2, 'alter the body from unhealthy to healthy via the body channels of elimination', 1, '2026-03-22 21:31:43.736795+00'),\n\t(209, 2, 'bowel, kidney, skin, liver', 2, '2026-03-22 21:31:43.736795+00'),\n\t(210, 2, 'aid in detoxification', 3, '2026-03-22 21:31:43.736795+00'),\n\t(211, 2, 'used to be called \\"blood cleanser\\"', 4, '2026-03-22 21:31:43.736795+00'),\n\t(212, 2, 'gradually restore proper function to the body and increase overall health and vitality.', 5, '2026-03-22 21:31:43.736795+00'),\n\t(213, 2, 'seem to alter the body''s metabolic processes to improve tissues'' ability to deal with a range of body functions, from nutrition to elimination.', 6, '2026-03-22 21:31:43.736795+00'),\n\t(214, 2, 'should be considered first for cases of chronic inflammatory and degenerative diseases', 7, '2026-03-22 21:31:43.736795+00'),\n\t(215, 2, 'Skin is the body system for which these are often used', 8, '2026-03-22 21:31:43.736795+00'),\n\t(216, 4, 'reduces inflammation from sprains, strains, headaches, wounds or chronic internal conditions', 1, '2026-03-22 21:31:43.736795+00'),\n\t(217, 4, 'promote healthy inflammation, regulate it to turn on and turn off', 2, '2026-03-22 21:31:43.736795+00'),\n\t(218, 4, 'work well with musculoskeletal discomfort', 3, '2026-03-22 21:31:43.736795+00'),\n\t(219, 4, 'help the body combat inflammation', 4, '2026-03-22 21:31:43.736795+00'),\n\t(220, 3, 'thin the mucus secretions and reduce congestion', 1, '2026-03-22 21:31:43.736795+00'),\n\t(221, 3, 'can be used for lungs, although aren''t as effective in loosening deep-seated mucus as the more stimulating expectorant', 2, '2026-03-22 21:31:43.736795+00'),\n\t(222, 3, 'help the body remove excess mucus, whether in the sinuses or in other parts of the body. They are used mainly for ear, nose, and throat infections,', 3, '2026-03-22 21:31:43.736795+00'),\n\t(223, 3, 'Some of this action remedies work by producing a less viscous mucus secretion that is easier for the body to remove. Others reduce mucus secretion directly.', 4, '2026-03-22 21:31:43.736795+00'),\n\t(224, 5, 'disinfectants, used both internally and externally to prevent or cure infections', 1, '2026-03-22 21:31:43.736795+00'),\n\t(225, 5, 'a lot of cooking herbs - sage, oregano', 2, '2026-03-22 21:31:43.736795+00'),\n\t(227, 5, 'usually can be used both topically and internally', 4, '2026-03-22 21:31:43.736795+00'),\n\t(228, 5, 'help the body destroy or resist pathogenic microorganisms in some way', 5, '2026-03-22 21:31:43.736795+00'),\n\t(229, 5, 'we are talking about plants that support the immune process, augmenting the integrity of the individual''s own defense system', 6, '2026-03-22 21:31:43.736795+00'),\n\t(230, 7, 'special kind of muscle relaxants', 1, '2026-03-22 21:31:43.736795+00'),\n\t(231, 7, 'help ease spasms and cramps and also very helpful in gently relaxing body extremities', 2, '2026-03-22 21:31:43.736795+00'),\n\t(232, 7, 'useful for variety of conditions: anxiety, nervousness, to hypertension, cold hands and feet', 3, '2026-03-22 21:31:43.736795+00'),\n\t(233, 7, 'prevent or ease spasms or cramps in the muscles. They thus reduce muscular tension in the body,', 4, '2026-03-22 21:31:43.736795+00'),\n\t(234, 7, 'facilitate physical relaxation of muscles without necessarily causing a sedative effect.', 5, '2026-03-22 21:31:43.736795+00'),\n\t(235, 7, 'the action that affects the peripheral nerves and the muscle tissue - may have an indirect relaxing action on the whole system.', 6, '2026-03-22 21:31:43.736795+00'),\n\t(236, 8, 'tone and tighten tissues', 1, '2026-03-22 21:31:43.736795+00'),\n\t(237, 8, 'tannin rich herbs', 2, '2026-03-22 21:31:43.736795+00'),\n\t(238, 8, 'pulling or drawing effect', 3, '2026-03-22 21:31:43.736795+00'),\n\t(239, 8, 'drying', 4, '2026-03-22 21:31:43.736795+00'),\n\t(240, 8, 'most barks have this property', 5, '2026-03-22 21:31:43.736795+00'),\n\t(241, 8, 'tightening of the tissue', 6, '2026-03-22 21:31:43.736795+00'),\n\t(242, 8, 'sometimes called styptics when applied externally to stop bleeding, or anti-hemorrhagics when used for internal bleeding.', 7, '2026-03-22 21:31:43.736795+00'),\n\t(243, 8, 'produce a kind of temporary leather coat on the surface of tissue.', 8, '2026-03-22 21:31:43.736795+00'),\n\t(244, 8, 'Reduce irritation on the surface of tissues through a sort of numbing action', 9, '2026-03-22 21:31:43.736795+00'),\n\t(245, 8, 'Reduce surface inflammation', 10, '2026-03-22 21:31:43.736795+00'),\n\t(246, 8, 'Create a barrier against infection, great help with wounds and burns', 11, '2026-03-22 21:31:43.736795+00'),\n\t(247, 8, 'of great importance in round healing and conditions affecting the digestive system.', 12, '2026-03-22 21:31:43.736795+00'),\n\t(248, 9, 'Stimulate appetite.', 1, '2026-03-22 21:31:43.736795+00'),\n\t(249, 9, 'Stimulate release of digestive juices from the pancreas, duodenum, and and liver', 2, '2026-03-22 21:31:43.736795+00'),\n\t(250, 9, 'Aid the liver in detoxification work and increase the flow of bile', 3, '2026-03-22 21:31:43.736795+00'),\n\t(251, 9, 'Help regulate secretion of pancreatic hormones that regulate blood sugar, insulin, and glucagon', 4, '2026-03-22 21:31:43.736795+00'),\n\t(252, 9, 'Help the gut wall repair damage by stimulating self-repair mechanisms.', 5, '2026-03-22 21:31:43.736795+00'),\n\t(253, 10, 'special affinity for the heart, regulating its beat, moderating hypertension, and usually tone the heart', 1, '2026-03-22 21:31:43.736795+00'),\n\t(254, 10, 'general category for herbal remedies that have some kind of action on the heart.', 2, '2026-03-22 21:31:43.736795+00'),\n\t(255, 11, 'clear \\"wind\\" and gas/bloating in the body', 1, '2026-03-22 21:31:43.736795+00'),\n\t(256, 11, 'move energy in the body downward if scattered thoughts as well!', 2, '2026-03-22 21:31:43.736795+00'),\n\t(257, 11, 'rich in volatile oils', 3, '2026-03-22 21:31:43.736795+00'),\n\t(258, 11, 'ease discomfort caused by flatulence.', 4, '2026-03-22 21:31:43.736795+00'),\n\t(259, 12, 'greek meaning bile, and as such has a cleaning and stimulating effect on the liver and gallbladder, allowing from the release of more bile', 1, '2026-03-22 21:31:43.736795+00'),\n\t(260, 12, 'helpful in aiding digestion, esp in the lower intestinal tract', 2, '2026-03-22 21:31:43.736795+00'),\n\t(261, 12, 'have the specific effect of stimulating the flow of bile from the liver.', 3, '2026-03-22 21:31:43.736795+00'),\n\t(262, 12, 'quite specific in that they act on the liver.', 4, '2026-03-22 21:31:43.736795+00'),\n\t(263, 12, 'indicated for disorders caused by insufficient or congested bile, such as intractable biliary constipation, jaundice, and mild hepatitis.', 5, '2026-03-22 21:31:43.736795+00'),\n\t(264, 12, 'contraindicated for painful gallstones, Increased contractile activity could further constrict the bile duct, leading to incredibly intense', 6, '2026-03-22 21:31:43.736795+00'),\n\t(265, 12, 'Because they help with assimilation, these have an enlivening \\"side effect\\" in the nervous system. These remedies may actively ease debility and', 7, '2026-03-22 21:31:43.736795+00'),\n\t(266, 13, 'soothing herbs rich in mucilage', 1, '2026-03-22 21:31:43.736795+00'),\n\t(267, 13, 'helps to heal mucosal barrier', 2, '2026-03-22 21:31:43.736795+00'),\n\t(268, 13, 'indication for gastric irritation, ulcers', 3, '2026-03-22 21:31:43.736795+00'),\n\t(269, 13, 'if someone is already damp, contraindication for this', 4, '2026-03-22 21:31:43.736795+00'),\n\t(270, 13, 'herbs with this action often have an apparently anti-inflammatory effect, but this is related to their ability to soothe inflamed surfaces, not to reductions in the cellular inflammatory response.', 5, '2026-03-22 21:31:43.736795+00'),\n\t(271, 13, 'rich in mucilage and can soothe and protect irritated or inflamed internal tissue. When used topically on the skin, these are called emollients.', 6, '2026-03-22 21:31:43.736795+00'),\n\t(272, 13, 'become slimy and gummy when they come in contact with water:', 7, '2026-03-22 21:31:43.736795+00'),\n\t(273, 13, 'Reduce irritation down the whole length of the bowel.', 8, '2026-03-22 21:31:43.736795+00'),\n\t(274, 13, 'Lessen the sensitivity of the digestive system to gastric acids and to digestive bitters', 9, '2026-03-22 21:31:43.736795+00'),\n\t(275, 14, 'gently promote elimination of water through the kidneys, as urine', 1, '2026-03-22 21:31:43.736795+00'),\n\t(276, 14, 'help the body rid itself of exces fluids by increasing the kidneys'' rate of urine production.', 2, '2026-03-22 21:31:43.736795+00'),\n\t(277, 14, 'Causes more blood to pass through the kidneys, which produces more urine', 3, '2026-03-22 21:31:43.736795+00'),\n\t(278, 14, 'Because of their cleansing actions, many of these help with problems of muscles and bones', 4, '2026-03-22 21:31:43.736795+00'),\n\t(279, 15, 'promote menstruation usually by slightly irritating the uterine lining', 1, '2026-03-22 21:31:43.736795+00'),\n\t(280, 15, 'severely contraindicated during pregnancy', 2, '2026-03-22 21:31:43.736795+00'),\n\t(281, 15, 'remedies that stimulate menstrual flow and activity', 3, '2026-03-22 21:31:43.736795+00'),\n\t(282, 19, 'herbal remedies that aid the work of the liver in a range of ways.', 1, '2026-03-22 21:31:43.736795+00'),\n\t(283, 19, 'Bitters and cholagogues all act as this action, but so do a whole array of other remedies that do not have those specific actions.', 2, '2026-03-22 21:31:43.736795+00'),\n\t(284, 20, 'trance-inducing, a little more than simple sedatives', 1, '2026-03-22 21:31:43.736795+00'),\n\t(285, 20, 'can be very relaxing , useful in sleep conditions, headaches, tension, and for addiction recovery', 2, '2026-03-22 21:31:43.736795+00'),\n\t(286, 20, 'don''t used with sedative medication already', 3, '2026-03-22 21:31:43.736795+00'),\n\t(287, 20, 'most are also hypotensives - lower blood pressure', 4, '2026-03-22 21:31:43.736795+00'),\n\t(288, 20, 'nervine remedies that help induce a deep and healing state of sleep.', 5, '2026-03-22 21:31:43.736795+00'),\n\t(289, 20, 'should always be used within the context of a holistic approach to sleep problems', 6, '2026-03-22 21:31:43.736795+00'),\n\t(290, 21, 'lower blood pressure by acting either on the heart, arteries, capillaries, or the water balance in the body', 1, '2026-03-22 21:31:43.736795+00'),\n\t(291, 21, 'use semi-preventatively, when the blood pressure starts to creep up, not in acute conditions', 2, '2026-03-22 21:31:43.736795+00'),\n\t(292, 21, 'reduce elevated blood pressure, tending to normalize both systolic and diastolic pressure.', 3, '2026-03-22 21:31:43.736795+00'),\n\t(293, 23, 'most important in times of stress and confusion, as they can alleviate many of the accompanying symptoms.', 1, '2026-03-22 21:31:43.736795+00'),\n\t(294, 23, 'the best remedies for the \\"inflamed state of mind\\"', 2, '2026-03-22 21:31:43.736795+00'),\n\t(295, 24, 'an action that quickens and enlivens the physiological activity of the body.', 1, '2026-03-22 21:31:43.736795+00'),\n\t(296, 17, 'seem also to act by reflex, but here the reflex action works to soothe bronchial spasm and loosen mucus secretions.', 1, '2026-03-22 21:31:43.736795+00'),\n\t(297, 17, 'help to produce a thinner mucus that is easier to expel, allowing the more viscous mucus to move and thus be eliminated.', 2, '2026-03-22 21:31:43.736795+00'),\n\t(298, 17, 'useful for dry, irritating coughs.', 3, '2026-03-22 21:31:43.736795+00'),\n\t(299, 17, 'This action is similar in some respects to that of demulcents, and both actions owe much to their content of mucilage and, occasionally, volatile oils.', 4, '2026-03-22 21:31:43.736795+00'),\n\t(300, 16, 'Irritate the bronchioles to stimulate expulsion of any material present', 1, '2026-03-22 21:31:43.736795+00'),\n\t(301, 16, 'Liquefy viscid sputum so that it can be cleared by coughing.', 2, '2026-03-22 21:31:43.736795+00')","--\n-- Data for Name: body_systems; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"body_systems\\" (\\"id\\", \\"name\\", \\"created_at\\") VALUES\n\t(9, 'Cardiovascular', '2026-03-22 21:15:28.830018+00'),\n\t(10, 'Respiratory', '2026-03-22 21:15:28.830018+00'),\n\t(11, 'Digestive', '2026-03-22 21:15:28.830018+00'),\n\t(12, 'Urinary', '2026-03-22 21:15:28.830018+00'),\n\t(13, 'Reproductive', '2026-03-22 21:15:28.830018+00'),\n\t(14, 'Musculoskeletal', '2026-03-22 21:15:28.830018+00'),\n\t(15, 'Nervous', '2026-03-22 21:15:28.830018+00'),\n\t(16, 'Skin', '2026-03-22 21:15:28.830018+00')","--\n-- Data for Name: herbs; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"herbs\\" (\\"id\\", \\"latin_name\\", \\"common_name\\", \\"created_at\\") VALUES\n\t(1, 'Acanthopanax sessiliflorum', 'Wu Jia Pi', '2026-03-22 21:15:28.845147+00'),\n\t(2, 'Albizzia julibrissin', 'Silk Tree', '2026-03-22 21:15:28.845147+00'),\n\t(3, 'Aralia elata', 'Japanese Angelica Tree', '2026-03-22 21:15:28.845147+00'),\n\t(4, 'Aralia manshurica', 'Manchurian Aralia', '2026-03-22 21:15:28.845147+00'),\n\t(5, 'Aralia schmidtii', 'Sakhalin Spikenard', '2026-03-22 21:15:28.845147+00'),\n\t(6, 'Cicer arietinum', 'Chickpea', '2026-03-22 21:15:28.845147+00'),\n\t(7, 'Codonoposis pilosula', 'Dang Shen', '2026-03-22 21:15:28.845147+00'),\n\t(8, 'Echinopanax elatus', 'Asian Devil’s Club', '2026-03-22 21:15:28.845147+00'),\n\t(9, 'Eleutherococcus senticosus', 'Siberian Ginseng', '2026-03-22 21:15:28.845147+00'),\n\t(10, 'Eucommia ulmoides', 'Hardy Rubber Tree', '2026-03-22 21:15:28.845147+00'),\n\t(11, 'Ganoderma lucidum', 'Reishi Mushroom', '2026-03-22 21:15:28.845147+00'),\n\t(12, 'Hoppea dichotoma Leuzea carthamoides', 'Maral Root', '2026-03-22 21:15:28.845147+00'),\n\t(13, 'Ocimum sanctum', 'Holy Basil', '2026-03-22 21:15:28.845147+00'),\n\t(14, 'Panax ginseng', 'Korean Ginseng', '2026-03-22 21:15:28.845147+00'),\n\t(15, 'Panax quinquefolius', 'American Ginseng', '2026-03-22 21:15:28.845147+00'),\n\t(16, 'Rhodiola rosea', 'Roseroot Stonecrop', '2026-03-22 21:15:28.845147+00'),\n\t(17, 'Schisandra chinensis', 'Schizandra', '2026-03-22 21:15:28.845147+00'),\n\t(18, 'Tinospora cordifolia', 'Guduchi', '2026-03-22 21:15:28.845147+00'),\n\t(19, 'Trichopus zeylanicus', 'Arogyappacha', '2026-03-22 21:15:28.845147+00'),\n\t(20, 'Withania somnifera', 'Ashwaganda', '2026-03-22 21:15:28.845147+00'),\n\t(21, 'Allium sativum', 'Garlic', '2026-03-22 21:15:28.845147+00'),\n\t(22, 'Arctium lappa', 'Burdock', '2026-03-22 21:15:28.845147+00'),\n\t(23, 'Baptisia tinctoria', 'Wild Indigo', '2026-03-22 21:15:28.845147+00'),\n\t(24, 'Chionanthus virginicus', 'Fringetree', '2026-03-22 21:15:28.845147+00'),\n\t(25, 'Cimicifuga racemosa', 'Black Cohosh', '2026-03-22 21:15:28.845147+00'),\n\t(26, 'Echinacea spp.', 'Echinacea', '2026-03-22 21:15:28.845147+00'),\n\t(27, 'Fumaria officinalis', 'Fumitory', '2026-03-22 21:15:28.845147+00'),\n\t(28, 'Galium aparine', 'Cleavers', '2026-03-22 21:15:28.845147+00'),\n\t(29, 'Guaiacum officinale', 'Guaiacum', '2026-03-22 21:15:28.845147+00'),\n\t(30, 'Hydrastis canadensis', 'Goldenseal', '2026-03-22 21:15:28.845147+00'),\n\t(31, 'Iris versicolor', 'Blue Flag', '2026-03-22 21:15:28.845147+00'),\n\t(32, 'Larrea tridentata', 'Chaparral', '2026-03-22 21:15:28.845147+00'),\n\t(33, 'Mahonia aquifolium', 'Oregon Grape', '2026-03-22 21:15:28.845147+00'),\n\t(34, 'Menyanthes trifoliata', 'Bogbean', '2026-03-22 21:15:28.845147+00'),\n\t(35, 'Phytolacca americana', 'Poke', '2026-03-22 21:15:28.845147+00'),\n\t(36, 'Pulsatilla vulgaris', 'Pasqueflower', '2026-03-22 21:15:28.845147+00'),\n\t(37, 'Rumex crispus', 'Yellow Dock', '2026-03-22 21:15:28.845147+00'),\n\t(38, 'Sanguinaria canadensis', 'Bloodroot', '2026-03-22 21:15:28.845147+00'),\n\t(39, 'Scrophularia nodosa', 'Figwort', '2026-03-22 21:15:28.845147+00'),\n\t(40, 'Smilax spp.', 'Sarsaparilla', '2026-03-22 21:15:28.845147+00'),\n\t(41, 'Stillingia sylvatica', 'Queen’s Delight', '2026-03-22 21:15:28.845147+00'),\n\t(42, 'Trifolium pratense', 'Red Clover', '2026-03-22 21:15:28.845147+00'),\n\t(43, 'Urtica dioica', 'Nettles', '2026-03-22 21:15:28.845147+00'),\n\t(44, 'Achillea millefolium', 'Yarrow', '2026-03-22 21:15:28.845147+00'),\n\t(45, 'Althaea officinalis', 'Marshmallow', '2026-03-22 21:15:28.845147+00'),\n\t(46, 'Arctostaphylos uva-ursi', 'Bearberry', '2026-03-22 21:15:28.845147+00'),\n\t(47, 'Capsicum annuum', 'Cayenne', '2026-03-22 21:15:28.845147+00'),\n\t(48, 'Cetraria islandica', 'Iceland Moss', '2026-03-22 21:15:28.845147+00'),\n\t(49, 'Chondrus crispus', 'Irish Moss', '2026-03-22 21:15:28.845147+00'),\n\t(50, 'Eupatorium perfoliatum', 'Boneset', '2026-03-22 21:15:28.845147+00'),\n\t(51, 'Euphrasia spp.', 'Eyebright', '2026-03-22 21:15:28.845147+00'),\n\t(52, 'Geranium maculatum', 'Cranesbill', '2026-03-22 21:15:28.845147+00'),\n\t(53, 'Hyssopus officinalis', 'Hyssop', '2026-03-22 21:15:28.845147+00'),\n\t(54, 'Inula helenium', 'Elecampane', '2026-03-22 21:15:28.845147+00'),\n\t(55, 'Mentha piperita', 'Peppermint', '2026-03-22 21:15:28.845147+00'),\n\t(56, 'Salvia officinalis', 'Sage', '2026-03-22 21:15:28.845147+00'),\n\t(57, 'Sambucus nigra', 'Elder', '2026-03-22 21:15:28.845147+00'),\n\t(58, 'Solidago virgaurea', 'Goldenrod', '2026-03-22 21:15:28.845147+00'),\n\t(59, 'Thymus vulgaris', 'Thyme', '2026-03-22 21:15:28.845147+00'),\n\t(60, 'Tussilago farfara', 'Coltsfoot', '2026-03-22 21:15:28.845147+00'),\n\t(61, 'Verbascum thapsus', 'Mullein', '2026-03-22 21:15:28.845147+00'),\n\t(62, 'Aesculus hippocastanum', 'Horse Chestnut', '2026-03-22 21:15:28.845147+00'),\n\t(63, 'Alchemilla arvensis', 'Lady’s Mantle', '2026-03-22 21:15:28.845147+00'),\n\t(64, 'Anethum graveolens', 'Dill', '2026-03-22 21:15:28.845147+00'),\n\t(65, 'Angelica archangelica', 'Angelica', '2026-03-22 21:15:28.845147+00'),\n\t(66, 'Apium graveolens', 'Celery Seed', '2026-03-22 21:15:28.845147+00'),\n\t(67, 'Asclepias tuberosa', 'Pleurisy Root', '2026-03-22 21:15:28.845147+00'),\n\t(68, 'Betula spp.', 'Birch', '2026-03-22 21:15:28.845147+00'),\n\t(69, 'Borago officinalis', 'Borage', '2026-03-22 21:15:28.845147+00'),\n\t(70, 'Calendula officinalis', 'Calendula', '2026-03-22 21:15:28.845147+00'),\n\t(71, 'Capsella bursa-pastoris', 'Shepherd’s Purse', '2026-03-22 21:15:28.845147+00'),\n\t(72, 'Caulophyllum thalictroides', 'Blue Cohosh', '2026-03-22 21:15:28.845147+00'),\n\t(73, 'Crataegus spp.', 'Hawthorn', '2026-03-22 21:15:28.845147+00'),\n\t(74, 'Dioscorea villosa', 'Wild Yam', '2026-03-22 21:15:28.845147+00'),\n\t(75, 'Filipendula ulmaria', 'Meadowsweet', '2026-03-22 21:15:28.845147+00'),\n\t(76, 'Foeniculum vulgare', 'Fennel', '2026-03-22 21:15:28.845147+00'),\n\t(77, 'Gaultheria procumbens', 'Wintergreen', '2026-03-22 21:15:28.845147+00'),\n\t(78, 'Glycyrrhiza glabra', 'Licorice', '2026-03-22 21:15:28.845147+00'),\n\t(79, 'Hamamelis virginiana', 'Witch Hazel', '2026-03-22 21:15:28.845147+00'),\n\t(80, 'Harpagophytum procumbens', 'Devil’s Claw', '2026-03-22 21:15:28.845147+00'),\n\t(81, 'Hypericum perforatum', 'St. John’s Wort', '2026-03-22 21:15:28.845147+00'),\n\t(82, 'Lavandula spp.', 'Lavender', '2026-03-22 21:15:28.845147+00'),\n\t(83, 'Malva sylvestris', 'Mallow', '2026-03-22 21:15:28.845147+00'),\n\t(84, 'Matricaria recutita', 'Chamomile', '2026-03-22 21:15:28.845147+00'),\n\t(85, 'Plantago major', 'Plantain', '2026-03-22 21:15:28.845147+00'),\n\t(86, 'Populus tremuloides', 'Aspen', '2026-03-22 21:15:28.845147+00'),\n\t(87, 'Salix spp.', 'Willow', '2026-03-22 21:15:28.845147+00'),\n\t(88, 'Stellaria media', 'Chickweed', '2026-03-22 21:15:28.845147+00'),\n\t(89, 'Symphytum officinale', 'Comfrey', '2026-03-22 21:15:28.845147+00'),\n\t(90, 'Tilia platyphyllos', 'Linden', '2026-03-22 21:15:28.845147+00'),\n\t(91, 'Trigonella foenum-graecum', 'Fenugreek', '2026-03-22 21:15:28.845147+00'),\n\t(92, 'Ulmus rubra', 'Slippery Elm', '2026-03-22 21:15:28.845147+00'),\n\t(93, 'Viburnum opulus', 'Cramp Bark', '2026-03-22 21:15:28.845147+00'),\n\t(94, 'Viburnum prunifolium', 'Black Haw', '2026-03-22 21:15:28.845147+00'),\n\t(95, 'Zea mays', 'Corn Silk', '2026-03-22 21:15:28.845147+00'),\n\t(96, 'Artemisia abrotanum', 'Southernwood', '2026-03-22 21:15:28.845147+00'),\n\t(97, 'Artemisia absinthium', 'Wormwood', '2026-03-22 21:15:28.845147+00'),\n\t(98, 'Carum carvi', 'Caraway', '2026-03-22 21:15:28.845147+00'),\n\t(99, 'Commiphora molmol', 'Myrrh', '2026-03-22 21:15:28.845147+00'),\n\t(100, 'Coriandrum sativum', 'Coriander', '2026-03-22 21:15:28.845147+00'),\n\t(101, 'Eucalyptus spp.', 'Eucalyptus', '2026-03-22 21:15:28.845147+00'),\n\t(102, 'Gentiana lutea', 'Gentian', '2026-03-22 21:15:28.845147+00'),\n\t(103, 'Juniperus communis', 'Juniper', '2026-03-22 21:15:28.845147+00'),\n\t(104, 'Ligusticum porteri', 'Osha', '2026-03-22 21:15:28.845147+00'),\n\t(105, 'Myroxylon balsamum var. pereirae', 'Balsam Of Peru', '2026-03-22 21:15:28.845147+00'),\n\t(106, 'Olea europaea', 'Olive', '2026-03-22 21:15:28.845147+00'),\n\t(107, 'Origanum majorana', 'Marjoram', '2026-03-22 21:15:28.845147+00'),\n\t(108, 'Pimpinella anisum', 'Aniseed', '2026-03-22 21:15:28.845147+00'),\n\t(109, 'Rosmarinus officinalis', 'Rosemary', '2026-03-22 21:15:28.845147+00'),\n\t(110, 'Ruta graveolens', 'Rue', '2026-03-22 21:15:28.845147+00'),\n\t(111, 'Syzygium aromaticum', 'Clove', '2026-03-22 21:15:28.845147+00'),\n\t(112, 'Usnea spp.', 'Usnea', '2026-03-22 21:15:28.845147+00'),\n\t(113, 'Armoracia rusticana', 'Horseradish', '2026-03-22 21:15:28.845147+00'),\n\t(114, 'Arnica montana', 'Arnica', '2026-03-22 21:15:28.845147+00'),\n\t(115, 'Artemisia vulgaris', 'Mugwort', '2026-03-22 21:15:28.845147+00'),\n\t(116, 'Brassica spp.', 'Mustard', '2026-03-22 21:15:28.845147+00'),\n\t(117, 'Eupatorium purpureum', 'Gravel Root', '2026-03-22 21:15:28.845147+00'),\n\t(118, 'Fucus vesiculosus', 'Kelp', '2026-03-22 21:15:28.845147+00'),\n\t(119, 'Myrica cerifera', 'Bayberry', '2026-03-22 21:15:28.845147+00'),\n\t(120, 'Petroselinum crispum', 'Parsley', '2026-03-22 21:15:28.845147+00'),\n\t(121, 'Tanacetum parthenium', 'Feverfew', '2026-03-22 21:15:28.845147+00'),\n\t(122, 'Taraxacum officinale', 'Dandelion', '2026-03-22 21:15:28.845147+00'),\n\t(123, 'Zanthoxylum americanum', 'Prickly Ash', '2026-03-22 21:15:28.845147+00'),\n\t(124, 'Zingiber officinale', 'Ginger', '2026-03-22 21:15:28.845147+00'),\n\t(125, 'Daucus carota', 'Wild Carrot', '2026-03-22 21:15:28.845147+00'),\n\t(126, 'Drosera rotundifolia', 'Sundew', '2026-03-22 21:15:28.845147+00'),\n\t(127, 'Elettaria cardamomum', 'Cardamom', '2026-03-22 21:15:28.845147+00'),\n\t(128, 'Eschscholzia californica', 'California Poppy', '2026-03-22 21:15:28.845147+00'),\n\t(129, 'Humulus lupulus', 'Hops', '2026-03-22 21:15:28.845147+00'),\n\t(130, 'Lactuca virosa', 'Wild Lettuce', '2026-03-22 21:15:28.845147+00'),\n\t(131, 'Leonurus cardiaca', 'Motherwort', '2026-03-22 21:15:28.845147+00'),\n\t(132, 'Lobelia inflata', 'Lobelia', '2026-03-22 21:15:28.845147+00'),\n\t(133, 'Lycopus spp.', 'Bugleweed', '2026-03-22 21:15:28.845147+00'),\n\t(134, 'Melissa officinalis', 'Lemon Balm', '2026-03-22 21:15:28.845147+00'),\n\t(135, 'Mentha pulegium', 'Pennyroyal', '2026-03-22 21:15:28.845147+00'),\n\t(136, 'Nepeta cataria', 'Catnip', '2026-03-22 21:15:28.845147+00'),\n\t(137, 'Passiflora incarnata', 'Passionflower', '2026-03-22 21:15:28.845147+00'),\n\t(138, 'Piper methysticum', 'Kava', '2026-03-22 21:15:28.845147+00'),\n\t(139, 'Piscidia erythrina', 'Jamaica Dogwood', '2026-03-22 21:15:28.845147+00'),\n\t(140, 'Prunus serotina', 'Wild Cherry Bark', '2026-03-22 21:15:28.845147+00'),\n\t(141, 'Salvia officinalis var. rubia', 'Red Sage', '2026-03-22 21:15:28.845147+00'),\n\t(142, 'Scutellaria lateriflora', 'Skullcap', '2026-03-22 21:15:28.845147+00'),\n\t(143, 'Symplocarpus foetidus', 'Skunk Cabbage', '2026-03-22 21:15:28.845147+00'),\n\t(144, 'Turnera diffusa', 'Damiana', '2026-03-22 21:15:28.845147+00'),\n\t(145, 'Valeriana officinalis', 'Valerian', '2026-03-22 21:15:28.845147+00'),\n\t(146, 'Verbena officinalis', 'Vervain', '2026-03-22 21:15:28.845147+00'),\n\t(147, 'Acacia catechu', 'Black Catechu', '2026-03-22 21:15:28.845147+00'),\n\t(148, 'Agrimonia eupatoria', 'Agrimony', '2026-03-22 21:15:28.845147+00'),\n\t(149, 'Camellia sinensis', 'Tea', '2026-03-22 21:15:28.845147+00'),\n\t(150, 'Cola acuminata', 'Kola', '2026-03-22 21:15:28.845147+00'),\n\t(151, 'Equisetum arvense', 'Horsetail', '2026-03-22 21:15:28.845147+00'),\n\t(152, 'Polygonum bistorta', 'Bistort', '2026-03-22 21:15:28.845147+00'),\n\t(153, 'Quercus spp.', 'Oak', '2026-03-22 21:15:28.845147+00'),\n\t(154, 'Rheum palmatum', 'Rhubarb', '2026-03-22 21:15:28.845147+00'),\n\t(155, 'Rubus idaeus', 'Raspberry', '2026-03-22 21:15:28.845147+00'),\n\t(156, 'Rubus villosus', 'Blackberry', '2026-03-22 21:15:28.845147+00'),\n\t(157, 'Vinca major', 'Periwinkle', '2026-03-22 21:15:28.845147+00'),\n\t(158, 'Berberis vulgaris', 'Barberry', '2026-03-22 21:15:28.845147+00'),\n\t(159, 'Centaurium erythraea', 'Centaury', '2026-03-22 21:15:28.845147+00'),\n\t(160, 'Marrubium vulgare', 'Horehound', '2026-03-22 21:15:28.845147+00'),\n\t(161, 'Tanacetum vulgare', 'Tansy', '2026-03-22 21:15:28.845147+00'),\n\t(162, 'Coleus forskohlii', 'Coleus', '2026-03-22 21:15:28.845147+00'),\n\t(163, 'Convallaria majalis', 'Lily Of The Valley', '2026-03-22 21:15:28.845147+00'),\n\t(164, 'Cytisus scoparius', 'Scotch Broom', '2026-03-22 21:15:28.845147+00'),\n\t(165, 'Ginkgo biloba', 'Ginkgo', '2026-03-22 21:15:28.845147+00'),\n\t(166, 'Urginea maritima', 'Squill', '2026-03-22 21:15:28.845147+00'),\n\t(167, 'Cinnamomum spp.', 'Cinnamon', '2026-03-22 21:15:28.845147+00'),\n\t(168, 'Eucalyptus globulus', 'Eucalyptus', '2026-03-22 21:15:28.845147+00'),\n\t(169, 'Thymus spp.', 'Thyme', '2026-03-22 21:15:28.845147+00'),\n\t(170, 'Chelidonium majus', 'Celandine', '2026-03-22 21:15:28.845147+00'),\n\t(171, 'Chelone glabra', 'Balmony', '2026-03-22 21:15:28.845147+00'),\n\t(172, 'Cynara scolymus', 'Artichoke', '2026-03-22 21:15:28.845147+00'),\n\t(173, 'Euonymus atropurpureus', 'Wahoo', '2026-03-22 21:15:28.845147+00'),\n\t(174, 'Juglans cinerea', 'Butternut', '2026-03-22 21:15:28.845147+00'),\n\t(175, 'Leptandra virginica', 'Black Root', '2026-03-22 21:15:28.845147+00'),\n\t(176, 'Peumus boldus', 'Boldo', '2026-03-22 21:15:28.845147+00'),\n\t(177, 'Taraxacum officinale root', 'Dandelion', '2026-03-22 21:15:28.845147+00'),\n\t(178, 'Avena sativa', 'Oat', '2026-03-22 21:15:28.845147+00'),\n\t(179, 'Elymus repens', 'Couch Grass', '2026-03-22 21:15:28.845147+00'),\n\t(180, 'Linum usitatissimum', 'Flax', '2026-03-22 21:15:28.845147+00'),\n\t(181, 'Agathosma betulina', 'Buchu', '2026-03-22 21:15:28.845147+00'),\n\t(182, 'Collinsonia canadensis', 'Stoneroot', '2026-03-22 21:15:28.845147+00'),\n\t(183, 'Cucurbita pepo', 'Pumpkin', '2026-03-22 21:15:28.845147+00'),\n\t(184, 'Eryngium maritimum', 'Sea Holly', '2026-03-22 21:15:28.845147+00'),\n\t(185, 'Parietaria judaica', 'Pellitory Of The Wall', '2026-03-22 21:15:28.845147+00'),\n\t(186, 'Serenoa repens', 'Saw Palmetto', '2026-03-22 21:15:28.845147+00'),\n\t(187, 'Marsdenia condurango', 'Condurango', '2026-03-22 21:15:28.845147+00'),\n\t(188, 'Mitchella repens', 'Partridgeberry', '2026-03-22 21:15:28.845147+00'),\n\t(189, 'Tropaeolum majus', 'Nasturtium', '2026-03-22 21:15:28.845147+00'),\n\t(190, 'Vitex agnus-castus', 'Chasteberry', '2026-03-22 21:15:28.845147+00'),\n\t(191, 'Bellis perennis', 'English Daisy', '2026-03-22 21:15:28.845147+00'),\n\t(192, 'Cephaelis ipecacuanha', 'Ipecac', '2026-03-22 21:15:28.845147+00'),\n\t(193, 'Hieracium pilosella', 'Mouse Ear', '2026-03-22 21:15:28.845147+00'),\n\t(194, 'Myroxylon balsamum var. balsamum', 'Tolu Balsam', '2026-03-22 21:15:28.845147+00'),\n\t(195, 'Polygala senega', 'Seneca Snakeroot', '2026-03-22 21:15:28.845147+00'),\n\t(196, 'Populus candicans', 'Balm Of Gilead', '2026-03-22 21:15:28.845147+00'),\n\t(197, 'Primula veris', 'Cowslip', '2026-03-22 21:15:28.845147+00'),\n\t(198, 'Viola odorata', 'Sweet Violet', '2026-03-22 21:15:28.845147+00'),\n\t(199, 'Grindelia camporum', 'Gumweed', '2026-03-22 21:15:28.845147+00'),\n\t(200, 'Pulmonaria officinalis', 'Lungwort', '2026-03-22 21:15:28.845147+00'),\n\t(201, 'Thuja occidentalis', 'Thuja', '2026-03-22 21:15:28.845147+00'),\n\t(202, 'Aloe vera', 'Aloe', '2026-03-22 21:15:28.845147+00'),\n\t(203, 'Curcuma longa', 'Turmeric', '2026-03-22 21:15:28.845147+00'),\n\t(204, 'Rhamnus cathartica', 'Buckthorn', '2026-03-22 21:15:28.845147+00'),\n\t(205, 'Rhamnus purshiana', 'Cascara Sagrada', '2026-03-22 21:15:28.845147+00'),\n\t(206, 'Silybum marianum', 'Milk Thistle', '2026-03-22 21:15:28.845147+00'),\n\t(207, 'Stachys officinalis', 'Wood Betony', '2026-03-22 21:15:28.845147+00'),\n\t(208, 'Allium cepa', 'Onion', '2026-03-22 21:15:28.845147+00'),\n\t(209, 'A.sativum', 'Garlic', '2026-03-22 21:15:28.845147+00'),\n\t(210, 'Fagopyrum esculentum', 'Buckwheat', '2026-03-22 21:15:28.845147+00'),\n\t(211, 'Viscum album', 'Mistletoe', '2026-03-22 21:15:28.845147+00'),\n\t(212, 'Ballota nigra', 'Black Horehound', '2026-03-22 21:15:28.845147+00'),\n\t(213, 'Chamaemelum nobile', 'Roman Chamomile', '2026-03-22 21:15:28.845147+00'),\n\t(214, 'Stachys betonica', 'Wood Betony', '2026-03-22 21:15:28.845147+00'),\n\t(215, 'Panax spp.', 'Ginseng', '2026-03-22 21:15:28.845147+00'),\n\t(216, 'Senna alexandrina', 'Senna', '2026-03-22 21:15:28.845147+00'),\n\t(217, 'Coffea arabica', 'Coffee', '2026-03-22 21:15:28.845147+00'),\n\t(218, 'Paullinia cupana', 'Guarana', '2026-03-22 21:15:28.845147+00')","--\n-- Data for Name: herb_primary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"herb_primary_actions\\" (\\"id\\", \\"herb_id\\", \\"primary_action_id\\", \\"body_system_id\\", \\"body_system_note\\", \\"relative_strength\\", \\"created_at\\") VALUES\n\t(47, 1, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.860367+00'),\n\t(48, 2, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.864506+00'),\n\t(49, 3, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.8667+00'),\n\t(50, 4, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.869125+00'),\n\t(51, 5, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.870665+00'),\n\t(52, 6, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.872882+00'),\n\t(53, 7, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.874695+00'),\n\t(54, 8, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.876419+00'),\n\t(55, 9, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.877971+00'),\n\t(56, 10, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.879809+00'),\n\t(57, 11, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.881635+00'),\n\t(58, 12, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.900256+00'),\n\t(59, 13, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.903098+00'),\n\t(60, 14, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.904748+00'),\n\t(61, 15, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.906662+00'),\n\t(62, 16, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.908764+00'),\n\t(63, 17, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.910856+00'),\n\t(64, 18, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.913147+00'),\n\t(65, 19, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.915547+00'),\n\t(66, 20, 1, NULL, NULL, NULL, '2026-03-22 21:15:28.917424+00'),\n\t(67, 21, 2, 9, 'The hypocholesteremic and hypotensive actions are well known', 'mild', '2026-03-22 21:15:28.918937+00'),\n\t(68, 21, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'mild', '2026-03-22 21:15:28.921029+00'),\n\t(69, 21, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'mild', '2026-03-22 21:15:28.922858+00'),\n\t(70, 22, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.924826+00'),\n\t(71, 22, 2, 14, 'Many alteratives are important here', 'strong', '2026-03-22 21:15:28.928079+00'),\n\t(72, 22, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.930067+00'),\n\t(73, 23, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'mild', '2026-03-22 21:15:28.932671+00'),\n\t(74, 24, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'mild', '2026-03-22 21:15:28.934721+00'),\n\t(75, 25, 2, 13, 'Here, the general alteratives are always of value', 'mild', '2026-03-22 21:15:28.936598+00'),\n\t(76, 25, 2, 14, 'Many alteratives are important here', 'mild', '2026-03-22 21:15:28.937801+00'),\n\t(77, 26, 2, 9, 'In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation', 'mild', '2026-03-22 21:15:28.939082+00'),\n\t(78, 26, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'mild', '2026-03-22 21:15:28.940283+00'),\n\t(79, 26, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'mild', '2026-03-22 21:15:28.941691+00'),\n\t(80, 27, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.943168+00'),\n\t(81, 28, 2, 9, 'In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation', 'strong', '2026-03-22 21:15:28.944308+00'),\n\t(82, 28, 2, 12, 'Some of the herbs described as diuretics could be characterized as urinary system alteratives', 'strong', '2026-03-22 21:15:28.945413+00'),\n\t(83, 28, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.946544+00'),\n\t(84, 29, 2, NULL, NULL, 'strong', '2026-03-22 21:15:28.947709+00'),\n\t(85, 30, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'strong', '2026-03-22 21:15:28.949028+00'),\n\t(86, 30, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.950192+00'),\n\t(87, 30, 2, 13, 'Here, the general alteratives are always of value', 'strong', '2026-03-22 21:15:28.951741+00'),\n\t(88, 31, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'very_strong', '2026-03-22 21:15:28.95297+00'),\n\t(89, 32, 2, NULL, NULL, 'very_strong', '2026-03-22 21:15:28.954093+00'),\n\t(126, 49, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.007816+00'),\n\t(257, 113, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.19752+00'),\n\t(90, 33, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'mild', '2026-03-22 21:15:28.955221+00'),\n\t(91, 34, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'mild', '2026-03-22 21:15:28.956865+00'),\n\t(92, 34, 2, 14, 'Many alteratives are important here', 'mild', '2026-03-22 21:15:28.958018+00'),\n\t(93, 35, 2, 9, 'In general, alterative activity is not specifically indicated for this system. However, by nature, alteratives will aid circulation by helping the whole body work at its peak. Alteratives to support the lymphatic aspects of circulation', 'very_strong', '2026-03-22 21:15:28.959159+00'),\n\t(94, 36, 2, 15, 'By helping the body to be healthy and whole, all alteratives aid the strained nervous system, but this is especially helpful as an alterative with nervine actions', 'mild', '2026-03-22 21:15:28.960447+00'),\n\t(95, 37, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.961598+00'),\n\t(96, 37, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.962943+00'),\n\t(97, 38, 2, 10, 'The main alteratives that also possess beneficial properties for the lungs and respiratory system as a whole', 'very_strong', '2026-03-22 21:15:28.963953+00'),\n\t(98, 39, 2, 9, 'useful in chronic eczema, also has positive inotropic actions', 'strong', '2026-03-22 21:15:28.965008+00'),\n\t(99, 39, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.966074+00'),\n\t(100, 40, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.967073+00'),\n\t(101, 40, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.968503+00'),\n\t(102, 41, 2, NULL, NULL, 'very_strong', '2026-03-22 21:15:28.969541+00'),\n\t(103, 42, 2, 15, 'By helping the body to be healthy and whole, all alteratives aid the strained nervous system, but this is especially helpful as an alterative with nervine actions', 'strong', '2026-03-22 21:15:28.970603+00'),\n\t(104, 42, 2, 16, 'The list of alteratives for the skin could include all of the herbs listed here, plus many more. This is the system for which alteratives are most often used. It is important to remember that in holistic herbalism, aiding and supporting the whole body in its return to health is always more important than applying specific remedies', 'strong', '2026-03-22 21:15:28.972026+00'),\n\t(105, 43, 2, 11, 'All of the alteratives that work on the liver, pancreas, and other digestive system organs are of great importance in herbal medicine', 'strong', '2026-03-22 21:15:28.973292+00'),\n\t(106, 43, 2, 12, 'Some of the herbs described as diuretics could be characterized as urinary system alteratives', 'strong', '2026-03-22 21:15:28.974732+00'),\n\t(107, 44, 3, 9, 'Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination', NULL, '2026-03-22 21:15:28.976266+00'),\n\t(108, 44, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.977744+00'),\n\t(109, 44, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:28.979452+00'),\n\t(110, 21, 3, 9, 'Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination', NULL, '2026-03-22 21:15:28.980845+00'),\n\t(111, 21, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.98224+00'),\n\t(112, 21, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:28.983471+00'),\n\t(113, 21, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:28.985451+00'),\n\t(114, 45, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.987434+00'),\n\t(115, 45, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:28.98896+00'),\n\t(116, 46, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.990977+00'),\n\t(117, 46, 3, 12, 'In addition to their anticatarrhal properties', NULL, '2026-03-22 21:15:28.993363+00'),\n\t(118, 46, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:28.995361+00'),\n\t(119, 23, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:28.997055+00'),\n\t(120, 23, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:28.998456+00'),\n\t(121, 47, 3, 9, 'Anticatarrhal action is not directly relevant to the cardiovascular system. However, it could be said that anticatarrhal remedies help the system by contributing to general detoxification and elimination', NULL, '2026-03-22 21:15:29.000208+00'),\n\t(122, 47, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.002531+00'),\n\t(123, 47, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.004104+00'),\n\t(124, 48, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.005399+00'),\n\t(125, 48, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.006687+00'),\n\t(127, 49, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.008974+00'),\n\t(128, 26, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.010639+00'),\n\t(129, 26, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:29.015538+00'),\n\t(130, 50, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.017363+00'),\n\t(131, 50, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.019108+00'),\n\t(132, 51, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.02082+00'),\n\t(133, 52, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.022388+00'),\n\t(134, 52, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.023785+00'),\n\t(135, 52, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:29.024917+00'),\n\t(136, 30, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.026073+00'),\n\t(137, 30, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.027758+00'),\n\t(138, 30, 3, 13, 'While the herbs listed below may all play a role in the holistic treatment of an individual with reproductive system issues, none of them is a primary remedy for male or female problems, this would be the first supportive remedies to consider', NULL, '2026-03-22 21:15:29.029486+00'),\n\t(139, 30, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:29.030747+00'),\n\t(140, 53, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.032163+00'),\n\t(141, 54, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.033392+00'),\n\t(142, 55, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.035013+00'),\n\t(143, 55, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.036125+00'),\n\t(144, 56, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.0374+00'),\n\t(145, 56, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.038828+00'),\n\t(146, 57, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.040289+00'),\n\t(147, 57, 3, 16, 'Anticatarrhals may be indirectly indicated for the treatment of a range of skin problems because they support the body’s cleansing processes', NULL, '2026-03-22 21:15:29.041571+00'),\n\t(148, 58, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.045083+00'),\n\t(149, 58, 3, 12, 'In addition to their anticatarrhal properties', NULL, '2026-03-22 21:15:29.048165+00'),\n\t(150, 59, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.053038+00'),\n\t(151, 59, 3, 11, 'Anticatarrhals that have bitter, demulcent, carminative, hepatic, or astringent properties make useful therapeutic contributions to digestive problems', NULL, '2026-03-22 21:15:29.055983+00'),\n\t(152, 60, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.057827+00'),\n\t(153, 61, 3, 10, 'All of the herbs listed as primary anticatarrhals have a beneficial effect on both the upper and lower respiratory systems', NULL, '2026-03-22 21:15:29.059374+00'),\n\t(154, 44, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.060695+00'),\n\t(155, 62, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.062208+00'),\n\t(156, 63, 4, 13, 'Many tonics and other specific reproductive remedies will often have anti-inflammatory actions', NULL, '2026-03-22 21:15:29.063465+00'),\n\t(157, 45, 4, 11, 'Demulcent remedies rich in mucilage, can have the localized effect of reducing inflammation through contact soothing', NULL, '2026-03-22 21:15:29.064655+00'),\n\t(158, 64, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.065846+00'),\n\t(159, 65, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.066948+00'),\n\t(160, 66, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.068003+00'),\n\t(161, 67, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.068991+00'),\n\t(162, 68, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own', NULL, '2026-03-22 21:15:29.070004+00'),\n\t(163, 69, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.070962+00'),\n\t(164, 70, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.072132+00'),\n\t(165, 71, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.073234+00'),\n\t(166, 72, 4, 13, 'Many tonics and other specific reproductive remedies will often have anti-inflammatory actions', NULL, '2026-03-22 21:15:29.074733+00'),\n\t(167, 48, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.075725+00'),\n\t(168, 49, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.076908+00'),\n\t(169, 25, 4, 14, NULL, NULL, '2026-03-22 21:15:29.077925+00'),\n\t(170, 73, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.079153+00'),\n\t(171, 74, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.080311+00'),\n\t(172, 74, 4, 14, NULL, NULL, '2026-03-22 21:15:29.081934+00'),\n\t(173, 75, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own,', NULL, '2026-03-22 21:15:29.08319+00'),\n\t(174, 76, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.084372+00'),\n\t(175, 28, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.08544+00'),\n\t(176, 77, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.086435+00'),\n\t(177, 52, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.087363+00'),\n\t(178, 78, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.088347+00'),\n\t(179, 78, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.089417+00'),\n\t(180, 29, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.090449+00'),\n\t(181, 79, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.091427+00'),\n\t(182, 80, 4, 14, NULL, NULL, '2026-03-22 21:15:29.092302+00'),\n\t(253, 65, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.189647+00'),\n\t(254, 66, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.192559+00'),\n\t(255, 22, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.194462+00'),\n\t(256, 46, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.196003+00'),\n\t(183, 30, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.09325+00'),\n\t(184, 30, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.094651+00'),\n\t(185, 81, 4, 15, 'While the nervous system often feels as if it needs anti-inflammatories, the best remedies for the “inflamed state of mind” are the relaxing nervines. The only direct anti-inflammatory for nervous system tissue is this, which helps speed the recovery of damaged nerves.', NULL, '2026-03-22 21:15:29.096744+00'),\n\t(186, 81, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.098488+00'),\n\t(187, 53, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.099495+00'),\n\t(188, 82, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.100599+00'),\n\t(189, 83, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.101593+00'),\n\t(190, 84, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.102659+00'),\n\t(191, 55, 4, 11, 'As herbal remedies go directly to the digestive system, they are particularly useful in inflammatory conditions that affect it, from stomach ulcers to colitis and hemorrhoids', NULL, '2026-03-22 21:15:29.1039+00'),\n\t(192, 34, 4, 14, NULL, NULL, '2026-03-22 21:15:29.104938+00'),\n\t(193, 85, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.105943+00'),\n\t(194, 86, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own,', NULL, '2026-03-22 21:15:29.106977+00'),\n\t(195, 87, 4, 14, 'For hardworking and abused muscles and bones, salicylate-containing remedies come into their own', NULL, '2026-03-22 21:15:29.10788+00'),\n\t(196, 56, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.108854+00'),\n\t(197, 57, 4, 10, 'For the upper respiratory system, consider', NULL, '2026-03-22 21:15:29.109784+00'),\n\t(198, 58, 4, 10, 'For the upper respiratory system, consider', NULL, '2026-03-22 21:15:29.110935+00'),\n\t(199, 58, 4, 12, 'A number of herbs soothe the tissue of the urinary tract directly as their anti-inflammatory constituents pass through the kidneys and bladder. Plants that soothe the tissue and fight infection will also have an anti-inflammatory action', NULL, '2026-03-22 21:15:29.111797+00'),\n\t(200, 88, 4, 16, 'Numerous remedies reduce inflammation on the skin', NULL, '2026-03-22 21:15:29.112856+00'),\n\t(201, 89, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.113949+00'),\n\t(202, 90, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.115089+00'),\n\t(203, 91, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.11612+00'),\n\t(204, 60, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.117083+00'),\n\t(205, 92, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.118107+00'),\n\t(206, 61, 4, 10, 'For the lower respiratory system, consider', NULL, '2026-03-22 21:15:29.119096+00'),\n\t(207, 93, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.120073+00'),\n\t(208, 94, 4, NULL, NULL, NULL, '2026-03-22 21:15:29.121258+00'),\n\t(209, 95, 4, 12, 'A number of herbs soothe the tissue of the urinary tract directly as their anti-inflammatory constituents pass through the kidneys and bladder. Plants that soothe the tissue and fight infection will also have an anti-inflammatory action', NULL, '2026-03-22 21:15:29.122296+00'),\n\t(210, 44, 5, 9, 'mong antimicrobial herbs, Allium sativum and Achillea millefolium have a reputation as tonics for this system.', NULL, '2026-03-22 21:15:29.123232+00'),\n\t(211, 44, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.124332+00'),\n\t(212, 21, 5, 9, 'among antimicrobial herbs, Allium sativum and Achillea millefolium have a reputation as tonics for this system. Allium sativum is especially appropriate because of its broad value for the cardiovascular system in general.', NULL, '2026-03-22 21:15:29.125387+00'),\n\t(213, 21, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines.', NULL, '2026-03-22 21:15:29.126407+00'),\n\t(214, 21, 5, 13, 'as well as urinary antimicrobials', NULL, '2026-03-22 21:15:29.127742+00'),\n\t(215, 21, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', NULL, '2026-03-22 21:15:29.129193+00'),\n\t(216, 46, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.130145+00'),\n\t(217, 96, 5, 13, 'as well as urinary antimicrobials', NULL, '2026-03-22 21:15:29.131126+00'),\n\t(218, 97, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.132317+00'),\n\t(219, 23, 5, 10, NULL, NULL, '2026-03-22 21:15:29.133502+00'),\n\t(220, 23, 5, 14, 'provides a good basis for treatment', NULL, '2026-03-22 21:15:29.134542+00'),\n\t(221, 70, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', 'mild', '2026-03-22 21:15:29.135511+00'),\n\t(222, 47, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.136459+00'),\n\t(223, 98, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.137431+00'),\n\t(224, 99, 5, 10, NULL, NULL, '2026-03-22 21:15:29.13846+00'),\n\t(225, 99, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.139457+00'),\n\t(226, 99, 5, 16, 'is one of the strongest external remedies', NULL, '2026-03-22 21:15:29.140455+00'),\n\t(227, 100, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.141573+00'),\n\t(228, 26, 5, 10, NULL, NULL, '2026-03-22 21:15:29.142572+00'),\n\t(229, 26, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines.', NULL, '2026-03-22 21:15:29.143566+00'),\n\t(230, 26, 5, 13, 'as well as urinary antimicrobials', NULL, '2026-03-22 21:15:29.144535+00'),\n\t(231, 26, 5, 14, 'provides a good basis for treatment', NULL, '2026-03-22 21:15:29.145518+00'),\n\t(232, 101, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.146496+00'),\n\t(233, 102, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', 'mild', '2026-03-22 21:15:29.147832+00'),\n\t(234, 30, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.148825+00'),\n\t(235, 81, 5, 15, 'in combination with nervines and other antimicrobial herbs, will help with the intransigent infections that can affect the nervous system', NULL, '2026-03-22 21:15:29.149833+00'),\n\t(236, 54, 5, 10, NULL, NULL, '2026-03-22 21:15:29.153633+00'),\n\t(237, 103, 5, 12, 'Be aware that if there is any suggestion of kidney disease, some of the urinary antimicrobial remedies can be too strong', NULL, '2026-03-22 21:15:29.156327+00'),\n\t(238, 104, 5, 10, NULL, NULL, '2026-03-22 21:15:29.15918+00'),\n\t(239, 55, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.16144+00'),\n\t(240, 105, 5, 10, NULL, NULL, '2026-03-22 21:15:29.16387+00'),\n\t(241, 106, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.165719+00'),\n\t(242, 107, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', 'mild', '2026-03-22 21:15:29.167329+00'),\n\t(243, 108, 5, 10, NULL, 'mild', '2026-03-22 21:15:29.169085+00'),\n\t(244, 85, 5, NULL, NULL, 'mild', '2026-03-22 21:15:29.170565+00'),\n\t(245, 109, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', NULL, '2026-03-22 21:15:29.174061+00'),\n\t(246, 110, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.175914+00'),\n\t(247, 56, 5, 11, 'Many volatile oil–containing herbs and some digestive bitters have an antimicrobial effect in the intestines', NULL, '2026-03-22 21:15:29.1778+00'),\n\t(248, 111, 5, 10, NULL, 'mild', '2026-03-22 21:15:29.179748+00'),\n\t(249, 59, 5, 10, NULL, NULL, '2026-03-22 21:15:29.181912+00'),\n\t(250, 59, 5, 16, 'Many antimicrobial herbs can be used on the skin. A wash of this can be most effective', NULL, '2026-03-22 21:15:29.184202+00'),\n\t(251, 112, 5, NULL, NULL, NULL, '2026-03-22 21:15:29.185996+00'),\n\t(252, 44, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.187818+00'),\n\t(258, 114, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.199057+00'),\n\t(259, 97, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.202174+00'),\n\t(260, 115, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.205828+00'),\n\t(261, 68, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.20961+00'),\n\t(262, 116, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.211365+00'),\n\t(263, 47, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.213296+00'),\n\t(264, 72, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.215109+00'),\n\t(265, 25, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.218953+00'),\n\t(266, 74, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.221434+00'),\n\t(267, 50, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.223684+00'),\n\t(268, 117, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.225511+00'),\n\t(269, 75, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.227412+00'),\n\t(270, 118, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.229265+00'),\n\t(271, 77, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.231514+00'),\n\t(272, 29, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.235441+00'),\n\t(273, 80, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.237676+00'),\n\t(274, 31, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.239716+00'),\n\t(275, 103, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.242314+00'),\n\t(276, 33, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.248401+00'),\n\t(277, 34, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.250894+00'),\n\t(278, 119, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.252726+00'),\n\t(279, 120, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.254443+00'),\n\t(280, 35, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.256168+00'),\n\t(281, 86, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.257898+00'),\n\t(282, 109, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.259745+00'),\n\t(283, 37, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.261824+00'),\n\t(284, 87, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.263768+00'),\n\t(285, 40, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.26858+00'),\n\t(286, 121, 6, NULL, NULL, 'strong', '2026-03-22 21:15:29.272113+00'),\n\t(287, 122, 6, NULL, NULL, 'mild', '2026-03-22 21:15:29.274829+00'),\n\t(288, 43, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.278215+00'),\n\t(289, 93, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.281557+00'),\n\t(290, 123, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.28526+00'),\n\t(291, 124, 6, NULL, NULL, NULL, '2026-03-22 21:15:29.287698+00'),\n\t(292, 64, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'mild', '2026-03-22 21:15:29.289876+00'),\n\t(293, 65, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.292819+00'),\n\t(294, 66, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.295503+00'),\n\t(295, 115, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.297537+00'),\n\t(296, 98, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.299662+00'),\n\t(297, 25, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.301974+00'),\n\t(298, 125, 7, 12, NULL, 'mild', '2026-03-22 21:15:29.303866+00'),\n\t(299, 74, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.305858+00'),\n\t(300, 126, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.307974+00'),\n\t(301, 127, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.309614+00'),\n\t(302, 128, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.311325+00'),\n\t(303, 76, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'mild', '2026-03-22 21:15:29.313774+00'),\n\t(304, 78, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.316223+00'),\n\t(305, 129, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.317859+00'),\n\t(306, 81, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.319257+00'),\n\t(307, 53, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.321021+00'),\n\t(308, 130, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'strong', '2026-03-22 21:15:29.322839+00'),\n\t(309, 82, 7, 9, NULL, NULL, '2026-03-22 21:15:29.324273+00'),\n\t(310, 131, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.325675+00'),\n\t(311, 132, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'strong', '2026-03-22 21:15:29.326946+00'),\n\t(312, 132, 7, 14, 'Externally, Lobelia inflata can be helpful.', 'strong', '2026-03-22 21:15:29.328248+00'),\n\t(313, 133, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.329568+00'),\n\t(314, 84, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', NULL, '2026-03-22 21:15:29.330695+00'),\n\t(315, 134, 7, 9, NULL, NULL, '2026-03-22 21:15:29.331895+00'),\n\t(316, 55, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'mild', '2026-03-22 21:15:29.333944+00'),\n\t(317, 135, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.33557+00'),\n\t(318, 136, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.337154+00'),\n\t(319, 137, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.338604+00'),\n\t(320, 120, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.340183+00'),\n\t(321, 108, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'mild', '2026-03-22 21:15:29.34157+00'),\n\t(322, 138, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.342972+00'),\n\t(323, 139, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.34463+00'),\n\t(324, 140, 7, 10, 'A range of antispasmodics are useful in the respiratory system', 'strong', '2026-03-22 21:15:29.348706+00'),\n\t(325, 109, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.350667+00'),\n\t(326, 141, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.352646+00'),\n\t(327, 57, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.354528+00'),\n\t(328, 142, 7, 13, 'The nervine antispasmodics, such as Valeriana officinalis and Scutellaria lateriflora, are also helpful.', 'strong', '2026-03-22 21:15:29.358041+00'),\n\t(329, 142, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.360972+00'),\n\t(330, 143, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.363151+00'),\n\t(331, 121, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.365012+00'),\n\t(332, 59, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.366665+00'),\n\t(333, 90, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.368414+00'),\n\t(334, 42, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.37005+00'),\n\t(335, 91, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.372129+00'),\n\t(336, 144, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.37418+00'),\n\t(337, 60, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.375759+00'),\n\t(338, 145, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.377305+00'),\n\t(339, 145, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.379061+00'),\n\t(340, 145, 7, 13, 'The nervine antispasmodics, such as Valeriana officinalis and Scutellaria lateriflora, are also helpful.', 'strong', '2026-03-22 21:15:29.380855+00'),\n\t(341, 145, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.382702+00'),\n\t(342, 61, 7, NULL, NULL, 'mild', '2026-03-22 21:15:29.384575+00'),\n\t(343, 146, 7, NULL, NULL, 'strong', '2026-03-22 21:15:29.386039+00'),\n\t(344, 93, 7, 9, NULL, 'strong', '2026-03-22 21:15:29.387672+00'),\n\t(345, 93, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.389166+00'),\n\t(346, 93, 7, 12, NULL, 'strong', '2026-03-22 21:15:29.391002+00'),\n\t(347, 93, 7, 13, 'Here, Viburnum opulus and Viburnum prunifolium come into their own', 'strong', '2026-03-22 21:15:29.394457+00'),\n\t(348, 93, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.396112+00'),\n\t(349, 94, 7, 11, 'All of the carminative herbs tend to act as antispasmodics in the gut, and hepatics can have such an action for gallbladder conditions.', 'strong', '2026-03-22 21:15:29.397864+00'),\n\t(350, 94, 7, 12, NULL, 'strong', '2026-03-22 21:15:29.399254+00'),\n\t(351, 94, 7, 13, 'Here, Viburnum opulus and Viburnum prunifolium come into their own', 'strong', '2026-03-22 21:15:29.401108+00'),\n\t(352, 94, 7, 14, 'Primary muscle relaxant remedies', 'strong', '2026-03-22 21:15:29.403779+00'),\n\t(353, 124, 7, NULL, NULL, NULL, '2026-03-22 21:15:29.405706+00'),\n\t(354, 147, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.407388+00'),\n\t(355, 44, 8, 9, 'Astringents are rarely needed internally for this system, although they are used externally for bruises that can be seen under the skin. However, certain cardiovascular remedies are also astringents, including this', NULL, '2026-03-22 21:15:29.409072+00'),\n\t(356, 44, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', NULL, '2026-03-22 21:15:29.411793+00'),\n\t(357, 44, 8, 12, NULL, NULL, '2026-03-22 21:15:29.413511+00'),\n\t(358, 44, 8, 16, 'Of the many external astringents, or styptics, an example is this', NULL, '2026-03-22 21:15:29.415664+00'),\n\t(425, 162, 10, 9, 'The primary cardiotonic herbs to consider, possibly this.', NULL, '2026-03-22 21:15:29.510833+00'),\n\t(359, 62, 8, 9, 'Astringents are rarely needed internally for this system, although they are used externally for bruises that can be seen under the skin. However, certain cardiovascular remedies are also astringents, including this', NULL, '2026-03-22 21:15:29.417141+00'),\n\t(360, 148, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.418826+00'),\n\t(361, 46, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.420405+00'),\n\t(362, 149, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.421848+00'),\n\t(363, 71, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', NULL, '2026-03-22 21:15:29.427068+00'),\n\t(364, 71, 8, 11, NULL, NULL, '2026-03-22 21:15:29.429277+00'),\n\t(365, 71, 8, 16, 'Of the many external astringents, or styptics, an example is this', NULL, '2026-03-22 21:15:29.430709+00'),\n\t(366, 150, 8, NULL, NULL, 'strong', '2026-03-22 21:15:29.432417+00'),\n\t(367, 151, 8, 12, NULL, NULL, '2026-03-22 21:15:29.434196+00'),\n\t(368, 151, 8, 16, 'Of the many external astringents, or styptics, an example is this', NULL, '2026-03-22 21:15:29.435895+00'),\n\t(369, 51, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', NULL, '2026-03-22 21:15:29.43726+00'),\n\t(370, 75, 8, 11, NULL, NULL, '2026-03-22 21:15:29.438577+00'),\n\t(371, 52, 8, 11, NULL, NULL, '2026-03-22 21:15:29.439854+00'),\n\t(372, 52, 8, 13, NULL, NULL, '2026-03-22 21:15:29.441496+00'),\n\t(373, 79, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.442937+00'),\n\t(374, 79, 8, 16, 'Of the many external astringents, or styptics, an example is this', 'strong', '2026-03-22 21:15:29.44424+00'),\n\t(375, 54, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.445677+00'),\n\t(376, 133, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.447031+00'),\n\t(377, 119, 8, NULL, NULL, 'strong', '2026-03-22 21:15:29.448248+00'),\n\t(378, 85, 8, 10, 'The anticatarrhal remedies often also have astringent properties.', 'mild', '2026-03-22 21:15:29.449539+00'),\n\t(379, 85, 8, 16, 'Of the many external astringents, or styptics, an example is this', 'mild', '2026-03-22 21:15:29.450744+00'),\n\t(380, 152, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.451954+00'),\n\t(381, 140, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.453132+00'),\n\t(382, 153, 8, 11, NULL, 'strong', '2026-03-22 21:15:29.454341+00'),\n\t(383, 153, 8, 16, 'Of the many external astringents, or styptics, an example is this', 'strong', '2026-03-22 21:15:29.455595+00'),\n\t(384, 154, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.456904+00'),\n\t(385, 109, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.458151+00'),\n\t(386, 155, 8, NULL, NULL, NULL, '2026-03-22 21:15:29.459441+00'),\n\t(387, 156, 8, NULL, NULL, 'strong', '2026-03-22 21:15:29.460679+00'),\n\t(388, 56, 8, 11, NULL, 'mild', '2026-03-22 21:15:29.462034+00'),\n\t(389, 58, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.463579+00'),\n\t(390, 89, 8, 11, NULL, 'mild', '2026-03-22 21:15:29.46482+00'),\n\t(391, 61, 8, NULL, NULL, 'mild', '2026-03-22 21:15:29.466167+00'),\n\t(392, 157, 8, 13, NULL, 'strong', '2026-03-22 21:15:29.467506+00'),\n\t(393, 44, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy. To a lesser degree, this, because of its mildness', 'mild', '2026-03-22 21:15:29.468829+00'),\n\t(394, 96, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'mild', '2026-03-22 21:15:29.470053+00'),\n\t(395, 97, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.471231+00'),\n\t(396, 97, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'strong', '2026-03-22 21:15:29.472415+00'),\n\t(397, 97, 9, 15, 'By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium', 'strong', '2026-03-22 21:15:29.473521+00'),\n\t(398, 115, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'mild', '2026-03-22 21:15:29.474773+00'),\n\t(399, 115, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'mild', '2026-03-22 21:15:29.476072+00'),\n\t(400, 115, 9, 15, 'By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium', 'mild', '2026-03-22 21:15:29.477372+00'),\n\t(401, 158, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.478603+00'),\n\t(402, 159, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.479879+00'),\n\t(403, 50, 9, NULL, NULL, 'strong', '2026-03-22 21:15:29.481093+00'),\n\t(404, 102, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.482419+00'),\n\t(405, 102, 9, 15, 'By stimulating healthy body processes, bitters support the nervous system in cases of depression and general nervous debility. Any bitter can work, but those most often used are Gentiana lutea, Artemisia vulgaris, and Artemisia absinthium', 'strong', '2026-03-22 21:15:29.483818+00'),\n\t(406, 30, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.485351+00'),\n\t(407, 160, 9, 10, 'Certain bitters have expectorant actions, and in the case of Marrubium vulgare, we have an excellent remedy for all chest problems combined with the value of a potent bitter', 'strong', '2026-03-22 21:15:29.486919+00'),\n\t(408, 84, 9, NULL, NULL, 'mild', '2026-03-22 21:15:29.488182+00'),\n\t(409, 34, 9, 14, 'Anything that helps with digestion and assimilation of food will benefit the musculoskeletal system. A bitter that is particularly valuable for this system is Menyanthes trifoliata', NULL, '2026-03-22 21:15:29.489522+00'),\n\t(410, 110, 9, 11, 'takes into account the liver and pancreas as organs of the digestive system', 'strong', '2026-03-22 21:15:29.490692+00'),\n\t(411, 110, 9, 13, 'Many bitter herbs have the ability to initiate delayed menstrual periods. They may, however, cause some cramping, and must not be used during pregnancy', 'strong', '2026-03-22 21:15:29.492108+00'),\n\t(412, 161, 9, NULL, NULL, 'strong', '2026-03-22 21:15:29.493362+00'),\n\t(413, 122, 9, NULL, NULL, 'mild', '2026-03-22 21:15:29.494772+00'),\n\t(414, 44, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.496021+00'),\n\t(415, 44, 10, 11, NULL, NULL, '2026-03-22 21:15:29.497389+00'),\n\t(416, 44, 10, 12, 'Most of the herbs that have a direct impact on the heart’s action also increase the amount of blood that passes through the kidneys, and so act as diuretics. Achillea millefolium is used in urinary problems, as is Cytisus scoparius. Any cardioactive properties must be taken into account, especially with Cytisus scoparius.', NULL, '2026-03-22 21:15:29.498664+00'),\n\t(417, 44, 10, 13, 'The cardiac tonics are not directly involved in the function of this system. Achillea millefolium may play a role as a gentle emmenagogue.', NULL, '2026-03-22 21:15:29.499993+00'),\n\t(418, 44, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.50151+00'),\n\t(419, 62, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.502963+00'),\n\t(420, 62, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.504324+00'),\n\t(421, 21, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.505629+00'),\n\t(422, 21, 10, 10, 'Any problem with the activity of the heart might have an effect on lung congestion due to a backup of blood waiting to be pumped. Thus, cardiac tonics may benefit the lungs by helping the heart. This is renowned for its antimicrobial and generally beneficial action on the lungs.', NULL, '2026-03-22 21:15:29.506971+00'),\n\t(423, 21, 10, 11, NULL, NULL, '2026-03-22 21:15:29.50825+00'),\n\t(424, 47, 10, 14, 'Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness', NULL, '2026-03-22 21:15:29.509585+00'),\n\t(570, 125, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.820719+00'),\n\t(426, 163, 10, 9, 'Primarily cardioactive remedies include Convallaria majalis and Digitalis lanata. Must be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.512078+00'),\n\t(427, 73, 10, 9, 'The primary cardiotonic herbs to consider', NULL, '2026-03-22 21:15:29.513366+00'),\n\t(429, 73, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.518104+00'),\n\t(430, 164, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.519549+00'),\n\t(431, 164, 10, 12, 'Most of the herbs that have a direct impact on the heart’s action also increase the amount of blood that passes through the kidneys, and so act as diuretics. Achillea millefolium is used in urinary problems, as is Cytisus scoparius. Any cardioactive properties must be taken into account, especially with Cytisus scoparius.', NULL, '2026-03-22 21:15:29.521201+00'),\n\t(432, 165, 10, 9, 'Remedies that specifically benefit blood vessels', NULL, '2026-03-22 21:15:29.522859+00'),\n\t(433, 131, 10, 11, NULL, NULL, '2026-03-22 21:15:29.524138+00'),\n\t(434, 131, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.525613+00'),\n\t(435, 133, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.527153+00'),\n\t(436, 134, 10, 11, NULL, NULL, '2026-03-22 21:15:29.528604+00'),\n\t(437, 134, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.529969+00'),\n\t(438, 109, 10, 11, NULL, NULL, '2026-03-22 21:15:29.531134+00'),\n\t(439, 109, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.532418+00'),\n\t(440, 39, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.533992+00'),\n\t(441, 39, 10, 16, 'The only directly applicable remedy here', NULL, '2026-03-22 21:15:29.535597+00'),\n\t(442, 90, 10, 9, 'The primary cardiotonic herbs to consider', NULL, '2026-03-22 21:15:29.605311+00'),\n\t(444, 90, 10, 11, NULL, NULL, '2026-03-22 21:15:29.609257+00'),\n\t(445, 90, 10, 15, 'Has a relaxing effect on the nervous system. Many nervines help the circulatory system by relaxing the mind and body as a whole', NULL, '2026-03-22 21:15:29.611231+00'),\n\t(446, 90, 10, 16, 'when a skin problem is related to varicosity in veins, cardiac tonics are very important', NULL, '2026-03-22 21:15:29.612793+00'),\n\t(447, 166, 10, 9, 'Other plants that mimic this cardioactive effect but do not contain cardiac glycosides. Must still be used with caution in order to avoid toxicity problems in heart patients.', NULL, '2026-03-22 21:15:29.614238+00'),\n\t(448, 123, 10, 14, 'Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness', NULL, '2026-03-22 21:15:29.615763+00'),\n\t(449, 124, 10, 14, 'Herbs that act as circulatory stimulants are important here because they increase peripheral blood flow. This can reduce swelling and ease stiffness', NULL, '2026-03-22 21:15:29.618071+00'),\n\t(450, 21, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.621595+00'),\n\t(451, 21, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.626015+00'),\n\t(452, 21, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.627914+00'),\n\t(453, 64, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.629565+00'),\n\t(454, 65, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.631889+00'),\n\t(455, 65, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.634011+00'),\n\t(456, 65, 11, 14, 'a carminative that is also a specific anti-inflammatory for this system', NULL, '2026-03-22 21:15:29.636329+00'),\n\t(457, 66, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.638189+00'),\n\t(458, 66, 11, 14, 'a carminative that is also a specific anti-inflammatory for this system', NULL, '2026-03-22 21:15:29.640253+00'),\n\t(459, 97, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.642313+00'),\n\t(460, 98, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.644194+00'),\n\t(461, 167, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.646449+00'),\n\t(462, 127, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.648388+00'),\n\t(463, 168, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.650467+00'),\n\t(464, 76, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.652017+00'),\n\t(465, 77, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.653979+00'),\n\t(466, 77, 11, 14, 'a carminative that is also a specific anti-inflammatory for this system', NULL, '2026-03-22 21:15:29.655526+00'),\n\t(467, 129, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.657154+00'),\n\t(468, 129, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.659518+00'),\n\t(469, 103, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.662077+00'),\n\t(571, 151, 14, 12, NULL, NULL, '2026-03-22 21:15:29.82212+00'),\n\t(572, 184, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.823527+00'),\n\t(470, 103, 11, 12, 'Because of their volatile oil content, some carminatives act as diuretics and may even irritate the kidneys', NULL, '2026-03-22 21:15:29.664054+00'),\n\t(471, 131, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.667802+00'),\n\t(472, 131, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.672672+00'),\n\t(473, 84, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.674035+00'),\n\t(474, 84, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.675484+00'),\n\t(475, 84, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.68008+00'),\n\t(476, 134, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.681589+00'),\n\t(477, 134, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.682981+00'),\n\t(478, 134, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.684305+00'),\n\t(479, 55, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.685758+00'),\n\t(480, 55, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.687041+00'),\n\t(481, 135, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.688568+00'),\n\t(482, 120, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.689895+00'),\n\t(483, 108, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.691064+00'),\n\t(484, 108, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.692177+00'),\n\t(485, 56, 11, 10, 'Many carminative herbs support this system through antispasmodic, antimicrobial, or anticatarrhal actions', NULL, '2026-03-22 21:15:29.693364+00'),\n\t(486, 56, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.694827+00'),\n\t(487, 169, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.696243+00'),\n\t(488, 145, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.69758+00'),\n\t(489, 145, 11, 15, 'Many volatile oil–containing remedies will soothe the nervous system', NULL, '2026-03-22 21:15:29.698936+00'),\n\t(490, 124, 11, 9, 'Carminatives may ease apparent cardiac symptoms by eliminating the pressure of flatulence and digestive pain. While most of the carminatives have no action on this system at all, volatile oils of this herb does have cardiovascular effects', NULL, '2026-03-22 21:15:29.700231+00'),\n\t(491, 124, 11, 11, 'As carminatives act specifically on the digestive tract, the list of herbs appropriate for this system is extremely long. All of the herbs listed as carminatives may be relevant.', NULL, '2026-03-22 21:15:29.701869+00'),\n\t(492, 23, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'strong', '2026-03-22 21:15:29.70329+00'),\n\t(493, 158, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.704665+00'),\n\t(494, 158, 12, 13, 'Cholagogue remedies such as Hydrastis canadensis and Berberis vulgaris have a marked action on the muscles of the uterus, as they are strong bitters', 'strong', '2026-03-22 21:15:29.705989+00'),\n\t(495, 170, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.707282+00'),\n\t(496, 171, 12, NULL, NULL, 'mild', '2026-03-22 21:15:29.708967+00'),\n\t(497, 24, 12, 11, 'the bark', 'mild', '2026-03-22 21:15:29.710327+00'),\n\t(498, 172, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.711626+00'),\n\t(499, 74, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.712825+00'),\n\t(500, 173, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.713979+00'),\n\t(501, 50, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'mild', '2026-03-22 21:15:29.71524+00'),\n\t(502, 50, 12, 12, 'can be an effective diuretic in feverish conditions', 'mild', '2026-03-22 21:15:29.71655+00'),\n\t(503, 27, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'mild', '2026-03-22 21:15:29.717783+00'),\n\t(504, 102, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.719032+00'),\n\t(505, 30, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'strong', '2026-03-22 21:15:29.720201+00'),\n\t(506, 30, 12, 13, 'Cholagogue remedies such as Hydrastis canadensis and Berberis vulgaris have a marked action on the muscles of the uterus, as they are strong bitters', 'strong', '2026-03-22 21:15:29.721549+00'),\n\t(507, 30, 12, 16, 'may also be of use externally', 'strong', '2026-03-22 21:15:29.722972+00'),\n\t(514, 31, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.732152+00'),\n\t(515, 31, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'strong', '2026-03-22 21:15:29.733676+00'),\n\t(516, 174, 12, 11, NULL, 'strong', '2026-03-22 21:15:29.735177+00'),\n\t(517, 175, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.736462+00'),\n\t(518, 33, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'strong', '2026-03-22 21:15:29.737913+00'),\n\t(519, 134, 12, 11, NULL, NULL, '2026-03-22 21:15:29.739894+00'),\n\t(520, 176, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.741402+00'),\n\t(521, 109, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'mild', '2026-03-22 21:15:29.742845+00'),\n\t(522, 109, 12, 13, 'has a tonic and emmenagogue action, while most bitters stimulate the womb or menstrual activity', 'mild', '2026-03-22 21:15:29.744433+00'),\n\t(523, 109, 12, 15, 'Because they help with assimilation, cholagogues have an enlivening “side effect” in the nervous system. These remedies may actively ease debility and depression. Rosmarinus officinalis is a', 'mild', '2026-03-22 21:15:29.745831+00'),\n\t(524, 37, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'mild', '2026-03-22 21:15:29.747349+00'),\n\t(525, 56, 12, 10, 'Certain cholagogues are also antimicrobial and anticatarrhal and in this way benefit the whole system. Some are also mucous membrane tonics, including this', 'mild', '2026-03-22 21:15:29.748686+00'),\n\t(526, 177, 12, 11, NULL, 'mild', '2026-03-22 21:15:29.749931+00'),\n\t(527, 177, 12, 12, 'Cholagogues confer only indirect benefits to this system. However, Taraxacum officinale root is partially diuretic in action, although weaker than the leaves', 'mild', '2026-03-22 21:15:29.751165+00'),\n\t(528, 177, 12, 16, 'Taken internally, cholagogues often aid in cleansing the body and so may help clear skin problems. Examples are Iris versicolor, Taraxacum officinale, Fumaria officinalis, Hydrastis canadensis, Mahonia aquifolium, and Rumex crispus.', 'mild', '2026-03-22 21:15:29.752329+00'),\n\t(529, 45, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.753414+00'),\n\t(530, 45, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.754616+00'),\n\t(531, 178, 13, 15, 'Demulcents are of direct value in this system only when applied to the skin, as in shingles. However, skin tonics may be thought of as “surrogate” demulcents, especially Avena sativa.', NULL, '2026-03-22 21:15:29.756145+00'),\n\t(532, 48, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.75751+00'),\n\t(533, 49, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.758802+00'),\n\t(534, 179, 13, 12, 'Excellent kidney and bladder demulcents', NULL, '2026-03-22 21:15:29.760109+00'),\n\t(535, 78, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.761521+00'),\n\t(536, 78, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.762904+00'),\n\t(537, 180, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.764571+00'),\n\t(538, 180, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.76583+00'),\n\t(539, 83, 13, NULL, NULL, NULL, '2026-03-22 21:15:29.767281+00'),\n\t(540, 89, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.768639+00'),\n\t(541, 89, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.769901+00'),\n\t(542, 89, 13, 14, 'Vulneraries and anti-inflammatories have a more direct value in this system than demulcents as such. The undeniable value of Symphytum officinale here is related to its vulnerary properties', NULL, '2026-03-22 21:15:29.77108+00'),\n\t(543, 89, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.772341+00'),\n\t(544, 60, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.773728+00'),\n\t(545, 92, 13, 11, 'These remedies can be applied freely whenever a soothing demulcent is indicated', NULL, '2026-03-22 21:15:29.774913+00'),\n\t(546, 92, 13, 16, 'The emollient herbs are all demulcent, including Symphytum officinale, Althaea officinalis, Plantago major, Stellaria media, Ulmus rubra, and Linum usitatissimum', NULL, '2026-03-22 21:15:29.776263+00'),\n\t(547, 61, 13, 10, 'soothe inflammation in the chest, throat and sinuses', NULL, '2026-03-22 21:15:29.777743+00'),\n\t(548, 95, 13, NULL, NULL, NULL, '2026-03-22 21:15:29.781489+00'),\n\t(549, 44, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', 'strong', '2026-03-22 21:15:29.783231+00'),\n\t(550, 44, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', 'strong', '2026-03-22 21:15:29.784589+00'),\n\t(551, 44, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.786031+00'),\n\t(552, 44, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.787485+00'),\n\t(553, 181, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.788888+00'),\n\t(554, 148, 14, 11, 'Some laxative herbs also act as diuretics', NULL, '2026-03-22 21:15:29.790537+00'),\n\t(555, 148, 14, 12, NULL, NULL, '2026-03-22 21:15:29.792019+00'),\n\t(556, 66, 14, 11, 'Some laxative herbs also act as diuretics', 'strong', '2026-03-22 21:15:29.793408+00'),\n\t(557, 66, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.794645+00'),\n\t(558, 66, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.800232+00'),\n\t(559, 22, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.802846+00'),\n\t(560, 46, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.804651+00'),\n\t(561, 46, 14, 13, 'Antiseptic diuretics often have similar effects in the reproductive system.', 'strong', '2026-03-22 21:15:29.80637+00'),\n\t(562, 150, 14, 12, NULL, NULL, '2026-03-22 21:15:29.807791+00'),\n\t(563, 182, 14, 12, NULL, NULL, '2026-03-22 21:15:29.809241+00'),\n\t(564, 163, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', NULL, '2026-03-22 21:15:29.810884+00'),\n\t(565, 163, 14, 12, NULL, NULL, '2026-03-22 21:15:29.812739+00'),\n\t(566, 73, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.815042+00'),\n\t(567, 183, 14, 12, NULL, NULL, '2026-03-22 21:15:29.816578+00'),\n\t(568, 164, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', 'strong', '2026-03-22 21:15:29.817901+00'),\n\t(569, 164, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.819263+00'),\n\t(573, 50, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', 'strong', '2026-03-22 21:15:29.824756+00'),\n\t(574, 50, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.826081+00'),\n\t(575, 50, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.82742+00'),\n\t(576, 117, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.828625+00'),\n\t(577, 117, 14, 14, 'Because of their cleansing actions, many diuretics help with problems of muscles and bones', 'strong', '2026-03-22 21:15:29.829869+00'),\n\t(578, 28, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', 'strong', '2026-03-22 21:15:29.830997+00'),\n\t(579, 28, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.832126+00'),\n\t(580, 28, 14, 16, 'All of the diuretics can potentially help the skin through inner cleansing actions. Especially important are these', 'strong', '2026-03-22 21:15:29.833416+00'),\n\t(581, 31, 14, 11, 'Some laxative herbs also act as diuretics', 'mild', '2026-03-22 21:15:29.83509+00'),\n\t(582, 31, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.836506+00'),\n\t(583, 103, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.837776+00'),\n\t(584, 185, 14, 12, NULL, NULL, '2026-03-22 21:15:29.839227+00'),\n\t(585, 120, 14, 11, 'Some laxative herbs also act as diuretics', 'strong', '2026-03-22 21:15:29.840713+00'),\n\t(586, 120, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.842068+00'),\n\t(587, 176, 14, 11, 'Some laxative herbs also act as diuretics', 'mild', '2026-03-22 21:15:29.843233+00'),\n\t(588, 176, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.844662+00'),\n\t(589, 57, 14, 10, 'If chest congestion is related to heart problems, most of the diuretics will be of value.', NULL, '2026-03-22 21:15:29.846264+00'),\n\t(590, 57, 14, 12, NULL, NULL, '2026-03-22 21:15:29.848136+00'),\n\t(591, 186, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.849884+00'),\n\t(592, 186, 14, 13, 'a mild diuretic.', 'mild', '2026-03-22 21:15:29.85183+00'),\n\t(593, 122, 14, 9, 'As already noted, cardioactive remedies have a diuretic effect because they increase blood flow through the kidneys. All diuretics that help remove water from the body can be of benefit for the cardiovascular system, including Convallaria majalis, Cytisus scoparius, Taraxacum officinale, and Achillea millefolium. Care should be taken to ensure that the right herb is used for the specific condition. For example, Cytisus scoparius should not be used in people with high blood pressure.', 'strong', '2026-03-22 21:15:29.853687+00'),\n\t(594, 122, 14, 11, 'Some laxative herbs also act as diuretics', 'strong', '2026-03-22 21:15:29.855162+00'),\n\t(595, 122, 14, 12, NULL, 'strong', '2026-03-22 21:15:29.856699+00'),\n\t(596, 122, 14, 16, 'All of the diuretics can potentially help the skin through inner cleansing actions. Especially important are these', 'strong', '2026-03-22 21:15:29.858345+00'),\n\t(597, 90, 14, 12, NULL, 'mild', '2026-03-22 21:15:29.859696+00'),\n\t(598, 95, 14, 12, NULL, NULL, '2026-03-22 21:15:29.861134+00'),\n\t(599, 44, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.862831+00'),\n\t(600, 96, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.864286+00'),\n\t(601, 97, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.865679+00'),\n\t(602, 115, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.867053+00'),\n\t(603, 70, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.868419+00'),\n\t(604, 72, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.869678+00'),\n\t(605, 25, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.870858+00'),\n\t(606, 102, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.872121+00'),\n\t(607, 30, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.873327+00'),\n\t(608, 53, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.874524+00'),\n\t(609, 82, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.875613+00'),\n\t(610, 131, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.876708+00'),\n\t(611, 160, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.87779+00'),\n\t(612, 187, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.878844+00'),\n\t(613, 84, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.879997+00'),\n\t(614, 55, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.881386+00'),\n\t(615, 135, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.882609+00'),\n\t(616, 188, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.883993+00'),\n\t(617, 120, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.885117+00'),\n\t(618, 35, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.886224+00'),\n\t(619, 36, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.887276+00'),\n\t(620, 109, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.888388+00'),\n\t(621, 155, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.889456+00'),\n\t(622, 110, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.890571+00'),\n\t(623, 56, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.89176+00'),\n\t(624, 121, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.892881+00'),\n\t(625, 161, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.893971+00'),\n\t(626, 59, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.895034+00'),\n\t(627, 90, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.896093+00'),\n\t(628, 91, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.897127+00'),\n\t(629, 189, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.898142+00'),\n\t(630, 145, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.89925+00'),\n\t(631, 146, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.900603+00'),\n\t(632, 93, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.901834+00'),\n\t(633, 94, 15, NULL, NULL, 'mild', '2026-03-22 21:15:29.903085+00'),\n\t(634, 190, 15, NULL, NULL, NULL, '2026-03-22 21:15:29.904241+00'),\n\t(635, 124, 15, NULL, NULL, 'strong', '2026-03-22 21:15:29.905466+00'),\n\t(636, 191, 16, 10, NULL, NULL, '2026-03-22 21:15:29.906503+00'),\n\t(637, 192, 16, 10, NULL, NULL, '2026-03-22 21:15:29.907738+00'),\n\t(638, 192, 16, 11, 'All of the stimulating expectorants may act as emetics if taken in too high a dose (for example, Cephaelis ipecacuanha)', NULL, '2026-03-22 21:15:29.908844+00'),\n\t(639, 193, 16, 10, NULL, NULL, '2026-03-22 21:15:29.909957+00'),\n\t(640, 54, 16, 10, NULL, NULL, '2026-03-22 21:15:29.911074+00'),\n\t(641, 54, 16, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.912209+00'),\n\t(642, 160, 16, 10, NULL, NULL, '2026-03-22 21:15:29.913456+00'),\n\t(643, 194, 16, 10, NULL, NULL, '2026-03-22 21:15:29.914726+00'),\n\t(644, 195, 16, 10, NULL, NULL, '2026-03-22 21:15:29.91577+00'),\n\t(645, 196, 16, 10, NULL, NULL, '2026-03-22 21:15:29.916986+00'),\n\t(646, 196, 16, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.918333+00'),\n\t(647, 197, 16, 10, NULL, NULL, '2026-03-22 21:15:29.919626+00'),\n\t(648, 197, 16, 15, 'can have relaxing nervine action.', NULL, '2026-03-22 21:15:29.920775+00'),\n\t(649, 38, 16, 10, NULL, NULL, '2026-03-22 21:15:29.923083+00'),\n\t(650, 166, 16, 10, NULL, NULL, '2026-03-22 21:15:29.92464+00'),\n\t(651, 198, 16, 10, NULL, NULL, '2026-03-22 21:15:29.925912+00'),\n\t(652, 45, 17, 10, NULL, NULL, '2026-03-22 21:15:29.927551+00'),\n\t(653, 67, 17, 10, NULL, NULL, '2026-03-22 21:15:29.928912+00'),\n\t(654, 48, 17, 10, NULL, NULL, '2026-03-22 21:15:29.930195+00'),\n\t(655, 49, 17, 10, NULL, NULL, '2026-03-22 21:15:29.931295+00'),\n\t(656, 126, 17, 10, NULL, NULL, '2026-03-22 21:15:29.932455+00'),\n\t(657, 78, 17, 10, NULL, NULL, '2026-03-22 21:15:29.933712+00'),\n\t(658, 199, 17, 10, NULL, NULL, '2026-03-22 21:15:29.934942+00'),\n\t(659, 30, 17, 10, NULL, NULL, '2026-03-22 21:15:29.936268+00'),\n\t(660, 30, 17, 13, 'can work as an expectorant while toning the mucous membranes of the respiratory system, may also be of value in the reproductive tract.', NULL, '2026-03-22 21:15:29.937458+00'),\n\t(661, 30, 17, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.938778+00'),\n\t(662, 53, 17, 10, NULL, NULL, '2026-03-22 21:15:29.940014+00'),\n\t(663, 53, 17, 15, 'can have relaxing nervine actions', NULL, '2026-03-22 21:15:29.94184+00'),\n\t(664, 132, 17, 10, NULL, NULL, '2026-03-22 21:15:29.943298+00'),\n\t(665, 132, 17, 14, 'a good muscle relaxant', NULL, '2026-03-22 21:15:29.9446+00'),\n\t(666, 108, 17, 10, NULL, NULL, '2026-03-22 21:15:29.945874+00'),\n\t(667, 108, 17, 11, 'The relaxing expectorants may be either demulcents (Symphytum officinale) or carminatives (Pimpinella anisum).', NULL, '2026-03-22 21:15:29.947182+00'),\n\t(668, 140, 17, 10, NULL, NULL, '2026-03-22 21:15:29.94868+00'),\n\t(669, 200, 17, 10, NULL, NULL, '2026-03-22 21:15:29.949795+00'),\n\t(670, 89, 17, 10, NULL, NULL, '2026-03-22 21:15:29.95085+00'),\n\t(671, 89, 17, 11, 'The relaxing expectorants may be either demulcents (Symphytum officinale) or carminatives (Pimpinella anisum).', NULL, '2026-03-22 21:15:29.951928+00'),\n\t(672, 89, 17, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.953254+00'),\n\t(673, 143, 17, 10, NULL, NULL, '2026-03-22 21:15:29.954802+00'),\n\t(674, 201, 17, 10, NULL, NULL, '2026-03-22 21:15:29.956084+00'),\n\t(675, 59, 17, 10, NULL, NULL, '2026-03-22 21:15:29.957407+00'),\n\t(676, 59, 17, 15, 'can have relaxing nervine actions', NULL, '2026-03-22 21:15:29.958655+00'),\n\t(677, 60, 17, 10, NULL, NULL, '2026-03-22 21:15:29.959912+00'),\n\t(678, 146, 17, 10, NULL, NULL, '2026-03-22 21:15:29.961173+00'),\n\t(679, 146, 17, 15, 'can have relaxing nervine actions', NULL, '2026-03-22 21:15:29.96275+00'),\n\t(680, 21, 18, 10, NULL, NULL, '2026-03-22 21:15:29.964255+00'),\n\t(681, 21, 18, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.965647+00'),\n\t(682, 57, 18, 10, NULL, NULL, '2026-03-22 21:15:29.966949+00'),\n\t(683, 57, 18, 16, 'By supporting respiration and thus the whole of a person’s health, these remedies may help the skin in a broad holistic way. Expectorants that may be used internally or externally for the skin include this', NULL, '2026-03-22 21:15:29.968197+00'),\n\t(684, 61, 18, 10, NULL, NULL, '2026-03-22 21:15:29.969338+00'),\n\t(685, 44, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.970522+00'),\n\t(686, 148, 19, 11, NULL, NULL, '2026-03-22 21:15:29.971752+00'),\n\t(687, 202, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.972986+00'),\n\t(688, 66, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.97425+00'),\n\t(689, 113, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.975355+00'),\n\t(690, 97, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.976506+00'),\n\t(691, 23, 19, 10, 'Certain hepatics are also antimicrobial and anticatarrhal, which will benefit the respiratory system. Also, mucous membrane tonics help here, including herbs such as this', NULL, '2026-03-22 21:15:29.977632+00'),\n\t(692, 158, 19, 11, NULL, NULL, '2026-03-22 21:15:29.979032+00'),\n\t(693, 158, 19, 13, 'Hepatic plants such as Hydrastis canadensis and Berberis vulgaris have a pronounced action on the muscles of the uterus', NULL, '2026-03-22 21:15:29.980132+00'),\n\t(694, 159, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.981341+00'),\n\t(695, 171, 19, 11, NULL, NULL, '2026-03-22 21:15:29.982539+00'),\n\t(696, 24, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.983716+00'),\n\t(697, 203, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.984789+00'),\n\t(698, 172, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.98591+00'),\n\t(699, 74, 19, 11, NULL, NULL, '2026-03-22 21:15:29.987084+00'),\n\t(700, 173, 19, 11, NULL, NULL, '2026-03-22 21:15:29.988444+00'),\n\t(701, 76, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.989787+00'),\n\t(702, 27, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:29.991019+00'),\n\t(703, 28, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.992217+00'),\n\t(704, 102, 19, 11, NULL, NULL, '2026-03-22 21:15:29.993514+00'),\n\t(705, 30, 19, 10, 'Certain hepatics are also antimicrobial and anticatarrhal, which will benefit the respiratory system. Also, mucous membrane tonics help here, including herbs such as this', NULL, '2026-03-22 21:15:29.994839+00'),\n\t(706, 30, 19, 13, 'Hepatic plants such as Hydrastis canadensis and Berberis vulgaris have a pronounced action on the muscles of the uterus', NULL, '2026-03-22 21:15:29.996054+00'),\n\t(707, 30, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:29.997265+00'),\n\t(709, 53, 19, NULL, NULL, NULL, '2026-03-22 21:15:29.99964+00'),\n\t(710, 54, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.000842+00'),\n\t(711, 31, 19, 11, NULL, NULL, '2026-03-22 21:15:30.002649+00'),\n\t(712, 31, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.004355+00'),\n\t(713, 131, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.005781+00'),\n\t(714, 175, 19, 11, NULL, NULL, '2026-03-22 21:15:30.006994+00'),\n\t(715, 33, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.008192+00'),\n\t(716, 134, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.009694+00'),\n\t(717, 34, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.010739+00'),\n\t(718, 176, 19, 11, NULL, NULL, '2026-03-22 21:15:30.011863+00'),\n\t(719, 204, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.013154+00'),\n\t(720, 205, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.014365+00'),\n\t(721, 37, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.015635+00'),\n\t(722, 206, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.016901+00'),\n\t(723, 177, 19, 11, NULL, NULL, '2026-03-22 21:15:30.018239+00'),\n\t(724, 177, 19, 12, 'Hepatics confer only an indirect benefit to this system. However, Taraxacum officinale root is partially diuretic in action, although weaker than the leaves', NULL, '2026-03-22 21:15:30.019678+00'),\n\t(725, 177, 19, 16, 'Taken internally, hepatic remedies often aid in cleansing and so clear skin problems.', NULL, '2026-03-22 21:15:30.020885+00'),\n\t(726, 123, 19, NULL, NULL, NULL, '2026-03-22 21:15:30.022222+00'),\n\t(727, 115, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.023632+00'),\n\t(728, 115, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.024861+00'),\n\t(729, 128, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.026145+00'),\n\t(730, 128, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.027338+00'),\n\t(731, 129, 20, 11, 'The relaxing nervines and carminatives are important', 'strong', '2026-03-22 21:15:30.028709+00'),\n\t(733, 129, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.03112+00'),\n\t(734, 129, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.032262+00'),\n\t(735, 130, 20, 10, 'eases irritable coughs', 'strong', '2026-03-22 21:15:30.0334+00'),\n\t(736, 130, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.034661+00'),\n\t(737, 130, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.036212+00'),\n\t(738, 131, 20, 9, 'Notice that this herb are all in the “milder” category', 'mild', '2026-03-22 21:15:30.037816+00'),\n\t(739, 131, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.039182+00'),\n\t(740, 131, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.040592+00'),\n\t(741, 84, 20, 11, 'The relaxing nervines and carminatives are important', 'mild', '2026-03-22 21:15:30.042968+00'),\n\t(742, 84, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.045066+00'),\n\t(743, 84, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.046872+00'),\n\t(744, 137, 20, 11, 'will help with intestinal colic—for example', 'strong', '2026-03-22 21:15:30.048683+00'),\n\t(745, 137, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.050671+00'),\n\t(746, 137, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.052866+00'),\n\t(747, 35, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.05479+00'),\n\t(748, 35, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.056713+00'),\n\t(749, 139, 20, 11, 'will help with intestinal colic—for example', 'strong', '2026-03-22 21:15:30.058546+00'),\n\t(750, 139, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.059905+00'),\n\t(751, 139, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.061367+00'),\n\t(752, 139, 20, 14, 'All hypnotics help reduce muscle tension and even the pain associated with problems in this system. They may be used', 'strong', '2026-03-22 21:15:30.062674+00'),\n\t(753, 142, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.063845+00'),\n\t(754, 142, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.064976+00'),\n\t(755, 207, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.070166+00'),\n\t(756, 207, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.072364+00'),\n\t(757, 90, 20, 9, 'Notice that this herb are all in the “milder” category', 'mild', '2026-03-22 21:15:30.073938+00'),\n\t(758, 90, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.075146+00'),\n\t(759, 90, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'mild', '2026-03-22 21:15:30.07631+00'),\n\t(760, 145, 20, 11, 'The relaxing nervines and carminatives are important', 'strong', '2026-03-22 21:15:30.077669+00'),\n\t(762, 145, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.080474+00'),\n\t(763, 145, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', 'strong', '2026-03-22 21:15:30.082035+00'),\n\t(764, 145, 20, 14, 'All hypnotics help reduce muscle tension and even the pain associated with problems in this system. They may be used', 'strong', '2026-03-22 21:15:30.083352+00'),\n\t(765, 146, 20, 11, 'The relaxing nervines and carminatives are important', NULL, '2026-03-22 21:15:30.08493+00'),\n\t(766, 146, 20, 12, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.086162+00'),\n\t(767, 146, 20, 13, 'Hypnotics are important here when used as muscle relaxants.', NULL, '2026-03-22 21:15:30.087521+00'),\n\t(768, 44, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.08892+00'),\n\t(769, 208, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.090184+00'),\n\t(770, 209, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.091531+00'),\n\t(771, 72, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.092829+00'),\n\t(772, 25, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.094093+00'),\n\t(773, 73, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.095205+00'),\n\t(774, 9, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.096217+00'),\n\t(775, 210, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.097517+00'),\n\t(776, 131, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.098762+00'),\n\t(777, 137, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.099968+00'),\n\t(778, 120, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.101153+00'),\n\t(779, 142, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.102739+00'),\n\t(780, 90, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.104272+00'),\n\t(781, 91, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.105603+00'),\n\t(782, 43, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.106993+00'),\n\t(783, 145, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.108243+00'),\n\t(784, 146, 21, NULL, NULL, 'mild', '2026-03-22 21:15:30.109533+00'),\n\t(785, 93, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.110739+00'),\n\t(786, 94, 21, NULL, NULL, NULL, '2026-03-22 21:15:30.112034+00'),\n\t(787, 211, 21, NULL, NULL, 'strong', '2026-03-22 21:15:30.113446+00'),\n\t(788, 142, 22, NULL, NULL, NULL, '2026-03-22 21:15:30.114627+00'),\n\t(789, 81, 22, NULL, NULL, NULL, '2026-03-22 21:15:30.115665+00'),\n\t(790, 115, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.116959+00'),\n\t(791, 212, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.118179+00'),\n\t(792, 69, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.119857+00'),\n\t(793, 213, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.121129+00'),\n\t(794, 25, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', NULL, '2026-03-22 21:15:30.122522+00'),\n\t(795, 25, 23, 13, NULL, NULL, '2026-03-22 21:15:30.123708+00'),\n\t(796, 25, 23, 14, 'All sedative remedies will help ease muscular tension and pain in this complex system', NULL, '2026-03-22 21:15:30.124828+00'),\n\t(797, 25, 23, 16, 'All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions', NULL, '2026-03-22 21:15:30.125939+00'),\n\t(798, 128, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.127248+00'),\n\t(799, 129, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include stronger herbs such as this', 'strong', '2026-03-22 21:15:30.128455+00'),\n\t(800, 81, 23, 16, 'All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions', NULL, '2026-03-22 21:15:30.12952+00'),\n\t(801, 53, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.130638+00'),\n\t(802, 130, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', 'strong', '2026-03-22 21:15:30.131851+00'),\n\t(803, 130, 23, 13, NULL, 'strong', '2026-03-22 21:15:30.13298+00'),\n\t(804, 82, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this', 'mild', '2026-03-22 21:15:30.134267+00'),\n\t(805, 131, 23, 9, 'a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.', NULL, '2026-03-22 21:15:30.136175+00'),\n\t(806, 131, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', NULL, '2026-03-22 21:15:30.137908+00'),\n\t(807, 131, 23, 13, NULL, NULL, '2026-03-22 21:15:30.139207+00'),\n\t(808, 132, 23, 10, 'Most sedatives will help with problems accompanied by chest tension, such as asthma, but specifically, we can mention this', NULL, '2026-03-22 21:15:30.140346+00'),\n\t(809, 84, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this', NULL, '2026-03-22 21:15:30.142443+00'),\n\t(810, 134, 23, 9, 'a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.', 'mild', '2026-03-22 21:15:30.145965+00'),\n\t(811, 134, 23, 11, 'All of the antispasmodic remedies may be of value here in easing spasms or colic. However, sedatives that actively aid digestion include mild herbs such as this', 'mild', '2026-03-22 21:15:30.148135+00'),\n\t(812, 137, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.149578+00'),\n\t(813, 138, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.151004+00'),\n\t(814, 139, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.152235+00'),\n\t(815, 36, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.153452+00'),\n\t(816, 142, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.154693+00'),\n\t(817, 214, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.15602+00'),\n\t(818, 90, 23, 9, 'a mild sedatives that are helpful to the cardiovascular system. However, most remedies that lessen overactivity of the nervous system will also aid the heart and have a positive impact on circulatory conditions, such as high blood pressure.', NULL, '2026-03-22 21:15:30.157444+00'),\n\t(819, 42, 23, 16, 'All nervines may help the skin in an indirect way, but the following have a good reputation for skin conditions', 'mild', '2026-03-22 21:15:30.159097+00'),\n\t(820, 144, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.160437+00'),\n\t(821, 145, 23, NULL, NULL, 'strong', '2026-03-22 21:15:30.161989+00'),\n\t(822, 146, 23, NULL, NULL, NULL, '2026-03-22 21:15:30.163356+00'),\n\t(823, 93, 23, NULL, NULL, 'mild', '2026-03-22 21:15:30.164643+00'),\n\t(824, 94, 23, 14, 'All sedative remedies will help ease muscular tension and pain in this complex system', 'mild', '2026-03-22 21:15:30.165906+00'),\n\t(825, 44, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.167254+00'),\n\t(826, 44, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.168808+00'),\n\t(827, 44, 24, 12, 'Relevant stimulants with diuretic properties include this', NULL, '2026-03-22 21:15:30.170051+00'),\n\t(828, 21, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.171174+00'),\n\t(829, 21, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.172381+00'),\n\t(830, 65, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.173526+00'),\n\t(831, 113, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.174597+00'),\n\t(832, 113, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.175848+00'),\n\t(833, 113, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.177037+00'),\n\t(834, 96, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.178228+00'),\n\t(835, 97, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.179483+00'),\n\t(836, 97, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.180697+00'),\n\t(837, 97, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.182479+00'),\n\t(838, 115, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.183776+00'),\n\t(839, 116, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.18502+00'),\n\t(840, 116, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.186239+00'),\n\t(841, 116, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.187441+00'),\n\t(842, 47, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.188666+00'),\n\t(843, 98, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.189869+00'),\n\t(844, 192, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.190985+00'),\n\t(845, 170, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.192159+00'),\n\t(846, 150, 24, 15, NULL, NULL, '2026-03-22 21:15:30.193349+00'),\n\t(847, 127, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.194469+00'),\n\t(848, 50, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.195778+00'),\n\t(849, 117, 24, 12, 'Relevant stimulants with diuretic properties include this', NULL, '2026-03-22 21:15:30.197116+00'),\n\t(850, 76, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.19833+00'),\n\t(851, 118, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.199892+00'),\n\t(852, 102, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.201324+00'),\n\t(853, 54, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.202743+00'),\n\t(854, 103, 24, 12, 'Relevant stimulants with diuretic properties include this', NULL, '2026-03-22 21:15:30.204121+00'),\n\t(855, 160, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.205461+00'),\n\t(856, 187, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.206678+00'),\n\t(857, 55, 24, 10, 'The diaphoretic chest remedies can be considered stimulant in action', NULL, '2026-03-22 21:15:30.207896+00'),\n\t(858, 55, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.209142+00'),\n\t(859, 119, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.210241+00'),\n\t(860, 119, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.211332+00'),\n\t(861, 215, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.212641+00'),\n\t(862, 195, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.213898+00'),\n\t(863, 204, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.215146+00'),\n\t(864, 205, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.216373+00'),\n\t(865, 109, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.217618+00'),\n\t(866, 109, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.218857+00'),\n\t(867, 109, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.220065+00'),\n\t(868, 110, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.221555+00'),\n\t(869, 110, 24, 11, 'As already discussed, bitters may be considered stimulants', NULL, '2026-03-22 21:15:30.222881+00'),\n\t(870, 110, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.224683+00'),\n\t(871, 38, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.225975+00'),\n\t(872, 216, 24, NULL, NULL, NULL, '2026-03-22 21:15:30.2274+00'),\n\t(873, 161, 24, 13, 'Stimulants for this system usually act as emmenagogues, and so should not be used during pregnancy. Important examples include this.', NULL, '2026-03-22 21:15:30.228678+00'),\n\t(874, 123, 24, 9, 'Stimulant actions must be used with care in people with cardiovascular problems, but if applied with knowledge, appropriate stimulation can often aid and support an ailing heart', NULL, '2026-03-22 21:15:30.230056+00'),\n\t(875, 124, 24, 14, 'a stimulant of peripheral circulation. In general, rubefacient remedies are stimulants.', NULL, '2026-03-22 21:15:30.23125+00'),\n\t(876, 217, 24, 15, NULL, NULL, '2026-03-22 21:15:30.232484+00'),\n\t(877, 149, 24, 15, NULL, NULL, '2026-03-22 21:15:30.233726+00'),\n\t(879, 218, 24, 15, NULL, NULL, '2026-03-22 21:15:30.236356+00')","--\n-- Data for Name: secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"secondary_actions\\" (\\"id\\", \\"name\\", \\"created_at\\") VALUES\n\t(35, 'Anticatarrhal', '2026-03-22 21:15:28.855694+00'),\n\t(36, 'Anti-inflammatory', '2026-03-22 21:15:28.855694+00'),\n\t(37, 'Antimicrobial', '2026-03-22 21:15:28.855694+00'),\n\t(38, 'Antispasmodic', '2026-03-22 21:15:28.855694+00'),\n\t(39, 'Astringent', '2026-03-22 21:15:28.855694+00'),\n\t(40, 'Bitter', '2026-03-22 21:15:28.855694+00'),\n\t(41, 'Diaphoretic', '2026-03-22 21:15:28.855694+00'),\n\t(42, 'Diuretic', '2026-03-22 21:15:28.855694+00'),\n\t(43, 'Emmenagogue', '2026-03-22 21:15:28.855694+00'),\n\t(44, 'Expectorant', '2026-03-22 21:15:28.855694+00'),\n\t(45, 'Hepatic', '2026-03-22 21:15:28.855694+00'),\n\t(46, 'Hypotensive', '2026-03-22 21:15:28.855694+00'),\n\t(47, 'Nervine', '2026-03-22 21:15:28.855694+00'),\n\t(48, 'Vulnerary', '2026-03-22 21:15:28.855694+00'),\n\t(49, 'Alterative', '2026-03-22 21:15:28.855694+00'),\n\t(50, 'Carminative', '2026-03-22 21:15:28.855694+00'),\n\t(51, 'Demulcent', '2026-03-22 21:15:28.855694+00'),\n\t(52, 'Laxative', '2026-03-22 21:15:28.855694+00'),\n\t(53, 'Tonic', '2026-03-22 21:15:28.855694+00'),\n\t(54, 'Cholagogue', '2026-03-22 21:15:28.855694+00'),\n\t(55, 'Circulatory stimulant', '2026-03-22 21:15:28.855694+00'),\n\t(56, 'Other action (or basis unclear)', '2026-03-22 21:15:28.855694+00'),\n\t(57, 'Analgesic', '2026-03-22 21:15:28.855694+00'),\n\t(58, 'Hypnotic', '2026-03-22 21:15:28.855694+00'),\n\t(59, 'Nervine relaxant', '2026-03-22 21:15:28.855694+00'),\n\t(60, 'Galactagogue', '2026-03-22 21:15:28.855694+00'),\n\t(61, 'Rubefacient', '2026-03-22 21:15:28.855694+00'),\n\t(62, 'Cardioactive', '2026-03-22 21:15:28.855694+00'),\n\t(63, 'Moderate', '2026-03-22 21:15:28.855694+00'),\n\t(64, 'Adaptogen', '2026-03-22 21:15:28.855694+00'),\n\t(65, 'Cardiotonic', '2026-03-22 21:15:28.855694+00')","--\n-- Data for Name: herb_secondary_actions; Type: TABLE DATA; Schema: herbal; Owner: postgres\n--\n\nINSERT INTO \\"herbal\\".\\"herb_secondary_actions\\" (\\"id\\", \\"herb_id\\", \\"secondary_action_id\\", \\"created_at\\") VALUES\n\t(12, 21, 35, '2026-03-22 21:15:30.237944+00'),\n\t(13, 23, 35, '2026-03-22 21:15:30.239783+00'),\n\t(14, 26, 35, '2026-03-22 21:15:30.241087+00'),\n\t(15, 30, 35, '2026-03-22 21:15:30.242335+00'),\n\t(16, 35, 35, '2026-03-22 21:15:30.243679+00'),\n\t(17, 43, 35, '2026-03-22 21:15:30.245109+00'),\n\t(18, 28, 36, '2026-03-22 21:15:30.246545+00'),\n\t(19, 29, 36, '2026-03-22 21:15:30.247823+00'),\n\t(20, 30, 36, '2026-03-22 21:15:30.249152+00'),\n\t(21, 31, 36, '2026-03-22 21:15:30.250341+00'),\n\t(22, 34, 36, '2026-03-22 21:15:30.251477+00'),\n\t(23, 40, 36, '2026-03-22 21:15:30.252606+00'),\n\t(24, 21, 37, '2026-03-22 21:15:30.253966+00'),\n\t(25, 23, 37, '2026-03-22 21:15:30.255441+00'),\n\t(26, 26, 37, '2026-03-22 21:15:30.256656+00'),\n\t(27, 30, 37, '2026-03-22 21:15:30.257857+00'),\n\t(28, 32, 37, '2026-03-22 21:15:30.259036+00'),\n\t(29, 35, 37, '2026-03-22 21:15:30.260281+00'),\n\t(30, 36, 37, '2026-03-22 21:15:30.261616+00'),\n\t(31, 38, 37, '2026-03-22 21:15:30.262876+00'),\n\t(32, 21, 38, '2026-03-22 21:15:30.264071+00'),\n\t(33, 25, 38, '2026-03-22 21:15:30.265339+00'),\n\t(34, 36, 38, '2026-03-22 21:15:30.266543+00'),\n\t(35, 38, 38, '2026-03-22 21:15:30.267865+00'),\n\t(36, 42, 38, '2026-03-22 21:15:30.268975+00'),\n\t(37, 30, 39, '2026-03-22 21:15:30.270233+00'),\n\t(38, 43, 39, '2026-03-22 21:15:30.271331+00'),\n\t(39, 22, 40, '2026-03-22 21:15:30.272573+00'),\n\t(40, 30, 40, '2026-03-22 21:15:30.273903+00'),\n\t(41, 34, 40, '2026-03-22 21:15:30.275155+00'),\n\t(42, 21, 41, '2026-03-22 21:15:30.276674+00'),\n\t(43, 29, 41, '2026-03-22 21:15:30.277981+00'),\n\t(44, 41, 41, '2026-03-22 21:15:30.279228+00'),\n\t(45, 40, 41, '2026-03-22 21:15:30.280505+00'),\n\t(46, 22, 42, '2026-03-22 21:15:30.281979+00'),\n\t(47, 28, 42, '2026-03-22 21:15:30.283447+00'),\n\t(48, 29, 42, '2026-03-22 21:15:30.284864+00'),\n\t(49, 31, 42, '2026-03-22 21:15:30.286261+00'),\n\t(50, 34, 42, '2026-03-22 21:15:30.287426+00'),\n\t(51, 40, 42, '2026-03-22 21:15:30.288578+00'),\n\t(52, 43, 42, '2026-03-22 21:15:30.289814+00'),\n\t(53, 25, 43, '2026-03-22 21:15:30.291071+00'),\n\t(54, 38, 44, '2026-03-22 21:15:30.292474+00'),\n\t(55, 42, 44, '2026-03-22 21:15:30.293746+00'),\n\t(56, 21, 45, '2026-03-22 21:15:30.29487+00'),\n\t(57, 22, 45, '2026-03-22 21:15:30.296069+00'),\n\t(58, 24, 45, '2026-03-22 21:15:30.297507+00'),\n\t(59, 30, 45, '2026-03-22 21:15:30.298693+00'),\n\t(60, 31, 45, '2026-03-22 21:15:30.299885+00'),\n\t(61, 33, 45, '2026-03-22 21:15:30.301094+00'),\n\t(62, 34, 45, '2026-03-22 21:15:30.302268+00'),\n\t(63, 35, 45, '2026-03-22 21:15:30.303601+00'),\n\t(64, 37, 45, '2026-03-22 21:15:30.304977+00'),\n\t(65, 21, 46, '2026-03-22 21:15:30.306271+00'),\n\t(66, 25, 46, '2026-03-22 21:15:30.307596+00'),\n\t(67, 43, 46, '2026-03-22 21:15:30.308841+00'),\n\t(68, 25, 47, '2026-03-22 21:15:30.309991+00'),\n\t(69, 36, 47, '2026-03-22 21:15:30.31114+00'),\n\t(70, 42, 47, '2026-03-22 21:15:30.312387+00'),\n\t(71, 28, 48, '2026-03-22 21:15:30.313665+00'),\n\t(72, 30, 48, '2026-03-22 21:15:30.314881+00'),\n\t(73, 21, 49, '2026-03-22 21:15:30.316148+00'),\n\t(74, 23, 49, '2026-03-22 21:15:30.317438+00'),\n\t(75, 26, 49, '2026-03-22 21:15:30.318736+00'),\n\t(76, 30, 49, '2026-03-22 21:15:30.32006+00'),\n\t(77, 61, 49, '2026-03-22 21:15:30.321249+00'),\n\t(78, 51, 36, '2026-03-22 21:15:30.322477+00'),\n\t(79, 52, 36, '2026-03-22 21:15:30.323628+00'),\n\t(81, 58, 36, '2026-03-22 21:15:30.326085+00'),\n\t(82, 44, 37, '2026-03-22 21:15:30.327256+00'),\n\t(84, 46, 37, '2026-03-22 21:15:30.329647+00'),\n\t(86, 47, 37, '2026-03-22 21:15:30.336261+00'),\n\t(88, 54, 37, '2026-03-22 21:15:30.338998+00'),\n\t(89, 55, 37, '2026-03-22 21:15:30.340425+00'),\n\t(90, 56, 37, '2026-03-22 21:15:30.341903+00'),\n\t(91, 58, 37, '2026-03-22 21:15:30.34327+00'),\n\t(92, 59, 37, '2026-03-22 21:15:30.344646+00'),\n\t(94, 50, 38, '2026-03-22 21:15:30.347583+00'),\n\t(95, 53, 38, '2026-03-22 21:15:30.349038+00'),\n\t(96, 55, 38, '2026-03-22 21:15:30.350367+00'),\n\t(97, 56, 38, '2026-03-22 21:15:30.351595+00'),\n\t(98, 59, 38, '2026-03-22 21:15:30.352755+00'),\n\t(99, 44, 39, '2026-03-22 21:15:30.353867+00'),\n\t(100, 46, 39, '2026-03-22 21:15:30.355062+00'),\n\t(101, 51, 39, '2026-03-22 21:15:30.356186+00'),\n\t(102, 52, 39, '2026-03-22 21:15:30.357365+00'),\n\t(104, 56, 39, '2026-03-22 21:15:30.359693+00'),\n\t(105, 59, 39, '2026-03-22 21:15:30.360898+00'),\n\t(106, 44, 40, '2026-03-22 21:15:30.362202+00'),\n\t(107, 50, 40, '2026-03-22 21:15:30.363407+00'),\n\t(109, 47, 50, '2026-03-22 21:15:30.365869+00'),\n\t(110, 53, 50, '2026-03-22 21:15:30.367054+00'),\n\t(111, 55, 50, '2026-03-22 21:15:30.368351+00'),\n\t(112, 56, 50, '2026-03-22 21:15:30.369606+00'),\n\t(113, 58, 50, '2026-03-22 21:15:30.370649+00'),\n\t(114, 59, 50, '2026-03-22 21:15:30.371708+00'),\n\t(115, 45, 51, '2026-03-22 21:15:30.372864+00'),\n\t(116, 46, 51, '2026-03-22 21:15:30.37401+00'),\n\t(117, 48, 51, '2026-03-22 21:15:30.375243+00'),\n\t(118, 49, 51, '2026-03-22 21:15:30.376478+00'),\n\t(119, 60, 51, '2026-03-22 21:15:30.377825+00'),\n\t(120, 61, 51, '2026-03-22 21:15:30.379042+00'),\n\t(121, 44, 41, '2026-03-22 21:15:30.38025+00'),\n\t(123, 50, 41, '2026-03-22 21:15:30.382751+00'),\n\t(124, 53, 41, '2026-03-22 21:15:30.384028+00'),\n\t(125, 54, 41, '2026-03-22 21:15:30.385221+00'),\n\t(126, 55, 41, '2026-03-22 21:15:30.386333+00'),\n\t(127, 57, 41, '2026-03-22 21:15:30.387578+00'),\n\t(128, 58, 41, '2026-03-22 21:15:30.389274+00'),\n\t(129, 44, 42, '2026-03-22 21:15:30.390477+00'),\n\t(130, 45, 42, '2026-03-22 21:15:30.392691+00'),\n\t(131, 46, 42, '2026-03-22 21:15:30.393847+00'),\n\t(132, 57, 42, '2026-03-22 21:15:30.395043+00'),\n\t(133, 58, 42, '2026-03-22 21:15:30.396527+00'),\n\t(134, 60, 42, '2026-03-22 21:15:30.397759+00'),\n\t(135, 61, 42, '2026-03-22 21:15:30.398968+00'),\n\t(136, 44, 43, '2026-03-22 21:15:30.400194+00'),\n\t(137, 50, 43, '2026-03-22 21:15:30.401305+00'),\n\t(138, 56, 43, '2026-03-22 21:15:30.402581+00'),\n\t(139, 59, 43, '2026-03-22 21:15:30.403801+00'),\n\t(140, 45, 44, '2026-03-22 21:15:30.405023+00'),\n\t(141, 48, 44, '2026-03-22 21:15:30.406196+00'),\n\t(142, 49, 44, '2026-03-22 21:15:30.407374+00'),\n\t(143, 53, 44, '2026-03-22 21:15:30.408586+00'),\n\t(144, 57, 44, '2026-03-22 21:15:30.410006+00'),\n\t(145, 59, 44, '2026-03-22 21:15:30.41106+00'),\n\t(146, 60, 44, '2026-03-22 21:15:30.412247+00'),\n\t(147, 61, 44, '2026-03-22 21:15:30.413401+00'),\n\t(149, 50, 45, '2026-03-22 21:15:30.41607+00'),\n\t(151, 44, 46, '2026-03-22 21:15:30.418542+00'),\n\t(153, 50, 52, '2026-03-22 21:15:30.420916+00'),\n\t(154, 30, 52, '2026-03-22 21:15:30.422236+00'),\n\t(155, 57, 52, '2026-03-22 21:15:30.42353+00'),\n\t(156, 53, 47, '2026-03-22 21:15:30.42469+00'),\n\t(157, 44, 53, '2026-03-22 21:15:30.425897+00'),\n\t(158, 47, 53, '2026-03-22 21:15:30.427072+00'),\n\t(159, 26, 53, '2026-03-22 21:15:30.428213+00'),\n\t(160, 50, 53, '2026-03-22 21:15:30.429424+00'),\n\t(161, 30, 53, '2026-03-22 21:15:30.43051+00'),\n\t(162, 45, 48, '2026-03-22 21:15:30.431649+00'),\n\t(163, 52, 48, '2026-03-22 21:15:30.433289+00'),\n\t(164, 57, 48, '2026-03-22 21:15:30.434667+00'),\n\t(165, 61, 48, '2026-03-22 21:15:30.435897+00'),\n\t(166, 44, 35, '2026-03-22 21:15:30.437163+00'),\n\t(167, 45, 35, '2026-03-22 21:15:30.4385+00'),\n\t(168, 48, 35, '2026-03-22 21:15:30.439871+00'),\n\t(169, 49, 35, '2026-03-22 21:15:30.441725+00'),\n\t(170, 52, 35, '2026-03-22 21:15:30.443197+00'),\n\t(172, 53, 35, '2026-03-22 21:15:30.445851+00'),\n\t(173, 55, 35, '2026-03-22 21:15:30.447607+00'),\n\t(174, 56, 35, '2026-03-22 21:15:30.449194+00'),\n\t(175, 57, 35, '2026-03-22 21:15:30.450553+00'),\n\t(176, 58, 35, '2026-03-22 21:15:30.453817+00'),\n\t(177, 60, 35, '2026-03-22 21:15:30.455799+00'),\n\t(178, 61, 35, '2026-03-22 21:15:30.459814+00'),\n\t(180, 70, 37, '2026-03-22 21:15:30.463779+00'),\n\t(182, 81, 37, '2026-03-22 21:15:30.467779+00'),\n\t(183, 84, 37, '2026-03-22 21:15:30.469051+00'),\n\t(185, 86, 37, '2026-03-22 21:15:30.472945+00'),\n\t(188, 64, 38, '2026-03-22 21:15:30.480205+00'),\n\t(189, 65, 38, '2026-03-22 21:15:30.483209+00'),\n\t(190, 66, 38, '2026-03-22 21:15:30.48601+00'),\n\t(191, 67, 38, '2026-03-22 21:15:30.488111+00'),\n\t(193, 74, 38, '2026-03-22 21:15:30.493284+00'),\n\t(194, 76, 38, '2026-03-22 21:15:30.495899+00'),\n\t(195, 78, 38, '2026-03-22 21:15:30.498448+00'),\n\t(196, 81, 38, '2026-03-22 21:15:30.501339+00'),\n\t(198, 82, 38, '2026-03-22 21:15:30.507946+00'),\n\t(199, 84, 38, '2026-03-22 21:15:30.510536+00'),\n\t(201, 86, 38, '2026-03-22 21:15:30.515522+00'),\n\t(203, 57, 38, '2026-03-22 21:15:30.519484+00'),\n\t(204, 90, 38, '2026-03-22 21:15:30.523454+00'),\n\t(205, 91, 38, '2026-03-22 21:15:30.526704+00'),\n\t(206, 61, 38, '2026-03-22 21:15:30.529668+00'),\n\t(207, 93, 38, '2026-03-22 21:15:30.532339+00'),\n\t(208, 94, 38, '2026-03-22 21:15:30.535068+00'),\n\t(210, 62, 39, '2026-03-22 21:15:30.53924+00'),\n\t(211, 63, 39, '2026-03-22 21:15:30.543064+00'),\n\t(212, 70, 39, '2026-03-22 21:15:30.546599+00'),\n\t(213, 71, 39, '2026-03-22 21:15:30.549406+00'),\n\t(214, 75, 39, '2026-03-22 21:15:30.551811+00'),\n\t(216, 79, 39, '2026-03-22 21:15:30.557233+00'),\n\t(218, 85, 39, '2026-03-22 21:15:30.561719+00'),\n\t(219, 86, 39, '2026-03-22 21:15:30.563714+00'),\n\t(221, 58, 39, '2026-03-22 21:15:30.569054+00'),\n\t(222, 89, 39, '2026-03-22 21:15:30.571996+00'),\n\t(223, 90, 39, '2026-03-22 21:15:30.574221+00'),\n\t(224, 61, 39, '2026-03-22 21:15:30.576359+00'),\n\t(227, 84, 40, '2026-03-22 21:15:30.582073+00'),\n\t(228, 44, 50, '2026-03-22 21:15:30.585308+00'),\n\t(229, 64, 50, '2026-03-22 21:15:30.588283+00'),\n\t(230, 65, 50, '2026-03-22 21:15:30.591277+00'),\n\t(231, 66, 50, '2026-03-22 21:15:30.594573+00'),\n\t(232, 75, 50, '2026-03-22 21:15:30.59828+00'),\n\t(233, 76, 50, '2026-03-22 21:15:30.600942+00'),\n\t(234, 78, 50, '2026-03-22 21:15:30.604285+00'),\n\t(236, 82, 50, '2026-03-22 21:15:30.607245+00'),\n\t(237, 84, 50, '2026-03-22 21:15:30.608863+00'),\n\t(241, 90, 50, '2026-03-22 21:15:30.613455+00'),\n\t(242, 91, 50, '2026-03-22 21:15:30.615929+00'),\n\t(243, 70, 54, '2026-03-22 21:15:30.617811+00'),\n\t(244, 74, 54, '2026-03-22 21:15:30.623887+00'),\n\t(245, 30, 54, '2026-03-22 21:15:30.625723+00'),\n\t(246, 34, 54, '2026-03-22 21:15:30.627563+00'),\n\t(250, 78, 51, '2026-03-22 21:15:30.633807+00'),\n\t(251, 83, 51, '2026-03-22 21:15:30.635412+00'),\n\t(252, 88, 51, '2026-03-22 21:15:30.636762+00'),\n\t(253, 89, 51, '2026-03-22 21:15:30.638188+00'),\n\t(254, 91, 51, '2026-03-22 21:15:30.639521+00'),\n\t(255, 92, 51, '2026-03-22 21:15:30.64092+00'),\n\t(257, 95, 51, '2026-03-22 21:15:30.643788+00'),\n\t(259, 65, 41, '2026-03-22 21:15:30.646412+00'),\n\t(260, 67, 41, '2026-03-22 21:15:30.64784+00'),\n\t(266, 90, 41, '2026-03-22 21:15:30.655096+00'),\n\t(268, 63, 42, '2026-03-22 21:15:30.657314+00'),\n\t(269, 66, 42, '2026-03-22 21:15:30.658758+00'),\n\t(270, 73, 42, '2026-03-22 21:15:30.660058+00'),\n\t(273, 85, 42, '2026-03-22 21:15:30.663729+00'),\n\t(276, 90, 42, '2026-03-22 21:15:30.667337+00'),\n\t(277, 95, 42, '2026-03-22 21:15:30.668615+00'),\n\t(279, 63, 43, '2026-03-22 21:15:30.671173+00'),\n\t(280, 70, 43, '2026-03-22 21:15:30.67252+00'),\n\t(281, 72, 43, '2026-03-22 21:15:30.674367+00'),\n\t(283, 30, 43, '2026-03-22 21:15:30.677548+00'),\n\t(284, 53, 43, '2026-03-22 21:15:30.679779+00'),\n\t(285, 82, 43, '2026-03-22 21:15:30.683888+00'),\n\t(287, 90, 43, '2026-03-22 21:15:30.687145+00'),\n\t(288, 93, 43, '2026-03-22 21:15:30.688708+00'),\n\t(289, 94, 43, '2026-03-22 21:15:30.690127+00'),\n\t(291, 67, 44, '2026-03-22 21:15:30.692886+00'),\n\t(294, 78, 44, '2026-03-22 21:15:30.696919+00'),\n\t(295, 30, 44, '2026-03-22 21:15:30.698441+00'),\n\t(297, 83, 44, '2026-03-22 21:15:30.700884+00'),\n\t(298, 85, 44, '2026-03-22 21:15:30.702103+00'),\n\t(302, 44, 45, '2026-03-22 21:15:30.706738+00'),\n\t(303, 70, 45, '2026-03-22 21:15:30.707938+00'),\n\t(304, 74, 45, '2026-03-22 21:15:30.709169+00'),\n\t(305, 76, 45, '2026-03-22 21:15:30.710436+00'),\n\t(306, 78, 45, '2026-03-22 21:15:30.711624+00'),\n\t(308, 53, 45, '2026-03-22 21:15:30.713957+00'),\n\t(310, 91, 45, '2026-03-22 21:15:30.716727+00'),\n\t(312, 78, 52, '2026-03-22 21:15:30.719139+00'),\n\t(313, 66, 47, '2026-03-22 21:15:30.720415+00'),\n\t(314, 69, 47, '2026-03-22 21:15:30.721604+00'),\n\t(316, 81, 47, '2026-03-22 21:15:30.723781+00'),\n\t(318, 82, 47, '2026-03-22 21:15:30.726202+00'),\n\t(319, 84, 47, '2026-03-22 21:15:30.72749+00'),\n\t(320, 55, 47, '2026-03-22 21:15:30.72871+00'),\n\t(321, 90, 47, '2026-03-22 21:15:30.729928+00'),\n\t(322, 94, 47, '2026-03-22 21:15:30.731009+00'),\n\t(324, 25, 53, '2026-03-22 21:15:30.73317+00'),\n\t(325, 73, 53, '2026-03-22 21:15:30.734457+00'),\n\t(326, 75, 53, '2026-03-22 21:15:30.735696+00'),\n\t(328, 81, 53, '2026-03-22 21:15:30.738142+00'),\n\t(329, 61, 53, '2026-03-22 21:15:30.739427+00'),\n\t(330, 44, 48, '2026-03-22 21:15:30.740551+00'),\n\t(331, 63, 48, '2026-03-22 21:15:30.741724+00'),\n\t(333, 70, 48, '2026-03-22 21:15:30.744524+00'),\n\t(334, 75, 48, '2026-03-22 21:15:30.745808+00'),\n\t(335, 79, 48, '2026-03-22 21:15:30.747427+00'),\n\t(336, 81, 48, '2026-03-22 21:15:30.748811+00'),\n\t(337, 53, 48, '2026-03-22 21:15:30.750073+00'),\n\t(338, 83, 48, '2026-03-22 21:15:30.75115+00'),\n\t(339, 84, 48, '2026-03-22 21:15:30.752305+00'),\n\t(340, 85, 48, '2026-03-22 21:15:30.753473+00'),\n\t(341, 88, 48, '2026-03-22 21:15:30.754622+00'),\n\t(342, 89, 48, '2026-03-22 21:15:30.75593+00'),\n\t(347, 54, 49, '2026-03-22 21:15:30.797326+00'),\n\t(349, 46, 35, '2026-03-22 21:15:30.804001+00'),\n\t(351, 47, 35, '2026-03-22 21:15:30.807008+00'),\n\t(353, 101, 35, '2026-03-22 21:15:30.809682+00'),\n\t(355, 54, 35, '2026-03-22 21:15:30.81234+00'),\n\t(357, 105, 35, '2026-03-22 21:15:30.816606+00'),\n\t(359, 59, 35, '2026-03-22 21:15:30.820482+00'),\n\t(360, 97, 36, '2026-03-22 21:15:30.821953+00'),\n\t(361, 70, 36, '2026-03-22 21:15:30.823367+00'),\n\t(362, 81, 36, '2026-03-22 21:15:30.824592+00'),\n\t(363, 55, 36, '2026-03-22 21:15:30.825843+00'),\n\t(364, 85, 36, '2026-03-22 21:15:30.827119+00'),\n\t(366, 98, 38, '2026-03-22 21:15:30.868063+00'),\n\t(369, 108, 38, '2026-03-22 21:15:30.871739+00'),\n\t(370, 109, 38, '2026-03-22 21:15:30.872948+00'),\n\t(371, 110, 38, '2026-03-22 21:15:30.874124+00'),\n\t(376, 98, 39, '2026-03-22 21:15:30.879492+00'),\n\t(377, 99, 39, '2026-03-22 21:15:30.880661+00'),\n\t(379, 109, 39, '2026-03-22 21:15:30.883573+00'),\n\t(383, 96, 40, '2026-03-22 21:15:30.887899+00'),\n\t(384, 97, 40, '2026-03-22 21:15:30.889128+00'),\n\t(385, 102, 40, '2026-03-22 21:15:30.890265+00'),\n\t(387, 110, 40, '2026-03-22 21:15:30.892562+00'),\n\t(388, 97, 50, '2026-03-22 21:15:30.893812+00'),\n\t(390, 98, 50, '2026-03-22 21:15:30.895965+00'),\n\t(391, 99, 50, '2026-03-22 21:15:30.897054+00'),\n\t(392, 100, 50, '2026-03-22 21:15:30.898208+00'),\n\t(393, 103, 50, '2026-03-22 21:15:30.899303+00'),\n\t(395, 108, 50, '2026-03-22 21:15:30.901531+00'),\n\t(396, 109, 50, '2026-03-22 21:15:30.902773+00'),\n\t(398, 111, 50, '2026-03-22 21:15:30.904768+00'),\n\t(401, 85, 51, '2026-03-22 21:15:30.907825+00'),\n\t(404, 23, 41, '2026-03-22 21:15:30.911045+00'),\n\t(405, 47, 41, '2026-03-22 21:15:30.912277+00'),\n\t(408, 107, 41, '2026-03-22 21:15:30.915843+00'),\n\t(411, 101, 42, '2026-03-22 21:15:30.920073+00'),\n\t(412, 103, 42, '2026-03-22 21:15:30.921193+00'),\n\t(415, 96, 43, '2026-03-22 21:15:30.924876+00'),\n\t(416, 97, 43, '2026-03-22 21:15:30.925983+00'),\n\t(418, 98, 43, '2026-03-22 21:15:30.928222+00'),\n\t(419, 102, 43, '2026-03-22 21:15:30.929333+00'),\n\t(421, 107, 43, '2026-03-22 21:15:30.93142+00'),\n\t(422, 109, 43, '2026-03-22 21:15:30.932547+00'),\n\t(423, 110, 43, '2026-03-22 21:15:30.933599+00'),\n\t(425, 98, 44, '2026-03-22 21:15:30.935611+00'),\n\t(426, 99, 44, '2026-03-22 21:15:30.936672+00'),\n\t(427, 101, 44, '2026-03-22 21:15:30.937858+00'),\n\t(428, 54, 44, '2026-03-22 21:15:30.93887+00'),\n\t(429, 104, 44, '2026-03-22 21:15:30.939995+00'),\n\t(430, 105, 44, '2026-03-22 21:15:30.941213+00'),\n\t(431, 107, 44, '2026-03-22 21:15:30.942429+00'),\n\t(432, 108, 44, '2026-03-22 21:15:30.943483+00'),\n\t(434, 110, 44, '2026-03-22 21:15:30.945902+00'),\n\t(437, 96, 45, '2026-03-22 21:15:30.949262+00'),\n\t(439, 102, 45, '2026-03-22 21:15:30.952129+00'),\n\t(441, 54, 45, '2026-03-22 21:15:30.954497+00'),\n\t(442, 110, 45, '2026-03-22 21:15:30.956151+00'),\n\t(445, 106, 46, '2026-03-22 21:15:30.961987+00'),\n\t(446, 44, 52, '2026-03-22 21:15:30.963666+00'),\n\t(447, 96, 52, '2026-03-22 21:15:30.964961+00'),\n\t(448, 97, 52, '2026-03-22 21:15:30.966263+00'),\n\t(449, 102, 52, '2026-03-22 21:15:30.968635+00'),\n\t(451, 110, 52, '2026-03-22 21:15:30.974037+00'),\n\t(454, 109, 47, '2026-03-22 21:15:30.980245+00'),\n\t(456, 21, 53, '2026-03-22 21:15:30.983629+00'),\n\t(457, 97, 53, '2026-03-22 21:15:30.985263+00'),\n\t(458, 70, 53, '2026-03-22 21:15:30.986806+00'),\n\t(461, 102, 53, '2026-03-22 21:15:30.992783+00'),\n\t(464, 54, 53, '2026-03-22 21:15:30.999164+00'),\n\t(465, 110, 53, '2026-03-22 21:15:31.001097+00'),\n\t(468, 99, 48, '2026-03-22 21:15:31.008312+00'),\n\t(472, 65, 36, '2026-03-22 21:15:31.016509+00'),\n\t(473, 66, 36, '2026-03-22 21:15:31.01865+00'),\n\t(474, 68, 36, '2026-03-22 21:15:31.021582+00'),\n\t(475, 74, 36, '2026-03-22 21:15:31.025442+00'),\n\t(476, 75, 36, '2026-03-22 21:15:31.028164+00'),\n\t(477, 77, 36, '2026-03-22 21:15:31.03+00'),\n\t(479, 80, 36, '2026-03-22 21:15:31.033043+00'),\n\t(481, 86, 36, '2026-03-22 21:15:31.036149+00'),\n\t(482, 121, 36, '2026-03-22 21:15:31.037646+00'),\n\t(483, 22, 49, '2026-03-22 21:15:31.039142+00'),\n\t(484, 33, 49, '2026-03-22 21:15:31.045656+00'),\n\t(485, 118, 49, '2026-03-22 21:15:31.047665+00'),\n\t(486, 29, 49, '2026-03-22 21:15:31.049422+00'),\n\t(487, 80, 49, '2026-03-22 21:15:31.050783+00'),\n\t(488, 31, 49, '2026-03-22 21:15:31.052126+00'),\n\t(489, 34, 49, '2026-03-22 21:15:31.053438+00'),\n\t(490, 35, 49, '2026-03-22 21:15:31.054909+00'),\n\t(491, 37, 49, '2026-03-22 21:15:31.056559+00'),\n\t(492, 40, 49, '2026-03-22 21:15:31.057926+00'),\n\t(493, 43, 49, '2026-03-22 21:15:31.059193+00'),\n\t(497, 50, 42, '2026-03-22 21:15:31.064107+00'),\n\t(498, 117, 42, '2026-03-22 21:15:31.065548+00'),\n\t(500, 120, 42, '2026-03-22 21:15:31.068072+00'),\n\t(501, 122, 42, '2026-03-22 21:15:31.069457+00'),\n\t(502, 113, 55, '2026-03-22 21:15:31.070525+00'),\n\t(503, 116, 55, '2026-03-22 21:15:31.071541+00'),\n\t(504, 47, 55, '2026-03-22 21:15:31.072627+00'),\n\t(505, 119, 55, '2026-03-22 21:15:31.073707+00'),\n\t(506, 109, 55, '2026-03-22 21:15:31.074936+00'),\n\t(507, 123, 55, '2026-03-22 21:15:31.076209+00'),\n\t(508, 124, 55, '2026-03-22 21:15:31.077451+00'),\n\t(511, 114, 56, '2026-03-22 21:15:31.081355+00'),\n\t(512, 97, 56, '2026-03-22 21:15:31.082804+00'),\n\t(513, 115, 56, '2026-03-22 21:15:31.084064+00'),\n\t(514, 72, 56, '2026-03-22 21:15:31.085288+00'),\n\t(515, 25, 49, '2026-03-22 21:15:31.086496+00'),\n\t(516, 42, 49, '2026-03-22 21:15:31.087716+00'),\n\t(517, 25, 57, '2026-03-22 21:15:31.088957+00'),\n\t(518, 74, 57, '2026-03-22 21:15:31.090087+00'),\n\t(519, 128, 57, '2026-03-22 21:15:31.091142+00'),\n\t(520, 81, 57, '2026-03-22 21:15:31.092199+00'),\n\t(521, 130, 57, '2026-03-22 21:15:31.093245+00'),\n\t(522, 55, 57, '2026-03-22 21:15:31.094471+00'),\n\t(523, 137, 57, '2026-03-22 21:15:31.095692+00'),\n\t(524, 139, 57, '2026-03-22 21:15:31.097209+00'),\n\t(525, 145, 57, '2026-03-22 21:15:31.098432+00'),\n\t(527, 82, 35, '2026-03-22 21:15:31.100674+00'),\n\t(528, 84, 35, '2026-03-22 21:15:31.101977+00'),\n\t(530, 136, 35, '2026-03-22 21:15:31.104641+00'),\n\t(533, 90, 35, '2026-03-22 21:15:31.107743+00'),\n\t(534, 91, 35, '2026-03-22 21:15:31.108839+00'),\n\t(537, 124, 35, '2026-03-22 21:15:31.111992+00'),\n\t(541, 78, 36, '2026-03-22 21:15:31.117275+00'),\n\t(543, 53, 36, '2026-03-22 21:15:31.121031+00'),\n\t(544, 82, 36, '2026-03-22 21:15:31.122839+00'),\n\t(545, 84, 36, '2026-03-22 21:15:31.124367+00'),\n\t(546, 134, 36, '2026-03-22 21:15:31.125749+00'),\n\t(548, 57, 36, '2026-03-22 21:15:31.128362+00'),\n\t(549, 90, 36, '2026-03-22 21:15:31.129803+00'),\n\t(550, 60, 36, '2026-03-22 21:15:31.131395+00'),\n\t(551, 98, 37, '2026-03-22 21:15:31.133022+00'),\n\t(552, 126, 37, '2026-03-22 21:15:31.134818+00'),\n\t(553, 129, 37, '2026-03-22 21:15:31.136333+00'),\n\t(555, 82, 37, '2026-03-22 21:15:31.138795+00'),\n\t(558, 108, 37, '2026-03-22 21:15:31.143244+00'),\n\t(559, 138, 37, '2026-03-22 21:15:31.144719+00'),\n\t(560, 109, 37, '2026-03-22 21:15:31.146222+00'),\n\t(562, 129, 39, '2026-03-22 21:15:31.151013+00'),\n\t(563, 81, 39, '2026-03-22 21:15:31.152584+00'),\n\t(564, 133, 39, '2026-03-22 21:15:31.154511+00'),\n\t(565, 140, 39, '2026-03-22 21:15:31.156577+00'),\n\t(568, 93, 39, '2026-03-22 21:15:31.161643+00'),\n\t(569, 94, 39, '2026-03-22 21:15:31.163205+00'),\n\t(570, 115, 40, '2026-03-22 21:15:31.164648+00'),\n\t(571, 129, 40, '2026-03-22 21:15:31.166063+00'),\n\t(575, 115, 50, '2026-03-22 21:15:31.17119+00'),\n\t(577, 125, 50, '2026-03-22 21:15:31.173692+00'),\n\t(578, 127, 50, '2026-03-22 21:15:31.174947+00'),\n\t(580, 129, 50, '2026-03-22 21:15:31.177666+00'),\n\t(583, 131, 50, '2026-03-22 21:15:31.184086+00'),\n\t(585, 134, 50, '2026-03-22 21:15:31.187367+00'),\n\t(587, 135, 50, '2026-03-22 21:15:31.190068+00'),\n\t(588, 136, 50, '2026-03-22 21:15:31.191372+00'),\n\t(589, 120, 50, '2026-03-22 21:15:31.19272+00'),\n\t(591, 141, 50, '2026-03-22 21:15:31.195366+00'),\n\t(595, 145, 50, '2026-03-22 21:15:31.200649+00'),\n\t(596, 146, 50, '2026-03-22 21:15:31.201865+00'),\n\t(597, 124, 50, '2026-03-22 21:15:31.203051+00'),\n\t(598, 126, 51, '2026-03-22 21:15:31.204309+00'),\n\t(604, 25, 41, '2026-03-22 21:15:31.211424+00'),\n\t(607, 136, 41, '2026-03-22 21:15:31.214823+00'),\n\t(608, 109, 41, '2026-03-22 21:15:31.216249+00'),\n\t(610, 143, 41, '2026-03-22 21:15:31.218827+00'),\n\t(612, 146, 41, '2026-03-22 21:15:31.2212+00'),\n\t(613, 124, 41, '2026-03-22 21:15:31.222665+00'),\n\t(614, 65, 42, '2026-03-22 21:15:31.22395+00'),\n\t(615, 125, 42, '2026-03-22 21:15:31.225306+00'),\n\t(616, 133, 42, '2026-03-22 21:15:31.226775+00'),\n\t(617, 136, 42, '2026-03-22 21:15:31.227995+00'),\n\t(619, 138, 42, '2026-03-22 21:15:31.230355+00'),\n\t(622, 144, 42, '2026-03-22 21:15:31.235621+00'),\n\t(624, 115, 43, '2026-03-22 21:15:31.238038+00'),\n\t(627, 131, 43, '2026-03-22 21:15:31.241701+00'),\n\t(628, 135, 43, '2026-03-22 21:15:31.243894+00'),\n\t(629, 65, 44, '2026-03-22 21:15:31.245745+00'),\n\t(631, 125, 44, '2026-03-22 21:15:31.248615+00'),\n\t(632, 126, 44, '2026-03-22 21:15:31.250314+00'),\n\t(633, 76, 44, '2026-03-22 21:15:31.251802+00'),\n\t(635, 133, 44, '2026-03-22 21:15:31.254793+00'),\n\t(636, 136, 44, '2026-03-22 21:15:31.256189+00'),\n\t(637, 120, 44, '2026-03-22 21:15:31.257579+00'),\n\t(639, 143, 44, '2026-03-22 21:15:31.260301+00'),\n\t(641, 91, 44, '2026-03-22 21:15:31.263576+00'),\n\t(644, 146, 45, '2026-03-22 21:15:31.267959+00'),\n\t(645, 128, 58, '2026-03-22 21:15:31.269333+00'),\n\t(646, 129, 58, '2026-03-22 21:15:31.270576+00'),\n\t(647, 130, 58, '2026-03-22 21:15:31.271741+00'),\n\t(648, 84, 58, '2026-03-22 21:15:31.272863+00'),\n\t(649, 137, 58, '2026-03-22 21:15:31.273978+00'),\n\t(650, 138, 58, '2026-03-22 21:15:31.275143+00'),\n\t(651, 139, 58, '2026-03-22 21:15:31.276411+00'),\n\t(652, 90, 58, '2026-03-22 21:15:31.277628+00'),\n\t(653, 145, 58, '2026-03-22 21:15:31.279005+00'),\n\t(654, 131, 46, '2026-03-22 21:15:31.280344+00'),\n\t(655, 137, 46, '2026-03-22 21:15:31.281974+00'),\n\t(656, 142, 46, '2026-03-22 21:15:31.283531+00'),\n\t(657, 90, 46, '2026-03-22 21:15:31.28485+00'),\n\t(658, 145, 46, '2026-03-22 21:15:31.286106+00'),\n\t(659, 25, 59, '2026-03-22 21:15:31.287288+00'),\n\t(660, 128, 59, '2026-03-22 21:15:31.288765+00'),\n\t(661, 129, 59, '2026-03-22 21:15:31.290097+00'),\n\t(662, 81, 59, '2026-03-22 21:15:31.291226+00'),\n\t(663, 53, 59, '2026-03-22 21:15:31.292472+00'),\n\t(664, 130, 59, '2026-03-22 21:15:31.293605+00'),\n\t(665, 82, 59, '2026-03-22 21:15:31.294877+00'),\n\t(666, 131, 59, '2026-03-22 21:15:31.29623+00'),\n\t(667, 132, 59, '2026-03-22 21:15:31.297568+00'),\n\t(668, 133, 59, '2026-03-22 21:15:31.298658+00'),\n\t(669, 84, 59, '2026-03-22 21:15:31.299872+00'),\n\t(670, 134, 59, '2026-03-22 21:15:31.301051+00'),\n\t(671, 55, 59, '2026-03-22 21:15:31.302177+00'),\n\t(672, 136, 59, '2026-03-22 21:15:31.303441+00'),\n\t(673, 137, 59, '2026-03-22 21:15:31.304661+00'),\n\t(674, 138, 59, '2026-03-22 21:15:31.305922+00'),\n\t(675, 139, 59, '2026-03-22 21:15:31.307114+00'),\n\t(676, 140, 59, '2026-03-22 21:15:31.308604+00'),\n\t(677, 142, 59, '2026-03-22 21:15:31.310177+00'),\n\t(678, 90, 59, '2026-03-22 21:15:31.311631+00'),\n\t(679, 145, 59, '2026-03-22 21:15:31.31342+00'),\n\t(680, 93, 59, '2026-03-22 21:15:31.31524+00'),\n\t(681, 94, 59, '2026-03-22 21:15:31.31708+00'),\n\t(682, 115, 53, '2026-03-22 21:15:31.318688+00'),\n\t(684, 142, 53, '2026-03-22 21:15:31.321595+00'),\n\t(685, 91, 53, '2026-03-22 21:15:31.322969+00'),\n\t(686, 144, 53, '2026-03-22 21:15:31.328758+00'),\n\t(687, 60, 53, '2026-03-22 21:15:31.330525+00'),\n\t(688, 146, 53, '2026-03-22 21:15:31.331779+00'),\n\t(689, 136, 48, '2026-03-22 21:15:31.332932+00'),\n\t(693, 91, 48, '2026-03-22 21:15:31.337706+00'),\n\t(697, 51, 35, '2026-03-22 21:15:31.342366+00'),\n\t(700, 152, 35, '2026-03-22 21:15:31.34606+00'),\n\t(707, 79, 36, '2026-03-22 21:15:31.354159+00'),\n\t(709, 152, 36, '2026-03-22 21:15:31.35805+00'),\n\t(710, 153, 36, '2026-03-22 21:15:31.360198+00'),\n\t(714, 147, 37, '2026-03-22 21:15:31.367528+00'),\n\t(716, 153, 37, '2026-03-22 21:15:31.370195+00'),\n\t(720, 133, 38, '2026-03-22 21:15:31.375078+00'),\n\t(721, 140, 38, '2026-03-22 21:15:31.376624+00'),\n\t(725, 148, 40, '2026-03-22 21:15:31.381447+00'),\n\t(726, 140, 40, '2026-03-22 21:15:31.382752+00'),\n\t(733, 119, 41, '2026-03-22 21:15:31.390868+00'),\n\t(736, 148, 42, '2026-03-22 21:15:31.394361+00'),\n\t(738, 150, 42, '2026-03-22 21:15:31.397129+00'),\n\t(744, 155, 43, '2026-03-22 21:15:31.406213+00'),\n\t(747, 140, 44, '2026-03-22 21:15:31.410233+00'),\n\t(748, 89, 44, '2026-03-22 21:15:31.412135+00'),\n\t(750, 148, 45, '2026-03-22 21:15:31.414753+00'),\n\t(752, 150, 47, '2026-03-22 21:15:31.417233+00'),\n\t(753, 140, 47, '2026-03-22 21:15:31.418711+00'),\n\t(756, 148, 53, '2026-03-22 21:15:31.422931+00'),\n\t(757, 155, 53, '2026-03-22 21:15:31.424467+00'),\n\t(760, 148, 48, '2026-03-22 21:15:31.428274+00'),\n\t(764, 159, 35, '2026-03-22 21:15:31.433292+00'),\n\t(765, 50, 35, '2026-03-22 21:15:31.434466+00'),\n\t(767, 160, 35, '2026-03-22 21:15:31.436601+00'),\n\t(768, 44, 36, '2026-03-22 21:15:31.437771+00'),\n\t(774, 96, 37, '2026-03-22 21:15:31.444415+00'),\n\t(775, 97, 37, '2026-03-22 21:15:31.445808+00'),\n\t(776, 115, 37, '2026-03-22 21:15:31.446889+00'),\n\t(779, 160, 38, '2026-03-22 21:15:31.450521+00'),\n\t(784, 96, 50, '2026-03-22 21:15:31.456752+00'),\n\t(786, 159, 50, '2026-03-22 21:15:31.46075+00'),\n\t(788, 161, 50, '2026-03-22 21:15:31.463722+00'),\n\t(789, 96, 54, '2026-03-22 21:15:31.465099+00'),\n\t(790, 97, 54, '2026-03-22 21:15:31.46666+00'),\n\t(791, 115, 54, '2026-03-22 21:15:31.468213+00'),\n\t(792, 158, 54, '2026-03-22 21:15:31.469744+00'),\n\t(793, 159, 54, '2026-03-22 21:15:31.471062+00'),\n\t(794, 102, 54, '2026-03-22 21:15:31.472295+00'),\n\t(796, 161, 54, '2026-03-22 21:15:31.474953+00'),\n\t(804, 159, 43, '2026-03-22 21:15:31.48588+00'),\n\t(808, 161, 43, '2026-03-22 21:15:31.490444+00'),\n\t(809, 160, 44, '2026-03-22 21:15:31.491578+00'),\n\t(812, 97, 45, '2026-03-22 21:15:31.494772+00'),\n\t(813, 115, 45, '2026-03-22 21:15:31.495905+00'),\n\t(814, 158, 45, '2026-03-22 21:15:31.497175+00'),\n\t(815, 159, 45, '2026-03-22 21:15:31.498315+00'),\n\t(819, 161, 45, '2026-03-22 21:15:31.503483+00'),\n\t(820, 158, 52, '2026-03-22 21:15:31.505687+00'),\n\t(821, 159, 52, '2026-03-22 21:15:31.507098+00'),\n\t(825, 115, 47, '2026-03-22 21:15:31.512201+00'),\n\t(826, 159, 47, '2026-03-22 21:15:31.513504+00'),\n\t(831, 159, 53, '2026-03-22 21:15:31.519583+00'),\n\t(833, 160, 53, '2026-03-22 21:15:31.522241+00'),\n\t(837, 160, 48, '2026-03-22 21:15:31.527243+00'),\n\t(854, 103, 37, '2026-03-22 21:15:31.546656+00'),\n\t(862, 97, 38, '2026-03-22 21:15:31.556802+00'),\n\t(864, 131, 38, '2026-03-22 21:15:31.559146+00'),\n\t(866, 134, 38, '2026-03-22 21:15:31.561503+00'),\n\t(870, 145, 38, '2026-03-22 21:15:31.5665+00'),\n\t(872, 167, 39, '2026-03-22 21:15:31.568948+00'),\n\t(873, 77, 39, '2026-03-22 21:15:31.570354+00'),\n\t(881, 134, 41, '2026-03-22 21:15:31.580084+00'),\n\t(883, 135, 41, '2026-03-22 21:15:31.582321+00'),\n\t(887, 77, 42, '2026-03-22 21:15:31.592279+00'),\n\t(891, 77, 43, '2026-03-22 21:15:31.59786+00'),\n\t(894, 120, 43, '2026-03-22 21:15:31.602439+00'),\n\t(899, 64, 60, '2026-03-22 21:15:31.610032+00'),\n\t(900, 98, 60, '2026-03-22 21:15:31.611684+00'),\n\t(901, 77, 60, '2026-03-22 21:15:31.613226+00'),\n\t(903, 134, 46, '2026-03-22 21:15:31.615801+00'),\n\t(906, 129, 47, '2026-03-22 21:15:31.62109+00'),\n\t(907, 131, 47, '2026-03-22 21:15:31.622648+00'),\n\t(909, 134, 47, '2026-03-22 21:15:31.627515+00'),\n\t(911, 145, 47, '2026-03-22 21:15:31.632926+00'),\n\t(912, 21, 61, '2026-03-22 21:15:31.635401+00'),\n\t(913, 103, 61, '2026-03-22 21:15:31.63737+00'),\n\t(914, 120, 61, '2026-03-22 21:15:31.639668+00'),\n\t(917, 84, 53, '2026-03-22 21:15:31.648556+00'),\n\t(920, 24, 49, '2026-03-22 21:15:31.657329+00'),\n\t(928, 158, 36, '2026-03-22 21:15:31.676898+00'),\n\t(930, 27, 36, '2026-03-22 21:15:31.679584+00'),\n\t(933, 109, 36, '2026-03-22 21:15:31.683513+00'),\n\t(935, 158, 37, '2026-03-22 21:15:31.68735+00'),\n\t(936, 170, 37, '2026-03-22 21:15:31.689353+00'),\n\t(938, 33, 37, '2026-03-22 21:15:31.693341+00'),\n\t(942, 175, 38, '2026-03-22 21:15:31.698506+00'),\n\t(947, 23, 40, '2026-03-22 21:15:31.704959+00'),\n\t(948, 158, 40, '2026-03-22 21:15:31.706316+00'),\n\t(949, 171, 40, '2026-03-22 21:15:31.707606+00'),\n\t(950, 172, 40, '2026-03-22 21:15:31.708908+00'),\n\t(951, 173, 40, '2026-03-22 21:15:31.710232+00'),\n\t(953, 27, 40, '2026-03-22 21:15:31.713097+00'),\n\t(956, 174, 40, '2026-03-22 21:15:31.717526+00'),\n\t(957, 33, 40, '2026-03-22 21:15:31.718994+00'),\n\t(958, 176, 40, '2026-03-22 21:15:31.720478+00'),\n\t(959, 177, 40, '2026-03-22 21:15:31.72324+00'),\n\t(960, 158, 41, '2026-03-22 21:15:31.724915+00'),\n\t(961, 74, 41, '2026-03-22 21:15:31.726551+00'),\n\t(964, 24, 42, '2026-03-22 21:15:31.730679+00'),\n\t(965, 173, 42, '2026-03-22 21:15:31.732144+00'),\n\t(967, 27, 42, '2026-03-22 21:15:31.735483+00'),\n\t(969, 176, 42, '2026-03-22 21:15:31.738394+00'),\n\t(970, 23, 43, '2026-03-22 21:15:31.739872+00'),\n\t(971, 158, 43, '2026-03-22 21:15:31.741284+00'),\n\t(972, 171, 43, '2026-03-22 21:15:31.742651+00'),\n\t(973, 172, 43, '2026-03-22 21:15:31.743922+00'),\n\t(974, 173, 43, '2026-03-22 21:15:31.745328+00'),\n\t(976, 27, 43, '2026-03-22 21:15:31.747831+00'),\n\t(979, 174, 43, '2026-03-22 21:15:31.751777+00'),\n\t(980, 33, 43, '2026-03-22 21:15:31.754097+00'),\n\t(981, 176, 43, '2026-03-22 21:15:31.755824+00'),\n\t(983, 177, 43, '2026-03-22 21:15:31.758509+00'),\n\t(984, 174, 52, '2026-03-22 21:15:31.759872+00'),\n\t(985, 177, 52, '2026-03-22 21:15:31.76211+00'),\n\t(986, 37, 52, '2026-03-22 21:15:31.763693+00'),\n\t(988, 171, 53, '2026-03-22 21:15:31.766224+00'),\n\t(989, 24, 53, '2026-03-22 21:15:31.767476+00'),\n\t(993, 31, 53, '2026-03-22 21:15:31.772211+00'),\n\t(994, 176, 53, '2026-03-22 21:15:31.77343+00'),\n\t(995, 37, 53, '2026-03-22 21:15:31.774594+00'),\n\t(996, 177, 53, '2026-03-22 21:15:31.775675+00'),\n\t(1000, 45, 36, '2026-03-22 21:15:31.779868+00'),\n\t(1002, 83, 36, '2026-03-22 21:15:31.782425+00'),\n\t(1003, 89, 36, '2026-03-22 21:15:31.786103+00'),\n\t(1005, 92, 36, '2026-03-22 21:15:31.789297+00'),\n\t(1006, 61, 36, '2026-03-22 21:15:31.791036+00'),\n\t(1007, 179, 37, '2026-03-22 21:15:31.793015+00'),\n\t(1008, 60, 38, '2026-03-22 21:15:31.795644+00'),\n\t(1010, 83, 38, '2026-03-22 21:15:31.798684+00'),\n\t(1012, 45, 39, '2026-03-22 21:15:31.80384+00'),\n\t(1013, 83, 39, '2026-03-22 21:15:31.805745+00'),\n\t(1015, 60, 39, '2026-03-22 21:15:31.808708+00'),\n\t(1016, 92, 39, '2026-03-22 21:15:31.810292+00'),\n\t(1017, 61, 41, '2026-03-22 21:15:31.811623+00'),\n\t(1019, 179, 42, '2026-03-22 21:15:31.814199+00'),\n\t(1030, 180, 52, '2026-03-22 21:15:31.828823+00'),\n\t(1031, 78, 53, '2026-03-22 21:15:31.830169+00'),\n\t(1034, 95, 53, '2026-03-22 21:15:31.83435+00'),\n\t(1038, 60, 48, '2026-03-22 21:15:31.839816+00'),\n\t(1041, 28, 49, '2026-03-22 21:15:31.844044+00'),\n\t(1046, 117, 36, '2026-03-22 21:15:31.854822+00'),\n\t(1050, 181, 37, '2026-03-22 21:15:31.860736+00'),\n\t(1053, 186, 37, '2026-03-22 21:15:31.864793+00'),\n\t(1055, 148, 39, '2026-03-22 21:15:31.867672+00'),\n\t(1057, 150, 39, '2026-03-22 21:15:31.870107+00'),\n\t(1058, 164, 39, '2026-03-22 21:15:31.871826+00'),\n\t(1059, 28, 39, '2026-03-22 21:15:31.873439+00'),\n\t(1061, 163, 62, '2026-03-22 21:15:31.876075+00'),\n\t(1062, 164, 62, '2026-03-22 21:15:31.87732+00'),\n\t(1064, 182, 51, '2026-03-22 21:15:31.879538+00'),\n\t(1075, 176, 45, '2026-03-22 21:15:31.894188+00'),\n\t(1077, 73, 46, '2026-03-22 21:15:31.896996+00'),\n\t(1079, 31, 52, '2026-03-22 21:15:31.899295+00'),\n\t(1084, 181, 53, '2026-03-22 21:15:31.904874+00'),\n\t(1087, 28, 53, '2026-03-22 21:15:31.908207+00'),\n\t(1094, 109, 35, '2026-03-22 21:15:31.931117+00'),\n\t(1097, 72, 36, '2026-03-22 21:15:31.937632+00'),\n\t(1102, 59, 36, '2026-03-22 21:15:31.945272+00'),\n\t(1109, 161, 37, '2026-03-22 21:15:31.95589+00'),\n\t(1111, 189, 37, '2026-03-22 21:15:31.959685+00'),\n\t(1112, 70, 38, '2026-03-22 21:15:31.961158+00'),\n\t(1113, 72, 38, '2026-03-22 21:15:31.964529+00'),\n\t(1124, 146, 38, '2026-03-22 21:15:31.978881+00'),\n\t(1128, 97, 39, '2026-03-22 21:15:31.983705+00'),\n\t(1130, 188, 39, '2026-03-22 21:15:31.98594+00'),\n\t(1131, 155, 39, '2026-03-22 21:15:31.987203+00'),\n\t(1139, 102, 50, '2026-03-22 21:15:31.995952+00'),\n\t(1146, 110, 50, '2026-03-22 21:15:32.004044+00'),\n\t(1148, 121, 50, '2026-03-22 21:15:32.006424+00'),\n\t(1151, 189, 50, '2026-03-22 21:15:32.009801+00'),\n\t(1159, 160, 40, '2026-03-22 21:15:32.020139+00'),\n\t(1162, 121, 40, '2026-03-22 21:15:32.023806+00'),\n\t(1163, 161, 40, '2026-03-22 21:15:32.025308+00'),\n\t(1164, 189, 40, '2026-03-22 21:15:32.026544+00'),\n\t(1173, 188, 42, '2026-03-22 21:15:32.037493+00'),\n\t(1189, 82, 46, '2026-03-22 21:15:32.068664+00'),\n\t(1202, 146, 47, '2026-03-22 21:15:32.086918+00'),\n\t(1206, 72, 53, '2026-03-22 21:15:32.092414+00'),\n\t(1209, 131, 53, '2026-03-22 21:15:32.0957+00'),\n\t(1212, 189, 53, '2026-03-22 21:15:32.099289+00'),\n\t(1214, 190, 53, '2026-03-22 21:15:32.101925+00'),\n\t(1216, 97, 48, '2026-03-22 21:15:32.104261+00'),\n\t(1220, 38, 49, '2026-03-22 21:15:32.109025+00'),\n\t(1222, 194, 37, '2026-03-22 21:15:32.111462+00'),\n\t(1223, 196, 37, '2026-03-22 21:15:32.112642+00'),\n\t(1226, 54, 39, '2026-03-22 21:15:32.116154+00'),\n\t(1229, 195, 41, '2026-03-22 21:15:32.119772+00'),\n\t(1230, 160, 43, '2026-03-22 21:15:32.121435+00'),\n\t(1232, 196, 48, '2026-03-22 21:15:32.124011+00'),\n\t(1233, 201, 49, '2026-03-22 21:15:32.125354+00'),\n\t(1241, 67, 36, '2026-03-22 21:15:32.137925+00'),\n\t(1242, 48, 36, '2026-03-22 21:15:32.139513+00'),\n\t(1243, 49, 36, '2026-03-22 21:15:32.140736+00'),\n\t(1251, 126, 38, '2026-03-22 21:15:32.150916+00'),\n\t(1253, 199, 38, '2026-03-22 21:15:32.153655+00'),\n\t(1255, 132, 38, '2026-03-22 21:15:32.156366+00'),\n\t(1258, 143, 38, '2026-03-22 21:15:32.160521+00'),\n\t(1264, 201, 39, '2026-03-22 21:15:32.16785+00'),\n\t(1268, 67, 50, '2026-03-22 21:15:32.172497+00'),\n\t(1283, 132, 47, '2026-03-22 21:15:32.190131+00'),\n\t(1298, 148, 49, '2026-03-22 21:15:32.216238+00'),\n\t(1300, 27, 49, '2026-03-22 21:15:32.2188+00'),\n\t(1305, 177, 49, '2026-03-22 21:15:32.224978+00'),\n\t(1306, 123, 49, '2026-03-22 21:15:32.226183+00'),\n\t(1309, 33, 35, '2026-03-22 21:15:32.229598+00'),\n\t(1328, 158, 39, '2026-03-22 21:15:32.251025+00'),\n\t(1334, 159, 40, '2026-03-22 21:15:32.260306+00'),\n\t(1339, 113, 50, '2026-03-22 21:15:32.2676+00'),\n\t(1344, 123, 50, '2026-03-22 21:15:32.275097+00'),\n\t(1350, 175, 41, '2026-03-22 21:15:32.28265+00'),\n\t(1352, 123, 41, '2026-03-22 21:15:32.285094+00'),\n\t(1355, 113, 42, '2026-03-22 21:15:32.28864+00'),\n\t(1370, 113, 52, '2026-03-22 21:15:32.30705+00'),\n\t(1371, 171, 52, '2026-03-22 21:15:32.308318+00'),\n\t(1372, 24, 52, '2026-03-22 21:15:32.309571+00'),\n\t(1373, 173, 52, '2026-03-22 21:15:32.310812+00'),\n\t(1376, 33, 52, '2026-03-22 21:15:32.31523+00'),\n\t(1387, 33, 53, '2026-03-22 21:15:32.329582+00'),\n\t(1388, 123, 53, '2026-03-22 21:15:32.331064+00'),\n\t(1391, 148, 63, '2026-03-22 21:15:32.334281+00'),\n\t(1392, 113, 63, '2026-03-22 21:15:32.335706+00'),\n\t(1393, 97, 63, '2026-03-22 21:15:32.337006+00'),\n\t(1394, 158, 63, '2026-03-22 21:15:32.338311+00'),\n\t(1395, 159, 63, '2026-03-22 21:15:32.339654+00'),\n\t(1396, 171, 63, '2026-03-22 21:15:32.340884+00'),\n\t(1397, 24, 63, '2026-03-22 21:15:32.341956+00'),\n\t(1398, 172, 63, '2026-03-22 21:15:32.343191+00'),\n\t(1399, 173, 63, '2026-03-22 21:15:32.344507+00'),\n\t(1400, 102, 63, '2026-03-22 21:15:32.345768+00'),\n\t(1401, 30, 63, '2026-03-22 21:15:32.346969+00'),\n\t(1402, 31, 63, '2026-03-22 21:15:32.348136+00'),\n\t(1403, 175, 63, '2026-03-22 21:15:32.349501+00'),\n\t(1404, 33, 63, '2026-03-22 21:15:32.350791+00'),\n\t(1405, 34, 63, '2026-03-22 21:15:32.352365+00'),\n\t(1406, 176, 63, '2026-03-22 21:15:32.354114+00'),\n\t(1407, 205, 63, '2026-03-22 21:15:32.355551+00'),\n\t(1408, 37, 63, '2026-03-22 21:15:32.356946+00'),\n\t(1409, 206, 63, '2026-03-22 21:15:32.358162+00'),\n\t(1410, 9, 64, '2026-03-22 21:15:32.359517+00'),\n\t(1413, 208, 35, '2026-03-22 21:15:32.364086+00'),\n\t(1416, 25, 36, '2026-03-22 21:15:32.368177+00'),\n\t(1417, 145, 36, '2026-03-22 21:15:32.369399+00'),\n\t(1419, 44, 38, '2026-03-22 21:15:32.371689+00'),\n\t(1420, 72, 39, '2026-03-22 21:15:32.372781+00'),\n\t(1421, 25, 39, '2026-03-22 21:15:32.374051+00'),\n\t(1422, 131, 39, '2026-03-22 21:15:32.375173+00'),\n\t(1423, 137, 39, '2026-03-22 21:15:32.376374+00'),\n\t(1424, 142, 39, '2026-03-22 21:15:32.377629+00'),\n\t(1427, 145, 39, '2026-03-22 21:15:32.381923+00'),\n\t(1428, 146, 39, '2026-03-22 21:15:32.38332+00'),\n\t(1431, 73, 65, '2026-03-22 21:15:32.386622+00'),\n\t(1432, 131, 65, '2026-03-22 21:15:32.388029+00'),\n\t(1435, 146, 54, '2026-03-22 21:15:32.391839+00'),\n\t(1438, 208, 41, '2026-03-22 21:15:32.395658+00'),\n\t(1449, 208, 44, '2026-03-22 21:15:32.407974+00'),\n\t(1452, 91, 60, '2026-03-22 21:15:32.411412+00'),\n\t(1453, 208, 45, '2026-03-22 21:15:32.412608+00'),\n\t(1455, 146, 52, '2026-03-22 21:15:32.414939+00'),\n\t(1458, 137, 47, '2026-03-22 21:15:32.418769+00'),\n\t(1459, 142, 47, '2026-03-22 21:15:32.420115+00'),\n\t(1463, 93, 47, '2026-03-22 21:15:32.42586+00'),\n\t(1465, 211, 47, '2026-03-22 21:15:32.428367+00'),\n\t(1466, 208, 48, '2026-03-22 21:15:32.429789+00'),\n\t(1472, 84, 57, '2026-03-22 21:15:32.437244+00'),\n\t(1484, 129, 38, '2026-03-22 21:15:32.451534+00'),\n\t(1492, 137, 38, '2026-03-22 21:15:32.460257+00'),\n\t(1493, 138, 38, '2026-03-22 21:15:32.461949+00'),\n\t(1494, 142, 38, '2026-03-22 21:15:32.467519+00'),\n\t(1499, 212, 39, '2026-03-22 21:15:32.473766+00'),\n\t(1522, 212, 43, '2026-03-22 21:15:32.500587+00'),\n\t(1526, 132, 44, '2026-03-22 21:15:32.506106+00'),\n\t(1539, 69, 48, '2026-03-22 21:15:32.522394+00')","--\n-- Name: action_descriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"action_descriptions_id_seq\\"', 301, true)","--\n-- Name: body_systems_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"body_systems_id_seq\\"', 16, true)","--\n-- Name: herb_primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"herb_primary_actions_id_seq\\"', 879, true)","--\n-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"herb_secondary_actions_id_seq\\"', 1541, true)","--\n-- Name: herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"herbs_id_seq\\"', 218, true)","--\n-- Name: primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"primary_actions_id_seq\\"', 24, true)","--\n-- Name: secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres\n--\n\nSELECT pg_catalog.setval('\\"herbal\\".\\"secondary_actions_id_seq\\"', 65, true)","--\n-- PostgreSQL database dump complete\n--\n\n-- \\\\unrestrict HpaiwY8Yszu6KUg42qKJGrWw1I58Lut0jmsVHHyCtzyDi9LO5YfoY4HteSXq58L\n\nRESET ALL"}	current_data_snapshot
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: action_descriptions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.action_descriptions_id_seq', 301, true);


--
-- Name: body_systems_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.body_systems_id_seq', 16, true);


--
-- Name: herb_primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.herb_primary_actions_id_seq', 879, true);


--
-- Name: herb_secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.herb_secondary_actions_id_seq', 1541, true);


--
-- Name: herbs_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.herbs_id_seq', 218, true);


--
-- Name: primary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.primary_actions_id_seq', 24, true);


--
-- Name: secondary_actions_id_seq; Type: SEQUENCE SET; Schema: herbal; Owner: postgres
--

SELECT pg_catalog.setval('herbal.secondary_actions_id_seq', 65, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: action_descriptions action_descriptions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.action_descriptions
    ADD CONSTRAINT action_descriptions_pkey PRIMARY KEY (id);


--
-- Name: body_systems body_systems_name_key; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.body_systems
    ADD CONSTRAINT body_systems_name_key UNIQUE (name);


--
-- Name: body_systems body_systems_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.body_systems
    ADD CONSTRAINT body_systems_pkey PRIMARY KEY (id);


--
-- Name: herb_primary_actions herb_primary_actions_herb_id_primary_action_id_body_system__key; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_herb_id_primary_action_id_body_system__key UNIQUE (herb_id, primary_action_id, body_system_id);


--
-- Name: herb_primary_actions herb_primary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_pkey PRIMARY KEY (id);


--
-- Name: herb_secondary_actions herb_secondary_actions_herb_id_secondary_action_id_key; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_herb_id_secondary_action_id_key UNIQUE (herb_id, secondary_action_id);


--
-- Name: herb_secondary_actions herb_secondary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_pkey PRIMARY KEY (id);


--
-- Name: herbs herbs_latin_name_key; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herbs
    ADD CONSTRAINT herbs_latin_name_key UNIQUE (latin_name);


--
-- Name: herbs herbs_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herbs
    ADD CONSTRAINT herbs_pkey PRIMARY KEY (id);


--
-- Name: primary_actions primary_actions_name_key; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.primary_actions
    ADD CONSTRAINT primary_actions_name_key UNIQUE (name);


--
-- Name: primary_actions primary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.primary_actions
    ADD CONSTRAINT primary_actions_pkey PRIMARY KEY (id);


--
-- Name: secondary_actions secondary_actions_name_key; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.secondary_actions
    ADD CONSTRAINT secondary_actions_name_key UNIQUE (name);


--
-- Name: secondary_actions secondary_actions_pkey; Type: CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.secondary_actions
    ADD CONSTRAINT secondary_actions_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_05 messages_2026_04_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_05
    ADD CONSTRAINT messages_2026_04_05_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_06 messages_2026_04_06_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_06
    ADD CONSTRAINT messages_2026_04_06_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_07 messages_2026_04_07_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_07
    ADD CONSTRAINT messages_2026_04_07_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_08 messages_2026_04_08_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_08
    ADD CONSTRAINT messages_2026_04_08_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_09 messages_2026_04_09_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_04_09
    ADD CONSTRAINT messages_2026_04_09_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_action_descriptions_action; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_action_descriptions_action ON herbal.action_descriptions USING btree (primary_action_id);


--
-- Name: idx_herb_primary_actions_action; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herb_primary_actions_action ON herbal.herb_primary_actions USING btree (primary_action_id);


--
-- Name: idx_herb_primary_actions_herb; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herb_primary_actions_herb ON herbal.herb_primary_actions USING btree (herb_id);


--
-- Name: idx_herb_primary_actions_system; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herb_primary_actions_system ON herbal.herb_primary_actions USING btree (body_system_id);


--
-- Name: idx_herb_secondary_actions_action; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herb_secondary_actions_action ON herbal.herb_secondary_actions USING btree (secondary_action_id);


--
-- Name: idx_herb_secondary_actions_herb; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herb_secondary_actions_herb ON herbal.herb_secondary_actions USING btree (herb_id);


--
-- Name: idx_herbs_common_name; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herbs_common_name ON herbal.herbs USING btree (common_name);


--
-- Name: idx_herbs_latin_name; Type: INDEX; Schema: herbal; Owner: postgres
--

CREATE INDEX idx_herbs_latin_name ON herbal.herbs USING btree (latin_name);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_05_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_05_inserted_at_topic_idx ON realtime.messages_2026_04_05 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_06_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_06_inserted_at_topic_idx ON realtime.messages_2026_04_06 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_07_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_07_inserted_at_topic_idx ON realtime.messages_2026_04_07 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_08_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_08_inserted_at_topic_idx ON realtime.messages_2026_04_08 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_09_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_04_09_inserted_at_topic_idx ON realtime.messages_2026_04_09 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (catalog_id, name);


--
-- Name: idx_iceberg_tables_location; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_location ON storage.iceberg_tables USING btree (location);


--
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (catalog_id, namespace_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: messages_2026_04_05_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_05_inserted_at_topic_idx;


--
-- Name: messages_2026_04_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_05_pkey;


--
-- Name: messages_2026_04_06_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_06_inserted_at_topic_idx;


--
-- Name: messages_2026_04_06_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_06_pkey;


--
-- Name: messages_2026_04_07_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_07_inserted_at_topic_idx;


--
-- Name: messages_2026_04_07_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_07_pkey;


--
-- Name: messages_2026_04_08_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_08_inserted_at_topic_idx;


--
-- Name: messages_2026_04_08_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_08_pkey;


--
-- Name: messages_2026_04_09_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_09_inserted_at_topic_idx;


--
-- Name: messages_2026_04_09_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_09_pkey;


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: action_descriptions action_descriptions_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.action_descriptions
    ADD CONSTRAINT action_descriptions_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: herb_primary_actions herb_primary_actions_body_system_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_body_system_id_fkey FOREIGN KEY (body_system_id) REFERENCES herbal.body_systems(id) ON DELETE CASCADE;


--
-- Name: herb_primary_actions herb_primary_actions_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: herb_primary_actions herb_primary_actions_primary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_primary_actions
    ADD CONSTRAINT herb_primary_actions_primary_action_id_fkey FOREIGN KEY (primary_action_id) REFERENCES herbal.primary_actions(id) ON DELETE CASCADE;


--
-- Name: herb_secondary_actions herb_secondary_actions_herb_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_herb_id_fkey FOREIGN KEY (herb_id) REFERENCES herbal.herbs(id) ON DELETE CASCADE;


--
-- Name: herb_secondary_actions herb_secondary_actions_secondary_action_id_fkey; Type: FK CONSTRAINT; Schema: herbal; Owner: postgres
--

ALTER TABLE ONLY herbal.herb_secondary_actions
    ADD CONSTRAINT herb_secondary_actions_secondary_action_id_fkey FOREIGN KEY (secondary_action_id) REFERENCES herbal.secondary_actions(id) ON DELETE CASCADE;


--
-- Name: iceberg_namespaces iceberg_namespaces_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA herbal; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA herbal TO anon;
GRANT USAGE ON SCHEMA herbal TO authenticated;
GRANT USAGE ON SCHEMA herbal TO service_role;


--
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE action_descriptions; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.action_descriptions TO anon;
GRANT ALL ON TABLE herbal.action_descriptions TO authenticated;
GRANT ALL ON TABLE herbal.action_descriptions TO service_role;


--
-- Name: SEQUENCE action_descriptions_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.action_descriptions_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.action_descriptions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.action_descriptions_id_seq TO service_role;


--
-- Name: TABLE body_systems; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.body_systems TO anon;
GRANT ALL ON TABLE herbal.body_systems TO authenticated;
GRANT ALL ON TABLE herbal.body_systems TO service_role;


--
-- Name: SEQUENCE body_systems_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.body_systems_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.body_systems_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.body_systems_id_seq TO service_role;


--
-- Name: TABLE herb_primary_actions; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.herb_primary_actions TO anon;
GRANT ALL ON TABLE herbal.herb_primary_actions TO authenticated;
GRANT ALL ON TABLE herbal.herb_primary_actions TO service_role;


--
-- Name: SEQUENCE herb_primary_actions_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.herb_primary_actions_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.herb_primary_actions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.herb_primary_actions_id_seq TO service_role;


--
-- Name: TABLE herb_secondary_actions; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.herb_secondary_actions TO anon;
GRANT ALL ON TABLE herbal.herb_secondary_actions TO authenticated;
GRANT ALL ON TABLE herbal.herb_secondary_actions TO service_role;


--
-- Name: SEQUENCE herb_secondary_actions_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.herb_secondary_actions_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.herb_secondary_actions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.herb_secondary_actions_id_seq TO service_role;


--
-- Name: TABLE herbs; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.herbs TO anon;
GRANT ALL ON TABLE herbal.herbs TO authenticated;
GRANT ALL ON TABLE herbal.herbs TO service_role;


--
-- Name: SEQUENCE herbs_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.herbs_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.herbs_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.herbs_id_seq TO service_role;


--
-- Name: TABLE primary_actions; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.primary_actions TO anon;
GRANT ALL ON TABLE herbal.primary_actions TO authenticated;
GRANT ALL ON TABLE herbal.primary_actions TO service_role;


--
-- Name: SEQUENCE primary_actions_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.primary_actions_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.primary_actions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.primary_actions_id_seq TO service_role;


--
-- Name: TABLE secondary_actions; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON TABLE herbal.secondary_actions TO anon;
GRANT ALL ON TABLE herbal.secondary_actions TO authenticated;
GRANT ALL ON TABLE herbal.secondary_actions TO service_role;


--
-- Name: SEQUENCE secondary_actions_id_seq; Type: ACL; Schema: herbal; Owner: postgres
--

GRANT ALL ON SEQUENCE herbal.secondary_actions_id_seq TO anon;
GRANT ALL ON SEQUENCE herbal.secondary_actions_id_seq TO authenticated;
GRANT ALL ON SEQUENCE herbal.secondary_actions_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_04_05; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_05 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_05 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_06; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_06 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_06 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_07; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_07 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_07 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_08; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_08 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_08 TO dashboard_user;


--
-- Name: TABLE messages_2026_04_09; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_04_09 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_04_09 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE iceberg_namespaces; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_namespaces TO service_role;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO anon;


--
-- Name: TABLE iceberg_tables; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_tables TO service_role;
GRANT SELECT ON TABLE storage.iceberg_tables TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_tables TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO postgres;
GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO postgres;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO postgres;
GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict CvkWgYkkvicseNUe4FiR86ToYanydrglk87Ky7fK4lAiEo68eXHogPU6PPP3Gjz

