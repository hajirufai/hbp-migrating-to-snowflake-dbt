select
    account_name,
    segment,
    industry,
    region,
    customer_success_owner,
    product_line,
    annual_contract_value,
    days_until_renewal,
    renewal_stage,
    active_learners,
    licensed_seats,
    seat_activation_rate,
    completion_rate,
    open_tickets,
    high_priority_tickets,
    avg_csat_score,
    account_health_status
from {{ ref('fct_account_health') }}
order by
    case account_health_status
        when 'High risk' then 1
        when 'Watch' then 2
        else 3
    end,
    days_until_renewal,
    annual_contract_value desc
