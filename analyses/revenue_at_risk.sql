select
    account_health_status,
    count(*) as account_count,
    sum(annual_contract_value) as annual_contract_value,
    avg(seat_activation_rate) as avg_seat_activation_rate,
    sum(open_tickets) as open_tickets,
    sum(high_priority_tickets) as high_priority_tickets
from {{ ref('fct_account_health') }}
group by 1
order by
    case account_health_status
        when 'High risk' then 1
        when 'Watch' then 2
        else 3
    end
