# Customer Health Analytics dbt + Snowflake Project

This project is a small, interview-ready analytics pipeline for a customer success and renewal-risk use case.

It combines data from multiple operational sources, models it in dbt, and produces account health, customer engagement, and content performance reporting in Snowflake.

## Business Problem

Organizations that sell learning or subscription-based digital products to universities, enterprises, nonprofits, and leadership teams need to understand whether customers are getting value before renewal conversations. Customer success and revenue leaders need to know:

- Which customer accounts are healthy, at risk, or need attention before renewal?
- Are licensed seats actually being used?
- Which learning content is driving engagement and completion?
- Are support issues connected to renewal risk?

## Stakeholders

- Customer Success Managers: prioritize accounts that need outreach.
- Revenue and Renewal Leaders: protect annual contract value before renewal dates.
- Product and Content Teams: understand which cases, simulations, courses, and articles are performing.
- Data Team: provide clean, trusted models instead of one-off spreadsheet analysis.

## Data Sources

This demo uses four CSV seed files that represent common business system extracts:

- `accounts.csv`: CRM account/customer data.
- `subscriptions.csv`: CRM or billing subscription and renewal data.
- `content_engagement.csv`: learning platform event data.
- `support_tickets.csv`: helpdesk support ticket data.

In a real production stack, these would usually arrive through Fivetran, Airbyte, Snowpipe, S3 stages, or source application APIs. For the interview, CSV seeds keep the demo fast while still showing the modeling pattern.

## dbt Models

Staging models clean types and standardize raw source tables:

- `stg_accounts`
- `stg_subscriptions`
- `stg_content_engagement`
- `stg_support_tickets`

Mart models answer business questions:

- `dim_accounts`: one row per account with subscription and renewal context.
- `fct_account_health`: account-level KPIs and health status.
- `fct_content_performance`: content-level engagement and completion metrics.

## Key KPIs

- Seat activation rate: active learners divided by licensed seats.
- Completion rate: percentage of learning events completed.
- Total learning events and active learners.
- Open and high-priority support tickets.
- Average CSAT score.
- Days until renewal.
- Account health status: `Healthy`, `Watch`, or `High risk`.

## How to Run in dbt Cloud

1. Create a free dbt Cloud account.
2. Create a new dbt project and connect it to this repository.
3. Create a Snowflake connection using your Snowflake account details.
4. In Snowflake, create a warehouse, database, schema, and dbt role/user if needed.
5. In dbt Cloud, open the IDE and run:

```bash
dbt deps
dbt seed
dbt run
dbt test
```

## Suggested Demo Flow

1. Explain the business problem and stakeholders.
2. Show the raw source files as simulated extracts from different systems.
3. Show staging models that clean and standardize the raw data.
4. Show mart models that combine engagement, subscription, and support data.
5. Run `dbt test` to show data quality checks.
6. Open the report queries in `analyses/` and explain the insights.

## Interview Sound Bite

I built a simple ELT pipeline in Snowflake and dbt that combines CRM, subscription, product engagement, and support data. The goal is to help customer success and revenue teams identify renewal risk early and understand which content or product experiences drive engagement. I used dbt staging models to clean raw extracts, mart models to calculate KPIs, and tests to enforce basic data quality.
