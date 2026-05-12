-- 07_account_health_dashboard.sql
-- Purpose: produce the account health output used by Customer Success teams.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

select
    account_name,
    segment,
    industry,
    region,
    customer_success_owner,
    product_line,
    annual_contract_value,
    days_until_renewal,
    renewal_stage,
    active_learners,
    licensed_seats,
    seat_activation_rate,
    completion_rate,
    open_tickets,
    high_priority_tickets,
    avg_csat_score,
    account_health_status
from HBP_DEMO.RAW_MARTS.FCT_ACCOUNT_HEALTH
order by
    case account_health_status
        when 'High risk' then 1
        when 'Watch' then 2
        else 3
    end,
    days_until_renewal,
    annual_contract_value desc;
