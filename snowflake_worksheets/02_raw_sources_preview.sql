-- 02_raw_sources_preview.sql
-- Purpose: show the source data loaded from dbt seed CSV files.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

show tables in schema HBP_DEMO.RAW_RAW;

select * from HBP_DEMO.RAW_RAW.ACCOUNTS limit 20;
select * from HBP_DEMO.RAW_RAW.SUBSCRIPTIONS limit 20;
select * from HBP_DEMO.RAW_RAW.CONTENT_ENGAGEMENT limit 20;
select * from HBP_DEMO.RAW_RAW.SUPPORT_TICKETS limit 20;
