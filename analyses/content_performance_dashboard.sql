select
    content_type,
    content_id,
    learning_events,
    accounts_reached,
    active_learners,
    total_minutes_spent,
    avg_minutes_per_event,
    completion_rate
from {{ ref('fct_content_performance') }}
order by
    completion_rate desc,
    learning_events desc
