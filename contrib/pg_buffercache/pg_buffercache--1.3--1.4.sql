/* contrib/pg_buffercache/pg_buffercache--1.3--1.4.sql */

-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION pg_buffercache UPDATE TO '1.4'" to load this file. \quit

CREATE FUNCTION pg_buffercache_summary()
RETURNS TABLE (used_buffers int4, unused_buffers int4, dirty_buffers int4,
				pinned_buffers int4, avg_usagecount real)
AS 'MODULE_PATHNAME', 'pg_buffercache_summary'
LANGUAGE C PARALLEL SAFE;

-- Don't want these to be available to public.
REVOKE ALL ON FUNCTION pg_buffercache_summary() FROM PUBLIC;
