with source as (
    select * from {{ ref('accounts') }}
)

select
    account_id,
    account_name,
    segment,
    industry,
    region,
    customer_success_owner
from source
