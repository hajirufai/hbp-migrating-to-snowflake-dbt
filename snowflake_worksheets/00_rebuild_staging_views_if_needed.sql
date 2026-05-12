-- 00_rebuild_staging_views_if_needed.sql
-- Purpose: repair staging views directly in Snowflake if old dbt views fail on blank dates.
-- Preferred long-term fix: run dbt again after updating the models/staging SQL files.

use role accountadmin;
use warehouse HBP_DEMO_WH;
use database HBP_DEMO;

create or replace view HBP_DEMO.RAW_STAGING.STG_ACCOUNTS as
select
    account_id,
    account_name,
    segment,
    industry,
    region,
    customer_success_owner
from HBP_DEMO.RAW_RAW.ACCOUNTS;

create or replace view HBP_DEMO.RAW_STAGING.STG_SUBSCRIPTIONS as
select
    subscription_id,
    account_id,
    product_line,
    try_to_date(nullif(to_varchar(contract_start_date), '')) as contract_start_date,
    try_to_date(nullif(to_varchar(contract_end_date), '')) as contract_end_date,
    try_to_number(nullif(to_varchar(licensed_seats), ''))::integer as licensed_seats,
    try_to_number(nullif(to_varchar(annual_contract_value), ''))::number(12, 2) as annual_contract_value,
    renewal_stage
from HBP_DEMO.RAW_RAW.SUBSCRIPTIONS;

create or replace view HBP_DEMO.RAW_STAGING.STG_CONTENT_ENGAGEMENT as
select
    event_id,
    account_id,
    user_id,
    try_to_date(nullif(to_varchar(event_date), '')) as event_date,
    content_type,
    content_id,
    try_to_number(nullif(to_varchar(minutes_spent), ''))::integer as minutes_spent,
    try_to_boolean(nullif(to_varchar(completed_flag), '')) as completed_flag
from HBP_DEMO.RAW_RAW.CONTENT_ENGAGEMENT;

create or replace view HBP_DEMO.RAW_STAGING.STG_SUPPORT_TICKETS as
select
    ticket_id,
    account_id,
    try_to_date(nullif(to_varchar(created_date), '')) as created_date,
    try_to_date(nullif(to_varchar(closed_date), '')) as closed_date,
    priority,
    category,
    status,
    try_to_number(nullif(to_varchar(csat_score), '')) as csat_score
from HBP_DEMO.RAW_RAW.SUPPORT_TICKETS;

select 'STG_ACCOUNTS' as staging_view, count(*) as row_count
from HBP_DEMO.RAW_STAGING.STG_ACCOUNTS
union all
select 'STG_SUBSCRIPTIONS', count(*)
from HBP_DEMO.RAW_STAGING.STG_SUBSCRIPTIONS
union all
select 'STG_CONTENT_ENGAGEMENT', count(*)
from HBP_DEMO.RAW_STAGING.STG_CONTENT_ENGAGEMENT
union all
select 'STG_SUPPORT_TICKETS', count(*)
from HBP_DEMO.RAW_STAGING.STG_SUPPORT_TICKETS
order by staging_view;
