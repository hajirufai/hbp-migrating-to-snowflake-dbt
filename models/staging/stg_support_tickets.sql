with source as (
    select * from {{ ref('support_tickets') }}
)

select
    ticket_id,
    account_id,
    cast(created_date as date) as created_date,
    cast(nullif(closed_date, '') as date) as closed_date,
    priority,
    category,
    status,
    try_to_number(csat_score) as csat_score
from source
