-- 01_environment_and_schemas.sql
-- Purpose: confirm the Snowflake role, warehouse, database, and dbt-created schemas.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

select
    current_role() as current_role,
    current_warehouse() as current_warehouse,
    current_database() as current_database;

show schemas in database HBP_DEMO;
