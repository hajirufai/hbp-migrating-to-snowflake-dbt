-- 10_source_to_output_audit.sql
-- Purpose: show the end-to-end flow from raw sources to final dbt output tables.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

select 'Source' as layer, 'ACCOUNTS' as object_name, count(*) as row_count
from HBP_DEMO.RAW_RAW.ACCOUNTS
union all
select 'Source', 'SUBSCRIPTIONS', count(*)
from HBP_DEMO.RAW_RAW.SUBSCRIPTIONS
union all
select 'Source', 'CONTENT_ENGAGEMENT', count(*)
from HBP_DEMO.RAW_RAW.CONTENT_ENGAGEMENT
union all
select 'Source', 'SUPPORT_TICKETS', count(*)
from HBP_DEMO.RAW_RAW.SUPPORT_TICKETS
union all
select 'Output', 'DIM_ACCOUNTS', count(*)
from HBP_DEMO.RAW_MARTS.DIM_ACCOUNTS
union all
select 'Output', 'FCT_ACCOUNT_HEALTH', count(*)
from HBP_DEMO.RAW_MARTS.FCT_ACCOUNT_HEALTH
union all
select 'Output', 'FCT_CONTENT_PERFORMANCE', count(*)
from HBP_DEMO.RAW_MARTS.FCT_CONTENT_PERFORMANCE
order by layer, object_name;
