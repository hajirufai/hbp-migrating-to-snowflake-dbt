-- 09_content_performance_dashboard.sql
-- Purpose: show learning content engagement and completion performance.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

select
    content_type,
    content_id,
    learning_events,
    accounts_reached,
    active_learners,
    total_minutes_spent,
    avg_minutes_per_event,
    completion_rate
from HBP_DEMO.RAW_MARTS.FCT_CONTENT_PERFORMANCE
order by
    completion_rate desc,
    learning_events desc;
