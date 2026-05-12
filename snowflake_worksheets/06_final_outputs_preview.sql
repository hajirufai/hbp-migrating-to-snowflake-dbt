-- 06_final_outputs_preview.sql
-- Purpose: show the final dbt mart tables used for analysis and reporting.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

show tables in schema HBP_DEMO.RAW_MARTS;

select * from HBP_DEMO.RAW_MARTS.DIM_ACCOUNTS limit 20;
select * from HBP_DEMO.RAW_MARTS.FCT_ACCOUNT_HEALTH limit 20;
select * from HBP_DEMO.RAW_MARTS.FCT_CONTENT_PERFORMANCE limit 20;
