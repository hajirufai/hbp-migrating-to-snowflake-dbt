-- 05_view_transformation_sql.sql
-- Purpose: display the SQL definition behind dbt staging views in Snowflake.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

select get_ddl('VIEW', 'HBP_DEMO.RAW_STAGING.STG_ACCOUNTS') as stg_accounts_sql;
select get_ddl('VIEW', 'HBP_DEMO.RAW_STAGING.STG_SUBSCRIPTIONS') as stg_subscriptions_sql;
select get_ddl('VIEW', 'HBP_DEMO.RAW_STAGING.STG_CONTENT_ENGAGEMENT') as stg_content_engagement_sql;
select get_ddl('VIEW', 'HBP_DEMO.RAW_STAGING.STG_SUPPORT_TICKETS') as stg_support_tickets_sql;
