with source as (
    select * from {{ ref('support_tickets') }}
)

select
    ticket_id,
    account_id,
    try_to_date(nullif(to_varchar(created_date), '')) as created_date,
    try_to_date(nullif(to_varchar(closed_date), '')) as closed_date,
    priority,
    category,
    status,
    try_to_number(nullif(to_varchar(csat_score), '')) as csat_score
from source
