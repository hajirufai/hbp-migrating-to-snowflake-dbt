with source as (
    select * from {{ ref('content_engagement') }}
)

select
    event_id,
    account_id,
    user_id,
    try_to_date(nullif(to_varchar(event_date), '')) as event_date,
    content_type,
    content_id,
    try_to_number(nullif(to_varchar(minutes_spent), ''))::integer as minutes_spent,
    try_to_boolean(nullif(to_varchar(completed_flag), '')) as completed_flag
from source
