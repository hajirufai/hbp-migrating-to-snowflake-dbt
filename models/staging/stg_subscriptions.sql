with source as (
    select * from {{ ref('subscriptions') }}
)

select
    subscription_id,
    account_id,
    product_line,
    cast(contract_start_date as date) as contract_start_date,
    cast(contract_end_date as date) as contract_end_date,
    cast(licensed_seats as integer) as licensed_seats,
    cast(annual_contract_value as number(12, 2)) as annual_contract_value,
    renewal_stage
from source
