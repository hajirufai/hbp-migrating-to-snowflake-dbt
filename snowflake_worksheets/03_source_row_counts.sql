-- 03_source_row_counts.sql
-- Purpose: verify that every raw source table has loaded records.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

select 'ACCOUNTS' as source_table, count(*) as row_count
from HBP_DEMO.RAW_RAW.ACCOUNTS
union all
select 'SUBSCRIPTIONS', count(*)
from HBP_DEMO.RAW_RAW.SUBSCRIPTIONS
union all
select 'CONTENT_ENGAGEMENT', count(*)
from HBP_DEMO.RAW_RAW.CONTENT_ENGAGEMENT
union all
select 'SUPPORT_TICKETS', count(*)
from HBP_DEMO.RAW_RAW.SUPPORT_TICKETS
order by source_table;
