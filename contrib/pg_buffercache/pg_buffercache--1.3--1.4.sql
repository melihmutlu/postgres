/* contrib/pg_buffercache/pg_buffercache--1.3--1.4.sql */

-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION pg_buffercache UPDATE TO '1.4'" to load this file. \quit

CREATE FUNCTION pg_buffercache_summary()
RETURNS SETOF RECORD
AS 'MODULE_PATHNAME', 'pg_buffercache_summary'
LANGUAGE C PARALLEL SAFE;

-- Create a view for convenient access.
CREATE VIEW pg_buffercache_summary AS
	SELECT P.* FROM pg_buffercache_summary() AS P
	(used_buffers int2,
     unused_buffers int2,
     dirty_buffers int2,
	 pinned_buffers int2);

-- Don't want these to be available to public.
REVOKE ALL ON FUNCTION pg_buffercache_summary() FROM PUBLIC;
