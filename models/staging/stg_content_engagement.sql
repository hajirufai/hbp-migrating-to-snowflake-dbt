with source as (
    select * from {{ ref('content_engagement') }}
)

select
    event_id,
    account_id,
    user_id,
    cast(event_date as date) as event_date,
    content_type,
    content_id,
    cast(minutes_spent as integer) as minutes_spent,
    cast(completed_flag as boolean) as completed_flag
from source
