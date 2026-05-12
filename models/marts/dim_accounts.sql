select
    a.account_id,
    a.account_name,
    a.segment,
    a.industry,
    a.region,
    a.customer_success_owner,
    s.product_line,
    s.contract_start_date,
    s.contract_end_date,
    s.licensed_seats,
    s.annual_contract_value,
    s.renewal_stage,
    datediff('day', current_date, s.contract_end_date) as days_until_renewal
from {{ ref('stg_accounts') }} as a
left join {{ ref('stg_subscriptions') }} as s
    on a.account_id = s.account_id
