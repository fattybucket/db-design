/* contrib/citext/citext--1.0--1.1.sql */

-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION citext UPDATE TO '1.1'" to load this file. \quit

/* First we have to remove them from the extension */
ALTER EXTENSION citext DROP FUNCTION regexp_matches( citext, citext );
ALTER EXTENSION citext DROP FUNCTION regexp_matches( citext, citext, text );

