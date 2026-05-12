# Report Questions

These are the questions the final analytics layer should answer.

## 1. Which accounts are at risk before renewal?

Use `fct_account_health`.

Important fields:

- `account_health_status`
- `days_until_renewal`
- `annual_contract_value`
- `seat_activation_rate`
- `open_tickets`
- `high_priority_tickets`

## 2. Which accounts should Customer Success contact first?

Sort by:

- `account_health_status`
- lowest `days_until_renewal`
- highest `annual_contract_value`
- highest `high_priority_tickets`

## 3. Are customers using the seats they bought?

Use:

- `licensed_seats`
- `active_learners`
- `seat_activation_rate`

This is a simple adoption signal. In production, the date window would be parameterized, for example last 30 days or last quarter.

## 4. Which content performs best?

Use `fct_content_performance`.

Important fields:

- `learning_events`
- `accounts_reached`
- `active_learners`
- `avg_minutes_per_event`
- `completion_rate`

## 5. Is support pain connected to renewal risk?

Use `fct_account_health`.

Look at:

- `open_tickets`
- `high_priority_tickets`
- `avg_csat_score`
- `days_until_renewal`
- `account_health_status`
