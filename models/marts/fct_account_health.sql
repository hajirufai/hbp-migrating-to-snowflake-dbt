with engagement as (
    select
        account_id,
        count(*) as total_learning_events,
        count(distinct user_id) as active_learners,
        sum(minutes_spent) as total_minutes_spent,
        avg(minutes_spent) as avg_minutes_per_event,
        avg(case when completed_flag then 1 else 0 end) as completion_rate
    from {{ ref('stg_content_engagement') }}
    group by 1
),

tickets as (
    select
        account_id,
        count(*) as total_tickets,
        count_if(status = 'Open') as open_tickets,
        count_if(priority = 'High') as high_priority_tickets,
        avg(csat_score) as avg_csat_score
    from {{ ref('stg_support_tickets') }}
    group by 1
),

account_base as (
    select * from {{ ref('dim_accounts') }}
)

select
    a.account_id,
    a.account_name,
    a.segment,
    a.industry,
    a.region,
    a.customer_success_owner,
    a.product_line,
    a.licensed_seats,
    a.annual_contract_value,
    a.renewal_stage,
    a.days_until_renewal,
    coalesce(e.total_learning_events, 0) as total_learning_events,
    coalesce(e.active_learners, 0) as active_learners,
    round(coalesce(e.active_learners, 0) / nullif(a.licensed_seats, 0), 4) as seat_activation_rate,
    coalesce(e.total_minutes_spent, 0) as total_minutes_spent,
    round(coalesce(e.avg_minutes_per_event, 0), 2) as avg_minutes_per_event,
    round(coalesce(e.completion_rate, 0), 4) as completion_rate,
    coalesce(t.total_tickets, 0) as total_tickets,
    coalesce(t.open_tickets, 0) as open_tickets,
    coalesce(t.high_priority_tickets, 0) as high_priority_tickets,
    round(coalesce(t.avg_csat_score, 0), 2) as avg_csat_score,
    case
        when a.days_until_renewal <= 90
            and (coalesce(e.active_learners, 0) / nullif(a.licensed_seats, 0) < 0.01
                or coalesce(t.high_priority_tickets, 0) >= 1)
            then 'High risk'
        when coalesce(e.completion_rate, 0) < 0.50
            or coalesce(t.open_tickets, 0) >= 1
            then 'Watch'
        else 'Healthy'
    end as account_health_status
from account_base as a
left join engagement as e
    on a.account_id = e.account_id
left join tickets as t
    on a.account_id = t.account_id
