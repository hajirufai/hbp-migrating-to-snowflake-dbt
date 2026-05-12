select
    content_type,
    content_id,
    count(*) as learning_events,
    count(distinct account_id) as accounts_reached,
    count(distinct user_id) as active_learners,
    sum(minutes_spent) as total_minutes_spent,
    round(avg(minutes_spent), 2) as avg_minutes_per_event,
    round(avg(case when completed_flag then 1 else 0 end), 4) as completion_rate
from {{ ref('stg_content_engagement') }}
group by 1, 2
