with source as (
    select * from {{ ref('subscriptions') }}
)

select
    subscription_id,
    account_id,
    product_line,
    try_to_date(nullif(to_varchar(contract_start_date), '')) as contract_start_date,
    try_to_date(nullif(to_varchar(contract_end_date), '')) as contract_end_date,
    try_to_number(nullif(to_varchar(licensed_seats), ''))::integer as licensed_seats,
    try_to_number(nullif(to_varchar(annual_contract_value), ''))::number(12, 2) as annual_contract_value,
    renewal_stage
from source
