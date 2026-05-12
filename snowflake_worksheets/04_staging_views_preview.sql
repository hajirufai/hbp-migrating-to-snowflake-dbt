-- 04_staging_views_preview.sql
-- Purpose: show dbt staging views that clean and standardize raw source data.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

show views in schema HBP_DEMO.RAW_STAGING;

select * from HBP_DEMO.RAW_STAGING.STG_ACCOUNTS limit 20;
select * from HBP_DEMO.RAW_STAGING.STG_SUBSCRIPTIONS limit 20;
select * from HBP_DEMO.RAW_STAGING.STG_CONTENT_ENGAGEMENT limit 20;
select * from HBP_DEMO.RAW_STAGING.STG_SUPPORT_TICKETS limit 20;
